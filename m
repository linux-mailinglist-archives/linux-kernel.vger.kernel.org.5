Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A807D22A5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjJVKe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVKe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:34:57 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87865A7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:34:55 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1dd1714b9b6so1813218fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697970894; x=1698575694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BjUl3gjm9wun4bMsuXatFcM3GHed43NJOgGcnPw7fW4=;
        b=MayvTCUZY2V4wz7RQpM3XmGkGKsmk22WaMEoKkbyF119TSpFCU4xPX60gC0guabZi1
         JKObOUsRcouOCP4d7Syme7RtVSuEAaNnv1PYnQKOS68MHNOhNIhP7z8Z1QAfqX2gYi3Z
         QNb6Si8QcUB+NlUBV/pV/Mf2C3UE+XLIm6hfp9BSsz9pwyoe7vNuOxI9CAdn21GCg5bD
         VMBD9+AX0eOu4743Cf+4U+W0xZxZsFVhiwkUi0gx1ob8e4c3jNjbgsdxPJEdD1ASzvJk
         gH9KFpWRXk0P9LFe/LziAyzSzF0WEp/cGfjHfsng1Z6fEBB+Fnd6KGWVvOXvSr/sWKUS
         UoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697970894; x=1698575694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjUl3gjm9wun4bMsuXatFcM3GHed43NJOgGcnPw7fW4=;
        b=Bh29ytfyrs8nj2Cg4UP4TssCDbLcrLoGZTLyT9lOw2fgcD2Fmtt23jSyyTXU33Gd/5
         hfEeKdB1aGsQ5ix7SzJGkBQDGzrMYo2P3Mz/y0QQztNtK2I0n6X1vxKqkUXzMp4v90t2
         AhB0LViWwuOJU9iZHfnvNjhaj+2OAwnpfTiRJ4o3nBDJUn9735CWEb5gKMnFHNahVAO8
         FUY64pPwWEeTz6RVB41gSjTTqVFHY38GeqVAowlGsqjjB04p+/GHBnt3SfbFQTleUTxP
         +pfwLA3OuzSL0PrWEn8GMSNA5tauJouM1A3i9agYz5CmktWSFL8fHhhWQ+QXYF+/K7uP
         voUQ==
X-Gm-Message-State: AOJu0Yx08G5X73Pf8wiKSvjt1qyFqRIWiTGzrsLaotxwv3Ol/MYHOh28
        gHg4ALi5IXhTOXe9vIsa/mM=
X-Google-Smtp-Source: AGHT+IHk2qRN03r/BAretK6kllYjBM69zB6LIN+acRJbHX9/tzqKUC5325pIl9VT6kCwuwiztIPckw==
X-Received: by 2002:a05:6871:3308:b0:1e9:b6aa:a629 with SMTP id nf8-20020a056871330800b001e9b6aaa629mr8700094oac.6.1697970894377;
        Sun, 22 Oct 2023 03:34:54 -0700 (PDT)
Received: from ubuntu ([122.171.143.200])
        by smtp.gmail.com with ESMTPSA id t23-20020a1709028c9700b001b5656b0bf9sm4228265plo.286.2023.10.22.03.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 03:34:54 -0700 (PDT)
Date:   Sun, 22 Oct 2023 03:34:49 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH] staging: greybus: avoid macro argument precedence issues
Message-ID: <20231022103449.GA6475@ubuntu>
References: <20231021214840.GA6557@ubuntu>
 <2023102210-undead-pucker-a1f2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023102210-undead-pucker-a1f2@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 12:24:48PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Oct 21, 2023 at 02:48:40PM -0700, Nandha Kumar Singaram wrote:
> > Adhere to linux coding style, added parentheses around
> > macro argument 'gcam'.
> > CHECK: Macro argument 'gcam' may be better as '(gcam)' to
> > avoid precedence issues
> > 
> > Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
> > ---
> >  drivers/staging/greybus/camera.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> > index cdbb42cd413b..ae49e37a87e9 100644
> > --- a/drivers/staging/greybus/camera.c
> > +++ b/drivers/staging/greybus/camera.c
> > @@ -180,9 +180,9 @@ static const struct gb_camera_fmt_info *gb_camera_get_format_info(u16 gb_fmt)
> >  
> >  #define GB_CAMERA_MAX_SETTINGS_SIZE	8192
> >  
> > -#define gcam_dbg(gcam, format...)	dev_dbg(&gcam->bundle->dev, format)
> > -#define gcam_info(gcam, format...)	dev_info(&gcam->bundle->dev, format)
> > -#define gcam_err(gcam, format...)	dev_err(&gcam->bundle->dev, format)
> > +#define gcam_dbg(gcam, format...)	dev_dbg(&(gcam)->bundle->dev, format)
> > +#define gcam_info(gcam, format...)	dev_info(&(gcam)->bundle->dev, format)
> > +#define gcam_err(gcam, format...)	dev_err(&(gcam)->bundle->dev, format)
> 
> Sorry, but checkpatch is wrong here, this is not a problem at all.  Look
> at what you changed and think about if the macro argument could actually
> be anything other than a pointer.
> 
> thanks,
> 
> greg k-h

Thanks, I will check it out.

Regards,
Nandha Kumar
