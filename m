Return-Path: <linux-kernel+bounces-21887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE382960C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D6BB26E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FF3EA6D;
	Wed, 10 Jan 2024 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7+MoRUnP"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15A3C490;
	Wed, 10 Jan 2024 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8aGnq018108;
	Wed, 10 Jan 2024 10:15:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=Oa0IFcQkZD0/owTviDimI7+i56Xf68eQjrWsXc8swwE=; b=7+
	MoRUnP66xGbpAivfKSxhkbeuHLkaFvGnOXwo91qiWXXUYUkMNdh4MaQuRenc5jW6
	Nh0r6WirKmHuZKhGBK59bGhD3Pc0lE6Vw3GblB+Wd6eplEGcZFrPFGkMyv+6uaza
	PeUFWuOdZy7RgjMlZ7OgEdNQCNwxtSyq1B95/3kV6cQjnCVshXC+Xmkb81bMU6gK
	yAV2QG466tXYNMzD2cS4WN8uu3O2TCtKRUbM8hH7fv3KFMYhh/ICGm80lQkFk4qs
	117SSsB5OV18pk4WO/vSdGHcs8y090oNztBm5+nInhuUi/Vc32o8py3pp0L4oNKG
	3449v/kVxfbrJmvt5ilA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vey30qrvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 10:15:08 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2540610004A;
	Wed, 10 Jan 2024 10:15:06 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1692B24B892;
	Wed, 10 Jan 2024 10:15:06 +0100 (CET)
Received: from [10.201.20.120] (10.201.20.120) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 10 Jan
 2024 10:15:04 +0100
Message-ID: <733bee3f-98ae-4f51-a1c5-6c09b38328ce@foss.st.com>
Date: Wed, 10 Jan 2024 10:15:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] dt-bindings: media: Document STM32MP25 VDEC & VENC
 video codecs
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
CC: Marco Felsch <m.felsch@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>,
        Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia
	<ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Dufresne
	<nicolas.dufresne@collabora.com>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Benjamin Mugnier
	<benjamin.mugnier@foss.st.com>,
        Benjamin Gaignard
	<benjamin.gaignard@collabora.com>,
        Laurent Pinchart
	<laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Almeida
	<daniel.almeida@collabora.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
References: <20240109085155.252358-1-hugues.fruchet@foss.st.com>
 <20240109085155.252358-2-hugues.fruchet@foss.st.com>
 <9ecc73a1-7457-45a2-ade1-c91b8e7176da@kernel.org>
From: Hugues FRUCHET <hugues.fruchet@foss.st.com>
In-Reply-To: <9ecc73a1-7457-45a2-ade1-c91b8e7176da@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02

Hi Krzysztof,

On 1/9/24 22:49, Krzysztof Kozlowski wrote:
> On 09/01/2024 09:51, Hugues Fruchet wrote:
>> Add STM32MP25 VDEC video decoder & VENC video encoder bindings.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC. It might happen, that command when run on an older
> kernel, gives you outdated entries. Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> You missed at least devicetree list (maybe more), so this won't be
> tested by automated tooling.
> 
> Please kindly resend and include all necessary To/Cc entries.

My fault when sending this exact v6, sorry for that.. It was done the 
right way for previous versions and no issues raised by automated tools.

> 
> While resending drop redundant blank line after SPDX. See all other
> bindings and example-schema.
I have double checked and I don't see any problem related to redundant 
blank lines in yaml after SPDX:

+++ b/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2

Could you point me out what is the exact issue ?

> 
> Best regards,
> Krzysztof
> 

