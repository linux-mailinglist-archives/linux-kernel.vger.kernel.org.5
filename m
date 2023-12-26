Return-Path: <linux-kernel+bounces-11410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C73B881E5E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424551F223A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA1F4CB43;
	Tue, 26 Dec 2023 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QVc5/mzz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDBE4CB39
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso1366901a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 00:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703579033; x=1704183833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLehRK77nhRqWHOhFH4iOgyb8YlvIlkQFgSTelSqOnM=;
        b=QVc5/mzztJ/5ibKfUyPpI0MS72eq63pT2STAOSe+KQSrdFowH4rj2j0CNn8D+K7/gY
         IlpUc+JkELReffaXcuhSGFVMXLT3EnHFP/IMi9fup2ABVWIofMjQQ5LbO5kACp/zKipd
         9RyrKfEwRW4Wvup3vAl4XBeaoNgz0E58ftWNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703579033; x=1704183833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLehRK77nhRqWHOhFH4iOgyb8YlvIlkQFgSTelSqOnM=;
        b=B/utHwGGOHfd9rmzk7fXVxwX5LgWKcHh7P8M94pacIy37WBvEpv9DBRAJubP7CmNxF
         vs5XzT+wM0rhxYbi9AuahuKkOZBKWrS/MGHWbfIoAxuGJ+rsjxzFuOBKiT5ys8KhGR88
         MbVgLB+/Ip1j06ZnJq8hlBLQTjWWXpk1WuYyXAUgphuXFftFHkkqE0JKUrBDrTbUzNTK
         LHBMS/wCS8pbNYD+hu6KvpyCAcy9NBocDT+qDd6JhtnQaBrNYW38YLFzKdXDNSaJCVCg
         079sEugKmz6yrC95DCjshUH61nFVezzYXBS1i9Xj8HQBaBeeuNwe6Dn+WoxGMBHtie+e
         HxRQ==
X-Gm-Message-State: AOJu0YyIfYfek0jQhvCysHkrBqYLLhCQVGYwIOK20OTOeE+/CffgDuKz
	Y61g/oSEStzh0yDhZ6kRPmlui59pF3v6
X-Google-Smtp-Source: AGHT+IG9doc507EpbIBeWdi8nniPXy2PH/GHhwLjp9Hs7CRC0/nXyDxCBsdM1zFB1N14bMygNEsNjQ==
X-Received: by 2002:a05:6a21:8185:b0:18b:480:a0f3 with SMTP id pd5-20020a056a21818500b0018b0480a0f3mr2755854pzb.4.1703579032752;
        Tue, 26 Dec 2023 00:23:52 -0800 (PST)
Received: from chromium.org (112.157.221.35.bc.googleusercontent.com. [35.221.157.112])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902e85200b001d3be09f374sm9327431plg.275.2023.12.26.00.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 00:23:52 -0800 (PST)
Date: Tue, 26 Dec 2023 08:23:49 +0000
From: Tomasz Figa <tfiga@chromium.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: hverkuil@xs4all.nl, mchehab@kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	kernel@collabora.com
Subject: Re: [PATCH v5 1/3] videobuf2: core: Rename min_buffers_needed field
 to vb2_queue
Message-ID: <20231226082349.x5ebvmt5dpanrm4k@chromium.org>
References: <20231211133251.150999-1-benjamin.gaignard@collabora.com>
 <20231211133251.150999-2-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211133251.150999-2-benjamin.gaignard@collabora.com>

Hi Benjamin,

On Mon, Dec 11, 2023 at 02:32:49PM +0100, Benjamin Gaignard wrote:
> Rename min_buffers_needed into min_queued_buffers and update
> the documentation about it.
> 

Sorry for being late to the party. I think this is generally a good idea,
thanks for doing this! Just one comment inline.

[snip]
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 40d89f29fa33..8912dff5bde3 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -865,7 +865,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	/*
>  	 * Make sure the requested values and current defaults are sane.
>  	 */
> -	num_buffers = max_t(unsigned int, *count, q->min_buffers_needed);
> +	num_buffers = max_t(unsigned int, *count, q->min_queued_buffers + 1);

