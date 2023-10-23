Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1017D3B22
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjJWPpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJWPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:45:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE5D101
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:45:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D76C433C9;
        Mon, 23 Oct 2023 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698075905;
        bh=sXrsDJWjDr+5qRRavSTLTE0/x+9rTRBhGpf1Xk2Ww+8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HuQtYY6Vycet+u+PiKpYW+UaiDzfDgLNQZLmLWXphiNISrsqXF8sJx7JvsMptN9/v
         2IlltV6NeOfklFSeuGhDv/QsHFpXOu1BtaY8QGFHa8H8fmT/1ZYpp/5T78ATQmno1w
         wTUv4cb3vlR2AgMzgesDM6DS8HmQUJ6w1cduDf4QH8lfeS72ff7dbrF/p35QBjfqeW
         Hmo4+62OtOFD4+RV6EOOElFMhD8mf9lwepXmhI3spxlBVVzqF5aRfcPdBQFypUf6ZC
         BgCxTvGAB8aJSBlx9BMxqaLGzealZDOcqJhHKmhS7BE70hdwFCb4pEiS/2ZNRX72NZ
         GpaHo7KfY38Dg==
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
In-Reply-To: <CAK9=C2UN4+HcNfM+JKDH=ERT7WqLgf7DXck=pSZjuCw0YN87Og@mail.gmail.com>
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
 <87o7gu7mo9.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2XMzzYri8TNBASKqc-VmJWjGdoOHy-fczksfkU0ahhgOQ@mail.gmail.com>
 <87h6mlbryy.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2VE9-L49tMKHjSTGDSpOFZGZw14LtD1V4GMXGiVQ-A=ng@mail.gmail.com>
 <87o7gtpdb4.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2WVkbDtz9uZTNjEcJzKQ44cHLR=+nSVZZmSptzL_U4NNA@mail.gmail.com>
 <87v8b1i72s.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2X__tYk21F+o2GmKDMzdnZf8TXJn=baO248ao8as47vnA@mail.gmail.com>
 <875y31cc2y.fsf@all.your.base.are.belong.to.us>
 <87jzrdx1mm.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2U2FEoAPgoxibsbPsjF+d+APWFuJtEL43=xxwnwM4L1ZA@mail.gmail.com>
 <87pm15l9fd.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2UN4+HcNfM+JKDH=ERT7WqLgf7DXck=pSZjuCw0YN87Og@mail.gmail.com>
Date:   Mon, 23 Oct 2023 17:45:01 +0200
Message-ID: <87v8axqr5u.fsf@all.your.base.are.belong.to.us>
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

> On Mon, Oct 23, 2023 at 7:37=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Anup Patel <apatel@ventanamicro.com> writes:
>>
>> > On Mon, Oct 23, 2023 at 12:32=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@=
kernel.org> wrote:
>> >>
>> >> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>> >>
>> >> > Anup Patel <apatel@ventanamicro.com> writes:
>> >> >
>> >> >> On Fri, Oct 20, 2023 at 10:07=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bj=
orn@kernel.org> wrote:
>> >> >>>
>> >> >>> Anup Patel <apatel@ventanamicro.com> writes:
>> >> >>>
>> >> >>> > On Fri, Oct 20, 2023 at 8:10=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <=
bjorn@kernel.org> wrote:
>> >> >>> >>
>> >> >>> >> Anup Patel <apatel@ventanamicro.com> writes:
>> >> >>> >>
>> >> >>> >> > On Fri, Oct 20, 2023 at 2:17=E2=80=AFPM Bj=C3=B6rn T=C3=B6pe=
l <bjorn@kernel.org> wrote:
>> >> >>> >> >>
>> >> >>> >> >> Thanks for the quick reply!
>> >> >>> >> >>
>> >> >>> >> >> Anup Patel <apatel@ventanamicro.com> writes:
>> >> >>> >> >>
>> >> >>> >> >> > On Thu, Oct 19, 2023 at 7:13=E2=80=AFPM Bj=C3=B6rn T=C3=
=B6pel <bjorn@kernel.org> wrote:
>> >> >>> >> >> >>
>> >> >>> >> >> >> Hi Anup,
>> >> >>> >> >> >>
>> >> >>> >> >> >> Anup Patel <apatel@ventanamicro.com> writes:
>> >> >>> >> >> >>
>> >> >>> >> >> >> > The RISC-V AIA specification is ratified as-per the RI=
SC-V international
>> >> >>> >> >> >> > process. The latest ratified AIA specifcation can be f=
ound at:
>> >> >>> >> >> >> > https://github.com/riscv/riscv-aia/releases/download/1=
.0/riscv-interrupts-1.0.pdf
>> >> >>> >> >> >> >
>> >> >>> >> >> >> > At a high-level, the AIA specification adds three thin=
gs:
>> >> >>> >> >> >> > 1) AIA CSRs
>> >> >>> >> >> >> >    - Improved local interrupt support
>> >> >>> >> >> >> > 2) Incoming Message Signaled Interrupt Controller (IMS=
IC)
>> >> >>> >> >> >> >    - Per-HART MSI controller
>> >> >>> >> >> >> >    - Support MSI virtualization
>> >> >>> >> >> >> >    - Support IPI along with virtualization
>> >> >>> >> >> >> > 3) Advanced Platform-Level Interrupt Controller (APLIC)
>> >> >>> >> >> >> >    - Wired interrupt controller
>> >> >>> >> >> >> >    - In MSI-mode, converts wired interrupt into MSIs (=
i.e. MSI generator)
>> >> >>> >> >> >> >    - In Direct-mode, injects external interrupts direc=
tly into HARTs
>> >> >>> >> >> >>
>> >> >>> >> >> >> Thanks for working on the AIA support! I had a look at t=
he series, and
>> >> >>> >> >> >> have some concerns about interrupt ID abstraction.
>> >> >>> >> >> >>
>> >> >>> >> >> >> A bit of background, for readers not familiar with the A=
IA details.
>> >> >>> >> >> >>
>> >> >>> >> >> >> IMSIC allows for 2047 unique MSI ("msi-irq") sources per=
 hart, and
