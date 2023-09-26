Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E540C7AE994
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 11:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjIZJxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 05:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjIZJw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 05:52:59 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FB0FB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:52:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a645e54806so1016328866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695721969; x=1696326769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahIZ7yuPJ9MJX7623BAJCLqe/mYzgXMdeYKDpf77qm8=;
        b=RRhw4MIaNsa7lpqZyR9xZUVzhdYDe8cp/HzuvyGGewabDF1ac147Q68zo5rFeOPmB0
         ac3z4ePJTw9I6hgCiJjRr6spT+Ps53snysfSHJe1JxaDEuKqLYxD+TRWVAlxGC5joHT+
         zC6II+VEHwhKKjxsuJoHa6VLor1zYVx6HEdZi56+v60O/+CycFtWJUH5eg3806JdhNhV
         S2+GLws9ER0tgsIibRzwraERtKODPYpRwlVTR2OoSjREvAQXagaDv8YE1VhmFV4QNdqw
         KrJFDQbE9sdFxfwo2sTL4tgvslT4eonCHaRGNVknJDMWA4zVGJwnZ8CHnNyjYcjgkvI4
         CEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695721969; x=1696326769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahIZ7yuPJ9MJX7623BAJCLqe/mYzgXMdeYKDpf77qm8=;
        b=OUCV1VdMmqey3GkuzCmHSrF0ajpo0cmLCev67ZoFGRjRKny0Q7nzlN2/wBLvxYLyET
         qCk/h9CnDUWt5jyal79vC9lGgZ6yAsNr93Fo62tLA5/3Ds63LPipf0Rc/OEHvXeo51lz
         gjEKn29sAt85iwTiwp2pBfYbqX7ulP+2bmTwwojESgdjGdCXQKcsPlMk7tdwsXsfFI5w
         a/Dv/sY94fZGOy4Av8gwjiXd/80/q4d1KRROd7laBMZWw8d7JuKU05Awl/4TkxN8KjsA
         xKNxtaT6Auv4xrVXV8GGZB54QPYyzWdxjV+i+ZhVuYLv8z5fc85VkVisG5SvYGjypMr/
         BCxA==
X-Gm-Message-State: AOJu0Yy8lbVDubAiAlu8IszT2vXRQLyOYp6GIolejp3USShJC06T+lzm
        qgJzvD6kCIK6SxBzPBJT7vQ+C0xFqrbmVADWs5R/8Q==
X-Google-Smtp-Source: AGHT+IEgXjQS5acUN/BhQbyuSj3NBsTBC11THgTrSOyiA98EuI4pGo7gQktc2BYq1e2OVHB0VLElJPkrzX9i4MT4k24=
X-Received: by 2002:a17:906:18b1:b0:9ae:6d0:84f7 with SMTP id
 c17-20020a17090618b100b009ae06d084f7mr6942913ejf.32.1695721969517; Tue, 26
 Sep 2023 02:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230919-70b2f1e368a8face73468dfa@fedora> <CAGD2q_anfBP78jck6AbMNtgAggjOgaB3P6dkmq9tONHP45adFA@mail.gmail.com>
 <20230919-cc4646dbfb953bd34e05658c@fedora> <CAGD2q_bkTpvXiomWb_yerNjQfMVKOctYgBqF_RBSo_jYqyyyxw@mail.gmail.com>
 <20230922-unclothed-bottom-5531329f9724@spud> <CAGD2q_YsFdDVhE4JCmQSGMWOdpe_yzG8-CdWYPXtjeZsManvgQ@mail.gmail.com>
 <20230922-removable-footwork-f1d4d96d38dd@spud> <CAGD2q_Y467jJJnwCVH+3F-hh6a-1-OYRugcy0DdjPnTCC77Z8A@mail.gmail.com>
 <20230925-cod-vacancy-08dc8d88f90e@wendy> <CAGD2q_a1nLtFj7H42f+u+J5Bih59MGS0aJLHCFJy5gM2ydys4w@mail.gmail.com>
 <20230926-action-sludge-ec8e51fdd6d4@spud>
