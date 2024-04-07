Return-Path: <linux-kernel+bounces-134370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D493C89B0BF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 594CEB21308
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C605322F14;
	Sun,  7 Apr 2024 12:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="xbvjakxY"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0072260A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712492849; cv=none; b=Nsen55gJmsooEMvp52zwp9YJJwM0FwDAqeRlnBvRkDodwkP35hmAj5cN5WRYcGCeoRRGzl5olCVSS96LKX5T6fQQjrJ9MDD8dfsqrEUpi+nOPCWmiocapLmOHc6LwvyPxkW2KktwNvKwH39MaQ+xTLT01QkFAUNwFhjm0Skahqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712492849; c=relaxed/simple;
	bh=eMt+hiNAqOcpgzcxSCxCT2JFGBal4RUe/em5wQvEJ/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwC1P4L+xs/N7uFOfwvNmUnceJxrVTY86450LxXr6pm/c8Mz6UqeCVj/eIFZSjd6OLIT9nV+4Gz3nl8Jw2ZiFwm4ZsbQXDVL3FeXWJrOZG64sFw9WwkawcNLZt07mwi/AUSesBGrG8peQ4xNLm9RpfOt0fMuJr/GAC3PHG44Yxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=xbvjakxY; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36a0e43afd8so8897405ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 05:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1712492847; x=1713097647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QCksRwm8Y76KRAcsLsW6dQLamVP3TZsUMRvQWXJjTE=;
        b=xbvjakxYwmO1ZPKMMgvmLsN5aMIM8HBHm7Z22ZeENWc9LMztk2sWmOuStwDg+/ubaY
         eFLDgkqditYkDvVV6axSDW4rObg8eCBNcD1eG7aWzVFTkl2HRlU4qRA6Jur1h87JBpyx
         bIiEpqN8mf3sXSeINM3TvBT+Ext85taNnQ9O5c1hQnvYSwLmNx05QbyTNRPT3ASwRMkW
         7Z7SuvNhHl0CA4zOwUlhGbTgCYuJJEo/88UuOC6RcpOG9UFOX5rMZJ5hsy635tB7yPK2
         7tfb+whdMnbNNyHOm8FqvslwiPhevwNQmg+chtFzVWo0z3IxRaX40awJvciF2pU32+cJ
         CXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712492847; x=1713097647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9QCksRwm8Y76KRAcsLsW6dQLamVP3TZsUMRvQWXJjTE=;
        b=a2kcrHB9Xl8/Q+cOIrQ8FML0UusmPfnsVO3K6f7Cr71OPCnuI+eqFBlvnyIprx5Jzn
         O3xTyNpmrU7mW9UcotNYueKuz+UKvKIKcmWx8NB1ULa7dyOf0zDqFQYiyvT2bFBFRn4c
         JIjKwqCG402rOm/HlXIu5i/kGKbhkfUcCaeijh96DK9GSAWosmhSldA7G78Vk/Ng8PYz
         Qiqi0xak7T6qk8Ra5Hx849G0ZP0dcd/9gzG1PDWglulouY2itbAjomRo/Sb5YpJDG5f0
         ik2/n5oirw5/ci77BoOVhyPKgG/B8JafW5tB2wBqkcepnHZyQy/C3GURNP6PpDQ0EpIW
         QNbw==
X-Forwarded-Encrypted: i=1; AJvYcCWrq/68TiObj7BsErPH/tK5GT1Iflb3nWLjfKkLYjqAq/OvoOIokKbYMVOwszwBZeBtdX9YOlISXUYnZr4xOERr1I868dZhLr1YDCsu
X-Gm-Message-State: AOJu0YxTFkCKVbA34frFN0LLZmIKwQrAjJ2kabpSNjTK3AVcLSlXuluG
	cVO/0dFURzoDzggjDtBOYB3J0cNbVfXQ38/s2QGXRyZgRXQM4hB18Y+Yj9V72WFOsx+BzEbvepS
	e
X-Google-Smtp-Source: AGHT+IH6X/cjtzxqcqZSVkZOIY9/wN7zfkc0ftq3MjA/SRWJHtHYGY0z/j1+ak4W7Py/xdfx301Q8Q==
X-Received: by 2002:a05:6e02:221f:b0:368:efa4:bdff with SMTP id j31-20020a056e02221f00b00368efa4bdffmr8052557ilf.22.1712492847139;
        Sun, 07 Apr 2024 05:27:27 -0700 (PDT)
Received: from airbuntu ([205.220.129.238])
        by smtp.gmail.com with ESMTPSA id vu8-20020a05620a560800b0078a3871bdf3sm2239832qkn.4.2024.04.07.05.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 05:27:26 -0700 (PDT)
Date: Sun, 7 Apr 2024 13:27:00 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, Yabin Cui <yabinc@google.com>
Subject: Re: [PATCH] sched/pi: Reweight fair_policy() tasks when inheriting
 prio
Message-ID: <20240407122700.ns7gknqwqkpjjyd4@airbuntu>
References: <20240403005930.1587032-1-qyousef@layalina.io>
 <CAKfTPtDB8D6bouxJN9q8gXqG+BQYcsrJYEodDWtOB2kQwPH53A@mail.gmail.com>
 <20240404220500.dmfl2krll37znbi5@airbuntu>
 <CAKfTPtDP7if0gozSrnj+E_hH5xR-vpGAM2TwN4qWXcg5BtrEtw@mail.gmail.com>
 <20240405171653.boxbylrdak5fopjv@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240405171653.boxbylrdak5fopjv@airbuntu>

On 04/05/24 18:16, Qais Yousef wrote:

> > 
> > All that to say that I think the weight is not applied on purpose.
> > This might work for your particular case but there are more changes to
> > be done if you want to apply prio inheritance between cfs tasks.
> > 
> > As an example, what about the impact of cgroup on the actual weight
> > and the inherited priority of a task ? If the owner and the waiter
> > don't belong to the same cgroup their own prio is meaningless... task
> > nice -20 in a group with a weight equal to nice 19 vs a task nice 19
> > in a group with a weight equals to nice -20
> 
> That is on my mind actually. But I thought it's a separate problem. That has to
> do with how we calculate the effective priority of the pi_task. And probably
> the sorting order to if we agree we need to revert the above. If that is done

Thinking more about it the revert is not the right thing to do. We want fair
tasks to stay ordered in FIFO for better fairness and avoid potential
starvation issues. It's just the logic for searching the top_waiter need to be
different. If the top_waiter is fair, then we need to traverse the tree to find
the highest nice value. We probably can keep track of this while adding items
to the tree to avoid the search.

For cgroup; is it reasonable (loosely speaking) to keep track of pi_cfs_rq and
detach_attach_task_cfs_rq() before the reweight? This seems the most
straightforward solution and will contain the complexity to keeping track of
cfs_rq. But it'll have similar issue to proxy execution where a task that
doesn't belong to the cgroup will consume its share..

Can we treat the two as separate problems? Or you think any solution must
address the two? Both must be fixed of course.


Thanks!

--
Qais Yousef