>> >> >>> >> >> >> each MSI is dedicated to a certain hart. The series take=
s the approach
>> >> >>> >> >> >> to say that there are, e.g., 2047 interrupts ("lnx-irq")=
 globally.
>> >> >>> >> >> >> Each lnx-irq consists of #harts * msi-irq -- a slice -- =
and in the
>> >> >>> >> >> >> slice only *one* msi-irq is acutally used.
>> >> >>> >> >> >>
>> >> >>> >> >> >> This scheme makes affinity changes more robust, because =
the interrupt
>> >> >>> >> >> >> sources on "other" harts are pre-allocated. On the other=
 hand it
>> >> >>> >> >> >> requires to propagate irq masking to other harts via IPI=
s (this is
>> >> >>> >> >> >> mostly done up setup/tear down). It's also wasteful, bec=
ause msi-irqs
>> >> >>> >> >> >> are hogged, and cannot be used.
>> >> >>> >> >> >>
>> >> >>> >> >> >> Contemporary storage/networking drivers usually uses que=
ues per core
>> >> >>> >> >> >> (or a sub-set of cores). The current scheme wastes a lot=
 of msi-irqs.
>> >> >>> >> >> >> If we instead used a scheme where "msi-irq =3D=3D lnx-ir=
q", instead of
>> >> >>> >> >> >> "lnq-irq =3D {hart 0;msi-irq x , ... hart N;msi-irq x}",=
 there would be
>> >> >>> >> >> >> a lot MSIs for other users. 1-1 vs 1-N. E.g., if a stora=
ge device
>> >> >>> >> >> >> would like to use 5 queues (5 cores) on a 128 core syste=
m, the current
>> >> >>> >> >> >> scheme would consume 5 * 128 MSIs, instead of just 5.
>> >> >>> >> >> >>
>> >> >>> >> >> >> On the plus side:
>> >> >>> >> >> >> * Changing interrupts affinity will never fail, because =
the interrupts
>> >> >>> >> >> >>   on each hart is pre-allocated.
>> >> >>> >> >> >>
>> >> >>> >> >> >> On the negative side:
>> >> >>> >> >> >> * Wasteful interrupt usage, and a system can potientiall=
y "run out" of
>> >> >>> >> >> >>   interrupts. Especially for many core systems.
>> >> >>> >> >> >> * Interrupt masking need to proagate to harts via IPIs (=
there's no
>> >> >>> >> >> >>   broadcast csr in IMSIC), and a more complex locking sc=
heme IMSIC
>> >> >>> >> >> >>
>> >> >>> >> >> >> Summary:
>> >> >>> >> >> >> The current series caps the number of global interrupts =
to maximum
>> >> >>> >> >> >> 2047 MSIs for all cores (whole system). A better scheme,=
 IMO, would be
