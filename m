Return-Path: <linux-kernel+bounces-107631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BFA87FF64
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C5B285478
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA98481755;
	Tue, 19 Mar 2024 14:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmiLTtQJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sAPXVYcL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEEF81748
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857710; cv=none; b=hm28KLHUNVMi8ANG4JTrOM6IxjjJKs340O4Rt6yUBhfVuAmAw+lUcTecinFamK27sE0E/rdn6Hhmyr8zE/wf0/0DkVh8NVIC+Cdo5eOk7RsdEgOGXgl46hnLqveCOBmmzOnXat6Ekea9j3OTo2wgObiYnt1mqiX1tpUJcxwNQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857710; c=relaxed/simple;
	bh=sXw/hen6coo9Y4mQg0v3PJdb45MkVSydX+eSXvbsNOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8qtDrLdRvPT/OAO4I7xWlttczhVPa4aiNSvEeUjVF7JR/cGJcg8tbF7CDGGgido0lVvSJwkqrzeQUZpNa72MIbOjtQUNic1WbwO1PD/05MT9xMinHWgD+XC7B31ZJLbNpk3gW6c6+Oq8xpEfPEn94vmls8EcRkvJp7G57/sFwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmiLTtQJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sAPXVYcL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Mar 2024 15:15:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710857706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pJN0PTyH0UKoPFa7kTYFWKIZEIxZksQ2C3Toyqp2Wnk=;
	b=wmiLTtQJqCc+rjcXTU23R8Pfq8MoQ2XY8xBpT4qhA7qyU5PbOG9FsD0dagLI0BXjP8H4cN
	JdTp6UOarDNSPEDDSQB0bjWOp3ChSsw76zAmUpAH45NSRiQkkuyLgh29BAaVYbQ+UlmFrZ
	sWCu8uMM3IPX3UF0QA3RAIFsU1clrS43szRWO7COZjzfqhPpJT4m1VZOTVuAPnINHVWkop
	4/AptIa7trdgFxf9zq2IXWBl6NRCSmEbuJZZp7KkUW/VFI29lggrJrSXpxXNIa0fc6+CR3
	ZH2mVS1gu7AIS5NzScaN7A13pb6BWuNmq2yKGhMhV4cUjTsXGr+qWuNPoT+bJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710857706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pJN0PTyH0UKoPFa7kTYFWKIZEIxZksQ2C3Toyqp2Wnk=;
	b=sAPXVYcL2PqmbaXWIkv4+xx/IqtaHQrE3Sar6jJuP2HFGUFHTv3ZIUzgrhvcKJuhat3VAK
	t5KVaPfC7tm9OFDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] Locking: Let PREEMPT_RT compile again with new rwsem
 asserts.
Message-ID: <20240319141506.DUd9NKl4@linutronix.de>
References: <20240319070550.ws_uO21-@linutronix.de>
 <ZfmVPid-d7cpf6Yt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfmVPid-d7cpf6Yt@casper.infradead.org>

On 2024-03-19 13:38:06 [+0000], Matthew Wilcox wrote:
> On Tue, Mar 19, 2024 at 08:05:50AM +0100, Sebastian Andrzej Siewior wrote:
> > -static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> > +static __always_inline bool rwsem_held_write(const struct rw_semaphore *sem)
> 
> The locking maintainers were very clear that this predicate Should Not
> Exist.  It encourages people to write bad code.  Assertions only!

What do you refer to? The inline vs __always_inline or
rwsem_held_write() should not exists and it should invoke directly
rw_base_is_write_locked()?

> >  {
> > -	rw_base_assert_held_write(sem);
> > +	return rw_base_is_write_locked(&sem->rwbase);
> > +}
> > +
> > +static __always_inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> > +{
> > +	WARN_ON(!rwsem_held_write(sem));
> >  }
> >  
> >  static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)

Sebastian

