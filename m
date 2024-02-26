Return-Path: <linux-kernel+bounces-81538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79A986773B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88BC71F28621
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD9C128839;
	Mon, 26 Feb 2024 13:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="KHiIlvdj"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692F05A7BF
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955534; cv=none; b=Zsv7wfmrMDt079V/joZPSXrxlqSqwFycwHkdixdb4eXuJmjUx9fE6+iQQgGuurukafVmQbsu404uM4Y7gmMknbccsRX2XSZy2lcoKHTt4lsmpdYCF5G9gsoqeBTE9u6lMMi+vqxkaCw8RmuQDQA73dmTX2KVV52kKXJllD8QgWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955534; c=relaxed/simple;
	bh=HrS/3jPOPurf1a/ULbGVyrwnHZgt1MgGkieYdCEifjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=odj1/4sl6w9qx7wWK5UrXu4nvY3cx4wYZjNU/7oY1dqmjonmjXe5sBRmO3WKUNcL7jvqJ8u6dNE5pEXy2wg5DsvrDHhc6G/Qn00l6USWYgUzUisqOi2RW1PkeHXxLTpVTmqFScHjFpMhh0MHZPEgM8UUwm4x9trnh5x1Pt6SPQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=KHiIlvdj; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QALFxh024741;
	Mon, 26 Feb 2024 14:51:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=HrS/3jPOPurf1a/ULbGVyrwnHZgt1MgGkieYdCEifjc=; b=KH
	iIlvdjS+/zHJOZA1ehXnvdZ96KKoxvYo1na/NVRbFDma7quuT7aSbLxVZoR8p362
	x35rF/jkbaaasbISTLmGb0Hr8QJK0oYI61sv9emxu9d2R9UGV05/NE3ziGg23VhB
	xzg75hXOLYD55+vLvM7h0HOGi0xJn5yjcnJeO+sQNNtmyOxWAglleoFqoO4EtscU
	qqmL5BZ5Jd2Ch2yzDxFIwHvaGF7Acra4O32HOyU2fNOGZiKbyz0eTNNCVUssaVnP
	2b+61EWpSNn47SM2uA4K4+4fOelW7j1z6IxqHm/uwW8G72oEfHX9118zPYK/hsSq
	4kpz9apJwHdKkHTYJcow==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wfv9tw14k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 14:51:32 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 19F7B40044;
	Mon, 26 Feb 2024 14:51:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6ED7027C9C7;
	Mon, 26 Feb 2024 14:50:45 +0100 (CET)
Received: from [10.252.9.163] (10.252.9.163) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 26 Feb
 2024 14:50:44 +0100
Message-ID: <0b91cb58-b9ca-4c67-b15a-77c60bc2ee18@foss.st.com>
Date: Mon, 26 Feb 2024 14:50:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/stm: Avoid use-after-free issues with crtc and
 plane
To: Katya Orlova <e.orlova@ispras.ru>
CC: Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu
	<philippe.cornu@foss.st.com>,
        David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <lvc-project@linuxtesting.org>
References: <20240216125040.8968-1-e.orlova@ispras.ru>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20240216125040.8968-1-e.orlova@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_09,2024-02-26_01,2023-05-22_02


On 2/16/24 13:50, Katya Orlova wrote:
> ltdc_load() calls functions drm_crtc_init_with_planes(),
> drm_universal_plane_init() and drm_encoder_init(). These functions
> should not be called with parameters allocated with devm_kzalloc()
> to avoid use-after-free issues [1].
>
> Use allocations managed by the DRM framework.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> [1]
> https://lore.kernel.org/lkml/u366i76e3qhh3ra5oxrtngjtm2u5lterkekcz6y2jkndhuxzli@diujon4h7qwb/
>
> Signed-off-by: Katya Orlova <e.orlova@ispras.ru>

Hi Katya,


Thanks for this submission.

Acked-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>


Regards,
Raphaël


