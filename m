Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F857BA6DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjJEQmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjJEQkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:40:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F7A6F86
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:31:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50435ad51bbso1515919e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 09:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696523512; x=1697128312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fmpm/y06U0/9riyHMMSe5cH0ucZInbAT/vXKTDHZnrc=;
        b=UBVl0WIvvp9UJQqfrp5NwP8PggszHWeWmgvqz79jMrl5wM0BQw3y3uUa563ChtEeB1
         47cApKlLXqEmIJwMbDqZMYKG7Arke1wwY3TJ4A2NO22MVeimdG+JgMQ85HmQq3YAWZ4T
         WtuWENurfx036e/U0VqPzY5K8IqF9xlGs9S5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696523512; x=1697128312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fmpm/y06U0/9riyHMMSe5cH0ucZInbAT/vXKTDHZnrc=;
        b=gAhb/5BhKO+JjXLwXDQaYc7Y2JHv+jQeX7BLmFNO0Lp8sXHbtAC1rlKRsmwoFfbeXx
         SwwUWdLw0cPXwDe+9MvytziARI7i59XSJMxSZ8uwk7wkL2T9/P1DoVavgDTCCgjARq1r
         GDXugLfUvACIc0vsbeqQ6W1zg8goKsurkdMbUZXljYzOqXDJoDnsyDAqc9VD4iC5MYka
         31nMno0ashu3XXfSAqdFcM/5zvsFvwNIW8n+rSOAIJOhaDCz8P2+p8Dy6dji+2zCD4I2
         hY+7MuwrzHWczAHfwuIVp1HNITcFAgqCDt6cDW5qFRxdKQqOnUFwGdSqg7tDMDHJ6YMQ
         oeKQ==
X-Gm-Message-State: AOJu0YwaUEnH2JgEhACGvL0x0VIf2KPQ2B/Hv/cKU9YFvwhYb23dGbMG
        0XkrdL0u9wzPCtZbawhAb8kaUA/xDoQUDaCtAoqrwhyu
X-Google-Smtp-Source: AGHT+IFs4ymSMo+MASjGHevR3zmFGxmd+HV0pHQK2fdhAO0V18mE0Ogg+dGlk0NfAWn8+NIq5kqmlA==
X-Received: by 2002:a05:6512:2821:b0:502:f2a8:d391 with SMTP id cf33-20020a056512282100b00502f2a8d391mr7372280lfb.45.1696523511948;
        Thu, 05 Oct 2023 09:31:51 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id f26-20020ac2533a000000b0050567350d90sm361578lfh.109.2023.10.05.09.31.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 09:31:51 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5032a508e74so5032e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 09:31:51 -0700 (PDT)
X-Received: by 2002:ac2:558c:0:b0:502:cdb6:f316 with SMTP id
 v12-20020ac2558c000000b00502cdb6f316mr38425lfg.3.1696523510776; Thu, 05 Oct
 2023 09:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20231002155857.24584-1-johan+linaro@kernel.org> <cnnjghxj4od6fniotztlgorc7myzya2bsvixkf2cpk4metcipa@r2w2ouob5ths>
In-Reply-To: <cnnjghxj4od6fniotztlgorc7myzya2bsvixkf2cpk4metcipa@r2w2ouob5ths>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Oct 2023 09:31:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wx2m2qgQwY7Od4T__SzC4zZ9Txr4D553+XmLGEaT15rA@mail.gmail.com>
Message-ID: <CAD=FV=Wx2m2qgQwY7Od4T__SzC4zZ9Txr4D553+XmLGEaT15rA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: fix handling of unpopulated devices
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 5, 2023 at 12:10=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> On Oct 02 2023, Johan Hovold wrote:
> > A recent commit reordered probe so that the interrupt line is now
> > requested before making sure that the device exists.
> >
> > This breaks machines like the Lenovo ThinkPad X13s which rely on the
> > HID driver to probe second-source devices and only register the variant
> > that is actually populated. Specifically, the interrupt line may now
> > already be (temporarily) claimed when doing asynchronous probing of the
> > touchpad:
> >
> >       genirq: Flags mismatch irq 191. 00082008 (hid-over-i2c) vs. 00082=
008 (hid-over-i2c)
> >       i2c_hid_of 21-0015: Could not register for hid-over-i2c interrupt=
, irq =3D 191, ret =3D -16
> >       i2c_hid_of: probe of 21-0015 failed with error -16
> >
> > Fix this by restoring the old behaviour of first making sure the device
> > exists before requesting the interrupt line.
> >
> > Note that something like this should probably be implemented also for
> > "panel followers", whose actual probe is currently effectively deferred
> > until the DRM panel is probed (e.g. by powering down the device after
> > making sure it exists and only then register it as a follower).
> >
> > Fixes: 675cd877c952 ("HID: i2c-hid: Rearrange probe() to power things u=
p later")
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >
> > Changes in v2
> >  - initialise ihid->is_panel_follower sooner to avoid repeated property
> >    lookups and so that it can be used consistently throughout the drive=
r
> >    for code that differs for "panel followers"
>
> Patches looks good to me, but I can not test it unfortunately.
>
> Doug, would you mind sending us your Ack or tested-by?

Sure. Patches look OK to me, so if you're good with them then I'm good
with them too.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I tested this on a board by adding a second i2c-hid device in the
device tree and confirming that things appeared to work OK. I also
tried this with a board setup to use panel-follower (but _not_ two
sources of touchscreens) and that also worked OK. Thus:

Tested-by: Douglas Anderson <dianders@chromium.org>

As expected, combining panel-follower with two sources of touchscreen
_didn't_ work because only one of them is able to acquire the
interrupt. This is fine with me as there is nobody currently doing
that. I'm still of the belief that we need a more complete solution
for that and I'll continue to work on it.

Thanks!

-Doug
