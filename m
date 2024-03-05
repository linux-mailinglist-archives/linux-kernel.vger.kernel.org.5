Return-Path: <linux-kernel+bounces-92211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DFD871CD7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BC41C22C98
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55E5548F3;
	Tue,  5 Mar 2024 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="eqlcWOwT"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5595A4CD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636658; cv=pass; b=fn/M4z9Le10/uhQj4tAhE2J5055ixDtKkn0j6jmYgaVyBHL4nhgwgLV1sh5DtD1kHgYmNO8Ps/LiHXvXEo9I/c0V862xWgoql8Wg48Ka7VyOCI81jTlWO+F8nkSn/hlnD4qHdLkIjQVoqoIg7hsVSuoE6JiF8wk0b9/EqJxjEHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636658; c=relaxed/simple;
	bh=bitf7vn1Tko3UcXW/HZcpK72mOMCQnHhPpBoHkJzFe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+oLMIhX6UnkFgxPCZvR5oZc+iIRuIk9RNatL26umKQnN0McKptwhgq9/E0D8TtLKiM5kK78m6WCXgV8Jp3cSQEwhWNTSKVShXhbHqGP/ZTRe/ZXDoXNDp6mEhf6DQW2iKDS/JwZuGS9Vh1BQTNBvn/xCPt57tqLIMdGB5ltHic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=eqlcWOwT; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from darkstar.musicnaut.iki.fi (85-76-8-182-nat.elisa-mobile.fi [85.76.8.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aaro.koskinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Tpt3m2K5RzyTd;
	Tue,  5 Mar 2024 13:04:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1709636646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+Tidk3xtKcnpQFfsXE2bzouU7P/cVDfr0RoP0AGszI=;
	b=eqlcWOwTRRK1xnhIU+EddEbelmnDCJTMlo1y4c/BF7xkeErjP+gyPn/88KXEjNvz99nVyc
	jfTIWi29M9V1Om92+y7UxD11a0vIP6EeGZe0cy04Fba0H5SQM/dCbgX5Cay3yrBtJOBpPU
	+FgLMv22VwwneOfp9fWakw1TUi6319w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1709636646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/+Tidk3xtKcnpQFfsXE2bzouU7P/cVDfr0RoP0AGszI=;
	b=w9VzYE4R8eMwXxVdDDXCDdCKWmTO66sy8E69lEzL/SuDFz9DfSDlO3/nPPnYmwhPclyd48
	TtVxVvQOdqTfXNL8FozpvVFrnrJADgI4bAgc1B3+ZJ2rhz8as63MCUyOwj7L9yUsClq6D+
	NzjDBh+R5XhblkdnZplsT9Ot98yOtwQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1709636646; a=rsa-sha256; cv=none;
	b=BKB1xcOCM0OiTWDnxAWrHGFNzLsJMmDv5KqI0ATzzrBFld3gg+t3zxerLY4turETvnpU7d
	4bMOFnxY5D8pr15Zj6U1Kohthpa4KKA6cWAWYiSM6/riGeKgUPAcMBgQbruQ9fFJ15E/nb
	qn5YklhOKfzjynMJy/eUK00Bw7Xj51o=
Date: Tue, 5 Mar 2024 13:04:02 +0200
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Mukesh Ojha <quic_mojha@quicinc.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, will@kernel.org, longman@redhat.com,
	boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
	Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Subject: Re: [PATCH v2] locking/rwsem: Disable preemption while trying for
 rwsem lock
Message-ID: <20240305110402.GA72649@darkstar.musicnaut.iki.fi>
References: <1662661467-24203-1-git-send-email-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662661467-24203-1-git-send-email-quic_mojha@quicinc.com>

Hi,

It seems this patch (commit 48dfb5d2560d) is missing from
at least 5.15 stable tree.

Based on quick test, it seems to fix an issue where system locks up
easily when RT throttling is disabled, and also it applies cleanly, so
I think it should be good to have it 5.15?

A.

On Thu, Sep 08, 2022 at 11:54:27PM +0530, Mukesh Ojha wrote:
> From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> 
> Make the region inside the rwsem_write_trylock non preemptible.
> 
> We observe RT task is hogging CPU when trying to acquire rwsem lock
> which was acquired by a kworker task but before the rwsem owner was set.
> 
> Here is the scenario:
> 1. CFS task (affined to a particular CPU) takes rwsem lock.
> 
> 2. CFS task gets preempted by a RT task before setting owner.
> 
> 3. RT task (FIFO) is trying to acquire the lock, but spinning until
> RT throttling happens for the lock as the lock was taken by CFS task.
> 
> This patch attempts to fix the above issue by disabling preemption
> until owner is set for the lock. While at it also fix the issues
> at the places where rwsem_{set,clear}_owner() are called.
> 
> This also adds lockdep annotation of preemption disable in
> rwsem_{set,clear}_owner() on Peter Z. suggestion.
> 
> Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
> Changes in v2:
>  - Remove preempt disable code in rwsem_try_write_lock_unqueued()
>  - Addressed suggestion from Peter Z.
>  - Modified commit text
>  kernel/locking/rwsem.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 65f0262..4487359 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -133,14 +133,19 @@
>   * the owner value concurrently without lock. Read from owner, however,
>   * may not need READ_ONCE() as long as the pointer value is only used
>   * for comparison and isn't being dereferenced.
> + *
> + * Both rwsem_{set,clear}_owner() functions should be in the same
> + * preempt disable section as the atomic op that changes sem->count.
>   */
>  static inline void rwsem_set_owner(struct rw_semaphore *sem)
>  {
> +	lockdep_assert_preemption_disabled();
>  	atomic_long_set(&sem->owner, (long)current);
>  }
>  
>  static inline void rwsem_clear_owner(struct rw_semaphore *sem)
>  {
> +	lockdep_assert_preemption_disabled();
>  	atomic_long_set(&sem->owner, 0);
>  }
>  
> @@ -251,13 +256,16 @@ static inline bool rwsem_read_trylock(struct rw_semaphore *sem, long *cntp)
>  static inline bool rwsem_write_trylock(struct rw_semaphore *sem)
>  {
>  	long tmp = RWSEM_UNLOCKED_VALUE;
> +	bool ret = false;
>  
> +	preempt_disable();
>  	if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp, RWSEM_WRITER_LOCKED)) {
>  		rwsem_set_owner(sem);
> -		return true;
> +		ret = true;
>  	}
>  
> -	return false;
> +	preempt_enable();
> +	return ret;
>  }
>  
>  /*
> @@ -1352,8 +1360,10 @@ static inline void __up_write(struct rw_semaphore *sem)
>  	DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) &&
>  			    !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE), sem);
>  
> +	preempt_disable();
>  	rwsem_clear_owner(sem);
>  	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
> +	preempt_enable();
>  	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
>  		rwsem_wake(sem);
>  }
> -- 
> 2.7.4
> 
> 

