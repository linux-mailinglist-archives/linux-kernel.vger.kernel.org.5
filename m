Return-Path: <linux-kernel+bounces-25032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E599A82C65E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 21:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFCD1F2494B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 20:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CDD168C0;
	Fri, 12 Jan 2024 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GrSe+ETC"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CCA28ED
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 20:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e5a9bcec9so8445287e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705091438; x=1705696238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1iV+yKY/ABdwUeupGJ6t32ip8oIrhAgFdSd3sB9aqoA=;
        b=GrSe+ETCzUqBwmHykeEw7TlqBZ9o1AbAj8vS9zyOOagKbpQ+VVOApPBOCcsWljreK1
         +CNXNT6nrEkJa6PvSdPMDDlg5FR4XGdmc7AldfxNUq5LNhhIeUEsD4nRXEsJYoGpP663
         gQzwtU5hkuy+NFoC1NQJEU/ysG5xO69KnU7OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705091438; x=1705696238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1iV+yKY/ABdwUeupGJ6t32ip8oIrhAgFdSd3sB9aqoA=;
        b=iabxgntFJxwA0+RZ8goEq/E03b3Ou+cFcltD2aWkR1UTj02PERHT3o/sUDPnYU+2Bf
         RGvV94bCgv9+izoDzybrLq91VCH43M6sbJUsQsTQOXDUw+M0qUoLLZfsjzZsmK3lFBU7
         J/hyCy7GrG7491rvP65/8zOGUGinzE0KbLAzm/63EaTzm7peBQCR6a88Z+MF+S5g5rg4
         a0y9GMvuXbuJAa8HAQ75RyU4sqCxf3+qhFKZQF1dL7w1uEyhPvheeXOr+MutnK5cCGYi
         yei+X+mhe9iXB8AcqPBF2m1vfrKh8lfG4fiCQoblJQH/dNphZZqp1GMzsxh/tiPpeHGF
         McoQ==
X-Gm-Message-State: AOJu0YztsLsGaGW1pujFw/CwsFcfwa981ZezfrxzIfoPfbJHmZOpCAXa
	cT87Jct0ljzK8gNPa9CG3+K8GwY1t0lDRMzaOxsmuFU85A8hYstt
X-Google-Smtp-Source: AGHT+IGz3vI7OkbWee5Uf+ZNdUzPbeX2BtCFt0q6zPqydSDTT8AQMOYasq0BXmSLluCFyCNMoIalwQ==
X-Received: by 2002:a05:6512:1105:b0:50e:5222:7435 with SMTP id l5-20020a056512110500b0050e52227435mr1206997lfg.74.1705091438139;
        Fri, 12 Jan 2024 12:30:38 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id f8-20020a170906494800b00a1f7ab65d3fsm2126532ejt.131.2024.01.12.12.30.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 12:30:36 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28a997f3dfso532840666b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:30:35 -0800 (PST)
X-Received: by 2002:a17:907:2da1:b0:a28:5901:70dd with SMTP id
 gt33-20020a1709072da100b00a28590170ddmr1374018ejc.17.1705091435317; Fri, 12
 Jan 2024 12:30:35 -0800 (PST)
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
 <CAKfTPtBQZcDpiPMF2sjJopNueMe+Lv0cziPzAMAaxH1XbfHiUQ@mail.gmail.com>
In-Reply-To: <CAKfTPtBQZcDpiPMF2sjJopNueMe+Lv0cziPzAMAaxH1XbfHiUQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Jan 2024 12:30:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiwRb50-q6EFU9RgjxOXHC2=x_ddQ6yzWTs5ah0nVeXPw@mail.gmail.com>
Message-ID: <CAHk-=wiwRb50-q6EFU9RgjxOXHC2=x_ddQ6yzWTs5ah0nVeXPw@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Qais Yousef <qyousef@layalina.io>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Ok, so testing a bit more. On a working kernel, when I do an empty
"make" (which is the fast test I've used), it's all single-threaded
because it's just 'make' doing tons of stat calls and string
operations.

And "cat /proc/cpuinfo | grep MHz" shows a nice clear signal:

  ...
  cpu MHz : 2200.000
  cpu MHz : 2200.000
  cpu MHz : 4425.339
  cpu MHz : 2200.000
  ...

so it boosts up to the top boost frequency.

Without the revert, doing the same thing, what I see is very
different. It's all just

  ...
  cpu MHz : 2200.000
  cpu MHz : 2200.000
  cpu MHz : 2200.000
  cpu MHz : 2200.000
  ...

which certainly explains why it takes 45s rather than 22s to do a full
empty build.

Btw, the "full empty build" I do is literally just

    timestamp sh -c "make -j128 > ../makes"

where 'timestamp' is my stupid little wrapper program that just shows
elapsed time as the command is progressing (as opposed to "time",
which just shows it at the end).

Side note: that 4425.339 is very much the boost frequency, 'cpupower' reports

  $ cpupower frequency-info
  analyzing CPU 0:
    driver: acpi-cpufreq
    CPUs which run at the same hardware frequency: 0
    CPUs which need to have their frequency coordinated by software: 0
    maximum transition latency:  Cannot determine or is not supported.
    hardware limits: 2.20 GHz - 3.70 GHz
    available frequency steps:  3.70 GHz, 2.80 GHz, 2.20 GHz
    available cpufreq governors: conservative ondemand userspace
powersave performance schedutil
    current policy: frequency should be within 2.20 GHz and 3.70 GHz.
                  The governor "schedutil" may decide which speed to use
                  within this range.
    current CPU frequency: Unable to call hardware
    current CPU frequency: 2.20 GHz (asserted by call to kernel)
    boost state support:
      Supported: yes
      Active: no

and for all I know the scheduler got confused by the fact that it
thinks the hardware limits are 2.2-3.7 GHz. But the 3970X has a boost
frequency of 4.5GHz, and yes, I very much want it.

I will test Vincent's test-patch next.

                Linus

