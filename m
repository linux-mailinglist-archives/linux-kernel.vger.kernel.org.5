Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3017F89CC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 10:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjKYJ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 04:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjKYJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 04:56:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C6B10D8;
        Sat, 25 Nov 2023 01:56:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-32deb2809daso1723868f8f.3;
        Sat, 25 Nov 2023 01:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700906188; x=1701510988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ8S4GA8sQkyoXQhisIQDzUpRENnlBDkm/bXMs/5Ous=;
        b=GvYyssJuxVYCgblC+6Loghzan5kk2TtjZ6KLgeZhGS+pPT/qBR6l4l7B5SgUX9MAx8
         8RSBdn4ND6+i9Kd0h9y4n5Y+EBL2U0PLmV51PW+ieIDRII90wKT82SiW6sFLIPu4f4DY
         tcZluTLyNDGo90L845Kiet27CjAhHLVnaqWmya+BcD8WA3wZCBGfCUKD8v4/alNO2wqW
         0X2dRLQz2e0dSUhI2vpxYoy2OpJ13dWOlyvWyoWnascvXzU5h6PB2WUf8I5kl9q94Wdz
         4/37Vhdk4q90NuFDFyL7z2kerzUAMsJgHllKmpoo93k/WDrv2HBDFgFp4rwnI5th1eFX
         HV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700906188; x=1701510988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZ8S4GA8sQkyoXQhisIQDzUpRENnlBDkm/bXMs/5Ous=;
        b=Rcg7mVcv7bFEeiArl+TT4fAlLSkL12M6XcmnrNi14b6G1C9ptbrVxiOSqx7w8sxzqn
         c6wtui9qNSplNZzdvZSauhjNUu22mm4PLCa49T1bW3U4l9R93J7u6qY0OC1xMs1FVu4X
         YrsG3llNuASgDccv/hqFl3vENmeoJUEVpNK/linLUVLYQURyNL+rs9a7caVdYBoyAPoU
         /ZY14mADfMgJY5N7bkOWDZhR8HvK9jizOsnykiztRjm1wssF6CNr9v8taoZbBq3vfkrY
         DCtSgyDWc8MuPwOcgkaSDyqID+HC+GYcsTYMYJFqCpRj5oZoS4h1hq76W8ZtsT4RpMdO
         ccEQ==
X-Gm-Message-State: AOJu0YwVpBUhRnhrzeg1usD1xkeQMAk91oJC4gjggB4UBIkB8CT7ccLj
        y1suvOBGgRIIOGhCshGHKpE=
X-Google-Smtp-Source: AGHT+IFR76D/Z3NnhOZcXwwWy53fQMzD2iIudvyif4u1evQbeuZ6YlwCg4M2HJ6jn16olrapoOYp8A==
X-Received: by 2002:a5d:58d3:0:b0:32d:89b5:7fd9 with SMTP id o19-20020a5d58d3000000b0032d89b57fd9mr4160331wrf.56.1700906188192;
        Sat, 25 Nov 2023 01:56:28 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-2-39-142-131.cust.vodafonedsl.it. [2.39.142.131])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d49c5000000b00327b5ca093dsm6229834wrs.117.2023.11.25.01.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 01:56:27 -0800 (PST)
Date:   Sat, 25 Nov 2023 10:56:25 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linuxfancy@googlegroups.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov5640: add missing v4l2_subdev_init_finalize
Message-ID: <ZWHEyTSnbuhH1Xdu@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231124184913.2574925-1-tomm.merciai@gmail.com>
 <ZWDzL+prP90gV6m2@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231124190636.GA15686@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124190636.GA15686@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Fri, Nov 24, 2023 at 09:06:36PM +0200, Laurent Pinchart wrote:
> On Fri, Nov 24, 2023 at 08:02:07PM +0100, Tommaso Merciai wrote:
> > On Fri, Nov 24, 2023 at 07:49:13PM +0100, Tommaso Merciai wrote:
> > > After the ov5640 configurations steps let's add v4l2_subdev_init_finalize
> > > that finalizes the initialization of the subdevice.
> > > 
> > > References:
> > >  - https://linuxtv.org/downloads/v4l-dvb-apis/driver-api/v4l2-subdev.html
> > > 
> > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > ---
> > >  drivers/media/i2c/ov5640.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> > > index 3f79a3b77044..338eea802ab8 100644
> > > --- a/drivers/media/i2c/ov5640.c
> > > +++ b/drivers/media/i2c/ov5640.c
> > > @@ -3924,6 +3924,12 @@ static int ov5640_probe(struct i2c_client *client)
> > >  	if (ret)
> > >  		goto entity_cleanup;
> > >  
> > > +	ret = v4l2_subdev_init_finalize(&sensor->sd);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "subdev init error: %d\n", ret);
> > > +		goto entity_cleanup;
> > > +	}
> > > +
> > >  	ret = ov5640_sensor_resume(dev);
> > >  	if (ret) {
> > >  		dev_err(dev, "failed to power on\n");
> > 
> > Ignore this patch please. I forget the cleanup part.
> 
> And you also forgot the conversion to the V4L2 subdev active state API
> :-) See commit e8a5b1df000e ("media: i2c: imx219: Use subdev active
> state") for an example.

Yup, thanks mb :'(
Thanks for sharing this :)

> 
> -- 
> Regards,
> 
> Laurent Pinchart
