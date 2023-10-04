Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626E17B7A10
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbjJDIbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJDIbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:31:39 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9E283;
        Wed,  4 Oct 2023 01:31:35 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163d.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4S0nwH0HHJzybV;
        Wed,  4 Oct 2023 11:31:26 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1696408293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKqxzOZ2qGHHi9gAj4QDW8D+W69O9XKgDH2rcoYp++Q=;
        b=jjKP9GPPuYNPNjVbWbzKxhtGMkzgxCQPjiea+rmCSgFJrsqjVHQLqf/i7/g60tHSes247Z
        zFroukg23yHFYFkYnkdak91bh95u8O5mZm4Mp13Lw7ju0ptDNyY9JIZFg9pPwYvZhsyHkH
        AoK+odFqRbpor22ObYuSY+HJQUlFOAw=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1696408293; a=rsa-sha256; cv=none;
        b=oBwSZIhyYZBJPLRuTIiXSEnw/21bkB5xqV/XPaagFVamkH8QEp1zC49wRg5EHuzGPubNrn
        zNOoVvPUcrh3AiG3WUFvrDnZ8Ph919Su3hN0OC6hDoMQjAwD0mHRk2OeSsWotS55SPKNLj
        V1kWmJsar6rJgtbyd/Gw9q2x3NnQD70=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1696408293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JKqxzOZ2qGHHi9gAj4QDW8D+W69O9XKgDH2rcoYp++Q=;
        b=pGuoSjaqsBGGVqxwz2ha7qzoPXBIFO5QeGWUsOsGlfRCknQ3zvipKtQz+1V9Dl75a2kbE4
        yiq0SZrqqt6dEnQoBuCqtcCu5DAZfnIq5rGc8WOe2K00/8NHZBPcOIzVo2AtnNRFq0y22s
        a6KBPAMIhz3/rzC50ON9Q0l4LcsVgcU=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 91D2C634C93;
        Wed,  4 Oct 2023 11:31:25 +0300 (EEST)
Date:   Wed, 4 Oct 2023 08:31:25 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v10 01/54] media: videobuf2: Rework offset 'cookie'
 encoding pattern
Message-ID: <ZR0i3Rv58uDOPNTK@valkosipuli.retiisi.eu>
References: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
 <20231003080704.43911-2-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003080704.43911-2-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On Tue, Oct 03, 2023 at 10:06:10AM +0200, Benjamin Gaignard wrote:
