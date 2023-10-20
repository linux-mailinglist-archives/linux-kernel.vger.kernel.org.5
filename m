Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002427D0C55
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376775AbjJTJwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376904AbjJTJvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:51:52 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22A810EA;
        Fri, 20 Oct 2023 02:51:48 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9ac9573274so632090276.0;
        Fri, 20 Oct 2023 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697795508; x=1698400308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3Mupx6T2tUBpLEDq3pUUT0TDzjyxWLvq5X9ApT7Hus=;
        b=LlD7ScoyXca1j1NIYOBrQGaHC1aDKweUjOfoGRyL5Elr9UyMyp4WVo7DAfn6EAK2Pr
         2G0gzLuCQLtyW0vl+5ggnq9/GbwG+U0/G2gaDwEnGGZeoBD/SfRrAJcDL+CDZIThwGxw
         r4r8p66zi9Qj3FMDOyWJmq+HIcMUbta7AZbJ+kL+sTk1C1+WLVDJuLWanIWXiRw6YFej
         FNVQW6rdv7/SeBO5Wb3ui746rxIecG4KZunfElKNFQBTcJDrIkJAuR3maOz1zeNwS7u3
         I4ypSHJbj6i2Nk/UblB0cfMujioy7R2sf3YifQidwE7b0n6cwbFQb4DQ0kLPHUMY6j0N
         B6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697795508; x=1698400308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3Mupx6T2tUBpLEDq3pUUT0TDzjyxWLvq5X9ApT7Hus=;
        b=Ohj/h8zcIi7p8jfvIz1+t1nlcEq25P88C76AgJh8cc1NZnsy//DFK7XhNl8f3u0w2+
         gyn9GpYysh5vmq7IicTllyk7xRLCkPKwYUUU2Qh76Uj5JxCWNNTEu8ynlJMcR3N8iYfg
         T2kaSqr4+uOlI1MBMP0luJ7uo4s2cUsRKT94eX5Qv4UsND6k3N5/qJjOyqte59IL1n49
         eB9jtO2w3JFaw0HQQ0PMB0aP7/Rt1qOUzXgPjE7pKH27fAMe0Pgy99z5jLaK3JC0omSW
         drkoE3/oenOQ2cGrKEb27FvhALV3rczWC34GmEGqTNVX7GhhF7pVcOa/L3C7CS8CKm3e
         o69Q==
X-Gm-Message-State: AOJu0YwyXTkC5mYvYYi3vsOZTZEt9o9D+U+Bv6nPiQxqTMXRF0O+gzpo
        lRp6HoJ+epOWw+s037E9w5wBBMQ4POql6W1pwdw=
X-Google-Smtp-Source: AGHT+IExbMwCq1BO9qwikaERDO6hdNO0TY7/Tu2uEc51jLOLQfcAm5R65BVe5B3y9e4kZCJEIHmduDaEpeMv47W+hrs=
X-Received: by 2002:a05:6902:727:b0:d9a:5f25:d0df with SMTP id
 l7-20020a056902072700b00d9a5f25d0dfmr1480235ybt.57.1697795507786; Fri, 20 Oct
 2023 02:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org> <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org> <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org> <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <86wmxcejav.wl-maz@kernel.org> <c7898abf-34ca-d0b4-fd0c-935100dcd3f2@flygoat.com>
 <86pm2ye2si.wl-maz@kernel.org> <CAMpQs4LjePLy5RFMz2S=1sa9Zme_UrJmKKRog0LAg_ZhA07TMA@mail.gmail.com>
 <CAOiHx=mq3hw-LFerb9UzU7VSnLypnvPuo1GomCnN=p0u3xN1Ug@mail.gmail.com>
 <CAMpQs4+neiaJKp93UcemJbPPbhmf1B7WYNqKh=qx0avrbwW2cQ@mail.gmail.com>
 <CAOiHx==uSQrO6+Ob1qe3NaRdXoGTwLYSS8S7YYMwQ4zhSbX75g@mail.gmail.com> <CAAhV-H4yZ7DKx865M1RN+0L8CZjua=wBMsuXT0ekNANRN+RWAg@mail.gmail.com>
In-Reply-To: <CAAhV-H4yZ7DKx865M1RN+0L8CZjua=wBMsuXT0ekNANRN+RWAg@mail.gmail.com>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Fri, 20 Oct 2023 15:51:35 +0600
Message-ID: <CAMpQs4Kug8dOWHD+nqAbGkmqkWU=y=k6+VwojETn8PEwf+MSPA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
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

Hi Krzysztof & Marc:

Sorry for the interruption.
As said before, we tried to use the 'interrupt-map attribute' in our
Loongson liointc dts(i), but there are some unfriendly points.
Do you have any other different suggestions?

Thanks.
Binbin

On Wed, Oct 18, 2023 at 8:33=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Jonas,
>
> On Wed, Oct 18, 2023 at 5:38=E2=80=AFPM Jonas Gorski <jonas.gorski@gmail.=
com> wrote:
> >
> > On Wed, 18 Oct 2023 at 08:58, Binbin Zhou <zhoubb.aaron@gmail.com> wrot=
e:
> > >
> > > On Tue, Oct 17, 2023 at 9:05=E2=80=AFPM Jonas Gorski <jonas.gorski@gm=
ail.com> wrote:
> > > >
> > > > On Mon, 16 Oct 2023 at 13:26, Binbin Zhou <zhoubb.aaron@gmail.com> =
wrote:
> > > > >
> > > > > Hi all:
> > > > >
> > > > > Sorry, it's been a while since the last discussion.
> > > > >
> > > > > Previously, Krzysztof suggested using the standard "interrupt-map=
"
> > > > > attribute instead of the "loongson,parent_int_map" attribute, whi=
ch I
> > > > > tried to implement, but the downside of this approach seems to be
> > > > > obvious.
> > > > >
> > > > > First of all, let me explain again the interrupt routing of the
> > > > > loongson liointc.
> > > > > For example, the Loongson-2K1000 has 64 interrupt sources, each w=
ith
> > > > > the following 8-bit interrupt routing registers (main regs attrib=
ute
> > > > > in dts):
> > > > >
> > > > > +----+-----------------------------------------------------------=
--------+
> > > > > | bit  | description
> > > > >             |
> > > > > +----+-----------------------------------------------------------=
--------+
> > > > > | 3:0 | Processor core to route                                  =
         |
