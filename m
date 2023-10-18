Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0853A7CE007
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345727AbjJROfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345558AbjJROfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:35:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C5D72;
        Wed, 18 Oct 2023 07:33:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C36C433CA;
        Wed, 18 Oct 2023 14:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697639626;
        bh=cLipz8J6oEmh+ml1rc21wOF53zzsI1dKLbu6UdJUPAE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pnKaJobVr1K8TrLoPMWwbp4EU6l54jpXaiZ3WiRMftDNOtS4Vc+7wQ2K1bm6VkpmV
         jo9kOetAQE1csLrFm64M8g0krD5DLQzJgSyY3RL6fgeni9HKZm0yVb3tcHXyz8f4cw
         zS7XlD8fUCBr0/K1hZvXc+X1mAa9EwYp86KIdWmJm51Ag5uINuVyU+tjRdzTh87qc4
         aea12HuAHGtTF/UV4GfwhiSOncFEcyP3LaV/fJiJq4WFBot6H8KVWx0iorXTtDQCxG
         LEG2HuuyhrH1QIAN4xlbf/255CE9UwdD5BOtXcY8MZ8+vhXWqrQAr49MEO4+6VN0sk
         FuV250BtzoC4A==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so1085641366b.1;
        Wed, 18 Oct 2023 07:33:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyd9UupN1qOjKcg1ZiktEc0ukEG8Qweb2dhyb211C7JKVq4izLK
        K2Sn6gLY7GCeQa5LfobX8Fy6aueUM1k4VFVevvA=
X-Google-Smtp-Source: AGHT+IEsWAGom4iQqn79hXr786s3mfMGfFSL+9U7yikMdyJnU4Qb89MGJCpe0Z+zNqgH5yPPIQqdurERnRAYU0THHxg=
X-Received: by 2002:a17:906:fd84:b0:9be:fc31:8cd4 with SMTP id
 xa4-20020a170906fd8400b009befc318cd4mr4906580ejb.18.1697639624987; Wed, 18
 Oct 2023 07:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org> <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org> <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org> <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <86wmxcejav.wl-maz@kernel.org> <c7898abf-34ca-d0b4-fd0c-935100dcd3f2@flygoat.com>
 <86pm2ye2si.wl-maz@kernel.org> <CAMpQs4LjePLy5RFMz2S=1sa9Zme_UrJmKKRog0LAg_ZhA07TMA@mail.gmail.com>
 <CAOiHx=mq3hw-LFerb9UzU7VSnLypnvPuo1GomCnN=p0u3xN1Ug@mail.gmail.com>
 <CAMpQs4+neiaJKp93UcemJbPPbhmf1B7WYNqKh=qx0avrbwW2cQ@mail.gmail.com> <CAOiHx==uSQrO6+Ob1qe3NaRdXoGTwLYSS8S7YYMwQ4zhSbX75g@mail.gmail.com>
In-Reply-To: <CAOiHx==uSQrO6+Ob1qe3NaRdXoGTwLYSS8S7YYMwQ4zhSbX75g@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 18 Oct 2023 22:33:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4yZ7DKx865M1RN+0L8CZjua=wBMsuXT0ekNANRN+RWAg@mail.gmail.com>
Message-ID: <CAAhV-H4yZ7DKx865M1RN+0L8CZjua=wBMsuXT0ekNANRN+RWAg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Binbin Zhou <zhoubb.aaron@gmail.com>,
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jonas,

On Wed, Oct 18, 2023 at 5:38=E2=80=AFPM Jonas Gorski <jonas.gorski@gmail.co=
m> wrote:
>
> On Wed, 18 Oct 2023 at 08:58, Binbin Zhou <zhoubb.aaron@gmail.com> wrote:
> >
> > On Tue, Oct 17, 2023 at 9:05=E2=80=AFPM Jonas Gorski <jonas.gorski@gmai=
l.com> wrote:
> > >
> > > On Mon, 16 Oct 2023 at 13:26, Binbin Zhou <zhoubb.aaron@gmail.com> wr=
ote:
> > > >
> > > > Hi all:
> > > >
> > > > Sorry, it's been a while since the last discussion.
> > > >
> > > > Previously, Krzysztof suggested using the standard "interrupt-map"
> > > > attribute instead of the "loongson,parent_int_map" attribute, which=
 I
> > > > tried to implement, but the downside of this approach seems to be
> > > > obvious.
> > > >
> > > > First of all, let me explain again the interrupt routing of the
> > > > loongson liointc.
> > > > For example, the Loongson-2K1000 has 64 interrupt sources, each wit=
h
> > > > the following 8-bit interrupt routing registers (main regs attribut=
e
> > > > in dts):
> > > >
> > > > +----+-------------------------------------------------------------=
------+
> > > > | bit  | description
> > > >             |
> > > > +----+-------------------------------------------------------------=
------+
> > > > | 3:0 | Processor core to route                                    =
       |
