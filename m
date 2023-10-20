Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3F67D11B9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377574AbjJTOkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377518AbjJTOkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:40:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA02D53
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:40:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17F68C433C7;
        Fri, 20 Oct 2023 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697812834;
        bh=u/U9nnqgPeREKVvmxW1xeTootMKuuSYkI2HYOXzF4ME=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VGAFqtx232BDmzSrStY1SaghPb5zcaRYo3f/dxKRFyLl3llsKJcdYXH9wr991Xq+/
         nEq3pvV+cStQODCp6NgWsebTukdU7HNoTQ7sJ4z852R6HH2QCIK4pQqFLvIrx0Zrrn
         Rbh25+A6On9EuNIutk3155soPgu1uh/CQ3WdHFmfxmJejPK7F44TE71SZIjQLGJirS
         j5qJSEhRMiZefZ1KHS3sJ/hCPPje9nkjLEKx41TTXjVA0V6j/bw1S6VSKnCbidTD/i
         mg80tpERyDcMBEWRNmYyP0EDZbFgVXkKkbATNeBJ+AGV0gBrF6yrGSkvtBR/8VoOc3
         N+EYyHDE+3fXQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Anup Patel <apatel@ventanamicro.com>
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
Subject: Re: [PATCH v10 00/15] Linux RISC-V AIA Support
In-Reply-To: <CAK9=C2VE9-L49tMKHjSTGDSpOFZGZw14LtD1V4GMXGiVQ-A=ng@mail.gmail.com>
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
 <87o7gu7mo9.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2XMzzYri8TNBASKqc-VmJWjGdoOHy-fczksfkU0ahhgOQ@mail.gmail.com>
 <87h6mlbryy.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2VE9-L49tMKHjSTGDSpOFZGZw14LtD1V4GMXGiVQ-A=ng@mail.gmail.com>
Date:   Fri, 20 Oct 2023 16:40:31 +0200
Message-ID: <87o7gtpdb4.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anup Patel <apatel@ventanamicro.com> writes:

> On Fri, Oct 20, 2023 at 2:17=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Thanks for the quick reply!
>>
>> Anup Patel <apatel@ventanamicro.com> writes:
>>
>> > On Thu, Oct 19, 2023 at 7:13=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@k=
ernel.org> wrote:
>> >>
>> >> Hi Anup,
>> >>
>> >> Anup Patel <apatel@ventanamicro.com> writes:
>> >>
>> >> > The RISC-V AIA specification is ratified as-per the RISC-V internat=
ional
>> >> > process. The latest ratified AIA specifcation can be found at:
>> >> > https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-inte=
rrupts-1.0.pdf
>> >> >
>> >> > At a high-level, the AIA specification adds three things:
>> >> > 1) AIA CSRs
>> >> >    - Improved local interrupt support
>> >> > 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>> >> >    - Per-HART MSI controller
>> >> >    - Support MSI virtualization
>> >> >    - Support IPI along with virtualization
>> >> > 3) Advanced Platform-Level Interrupt Controller (APLIC)
>> >> >    - Wired interrupt controller
>> >> >    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI gene=
rator)
>> >> >    - In Direct-mode, injects external interrupts directly into HARTs
>> >>
>> >> Thanks for working on the AIA support! I had a look at the series, and
>> >> have some concerns about interrupt ID abstraction.
>> >>
>> >> A bit of background, for readers not familiar with the AIA details.
>> >>
>> >> IMSIC allows for 2047 unique MSI ("msi-irq") sources per hart, and
>> >> each MSI is dedicated to a certain hart. The series takes the approach
>> >> to say that there are, e.g., 2047 interrupts ("lnx-irq") globally.
>> >> Each lnx-irq consists of #harts * msi-irq -- a slice -- and in the
>> >> slice only *one* msi-irq is acutally used.
>> >>
>> >> This scheme makes affinity changes more robust, because the interrupt
>> >> sources on "other" harts are pre-allocated. On the other hand it
>> >> requires to propagate irq masking to other harts via IPIs (this is
>> >> mostly done up setup/tear down). It's also wasteful, because msi-irqs
>> >> are hogged, and cannot be used.
>> >>
>> >> Contemporary storage/networking drivers usually uses queues per core
>> >> (or a sub-set of cores). The current scheme wastes a lot of msi-irqs.
>> >> If we instead used a scheme where "msi-irq =3D=3D lnx-irq", instead of
>> >> "lnq-irq =3D {hart 0;msi-irq x , ... hart N;msi-irq x}", there would =
be
>> >> a lot MSIs for other users. 1-1 vs 1-N. E.g., if a storage device
>> >> would like to use 5 queues (5 cores) on a 128 core system, the current
>> >> scheme would consume 5 * 128 MSIs, instead of just 5.
>> >>
>> >> On the plus side:
>> >> * Changing interrupts affinity will never fail, because the interrupts
>> >>   on each hart is pre-allocated.
>> >>
>> >> On the negative side:
>> >> * Wasteful interrupt usage, and a system can potientially "run out" of
>> >>   interrupts. Especially for many core systems.
>> >> * Interrupt masking need to proagate to harts via IPIs (there's no
>> >>   broadcast csr in IMSIC), and a more complex locking scheme IMSIC
>> >>
>> >> Summary:
>> >> The current series caps the number of global interrupts to maximum
>> >> 2047 MSIs for all cores (whole system). A better scheme, IMO, would be
>> >> to expose 2047 * #harts unique MSIs.
>> >>
>> >> I think this could simplify/remove(?) the locking as well.
>> >
>> > Exposing 2047 * #harts unique MSIs has multiple issues:
>> > 1) The irq_set_affinity() does not work for MSIs because each
>> >      IRQ is not tied to a particular HART. This means we can't
>> >      balance the IRQ processing load among HARTs.
>>
>> Yes, you can balance. In your code, each *active* MSI is still
>> bound/active to a specific hard together with the affinity mask. In an
>> 1-1 model you would still need to track the affinity mask, but the
>> irq_set_affinity() would be different. It would try to allocate a new
>> MSI from the target CPU, and then switch to having that MSI active.
>>
>> That's what x86 does AFAIU, which is also constrained by the # of
>> available MSIs.
>>
>> The downside, as I pointed out, is that the set affinity action can
>> fail for a certain target CPU.
>
> Yes, irq_set_affinity() can fail for the suggested approach plus for
> RISC-V AIA, one HART does not have access to other HARTs
> MSI enable/disable bits so the approach will also involve IPI.

