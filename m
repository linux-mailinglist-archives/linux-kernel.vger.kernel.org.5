Return-Path: <linux-kernel+bounces-158270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615308B1DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87879B21490
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6329684E11;
	Thu, 25 Apr 2024 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aYP9Ut5M"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443784E19
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036725; cv=none; b=fLgZccv2Uq7KHrUSXS1iQRLRFU9xuy8FK3age+9xYtyo8bBuwkihSPkzZ9nl3lB+86hjWhJj1qjO2a0FhdWojYnY2BBIOTRU86y4Ct9DmltXkMp64TRbfOIREbtGzQkNbP15zCnsq4hDM4sF4xDPFuAAt73lyR55eFpLm4pXfIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036725; c=relaxed/simple;
	bh=IeUtnMuIrKtJU25e/0i8VDUTfVLgLYppvOq/aFaHLmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ZiEL6daMN/qCX8FMd5m+vv9Af82EiZwP3eEjQGmPb3MdgArm4aoe91eWkL0EDFDxPNJBgQ9K1PARncIoI2AphztiEqWgwjwcjjaropGTXXh0pv6seMb8ZXeUVi4q1zlKKh8zb9G4dzvkJtLmrH9bKlejPjdf6Wl27wjflD/7qts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aYP9Ut5M; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240425091832euoutp01ccb64757cb089037aae475fc716c7bc1~Je08Ea_Rt1807818078euoutp01J
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:18:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240425091832euoutp01ccb64757cb089037aae475fc716c7bc1~Je08Ea_Rt1807818078euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714036712;
	bh=UcevfzM3HySwsVSZ3bKMbO3akNMzRPduII3Yg0WvZDE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=aYP9Ut5MVnGrUaG8mGBdzaiqBU6gF201Wh4xTUqBNO0ZhMXM86I6hU0CVp/Kwk5tk
	 MPaHlY1hmB5x8ITxF3vyAPrVerER9tdhPPDqcv1bko48tXVqthXie7AdwHReny2enh
	 whfzNXTBnGdDLDHb3Z2KxTshjMnO1BD5x8XsTKzM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240425091832eucas1p179d60c7ad909f0266dfbb3d80143e688~Je07qwsSa0894508945eucas1p1W;
	Thu, 25 Apr 2024 09:18:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id FD.DA.09624.7EF1A266; Thu, 25
	Apr 2024 10:18:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240425091831eucas1p10ab2af66510a0698056054e75580da27~Je07Ep6JX0603806038eucas1p1T;
	Thu, 25 Apr 2024 09:18:31 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240425091831eusmtrp11f385cf2cc89c3de337fc86778154143~Je07Dzjf71572015720eusmtrp1G;
	Thu, 25 Apr 2024 09:18:31 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-22-662a1fe70121
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id A5.6B.09010.7EF1A266; Thu, 25
	Apr 2024 10:18:31 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240425091830eusmtip23af9ec006b450ee82623f2a299d7801a~Je06IgtSz1628616286eusmtip2W;
	Thu, 25 Apr 2024 09:18:30 +0000 (GMT)
Message-ID: <e8d6826a-67d4-417f-ab40-072b8705e37d@samsung.com>
Date: Thu, 25 Apr 2024 11:18:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] drm/bridge: samsung-dsim: Set P divider based on
 min/max of fin pll
