Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DE48012D6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379323AbjLASd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjLASdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:33:25 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5203C1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:33:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso66413a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701455610; x=1702060410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=738HwGeAiA3Mv3rj5fZwSn1NgklwgVqxq6lPPHVus6g=;
        b=ZwVkNoJiLcvQ/m8nuZm6fMLa16NTU1jEfWgcBR7tIjxW7DTZtPOx3EwpaMcZUGyIL4
         QbS9Y6l9gSVDaIUgB/3I7ZnyPEAmYQ1aRCFvRSRrrh3abgpNy0Im5LA3BYiJUILZv2IR
         iKlAnX0TOsqN0jOfXbDZb6DJmL3WuheXJLv44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455610; x=1702060410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=738HwGeAiA3Mv3rj5fZwSn1NgklwgVqxq6lPPHVus6g=;
        b=EtAntF68+McB+4APSTm2plHC18odAgLn40M7SkyvUAFJbpalQBjbS5pmzBDaCtN/lz
         PVjnz9tUbyj6JnGJYuJ7B631qkJUn8InQORwttatf9XQ5NFUFOBLd91Am2CtyWwlRS+F
         9ZeiriVw19UTeOg0lGJDlo1FNDChYBVxRBMjrjvVLC/5TgoZSxd7b7WzULbjX4LXS210
         ymR4rv0z+PF/bnL6U+A7cZCo/pGc58QtleZmXIuIOGiy3IYPKxulHni+NAnIy0CoTX7J
         PYil9q3/JsX5P6jIkjOwzmpqULw1vIwFbPwLYhv3LlP0aYiON3FoPu/9wCRyR/gfXYNl
         DSxQ==
X-Gm-Message-State: AOJu0Yz9GQDKP8wYRq/1EYmavwq/v85PWO0+chSeZFgG/EYNcMWTfa/3
        Gd4VWyKpzWKmp3wrVAgBhmm2NK+QDl/3mmSS5SjHXj1z
X-Google-Smtp-Source: AGHT+IFDKsdJ2zX2uNPbao8GbK5uANWXcS4RSAP8+cBfFecVgusczQZy27E4tr2IdNhGo4SmacmX+w==
X-Received: by 2002:a50:99c3:0:b0:54b:cb6d:48ad with SMTP id n3-20020a5099c3000000b0054bcb6d48admr1436903edb.18.1701455610018;
        Fri, 01 Dec 2023 10:33:30 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id cf5-20020a0564020b8500b0054c4db03b9dsm1006814edb.30.2023.12.01.10.33.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 10:33:29 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so3575e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:33:29 -0800 (PST)
X-Received: by 2002:a05:600c:35d2:b0:40a:4c7d:f300 with SMTP id
 r18-20020a05600c35d200b0040a4c7df300mr234494wmq.6.1701455589264; Fri, 01 Dec
 2023 10:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid>
 <62b7467f-f142-459d-aa23-8bfd70bbe733@rowland.harvard.edu>
In-Reply-To: <62b7467f-f142-459d-aa23-8bfd70bbe733@rowland.harvard.edu>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 Dec 2023 10:32:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VMZGaNdSKAL8o6jtXwmik0aKgO6DdOpe9OvHth9TZf9Q@mail.gmail.com>
Message-ID: <CAD=FV=VMZGaNdSKAL8o6jtXwmik0aKgO6DdOpe9OvHth9TZf9Q@mail.gmail.com>
Subject: Re: [PATCH] usb: core: Save the config when a device is deauthorized+authorized
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon Horman <horms@kernel.org>,
        Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Brian Geffon <bgeffon@google.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Rob Herring <robh@kernel.org>, Roy Luo <royluo@google.com>,
        Stanley Chang <stanley_chang@realtek.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 1, 2023 at 7:59=E2=80=AFAM Alan Stern <stern@rowland.harvard.ed=
u> wrote:
>
> On Thu, Nov 30, 2023 at 03:43:47PM -0800, Douglas Anderson wrote:
> > Right now, when a USB device is deauthorized (by writing 0 to the
> > "authorized" field in sysfs) and then reauthorized (by writing a 1) it
> > loses any configuration it might have had. This is because
> > usb_deauthorize_device() calls:
> >   usb_set_configuration(usb_dev, -1);
> > ...and then usb_authorize_device() calls:
> >   usb_choose_configuration(udev);
> > ...to choose the "best" configuration.
> >
> > This generally works OK and it looks like the above design was chosen
> > on purpose. In commit 93993a0a3e52 ("usb: introduce
> > usb_authorize/deauthorize()") we can see some discussion about keeping
> > the old config but it was decided not to bother since we can't save it
> > for wireless USB anyway. It can be noted that as of commit
> > 1e4c574225cc ("USB: Remove remnants of Wireless USB and UWB") wireless
> > USB is removed anyway, so there's really not a good reason not to keep
> > the old config.
> >
> > Unfortunately, throwing away the old config breaks when something has
> > decided to choose a config other than the normal "best" config.
> > Specifically, it can be noted that as of commit ec51fbd1b8a2 ("r8152:
> > add USB device driver for config selection") that the r8152 driver
> > subclasses the generic USB driver and selects a config other than the
> > one that would have been selected by usb_choose_configuration(). This
> > logic isn't re-run after a deauthorize + authorize and results in the
> > r8152 driver not being re-bound.
> >
> > Let's change things to save the old config when we deauthorize and
> > then restore it when we re-authorize. We'll disable this logic for
> > wireless USB where we re-fetch the descriptor after authorization.
>
> Would it be better to make the r8152 driver override
> usb_choose_configuration()?  This is the sort of thing that subclassing
> is intended for.

Yes, this is a nice solution. Posted.

https://lore.kernel.org/r/20231201183113.343256-1-dianders@chromium.org
