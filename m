Return-Path: <linux-kernel+bounces-54695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8FC84B28B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4741C283727
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA47F1EA7D;
	Tue,  6 Feb 2024 10:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Gq4i2HaZ"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6051EA76;
	Tue,  6 Feb 2024 10:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215556; cv=none; b=I/UUERpJ3wy+Ww8Q9Ch7GrKcSZawUwNiT0MkSt5mEZ6ab1mTZda6MdacBo9M7iCtFiwevUway/FoByYo/D3b5zCZBYgTnfMzZbVLIfXP56lKfSaYZYD2ha1/vos9/YTM4GG964qgjGjssdvWwAzFrCvubahX/2UOzYeElWwuW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215556; c=relaxed/simple;
	bh=+WeGa3Eq4sDl93t4zuFq8b2hQy60542lYtYLgCSbIrQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJtBxX8WfVPHurMipH7RaEuXnC4d8SXtqWLQrr71Pekk0iwrKpXlxF0lwc3DscyI6w1nPIOe+BTLPM4fj5Wwe8pfG/F4wfs7dt9sJPXenP90Pg8jVVDjY8Tik2JW6iTLqFfEsE373sD5Spcc3qdRzJeI4xVXGF2D4gfkWdHP+YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Gq4i2HaZ; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4169iw9L025133;
	Tue, 6 Feb 2024 04:23:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=v8WU0lB9flpGY7v
	YDfUpKZOIGwF1bC5Mlqhymq+hVuI=; b=Gq4i2HaZBxfaa9D+cEHHCkIim11Aq+L
	PsNfQCWEW/RohMHzj0MnwF9nyXJoQyaQubAxDrlPApglgBXw0Tvtf/px2vdmfLYv
	GSjZyVUaRg/A4TXB1Af6DwIP7K9jOLni5AgK8O8el8CUiAcoiNI36wfWIX7Yx9q2
	+RH3aKAEpHFGg8h+W7RkXMCEL92bLlBaIANFvIFkv6MSF3OqKzKVI/GtcmBt1Aeh
	D0TDVyCkgJ/ydhQx45QDBWNy8Sn9N1sMqxP6Ly0ZgAumPhVzd4GcBPh4MHToFQP3
	wnUaon/CBqLht8YtsL+jDbw4Z9onUqFhuTc/zsVljd2CV0kWe2AGiSA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3w1jsnk6h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 04:23:30 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 10:23:28 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Tue, 6 Feb 2024 10:23:28 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 9CD37820241;
	Tue,  6 Feb 2024 10:23:28 +0000 (UTC)
Date: Tue, 6 Feb 2024 10:23:27 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bo Liu <liubo03@inspur.com>
CC: <lee@kernel.org>, <wens@csie.org>, <marek.vasut+renesas@gmail.com>,
        <support.opensource@diasemi.com>, <neil.armstrong@linaro.org>,
        <rf@opensource.cirrus.com>, <mazziesaccount@gmail.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <patches@opensource.cirrus.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 10/18] mfd: wolfson: convert to use maple tree register
 cache
Message-ID: <ZcIIn6b+BFR/FRIS@ediswmail9.ad.cirrus.com>
References: <20240206071314.8721-1-liubo03@inspur.com>
 <20240206071314.8721-11-liubo03@inspur.com>
 <ZcIEFxh76TTXBTiT@ediswmail9.ad.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZcIEFxh76TTXBTiT@ediswmail9.ad.cirrus.com>
X-Proofpoint-GUID: VZagnLkW2TlCS_BzEYBGYEssTNO5DPkf
X-Proofpoint-ORIG-GUID: VZagnLkW2TlCS_BzEYBGYEssTNO5DPkf
X-Proofpoint-Spam-Reason: safe

On Tue, Feb 06, 2024 at 10:04:07AM +0000, Charles Keepax wrote:
> On Tue, Feb 06, 2024 at 02:13:06AM -0500, Bo Liu wrote:
> >  drivers/mfd/wm5102-tables.c | 2 +-
> >  drivers/mfd/wm5110-tables.c | 2 +-
> >  drivers/mfd/wm8350-regmap.c | 2 +-
> >  drivers/mfd/wm8400-core.c   | 2 +-
> >  drivers/mfd/wm97xx-core.c   | 6 +++---
>
> seems a bit weird not to convert wm8997, wm8998 and cs47l24.
> These are part of the same driver as wm5102 and wm5110.

Nevermind, it seems those parts were already converted.

Thanks,
Charles

