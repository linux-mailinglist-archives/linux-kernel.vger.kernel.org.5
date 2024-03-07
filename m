Return-Path: <linux-kernel+bounces-94869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3587462D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9403E1F23F13
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F95CA6B;
	Thu,  7 Mar 2024 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ngT8lCR3"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6806D1847;
	Thu,  7 Mar 2024 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779256; cv=none; b=hpVIqg92GrjyfTZjhzs1EA13+SQNQZChAkxgA77aFjn0PyXbtlzi7Pd6VeMFjyczFrd2PR1PWUcH6bsoQIjr5GMJbQNOcib/O2WNK9PKBzMzC/LPFq33IPBVTgja/FJoIxG6DIa7iYFYPND7P9g2ZjyDMtsjLELx+s4Qep+mG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779256; c=relaxed/simple;
	bh=Yjjz5ewPjXZp4KyL2oiueZbhuwnsqUODQj8pNHnwbkc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJbtFnOEg6mXXJZPx4wiFzm1NEN4ci8mL569hfjFMV6Rbe6J4+MuYRQW82Yso+SABZPQGqKTWzBl1Kvnc74r4aArMURKosEIMNZ1O0qfQXL5dKGUVx3LlLFGWtm0qkvUyWnCnmAcaPks01TbMZ6bx7Og9TB2avbAUnKEp1h/TIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ngT8lCR3; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 05C5312001F;
	Thu,  7 Mar 2024 05:40:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 05C5312001F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1709779245;
	bh=jEVsja8SSmoMIIjVaOxrbFMoSgIk5r+GyxaxqJuvUC4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ngT8lCR3EkUmke2AOk56uWYG4CAuNBWDlIKszqS1zln2UZaEF+1yEzt2vI7f8Nn0W
	 KojlbOIIVzM95uqCKn1NJAG9vU7b7gTDCvhIX+GMFiquDk7sLDkBvk95nuPECE26q+
	 /Eu1HxrZr7thZXj90/iIJeve4tbdPOdjyWU3MBLNdcnHzamHA9gDqdOxG0dw/J7M1Z
	 k4bhE4Og8ZeCC8Een2FVn7E1O5Bi610KIzTocJq+EGHSvRT2FRDAQg/Qkcz5A8Yvpc
	 wrhRfI+pCpolfY/a0nOpQJL8Kmbusli08c3YBudNBCLrJHzmh3LJFTmnH/15ZiZWEe
	 qlS4PomkNG+nw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu,  7 Mar 2024 05:40:44 +0300 (MSK)
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
Subject: [PATCH v5 01/10] locking/mutex: move mutex_destroy() definition lower
Date: Thu, 7 Mar 2024 05:40:25 +0300
Message-ID: <20240307024034.1548605-2-gnstark@salutedevices.com>
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

mutex_destroy() definition is located in the middle of the code related
purely to mutex initialization so place it separately after mutex_init()

Signed-off-by: George Stark <gnstark@salutedevices.com>
---
Hello Waiman. This is helper patch to make resulting mutex.h look like we discussed
it in December. It was in you cleanup patch at first but slept away somehow

 include/linux/mutex.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 67edc4ca2bee..f7611c092db7 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -37,14 +37,10 @@
 # define __DEBUG_MUTEX_INITIALIZER(lockname)				\
 	, .magic = &lockname

-extern void mutex_destroy(struct mutex *lock);
-
 #else

 # define __DEBUG_MUTEX_INITIALIZER(lockname)

-static inline void mutex_destroy(struct mutex *lock) {}
-
 #endif

 #ifndef CONFIG_PREEMPT_RT
@@ -117,6 +113,16 @@ do {							\
 } while (0)
 #endif /* CONFIG_PREEMPT_RT */

+#ifdef CONFIG_DEBUG_MUTEXES
+
+void mutex_destroy(struct mutex *lock);
+
+#else
+
+static inline void mutex_destroy(struct mutex *lock) {}
+
+#endif
+
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.
--
2.25.1


