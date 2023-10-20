Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159F07D142A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377931AbjJTQhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 12:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377917AbjJTQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 12:37:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2580CD61
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 09:37:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135ABC433C8;
        Fri, 20 Oct 2023 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697819823;
        bh=IKXvz0RUOrs45XsQ+nGeRi2+3vpHR0dpcPyszdbrLks=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lR5fdsD0B7Ja2DIlG2phhgKJMnrg2aCf29I5oI3aZ01AECEmI83bTQAnOBquAHRoL
         R6BbfjbR1MA/CaHZZdLprChXP+eI/qjH7yAzXCBGg7S0wECCIxhkoYGyErYC8GsOeJ
         xMPGTl/EWmXNcCjDGotZzvRAtKjtPfuzf9T4PlKQdfkveTcqe/7Q0dpqt1o2KyPEQi
         gp8ZQkBsKm0httkDFFBJT0PUwQpIQpCQpjS4FGNRB4oyk2UzX2TEcHJL6OCWcb5ncm
         OVjBlosCRgO3FxzGD0FDAjXVCDj15AMsyITSzIJhzspdrDIasZNufPOOR7hX9pZQDj
         MiwmO6sZ2ElLA==
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
In-Reply-To: <CAK9=C2WVkbDtz9uZTNjEcJzKQ44cHLR=+nSVZZmSptzL_U4NNA@mail.gmail.com>
References: <20231003044403.1974628-1-apatel@ventanamicro.com>
 <87o7gu7mo9.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2XMzzYri8TNBASKqc-VmJWjGdoOHy-fczksfkU0ahhgOQ@mail.gmail.com>
 <87h6mlbryy.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2VE9-L49tMKHjSTGDSpOFZGZw14LtD1V4GMXGiVQ-A=ng@mail.gmail.com>
 <87o7gtpdb4.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2WVkbDtz9uZTNjEcJzKQ44cHLR=+nSVZZmSptzL_U4NNA@mail.gmail.com>
Date:   Fri, 20 Oct 2023 18:36:59 +0200
Message-ID: <87v8b1i72s.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anup Patel <apatel@ventanamicro.com> writes:

> On Fri, Oct 20, 2023 at 8:10=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>>
>> Anup Patel <apatel@ventanamicro.com> writes:
>>
>> > On Fri, Oct 20, 2023 at 2:17=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@k=
ernel.org> wrote:
>> >>
>> >> Thanks for the quick reply!
>> >>
>> >> Anup Patel <apatel@ventanamicro.com> writes:
>> >>
>> >> > On Thu, Oct 19, 2023 at 7:13=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjor=
n@kernel.org> wrote:
>> >> >>
>> >> >> Hi Anup,
>> >> >>
>> >> >> Anup Patel <apatel@ventanamicro.com> writes:
>> >> >>
>> >> >> > The RISC-V AIA specification is ratified as-per the RISC-V inter=
national
>> >> >> > process. The latest ratified AIA specifcation can be found at:
>> >> >> > https://github.com/riscv/riscv-aia/releases/download/1.0/riscv-i=
nterrupts-1.0.pdf
>> >> >> >
>> >> >> > At a high-level, the AIA specification adds three things:
>> >> >> > 1) AIA CSRs
>> >> >> >    - Improved local interrupt support
>> >> >> > 2) Incoming Message Signaled Interrupt Controller (IMSIC)
>> >> >> >    - Per-HART MSI controller
>> >> >> >    - Support MSI virtualization
>> >> >> >    - Support IPI along with virtualization
>> >> >> > 3) Advanced Platform-Level Interrupt Controller (APLIC)
>> >> >> >    - Wired interrupt controller
>> >> >> >    - In MSI-mode, converts wired interrupt into MSIs (i.e. MSI g=
enerator)
>> >> >> >    - In Direct-mode, injects external interrupts directly into H=
ARTs
>> >> >>
>> >> >> Thanks for working on the AIA support! I had a look at the series,=
 and
