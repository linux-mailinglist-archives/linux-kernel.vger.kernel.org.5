Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5259879F31D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjIMUsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjIMUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:48:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E454F1BCB;
        Wed, 13 Sep 2023 13:48:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so3617441fa.3;
        Wed, 13 Sep 2023 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694638095; x=1695242895; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdG3zI4QDFsCKJehQ8JPYh15/frkEQQoAmI3rZpMavc=;
        b=Jpq6ilIQ5iVh1dqU+apx+taje3Eq7+dRUMicjwjhBIwNsYkG1Ngql0fOwmTNIl1Q9/
         H66keylcIUqDomLJaBZnYrmKVjL194Nw+NyAj7e3AwxnRY8rsoEpc3G0oNGDnxNyNpSz
         tU0+mvNKegYXklcyze9d8ho5nepgqN9TQu7CT2BrP12LwSI71E+e1N6uV0nLSUbQyiFv
         cXR6xyMkszer3HQl/DJChD+rrlkvepNVWe+mWVEJtYSlU7nSToDfBB7nnJ+XFRZy9Afq
         do2NXLbT0wOXCGJnfz4SCRIxJ+Y8BW8O6XWr771qB0RJQuvhtMV4x36BuY8bjzPTxhUJ
         9DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694638095; x=1695242895;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdG3zI4QDFsCKJehQ8JPYh15/frkEQQoAmI3rZpMavc=;
        b=keN2Jbb11ug+C8uiGACL9iYV0QOSXjtbBEkI6eub9I4c7cO7yfU4zrFnhcckc0HUdH
         kwQtXkCSwdipzjFBXYtH3c+z5PwnqY+HHCBkmpS/73ri+57IlBouKFCmFK8RelHXqrBJ
         YzJYvjK8m5lgl0mCeQw75eJDnPP+HtUpgTfxwEFi6LwUHjzl98ZT++kARK5+p/k4po7t
         WZuKF0fI4SLpKorGdb22WYLe0FdsRod1x/8HeY4cY10diyk2mq9pE9m+i/aU6KlZoWiI
         ccoZ+G2Fxs7cLo0XWsjEDlQsXCJwzJ0oF3ifg276Jm+G7HRkmOm+CYDgYo/LXMOx3qzL
         8p6w==
X-Gm-Message-State: AOJu0YyITAlyhoKAaQus37RtpJs0Ia7LQXcWjoX4w7JU6kzFvCTficMV
        1OgE0JvOH999p7cjvY06ZPhrvJRMZON+vqpg
X-Google-Smtp-Source: AGHT+IGVzAfoRlyKuRelAv5HJbXsQ/MQOp+1GFo/OyzwiMAGZh8USbW/ojCnM5kEdcq+z4+6MACl0w==
X-Received: by 2002:a2e:781a:0:b0:2bd:1fee:aacf with SMTP id t26-20020a2e781a000000b002bd1feeaacfmr3098364ljc.24.1694638094834;
        Wed, 13 Sep 2023 13:48:14 -0700 (PDT)
Received: from localhost ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
        by smtp.gmail.com with ESMTPSA id b1-20020a2e8941000000b002b6db0ed72fsm2587536ljk.48.2023.09.13.13.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 13:48:14 -0700 (PDT)
Date:   Wed, 13 Sep 2023 23:48:13 +0300
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH] media: ov5640: use pm_runtime_force_suspend/resume for
 system suspend
Message-ID: <ZQIgDb0usm768umH@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        laurent.pinchart@ideasonboard.com
References: <20230818173416.2467832-1-andrej.skvortzov@gmail.com>
 <ZQHU+LA+BEB7jzx1@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZQHU+LA+BEB7jzx1@valkosipuli.retiisi.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 23-09-13 15:27, Sakari Ailus wrote:
> Hi Andrey,
> 
> On Fri, Aug 18, 2023 at 08:34:16PM +0300, Andrey Skvortsov wrote:
> > If system was suspended while camera sensor was used, data and
> > interrupts were still coming from sensor and that caused unstable
> > system. Sometimes system hanged during a resume. Use
> > pm_runtime_force_* helpers in order to support system suspend.
> > 
> > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> 
> Thanks for the patch.
> 
> It's not been documented really how system suspend and resume should
> work for complex cameras. But I don't think it can be done by drivers
> separately as the CSI-2 bus initialisation requires actions from both
> sender and receiver drivers, at particular points of time.

Thanks for the review.

I've tested this on PinePhone A64. It uses DVP, maybe because of that
system suspend/resume worked good in my case.
Originally I've implemented system suspend/resume similar to this [1]
or [2] as I've seen this approach in other mainlined drivers. But some
drivers reuse pm_runtime_force_* helpers, so I've went with this.

Do you think it would be better to use something like [2] until there
is better well defined way for system suspend/resume for complex cameras?

> 
> So I think we'll need to initiate this from the driver handling DMA, just
> as starting and stopping streaming. Even then, there needs to be a
> certainty that the sensor device has resumed before streaming is started. I
> recall Laurent suggested device links for that purpose, but I don't think
> any work has been done to implement it that way.

1. https://salsa.debian.org/Mobian-team/devices/kernels/sunxi64-linux/-/blob/mobian-6.1/debian/patches/camera/0076-media-gc2145-implement-system-suspend.patch
2. https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/imx219.c#L1159

-- 
Best regards,
Andrey Skvortsov
