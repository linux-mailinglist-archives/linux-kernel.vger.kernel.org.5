Return-Path: <linux-kernel+bounces-13335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A84708203AC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 06:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5497B282E13
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318B01FCF;
	Sat, 30 Dec 2023 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APKe3h12"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868615AE;
	Sat, 30 Dec 2023 05:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ccc7d7e399so42871041fa.0;
        Fri, 29 Dec 2023 21:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703913588; x=1704518388; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv7UO7csjNz160y529e4P/Xh16i9o3WZFxaja/0pQ64=;
        b=APKe3h12xzqb12SvSjlD2GGi3b16H1OCJ+XFqAddAxqhKlyZasKdJcj89ME5hDGrER
         P0UR36Bvw3Jm7B/IR7Vn6c42ctNAdeyxExkek/IoL2Wbqo1i9Ha48jtuklUSb5fZ9smw
         idpRvKm+Yryd5aGNuJ2CUbOY9IVfi9+FC9TvxgchOEys3u00fhyKxXLQ03UrO89atguE
         By43NWc9onxLlBN1IS9bl6WBIUCW/LK7y664a2KWgupdxUw84cbpgOvY4nzVBbOeSF8b
         dpvRBzFyrwBlw0957/JEJZ7vfePc6GumOcor9UnXVDs2Vlzc75ckJWMI4+GSLNHWsCYf
         bQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703913588; x=1704518388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nv7UO7csjNz160y529e4P/Xh16i9o3WZFxaja/0pQ64=;
        b=kKYDXps5ykUfXqhESU/La3WxyX0Vs07TKwcHzvqEuEzHjlAwlOos2Z4MgbWQh/V7cE
         fUh4KyUaYKaPqXOcHzIfrgHKPvVcGMPBxfc2EE0syK6XLp4SDjKWqG18nSpO+BBmMUXk
         hRrxZMkCgFzngT4oKIsbqJ3rzG8eIRB967QS+mNEFBlznnDpQbOmmGYjwJJlDCi1fqvj
         AQBDypClG1/6ZQ+Do5Twgz//4wlq1Av4eRUI671cI2hols59jW9LysFfwtVHwlT6on0/
         vAfGN1cGd1XvwOq5wxL5zu5Z6r1T1rux8Z3cBmqh7xNZIReEHTvAElGg6fdnu7z0z1/8
         5XgQ==
X-Gm-Message-State: AOJu0YwVmOR3DFmeryZ2HjOHlgDGOUWFDX96jBMMZ/LzWmz51upok4Jp
	ljcxCvFsndgdCVaYziWw4BJtWxESGxufULLTCzc=
X-Google-Smtp-Source: AGHT+IEpz5a/cYri9HwuK0EiUNxDNfgNaTnYWMZgWHmhW8Xhf6o2WH8E9j6ZHlBpg9IbZrqeRr21tELP6o1njKx2v5I=
X-Received: by 2002:a05:651c:10a3:b0:2cc:a51c:32ed with SMTP id
 k3-20020a05651c10a300b002cca51c32edmr4723621ljn.22.1703913587293; Fri, 29 Dec
 2023 21:19:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
 <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
 <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com> <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>
In-Reply-To: <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 30 Dec 2023 02:19:35 -0300
Message-ID: <CAJq09z4YSGyU6QuZL1uEB9vH39-WbR2dZhy7MiD=5yZb0Urz1Q@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > [    3.976779] realtek-smi switch: missing child interrupt-controller node
> > [    3.983455] realtek-smi switch: no interrupt support
> > [    4.158891] realtek-smi switch: no LED for port 5
>
> Are the LEDs working? My device has no LEDs so I have never
> tested it, despite I coded it. (Also these days we can actually
> support each LED individually configured from device tree using
> the LED API, but that would be quite a bit of code, so only some
> fun for the aspiring developer...)

Hi Linus,

I took a look at the LED code. It looks like you got it a little bit wrong.

        /* Set blinking, TODO: make this configurable */
       ret = regmap_update_bits(priv->map, RTL8366RB_LED_BLINKRATE_REG,
                                RTL8366RB_LED_BLINKRATE_MASK,
                                RTL8366RB_LED_BLINKRATE_56MS);
       if (ret)
               return ret;

       /* Set up LED activity:
        * Each port has 4 LEDs, we configure all ports to the same
        * behaviour (no individual config) but we can set up each
        * LED separately.
        */
       if (priv->leds_disabled) {
               /* Turn everything off */
               regmap_update_bits(priv->map,
                                  RTL8366RB_LED_0_1_CTRL_REG,
                                  0x0FFF, 0);
               regmap_update_bits(priv->map,
                                  RTL8366RB_LED_2_3_CTRL_REG,
                                  0x0FFF, 0);
               regmap_update_bits(priv->map,
                                  RTL8366RB_INTERRUPT_CONTROL_REG,
                                  RTL8366RB_P4_RGMII_LED,
                                  0);
               val = RTL8366RB_LED_OFF;
       } else {
               /* TODO: make this configurable per LED */
               val = RTL8366RB_LED_FORCE;
       }
       for (i = 0; i < 4; i++) {
               ret = regmap_update_bits(priv->map,
                                        RTL8366RB_LED_CTRL_REG,
                                        0xf << (i * 4),
                                        val << (i * 4));
               if (ret)
                       return ret;
       }

