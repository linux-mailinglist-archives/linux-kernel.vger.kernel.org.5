Return-Path: <linux-kernel+bounces-41421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D3F83F0A5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54F21B258F6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFB91EA77;
	Sat, 27 Jan 2024 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OBYlnWeo"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786EE28F5;
	Sat, 27 Jan 2024 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394246; cv=none; b=eAum37vTq9eBYtE0bir/FH4TICdkUBsQ0WnlAIb1ohDc/xSa4InMYxGYde5nkyvN/LRfiaZ4OKvw+aw7/RAeWOxcvhasISNxX+wtIin2izg6c/ea2sGQ1VEnmT+JMJr2ctm/XAprunPtnOJm+b76SOy7DV0dznwm4DFqWgtqX8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394246; c=relaxed/simple;
	bh=azbsrdWbk2C26uZOQ5sAP8smp6+BEZ6Gbu0+jZMGf8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNOZtY61ZBJttkGg/YjsMGqCjG8fWEsNKWiFLbm0iAny+Z41GYZyzcXntR3h70Xm0k2rwf48Wp8UrN/dEE4XvDqF/4PZvnbBKlwHpycGajBkQa5sNevNasnhfSO/jRJW/hM0cX5kghnkbBtcD0xQp24QZ2t+Js6VOUND9bh9pEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OBYlnWeo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3gsupESMPkziY7RvwVM4+Lok//ky5hAjMzILggxl/WI=; b=OBYlnWeovgCRQyZ+WyVtTNrzxI
	fikMs0uOYHhz6eX8sA9lT9CgNOHvr2DEuVBQU1zHPjErDeRAnqZfVIRaHcUyLsFkE9VnQeM9JzqLn
	vclF2P3w5ohAG5S/czHEQFf5wXIrZlWaO1vFvpkeNRikpgZ+XElot+o4U2j8spsZJF3p5ydpFLf3P
	z8A4OvNAPv+jExc8c2mQaIt5L/D1G5LvQwHLBxa1k5PHvM/1uNjSPtCLnz3oG8PS3rs6IBxkrOm0Q
	0j8f5urhMupL/N+MzjHDTTGvREZ/MqCb8tf2uUHtM27KjUFHG9QYxqWhvt3e5kn8I6kpOcOK0JhB6
	voCtAq3Q==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTr5i-00000008IVq-2AZl;
	Sat, 27 Jan 2024 22:23:58 +0000
Message-ID: <9f3b5e25-3d41-4c1f-a8be-788f617f4d58@infradead.org>
Date: Sat, 27 Jan 2024 14:23:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] media: staging: meson: Fix kerneldoc
Content-Language: en-US
To: Ricardo Ribalda <ribalda@chromium.org>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, Hans Verkuil <hverkuil@xs4all.nl>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Bin Liu <bin.liu@mediatek.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
 Tianshu Qiu <tian.shu.qiu@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-amlogic@lists.infradead.org
References: <20240126-gix-mtk-warnings-v1-0-eed7865fce18@chromium.org>
 <20240126-gix-mtk-warnings-v1-16-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-16-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> Remove documentation from missing field.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

 
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/staging/media/meson/vdec/vdec.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/media/meson/vdec/vdec.h b/drivers/staging/media/meson/vdec/vdec.h
> index 0906b8fb5cc6..258685177700 100644
> --- a/drivers/staging/media/meson/vdec/vdec.h
> +++ b/drivers/staging/media/meson/vdec/vdec.h
> @@ -101,7 +101,6 @@ struct amvdec_core {
>   * @conf_esparser: mandatory call to let the vdec configure the ESPARSER
>   * @vififo_level: mandatory call to get the current amount of data
>   *		  in the VIFIFO
> - * @use_offsets: mandatory call. Returns 1 if the VDEC supports vififo offsets
>   */
>  struct amvdec_ops {
>  	int (*start)(struct amvdec_session *sess);
> 

-- 
#Randy

