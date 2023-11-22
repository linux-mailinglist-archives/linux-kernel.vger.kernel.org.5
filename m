Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306A47F4003
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjKVIXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjKVIXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:23:07 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B354F9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:23:03 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5845213c583so3505802eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700641382; x=1701246182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b1tLro5qVWpp7kyrB0acm9exDu7RQojZgmOKkDhEynw=;
        b=m5i+UpSrxa9CwjPpDyMIRs//Fc3+trBYFfVkj3BNE8HAlfNmm5wDTaPmqU4MVmdR6+
         Z4s7gIPgSknW7uytsGQ4ztSac/YoQ6XFVDyggC/w73N/LNkD2AnVVYzpdRdygZEpZBC1
         yor5YiDBdKgt/OY2hLBB6FOcSXHhUe7k9x3kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700641382; x=1701246182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1tLro5qVWpp7kyrB0acm9exDu7RQojZgmOKkDhEynw=;
        b=HjlBkdrPM7T8yoM2TfSnnfZIDXlpO92N7sj3zm1ZW6VtkgPFQ19PCydi4uh33zQOkx
         ufwmYSvRgFtk+Go7JuBm9SxM7q/I4Q0y53EOqujOJ4BZRL47RU7HOQgwLSu7kGv4K6GF
         Ev1UBTqlVju9iyrOd7dm02vajMfOYj0Ld3rBH9RrZ7kR749cTelJ/xDU1cMLx5l6IxAx
         lf2Xne9KXtAKkcCLOZjl75L1pccJEkU/M5EcGbkDsKVxo6as15M9B6MzalwgoeW/FnAy
         zonwdXZ6wlWCEOKJl6riQWTqNjNMHoFTlMJoi8MsroROE9EBhXhhiu7U9ptUTeSnlPlu
         g2yw==
X-Gm-Message-State: AOJu0YzlcYDdqGX9mU0NZzaHd32hnGI57CsXWwTpKJtbBrjucgeYcoz7
        0dmZ0dZah6vtKK7AfwLI6hv+pg==
X-Google-Smtp-Source: AGHT+IHthHR4uSwyBMbf5L0LPuBScubFWeTz3LWQhscIQ7SlJqGt1wJujwql08okmUIRt1e/T+Tjnw==
X-Received: by 2002:a05:6358:5e0f:b0:16d:aead:f750 with SMTP id q15-20020a0563585e0f00b0016daeadf750mr1978924rwn.7.1700641382487;
        Wed, 22 Nov 2023 00:23:02 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:1aba:fb75:807e:7620])
        by smtp.gmail.com with ESMTPSA id j26-20020a63551a000000b005b529d633b7sm8989061pgb.14.2023.11.22.00.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 00:23:02 -0800 (PST)
Date:   Wed, 22 Nov 2023 17:22:57 +0900
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
Subject: Re: [PATCH v3 3/3] media: uvcvideo: Lock video streams and queues
 while unregistering
Message-ID: <20231122082257.GB1526356@google.com>
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-3-d8a5eae2312b@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-guenter-mini-v3-3-d8a5eae2312b@chromium.org>
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
> The call to uvc_disconnect() is not protected by any mutex.
> This means it can and will be called while other accesses to the video
> device are in progress. This can cause all kinds of race conditions,
> including crashes such as the following.
> 
[..]
> 
> Call Trace:
>  usb_hcd_alloc_bandwidth+0x1ee/0x30f
>  usb_set_interface+0x1a3/0x2b7
>  uvc_video_start_transfer+0x29b/0x4b8 [uvcvideo]
>  uvc_video_start_streaming+0x91/0xdd [uvcvideo]
>  uvc_start_streaming+0x28/0x5d [uvcvideo]
>  vb2_start_streaming+0x61/0x143 [videobuf2_common]
>  vb2_core_streamon+0xf7/0x10f [videobuf2_common]
>  uvc_queue_streamon+0x2e/0x41 [uvcvideo]
>  uvc_ioctl_streamon+0x42/0x5c [uvcvideo]
>  __video_do_ioctl+0x33d/0x42a
>  video_usercopy+0x34e/0x5ff
>  ? video_ioctl2+0x16/0x16
>  v4l2_ioctl+0x46/0x53
>  do_vfs_ioctl+0x50a/0x76f
>  ksys_ioctl+0x58/0x83
>  __x64_sys_ioctl+0x1a/0x1e
>  do_syscall_64+0x54/0xde
> 
> usb_set_interface() should not be called after the USB device has been
> unregistered. However, in the above case the disconnect happened after
> v4l2_ioctl() was called, but before the call to usb_ifnum_to_if().
> 
> Acquire various mutexes in uvc_unregister_video() to fix the majority
> (maybe all) of the observed race conditions.
> 
> The uvc_device lock prevents races against suspend and resume calls
> and the poll function.
> 
> The uvc_streaming lock prevents races against stream related functions;
> for the most part, those are ioctls. This lock also requires other
> functions using this lock to check if a video device is still registered
> after acquiring it. For example, it was observed that the video device
> was already unregistered by the time the stream lock was acquired in
> uvc_ioctl_streamon().
> 
> The uvc_queue lock prevents races against queue functions, Most of
> those are already protected by the uvc_streaming lock, but some
> are called directly. This is done as added protection; an actual race
> was not (yet) observed.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Reviewed-by: Tomasz Figa <tfiga@chromium.org>
> Reviewed-by: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