Correct, but the current series does a broadcast to all cores, where the
1-1 approach is at most an IPI to a single core.

128+c machines are getting more common, and you have devices that you
bring up/down on a per-core basis. Broadcasting IPIs to all cores, when
dealing with a per-core activity is a pretty noisy neighbor.

This could be fixed in the existing 1-n approach, by not require to sync
the cores that are not handling the MSI in question. "Lazy disable"

>> > 2) All wired IRQs for APLIC MSI-mode will also target a
>> >     fixed HART hence irq_set_affinity() won't work for wired
>> >     IRQs as well.
>>
>> I'm not following here. Why would APLIC put a constraint here? I had a
>> look at the specs, and I didn't see anything supporting the current
>> scheme explicitly.
>
> Lets say the number of APLIC wired interrupts  are greater than the
> number of per-CPU IMSIC IDs. In this case, if all wired interrupts are
> moved to a particular CPU then irq_set_affinity() will fail for some of
> the wired interrupts.

Right, it's the case of "full remote CPU" again. Thanks for clearing
that up.

>> > The idea of treating per-HART MSIs as separate IRQs has
>> > been discussed in the past.
>>
>> Aha! I tried to look for it in lore, but didn't find any. Could you
>> point me to those discussions?
>
> This was done 2 years back in the AIA TG meeting when we were
> doing the PoC for AIA spec.

Ah, too bad. Thanks regardless.

>> My concern is interrupts become a scarce resource with this
>> implementation, but maybe my view is incorrect. I've seen bare-metal
>> x86 systems (no VMs) with ~200 cores, and ~2000 interrupts, but maybe
>> that is considered "a lot of interrupts".
>>
>> As long as we don't get into scenarios where we're running out of
>> interrupts, due to the software design.
>>
>
> The current approach is simpler and ensures irq_set_affinity
> always works. The limit of max 2047 IDs is sufficient for many
> systems (if not all).

Let me give you another view. On a 128c system each core has ~16 unique
interrupts for disposal. E.g. the Intel E800 NIC has more than 2048
network queue pairs for each PF.

> When we encounter a system requiring a large number of MSIs,
> we can either:
> 1) Extend the AIA spec to support greater than 2047 IDs
> 2) Re-think the approach in the IMSIC driver
>
> The choice between #1 and #2 above depends on the
> guarantees we want for irq_set_affinity().

The irq_set_affinity() behavior is better with this series, but I think
the other downsides: number of available interrupt sources, and IPI
broadcast are worse.


Bj=C3=B6rn
