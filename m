Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0337B10AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjI1CM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI1CMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:12:54 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA8DAC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 19:12:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405361bb9cdso126038595e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 19:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695867171; x=1696471971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKZRe/GZV/iQCUofnVyQt/z8LYx3Pf2DFuz6RSVBq38=;
        b=0lJGkrLPMaXMlFY8g89vfWf9ueJD03EhIiiqQRAqSk9/ji4vvY1XqKrMWjnXTX8xy7
         5DSWnXXz6X9WqEymrnCZsWWiJwBeAXlQtECAHm3Y62G90YkCRVOtWclYU6/YYRmrkpnm
         eLrMTPjCEpAeutbJc1lMImAUBt3HkIsnLqjrXYSwUagz9EDz25LytGJObVCr7feaNqHj
         h4SfbYwPH3TEkOHqGuxrxxc3Jxjflzd8MDxV3/VIshzszDE3/0oV8eYjdqAZgruwiwzA
         LuX3NpgnzRX/hGJ6kvDWnapEWgWqBjz78VQK40MsEY4NENvGXwAgjLkF7a/2ruqS1eqf
         HpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695867171; x=1696471971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kKZRe/GZV/iQCUofnVyQt/z8LYx3Pf2DFuz6RSVBq38=;
        b=H0EpuABT8fxmihs4WtN9GGbDeEFGg9XdYQ2Dwv04hF+GmZAN5aJy2/w8J4xHLqJnZD
         KCJ4mhQ6jLhqMqwSUzg2lOlxPAZ3vj1aPEqr8Q/uLqPG9/5XToDDNwqcr20TgYt5qmzb
         0JjnA+ydhZ/WEijoAbS51YKTE4M7OWZBu3EK9UWB6e+lLiZg9PY/Nkrr2NfiW5UXDK+U
         RG+QnhEUe6SXXGEIYzWMp6oYfOmT6vhU75utBSSS+PpCXfkYIhMfhuDQgWvVi1XfQVdj
         VIccFvTbGoM6BZLQI58Gz6jLWPIDxDqpKPxYUcnCMy/bSn0OeINq7ZreAXjcKJ5diLqN
         kUbQ==
X-Gm-Message-State: AOJu0YxQJtalXD//BQPdMZUfu7EAVJMabcQ4Lzq6NAbngtAsZPKEMbub
        Cdg3n1tdBunUXh57S3DBebrIoq4WAZ345zbm5M8Au8DM+oGkoQBa
X-Google-Smtp-Source: AGHT+IEMv+Xy4MV7QczSeD1RKvQAMX8lQaX7KPMiwGeyLFZkBRuoVIs5f9huGJCKsgim33SeJFTH6rjd9PQnuyh8rbo=
X-Received: by 2002:adf:e60b:0:b0:314:3e77:f210 with SMTP id
 p11-20020adfe60b000000b003143e77f210mr3284677wrm.59.1695867171521; Wed, 27
 Sep 2023 19:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230919-cc4646dbfb953bd34e05658c@fedora> <CAGD2q_bkTpvXiomWb_yerNjQfMVKOctYgBqF_RBSo_jYqyyyxw@mail.gmail.com>
 <20230922-unclothed-bottom-5531329f9724@spud> <CAGD2q_YsFdDVhE4JCmQSGMWOdpe_yzG8-CdWYPXtjeZsManvgQ@mail.gmail.com>
 <20230922-removable-footwork-f1d4d96d38dd@spud> <CAGD2q_Y467jJJnwCVH+3F-hh6a-1-OYRugcy0DdjPnTCC77Z8A@mail.gmail.com>
 <20230925-cod-vacancy-08dc8d88f90e@wendy> <CAGD2q_a1nLtFj7H42f+u+J5Bih59MGS0aJLHCFJy5gM2ydys4w@mail.gmail.com>
 <20230926-action-sludge-ec8e51fdd6d4@spud> <CAGD2q_YBfDT950tyxEF87ZeiANgea_x8S16Ud5K2bcQ+eL9T=w@mail.gmail.com>
 <20230926-reverence-unlit-d0027225cc43@spud>
