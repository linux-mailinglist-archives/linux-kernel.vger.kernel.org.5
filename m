Return-Path: <linux-kernel+bounces-15617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B8C822EE3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66B56B20F93
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518DB19BC3;
	Wed,  3 Jan 2024 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3I4jmmK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FD419BB1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704289681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jRyqnGTHgGZertwD5poNQmcnCT/WACtU9bt3gylthro=;
	b=R3I4jmmKSWHM8rKMkWJ9Q0a5TCw7vnmkJqTqOarlMg/hpd7g41d3WgzJDswv5Yweu2fymv
	hiFJtiABtIWiN3jkNp+6kh3N3lPtP0csRKw4LYr56SgDfE1+9s2TMCXlyKXoNCJKE8A47G
	o2K0B6z50dXcwVfFI/0L0FEQZw/ic8U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-DlXgOt7AMDOv09IRu313mQ-1; Wed, 03 Jan 2024 08:48:00 -0500
X-MC-Unique: DlXgOt7AMDOv09IRu313mQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33677bbd570so7779094f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704289679; x=1704894479;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRyqnGTHgGZertwD5poNQmcnCT/WACtU9bt3gylthro=;
        b=i1V2e+J0tI3INxYxu1n3KvicTCI8j40RRYGO7gkvDfd4U71XKKGffMu8JFxBV7YKDS
         sDMnsTLHqEhF+qSQAB+7Oi8LxKV/wUJ6WBroj7jvq0slhis0aGBryhbRkEo19UZmc7b1
         S0XtZpvTKdd2bxO3CGawJHO5d9GnKghO0C3O2K3sID1IN4P9oq1b+jBRG8ajoMexXnBo
         65j8l6hkhnrchzLR2WVJMC7pGha2S2F7CGNgtYoWIFqNZzVgMsRXzIYuATWjeP0lDJs4
         rdlPheYuE8lJMVW/TslnjyJx0ARpeTfWuMnA0riVnM+mXgOWa6wzrOo1xGbSg1oGonDj
         G5aQ==
X-Gm-Message-State: AOJu0YwoYYQ/cosqEgEU2Pgej8JijHweUGPLc/I7ry26NrsYTq8O5nzF
	z4bPqK7ScPgbpOy475Syqe56Vxlx/CVzLFwuKosxmvlTpMBF51BX+lx3SxlhLkK3aURne5Nxep+
	xsjeMIQ/PJZy+7hV35FDo3PQ/103FZ8b0
X-Received: by 2002:a7b:cd15:0:b0:40d:6f89:a839 with SMTP id f21-20020a7bcd15000000b0040d6f89a839mr4935096wmj.30.1704289679248;
        Wed, 03 Jan 2024 05:47:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtwMkdlJKtUdnR/VRnqV/Ady8X2AgcJ8cYnPeEu7tB5w0tgHAN2G/csQRBTUv3jDBfBN96hw==
X-Received: by 2002:a7b:cd15:0:b0:40d:6f89:a839 with SMTP id f21-20020a7bcd15000000b0040d6f89a839mr4935093wmj.30.1704289678919;
        Wed, 03 Jan 2024 05:47:58 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c470a00b0040d579817b0sm2386420wmo.15.2024.01.03.05.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:47:58 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>,
 Qais Yousef <qyousef@google.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Youssef
 Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, Xuewen
 Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: Re: [PATCH v7 09/23] sched: Fix runtime accounting w/ split exec &
 sched contexts
In-Reply-To: <20231220001856.3710363-10-jstultz@google.com>
References: <20231220001856.3710363-1-jstultz@google.com>
 <20231220001856.3710363-10-jstultz@google.com>
Date: Wed, 03 Jan 2024 14:47:57 +0100
Message-ID: <xhsmhedeyjzoy.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

(I did a reply instead of a reply-all, sorry John you're getting this one twice!)

On 19/12/23 16:18, John Stultz wrote:
> The idea here is we want to charge the scheduler-context task's
> vruntime but charge the execution-context task's sum_exec_runtime.
>
> This way cputime accounting goes against the task actually running
> but vruntime accounting goes against the selected task so we get
> proper fairness.

This looks like the right approach, especially when it comes to exposing
data to userspace as with e.g. top.

I did however get curious as to what would be the impact of not updating
the donor's sum_exec_runtime. A quick look through fair.c shows these
function using it:
  - numa_get_avg_runtime()
  - task_numa_work()
  - task_tick_numa()
  - set_next_entity()
  - hrtick_start_fair()

The NUMA ones shouldn't matter too much, as they care about the actually
running task, which is the one that gets its sum_exec_runtime increased.
task_tick_numa() needs to be changed though, as it should be passed the
currently running task, not the selected (donor) one, but shouldn't need
any other change (famous last words).

Generally I think all of the NUMA balancing stats stuff shouldn't care
about the donor task, as the pages being accessed are part of the execution
context.

The hrtick one is tricky. AFAICT since we don't update the donor's
sum_exec_runtime, in proxy scenarios we'll end up always programming the
hrtimer to the entire extent of the donor's slice, which might not be
correct. Considering the HRTICK SCHED_FEAT defaults to disabled, that could
be left as a TODO.