> Change how offset 'cookie' field value is computed to make possible
> to use more buffers.
> The maximum number of buffers depends of PAGE_SHIFT value and can
> go up to 0x7fff when PAGE_SHIFT = 12.
> With this encoding pattern we know the maximum number that a queue
> could store so we can check it at  queue init time.
> It also make easier and faster to find buffer and plane from using
> the offset field.
> Change __find_plane_by_offset() prototype to return the video buffer
> itself rather than it index.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> changes in version 10:
> - Make BUFFER_INDEX_MASK definition more readable.
> - Correct typo.
> 
>  .../media/common/videobuf2/videobuf2-core.c   | 72 +++++++++----------
>  1 file changed, 33 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 27aee92f3eea..5591ac830668 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -31,6 +31,11 @@
>  
>  #include <trace/events/vb2.h>
>  
> +#define PLANE_INDEX_SHIFT	(PAGE_SHIFT + 3)
> +#define PLANE_INDEX_MASK	0x7
> +#define MAX_BUFFER_INDEX	BIT_MASK(30 - PLANE_INDEX_SHIFT)
> +#define BUFFER_INDEX_MASK	(MAX_BUFFER_INDEX - 1)
> +
>  static int debug;
>  module_param(debug, int, 0644);
>  
> @@ -358,21 +363,24 @@ static void __setup_offsets(struct vb2_buffer *vb)
>  	unsigned int plane;
>  	unsigned long off = 0;
>  
> -	if (vb->index) {
> -		struct vb2_buffer *prev = q->bufs[vb->index - 1];
> -		struct vb2_plane *p = &prev->planes[prev->num_planes - 1];
> -
> -		off = PAGE_ALIGN(p->m.offset + p->length);
> -	}
> +	/*
> +	 * Offsets cookies value have the following constraints:
> +	 * - a buffer can have up to 8 planes.
> +	 * - v4l2 mem2mem uses bit 30 to distinguish between source and destination buffers.

Long line.

Shouldn't this be OUTPUT and CAPTURE?

> +	 * - must be page aligned
> +	 * That led to this bit mapping when PAGE_SHIFT = 12:
> +	 * |30                |29        15|14       12|11 0|
> +	 * |DST_QUEUE_OFF_BASE|buffer index|plane index| 0  |
> +	 * where there are 15 bits to store the buffer index.
> +	 * Depending on PAGE_SHIFT value we can have fewer bits to store the buffer index.

Here, too...

> +	 */
> +	off = vb->index << PLANE_INDEX_SHIFT;
>  
>  	for (plane = 0; plane < vb->num_planes; ++plane) {
> -		vb->planes[plane].m.offset = off;
> +		vb->planes[plane].m.offset = off + (plane << PAGE_SHIFT);
>  
>  		dprintk(q, 3, "buffer %d, plane %d offset 0x%08lx\n",
>  				vb->index, plane, off);
> -
> -		off += vb->planes[plane].length;
> -		off = PAGE_ALIGN(off);
>  	}
>  }
>  
> @@ -2185,13 +2193,12 @@ int vb2_core_streamoff(struct vb2_queue *q, unsigned int type)
>  EXPORT_SYMBOL_GPL(vb2_core_streamoff);
>  
>  /*
> - * __find_plane_by_offset() - find plane associated with the given offset off
> + * __find_plane_by_offset() - find video buffer and plane associated with the given offset off
>   */
>  static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
> -			unsigned int *_buffer, unsigned int *_plane)
> +			struct vb2_buffer **vb, unsigned int *plane)
>  {
> -	struct vb2_buffer *vb;
> -	unsigned int buffer, plane;
> +	unsigned int buffer;
>  
>  	/*
>  	 * Sanity checks to ensure the lock is held, MEMORY_MMAP is
> @@ -2209,24 +2216,15 @@ static int __find_plane_by_offset(struct vb2_queue *q, unsigned long off,
>  		return -EBUSY;
>  	}
>  
> -	/*
> -	 * Go over all buffers and their planes, comparing the given offset
> -	 * with an offset assigned to each plane. If a match is found,
> -	 * return its buffer and plane numbers.
> -	 */
> -	for (buffer = 0; buffer < q->num_buffers; ++buffer) {
> -		vb = q->bufs[buffer];
> +	/* Get buffer and plane from the offset */
> +	buffer = (off >> PLANE_INDEX_SHIFT) & BUFFER_INDEX_MASK;
> +	*plane = (off >> PAGE_SHIFT) & PLANE_INDEX_MASK;
>  
> -		for (plane = 0; plane < vb->num_planes; ++plane) {
> -			if (vb->planes[plane].m.offset == off) {
> -				*_buffer = buffer;
> -				*_plane = plane;
> -				return 0;
> -			}
> -		}
> -	}
> +	if (buffer >= q->num_buffers || *plane >= q->bufs[buffer]->num_planes)
> +		return -EINVAL;
>  
> -	return -EINVAL;
> +	*vb = q->bufs[buffer];
> +	return 0;
>  }
>  
>  int vb2_core_expbuf(struct vb2_queue *q, int *fd, unsigned int type,
> @@ -2306,7 +2304,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
>  {
>  	unsigned long off = vma->vm_pgoff << PAGE_SHIFT;
>  	struct vb2_buffer *vb;
> -	unsigned int buffer = 0, plane = 0;
> +	unsigned int plane = 0;
>  	int ret;
>  	unsigned long length;
>  
> @@ -2335,12 +2333,10 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
>  	 * Find the plane corresponding to the offset passed by userspace. This
>  	 * will return an error if not MEMORY_MMAP or file I/O is in progress.
>  	 */
> -	ret = __find_plane_by_offset(q, off, &buffer, &plane);
> +	ret = __find_plane_by_offset(q, off, &vb, &plane);
>  	if (ret)
>  		goto unlock;
>  
> -	vb = q->bufs[buffer];
> -
>  	/*
>  	 * MMAP requires page_aligned buffers.
>  	 * The buffer length was page_aligned at __vb2_buf_mem_alloc(),
> @@ -2368,7 +2364,7 @@ int vb2_mmap(struct vb2_queue *q, struct vm_area_struct *vma)
>  	if (ret)
>  		return ret;
>  
> -	dprintk(q, 3, "buffer %d, plane %d successfully mapped\n", buffer, plane);
> +	dprintk(q, 3, "buffer %u, plane %d successfully mapped\n", vb->index, plane);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(vb2_mmap);
> @@ -2382,7 +2378,7 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
>  {
>  	unsigned long off = pgoff << PAGE_SHIFT;
>  	struct vb2_buffer *vb;
> -	unsigned int buffer, plane;
> +	unsigned int plane;
>  	void *vaddr;
>  	int ret;
>  
> @@ -2392,12 +2388,10 @@ unsigned long vb2_get_unmapped_area(struct vb2_queue *q,
>  	 * Find the plane corresponding to the offset passed by userspace. This
>  	 * will return an error if not MEMORY_MMAP or file I/O is in progress.
>  	 */
> -	ret = __find_plane_by_offset(q, off, &buffer, &plane);
> +	ret = __find_plane_by_offset(q, off, &vb, &plane);
>  	if (ret)
>  		goto unlock;
>  
> -	vb = q->bufs[buffer];
> -
>  	vaddr = vb2_plane_vaddr(vb, plane);
>  	mutex_unlock(&q->mmap_lock);
>  	return vaddr ? (unsigned long)vaddr : -EINVAL;

-- 
Regards,

Sakari Ailus
