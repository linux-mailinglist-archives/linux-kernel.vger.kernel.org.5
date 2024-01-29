Return-Path: <linux-kernel+bounces-43477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D91841466
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 214331F24591
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6167605A;
	Mon, 29 Jan 2024 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmfJNimf"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B4E2E834
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560587; cv=none; b=No5n4iDxQcxMCLd0YrUKb8qUrAyCn6wiRF9J5hNFUHxHjtt4YHaG8O5lMzWJdXYMDWKFVcbg3c+chPt7Jo37sfx64W79Zwk/9YISYrcxepOW6/hniS7GAWJEnsNr6TpzrFTD6dBSMCKQva1dKjDfxjUwFldutyJDDYJ7n6MagCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560587; c=relaxed/simple;
	bh=jmfLZ2+7pN7JofKmXg1xYnNEo44gbiC1PDeMaQAIhS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dGyiq0ogxxyz4gdRht/1xJJ5p7brf/bTuCRsWCd88TDtteZriDXSfF/zpZH0X4EkwiZzI09KsPmijaNF9vRHqroHutcJSIHo/87TZ1mZkPsO7uahtSLVWXv+VbbZWCqEQMcCad/rLOaTIxGOm28QAW3eiB6dgdfbBQBZfAvdrfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmfJNimf; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d5ce88b51cso45035ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706560584; x=1707165384; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZxWgZjR7stXfQ+YDnMHNeKFVDof3/JXTOW+q6qvfTSY=;
        b=dmfJNimflQdk/0YNE1YOgmYHWsKEs5X1YC5JrL1Ul48bSyzT9kr6rjhxMF6mu2BOvt
         8GHPdwAD2ypMh1+tyEDSvltkaL/i+6EKZ9dUtGRNlSU4sQiaDaAYEg0ll47Q/mdMMvLL
         sqb4UEJFaEc8xP0tp4w29aVlmqO6mx47bWOf/BydZbHFXMkFYnxa1grADwyEpyISMzTm
         a0jXzfZv57NuKSg1O0HyawsKC8UaTPD0MaAX5NNPrGjjqIXsYvZCcGySgPeSUfRqgesd
         VTtW6bl8kBemr/hAtGiJ4tIJ0DS7rdYAgf56/Pb8ooYkGsk9WdBEotk+J+0NrH1oci7T
         LvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706560584; x=1707165384;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxWgZjR7stXfQ+YDnMHNeKFVDof3/JXTOW+q6qvfTSY=;
        b=r9+475sCdrgQepLC9lgNErSKC82PyOc9k5DphFxGRVK0nJew1WbFLX/T2nMqOVQSpx
         TQtTj8t3pzf8hrQAnjSRayVGowtLnV1j1tSyYZ1Na8KutcshV0MZ1j5lhi7tvgr23WST
         +06aKBDZ07WLbojpLU56T6/vU6QHZ3qOUl/+4v0yOnsjeOPU8+cNydjGNQ/bA/TU0Gd9
         IwNnEU7HPFneDPP5nd4F2PDBhKvuDeVv4ALfcoUEsTanSvlc4mxk27pRNSE+CZtGnUiF
         UjTZit25zw0CR3tn8bPE9AtiTN64/UYLBFB9LeHBXPdvQoPFWny6YLrxtYWRqWR+bUN5
         QOCQ==
X-Gm-Message-State: AOJu0YxZtgJWhc5IiNutKWE8GsitSY5vrUhv/Ky2X1xvdRezgpvnOEUj
	iXR2EexNCU/FNkiBaRO9RmAhhhhWcX5q4mUfhObKifYsb7GO7GQW9IdcBlJMs+8R7m5fWE7HRxF
	KGw==
X-Google-Smtp-Source: AGHT+IFYoSEdwRBnKk4ZFEQZtXte9ans7MKYcm6dZiU1nm5l+23BeLVQ+oGKofdTxe/FZVgZazUwUw==
X-Received: by 2002:a17:902:684f:b0:1d8:b0bf:3e3f with SMTP id f15-20020a170902684f00b001d8b0bf3e3fmr46602pln.26.1706560583515;
        Mon, 29 Jan 2024 12:36:23 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090274cc00b001d72358de29sm2315356plt.287.2024.01.29.12.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 12:36:21 -0800 (PST)
From: Benjamin Segall <bsegall@google.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Will Deacon <will@kernel.org>,  Waiman Long <longman@redhat.com>,  Boqun
 Feng <boqun.feng@gmail.com>,  linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] locking/percpu-rwsem: do not do lock handoff in
 percpu_up_write
In-Reply-To: <20240127112039.896-1-hdanton@sina.com> (Hillf Danton's message
	of "Sat, 27 Jan 2024 19:20:39 +0800")
References: <xm26zfwx7z5p.fsf@google.com>
	<20240123150541.1508-1-hdanton@sina.com>
	<20240125110456.783-1-hdanton@sina.com>
	<20240126122230.838-1-hdanton@sina.com>
	<20240127112039.896-1-hdanton@sina.com>
Date: Mon, 29 Jan 2024 12:36:20 -0800
Message-ID: <xm26o7d33mij.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hillf Danton <hdanton@sina.com> writes:

> On Fri, 26 Jan 2024 12:40:43 -0800 Benjamin Segall <bsegall@google.com>
>> 
>> I'm fine with "no, fairness is more important than these performance
>> numbers or mitigating already-sorta-broken situations", but it's not
>
> Fine too because your patch is never able to escape standing ovation.
>
> And feel free to specify the broken situations you saw.

The basic locking issue was due to userspace rapidly spawning threads
(or processes) more rapidly than the cpus they are running on can
support, and this causing issues for unrelated threads doing cgroup
operations on other cpus.

The contention can be due to a combination of just straight up spawning
way too many, userspace misconfiguration of cpus allowed, or load
balancer weaknesses. (If you pick minimum cpu.shares values and have
large machines, SCHED_LOAD_RESOLUTION isn't really enough for load
balance to do a good job, and what you're telling the load balancer you
want isn't really a good idea in the first place).

>
>> clear to me you've even understood the patch, because you keep only
>> talking about completely different forms of starvation, and suggesting
>
> Given woken writer in your reply and sem->ww is write waiters, there is
> only one starvation in this thread.

The problem is *not* new readers/writers coming in and taking the lock
before the waiting ones, which is what your patch would solve. The
problem is that some of the woken readers do not get scheduled for a
long time, and nothing can take the lock until they do.


