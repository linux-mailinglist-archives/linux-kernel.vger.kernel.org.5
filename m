Return-Path: <linux-kernel+bounces-40965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317EE83E90D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D1A2881CF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7263CB65D;
	Sat, 27 Jan 2024 01:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HEAXzmCx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADCC944D;
	Sat, 27 Jan 2024 01:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706319531; cv=none; b=MaC3nWxJkNNgNwDoCnavlc0rKVgC7zLCialhYhRejLNZyxC2qW/wGwa/F2gy/LVSJjCSjDup1jrbNNsXm7lPpMR1k2Ph4cfCCDCLwCKv70wzlBD0KT1RiOln3gAQamqDQn3ysry7zzHGhtaN+ItWMOj2nJmVnoSu8LrNWfm8AGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706319531; c=relaxed/simple;
	bh=A1/ygdm7x3wtNRu3eyRy8/a37du/hTt3ajMykS1TWZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufUadhr++8z5y5mF201yYNSSEVCCvXDUuW4SvTXu29ZIjwH39qdknedFKeo2Ewlp++oXtlzZ5AZDaYcbqbfDeOLSN+Pa6JvvctI6y14M2AlvTMri1YgMImJbU4o5c0WYrBlH+45ZyyLWZIgdX9U9t8PqcxRTd3S2EQ9IdpZD5Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HEAXzmCx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XYytVHxOlurwd5+2vgAlofMMVVyo2Oaj6o0YkShtiUY=; b=HEAXzmCxPE9euMRkJ6PQe+i7AP
	gNkn1XIiNFqlmQ51Ukxam68ZoJwn2Dx50z9XGYSSVlVtG+QHDL4LjrGbTVZCY7HEhrQI/2MMtlb/X
	VNmGXTLsn5t06Ji9O96CY3PotfVqeHV+/nkfI5Ulmetow1iGDkiRcRsxvunduSTNZg0oBFOGl9++O
	sI+DYOZDI+sq0WCmP9bgglcKnI8xJL7nu7Dbn9FKOHxHWYywvcw7y8MlXP5JS0BzdvLaVllNvKpNX
	8EE0G6ALTofZQfsWVaQDVuLSMOBLYxDtEZtUWNOuWzBvO+xel9b7pcBa9J5sEDhA43oRbp+1YhlkF
	stt9sCog==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTXeY-000000068Aw-1jDt;
	Sat, 27 Jan 2024 01:38:38 +0000
Message-ID: <4131bd36-a6a8-4ec3-b323-b7c4aa487703@infradead.org>
Date: Fri, 26 Jan 2024 17:38:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] media: mediatek: vcodec: Fix kerneldoc warnings
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
 <20240126-gix-mtk-warnings-v1-1-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-1-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> These fields seems to be gone:
> drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c:57: warning: Excess struct member 'wait_key_frame' description in 'vdec_vp8_slice_info'
> drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c:166: warning: Excess struct member 'mv_joint' description in 'vdec_vp9_slice_counts_map'
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c    | 1 -
>  .../media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c    | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
> index f64b21c07169..f677e499fefa 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp8_req_if.c
> @@ -37,7 +37,6 @@
>   * @bs_sz:		bitstream size
>   * @resolution_changed:resolution change flag 1 - changed,  0 - not change
>   * @frame_header_type:	current frame header type
> - * @wait_key_frame:	wait key frame coming
>   * @crc:		used to check whether hardware's status is right
>   * @reserved:		reserved, currently unused
>   */
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> index 69d37b93bd35..cf48d09b78d7 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_lat_if.c
> @@ -141,7 +141,6 @@ struct vdec_vp9_slice_frame_counts {
>   * @skip:	skip counts.
>   * @y_mode:	Y prediction mode counts.
>   * @filter:	interpolation filter counts.
> - * @mv_joint:	motion vector joint counts.
>   * @sign:	motion vector sign counts.
>   * @classes:	motion vector class counts.
>   * @class0:	motion vector class0 bit counts.
> 

-- 
#Randy