>> >> >>> >> >> >> to expose 2047 * #harts unique MSIs.
>> >> >>> >> >> >>
>> >> >>> >> >> >> I think this could simplify/remove(?) the locking as wel=
l.
>> >> >>> >> >> >
>> >> >>> >> >> > Exposing 2047 * #harts unique MSIs has multiple issues:
>> >> >>> >> >> > 1) The irq_set_affinity() does not work for MSIs because =
each
>> >> >>> >> >> >      IRQ is not tied to a particular HART. This means we =
can't
>> >> >>> >> >> >      balance the IRQ processing load among HARTs.
>> >> >>> >> >>
>> >> >>> >> >> Yes, you can balance. In your code, each *active* MSI is st=
ill
>> >> >>> >> >> bound/active to a specific hard together with the affinity =
mask. In an
>> >> >>> >> >> 1-1 model you would still need to track the affinity mask, =
but the
>> >> >>> >> >> irq_set_affinity() would be different. It would try to allo=
cate a new
>> >> >>> >> >> MSI from the target CPU, and then switch to having that MSI=
 active.
>> >> >>> >> >>
>> >> >>> >> >> That's what x86 does AFAIU, which is also constrained by th=
e # of
>> >> >>> >> >> available MSIs.
>> >> >>> >> >>
>> >> >>> >> >> The downside, as I pointed out, is that the set affinity ac=
tion can
>> >> >>> >> >> fail for a certain target CPU.
>> >> >>> >> >
>> >> >>> >> > Yes, irq_set_affinity() can fail for the suggested approach =
plus for
>> >> >>> >> > RISC-V AIA, one HART does not have access to other HARTs
>> >> >>> >> > MSI enable/disable bits so the approach will also involve IP=
I.
>> >> >>> >>
>> >> >>> >> Correct, but the current series does a broadcast to all cores,=
 where the
>> >> >>> >> 1-1 approach is at most an IPI to a single core.
>> >> >>> >>
>> >> >>> >> 128+c machines are getting more common, and you have devices t=
hat you
>> >> >>> >> bring up/down on a per-core basis. Broadcasting IPIs to all co=
res, when
>> >> >>> >> dealing with a per-core activity is a pretty noisy neighbor.
>> >> >>> >
>> >> >>> > Broadcast IPI in the current approach is only done upon MSI mas=
k/unmask
>> >> >>> > operation. It is not done upon set_affinity() of interrupt hand=
ling.
>> >> >>>
>> >> >>> I'm aware. We're on the same page here.
>> >> >>>
>> >> >>> >>
>> >> >>> >> This could be fixed in the existing 1-n approach, by not requi=
re to sync
>> >> >>> >> the cores that are not handling the MSI in question. "Lazy dis=
able"
>> >> >>> >
>> >> >>> > Incorrect. The approach you are suggesting involves an IPI upon=
 every
>> >> >>> > irq_set_affinity(). This is because a HART can only enable it's=
 own
>> >> >>> > MSI ID so when an IRQ is moved to from HART A to HART B with
>> >> >>> > a different ID X on HART B then we will need an IPI in irq_set_=
affinit()
>> >> >>> > to enable ID X on HART B.
>> >> >>>
>> >> >>> Yes, the 1-1 approach will require an IPI to one target cpu on af=
finity
>> >> >>> changes, and similar on mask/unmask.
>> >> >>>
>> >> >>> The 1-n approach, require no-IPI on affinity changes (nice!), but=
 IPI
>> >> >>> broadcast to all cores on mask/unmask (not so nice).
>> >> >>>
>> >> >>> >> >> My concern is interrupts become a scarce resource with this
>> >> >>> >> >> implementation, but maybe my view is incorrect. I've seen b=
are-metal
>> >> >>> >> >> x86 systems (no VMs) with ~200 cores, and ~2000 interrupts,=
 but maybe
>> >> >>> >> >> that is considered "a lot of interrupts".
>> >> >>> >> >>
>> >> >>> >> >> As long as we don't get into scenarios where we're running =
out of
>> >> >>> >> >> interrupts, due to the software design.
>> >> >>> >> >>
>> >> >>> >> >
>> >> >>> >> > The current approach is simpler and ensures irq_set_affinity
>> >> >>> >> > always works. The limit of max 2047 IDs is sufficient for ma=
ny
>> >> >>> >> > systems (if not all).
>> >> >>> >>
>> >> >>> >> Let me give you another view. On a 128c system each core has ~=
16 unique
>> >> >>> >> interrupts for disposal. E.g. the Intel E800 NIC has more than=
 2048