>> >> >> have some concerns about interrupt ID abstraction.
>> >> >>
>> >> >> A bit of background, for readers not familiar with the AIA details.
>> >> >>
>> >> >> IMSIC allows for 2047 unique MSI ("msi-irq") sources per hart, and
>> >> >> each MSI is dedicated to a certain hart. The series takes the appr=
oach
>> >> >> to say that there are, e.g., 2047 interrupts ("lnx-irq") globally.
>> >> >> Each lnx-irq consists of #harts * msi-irq -- a slice -- and in the
>> >> >> slice only *one* msi-irq is acutally used.
>> >> >>
>> >> >> This scheme makes affinity changes more robust, because the interr=
upt
>> >> >> sources on "other" harts are pre-allocated. On the other hand it
>> >> >> requires to propagate irq masking to other harts via IPIs (this is
>> >> >> mostly done up setup/tear down). It's also wasteful, because msi-i=
rqs
>> >> >> are hogged, and cannot be used.
>> >> >>
>> >> >> Contemporary storage/networking drivers usually uses queues per co=
re
>> >> >> (or a sub-set of cores). The current scheme wastes a lot of msi-ir=
qs.
>> >> >> If we instead used a scheme where "msi-irq =3D=3D lnx-irq", instea=
d of
>> >> >> "lnq-irq =3D {hart 0;msi-irq x , ... hart N;msi-irq x}", there wou=
ld be
>> >> >> a lot MSIs for other users. 1-1 vs 1-N. E.g., if a storage device
>> >> >> would like to use 5 queues (5 cores) on a 128 core system, the cur=
rent
>> >> >> scheme would consume 5 * 128 MSIs, instead of just 5.
>> >> >>
>> >> >> On the plus side:
>> >> >> * Changing interrupts affinity will never fail, because the interr=
upts
>> >> >>   on each hart is pre-allocated.
>> >> >>
>> >> >> On the negative side:
>> >> >> * Wasteful interrupt usage, and a system can potientially "run out=
" of
>> >> >>   interrupts. Especially for many core systems.
>> >> >> * Interrupt masking need to proagate to harts via IPIs (there's no
>> >> >>   broadcast csr in IMSIC), and a more complex locking scheme IMSIC
>> >> >>
>> >> >> Summary:
>> >> >> The current series caps the number of global interrupts to maximum
>> >> >> 2047 MSIs for all cores (whole system). A better scheme, IMO, woul=
d be
>> >> >> to expose 2047 * #harts unique MSIs.
>> >> >>
>> >> >> I think this could simplify/remove(?) the locking as well.
>> >> >
>> >> > Exposing 2047 * #harts unique MSIs has multiple issues:
>> >> > 1) The irq_set_affinity() does not work for MSIs because each
>> >> >      IRQ is not tied to a particular HART. This means we can't
>> >> >      balance the IRQ processing load among HARTs.
>> >>
>> >> Yes, you can balance. In your code, each *active* MSI is still
>> >> bound/active to a specific hard together with the affinity mask. In an
>> >> 1-1 model you would still need to track the affinity mask, but the
>> >> irq_set_affinity() would be different. It would try to allocate a new
>> >> MSI from the target CPU, and then switch to having that MSI active.
>> >>
>> >> That's what x86 does AFAIU, which is also constrained by the # of
>> >> available MSIs.
>> >>
>> >> The downside, as I pointed out, is that the set affinity action can
>> >> fail for a certain target CPU.
>> >
>> > Yes, irq_set_affinity() can fail for the suggested approach plus for
>> > RISC-V AIA, one HART does not have access to other HARTs
>> > MSI enable/disable bits so the approach will also involve IPI.
>>
>> Correct, but the current series does a broadcast to all cores, where the
>> 1-1 approach is at most an IPI to a single core.
>>
>> 128+c machines are getting more common, and you have devices that you
>> bring up/down on a per-core basis. Broadcasting IPIs to all cores, when
>> dealing with a per-core activity is a pretty noisy neighbor.
>
> Broadcast IPI in the current approach is only done upon MSI mask/unmask
> operation. It is not done upon set_affinity() of interrupt handling.

I'm aware. We're on the same page here.

>>
>> This could be fixed in the existing 1-n approach, by not require to sync
>> the cores that are not handling the MSI in question. "Lazy disable"
>
> Incorrect. The approach you are suggesting involves an IPI upon every
> irq_set_affinity(). This is because a HART can only enable it's own
> MSI ID so when an IRQ is moved to from HART A to HART B with
> a different ID X on HART B then we will need an IPI in irq_set_affinit()
> to enable ID X on HART B.

