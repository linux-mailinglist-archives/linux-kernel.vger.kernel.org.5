Return-Path: <linux-kernel+bounces-147974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C326E8A7C08
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA181C2136D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B704E535D1;
	Wed, 17 Apr 2024 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="plrDSG6r"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1B535A4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713333857; cv=none; b=g7Kbr5U2OAamoSL9jiZ1kNpAbn1mQ+uD4GWUx/zaVhWi4itaIB5aX8zVaSoYfmRHXYtov1D/+FcLX+r3f+7TqNXzV5vDfVK/jdRPPxLQlqn4E706jn5BPtccUKIxLNVWE/CojD/yhz+ZwDCPDGsWblESgtDhWhxg9oQkUMudjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713333857; c=relaxed/simple;
	bh=ZGh2Oun/2Xy3zlhfCoEUmiZx6g9yxMw149Z7Exr23Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYwxfYStoPElDY/rMLE+wAnY7DROurByDdGWKBtLgPcYX1xknfBtX8jDrAVGs/MxmTfJzFbY6rvPGKXVwBRm9BiUK0Lj5ouCkEgLqEknhczXdVB3LEpJnIkJi9IuVa3nSbH8bOavRlNv2vU5NVHORbnyL6tcKVLYms/LiZCuM+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=plrDSG6r; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-36a23d5c31bso24535605ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 23:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713333855; x=1713938655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emlaPvn8yP0ZKbzvbtaqbLqnMofLE1ThVdu9UJ+caJI=;
        b=plrDSG6rF+1Ui28n5YoBXb9UqgVzdjU+/Hz98A4/eRAtSPqPfsklNXTYUfadT8gWXj
         /M9Q9H/RORgs1zrXuDHHj99saYhBSaX/rx7mGD/RdqD7iDxztMzW+1MIVyMYTqVPbAvh
         15MpIItXKlQUpSXB+OTgD4npc5b3AVKlySYBEMps5GCr6ywQSxYgPw9MvPHpsdq+pZg4
         3bH24uW/LQamR7FtjTLHXS5rjCe7erkUoDpSLCQI5q8lZMbvbsRsJTtmcVQzyYJLiY4N
         8EkLEBD2myOcvj44051OZ4x3W+TPov/hX2lEoFps4S7uQRQdh7VAInht002hlgztjZ5a
         sWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713333855; x=1713938655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emlaPvn8yP0ZKbzvbtaqbLqnMofLE1ThVdu9UJ+caJI=;
        b=GPPzH7lCMU0qDnlyjbm0RS2jIvRh427p276pecMUajde0hB9+rTzy9E9mcFJtZQSSn
         /vR8T5/nKJVzwaNQEiECPPbK94IJEx0aZG9YltfLAGOp3AOSo9rc55C0735PqM8AGaka
         SYf3bs2+4G4UQ3dlHNAdm0by1ah4S3q1snjv/mfGKxzqU7mzxfp5lJR6Y3S8Q/TOQ50u
         Mer0Z48air5uCBd6gjmCkHUqZyGEstL8+P6R0FLvVwmME+dLKxtLU6fEGgCJ2wbhF3M5
         n5vgzKf4rlqnuWL33Rf3zAV40n9MqtX759N/NFPWxfQ+1pAslJrAxLntyYXe6MJdN84m
         V3VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSFc+hMLsFMvn0Z6YtYv8xuir+3gUUFjz5OwV1gvw8MMItqClToLIuk1yOkClbuTs2cVG8iwDnPKu2z1s1/QjMBydw4iQpl/F8qUay
X-Gm-Message-State: AOJu0YzTPzBTPPLxEKV3jhr334Uix3lfnP+V/5DVXSSzLSjJ6O3MfRyy
	Tc6unc2+jftM5QEJXnHrtAoZX8MpCPHzYRemk00+xZzHbDLo6Gq7oXn+fYNxGCeT4IqCOX8/6Lq
	r8RKXHzP7CD3uy3cNPDiu2s360OOuyjlylnEnAA==
