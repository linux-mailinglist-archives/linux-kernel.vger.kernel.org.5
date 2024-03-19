Return-Path: <linux-kernel+bounces-107602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D7F87FEFB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7B79B23857
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A118004F;
	Tue, 19 Mar 2024 13:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLfDnbn3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D62B9A3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855688; cv=none; b=aA8JUPyD9Q1/Fnkcdu802DhJoEKcginj6itb1vGC54uboBGKF/dShc0oPnvo8cdHS1mVoriWNfQBIQ6vRrbdQt9EwKCB6WEBc439yu7WaDS6paGbhjbKyxI8/Deoj65R2x4bIuliUkXfUdr49tH0GSdkgmoiTiuyLVzUbcyFtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855688; c=relaxed/simple;
	bh=I2Bft1gTAELIt+NlJwNPw+KuZGb/cW9fyLb6r2g3/QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOpkH78XdjDVF95bN0juZa7vpU/74K32AQSz9RjKfJtxofqF4SBzlfAYVumJ5IDyo5rOp6cO4hsfYuS6OgWsXtWmm/nLqOm3Sb7KpQ7fYonLEADhK++aL9T+gox1n/WbXpQB6mivHIxWdGBxZ8FG6oqWl9yR23WrgTEHNfud/yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bLfDnbn3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dddbe47ac1so36736215ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 06:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710855686; x=1711460486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QkH9co6nduiKcJJYKmYutH4boWdY0DvPoemwdNHxcDM=;
        b=bLfDnbn3i7wLGp3G/6YGgZfIwu6R7syNWNQlnWHi0SD2plA+Ba+0I6LeIG4zSSJ3yW
         VLyU5J7FQVzke0Sn3XSacpezbXNyLNA+ZuxcI5rQrZ6s8FYjQZ1WxefWSUtsULMgY64y
         u3K6wTRC0rQWM3WZvBEaX+va+d6MhHq4SpCLAjYxnrBsM50TAMMgrmzuSfJy5gfJ1ZQ4
         /YIyz8dNv8YaHlYzimeNgLXSzf54nr/He+f6HxeP2u2tSIGBkYs8vf/UqIM4vsH/dGli
         XUav7y9V9iXyISN3ZOGHbWGzEx+91OhDd8ggtnI/DjD1/D2HqxbLTOYSEfAS8RrU+0dj
         fW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710855686; x=1711460486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkH9co6nduiKcJJYKmYutH4boWdY0DvPoemwdNHxcDM=;
        b=EJlnFNNtHpLh9xLY6ppOn3ktno1KB/N5sUQ4DxescgT+vp6/dcUKuxmFV43VrRmscW
         beUL4+5JukRvVRbjshPIZaJ/dMtVI67xSiC5x8ACyLXTRw1eFbI87E9c+pLcQ6htrL8W
         GMi0Lc0qLAXlemHz34xZlqVAmbrpMPGegHuvT4GxjirbXco6+OU2FiwCG3WaDXcDYKru
         iKj1Vp+JmMtDRyRdhx2N/ZR+AuqhGfRSOMCA9q004QbT5X/BHowEEeBu3AYgPIH6crDM
         NhS9EK7WXNvYfapulKdYZqMzFx4cqbiuX1fwQs8/BHpWy4bELIXrBhwZJl6ImmXo2HMI
         fqhw==
X-Forwarded-Encrypted: i=1; AJvYcCVYugKK7Jx7zblZHagLhgbx2pBSP89f6L1kF/vI7hyL9mWl3SHWaC+BjyNdQ3cjcSIRNXlxbns7Dz0B+gnHGJuUdYK8Hf5NkxAtknD3
X-Gm-Message-State: AOJu0YyGJv5Ft95O6OJS1t2ythfjtoZoHrakeI7cxFu68tnZDZBLIieL
	15R+QD+7juTzD79lOq0b/r0xr1ouQphKlHbdV61hFDpjHGwwdDtmOv848yNgpuCwQ+CgxXk9i3k
	hi3jgCxZ9xSOXvPWVvmKqvKmfrN242tfR4oNXcA==
X-Google-Smtp-Source: AGHT+IEAbi0auRWgIpSpp8odJgiWiLOLp0RBR9BR3RBs5ux9Mb65HmgLxN0vr1fSWZK37iYVFCgfrwQjcZWrsLKnr5s=
X-Received: by 2002:a17:903:2387:b0:1e0:3620:375d with SMTP id
 v7-20020a170903238700b001e03620375dmr3235503plh.17.1710855686271; Tue, 19 Mar
 2024 06:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228161018.14253-1-huschle@linux.ibm.com> <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
 <ZfL/hROYxQudcTuX@DESKTOP-2CCOB1S.> <66c4286e-deaf-44a0-be62-0928529ae73f@arm.com>
 <4b25ab45b762e64b9df09d4d12d8289f@linux.ibm.com>
