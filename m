Return-Path: <linux-kernel+bounces-2894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CE48163E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 01:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C06B21A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7EC23C2;
	Mon, 18 Dec 2023 00:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dB+wwYE4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0376D2107
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e2bd8c396so1144425e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 16:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702861074; x=1703465874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUdHF1MxkAooUSLHF4kQjIZjImBNrzkIpbjt/k8iX6w=;
        b=dB+wwYE4pIVhiOtorR4WddajmTIciHXtX2Gp7vOZl2tFhCBqVlGYUfZriQzxWeLRcy
         pSJknvyEltLEsVlkoD5QMrDfa7ltszTPybiTyBLbdf/binFyxea7Tg1flDFFUyOtH4XG
         eneH+L8xMdedZUQ1VYE29ngy9phnJpF0kVRmh55TzV9oouo/t1pNZ//cmQKvEeCqfIc2
         E1Xlmy8/oPLsupPU86R0fAq1S7SwDVPnWAcDNr9SZvIQOyYJxn4jW/I70beH3plLdB6s
         9OlfvbPrnnjuP9pEKFEcuuoI7/q4Rek5hLM5x+tJu7gac1qqT3HnYxILWgjjwRSv3Rli
         3Meg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702861074; x=1703465874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUdHF1MxkAooUSLHF4kQjIZjImBNrzkIpbjt/k8iX6w=;
        b=E9tzJydeX0R41DzIYWGG+Lft0f7HaBGP8LHD9pID9/iXw8kExq1oFZjzROV5zBDT98
         2n4UA4fgUVgyembaoNCVZSNcMTuOa/R06QYWUKhFcxrL0VvIocFoO+WwNN6gK+jEDsU/
         E0eJnLA++T0mMeI8lAwTDB6uWDro1Qr47lwy2mD/vgZ/WETLqT3E86ve3c6o9V/F7rG3
         oFoROwwNU7BKEpIvX0sjvrQHFp4JK5L5yQ6I5+o2K3EbdjtaA3669QjDwPQKYRYmk5QE
         z16TMSAwVGAHykX2OH5dW1B9krqDZYMA86joqQu7+c/9PJaMW4truO/Z3N6Xva8/Ntd1
         4FIA==
X-Gm-Message-State: AOJu0Yw41WYgreve0V7Nus5MGk6MPvUolnDZEVefzkn0HtEX5x+ziZdR
	YItVq5dLkZsyGpHMg5w1w7xFDYtiBZoGDVa94SoWp1wPk2xRqW29+bM=
X-Google-Smtp-Source: AGHT+IEU/WHI1h/ykMV4VNrgx/RATuTIz8NW32NhEYWQF3ndy6wdTfdQBKd77OhDQIGgHWDz6r4TaShSH8NUihvKhm8=
X-Received: by 2002:ac2:4c4e:0:b0:50e:1b7a:59a2 with SMTP id
 o14-20020ac24c4e000000b0050e1b7a59a2mr3353284lfk.86.1702861073964; Sun, 17
 Dec 2023 16:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205024310.1593100-1-atishp@rivosinc.com> <20231205024310.1593100-7-atishp@rivosinc.com>
 <20231207-daycare-manager-2f4817171422@wendy> <CAHBxVyE3xAAj=Z_Cu33tEKjXEAcnOV_=Jpkpn-+j5MoLj1FPWw@mail.gmail.com>
 <20231217-navigate-thirsty-03509850a683@spud>
In-Reply-To: <20231217-navigate-thirsty-03509850a683@spud>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Sun, 17 Dec 2023 16:57:42 -0800
Message-ID: <CAHBxVyFQ2+NYeb77zqMofHQC0zD5_Ye2cGk6Zsc+KHKm4zE5mw@mail.gmail.com>
Subject: Re: [RFC 6/9] drivers/perf: riscv: Implement SBI PMU snapshot function
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, Guo Ren <guoren@kernel.org>, 
	Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 4:10=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sat, Dec 16, 2023 at 05:39:12PM -0800, Atish Kumar Patra wrote:
> > On Thu, Dec 7, 2023 at 5:06=E2=80=AFAM Conor Dooley <conor.dooley@micro=
chip.com> wrote:
> > > On Mon, Dec 04, 2023 at 06:43:07PM -0800, Atish Patra wrote:
>
> > > > +static void pmu_sbi_snapshot_free(struct riscv_pmu *pmu)
> > > > +{
> > > > +     int cpu;
> > >
> > > > +     struct cpu_hw_events *cpu_hw_evt;
> > >
> > > This is only used inside the scope of the for loop.
> > >
> >
> > Do you intend to suggest using mixed declarations ? Personally, I
> > prefer all the declarations upfront for readability.
> > Let me know if you think that's an issue or violates coding style.
>
> I was suggesting
>
> int cpu;
>
> for_each_possible_cpu(cpu)
>         struct cpu_hw_events *cpu_hw_evt =3D per....()
>

That's what I meant by mixed declarations.

> I've been asked to do this in some subsystems I submitted code to,
> and checkpatch etc do not complain about it. I don't think there is any
> specific commentary in the coding style about minimising the scope of
> variables however.
>

I didn't know any subsystem which prefers mixed declaration vs upfront.

> > > > +     /* Free up the snapshot area memory and fall back to default =
SBI */
> > >
> > > What does "fall back to the default SBI mean"? SBI is an interface so=
 I
> > > don't understand what it means in this context. Secondly,
> >
> > In absence of SBI PMU snapshot, the driver would try to read the
> > counters directly and end up traps.
> > Also, it would not use the SBI PMU snapshot flags in the SBI start/stop=
 calls.
> > Snapshot is an alternative mechanism to minimize the traps. I just
> > wanted to highlight that.
> >
> > How about this ?
> > "Free up the snapshot area memory and fall back to default SBI PMU
> > calls without snapshot */
>
> Yeah, that's fine (modulo the */ placement). The original comment just
> seemed truncated.
>

ok.

> > > > +     if (ret.error) {
> > > > +             if (ret.error !=3D SBI_ERR_NOT_SUPPORTED)
> > > > +                     pr_warn("%s: pmu snapshot setup failed with e=
rror %ld\n", __func__,
> > > > +                             ret.error);
> > >
> > > Why is the function relevant here? Is the error message in-and-of-its=
elf
> > > not sufficient here? Where else would one be setting up the snapshots
> > > other than the setup function?
> > >
> >
> > The SBI implementation (i.e OpenSBI) may or may not provide a snapshot
> > feature. This error message indicates
> > that SBI implementation supports PMU snapshot but setup failed for
> > some other error.
>
> I don't see what this has to do with printing out the function. This is
> a unique error message, and there is no other place where the setup is
> done AFAICT.
>

Ahh you were concerned about the function name in the log. I
misunderstood it at first.
The function name is not relevant and has been already removed.

> > > > +             /* Snapshot is taken relative to the counter idx base=
. Apply a fixup. */
> > > > +             if (hwc->idx > 0) {
> > > > +                     sdata->ctr_values[hwc->idx] =3D sdata->ctr_va=
lues[0];
> > > > +                     sdata->ctr_values[0] =3D 0;
> > >
> > > Why is this being zeroed in this manner? Why is zeroing it not requir=
ed
> > > if hwc->idx =3D=3D 0? You've got a comment there that could probably =
do with
> > > elaboration.
> > >
> >
> > hwc->idx is the counter_idx_base here. If it is zero, that means the
> > counter0 value is updated
> > in the shared memory. However, if the base > 0, we need to update the
> > relative counter value
> > from the shared memory. Does it make sense ?
>
> Please expand on the comment so that it contains this information.
>

Sure.

> > > > +             ret =3D pmu_sbi_snapshot_setup(pmu, smp_processor_id(=
));
> > > > +             if (!ret) {
> > > > +                     pr_info("SBI PMU snapshot is available to opt=
imize the PMU traps\n");
> > >
> > > Why the verbose message? Could we standardise on one wording for the =
SBI
> > > function probing stuff? Most users seem to be "SBI FOO extension dete=
cted".
> > > Only IPI has additional wording and PMU differs slightly.
> >
> > Additional information is for users to understand PMU functionality
> > uses less traps on this system.
> > We can just resort to and expect users to read upon the purpose of the
> > snapshot from the spec.
> > "SBI PMU snapshot available"
>
> What I was asking for was alignment with the majority of other SBI
> extensions that use the format I mentioned above.
>

PMU snapshot is a function and my previous suggestion aligns PMU
extension availability log message.
I can change it to "SBI PMU snapshot detected"

> >
> > >
> > > > +                     /* We enable it once here for the boot cpu. I=
f snapshot shmem fails during
> > >
> > > Again, comment style here. What does "snapshot shmem" mean? I think
> > > there's a missing action here. Registration? Allocation?
> > >
> >
> > Fixed it. It is supposed to be "snapshot shmem setup"
> >
> > > > +                      * cpu hotplug on, it should bail out.
> > >
> > > Should or will? What action does "bail out" correspond to?
> > >
> >
> > bail out the cpu hotplug process. We don't support heterogeneous pmus
> > for snapshot.
> > If the SBI implementation returns success for SBI_EXT_PMU_SNAPSHOT_SET_=
SHMEM
> > boot cpu but fails for other cpus while bringing them up, it is
> > problematic to handle that.
>
> "bail out" should be replaced by a more technical explanation of what is
> going to happen. "should" is a weird word to use, either the cpuhotplug
> code does or does not deal with this case, and since that code is also
> in the kernel, this patchset should ensure that it does handle the case,
> no? If the kernel does handle it "should" should be replaced with more
> definitive wording.
>

ok. I will improve the comment to explain a bit more.

> Thanks,
> Conor.

