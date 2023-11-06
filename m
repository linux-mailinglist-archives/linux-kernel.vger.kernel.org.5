Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396BF7E1F56
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjKFLGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFLGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:06:08 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53E698;
        Mon,  6 Nov 2023 03:06:04 -0800 (PST)
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SP7nR0WS3z49PxL;
        Mon,  6 Nov 2023 13:05:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1699268763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uISDGrcsU+uJBZBe4/Ydlk3kQbGjuYfOXOgBVO94llU=;
        b=stql468lyE6BCbvh2iQrb2BLsARddF5V2Asx1LqG2QHPdADr39F79uXBLG6bmCDDBhh3B8
        pJvklxHCCxPy+TtQC3y8wIXz95NZbG0mIiwyYipd9g80o+GGZwsu1OcbuVhqz5C6/uvJIm
        ocNDOnfvS3DY1YaeUlzcgQFs1/UGwxD+f8JJmxxR+bNhS/YhJ4VNYiWCBwiOxc56kAbGjI
        aJlRn9MEeDfNfcGssvCQTklqIHnm8OvA6fixR5Wj/bMFRNWNTqNOtrrOwavWJ0a0GSuFVT
        AzOpnFHF0cB6SsFNR4cA3KN3chEn6xP18K1QASR5p9Ah9kx+xzJn99a2YFnymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1699268763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uISDGrcsU+uJBZBe4/Ydlk3kQbGjuYfOXOgBVO94llU=;
        b=RpRHf7qveNTOwK6euwMeTMRK/30nJ/DPWxsPKy/JbbFUgVlzrkWhv8tqI/IeUnxx9LgzNh
        It6dl0AH/Lt4mMJJ4s0s6x/cIeExtQVL3QgVE6jK7q9lSsjk29KG3OJ7AR5s1PrfTq4jsg
        dvJg1cS9npXpPiwUh3otBFJSXrfAQOf7qDIXCmQe9AFXIIWTOi1JKM5lRUABEj0WqlTvvh
        wUErdADJLKgGkFG3XYqtM/uf0ROLRmrzuOFerkpejLX3Erq9kg+Hf1iCi6ZPzTigc8SuLm
        n2Jv6eQaz/46oNeIyNwB+yXo8vwqbszyNQLbDmNmMGeOSjBY6O0e6uZPHuIlrg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699268763; a=rsa-sha256;
        cv=none;
        b=mE2TEKGC2U5R9siruvJhNsRT+Tk/vUHcWxsBcvA7Y9dlI7ZFOdNqKle2XekdtBHLzOWcf5
        LohxPeJ3x3d+ZSccJNvtD6zfN/IRy7Lem+2rtKcwKyzmS8ClPPV6W8rZsD+fCANlJLOiw5
        RYjsubPOBSCobA1QNT7j3TrNFxktmYcv0ZIEziOI3dvjDdD7BHYfUmyHHu50Qj6EYjCbbk
        n4Gag6PyJYchJFoH7A4lEoFMkTXbOfDjXYzjJPdIOyZV4LeM9eM/j96eAYOQvZDcEyXdu3
        gw/lKGpzQcRHXJhhks7PbUF8NVwby/B3aWwa7/qkAuPxrj06Yq7YPIe4tEkkhg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id BDCF0634C93;
        Mon,  6 Nov 2023 13:05:58 +0200 (EET)
Date:   Mon, 6 Nov 2023 11:05:58 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esker Wong <esker@chromium.org>
Subject: Re: [PATCH v2] media: uvcvideo: Implement V4L2_EVENT_FRAME_SYNC
Message-ID: <ZUjIlq0cxSv9Cut0@valkosipuli.retiisi.eu>
References: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106-uvc-event-v2-1-7d8e36f0df16@chromium.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Mon, Nov 06, 2023 at 10:52:27AM +0000, Ricardo Ribalda wrote:
> Add support for the frame_sync event, so user-space can become aware
> earlier of new frames.
> 
> Suggested-by: Esker Wong <esker@chromium.org>
> Tested-by: Esker Wong <esker@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> We have measured a latency of around 30msecs between frame sync
> and dqbuf.
> ---
> Changes in v2:
> - Suggested by Laurent. Split sequence++ and event init.
> - Link to v1: https://lore.kernel.org/r/20231020-uvc-event-v1-1-3baa0e9f6952@chromium.org
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c  | 2 ++
>  drivers/media/usb/uvc/uvc_video.c | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index f4988f03640a..9f3fb5fd2375 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -1352,6 +1352,8 @@ static int uvc_ioctl_subscribe_event(struct v4l2_fh *fh,
>  	switch (sub->type) {
>  	case V4L2_EVENT_CTRL:
>  		return v4l2_event_subscribe(fh, sub, 0, &uvc_ctrl_sub_ev_ops);
> +	case V4L2_EVENT_FRAME_SYNC:
> +		return v4l2_event_subscribe(fh, sub, 0, NULL);
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 28dde08ec6c5..4f3a510ca4fe 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1073,9 +1073,16 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
>  	 * that discontinuous sequence numbers always indicate lost frames.
>  	 */
>  	if (stream->last_fid != fid) {
> +		struct v4l2_event event = {
> +			.type = V4L2_EVENT_FRAME_SYNC,
> +		};
> +
>  		stream->sequence++;
>  		if (stream->sequence)
>  			uvc_video_stats_update(stream);
> +
> +		event.u.frame_sync.frame_sequence = stream->sequence,
> +		v4l2_event_queue(&stream->vdev, &event);

uvc_video_decode_start() is called when the reception of the entire frame
has been completed. However, the documentation for V4L2_EVENT_FRAME_SYNC
says that the event is "Triggered immediately when the reception of a frame
has begun.". The functionality here doesn't seem to fit to this patch.

Wouldn't V4L2_EVENT_VSYNC be a better fit, even if we don't really have a
concept of vertical sync in the case of USB? That event doesn't have the
sequence though but I guess it's not an issue at least if your case.

Another technically correct option could be to create a new event for this
but I'm not sure it's worth it.

>  	}
>  
>  	uvc_video_clock_decode(stream, buf, data, len);
> 

-- 
Regards,

Sakari Ailus
