Return-Path: <linux-kernel+bounces-102995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B7A87B990
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4780F1C21893
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9426E5FB;
	Thu, 14 Mar 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Km0rU/5E"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7246D1AD;
	Thu, 14 Mar 2024 08:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710405983; cv=none; b=toSqondCxUvTGV/gzOjKcjs+/MGyABWgfFfHpY5xTYchbuo7IWIJhVBZvSY3fU9Ofa5lWaVDBfKbEJbzx+reEmYnVzmzylAz2AgiylhUnFwSZkyMZInbWOpibiRVzNOOxmvuL06Rq5SLB+GGc3WNzX+uw43JSz2BX36+LaosQGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710405983; c=relaxed/simple;
	bh=1wp47qp/alsOZHbeqiRWsh/Pk9ud/IcelhS3NNl88Xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9USZwieycXOEfMKDVqE9knsyFvRXz64g7R9VLhoowRaCJDkXrXRxpTlIqocLYRMkFwCNLRj3JNN1uvV1n5cD282GkAovGEKCVzV4L/Ecp8ic7xkds6r97r/3FDP7vajBAgUof1dfoLeWGozhErzqiCbU8kpn2xW1ehovYHOgao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Km0rU/5E; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id F3DA2120008;
	Thu, 14 Mar 2024 11:46:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru F3DA2120008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710405974;
	bh=7LCfx2PuYn9jYgJQVVqsryHiVahatRhw2btAYqtVZKA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Km0rU/5EocJAGAGZUTwMqQW8XgG6JPo2LG/cdDXbhCOBG50+BbEaCA4CUdi3q8YO5
	 Tj/UlU/1LzkSQb/lXzFcXEj+u82RamL1hG+CJRep9/llwry1Y8RXQSK8mIA2/9iHQ5
	 7VITNa4d06ebreVhGtVi3kAXq6FHvP71gUt0ezJI1BtmrGnGRB8OascoAGnbovXxIy
	 Fem0sKyRXdYQ1wGGgZ3Ujfrnis7mubDgTFYP7Q/YfWpYEkPQbNk/cY/eyORXa/xDOK
	 +s4x1AHMuYKwW2Kyjs2Ju6LsJKuKiey+op77hhmjCfN8Uw0b6q4eNZpkdOrvDoWROa
	 L8hJ1tqXgjPzQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 14 Mar 2024 11:46:13 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 11:46:13 +0300
From: George Stark <gnstark@salutedevices.com>
To: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
	<vadimp@nvidia.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <marek.behun@nic.cz>, <kabel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>, George Stark
	<gnstark@salutedevices.com>
Subject: [PATCH v6 1/9] locking/mutex: introduce devm_mutex_init
Date: Thu, 14 Mar 2024 11:45:23 +0300
Message-ID: <20240314084531.1935545-2-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314084531.1935545-1-gnstark@salutedevices.com>
References: <20240314084531.1935545-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
X-KSMG-AntiVirus-Status: Clean, skipped

Using of devm API leads to a certain order of releasing resources.
So all dependent resources which are not devm-wrapped should be deleted
with respect to devm-release order. Mutex is one of such objects that
often is bound to other resources and has no own devm wrapping.
Since mutex_destroy() actually does nothing in non-debug builds
frequently calling mutex_destroy() is just ignored which is safe for now
but wrong formally and can lead to a problem if mutex_destroy() will be
extended so introduce devm_mutex_init()

Signed-off-by: George Stark <gnstark@salutedevices.com>
Suggested by-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/mutex.h        | 27 +++++++++++++++++++++++++++
 kernel/locking/mutex-debug.c | 11 +++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 67edc4ca2bee..f57e005ded24 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -22,6 +22,8 @@
 #include <linux/cleanup.h>
 #include <linux/mutex_types.h>
 
+struct device;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
 		, .dep_map = {					\
@@ -117,6 +119,31 @@ do {							\
 } while (0)
 #endif /* CONFIG_PREEMPT_RT */
 
+#ifdef CONFIG_DEBUG_MUTEXES
+
+int __devm_mutex_init(struct device *dev, struct mutex *lock);
+
+#else
+
+static inline int __devm_mutex_init(struct device *dev, struct mutex *lock)
+{
+	/*
+	 * When CONFIG_DEBUG_MUTEXES is off mutex_destroy is just a nop so
+	 * no really need to register it in devm subsystem.
+	 */
+	return 0;
+}
+
+#endif
+
+#define devm_mutex_init(dev, mutex)			\
+({							\
+	typeof(mutex) mutex_ = (mutex);			\
+							\
+	mutex_init(mutex_);				\
+	__devm_mutex_init(dev, mutex_);			\
+})
+
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index bc8abb8549d2..6aa77e3dc82e 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -19,6 +19,7 @@
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 #include <linux/debug_locks.h>
+#include <linux/device.h>
 
 #include "mutex.h"
 
@@ -89,6 +90,16 @@ void debug_mutex_init(struct mutex *lock, const char *name,
 	lock->magic = lock;
 }
 
+static void devm_mutex_release(void *res)
+{
+	mutex_destroy(res);
+}
+
+int __devm_mutex_init(struct device *dev, struct mutex *lock)
+{
+	return devm_add_action_or_reset(dev, devm_mutex_release, lock);
+}
+
 /***
  * mutex_destroy - mark a mutex unusable
  * @lock: the mutex to be destroyed
-- 
2.25.1


