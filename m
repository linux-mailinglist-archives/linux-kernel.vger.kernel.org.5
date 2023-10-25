Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186097D758D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjJYU0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbjJYUZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:25:42 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D618F19A2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:25:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507f1c29f25so152637e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698265514; x=1698870314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBhYd8KrptCnHhI12JEqE8NhWUYADTCkyVE3k5UBWiw=;
        b=JVYagIaZFteH4Aj4tfwXIJvdWkEsh6r9e/07fQpJ+15fz5DwrNNPfEYodPUqIO61g/
         ilAv8RxOLZrrx0sQpnS7+3u5YqT8Yr/w6fU1uxduX0hH1rplDWM9YJS9/DyKR5vAldDx
         SWNCGg4EmNhFlkCtmvf6ICmcwxnz7K0dd2ZYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265514; x=1698870314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBhYd8KrptCnHhI12JEqE8NhWUYADTCkyVE3k5UBWiw=;
        b=m5gHh1TO8bHnGTeZoY1jrTor72ajUOQ2riqP+Wmj2RqpQy8KskcW9X8ZIQyEuSNaZm
         fxWV3zxD/y9Qv0Ke6TCG6JYqJBnr6gIZTNyOaKBZVxc5nFeQrNJ0fHz7P9fekitZnzs0
         yjivwqz/5kIzYILjg2QvOteF6MYhmYY5WEknUxGw1fluizynyI0T0hzx+zfNIekQbY8l
         uRRAk1bgtC6NmXBVDQ1VL/YYym01swkQtVxu5WfyezYMkqdRfykauJsUIiTVotb00yAt
         oq3D1PsTjZpp0pyH84/OESgBH3iZMAiMkFty2UxV6iMqyWMT+TOWiAF4hb6zs3GQMgHk
         eFew==
X-Gm-Message-State: AOJu0Yw7BD/CFFg1TP5NRyilBeJG4X3fEO11tIz5AYtct6/PctgNuWPY
        XpYH8wwCNK0GN9GvOl26i8ffPjUAKwq1R9nUVODl+Q==
X-Google-Smtp-Source: AGHT+IGEKzcqKA2dc+K1G4bnrJHRMxCnlXHyzHS6gW7gTed7UlDlVWe33NlM9ZmbNs8RJMEkeH8h8A==
X-Received: by 2002:ac2:5f76:0:b0:4fe:7dcb:4150 with SMTP id c22-20020ac25f76000000b004fe7dcb4150mr11207376lfc.67.1698265514035;
        Wed, 25 Oct 2023 13:25:14 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id u21-20020a50d515000000b0053dbb214d96sm10311588edi.13.2023.10.25.13.25.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 13:25:13 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so3515e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:25:12 -0700 (PDT)
X-Received: by 2002:a05:600c:4592:b0:3f6:f4b:d4a6 with SMTP id
 r18-20020a05600c459200b003f60f4bd4a6mr138900wmo.7.1698265511701; Wed, 25 Oct
 2023 13:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org>
 <20231020140655.v5.8.Ib2affdbfdc2527aaeef9b46d4f23f7c04147faeb@changeid> <20231025162824.GK57304@kernel.org>
In-Reply-To: <20231025162824.GK57304@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 25 Oct 2023 13:24:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XVJVkyA09Ca_YGa5xRS4jGra4cw-6ArgwCekMzn7uWcA@mail.gmail.com>
Message-ID: <CAD=FV=XVJVkyA09Ca_YGa5xRS4jGra4cw-6ArgwCekMzn7uWcA@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] r8152: Block future register access if register
 access fails
To:     Simon Horman <horms@kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 25, 2023 at 9:28=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Oct 20, 2023 at 02:06:59PM -0700, Douglas Anderson wrote:
>
> ...
>
> > @@ -9603,25 +9713,14 @@ static bool rtl8152_supports_lenovo_macpassthru=
(struct usb_device *udev)
> >       return 0;
> >  }
> >
> > -static int rtl8152_probe(struct usb_interface *intf,
> > -                      const struct usb_device_id *id)
> > +static int rtl8152_probe_once(struct usb_interface *intf,
> > +                           const struct usb_device_id *id, u8 version)
> >  {
> >       struct usb_device *udev =3D interface_to_usbdev(intf);
> >       struct r8152 *tp;
> >       struct net_device *netdev;
> > -     u8 version;
> >       int ret;
> >
> > -     if (intf->cur_altsetting->desc.bInterfaceClass !=3D USB_CLASS_VEN=
DOR_SPEC)
> > -             return -ENODEV;
> > -
> > -     if (!rtl_check_vendor_ok(intf))
> > -             return -ENODEV;
> > -
> > -     version =3D rtl8152_get_version(intf);
> > -     if (version =3D=3D RTL_VER_UNKNOWN)
> > -             return -ENODEV;
> > -
> >       usb_reset_device(udev);
> >       netdev =3D alloc_etherdev(sizeof(struct r8152));
> >       if (!netdev) {
> > @@ -9784,10 +9883,20 @@ static int rtl8152_probe(struct usb_interface *=
intf,
> >       else
> >               device_set_wakeup_enable(&udev->dev, false);
> >
> > +     /* If we saw a control transfer error while probing then we may
> > +      * want to try probe() again. Consider this an error.
> > +      */
> > +     if (test_bit(PROBE_SHOULD_RETRY, &tp->flags))
> > +             goto out2;
>
> Sorry for being a bit slow here, but if this is an error condition,
> sould ret be set to an error value?
>
> As flagged by Smatch.

Thanks for the note. I think we're OK, though. If you look at the
"out:" label, which is right after "out1" it tests for the same bit.
That will set "ret =3D -EAGAIN" for us.

I'll admit it probably violates the principle of least astonishment,
but there's a method to my madness. Specifically:

a) We need a test here to make sure we don't return "success" if the
bit is set. The driver doesn't error check for success when it
modifies HW registers so it might _thnk_ it was successful but still
have this bit set. ...so we need this check right before we return
"success".

b) We also need to test for this bit if we're in the error handling
code. Even though the driver doesn't check for success in lots of
places, there still could be some places that notice an error. It may
return any kind of error here, so we need to override it to -EAGAIN.

...so I just set "ret =3D -EAGAIN" in one place.

Does that make sense? If you want to submit a patch adjusting the
comment to make this more obvious, I'm happy to review it.

-Doug
