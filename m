Return-Path: <linux-kernel+bounces-112554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF43887B78
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B83AB22059
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 02:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352C428EB;
	Sun, 24 Mar 2024 02:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4Z4agfv"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B7919E;
	Sun, 24 Mar 2024 02:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711247496; cv=none; b=tselQ0g0Li7IH7Xowue2zPi/xsuq25iud/Zxv43UuXAwtEzC/5EOv6/AZ5Gb9Ooq8cn4NpX+CHnluMSqn2VctIXxmZIYFcZRuDMd/Zke/vf2chUw9WJSOk3kWuMYkxvgy08wNXCOHtVqz80FqZOm2pf4boFIsNpNEk+f1icP/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711247496; c=relaxed/simple;
	bh=1nmzs8+59f3eTSSb4EHKHfXDxUT3kLk5jsjI1LOqsgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dq8sAcq0YmDuhz1/zY8w8HW/qJ46Tz4XjF4jmquMNatvug5D7C8+/kWJkd3E4wphiCNSnms5BsvaOvCIKDHBdYIsybMPW7sn/QKDqGsLtQ9libTcm6zZf7RK9NNfoM6yeIfDZlufNxuXvVva/NYCDp3nmdpWJQZPGLRD+WYqvEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4Z4agfv; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513edc88d3cso3576798e87.0;
        Sat, 23 Mar 2024 19:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711247493; x=1711852293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ttFDHYUPF8eVry49hS32GJpVcROjul1wVNuPzf2VzU=;
        b=A4Z4agfvL/zWC6+zEC9z34UGGQU/cGmLkBECK4P5b9GHNSrN48W2rtpmY8zKtIx7GD
         rJuayNt8UsO0ZIXLdbqkzb+9bme+7I+3qehqyyTl7Cbu0xcppnt4AAC9094vYRKsy2dz
         iFda7nwtoppfZrlrU+nsIKgaRPRc14SiG9U5dYnoEPD2hD277WdYEqWq21o6QhZR95PB
         nuANiTCy/BcXL8wKYoiuBQIEbRnkriL+Gm64WWJLy6yNPucGDSTGpRpPlJOBC/BBE626
         l4BUZPD/9xWOuNDwydnYcG8j/MLPmDMRgt63AM7pV8nNSEmWeGwaSuP1d76+ungmHP6R
         t0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711247493; x=1711852293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ttFDHYUPF8eVry49hS32GJpVcROjul1wVNuPzf2VzU=;
        b=MBHO079c1cC8NkGS89+2b/PlGOFLbL1w5JATG9ea5fH9CtsBk+bbX1gphga07f638u
         fY0KtnaDPWRwCeIpTww/ek0JjS8zfe9EiuXeHzdaayxBTDWX/Y4O6Bn+d7saGickDsiF
         h6e3NiKhqhqVJbMIwVgsKMEzYuwWFb+t7gbFmE7X9tD39gOsNmrQvtXsACAs5AKB4t6M
         Cfx0IVu/Jzw+6UhqkxOaDsFnZGkT6/LzHKU+uSa90RWXvr7152JTMNc+YYGuxA+iRVHr
         yg0L014FfZv9wIO9EIJNj4GAZU3Lm32nkjQKuHX7gwbXZQkVbBlOWdY46qI7HpICpQJ+
         l3/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV25/7KZGBkW2h2aOpwdyEvBVDzvlB0I7SmNNbiVXcSU6tgMLoZTq1n4JjnHFujIOp3ixYLjvMOe7fH+83enNxn8sD8bkITOd5Tq10/TrgEfK1R/tkaLXtQuunjwxmXDA+kIryz
X-Gm-Message-State: AOJu0YyHP/AgK1OkI8uDLio4BwjySQGTpAcl1Evk6iiHOoom8bMAuNIW
	jT+CHtu53+CYBLXZAlinU4M5V/cahBRfG7lkfEi8+6YDGBcRkJBdFX+znbYjhsFhOi/RC2uQRSU
	LZyjBO6pl8ZiEZSlNv0wwXlLK03zCG6jiBqOg8g==
