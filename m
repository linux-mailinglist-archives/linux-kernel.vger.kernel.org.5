Return-Path: <linux-kernel+bounces-13609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A32B820929
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 00:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E20F2B21B02
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 23:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BDBF505;
	Sat, 30 Dec 2023 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWUDlUd5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256BDDC6;
	Sat, 30 Dec 2023 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ccf55bed13so8744111fa.1;
        Sat, 30 Dec 2023 15:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703980582; x=1704585382; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L5zAmrcU0rDyTMldnWGuhFtbY40ZcOd+zmFip/yI9K8=;
        b=CWUDlUd5LI4yyn4puZcvTu7vvKyts2XBTGeRqf6tcftAfXMNByNWlhvWZgKtbJBhxW
         AtPPoB20dwnIsf2iw0D2a98S0j1RK1PXU16TOuJK7Y/zLzmdtHqM7gkLDTatDmATEWZ0
         Ac9b+o0vjGzF1Rt3Llm+jXTm5spOW43gYFxTyvSXsfXiQ5KcDoAgM98QU7JbIHjhZJ9U
         Mnn4+IgMSL64upk+S3A1DGYwOi7xlCCEmBzR4QhDfBpbx0bQFMpifaSt+1nqTHPNQ1tr
         8T5pg0rdiPbrLiVt3YsNt4NmC44QprTGfHPbXsmHsPkhXj9v7f4OQkaIKJkGeCEoSVKh
         voAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703980582; x=1704585382;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5zAmrcU0rDyTMldnWGuhFtbY40ZcOd+zmFip/yI9K8=;
        b=qc09aUfp2Dr4M+du2i2qPFJFqbkpwW4LSJwRjAkyxkixe5mMm9dF0u7AKE98PVlml6
         yDQj0PZBOrsdM8L2jvgn1lwAgmsRM87fo2XxDbycJWb99YhU0ac+c/AvCoNdT7NwaCPg
         aJHQ9lPxUOXuxTxXMXsDnDwLwZ8DTt1JEEiuYhPEQiLr/7J5djqa3cBpSM7S/Uj/9OsH
         +mynZoc9maIZrGI+q6HBU/Ja/IF35T1dHjusc/0G4H1b/TEPKfQSuHY0/gKKPJDj8sVW
         xbBvlfnkXR4poGQopC6cCbcW60lOz79ZZQQp7o2B8okE5ahhIXHh1KQsMvDzRKqLBdwD
         hV0A==
X-Gm-Message-State: AOJu0YztGJnGQMtLZy471qO9/NK6sndEwKtv3OTkSTl2YUyG0JXw+EFz
	pqBDsRMMtthcwButRKfc3rervPORynmQG5E81JRgtoWVEPOnX7pI
X-Google-Smtp-Source: AGHT+IF2Wg676gczAtvkd20vpFPvT40Dbhl8a/yw1mt/kUXSYbEgd067fvLk6YybmgGC6T+VAhzbNZwwi2bmj+f4KL4=
X-Received: by 2002:a2e:9686:0:b0:2cc:7db2:acb9 with SMTP id
 q6-20020a2e9686000000b002cc7db2acb9mr6007446lji.24.1703980581641; Sat, 30 Dec
 2023 15:56:21 -0800 (PST)
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
 <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com>
 <CACRpkdaoBo0S0RgLhacObd3pbjtWAfr6s3oizQAHqdB76gaG5A@mail.gmail.com>
 <CAJq09z4YSGyU6QuZL1uEB9vH39-WbR2dZhy7MiD=5yZb0Urz1Q@mail.gmail.com> <CACRpkdZOKz-DdZgwwxj9FsJZ+GNMCXUjTDLo5wVgjw5OrfOZQA@mail.gmail.com>
In-Reply-To: <CACRpkdZOKz-DdZgwwxj9FsJZ+GNMCXUjTDLo5wVgjw5OrfOZQA@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 30 Dec 2023 20:56:10 -0300
Message-ID: <CAJq09z6xA7roZJYuQFn6B1ivOUOyhrE4-wf4Kj3o6az8hArNqg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ansuel Smith <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > I took a look at the LED code. It looks like you got it a little bit wrong.
>
> You are right...
>
> > If LEDs are not disabled, it will use the RTL8366RB_LED_FORCE for all
> > 4 LED groups. That RTL8366RB_LED_FORCE keeps the LEDs on. I would use
> > RTL8366RB_LED_LINK_ACT by default to make it blink on link activity
> > (or make it configurable as the comment suggests) but it is not wrong.
> > I cannot evaluate the RTL8366RB_INTERRUPT_CONTROL_REG usage when you
> > disable the LEDs but it seems to be odd.
>
> The problem is that since I don't have a device with LEDs connected
> to tHE RTL8366RB it is all just dry coding.
>
> I would suggest if you can test it just make a basic patch that will
> at least turn on the LEDs to some default setting that works for
> you?

Sure. I believe using link act will be much more useful than just
turning all leds on, independently from the port state. It is an easy
one-line fix.
I can do that after the other series gets merged.

I think that we should also remove rb8366rb_set_port_led(). Even if I
fix it, it will just turn the LED off when the port is
administratively down. RTL8366RB_LED_0_1_CTRL_REG and
RTL8366RB_LED_2_3_CTRL_REG are only used to control leds when you
force them to be on (RTL8366RB_LED_FORCE). In that scenario, the OS
might be in charge of triggering them, even for uses not related to
the switch.

> > I though that maybe we could setup a LED driver to expose the LEDs
> > status in sysfs. However, I'm not sure it is worth it. If you change a
> > LED behavior, it would break the HW triggering rule for all the group.
> > I'm not sure the LED API is ready to expose LEDs with related fate. It
> > would, indeed, be useful as a readonly source or just to
> > enable/disable a LED.
>
> The LED subsystem supports hardware triggering etc thanks to the
> elaborate work by Christian (ansuel). You can see an example of how
> this is done in:
> drivers/net/dsa/qca/qca8k-leds.c
>
> Christian also extended the LEDs subsystem with the necessary
> callbacks to support HW-backed LED control.
>
> This can be used already to achieve HW triggers for the LEDs
> from sysfs. (See callbacks .hw_control_is_supported,
> .hw_control_set etc etc).
>
> I was working to implement this for the Marvell switches but Andrew
> wanted to do some more structured approach with a LED library
> for DSA switches.

Yes, I took a look at it. It would be my inspiration if I go down that
road. I can use the HW offload only if all LEDs in the group share the
same trigger and timer. Otherwise, I'll need to fall back to software
control. I'll think about it if that is a viable solution.

Regards,

Luiz

