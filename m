Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B797980CFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343955AbjLKPfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344139AbjLKPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:35:08 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08336116
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:35:14 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2ca02def690so57332691fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702308909; x=1702913709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SD+slHvHquFxJLd6D5SBrC9H4ySn5gVhp3h2f4/9JhE=;
        b=bli5bog1kLW1SE0HtRlRn8nEKYWQQbdYJDxVehhanSADI4T3lM1N4fcA9Z7oiH3TgP
         4IMgOWVMfoc44jTf96AwQZcbXplPjxxEIE5ud9kSJ6vwNLLgqLRxZkkutijavZOUndD7
         DsBQEMfM8KXBf4fZfwf7458xFatavBQvWFKs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308909; x=1702913709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SD+slHvHquFxJLd6D5SBrC9H4ySn5gVhp3h2f4/9JhE=;
        b=VG6LgS1nCa0mzIgRPQ9D2VZSpmngfjzTrAbZ5Rs9qsd4zmpgcy2NeJxL3Z/jUPcXC4
         PbNXNpOhT+wuxjCxvMWvV3TefWZ7VfsLKkIZn0o6+gs1oLj2W3DbSxTTfdWzXCrb3zNO
         8XuKd83+3O/GJ+BLecRrf9I7+6tvj8LEM4Vv00/JABrKUvIekcWTuTKu9jeEa8uvrq3U
         83zMwcNb5rCiH+d26aIgTFaqT46Huo3tvo8dL5UdkOzaedwkGf90nDXQJt7WkteMlFiW
         iFqSEAhen3eal59tpzwWBoR2aTBtH8kgDGpXPKrPPtt52Q3uHt8LOrcPUnT29pfLdulN
         8/HA==
X-Gm-Message-State: AOJu0YyywSPUXNMQoJbGaXDT/T49omAAq8M3u+1J2kXEWEwAsn0Gygk+
        h14QaNz9pXNIEr+v+7g0MhkdrV8JkLIFXcLBXBcz/w==
X-Google-Smtp-Source: AGHT+IEAMclNrUUNjJV4SqMYcWDrZGGx0WC9fKlihtLnkhbQOb+7PLEC2YoIdR7VWmDsxEpihhE0sQ==
X-Received: by 2002:a05:651c:88b:b0:2cc:1c75:3494 with SMTP id d11-20020a05651c088b00b002cc1c753494mr1911611ljq.55.1702308908676;
        Mon, 11 Dec 2023 07:35:08 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id tl18-20020a170907c31200b00a1da2c9b06asm4969022ejc.42.2023.12.11.07.35.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 07:35:08 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so101705e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:35:07 -0800 (PST)
X-Received: by 2002:a05:600c:3b20:b0:40c:1e46:508e with SMTP id
 m32-20020a05600c3b2000b0040c1e46508emr225387wms.0.1702308907352; Mon, 11 Dec
 2023 07:35:07 -0800 (PST)
MIME-Version: 1.0
References: <20231211070808.v2.1.If27eb3bf7812f91ab83810f232292f032f4203e0@changeid>
 <1ec52764-7fd9-484f-bcdc-bbf97194deef@rowland.harvard.edu>
In-Reply-To: <1ec52764-7fd9-484f-bcdc-bbf97194deef@rowland.harvard.edu>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Dec 2023 07:34:50 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V3=Lnk-8E9GmpYtXXJBDLkPZgXWt+5MVof3Wn_JYS9rg@mail.gmail.com>
Message-ID: <CAD=FV=V3=Lnk-8E9GmpYtXXJBDLkPZgXWt+5MVof3Wn_JYS9rg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: core: Fix crash w/ usb_choose_configuration() if
 no driver
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Brian Geffon <bgeffon@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Grant Grundler <grundler@chromium.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 11, 2023 at 7:27=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Mon, Dec 11, 2023 at 07:08:14AM -0800, Douglas Anderson wrote:
> > It's possible that usb_choose_configuration() can get called when a
> > USB device has no driver. In this case the recent commit a87b8e3be926
> > ("usb: core: Allow subclassed USB drivers to override
> > usb_choose_configuration()") can cause a crash since it dereferenced
> > the driver structure without checking for NULL. Let's add a check.
> >
> > A USB device with no driver is an anomaly, so make
> > usb_choose_configuration() return immediately if there is no driver.
> >
> > This was seen in the real world when usbguard got ahold of a r8152
> > device at the wrong time. It can also be simulated via this on a
> > computer with one r8152-based USB Ethernet adapter:
> >   cd /sys/bus/usb/drivers/r8152-cfgselector
> >   to_unbind=3D"$(ls -d *-*)"
> >   real_dir=3D"$(readlink -f "${to_unbind}")"
> >   echo "${to_unbind}" > unbind
> >   cd "${real_dir}"
> >   echo 0 > authorized
> >   echo 1 > authorized
> >
> > Fixes: a87b8e3be926 ("usb: core: Allow subclassed USB drivers to overri=
de usb_choose_configuration()")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Return immediately if no driver, as per Alan.
> >
> >  drivers/usb/core/generic.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
> > index dcb897158228..2be1e8901e2f 100644
> > --- a/drivers/usb/core/generic.c
> > +++ b/drivers/usb/core/generic.c
> > @@ -59,7 +59,11 @@ int usb_choose_configuration(struct usb_device *udev=
)
> >       int num_configs;
> >       int insufficient_power =3D 0;
> >       struct usb_host_config *c, *best;
> > -     struct usb_device_driver *udriver =3D to_usb_device_driver(udev->=
dev.driver);
> > +     struct usb_device_driver *udriver;
> > +
> > +     if (!udev->dev.driver)
> > +             return -1;
>
> This is a rather unusual condition.  It would be good to put a comment
> just before the test, explaining that if a USB device (not an interface)
> doesn't have a driver then the kernel has no business trying to select
> or install a configuration for it.
>
> Along with the comment, feel free to add:
>
> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

Thanks for the quick reply. I've added your comment almost verbatim to
the code and sent out a quick v3 with your tag:

https://lore.kernel.org/r/20231211073237.v3.1.If27eb3bf7812f91ab83810f23229=
2f032f4203e0@changeid