If LEDs are not disabled, it will use the RTL8366RB_LED_FORCE for all
4 LED groups. That RTL8366RB_LED_FORCE keeps the LEDs on. I would use
RTL8366RB_LED_LINK_ACT by default to make it blink on link activity
(or make it configurable as the comment suggests) but it is not wrong.
I cannot evaluate the RTL8366RB_INTERRUPT_CONTROL_REG usage when you
disable the LEDs but it seems to be odd.

We also have:

static void rb8366rb_set_port_led(struct realtek_priv *priv,
                                 int port, bool enable)
{
       u16 val = enable ? 0x3f : 0;
       int ret;

       if (priv->leds_disabled)
               return;

       switch (port) {
       case 0:
               ret = regmap_update_bits(priv->map,
                                        RTL8366RB_LED_0_1_CTRL_REG,
                                        0x3F, val);
               break;
       case 1:
               ret = regmap_update_bits(priv->map,
                                        RTL8366RB_LED_0_1_CTRL_REG,
                                        0x3F << RTL8366RB_LED_1_OFFSET,
                                        val << RTL8366RB_LED_1_OFFSET);
               break;
       case 2:
               ret = regmap_update_bits(priv->map,
                                        RTL8366RB_LED_2_3_CTRL_REG,
                                        0x3F, val);
               break;
       case 3:
               ret = regmap_update_bits(priv->map,
                                        RTL8366RB_LED_2_3_CTRL_REG,
                                        0x3F << RTL8366RB_LED_3_OFFSET,
                                        val << RTL8366RB_LED_3_OFFSET);
               break;
       case 4:
               ret = regmap_update_bits(priv->map,
                                        RTL8366RB_INTERRUPT_CONTROL_REG,
                                        RTL8366RB_P4_RGMII_LED,
                                        enable ? RTL8366RB_P4_RGMII_LED : 0);
               break;
       default:
               dev_err(priv->dev, "no LED for port %d\n", port);
               return;
       }
       if (ret)
               dev_err(priv->dev, "error updating LED on port %d\n", port);
}

Here things gets strange. The code assumes that
RTL8366RB_LED_0_1_CTRL_REG is related to ports 0 and 1. However, it is
actually LED group 0 and 1. I don't have the docs but the register
seem to enable/disable a port in a group. The first LED pins for all
ports form the group 0 (and so on). My device only use the group 0 for
its 5 ports, limiting my tests. Anyway, to make all ports blink on
link act, I need, at least:

RTL8366RB_LED_CTRL_REG(0x0431) = 0x0002 / 0x000f (set led group 0 to
RTL8366RB_LED_LINK_ACT or 0x2)
RTL8366RB_LED_0_1_CTRL_REG(0x0432) = 0x001f / 0x003f (enable ports
0..5 in LED group 0. I don't really know the mask but the probe code
indicates it is 6 bits per group).

If you really want to disable port 0 LEDs in all groups, you should
unset the first bit for each group. If the mask is really 0x3f, it
would be:

               ret = regmap_update_bits(priv->map,
                                        RTL8366RB_LED_0_1_CTRL_REG,
                                        port,
                                        enable);
               ret = regmap_update_bits(priv->map,
                                        RTL8366RB_LED_0_1_CTRL_REG,
                                        port << RTL8366RB_LED_1_OFFSET,
                                        enable);
               ret = regmap_update_bits(priv->map,
                                        RTL8366RB_LED_2_3_CTRL_REG,
                                        port,
                                        enable);
               ret = regmap_update_bits(priv->map,
                                        RTL8366RB_LED_2_3_CTRL_REG,
                                        port << RTL8366RB_LED_3_OFFSET,
                                        enable);

This message, in fact, does not make sense:

> > [    4.158891] realtek-smi switch: no LED for port 5

I though that maybe we could setup a LED driver to expose the LEDs
status in sysfs. However, I'm not sure it is worth it. If you change a
LED behavior, it would break the HW triggering rule for all the group.
I'm not sure the LED API is ready to expose LEDs with related fate. It
would, indeed, be useful as a readonly source or just to
enable/disable a LED.

Regards,

Luiz

