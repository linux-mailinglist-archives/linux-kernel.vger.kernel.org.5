Return-Path: <linux-kernel+bounces-168053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F548BB31C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C971F2145A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCEB6158A24;
	Fri,  3 May 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ppu7nfIu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7wdPy5A+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E019139D19;
	Fri,  3 May 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714761009; cv=none; b=uMrDA2RwUJjZwFKYdbRuQR3gSRMP/Rq8nh7MG8Qs+s2cgD2AiM/rjBfEi4dWPACgwUtwQy3Tp1194uLQM2zA19crG308+ff5hCmO47HvBcuEsjX5dI3IDgcCz75fRQmwww4hJHPyFDL9T1cEe9IpZKCnpdGI8G6kbVzmk8/8+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714761009; c=relaxed/simple;
	bh=74/0AKsnF9vBQRTv+86J/6a3kei1SXSM/rCzTC9ygsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XaKTO6F7DpTUYHIzz/8x2e4xgO2y9ty4cr3B3xgti59wbZzUqzqA8swqAwQLimcQ8fDfuO/5Dl740SipJu6+36iyF6Sa0Ud3+0KzTJmKVSfnSgcpDgFqslkPw2C7fUh8LgnS9ROp10OECPJJ/Kmr1w/52RyryK4rbJc1sjwGFaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ppu7nfIu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7wdPy5A+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714761005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+L2OHtZGBVAI0AzBMGBr/lDGosDbMk0Ei6sq1IBWuVc=;
	b=Ppu7nfIusKN+1NEBP9Cj+ylvfFl2Rr2yfx6sxiesPdeDuTzk2ge/+lzj8delQEA83Y9WPb
	2GUeBYsZd2VD4hp4h0lsUlo6IYtBxI9nMCyKW0z46IJg0wjqOXuJPPebbKoa1q7k1+4eOK
	dByO+YeuD1daiokAvKf2cZ/zvPRJkcLIp+QBQt5fr8FTTOsXAlmQyCCW1ZKsr5e5kgOlLh
	lL77tEPZD0Mtuzp8JXI6LnK+q3Re7/LhVEgqOWojN8ULEPXwobn6S6/qG+9PNE2K/6PUzO
	nlAD+PBmSiO3igZAFknGs0fwxL81P0CWYHDfPhWPGGY8O7wLtnla2rCtCA1laA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714761005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+L2OHtZGBVAI0AzBMGBr/lDGosDbMk0Ei6sq1IBWuVc=;
	b=7wdPy5A+jZsO+4HaU3i8bJJIZjAXBJH0k7XSH/fFPG85io9JfzgW6FEV+YtX7UgQDwjRcC
	JBXUYRUDC0SP6vCA==
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Boqun Feng <boqun.feng@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2 net-next 00/15] locking: Introduce nested-BH locking.
Date: Fri,  3 May 2024 20:25:04 +0200
Message-ID: <20240503182957.1042122-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Disabling bottoms halves acts as per-CPU BKL. On PREEMPT_RT code within
local_bh_disable() section remains preemtible. As a result high prior
tasks (or threaded interrupts) will be blocked by lower-prio task (or
threaded interrupts) which are long running which includes softirq
sections.

The proposed way out is to introduce explicit per-CPU locks for
resources which are protected by local_bh_disable() and use those only
on PREEMPT_RT so there is no additional overhead for !PREEMPT_RT builds.

The series introduces the infrastructure and converts large parts of
networking which is largest stake holder here. Once this done the
per-CPU lock from local_bh_disable() on PREEMPT_RT can be lifted.

v1=E2=80=A6v2 https://lore.kernel.org/all/20231215171020.687342-1-bigeasy@l=
inutronix.de/:
- Jakub complained about touching networking drivers to make the
  additional locking work. Alexei complained about the additional
  locking within the XDP/eBFP case.
  This led to a change in how the per-CPU variables are accessed for the
  XDP/eBPF case. On PREEMPT_RT the variables are now stored on stack and
  the task pointer to the structure is saved in the task_struct while
  keeping every for !RT unchanged. This was proposed as a RFC in
  	v1: https://lore.kernel.org/all/20240213145923.2552753-1-bigeasy@linutro=
nix.de/

  and then updated

        v2: https://lore.kernel.org/all/20240229183109.646865-1-bigeasy@lin=
utronix.de/
	  - Renamed the container struct from xdp_storage to bpf_net_context.
            Suggested by Toke H=C3=B8iland-J=C3=B8rgensen.
	  - Use the container struct also on !PREEMPT_RT builds. Store the
	    pointer to the on-stack struct in a per-CPU variable. Suggested by
            Toke H=C3=B8iland-J=C3=B8rgensen.

  This reduces the initial queue from 24 to 15 patches.

- There were complains about the scoped_guard() which shifts the whole
  block and makes it harder to review because the whole gets removed and
  added again. The usage has been replaced with local_lock_nested_bh()+
  its unlock counterpart.

Sebastian