In-Reply-To: <20230926-action-sludge-ec8e51fdd6d4@spud>
From:   yang tylor <tylor_yang@himax.corp-partner.google.com>
Date:   Tue, 26 Sep 2023 17:52:39 +0800
Message-ID: <CAGD2q_YBfDT950tyxEF87ZeiANgea_x8S16Ud5K2bcQ+eL9T=w@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 5:02=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Sep 25, 2023 at 06:16:29PM +0800, yang tylor wrote:
> > On Mon, Sep 25, 2023 at 4:41=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > >
> > > On Mon, Sep 25, 2023 at 09:44:21AM +0800, yang tylor wrote:
> > > > On Fri, Sep 22, 2023 at 11:31=E2=80=AFPM Conor Dooley <conor@kernel=
.org> wrote:
> > > > >
> > > > > On Fri, Sep 22, 2023 at 05:43:54PM +0800, yang tylor wrote:
> > > > > > On Fri, Sep 22, 2023 at 5:22=E2=80=AFPM Conor Dooley <conor@ker=
nel.org> wrote:
> > > > > > >
> > > > > > > On Fri, Sep 22, 2023 at 03:56:25PM +0800, yang tylor wrote:
> > > > > > > > On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Conor Dooley <conor=
@kernel.org> wrote:
> > > > > > > > > On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylor wrot=
e:
> > > > > > >
> > > > > > > > > > The behavior of "himax,boot_time_fw_upgrade" seems not =
stable and
> > > > > > > > > > should be removed. "himax,fw_in_flash", I use the kerne=
l config for
> > > > > > > > > > user to select.
> > > > > > > > >
> > > > > > > > > That seems like a bad idea, we want to be able to build o=
ne kernel that
> > > > > > > > > works for all hardware at the same time.
> > > > > > > > >
> > > > > > > > I see, so I should take that back?
> > > > > > > > I'll explain more about it.
> > > > > > >
> > > > > > > Are there particular ICs where the firmware would always be i=
n flash and
> > > > > > > others where it would never be? Or is this a choice made by t=
he board or
> > > > > > > system designer?
> > > > > > >
> > > > > > Most cases it's about the system designer's decision. But some =
ICs may be forced
> > > > > > to use flash because of its architecture(multiple IC inside, ne=
ed to
> > > > > > load firmware to
> > > > > > multiple IC's sram by master IC). But if there is no limitation=
 on
> > > > > > this part, most system
> > > > > > designers will prefer flashless.
> > > > >
> > > > > Forgive me if I am not understanding correctly, there are some IC=
s that
> > > > > will need to load the firmware from flash and there are some wher=
e it
> > > > > will be a decision made by the designer of the board. Is the flas=
h part
> > > > > of the IC or is it an external flash chip?
> > > > >
> > > >
> > > > Both are possible, it depends on the IC type. For TDDI, the IC is l=
ong
> > > > and thin, placed on panel PCB, flash will be located at the externa=
l
> > > > flash chip. For the OLED TP, IC is usually placed at FPC and its fl=
ash
> > > > is embedded, thus the IC size is large compared to TDDI. But from t=
he
> > > > driver's perspective either external flash or embedded flash, the I=
C
> > > > itself will load firmware from flash automatically when reset pin i=
s
> > > > released. Only if firmware is loading from the host storage system,
> > > > the driver needs to operate the IC in detail.
> > >
> > >
> > > Since there are ICs that can use the external flash or have it loaded
> > > from the host, it sounds like you do need a property to differentiate
> > > between those cases.
> > Yep.
> >
> > > Is it sufficient to just set the firmware-name property for these cas=
es?
> > > If the property exists, then you know you need to load firmware & wha=
t
> > > its name is. If it doesn't, then the firmware either isn't needed or
> > > will be automatically loaded from the external flash.
>
> > We have a default prefix firmware name(like himax_xxxx.bin) in the driv=
er code.
>
> How do you intend generating the name of the firmware file? I assume the
> same firmware doesn't work on every IC, so you'll need to pick a
> different one depending on the compatible?
>
If considering a firmware library line-up for all the incoming panels
of this driver.
We would use PID as part of the file name. Because all the support panels w=
ould
have a unique PID associated. Which will make the firmware name like
himax_xxx_{$PID}.bin. The problem is, we need to know PID before firmware l=
oad
at no flash condition. Thus PID information is required in dts when
no-flash-flag
is specified.

> > So we'll look for it when no-flash-flag is specified. In our experience=
,
> > forcing a prefix firmware name helps the user to aware what firmware
> > they are dealing with.

If a more simple solution for no-flash condition is needed, as you mentione=
d,
specifying a firmware name in dts would be the best. Otherwise, a
no-flash-flag and
PID information needs to be added in dts.

Thanks,
Tylor