In-Reply-To: <4b25ab45b762e64b9df09d4d12d8289f@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 19 Mar 2024 14:41:14 +0100
Message-ID: <CAKfTPtDyrsnq-CSFo+upzdOJpuH=JkRzSALad-OL29OvqkK2dg@mail.gmail.com>
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Luis Machado <luis.machado@arm.com>, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Mar 2024 at 10:08, Tobias Huschle <huschle@linux.ibm.com> wrote:
>
> On 2024-03-18 15:45, Luis Machado wrote:
> > On 3/14/24 13:45, Tobias Huschle wrote:
> >> On Fri, Mar 08, 2024 at 03:11:38PM +0000, Luis Machado wrote:
> >>> On 2/28/24 16:10, Tobias Huschle wrote:
> >>>>
> >>>> Questions:
> >>>> 1. The kworker getting its negative lag occurs in the following
> >>>> scenario
> >>>>    - kworker and a cgroup are supposed to execute on the same CPU
> >>>>    - one task within the cgroup is executing and wakes up the
> >>>> kworker
> >>>>    - kworker with 0 lag, gets picked immediately and finishes its
> >>>>      execution within ~5000ns
> >>>>    - on dequeue, kworker gets assigned a negative lag
> >>>>    Is this expected behavior? With this short execution time, I
> >>>> would
> >>>>    expect the kworker to be fine.
> >>>
> >>> That strikes me as a bit odd as well. Have you been able to determine
> >>> how a negative lag
> >>> is assigned to the kworker after such a short runtime?
> >>>
> >>
> >> I did some more trace reading though and found something.
> >>
> >> What I observed if everything runs regularly:
> >> - vhost and kworker run alternating on the same CPU
> >> - if the kworker is done, it leaves the runqueue
> >> - vhost wakes up the kworker if it needs it
> >> --> this means:
> >>   - vhost starts alone on an otherwise empty runqueue
> >>   - it seems like it never gets dequeued
> >>     (unless another unrelated task joins or migration hits)
> >>   - if vhost wakes up the kworker, the kworker gets selected
> >>   - vhost runtime > kworker runtime
> >>     --> kworker gets positive lag and gets selected immediately next
> >> time
> >>
> >> What happens if it does go wrong:
> >> From what I gather, there seem to be occasions where the vhost either
> >> executes suprisingly quick, or the kworker surprinsingly slow. If
> >> these
> >> outliers reach critical values, it can happen, that
> >>    vhost runtime < kworker runtime
> >> which now causes the kworker to get the negative lag.
> >>
> >> In this case it seems like, that the vhost is very fast in waking up
> >> the kworker. And coincidentally, the kworker takes, more time than
> >> usual
> >> to finish. We speak of 4-digit to low 5-digit nanoseconds.
> >>
> >> So, for these outliers, the scheduler extrapolates that the kworker
> >> out-consumes the vhost and should be slowed down, although in the
> >> majority
> >> of other cases this does not happen.
> >
> > Thanks for providing the above details Tobias. It does seem like EEVDF
> > is strict
> > about the eligibility checks and making tasks wait when their lags are
> > negative, even
> > if just a little bit as in the case of the kworker.
> >
> > There was a patch to disable the eligibility checks
> > (https://lore.kernel.org/lkml/20231013030213.2472697-1-youssefesmat@chromium.org/),
> > which would make EEVDF more like EVDF, though the deadline comparison
> > would
> > probably still favor the vhost task instead of the kworker with the
> > negative lag.
> >
> > I'm not sure if you tried it, but I thought I'd mention it.
>
> Haven't seen that one yet. Unfortunately, it does not help to ignore the
> eligibility.
>
> I'm inclined to rather propose propose a documentation change, which
> describes that tasks should not rely on woken up tasks being scheduled
> immediately.

Where do you see such an assumption ? Even before eevdf, there were
nothing that ensures such behavior. When using CFS (legacy or eevdf)
tasks, you can't know if the newly wakeup task will run 1st or not


>
> Changing things in the code to address for the specific scenario I'm
> seeing seems to mostly create unwanted side effects and/or would require
> the definition of some magic cut-off values.
>
>

