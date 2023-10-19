Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F247CFF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjJSQL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjJSQLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:11:24 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCE4134
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:11:22 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b7f3f470a9so2624251a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697731882; x=1698336682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOjYwgdk9z8wQA3VmtvZ1n8QsFFkfcCxM5197gEqm4U=;
        b=Y91rB4GoPLy8/oGanHiNR+IxvV8EYZzPF+uDEv2Bv9n4MxM/juvmagYfdqIQrVE/oN
         +ofocpCtV7zEyUZiPmmscPhN1IjDx9/dW779JwzHY8cttLXjHeRx8hNXjOz7bktQxSVZ
         4nmvR0/rVzo87wfS/7pIf4SuFbtlBUXYR18tSCh3HyPDt8DTy/tB1IP4muY5eJbtTEPe
         Y+/nU1TewPCk0X8UpQZiew6Vc+yjeIS7lpzTIwQ75K5Jv+GokFwyyJ0NtT4qb7onAwir
         h+AwU2nrOOAtbuLx8Cn4T2kUt3kFmZHYLu2q8e/fRH3GULo1F0hvyHSxtFJmF47DHX5f
         ALwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697731882; x=1698336682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOjYwgdk9z8wQA3VmtvZ1n8QsFFkfcCxM5197gEqm4U=;
        b=G+U28vkInwqraYgwT6RlU2kUu7XMjeTtoXAOB03WVGQMBSQS/pCn7I4ns4xAyDkfPy
         rXx+Mdtp9an/jTkliNW4LpGAYZYspL+F3yOl7jvhK1Mb6I0NUqSi67B8eLmIjW04Vhrc
         jJ0Gcr1RtMeJ0U2sgK18IQHr28jq1KsdWFfyfTzRVSeMQwijnnR2uaG4kVhstbB+t0PI
         BDODSMWwcTVy79zxICA+eZvM2uDOamwPZ5Ld2lp8h15Ybv+ggkwbt6giTeIn1voqfP8A
         4hRJgZK4D+X2Yjeq+a+UQT6MQBi3xWkFtksCpiPWGFxBeNDTrsVuaKAiRNf9lvKcCZg7
         sJZw==
X-Gm-Message-State: AOJu0YwRQF2gBjZZFNdM/ocADCI0Zdj3gGBfTWgwMjHpHJYzOM0atKLW
        3H2PyWmMu0NBkrIpODlwAhDCeNOQYB8ZBrrH8uf/36yUC7SevQ86
X-Google-Smtp-Source: AGHT+IHyxUQVRECrrku3aBHQKGFGKsHUbRup3XjNvl7h7Cf1LJLXNBlAxjNyNIPFpPpc531lLIcmfpp9YIzhp+ETcyI=
X-Received: by 2002:a05:6a20:8e0e:b0:154:a1e3:f967 with SMTP id
 y14-20020a056a208e0e00b00154a1e3f967mr3115507pzj.47.1697731881787; Thu, 19
 Oct 2023 09:11:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231003044403.1974628-1-apatel@ventanamicro.com> <87o7gu7mo9.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87o7gu7mo9.fsf@all.your.base.are.belong.to.us>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Thu, 19 Oct 2023 21:41:10 +0530
