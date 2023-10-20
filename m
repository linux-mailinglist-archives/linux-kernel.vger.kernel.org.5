Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F057D1363
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377840AbjJTQAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377827AbjJTQAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:00:02 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22813D7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:00:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9c2a0725825so152255566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697817598; x=1698422398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/hb65rqGn/L+bqKuL2ueokcLD6OZN5u11ra2F8eMBc=;
        b=FZL4dIzBnJXKvoL3ec8cAMkeAUHu2IlgO46wAQoO42cyPZ1E5+aQYFd2A9SEykYWR+
         Tv0ysRlyxJFze2RbnhjQOqGaLJdMPkbQVWOTQBJN5+/GDB2fSg/5KfU60b/s+hi0iOZ7
         qkXrgA+QdqALAbWB0QZWPGu+KUaM0Mob/bpHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697817598; x=1698422398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/hb65rqGn/L+bqKuL2ueokcLD6OZN5u11ra2F8eMBc=;
        b=Tz1x2LuR28ZT6/kFpHyXJ1AMyi/2jv83H6M04Fu76RJM33/sRu9XK+k7duhGJGeJrN
         tjd3Mj0TAz0JPUaRV7nniQ6qQIs83bU3HB20xyd1610KQMVCG0XANLD0AHu9lboAlMFc
         ksdQ8CJxeBw8+gAqWtVPUdBTKdh8XYVuzE7yEKl1AzGoWnF8bK093MKWbSk0+51cW2ZO
         JeNdFxckSxVSJN0wpRBBmRkcZz+NGP2gasaCRSq/3xzl3TjR1LMRybsDrr+qjiBQgIBi
         lXvQ/F6k2P5xVLDfAsrQ/eaF7Ika4J2/8ZBXKBl5ZKSTGtrd1rkK266Mdr7LNopJ1Z0u
         PUjw==
X-Gm-Message-State: AOJu0Yw3WlgLQxzUyek2fs8JiI7tYQCEFLDRYaTw+cGtNqtWqKddTzkN
        NTy+LW8ThRD8c8zkUN/85H3Nlw6vTn7WsRtlOoEyolrW
X-Google-Smtp-Source: AGHT+IHbTxNn5hQOBVIEknqXJmsg+tJnGGjWjX63v/4o9aB0QLj2h2GCnsYJsydT7PeSSZXNUlqUuA==
X-Received: by 2002:a17:907:9282:b0:9ae:5120:5147 with SMTP id bw2-20020a170907928200b009ae51205147mr1659889ejc.38.1697817598658;
        Fri, 20 Oct 2023 08:59:58 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id rh8-20020a17090720e800b009930308425csm1728791ejb.31.2023.10.20.08.59.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:59:58 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40662119cd0so79715e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:59:58 -0700 (PDT)
X-Received: by 2002:a1c:6a1a:0:b0:405:320a:44f9 with SMTP id
 f26-20020a1c6a1a000000b00405320a44f9mr120847wmc.5.1697817598277; Fri, 20 Oct
 2023 08:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231020083125.1.I3e5f7abcbf6f08d392e31a5826b7f234df662276@changeid>
 <60a358c9-b44b-4d25-9a20-aa9e00c65ab6@rowland.harvard.edu>
In-Reply-To: <60a358c9-b44b-4d25-9a20-aa9e00c65ab6@rowland.harvard.edu>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Oct 2023 08:59:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VQ22p7iDdzK-CXOBEqpu0b3J=LKRZuPcajQWFUmr=1cA@mail.gmail.com>
Message-ID: <CAD=FV=VQ22p7iDdzK-CXOBEqpu0b3J=LKRZuPcajQWFUmr=1cA@mail.gmail.com>
Subject: Re: [PATCH] usb: core: Prevent infinite loops when usb_reset_device() unbinds/binds
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        Hayes Wang <hayeswang@realtek.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ray Chi <raychi@google.com>,
        =?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>,
        Rob Herring <robh@kernel.org>, Roy Luo <royluo@google.com>,
        Stanley Chang <stanley_chang@realtek.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Oct 20, 2023 at 8:46=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Fri, Oct 20, 2023 at 08:31:38AM -0700, Douglas Anderson wrote:
> > When we call usb_reset_device() and a driver doesn't implement
> > pre_reset() and post_reset() methods then the USB core will attempt to
> > unbind and rebind the driver in order to make reset work. This is a
> > great general solution, but it has the potential to loop forever.
> > Specifically, if the USB device is in a state that the USB device
> > driver issues another usb_reset_device() after each rebind then we'll
> > just continually unbind and rebind with no end.
> >
> > It's difficult to address this condition in a USB device driver
> > because it's hard for the driver to keep state across each
> > unbind/bind.
>
> How about just adding appropriate pre_reset() and post_reset() methods?
> This is precisely what they are meant for.  Then the the unbind/rebind
> loop wouldn't ever get started.

Right, and we have pre_reset() and post_reset() in the r1852 driver.
The issue is that we are seeing occasional control transfer errors
while the r8152 driver is still running its probe() routine and we
want to reset in response to those. It is relatively difficult to have
the pre_reset() and post_reset() methods work properly if failures
happen and probe() hasn't finished yet. The current proposal I have
for the r8152 driver is to have the pre_reset() routine return -EIO if
we saw errors during probe, which tells the USB core to unbind/rebind
us. This gets us to a known good state. If we need to do a reset later
on (after probe finished successfully) then pre_reset() and
post_reset() can avoid the unbind/bind.

The worry was that this could cause an infinite loop. Hence this patch. ;-)

-Doug
