Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE27EB821
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjKNVEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNVEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:04:10 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C831195
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:04:06 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bee11456baso5282135b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 13:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699995846; x=1700600646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjmcNeZhrefNUyVY1em5QbCLnop7PtKaN2GsNSSWYA4=;
        b=GqaQhgUMl0p3IygitTYtHmY3xiORWRVlPIzsYKh5jovWXrzE3zMTnhWP3vsUgOFqP+
         17VJtFAUdYg+X6zPyB8WvQ33g8/CgFCqyFtdJFvn8JtQ8gTPMGKKfaBYqBA4YzQxeThC
         vLU5/JvI585pea2FZBee86mz7dUCwa/g4z8d/q3DJKz+vb6d9JkO8wQodt7SsfrKChRM
         U6Z3AVwH2rVbdRIqz64xhSwtqcPEdjJHda8OTItOCavyT2uF7dQ5ehUz+62C6NH6PrdH
         QsCLjugqLvP8oM3SfD1WqJgL1pkEfhuZ94vA4IzkgdSUgmDUeIXvRKAfLmnYVHfPbL0a
         VHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699995846; x=1700600646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjmcNeZhrefNUyVY1em5QbCLnop7PtKaN2GsNSSWYA4=;
        b=Tt6cBHB7oxDREp+vroduJx5+R2tvRfOfi4OX2EZco7EgYuU078+U9pAp3l31svDUDH
         bBoy/gyiE6Q+SCqCOgb9OZ1seQd1nlvZw54YpVw1nG3HzX75X8oJ8SUZBjCpSnozyacA
         G9RYru1/ul/nKhVZ+oltfR0rx1FLUmOG+Fzm33qqXeaZn0fjTX41FGAIQ6ooZQQNqL9/
         rIBJBEPZEwEwqjCQ1G5k5yK4eYvqLsR2Jnt+Sf+qiTdkuCEa75aTZsCR3TCcsOrKVYWx
         5ADY6RqLqgcRcLWyhdkFk1cv+t8j2mzMHkz2MigpJ43bfmQdtAMr+WXrOQe/ZQdxza7a
         MXag==
X-Gm-Message-State: AOJu0YyXaN03kwtfPZ/0p3bAbcV/Y63rbwwmpaa6W4bmu5yRwbhejABM
        cvC+C9oNAz34D5cff0ohQMhPsg==
X-Google-Smtp-Source: AGHT+IF+/ubiFsFk/ps5IuxtuTf+htTpjU57D2zMenSQiIigtpnBq4IN+0vtUNNscpMJHjlPjbhE9Q==
X-Received: by 2002:a05:6a00:3907:b0:6be:43f8:4e0b with SMTP id fh7-20020a056a00390700b006be43f84e0bmr9762580pfb.24.1699995845983;
        Tue, 14 Nov 2023 13:04:05 -0800 (PST)
Received: from [192.168.60.239] (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with ESMTPSA id i30-20020a056a00005e00b0068ffb8da107sm1564892pfk.212.2023.11.14.13.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 13:04:05 -0800 (PST)
Message-ID: <444878d9-be44-4f52-91c7-f593a24cd930@google.com>
Date:   Tue, 14 Nov 2023 13:04:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/4] usb: gadget: uvc: prevent use of disabled
 endpoint
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     etalvala@google.com, jchowdhary@google.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, m.grzeschik@pengutronix.de,
        dan.scally@ideasonboard.com
References: <73309396-3856-43a2-9a6f-81a40ed594db@google.com>
 <20231109004104.3467968-1-arakesh@google.com>
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <20231109004104.3467968-1-arakesh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Greg, I think this patchset is ready for submission. 
Let me know if I am missing something and something else
needs to be done.

Thank you!
- Avi

