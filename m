Return-Path: <linux-kernel+bounces-21792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF2B829454
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24ACE1C258A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD6E3D966;
	Wed, 10 Jan 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Gm3lQmmX"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAD43C461
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 48C9A3F2C4
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 07:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704871895;
	bh=KvxfHlrMgiqX95kb2kMMpwevy28rI1e3PWaaS37wyJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Gm3lQmmXZxew9IweYLyhi8bEykWCMLIAhmz/kQy7Zxro30e8JGOkRzk5hvZEUTRXW
	 NumKaAcHPit37jjy4+OsAqSKSKQeEQhtlBLUmpl/fYI0Ns1YdoEVlsASCX//yyl6Be
	 e0mFHZ/V0Am/yMdSzXnX43Oi5JOhCJmu8LzK7wCfgdl1rbbWX32tS+BA/6sAYU7XyO
	 Y4dyt3sYbK8yMSqBVe3gr3BHLAzBYDx7Lqup570Jqtn+eamJAx1jZMtmXPJe8Hc/3j
	 GLTh0y21Hq2Td4rOyfZhGWRKjPRIwzoL5jXFs6KK0KzYmEqVTf0L8hSyc7hsgSgJAM
	 oQCd1XIIi9fMg==
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3bd3b54e5c6so2414606b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 23:31:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704871894; x=1705476694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvxfHlrMgiqX95kb2kMMpwevy28rI1e3PWaaS37wyJE=;
        b=vYS22SEcySDPuqAwdhs4tFE9+z6ekeCjyaU+TDGqBzHPlPfYdE77HTu+2kS64xp4ev
         7PD0G6BWx+1qqko8UAbwfUEl/O8CE3m5FIDeYnb3PO9f0BL7t2//KhGG30U/JJJDUw72
         Sxh6NVxg14t5h2x/Z7UKwUHuR0I/HWUsy2zZzln9xLlu24m/4heVYQ4N6A8lPXREed4z
         2UEZaKsKUznTuLSldWfW7WerLebwkYbHUuq6xJzpDr/0G1Tg+SzAgwYPDZpTz9zgq2rR
         rH1Pqz6XB87Guv4GqEwMRZag9ERkUvP/oU9DRol+brFyXwLIloUVFNFrblOzTPPXA+mO
         +I2Q==
X-Gm-Message-State: AOJu0YzU2aQ6lUHJzIPVIqRR4VXDCOwJ4llvQRP34ggeCURT7CjUvg+d
	Bt2VCVNEBE1PDtZn5jzk4F8TMTpP68Go6+2rpvySl3wWKM/JNJNdKbEXGHoLYN61S2Bh756gEZH
	C/u2tqL9KuQhk9b5/3LIJo0fwFMwR1hQqvsmDxyroyhctgxlbhYatOe9A1BqJ1lHK
X-Received: by 2002:a05:6808:398b:b0:3bc:3796:c505 with SMTP id gq11-20020a056808398b00b003bc3796c505mr1145197oib.12.1704871894205;
        Tue, 09 Jan 2024 23:31:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFx4NWcyUfrYOnYOViy1uhGOZOzfKz5/qAT23x5r4kOSlKuKLbm/wspzUOeV/TMqu1QmZz8m2BJouoJ6J02iw=
X-Received: by 2002:a05:6808:398b:b0:3bc:3796:c505 with SMTP id
 gq11-20020a056808398b00b003bc3796c505mr1145188oib.12.1704871893963; Tue, 09
 Jan 2024 23:31:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103003355.747335-1-kai.heng.feng@canonical.com> <CAD=FV=VmGNB5dP5WO7=txNDScNfhCDEsfFFivXqz+PH6rt=x8g@mail.gmail.com>
In-Reply-To: <CAD=FV=VmGNB5dP5WO7=txNDScNfhCDEsfFFivXqz+PH6rt=x8g@mail.gmail.com>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 10 Jan 2024 15:31:22 +0800
Message-ID: <CAAd53p4gPkbDyNLiYGtcvqWwEgBqVhri+qgh+=Ha0xsVfYy92g@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: Remove SET_POWER SLEEP on system suspend
To: Doug Anderson <dianders@chromium.org>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, 
	Maxime Ripard <mripard@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Johan Hovold <johan+linaro@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 5:25=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Tue, Jan 2, 2024 at 4:34=E2=80=AFPM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > There's a Cirque touchpad that wakes system up without anything touched
> > the touchpad. The input report is empty when this happens.
> > The reason is stated in HID over I2C spec, 7.2.8.2:
> > "If the DEVICE wishes to wake the HOST from its low power state, it can
> > issue a wake by asserting the interrupt."
> >
> > This is fine if OS can put system back to suspend by identifying input
> > wakeup count stays the same on resume, like Chrome OS Dark Resume [0].
> > But for regular distro such policy is lacking.
> >
> > According to commit d9f448e3d71f ("HID: i2c-hid: set power sleep before
> > shutdown"), SLEEP is required for shutdown, in addition to that, commit
> > 67b18dfb8cfc ("HID: i2c-hid: Remove runtime power management") didn't
> > notice any power comsumption reduction from SET_POWER SLEEP, so also
> > remove that to avoid the device asserting the interrupt.
> >
> > [0] https://chromium.googlesource.com/chromiumos/platform2/+/HEAD/power=
_manager/docs/dark_resume.md
> >
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  drivers/hid/i2c-hid/i2c-hid-core.c | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i=
2c-hid-core.c
> > index 2735cd585af0..dd513dc75cb9 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> > @@ -957,9 +957,6 @@ static int i2c_hid_core_suspend(struct i2c_hid *ihi=
d, bool force_poweroff)
> >         if (ret < 0)
> >                 return ret;
> >
> > -       /* Save some power */
> > -       i2c_hid_set_power(ihid, I2C_HID_PWR_SLEEP);
>
> IMO this is not a good idea to do universally. Specifically:
>
> 1. There are many vendors of i2c-hid devices and many different
> devices per vendor. Even if your device doesn't save power in "sleep"
> mode, that doesn't mean it's not important for some other devices.

Thanks for the response.

>
> 2. There are some boards where an i2c-hid device is powered by an
> "always-on" regulator. On these devices it seems like a bad idea not
> to be able to put the i2c-hid device into sleep mode.
>

So if SLEEP for system wide suspend is crucial for some i2c-hid
devices, it should be kept.

>
> I'd also note that I'm really not sure what ChromeOS dark resume has
> to do with anything here. Dark resume is used for certain types of
> events that wakeup the system where we can identify that the event
> shouldn't turn the screen on, then we do some processing, then we go
> back to sleep. I'm nearly certain that a trackpad / touchscreen wakeup
> event would never qualify for "dark resume". If we see a
> trackpad/touchscreen event then we'll wakeup the system. If the system
> is in a state where trackpad/touchscreen events shouldn't wake us up
> then we disable those wakeups before going to suspend...

Doesn't Dark Resume use wakeup count to decide whether the system
should wake up or go back to suspend?
For this case the input report is empty, hence wakeup count remains
the same after the wakeup. I assumed Dark Resume will check the wakeup
count and decide to put the system back to suspend.

>
> It seems to me like the board you're testing on has some strange bug
> and that bug should be fixed, or (in the worst case) you should send a
> patch to detect this broken touchpad and disable wakeup for it.

It's desired to keep the wakeup capability, disabling wakeup isn't ideal he=
re.
I'll write a patch to use touchpad specific quirk instead of applying
the change universally.

Kai-Heng


>
>
> -Doug

