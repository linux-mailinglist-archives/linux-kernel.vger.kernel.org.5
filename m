Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF277F3F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234563AbjKVHrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjKVHrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:47:51 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B4C112
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:47:47 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1ce5e76912aso41983145ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700639267; x=1701244067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSslZ87O8gm8ECVDRusqRDaovztLCrl5qgvaEZ6Clyk=;
        b=Ed7MWDsQfSXqjYq5NpP/K7pu9Y1cUr5rQnHFL78z7M7vWfV6mGv48UR20/9exZSpAc
         OxeyeNbWLiYl5StAUBDVyThQr67AwyDs71xHxtAaWa0SxQqIkDrLFvBh3M0UAw2+zgpT
         NkBbNA1+b3RB+NYEV71fmGdVwdbGnHqemZ0Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700639267; x=1701244067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSslZ87O8gm8ECVDRusqRDaovztLCrl5qgvaEZ6Clyk=;
        b=emcV2GgbdMiYdxdt82Q04Ekedcm4u4LEbCehNeeH+TEVL455vBkeRBGnFmE/zBZ1A6
         lNFzHECXyxf3J3Hoz7svNBfFMGYUg51bVXSKbW6gG1rMUVWVZqRlJ9W5Im3MYgNRj9R8
         loIE/Viv989f8WTyx8z0zXR7jUhZTvhN4rf4XpGvVtmjzZBgsbxsFIfEWmJnSbsOmkpS
         tdDLGMew9PjzwyNtoxaf7Jrs6JI5/X/XNaKle+O61yxRhvYfvFA2K1byfo0R2Pq6VvtL
         npReubsSMT1mfKxz75diFRMmxG+0eDgm5Zb0du9QP/kLzXBq3MFsVHGAFnJEPadgLWy9
         Krtw==
X-Gm-Message-State: AOJu0YxjWTqxv0RCRPMkBdBj9MRyAVeiFuMxMlitdGNAlVL4vt4RGZo5
        Bg/zF9bdRlQPtWZ435wcfn85Vw==
X-Google-Smtp-Source: AGHT+IECNClYO1LaWKWeX1noutwtFiNs4YaYyUIMp8wEuuTx1lDdfzGhFQs83fwaV5XDfo1fwtqQlQ==
X-Received: by 2002:a17:902:b687:b0:1cf:6d46:9f2f with SMTP id c7-20020a170902b68700b001cf6d469f2fmr1501436pls.48.1700639267184;
        Tue, 21 Nov 2023 23:47:47 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:1aba:fb75:807e:7620])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001ce160421aesm9182064plb.200.2023.11.21.23.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 23:47:46 -0800 (PST)
Date:   Wed, 22 Nov 2023 16:47:42 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v3 2/3] media: uvcvideo: Do not halt the device after
 disconnect
Message-ID: <20231122074742.GB1465745@google.com>
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-2-d8a5eae2312b@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-guenter-mini-v3-2-d8a5eae2312b@chromium.org>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/21 19:53), Ricardo Ribalda wrote:
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 08fcd2ffa727..413c32867617 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -2257,6 +2257,8 @@ static void uvc_disconnect(struct usb_interface *intf)
>  		return;
>  
>  	uvc_unregister_video(dev);
> +	/* Barrier needed to synchronize with uvc_video_stop_streaming(). */
> +	smp_store_release(&dev->disconnected, true);
>  	kref_put(&dev->ref, uvc_delete);
>  }

[..]

> +void uvc_video_stop_streaming(struct uvc_streaming *stream)
> +{
> +	uvc_video_stop_transfer(stream, 1);
> +
> +	/*
> +	 * Barrier needed to synchronize with uvc_disconnect().
> +	 * We cannot call usb_* functions on a disconnected USB device.
> +	 */
> +	if (!smp_load_acquire(&stream->dev->disconnected))
> +		uvc_video_halt(stream);
> +
>  	uvc_video_clock_cleanup(stream);
>  }

Can the following happen?

CPU0                                            CPU1
 uvc_disconnect()
						uvc_video_stop_streaming()
 usb_set_intfdata()
 uvc_unregister_video()

						if (!smp_load(&dev->disconnected))
							uvc_video_halt()

 smp_store_release(&dev->disconnected, true);

 kref_put(&dev->ref, uvc_delete);
