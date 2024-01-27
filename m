Return-Path: <linux-kernel+bounces-41420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EAB83F09F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E1EB25538
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513AE1E52B;
	Sat, 27 Jan 2024 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="28mIStYb"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5147F1DFD3;
	Sat, 27 Jan 2024 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394152; cv=none; b=ar3Fuj09b1xZJj5bPiF0lUXeR9CO5CUIZO4qUxJJLiikCcvjubcdcLnw/ZlkABL6KOeRdTGdoU2ZYM7DNU0Cu9L7v/r1UQJjbC3AbA7BRrMbDC4ev5gzfnnijkO8fx2NaLi7ez08exermiJYOGAvcPaSvpmfEode9B8DHAHhc04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394152; c=relaxed/simple;
	bh=oAn0ju9TpFuMangJuBlk5iU3n34rk7USMWuxcQ1Mgtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/XBAYWuVCgRczJ7EFcKeygPFINW+lqyB8zJjCrscr/IAUuY1QzqZeP/oJHfVvPvsNkF3lgTz/IRFh33b6e64ezGqg76QyhIgceBEtwcO1RImZA8hq7S3PSlzkve+asXnnQGX81OJK+pl3jIy6TRm9/9Dz1Zno8Qcy7agpJDASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=28mIStYb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XAE8ljZSXyHXHC/ekbLxh89y4+5D78kHcCnYr8JbBI8=; b=28mIStYb3IkgLntRumYg6tUETg
	ZPxyoVW/uR5DexnDukrpjBzOWBdfVeGqWKlwKoJY+CkIfOcFICM+IH0vzpvSQUTAyzuPbhlKjx+FT
	4kM1kxm+pkMlCbgsKT0fOkS/OmFF9bUYZ8p45m4V2f6WLIW3lmswPMNSjY1xTB5J/gdq4IsYwRyau
	QVilwZe470sThhvWVcHTUCUKCV8f98cm4r7Cj9bXW7GNwvxKGf3Bf7XJHPMRg5R6uCxSOL2j6Ym6a
	as6uDH6BPn1hsPqICptXirdC66tN8T9sXz/ZcT8bijSOTUGf8jcPBwVQlYPCYaX9mtZ/pVBIR/Fum
	dGgJU/dA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTr4C-00000008IVq-3NJU;
	Sat, 27 Jan 2024 22:22:25 +0000
Message-ID: <eed7560f-cd7d-4e07-9b38-038ca65445bf@infradead.org>
Date: Sat, 27 Jan 2024 14:22:23 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/17] media: ipu3: Fix kerneldoc
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
 <20240126-gix-mtk-warnings-v1-15-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-15-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> Remove documentation from missing fields.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/staging/media/ipu3/include/uapi/intel-ipu3.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
> index caa358e0bae4..4aa2797f5e3c 100644
> --- a/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
> +++ b/drivers/staging/media/ipu3/include/uapi/intel-ipu3.h
> @@ -2485,11 +2485,9 @@ struct ipu3_uapi_anr_config {
>   *		&ipu3_uapi_yuvp1_y_ee_nr_config
>   * @yds:	y down scaler config. See &ipu3_uapi_yuvp1_yds_config
>   * @chnr:	chroma noise reduction config. See &ipu3_uapi_yuvp1_chnr_config
> - * @reserved1: reserved
>   * @yds2:	y channel down scaler config. See &ipu3_uapi_yuvp1_yds_config
>   * @tcc:	total color correction config as defined in struct
>   *		&ipu3_uapi_yuvp2_tcc_static_config
> - * @reserved2: reserved
>   * @anr:	advanced noise reduction config.See &ipu3_uapi_anr_config
>   * @awb_fr:	AWB filter response config. See ipu3_uapi_awb_fr_config
>   * @ae:	auto exposure config  As specified by &ipu3_uapi_ae_config
> @@ -2724,7 +2722,6 @@ struct ipu3_uapi_obgrid_param {
>   * @acc_ae: 0 = no update, 1 = update.
>   * @acc_af: 0 = no update, 1 = update.
>   * @acc_awb: 0 = no update, 1 = update.
> - * @__acc_osys: 0 = no update, 1 = update.
>   * @reserved3: Not used.
>   * @lin_vmem_params: 0 = no update, 1 = update.
>   * @tnr3_vmem_params: 0 = no update, 1 = update.
> 

-- 
#Randy