Where does this + 1 come from here?
Agreed with Hans that this change deserves its own patch with a proper
explanation in its description.

>  	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
>  	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
>  	/*
> @@ -917,7 +917,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	 * There is no point in continuing if we can't allocate the minimum
>  	 * number of buffers needed by this vb2_queue.
>  	 */
> -	if (allocated_buffers < q->min_buffers_needed)
> +	if (allocated_buffers < q->min_queued_buffers)
>  		ret = -ENOMEM;
>  
>  	/*
> @@ -1653,7 +1653,7 @@ EXPORT_SYMBOL_GPL(vb2_core_prepare_buf);
>   * @q:		videobuf2 queue
>   *
>   * Attempt to start streaming. When this function is called there must be
> - * at least q->min_buffers_needed buffers queued up (i.e. the minimum
> + * at least q->min_queued_buffers queued up (i.e. the minimum
>   * number of buffers required for the DMA engine to function). If the
>   * @start_streaming op fails it is supposed to return all the driver-owned
>   * buffers back to vb2 in state QUEUED. Check if that happened and if
> @@ -1846,7 +1846,7 @@ int vb2_core_qbuf(struct vb2_queue *q, struct vb2_buffer *vb, void *pb,
>  	 * then we can finally call start_streaming().
>  	 */
>  	if (q->streaming && !q->start_streaming_called &&
> -	    q->queued_count >= q->min_buffers_needed) {
> +	    q->queued_count >= q->min_queued_buffers) {
>  		ret = vb2_start_streaming(q);
>  		if (ret) {
>  			/*
> @@ -2210,9 +2210,9 @@ int vb2_core_streamon(struct vb2_queue *q, unsigned int type)
>  		return -EINVAL;
>  	}
>  
> -	if (q_num_bufs < q->min_buffers_needed) {
> -		dprintk(q, 1, "need at least %u allocated buffers\n",
> -				q->min_buffers_needed);
> +	if (q_num_bufs < q->min_queued_buffers) {
> +		dprintk(q, 1, "need at least %u queued buffers\n",

Note that the value being checked here is the number of allocated buffers,
not queued buffers. So basically we're enforcing here that at the time
STREAMON is called, there is enough buffers allocated to queue the minimum
number of buffers to start streaming, but then later down we're not
actually enforcing that they are queued - if not, the queue start_streaming
operation is deferred until enough buffers are queued.

The question is: Do we really want this to be an error? Or should we just
be consistent with the allocated-but-not-queued case and let the
application allocate more buffers later using CREATE_BUFS?
(Another question: How does an application know how many buffers to
allocate for STREAMON to work?)

That said, this doesn't really affect the correctness of the patch itself.
Just some additional oddity in the current implementation that we could
simplify in the future.

> +			q->min_queued_buffers);
>  		return -EINVAL;
>  	}
>  
[snip]
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 5557d78b6f20..f9a00b6c3c46 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -546,10 +546,13 @@ struct vb2_buf_ops {
>   * @gfp_flags:	additional gfp flags used when allocating the buffers.
>   *		Typically this is 0, but it may be e.g. %GFP_DMA or %__GFP_DMA32
>   *		to force the buffer allocation to a specific memory zone.
> - * @min_buffers_needed: the minimum number of buffers needed before
> + * @min_queued_buffers: the minimum number of queued buffers needed before
>   *		@start_streaming can be called. Used when a DMA engine
>   *		cannot be started unless at least this number of buffers
>   *		have been queued into the driver.
> + *		VIDIOC_REQBUFS will ensure at least @min_queued_buffers + 1
> + *		buffers will be allocated. Note that VIDIOC_CREATE_BUFS will not
> + *		modify the requested buffer count.

Same here, this + 1 needs a proper explanation.
Also, I don't like this API inconsistency where REQBUFS guarantees the
right number of buffers, but CREATE_BUFS doesn't. In fact, would an
application have a way to know how many buffers to allocate if it simply
wants to use CREATE_BUFS?

(It's generally related to the oddity that I pointed out above. Maybe we
should let the allocation code only handle allocation constraints and not
care about STREAMON constraints?)

[snip]

Best regards,
Tomasz

