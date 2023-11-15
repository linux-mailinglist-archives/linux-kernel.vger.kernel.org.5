Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A947A7EC675
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344297AbjKOO5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344272AbjKOO5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:57:13 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04F8121;
        Wed, 15 Nov 2023 06:57:10 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1ea82246069so3900964fac.3;
        Wed, 15 Nov 2023 06:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700060230; x=1700665030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7UFCXikobOe7NagckS+Ldfl/huzC/GDUL1xICL6pThc=;
        b=Ob9dOLFN3IkvHzW89q6WU/2MX97+8EAGiBlCS3UHbtbtAgAVKoGTNILZnrSNcw/s1C
         ids7J9KFsOiKMzMh7CIt9zMsMs52hBdWR9+eHhJzgcJDOsHuNrMVDefGjUmM40hJ8H50
         yGWFG+Mylr++hHbxVvE2UXQClAAxmTjeYrlemV/yUnn2uvek8REryXBs0RqSezRyIuny
         Hk2RlgPrX0IX6XpQdX4i94pVB6/4cS3ZpEDk00bMg2ffKaGmAy4WUNPuEHNDkmmxwcq7
         f6GKmGhO6G8An1ElMemz79MtJLUv0uC7zxb8vnRbz4/25h7QzNz3kcocgKLZy5BC6dXT
         qm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700060230; x=1700665030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UFCXikobOe7NagckS+Ldfl/huzC/GDUL1xICL6pThc=;
        b=TLQEDsjg1CpSviev9UcLWnkLZ+i0jfi38Xd01NN9W+Lff7VSXvt9jXRAjM1kUcZHmi
         8xJ/FuDJFxk6ZlD7mL+vzrmDprrShJlwGbNAXGSgU+OJ1Y9CZTPxlAcsMQk+Mo/I4QcX
         ucBf5hdPN/5ckLE7112Wssr+0tzk1ssNJn4Ok57RixmUKiS8dOr9qgFJ75Y3f0Lu2apT
         77umM/gwW6S0vo6aN9HAcDkREwhCTq4s9z1tQSZyU9FHqMULpqGjm26pk8zfoVX/W5N6
         llenJrxnhWGZ7ZKr9jyBmPW7Rl10G/Ro5jPnS86nJGH133cV3DCY1raH0Cs1RjpgteZG
         Q51Q==
X-Gm-Message-State: AOJu0YwJQJWxIcqJ1iUL1FgBMG1/64OBXo+ERIDsQYts0WzJmnnXCI7c
        P4pzDfbo7DmQGhQaAWh9WKo=
X-Google-Smtp-Source: AGHT+IH5PjGIk7Gl8ToTDM34GQejboIXLEbjtzvTB7suLwByRDhW/R42bKPWOaZmzCVOft/K9b90iA==
X-Received: by 2002:a05:6871:5c7:b0:1e9:9aa5:997b with SMTP id v7-20020a05687105c700b001e99aa5997bmr16236707oan.20.1700060229566;
        Wed, 15 Nov 2023 06:57:09 -0800 (PST)
Received: from google.com ([12.186.190.2])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a14a400b0077438383a07sm3525383qkj.80.2023.11.15.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:57:09 -0800 (PST)
Date:   Wed, 15 Nov 2023 14:57:06 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     andy.shevchenko@gmail.com
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Hans de Goede <hdegoede@redhat.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 2/3] gpiolib: Fix debug messaging in
 gpiod_find_and_request()
Message-ID: <ZVTcQnH_BEEFJ2Ut@google.com>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
 <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
 <ZTGBqEUzgGCcZP1B@google.com>
 <ZVOSd62yCz4lFIP1@smile.fi.intel.com>
 <ZVPkIOk6gvnwkp9F@google.com>
 <ZVQg9hTQwGtNwIhv@surfacebook.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVQg9hTQwGtNwIhv@surfacebook.localdomain>
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 03:37:58AM +0200, andy.shevchenko@gmail.com wrote:
> Tue, Nov 14, 2023 at 09:18:24PM +0000, Dmitry Torokhov kirjoitti:
> > On Tue, Nov 14, 2023 at 05:29:59PM +0200, Andy Shevchenko wrote:
> > > On Thu, Oct 19, 2023 at 12:21:12PM -0700, Dmitry Torokhov wrote:
> > > > On Thu, Oct 19, 2023 at 08:34:56PM +0300, Andy Shevchenko wrote:
> 
> 
> > > > > When consolidating GPIO lookups in ACPI code, the debug messaging
> > > > > had been broken and hence lost a bit of sense. Restore debug
> > > > > messaging in gpiod_find_and_request() when configuring the GPIO
> > > > > line via gpiod_configure_flags().
> > > > 
> > > > Could you give an example of the before/after messages to show exavtly
> > > > what is being improved?
> > > 
> > > Before your patch:
> > > 
> > > [    5.266823] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> > > [   14.182994] gpio-40 (?): no flags found for gpios
> > > 
> > > After your patch:
> > > 
> > > [    5.085048] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> > > [   13.401402] gpio-40 (?): no flags found for (null)
> > > 
> > > After this patch:
> > > 
> > > [    3.871185] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> > > [   12.491998] gpio-40 (?): no flags found for gpios
> > > 
> > > ...
> > > 
> > > Looking at this it's definitely a fix.
> > 
> > If this ("(null)" vs static "gpios" string) is important, can we reduce
> > the patch to:
> > 
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index 76e0c38026c3..b868c016a9be 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -4151,7 +4151,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
> >  
> >  	/* No particular flag request, return here... */
> >  	if (!(dflags & GPIOD_FLAGS_BIT_DIR_SET)) {
> > -		gpiod_dbg(desc, "no flags found for %s\n", con_id);
> > +		gpiod_dbg(desc, "no flags found for %s\n", con_id ?: "gpios");
> >  		return 0;
> >  	}
> >  
> > 
> > instead of plumbing the names through?
> 
> Definitely no, because how can you guess that this is "gpios" and not "gpio"?
> 
> > Although this (and the original fix patch) are losing information, in
> > the sense that "(null)" explicitly communicates that caller used
> > default/NULL conn_id, and not something like "gpios-gpios".
> 
> This is not true, there was no such information before your patch and NULL
> pointer printing is simply a bad style programming. We already had the cases
> when users were scary by "NULL device *" and other similar stuff when it's
> practically no problems in the flow. This has to be fixed anyway.
> 
> And what's the practical meaning of gpios-gpios / gpio-gpios / gpios-gpio /
> gpio-gpio? I believe they are so weird that thinking about them would be lowest
> priority over the issues with the messaging there.

Well, I think we should try to communicate better what it is that we are
printing. Consider your example:

	"gpio-40 (?): no flags found for gpios"

what gpios mean here? You need to go into the code to figure out that it
is connection id (whatever it is for a person who is not ultimately
familiar with gpio subsystem) and not "gpios" in a generic sense. Plus
with your patch you need to ascend a couple of layers up to figure out
that it is connection id and not something else. With "(null)" we at
least did not obfuscate things just so they are visually pleasing to a
random user.

How about we change a message a bit:

	gpiod_dbg(desc, "no flags found for %s gpios\n",
		  con_id ?: "default");

We can argue if "default" should be "unnamed" or "unspecified" or
something else.

And finally what would help most is having a consumer device for which
we are carrying out the operation. You can figure it out from the
sequence of debug messages, but having it right here would be better.

Thanks.

-- 
Dmitry
