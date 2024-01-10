Return-Path: <linux-kernel+bounces-22867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521D382A45E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FB91F226F7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA044F88F;
	Wed, 10 Jan 2024 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OAHDw2r3"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A744F61B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 22:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55790581457so4958452a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704927453; x=1705532253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2MyVBNX2RTaW1r7FyIy8YJ/4uKyEfeD9kNrWweEsw00=;
        b=OAHDw2r35G0N6T1rBJtJQgAk5oOGA9bJvtMgGdnDAUze/9tN7gEuYvbg0rCumkDwYN
         tM1AeCwI1L9FSogYcZYieHfEaj+vdFxaxZRPPKDVI92Wzv0kYR75x6itp4KQZF3zzyXf
         oVmHWmuhIcO5ImT74YjKbWHbh025vF4DrB6rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704927453; x=1705532253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2MyVBNX2RTaW1r7FyIy8YJ/4uKyEfeD9kNrWweEsw00=;
        b=B0fdircHPig+DBos6LI1aaCYBNSeCLSHzUw6566Vr+SPFKFgweAPsDY8dqrpFpecHy
         JPhHlW0GhxPf3RRSx6/LEKVV1obZXlKXdbw2LwuFnM5TQfT0AAOkh1o/3CodeM52Xje6
         lQkrnTgFwYtBXAA1fC+wDwdJr5u7YF/n6iVbF+14gK+3DGZOPp6HiF1AyAY7LqvXNwWs
         tkG9jqgOhuOZwGyMH82DXCC8+VLV3ynGnuV68UB96Ii9uwzTJx+DwqUyGMFkKa0Og74r
         5w49/gESN2s7YN4NFn9jmwSttDHl3YnG2Dn7Fo+p9auT4A+3EpxNxqWrPAneilXhPKIW
         z3qg==
X-Gm-Message-State: AOJu0YwNaHkho14bVplFlx9lsttZmRnDGJJ2Iw7lwmqypz3CnV2o3VSy
	rgNdH7uoW+0I1Q9RFj5plM+qTFllhgVbbxLh7M+uemOLwRzQPNyv
X-Google-Smtp-Source: AGHT+IHxUHrQmP+AOWk/p4RV9xJCHZuHXa9fpbTgLe0Z6/P7ziQN9feM0kpXfvN7bArfeN+f872wRA==
X-Received: by 2002:a17:906:371a:b0:a2c:199d:557f with SMTP id d26-20020a170906371a00b00a2c199d557fmr98000ejc.51.1704927453027;
        Wed, 10 Jan 2024 14:57:33 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id n11-20020a170906688b00b00a28e533acabsm2499343ejr.190.2024.01.10.14.57.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 14:57:31 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55790581457so4958424a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:57:31 -0800 (PST)
X-Received: by 2002:a17:906:c1c3:b0:a29:905d:447b with SMTP id
 bw3-20020a170906c1c300b00a29905d447bmr95424ejb.96.1704927450968; Wed, 10 Jan
 2024 14:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTz9RpZxfxysYCmt@gmail.com> <ZZwBi/YmnMqm7zrO@gmail.com>
 <CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com> <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
In-Reply-To: <CAHk-=wiXpsxMcQb7MhL-AxOityTajK0G8eWeBOzX-qBJ9X2DSw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 14:57:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
Message-ID: <CAHk-=wjK28MUqBZzBSMEM8vdJhDOuXGSWPmmp04GEt9CXtW6Pw@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Ingo Molnar <mingo@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 14:41, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It's one of these two:
>
>   f12560779f9d sched/cpufreq: Rework iowait boost
>   9c0b4bb7f630 sched/cpufreq: Rework schedutil governor performance estimation
>
> one more boot to go, then I'll try to revert whichever causes my
> machine to perform horribly much worse.

I guess it should come as no surprise that the result is

   9c0b4bb7f6303c9c4e2e34984c46f5a86478f84d is the first bad commit

but to revert cleanly I will have to revert all of

      b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
      f12560779f9d ("sched/cpufreq: Rework iowait boost")
      9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
performance estimation")

This is on a 32-core (64-thread) AMD Ryzen Threadripper 3970X, fwiw.

I'll keep that revert in my private test-tree for now (so that I have
a working machine again), but I'll move it to my main branch soon
unless somebody has a quick fix for this problem.

                Linus