>> >> >>> >> network queue pairs for each PF.
>> >> >>> >
>> >> >>> > Clearly, this example is a hypothetical and represents a poorly
>> >> >>> > designed platform.
>> >> >>> >
>> >> >>> > Having just 16 IDs per-Core is a very poor design choice. In fa=
ct, the
>> >> >>> > Server SoC spec mandates a minimum 255 IDs.
>> >> >>>
>> >> >>> You are misreading. A 128c system with 2047 MSIs per-core, will o=
nly
>> >> >>> have 16 *per-core unique* (2047/128) interrupts with the current =
series.
>> >> >>>
>> >> >>> I'm not saying that each IMSIC has 16 IDs, I'm saying that in a 1=
28c
>> >> >>> system with the maximum amount of MSIs possible in the spec, you'=
ll end
>> >> >>> up with 16 *unique* interrupts per core.
>> >> >>
>> >> >> -ENOPARSE
>> >> >>
>> >> >> I don't see how this applies to the current approach because we tr=
eat
>> >> >> MSI ID space as global across cores so if a system has 2047 MSIs
>> >> >> per-core then we have 2047 MSIs across all cores.
>> >> >
>> >> > Ok, I'll try again! :-)
>> >> >
>> >> > Let's assume that each core in the 128c system has some per-core
>> >> > resources, say a two NIC queue pairs, and a storage queue pair. This
>> >> > will consume, e.g., 2*2 + 2 (6) MSI sources from the global namespa=
ce.
>> >> >
>> >> > If each core does this it'll be 6*128 MSI sources of the global
>> >> > namespace.
>> >> >
>> >> > The maximum number of "privates" MSI sources a core can utilize is =
16.
>> >> >
>> >> > I'm trying (it's does seem to go that well ;-)) to point out that i=
t's
>> >> > only 16 unique sources per core. For, say, a 256 core system it wou=
ld be
>> >> > 8. 2047 MSI sources in a system is not much.
>> >> >
>> >> > Say that I want to spin up 24 NIC queues with one MSI each on each =
core
>> >> > on my 128c system. That's not possible with this series, while with=
 an
>> >> > 1-1 system it wouldn't be an issue.
>> >> >
>> >> > Clearer, or still weird?
>> >> >
>> >> >>
>> >> >>>
>> >> >>> > Regarding NICs which support a large number of queues, the driv=
er
>> >> >>> > will typically enable only one queue per-core and set the affin=
ity to
>> >> >>> > separate cores. We have user-space data plane applications based
>> >> >>> > on DPDK which are capable of using a large number of NIC queues
>> >> >>> > but these applications are polling based and don't use MSIs.
>> >> >>>
>> >> >>> That's one sample point, and clearly not the only one. There are =
*many*
>> >> >>> different usage models. Just because you *assign* MSI, doesn't me=
an they
>> >> >>> are firing all the time.
>> >> >>>
>> >> >>> I can show you a couple of networking setups where this is clearl=
y not
>> >> >>> enough. Each core has a large number of QoS queues, and each queu=
e would
>> >> >>> very much like to have a dedicated MSI.
>> >> >>>
>> >> >>> >> > When we encounter a system requiring a large number of MSIs,
>> >> >>> >> > we can either:
>> >> >>> >> > 1) Extend the AIA spec to support greater than 2047 IDs
>> >> >>> >> > 2) Re-think the approach in the IMSIC driver
>> >> >>> >> >
>> >> >>> >> > The choice between #1 and #2 above depends on the
>> >> >>> >> > guarantees we want for irq_set_affinity().
>> >> >>> >>
>> >> >>> >> The irq_set_affinity() behavior is better with this series, bu=
t I think
>> >> >>> >> the other downsides: number of available interrupt sources, an=
d IPI
>> >> >>> >> broadcast are worse.
>> >> >>> >
>> >> >>> > The IPI overhead in the approach you are suggesting will be
>> >> >>> > even bad compared to the IPI overhead of the current approach
>> >> >>> > because we will end-up doing IPI upon every irq_set_affinity()
>> >> >>> > in the suggested approach compared to doing IPI upon every
>> >> >>> > mask/unmask in the current approach.
>> >> >>>
>> >> >>> Again, very workload dependent.
>> >> >>>
>> >> >>> This series does IPI broadcast on masking/unmasking, which means =
that
>> >> >>> cores that don't care get interrupted because, say, a network que=
ue-pair
>> >> >>> is setup on another core.
>> >> >>>
>> >> >>> Some workloads never change the irq affinity.
>> >> >>
>> >> >> There are various events which irq affinity such as irq balance,
>> >> >> CPU hotplug, system suspend, etc.
>> >> >>
>> >> >> Also, the 1-1 approach does IPI upon set_affinity, mask and
>> >> >> unmask whereas the 1-n approach does IPI only upon mask
>> >> >> and unmask.
>> >> >
>> >> > An important distinction; When you say IPI on mask/unmask it is a
>> >> > broadcast IPI to *all* cores, which is pretty instrusive.
>> >> >
>> >> > The 1-1 variant does an IPI to a *one* target core.
>> >> >
>> >> >>> I'm just pointing out that there are pro/cons with both variants.
>> >> >>>
>> >> >>> > The biggest advantage of the current approach is a reliable
>> >> >>> > irq_set_affinity() which is a very valuable thing to have.
>> >> >>>
>> >> >>> ...and I'm arguing that we're paying a big price for that.
>> >> >>>
>> >> >>> > ARM systems easily support a large number of LPIs per-core.
>> >> >>> > For example, GIC-700 supports 56000 LPIs per-core.
>> >> >>> > (Refer, https://developer.arm.com/documentation/101516/0300/Abo=
ut-the-GIC-700/Features)
>> >> >>>
>> >> >>> Yeah, but this is not the GIC. This is something that looks more =
like
>> >> >>> the x86 world. We'll be stuck with a lot of implementations with =
AIA 1.0
>> >> >>> spec, and many cores.
>> >> >>
>> >> >> Well, RISC-V AIA is neigher ARM GIG not x86 APIC. All I am saying
>> >> >> is that there are systems with large number per-core interrupt IDs
>> >> >> for handling MSIs.
>> >> >
>> >> > Yes, and while that is nice, it's not what IMSIC is.
>> >>
>> >> Some follow-ups, after thinking more about it more over the weekend.
>> >>
>> >> * Do one really need an IPI for irq_set_affinity() for the 1-1 model?
>> >>   Why touch the enable/disable bits when moving interrupts?
>> >
>> > In the 1-1 model, the ID on the current HART and target HART upon
>> > irq_set_affinity will be different so we can't leave the unused ID on
>> > current HART enabled because it can lead to spurious interrupts
>> > when the ID on current HART is re-used for some other device.
>>
>> Hmm, is this really an actual problem, or a theoretical one? The
>> implementation need to track what's in-use, so can we ever get into this
>> situation?
>
> As of now, it is theoretical but it is certainly possible to hit this iss=
ue.

