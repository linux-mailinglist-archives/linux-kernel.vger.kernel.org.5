Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92A07C7B88
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjJMCP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjJMCP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:15:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFF3BB
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:15:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405361bb9f7so17339035e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697163324; x=1697768124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=479sT2wXZ3lF8ZnjGHtr1v6duycKwjupuTdioRmVjBQ=;
        b=gJAtSS4rsORc76dR2jDaa4rHv4A8CgHZRqOVwnrCkuyVR60kwpSVnAgpibIQZ/X3Wc
         yEUUHLs9RcWzIvqQSJw9EbYEb3ZT6oQNV2CB2t2RjGWLBwT2hE2JkjUpeUS8e7QYLTKc
         TeevjP/OIBeeq5tr7+BWlAoaptjbu48lJtsILKUW74UIi3aOb+tgVTatZM9epxtdgiVx
         CoZ5fDq67eCP3V8+AoPz5f2x9VVnZlH/aaHJv2mb0P+RULbzozHSN0AooSzukmWJA3Cp
         0aXlCSzPZ83Teu9EcdNnkERYoB2PKKp45WS1TpIlOmvkmFmqfP6mlskl5G1IOcXzzNzu
         h2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697163324; x=1697768124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=479sT2wXZ3lF8ZnjGHtr1v6duycKwjupuTdioRmVjBQ=;
        b=WcAPpGWalV/ge/bZhcLHwg5ODKG5QPpVuzUk6Zn9Gsy2yi/hJKRbzr/ikHJa+NfRWx
         lD4UqYnNk1phvUYUKCqcrDIFs0aimX7BCDmxGNoICDCkghjTi52EuIzh8b63p2os3DzR
         Ao31kUtmwZwaMEtDXw6icgmTvmUfTaQxyGsfTgbHShEV3CR8qLvLWRDUbYNHtk3zDEia
         BekSsWwqvCht1FVueND71h2ieU2RIIXTFLXG8CE3vR+kQc67zvlCCjuWxHHXlTO1j/25
         YMolDTm2foEh1TDaKW8imdDD8kXAVOS5eIinl8+ghriznX/eCBz+T9oZ5aEfCWc18Cv+
         eOLQ==
X-Gm-Message-State: AOJu0YwvmazrIhlrgO1CGzAh7rkjcXU6o7/Yox8R/nFA2qpmjK5c6u2W
        OBqW163MqYDJsl2VMfv3PsFeItg60YerNKI07Xga1Q==
X-Google-Smtp-Source: AGHT+IFhpyBP7U/5sPsuSV3WRb3/V3m+DTQDPdPSdTYu6ljAIoR+ANHbmo+h3/cwZ/iAOsdX96X0bgvSpXAcCKHMEck=
X-Received: by 2002:adf:f4c5:0:b0:32d:9585:8680 with SMTP id
 h5-20020adff4c5000000b0032d95858680mr2180378wrp.4.1697163323265; Thu, 12 Oct
 2023 19:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230925-cod-vacancy-08dc8d88f90e@wendy> <CAGD2q_a1nLtFj7H42f+u+J5Bih59MGS0aJLHCFJy5gM2ydys4w@mail.gmail.com>
 <20230926-action-sludge-ec8e51fdd6d4@spud> <CAGD2q_YBfDT950tyxEF87ZeiANgea_x8S16Ud5K2bcQ+eL9T=w@mail.gmail.com>
 <20230926-reverence-unlit-d0027225cc43@spud> <CAGD2q_ZzNPOL+Mhg7aWFTQd+UJJYVLz1ZE9hbNb0roS2M6y34g@mail.gmail.com>
 <20230928-spectacle-civic-339c0d71d8d7@spud> <CAGD2q_b1gn8XAfgfzuNn3Jo6gEguBEacxERyRM5ms-V=+hWS+g@mail.gmail.com>
 <20231009-pentagram-clamshell-b14ff00743fd@spud> <CAGD2q_aqr+mu4K1SkTVC+65ctL6BsqRP4Ld0HD_H0_rgzFT9MQ@mail.gmail.com>
 <20231012-pope-denatured-c1898bc1e44b@spud>
In-Reply-To: <20231012-pope-denatured-c1898bc1e44b@spud>
From:   yang tylor <tylor_yang@himax.corp-partner.google.com>
Date:   Fri, 13 Oct 2023 10:15:13 +0800
Message-ID: <CAGD2q_YKJyLn8q1F661kRRpZtCtN4w46+mdh2Fq9rkfQ78ssOA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: input: Introduce Himax HID-over-SPI device
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
        "jingyliang@chromium.org" <jingyliang@chromium.org>,
        wuxy23@lenovo.com, luolm1@lenovo.com,
        hung poyu <poyu_hung@himax.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 11:24=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Thu, Oct 12, 2023 at 10:30:03AM +0800, yang tylor wrote:
> > On Tue, Oct 10, 2023 at 1:52=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Mon, Oct 02, 2023 at 06:44:41PM +0800, yang tylor wrote:
> > > > On Fri, Sep 29, 2023 at 12:56=E2=80=AFAM Conor Dooley <conor@kernel=
.org> wrote:
> > > > >
> > > > > On Thu, Sep 28, 2023 at 10:12:41AM +0800, yang tylor wrote:
> > > > > > On Tue, Sep 26, 2023 at 8:53=E2=80=AFPM Conor Dooley <conor@ker=
nel.org> wrote:
> > > > > > > On Tue, Sep 26, 2023 at 05:52:39PM +0800, yang tylor wrote:
> > > > > > > > On Tue, Sep 26, 2023 at 5:02=E2=80=AFPM Conor Dooley <conor=
@kernel.org> wrote:
> > > > > > > > > On Mon, Sep 25, 2023 at 06:16:29PM +0800, yang tylor wrot=
e:
> > > > > > > > > > On Mon, Sep 25, 2023 at 4:41=E2=80=AFPM Conor Dooley <c=
onor.dooley@microchip.com> wrote:
> > > > > > > > > > We have a default prefix firmware name(like himax_xxxx.=
bin) in the driver code.
> > > > > > > > >
> > > > > > > > > How do you intend generating the name of the firmware fil=
e? I assume the
> > > > > > > > > same firmware doesn't work on every IC, so you'll need to=
 pick a
> > > > > > > > > different one depending on the compatible?
> > > > > > > > >
> > > > > > > > If considering a firmware library line-up for all the incom=
ing panels
> > > > > > > > of this driver.
> > > > > > > > We would use PID as part of the file name. Because all the =
support panels would
> > > > > > > > have a unique PID associated. Which will make the firmware =
name like
> > > > > > > > himax_xxx_{$PID}.bin. The problem is, we need to know PID b=
efore firmware load
> > > > > > > > at no flash condition. Thus PID information is required in =
dts when
> > > > > > > > no-flash-flag
> > > > > > > > is specified.
> > > > > > >
> > > > > > > Firstly, where does the "xxx" come from?
> > > > > > > And you're making it sound more like having firmware-name is =
suitable
> > > > > > > for this use case, given you need to determine the name of th=
e file to
> > > > > > > use based on something that is hardware specific but is not
> > > > > > > dynamically detectable.
> > > > > > Current driver patch uses a prefix name "himax_i2chid" which co=
mes
> > > > > > from the previous project
> > > > > >  and seems not suitable for this condition, so I use "xxx" and =
plan to
> > > > > > replace it in the next version.
> > > > > > For finding firmware, I think both solutions are reasonable.
> > > > > > - provide firmware name directly: implies no-flash and use user
> > > > > > specified firmware, no PID info.
> > > > > > - provide no-flash-flag and PID info: loading firmware from org=
anized
> > > > > > names with PID info.
> > > > > > I prefer the 2nd solution, but it needs more properties in dts.=
 1st
> > > > > > has less properties and more
> > > > > > intuitive.
> > > > > >
> > > > > > I don't know which one is more acceptable by the community, as =
you
> > > > > > know I'm a newbie here.
> > > > >
> > > > > To be honest, I am not all that sure either! Does the panel id ha=
ve
> > > > > value in its own right, or is that only used to determine the fir=
mware
> > > > > filename?
> > > > Currently, PID stands for Panel/Project ID and is used for determin=
ing
> > > > the firmware filename only. We haven't come up with any new attribu=
te that
> > > > may attach to it. The differences between panels are handled in fir=
mware
> > > > dedicated to its PID.
> > > >
> > > > > Also, if it does have value in its own right, rather than a "pid"=
,
> > > > > should the panel be a child node of this hid device with its own
> > > > > compatible?
> > > > It may need a child node if we find it necessary to add attributes =
to each PID.
> > > > But currently we have no idea about it.
> > >
> > > To be honest, it seems to me like you are using "PID" in place of a
> > > compatible for the panel, since it needs to be provided via DT anyway=
.
> >
> > Hmm... So the more formal way is?
> > If I add a sub-note inside this spi-device block, such as "panel" and
> > add PID inside.
> > Will it be more appropriate?
> > ...
> > spi {
> > ...
> >     hx_spi@0 {
> > ...
> >         panel {
> >             himax,pid =3D ...
>
> And this now looks exactly like compatible =3D "vendor,part" now, no?

I think it's not the same, I thought "compatible" is used to target
from the driver side.
For finding other information inside the block. But I just store PID
information in this
one, not used for targeting but getting infos from it.

Thanks,
Tylor
