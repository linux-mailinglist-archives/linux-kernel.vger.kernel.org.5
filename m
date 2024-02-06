Return-Path: <linux-kernel+bounces-54163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E522A84ABB9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969641F25AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9EF79C5;
	Tue,  6 Feb 2024 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7oUbquM"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB016FB0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183660; cv=none; b=u0b1GCJOSiBFq0QpzTt4LFk3YjPGuIjxbQoqU0+zDSdBHCu2kMB7me3YM5io8BdB4f3WUNvy7nb2reo282mhHzJbB1EbnXfMWh/uFm4jNNrCQDnL+RaAzHamCKEjYJx9iYyYV15BvQlZ1ebYFOB354AN3extE4DmYYGn7d9+l2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183660; c=relaxed/simple;
	bh=EJX1aSiUsQpUURNR8wGkY2ER/ZLmtFqAVRvSKnMN0zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3/ybvklYRRcF6L5U+DT+JGVIG3dX6EWB2nKnoRqKiDQ5nEOl9QotqCPERZDCHYUK6E91vSAETk1cedPmi8sf8eY8lDf6c18/QEDZw4UUW/TTR/YkG8AB89tBkAMVSKJE2jzHqTzU6hy7qlgNePeA5Lc34H1jal5oswmOJq1ZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7oUbquM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d71cb97937so2887985ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 17:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707183658; x=1707788458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1FhD7dCGFDGS4AXee8u96jXb8nzsDejoeVMiQf1ZUM=;
        b=C7oUbquM9slpcVctYqdvlb7dMtR7Wiw7ri1pMYecsyKqW0Yg0N4DVF35Kilf3bVIVm
         PR0PUEhDncqnnoRd53XkAY8cUFJAQOUMGR3e59ZZ4c3qFvd45SOaKNA1Q9e4vfoRhOYc
         6QufLP1mLi/+p6WGuS3Oh4Oxta6wOifOFyZZY4KWwP9q1pd/LlDXmP0oHCK3R3oDPTHU
         KZ3YuRUkKpYSUxH0y4bOpFcSq3nGtsiuepXcIYpwBEXKHjWIEjDl4AblcldgDII/IaLv
         xwdb7k0+W+LHnxaDA1jkNzOq+Scw6IzBJ606kHARa8GfJdnVl+ogZp7F59A4XNghbiPK
         vbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707183658; x=1707788458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1FhD7dCGFDGS4AXee8u96jXb8nzsDejoeVMiQf1ZUM=;
        b=tmEr2uL+u3b3tC6KkKaSyeLgUencDV9KW/9cu1IacShBDT+vBu7M5atde+zR1GdL5s
         cizT4B1KQIZ04CnbLZwvxVaM8jYZRtBMjTqyjBxDAQtTmd/VYXsCSyy6rm0SlkxE7h8y
         iHk9AoJJSEVfyoOqmmTfzZpOqNN4EOL1sMzopjPMMOMfKJBIQFMdybXGYHB0SawRqSME
         cx8MJZ6GV7YYUBcq/k525n1r8g+kJNGuRPKk4E1imBk8490wjOb0Cz8Y/4iquVri0/vk
         Cjw+OSeL1q2DAmYCUadlaGeYhBD7SUaDIHyDkLvDHj1NNVsmjAW/nbfVXivaqMrBAazh
         Qjhg==
X-Gm-Message-State: AOJu0Ywo+mAfAqs0FjcTtO7z/0/uyoPOYdc7JFNKgeysWXSfOP3MQudn
	NLRDTqE6mqcaSfjNmzfFUr4hXrId8AO5lToOBPVv+JYQ0rO9l52r
X-Google-Smtp-Source: AGHT+IGXgUadCg+XodhrSr97QMN0VuUJ5GZq8Chw7RBsrowD7hG3rNtCjZIygR4119nHiZUIVlVuXg==
X-Received: by 2002:a17:902:6b0a:b0:1d9:a589:aa6f with SMTP id o10-20020a1709026b0a00b001d9a589aa6fmr270056plk.67.1707183657611;
        Mon, 05 Feb 2024 17:40:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUGyTutDRkuYEOnlQnvnBFSM5KthUadLICZCHYz6/2ljiEZLidhgmagLOf/SIYuYklXMB2rNJispjrqWiYN0wCzWb+L70SaLqgZ2KusTnKCAmOeYadXO+N/u4stsJGD4kcknKaAFfesK2NsoA2KD1aqjhdTDD3uSTso9oWFKX+znkw4XH7rdDAQwcD8CfPUMFcIfSkAEQsowG2pgqLZQaDPWwmCmad0J9hUCXSjiNGcwWnNcKuGMFEw00fONvwFiUv5cqGhYw==
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id jz5-20020a170903430500b001d8d1bf5b98sm558029plb.54.2024.02.05.17.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 17:40:57 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 15:40:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH-wq v3 0/4] workqueue: Enable unbound cpumask update on
 ordered workqueues
Message-ID: <ZcGOKNcqfr2t1NC9@slm.duckdns.org>
References: <20240205194602.871505-1-longman@redhat.com>
 <ZcE8pUuHfa7gVZs6@slm.duckdns.org>
 <ZcF3qmion7H6qyYY@slm.duckdns.org>
 <35ec9009-52eb-40aa-bf7a-db7a451d3652@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35ec9009-52eb-40aa-bf7a-db7a451d3652@redhat.com>

On Mon, Feb 05, 2024 at 08:24:06PM -0500, Waiman Long wrote:
> 
> On 2/5/24 19:04, Tejun Heo wrote:
> > On Mon, Feb 05, 2024 at 09:53:09AM -1000, Tejun Heo wrote:
> > > On Mon, Feb 05, 2024 at 02:45:58PM -0500, Waiman Long wrote:
> > > >   v3:
> > > >    - [v2] https://lore.kernel.org/lkml/20240203154334.791910-1-longman@redhat.com/
> > > >    - Drop patch 1 as it has been merged into the for-6.9 branch.
> > > >    - Use rcu_access_pointer() to access wq->dfl_pwq.
> > > >    - Use RCU protection instead of acquiring wq->mutex in
> > > >      apply_wqattrs_cleanup().
> > > Looks like we raced each other. I'll wait for v4.
> > BTW, please don't bother to handle __WQ_ORDERED being cleared. We are very
> > close to removing the implicit ORDERED promotion, so we should be able to
> > apply the patch to remove the distinction between explicitly and implicitly
> > ordered workqueues.
> 
> BTW, the workqueue.c file in your latest for-6.9 branch still has a
> reference to __WQ_ORDERED_EXPLICIT in workqueue_apply_unbound_cpumask().
> Will that break compilation?

Right you are. Will post a followup patch.

Thanks.

-- 
tejun

