Return-Path: <linux-kernel+bounces-148501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CEA8A8393
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26C51C21DEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E162D60C;
	Wed, 17 Apr 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ortz7J2e"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8C984DF6;
	Wed, 17 Apr 2024 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358735; cv=none; b=C1ePYHnJ/HhR9rAgYBXgC4xwgEJxFUYgu2k1sCTmgoKUwd/rJOJISRrnJxEmipR93QmHxups9+zDHZouUVoPgSkGWhClINqeZErq0qX3y/wnXhjFOvLk8UvEKiq6jU2I33VbpAbH3/agJu5Tghm3Uxp+C6I5/Ecmcod7DDOT+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358735; c=relaxed/simple;
	bh=mRlRkorupNuv+TJWx/y+uXXu1O9+ZgMbFD+YQNFOBqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tjb6XkGhsZox86JdBLtyE3D7d2DLcuBYGv+EdyNw5aw3bFmhGsSrV+VvdBIsAtG+PqbpPJWd+R6Q5uNepbYDJZlh0PZvBWN8v9BrapSg7DKGYTSO1dw20m9MyBDDS9wf0TqfcMsCEyyfVCSb4qNnR0zov+6WSBvAVFcls+NoUMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ortz7J2e; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HClsCK003624;
	Wed, 17 Apr 2024 14:57:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=Oy6ydHY6pQ8DYm8xK8PeLsM+pd6WltoQh0mGRUSj86E=; b=or
	tz7J2eIpRjwTS6nxsow94Im5O+PJ8pyQKEzgQC9x+TEQyuiVxirXsxSqUmOFi5z6
	j9JuaMCVAueB7+ptBoHkZGcb+q5wgjo9DutZh3e/xcZNv9ir2WSLw5Tx3J4ORSCe
	EA73ib1bb2NSzUytaI+3EJVy3k1Q1gI0fSP3IQEsjwu2YJe3ZCZaDZ9kzaEBLiHp
	IczYev9vu0LgIHwFgY0toURY1M4EinAS1+idFQEUfhYnNuSSXU5+tp4rEI3eP1EF
	QiCs84WlUXA+URlFhvVZDuDiVG8dZypP1QlE91pV8tkChGQWA45K8voZ9I1+fYd5
	RRPfPDBlEjqpZ5kxlIMg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecyea3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 14:57:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E01244002D;
	Wed, 17 Apr 2024 14:57:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E51CB214D29;
	Wed, 17 Apr 2024 14:55:47 +0200 (CEST)
Received: from [10.130.72.241] (10.130.72.241) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 17 Apr
 2024 14:55:46 +0200
Message-ID: <ea60a9e8-6240-4a0a-a224-e132b67160b1@foss.st.com>
Date: Wed, 17 Apr 2024 14:55:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/35] media: i2c: st-mipid02: Use the correct div
 function
To: Ricardo Ribalda <ribalda@chromium.org>,
        Martin Tuma
	<martin.tuma@digiteqautomotive.com>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet
	<hugues.fruchet@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Paul Kocialkowski
	<paul.kocialkowski@bootlin.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec
	<jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari
 Ailus <sakari.ailus@linux.intel.com>,
        Thierry Reding
	<thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya
 Komatineni <skomatineni@nvidia.com>,
        Luca Ceresoli
	<luca.ceresoli@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Hans
 Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>,
        Abylay Ospan
	<aospan@netup.ru>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Dmitry
 Osipenko <digetx@gmail.com>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sylvain
 Petinot <sylvain.petinot@foss.st.com>,
        Jacopo Mondi
	<jacopo+renesas@jmondi.org>,
        Kieran Bingham
	<kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart
	<laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
        Pavel Machek <pavel@ucw.cz>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-staging@lists.linux.dev>, <linux-sunxi@lists.linux.dev>,
        <linux-tegra@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240415-fix-cocci-v1-0-477afb23728b@chromium.org>
 <20240415-fix-cocci-v1-22-477afb23728b@chromium.org>
Content-Language: en-US
From: Benjamin Mugnier <benjamin.mugnier@foss.st.com>
In-Reply-To: <20240415-fix-cocci-v1-22-477afb23728b@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_10,2024-04-16_01,2023-05-22_02

Hi Ricardo,

Thanks a lot.
Reviewed-by: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

On 4/15/24 21:34, Ricardo Ribalda wrote:
> link_freq does not fit in 32 bits.
> 
> Found by cocci:
> drivers/media/i2c/st-mipid02.c:329:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_s64 instead.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/i2c/st-mipid02.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index f250640729ca..93a40bfda1af 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -326,7 +326,7 @@ static int mipid02_configure_from_rx_speed(struct mipid02_dev *bridge,
>  	}
>  
>  	dev_dbg(&client->dev, "detect link_freq = %lld Hz", link_freq);
> -	do_div(ui_4, link_freq);
> +	ui_4 = div64_s64(ui_4, link_freq);
>  	bridge->r.clk_lane_reg1 |= ui_4 << 2;
>  
>  	return 0;
> 

-- 
Regards,

Benjamin

