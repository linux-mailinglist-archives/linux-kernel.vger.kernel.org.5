Return-Path: <linux-kernel+bounces-88333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE19C86E01C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65535285C35
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FB66BFA2;
	Fri,  1 Mar 2024 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5aPG4RN"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFAF6BFCD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292225; cv=none; b=MFxA6Af2GV7UDt2Qp2Q7cstHZmWeuyuxjJ6c8DOi0ap1T1AAi4QN/Fdibh7w6EeM45ttw/rtFbHSzNMy851UrsFdXJK9hdi7FPG918rd+CC//OGewaYaW4ujeZ6NVYDyiX2KmobdqrRy9XKhgLLR/YVpsbysyMND8xkg2MeDrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292225; c=relaxed/simple;
	bh=k8hEiunDT72IUYaIDVDVkRmFIKsyAIql5+BCw4Jt3ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a++e3t/cbWbn8tenafRZxxVOyxDHRiFfQQ5g5yo+1EAu0gMekXCGoevS93y55yFk6XgBA/q7PwYvet9duCRzm/mz9nEU5myjvNJjgN/5ludyuKOolYkzxk3v/1w1pI3KiJoFLUETjEHpex2DOQOSitXjPSvjYDvbfqEGvVlvSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5aPG4RN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512d19e2cb8so2318411e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292222; x=1709897022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbV4RstQ1yy3Py1H9UD5fXpvupqpgOucnTFrZXkpzwA=;
        b=b5aPG4RNWLm7X1h+5G6+NCs2SVcPVdcjg+QcDDN5C6zsi1juv+ouPpK+O8XV0N8gs5
         aMQsRADHAbKOQ0sO9I/6axn7MrJrQhz+7o4mjbLEndGrLUOsn+sYK7TGeATXcI0Tbbbi
         7xQDb+6oXD/9KIzzRlCHiByQSOwE5kaDCyVJQvjILAeZpwoRK/ZR0S5gnj2SPUQ8yTZM
         xoq0/XqMC11cC2XtXR64jvnrbavGgeL4aGK+367m230RuaG6eZu0e9dRNrSjraXSBVIf
         M93+WgYsx+oTx6azWpbloV24li2l/YOTLWpOZ+rrE94OZrdfxbO9SfIQsC+lkLzRrKlc
         kTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292222; x=1709897022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbV4RstQ1yy3Py1H9UD5fXpvupqpgOucnTFrZXkpzwA=;
        b=bGh/vwkBsVye7exSR8LZIUYU3lZs1/kCkWseEn7K4PvxjGN/87RY/ytkaTdnpzjbee
         zkZkqOje9fTAtib57z1K4fgKDK2+WRT7BBH290hurXE3f9IvNOPAntS9aO92123tjfoj
         kJtFLwxNAKwMNbxbu+d0lyEXqKdcjlw1ta/Nnd7A2QktYCo6/eSE4k6whChHth2Q3xV+
         HpKPOQlt36x8Q2qhXnfx4dbCa58qZA8bQDa2Znj0+KI4PCZD6H6WnzlGWk0ppPwCI6hn
         FYni1U5cuoks7qUpKh+p+s+TmXRuS3rRepphlynV1Ep7lVtD92jG8see3CpQ0AUS2FX+
         /yLA==
X-Gm-Message-State: AOJu0YymvD0gsQEGUNOstp4y2AXapwLldl6CPx4DnuNArB5FlN/Ajw79
	M821p2V2Z84HLbaSPjXLXHR3GgoqTp7rU+3GvlG7erarCQY2RJBbp+gcrjOBUY4=
X-Google-Smtp-Source: AGHT+IENSEQ07cDz3q8C790qhQj0OM8mFS7XjvR6Usnh0oYpn27qJTc7d7i271qrlbbvK/a9Kq6u1g==
X-Received: by 2002:ac2:4892:0:b0:513:1cc8:6d0d with SMTP id x18-20020ac24892000000b005131cc86d0dmr1026806lfc.12.1709292221702;
        Fri, 01 Mar 2024 03:23:41 -0800 (PST)
Received: from gmail.com (1F2EF13F.nat.pool.telekom.hu. [31.46.241.63])
        by smtp.gmail.com with ESMTPSA id bv16-20020a0560001f1000b0033e0523b829sm4429110wrb.13.2024.03.01.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:23:41 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 1 Mar 2024 12:23:39 +0100
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH 4/7 v2] sched/balancing: Fix comments (trying to) refer to
 NOHZ_BALANCE_KICK
Message-ID: <ZeG6u2dOEXOqtvZw@gmail.com>
References: <20240301110951.3707367-1-mingo@kernel.org>
 <20240301110951.3707367-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301110951.3707367-5-mingo@kernel.org>


* Ingo Molnar <mingo@kernel.org> wrote:

> Fix two typos:
> 
>  - There's no such thing as 'nohz_balancing_kick', the
>    flag is named 'BALANCE' and is capitalized:  NOHZ_BALANCE_KICK.
> 
>  - Likewise there's no such thing as a 'pending nohz_balance_kick'
>    either, the NOHZ_BALANCE_KICK flag is all upper-case.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Valentin Schneider <vschneid@redhat.com>
> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 934ace69eb30..31838b9dcf36 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12410,14 +12410,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  
>  /*
>   * run_rebalance_domains is triggered when needed from the scheduler tick.
> - * Also triggered for nohz idle balancing (with nohz_balancing_kick set).
> + * Also triggered for NOHZ idle balancing (with NOHZ_BALANCING_KICK set).

    s/NOHZ_BALANCING_KICK
     /NOHZ_BALANCE_KICK

As the changelog says.

This change got squashed into the wrong patch later in the rest of this series
that I haven't posted yet. Find -v2 below.

Thanks,

	Ingo

===============>
From: Ingo Molnar <mingo@kernel.org>
Date: Fri, 1 Mar 2024 11:30:42 +0100
Subject: [PATCH] sched/balancing: Fix comments (trying to) refer to NOHZ_BALANCE_KICK

Fix two typos:

 - There's no such thing as 'nohz_balancing_kick', the
   flag is named 'BALANCE' and is capitalized:  NOHZ_BALANCE_KICK.

 - Likewise there's no such thing as a 'pending nohz_balance_kick'
   either, the NOHZ_BALANCE_KICK flag is all upper-case.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 934ace69eb30..4c46bffb6a7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12410,14 +12410,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 /*
  * run_rebalance_domains is triggered when needed from the scheduler tick.
- * Also triggered for nohz idle balancing (with nohz_balancing_kick set).
+ * Also triggered for NOHZ idle balancing (with NOHZ_BALANCE_KICK set).
  */
 static __latent_entropy void run_rebalance_domains(struct softirq_action *h)
 {
 	struct rq *this_rq = this_rq();
 	enum cpu_idle_type idle = this_rq->idle_balance;
 	/*
-	 * If this CPU has a pending nohz_balance_kick, then do the
+	 * If this CPU has a pending NOHZ_BALANCE_KICK, then do the
 	 * balancing on behalf of the other idle CPUs whose ticks are
 	 * stopped. Do nohz_idle_balance *before* rebalance_domains to
 	 * give the idle CPUs a chance to load balance. Else we may

