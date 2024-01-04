Return-Path: <linux-kernel+bounces-16513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B953D823F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FAAEB226DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388E20DD2;
	Thu,  4 Jan 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PimzDzdY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874F20B12
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704364730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UBsofFS/gKrGHJmrD7vxg1XvYsRw/h2z5LmDFHSmzrw=;
	b=PimzDzdY5sNi8daa6UiT8WNCxBOZvyyjeA/Cm60PY8uECNase8UkRQsu9pmPZjkhNMxhVq
	vT+2NL/6PckKUhoBJ4+1QvmQE5vKyYcyLpwQt13Sm6dl8CWtUD92WcRYtjRpEXT8GnvXRz
	E3QckJ2zfGIsAVlpaEUUzRk59V+SRhU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-enNxeBIPNPueHODMRSoRNA-1; Thu, 04 Jan 2024 05:38:48 -0500
X-MC-Unique: enNxeBIPNPueHODMRSoRNA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3368250f2a3so233923f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 02:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704364727; x=1704969527;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBsofFS/gKrGHJmrD7vxg1XvYsRw/h2z5LmDFHSmzrw=;
        b=S7BZpvSAeN2Gjp41iEIK1AbJEliOLMGOkdj6mFlUkMdXnz5xqbq++RCJcfI5QC/g1c
         jcYydNfdRJbJTJ61/Q2kCtzphQPgdumtVn87/jAxI4V71xsA57/NLh4T5lU6YxHWFG81
         M+Acq/A9kUc7gt4FNLd8QLSx9t97VcwV6UmEOyu5c7P49wRh/olt7Bh2Z2agwBu2VfYZ
         DvxiS7BEmZClP1Ags3WkyfWjzp2Qn9KRNem3mjKKbWCXvSpjLy8aMGgVFElm2XBW5pN+
         VNy8v0pja1bsDE/Rpe1Wjgf6VbBeOrEXeYDmAKz06oQ/8MJDwkl0LOkzq16PvHyCd4OR
         cFiw==
X-Gm-Message-State: AOJu0YxGmD+KhzicDWFMB/17yZJBtPGzzA/k2q/effnAsXq7Gol7XWER
	TB4RoyJmWoR52H7niwjl8e4nPlQySXECp8SkWYyFQetWZphTMz2AEqprukdQYjQyG89G2iDMqjV
	k2HAJy/sYMq/kyhJydsLjtMuvjO5Dz+gj
X-Received: by 2002:adf:cd90:0:b0:337:4e99:9193 with SMTP id q16-20020adfcd90000000b003374e999193mr114390wrj.2.1704364727742;
        Thu, 04 Jan 2024 02:38:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeMWiPhW+NjWkpVbwNVWkRYyy3U0zuceK83BPXwKod81rB2j/SBpSvif22g+CVtN6qF8Vbig==
X-Received: by 2002:adf:cd90:0:b0:337:4e99:9193 with SMTP id q16-20020adfcd90000000b003374e999193mr114382wrj.2.1704364727440;
        Thu, 04 Jan 2024 02:38:47 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d430f000000b0033740e109adsm8900271wrq.75.2024.01.04.02.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 02:38:47 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben
 Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot
 de Oliveira <bristot@redhat.com>, linux-kernel@vger.kernel.org
Cc: curuwang@tencent.com, Alex Shi <alexs@kernel.org>
Subject: Re: [PATCH v2] sched/stat: correct the task blocking state
In-Reply-To: <20240103081042.1549189-1-alexs@kernel.org>
References: <20240103081042.1549189-1-alexs@kernel.org>
Date: Thu, 04 Jan 2024 11:38:46 +0100
Message-ID: <xhsmhy1d5ids9.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 03/01/24 16:10, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
>
> The commit 80ed87c8a9ca ("sched/wait: Introduce TASK_NOLOAD and TASK_IDLE")
> stopped the idle kthreads from contributing to the load average. However,
> the idle state time still contributes to the blocked state time instead of
> the sleep time. As a result, we cannot determine if a task is stopped due
> to some reasons or if it is idle by its own initiative.
>
> Distinguishing between these two states would make the system state clearer
> and provide us with an opportunity to use the 'D' state of a task as an
> indicator of latency issues.
>

get_task_state() already reports TASK_IDLE as 'I', which should be what
userspace sees (e.g. via /proc/$pid/stat). This is also the case for the
sched_switch and sched_wakeup trace events.

I assume what you mean here is you first turn to schedstats to check
whether there is any abnormal amount of blocking, and then if there is any
you turn to tracing, in which case you'd like the schedstats to not make
things look worse than they really are?


