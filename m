Return-Path: <linux-kernel+bounces-29114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9CB8308E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755311C23FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEE520DD9;
	Wed, 17 Jan 2024 14:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH/X3Cbw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A62120DC9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503539; cv=none; b=q1AW/bcGKhVEfBV3ijIF5TQufGqVIqe1vjIhaoaSjRfkInUSLVGVsYTg2Cpvp15IpHfDYDoeCmppzz/08akgg56GD/f2/chXbuOU/2PDT3Lp1Js1SbSqQiAYq8q7QG4X6aUSqglPeGN1ETOWzUKS3u//aINla1UOlnMC+nTY5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503539; c=relaxed/simple;
	bh=IDdiZ9IYC/v8mbr8KV6qe4pnXWXW+PnOzhK1/6ZUJy0=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Scanned-By; b=H1KUBTIuDTha2EeSmF1Qhv1JcXhCCYZ014YKCQNZFstSZDZVuMh1iBiaEjM4WaRmeKS8oiPpmN5TKpMwOzEA/2av/rNI3Q3jv4G+VO0zBwRnYcbL/yPgfwEf1EU7BO19B2a/b9o+xYoN+wqj2QojdqxxrtRx5JZpmgHAM3c+Iww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QH/X3Cbw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705503536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2cRPPiRnQNPcYyC98LZkrWQLgYYclbEsGM6mbdQ/VDk=;
	b=QH/X3CbwkLP/JKJO8N42FYESJuRuwiTpnCLRZ1fR5l2mcQT3N7axGy4M2Gkwlm7YYNDQ4v
	cncb0Jz5RnjGI27Vg+ySPD0HcBas/Pn5q3VyrhtXbOCcEyOddSiN8RMiEifZinCQf8BGFB
	uEwqGs9JOHBUOo6tS0NXQ/QSJpRtvEU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-SMMkAjH8P42wGL39CoVR7A-1; Wed, 17 Jan 2024 09:58:52 -0500
X-MC-Unique: SMMkAjH8P42wGL39CoVR7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 592971005055;
	Wed, 17 Jan 2024 14:58:52 +0000 (UTC)
