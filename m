Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAD97F3ECB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjKVHVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbjKVHVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:21:17 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E69DD58
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:21:14 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so6505462b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700637673; x=1701242473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=btzJxuP/9DloLjZH5Va9+pYoBGlTVhIo1JatCNov9xI=;
        b=OTXSxcB/hdCPN9wWpvhc1t9YyOZCEl8YYTNquxBsentcZgQTu8CODH6gO7ctNQfpYr
         8E5wjKhJvFsPPSUWpKXHMvNH+Bf3CXUUG5Uz3M8EHnaYqnnZa7FDiFPU888bIo9VR67n
         4GC7la2XlPg1inBa6FT+aS4OuyCaSx0+vFG1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700637673; x=1701242473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btzJxuP/9DloLjZH5Va9+pYoBGlTVhIo1JatCNov9xI=;
        b=Wd6QaRPtVrFxQomNqVOxHoqBhJ4ZJEgRm+1ABcVnEuPMZGGCT+gFLJHBDOlOaXjSks
         ca/Ea837m5uScxcI1crNEoJIZ3YixLxXkkjzKnaLlE2judAPtzY6Fcje5F0kiM0cN/Fb
         NyP4citOrunVFxwSkUvDFXyoW3cRFtw4Umo0Db/xrQKcLWXADxz0JEgtP2MaMga4NP5T
         92VAqIjjAawozLvNpo6o0cxMA0buDfxFua4pAl3c8yRBcGRsYqJhf1174AuM037rhm9T
         lQIMmSQs3MqK9bwQ0AWE17pYrp8Lu6Ox3nrYeMjkVMgGQ2Hr70Ms98hxt7J9Fv7RTN4t
         SyTw==
X-Gm-Message-State: AOJu0Yx/5tyMUHyAeHk+BLuoJ8KRL/o7p872SROAlsFdMpyQPAJW7EiH
        ALzbXlodYb0p9u9+7rK51Unv+ivNskjujFIUgA4=
X-Google-Smtp-Source: AGHT+IG/SnMh/5aBN5j16Wk503icTKW0NfJndoV03B0S/arEvoFTCyFqbThSvKq/emWxyGb5baAOFw==
X-Received: by 2002:a05:6a21:3288:b0:186:736f:7798 with SMTP id yt8-20020a056a21328800b00186736f7798mr1645887pzb.11.1700637673410;
        Tue, 21 Nov 2023 23:21:13 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:1aba:fb75:807e:7620])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902860400b001c74df14e6fsm9024022plo.284.2023.11.21.23.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 23:21:13 -0800 (PST)
Date:   Wed, 22 Nov 2023 16:21:08 +0900
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
Subject: Re: [PATCH v3 1/3] media: uvcvideo: Always use uvc_status_stop()
Message-ID: <20231122072108.GA1465745@google.com>
References: <20231121-guenter-mini-v3-0-d8a5eae2312b@chromium.org>
 <20231121-guenter-mini-v3-1-d8a5eae2312b@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121-guenter-mini-v3-1-d8a5eae2312b@chromium.org>
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
> uvc_status_stop() handles properly the race conditions with the
> asynchronous worker.
> Let's use uvc_status_stop() for all the code paths that require stopping
> it.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c   | 4 ----
>  drivers/media/usb/uvc/uvc_status.c | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index e59a463c2761..8e22a07e3e7b 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -2765,10 +2765,6 @@ void uvc_ctrl_cleanup_device(struct uvc_device *dev)
>  	struct uvc_entity *entity;
>  	unsigned int i;
>  
> -	/* Can be uninitialized if we are aborting on probe error. */
> -	if (dev->async_ctrl.work.func)
> -		cancel_work_sync(&dev->async_ctrl.work);
> -
>  	/* Free controls and control mappings for all entities. */
>  	list_for_each_entry(entity, &dev->entities, list) {
>  		for (i = 0; i < entity->ncontrols; ++i) {
> diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> index a78a88c710e2..0208612a9f12 100644
> --- a/drivers/media/usb/uvc/uvc_status.c
> +++ b/drivers/media/usb/uvc/uvc_status.c
> @@ -292,7 +292,7 @@ int uvc_status_init(struct uvc_device *dev)
>  
>  void uvc_status_unregister(struct uvc_device *dev)
>  {
> -	usb_kill_urb(dev->int_urb);
> +	uvc_status_stop(dev);

Sort of feels like this needs dev->lock somewhere here. Should we move 3/3
to the head of the series?

The question is, can this be called in parallel with uvc_v4l2_release(),
for instance?

>  	uvc_input_unregister(dev);
>  }
