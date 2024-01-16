Return-Path: <linux-kernel+bounces-27637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C53182F375
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259FA1C237D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFC01CD0A;
	Tue, 16 Jan 2024 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgDdCfzb"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746541CD03
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427251; cv=none; b=cffMmO1vOOMdou1EyFMcjX+FJ5HxxhWrxMRMV5bdxzPkx0+KcAGHZ7gjODwXZfHDQUveNXkUZlww7RMZJQeSeAwEcd0Ls/ycAHfaK5h1ZwAyiF6pWPgt/7o/smzJVW4tKn/Y8vcX0nhFD9nDu9sbkY8fMDHdtxwRxG+ofdDPxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427251; c=relaxed/simple;
	bh=0/isWeFMhnfYH9X/K89t23Z1ify73WMdfmYzYqWJFYs=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:Received:X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:
	 X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=g8D7hSLr3bRUcnyd3alrrfsXoh89uxa2OI/zpca1Uuxkr2eUQeFOATvVxhytghrZLQHCA1LDHO30yBl5JrMlphx56Lu3HmWO2HkGzqj/0LCzyQFB32PJ6Fu27KSHd2bRn3WfzltZbWNq3qs4Jxk/vlzianeWXoi/LqnAlTL61no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgDdCfzb; arc=none smtp.client-ip=209.85.219.54
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-681397137afso36301336d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705427249; x=1706032049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9/4nniJGFU/CJ741SHgigkRUcx2eNLr43luj0B9gCo=;
        b=JgDdCfzbjFH4zXvklclmlKlMDSD9C7xv2bLN9uD4D09+iVxeXFER3EDM+Y7GWIOrg4
         ZedMFu760OgXTziWxhFhJ7JvzwGtByp8mDCvrjwPbcHdYVHAGosWDn0USVuOcOuzT+sp
         wTqX9mQHTt+98irpf3ClNdNMMc/yS5ZlOMHk23UKEiCuwxS8h91SW5Wy9Qb5cktgMyFJ
         Gfi6PxXyeCZbXp5dqFrbyu1bJEB86GSXG4+ZBuRpV0/zQ9kMOAPWCwMw8yJXMyDlixxt
         HJkiuRT3V73lCSNQVV8chdVFQ6xfc4KRkxkIKAYsfNx8SCSfuy+LNTp4jmnymhUBAhT0
         ss5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705427249; x=1706032049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9/4nniJGFU/CJ741SHgigkRUcx2eNLr43luj0B9gCo=;
        b=Xwx3ehFX36zBvQIXZyEpWtXRdwz5DGmAUnmGRBx3YLRsuBjCPxSty7GQwd8MLrKX1c
         Z2GSwzWxtQXi8RoYR21J7Z5LdachRKAljaGobqr9bepeZ6zDx3CeP4hcnMsAnw5jayRx
         EgSCRBffL1HZkvDN/v3E+QrdS3bQL35/awftfWbzw0RVxgeN8/2GnJNmFanyqCvCma8j
         mOJ6hVIIEldRMYxwwv23XPd5pTAqtKEmUeLcawAdcVvtvx0YECkXTbjDmY5YUqVxGPzT
         Ce7aDNK93ZuH+HNZEf7XokG39oKCeFVhLkhhyI21PlNpsEA3mcmo3ifXRwuvg6Zabik1
         ZkkA==
X-Gm-Message-State: AOJu0YwwING76rNnx7gUN9lT1dPFjdA4J3Ihne/Fn8KVtlCk75zedQoj
	69rHc8kcfADG5VwBgVlFtPjHwF8IhEo=
X-Google-Smtp-Source: AGHT+IFXJouSw95e5E+j0j8szvGi8jRVVra1MtGJCx70Xo0HVBxxoP00gvporqcrWgkbwTDErYFspw==
X-Received: by 2002:a05:6214:268c:b0:67f:ae28:f570 with SMTP id gm12-20020a056214268c00b0067fae28f570mr8802004qvb.124.1705427249406;
        Tue, 16 Jan 2024 09:47:29 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x19-20020ad44593000000b0067f678747ffsm4374070qvu.50.2024.01.16.09.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 09:47:28 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailauth.nyi.internal (Postfix) with ESMTP id 680CC27C0067;
	Tue, 16 Jan 2024 12:47:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 16 Jan 2024 12:47:28 -0500
X-ME-Sender: <xms:L8GmZXDE44Ovaf7yrVs4hEM2dSIfgB0nt5mV9F1hMT6Gxe1oDNZ1kA>
    <xme:L8GmZdhfrUkc-tZCq36f_zkEN7PPVOQ9kNB-7VDd_bVu348q0kE7Wl3PS-FE_BHCe
    4YpS-1RkvkJAaX-6g>
