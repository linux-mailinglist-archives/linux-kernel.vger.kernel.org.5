Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03AB7B28C6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjI1XVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 19:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjI1XVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 19:21:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615A91A1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 16:21:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-533e7d127d4so12581972a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695943306; x=1696548106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkQcVwe9M7L9IpIFMavUWzzmZAq1l5yINAWR+c99PmM=;
        b=OvZZ4d+xkBCeUGq4wZ6Tp4N3wmKYMCwjd6BYDrdhEYW+vcLcLNEbAvLBNS1kPITpLp
         AuMSoXRfxWwn3rZxKWfj9V4KmwPqXlrV5fXfVc16lGEHwjfBZAOT95OuXE/MFJMa31Uh
         NWFI5geIp30oE01NGfnhXBv8BvtJ+NJmiDG8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695943306; x=1696548106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkQcVwe9M7L9IpIFMavUWzzmZAq1l5yINAWR+c99PmM=;
        b=IRmD7v2Om5i7Zn40ElySTcolWOBYxMDjfjzmDroZr0Hf2BA/npMhkCjnHpAZPQq45O
         OKKyrnoFhIFopCSk9XLSrVskX7nksB9NLWhHCDQSk9B9Pz1p2HOdA3q0lEXQpTl5/2q6
         f+Rp/4vydCOd0a4qp74ezyBLoCnBhNV+YsqQ39mNhw5HC9qjf7Wngd9x4Nbk+KWMXIFF
         sSzmTrAuL0zweRo2mtqRfP5XpVxL7/wKVxmSoLGxCpYv+wQFdEPAoMtxGbfXFpjUfWWW
         soyJzrqvRy/XlHkTnR3sIe3em1R7WXX15ChdvcgyO0fk2smjFAR3nNEYwnlJ1ah4iNWX
         TCTw==
X-Gm-Message-State: AOJu0YxlrqZVSxaJz5dPwfvyW7RNaYiCOA0zf3gUDgVtZu1O8zlzyHl0
        85IFVeUeS/1Tlew1cv/BwpLtHfGdlV5onM5Gfb8St7cu
X-Google-Smtp-Source: AGHT+IHQGmX52ZCgTgDKVeXuo38R+cGKdLX79Kyhi7KX3Pqhi4Nvh2V+pyGjg3SuaIsPLCI8KGswVA==
X-Received: by 2002:a05:6402:12cf:b0:52e:86b3:a4a6 with SMTP id k15-20020a05640212cf00b0052e86b3a4a6mr2306773edx.29.1695943305867;
        Thu, 28 Sep 2023 16:21:45 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id n9-20020aa7d049000000b0051e0be09297sm10349156edo.53.2023.09.28.16.21.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Sep 2023 16:21:45 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so7437a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 16:21:45 -0700 (PDT)
X-Received: by 2002:ac2:55ac:0:b0:502:d804:38fd with SMTP id
 y12-20020ac255ac000000b00502d80438fdmr280774lfg.0.1695943284350; Thu, 28 Sep
 2023 16:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230921102420.RFC.1.I9dddd99ccdca175e3ceb1b9fa1827df0928c5101@changeid>
 <CAL_Jsq+noP32-m5xdUCLFPFBXLxX9Ys1BNFM+9sga6KYTmDzqQ@mail.gmail.com>
 <CAD=FV=WXxGhX0Fw2nSS7PxYb1O-LUewAhoUVPn=2EpbSD2OeHQ@mail.gmail.com>
 <CAL_JsqKJyRJmwJzB1yew71Ld7BeMMat+rzhX9XtDtiFE8Dbvcw@mail.gmail.com>
 <CAD=FV=UgFzT0TW2WEV0Wmk05EXUad2EYhN2DcckAxE_Lw5gV1Q@mail.gmail.com> <CAL_JsqKK0tjeXNv=a8L3k0AjhCa15XOq1tPWqVod9mycsKXJHg@mail.gmail.com>
