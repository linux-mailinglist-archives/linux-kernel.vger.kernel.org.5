Return-Path: <linux-kernel+bounces-111835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B7488717B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E611D28A258
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5B15D8EE;
	Fri, 22 Mar 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvLmP0Jq"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8D54660
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126939; cv=none; b=BxI03hvKxInwAq8W1WeUzzPv9L4NBf2dsiJ0jn5Cm+ON63Ogz9/6oY0ZLY9S9bfTD69c0gpeqAreKFcUO4R7YaecPn7gv7nyAtlm7J3IOmRfjQWEatKx5dZWNJGEmmIr3fkJcUZTaV+pRPCgwWDjeWbzZUisNT7MEh0wbhruuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126939; c=relaxed/simple;
	bh=dRCD6x1yQh0ZOSt7H+rlner6EJ2b+CTrN0ysiYC13zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRvLAl8OzxdXjuNgqIRkbR5i675SZ9lrV6y2NlmbBDtPpKFvHfXtzV0SxTUvKgZlow0C263tFdoG1t5fw+o3U9GFV36Ua1o+9RD5/6pqcGTMi79r+91Zv3/PfuUzGvb2PVmrGM0Pqi1dHTY9F2xIattNkQG6o0Jn5W1SWvo/ABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zvLmP0Jq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1de0f92e649so15938365ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711126937; x=1711731737; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FokECRCKDFSvWdQlq198p2mJBvxWlTy6rfKRldf1OUE=;
        b=zvLmP0JqnCtTJqOXBLEQ9ddIbnZWVE0dynmpLRfhijr/vTlcApSj2BkU7xbod0Eseo
         rYkolI2uZp+yyvk2tXnaKYcHJUuQ0tlEiPELR7TPpjiB2VgHY/M+BUlf0ibOrWvxQ14l
         8lsBcqo+cfqKjflHLSBZdX+B8CIW2Y8Ivgs9U5nNuwHwftvfDoAHwzHpSLN88TRvVjl1
         6qjC0EgvDp6J/vsB+XW33Ys9392sUmcNzVnhVMMYCxlDyAgsvDTnTxB0kC7eBDs4S1FG
         /TPFEF+t0NBPynbOPTp9Pudln+/LaRQwvkJLBk0aSrz4wAh771DLqh9ns6HfgnXRHpNR
         BY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126937; x=1711731737;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FokECRCKDFSvWdQlq198p2mJBvxWlTy6rfKRldf1OUE=;
        b=G8i1yFe94W4VcVfeCq5wjaxQvCLSUbJG3dDKDH+GeOnuxuTXZ6wSqj8EcHrHlzcN5m
         LP3DmhSehOVYoO3zRjOJK8lkmF+/z4ULYfHt5MvaWQN8YwuVL11OItrG08thoB1Gt50i
         mPTUBaSZSXtUMBVNdTNXouD5dkPnIAQwDHuoRPZWgHJaadZRSxbgeBSlNzChdjT+WbyU
         4sb96ccbPLX2vdsEAPgYjuGfPWERjVK4ipj96MjnQEfUjJno8bixsrGwi6hEHtcOGl8i
         trv5JOYvt5tqYiINZUP7SyDEPzCcTqMuPAQ3xGNqXMXwcfKeGCxYqm8M4KjselviM7Nm
         SPdw==
X-Forwarded-Encrypted: i=1; AJvYcCUcWAYaq5hC4LnbDNCDgY3mkOc8+h6BAEqmR6BYJs5mINFt15zQUY+Witgxrtv89Dgyzowu3sM5hUUZiXRtg+CGeLyJWTW+2CSxJlr9
X-Gm-Message-State: AOJu0Yw2nCMeT9P5KHXRz5yhY7tTHJyO0/QyKaIy+JsIkfSA2iawHKDR
	4YFmPlpwsnPx0itfRoC/8naEIdyJdpL/iYI8NeWETIrV98t1497y4ByG84JUOgrTvOmlG1JPo+v
	2OV4GMKy9irax4ZwuoPQQ6QWnaHIAj1Xui3w55A==
X-Google-Smtp-Source: AGHT+IENwh//6sLgcAqzxnJVnVpd66zXyuxgJJpLL7SyiDKB5DoNOJAorNwqZN2UlpGRBelhcanxNeLS7zSknKQgV4w=
X-Received: by 2002:a17:902:c255:b0:1e0:20c3:7c39 with SMTP id
 21-20020a170902c25500b001e020c37c39mr295946plg.24.1711126937416; Fri, 22 Mar
 2024 10:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228161018.14253-1-huschle@linux.ibm.com> <5a32e8e1-67cf-4296-a655-f0fc35dc880a@arm.com>
 <ZfL/hROYxQudcTuX@DESKTOP-2CCOB1S.> <66c4286e-deaf-44a0-be62-0928529ae73f@arm.com>
 <4b25ab45b762e64b9df09d4d12d8289f@linux.ibm.com> <CAKfTPtDyrsnq-CSFo+upzdOJpuH=JkRzSALad-OL29OvqkK2dg@mail.gmail.com>
 <65fa8a7c.050a0220.c8ec5.0278SMTPIN_ADDED_BROKEN@mx.google.com>
 <CAKfTPtBA7ECeYJYdzL9ybeXLbpEudLfB6V9s+DZiJUmpnPf_kQ@mail.gmail.com> <65fc25ae.810a0220.f705f.4cdbSMTPIN_ADDED_BROKEN@mx.google.com>
In-Reply-To: <65fc25ae.810a0220.f705f.4cdbSMTPIN_ADDED_BROKEN@mx.google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 22 Mar 2024 18:02:05 +0100
Message-ID: <CAKfTPtCv37JA+5D6WQbgsjeY7-Vx4tD+6PFDH+wc8TtPE58T9A@mail.gmail.com>
Subject: Re: [RFC] sched/eevdf: sched feature to dismiss lag on wakeup
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Luis Machado <luis.machado@arm.com>, linux-kernel@vger.kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Mar 2024 at 13:18, Tobias Huschle <huschle@linux.ibm.com> wrote:
>
> On Wed, Mar 20, 2024 at 02:51:00PM +0100, Vincent Guittot wrote:
> > On Wed, 20 Mar 2024 at 08:04, Tobias Huschle <huschle@linux.ibm.com> wrote:
> > > There was no guarantee of course. place_entity was reducing the vruntime of
> > > woken up tasks though, giving it a slight boost, right?. For the scenario
> >
> > It was rather the opposite, It was ensuring that long sleeping tasks
> > will not get too much bonus because of vruntime too far in the past.
> > This is similar although not exactly the same intent as the lag. The
> > bonus was up to 24ms previously whereas it's not more than a slice now
> >
>
> I might have gotten this quite wrong then. I was looking at place_entity
> and saw that non-initial placements get their vruntime reduced via
>
>     vruntime -= thresh;

and then
    se->vruntime = max_vruntime(se->vruntime, vruntime)

>
> which would mean that the placed task would have a vruntime smaller than
> cfs_rq->min_vruntime, based on pre-EEVDF behavior, last seen at:
>
>    af4cf40470c2 sched/fair: Add cfs_rq::avg_vruntime
>
> If there was no such benefit for woken up tasks. Then the scenario I observed
> is just conincidentally worse with EEVDF, which can happen when exchanging an
> algorithm I suppose. Or EEVDF just exposes a so far hidden problem in that
> scenario.