Yes, the 1-1 approach will require an IPI to one target cpu on affinity
changes, and similar on mask/unmask.

The 1-n approach, require no-IPI on affinity changes (nice!), but IPI
broadcast to all cores on mask/unmask (not so nice).

>> >> My concern is interrupts become a scarce resource with this
>> >> implementation, but maybe my view is incorrect. I've seen bare-metal
>> >> x86 systems (no VMs) with ~200 cores, and ~2000 interrupts, but maybe
>> >> that is considered "a lot of interrupts".
>> >>
>> >> As long as we don't get into scenarios where we're running out of
>> >> interrupts, due to the software design.
>> >>
>> >
>> > The current approach is simpler and ensures irq_set_affinity
>> > always works. The limit of max 2047 IDs is sufficient for many
>> > systems (if not all).
>>
>> Let me give you another view. On a 128c system each core has ~16 unique
>> interrupts for disposal. E.g. the Intel E800 NIC has more than 2048
>> network queue pairs for each PF.
>
> Clearly, this example is a hypothetical and represents a poorly
> designed platform.
>
> Having just 16 IDs per-Core is a very poor design choice. In fact, the
> Server SoC spec mandates a minimum 255 IDs.

You are misreading. A 128c system with 2047 MSIs per-core, will only
have 16 *per-core unique* (2047/128) interrupts with the current series.

I'm not saying that each IMSIC has 16 IDs, I'm saying that in a 128c
system with the maximum amount of MSIs possible in the spec, you'll end
up with 16 *unique* interrupts per core.

> Regarding NICs which support a large number of queues, the driver
> will typically enable only one queue per-core and set the affinity to
> separate cores. We have user-space data plane applications based
> on DPDK which are capable of using a large number of NIC queues
> but these applications are polling based and don't use MSIs.

That's one sample point, and clearly not the only one. There are *many*
different usage models. Just because you *assign* MSI, doesn't mean they
are firing all the time.

I can show you a couple of networking setups where this is clearly not
enough. Each core has a large number of QoS queues, and each queue would
very much like to have a dedicated MSI.

>> > When we encounter a system requiring a large number of MSIs,
>> > we can either:
>> > 1) Extend the AIA spec to support greater than 2047 IDs
>> > 2) Re-think the approach in the IMSIC driver
>> >
>> > The choice between #1 and #2 above depends on the
>> > guarantees we want for irq_set_affinity().
>>
>> The irq_set_affinity() behavior is better with this series, but I think
>> the other downsides: number of available interrupt sources, and IPI
>> broadcast are worse.
>
> The IPI overhead in the approach you are suggesting will be
> even bad compared to the IPI overhead of the current approach
> because we will end-up doing IPI upon every irq_set_affinity()
> in the suggested approach compared to doing IPI upon every
> mask/unmask in the current approach.

Again, very workload dependent.

This series does IPI broadcast on masking/unmasking, which means that
cores that don't care get interrupted because, say, a network queue-pair
is setup on another core.

Some workloads never change the irq affinity.

I'm just pointing out that there are pro/cons with both variants.

> The biggest advantage of the current approach is a reliable
> irq_set_affinity() which is a very valuable thing to have.

...and I'm arguing that we're paying a big price for that.

> ARM systems easily support a large number of LPIs per-core.
> For example, GIC-700 supports 56000 LPIs per-core.
> (Refer, https://developer.arm.com/documentation/101516/0300/About-the-GIC=
-700/Features)

Yeah, but this is not the GIC. This is something that looks more like
the x86 world. We'll be stuck with a lot of implementations with AIA 1.0
spec, and many cores.

> In the RISC-V world, we can easily define a small fast track
> extension based on S*csrind extension which can allow a
> large number of IMSIC IDs per-core.
>
> Instead of addressing problems on a hypothetical system,
> I suggest we go ahead with the current approach and deal
> with a system having MSI over-subscription when such a
> system shows up.

I've pointed out my concerns. We're not agreeing, but hey, I'm just one
sample point here! I'll leave it here for others to chime in!

Still much appreciate all the hard work on the series!


Have a nice weekend,
Bj=C3=B6rn
