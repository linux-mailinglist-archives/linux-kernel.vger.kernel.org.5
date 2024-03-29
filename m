Return-Path: <linux-kernel+bounces-125171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB389219F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95D5B24A06
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C34686146;
	Fri, 29 Mar 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHAzbDH1"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B54664C;
	Fri, 29 Mar 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729682; cv=none; b=QcJrfo0wPMv5T9z23JQvHVjmhBIOJtGSeH1Z8SzClVL0aLa9J2CjjjbcV7/RGMXSX4+DeE3dWDgSvNmTk4Iag569kRMhTLXcgoFr7tJ669Niwfwa+NmeqiNovSoZIqcAJW59JQO0474zpgv0PwYxdUOVfde6CbHYIkCf+mL/GEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729682; c=relaxed/simple;
	bh=ofVTq6gm3R5jjKPD6kHA8iOuIKaOrH9lW0lqKfFNJqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tir3orUmCfLhlu21yhnBXwB1FFLgmBv8Bmw4LjdZ56lGuuBPc9w160jQPvAGNvmgUQa+yBmX0v47veUkWtp4VNRDAtgcDXL6iV5sAAj/r965K4rGzHO2eqkpcHcys0IB0Ot9AIM+Ze9aSNugkOutSOGiuNx1mecEII1+bk+x7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHAzbDH1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso1657718a12.2;
        Fri, 29 Mar 2024 09:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711729681; x=1712334481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxggmW6FG2LusZiwV++bHWnPbSjOWz2PLOsIKM1Zc58=;
        b=aHAzbDH1DDoPoVtREvfxxiRuAnNAlyi+dKZ0TYwTGT9NTyI8C0QBR1kh83DCieuyuj
         WB6c4MmJCKsU+bXx9rJTr8P+gpCELGQ6Bb9PwydQXrc8TPqH4BaeyzQw2+WWaLAo5SlG
         UrwiFl9iv4GpUzyxyNHzN6yTPmuNz9+sbQHl1PesMZ2W1rNHs403l8Lyb3lDZ4e06p+5
         qDi3UaFni0Tu3zChRRg6lkLy4m3iZfb2zKi5d8FdZKPsbSDcahPlDAsktFnCwFxmlEDM
         ld6dOhsShJij1VZwY83N9jCI9ajLnZuvN2Eu6BVNOU/V0rNFmhEO/q6aGVWLFJiMLMYx
         TOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729681; x=1712334481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxggmW6FG2LusZiwV++bHWnPbSjOWz2PLOsIKM1Zc58=;
        b=k2OivDN3IepINk4YQj8vSe5dgkPoM9xZ6ZPz5jAjNqlDu5jQ30p9qurwVeB0Wj3K7Q
         nSCEzp9uPRVHwsLcsSz4FFgzhfbD44qm4sPgVPqHkHAOREIFG4fJLHVybY2LLN5I83gx
         aHcBPTUvM4JYZwDU+qC9hPap3hzeXZGWFwJPXVG2FHmIjBl7G0PJk/UcSe2TYaemyshW
         7hSYtr0cqulSBV4nj05TMvmvDpD2WrpICIsC3k2MaG4yeG5ArQTZmD0ToNssVYFgc5gF
         6TJWrumzHqAgh2jS3p3Ok5WghN1ev2MgNJaNF+1Tg3kN3PAm9+8vtvilz8Z86GPf+PoT
         R2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcyjWxs3V6mrnCkKvJtgKUf81ItrjsYaMM16q068rp3AcLh9CVD9vg2p9k8YLs3vgdyu8LawXeD/YDKjZlLtAyQIz13qXcyKhq/S7ZiKDlM1/ZjhljAduXjHhO6rhuMaCz
X-Gm-Message-State: AOJu0YzJnUIeLmGx1pa090zbV+DjwzSjglPAwjMuqVains4cFM3BpQIG
	0YcGL/IrMr0j4BSs7Ulu/PyfQ7ybyEc1hEIxoQWLI2gAywF8qw2NOqMa+7QK4JaUpagnbfqLimO
	jNBP+12tfY8TTeImZoXdXwf/6BXk=
X-Google-Smtp-Source: AGHT+IF+zE6ivs3MQ7dcO7YHSEIlrPLB+bzOAs9AT5TaWiOn51leuswtmlMQQBp+7mi5ZIPRIALDtO4oSMEQqFhr5Gc=
X-Received: by 2002:a17:90b:4a0a:b0:2a2:191a:e1ed with SMTP id
 kk10-20020a17090b4a0a00b002a2191ae1edmr1317700pjb.4.1711729680691; Fri, 29
 Mar 2024 09:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328133359.731818-1-andrii@kernel.org> <e6a59310-a3de-4ba8-96b2-dd123069d0ad@amd.com>
In-Reply-To: <e6a59310-a3de-4ba8-96b2-dd123069d0ad@amd.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Mar 2024 09:27:48 -0700
Message-ID: <CAEf4BzYKArxcAFSLuOSeMNsi0M9y1LuDPmQhTEhGvqkRg4BzSQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf/x86/amd: support capturing LBR from software events
To: Sandipan Das <sandipan.das@amd.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, song@kernel.org, kernel-team@meta.com, x86@kernel.org, 
	peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 2:29=E2=80=AFAM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> On 3/28/2024 7:03 PM, Andrii Nakryiko wrote:
> > [0] added ability to capture LBR (Last Branch Records) on Intel CPUs
> > from inside BPF program at pretty much any arbitrary point. This is
> > extremely useful capability that allows to figure out otherwise
> > hard-to-debug problems, because LBR is now available based on some
> > application-defined conditions, not just hardware-supported events.
> >
> > retsnoop ([1]) is one such tool that takes a huge advantage of this
> > functionality and has proved to be an extremely useful tool in
> > practice.
> >
> > Now, AMD Zen4 CPUs got support for similar LBR functionality, but
> > necessary wiring inside the kernel is not yet setup. This patch seeks t=
o
> > rectify this and follows a similar approach to the original patch [0]
> > for Intel CPUs.
> >
> > Given LBR can be set up to capture any indirect jumps, it's critical to
> > minimize indirect jumps on the way to requesting LBR from BPF program,
> > so we split amd_pmu_lbr_disable_all() into a wrapper with some generic
> > conditions vs always-inlined __amd_pmu_lbr_disable() called directly
> > from BPF subsystem (through perf_snapshot_branch_stack static call).
> >
> > Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
> > point, there is no reason to artificially limit this feature to samplin=
g
> > events. So corresponding check is removed. AFAIU, there is no
> > correctness implications of doing this (and it was possible to bypass
> > this check by just setting perf_event's sample_period to 1 anyways, so
> > it doesn't guard all that much).
> >
> > This was tested on AMD Bergamo CPU and worked well when utilized from
> > the aforementioned retsnoop tool.
> >
> >   [0] https://lore.kernel.org/bpf/20210910183352.3151445-2-songliubravi=
ng@fb.com/
> >   [1] https://github.com/anakryiko/retsnoop
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Changes look good to me.
>
> Reviewed-by: Sandipan Das <sandipan.das@amd.com>

Thanks for your review! Will split out the check removal, as Ingo
asked, and will post v3, thanks!

>
> > ---
> >  arch/x86/events/amd/core.c   | 29 ++++++++++++++++++++++++++++-
> >  arch/x86/events/amd/lbr.c    | 11 +----------
> >  arch/x86/events/perf_event.h | 11 +++++++++++
> >  3 files changed, 40 insertions(+), 11 deletions(-)
> >

[...]