Message-ID: <CAK9=C2XMzzYri8TNBASKqc-VmJWjGdoOHy-fczksfkU0ahhgOQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] Linux RISC-V AIA Support
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Saravana Kannan <saravanak@google.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 7:13=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> Hi Anup,
>
> Anup Patel <apatel@ventanamicro.com> writes:
>
> > The RISC-V AIA specification is ratified as-per the RISC-V internationa=
l
> > process. The latest ratified AIA specifcation can be found at:
> > https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-interrup=
ts-1.0.pdf
> >
> > At a high-level, the AIA specification adds three things:
> > 1) AIA CSRs
> >    - Improved local interrupt support
> > 2) Incoming Message Signaled Interrupt Controller (IMSIC)
> >    - Per-HART MSI controller
> >    - Support MSI virtualization
> >    - Support IPI along with virtualization
> > 3) Advanced Platform-Level Interrupt Controller (APLIC)
> >    - Wired interrupt controller
> >    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI generato=
r)
> >    - In Direct-mode, injects external interrupts directly into HARTs
>
> Thanks for working on the AIA support! I had a look at the series, and
> have some concerns about interrupt ID abstraction.
>
> A bit of background, for readers not familiar with the AIA details.
>
> IMSIC allows for 2047 unique MSI ("msi-irq") sources per hart, and
> each MSI is dedicated to a certain hart. The series takes the approach
> to say that there are, e.g., 2047 interrupts ("lnx-irq") globally.
> Each lnx-irq consists of #harts * msi-irq -- a slice -- and in the
> slice only *one* msi-irq is acutally used.
>
> This scheme makes affinity changes more robust, because the interrupt
> sources on "other" harts are pre-allocated. On the other hand it
> requires to propagate irq masking to other harts via IPIs (this is
> mostly done up setup/tear down). It's also wasteful, because msi-irqs
> are hogged, and cannot be used.
>
> Contemporary storage/networking drivers usually uses queues per core
> (or a sub-set of cores). The current scheme wastes a lot of msi-irqs.
> If we instead used a scheme where "msi-irq =3D=3D lnx-irq", instead of
> "lnq-irq =3D {hart 0;msi-irq x , ... hart N;msi-irq x}", there would be
> a lot MSIs for other users. 1-1 vs 1-N. E.g., if a storage device
> would like to use 5 queues (5 cores) on a 128 core system, the current
> scheme would consume 5 * 128 MSIs, instead of just 5.
>
> On the plus side:
> * Changing interrupts affinity will never fail, because the interrupts
>   on each hart is pre-allocated.
>
> On the negative side:
> * Wasteful interrupt usage, and a system can potientially "run out" of
>   interrupts. Especially for many core systems.
> * Interrupt masking need to proagate to harts via IPIs (there's no
>   broadcast csr in IMSIC), and a more complex locking scheme IMSIC
>
> Summary:
> The current series caps the number of global interrupts to maximum
> 2047 MSIs for all cores (whole system). A better scheme, IMO, would be
> to expose 2047 * #harts unique MSIs.
>
> I think this could simplify/remove(?) the locking as well.

Exposing 2047 * #harts unique MSIs has multiple issues:
1) The irq_set_affinity() does not work for MSIs because each
     IRQ is not tied to a particular HART. This means we can't
     balance the IRQ processing load among HARTs.
2) All wired IRQs for APLIC MSI-mode will also target a
    fixed HART hence irq_set_affinity() won't work for wired
    IRQs as well.
3) Contemporary storage/networking drivers which use per-core
     queues use irq_set_affinity() on queue IRQs to balance
     across cores but this will fail.
4) HART hotplug breaks because kernel irq-subsystem can't
    migrate the IRQs (both MSIs and Wired) targeting HART X
    to another HART Y when the HART X goes down.

The idea of treating per-HART MSIs as separate IRQs has
been discussed in the past. The current approach works nicely
with all kernel use-cases at the cost of additional work on the
driver side.

Also, the current approach is very similar to the ARM GICv3
driver where ITS LPIs across CPUs are treated as single IRQ.

>
> I realize that the series in v10, and coming with a change like this
> now might be a bit of a pain...
>
> Finally, another question related to APLIC/IMSIC. AFAIU the memory map
> of the IMSIC regions are constrained by the APLIC, which requires a
> certain layout for MSI forwarding (group/hart/guest bits). Say that a
> system doesn't have an APLIC, couldn't the layout requirement be
> simplified?

Yes, this is already taken care of in the current IMSIC driver based
on feedback from Atish. We can certainly improve flexibility on the
IMSIC driver side if some case is missed-out.

The APLIC driver is certainly very strict about the arrangement of
IMSIC files so we do additional sanity checks on the APLIC driver
side at the time of probing.

>
>
> Again, thanks for the hard work!
> Bj=C3=B6rn

Regards,
Anup