To: Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org
Cc: marex@denx.de, aford@beaconembedded.com, Frieder Schrempf
	<frieder.schrempf@kontron.de>, Inki Dae <inki.dae@samsung.com>, Jagan Teki
	<jagan@amarulasolutions.com>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil
	Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
	<jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
	Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Marco Felsch
	<m.felsch@pengutronix.de>, Michael Tretter <m.tretter@pengutronix.de>,
	linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240211230931.188194-1-aford173@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTdRzu+77v3o3Z8N2Q43srb91Kr3nGIKm+hhIFem+ed9EVRPyTO3gF
	L5i0gRWWgZ78GEMZmIyhCE7BuBrd2hDGDw/0HBMOEh3lGDdFChCmLdGOIRnbS8V/z/P5PJ9f
	z314uMhAinn7lHmMSqnIlpJ8ou3qwvArU5JNe6NG27ci99gAjjqd5VzU/8tZDHmMDwn0tE2H
	o5uPHpCo4vwQB1V5Kgk0b64k0dQZE0COOSeBynTnuOiG7RSJ/rA5cdR2YVnX6LMSaK64CKDi
	siYOetDhAqiq/hYHWeZ0nPhw+gefh0PPNBfidL2hn6C7HzcQdIdhnEvXldZyaGPXDEabW8pI
	+orTyKH7K0cw2j3aRdL1jvdpT7kdo48vRdHHLC2A/mngYJIwjb8tg8ned4BRyeP28LOsFRYy
	96Lwi2HzMCgER0M1IIQHqRjYPXEO1wA+T0RdAPDGQhuXJfMA3ly6s5J5CGC13b1MeMGSzp4t
	bLwZwNnrYxyW+ACs8ZRyA30FVBy0TXSQAUxQG+DgvA6wcSF01E4SARxOSaDHpQ/qwygFbBz/
	K4jXUQnQsfQYCzTFqRkO9N6xcgIJnIqArskzWACTVDTUeDXBASHUVthTXYaxGgm86D0VXBtS
	tXw4bXIA9tJEuKj1cFkcBu/ZLSv4eThQrSXYghIAGxY9GEsqASyccq1Ux0L3kJ8MGIBTMthq
	k7Pht+HgeSPB+hIKf/UK2SVCYVVbzYpdAlhaLGLVG6HBbvpvbO/PI3glkBpW+WJYdaZh1TmG
	/+c2AKIFRDD56pxMRh2tZD6PVCty1PnKzMj0/TlmsPy+A3/b/2wHp+/5IvsAxgN9APJw6TrB
	Ld/Le0WCDMWXBYxq/yeq/GxG3Qee4xHSCMGGDAkjojIVecynDJPLqP7NYrwQcSEmfuf1VuuJ
	vsSSXZMHb6MnkWkZqqflDd7XCrbdv1Ye44tNifdXfW+d36nU1ZSO73ry8d0efclCdwJsdDVN
	ph4zhucdPR6VLr9mT3bMmH48LPwmN/mA9qtDO5NfWjiyQ2xK0Z+8tP5d/ZK4zvZbr3fztD+t
	IKloMTFppOCQLCXBuOf2lcws7VBqXfMbd9dq2nN8fP1nIkvIqHXuBYHr2zj5Fqfpo7yvk9dP
	xKzRolcTHm2clvTGbT9bPBpdaq74IOxNi9+dvrv62abr+q4P/S/iYz7ZGC23i2Ztl++HXVLL
	Tu64fGT34dSUit+/W1PWufBMbHV80WxT3XvgrdbBq7JIjXmza7uUUGcpojfhKrXiH8OD0jQt
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsVy+t/xe7rP5bXSDO5dEra4c/s0s8Xuq93s
	FieuL2KyuL/4M4vF/20TmS2ufH3PZtG79ByrxaT7E1gsvmyawGbxfP46RouTb66yWHROXMJu
	cXnXHDaLD7uuMltsWwFUt/DjVhaLN22NjBZtnctYLd7vvMVoMWneTVaLLW8msjqIeqz9eJ/V
	4+XyBmaPebNOsHjs/baAxWPnrLvsHrM7ZrJ6LN7zkslj06pONo8jVxezepyYcInJ4861PWwe
	804GetzvPs7k0f/XwKNvyypGj82nqwMEo/RsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyN
	zWOtjEyV9O1sUlJzMstSi/TtEvQytvZuYSvYLlhxftN5xgbGVr4uRg4OCQETid37jLsYuTiE
	BJYySkzc8Imti5ETKC4jcXJaAyuELSzx51oXG0TRe0aJSyc3M4MkeAXsJHY92gnWwCKgKnHm
	y0RGiLigxMmZT1hAbFEBeYn7t2awg9jCAokSC+9+B7NFBJwlTv79xgQylFngNavEt1vnGCE2
	9DBK7Lj4kgmkillAXOLWk/lgNpuAoUTX2y6wbZwClhL7JndC1ZhJdG3tYoSw5SW2v53DPIFR
	aBaSQ2YhGTULScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBCabbcd+btnBuPLV
	R71DjEwcjIcYJTiYlUR4b37USBPiTUmsrEotyo8vKs1JLT7EaAoMjYnMUqLJ+cB0l1cSb2hm
	YGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwKT3pSSlRHXS5ML9Byfb/xK7
	EatkubRSiWXHx4U+U2uV/0aa3vnsV59s8lvbPt1t2UydXf4/bav0uY7tcuv/8yPvjzqDnNyK
	PaKz5xX+cp7Q7zbt326fDRfnWG+Oitjo7zVPZXNp30fef9FbPbuc1h9Ufmwll/BiAnv64X1P
	jzTtyzlz4J/jgbaImwz7FT1rl33qXTVj9cPdc9XmCcdPXxb+9cA75x3e2ucvcc7S7zTpqTJ9
	drq0pSlY0f2bafTr4Jp7z7iOaC5Yqv58WbNj+LPVCpYHZkk4+wf8+bRxDv/np6bfOj4tvzHj
	2qdZh8P3GwqxmcquLd3NlKjEmHNvorJ8SFZq1je7x6mn8pg533oosRRnJBpqMRcVJwIALty9
	I78DAAA=
