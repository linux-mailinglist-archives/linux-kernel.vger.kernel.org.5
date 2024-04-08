Return-Path: <linux-kernel+bounces-135460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AAC89C3D5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 579BC1C21356
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5807FBB7;
	Mon,  8 Apr 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qah5OmVW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3553C6D1A9;
	Mon,  8 Apr 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712583565; cv=none; b=JZdchjBRjKQO5xDCULxkgXk2QeJ6cKR7s0URcCP5AV0MTK36Y7mQAHm3ANzg9IxjEBGwmBuNtlGYcKkDaql2IAnL27yreNaB+90Wg+EYGueDrLZq/3UmEsNfDvaGtkv/gV8OFCmQ87DepPIXd43oDKmYE+GDBQmegtbznAjHEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712583565; c=relaxed/simple;
	bh=eDWCxs4ziaIZR2XbrKl5zSTz53SQllPV4wWZA5M1SZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/vJe1oSA9WPBIyIT12rRyNenupH7DQjF1+aMdVIdc6OdnDcNQXJbOZ3xAdyTN2aNmw7I6Q21bbyJuC3R+e3v2oieHrd+9y8KR4HqeOyvsYAv99s/4RiFsoYbRlr/iawgpDQH5VsyOdR0tU7fCXZ0NGCckCyDPd69NYi14T/jFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qah5OmVW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27B9C433B1;
	Mon,  8 Apr 2024 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712583565;
	bh=eDWCxs4ziaIZR2XbrKl5zSTz53SQllPV4wWZA5M1SZM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qah5OmVW/27dsQPB7tjYrvQHIiNUVvY5o0Yh/1+idQgrS77heNg3JLXtoCNSbxoqP
	 NsjzQ+j5/L4PgDWSlnD7abmyJ/OxQRW79dwVYiTNuxlYNmTwgu8imgF9gXRvbf+Zdc
	 sA2KniiaQ8Zq5AnOBqbfBxcrRhLE1vBpaBA+w4/Wio22wRe3PbRl+JFyDUQPRK/+hI
	 bhUAByO9aBuwn2/gAj8Er9BqkDMT2GxAQYWw/a9skMAawfWcuCgCsbia+CaFGz2d0A
	 pfHTAbxg17x4A7vnRHClPMS6O5a+8JiIT8eRu7ZQKLJ85gosYZz+iFcIdKS4EAKiD7
	 C1CMMtO7uK/6w==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a4e0859b65so1265220eaf.0;
        Mon, 08 Apr 2024 06:39:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIKZWpBjBhCyBsVa/ix+nc94w1QGqz58VBJjybd9JKUjJRfAjIZwi+lVtbaSIT78zP9WD7KvrZWXtG08egs8jtsAxh86y3FMQ=
X-Gm-Message-State: AOJu0YyVhIC4Va0VBEFRrFymQRC9KikE2eHJ3kQG+68it0pyrMeEzTCc
	oVDRjxocnN6CaE50ShaMv+BISGOP+EaV5XA0SPvzJbCQj6n97fLCgOA3K8JDPValvnpD88ajN4Q
	z/oFzRYJPMIIHsv54L4H1sT9ZV7U=
X-Google-Smtp-Source: AGHT+IEZ4FW+AXR1JGZjLDUrJqqDJHLSLxxUdEhim+3owzY9EeluVIUlB7p+TAhQ5QIXKKM2qzkhh0rfRayq/w2+ivw=
X-Received: by 2002:a4a:d0af:0:b0:5aa:241a:7f4b with SMTP id
 t15-20020a4ad0af000000b005aa241a7f4bmr4920066oor.1.1712583564206; Mon, 08 Apr
 2024 06:39:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405083410.4896-1-anna-maria@linutronix.de>
 <87r0fg5ocg.fsf@somnus> <CAPDyKFo7KT4V8Nvn58N3mNfeW6ai=-5hampjN7N19kYaR7zdVA@mail.gmail.com>
In-Reply-To: <CAPDyKFo7KT4V8Nvn58N3mNfeW6ai=-5hampjN7N19kYaR7zdVA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Apr 2024 15:39:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gUciunPSMsytW_voxx5F=DJURsLQb4TMLepMD6YPUZ-A@mail.gmail.com>
Message-ID: <CAJZ5v0gUciunPSMsytW_voxx5F=DJURsLQb4TMLepMD6YPUZ-A@mail.gmail.com>
Subject: Re: [PATCH v2] PM: s2idle: Make sure CPUs will wakeup directly on resume
To: Ulf Hansson <ulf.hansson@linaro.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 2:43=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Mon, 8 Apr 2024 at 09:02, Anna-Maria Behnsen
> <anna-maria@linutronix.de> wrote:
> >
> > s2idle works like a regular suspend with freezing processes and freezin=
g
> > devices. All CPUs except the control CPU go into idle. Once this is
> > completed the control CPU kicks all other CPUs out of idle, so that the=
y
> > reenter the idle loop and then enter s2idle state. The control CPU then
> > issues an swait() on the suspend state and therefore enters the idle lo=
op
> > as well.
> >
> > Due to being kicked out of idle, the other CPUs leave their NOHZ states=
,
> > which means the tick is active and the corresponding hrtimer is program=
med
> > to the next jiffie.
> >
> > On entering s2idle the CPUs shut down their local clockevent device to
> > prevent wakeups. The last CPU which enters s2idle shuts down its local
> > clockevent and freezes timekeeping.
> >
> > On resume, one of the CPUs receives the wakeup interrupt, unfreezes
> > timekeeping and its local clockevent and starts the resume process. At =
that
> > point all other CPUs are still in s2idle with their clockevents switche=
d
> > off. They only resume when they are kicked by another CPU or after resu=
ming
> > devices and then receiving a device interrupt.
> >
> > That means there is no guarantee that all CPUs will wakeup directly on
> > resume. As a consequence there is no guarantee that timers which are qu=
eued
> > on those CPUs and should expire directly after resume, are handled. Als=
o
> > timer list timers which are remotely queued to one of those CPUs after
> > resume will not result in a reprogramming IPI as the tick is
> > active. Queueing a hrtimer will also not result in a reprogramming IPI
> > because the first hrtimer event is already in the past.
> >
> > The recent introduction of the timer pull model (7ee988770326 ("timers:
> > Implement the hierarchical pull model")) amplifies this problem, if the
> > current migrator is one of the non woken up CPUs. When a non pinned tim=
er
> > list timer is queued and the queuing CPU goes idle, it relies on the st=
ill
> > suspended migrator CPU to expire the timer which will happen by chance.
> >
> > The problem exists since commit 8d89835b0467 ("PM: suspend: Do not paus=
e
> > cpuidle in the suspend-to-idle path"). There the cpuidle_pause() call w=
hich
> > in turn invoked a wakeup for all idle CPUs was moved to a later point i=
n
> > the resume process. This might not be reached or reached very late beca=
use
> > it waits on a timer of a still suspended CPU.
> >
> > Address this by kicking all CPUs out of idle after the control CPU retu=
rns
> > from swait() so that they resume their timers and restore consistent sy=
stem
> > state.
> >
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218641
> > Fixes: 8d89835b0467 ("PM: suspend: Do not pause cpuidle in the suspend-=
to-idle path")
> > Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: stable@kernel.org
>
> Thanks for the detailed commit message! Please add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied as 6.9-rc material, many thanks to everyone involved!

