Return-Path: <linux-kernel+bounces-23972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CFA82B4AA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791F41F25F74
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CAF53816;
	Thu, 11 Jan 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAHStZxh"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A4352F74
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cdbc7bebecso2477879a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 10:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704996989; x=1705601789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DIGTPxSUQMK04RZ3/HlDw07M+fndzwXuVoi9HmaACM8=;
        b=hAHStZxh+hDcRjhrQTVka8253fvh/QyKBJovK9EA9NHmIHkWk76kndvD/Xt4ZTKA3/
         SI2HiB44QsLbUHD1r18RZzRe7v4vvpuPCYrTBaZrHUHFHvgFNP/QUfFsS5xktPqu7kv7
         lL2Mv8NJ4MS70z6G8NOFeeEhwm9fil/DjzyLbx6kZsqXXLPDBFzYMOralrZfPb9yNRoq
         gs2+/l0d073Di1LX4sEol4aol26HJ4nFX8CmHXbYVvOzYKWo9QvqdRwc29oTy5y00lhB
         Zh+D07BTfU+WnCIV7mRD+Dz/Z9UzUX6SbC0lgHoOS2YBRaRUN0171sS8CiannCiYjDWs
         qQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704996989; x=1705601789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIGTPxSUQMK04RZ3/HlDw07M+fndzwXuVoi9HmaACM8=;
        b=by60/vTGGCRq92WlpT6akuafJWH5LqYQFrvdgratCP/0MAs8B8CtomSWuYEdPROlNs
         pObV/jmlDjs08fSIQ/H6gZa4cljxn4g8BvECG3eYIpU0LwSSBXXGLCBUvPBaYONZkqJt
         Aoicusk4JFfTX6ZXJOUmv2fYjglORmv3+OGjsydlKvBsdhJdReNYu6WoEvW0lDsMmWS2
         m0b3Fy1+7F4BWxg5N3YWwr2/ZsPF8ljsDTzwiSY3y5kMlOeAwJYTzfBttKpiHVuVXpyE
         Jkl+UKX6PS77aUkpGcebysGJDlA8QdVzpNaaGuNajJy5+GNTXF7nzTIO+AlyvlqUyHBY
         M9JQ==
X-Gm-Message-State: AOJu0YxsVJWJlp7o5222X3/5ZYZZR3N1dMH1GKM6UbUyncm0n3uheQ2a
	tT2Glrz41ghFOn/WNrh1S0PTY4yb1QfhbJ9FqvYFxFGWOdM37Q==
X-Google-Smtp-Source: AGHT+IFEZcHN2XJquUzQAiaMw7L0X98vRHDRasyouzfB/0ndw2QgplMQTYhc8L1GpbK1BGPXduZj0ennaYg4QqIApxs=
X-Received: by 2002:a05:6a21:6d87:b0:199:95cf:7e30 with SMTP id
 wl7-20020a056a216d8700b0019995cf7e30mr224360pzb.93.1704996989252; Thu, 11 Jan
 2024 10:16:29 -0800 (PST)
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
In-Reply-To: <CAHk-=whK-cuBUQ2hECtkGu3LR-ipai+tmB85M=C7n3b1M8B4gQ@mail.gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 11 Jan 2024 19:16:18 +0100
Message-ID: <CAKfTPtCnT9VLqiQGL5kyhzqv=WAUNRA3tVDVoKjB7jX-00Un+g@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 18:53, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 11 Jan 2024 at 09:45, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 11 Jan 2024 at 00:11, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > Could you confirm that cpufreq governor is schedutil and the driver is
> > > amd-pstate on your system ?
> >
> > schedutil yes, amd-pstate no. I actually just use acpi_cpufreq
>
> Bah. Hit 'send' mistakenly too soon, thus the abrupt end and
> unfinished quoting removal.
>
> And don't ask me why it's acpi_pstate-driven. I have X86_AMD_PSTATE=y, but
>
>     /sys/devices/system/cpu/cpufreq/policy0/scaling_driver
>
> clearly says 'acpi-cpufreq'. Maybe I'm looking in the wrong place. My dmesg says

That seems to be the right place to look

>
>     amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
>
> which is presumably the reason my machine uses acpi-pstate.
>
> I will also test out your other questions, but I need to go back and
> do more pull requests first.

ok, thanks

I'm going to continue checking what else could trigger such regression
having in mind that your system should not have beeb impacted by this
changes


>
>               Linus

