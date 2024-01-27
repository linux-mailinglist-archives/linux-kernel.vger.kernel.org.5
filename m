Return-Path: <linux-kernel+bounces-40967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1201B83E917
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93FCF1F28D95
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56A4B666;
	Sat, 27 Jan 2024 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qkt5I1h0"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A662C9D;
	Sat, 27 Jan 2024 01:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706319761; cv=none; b=kJTcsQNm0Bcixv3RkgmkzgM5JJKKQcOXsxmBMuw+NWdylm3tio41h4Uba24gwLU15u7B7Nty5rXRbXko7m1/j10CE9o2RMExYkJ7iMhDRKlcI4pDX/s9xg7nDtlzBYQF5dY90D+V2U+RmFiNHBAMPLCDOCezQHxOrUfT3p6EsyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706319761; c=relaxed/simple;
	bh=+FrMO7KHGjeU3O6gA7ZRLbSvP919wTJoRAJoLE3ZL+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZ7QEK6r5SFRwBfoCtt1AdpZSNHlq8wAPk+srhctSBJC5oQxXoUXm5wCGNmqeqXfO0OAr3F/b0OeffLe8JS8H34Z2QACPfDemzrXYOw7IHJUdUXY8DN+QnFJFA5g6xlijiqhouV9qL1EqTmYV6Onl4oAPYj1eQgv0Ny3m/fUJ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qkt5I1h0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=w4asszGwiUMo7LHN03Rxc+ehZmU371TLpgrR3TOTZpw=; b=qkt5I1h0cn6wXrxkJFgyE7S4no
	APcN+6ANbj0CEzFjg+mUAYnmtDt7OZh4nbDkragi+1Fu6DmIGuYsKXrP39zKy99SiX/Xzc2c/LZHN
	yYlrZbKxJFnTMfA6DGmF5e92cXraM/2WLiL0QlCJ9eGUQbar8sa9Zhk83xsunWB2/maDN5uZau56x
	RNgPHqrSq5rU4/yogDSj6fcE4JGTCo2y7JwbPsnexqISZq/fKWHDc0fG3ev8zLO91ZjvaCgDiwbJ5
	B0uCA3rRIOd6d2RiYunm0PN/qYbTQKJdHbE/5tRfeKWNDNNFKQanMF/bMcFWiL0z7X6RldM/5NCYx
	OD19zURw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTXiL-0000000698f-1Znu;
	Sat, 27 Jan 2024 01:42:33 +0000
Message-ID: <c2b1e412-f1da-4e71-8ab9-e1a655c966e3@infradead.org>
Date: Fri, 26 Jan 2024 17:42:32 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] media: videodev2.h: Fix kerneldoc
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
 <20240126-gix-mtk-warnings-v1-2-eed7865fce18@chromium.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240126-gix-mtk-warnings-v1-2-eed7865fce18@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/26/24 15:16, Ricardo Ribalda wrote:
> Named nested unions need their prefix:
> https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#nested-structs-unions
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/uapi/linux/videodev2.h | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index 68e7ac178cc2..a8015e5e7fa4 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -1041,13 +1041,13 @@ struct v4l2_requestbuffers {
>   * struct v4l2_plane - plane info for multi-planar buffers
>   * @bytesused:		number of bytes occupied by data in the plane (payload)
>   * @length:		size of this plane (NOT the payload) in bytes
> - * @mem_offset:		when memory in the associated struct v4l2_buffer is
> + * @m.mem_offset:	when memory in the associated struct v4l2_buffer is
>   *			V4L2_MEMORY_MMAP, equals the offset from the start of
>   *			the device memory for this plane (or is a "cookie" that
>   *			should be passed to mmap() called on the video node)
> - * @userptr:		when memory is V4L2_MEMORY_USERPTR, a userspace pointer
> + * @m.userptr:		when memory is V4L2_MEMORY_USERPTR, a userspace pointer
>   *			pointing to this plane
> - * @fd:			when memory is V4L2_MEMORY_DMABUF, a userspace file
> + * @m.fd:		when memory is V4L2_MEMORY_DMABUF, a userspace file
>   *			descriptor associated with this plane
>   * @m:			union of @mem_offset, @userptr and @fd
>   * @data_offset:	offset in the plane to the start of data; usually 0,
> @@ -1085,14 +1085,14 @@ struct v4l2_plane {
>   * @sequence:	sequence count of this frame
>   * @memory:	enum v4l2_memory; the method, in which the actual video data is
>   *		passed
> - * @offset:	for non-multiplanar buffers with memory == V4L2_MEMORY_MMAP;
> + * @m.offset:	for non-multiplanar buffers with memory == V4L2_MEMORY_MMAP;
>   *		offset from the start of the device memory for this plane,
>   *		(or a "cookie" that should be passed to mmap() as offset)
> - * @userptr:	for non-multiplanar buffers with memory == V4L2_MEMORY_USERPTR;
> + * @m.userptr:	for non-multiplanar buffers with memory == V4L2_MEMORY_USERPTR;
>   *		a userspace pointer pointing to this buffer
> - * @fd:		for non-multiplanar buffers with memory == V4L2_MEMORY_DMABUF;
> + * @m.fd:		for non-multiplanar buffers with memory == V4L2_MEMORY_DMABUF;
>   *		a userspace file descriptor associated with this buffer
> - * @planes:	for multiplanar buffers; userspace pointer to the array of plane
> + * @m.planes:	for multiplanar buffers; userspace pointer to the array of plane
>   *		info structs for this buffer
>   * @m:		union of @offset, @userptr, @planes and @fd
>   * @length:	size in bytes of the buffer (NOT its payload) for single-plane
> @@ -2423,15 +2423,15 @@ struct v4l2_meta_format {
>  
>  /**
>   * struct v4l2_format - stream data format
> - * @type:	enum v4l2_buf_type; type of the data stream
> - * @pix:	definition of an image format
> - * @pix_mp:	definition of a multiplanar image format
> - * @win:	definition of an overlaid image
> - * @vbi:	raw VBI capture or output parameters
> - * @sliced:	sliced VBI capture or output parameters
> - * @raw_data:	placeholder for future extensions and custom formats
> - * @fmt:	union of @pix, @pix_mp, @win, @vbi, @sliced, @sdr, @meta
> - *		and @raw_data
> + * @type:		enum v4l2_buf_type; type of the data stream
> + * @fmt.pix:		definition of an image format
> + * @fmt.pix_mp:		definition of a multiplanar image format
> + * @fmt.win:		definition of an overlaid image
> + * @fmt.vbi:		raw VBI capture or output parameters
> + * @fmt.sliced:		sliced VBI capture or output parameters
> + * @fmt.raw_data:	placeholder for future extensions and custom formats
> + * @fmt:		union of @pix, @pix_mp, @win, @vbi, @sliced, @sdr,
> + *			@meta and @raw_data
>   */
>  struct v4l2_format {
>  	__u32	 type;
> 

-- 
#Randy

