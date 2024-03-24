Return-Path: <linux-kernel+bounces-112568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE5887B90
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 04:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDCF1F2165C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 03:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8105C46AB;
	Sun, 24 Mar 2024 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHoh0enZ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631C17C8;
	Sun, 24 Mar 2024 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711252020; cv=none; b=MihU8Qkbv+KNzNqi401TaPZTMI8/YsvL/fCxYZ2chK2whAtHI/a9vUHwsbAMqb2D4KrFODhvt0HrCGH5D6JhsdOx5BKVOLtDaHRhT7sQb1pUfk/ce5Xfq87R+7eZym4V3DfkvITuz8VVe+x/YgtgKigmUELyPD4wNuz24cwmQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711252020; c=relaxed/simple;
	bh=gVqqkRGU/3els7tcz6OsDQKpy7LxTpDMrrgR0NlEdlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N17yL3KruFZrUDBtjZ1MBdomYtbJDf+IPay1jyVRlr92ne+PwzMnYtmN0PwbzujDLFl4z6i2M0BiPO7yojk2QsrLm5egqkstrl23Nfc0vV56gT5pIB45hd9wD7wyT4bUD3yQrAjMDkH6sf3o26L/E03RV4NJ3acb+nwnmY+u95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHoh0enZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-513e14b2bd9so4106113e87.2;
        Sat, 23 Mar 2024 20:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711252017; x=1711856817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+SbCCM4Rqqk3o4wOpzi2ca6RVXsIMPypp6pppWrvaAY=;
        b=fHoh0enZTi25qyawpWdjj9m/frgSMN9b3ciYP5MiNXmTF3PM3BcNXAp0QgbDnn1AEb
         Majn6ZPBiZi6wKC7XyoqKlB+13pjDUF53q9WTIDDWdoyUpWyRB0J5qFDKBl8i/cxAGsI
         c0GP2FGxUhBXvE4TtoYAif0YT4pMJ2FjmOTnwyBNVlblZFkyOE0v9hEVVc8QmuKGSh1J
         QIua9XEuyAJqYKDQeTcor9JXnRzpnJPart2Ilq7C28WSjPS1w+wHodoTTvmZWM6bz2c3
         eo/dEcV6Xf0MlUgXaNcgF8Nr4gbzpu2DvS1kiagMDpqyA3iTJeZvGZ6VWotqufDPiRrC
         z5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711252017; x=1711856817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SbCCM4Rqqk3o4wOpzi2ca6RVXsIMPypp6pppWrvaAY=;
        b=w0MgsnoMx2DpqF3ZSBKsi5Zv9YU58bvuEqH6nS8CBC8LKePnLL82uzDwtYGnVCRyEX
         XWR3Xo4X/7O7CXRUXCA25+ZAmcsh5X6xHuEr67TNg+p0hdMtQLspJrW2oBSbmEE6zbit
         2h+gXq4Pc6WCghlNqF+P8tDcgclmu6YMJSdTPH4T01emjyHk/tILM5yCRCuaNiHvVdqz
         q3JP+mEgTyIt0nfprecbHNd7aYOpkbxkXkqFyW3aMf+P5pqR5ArjBzetWFcV/erI2WK1
         zy+/nBWh1t+GuW/shlTSucJNuNSzPTFX5hnpz1ioS6g5jRZUSMAtpGGJNLj4oSvRiCVR
         H3hA==
X-Forwarded-Encrypted: i=1; AJvYcCWt09AEQC0v7GkExV9HnUTu9LCzIM71yAz2SzHI9yWG3GohpUlZC0vm9h1T+j2xH5GTvGmA0F9pmNoxIA1F2Vy12NImeTPk/Y3FJqj6ef5i1VAGto2sP6NejXjIDJg9oBEvI/NT
X-Gm-Message-State: AOJu0YxLlD83O45Hi8LQm7uqc+4ywKNTdFjBINqJXBy2uzdGvue7luS5
	TQMicOtV4Fm+m/pzpvwk+03l6rxrX+WVxVLEawypc/l7YH66p0mqM40gpVSEqbA4Rg0Kro0cL/R
	Uoq0D7BA3CSVJOqEFUXYljQDQBfw=
X-Google-Smtp-Source: AGHT+IFe4xxZSB5uiqrgYTbUMVoUPUFnpmDPPgpUYdTBWP7/JgAhEFsqSZVQYC+6K2QFidWW8VfIZv3DZVLBnIsK9Nw=
X-Received: by 2002:a19:9149:0:b0:513:dd23:7a02 with SMTP id
 y9-20020a199149000000b00513dd237a02mr2255369lfj.26.1711252016380; Sat, 23 Mar
 2024 20:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
 <20240310-realtek-led-v1-4-4d9813ce938e@gmail.com> <d064b1be-1004-487b-9944-b62d91b671c9@lunn.ch>
