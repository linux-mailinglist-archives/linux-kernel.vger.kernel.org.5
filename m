Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C71275D733
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjGUWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjGUWKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:10:07 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3046E30CD;
        Fri, 21 Jul 2023 15:10:06 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b89b75dc1cso23701265ad.1;
        Fri, 21 Jul 2023 15:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689977405; x=1690582205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pXQ5hDMKSWJDU9uqg2X9Wkd9h1kRn35yH0M0crdOhaU=;
        b=g34ViM1CXFJPjCYZoKRcJrdpHZi+9UkPqbaSslBQDt30H1ol90S1y7sP+EI+VkhEqe
         18DiNo4SpRI8WiSidQCHSqPnJIGNnOwbTmq6Ob3KL+rkcAD11d2wegnYOly2amk5Vvto
         7SlRhZzsmUlufw2r8InjywH+CylaNw7F2Hp1SNTR0cQagcF58DrzIZh6MCkLYmDtIRBm
         UztzuAOetSgbSLvMmVudfly+FkMNw9V5Y+70EnEjaeRi1lEVXmDFhc5OqUU08xkMcW6t
         OqGAEnZiI3WqJnS6ieUSPdyOVFJqIZMrY414wlsr8GEhx96NTIoXZUcU4I34Dbh3/ZA+
         WxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689977405; x=1690582205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXQ5hDMKSWJDU9uqg2X9Wkd9h1kRn35yH0M0crdOhaU=;
        b=kJ0IE52EV9ugsh5WPUVZKloypA3e3GaR/nJepzBFMcC6O3yqALw3xcR7tO7GE4a6Yz
         gKryTiTQj0X+XAO6AHCZrrh7p7fs2ERJtr3NtJnD9O0FvYme8IreGYAyCO9soW9xNvkM
         8lopZUJolViQ71azVdH2yIDXBd043uH4xE6IidePZ1nAlYxtc2bTq+KvsVnRFZrpeLga
         J8FB15A3npzI/Kn0HbzBAdF2jgmQaEupJ3sgFSS6MIdkB/q7LCKeP7mk+WwPUzy3IuXu
         cx4Ws38Sr4gWLhouUO0T25dlbgflP/OYCVFaI4TFFRADFPjObilEA2IVx/pyWJmW6JjT
         l9Cg==
X-Gm-Message-State: ABy/qLZlXOzBEZD05z8kkQZmM9sW9KkwshTjfZP0F3h7kqXBpvYpZYIm
        6NOShRElIm+4Y7WnkxE9Lc3ydNpiFEM=
X-Google-Smtp-Source: APBJJlFjOQrNWEdeJ3ZK7t3BaS3rsRqc8CzmhyHq1gA1ZSjNMfqMGZIsMVfa5c94GdV1mPbQrcYyew==
X-Received: by 2002:a17:902:f690:b0:1b8:8682:62fb with SMTP id l16-20020a170902f69000b001b8868262fbmr5966360plg.4.1689977405457;
        Fri, 21 Jul 2023 15:10:05 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fd88:dbb:fc42:8207])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001b9de67285dsm3996910plh.156.2023.07.21.15.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:10:05 -0700 (PDT)
Date:   Fri, 21 Jul 2023 15:10:02 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Andreas Helbech Kleist <andreaskleist@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
Message-ID: <ZLsCOj1t4JvG3SEp@google.com>
References: <20230717131756.240645-1-biju.das.jz@bp.renesas.com>
 <20230717131756.240645-2-biju.das.jz@bp.renesas.com>
 <ZLVlIPHdmEGdG5D1@google.com>
 <OS0PR01MB592264ADC86061AB003048DD863BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <66228ad3-c087-418c-925f-b9fd4a60fb16@sirena.org.uk>
 <ZLWIPPAfeR1+KbeH@google.com>
 <OS0PR01MB59225D8CF3E96808DD776A8E863BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZLbbslBiIQXFWpmN@google.com>
 <TYCPR01MB593346FBBA320260A290EAFD8639A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB593346FBBA320260A290EAFD8639A@TYCPR01MB5933.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 06:43:47AM +0000, Biju Das wrote:
> Hi Dmitry Torokhov,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> > 
> > On Mon, Jul 17, 2023 at 06:45:27PM +0000, Biju Das wrote:
> > > Hi Dmitry,
> > >
> > > > Subject: Re: [PATCH v2 1/2] Input: exc3000 - Simplify probe()
> > > >
> > > > On Mon, Jul 17, 2023 at 07:15:50PM +0100, Mark Brown wrote:
> > > > > On Mon, Jul 17, 2023 at 04:35:02PM +0000, Biju Das wrote:
> > > > >
> > > > > > The .device_get_match_data callbacks are missing for I2C and SPI
> > > > > > bus
> > > > subsystems.
> > > > > > Can you please throw some lights on this?
> > > > >
> > > > > It's the first time I've ever heard of that callback, I don't know
> > > > > why whoever added it wouldn't have done those buses in particular
> > > > > or if it just didn't happen.  Try adding it and if it works send
> > the patches?
> > > >
> > > > I think there is a disconnect. Right now device_get_match_data
> > > > callbacks are part of fwnode_operations. I was proposing to add
> > > > another optional device_get_match_data callback to 'struct bus_type'
> > > > to allow individual buses control how match data is handled, before
> > > > (or after) jumping into the fwnode-backed device_get_match_data
> > callbacks.
> > >
> > > That is what implemented here [1] and [2] right?
> 
> [1] https://elixir.bootlin.com/linux/v6.5-rc2/source/drivers/spi/spi.c#L364
> 
> [2] https://elixir.bootlin.com/linux/v6.5-rc2/source/drivers/i2c/i2c-core-base.c#L117
> 
> > >
> > >
> > > First it check for fwnode-backed device_get_match_data callbacks and
> > > Fallback is bus-type based match.
> > >
> > > Looks like you are proposing to unify [1] and [2] and you want the
> > > logic to be other way around. ie, first bus-type match, then
> > > fwnode-backed callbacks?
> > >
> > 
> > I do not have a strong preference for the ordering, i.e. I think it is
> > perfectly fine to do the generic fwnode-based lookup and if there is no
> > match have bus method called as a fallback, 
> 
> That involves a bit of work.
> 
> const void *device_get_match_data(const struct device *dev);
> 
> const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
> 					 const struct i2c_client *client);
> 
> const struct spi_device_id *spi_get_device_id(const struct spi_device *sdev);
> 
> Basically, the bus-client driver(such as exc3000) needs to pass struct device
> and device_get_match_data after generic fwnode-based lookup,
> needs to find the bus type based on struct device and call a new generic 
> void* bus_get_match_data(void*) callback, so that each bus interface
> can do a match.

Yes, something like this (which does not seem that involved to me...):

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 8c40abed7852..cc0bf7bb6f3a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1277,7 +1277,13 @@ EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
 
 const void *device_get_match_data(const struct device *dev)
 {
-	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
+	const void *data;
+
+	data = fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
+	if (!data && dev->bus && dev->bus->get_match_data)
+		data = dev->bus->get_match_data(dev);
+
+	return data;
 }
 EXPORT_SYMBOL_GPL(device_get_match_data);
 
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 60746652fd52..5fe47bc491a6 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -114,6 +114,26 @@ const struct i2c_device_id *i2c_match_id(const struct i2c_device_id *id,
 }
 EXPORT_SYMBOL_GPL(i2c_match_id);
 
+static const void *i2c_device_get_match_data(const struct device *dev)
+{
+	const struct i2c_client *client = to_i2c_client(dev);
+	const struct i2c_driver *driver;
+	const struct i2c_device_id *match;
+
+	if (!dev->driver)
+		return NULL;
+
+	driver = to_i2c_driver(dev->driver);
+	if (!driver)
+		return NULL;
+
+	match = i2c_match_id(driver->id_table, client);
+	if (!match)
+		return NULL;
+
+	return (const void *)match->driver_data;
+}
+
 const void *i2c_get_match_data(const struct i2c_client *client)
 {
 	struct i2c_driver *driver = to_i2c_driver(client->dev.driver);
@@ -695,6 +715,7 @@ struct bus_type i2c_bus_type = {
 	.probe		= i2c_device_probe,
 	.remove		= i2c_device_remove,
 	.shutdown	= i2c_device_shutdown,
+	.get_match_data	= i2c_device_get_match_data,
 };
 EXPORT_SYMBOL_GPL(i2c_bus_type);
 
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index ae10c4322754..3f2cba28a1af 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -102,6 +102,8 @@ struct bus_type {
 	int (*dma_configure)(struct device *dev);
 	void (*dma_cleanup)(struct device *dev);
 
+	const void *(*get_match_data)(const struct device *dev);
+
 	const struct dev_pm_ops *pm;
 
 	const struct iommu_ops *iommu_ops;


Thanks.

-- 
Dmitry
