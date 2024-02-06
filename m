Return-Path: <linux-kernel+bounces-54519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 099E784B031
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0EB4B25190
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1914412EBDE;
	Tue,  6 Feb 2024 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVx0oG7s"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD212C7E4;
	Tue,  6 Feb 2024 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707208965; cv=none; b=jIrLmWWo/d0v6gvCHCbzhK6fFw9XagGE3npnv9J0zHhgiCwPKz915l3DAKpbe1fu4+YT0rO9uHfAFFccdqQ65QqDSsx0X53684WjzNV1ra+dxerC49kxco6FJmFlpOP6RK+lOudf84BaMk821xwwF2L+806k6TAHCMWG96Z983M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707208965; c=relaxed/simple;
	bh=Xra9uIettsqlejbTwgl4RaBulJHo8XpiY9JZgYuDOH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZz01h9ScVYMTY1Fy7dgmKHQPDzJrPtjoqQnfoTwJ/AmAovd0aojevHWay7ZqDB2h+KQ9JLgbwwLJNUkYmGJqQ8lgvh8Q17rsyAsq0K28woNZge8HFy0WzxK66jBsoINtr0x38BM+kJeh5iP12QW9+5HmEBRQEmmYJchLfuI+o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVx0oG7s; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b40208735so1047269f8f.3;
        Tue, 06 Feb 2024 00:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707208962; x=1707813762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRz+fl1vMOSU9qlDEq2lb1aXX2zcI26N8x0T+ksleSc=;
        b=nVx0oG7sjEXPKSOdbOL/lrrM6xg/S44Vl6lNPjFdcTJKbwdcrk7I9CfNgDQxYaBOzT
         Us5VNDMBdZ22k8CLImt4GVhoCCWsVaS6hYuhVgXgJLVrECjeDiJOphfdSJTBhqyOJA63
         z8Pq4PyVZnLjIAZskqF9Kx7nkJL6cy9Gx1xVVHpWsSlYHYmd8LSadQklOpoCKybkAHUv
         GwQx761HthX/T5O18VxAh01HPjy8yO24Sukj1LMCnx22SbXSLacUoHn1zkw74makbRje
         7rrFJ/UhJoPeLxOdvOIeUD6jmOJNSZ5CgPk9kTwP6AS0GdlmSJF8pt1g9BclPma4ctVE
         9QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707208962; x=1707813762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRz+fl1vMOSU9qlDEq2lb1aXX2zcI26N8x0T+ksleSc=;
        b=xCoRDIEIqRoW26bsD4wOm7WM4PmJ+Um/p1ZYRQUYMX4R+dyItoqDx420/uYtsDk5gY
         oKmZwebRFfIhYW5lkwpADpoGyUmc90zP6vE2VJZ6KOvXB2tPwyIS9J7oo1tZMbT/jsYc
         FGjuOZtcAK0xggRO8pFaI1yNAZYxIA8TqtqDckswacVR7Y9BmljxbkwUpOlb5zfWYfH3
         YyqQRGasanyUobiBqHrxiXusf2A9+MU4YwnEP/aL6dOK2PmzEf+6GAVYkFS2otMiHsQ8
         nToI/7DJpV06T8qVQv3GqKPSJ7qG42O8SGnvg4d5QxNfRSGcsgDW24dJU/dfn20oY57X
         zXiA==
X-Gm-Message-State: AOJu0YzPSpwS6Ezj6rUI40RMlNJBKoLsO37DeH8G/MxQKXh2wuYfGGCf
	YdHLZc97+yzA/QKMvugMNicVbrDrEWUQDKx2uIrGZ+6F0VfLOa4O02OMH4Em7UrzZo0zoOxqK5N
	qOonDydCfFwBv8UNcUXO612tqZEc=