In-Reply-To: <d064b1be-1004-487b-9944-b62d91b671c9@lunn.ch>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 24 Mar 2024 00:46:44 -0300
Message-ID: <CAJq09z54+049aPL2LzAqAFigrvpchPhv_YQ6yJ5C9b9J7mngLQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net: dsa: realtek: add LED drivers for rtl8366rb
To: Andrew Lunn <andrew@lunn.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Thanks for the review.

> > This commit introduces LED drivers for rtl8366rb, enabling LEDs to be
> > described in the device tree using the same format as qca8k. Each port
> > can configure up to 4 LEDs.
> >
> > If all LEDs in a group use the default state "keep", they will use the
> > default behavior after a reset. Changing the brightness of one LED,
> > either manually or by a trigger, will disable the default hardware
> > trigger and switch the entire LED group to manually controlled LEDs.
>
>
> The previous patch said:
>
>   This switch family supports four LEDs for each of its six
>   ports. Each LED group is composed of one of these four LEDs from all
>   six ports. LED groups can be configured to display hardware
>   information, such as link activity, or manually controlled through a
>   bitmap in registers RTL8366RB_LED_0_1_CTRL_REG and
>   RTL8366RB_LED_2_3_CTRL_REG.
>
> I could be understanding this wrongly, but to me, it sounds like an
> LED is either controlled via the group, or you can take an LED out of
> the group and software on/off control it? Ah, after looking at the
> code. The group can be put into forced mode, and then each LED in the
> group controlled in software.

The group of a LED is a HW property. There are pins for each LED on
each group. You cannot move LEDs out of a group, not even to simply
disable a single LED.
The trigger mode is the same for all LEDs in a group as it is a LED
group property and not a LED characteristic. There is a special
trigger mode (manual) that disables HW triggers and lets the LEDs be
controlled by software triggers using a register bitmap.

> > Once in this mode, there is no way to revert to hardware-controlled LEDs
> > (except by resetting the switch).
>
> Just for my understanding.... This is a software limitation. You could
> check if all LEDs in a group are using the same trigger, and then set
> the group to that trigger?

I tried to implement that but I failed. There was some discussion
about it in the RFC thread. The main issue is that hw offload is only
evaluated when a LED changes its sysfs settings. The driver has
limited control about the hw offload decision, only being notified
when led_cdev->hw_control_is_supported() is called. The driver will
not be notified, for example, if the trigger_data->net_dev was changed
or if hw_control was disabled. However, even if you know a HW trigger
could be enabled, you cannot put those other LEDs in HW offload mode.
It is only enabled from sysfs calls but not from the kernel space and
AFAIK, you should not poke with sysfs from the kernel space.

The incompatibility with LDE API also has some unexpected
side-effects. For example, LEDS_DEFSTATE_KEEP will only really keep
the default vendor state if all LEDs in a group use that setting or
are missing in the DT. If one of them differs, it will switch the
group to manual mode.

> I do understand how the current offload concept causes problems here.
> You need a call into the trigger to ask it to re-evaluate if offload
> can be performed for an LED.

The trigger_data->hw_control is only set from netdev_led_attr_store()
(or during trigger activation). That code is only exposed to sysfs
calls. We'll need an exported function that could set that. Also, the
driver can only control that decision from
led_cdev->hw_control_is_supported. However, it is not enough to
surelly decide if a LED is still in a state that would support HW
offload (i.e. because trigger_data->net_dev could have changed). So,
we need to:

1) expose internal ledtrig-netdev data required for deciding if
offload is supported for any LED at any time
2) expose a way to reevaluate trigger_data->hw_control (or a way to
forcely enable it)

> What you have here seems like a good first step, offloaded could be
> added later if somebody wants to.

Yes, it is, at least, working. The current code is simply not usable.

