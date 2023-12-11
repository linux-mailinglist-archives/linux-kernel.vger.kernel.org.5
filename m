Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C480C617
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjLKKLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbjLKKK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:10:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30EECF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:11:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C8DC433C8;
        Mon, 11 Dec 2023 10:11:00 +0000 (UTC)
Message-ID: <45fbd63f-068a-433d-9950-e6c645a6068b@xs4all.nl>
Date:   Mon, 11 Dec 2023 11:10:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] videobuf2: Add min_reqbufs_allocation field to
 vb2_queue structure
Content-Language: en-US, nl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, kernel@collabora.com
References: <20231208103908.85874-1-benjamin.gaignard@collabora.com>
 <20231208103908.85874-3-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <20231208103908.85874-3-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 08/12/2023 11:39, Benjamin Gaignard wrote:
> Add 'min_reqbufs_allocation' field in vb2_queue structure so drivers
> can specificy the minimum number of buffers to allocate when calling
> VIDIOC_REQBUFS.
> If used this minimum should be higher than the minimum number of
> queued buffers needed to start streaming.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-core.c | 1 +
>  include/media/videobuf2-core.h                  | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 7b6d89641e66..3bc30d107308 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -866,6 +866,7 @@ int vb2_core_reqbufs(struct vb2_queue *q, enum vb2_memory memory,
>  	 * Make sure the requested values and current defaults are sane.
>  	 */
>  	num_buffers = max_t(unsigned int, *count, q->min_queued_buffers);

This should be changed to 'q->min_queued_buffers + 1'.

Without the '+ 1' you wouldn't have a buffer available to return to userspace.

> +	num_buffers = max_t(unsigned int, num_buffers, q->min_reqbufs_allocation);
>  	num_buffers = min_t(unsigned int, num_buffers, q->max_num_buffers);
>  	memset(q->alloc_devs, 0, sizeof(q->alloc_devs));
>  	/*

I'm missing a WARN_ON in vb2_core_queue_init verifying that min_reqbufs_allocation
<= max_num_buffers. Also, min_reqbufs_allocation must be > min_queued_buffers + 1.

I also think it might be a good idea to add this to vb2_core_queue_init():

	if (!q->min_reqbufs_allocation)
		q->min_reqbufs_allocation = q->min_queued_buffers + 1;

Now we can just use q->min_reqbufs_allocation everywhere in vb2. And with
that change you can probably simplify the code, e.g. there is no more need
to check q->min_queued_buffers + 1 in the code above.

> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index 6d11cb724e95..252d34cc47d3 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -550,6 +550,11 @@ struct vb2_buf_ops {
>   *		@start_streaming can be called. Used when a DMA engine
>   *		cannot be started unless at least this number of buffers
>   *		have been queued into the driver.

This needs to be expanded:

 *		VIDIOC_REQBUFS will ensure at least @min_queued_buffers + 1
 *		buffers will be allocated. Note that VIDIOC_CREATE_BUFS will not
 *		modify the requested buffer count.

> + * @min_reqbufs_allocation: the minimum number of buffers allocated when
> + *		calling VIDIOC_REQBUFS. Used when drivers need a to
> + *		specify a minimum buffers allocation before setup a queue.
> + *		If min_queued_buffers < min_queued_buffers then min_queued_buffers
> + *		is the minimum.

I'd rephrase this:

 * @min_reqbufs_allocation: the minimum number of buffers to be allocated when
 *		calling VIDIOC_REQBUFS. Drivers can set this if there has to
 *		be a certain number of buffers available for the hardware to
 *		work effectively. If set, then @min_reqbufs_allocation must be
 *		larger than @min_queued_buffers + 1.
 *
 *		This field is only used by VIDIOC_REQBUFS. This allows calling
 *		that ioctl with a buffer count of 1 and it will be automatically
 *		adjusted to a workable buffer count. VIDIOC_CREATE_BUFS will not
 *		modify the requested buffer count.
 *
 *		If this field is > 3, then it is highly recommended that the
 *		driver implements the V4L2_CID_MIN_BUFFERS_FOR_CAPTURE/OUTPUT
 *		control.

Feel free to modify these texts, they are just suggestions.

>   */
>  /*
>   * Private elements (won't appear at the uAPI book):
> @@ -615,6 +620,7 @@ struct vb2_queue {
>  	u32				timestamp_flags;
>  	gfp_t				gfp_flags;
>  	u32				min_queued_buffers;
> +	u32				min_reqbufs_allocation;
>  
>  	struct device			*alloc_devs[VB2_MAX_PLANES];
>  

Looking through videobuf2-core.c I see one more min_queued_buffers-related issue:

In vb2_core_reqbufs() there is this code:

        if (allocated_buffers < q->min_buffers_needed)
                ret = -ENOMEM;

That should be '< q->min_reqbufs_allocation'.

Finally, add a patch updating the test-drivers as per "[PATCH v2 17/36] media:
test-drivers: Fix misuse of min_buffers_needed field" + my reply to that.

At least the test drivers should use these fields correctly.

Regards,

	Hans
