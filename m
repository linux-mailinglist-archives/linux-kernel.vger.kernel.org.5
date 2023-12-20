Return-Path: <linux-kernel+bounces-6293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFA18196DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE264288440
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A509BE65;
	Wed, 20 Dec 2023 02:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHNufr01"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599D8F6D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 02:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so3950a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703039853; x=1703644653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJviHCBL4OtjAlOVHOwYy41fgt0CrIMl9t0izWB4/T0=;
        b=MHNufr01XGXc6cHtI/G+ySdQ7uppROfRCRMk83KGz71WODjbIV7Eq5q4i0HHJP7F8Z
         Rwc/MEs4YNGkD8ymTKqRulQLJeSOQLHsTEMi+5vefeaO8Br5wbcECRA8uevRBd+7lwS3
         3phfxG4qPZlpmAS0A66++JHwumlfara4elJeFqAoqatXwqayZgp4XQ0qTubgkHvlXY2N
         7KoDZfi8h3+jicIFpXllXDfys4vQ7GfPxcGQ94+jrBzsXoM30atE+oZKJgEEDXu+KaHI
         q8FGEsXc0oOmLHVOiZLL7Zv6WU0MGaza4liQoKmDlMGs9UxP3z9+DUFjSvEQsJ+2wifs
         3OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703039853; x=1703644653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJviHCBL4OtjAlOVHOwYy41fgt0CrIMl9t0izWB4/T0=;
        b=i7ml1kOpJ0YTcg4lFDVSIsMHesyJROnPqWige0Ad7NB8Bv6iIQCrpQ2SWMT3Tjx5j+
         oljrT6IVRU/D/lgJV2RjVGyN5FoNs2pv1FVKo0yEj9bKL35gPZYEn/13i2bACYS9A0dk
         tlRe0KrYMu19tvhC72W65o5EWjey/POnrpzPtVYxh7VJmYnFq0CXBibaduIFfsx6Lx4U
         bzZaJw5L2TEOLRjyy1txH2u+fEIjudOkjLkjT/uAf5dNFjiuG1jfpvaEmIP+oRcJcf8t
         aYxlBnl2D+7uWTaVENz4heRLus+rNhtjhJd/Df2jdLi4RiZ2yRlrj4G8eNXbDE907fjC
         OizQ==
X-Gm-Message-State: AOJu0Yzi0tKxLiV8tKQ0ZmcO7aNrN4XveaMPQoqROlJKJYTZkIf0RK2M
	oQWsksW90BxGHqN4Aghck83VfDWyPd1zoHPnNRmNH0H9VN4=
X-Google-Smtp-Source: AGHT+IFnyK56HYN4ay1zCIdq9uCAWHN6Ew8jhXDDwXh3WNhxWurzEk5BNkcavt0KJl9KLQdfsTsju6SeOh4Vo2RsTwk=
X-Received: by 2002:a50:9319:0:b0:54c:f4fd:3427 with SMTP id
 m25-20020a509319000000b0054cf4fd3427mr56062eda.7.1703039853437; Tue, 19 Dec
 2023 18:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220001856.3710363-1-jstultz@google.com> <20231220001856.3710363-18-jstultz@google.com>
 <338faf05-e545-4b17-b941-32a4a02adbd4@infradead.org>
In-Reply-To: <338faf05-e545-4b17-b941-32a4a02adbd4@infradead.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 19 Dec 2023 18:37:20 -0800
Message-ID: <CANDhNCqjcUAmQU=8VA7Mzxwh+EU2AgW5zVr2tGh2GFd+7vf=Tg@mail.gmail.com>
Subject: Re: [PATCH v7 17/23] sched: Initial sched_football test implementation
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, 
	Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 4:59=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
> On 12/19/23 16:18, John Stultz wrote:
> []
>
> Is this the referee?

Yea, good point. "ref" is an overloaded shorthand. Will fix.

Thanks also for all the spelling corrections! Much appreciated.
-john

