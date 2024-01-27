Return-Path: <linux-kernel+bounces-41414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BA483F082
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B44C286CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B51BF21;
	Sat, 27 Jan 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NeAn/eNC"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E6E1B80E;
	Sat, 27 Jan 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706393382; cv=none; b=gRwgjuDTMbwvAeaT4GHdoDpgJKm3b3q8pqD0DPO7CUFePpAYLDdIyajq/V8BGIq5szs6suSkKa0viiy/laEaTRDTCPyYlsqI/idZw6vX1Om5xDVCcg2o6d9wWLgCS92RKBvZCmTrBp4v4WZoKgrqQZc6+PIWo6HXTh4ODpw44SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706393382; c=relaxed/simple;
	bh=RjcbuB1jGmIYOzqZ0rVuEKllIJGS8a6WPEZoJvI9ZQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nD0pjDtXPC61Ol1SKPR2zYRaRfGW82958gWgq0ain8dmyJT7D4YI/v8UIyNq83Vvh98TuCfT0ejGH9zKab8ETRKqN+ErlMD4kVCxJX6m6ZZhZ+bMv5H7Tcqfp4AD2HRnY2T7RC+trVgcEl8PKcFZn2LDpDvxv5zIfT1lPWbVqLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NeAn/eNC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Ac/nRdSPsyofQRiBXur5LIG8eujGM+8tF7cRkxck+i0=; b=NeAn/eNC2y7htXMm4lg2RFQtLr
	aLFSjh+/KjqYtZBjQ81ZtcRlvuoglJToiZDyXFb0ZWgdbjRZiJ/I2VuNOewe7JZXYdXnEEmQOPIV9
	bEUg/MrDok8Lw/AApGRt/jp9N4TPPjAFdv0GRqUNr6Lzs66OCx/EmBgVD3ejKqkI3TctKsmCZ4YHd
	Sxt1hnsoTJv09uMzQcl9uG+W+0TvJ0kqvq6KmRmJH8m4wW6xJXHlaCC9gDtBL10l7fB9qm6kKYTgM
	17NYp1j8k6zVu4lY9eAbDyd4JVDXjh4E+lang/v3v4h4Vei5X7FGLmPyOj+5sSYG/VaPjZA8jWRNw
	FDlbWi+w==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTqrm-00000008H2f-3uWE;
	Sat, 27 Jan 2024 22:09:35 +0000
Message-ID: <6e780215-2cd2-452d-b879-5f96d4e6f42d@infradead.org>
Date: Sat, 27 Jan 2024 14:09:33 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] media: verisilicon: Fix kerneldoc
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
 <20240126-gix-mtk-warnings-v1-10-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-10-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> The field is not part of the structure. Remove the doc.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/media/platform/verisilicon/hantro.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index 6f5eb975d0e3..811260dc3c77 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -237,7 +237,6 @@ struct hantro_dev {
>   * @codec_ops:		Set of operations related to codec mode.
>   * @postproc:		Post-processing context.
>   * @h264_dec:		H.264-decoding context.
> - * @jpeg_enc:		JPEG-encoding context.
>   * @mpeg2_dec:		MPEG-2-decoding context.
>   * @vp8_dec:		VP8-decoding context.
>   * @hevc_dec:		HEVC-decoding context.
> 

-- 
#Randy

