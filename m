Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B956A7E3B57
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjKGLwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjKGLwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:52:16 -0500
Received: from esa2.ltts.com (unknown [14.140.155.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F1C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 03:52:11 -0800 (PST)
IronPort-SDR: YyJCSyCxL1qETMYkp3vKdkn50y3f0yy2rDSaYH/eRAEGgKPCIwe+R8x1rKZ/oUjCOVbAWfLpLn
 f04GXWDfUF5A==
Received: from unknown (HELO BLTSP01651.lnties.com) ([10.20.120.98])
  by esa2.ltts.com with ESMTP; 07 Nov 2023 17:22:09 +0530
From:   Gairuboina Sirisha <sirisha.gairuboina@Ltts.com>
To:     krzk@kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org, lee@kernel.org,
        linux-kernel@vger.kernel.org, sirisha.gairuboina@Ltts.com,
        Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
Subject: Re: [PATCH v1 2/3] drivers: mfd: Add support for TPS65224 i2c driver
Date:   Tue,  7 Nov 2023 17:20:40 +0530
Message-Id: <20231107115040.1072810-1-sirisha.gairuboina@Ltts.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f0e7a7f4-a34e-40cf-bd11-b648c28c5153@kernel.org>
References: <f0e7a7f4-a34e-40cf-bd11-b648c28c5153@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>

> On 26/10/2023 15:32, Gairuboina Sirisha wrote:
> > From: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> >
> > Added MFD driver that enables I2C communication with and without CRC
> >
> > Signed-off-by: Gairuboina Sirisha <sirisha.gairuboina@ltts.com>
> > ---
> >  drivers/mfd/Kconfig        |  14 +++
> >  drivers/mfd/Makefile       |   1 +
> >  drivers/mfd/tps65224-i2c.c | 245 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 260 insertions(+)
> >  create mode 100644 drivers/mfd/tps65224-i2c.c
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 2e4906484eed..943d85d49fc5 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -1767,12 +1767,26 @@ config MFD_TPS6594_SPI
> >
> >  	  This driver can also be built as a module.  If so, the module
> >  	  will be called tps6594-spi.
> > +
>
> This does not belong to this patch.
>
> >  config MFD_TPS65224
> >          tristate
> >          select MFD_CORE
> >          select REGMAP
> >          select REGMAP_IRQ
>
> ...
>
> }
> > +
> > +static const struct regmap_config tps65224_i2c_regmap_config = {
> > +	.reg_bits = 16,
> > +	.val_bits = 8,
> > +	.max_register = TPS65224_REG_WD_FAIL_CNT_REG,
> > +	.volatile_reg = tps65224_is_volatile_reg,
> > +	.read = tps65224_i2c_read,
> > +	.write = tps65224_i2c_write,
> > +};
> > +
> > +static const struct of_device_id tps65224_i2c_of_match_table[] = {
> > +	{ .compatible = "ti,tps65224-q1", },
>
> Where is it documented? It seems nowhere, even though tools asked you to
> do this. :(
>
> Please run scripts/checkpatch.pl and fix reported warnings. Some
> warnings can be ignored, but the code here looks like it needs a fix.
> Feel free to get in touch if the warning is not clear.

Sure. We will submit the required documentation in the next version of patch.

Thanks & Regards,
Sirisha G.
