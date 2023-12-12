Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DF280EABA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjLLLoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjLLLop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:44:45 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E9AAF;
        Tue, 12 Dec 2023 03:44:51 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3362216835eso1505520f8f.3;
        Tue, 12 Dec 2023 03:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702381489; x=1702986289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLp+6kB70DCE3KUm4Gy/AsdidSLhD4UHtyeSm7Ac4Gc=;
        b=kMLKFIreRhzmDCI5fUMsmMZU1M/MvJMi12wsXdQbq6l54Gd57Tln8ylp5dSBvQIkse
         otVU7KPpKMfp20bCrmxOx/72ZjV3254SIFLM4t+PEAtN5P6zkz6W1TLc4OEWkYLHU1JL
         CQRHItXfeHNWAD+BLNIJ1axDSspdznUJNiW9pIYgCw+a3vfJRVtIR/Qc4JGRyvlyMR2b
         Tu9ICQJ1QCjDDis1y+1Dfb+jbzbNt20w8A8dKvdAMJTFkYrC346SSBLdEXCzL8Hu6Z2d
         4EXFtxtyJv28KV74gPzjZNNI5WvSKE0uLzHp2OaxcqviX0UbE2wul6W1BTU35su0swWm
         0pDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381489; x=1702986289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLp+6kB70DCE3KUm4Gy/AsdidSLhD4UHtyeSm7Ac4Gc=;
        b=Rxl4D5MW+5HcNxNd7/601bSeasyJATIQnhu+NBgnHr33nJ8Gf3KtYy3VMyCeNV14SH
         QD9iIEHrP7qsb/E30KWWtyGzh41EkD8/9Rdgg0045BGeZUI+89JQaU3CQGtQbY57cB8j
         N0Ng/4oTHYMQg18xxxIE32Sr7pc/nvmUEHun+Xgkb65XZk9T5DHEIFn0BcBcRuc6Qfa7
         67vryxxfhqUBYHgrebixPclJfrKkEGrvCYn8dzv8xo0Fvq0SXyBzea9BfqkkK+yBGOkn
         tQ/2e3pzK8vubARjxnASc/s179ce+Pp1DqEJAMZMbWXrMUrWGQLEpEQVM+LPmn3mYkF0
         9Hww==
X-Gm-Message-State: AOJu0Yy/FIg9va/rpO6KC4U1AWl0IzAf70g7VaWat8G4gmE3IgqSl40e
        JClYUpJ6Xyyo1eJfUx4+g/M=
X-Google-Smtp-Source: AGHT+IFzWn1t7MI3JYcwjKGiJXwvh6Xap7ttOSMKfr2iNIKlOOcRf5lQ6YS/fTivmMljPro9o5VPzw==
X-Received: by 2002:a05:600c:4da1:b0:40c:32cf:62fb with SMTP id v33-20020a05600c4da100b0040c32cf62fbmr3072921wmp.163.1702381489306;
        Tue, 12 Dec 2023 03:44:49 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-229.cust.vodafonedsl.it. [188.217.59.229])
        by smtp.gmail.com with ESMTPSA id bh15-20020a05600c3d0f00b0040b4ccdcffbsm16601087wmb.2.2023.12.12.03.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:44:48 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:44:46 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     laurent.pinchart@ideasonboard.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, linuxfancy@googlegroups.com,
        mhecht73@gmail.com, christophe.jaillet@wanadoo.fr,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v15 3/3] media: i2c: Add support for alvium camera
Message-ID: <ZXhHrhNQfn0uJMjk@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231204094719.190334-1-tomm.merciai@gmail.com>
 <20231204094719.190334-4-tomm.merciai@gmail.com>
 <ZXhGQuqTZogWTJ42@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXhGQuqTZogWTJ42@kekkonen.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Tue, Dec 12, 2023 at 11:38:42AM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Mon, Dec 04, 2023 at 10:47:16AM +0100, Tommaso Merciai wrote:
> > The Alvium camera is shipped with sensor + isp in the same housing.
> > The camera can be equipped with one out of various sensor and abstract
> > the user from this. Camera is connected via MIPI CSI-2.
> > 
> > Most of the camera module features are supported, with the main exception
> > being fw update.
> > 
> > The driver provides all mandatory, optional and recommended V4L2 controls
> > for maximum compatibility with libcamera
> > 
> > References:
> >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> 
> Could you run
> 
> 	./scripts/checkpatch.pl --strict --max-line-length=80
> 
> and address the issues in a patch on top of this set?
> 

Yes ofc.
You need also the following?

--- a/drivers/media/i2c/alvium-csi2.c
+++ b/drivers/media/i2c/alvium-csi2.c
@@ -2426,8 +2426,8 @@ static int alvium_probe(struct i2c_client *client)
                goto err_powerdown;

        if (!alvium_is_alive(alvium)) {
-               dev_err_probe(dev, ret, "Device detection failed\n");
                ret = -ENODEV;
+               dev_err_probe(dev, ret, "Device detection failed\n");
                goto err_powerdown;
        }

Let me know. Thanks for your work.


Regards,
Tommaso

> Thanks.
> 
> -- 
> Sakari Ailus
