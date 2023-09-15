Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08097A2ACA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbjIOW5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbjIOW4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:56:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB587AF;
        Fri, 15 Sep 2023 15:56:31 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c0db66af1bso21049085ad.2;
        Fri, 15 Sep 2023 15:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694818591; x=1695423391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYhaJs0QfjNPt5yJIDvqz/fYTXFTi+vd06sH5X+6Upk=;
        b=NftQiGoljlLi6Mb7XayJj3Mit0Kqie62TZFBWksy/z1gqKSVnwNnQQtx4vEeFJO/Ga
         3fWAS+mARs1o48dOGTInWphKsufD9ogmUzXlEBAo0kN18xGjbVstbtBaTagFsb4HKlqx
         yCg0xfVEyF2PIUSOhGywIBeIT6vi2jJ78gQBbpv/C204vLC5KMuwggr4M/SD1QIf+U6n
         /wY2y9MuVXiFxp0TgRohUsuMPB1Lm5w+14ZQuVEwofZSn+ciifXH0Y2RVJCgfBDbcrzV
         XX76h7OGtLGtEWvSFkzyE+5HDorWdxKlQA5w3P2DeR6oRklkQRi3N+UnLpmJqeMRWM7K
         pXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694818591; x=1695423391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYhaJs0QfjNPt5yJIDvqz/fYTXFTi+vd06sH5X+6Upk=;
        b=bhxiduAsynhqHxaIqxI/a6GSJ9eMC0dMlouoF2GaDiQ6Q3ffhCNO9A/FnRN1smotS8
         g0v7+PMEDgxpv1mNjre8mZOmTCzpF9AazCgs1AhnW+O8fQWn6iQcuvpsATEIqcFzvLSV
         cL2iF7Yvsmwi/GW1K/I4RyuCcT8OPxBhlesbeG7YOhK/TvQfripcTwHKJm5/w2+zCR2j
         EgdbHJQ9V8u0UzAq2Fxg/0FNkkiLWtOLlWvRD3zEyI93ItcE7boTSlBedz7q1HJSN5Bl
         siLmvkAXKnEt7ZlQB+4A3K7ZRejDAWnDbd+CdIjZ29lWe3rIzXoR1k61kqVmJ+He+IIK
         RO5w==
X-Gm-Message-State: AOJu0YyKZAkGmv5XjemjP9UsEIj/Dzhtavnu+wnSmayO7rR1thRK/f4X
        hfIOlheQgIKmrUcedPfGrOo=
X-Google-Smtp-Source: AGHT+IFd3bG3L2tySHG9ogSRmoQU14yC4ccoLWfU63vyX1xXbz3gIiKyPMBfB/wthO0+kqOBqPG0rQ==
X-Received: by 2002:a17:902:da8e:b0:1c0:c640:3f3e with SMTP id j14-20020a170902da8e00b001c0c6403f3emr3508643plx.42.1694818591014;
        Fri, 15 Sep 2023 15:56:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j21-20020a170902c3d500b001b898595be7sm3981989plj.291.2023.09.15.15.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 15:56:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 15 Sep 2023 15:56:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     Guenter Roeck <groeck7@gmail.com>,
        David Ober <dober6023@gmail.com>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, corbet@lwn.net, David Ober <dober@lenovo.com>
Subject: Re: [PATCH] hwmon:Add MEC172x Micro Chip driver for Lenovo
 motherboards
Message-ID: <68c6df3f-f83b-48da-9ee2-351995479915@roeck-us.net>
References: <20230915150340.301067-1-dober6023@gmail.com>
 <8a566102-5ea6-4449-9083-8feebe711065@roeck-us.net>
 <TYZPR03MB59949F797738F5B1B8638278BDF6A@TYZPR03MB5994.apcprd03.prod.outlook.com>
 <55f22980-b47a-4a22-8f19-2b0a5b4e6a1a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f22980-b47a-4a22-8f19-2b0a5b4e6a1a@app.fastmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 06:43:02PM -0400, Mark Pearson wrote:
> Hi Guenter,
> 
> > From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck 
> > On Fri, Sep 15, 2023 at 11:03:40AM -0400, David Ober wrote:
> >> This addition adds in the ability for the system to scan the
> >> MEC172x EC chip in Lenovo ThinkStation systems to get the
> >> current fan RPM speeds and the Maximum speed value for each
> >> fan also provides the current CPU and DIMM thermal status
> >>
> >> Signed-off-by: David Ober <dober6023@gmail.com>
> >>
> >> Written by David Ober from Lenovo using this gmail address since
> >> my corporate email address does not comply with git email
> >
> > FWIW, this needs to be after '---'
> >
> > Anyway, thinking about this submission makes me even more concerned.
> >
> > This isn't really a driver for MEC172x; it is simply a driver
> > accessing an EC on a set of PCs and/or laptops from Lenovo
> > which uses a vertain API for communication between EC and main
> > CPU.
> >
> > Such ECs are typically accessed through ACPI. Yet, in this driver
> > there is no mention of ACPI, much less any protection against
> > parallel use by ACPI code (that access lock in get_ec_reg() doesn't
> > even protect against parallel access from userspace, much less
> > against parallel access from other drivers or ACPI, for example
> > by using request_region() to reserve the used memory ranges).
> >
> > There needs to be explanations and clarifications
> > - Why this driver will only be used for communication with MEC172X
> >   based chips, and why the exact EC chip is relevant in the first place
> >   to be mentioned as much as it is.
> > - How it is guaranteed that the EC is not and will never be accessed
> >   through ACPI.
> > - How it is guaranteed that there will never be any other kernel drivers
> >   accessing the chip.
> >
> I assume for this we just need confirmation from the BIOS team that this is how it will be handled and it's intentional by design?
> 
> Agreed this is normally done by ACPI, but my understanding is that it's not the case on these particular workstation platforms. FWIW Windows is also doing access by a separate driver. 
> I'm not sure why the design is done this way but will confirm to make sure.
> 
> With regards to guaranteeing that no other kernel drivers access the chip - I'm not sure how we can ensure that. Or do you mean if another vendor is using this chip but with different platform IDs and want to use a similar driver? 
> For this case we can make the driver generic (rename it mec172x.c) so others could add their platform support in the future (the platform IDs will be unique). Either that or I can confirm with Microchip if this particular chip is Lenovo specific.

This has nothing to do with the microcontroller you use as EC,
and you can not tell anyone that they must not use the same
microcontroller in their system.

If the chip is not accessed from another driver, you can use
request_region() to reserve the memory space used by the chip.

Guenter



> 
> Let me know if I'm misunderstanding or missing something obvious here. Ack on reserving the region.
> 
> >> ---
> >>  drivers/hwmon/Kconfig             |  10 +
> >>  drivers/hwmon/Makefile            |   1 +
> >>  drivers/hwmon/lenovo-ec-sensors.c | 471 ++++++++++++++++++++++++++++++
> >
> > Documentation missing.
> Ack. I assume under Documentation/hwmon
> 
> Thanks for the review
> Mark
