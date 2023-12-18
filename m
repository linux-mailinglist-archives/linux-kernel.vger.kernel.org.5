Return-Path: <linux-kernel+bounces-4497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A83B8817E33
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6E428490D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55D8760B3;
	Mon, 18 Dec 2023 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R4TXPB8d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7389E740AB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 23:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso2622a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702942734; x=1703547534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nss6lBRIXjCxmQQ6udJHzTNEIpm4Tthj5bMWYR6jzA=;
        b=R4TXPB8d/oKcykvFCoq6UazEfv5Y4U7sf767mVaJITKRtLR0eGHJZbQvNk7Z9ViNfJ
         5nfpfY+ouUFYeCoaGS29K0Ra2xdfIa0XYc1QGb4T8r32a7I+TvtUIDTaDmP7oeKTBDYf
         v+F5+Z9S1E6rJJXhCRpfnmS5JM56tcNd0bYDJi2ODDoYpyiecs2+Sqxrc3FHwd0Ky7u7
         NrwrtNaLohj7CGrat++ISUuVl/ks73v9/aMhgsZG9667xs67hQRnlUm6iHf7zDBFXbqM
         yCx8vAk1r4/XzQeninJuhdgBZIr2/5cRdkGHMciXnYcFxTTHgplOzAJQ4iGTbYxV2hof
         wPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702942734; x=1703547534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nss6lBRIXjCxmQQ6udJHzTNEIpm4Tthj5bMWYR6jzA=;
        b=lLlHp6GzGkvpkw9UIiFMWoT/9Foe4wJ/6mNgyJAmUBtpTSwSf+To53RY/86vRVThIo
         twZ4rU4HnKP5+I0oyGMf1IV8Hc6U4j3/9caBJXXLCBeqd5WproP1Hw7XuNgX9FX70Rth
         wAfqZz7twh+vyKBNcfCggTkb9N/KMBe3TnTHXnusfKOpfQlIk2C6Pa55KwR6jYHzKUGQ
         Fr1mTGgKTLoxp99sJw873AKuD8+7aBsNfx5oz/G2dg7m/yoNqhMdRaf+nonUlbrnIFyk
         7DRVKDnU9NE5rDc6206dc0ib6RdYyrYVOjNwk7t9fN+WaBOMbT6eW9z6lpJ7OQvWqaKt
         GNaQ==
X-Gm-Message-State: AOJu0YxYaJs6hpYq8oyyvlS1Nf10AQnSRtd6scKGrbNtMtkjdHGDW6dg
	g5YkDhHlhputAQTyZepbxvPNa0iXvpy03lAT3ljxED93dCc=
X-Google-Smtp-Source: AGHT+IHb/jrttaiY+fZVYPuGYEMDy+5A9FslJRPIkOXkaiKshf4hmfdze8zf2xglg5qj2C6BC2EwVDL+KWn0veHY/no=
X-Received: by 2002:a50:9e49:0:b0:553:2840:6aad with SMTP id
 z67-20020a509e49000000b0055328406aadmr76834ede.2.1702942734423; Mon, 18 Dec
 2023 15:38:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106193524.866104-1-jstultz@google.com> <20231217030734.ty7isyjyzgcix7er@airbuntu>
In-Reply-To: <20231217030734.ty7isyjyzgcix7er@airbuntu>
From: John Stultz <jstultz@google.com>
Date: Mon, 18 Dec 2023 15:38:42 -0800
Message-ID: <CANDhNCoC1fo8RoKsQHJUcJiJVAYjD8W+8jHZJ7XS-WpdikkvSQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/20] Proxy Execution: A generalized form of Priority
 Inheritance v6
To: Qais Yousef <qyousef@layalina.io>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E . McKenney" <paulmck@kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 7:07=E2=80=AFPM Qais Yousef <qyousef@layalina.io> w=
rote:
> I am trying to find more time to help with review and hopefully debugging=
 too,
> but as it stands, I think to make progress we need to think about breakin=
g this
> patchset into smaller problems and get them merged into phases so at leas=
t the
> review and actual work done would be broken down into smaller more manage=
able
> chunks.
>
> From my very birds eye view it seems we have 3 elements:
>
>         1. Extend locking infrastructure.
>         2. Split task context into scheduling and execution.
>         3. Actual proxy_execution implementation.
>
> It seems to me (and as ever I could be wrong of course) the first 7 patch=
es are
> more or less stable? Could you send patch 1 individually and the next 6 p=
atches
> to get the ground work to extend locking reviewed and merged first?

So I'm working hard to get v7 out the door here, but your general
suggestion here sounds fair.

Part of why I've not pushed as hard to get the first initial patches
in, is that the earlier changes to rework things are mostly done in
service of the later proxy exec logic, so it may be a little hard to
justify the churn on their own.  Also, I've been hoping to get more
discussion & feedback around the big picture - but I suspect the size
& number of the changes makes this daunting.

That said, if Peter is up for it, I'd be happy if the initial chunks
of the series were to be considered to be pulled in.

> After that we can focus on splitting the task context into scheduling and
> execution (and maybe introduce the PROXY_EXEC config along with it) but w=
ithout
> actually implementing the inheritance, etc parts? Just generally teaching=
 the
> scheduler these now are 2 separate parts.

The majority of that is done in a single patch:
https://github.com/johnstultz-work/linux-dev/commit/9e3b364f3724ed840137d68=
1876268b0ad67a469

There we start to have separate names, but at least until we are doing
the proxying, the rq->curr and rq_selected() will be the same task.

> Are 1 and 2 dependent on each other or can be sent as two series in paral=
lel
> actually?

Technically, I think they can be done in parallel. Though I'm not sure
if managing and submitting multiple patch series is easier or harder
for folks to review.

> Hopefully this should reduce the work a lot from continuously rebasing th=
ese
> patches and focus on the last part which is the meaty and most difficult =
bit
> IIUC. Which I hope we can break down too; but I have no idea at the momen=
t how
> to do that.

Rebasing hasn't been the major problem, but wrangling the large patch
set has. For v7 I got a lot of offlist feedback, and propagating those
changes through the full fine-grained stack makes even trivial changes
to early patches quite laborious.

As for breaking down the rest, I thought the v6 series had later
patches broken down fairly well:
1) Just local rq proxying (where the owner happens to be on the current rq)
2) Add proxy migration & return migration, so we can boost tasks on remote =
rqs
3) Sleeping owner enqueueing (so we get woken and added to the rq the
owner gets woken on)
...

And I have the fine-grained version that is even more split up so I
could test each small change at a time:
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v6-6.6-fi=
ne-grained

But I'm open to other suggestions.

> Merging in parts will help with giving each part a chance to soak individ=
ually
> in mainline while the rest is being discussed. Which would make handling
> potential fall overs easier too.

Again, I think this would be great.

I'll try to get v7 out the door so folks can once more consider the
big picture, but then maybe I'll send out the earlier changes more
frequently.

thanks
-john

