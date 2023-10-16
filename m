Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFED57CA6AD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjJPL0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJPL0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:26:34 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F638E;
        Mon, 16 Oct 2023 04:26:30 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7be88e9ccso55216587b3.2;
        Mon, 16 Oct 2023 04:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697455590; x=1698060390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yQmSlsxbnMckjW63VAfUcoliPYUbmy3I2guqKRcrjg=;
        b=WXYvfGGKVVAOfjX4uomvB7l9ylK+K37BrzcEegphhHBm6tfx7h1tCA9DIVn4Q+PEHB
         yIHkDje1JWgCs9lSDyfMNonm/jgtCn0ntphSzcKpYM1GR2AEnWmZ4QLHVmcb/RdMV4lN
         JOnp2aLwZ+xfytzCMcxzQpPK09UKrzPzdFkAQmrq28F1/HYuhmXhk8e7m9b3IEx1Llkn
         br6iNve0F6mwdNqi1M7taTWuWpubSnO8knbRDN2zTuSr6CvufkyMlg1IL7vxOlvVeQX4
         yQXn2Ko4oCqZHzKpKc4dGYp++8WnXYFK6mXzgxcUbVrVuojdRJzBd6IMc0iHyt7g3Kup
         gzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697455590; x=1698060390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yQmSlsxbnMckjW63VAfUcoliPYUbmy3I2guqKRcrjg=;
        b=kc/cpeAgp47vPsGhriLckp1fYF1oMh6OSwU9iPRClm+3ggIkZg28FrI4du0RML7HvZ
         XS8Y7yqFe/t3OrHiNnjnBIauiVAVvXEC9PSw9VnaEV1q+IC6VOPMRdLXzYNvBvWCwSCj
         t06pr+YOW06CNksfm42lS7O3QVdWlkec1ZaYGfCcjJIuq5tCUeDaMrBd3y4urU624Xwc
         lj/OsvK0rFMQ1+K5r0OpHQkAwZQSU374QHDkFqjw2r0n/jTNFPHgjsuWB1DIUS8bjE1z
         x3znmdWmVy35ZH9aJXWDXPqhjKCvU6/qqH4Pu1QB24i5WsQTqhwCbQpBDkXeFOpEzpi8
         4CdA==
X-Gm-Message-State: AOJu0YxCHcgre+nhtqTmvsImxetRCzoDgDWftEJbzt+jzxNJ2avV7A72
        aNPxMclliAzgtobZVdk71MkJypHQpWgXp7XVHls=
X-Google-Smtp-Source: AGHT+IH1bcIS3tF3im0FBq83yq9oAgb+7dUHfMwOTu59VXIzcm4XrCfp5dma/A/3H4Z2CPsF/nk5vAHl8NcQA7AwAuk=
X-Received: by 2002:a25:b94f:0:b0:d9b:1495:cfe5 with SMTP id
 s15-20020a25b94f000000b00d9b1495cfe5mr7839940ybm.51.1697455589696; Mon, 16
 Oct 2023 04:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org> <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org> <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org> <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <86wmxcejav.wl-maz@kernel.org> <c7898abf-34ca-d0b4-fd0c-935100dcd3f2@flygoat.com>
 <86pm2ye2si.wl-maz@kernel.org>
In-Reply-To: <86pm2ye2si.wl-maz@kernel.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Mon, 16 Oct 2023 17:26:18 +0600
Message-ID: <CAMpQs4LjePLy5RFMz2S=1sa9Zme_UrJmKKRog0LAg_ZhA07TMA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

Sorry, it's been a while since the last discussion.

Previously, Krzysztof suggested using the standard "interrupt-map"
attribute instead of the "loongson,parent_int_map" attribute, which I
tried to implement, but the downside of this approach seems to be
obvious.

First of all, let me explain again the interrupt routing of the
loongson liointc.
For example, the Loongson-2K1000 has 64 interrupt sources, each with
the following 8-bit interrupt routing registers (main regs attribute
in dts):

+----+-------------------------------------------------------------------+
| bit  | description
            |
+----+-------------------------------------------------------------------+
| 3:0 | Processor core to route                                           |
| 7:4 | Routed processor core interrupt pins (INT0--INT3) |
+-----+------------------------------------------------------------------+

The "loongson,parent_int_map" attribute is to describe the routed
interrupt pins to cpuintc.

However, the "interrupt-map" attribute is not supposed to be used for
interrupt controller in the normal case. Though since commit
041284181226 ("of/irq: Allow matching of an interrupt-map local to an
interrupt controller"), the "interrupt-map" attribute can be used in
interrupt controller nodes. Some interrupt controllers were found not
to work properly later, so in commit de4adddcbcc2 ("of/irq: Add a
quirk for controllers with their own definition of interrupt-map"), a
quirk was added for these interrupt controllers. As we can see from
the commit message, this is a bad solution in itself.

Similarly, if we choose to use the "interrupt-map" attribute in the
interrupt controller, we have to use this unfriendly solution (quirk).
Because we hope of_irq_parse_raw() stops at the liointc level rather
than goto its parent level.

So, I don't think it's a good choice to use a bad solution as a replacement=
.

Do you have any other ideas?

Thanks.
Binbin

On Mon, Sep 4, 2023 at 2:54=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 30 Aug 2023 16:25:48 +0100,
> Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> >
> >
> >
> > =E5=9C=A8 2023/8/30 21:44, Marc Zyngier =E5=86=99=E9=81=93:
> > [...]
> > >> What's the best way, in your opinion, to overhaul this property? As =
we don't
> > >> really care backward compatibility of DTBs on those systems we can
> > >> just redesign it.
> > > You may not care about backward compatibility, but I do. We don't
> > > break existing systems, full stop.
> > Ah it won't break any existing system. Sorry for not giving enough insi=
ght
> > into the platform in previous reply. As for Loongson64 all DTBs are bui=
lt
> > into kernel binary. So as long as binding are changed together with all=
 DTS
> > in tree we won't break any system.
>
> This is factually wrong. QEMU produces a DT for Loongarch at runtime.
> So no, you're not allowed to just drop bindings on the floor. They
> stay forever.
>
> > > As for the offending property, it has no place here either. DT is not
> > > the place where you put "performance knobs".
> > Hmm, I can see various bindings with vendor prefix exposing device
> > configurations. If we seen this interrupt routing as a device configura=
tion
> > I don't think it's against devicetree design philosophy.
>
> Just because we have tons of crap in the device trees doesn't give you
> a license to be just as bad.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