X-CMS-MailID: 20240425091831eucas1p10ab2af66510a0698056054e75580da27
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240211230943eucas1p23524077c0e8e7431c2af6f3153935bd5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240211230943eucas1p23524077c0e8e7431c2af6f3153935bd5
References: <CGME20240211230943eucas1p23524077c0e8e7431c2af6f3153935bd5@eucas1p2.samsung.com>
	<20240211230931.188194-1-aford173@gmail.com>

On 12.02.2024 00:09, Adam Ford wrote:
> The P divider should be set based on the min and max values of
> the fin pll which may vary between different platforms.
> These ranges are defined per platform, but hard-coded values
> were used instead which resulted in a smaller range available
> on the i.MX8M[MNP] than what was possible.
>
> As noted by Frieder, there are descripencies between the reference
> manuals of the Mini, Nano and Plus, so I reached out to my NXP
> rep and got the following response regarding the varing notes
> in the documentation.
>
> "Yes it is definitely wrong, the one that is part of the NOTE in
> MIPI_DPHY_M_PLLPMS register table against PMS_P, PMS_M and PMS_S is
> not correct. I will report this to Doc team, the one customer should
> be take into account is the Table 13-40 DPHY PLL Parameters and the
> Note above."
>
> With this patch, the clock rates now match the values used in NXP's
> downstream kernel.
>
> Fixes: 846307185f0f ("drm/bridge: samsung-dsim: update PLL reference clock")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Feel free to add:

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

although all Exynos based boards have panels with fixed timings afair.

> ---
> V2:  Only update the commit message to reflect why these values
>       were chosen.  No code change present
>
> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
> index 95fedc68b0ae..8476650c477c 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -574,8 +574,8 @@ static unsigned long samsung_dsim_pll_find_pms(struct samsung_dsim *dsi,
>   	u16 _m, best_m;
>   	u8 _s, best_s;
>   
> -	p_min = DIV_ROUND_UP(fin, (12 * MHZ));
> -	p_max = fin / (6 * MHZ);
> +	p_min = DIV_ROUND_UP(fin, (driver_data->pll_fin_max * MHZ));
> +	p_max = fin / (driver_data->pll_fin_min * MHZ);
>   
>   	for (_p = p_min; _p <= p_max; ++_p) {
>   		for (_s = 0; _s <= 5; ++_s) {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


