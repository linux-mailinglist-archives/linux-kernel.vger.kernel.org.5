Return-Path: <linux-kernel+bounces-41417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC9183F091
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2C71C24303
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF71C2AB;
	Sat, 27 Jan 2024 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bmfCH6Xp"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8121B7FA;
	Sat, 27 Jan 2024 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706393790; cv=none; b=obmsrYdYOPS0NOdHhaZmQiksBFlmQ9tkdmAxWpFTejQwPjSDXRBkrEJ8Z1JX5sUQvqIOcDgKif5jJImDhl1/3CiBoH4W/T8QvltOte4dNdO6S4jv1jTo6i0OKZ/ZDU8Oa1Bf6E+hZNa3TMH9pcQRiyBbu6Pnm++Oc1/lXfy7rRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706393790; c=relaxed/simple;
	bh=YSHfunSS4ecLqdUtQDR5pEaVjQ/uj59tmeX4gh9SSno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Thz9ERDdLdbTfule9PHeUZTLXkDRbI93/zEWL60CrXR7od808Uf8SxyInZ/A1rF78G+xbPdfi/7KyoDFH6Y3ydGmWD47ztayIp0DmeA60avmwc+NO99WEPzXFdWYnYEf0Q9l7leXZ/lqutC0TruYR6H81YmeW3M3ykc0nnex4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bmfCH6Xp; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=QVk+wHOOHOwLPnfHS0Lt1FiDB1iuU9eTerDUMC8rmMk=; b=bmfCH6XpQF0iImROm9IZxxO7bi
	Q2bJ+9a3phStjiOOWUhRroJZwU+FnPCeQx44O5ShQbL1fYIpHJfWYm3dRkizhH1pPXTX0hQwtf0Ej
	QATxgmiRHi8v64h0Eod1jhrMuBVjIF4ooQPkirH7MTSVE3O+m+zM3gp+wLaWDusAb1bH38zQbXPLz
	1ghXRkqrjiSxkFmOzuu78ko6zOgekaj16MIcd3vuIIGOhSXNH4m+k8cXRxtiAzny+wzFGEszjj0HH
	7myjGPGcJPieX4fCR3bTXnhNW/ax9AKw6sF+UNk+xaEDtYe5cUEjOrcBp7VPbfxcoO1FbD7+eNYh3
	4kjlIxCQ==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTqyN-00000008Hpp-1WRk;
	Sat, 27 Jan 2024 22:16:23 +0000
Message-ID: <4b3f5de5-4039-4b95-880a-70635f2e3112@infradead.org>
Date: Sat, 27 Jan 2024 14:16:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] media: samsung: exynos4-is: Fix kerneldoc
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
 <20240126-gix-mtk-warnings-v1-12-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-12-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> Remove doc from missing fields.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  drivers/media/platform/samsung/exynos4-is/fimc-lite.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/exynos4-is/fimc-lite.h b/drivers/media/platform/samsung/exynos4-is/fimc-lite.h
> index ddf29e0b5b1c..2d96fb00a5c6 100644
> --- a/drivers/media/platform/samsung/exynos4-is/fimc-lite.h
> +++ b/drivers/media/platform/samsung/exynos4-is/fimc-lite.h
> @@ -117,8 +117,6 @@ struct flite_buffer {
>   * @ctrl_handler: v4l2 control handler
>   * @test_pattern: test pattern controls
>   * @index: FIMC-LITE platform device index
> - * @pipeline: video capture pipeline data structure
> - * @pipeline_ops: media pipeline ops for the video node driver
>   * @slock: spinlock protecting this data structure and the hw registers
>   * @lock: mutex serializing video device and the subdev operations
>   * @clock: FIMC-LITE gate clock
> @@ -134,7 +132,6 @@ struct flite_buffer {
>   * @active_buf_q: the queue head of buffers scheduled in hardware
>   * @vb_queue: vb2 buffers queue
>   * @buf_index: helps to keep track of the DMA start address register index
> - * @active_buf_count: number of video buffers scheduled in hardware
>   * @frame_count: the captured frames counter
>   * @reqbufs_count: the number of buffers requested with REQBUFS ioctl
>   * @events: event info
> 

-- 
#Randy

