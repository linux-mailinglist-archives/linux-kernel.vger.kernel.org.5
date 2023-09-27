Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6317B0FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 01:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjI0Xux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 19:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjI0Xuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 19:50:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B19F5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 16:50:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-991c786369cso1497401166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 16:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695858647; x=1696463447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQOY6tEOrqC0mvJgxPaq1cgtEoQjHgAb4TcKrL7E2Jg=;
        b=fl/ZUkNG9s23Jw+oUuFzzrZc8km9/xByCFgITl6IqKCEBSF5GMl17dthG4aajbRyi2
         klHWp/yhD0K8Ro0lpERYVxEwt+mf3QoW8fJvDL58sKL0xsh29siHbY1oJjcvAB+ZUueB
         z7NhVktb6NrOxcf46Uyz8iZPXuxnrA7d+BABA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695858647; x=1696463447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQOY6tEOrqC0mvJgxPaq1cgtEoQjHgAb4TcKrL7E2Jg=;
        b=YgKJS4zyB7431Zzpdma5+luLwcHpnF+AXT/eiZVLslX2L7KyJiCgdtHpgluqAnA6p6
         ecK9yVZa//CvxqDo/iDA7VAVDNIjigwxTscPIqZfQPGTBZcdmrhZ95fw36FEszyINmV0
         Ix7XV7PHW2Y9r8GvPvhEzp9PVr26z5uDK8HoLDZyyInlK+Nr2nsB35H/nkU3UJx5Xf7D
         7QsrV7qaCoD3uhQtiBeqd+C47PFZMXXbHDkrzGQzQJcx9kpKSktqNeVn39SAJjN4oBvb
         OTbG12QkkA0i1ruxbrYK1HAUOc3y8TsQQuTN68rVQ78+32BBGBzg6xpuqUEC6OQnf+cX
         jDfA==
X-Gm-Message-State: AOJu0YzTX56JycaDbFVvh87848NTh6LxsKpfq2cPuVZ702IuLHC1YiKF
        0NHFJVozeJeThEAtayVdeBSz67HXwoC5HfAs6hiontGC
X-Google-Smtp-Source: AGHT+IEjzyj9Nj8DtCS4vovJhFmwj+yb9vF8dHWRGvka1nbm0/NgXzKgZu3laJ3mRS/4u94C2K+20w==
X-Received: by 2002:a17:907:b1b:b0:9b2:b748:15db with SMTP id h27-20020a1709070b1b00b009b2b74815dbmr2003088ejl.73.1695858647104;
        Wed, 27 Sep 2023 16:50:47 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id h11-20020a170906854b00b0099b8234a9fesm9870239ejy.1.2023.09.27.16.50.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 16:50:47 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53074ee0c2aso4001a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 16:50:47 -0700 (PDT)
X-Received: by 2002:a50:d71d:0:b0:52f:2f32:e76c with SMTP id
 t29-20020a50d71d000000b0052f2f32e76cmr365834edi.2.1695858626384; Wed, 27 Sep
 2023 16:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230921102420.RFC.1.I9dddd99ccdca175e3ceb1b9fa1827df0928c5101@changeid>
 <CAL_Jsq+noP32-m5xdUCLFPFBXLxX9Ys1BNFM+9sga6KYTmDzqQ@mail.gmail.com>
 <CAD=FV=WXxGhX0Fw2nSS7PxYb1O-LUewAhoUVPn=2EpbSD2OeHQ@mail.gmail.com>
 <CAL_JsqKJyRJmwJzB1yew71Ld7BeMMat+rzhX9XtDtiFE8Dbvcw@mail.gmail.com>
 <CAD=FV=UgFzT0TW2WEV0Wmk05EXUad2EYhN2DcckAxE_Lw5gV1Q@mail.gmail.com> <ZROVSAoKF9bimnSP@nixie71>
In-Reply-To: <ZROVSAoKF9bimnSP@nixie71>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Sep 2023 16:50:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UR47x+t37B2+Myv0qvvOJMFxVe-Fj7js=-Ez2GWuDySg@mail.gmail.com>
Message-ID: <CAD=FV=UR47x+t37B2+Myv0qvvOJMFxVe-Fj7js=-Ez2GWuDySg@mail.gmail.com>
Subject: Re: [RFC PATCH] of: device: Support 2nd sources of probeable but
 undiscoverable devices
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        rafael@kernel.org, tglx@linutronix.de
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

