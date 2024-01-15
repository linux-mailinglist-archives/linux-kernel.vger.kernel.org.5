Return-Path: <linux-kernel+bounces-26025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E333E82DA12
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978EB1F2268B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7433171B0;
	Mon, 15 Jan 2024 13:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="llicJO5i"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F61171A2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3f29fea66so47467585ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705325377; x=1705930177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lgAzS/zHQ4xeL2VQeCafin7hplTfrsTL8fPdzk5Mezg=;
        b=llicJO5im6//9gKJ+8BvdhkXL2+HHPBRBRs7yc+zp/2hk9p3RG5YuuMD7mZ9aoH6AR
         m+gX283B+19BtDcqrZGgucYQOO/QwvNBUbUph03Lz4jzXQYw2ZEU71SiyqO4cz2xx97V
         Ol6lSIvxhncl49TZZz4t0SerR5bRCNYvrGRDYX0jUXayO6igB4msea67hHuLoL2qae0C
         6Su5j+eWBnTYR/l/p2canHlMfSy6ACOoud5yyQu2NI99da5Kw3YQLrSlQziUF3PkQhgs
         xxzDahv+pm1p00COyACDSeRaCayjIHjP3PsAdEC9eCogjJ5bI3N9X0Bi2amOWV45oU+v
         sw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705325377; x=1705930177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgAzS/zHQ4xeL2VQeCafin7hplTfrsTL8fPdzk5Mezg=;
        b=fgoOB01JrzqlEciculjWeCPJOOrGDQ2QqDEB9ist2nnStIWl/Kf4LNmgU3W6wv5Qg6
         yskHzpxkkZWt16AjwHpSoAkzBL1zHsN0Ase2U0y6ZzQuX0OlwT3KKA1tNzfIOaSrshkq
         /nhGsqGOb8XA7J2/xo7yCH5WoTnRiZvqHHjzGRzgenW9O+fT6PlTYW8O0YRzIoDWiqKv
         4MzTdubh2w55X5tQ4JvG7s3DIP1OtYtegcxhd97mAnzR9jRv6ShWhfBD0zutq/J6g8SP
         H8PAlC8QL8cP2ibPFyHVGmMVJBGavOUYRE33A2OXEQXhFddR9crsCb+EypV2sMo3BQqJ
         klHw==
X-Gm-Message-State: AOJu0Yw/NvkMA3vVWC4wm6oXR0DhWIlN7hyASqZhWP0J5kObpiq/1fHG
	8gJW/MT8tb0wh8FSrsJ30G48VSBCA8N4SgUI5I+dILrntDeF3w==
X-Google-Smtp-Source: AGHT+IGYH100Sbg/Mop6AuVHkfA7UU8sn0uNkBF4USi1a4Yepl+dZP88ZQVqww1CLQ2mSYC7ayyhKD6r57O6v5klzTA=
X-Received: by 2002:a17:90b:2cce:b0:28d:2a47:177f with SMTP id
 sx14-20020a17090b2cce00b0028d2a47177fmr2762645pjb.45.1705325377076; Mon, 15
 Jan 2024 05:29:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215130501.24542-1-anna-maria@linutronix.de>
 <c09fb78b-5bf9-4c0b-b93f-10fd19a4ab36@arm.com> <87ttnmiif9.fsf@somnus>
 <06a2561f-557b-4eaa-8f11-75883bbbaef9@arm.com> <87a5pag6q7.fsf@somnus>
 <d0f1617e-0088-4bd9-bea6-e89c63b0e2ae@arm.com> <87mstaioy6.ffs@tglx> <fe5038e1-e06b-41dd-9584-cbd992bef1fe@arm.com>
In-Reply-To: <fe5038e1-e06b-41dd-9584-cbd992bef1fe@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 15 Jan 2024 14:29:26 +0100
Message-ID: <CAKfTPtC3kN7gsgh+W4YZutQDMfs6TeT_F+Y5ba9txcM2jbbX6g@mail.gmail.com>
Subject: Re: [PATCH] sched/idle: Prevent stopping the tick when there is no
 cpuidle driver
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jan 2024 at 13:40, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> Hello Thomas,
>
> On 1/12/24 15:52, Thomas Gleixner wrote:
> > On Fri, Jan 12 2024 at 14:39, Pierre Gondois wrote:
> >> On 1/12/24 11:56, Anna-Maria Behnsen wrote:
> >>> Pierre Gondois <pierre.gondois@arm.com> writes:
> >>>> I agree that the absence of cpuidle driver prevents from reaching deep
> >>>> idle states. FWIU, there is however still benefits in stopping the tick
> >>>> on such platform.
> >>>
> >>> What's the benefit?
> >>
> >> I did the following test:
> >> - on an arm64 Juno-r2 platform (2 big A-72 and 4 little A-53 CPUs)
> >> - booting with 'cpuidle.off=1'
> >> - using the energy counters of the platforms
> >>     (the counters measure energy for the whole cluster of big/little CPUs)
> >> - letting the platform idling during 10s
> >>
> >> So the energy consumption would be up:
> >> - ~6% for the big CPUs
> >> - ~10% for the litte CPUs
> >
> > Fair enough, but what's the actual usecase?
> >
> > NOHZ w/o cpuidle driver seems a rather academic exercise to me.

Don't know if it's really a valid use case but can't we have VMs in
such a configuration ?
NOHZ enabled and no cpuidle driver as VM doesn't manage HW anyway ?

>
> I thought Anna-Maria had a use-case for this.
> I just wanted to point out that this patch could potentially
> increase the energy consumption for her use-case, nothing more,
>
> Regards,
> Pierre
>
> >
> > Thanks,
> >
> >          tglx

