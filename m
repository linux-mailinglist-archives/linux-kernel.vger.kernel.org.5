Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DC37CD4B6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344419AbjJRG6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjJRG6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:58:08 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFE3B0;
        Tue, 17 Oct 2023 23:58:06 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5a7c95b8d14so82809827b3.3;
        Tue, 17 Oct 2023 23:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697612286; x=1698217086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwC4vINsKq9AZoCiHY7v2qaBARUu3Ce9v82O1PQj3I8=;
        b=YkcPy1I42u2qAWk/UMix0vDl8hSdVc25OHbDbszY7lMTuzdETKKoD9SOJHuzyMlFZI
         jWYDEN5ZeJLNmFMbnDJryxJcDY2FZAaEdHsTMQd12rRIwU2t5Vfh4QLncREQf1OgshwB
         sl7QyVlN60dAdhIkailca/lmeux4FhlHJ/WNjVBg+OnzZ5amEm0gTO3UdQGhAPF/ly0S
         YC1WbzflWA9DGd8nHhvoBY2zVajeD/GXXAgKJj24VjSzsmxEWwEdA1at+pghOpVJOm4K
         SwfphGgS0ksLEylGSJPkjJbAh6ZnH90M8EieeyzH/1XRh0JX1IzdVQCcxDtu8U6KxKJi
         5B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697612286; x=1698217086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwC4vINsKq9AZoCiHY7v2qaBARUu3Ce9v82O1PQj3I8=;
        b=SBlSWq2XjVhT4DJDwQ48uVkU5YMW6Wkm33+hS0+8Vy3pDtZOmmzrY8v5gTFTP9dZ0B
         32SNExtNubCUbGHL/LkoxUi3/lkOQT7Ajk0OHom69CFQ7w6q3Pq+MVAVV83Yp6Stubx1
         LOvrEZhxOqi3vNWicP1Pgku3okjbcdoadbyBSDKMBsnrbtprJHSmGlkXLxvA8YJIamyt
         602+XcC0hxuW6OLOrD/pH8Dk2px113nneD4rShfhKQMuBPs1NuObNCBp3tpL6sWbWJrg
         S5eIBb+SUGJ5ZvLyGdO5DUMYZo1yWLjDhtpzYjBW8KmLSjb4Z/QzFrU9HbhtCAtFLa+Y
         eeqg==
X-Gm-Message-State: AOJu0Yx5XaESVnYr5GT2Uiz6ILNWMLSIF7T+HpToVHUqRspsIwikqmy4
        UwOKZkWC72DEl23AeJQzE/LRB9g+KFyW7+6VfeU=
X-Google-Smtp-Source: AGHT+IE6HbcHtJGJ8vsAFILw76rUp7kVer/XFcoWhaAjgYaag/14z9b9gNxOtypzAhjLZ9R641Sfqma1OaIo29kRNNo=
X-Received: by 2002:a25:8042:0:b0:d9a:baa8:30a2 with SMTP id
 a2-20020a258042000000b00d9abaa830a2mr4263564ybn.8.1697612286050; Tue, 17 Oct
 2023 23:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org> <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org> <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org> <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <86wmxcejav.wl-maz@kernel.org> <c7898abf-34ca-d0b4-fd0c-935100dcd3f2@flygoat.com>
 <86pm2ye2si.wl-maz@kernel.org> <CAMpQs4LjePLy5RFMz2S=1sa9Zme_UrJmKKRog0LAg_ZhA07TMA@mail.gmail.com>
 <CAOiHx=mq3hw-LFerb9UzU7VSnLypnvPuo1GomCnN=p0u3xN1Ug@mail.gmail.com>
In-Reply-To: <CAOiHx=mq3hw-LFerb9UzU7VSnLypnvPuo1GomCnN=p0u3xN1Ug@mail.gmail.com>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Wed, 18 Oct 2023 12:57:53 +0600
Message-ID: <CAMpQs4+neiaJKp93UcemJbPPbhmf1B7WYNqKh=qx0avrbwW2cQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Jonas Gorski <jonas.gorski@gmail.com>
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

