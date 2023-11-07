Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE627E3B30
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjKGLmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGLmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:42:21 -0500
Received: from esa1.ltts.com (unknown [118.185.121.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B6510A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:42:17 -0800 (PST)
IronPort-SDR: bpSv0UIQB+/NLwrQzn1nbkD6LC5paG1AfxmDkr1d9X8zeBf3xADDhwftMoIbXGQDU63M4si8ph
 NqzIynMFIwww==
Received: from unknown (HELO BLTSP01651.lnties.com) ([10.20.120.98])
  by esa1.ltts.com with ESMTP; 07 Nov 2023 17:12:14 +0530
From:   Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
To:     gregkh@linuxfoundation.org
Cc:     arnd@arndb.de, lee@kernel.org, linux-kernel@vger.kernel.org,
        sirisha.gairuboina@ltts.com
Subject: Re: [PATCH v1 1/3] drivers: mfd: Add support for TPS65224
Date:   Tue,  7 Nov 2023 17:10:44 +0530
Message-Id: <20231107114044.1046407-1-sirisha.gairuboina@Ltts.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2023102739-absolve-coastal-6b4d@gregkh>
References: <2023102739-absolve-coastal-6b4d@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>

> On Thu, Oct 26, 2023 at 07:02:24PM +0530, Gairuboina Sirisha wrote:
> > From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> >
> > Added support for tps65224 driver pmic core, header, Makefile and Kconfig
>
> What is a "tps65224"?  Please provide some more information so we know
> how to review this.
>
> >
> > Signed-off-by: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> > ---
> >  drivers/mfd/Kconfig          |   5 +
> >  drivers/mfd/Makefile         |   1 +
> >  drivers/mfd/tps65224-core.c  | 291 ++++++++++++++
> >  include/linux/mfd/tps65224.h | 735 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 1032 insertions(+)
> >  create mode 100644 drivers/mfd/tps65224-core.c
> >  create mode 100644 include/linux/mfd/tps65224.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 90ce58fd629e..2e4906484eed 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1767,6 +1767,11 @@ config MFD_TPS6594_SPI
> >
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called tps6594-spi.
> > +config MFD_TPS65224
>
> You need a blank line before this, right?
>
> > +        tristate
> > +        select MFD_CORE
> > +        select REGMAP
> > +        select REGMAP_IRQ
>
> No help text at all to describe what this is?
>
> > --- /dev/null
> > +++ b/drivers/mfd/tps65224-core.c
> > @@ -0,0 +1,291 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Core functions for TI TPS65224 PMIC
> > + *
> > + * Copyright (C) 2015 Texas Instruments Incorporated - https://www.ti.com/
>
> No changes have happened since 2015 to this code?
>
> > +EXPORT_SYMBOL_GPL(tps65224_device_init);
> > +
> > +MODULE_AUTHOR("Gairuboina Sirisha <sirisha.gairuboina@ltts.com>");
>
> That dosn't match the copyright line :(
>

Thanks for pointing it out. We will update the cover letter to describe about tps65224.
Also, style and copyright will be corrected in the next patch version V2.

> > --- /dev/null
> > +++ b/include/linux/mfd/tps65224.h
>
> Why do you need a .h file at all?  This is just used in one .c file,
> right?

This is a common header file for tps65224 PMIC which will be used for other drivers
like GPIO, Regulators, PFSM, ESM, SPI and I2C.

Thanks & Regards,
Sirisha G.