Sorry for being slow here, Anup, but could you give an example how this
could happen? For me it sounds like this could only be caused by a
broken (buggy) implementation?

>> Somewhat related; I had a similar question for imsic_pci_{un,}mask_irq()
>> -- why not only do the the default mask operation (only
>> pci_msi_{un,}mask_irq()), but instead propagate to the IMSIC
>> mask/unmask?
>
> We have hierarchical IMSIC PCI irq domain whoes parent irq domain
> is IMSIC base domain. Unfortunately pci_msi_[un]mask_irq() don't
> work for hierarchical irq domain.

Ok! Thanks for the explanation!

>> > There is also a possibility of receiving an interrupt while the ID was
>> > moved to a new target HART in-which case we have to detect and
>> > re-trigger interrupt on the new target HART. In fact, x86 APLIC does
>> > an IPI to take care of this case.
>>
>> This case I get, and the implementation can track that both are in use.
>> It's the spurious one that I'm dubious of (don't get).
>>
>> >>
>> >> * In my book the IMSIC looks very much like the x86 LAPIC, which also
>> >>   has few interrupts (IMSIC <2048, LAPIC 256). The IRQ matrix allocat=
or
>> >>   [1], and a scheme similar to LAPIC [2] would be a good fit. This is
>> >>   the 1-1 model, but more sophisticated than what I've been describing
>> >>   (e.g. properly handling mangaged/regular irqs). As a bonus we would
>> >>   get the IRQ matrix debugfs/tracepoint support.
>> >>
>> >
>> > Yes, I have been evaluating the 1-1 model for the past few days. I also
>> > have a working implementation with a simple per-CPU bitmap based
>> > allocator which handles both legacy MSI (block of 1,2,4,8,16, or 32 ID=
s)
>> > and MSI-X.
>> >
>> > The irq matrix allocator needs to be improved for handling legacy MSI
>> > so initially I will post a v11 series which works for me and converging
>> > with irq matrix allocator can be future work.
>>
>> What's missing/needs to be improved for legacy MSI (legacy MSI =3D=3D
>> !MSI-X, right?) in the matrix allocator?
>
> For legacy MSI, a block IDs needs to be contiguous and the number
> of IDs can be a power of 2.

Oh, so this is not supported by the matrix allocator?


Bj=C3=B6rn