On Tue, Oct 17, 2023 at 9:05=E2=80=AFPM Jonas Gorski <jonas.gorski@gmail.co=
m> wrote:
>
> On Mon, 16 Oct 2023 at 13:26, Binbin Zhou <zhoubb.aaron@gmail.com> wrote:
> >
> > Hi all:
> >
> > Sorry, it's been a while since the last discussion.
> >
> > Previously, Krzysztof suggested using the standard "interrupt-map"
> > attribute instead of the "loongson,parent_int_map" attribute, which I
> > tried to implement, but the downside of this approach seems to be
> > obvious.
> >
> > First of all, let me explain again the interrupt routing of the
> > loongson liointc.
> > For example, the Loongson-2K1000 has 64 interrupt sources, each with
> > the following 8-bit interrupt routing registers (main regs attribute
> > in dts):
> >
> > +----+-----------------------------------------------------------------=
--+
> > | bit  | description
> >             |
> > +----+-----------------------------------------------------------------=
--+
> > | 3:0 | Processor core to route                                        =
   |
> > | 7:4 | Routed processor core interrupt pins (INT0--INT3) |
> > +-----+----------------------------------------------------------------=
--+
> >
> > The "loongson,parent_int_map" attribute is to describe the routed
> > interrupt pins to cpuintc.
> >
> > However, the "interrupt-map" attribute is not supposed to be used for
> > interrupt controller in the normal case. Though since commit
> > 041284181226 ("of/irq: Allow matching of an interrupt-map local to an
> > interrupt controller"), the "interrupt-map" attribute can be used in
> > interrupt controller nodes. Some interrupt controllers were found not
> > to work properly later, so in commit de4adddcbcc2 ("of/irq: Add a
> > quirk for controllers with their own definition of interrupt-map"), a
> > quirk was added for these interrupt controllers. As we can see from
> > the commit message, this is a bad solution in itself.
> >
> > Similarly, if we choose to use the "interrupt-map" attribute in the
> > interrupt controller, we have to use this unfriendly solution (quirk).
> > Because we hope of_irq_parse_raw() stops at the liointc level rather
> > than goto its parent level.
> >
> > So, I don't think it's a good choice to use a bad solution as a replace=
ment.
> >
> > Do you have any other ideas?
>
> Assuming this is changeable at runtime, this sounds to me like this
> mapping/routing could easily be exposed as irqchip cpu affinity. Then
> userspace can apply all the performance optimizations it wants (and
> can easily update them without fiddling with the kernel/dts).
>
> And then there would be no need to hardcode/describe it in the dts(i) at =
all.

Hi Jonas:

Thanks for your reply.

It is possible that my non-detailed explanation caused your misunderstandin=
g.
Allow me to explain again about the interrupt routing register above,
which we know is divided into two parts:

+----+-------------------------------------------------------------------+
| bit  | description |
+----+-------------------------------------------------------------------+
| 3:0 | Processor core to route                                           |
| 7:4 | Routed processor core interrupt pins (INT0--INT3) |
+-----+------------------------------------------------------------------+

The first part "processor core" will be set to "boot_cpu_id" in the
driver, which we assume is fixed and we don't need to care about it
here.
What we care about is the second part "mapping of device interrupts to
processor interrupt pins", which is what we want to describe in
dts(i).

Let's take the Loongson-2K1000 as an example again, it has 64
interrupt sources as inputs and 4 processor core interrupt pins as
outputs.
The sketch is shown below:

Device Interrupts           Interrupt Pins
                 +-------------+
         0---->|                |--> INT0
        ...       | Mapping |--> INT1
        ...       |                |--> INT2
        63--->|                |--> INT3
                 +-------------+

Therefore, this mapping relationship cannot be changed at runtime and
needs to be hardcoded/described in dts(i).

Thanks.
Binbin
>
> Best Regards,
> Jonas