X-Google-Smtp-Source: AGHT+IFV1XWxS8tcuJKurVxhm37o/Feyf29TJzs2ECwD8y+UBPAQnNudzSZ7jomWmHJDOyJFzoS6IOpmBkHhFyfVcDc=
X-Received: by 2002:adf:a1d0:0:b0:33b:1544:af23 with SMTP id
 v16-20020adfa1d0000000b0033b1544af23mr761337wrv.8.1707208961587; Tue, 06 Feb
 2024 00:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcDwoce6Ok25K6Dm@FVFF77S0Q05N> <xhsmhmssehp6t.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
In-Reply-To: <xhsmhmssehp6t.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
From: richard clark <richard.xnu.clark@gmail.com>
Date: Tue, 6 Feb 2024 16:42:25 +0800
Message-ID: <CAJNi4rMiGcP4wdA=1dSOXwYXOKSCWnN8FYxBaFdaAXBqAU_ePQ@mail.gmail.com>
Subject: Re: Question about the ipi_raise filter usage and output
To: Valentin Schneider <vschneid@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, nico@fluxnic.net, 
	mhiramat@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 12:05=E2=80=AFAM Valentin Schneider <vschneid@redhat=
com> wrote:
>
> On 05/02/24 14:39, Mark Rutland wrote:
> > [adding Valentin]
> >
>
> Thanks!
>
> > On Mon, Feb 05, 2024 at 08:06:09AM -0500, Steven Rostedt wrote:
> >> On Mon, 5 Feb 2024 10:28:57 +0000
> >> Mark Rutland <mark.rutland@arm.com> wrote:
> >>
> >> > > I try to write below:
> >> > > echo 'target_cpus =3D=3D 11 && reason =3D=3D "Function call interr=
upts"' >
> >> > > events/ipi/ipi_raise/filter
> >> >
> >> > The '=3D' checks if the target_cpus bitmap *only* contains CPU 11. I=
f the cpumask
> >> > contains other CPUs, the filter will skip the call.
> >> >
> >> > I believe you can use '&' to check whether a cpumask contains a CPU,=
 e.g.
> >> >
> >> >    'target_cpus & 11'
> >>
> >> 11 =3D=3D 0xb =3D b1011
> >>
> >> So the above would only be true for CPUs 0,1 and 3 ;-)
> >
> > Sorry, I misunderstood the scalar logic and thought that we treated:
> >
> >       '$mask $OP $scalar', e.g. 'target_cpus & 11'
> >
> > .. as a special case meaning a cpumask with that scalar bit set, i.e.
> >
> >       '$mask $OP CPUS{$scalar}', e.g. 'target_cpus & CPUS{11}'
> >
> > .. but evidently I was wrong.
> >
> >> I think you meant: 'target_cpus & 0x800'
> >>
> >> I tried "1 << 11' but it appears to not allow shifts. I wonder if we s=
hould add that?
> >
> > Hmm... shouldn't we make 'CPUS{11}' work for that?
> >
>
> It /should/ already be the case, the user input with the curly braces is
> parsed as a cpulist. So CPUS{11} really does mean CPU11, not a hex value =
to
> be interpreted as a cpumask.
>
> However...
>
> > From a quick test (below), that doesn't seem to work, though I think it
> > probably should?
> > Have I completely misunderstood how this is supposed to work, or is tha=
t a bug?
> >
>
> The CPUS{} thingie only works with an event field that is either declared=
 as a
> cpumask (__cpumask) or a scalar. That's not the case for ipi_raise, the
> target_cpus event field is saved as a "raw" bitmask.
>
> There /should/ have been a warning about the event filter though, but I
> think it's not happening because I'm allowing more than just FILTER_CPUMA=
SK
> in parse_pred() to make it work for scalars. I'll go poke around some mor=
e.
>
> Generally for this sort of IPI investigation I'd recommend using the newe=
r
> trace_ipi_send_cpu() and trace_ipi_send_cpumask() (for which CPUS{}
> filtering works).
> If it's only the function call interrupts you're interesting in, have a
> look at trace_csd_queue_cpu().

This should be supported by newer version kernels like v6.5, but I am
using v6.1 and this trace event has not been supported yet... so ipi
is more suitable for me. ipi_entry and ipi_exit is ok, but seems the
filter doesn't support a specific cpu, maybe we need to add this?
>
> > Mark.
>