> > > > > | 7:4 | Routed processor core interrupt pins (INT0--INT3) |
> > > > > +-----+----------------------------------------------------------=
--------+
> > > > >
> > > > > The "loongson,parent_int_map" attribute is to describe the routed
> > > > > interrupt pins to cpuintc.
> > > > >
> > > > > However, the "interrupt-map" attribute is not supposed to be used=
 for
> > > > > interrupt controller in the normal case. Though since commit
> > > > > 041284181226 ("of/irq: Allow matching of an interrupt-map local t=
o an
> > > > > interrupt controller"), the "interrupt-map" attribute can be used=
 in
> > > > > interrupt controller nodes. Some interrupt controllers were found=
 not
> > > > > to work properly later, so in commit de4adddcbcc2 ("of/irq: Add a
> > > > > quirk for controllers with their own definition of interrupt-map"=
), a
> > > > > quirk was added for these interrupt controllers. As we can see fr=
om
> > > > > the commit message, this is a bad solution in itself.
> > > > >
> > > > > Similarly, if we choose to use the "interrupt-map" attribute in t=
he
> > > > > interrupt controller, we have to use this unfriendly solution (qu=
irk).
> > > > > Because we hope of_irq_parse_raw() stops at the liointc level rat=
her
> > > > > than goto its parent level.
> > > > >
> > > > > So, I don't think it's a good choice to use a bad solution as a r=
eplacement.
> > > > >
> > > > > Do you have any other ideas?
> > > >
> > > > Assuming this is changeable at runtime, this sounds to me like this
> > > > mapping/routing could easily be exposed as irqchip cpu affinity. Th=
en
> > > > userspace can apply all the performance optimizations it wants (and
> > > > can easily update them without fiddling with the kernel/dts).
> > > >
> > > > And then there would be no need to hardcode/describe it in the dts(=
i) at all.
> > >
> > > Hi Jonas:
> > >
> > > Thanks for your reply.
> > >
> > > It is possible that my non-detailed explanation caused your misunders=
tanding.
> > > Allow me to explain again about the interrupt routing register above,
> > > which we know is divided into two parts:
> > >
> > > +----+---------------------------------------------------------------=
----+
> > > | bit  | description |
> > > +----+---------------------------------------------------------------=
----+
> > > | 3:0 | Processor core to route                                      =
     |
> > > | 7:4 | Routed processor core interrupt pins (INT0--INT3) |
> > > +-----+--------------------------------------------------------------=
----+
> > >
> > > The first part "processor core" will be set to "boot_cpu_id" in the
> > > driver, which we assume is fixed and we don't need to care about it
> > > here.
> > > What we care about is the second part "mapping of device interrupts t=
o
> > > processor interrupt pins", which is what we want to describe in
> > > dts(i).
> > >
> > > Let's take the Loongson-2K1000 as an example again, it has 64
> > > interrupt sources as inputs and 4 processor core interrupt pins as
> > > outputs.
> > > The sketch is shown below:
> > >
> > > Device Interrupts           Interrupt Pins
> > >                  +-------------+
> > >          0---->|                |--> INT0
> > >         ...       | Mapping |--> INT1
> > >         ...       |                |--> INT2
> > >         63--->|                |--> INT3
> > >                  +-------------+
> > >
> > > Therefore, this mapping relationship cannot be changed at runtime and
> > > needs to be hardcoded/described in dts(i).
> >
> > But that's only a driver/description limitation, not an actual
> > physical limitation, right? In theory you could reroute them as much
> > as you want as long as you keep the kernel up-to-date about the
> > current routing (via whatever means).
> >
> > Anyway, I guess you want to use the routed interrupt pin to identify
> > different irq controller blocks.
> >
> > Can't the interrupt pin be inferred from the parent interrupt? If your
> > parent (hw) irq is two, route everything to INT0 etc? Or alternatively
> > use the name of the parent interrupt?
> Let me make things clear and ignore those irrelevant information.
> 1, Our liointc controller has 32 inputs from downstream interrupt
> sources and 4 outputs to the parent irqchip, the "routing" here means
> which input go to which output.
> 2, We use 'parent_int_map' to describe the boot-time routing in dts
> previously, but Krzysztof suggests us to use 'interrupt-map' instead.
> 3, When we rework our driver to use 'interrupt-map', we found that
> this property is not supposed to be used in a regular irqchip (it is
> usually used in a pcie port which is also act as an irqchip).
> 4, If we still want to use 'interrupt-map' to describe the routing in
> liointc, we should make of_irq_parse_raw() stop at the liointc level
> rather than go to its parent level, because the hwirq is provided by
> liointc, not its parent. To archive this goal, we should add liointc
> to the quirk list.
> 5, So, for our liointc driver we have two choices: 1) still use the
> 'parent_int_map' property; 2) use 'interrupt-map' property and add
> liointc to the quirk list. We prefer the first ourselves, but
> Krzysztof may give us a best solution.
>
> Huacai
>
> >
> > Best Regards,
> > Jonas
