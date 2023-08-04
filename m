Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25C3770BD5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 00:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjHDWR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 18:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjHDWR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 18:17:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1776170D;
        Fri,  4 Aug 2023 15:17:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b8ad8383faso22690265ad.0;
        Fri, 04 Aug 2023 15:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691187438; x=1691792238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PE4QZNuuu7C0bSqFySHaBYQN1XQz2ilfd/lPvByw4oA=;
        b=fljTr62Qp0eBVEhKJWUVlRWTmGhmLxy7KMtkV9HjZr5dZEC+fJfM/W1p3i9yBPc3s7
         U1qrW5yVOzDFoXqHfUpJqu8l946Y0lBC7ElENxJxwmV6NbKVLgBNlUyWK4sasocfBD/1
         THT7NHsGy4Wx/64r0cG+V212cJ38fUYJW/+3YmOHV7kqE1CQEDmrf/AYwnkmyEhxg9U3
         VaQfrmpiEtkFI1PNZHNjPH+yJ+a/wWcjmdOEdLWsXP3boNAUYZBez8bUutfcY08ZkoH7
         mtLq6FPSAz9a5Fmqc4TOfm1hyLrROVQyZT5DT4YiCeaMJXkH6F+DiL/OFMQYjs8aKImN
         +OSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691187438; x=1691792238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE4QZNuuu7C0bSqFySHaBYQN1XQz2ilfd/lPvByw4oA=;
        b=XVtZ6PXUjBoCN48E0jfxVNDJE8lN/PAZaoFTVIlFMHspnvI9Si1Xgi8bdoIHIhPdp7
         txgxIUdiJVrHnDYw2bdc789+bzqZdng1uHOY2aK4zTAXMjJT6OY/+YZmTIfIHGzz2u+9
         VUMt6IAEVyysAga5u8n09r2e6uowX4JIyeIaXyGZ/Kov0mm3HFf8dvXCGeimHUlDFHPL
         jP21TuxDghiPVPapo7Lwx360vAFAgkbyVZienaibYWWhHhkYms7XLxNS1LKXcmhaouC0
         uMeAtAn8i/GgmpNxVY6nWHTaIIL1HNJ3gP+ifUECO0ZiFouRPzjfmaDemw4dOmfsx25L
         I4tw==
X-Gm-Message-State: AOJu0Yyi/kCX+Tsgf5F0hWO6vvw9zE6/+HROTnTL429LtavdAe7RmtdY
        K5b/kpVmYmmFSBciIfn7uXs=
X-Google-Smtp-Source: AGHT+IFTmHMFb8yGeTx3OG7yCNaLjfL6n2xu/FMB5EEKux3lC6JIUIE2IitVf3qABXJHQkcIBB2y9w==
X-Received: by 2002:a17:903:18c:b0:1bc:532f:1bf8 with SMTP id z12-20020a170903018c00b001bc532f1bf8mr2242421plg.45.1691187437944;
        Fri, 04 Aug 2023 15:17:17 -0700 (PDT)
Received: from taoren-fedora-PC23YAB4 ([76.132.59.39])
        by smtp.gmail.com with ESMTPSA id ja4-20020a170902efc400b001b8013ed362sm2233229plb.96.2023.08.04.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 15:17:17 -0700 (PDT)
Date:   Fri, 4 Aug 2023 15:17:15 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, taoren@meta.com
Subject: Re: [PATCH] hwmon: (pmbus/bel-pfe) Enable PMBUS_SKIP_STATUS_CHECK
 for pfe1100
Message-ID: <ZM1460GZM8bkOxTe@taoren-fedora-PC23YAB4>
References: <20230803235536.798166-1-rentao.bupt@gmail.com>
 <eaff724f-fceb-c50e-3ff5-58f61b396d02@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaff724f-fceb-c50e-3ff5-58f61b396d02@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thank you for the quick review, and I've addressed your comments in v2.


Cheers,
Tao

On Fri, Aug 04, 2023 at 08:19:40AM -0700, Guenter Roeck wrote:
> On 8/3/23 16:55, rentao.bupt@gmail.com wrote:
> > From: Tao Ren <rentao.bupt@gmail.com>
> > 
> > Enable PMBUS_SKIP_STATUS_CHECK flag for both pfe1100 and pfe3000 because
> > the similar communication error is observed on pfe1100 devices.
> > 
> > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > ---
> >   drivers/hwmon/pmbus/bel-pfe.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/hwmon/pmbus/bel-pfe.c b/drivers/hwmon/pmbus/bel-pfe.c
> > index fa5070ae26bc..8280d274da3f 100644
> > --- a/drivers/hwmon/pmbus/bel-pfe.c
> > +++ b/drivers/hwmon/pmbus/bel-pfe.c
> > @@ -17,12 +17,12 @@
> >   enum chips {pfe1100, pfe3000};
> >   /*
> > - * Disable status check for pfe3000 devices, because some devices report
> > + * Disable status check for pfexxxx devices, because some devices report
> >    * communication error (invalid command) for VOUT_MODE command (0x20)
> >    * although correct VOUT_MODE (0x16) is returned: it leads to incorrect
> >    * exponent in linear mode.
> >    */
> 
> Rephrase to something like
> 
>  Disable status check because some devices ... linear mode.
>  This affects both pfe3000 and pfe1100.
> 
> We don't know if other pfe devices will be supported by the driver in the
> future, and we don't know if those will be affected, so we should not make
> any claims about such devices.
> 
> > -static struct pmbus_platform_data pfe3000_plat_data = {
> > +static struct pmbus_platform_data pfe_plat_data = {
> >   	.flags = PMBUS_SKIP_STATUS_CHECK,
> >   };
> > @@ -94,6 +94,7 @@ static int pfe_pmbus_probe(struct i2c_client *client)
> >   	int model;
> >   	model = (int)i2c_match_id(pfe_device_id, client)->driver_data;
> > +	client->dev.platform_data = &pfe_plat_data;
> >   	/*
> >   	 * PFE3000-12-069RA devices may not stay in page 0 during device
> > @@ -101,7 +102,6 @@ static int pfe_pmbus_probe(struct i2c_client *client)
> >   	 * So let's set the device to page 0 at the beginning.
> >   	 */
> >   	if (model == pfe3000) {
> > -		client->dev.platform_data = &pfe3000_plat_data;
> >   		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
> >   	}
> 
> { } is no longer needed.
> 
> Thanks,
> Guenter
> 
