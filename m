Return-Path: <linux-kernel+bounces-122532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1E088F91E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 126C8B23D34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901AD54777;
	Thu, 28 Mar 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AK+5IoRE"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9B5473F;
	Thu, 28 Mar 2024 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612260; cv=none; b=J6kDM31lRoCgXtyPTYyedi+BgwL3c8JWmqF6deFN4ycQIsa3MVxGOqRs/YeCATMeDeGZODwtKFkjgtBHqQntCurQRohqXQTttUS/5vvl6QsaLwAdmGAErbwcKrYm0+0qxW6SUOye6yiA+Sao00Zwmb+mA6NAWZ4TJ4GImvwxGTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612260; c=relaxed/simple;
	bh=IH/NVPiz0bWht5JKxdEAshiqI2BIr+nUQ1IBd+0iPuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/T6RmPBnGz7eV3yhBGG4TzqkOOstCGBYyQDFnwPc6sbnRzPy/+YThh/HZJld7ythnOPH1YXTQG4H7clbKFLTohMlj1bdukWURzbgAJb56lc4zxlaQQ7+L9Cw6lIpcM13itannyzN8BWWSjiS0hqnh9j0cOO3vFNvlnzDocAjYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AK+5IoRE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e6b6f86975so458685b3a.1;
        Thu, 28 Mar 2024 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612258; x=1712217058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ulcfe4DXVNKzIDhNYM33efHgfW9bwWfLdiuO4gC4Q3M=;
        b=AK+5IoREw9GLCgCheA50VW4WX8B6CPX8FRgYfS/u9/eMf8Dgu+eBKm2iCXhuJBT8/T
         Mjrb7RhIPFiO26Wr7qDC5YUq1fPjh8HYv7BrS1m+ggxboVtux4DFHTX5kIOzHnLQdFVk
         xdC7dLj2xGSLtJtxog3LBxChIpKdox52S+lhzD+Rs77UJ56O0ydnz14IS4DPa85nWJtK
         M4SQZmqZtSY4fxUqpNaTtsbnYx10AfFF3ow0iyv7Z/ymEl4TUX6HlJMpoCd+oq7jVfX7
         YPGEhGALPNs+xjF9YQaph/MeNtDumq1EVjXS+jYCTfBXlUVAwdyBK+11UZH3AFE1nfzD
         DyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612258; x=1712217058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ulcfe4DXVNKzIDhNYM33efHgfW9bwWfLdiuO4gC4Q3M=;
        b=NNThyMhc3ZY3mU+ybsizrLGjJXKXWUO7nZZ40609Ld2KpfujGUev9ihERrpzlToCxH
         6s0WI7/F72BnrVlrHX2Kfzm3xvdSsK5/qIUI83ZjHE4+0HW1poCe3yveosCA95IcMvIO
         5dGH+x2O44RBQOsMe5RuUHkadeoIDPeufOooWiDmNN+cQTsueP/p+rJqQui0bz6xqUKt
         erZImcg5c63VngNFDzQnNDH08hQzD40CNPI9kNOc00YAPzhq5Wmc2ZhNEpXtrssnRKUt
         hrz7eKKdm5lYAVreNwT99jfiOzcp3k6Ai4SHhj6uWL9/yYmEEWbldp44+pJ09bO/37fC
         nmPA==
X-Gm-Message-State: AOJu0YycMU2P43kHkr9tZQYsDON95alSjPc/tRKE4v131lH4vcsc6HaG
	nIOGGSM4xqmrgYqkmx+FPhFOvD/TYrqSIO5fwCdUlyJDO4kuv+1URPdQ0QI6
X-Google-Smtp-Source: AGHT+IFQkONNKHMl2jBI6NVmx5JwO2Q7pKrDHzcKuae1qfFUmz7oHXKlI4kDJJcKcEThvn3kdgW45A==
X-Received: by 2002:a05:6a20:4387:b0:1a3:df2f:ab7 with SMTP id i7-20020a056a20438700b001a3df2f0ab7mr2341741pzl.24.1711612258362;
        Thu, 28 Mar 2024 00:50:58 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79a48000000b006e6aee6807dsm746913pfj.22.2024.03.28.00.50.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:50:58 -0700 (PDT)
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
Subject: [PATCH 02/10] rcu: Move rcu_preempt_depth_set() to rcupdate.h
Date: Thu, 28 Mar 2024 15:53:10 +0800
Message-Id: <20240328075318.83039-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240328075318.83039-1-jiangshanlai@gmail.com>
References: <20240328075318.83039-1-jiangshanlai@gmail.com>
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
index 16f519914415..210f65baf47c 100644
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