Received: from [10.22.16.147] (unknown [10.22.16.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E4E8340C6E2B;
	Wed, 17 Jan 2024 14:58:51 +0000 (UTC)
Message-ID: <ba1bcfdd-ad61-429e-b332-cd9b52588a71@redhat.com>
Date: Wed, 17 Jan 2024 09:58:51 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] lockdep: fix deadlock issue between lockdep and rcu
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, peterz@infradead.org,
 mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Cc: linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, ke.wang@unisoc.com,
 xuewen.yan@unisoc.com
References: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <1705477714-10467-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 1/17/24 02:48, Zhiguo Niu wrote:
> There is a deadlock scenario between lockdep and rcu when
> rcu nocb feature is enabled, just as following call stack:
>
>       rcuop/x
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFF817F2A8A80, val = ?)
> -001|queued_spin_lock(inline) // try to hold nocb_gp_lock
> -001|do_raw_spin_lock(lock = 0xFFFFFF817F2A8A80)
> -002|__raw_spin_lock_irqsave(inline)
> -002|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F2A8A80)
> -003|wake_nocb_gp_defer(inline)
> -003|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F30B680)
> -004|__call_rcu_common(inline)
> -004|call_rcu(head = 0xFFFFFFC082EECC28, func = ?)
> -005|call_rcu_zapped(inline)
> -005|free_zapped_rcu(ch = ?)// hold graph lock
> -006|rcu_do_batch(rdp = 0xFFFFFF817F245680)
> -007|nocb_cb_wait(inline)
> -007|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F245680)
> -008|kthread(_create = 0xFFFFFF80803122C0)
> -009|ret_from_fork(asm)
>
>       rcuop/y
> -000|queued_spin_lock_slowpath(lock = 0xFFFFFFC08291BBC8, val = 0)
> -001|queued_spin_lock()
> -001|lockdep_lock()
> -001|graph_lock() // try to hold graph lock
> -002|lookup_chain_cache_add()
> -002|validate_chain()
> -003|lock_acquire
> -004|_raw_spin_lock_irqsave(lock = 0xFFFFFF817F211D80)
> -005|lock_timer_base(inline)
> -006|mod_timer(inline)
> -006|wake_nocb_gp_defer(inline)// hold nocb_gp_lock
> -006|__call_rcu_nocb_wake(rdp = 0xFFFFFF817F2A8680)
> -007|__call_rcu_common(inline)
> -007|call_rcu(head = 0xFFFFFFC0822E0B58, func = ?)
> -008|call_rcu_hurry(inline)
> -008|rcu_sync_call(inline)
> -008|rcu_sync_func(rhp = 0xFFFFFFC0822E0B58)
> -009|rcu_do_batch(rdp = 0xFFFFFF817F266680)
> -010|nocb_cb_wait(inline)
> -010|rcu_nocb_cb_kthread(arg = 0xFFFFFF817F266680)
> -011|kthread(_create = 0xFFFFFF8080363740)
> -012|ret_from_fork(asm)
>
> rcuop/x and rcuop/y are rcu nocb threads with the same nocb gp thread.
> This patch release the graph lock before lockdep call_rcu.
>
> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
> changes of v2: update patch according to Boqun's suggestions.
> ---
> ---
>   kernel/locking/lockdep.c | 47 +++++++++++++++++++++++++++++++----------------
>   1 file changed, 31 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3d..ddcaa69 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6184,25 +6184,27 @@ static struct pending_free *get_pending_free(void)
>   static void free_zapped_rcu(struct rcu_head *cb);
>   
>   /*
> - * Schedule an RCU callback if no RCU callback is pending. Must be called with
> - * the graph lock held.
> - */
> -static void call_rcu_zapped(struct pending_free *pf)
> +* See if we need to queue an RCU callback, must called with
> +* the lockdep lock held, returns false if either we don't have
> +* any pending free or the callback is already scheduled.
> +* Otherwise, a call_rcu() must follow this function call.
> +*/
> +static bool prepare_call_rcu_zapped(struct pending_free *pf)
>   {
>   	WARN_ON_ONCE(inside_selftest());
>   
>   	if (list_empty(&pf->zapped))
> -		return;
> +		return false;
>   
>   	if (delayed_free.scheduled)
> -		return;
> +		return false;
>   
>   	delayed_free.scheduled = true;
>   
>   	WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
>   	delayed_free.index ^= 1;
>   
> -	call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> +	return true;
>   }
>   
>   /* The caller must hold the graph lock. May be called from RCU context. */
> @@ -6228,6 +6230,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
>   {
>   	struct pending_free *pf;
>   	unsigned long flags;
> +	bool need_callback;
>   
>   	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
>   		return;
> @@ -6239,14 +6242,17 @@ static void free_zapped_rcu(struct rcu_head *ch)
>   	pf = delayed_free.pf + (delayed_free.index ^ 1);
>   	__free_zapped_classes(pf);
>   	delayed_free.scheduled = false;
> +	need_callback =
> +		prepare_call_rcu_zapped(delayed_free.pf + delayed_free.index);
> +	lockdep_unlock();
> +	raw_local_irq_restore(flags);
>   
>   	/*
> -	 * If there's anything on the open list, close and start a new callback.
> -	 */
> -	call_rcu_zapped(delayed_free.pf + delayed_free.index);
> +	* If there's anything on the open list, close and start a new callback.
> +	*/
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>   
> -	lockdep_unlock();
> -	raw_local_irq_restore(flags);
>   }
>   
>   /*
> @@ -6286,6 +6292,7 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
>   {
>   	struct pending_free *pf;
>   	unsigned long flags;
> +	bool need_callback;
>   
>   	init_data_structures_once();
>   
> @@ -6293,10 +6300,11 @@ static void lockdep_free_key_range_reg(void *start, unsigned long size)
>   	lockdep_lock();
>   	pf = get_pending_free();
>   	__lockdep_free_key_range(pf, start, size);
> -	call_rcu_zapped(pf);
> +	need_callback = prepare_call_rcu_zapped(pf);
>   	lockdep_unlock();
>   	raw_local_irq_restore(flags);
> -
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>   	/*
>   	 * Wait for any possible iterators from look_up_lock_class() to pass
>   	 * before continuing to free the memory they refer to.
> @@ -6390,6 +6398,7 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
>   	struct pending_free *pf;
>   	unsigned long flags;
>   	int locked;
> +	bool need_callback = false;
>   
>   	raw_local_irq_save(flags);
>   	locked = graph_lock();
> @@ -6398,11 +6407,13 @@ static void lockdep_reset_lock_reg(struct lockdep_map *lock)
>   
>   	pf = get_pending_free();
>   	__lockdep_reset_lock(pf, lock);
> -	call_rcu_zapped(pf);
> +	need_callback = prepare_call_rcu_zapped(pf);
>   
>   	graph_unlock();
>   out_irq:
>   	raw_local_irq_restore(flags);
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
>   }
>   
>   /*
> @@ -6446,6 +6457,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
>   	struct pending_free *pf;
>   	unsigned long flags;
>   	bool found = false;
> +	bool need_callback = false;
>   
>   	might_sleep();
>   
> @@ -6466,11 +6478,14 @@ void lockdep_unregister_key(struct lock_class_key *key)
>   	if (found) {
>   		pf = get_pending_free();
>   		__lockdep_free_key_range(pf, key, 1);
> -		call_rcu_zapped(pf);
> +		need_callback = prepare_call_rcu_zapped(pf);
>   	}
>   	lockdep_unlock();
>   	raw_local_irq_restore(flags);
>   
> +	if (need_callback)
> +		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> +
>   	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
>   	synchronize_rcu();
>   }

LGTM.

Reviewed-by: Waiman Long <longman@redhat.com>