X-ME-Received: <xmr:L8GmZSk3bsUrx7VybiKonzy71rAqVRBvtU6DZocnhi6rfBOARzKFUAQrzkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejfedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:L8GmZZy-K8KzzzZp7crcaPGswomQYzi7RLUkB4rCUkt_0AHdo-0u7Q>
    <xmx:L8GmZcQU9DXRH5UPSPgt3hYdMcy7nshMVoRKqr6MjiPYqAlJopEOOQ>
    <xmx:L8GmZcaLK-HVrz-c5wJDGWgfwg7huG7dNfToFMzjnl18VUAaRqECeQ>
    <xmx:MMGmZfE7rZPZEML_xUoDcPVJhGzFdKM4opR9mbgTx5c0FwNlFQyY2g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 12:47:27 -0500 (EST)
Date: Tue, 16 Jan 2024 09:47:08 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, linux-kernel@vger.kernel.org,
	niuzhiguo84@gmail.com, ke.wang@unisoc.com, xuewen.yan@unisoc.com
Subject: Re: [PATCH] lockdep: fix deadlock issue between lockdep and rcu
Message-ID: <ZabBHHwZd70IDDxP@boqun-archlinux>
References: <1705308796-13547-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705308796-13547-1-git-send-email-zhiguo.niu@unisoc.com>

On Mon, Jan 15, 2024 at 04:53:16PM +0800, Zhiguo Niu wrote:
> There is a deadlock scenario between lockdep and rcu when
> rcu nocb feature is enabled, just as following call stack:
> 
>      rcuop/x
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
>      rcuop/y
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
> 

Nice! Looks like you find the root cause ;-) nocb_gp_lock and graph_lock
have an ABBA deadlock due to lockdep's dependency on RCU. I assume this
actually fixes the problem you saw?

However, I want to suggest a different fix, please see below:

> This patch release the graph lock before lockdep call_rcu.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/locking/lockdep.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 151bd3d..c1d432a 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -6186,23 +6186,29 @@ static struct pending_free *get_pending_free(void)
>  /*
>   * Schedule an RCU callback if no RCU callback is pending. Must be called with
>   * the graph lock held.
> + *
> + * Return true if graph lock need be released by the caller, otherwise false
> + * means graph lock is released by itself.
>   */
> -static void call_rcu_zapped(struct pending_free *pf)
> +static bool call_rcu_zapped(struct pending_free *pf)
>  {
>  	WARN_ON_ONCE(inside_selftest());
>  
>  	if (list_empty(&pf->zapped))
> -		return;
> +		return true;
>  
>  	if (delayed_free.scheduled)
> -		return;
> +		return true;
>  
>  	delayed_free.scheduled = true;
>  
>  	WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
>  	delayed_free.index ^= 1;
>  
> +	lockdep_unlock();
>  	call_rcu(&delayed_free.rcu_head, free_zapped_rcu);
> +
> +	return false;
>  }
>  
>  /* The caller must hold the graph lock. May be called from RCU context. */
> @@ -6228,6 +6234,7 @@ static void free_zapped_rcu(struct rcu_head *ch)
>  {
>  	struct pending_free *pf;
>  	unsigned long flags;
> +	bool need_unlock;
>  
>  	if (WARN_ON_ONCE(ch != &delayed_free.rcu_head))
>  		return;
> @@ -6243,9 +6250,9 @@ static void free_zapped_rcu(struct rcu_head *ch)
>  	/*
>  	 * If there's anything on the open list, close and start a new callback.
>  	 */
> -	call_rcu_zapped(delayed_free.pf + delayed_free.index);
> -
> -	lockdep_unlock();
> +	need_unlock = call_rcu_zapped(delayed_free.pf + delayed_free.index);
> +	if (need_unlock)
> +		lockdep_unlock();

Instead of returning a bool to control the unlock, I think it's better
that we refactor the call_rcu_zapped() a bit, so it becomes a
prepare_call_rcu_zapped():

	// See if we need to queue an RCU callback, must called with
	// the lockdep lock held, returns false if either we don't have
	// any pending free or the callback is already scheduled.
	// Otherwise, a call_rcu() must follow this function call.
	static bool prepare_call_rcu_zapped(struct pending_free *pf)
	{
		WARN_ON_ONCE(inside_selftest());
	
		if (list_empty(&pf->zapped))
			return false;
	
		if (delayed_free.scheduled)
			return false;
	
		delayed_free.scheduled = true;
	
		WARN_ON_ONCE(delayed_free.pf + delayed_free.index != pf);
		delayed_free.index ^= 1;
	
		return true;
	}

, and here we can:

	<lockdep_lock() is called previous>
	need_callback = prepare_call_rcu_zapped(...);
	lockdep_unlock();
  	raw_local_irq_restore(flags);

	if (need_callback)
		call_rcu(&delayed_free.rcu_head, free_zapped_rcu);

compared to your fix, we don't have a special logic where
call_rcu_zapped() can be an unlock in some conditions, which prevents
local correctness reasoning.

Thoughts?

Regards,
Boqun

>  	raw_local_irq_restore(flags);
>  }
>  
[...]

