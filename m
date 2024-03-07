Return-Path: <linux-kernel+bounces-94875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4E87463A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A2861C21A73
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD0B1C6B7;
	Thu,  7 Mar 2024 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="k3w+8DQK"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6841710FD;
	Thu,  7 Mar 2024 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779256; cv=none; b=Gi2jFavesK7FhB+LCvrxRaz+gkFSQg60kZtd0e06O/gkjQGgMjSR76XO9zOQ0BBRHjEinQxtw/QFpmg6UCnyoYtldxvs44xoTyjUUXabqc1ZUxAw/ZqC1Xc5S2sBUQ0O6SOaVvTl65ULugkLgTRrmU4WSAg+RdTaqRDaSv43XOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779256; c=relaxed/simple;
	bh=UE0TY/3q957KVRIjVYoueNUwmQf5HGQ0Hm6CoA9ZdTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYZ2kGTqgI6hYelI09O9vy00hYMQALoEhtnBpWUuxMILzcFsUi/3dFCAjEs+x7CgRvpVVt0mtmu2i0tEZirzrtsBph7ZZmXuuvnUsbEH2ezPR8x1u/hpNG2wdI0t7PE75ajA0uDuSRgvMxYxH6x9Mzyz6Le/zpvqWMh7IhBr4s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=k3w+8DQK; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 45A39100025;
	Thu,  7 Mar 2024 05:40:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 45A39100025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709779245;
	bh=P/O5w/8cj7I+6+/1kVHjj9xK1e1tJXqkaq/6XxYDflE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=k3w+8DQKlF91NKxB21htrdawx2AotviLb3pmh3STsrkcMwMLsI55bPu/xmidlzxrv
	 92naq5T7S88QeSLNbmy67UABFnxK/9+jjVYGWzwJPQlVQ45NXbUWh+xyEZIucBReSm
	 WVDQ3I1EtfxTrKUulke63Pk8LkaX8ZommFKMhtb+Tf3FXCU4Zu9qs3Bs+4ppEfKMBG
	 fawCmnXBIgQZqUNlAP2eT+bVgO9bOB6FtdfTpIDmdGa3iWriwvfIBQfLNtZQ1nMKl6
	 71In8X5XlWdXQ4sOPol3KCMk0FjP937env9HY61qbqFNwppK/gRcMSzYgjgzN+B97a
	 H0rPCvtz4F1SA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  7 Mar 2024 05:40:45 +0300 (MSK)
Received: from localhost.localdomain (100.125.24.169) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Mar 2024 05:40:44 +0300
From: George Stark <gnstark@salutedevices.com>
To: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
	<vadimp@nvidia.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <kabel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <kernel@salutedevices.com>, George Stark
	<gnstark@salutedevices.com>
Subject: [PATCH v5 02/10] locking/mutex: introduce devm_mutex_init
Date: Thu, 7 Mar 2024 05:40:26 +0300
Message-ID: <20240307024034.1548605-3-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240307024034.1548605-1-gnstark@salutedevices.com>
References: <20240307024034.1548605-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.125.24.169
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
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 Hello Christophe. Hope you don't mind I put you SoB tag because you helped alot
 to make this patch happen.

 include/linux/mutex.h        | 13 +++++++++++++
 kernel/locking/mutex-debug.c | 22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index f7611c092db7..9bcf72cb941a 100644
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
@@ -115,10 +117,21 @@ do {							\

 #ifdef CONFIG_DEBUG_MUTEXES

+int devm_mutex_init(struct device *dev, struct mutex *lock);
 void mutex_destroy(struct mutex *lock);

 #else

+static inline int devm_mutex_init(struct device *dev, struct mutex *lock)
+{
+	/*
+	 * since mutex_destroy is nop actually there's no need to register it
+	 * in devm subsystem.
+	 */
+	mutex_init(lock);
+	return 0;
+}
+
 static inline void mutex_destroy(struct mutex *lock) {}

 #endif
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index bc8abb8549d2..c9efab1a8026 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -19,6 +19,7 @@
 #include <linux/kallsyms.h>
 #include <linux/interrupt.h>
 #include <linux/debug_locks.h>
+#include <linux/device.h>

 #include "mutex.h"

@@ -104,3 +105,24 @@ void mutex_destroy(struct mutex *lock)
 }

 EXPORT_SYMBOL_GPL(mutex_destroy);
+
+static void devm_mutex_release(void *res)
+{
+	mutex_destroy(res);
+}
+
+/**
+ * devm_mutex_init - Resource-managed mutex initialization
+ * @dev:	Device which lifetime mutex is bound to
+ * @lock:	Pointer to a mutex
+ *
+ * Initialize mutex which is automatically destroyed when the driver is detached.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+int devm_mutex_init(struct device *dev, struct mutex *lock)
+{
+	mutex_init(lock);
+	return devm_add_action_or_reset(dev, devm_mutex_release, lock);
+}
+EXPORT_SYMBOL_GPL(devm_mutex_init);
--
2.25.1


