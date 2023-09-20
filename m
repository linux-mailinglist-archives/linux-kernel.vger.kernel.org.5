Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347427A87D9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjITPHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjITPHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:07:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E931A9;
        Wed, 20 Sep 2023 08:06:54 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40476ce8b2fso65545695e9.3;
        Wed, 20 Sep 2023 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695222412; x=1695827212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6jLYbx3Kj5iFhIPdJC/nxya3IqybFyHBYSnhy8+7io=;
        b=QZbz8USREBV6dalkNErnBfi5z/kxZmaUoBebU4jslK+h5vufDWgU4lKO483LPk9Nsp
         mJ05CaphJ0ioLgvIFMHZqXy3TJ9t+YQLU6N/65ysU4Pc13Oz4MBSLGFLLwHu+55/J3P0
         Ro11S2+UIrY1bMhnExgh4oCvU9byBzHk4p1XWAZLgq65iWkGCIc3/1EbU8blQYrPdqDa
         XUhGiqppqYyBzFgeioqjxxkhjLfTMVwSUSuMqVF6Xtbfi26w5fU4DpyQxc3kFfD72Q3r
         KcpPXJpe1S13/OWQmjWLVU1cnCq77fbYP5xw8WiDwqWeoTyMdBam831Hs11MfDwdYIWg
         cqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695222412; x=1695827212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6jLYbx3Kj5iFhIPdJC/nxya3IqybFyHBYSnhy8+7io=;
        b=pGAZrOtZJY8oSl128iZHbg5EG83CiVZVv/8C+KO1WDvRJWwsy9ImSfMJ34er66mvmz
         uCTzT1/MCPKfwvNDBNROXq3/mWHMJU/qg3zcacC3/GM1BWhAQnsRPb/TRNNBZ5EM5LM4
         q64/2tzzWaHjiuWMxWh0L3ZSA4ezvpV6tBibwM66biwC1Lti800FeaWv4hh5/2VknL9k
         QzbsacW8ywgNzQoSPG+QCwxdaz1/l/2Xqh5fIVtpVwo/lZ2ZaQGAIq13nEdYh1aQLiYd
         iUz5RzP8HmDegk3RkS+xcH6UYWUjJ4d+7X006w7nvbPi+WU3tOE40F2hzfhgg1MLHTLd
         q0jA==
X-Gm-Message-State: AOJu0Yxkp+TKJXPgUYD0vZoY2cJeGQ4tJgrGwSfBnvus9R6rPqrU/8rb
        vZtDZK8hKOTrC7ky7jHEDJM=
X-Google-Smtp-Source: AGHT+IH1kWTSrDgbrwmPQg1oibF+aJRlO1ZejFw1vlQjaI++hCBcrB4dpbZDa9yVx19qWBXrXRY8Qg==
X-Received: by 2002:a1c:740f:0:b0:401:daf2:2735 with SMTP id p15-20020a1c740f000000b00401daf22735mr2570020wmc.31.1695222412127;
        Wed, 20 Sep 2023 08:06:52 -0700 (PDT)
Received: from primary ([212.34.23.120])
        by smtp.gmail.com with ESMTPSA id y20-20020a1c4b14000000b003feee8d8011sm2197473wma.41.2023.09.20.08.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:06:51 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:53:23 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH v5 10/15] USB: typec: Add port registration for tps25750
Message-ID: <ZQsHY/53tk0KJYUK@primary>
References: <20230917152639.21443-1-alkuor@gmail.com>
 <20230917152639.21443-11-alkuor@gmail.com>
 <ZQhJZ82nRCD797lA@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQhJZ82nRCD797lA@kuha.fi.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 03:58:15PM +0300, Heikki Krogerus wrote:
> On Sun, Sep 17, 2023 at 11:26:34AM -0400, Abdel Alkuor wrote:
> > From: Abdel Alkuor <abdelalkuor@geotab.com>
> > 
> > TPS25750 doesn't have system configuration register to get dr/pr of the
> > current applied binary configuration.
> > 
> > Get data role from the device node and power role from PD status register.
> > 
> > Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> > ---
> >  drivers/usb/typec/tipd/core.c     | 61 ++++++++++++++++++++++++++++++-
> >  drivers/usb/typec/tipd/tps6598x.h | 10 +++++
> >  2 files changed, 70 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > index 8218d88a4a06..a97fda68cb54 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -39,6 +39,7 @@
> >  #define TPS_REG_CTRL_CONF		0x29
> >  #define TPS_REG_BOOT_STATUS		0x2D
> >  #define TPS_REG_POWER_STATUS		0x3f
> > +#define TPS_REG_PD_STATUS		0x40
> >  #define TPS_REG_RX_IDENTITY_SOP		0x48
> >  #define TPS_REG_DATA_STATUS		0x5f
> >  
> > @@ -1028,6 +1029,60 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
> >  	return 0;
> >  }
> >  
> > +static int
> > +tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
> > +{
> > +	struct typec_capability typec_cap = { };
> > +	const char *data_role;
> > +	u8 pd_status;
> > +	int ret;
> > +
> > +	ret = tps6598x_read8(tps, TPS_REG_PD_STATUS, &pd_status);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = fwnode_property_read_string(fwnode, "data-role", &data_role);
> > +	if (ret) {
> > +		dev_err(tps->dev, "data-role not found: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = typec_find_port_data_role(data_role);
> > +	if (ret < 0) {
> > +		dev_err(tps->dev, "unknown data-role: %s\n", data_role);
> > +		return ret;
> > +	}
> > +
> > +	typec_cap.data = ret;
> > +	typec_cap.revision = USB_TYPEC_REV_1_3;
> > +	typec_cap.pd_revision = 0x300;
> > +	typec_cap.driver_data = tps;
> > +	typec_cap.ops = &tps6598x_ops;
> > +	typec_cap.fwnode = fwnode;
> > +	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
> > +
> > +	switch (TPS_PD_STATUS_PORT_TYPE(pd_status)) {
> > +	case TPS_PD_STATUS_PORT_TYPE_SINK_SOURCE:
> > +	case TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK:
> > +		typec_cap.type = TYPEC_PORT_DRP;
> > +		break;
> > +	case TPS_PD_STATUS_PORT_TYPE_SINK:
> > +		typec_cap.type = TYPEC_PORT_SNK;
> > +		break;
> > +	case TPS_PD_STATUS_PORT_TYPE_SOURCE:
> > +		typec_cap.type = TYPEC_PORT_SRC;
> > +		break;
> > +	default:
> > +		return -ENODEV;
> > +	}
> > +
> > +	tps->port = typec_register_port(tps->dev, &typec_cap);
> > +	if (IS_ERR(tps->port))
> > +		return PTR_ERR(tps->port);
> > +
> > +	return 0;
> > +}
> > +
> >  static int tps6598x_probe(struct i2c_client *client)
> >  {
> >  	irq_handler_t irq_handler = tps6598x_interrupt;
> > @@ -1124,7 +1179,11 @@ static int tps6598x_probe(struct i2c_client *client)
> >  	if (ret)
> >  		goto err_role_put;
> >  
> > -	ret = tps6598x_register_port(tps, fwnode);
> > +	if (np && of_device_is_compatible(np, "ti,tps25750"))
> 
> Why aren't you using is_tps25750 here?
Ops, I missed that. Will be fixed in v6.
> 
> > +		ret = tps25750_register_port(tps, fwnode);
> > +	else
> > +		ret = tps6598x_register_port(tps, fwnode);
> > +
> >  	if (ret)
> >  		goto err_role_put;
> 
> thanks,
> 
> -- 
> heikki

Thanks,
Abdel
