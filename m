Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF847CD859
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjJRJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjJRJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:38:24 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425E5FE;
        Wed, 18 Oct 2023 02:38:22 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3b2e330033fso695347b6e.3;
        Wed, 18 Oct 2023 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697621901; x=1698226701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0u5M0ZZhwkKU2GcONxNDgJGLpFlS78x5vh9a4iVf20=;
        b=UTdQgE0Q4H9+ALZhcuXbgbiPk90FNYgDyEfm83zO1nN8v4Lv2SExlhzCTWp1Xom+EC
         7gEXBzkZjk7gZ1cliYV5fDascYF+YVeDFKuwl3WnA1G7fFo1Haz/QuPET6PUKB7L+GX7
         LjthbF4f7w0d9YiTTzrqseinrMdI81c+jYwV+g5dGJjVfWBnUdqszNZGVY7D0qE3ST0C
         dUVnOkQ06XJKCV3/06TBD5MdDbOzwvY9OK3jn3pQK2TKoRmCIMFXkGRsPnc7XWfYEAH+
         F1CRZ5PFuGTxlkD2qwRe8y6YB3FUqYONuY3pjVsz8n1HRug3gfhp6i6xZTtwHmQoIJ/K
         gbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621901; x=1698226701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0u5M0ZZhwkKU2GcONxNDgJGLpFlS78x5vh9a4iVf20=;
        b=P3G5C8WvqWcWTg7T9MLU31KrGeVq6Z8gk3iNoUtN/bFmeWB/F/TPokoIwnB9IbTkwm
         bztsVrp369JvEfKHE4jtHnmMZ0SBSYAk5RMzVssOSPEIWw/ISTtjf3BXPVA9MIQKS2IL
         Sj4w+6Ohx3RXEiXhvdGs0lTxOab/pq66SM111OLxfx8VLnbllwFkiNl6d5SE1T3nS+S8
         8kDMJiGlKZZAwxYosvicEVF0w46nHNd9nqkwYqyY46AD6byZm5OToVvqF/9UU3YrEYXt
         chEcNNFdFd31ZodpS58czcxPQZrdwu/ANAraRicGJ0mWUjyE25kaVHXHdDdLDHRUAY6l
         2qgQ==
X-Gm-Message-State: AOJu0YwJaebhE7t30KvVDobBkRRMXzu0gwOWkzjDFgEFxD5Ec4QkQI+o
        v24VaiEQ1F/BqV8Cu1JuMDqKhbGLMRrw7FYk0Hg=
X-Google-Smtp-Source: AGHT+IET6I6U2ZetmcYDU8PeKz3wTlsYrjNzxkrKoO78zeiACo2nJCvz8TEl23PVIF08u/xNfL1SmvquKj7To0reTAM=
X-Received: by 2002:a05:6808:7c9:b0:3a8:29a9:e4d0 with SMTP id
 f9-20020a05680807c900b003a829a9e4d0mr5297729oij.34.1697621901480; Wed, 18 Oct
 2023 02:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org> <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org> <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org> <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <86wmxcejav.wl-maz@kernel.org> <c7898abf-34ca-d0b4-fd0c-935100dcd3f2@flygoat.com>
 <86pm2ye2si.wl-maz@kernel.org> <CAMpQs4LjePLy5RFMz2S=1sa9Zme_UrJmKKRog0LAg_ZhA07TMA@mail.gmail.com>
 <CAOiHx=mq3hw-LFerb9UzU7VSnLypnvPuo1GomCnN=p0u3xN1Ug@mail.gmail.com> <CAMpQs4+neiaJKp93UcemJbPPbhmf1B7WYNqKh=qx0avrbwW2cQ@mail.gmail.com>
In-Reply-To: <CAMpQs4+neiaJKp93UcemJbPPbhmf1B7WYNqKh=qx0avrbwW2cQ@mail.gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Wed, 18 Oct 2023 11:38:09 +0200
Message-ID: <CAOiHx==uSQrO6+Ob1qe3NaRdXoGTwLYSS8S7YYMwQ4zhSbX75g@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Binbin Zhou <zhoubb.aaron@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org, frowand.list@gmail.com
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