In-Reply-To: <CAL_JsqKK0tjeXNv=a8L3k0AjhCa15XOq1tPWqVod9mycsKXJHg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 28 Sep 2023 16:21:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WCg==d=1uuuVrJZb_cqYK76Vw1QVBu5jV+mja15tFoxg@mail.gmail.com>
Message-ID: <CAD=FV=WCg==d=1uuuVrJZb_cqYK76Vw1QVBu5jV+mja15tFoxg@mail.gmail.com>
Subject: Re: [RFC PATCH] of: device: Support 2nd sources of probeable but
 undiscoverable devices
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        andriy.shevchenko@linux.intel.com, broonie@kernel.org,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, james.clark@arm.com, james@equiv.tech,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 28, 2023 at 1:12=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> > > Perhaps then this should be solved in userspace where it can learn
> > > which device is actually present and save that information for
> > > subsequent boots.
> >
> > Yeah, the thought occurred to me as well. I think there are a few
> > problems, though:
> >
> > a) Userspace can't itself probe these devices effectively. While
> > userspace could turn on GPIOs manually and query the i2c bus manually,
> > it can't (I believe) turn on regulators nor can it turn on clocks, if
> > they are needed. About the best userspace could do would be to blindly
> > try binding an existing kernel driver, and in that case why did we
> > need userspace involved anyway?
> >
> > b) While deferring to userspace can work for solutions like ChromeOS
> > or Android where it's easy to ensure the userspace bits are there,
> > it's less appealing as a general solution. I think in Johan's case
> > he's taking a laptop that initially ran Windows and then is trying to
> > run a generic Linux distro on it. For anyone in a similar situation,
> > they'd either need to pick a Linux distro that has the magic userspace
> > bits that are needed or they need to know that, on their laptop, they
> > need to manually install some software. While requiring special
> > userspace might make sense if you've got a special peripheral, like an
> > LTE modem, it makes less sense to need special userspace just to get
> > the right devices bound...
>
> I did not mean do it all in userspace, but for userspace to save off
> what devices are actually present. For example, if userspace has
> access to the dtb, it could just update the dtb to enable the right
> nodes. Then after the first boot, boot time is faster. Or a driver
> could try to load an overlay with the config enabling the right
> devices. Though maybe waiting til userspace is available wouldn't
> speed things up.

At least for the ChromeOS boot flow userspace isn't able to make any
changes to the dtb so I don't think this would help us unless I'm
misunderstanding.


> > Imagine that instead of the hated "hid-over-i2c" compatible we were
> > using two other devices. Imagine that a given board could have a
> > "elan,ekth6915" and a "goodix,gt7375p". Both of these devices have
> > specific timing requirements on how to sequence their supplies and
> > reset GPIOs. For Elan we power on the supplies, wait at least 1 ms,
> > deassert reset, wait at least 300 ms, and then can talk i2c. For
> > Goodix we power on the supply, wait at least 10 ms, deassert reset,
> > wait at least 180 ms, and then can talk i2c. If we had a
> > board-specific probing driver then it would power on the supplies,
> > wait at least 10 ms (the max of the two), deassert reset, wait at
> > least 300 ms (the max of the two), and then see which device talked.
> > Then it would instantiate whichever of the two drivers. This could be
> > done for any two devices that EEs have determined have "compatible"
> > probing sequences.
>
> My point was that in the above example, all these delay times would
> have to be defined in the kernel, not DT.

In the case of using the actual "hid-over-i2c" driver and not one of
the specialized ones, I think we'd still need to put the delay times
in the DT for the individual "hid-over-i2c" nodes, right? The
board-specific driver could still have an implicit delay depending on
the board compatible, but if you set the "hid-over-i2c" node to "okay"
then that driver is going to be expecting to read the delay from DT.
It will use the delay it reads from the DT for powering on after
suspend/resume...


> > Ideally in the above situation we'd be able to avoid turning the
> > device off and on again between the board-specific probe code and the
> > normal driver. That optimization might need special code per-driver
> > but it feels doable by passing some sort of hint to the child driver
> > when it's instantiated.
>
> I think fixing regulators getting turned off on failed probes and
> having a "regulator on time" would go a long way towards providing
> that hint even if the on time was just since clocksource started.

You're suggesting that when a touchscreen fails to probe because it
didn't find the touchscreen on the i2c bus that it should leave its
regulator on? That doesn't seem right to me. While we might find a way
for it to help in the 2nd sourcing case, it doesn't seem right in the
case of a device truly being missing...

I'm also not sure that it truly solves the problem since the power
sequencing of these devices is more than just a regulator but often
involves several regulators being turned on (perhaps with delays in
between) and some enable and/or reset GPIOs. In the case of many
touchscreens the delay needed is actually the delay from after the
reset GPIO is deasserted.

In any case, we can talk more about this in my other response.

-Doug