X-Google-Smtp-Source: AGHT+IFlY+Fttl28efbIUi6jVfI4wTI04bDmnQk+zKphR7HN3pZ9C0TAL7sTYl5WjTiT2L3Bv4yly414b6+rK4o0b8A=
X-Received: by 2002:a92:c542:0:b0:36b:a3:bc93 with SMTP id a2-20020a92c542000000b0036b00a3bc93mr17521625ilj.5.1713333855283;
 Tue, 16 Apr 2024 23:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK9=C2Vsq0iN5FW=zC7+2GHe115TPJOEEPcDCLs_40yBGpbVdw@mail.gmail.com>
 <mhng-3a5fcdd0-0bf4-45d3-aa7d-fffddd852288@palmer-ri-x1c9a>
In-Reply-To: <mhng-3a5fcdd0-0bf4-45d3-aa7d-fffddd852288@palmer-ri-x1c9a>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 17 Apr 2024 11:34:02 +0530
Message-ID: <CAAhSdy0YJ7STirgtZpdBGGBT6HB19CdN_Fe0ywhd8SSF2iXJqg@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/timer-riscv: Drop extra CSR write
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: apatel@ventanamicro.com, samuel.holland@sifive.com, 
	daniel.lezcano@linaro.org, tglx@linutronix.de, aou@eecs.berkeley.edu, 
	Paul Walmsley <paul.walmsley@sifive.com>, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 7:20=E2=80=AFAM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Wed, 13 Mar 2024 09:56:34 PDT (-0700), apatel@ventanamicro.com wrote:
> > On Wed, Mar 13, 2024 at 1:03=E2=80=AFAM Samuel Holland
> > <samuel.holland@sifive.com> wrote:
> >>
> >> On riscv32, the time comparator value is split across two CSRs. We wri=
te
> >> both when stopping the timer, but realistically the time is just as
> >> unlikely to reach 0xffffffff00000000 as 0xffffffffffffffff, so there i=
s
> >> no need to write the low CSR.
> >
> > Even though unlikely, there is still a theoretical possibility of
> > counter reaching value 0xffffffff00000000.
>
> I guess that depends on the timebase frequency, but if my math is right
> then we've got some timers that will overflow a 32-bit counter in 10
> minutes -- take that with a grain of salt as they're all 64-bit systems
> (we don't have any 32-bit DTs upstream?), but it still seems plausible
> for 32-bit overflows to happen here on real systems.
>
> > The good thing about value 0xffffffffffffffff is that the counter will
> > immediately wrap around after reaching it.
>
> I'm not sure how that's good?  Luckily we've got ~100,000 years to
> figure out, even on these systems with pretty fast timers ;)

The RISC-V server soc spec mandates timer frequency to be at least
100 MHz so we can certainly have 100MHz as the timer frequency
and based on this time CSR will overflow in roughly 5840 years. Also,
nothing stops a SoC vendor from having a GHz timer frequency.

In addition to timer frequency, changing the initial value of time CSR
can also impact when the time CSR overflows. This particularly applies
to virtualization because KVM RISC-V allows the KVM user space tool
to set the desired initial value of time CSR visible to the Guest/VM.

For example, if the timer frequency is 10MHz and KVM user space
tool sets initial time CSR value to 0xffffffff_00000000 then Guest/VM
time CSR will overflow in roughly 7 mins.

Regards,
Anup

>
> > Regards,
> > Anup
> >
> >
> >>
> >> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> >> ---
> >>
> >>  drivers/clocksource/timer-riscv.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/t=
imer-riscv.c
> >> index e66dcbd66566..eaaf01f3c34b 100644
> >> --- a/drivers/clocksource/timer-riscv.c
> >> +++ b/drivers/clocksource/timer-riscv.c
> >> @@ -35,9 +35,10 @@ static bool riscv_timer_cannot_wake_cpu;
> >>  static void riscv_clock_event_stop(void)
> >>  {
> >>         if (static_branch_likely(&riscv_sstc_available)) {
> >> -               csr_write(CSR_STIMECMP, ULONG_MAX);
> >>                 if (IS_ENABLED(CONFIG_32BIT))
> >>                         csr_write(CSR_STIMECMPH, ULONG_MAX);
> >> +               else
> >> +                       csr_write(CSR_STIMECMP, ULONG_MAX);
> >>         } else {
> >>                 sbi_set_timer(U64_MAX);
> >>         }
> >> --
> >> 2.43.1
> >>
> >>
>