On 11/8/23 16:41, Avichal Rakesh wrote:
> Currently the set_alt callback immediately disables the endpoint and queues
> the v4l2 streamoff event. However, as the streamoff event is processed
> asynchronously, it is possible that the video_pump thread attempts to queue
> requests to an already disabled endpoint.
> 
> This change moves disabling usb endpoint to the end of streamoff event
> callback. As the endpoint's state can no longer be used, video_pump is
> now guarded by uvc->state as well. To be consistent with the actual
> streaming state, uvc->state is now toggled between CONNECTED and STREAMING
> from the v4l2 event callback only.
> 
> Link: https://lore.kernel.org/20230615171558.GK741@pendragon.ideasonboard.com/
> Link: https://lore.kernel.org/20230531085544.253363-1-dan.scally@ideasonboard.com/
> Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
> Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Avichal Rakesh <arakesh@google.com>
> ---
> v1  -> v2  : Rebased to ToT and reworded commit message.
> v2  -> v3  : Fix email threading goof-up
> v3  -> v4  : Address review comments & re-rebase to ToT
> v4  -> v5  : Add Reviewed-by & Tested-by
> v5  -> v6  : No change
> v6  -> v7  : No change
> v7  -> v8  : No change. Getting back in review queue
> v8  -> v9  : Fix typo. No functional change.
> v9  -> v10 : Rebase to ToT (usb-next)
> v10 -> v11 : No change
> v11 -> v12 : Rebase to ToT (usb-next)
> 
>  drivers/usb/gadget/function/f_uvc.c     | 11 +++++------
>  drivers/usb/gadget/function/f_uvc.h     |  2 +-
>  drivers/usb/gadget/function/uvc.h       |  2 +-
>  drivers/usb/gadget/function/uvc_v4l2.c  | 20 +++++++++++++++++---
>  drivers/usb/gadget/function/uvc_video.c |  3 ++-
>  5 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 786379f1b7b7..77999ed53d33 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -263,10 +263,13 @@ uvc_function_setup(struct usb_function *f, const struct usb_ctrlrequest *ctrl)
>  	return 0;
>  }
> 
> -void uvc_function_setup_continue(struct uvc_device *uvc)
> +void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep)
>  {
>  	struct usb_composite_dev *cdev = uvc->func.config->cdev;
> 
> +	if (disable_ep && uvc->video.ep)
> +		usb_ep_disable(uvc->video.ep);
> +
>  	usb_composite_setup_continue(cdev);
>  }
> 
> @@ -337,15 +340,11 @@ uvc_function_set_alt(struct usb_function *f, unsigned interface, unsigned alt)
>  		if (uvc->state != UVC_STATE_STREAMING)
>  			return 0;
> 
> -		if (uvc->video.ep)
> -			usb_ep_disable(uvc->video.ep);
> -
>  		memset(&v4l2_event, 0, sizeof(v4l2_event));
>  		v4l2_event.type = UVC_EVENT_STREAMOFF;
>  		v4l2_event_queue(&uvc->vdev, &v4l2_event);
> 
> -		uvc->state = UVC_STATE_CONNECTED;
> -		return 0;
> +		return USB_GADGET_DELAYED_STATUS;
> 
>  	case 1:
>  		if (uvc->state != UVC_STATE_CONNECTED)
> diff --git a/drivers/usb/gadget/function/f_uvc.h b/drivers/usb/gadget/function/f_uvc.h
> index 1db972d4beeb..083aef0c65c6 100644
> --- a/drivers/usb/gadget/function/f_uvc.h
> +++ b/drivers/usb/gadget/function/f_uvc.h
> @@ -11,7 +11,7 @@
> 
>  struct uvc_device;
> 
> -void uvc_function_setup_continue(struct uvc_device *uvc);
> +void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep);
> 
>  void uvc_function_connect(struct uvc_device *uvc);
> 
> diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
> index 6751de8b63ad..989bc6b4e93d 100644
> --- a/drivers/usb/gadget/function/uvc.h
> +++ b/drivers/usb/gadget/function/uvc.h
> @@ -177,7 +177,7 @@ struct uvc_file_handle {
>   * Functions
>   */
> 
> -extern void uvc_function_setup_continue(struct uvc_device *uvc);
> +extern void uvc_function_setup_continue(struct uvc_device *uvc, int disable_ep);
>  extern void uvc_function_connect(struct uvc_device *uvc);
>  extern void uvc_function_disconnect(struct uvc_device *uvc);
> 
> diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
> index 3f0a9795c0d4..7cb8d027ff0c 100644
> --- a/drivers/usb/gadget/function/uvc_v4l2.c
> +++ b/drivers/usb/gadget/function/uvc_v4l2.c
> @@ -451,7 +451,7 @@ uvc_v4l2_streamon(struct file *file, void *fh, enum v4l2_buf_type type)
>  	 * Complete the alternate setting selection setup phase now that
>  	 * userspace is ready to provide video frames.
>  	 */
> -	uvc_function_setup_continue(uvc);
> +	uvc_function_setup_continue(uvc, 0);
>  	uvc->state = UVC_STATE_STREAMING;
> 
>  	return 0;
> @@ -463,11 +463,18 @@ uvc_v4l2_streamoff(struct file *file, void *fh, enum v4l2_buf_type type)
>  	struct video_device *vdev = video_devdata(file);
>  	struct uvc_device *uvc = video_get_drvdata(vdev);
>  	struct uvc_video *video = &uvc->video;
> +	int ret = 0;
> 
>  	if (type != video->queue.queue.type)
>  		return -EINVAL;
> 
> -	return uvcg_video_enable(video, 0);
> +	uvc->state = UVC_STATE_CONNECTED;
> +	ret = uvcg_video_enable(video, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	uvc_function_setup_continue(uvc, 1);
> +	return 0;
>  }
> 
>  static int
> @@ -500,6 +507,14 @@ uvc_v4l2_subscribe_event(struct v4l2_fh *fh,
>  static void uvc_v4l2_disable(struct uvc_device *uvc)
>  {
>  	uvc_function_disconnect(uvc);
> +	/*
> +	 * Drop uvc->state to CONNECTED if it was streaming before.
> +	 * This ensures that the usb_requests are no longer queued
> +	 * to the controller.
> +	 */
> +	if (uvc->state == UVC_STATE_STREAMING)
> +		uvc->state = UVC_STATE_CONNECTED;
> +
>  	uvcg_video_enable(&uvc->video, 0);
>  	uvcg_free_buffers(&uvc->video.queue);
>  	uvc->func_connected = false;
> @@ -647,4 +662,3 @@ const struct v4l2_file_operations uvc_v4l2_fops = {
>  	.get_unmapped_area = uvcg_v4l2_get_unmapped_area,
>  #endif
>  };
> -
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index 91af3b1ef0d4..c334802ac0a4 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -384,13 +384,14 @@ static void uvcg_video_pump(struct work_struct *work)
>  	struct uvc_video_queue *queue = &video->queue;
>  	/* video->max_payload_size is only set when using bulk transfer */
>  	bool is_bulk = video->max_payload_size;
> +	struct uvc_device *uvc = video->uvc;
>  	struct usb_request *req = NULL;
>  	struct uvc_buffer *buf;
>  	unsigned long flags;
>  	bool buf_done;
>  	int ret;
> 
> -	while (video->ep->enabled) {
> +	while (uvc->state == UVC_STATE_STREAMING && video->ep->enabled) {
>  		/*
>  		 * Retrieve the first available USB request, protected by the
>  		 * request lock.
> --
> 2.42.0.869.gea05f2083d-goog
