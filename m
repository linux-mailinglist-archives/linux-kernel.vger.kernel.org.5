Return-Path: <linux-kernel+bounces-30802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B80EC832478
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE981C222D9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B2D523A;
	Fri, 19 Jan 2024 05:57:45 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFCF4A0C;
	Fri, 19 Jan 2024 05:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643865; cv=none; b=UAoiKxvUrOLLJg7yoDXCH9cUh4vRkWqSyJGz+BtLBhAiRABG9tkYa/8QKJcS0pgEt5w4+Y9l3eshbE5E+YAbOrBS93gY4sV+wYIylFzU5c4PxzPMxdU28s9YfODcQCQ2DAuOL7znPfW7V7txsxjVegIHYo4enEFYdy0YbzmoFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643865; c=relaxed/simple;
	bh=YpuHcp6+Ti3Nxz4REWJ5idtkTVRA5Y18LT0RNIdJkOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB/on9237RPDbkUm43TnGqueooGSlk433AHJ8IXaMrCaE0rORRX8hj+w5RkAF2Hvl5JobzynGCiQWJ107xQKRDTMTNLl3L7kG0M1ZIv2zCLNipMSoVT2/QAaTz5Efk8n4LlN3tcDIl/i3mVKEXwZ33Cq6QUASgvz2BaWhRqmkjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso222753a12.3;
        Thu, 18 Jan 2024 21:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705643863; x=1706248663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTo9VBdYCTdMSnliyvMcXcpJ1UufCYRIjm4qXNyfvm4=;
        b=EFqSgkaDqqpjj5Su84qwxpSqftBrbcJEhF4niPnUvkeEPGxMCh9a29ONpTBUBxGw4S
         h0DRiAGqVYpxGjD1C/qYiIEpzSEXyYgokyF/QAf4SgNaxcU5g/eVm5b9kddMVSnAtAfa
         KQkrAUSWUg0kOcPv7Opm+hkyuG0aVZYDlKb75Rzy7cQYxIx3D9jx6By8I1dNwt92JVgN
         OTJIirTMLACDcUiKR0fv6CQV+AhC2g5qNG2/OfK253woTujCDdeAyGroot+3TosSV/t9
         GdyJswK+QI55SlHUuPid8xIui7jCjE9fvnv9BZFxd8Hx22yKQ+Lum0cTZBemk3rXbTC4
         rY+g==
X-Gm-Message-State: AOJu0YypNGx1x/JEbpLm4/SVZMCpbFRbeLgid7Ti05LEazxXkjhekQBK
	Qp9YwG7/gIRleVVSlrZtTt0bvrFpkGv8W2lfN4388BxRft80yiXNOgXitkdwdi0Xk/Fm0Fk2AD9
	8f/MmsNjU5KsuI8+MnrdYiBiidUU=
X-Google-Smtp-Source: AGHT+IGU/4cpjmHUgt6iJLKo574CuwTxb4dYoIjbdba4DX8C8YrzMxXypUEoQr219U1oaKlD86OWqT+WAr9tCmYYfLI=
X-Received: by 2002:a05:6a21:3183:b0:199:6bcb:573 with SMTP id
 za3-20020a056a21318300b001996bcb0573mr2087238pzb.50.1705643863243; Thu, 18
 Jan 2024 21:57:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116170348.463479-1-mark.rutland@arm.com> <8734uwxrca.wl-maz@kernel.org>
 <ZafEFU7kwf6W0_Qx@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZafEFU7kwf6W0_Qx@FVFF77S0Q05N.cambridge.arm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 18 Jan 2024 21:57:32 -0800
Message-ID: <CAM9d7ciYEzX1EQ2tXT-FFK2z6Nid9vM6WgSYDFm-rzx=AWsxOA@mail.gmail.com>
Subject: Re: [PATCH] perf print-events: make is_event_supported() more robust
To: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	Hector Martin <marcan@marcan.st>, Ian Rogers <irogers@google.com>, acme@redhat.com, 
	james.clark@arm.com, john.g.garry@oracle.com, leo.yan@linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	mike.leach@linaro.org, suzuki.poulose@arm.com, tmricht@linux.ibm.com, 
	will@kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Adding Ravi to CC.

On Wed, Jan 17, 2024 at 4:12=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Wed, Jan 17, 2024 at 09:05:25AM +0000, Marc Zyngier wrote:
> > Hi Mark,
> >
> > On Tue, 16 Jan 2024 17:03:48 +0000,
> > Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > Currently the perf tool doesn't deteect support for extneded event ty=
pes
> > > on Apple M1/M2 systems, and will not auto-expand plain PERF_EVENT_TYP=
E
> > > hardware events into per-PMU events. This is due to the detection of
> > > extended event types not handling mandatory filters required by the
> > > M1/M2 PMU driver.
> >
> > Thanks for looking into this.
> >
> > I've given your patch a go on my M1 box, and it indeed makes things
> > substantially better:
> >
> > $ sudo ./perf stat -e cycles ~/hackbench 100 process 1000
> > Running with 100*40 (=3D=3D 4000) tasks.
> > Time: 3.419
> >
> >  Performance counter stats for '/home/maz/hackbench 100 process 1000':
> >
> >    174,783,472,090      apple_firestorm_pmu/cycles/                    =
                         (93.10%)
> >     39,134,744,813      apple_icestorm_pmu/cycles/                     =
                         (71.86%)
> >
> >        3.568145595 seconds time elapsed
> >
> >       12.203084000 seconds user
> >       55.135271000 seconds sys
>
> Thanks for giving that a spin!
>
> > However, I'm seeing some slightly odd behaviours:
> >
> > $ sudo ./perf stat -e cycles:k ~/hackbench 100 process 1000
> > Running with 100*40 (=3D=3D 4000) tasks.
> > Time: 3.313
> >
> >  Performance counter stats for '/home/maz/hackbench 100 process 1000':
> >
> >    <not supported>      apple_firestorm_pmu/cycles:k/
> >    <not supported>      apple_icestorm_pmu/cycles:k/

Hmm.. I guess this should look like apple_firestorm_pmu/cycles/k.
IIRC there was a thread for this, right?

> >
> >        3.467568841 seconds time elapsed
> >
> >       13.080111000 seconds user
> >       53.162099000 seconds sys
> >
> > I would have expected it to count, but it didn't. For that to work, I
> > have to add the 'H' modifier:
>
> Ok, so that'll have something to do with the way the tool chooses which
> perf_evant_attr::exclude_* bits to set. I thought that was the same for p=
lain
> events and pmu_name/event/ events, but I could be mistaken.

I think it sets the attr.exclude_guest by event_attr_init().  Maybe
it's deleted during the missing feature detection logic.  But IIUC
it should work on each PMU separately.

By the way, I really hope the kernel exports caps/exclude_bits
for PMUs so that tools can see which bits are supported.  For
example AMD IBS has CAP_NO_EXCLUDE so setting exclude_guest
will fail to open.  Then it disables the new features added after
that in the missing feature detection logic.

If we know if it doesn't support any exclude bits, then tools can
try other features after removing the bit first.

Thanks,
Namhyung

>
> Is that something you had tried prior to this patch, and did that "just w=
ork"
> with the explicit pmu_name/event/ syntax prior to this patch?
>
> e.g. did something like:
>
>         perf stat -e apple_firestorm_pmu/cycles/k -e apple_icestorm_pmu/c=
ycles/k ./workload
>
> ... happen to work withiout requiring the addition of 'H'?
>
> If so, does that behave the same before/after this patch?
>
> ... and could you run that with '-vvv' and dump the output for comparison=
?
>
> Thanks,
> Mark.