On Wed, 18 Oct 2023 at 08:58, Binbin Zhou <zhoubb.aaron@gmail.com> wrote:
>
> On Tue, Oct 17, 2023 at 9:05=E2=80=AFPM Jonas Gorski <jonas.gorski@gmail.=
com> wrote:
> >
> > On Mon, 16 Oct 2023 at 13:26, Binbin Zhou <zhoubb.aaron@gmail.com> wrot=
e:
> > >
> > > Hi all:
> > >
> > > Sorry, it's been a while since the last discussion.
> > >
> > > Previously, Krzysztof suggested using the standard "interrupt-map"
> > > attribute instead of the "loongson,parent_int_map" attribute, which I
> > > tried to implement, but the downside of this approach seems to be
> > > obvious.
> > >
> > > First of all, let me explain again the interrupt routing of the
> > > loongson liointc.
> > > For example, the Loongson-2K1000 has 64 interrupt sources, each with
> > > the following 8-bit interrupt routing registers (main regs attribute
> > > in dts):
> > >
> > > +----+---------------------------------------------------------------=
----+
> > > | bit  | description
> > >             |
> > > +----+---------------------------------------------------------------=
----+
> > > | 3:0 | Processor core to route                                      =
     |
> > > | 7:4 | Routed processor core interrupt pins (INT0--INT3) |
> > > +-----+--------------------------------------------------------------=
----+
> > >
> > > The "loongson,parent_int_map" attribute is to describe the routed
> > > interrupt pins to cpuintc.
> > >
> > > However, the "interrupt-map" attribute is not supposed to be used for
> > > interrupt controller in the normal case. Though since commit
> > > 041284181226 ("of/irq: Allow matching of an interrupt-map local to an
> > > interrupt controller"), the "interrupt-map" attribute can be used in
> > > interrupt controller nodes. Some interrupt controllers were found not
> > > to work properly later, so in commit de4adddcbcc2 ("of/irq: Add a
> > > quirk for controllers with their own definition of interrupt-map"), a
> > > quirk was added for these interrupt controllers. As we can see from
> > > the commit message, this is a bad solution in itself.
> > >
> > > Similarly, if we choose to use the "interrupt-map" attribute in the
> > > interrupt controller, we have to use this unfriendly solution (quirk)=
.
> > > Because we hope of_irq_parse_raw() stops at the liointc level rather
> > > than goto its parent level.
> > >
> > > So, I don't think it's a good choice to use a bad solution as a repla=
cement.
> > >
> > > Do you have any other ideas?
> >
> > Assuming this is changeable at runtime, this sounds to me like this
> > mapping/routing could easily be exposed as irqchip cpu affinity. Then
> > userspace can apply all the performance optimizations it wants (and
> > can easily update them without fiddling with the kernel/dts).
> >
> > And then there would be no need to hardcode/describe it in the dts(i) a=
t all.
>
> Hi Jonas:
>
> Thanks for your reply.
>
> It is possible that my non-detailed explanation caused your misunderstand=
ing.
> Allow me to explain again about the interrupt routing register above,
> which we know is divided into two parts:
>
> +----+-------------------------------------------------------------------=
+
> | bit  | description |
> +----+-------------------------------------------------------------------=
+
> | 3:0 | Processor core to route                                          =
 |
> | 7:4 | Routed processor core interrupt pins (INT0--INT3) |
> +-----+------------------------------------------------------------------=
+
>
> The first part "processor core" will be set to "boot_cpu_id" in the
> driver, which we assume is fixed and we don't need to care about it
> here.
> What we care about is the second part "mapping of device interrupts to
> processor interrupt pins", which is what we want to describe in
> dts(i).
>
> Let's take the Loongson-2K1000 as an example again, it has 64
> interrupt sources as inputs and 4 processor core interrupt pins as
> outputs.
> The sketch is shown below:
>
> Device Interrupts           Interrupt Pins
>                  +-------------+
>          0---->|                |--> INT0
>         ...       | Mapping |--> INT1
>         ...       |                |--> INT2
>         63--->|                |--> INT3
>                  +-------------+
>
> Therefore, this mapping relationship cannot be changed at runtime and
> needs to be hardcoded/described in dts(i).

But that's only a driver/description limitation, not an actual
physical limitation, right? In theory you could reroute them as much
as you want as long as you keep the kernel up-to-date about the
current routing (via whatever means).

Anyway, I guess you want to use the routed interrupt pin to identify
different irq controller blocks.

Can't the interrupt pin be inferred from the parent interrupt? If your
parent (hw) irq is two, route everything to INT0 etc? Or alternatively
use the name of the parent interrupt?

Best Regards,
Jonas
