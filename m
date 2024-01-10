Return-Path: <linux-kernel+bounces-22860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DECF82A410
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61BF1F2525A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8224F8A9;
	Wed, 10 Jan 2024 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WIwmPBaN"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E24F8BE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28bf46ea11so824411166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704926494; x=1705531294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k35Q5QIp5MyCO5VamMpz/sosd3XUE8jfAcVkkJ5lw8w=;
        b=WIwmPBaN+fnxhCnsUZpFRiiAwkdKy40erGNezc9/qpWeTaUS7a8SXq2I9uQw2PaFkk
         PUSvzS3Dt/MzEr979OxwuibZwYo3C2xBhHl8sGIBIU92xyYtwjw8y3Ns6jqlAKzVnWEd
         1JPkxG0oxotNg4uvCk+D5ek2s/VMyKE4emPh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704926494; x=1705531294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k35Q5QIp5MyCO5VamMpz/sosd3XUE8jfAcVkkJ5lw8w=;
        b=ZtEU0IrlX93DvGIQkaE17yXb3ZhvZAxs5Cz2kgTRZvGg8GYdWPmxZ4ccC/+rrSEYcN
         V+osPqO9BoqSnJ+EfQVyGDILE1DaGeVMrjFCFkLrtiivBx/Yky7hwpyfs4+AyfmFswbp
         LI+/8PPiFLUUOyCwIESCxDR7Nzf2MH4qy3wxi7PEWjPaPJBqtc3t0lTaXPLhnl0YlB7T
         wSyYxPGTzI7fEyQ1YwSMeooSueCrggg9FsgdcEWUKkV/Jr7R8nKHT126Zt2UsGTcT+7p
         0rTKx8Yo7f96wnPekjCd0nqA1akOJ0MK7eHumYFv/XrLJD3vGChh1fS16iVqYV29J7eg
         sYSw==
X-Gm-Message-State: AOJu0YxQIUMRnJuCCLxAW1WcP0dBRyCCZEfBWy5bWsZzoayzyqAS7R1Q
	kWdNwmIW79wUlWGOr2FsfinM6N9u+xHUM+dKE5qIQ6UMHv/w2vbq
X-Google-Smtp-Source: AGHT+IG9VSi409USpyKYbUV0j0ICoFJvK87emHDKRmy7wNFQLKBCwJ0em+lf2BM1aZpfyr86R7z49w==
X-Received: by 2002:a17:906:a142:b0:a27:d309:b6b8 with SMTP id bu2-20020a170906a14200b00a27d309b6b8mr171973ejb.35.1704926494517;
        Wed, 10 Jan 2024 14:41:34 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id le15-20020a170907170f00b00a2a0212cfe1sm2485362ejc.50.2024.01.10.14.41.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 14:41:34 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28da6285c1so841066166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:41:33 -0800 (PST)
X-Received: by 2002:a17:906:b115:b0:a28:c04e:315b with SMTP id
 u21-20020a170906b11500b00a28c04e315bmr174538ejy.13.1704926493632; Wed, 10 Jan
 2024 14:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com> <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 14:41:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
Message-ID: <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 14:19, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Just a note that I'm currently bisecting into this merge for a
> horrendous performance regression.
>
> It makes my empty kernel build go from 22 seconds to 44 seconds, and
> makes a full kernel build enormously slower too.
>
> I haven't finished the bisection, but it's now inside *just* this
> pull, so I can already tell that I'm going to revert something in
> here, because this has been making my merge window miserable.

It's one of these two:

  f12560779f9d sched/cpufreq: Rework iowait boost
  9c0b4bb7f630 sched/cpufreq: Rework schedutil governor performance estimation

one more boot to go, then I'll try to revert whichever causes my
machine to perform horribly much worse.

             Linus

