Return-Path: <linux-kernel+bounces-134282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E61689AFE9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141D71F22C78
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6F12C6BA;
	Sun,  7 Apr 2024 09:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1xsNfx0"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3BC22F02;
	Sun,  7 Apr 2024 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480635; cv=none; b=JsMUejhSOD/p9WDs0Z5ccP69t+EK+BCIX1hgVFvoRPSghs/TqMYDe//mzfz78ZzZU2bOWJKXLO8GCAihmpSQ0ESwPu6qCzza0JW+j06L+j/YYCWY17vY7dGfi77TvJCbZTEPhHA4dKU7JOsXM9lA55n1b1xPTAXv6HArdK7fajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480635; c=relaxed/simple;
	bh=3TturtFYIwfV1u8ACm2gm3tHdeACQEBcKlzkWT/2VSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KsJfJ4rkUx7Ti05n00K2Q1THzY3hGnym0gvw68dy3Hrqz0dZ8h5ucdxokJBXhJ9oOwcIfkwxJC7I6aZb6wvoP3es1BOztrQT7IWtiNbsVwIODb9uL0XNAUT78MsLxMz3h/fmdGTQBgTXAP2W579t4SnFe2+f/CN9jpQTp71B0O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1xsNfx0; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2580802a12.3;
        Sun, 07 Apr 2024 02:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480633; x=1713085433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7zjP/fD7ntbdBgOTsfd20ge3XzeOlmyb2f9DwxHaY0=;
        b=M1xsNfx0NmYoubyMUScrEDrph+U8x/PfXlmiFJft93QuVlGx1Xc9u8FmDxQ1w7SOfu
         zDJvfuGr3K4kL1Xw5AvSM0k7whx12HNXPPmBp3HldfjA7vH6+u4BT8XYf2SRelAgoNU6
         p3weNc/P7KQi5A4aO76VKHIkT19b6uVMhSkkFxj7JGAmFythsSgG6AjWcgIyyaV7bqF6
         9+varSYGy4yfIGDJuY7JudIbuf4PE2KlacMsVHANa6dgiQIecfzb4xWnM/ikRZGEaMsZ
         92C1K2WC/1qtPyaSmPMDzysDJeb1nz+hbeuzeNQrV83/QQuQgglHiiJI8mkJuSQ2iuu7
         u6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480633; x=1713085433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7zjP/fD7ntbdBgOTsfd20ge3XzeOlmyb2f9DwxHaY0=;
        b=BJBRYsqWNYA6Sox7Jekcx9Cw0pXEY4oXUpNcdLIy62gpV1VZgUk3qmQn9suGDuexRk
         f1TgpmLnt47CQuRWsS0zD3BxyPL4a7Uym+28s41CXF7wpVJdnqulJkaiKl6PIXMDlCJW
         6C+uINsBR4Tadq/Wg+0IUv0IHwmCxW93hYxjvPJnz9V5ygU/tnfFJFb/bIXYsNIiGV/4
         H+i3jY3xvjzLDUGJwsadsPlDy+ACXHr6l3l1zBow7BeA4VYp5EoawSzn9NN1sTIXM6dk
         zSp2Qtnr807VU9rcq0eSgWl3Bz18AkIsTQSDh4B8yqZCUJMBbTLP4/A4JBaKK3Z8DXHf
         VECg==
X-Gm-Message-State: AOJu0YxkuSd3vvqi6Gm3AIj8z+o+msgIT1dR4sffQLFMxoCk3FE2H/6O
	/RJIBbKKLHfVqWjRa7PksupvHZCA/8JESbxBHUs2icNqqgSjSvAWW6EVjscE
X-Google-Smtp-Source: AGHT+IGUXYj82DWPk7jq9yGQJ0difrAS0sPahh0a1BfbXK03ecPROvUt1tXny7PR6YY3g1QvTtJxog==
X-Received: by 2002:a17:902:d386:b0:1e0:119e:f935 with SMTP id e6-20020a170902d38600b001e0119ef935mr4703483pld.15.1712480633128;
        Sun, 07 Apr 2024 02:03:53 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902680700b001e2b4f513e1sm4632217plk.106.2024.04.07.02.03.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2024 02:03:52 -0700 (PDT)
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
Subject: [PATCH V2 06/11] rcu: Rename marco __LINUX_RCU_H to __KERNEL_RCU_H
Date: Sun,  7 Apr 2024 17:05:53 +0800
Message-Id: <20240407090558.3395-7-jiangshanlai@gmail.com>
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


