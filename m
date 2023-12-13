Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15A4B8110C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378812AbjLMMHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjLMMHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:07:37 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EB9CD;
        Wed, 13 Dec 2023 04:07:43 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3333074512bso4202097f8f.1;
        Wed, 13 Dec 2023 04:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702469262; x=1703074062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IQrh0R5F3QXYcuFJGXMMHCAReFJPL8RBLhIJtN3JtEs=;
        b=VndgmxerwCTzpzUTlTok9FQTheTfDSTZF1iMLIIum7m55wY7S75l+dRwC/TPB1O9Ab
         PJORqDHJpkIgo+YMkYAm5ZkzpfSom5eSoRzL4Ovspc65naUv08brI6Vy554A6rak/iz9
         oUVBfvI5gyTxDYWdgpfivtkpOO7xhAkuLFlC2ij2+hPPr3CrEzcxQDGzyj9Pq/pix9uj
         XBc5jSRrNMqm6ycOn85MThj8wXE+duF2d2mweuMF51ehuBh2xkyKguo4BKbjkfdwwAn2
         Lb84qVQTpaKWTtSPdJNan/0rr2AuGQqshYatWOqPCP3CmRrvYrU5mavv61JXmpNHYMLs
         0iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702469262; x=1703074062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQrh0R5F3QXYcuFJGXMMHCAReFJPL8RBLhIJtN3JtEs=;
        b=ZQx9f7MfcXr8Tn1TgsGegHGrLPDOWGug2jjPmNbLFY37E5ORBPAqV0wg4YEV0O//cO
         DDEtZQ66/96gX/IVZN8yk3Axu5TReeGXHEOI3lB1HqfjooDDR0eVDSU+MX+DuvADd04i
         keVjDMbm9JJXAZm+xIzAmxYGjM3FpA3SXju1zZRBXD2URl9TkwU4m73r5tFLFh8AHX21
         yvrFAFO1Rs6EZ3g6KtcOuJCY2vpJYGdwLbu0HZXH4ajDPz9hAySTU3G7kaLpdJb97Rej
         Gg0F+YRU2kXo/5ZiYhZ5Fi8st4B8yju5SGafxM24qX2aGWuLJz1B8IXgTD6DLsX7rOeW
         Cwbw==
X-Gm-Message-State: AOJu0Yzwvcoo/7IPDAw2sa3iVgqHG4HQqD/7gv/Zaym/GPPuBKq4GhMm
        0COZTAejsSltGZbz94PfQb87SxImtBI=
X-Google-Smtp-Source: AGHT+IEwwveQm0Nw1FrJx41dmgyNO20Q2tzfqHWByF/M65X9s1Q+8tJlvMOiNAO6hgtP1bSEobwN5w==
X-Received: by 2002:a5d:6d4a:0:b0:336:1d85:a87 with SMTP id k10-20020a5d6d4a000000b003361d850a87mr2553013wri.12.1702469262050;
        Wed, 13 Dec 2023 04:07:42 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id r12-20020adff70c000000b0033641c10360sm799956wrp.117.2023.12.13.04.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 04:07:41 -0800 (PST)
Message-ID: <65799e8d.df0a0220.1c142.2743@mx.google.com>
X-Google-Original-Message-ID: <ZXmei1mSnxXZh3qh@Ansuel-xps.>
Date:   Wed, 13 Dec 2023 13:07:39 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>,
        Li Zetao <lizetao1@huawei.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: trigger: netdev: display only supported link speed
 attribute
References: <20231209150724.25565-1-ansuelsmth@gmail.com>
 <20231213130521.11513e0a@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231213130521.11513e0a@dellmb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 01:05:21PM +0100, Marek Behún wrote:
> On Sat,  9 Dec 2023 16:07:24 +0100
> Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > With the addition of more link speed mode to the netdev trigger, it was
> > pointed out that there may be a problem with bloating the attribute list
> > with modes that won't ever be supported by the trigger as the attached
> > device name doesn't support them.
> > 
> > To clear and address this problem, change the logic where these
> > additional trigger modes are added.
> > 
> > Since the netdev trigger REQUIRE a device name to be set, attach to the
> > device name change function additional logic to parse the supported link
> > speed modes using ethtool APIs and add only the supported link speed
> > modes attribute.
> > 
> > This only apply to the link speed modes and every other mode is still
> > provided by default.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/leds/trigger/ledtrig-netdev.c | 56 +++++++++++++++++++++++----
> >  1 file changed, 49 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> > index 09e75fd9f2bc..ce84808e231c 100644
> > --- a/drivers/leds/trigger/ledtrig-netdev.c
> > +++ b/drivers/leds/trigger/ledtrig-netdev.c
> > @@ -61,6 +61,8 @@ struct led_netdev_data {
> >  	bool hw_control;
> >  };
> >  
> > +static int add_link_speed_attr(struct led_netdev_data *trigger_data);
> > +
> >  static void set_baseline_state(struct led_netdev_data *trigger_data)
> >  {
> >  	int current_brightness;
> > @@ -262,8 +264,10 @@ static int set_device_name(struct led_netdev_data *trigger_data,
> >  	trigger_data->carrier_link_up = false;
> >  	trigger_data->link_speed = SPEED_UNKNOWN;
> >  	trigger_data->duplex = DUPLEX_UNKNOWN;
> > -	if (trigger_data->net_dev)
> > +	if (trigger_data->net_dev) {
> >  		get_device_state(trigger_data);
> > +		add_link_speed_attr(trigger_data);
> > +	}
> >  
> >  	trigger_data->last_activity = 0;
> >  
> > @@ -396,6 +400,50 @@ DEFINE_NETDEV_TRIGGER(full_duplex, TRIGGER_NETDEV_FULL_DUPLEX);
> >  DEFINE_NETDEV_TRIGGER(tx, TRIGGER_NETDEV_TX);
> >  DEFINE_NETDEV_TRIGGER(rx, TRIGGER_NETDEV_RX);
> >  
> > +static int add_link_speed_attr(struct led_netdev_data *trigger_data)
> > +{
> > +	struct led_classdev *led_cdev = trigger_data->led_cdev;
> > +	struct device *dev = led_cdev->dev;
> > +	struct ethtool_link_ksettings cmd;
> > +	int ret;
> > +
> > +	/* First remove any entry previously added */
> > +	device_remove_file(dev, &dev_attr_link_10);
> > +	device_remove_file(dev, &dev_attr_link_100);
> > +	device_remove_file(dev, &dev_attr_link_1000);
> > +	device_remove_file(dev, &dev_attr_link_2500);
> > +	device_remove_file(dev, &dev_attr_link_5000);
> > +	device_remove_file(dev, &dev_attr_link_10000);
> 
> Noooooo!
> 
> > +	ret = __ethtool_get_link_ksettings(trigger_data->net_dev, &cmd);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Add only supported entry */
> > +	if (test_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, cmd.link_modes.supported) ||
> > +	    test_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, cmd.link_modes.supported))
> > +		device_create_file(dev, &dev_attr_link_10);
> > +
> > +	if (test_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, cmd.link_modes.supported) ||
> > +	    test_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, cmd.link_modes.supported))
> > +		device_create_file(dev, &dev_attr_link_100);
> > +
> > +	if (test_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, cmd.link_modes.supported) ||
> > +	    test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, cmd.link_modes.supported))
> > +		device_create_file(dev, &dev_attr_link_1000);
> > +
> > +	if (test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, cmd.link_modes.supported))
> > +		device_create_file(dev, &dev_attr_link_2500);
> > +
> > +	if (test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, cmd.link_modes.supported))
> > +		device_create_file(dev, &dev_attr_link_5000);
> > +
> > +	if (test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, cmd.link_modes.supported))
> > +		device_create_file(dev, &dev_attr_link_10000);
> > +
> > +	return 0;
> > +}
> 
> This should be done via the is_visible sysfs attribute_group method.
> 
> Also documentation for the link_* files should be changed so that it
> says that the files are present only if those speeds are available.
>

Just working on doing this change!

Just need to do some test on how is_visible behave with changing the
device_name.

-- 
	Ansuel