In-Reply-To: <20230926-reverence-unlit-d0027225cc43@spud>
From:   yang tylor <tylor_yang@himax.corp-partner.google.com>
Date:   Thu, 28 Sep 2023 10:12:41 +0800
Message-ID: <CAGD2q_ZzNPOL+Mhg7aWFTQd+UJJYVLz1ZE9hbNb0roS2M6y34g@mail.gmail.com>
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 8:53=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Sep 26, 2023 at 05:52:39PM +0800, yang tylor wrote:
> > On Tue, Sep 26, 2023 at 5:02=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Mon, Sep 25, 2023 at 06:16:29PM +0800, yang tylor wrote:
> > > > On Mon, Sep 25, 2023 at 4:41=E2=80=AFPM Conor Dooley <conor.dooley@=
microchip.com> wrote:
> > > > >
> > > > > On Mon, Sep 25, 2023 at 09:44:21AM +0800, yang tylor wrote:
> > > > > > On Fri, Sep 22, 2023 at 11:31=E2=80=AFPM Conor Dooley <conor@ke=
rnel.org> wrote:
> > > > > > >
> > > > > > > On Fri, Sep 22, 2023 at 05:43:54PM +0800, yang tylor wrote:
> > > > > > > > On Fri, Sep 22, 2023 at 5:22=E2=80=AFPM Conor Dooley <conor=
@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Sep 22, 2023 at 03:56:25PM +0800, yang tylor wrot=
e:
> > > > > > > > > > On Tue, Sep 19, 2023 at 7:09=E2=80=AFPM Conor Dooley <c=
onor@kernel.org> wrote:
> > > > > > > > > > > On Tue, Sep 19, 2023 at 05:31:29PM +0800, yang tylor =
wrote:
> > > > > > > > >
> > > > > > > > > > > > The behavior of "himax,boot_time_fw_upgrade" seems =
not stable and
> > > > > > > > > > > > should be removed. "himax,fw_in_flash", I use the k=
ernel config for
> > > > > > > > > > > > user to select.
> > > > > > > > > > >
> > > > > > > > > > > That seems like a bad idea, we want to be able to bui=
ld one kernel that
> > > > > > > > > > > works for all hardware at the same time.
> > > > > > > > > > >
> > > > > > > > > > I see, so I should take that back?
> > > > > > > > > > I'll explain more about it.
> > > > > > > > >
> > > > > > > > > Are there particular ICs where the firmware would always =
be in flash and
> > > > > > > > > others where it would never be? Or is this a choice made =
by the board or
> > > > > > > > > system designer?
> > > > > > > > >
> > > > > > > > Most cases it's about the system designer's decision. But s=
ome ICs may be forced
> > > > > > > > to use flash because of its architecture(multiple IC inside=
, need to
> > > > > > > > load firmware to
> > > > > > > > multiple IC's sram by master IC). But if there is no limita=
tion on
> > > > > > > > this part, most system
> > > > > > > > designers will prefer flashless.
> > > > > > >
> > > > > > > Forgive me if I am not understanding correctly, there are som=
e ICs that
> > > > > > > will need to load the firmware from flash and there are some =
where it
> > > > > > > will be a decision made by the designer of the board. Is the =
flash part
> > > > > > > of the IC or is it an external flash chip?
> > > > > > >
> > > > > >
> > > > > > Both are possible, it depends on the IC type. For TDDI, the IC =
is long
> > > > > > and thin, placed on panel PCB, flash will be located at the ext=
ernal
> > > > > > flash chip. For the OLED TP, IC is usually placed at FPC and it=
s flash
> > > > > > is embedded, thus the IC size is large compared to TDDI. But fr=
om the
> > > > > > driver's perspective either external flash or embedded flash, t=
he IC
> > > > > > itself will load firmware from flash automatically when reset p=
in is
> > > > > > released. Only if firmware is loading from the host storage sys=
tem,
> > > > > > the driver needs to operate the IC in detail.
> > > > >
> > > > >
> > > > > Since there are ICs that can use the external flash or have it lo=
aded
> > > > > from the host, it sounds like you do need a property to different=
iate
> > > > > between those cases.
> > > > Yep.
> > > >
> > > > > Is it sufficient to just set the firmware-name property for these=
 cases?
> > > > > If the property exists, then you know you need to load firmware &=
 what
> > > > > its name is. If it doesn't, then the firmware either isn't needed=
 or
> > > > > will be automatically loaded from the external flash.
> > >
> > > > We have a default prefix firmware name(like himax_xxxx.bin) in the =
driver code.
> > >
> > > How do you intend generating the name of the firmware file? I assume =
the
> > > same firmware doesn't work on every IC, so you'll need to pick a
> > > different one depending on the compatible?
> > >
> > If considering a firmware library line-up for all the incoming panels
> > of this driver.
> > We would use PID as part of the file name. Because all the support pane=
ls would
> > have a unique PID associated. Which will make the firmware name like
> > himax_xxx_{$PID}.bin. The problem is, we need to know PID before firmwa=
re load
> > at no flash condition. Thus PID information is required in dts when
> > no-flash-flag
> > is specified.
>
> Firstly, where does the "xxx" come from?
> And you're making it sound more like having firmware-name is suitable
> for this use case, given you need to determine the name of the file to
> use based on something that is hardware specific but is not
> dynamically detectable.
Current driver patch uses a prefix name "himax_i2chid" which comes
from the previous project
 and seems not suitable for this condition, so I use "xxx" and plan to
replace it in the next version.
For finding firmware, I think both solutions are reasonable.
- provide firmware name directly: implies no-flash and use user
specified firmware, no PID info.
- provide no-flash-flag and PID info: loading firmware from organized
names with PID info.
I prefer the 2nd solution, but it needs more properties in dts. 1st
has less properties and more
intuitive.

I don't know which one is more acceptable by the community, as you
know I'm a newbie here.

Thanks,
Tylor
