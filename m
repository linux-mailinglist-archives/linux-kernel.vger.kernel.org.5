Return-Path: <linux-kernel+bounces-25156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE082C8B1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7BBB24684
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610FC18EA9;
	Sat, 13 Jan 2024 01:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MIa+oAqZ"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07FB1862D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 01:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-558b5f4cf29so2008004a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705109110; x=1705713910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hDSTWIej/AfUdbeozH/PkrZfGM7w3fp4DUBNEAxu2os=;
        b=MIa+oAqZiE30LyJkPudTBnvmoGbrFelEj81IT/kPXtxYtYLM3sIBsUCKLVEs1Q5Hoy
         UUU4aMLyo4eIwSBIEE/WdM5YKuRcgU8j+VsKsI7rA67sxc1SltSyOif4J5l72CFD6PQh
         SFMUmEk3PopByDWlGSTZf/oyp2pB6c738w5Bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705109110; x=1705713910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDSTWIej/AfUdbeozH/PkrZfGM7w3fp4DUBNEAxu2os=;
        b=gpZW1TopYMriseUsSxUH1EDOJV8AK7wOeOcUtV0fvU3IkjE/i46Xj6/pqedpIY0IGW
         4sRJtUhxz6bNeXBpknZll5ZQpfqX3H0FUJDzYnlhUINmS/ZB4RK5lEgIHa2OSrCA+SUU
         usJC8XelpxjzH3EVZ3wpWvuLYPBZNiw299n3NAL7FwF0aPtN20L13pyrtd3PguXgBPEp
         xYEk/UlSiptD/EicbKPSiyGfBQ0X6vUlFV9YZ00lawyr9jwxLgFCWY/JVvJfU6Gk7WIn
         mnhqcexU8ZJi3okptr6vhEY6qIoj9oQquj1PCicwzYYrrVIM8dyMJ0gK2im5q1BD1dHR
         817Q==
X-Gm-Message-State: AOJu0Yxb3MnXolg05l2N+ufYKJ+pUXM717EMn875vJpeU8xUOMONQH7d
	Gl7DYf9V5++vMENQ4D0VCbX9gOuAxR6Tyk8v5YXXm+3NZ/Li87xr
X-Google-Smtp-Source: AGHT+IESYWFiNOmJA4YhShNwm2WiasmkmAV4MrBMmooz7a4VVEtMpypCT2VrIyGTTASJ0ydaYRwVFw==
X-Received: by 2002:a05:6402:f81:b0:553:2b99:ce48 with SMTP id eh1-20020a0564020f8100b005532b99ce48mr910545edb.44.1705109110477;
        Fri, 12 Jan 2024 17:25:10 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id h3-20020a0564020e0300b0055788ce07e1sm2359869edh.16.2024.01.12.17.25.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 17:25:08 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so354401466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:25:07 -0800 (PST)
X-Received: by 2002:a17:907:a4c:b0:a27:941f:32a1 with SMTP id
 be12-20020a1709070a4c00b00a27941f32a1mr1322731ejc.58.1705109107418; Fri, 12
 Jan 2024 17:25:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ+ixagkxRPYyTCE@vingu-book> <CAHk-=wj75Er8k4QY-KF34NBCWkDpr3D26XptOpkfDcTyGEA7iA@mail.gmail.com>
 <CAHk-=whK-cuBUQ2hECtkGu3LR-ipai+tmB85M=C7n3b1M8B4gQ@mail.gmail.com>
 <CAKfTPtCnT9VLqiQGL5kyhzqv=WAUNRA3tVDVoKjB7jX-00Un+g@mail.gmail.com>
 <4405adb5-0b16-4716-9542-47d8bb1737ee@arm.com> <20240112181805.bjvrkvvkszdfa7co@airbuntu>
 <CAKfTPtBQZcDpiPMF2sjJopNueMe+Lv0cziPzAMAaxH1XbfHiUQ@mail.gmail.com>
 <CAHk-=wiwRb50-q6EFU9RgjxOXHC2=x_ddQ6yzWTs5ah0nVeXPw@mail.gmail.com>
 <CAHk-=wh-RR5DMb8jttBGT3Y+W0=X=dSBHZxWpNECT4Dw0_1erQ@mail.gmail.com>
 <CAHk-=whCt-Eem=BbDo+f0VoDerYQNbvnPCdh6fcBNDnLyZyvfA@mail.gmail.com> <20240113010432.xe25lxqogxuvl72t@airbuntu>
In-Reply-To: <20240113010432.xe25lxqogxuvl72t@airbuntu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Jan 2024 17:24:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgfS+F+QNbFPurhnZTVLkw4xDOmmaSD3qdQLUoE2VsGTw@mail.gmail.com>
Message-ID: <CAHk-=wgfS+F+QNbFPurhnZTVLkw4xDOmmaSD3qdQLUoE2VsGTw@mail.gmail.com>
Subject: Re: [GIT PULL] Scheduler changes for v6.8
To: Qais Yousef <qyousef@layalina.io>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Juri Lelli <juri.lelli@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jan 2024 at 17:04, Qais Yousef <qyousef@layalina.io> wrote:
>
> That is odd. I can't see how the patch can cause this yet, could you try with
> a different compiler if possible?

I use two different compilers - I do my allmodconfig builds with gcc,
and the kernels I boot with clang, so my problems have been with a
kernel built with

   clang version 17.0.6

but to check that it's not a compiler issue I just did another try
with my current public tip of tree (ie *without* any reverts for this
issue) and gcc:

    gcc version 13.2.1

and the behavior is exactly the same: all cores are stuck at 2.2GHz.

So no, it's not compiler-dependent.

> I usually use perfetto but it should be easy to see frequency updates from
> power/cpu_frequency trace event.
>
>         echo 1 | sudo tee /sys/kernel/tracing/tracing_on
>         echo 1 | sudo tee /sys/kernel/tracing/events/power/cpu_frequency/enable
>         sudo cat /sys/kernel/tracing/trace

Shows absolutely nothing. Or rather, it shows the header with

  # entries-in-buffer/entries-written: 0/0   #P:64

and that's it.

With a *working* kernel, I get events, setting the frequency to either
2.2GHz (idle) or 3.8GHz (work).

IOW, the tracing output is 100% consistent with "that commit breaks everything".

                  Linus

