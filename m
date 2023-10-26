Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5BA7D89A9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 22:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjJZUXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjJZUXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 16:23:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65E318A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:23:47 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc0d0a0355so8225935ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 13:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698351827; x=1698956627; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gvkiqHTsXEVyc9c8Zm+MRgwHjcY6wcBgvCGB0YLRdQ=;
        b=HjnO2wZnhKGZi2qNmE+cb1SpilvLJJHHjO/Tm71gWnaKbChnChkSBKXK8ncgG5jWcg
         VD3E9lvuk/i8Tw06AXqeOtcMdZiC2KDEUu5OAr1PKNH+9rQrvI4eSNnMq2+Na+ZclD8J
         P6I6DkpQzKbRbinTjALe338ZhtoAU0XPujU2koHksHBrgtqsiW/sa76P0XvhzQn+v4yo
         MgMVaVdfC2RUeA+n9hmUvoJQdrlLTlwpTEkad1Reo5l1htkegSjTD1NVt5PDt9W0gef1
         P7ALx80jpP7d4PReUaya3doA6/NzAii/GO4UTRUbeN9eUqa956sQ1cxj0RcBkVSgGlgu
         MoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698351827; x=1698956627;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gvkiqHTsXEVyc9c8Zm+MRgwHjcY6wcBgvCGB0YLRdQ=;
        b=rK0jdncWPjy+3uSCH4GUBaxYn8hIW2Xx9/C0yndZKXdwwdzqrwgkp6cQd72uLZ6W4B
         xYbnTgSLU4dtGLyvz+cGCmgAEXiK23/FLVriCcx6EdrKftCBoZETwW/+v1WUj+cdB0fq
         9ZWgvKtxjFFnBT/nrL92fqcgpHrO/nwh60cw7mb/A4bQzP3xKYfK7oRZyzR+TzNpgcPk
         PMrI+YQBjd3P0N/MGztGvr/NzUqIvQdx81puCfRW6hjn3q85vW8UNRj8Ze0ywrAERqZI
         LQ7SEHj97yDff78m7SCHprgfroJEjDySajscnrxa450+8H5+MLzlbcDfBE9rQYtj9r9B
         4OSw==
X-Gm-Message-State: AOJu0Yxtf0tBpqB1/zaQo2TSXc6K1YaTLnq+P8q0FSN2aNTbQ5+mPrRA
        lBcVDKF87/m8zbqujXyDE7hU6A==
X-Google-Smtp-Source: AGHT+IE0BRAdbuh92VX3DscJ3TSa9K21TW9l8Ff8wrKk72GSKDOzsVGLpw58ksWgc5QFWk4IaHUzKg==
X-Received: by 2002:a17:903:120e:b0:1c8:92ee:108a with SMTP id l14-20020a170903120e00b001c892ee108amr812875plh.23.1698351826926;
        Thu, 26 Oct 2023 13:23:46 -0700 (PDT)
Received: from [192.168.60.239] (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001bdeb6bdfbasm82604plh.241.2023.10.26.13.23.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 13:23:46 -0700 (PDT)
Message-ID: <eeea887c-8fd5-45df-aed8-1046d8451a2e@google.com>
Date:   Thu, 26 Oct 2023 13:23:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/4] usb: gadget: uvc: prevent use of disabled endpoint
Content-Language: en-US
To:     gregkh@linuxfoundation.org
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        m.grzeschik@pengutronix.de, dan.scally@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
References: <20231019185319.2714000-1-arakesh@google.com>
 <20231024183605.908253-1-arakesh@google.com>
From:   Avichal Rakesh <arakesh@google.com>
In-Reply-To: <20231024183605.908253-1-arakesh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/23 11:36, Avichal Rakesh wrote:
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
> Reviewed-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Avichal Rakesh <arakesh@google.com>
> ---
> v1 -> v2: Rebased to ToT and reworded commit message.
> v2 -> v3: Fix email threading goof-up
> v3 -> v4: Address review comments & re-rebase to ToT
> v4 -> v5: Add Reviewed-by & Tested-by
> v5 -> v6: No change
> v6 -> v7: No change
> v7 -> v8: No change. Getting back in review queue
> 
>  drivers/usb/gadget/function/f_uvc.c     | 11 +++++------
>  drivers/usb/gadget/function/f_uvc.h     |  2 +-
>  drivers/usb/gadget/function/uvc.h       |  2 +-
>  drivers/usb/gadget/function/uvc_v4l2.c  | 20 +++++++++++++++++---
>  drivers/usb/gadget/function/uvc_video.c |  3 ++-
>  5 files changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index faa398109431..ae08341961eb 100644
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
> index 1db972d4beeb..e7f9f13f14dc 100644
> --- a/drivers/usb/gadget/function/f_uvc.h
> +++ b/drivers/usb/gadget/function/f_uvc.h
> @@ -11,7 +11,7 @@
> 
>  struct uvc_device;
> 
> -void uvc_function_setup_continue(struct uvc_device *uvc);
> +void uvc_function_setup_continue(struct uvc_device *uvc, int disale_ep);
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
> 2.42.0.758.gaed0368e0e-goog

Hey Greg,

Considering Laurent and Dan haven't responded, and Michael and I have 
tested this change, would it be possible to merge this patch set
if the changes look OK to you? I don't think there are any outstanding
items to be done around these fixes.

Thank you!
- Avi.
