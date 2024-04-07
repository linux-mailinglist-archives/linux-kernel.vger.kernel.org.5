Return-Path: <linux-kernel+bounces-134278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C3A89AFE3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675F5B2221D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321523765;
	Sun,  7 Apr 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc79AA6G"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D333225D0;
	Sun,  7 Apr 2024 09:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480623; cv=none; b=G9UQGj3p5Wyd/nZv4WmSKkc/dmVdO0LWOn6BtEs+IMZQziUeX04t6kU7IoaHTvAFvvlId9mY9a7xnJMRDOJJvMt34awSlcdMtqdy+pQNmFSpdgSMFpUngouvxiqWmkKhoRvUQdvhwGzn/6UwGTd0LlWMOrW+A7FiRY7stAL53Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480623; c=relaxed/simple;
	bh=fbc/eh8HxR9mhBJCVcgaSscwMF8MFg41ZBJxKMGrRA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pzdR/+xpQ2mKeEH6xncu6GyAXENSI/irhtlerkaLnlyx6eBFcKGy7WAdMR88v+fSHyeMMj+Z21Z32FO6mlJta/QnNbDnjZtqM1TTgSNHuA0c6PC+xeEak+y5+YZ9B5nCAHzuXmsUEq/aust9QHxFx4GVT1oYKeDOZsSnucnwhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc79AA6G; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ed2dc03df6so12903b3a.1;
        Sun, 07 Apr 2024 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480620; x=1713085420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RryskTliZ3IXjIMEW4QLTJUCIPdL2atrGVjHqL54oO4=;
        b=jc79AA6Gso7gENaAKp+SmB7dB9pe17z50Cj5CRYFoG/mKJUo4Ij8QG2d94CIN3mFyi
         c8pxqhlTbjRFmmHPOjdYq4YppZudK91fha8BQyvmcuGC6iLaxtjbPioMvMima8zfkksY
         kfpBoONJH5h9HAEHqKj98jq/WwR7eyFjf6RyYNJl6ppXXftTj4dbel7/Xlrl6hFOfa0C
         YRhG4UrPokICxNr3PHvYJz8KIxObn3LKWbVoaOY3qixCQfgs92QifA+2KQGggRW+dTm2
         oRpg9Q6AN2tAgxNrX3VQEQVO5RkEGKfkECxgvslkaTxIYXSsP1AUElaz8UOyIaL70ZFm
         /Bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480620; x=1713085420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RryskTliZ3IXjIMEW4QLTJUCIPdL2atrGVjHqL54oO4=;
        b=BzjIgO9XzKeLHMmfDGz6MQcRU/LDEV0XYMBdXunPRkTZ6/9hjTcFphIyANP4eLi4Ha
         qwKI3xJVQf90XoXinpUWNXqHFyHqofWpgK+KyDaehlzSLppmmeAXsmFKWedkSPfzMoXl
         PvlN8dDrCL7s2t7C3R0f7ErgFNaOiScuExw2SeYyxSr6G9nzRqDijOvtUwDH5DFvieYN
         0u8MI83mgiS0eXPh2bra+zUaJo5GoCjn2v8VsEEwtGPuuZGLtPJm9oS1HPLDtG9nFJJn
         3Qmc+SkqNU76YQrmKTVFRG2nFTdZVkZY0p8Jxq4wv9pP+71LysP9f6iUrAdjlTXOrtdV
         NZog==
X-Gm-Message-State: AOJu0Yy0cVS8+b3S6Mz78Et9LVrlvqNLEEw4E+i7XIiL3VEoBjPweElw
	1ba3wlIVjX2d/GhOHfafgh+tRgjR+7U1/l3NfmhmFgx4lrm09J+DYAziIlmc
X-Google-Smtp-Source: AGHT+IGbg1psQDNl4aGTCjaoHOZ/zbY+xXBJoXh6D1RemuxFUcbUJQU2ZTzC3jwjhyKQjLgtVQ8Z/g==
X-Received: by 2002:a05:6a20:394f:b0:1a3:a637:9753 with SMTP id r15-20020a056a20394f00b001a3a6379753mr8330961pzg.12.1712480620477;
        Sun, 07 Apr 2024 02:03:40 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id p37-20020a056a0026e500b006e6813f2301sm2587566pfw.56.2024.04.07.02.03.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:03:40 -0700 (PDT)
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
Subject: [PATCH V2 03/11] rcu: Reorder tree_exp.h after tree_plugin.h
Date: Sun,  7 Apr 2024 17:05:50 +0800
Message-Id: <20240407090558.3395-4-jiangshanlai@gmail.com>
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

Enable tree_exp.h using some rcu preempt macros introduced in
the next patch. The new macros touch core rcu-preempt fields
and are better to be implemented in tree_plugin.h.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/rcu/tree.c        | 2 +-
 kernel/rcu/tree_plugin.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d9642dd06c25..57d1ae26861f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -5245,6 +5245,6 @@ void __init rcu_init(void)
 }
 
 #include "tree_stall.h"
-#include "tree_exp.h"
 #include "tree_nocb.h"
 #include "tree_plugin.h"
+#include "tree_exp.h"
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b1264096d03a..d899b4afc21c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -103,6 +103,7 @@ static void __init rcu_bootup_announce_oddness(void)
 #ifdef CONFIG_PREEMPT_RCU
 
 static void rcu_report_exp_rnp(struct rcu_node *rnp, bool wake);
+static bool sync_rcu_exp_done(struct rcu_node *rnp);
 static void rcu_read_unlock_special(struct task_struct *t);
 
 /*
-- 
2.19.1.6.gb485710b