X-Google-Smtp-Source: AGHT+IF3shpvwe10rEcyKLKEb5RmNM0sKYtRAER9MhHGFZ2E5mCR/NC5ZFXNCzglxZCcWmGNEoqIpl1Sq3bq9zKtF3I=
X-Received: by 2002:a19:6917:0:b0:513:a39e:ae45 with SMTP id
 e23-20020a196917000000b00513a39eae45mr2217192lfc.62.1711247492731; Sat, 23
 Mar 2024 19:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-4-4d9813ce938e@gmail.com> <20240310114928.GB1623@kernel.org>
In-Reply-To: <20240310114928.GB1623@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 23 Mar 2024 23:31:21 -0300
Message-ID: <CAJq09z5n8iRe4Qt=qMFU6064ci6WavKcx8_D6Dx=hLst_vXHrw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net: dsa: realtek: add LED drivers for rtl8366rb
To: Simon Horman <horms@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> On Sun, Mar 10, 2024 at 01:52:01AM -0300, Luiz Angelo Daros de Luca wrote:
> > This commit introduces LED drivers for rtl8366rb, enabling LEDs to be
> > described in the device tree using the same format as qca8k. Each port
> > can configure up to 4 LEDs.
> >
> > If all LEDs in a group use the default state "keep", they will use the
> > default behavior after a reset. Changing the brightness of one LED,
> > either manually or by a trigger, will disable the default hardware
> > trigger and switch the entire LED group to manually controlled LEDs.
> > Once in this mode, there is no way to revert to hardware-controlled LEDs
> > (except by resetting the switch).
> >
> > Software triggers function as expected with manually controlled LEDs.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >  drivers/net/dsa/realtek/rtl8366rb.c | 270 ++++++++++++++++++++++++++++++++----
>
> ...
>
> > +static int rtl8366rb_setup_led(struct realtek_priv *priv, struct dsa_port *dp,
> > +                            struct fwnode_handle *led_fwnode)
> > +{
> > +     struct rtl8366rb *rb = priv->chip_data;
> > +     struct led_init_data init_data = { };
> > +     struct rtl8366rb_led *led;
> > +     enum led_default_state state;
> > +     u32 led_group;
> > +     int ret;
>
> nit: Please consider using reverse xmas tree - longest line to shortest -
>      for local variables in networking code.

Sorry, I might have renamed a variable to a shorter form without
rechecking the order. Thanks for the tip.

> ...
>
> > +static int rtl8366rb_setup_leds(struct realtek_priv *priv)
> > +{
> > +     struct device_node *leds_np, *led_np;
> > +     struct dsa_switch *ds = &priv->ds;
> > +     struct dsa_port *dp;
> > +     int ret;
> > +
> > +     dsa_switch_for_each_port(dp, ds) {
> > +             if (!dp->dn)
> > +                     continue;
> > +
> > +             leds_np = of_get_child_by_name(dp->dn, "leds");
> > +             if (!leds_np) {
> > +                     dev_dbg(priv->dev, "No leds defined for port %d",
> > +                             dp->index);
> > +                     continue;
> > +             }
> > +
> > +             for_each_child_of_node(leds_np, led_np) {
> > +                     ret = rtl8366rb_setup_led(priv, dp,
> > +                                               of_fwnode_handle(led_np));
> > +                     if (ret) {
> > +                             of_node_put(led_np);
>
> FWIIW, Coccinelle complans about "probable double put" here.
> But it looks correct to me as it's only called when breaking out of
> the loop, when it is required AFAIK.

I agree. I do think the put is required when you break the loop as the
put happens in the increment/decrement code, including the last one
when it naturally ends the loop with led_np defined as null.

>
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             of_node_put(leds_np);
> > +             if (ret)
>
> I'm unsure if this can happen. But if for_each_child_of_node()
> iterates zero times then ret may be uninitialised here.
>
> Flagged by Smatch.

Yes, I'll initialize it as 0. It could also use if (led_np), as it
will only be defined if the loop was broken (but checking ret seems to
be simpler).

>
> > +                     return ret;
> > +     }
> > +     return 0;
> > +}
>
> ...

