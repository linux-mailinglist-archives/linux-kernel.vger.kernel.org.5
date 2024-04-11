Return-Path: <linux-kernel+bounces-141287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A978A1C25
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B349B1F22950
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FAB153838;
	Thu, 11 Apr 2024 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="k6YlraxO"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C43153518;
	Thu, 11 Apr 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851845; cv=none; b=YPoNPpY+pOa7p54wpxZFBX+NFVirEG/kWMhnaFKUF5HZtV2d5jptRXbkog1v7CbUDtH8OBeD6YmPIF1doKL3ri2lngO3tyzt1Q6sAobs7vjLPVdWaA+BpE+NUYOZEwfiWAgYs0IcI4aYGYhHPE2Pup0nljtUtjlkRkEmeY7rlCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851845; c=relaxed/simple;
	bh=bb9lzyphdX3stbBQR7nN0Hf6LMEEnErhkaUCmZrc0iI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQh3AGwxj5m7DIfOwu/nzqtQOTpB5rFa2KZDL7k3rmTazgVGK+wzVhTVofmcvnyFSKI2Q4QpRAdUB8JM/vaUKLvPHng4HO/m5WDYK2iQrBl4SYtq81Nur1PoezDcU43vVZTgx7K1LgdXIRIlMMRMWlfd7l6Kz+GPgBE5yEYva3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=k6YlraxO; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 159FE100087;
	Thu, 11 Apr 2024 19:10:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 159FE100087
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1712851840;
	bh=B97uQZTkk0TcEN1sTU7RxyBCX+ggxBCP+erXrBmLqtg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=k6YlraxOipAe1NE8LqA5SZL0YUmi/BGseDzY0qbVo9WnFR8J5P6y8QyCrg8d+Jr4n
	 GU6g/2S5xZ6l/8K7cqCblSsJll3sYotryyuXde3qn4Vz90x6mr/aF+I/ENjOffCDmF
	 34zEHEQgbPWw+YUtDDTfXHOJ/IFLJHk0FQ0UPPa7nSVtP1JhwVWOQ02n+OvY27gOor
	 OVRUAG7RUALTTYWN+lvO1ZOaZwxevNchMsbvCKBCA9gUDLkEjoxAcoR8ODI83L2Ukl
	 5UHbC5jfU+Fadk1VuI4G1MuNWdNMsj4tbbbXfjRun31sgmxp2UZBeKUFtHHHKqmkNG
	 FtssyBi33Fndg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 11 Apr 2024 19:10:39 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 11 Apr 2024 19:10:39 +0300
From: George Stark <gnstark@salutedevices.com>
To: <andy.shevchenko@gmail.com>, <pavel@ucw.cz>, <lee@kernel.org>,
	<vadimp@nvidia.com>, <christophe.leroy@csgroup.eu>, <hdegoede@redhat.com>,
	<mazziesaccount@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<nikitos.tr@gmail.com>, <marek.behun@nic.cz>, <kabel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@salutedevices.com>, George Stark <gnstark@salutedevices.com>
Subject: [PATCH v8 1/8] locking/mutex: introduce devm_mutex_init()
Date: Thu, 11 Apr 2024 19:10:25 +0300
Message-ID: <20240411161032.609544-2-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240411161032.609544-1-gnstark@salutedevices.com>
References: <20240411161032.609544-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184677 [Apr 11 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 16 0.3.16 6e64c33514fcbd07e515710c86ba61de7f56194e, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/04/11 11:38:00 #24745823
X-KSMG-AntiVirus-Status: Clean, skipped

Using of devm API leads to a certain order of releasing resources.
So all dependent resources which are not devm-wrapped should be deleted
with respect to devm-release order. Mutex is one of such objects that
often is bound to other resources and has no own devm wrapping.
Since mutex_destroy() actually does nothing in non-debug builds
frequently calling mutex_destroy() is just ignored which is safe for now
but wrong formally and can lead to a problem if mutex_destroy() will be
extended so introduce devm_mutex_init().

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: George Stark <gnstark@salutedevices.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Marek Behún <kabel@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
---
 include/linux/mutex.h        | 27 +++++++++++++++++++++++++++
 kernel/locking/mutex-debug.c | 12 ++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 7e208d46ba5b..66dfbbd66310 100644
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
@@ -121,6 +123,31 @@ do {							\
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
+	 * When CONFIG_DEBUG_MUTEXES is off mutex_destroy() is just a nop so
+	 * no really need to register it in the devm subsystem.
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
index bc8abb8549d2..6e6f6071cfa2 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -12,6 +12,7 @@
  */
 #include <linux/mutex.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/export.h>
 #include <linux/poison.h>
 #include <linux/sched.h>
@@ -89,6 +90,17 @@ void debug_mutex_init(struct mutex *lock, const char *name,
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
+EXPORT_SYMBOL_GPL(__devm_mutex_init);
+
 /***
  * mutex_destroy - mark a mutex unusable
  * @lock: the mutex to be destroyed
-- 
2.25.1