On Tue, Sep 26, 2023 at 7:37=E2=80=AFPM Jeff LaBundy <jeff@labundy.com> wro=
te:
>
> Hi Doug,
>
> On Fri, Sep 22, 2023 at 05:11:10PM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Sep 22, 2023 at 12:08=E2=80=AFPM Rob Herring <robh+dt@kernel.or=
g> wrote:
> > >
> > > > > This seems like overkill to me. Do we really need groups and a mu=
tex
> > > > > for each group? Worst case is what? 2-3 groups of 2-3 devices?
> > > > > Instead, what about extending "status" with another value
> > > > > ("fail-needs-probe"? (fail-xxx is a documented value)). Currently=
, the
> > > > > kernel would just ignore nodes with that status. Then we can proc=
ess
> > > > > those nodes separately 1-by-1.
> > > >
> > > > My worry here is that this has the potential to impact boot speed i=
n a
> > > > non-trivial way. While trackpads and touchscreens _are_ probable,
> > > > their probe routines are often quite slow. This is even mentioned i=
n
> > > > Dmitry's initial patches adding async probe to the kernel. See comm=
it
> > > > 765230b5f084 ("driver-core: add asynchronous probing support for
> > > > drivers") where he specifically brings up input devices as examples=
.
>
> Ideally, all but one driver in a group should bail out of probe quickly i=
f
> the device is not populated. If not, I would consider that to be a bug or=
 at
> least room for improvement in that driver.
>
> The reason input devices can take a while to probe is because they may be
> loading FW over I2C or performing some sort of calibration procedure; onl=
y
> one driver in the group should get that far.

Hmm, that's not my experience. Specifically I've seen i2c-hid devices
whose datasheets say that you're not allowed to talk i2c to them at
all for hundreds of milliseconds after you power them on. See, for
instance, "i2c-hid-of-goodix.c" which has a "post_gpio_reset_delay_ms"
of 180 ms and "i2c-hid-of-elan.c" which has one of 300 ms.

As I understand it these touchscreens have firmware on them and that
firmware can take a while to boot. Until the firmware boots they won't
respond over i2c. This is simply not something that Linux can do
anything about.

About the best you could do would be to add a board-specific driver
that understood that it could power up the rails, wait the maximum
amount of time that all possible touchscreens might need, and then
look for i2c ACKs. I'm still hoping to hear from Rob about how I would
get a board-specific driver to load on a DT system so I can
investigate / prototype this.


> > > We could add information on the class of device. touchscreen and
> > > touchpad aliases or something.
> >
> > Ah, I see. So something like "fail-needs-probe-<class>". The
> > touchscreens could have "fail-needs-probe-touchscreen" and the
> > trackpads could have "fail-needs-probe-trackpad" ? That could work. In
> > theory that could fall back to the same solution of grabbing a mutex
> > based on the group ID...
> >
> > Also: if having the mutex in the "struct device" is seen as a bad
> > idea, it would also be easy to remove. __driver_probe_device() could
> > just make a call like "of_device_probe_start()" at the beginning that
> > locks the mutex and then "of_device_probe_end()" that unlocks it. Both
> > of those calls could easily lookup the mutex in a list, which would
> > get rid of the need to store it in the "struct device".
> >
> >
> > > > That would lead me to suggest this:
> > > >
> > > >   &i2c_bus {
> > > >     trackpad-prober {
> > > >       compatible =3D "mt8173-elm-hana-trackpad-prober";
> > > >
> > > >       tp1: trackpad@10 {
> > > >         compatible =3D "hid-over-i2c";
> > > >         reg =3D <0x10>;
> > > >         ...
> > > >         post-power-on-delay-ms =3D <200>;
> > > >       };
> > > >       tp2: trackpad@20 {
> > > >         compatible =3D "hid-over-i2c";
> > > >         reg =3D <0x20>;
> > > >         ...
> > > >         post-power-on-delay-ms =3D <200>;
> > > >       };
> > > >     };
> > > >   };
> > > >
> > > > ...but I suspect that would be insta-NAKed because it's creating a
> > > > completely virtual device ("mt8173-elm-hana-trackpad-prober") in th=
e
> > > > device tree. I don't know if there's something that's functionally
> > > > similar that would be OK?
>
> This solution seems a bit confusing to me, and would require more edits
> to the dts each time a second source is added. It also means one would
> have to write a small platform driver for each group of devices, correct?

No matter what we need to add something to the dts each time a second
source is added, right?

While it's true that we'd end up with some extra drivers, if we do it
correctly we don't necessarily need a driver for each group of devices
nor even a driver per board. If several boards have very similar
probing requirements then, even if they have unique "compatible"
strings they could still end up using the same Linux driver.

I've actually been talking offline with folks on ChromeOS more about
this problem as well. Chen-Yu actually pointed at a patch series (that
never landed, I guess) that has some similar ideas [1]. I guess in
that case Hans was actually constructing device tree properties
manually in the driver. I was thinking more of having all of the
options listed in the device tree and then doing something that only
causes some of them to probe.

If Rob was OK with it, I guess I could have some sort of top-level
"hwmanager" node like Hans did and then have phandle links to all the
hardware that are managed by it. Then I could just change those to
"okay"?

Ideally, though, this could somehow use device tree "overlays" I
guess. That seems like almost a perfect fit. I guess the issue here,
though, is that I'd want the overlays bundled together with the
original DT and then the board-specific "hardware prober" driver to
actually apply the overlays after probing. Does that seem sensible?


[1] https://lore.kernel.org/linux-arm-kernel/20160901190820.21987-1-hdegoed=
e@redhat.com/