> > +enum rtl8366_led_mode {
> > +     RTL8366RB_LED_OFF               = 0x0,
> > +     RTL8366RB_LED_DUP_COL           = 0x1,
> > +     RTL8366RB_LED_LINK_ACT          = 0x2,
> > +     RTL8366RB_LED_SPD1000           = 0x3,
> > +     RTL8366RB_LED_SPD100            = 0x4,
> > +     RTL8366RB_LED_SPD10             = 0x5,
> > +     RTL8366RB_LED_SPD1000_ACT       = 0x6,
> > +     RTL8366RB_LED_SPD100_ACT        = 0x7,
> > +     RTL8366RB_LED_SPD10_ACT         = 0x8,
> > +     RTL8366RB_LED_SPD100_10_ACT     = 0x9,
> > +     RTL8366RB_LED_FIBER             = 0xa,
> > +     RTL8366RB_LED_AN_FAULT          = 0xb,
> > +     RTL8366RB_LED_LINK_RX           = 0xc,
> > +     RTL8366RB_LED_LINK_TX           = 0xd,
> > +     RTL8366RB_LED_MASTER            = 0xe,
> > +     RTL8366RB_LED_FORCE             = 0xf,
>
> This is what the group shows? Maybe put _GROUP_ into the name? This
> concept of a group is pretty unusual, so we should be careful with
> naming to make it clear when we are referring to one LED or a group of
> LEDs. I would also put _group_ into the enum.

I don't know if this concept of group is unusual but LED API
definitely does not handle it well.

OK, I'll add _group_/_GROUP_ both to the enum name and macros. Led
blink rate, for example, is global, used by all groups. However, it
will be difficult to respect the 80 columns limit passing
RTL8366RB_LED_GROUP_OFF to a rb8366rb_set_ledgroup_mode function with
only two levels of indentation. Do you have any recommendations?

>
> > +
> > +     __RTL8366RB_LED_MAX
> > +};
> > +
> > +struct rtl8366rb_led {
> > +     u8 port_num;
> > +     u8 led_group;
> > +     struct realtek_priv *priv;
> > +     struct led_classdev cdev;
> > +};
> > +
> >  /**
> >   * struct rtl8366rb - RTL8366RB-specific data
> >   * @max_mtu: per-port max MTU setting
> >   * @pvid_enabled: if PVID is set for respective port
> > + * @leds: per-port and per-ledgroup led info
> >   */
> >  struct rtl8366rb {
> >       unsigned int max_mtu[RTL8366RB_NUM_PORTS];
> >       bool pvid_enabled[RTL8366RB_NUM_PORTS];
> > +     struct rtl8366rb_led leds[RTL8366RB_NUM_PORTS][RTL8366RB_NUM_LEDGROUPS];
> >  };
> >
> >  static struct rtl8366_mib_counter rtl8366rb_mib_counters[] = {
> > @@ -809,6 +829,208 @@ static int rtl8366rb_jam_table(const struct rtl8366rb_jam_tbl_entry *jam_table,
> >       return 0;
> >  }
> >
> > +static int rb8366rb_set_ledgroup_mode(struct realtek_priv *priv,
> > +                                   u8 led_group,
> > +                                   enum rtl8366_led_mode mode)
> > +{
> > +     int ret;
> > +     u32 val;
> > +
> > +     val = mode << RTL8366RB_LED_CTRL_OFFSET(led_group);
> > +
> > +     ret = regmap_update_bits(priv->map,
> > +                              RTL8366RB_LED_CTRL_REG,
> > +                              RTL8366RB_LED_CTRL_MASK(led_group),
> > +                              val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +
> > +static inline u32 rtl8366rb_led_group_port_mask(u8 led_group, u8 port)
> > +{
> > +     switch (led_group) {
> > +     case 0:
> > +             return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
> > +     case 1:
> > +             return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
> > +     case 2:
> > +             return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
> > +     case 3:
> > +             return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));
> > +     default:
> > +             return 0;
> > +     }
> > +}
> > +
> > +static int rb8366rb_get_port_led(struct rtl8366rb_led *led, bool enable)
>
> enable seems unused here. It also seems an odd parameter to pass to a
> _get_ function.

Yes, copy/paste mistake. Thanks.

>
> > +{
> > +     struct realtek_priv *priv = led->priv;
> > +     u8 led_group = led->led_group;
> > +     u8 port_num = led->port_num;
> > +     int ret;
> > +     u32 val;
> > +
> > +     if (led_group >= RTL8366RB_NUM_LEDGROUPS) {
> > +             dev_err(priv->dev, "Invalid LED group %d for port %d",
> > +                     led_group, port_num);
> > +             return -EINVAL;
> > +     }
>
> This check seems odd. You can validate it once when you create the
> struct rtl8366rb_led. After that, just trust it?

Yes, I was redundant. If memory is intact, led->led_group is
guaranteed to be in range. I'll drop it in both get/set.

>
>        Andrew

Regards,

Luiz

