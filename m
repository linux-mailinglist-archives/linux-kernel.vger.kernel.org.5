Return-Path: <linux-kernel+bounces-122536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB288F923
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F091C22C24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A14054672;
	Thu, 28 Mar 2024 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qrne00b+"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC7458209;
	Thu, 28 Mar 2024 07:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612274; cv=none; b=s+yTDAumW22GfRXl2pSlAnM/sqBGp6tnJ1kIRBpK63pxtIoKhwX04ntCrqdTSXjLGTwv4MFvmlxYycZtlr0BQAOspWhEPVqQQj2d74iflZnAI6cuRC0oX/B6Ga8Ydtzij42ixGE75CJlZ2iqU1blr6FLt5S4U2HwuOtPIa1DVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612274; c=relaxed/simple;
	bh=3TturtFYIwfV1u8ACm2gm3tHdeACQEBcKlzkWT/2VSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DvsXjEKC5uAyp9gLZGU+IxMEN5kRoYrYG/f/MEWofKDYOFQayGyVR6ZjW5WiWokcJMkSVY8M5CntZ5CE+4hNyU7KC0M4/kMjZs2vxDk6H8CO/zvdSbdaK1PZF80U6uYHIPXUXDHd15v+3BuZe2lmLtFcxkysOhoyLaC8WADRVi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qrne00b+; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e74bd85f26so607163b3a.1;
        Thu, 28 Mar 2024 00:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711612272; x=1712217072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7zjP/fD7ntbdBgOTsfd20ge3XzeOlmyb2f9DwxHaY0=;
        b=Qrne00b+JFmLsVv8yqzD+LXn8kxvQxd/rR2Rw8x0Qp3aga06+j9f1w6sA0K3UM2be4
         B8FCz0UndJylAVTvr0QMcWx8OVvJhqQTgbFhwDV7imQdzUv6omQPx/ShdeRc9PDpfVcE
         Jy/rQFWS5ULSo+wV3HoFeauCVUJH03HVseDWznp1YRQ3kvh9zi75EmHZCvNcJF25+L+1
         UwNwIW1KfFv4yqNO3CD9oL2YW0VaTKevyeICi/KEltNmWCe2ZKok3v25oY3JFkmp+/qG
         0PbOMPlsCkT0Q6mQBrY1+rNttAqXXMnzORK5HGIWavR1qnoo33zvg3e1ShW/vkmGL1cb
         v5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711612272; x=1712217072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7zjP/fD7ntbdBgOTsfd20ge3XzeOlmyb2f9DwxHaY0=;
        b=PWt/GIxsqAIzsmSPkQhEZej0xseVpp14I65/LcuOpSAGhu0r8AIJ0bnHqyTmWqh3XU
         xsQN0/R4YpV0Tpj0i4X3Sn0ypXpGbxSV4/MLxovQL3/DSEY/NWDCPquTmm1TrSIF9Pu2
         8gRXfLcQSVEEv9Haq5jQzjrfijsb7YzLSkwuOD41tC5e8DbrZvZnLOHATpWxPPa016op
         Ch3vjlAH6TRWXPK8QYQIIJqtMGkyU26JcqOYNWeEcmuZKyvK6fRofPjZuMMq7aQw84c6
         7DWoBswoRawPCvuPSr5lG28q/kzkA30pcwQ64OvTdP/gR4QNE4ciNrkmiHygzojE9jZP
         E9rw==
X-Gm-Message-State: AOJu0YxuTiVhieumi0TpdDCXLF3WjG1VUK/7Bqz9VaZ+yqjzUrjq7iYc
	Hs6uQYNalXwiNI3chWglCAnjU8i7GfmZTGeU7W13zlpxuN/zZbrL0acinE5k
X-Google-Smtp-Source: AGHT+IFSOSZLlO1NnrKQSPtda1+ZjQ15dhdKV5SqZhDSS9xqF0bDwi+WCn2fnHOjvcOnYPiQaKY6gg==
X-Received: by 2002:a05:6a20:2583:b0:1a5:6a72:af54 with SMTP id k3-20020a056a20258300b001a56a72af54mr1867908pzd.45.1711612271919;
        Thu, 28 Mar 2024 00:51:11 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b001e00d9680cesm864684plk.130.2024.03.28.00.51.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2024 00:51:11 -0700 (PDT)
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
Subject: [PATCH 06/10] rcu: Rename marco __LINUX_RCU_H to __KERNEL_RCU_H
Date: Thu, 28 Mar 2024 15:53:14 +0800
Message-Id: <20240328075318.83039-7-jiangshanlai@gmail.com>
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

to reflect the path of kernel/rcu/rcu.h.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/rcu/rcu.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 86fce206560e..b17b2ed657fc 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -7,8 +7,8 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
-#ifndef __LINUX_RCU_H
-#define __LINUX_RCU_H
+#ifndef __KERNEL_RCU_H
+#define __KERNEL_RCU_H
 
 #include <linux/slab.h>
 #include <trace/events/rcu.h>
@@ -668,4 +668,4 @@ int rcu_stall_notifier_call_chain(unsigned long val, void *v);
 static inline int rcu_stall_notifier_call_chain(unsigned long val, void *v) { return NOTIFY_DONE; }
 #endif // #else // #if defined(CONFIG_RCU_STALL_COMMON) && defined(CONFIG_RCU_CPU_STALL_NOTIFIER)
 
-#endif /* __LINUX_RCU_H */
+#endif /* __KERNEL_RCU_H */
-- 
2.19.1.6.gb485710b


