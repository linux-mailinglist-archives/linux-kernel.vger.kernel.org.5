Return-Path: <linux-kernel+bounces-41418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B6983F097
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241151C24617
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6443C1DA45;
	Sat, 27 Jan 2024 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dP6YUcR0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655671D68D;
	Sat, 27 Jan 2024 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706393870; cv=none; b=DJHt0NTvVBj3VaBLuR1f1l5/MOTPxXiPcuHhNIFs+Bzrvo2BqZPD+Wj7I2GdkZMmzdoyyynj3R1p3++E64MkFfIGWUySE7SPSOcA0VcBoSD5CJtpkOGxOQ0vH+F+u2VoWqedotJevpwahUxtbJs54scdOIIT7oqCyDiOmApBEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706393870; c=relaxed/simple;
	bh=ise3EdCDBxXc3AWYZqjxGIy0tVO9WLURF9JY+RojkK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJqvhUpTMfPJDJm77kUwAXx2FJ6CF0TWWDUNKcslR1nz2EsJPi9n2RstvoRXTWkjcOdavPbuBfjAvarQQUjv/e+F3DLr64f+gJRKEfbda5l1+PXdthmYTVMqZgC7aohhr5WbdNNfMuyD6Lqg9ic1wknxXDTyYZd/NUU8uHGFmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dP6YUcR0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=THYMKkTcMXpUfk1i5i9o98XbXUsf19talB62dQuJhd8=; b=dP6YUcR0fNZIDV9okmykAhRQoX
	pLTNiWUfFVUp4dBEjig0rHbv+7a8hClipcHI6cenKc7QMTYvd3Yqe4sO9mLWL3UjWWsgc59dNI1We
	Q6d38WRQvRyx6kd3igu9tmQKvbxsEj42gxThEdSt9rw3QZ8cVUTda6F8Lo027IFOgAwSlCViVtQ/f
	XlZ267nl6GFntZBEHA9WtdpPigJqCCKuvbBbKIlNebtPwn+jpxRf6ITPFoiySTtAFpTmOW9ufkUd7
	FZl4TslrPgKvBUXDlr2FnpTzLD3+bAPD4fjPEMLoKUHNpjaCeuyAVQFGMeKyQRJJsvK0WcpR5qpWy
	mx8uIcWQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTqzf-00000008Hpp-2Umt;
	Sat, 27 Jan 2024 22:17:43 +0000
Message-ID: <9790f78f-8616-45e8-becb-7afc10841e80@infradead.org>
Date: Sat, 27 Jan 2024 14:17:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] media: samsung: s5p-mfc: Fix kerneldoc
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
 <20240126-gix-mtk-warnings-v1-13-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-13-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> Remove doc from missing fields.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> index 59450b324f7d..7e7e7b695b53 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
> @@ -612,7 +612,6 @@ struct s5p_mfc_codec_ops {
>   * @chroma_dpb_size:	dpb buffer size for chroma
>   * @me_buffer_size:	size of the motion estimation buffer
>   * @tmv_buffer_size:	size of temporal predictor motion vector buffer
> - * @frame_type:		used to force the type of the next encoded frame
>   * @ref_queue:		list of the reference buffers for encoding
>   * @force_frame_type:	encoder's frame type forcing control
>   * @ref_queue_cnt:	number of the buffers in the reference list
> 

-- 
#Randy

