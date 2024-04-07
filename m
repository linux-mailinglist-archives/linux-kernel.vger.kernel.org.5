Return-Path: <linux-kernel+bounces-134277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4939389AFE2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C283CB21E63
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD0A2032A;
	Sun,  7 Apr 2024 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnQcOZ9b"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838B21DA24;
	Sun,  7 Apr 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480618; cv=none; b=psyqen/guuzYIDUGmDR1VLaOW3Z0yGGYRO2NDi+V7APjWP8enmvTph99xIckT5wdWT9aCUXv/f8AbXobvlU0sEF4flDdFkdlzC41esQymuyEGfeeVPcSWLHAVFGlT3Daror543EoUBQzD1ztzwu88EW+evbnBy+m6sLJFuB2ZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480618; c=relaxed/simple;
	bh=83Npl5u33AsT7Ew5r4IPt7zF9FD8Clznb3uYTsdUbDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gji+WE/G0f+HxKEs3pw9MCO+WPOPcI/w5iRckdcpR6T0ZQTu+J28EHhqq7l0G+aofHV0J5dhlOuc5FOc7PluWFQiaH3mGZOg2SrfMf9I1EfqdJf/Fq/0UJ4A7DoWZayv9XuW/ceWIbcdgiD3MZXSZ0zEcTWWZCltUviso+wNXSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnQcOZ9b; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2580691a12.3;
        Sun, 07 Apr 2024 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480616; x=1713085416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RqVJfN/RcgKGdk3KqHQb6BibGIpzFn9cI1YBM8NAdA=;
        b=lnQcOZ9b0PQ1lkjNQQ2lFM31IS053zHwNA3ncDX6TdBQNIueFcTZoPjV/hqG14LEsl
         yEaLR9wW684n5nrXPnqM+vyMuTubVEfYMocjCVdombzvTvT66a3pIb8Op7jsBUZjxadD
         SGmBDHWhXRHFoPcPvxwpoCv+ZcuNMQUIq9XMrQflPPFZdKT+ZPoyUyt61hYm2Ky/LyNY
         NTgfRJlHJZ/xcIzEZFkOsceWMiHJqqMjCCsGnrOb5W6HL+/SV0p45vzfXlmIoZHQJT9x
         YbTFe57WS9NIyZubx1zDoOhcW6eFiUvtUGtsm2Xam0MaVXp7vCByXf/zoBadeN6RZniw
         hBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480616; x=1713085416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RqVJfN/RcgKGdk3KqHQb6BibGIpzFn9cI1YBM8NAdA=;
        b=pMP9/8UWoOg0zEVM7HzQWuxvjnPIrsx71z7nbOVHVO9HZpBzN6TnD1nE0qcd4tmc4c
         TA43Zp3fpX28cnYx642Z3cIiKyn0iWVQJ3+gbKtcIw/fSYQ76jn9knl/7/rd0UbAtLFW
         ZpIDc8N8Z0mOW1rUTYE1CAKwFHrqW9w2WNKulmVLlCuX6sgFf623/dQOmGaug0RQg4Id
         s8h+VkHKm56owgn3bsYGmjmR32vlqh2DbZsZ+b1HpmikAzQflMzZ3EH0TQaeM8qYenZ+
         ceiedBWUj9U52cbsZ0TGGdAZXTECqxt5D5wyI52eG207MGOjgrzROTAjwwBduklb04On
         aZUA==
X-Gm-Message-State: AOJu0YxbE86CvQ2+sl7pzYP0GJud2LXto0mj0oYH5nEETIotFdL/XrdN
	PrXZ29QOqmQFWKIJXm8VLUm+6WjgvGjRKl6xRlcKBT2vLgm1eZDZx6HJEtZt
X-Google-Smtp-Source: AGHT+IHidET2V2zDq2JEY2AQ2oyH0YB/n+RTzr+56t5d/1xTL7S25sWEPxmaw9RVF38l1lrFhZc1BQ==
X-Received: by 2002:a17:903:11d0:b0:1df:f681:3cd8 with SMTP id q16-20020a17090311d000b001dff6813cd8mr6169822plh.12.1712480616461;
        Sun, 07 Apr 2024 02:03:36 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id o22-20020a17090aac1600b002a26245adffsm4156102pjq.41.2024.04.07.02.03.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:03:36 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: rcu@vger.kernel.org,
	x86@kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH V2 02/11] rcu: Move rcu_preempt_depth_set() to rcupdate.h
Date: Sun,  7 Apr 2024 17:05:49 +0800
Message-Id: <20240407090558.3395-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240407090558.3395-1-jiangshanlai@gmail.com>
References: <20240407090558.3395-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Prepare for arch-specific-defined rcu_preempt_depth_set().

No functionality change intended, but it has to be defined as a macro
as rcupdate.h is a very low level header included from areas that don't
even know about the task struct "current".

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 include/linux/rcupdate.h | 1 +
 kernel/rcu/tree_plugin.h | 5 -----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 17d7ed5f3ae6..ebe9bfc700bb 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -78,6 +78,7 @@ void __rcu_read_unlock(void);
  * types of kernel builds, the rcu_read_lock() nesting depth is unknowable.
  */
 #define rcu_preempt_depth() READ_ONCE(current->rcu_read_lock_nesting)
+#define rcu_preempt_depth_set(val) WRITE_ONCE(current->rcu_read_lock_nesting, (val))
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 36a8b5dbf5b5..b1264096d03a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -387,11 +387,6 @@ static int rcu_preempt_read_exit(void)
 	return ret;
 }
 
-static void rcu_preempt_depth_set(int val)
-{
-	WRITE_ONCE(current->rcu_read_lock_nesting, val);
-}
-
 /*
  * Preemptible RCU implementation for rcu_read_lock().
  * Just increment ->rcu_read_lock_nesting, shared state will be updated
-- 
2.19.1.6.gb485710b