> > > > | 7:4 | Routed processor core interrupt pins (INT0--INT3) |
> > > > +-----+------------------------------------------------------------=
------+
> > > >
> > > > The "loongson,parent_int_map" attribute is to describe the routed
> > > > interrupt pins to cpuintc.
> > > >
> > > > However, the "interrupt-map" attribute is not supposed to be used f=
or
> > > > interrupt controller in the normal case. Though since commit
> > > > 041284181226 ("of/irq: Allow matching of an interrupt-map local to =
an
> > > > interrupt controller"), the "interrupt-map" attribute can be used i=
n
> > > > interrupt controller nodes. Some interrupt controllers were found n=
ot
> > > > to work properly later, so in commit de4adddcbcc2 ("of/irq: Add a
> > > > quirk for controllers with their own definition of interrupt-map"),=
 a
> > > > quirk was added for these interrupt controllers. As we can see from
> > > > the commit message, this is a bad solution in itself.
> > > >
> > > > Similarly, if we choose to use the "interrupt-map" attribute in the
> > > > interrupt controller, we have to use this unfriendly solution (quir=
k).
> > > > Because we hope of_irq_parse_raw() stops at the liointc level rathe=
r
> > > > than goto its parent level.
> > > >
> > > > So, I don't think it's a good choice to use a bad solution as a rep=
lacement.
> > > >
> > > > Do you have any other ideas?
> > >
> > > Assuming this is changeable at runtime, this sounds to me like this
> > > mapping/routing could easily be exposed as irqchip cpu affinity. Then
> > > userspace can apply all the performance optimizations it wants (and
> > > can easily update them without fiddling with the kernel/dts).
> > >
> > > And then there would be no need to hardcode/describe it in the dts(i)=
 at all.
> >
> > Hi Jonas:
> >
> > Thanks for your reply.
> >
> > It is possible that my non-detailed explanation caused your misundersta=
nding.
> > Allow me to explain again about the interrupt routing register above,
> > which we know is divided into two parts:
> >
> > +----+-----------------------------------------------------------------=
--+
> > | bit  | description |
> > +----+-----------------------------------------------------------------=
--+
> > | 3:0 | Processor core to route                                        =
   |
> > | 7:4 | Routed processor core interrupt pins (INT0--INT3) |
> > +-----+----------------------------------------------------------------=
--+
> >
> > The first part "processor core" will be set to "boot_cpu_id" in the
> > driver, which we assume is fixed and we don't need to care about it
> > here.
> > What we care about is the second part "mapping of device interrupts to
> > processor interrupt pins", which is what we want to describe in
> > dts(i).
> >
> > Let's take the Loongson-2K1000 as an example again, it has 64
> > interrupt sources as inputs and 4 processor core interrupt pins as
> > outputs.
> > The sketch is shown below:
> >
> > Device Interrupts           Interrupt Pins
> >                  +-------------+
> >          0---->|                |--> INT0
> >         ...       | Mapping |--> INT1
> >         ...       |                |--> INT2
> >         63--->|                |--> INT3
> >                  +-------------+
> >
> > Therefore, this mapping relationship cannot be changed at runtime and
> > needs to be hardcoded/described in dts(i).
>
> But that's only a driver/description limitation, not an actual
> physical limitation, right? In theory you could reroute them as much
> as you want as long as you keep the kernel up-to-date about the
> current routing (via whatever means).
>
> Anyway, I guess you want to use the routed interrupt pin to identify
> different irq controller blocks.
>
> Can't the interrupt pin be inferred from the parent interrupt? If your
> parent (hw) irq is two, route everything to INT0 etc? Or alternatively
> use the name of the parent interrupt?
Let me make things clear and ignore those irrelevant information.
1, Our liointc controller has 32 inputs from downstream interrupt
sources and 4 outputs to the parent irqchip, the "routing" here means
which input go to which output.
2, We use 'parent_int_map' to describe the boot-time routing in dts
previously, but Krzysztof suggests us to use 'interrupt-map' instead.
3, When we rework our driver to use 'interrupt-map', we found that
this property is not supposed to be used in a regular irqchip (it is
usually used in a pcie port which is also act as an irqchip).
4, If we still want to use 'interrupt-map' to describe the routing in
liointc, we should make of_irq_parse_raw() stop at the liointc level
rather than go to its parent level, because the hwirq is provided by
liointc, not its parent. To archive this goal, we should add liointc
to the quirk list.
5, So, for our liointc driver we have two choices: 1) still use the
'parent_int_map' property; 2) use 'interrupt-map' property and add
liointc to the quirk list. We prefer the first ourselves, but
Krzysztof may give us a best solution.

Huacai

>
> Best Regards,
> Jonas
