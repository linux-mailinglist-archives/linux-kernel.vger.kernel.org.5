Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA07E55C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjKHLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHLsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:48:55 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56DF198A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:48:52 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-9e1020e2996so222872366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 03:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699444131; x=1700048931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ5G9d+jSp3nV9CSfk+uvGLQF4xfVO1jNHZEyb9GdSk=;
        b=1ym1xKRCzC3xH5mF2rCEzcm5MZl8/Tj2YO0UAMAybDS1zPDIMR6SiwCGS0ODVt7oAA
         ZxLZirBvOlEliFKBEIc8YGHzcQOmEPQsPAKtYFPHKdiUnGCFlUyQLsCT6pV3j2mWYYLa
         oxSMx8462KLsLYZxRnKK2sQVQx7cRLsvksf0F4Qr5c5OWYj3f6wlVIW1ru/d2zVOGE1N
         G15McUXmbkpOiqPKuIPBNuMBrwAPZyqzoou+1Dhsd8d15xBNe1D1esT2fl4PbpVJacXp
         OeDWin23w5A6RZEDGmed/iYMwop20Sny2O5amfClL/y8QD4XbXPK3FUgPdxKLPeXyg+n
         eAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699444131; x=1700048931;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZ5G9d+jSp3nV9CSfk+uvGLQF4xfVO1jNHZEyb9GdSk=;
        b=Y+3OXJ6XCbS4FyzCq0iNQZ2+BIh9ZEXO7h0+0DGRsZaZI5opsWcPMYVApj0rkfLpso
         QL22u1qPnEfX+Aq6Et8w5aGmcMIBty1wK8Hvg2Rjg1H5kX4eQngpONpN+WVvs777zWx9
         UkQNzGPRABzpwXgVzbO1W3s5F+tdd1/GAtD4c5O5F4Rfo5rJPppob/QsSzc1/7XrNdn4
         ZQTyHlTeCFwb/POx4xpU+TLWEeBsGJzeijL8XsMm3YTFGdXxQ1keqPiPuzSh2WhrBHrd
         7k4Cb9Orie1AGWcHaDx/GBrEnV8mrCNNhJpeHzoQ3Vot1JiIH+Y9UelIxZuG60KXCgmG
         ZnzA==
X-Gm-Message-State: AOJu0Yx4UDco06jc24MLeOAFT7V2/vqFACdlU3I0drw/tHX8LLY4DwD+
        AvkHzGmo5FT72ll+e4dIfzcYMfkdcNM=
X-Google-Smtp-Source: AGHT+IGVlTM8tCYiR2v19Vw/mF+XZ5YO/yPmsBGoDixWzqNeoiqcjIKD1mLxBh4SYcf9we26eWI8xYgrU2g=
X-Received: from khtsai-large-gcloudtop.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:289])
 (user=khtsai job=sendgmr) by 2002:a17:906:dfd3:b0:9c2:79f9:821a with SMTP id
 jt19-20020a170906dfd300b009c279f9821amr6380ejc.11.1699444131213; Wed, 08 Nov
 2023 03:48:51 -0800 (PST)
Date:   Wed,  8 Nov 2023 19:48:48 +0800
In-Reply-To: <80a05f4a-eaae-4db1-9604-c5eed9ff594c@ideasonboard.com>
Mime-Version: 1.0
References: <80a05f4a-eaae-4db1-9604-c5eed9ff594c@ideasonboard.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108114848.794045-1-khtsai@google.com>
Subject: Re: [PATCH] usb: gadget: uvc_video: unlock before submitting a
 request to ep
From:   Kuen-Han Tsai <khtsai@google.com>
To:     dan.scally@ideasonboard.com
Cc:     gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        michal.simek@amd.com, piyush.mehta@amd.com,
        radhey.shyam.pandey@amd.com, siva.durga.prasad.paladugu@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 07:11, Piyush Mehta wrote:
> There could be chances where the usb_ep_queue() could fail and trigger
> complete() handler with error status. In this case, if usb_ep_queue()
> is called with lock held and the triggered complete() handler is waiting
> for the same lock to be cleared could result in a deadlock situation and
> could result in system hang. To aviod this scenerio, call usb_ep_queue()
> with lock removed. This patch does the same.

I would like to provide more background information on this problem.

We met a deadlock issue on Android devices and the followings are stack traces.

[35845.978435][T18021] Core - Debugging Information for Hardlockup core(8) - locked CPUs mask (0x100)
[35845.978442][T18021] Call trace:
[*][T18021]  queued_spin_lock_slowpath+0x84/0x388
[35845.978451][T18021]  uvc_video_complete+0x180/0x24c
[35845.978458][T18021]  usb_gadget_giveback_request+0x38/0x14c
[35845.978464][T18021]  dwc3_gadget_giveback+0xe4/0x218
[35845.978469][T18021]  dwc3_gadget_ep_cleanup_cancelled_requests+0xc8/0x108
[35845.978474][T18021]  __dwc3_gadget_kick_transfer+0x34c/0x368
[35845.978479][T18021]  __dwc3_gadget_start_isoc+0x13c/0x3b8
[35845.978483][T18021]  dwc3_gadget_ep_queue+0x150/0x2f0
[35845.978488][T18021]  usb_ep_queue+0x58/0x16c
[35845.978493][T18021]  uvcg_video_pump+0x22c/0x518

As mentioned by Piyush, the uvcg_video_pump function acquires a spinlock before submitting the USB
request to the endpoint, which will be processed by the dwc3 controller in our case.

However, a deadlock can occur when the dwc3 controller fails to kick the transfer and decides to
cancel and clean up all requests. At this point, the dwc3 driver calls the giveback function asking
the corresponding driver to handle the cancellation. The uvcg_queue_cancel function then acquires
the same spinlock to cancel the request, which results in a double acquirement and a deadlock.

>
> Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
> ---
>   drivers/usb/gadget/function/uvc_video.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
> index 91af3b1ef0d4..0a5d9ac145e7 100644
> --- a/drivers/usb/gadget/function/uvc_video.c
> +++ b/drivers/usb/gadget/function/uvc_video.c
> @@ -460,11 +460,12 @@ static void uvcg_video_pump(struct work_struct *work)
>   			req->no_interrupt = 1;
>   		}
>
> -		/* Queue the USB request */
> -		ret = uvcg_video_ep_queue(video, req);
>   		spin_unlock_irqrestore(&queue->irqlock, flags);
>
> +		/* Queue the USB request */
> +		ret = uvcg_video_ep_queue(video, req);
>   		if (ret < 0) {
> +			usb_ep_set_halt(video->ep);
>   			uvcg_queue_cancel(queue, 0);
>   			break;
>   		}
