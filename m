Return-Path: <linux-kernel+bounces-24991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7516582C5B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6401C21F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E015E99;
	Fri, 12 Jan 2024 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOYWWrHu"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0D15E8E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 19:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28bcc273833so5872050a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705086228; x=1705691028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9dt8X+Vtql8Jk3ZGqAjOBvDvFvpIh/V3y4Jn7PPUwXM=;
        b=oOYWWrHuMlL9dwML7XjDyHl8AAnxtl+mv8aMvcDqsdMUWXTMWJPM93NhJb4cusnOhF
         fwHFI7btQvd0kytiKAi5fDsafsUA9+bUhVDfTxQ7paWq+PXiy2x/fabiapjHMq16Ep3t
         xUn1EVFaSoYupR086KV4p3cgyLEHLOAVReLGZX9lQGGrCEYHNX0BfBOliPG5Fa+mj4mh
         QFOtg5f2p1XxGhImFu6ZIUFo9lOn0UegqT/E8f152tlaJHRAC7p9kXUFdCnovv8zIu4P
         0zxgpCPGqZV1AAvhb9LFFqbRzVS3KnNi4OGnD0ewksIR4+BHUjkJfcK/yETs328PMAyJ
         iD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705086228; x=1705691028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dt8X+Vtql8Jk3ZGqAjOBvDvFvpIh/V3y4Jn7PPUwXM=;
        b=SfYXj1POuzJVSJGxeJkdfWoWB8NXxwdEOpc4akj1E+avTucPkKcdgKoTmw+LcRyeki
         BtUPSekb1/HiAH86gis2Cc5DqrvZzJfUmA6iBZge5+epUWDW7Zx73dNl/RT8FEqy2Nzd
         gOgsWqtxGrKNrTEUK8ikSPYgtMWFl7LDWYtZBsr3zmJITBVnzUxUELZRnraVQyJJPXnb
         /iUdqZfYntmuKUCDcNXIKQEl5Zlo6+T3584pIgJBH/Y1H5Va7YoDBPWyPF87CaIJmfNZ
         JsIJHwlCDTwmQ0swlUEr1gFw/Pne2VSunrZOLZxL+L3IIR/b3QBB1TSscLbHCtgO5SUl
         NP+g==
X-Gm-Message-State: AOJu0YxUu9Gw0XisaXupEMSSccbOAVIaYm+AE4tZiMeyKsy09CJXEhCi
	lfBHfzSw+kryHdgikCWbKlYvsrds6on2DvvChhcz2J3NE+0aqw==
X-Google-Smtp-Source: AGHT+IEc2i4CCGehiyeblPwyJK6L5C3Yzp3nIt1HYspmu9JPO6sC8zQc90uNMxkPLfIYYU5ABmMcHz0JXPIZ/F7wmBc=
X-Received: by 2002:a17:90b:46d8:b0:28c:1bfd:e7ea with SMTP id
 jx24-20020a17090b46d800b0028c1bfde7eamr1800594pjb.27.1705086228258; Fri, 12
 Jan 2024 11:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
 <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
 <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
 <ZZ+ixagkxRPYyTCE@vingu-book> <CAHk-=wj75Er8k4QY-KF34NBCWkDpr3D26XptOpkfDcTyGEA7iA@mail.gmail.com>
 <CAHk-=whK-cuBUQ2hECtkGu3LR-ipai+tmB85M=C7n3b1M8B4gQ@mail.gmail.com>
 <CAKfTPtCnT9VLqiQGL5kyhzqv=WAUNRA3tVDVoKjB7jX-00Un+g@mail.gmail.com>
 <4405adb5-0b16-4716-9542-47d8bb1737ee@arm.com> <20240112181805.bjvrkvvkszdfa7co@airbuntu>
In-Reply-To: <20240112181805.bjvrkvvkszdfa7co@airbuntu>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 12 Jan 2024 20:03:36 +0100
Message-ID: <CAKfTPtBQZcDpiPMF2sjJopNueMe+Lv0cziPzAMAaxH1XbfHiUQ@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Qais Yousef <qyousef@layalina.io>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 19:18, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 01/12/24 15:23, Dietmar Eggemann wrote:
> > On 11/01/2024 19:16, Vincent Guittot wrote:
> > > On Thu, 11 Jan 2024 at 18:53, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > >>
> > >> On Thu, 11 Jan 2024 at 09:45, Linus Torvalds
> > >> <torvalds@linux-foundation.org> wrote:
> > >>>
> > >>> On Thu, 11 Jan 2024 at 00:11, Vincent Guittot
> > >>> <vincent.guittot@linaro.org> wrote:
> > >>>>
> > >>>> Could you confirm that cpufreq governor is schedutil and the driver is
> > >>>> amd-pstate on your system ?
> > >>>
> > >>> schedutil yes, amd-pstate no. I actually just use acpi_cpufreq
> > >>
> > >> Bah. Hit 'send' mistakenly too soon, thus the abrupt end and
> > >> unfinished quoting removal.
> > >>
> > >> And don't ask me why it's acpi_pstate-driven. I have X86_AMD_PSTATE=y, but
> > >>
> > >>     /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
> > >>
> > >> clearly says 'acpi-cpufreq'. Maybe I'm looking in the wrong place. My dmesg says
> > >
> > > That seems to be the right place to look
> > >
> > >>
> > >>     amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
> > >>
> > >> which is presumably the reason my machine uses acpi-pstate.
> > >>
> > >> I will also test out your other questions, but I need to go back and
> > >> do more pull requests first.
> > >
> > > ok, thanks
> > >
> > > I'm going to continue checking what else could trigger such regression
> > > having in mind that your system should not have beeb impacted by this
> > > changes
> >
> > I can't see the regression on my
> >
> >   20-core (40-thread) Intel Xeon CPU E5-2690 v2
> >
> > with 'schedutil' and 'acpi-cpufreq'.
>
> I tried to reproduce on AMD 3900X 12-Core system. I don't see any difference
> in compiling defconfig with and without the two patches reverted. ~1m26s.

Thanks for testing.
I haven't been able to reproduce the problem too. But my system are
quite different

>
> using schedutil and acpi-cpufreq driver too.
>
> I disabled CONFIG_UCLAMP_TASK and that didn't make a difference.
>
> I would have expected the iowait boost to be the more troublesome being the
> more subtle one tbh.

