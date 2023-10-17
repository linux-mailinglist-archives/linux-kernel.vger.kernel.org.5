Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DEA7CC707
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbjJQPHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344279AbjJQPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:07:29 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1533919BC;
        Tue, 17 Oct 2023 08:05:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6bd0e1b1890so2280142b3a.3;
        Tue, 17 Oct 2023 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697555145; x=1698159945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fc+BeKPfjaApdVuZ2mptOISBL2EV+8avGTyYqpZGpXk=;
        b=XXul8jSnElKAFWr77zuxxKgHVM3pz0IZPj6/FpQ8+C4jV27uH6yxhPJi5lfIuvQA9O
         msdvn+yNOVDyENYae5tdXkquwpiyeK8mXoeT/MXofb0vAz7UEqqcBWHYh/Z0hbRHCEV/
         69x0apS8T1CS5Qa7R3Yr+wuycUbXC8y4iK/Fj62ieAKk9CqQXvWParEGK630Erh4FgkK
         zr6dPiTq2VnBfXM+26TbP0KLy8Sws8ggwcAZZukpCte23XFNHZ6ikMf1F0vqFf+oWq2h
         EG5NdQMJdkIw1lNKnJe97yaOiWZuXTX+srzngs9ctg70dwTT23vQW4lkk05cDfBoXxn9
         DRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697555145; x=1698159945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fc+BeKPfjaApdVuZ2mptOISBL2EV+8avGTyYqpZGpXk=;
        b=o0GInIXWBMlXZJtEb7cx7pySnGeZr/uK5RUEsXoTfeknaAoIk9/btpufbSdTvlWn+I
         6raG0reMrR28rt501KTp/zvzH7IAhy/Z6blube97wXSBZHj9i/VG8IzS3331fJCkywqE
         bt4eOAhjXAl/Gq+M0Dvg4sGs5c33LYy3B0/si7IeZemVIl/RXK6fkyXCmbfPrCvBtk0y
         /iLIRBgcuQf4prZx41ZxgJVcu/teRdYFapd51d35WHCMhKCzxvXKGljqgQNAJC3YOG7d
         lnkEl/gHNTEWn0G0XXrgWHRAcxdlbMSq1krLUnp2dKatPkYUP/e7bK0uPoQDFZm/bE78
         hdEQ==
X-Gm-Message-State: AOJu0YyhN814NgvlKV8vqM5scJzFG5axfIQw+AdpWO6PEwIYmW2UMjkm
        szwfQZYMd3+I8dHegtr3X6jwehkilZXUWQqrDWg=
X-Google-Smtp-Source: AGHT+IHRVJcqqQ05a6eUWlxAyiD4fn+eYoln4HJwNwndR9ebKz7p4uoLjo93gwRzO28tEriZtsd5k30PA+Z5wb/S43U=
X-Received: by 2002:a05:6a20:3d01:b0:163:9f1d:b464 with SMTP id
 y1-20020a056a203d0100b001639f1db464mr2630754pzi.5.1697555145234; Tue, 17 Oct
 2023 08:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org> <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org> <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org> <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <86wmxcejav.wl-maz@kernel.org> <c7898abf-34ca-d0b4-fd0c-935100dcd3f2@flygoat.com>
 <86pm2ye2si.wl-maz@kernel.org> <CAMpQs4LjePLy5RFMz2S=1sa9Zme_UrJmKKRog0LAg_ZhA07TMA@mail.gmail.com>
In-Reply-To: <CAMpQs4LjePLy5RFMz2S=1sa9Zme_UrJmKKRog0LAg_ZhA07TMA@mail.gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 17 Oct 2023 17:05:33 +0200
Message-ID: <CAOiHx=mq3hw-LFerb9UzU7VSnLypnvPuo1GomCnN=p0u3xN1Ug@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2023 at 13:26, Binbin Zhou <zhoubb.aaron@gmail.com> wrote:
>
> Hi all:
>
> Sorry, it's been a while since the last discussion.
>
> Previously, Krzysztof suggested using the standard "interrupt-map"
> attribute instead of the "loongson,parent_int_map" attribute, which I
> tried to implement, but the downside of this approach seems to be
> obvious.
>
> First of all, let me explain again the interrupt routing of the
> loongson liointc.
> For example, the Loongson-2K1000 has 64 interrupt sources, each with
> the following 8-bit interrupt routing registers (main regs attribute
> in dts):
>
> +----+-------------------------------------------------------------------+
> | bit  | description
>             |
> +----+-------------------------------------------------------------------+
> | 3:0 | Processor core to route                                           |
> | 7:4 | Routed processor core interrupt pins (INT0--INT3) |
> +-----+------------------------------------------------------------------+
>
> The "loongson,parent_int_map" attribute is to describe the routed
> interrupt pins to cpuintc.
>
> However, the "interrupt-map" attribute is not supposed to be used for
> interrupt controller in the normal case. Though since commit
> 041284181226 ("of/irq: Allow matching of an interrupt-map local to an
> interrupt controller"), the "interrupt-map" attribute can be used in
> interrupt controller nodes. Some interrupt controllers were found not
> to work properly later, so in commit de4adddcbcc2 ("of/irq: Add a
> quirk for controllers with their own definition of interrupt-map"), a
> quirk was added for these interrupt controllers. As we can see from
> the commit message, this is a bad solution in itself.
>
> Similarly, if we choose to use the "interrupt-map" attribute in the
> interrupt controller, we have to use this unfriendly solution (quirk).
> Because we hope of_irq_parse_raw() stops at the liointc level rather
> than goto its parent level.
>
> So, I don't think it's a good choice to use a bad solution as a replacement.
>
> Do you have any other ideas?

Assuming this is changeable at runtime, this sounds to me like this
mapping/routing could easily be exposed as irqchip cpu affinity. Then
userspace can apply all the performance optimizations it wants (and
can easily update them without fiddling with the kernel/dts).

And then there would be no need to hardcode/describe it in the dts(i) at all.

Best Regards,
Jonas
