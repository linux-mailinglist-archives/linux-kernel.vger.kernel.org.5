Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68387AD3D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjIYIwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjIYIwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:52:31 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EC8FE;
        Mon, 25 Sep 2023 01:52:24 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5739965a482so3239492eaf.0;
        Mon, 25 Sep 2023 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695631943; x=1696236743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1at5Bwmh4sCDy6jmu2eWw8wOIO0LjytvQnxyA14xNhk=;
        b=GWYDiDzlteRzzgXVbReYuGTddF2bT/fiaX6T+xFT6lwClhNh1SkrRD20H+Rw4AHdhU
         Oy3voHGvHt1i/MMc97WISIUZRrM5ZZftFlhdoS/D/pQku8DPJlwWBjb7qxCNY78KDQ6y
         3p4+dVamIDSUQj2v6xXb5Q99es7CmsAykM4HBxbjTHC0ve9PZoz3VJ3DLhYeul1xF1oQ
         uYBcuS+6ezIkC814s4dt/YHdw7HEFteij4PzKertZ2AoSH059cF2tJuz6HuyRBM/HGJr
         Qt4byMHq/VFo9EjrLi4RYKAl+V9EBPi6RdlPGlPsqyB0/FnSkc8SRa47mgL9eAOT6bYz
         jcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695631943; x=1696236743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1at5Bwmh4sCDy6jmu2eWw8wOIO0LjytvQnxyA14xNhk=;
        b=GX4q4lZyvFrQhM/OI2Jv0Pz+52DwjVeNOYAVeIpLG8Vk2KXVgncjXdhF2q0io5wCby
         M+Zz5WF7bLo9086GOEwW9g1SO3R5u3FMlhPHneXrf1q9q2UuZS+759DjHBOLtAIrUmuD
         /uCi277SUmDNMAQyePy7R6iKKsL8ojvoPqg8nsdLlUgbNeaBvvL0W2EtnAXkF3ZOChHG
         7D6U2Jl+A0Ix0fke4vK85EU0j1M28hurSOC1mveiTnEHmk+iWI5oxZj/YonwkvlqaYPg
         iMN5B9aqd/uQffVzLnKB5ag3jzrXoJkTz7XFlQi6uWpG6f8+d2hd1UR9yju/bwYniQpl
         Gy/w==
X-Gm-Message-State: AOJu0YwN/vgG+lUeGB7tA4bcvTuoC77GIuEzQLYIKEfeShFgbKrvtrKu
        Xw7luus/eInMp96NhUkCo7+leKALdGb13zDGJHvZXVgMUws=
X-Google-Smtp-Source: AGHT+IE7ZzhsO++rPVQqOURjIrUSBvAum8B5hH26XMWfLw/TGilx4XohucuBZF01BZtWYDJTySMQrf1EqcONODk/Rnk=
X-Received: by 2002:a4a:2b02:0:b0:573:70a2:4233 with SMTP id
 i2-20020a4a2b02000000b0057370a24233mr3954867ooa.3.1695631943392; Mon, 25 Sep
 2023 01:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230913214944.59804-1-blarson@amd.com> <20230913214944.59804-7-blarson@amd.com>
 <68ca306c-5ea2-437e-b7f1-68bad88557a0@app.fastmail.com>
In-Reply-To: <68ca306c-5ea2-437e-b7f1-68bad88557a0@app.fastmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Sep 2023 11:51:47 +0300
Message-ID: <CAHp75VdV+2q2_W9buoL-SCO-NkNo2AU1KuiWkFBPDHOhV7b4wA@mail.gmail.com>
Subject: Re: [PATCH v16 6/6] soc: amd: Add support for AMD Pensando SoC Controller
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Brad Larson <blarson@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        linux-spi@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        alcooperx@gmail.com, brendan.higgins@linux.dev,
        Brian Norris <briannorris@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        David Gow <davidgow@google.com>, gsomlo@gmail.com,
        Greg Ungerer <gerg@linux-m68k.org>,
        Hal Feng <hal.feng@starfivetech.com>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Joel Stanley <joel@jms.id.au>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, vaishnav.a@ti.com,
        Walker Chen <walker.chen@starfivetech.com>,
        Will Deacon <will@kernel.org>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 1:24=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Wed, Sep 13, 2023, at 17:49, Brad Larson wrote:

...

> > v15 changes:
> > - Drop custom ioctl and use existing miscdevice interface.
> > - Delete unused definitions in amd-pensando-ctrl.h
> > - Makefile change to compile for ARCH_PENSANDO
>
> Hi Brad,
>
> I'm sorry I've been out of the loop for so long, and I hope
> we can find a way to manage your SoC support soon. My impression
> is that the normal support patches (1, 3, 4, and 5) are largely
> uncontroversial, while the SoC controller support seems like
> we are still not converging onto something that is ready to
> merge, so I would suggest you split the two parts and send
> the basic support for inclusion in linux-6.7 while we continue
> to discuss the soc controller driver.
>
> Please remove any references to the soc controller from the
> dts files and send that first series to:soc@kernel.org
> cc:linux-arm-kernel (and the other interested parties) so
> I can pick those up.
>
> Regarding the soc controller driver, let me try to give
> you my impression of where we are:
>
> - you have gone through 16 revisions already, which is way
>   too much for a public review, we should have been able
>   to find a solution earlier than that, and this is partly
>   our fault on the reviewer side, and I'm sorry about that.
>
> - Andy's latest comments and a lot of the earlier reviews
>   were focused on implementation details. While those comments
>   are helpful suggestions for improving the code, they miss
>   the larger point about the system design that I'm worried
>   about and probably don't help you actually get it merged.

True. The fact that the new versions left the design remaining make me
think that the ABI was settled down.

> - The main problem I still see is that this driver completely
>   bypasses our normal kernel abstractions and instead creates
>   a low-level passthrough interface for handling kernel
>   functionality in userspace. This creates a liability both
>   for the user ABI and the kernel implementation and prevents
>   any
>
> - There is a chance that your design is in fact the
>   best way to handle this particular hardware, but it is
>   your job to write a convincing explanation of why this
>   platform is different from all the others in the patch
>   description. Your current one-paragraph text does not
>   explain this at all.
>
> I would suggest you prioritize getting the other patches
> included for the moment, but we can keep discussion the
> API design for this driver either in this thread or on the
> #armlinux IRC channel (irc.libera.chat) in parallel if you
> like. In order to help you here, I would need either
> the documentation of the SPI software interface, or the
> source code for the userspace tool.



--=20
With Best Regards,
Andy Shevchenko
