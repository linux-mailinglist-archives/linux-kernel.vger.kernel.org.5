Return-Path: <linux-kernel+bounces-12404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB48E81F456
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA72B22953
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1AA5668;
	Thu, 28 Dec 2023 03:18:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 6546F5244
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 9929F6019ED87;
	Thu, 28 Dec 2023 11:17:52 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: tglx@linutronix.de,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?kernel:=20cpu:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20ret?=
Date: Thu, 28 Dec 2023 11:17:50 +0800
Message-Id: <20231228031750.12941-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ret variable is assigned when it does not need to be defined, as it
has already been assigned before use.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6de7c6bb74eee..c1f331ddf0dc7 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -998,7 +998,7 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 			      enum cpuhp_state target)
 {
 	enum cpuhp_state prev_state = st->state;
-	int ret = 0;
+	int ret;
 
 	ret = cpuhp_invoke_callback_range(true, cpu, st, target);
 	if (ret) {
@@ -1402,7 +1402,7 @@ static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 				enum cpuhp_state target)
 {
 	enum cpuhp_state prev_state = st->state;
-	int ret = 0;
+	int ret;
 
 	ret = cpuhp_invoke_callback_range(false, cpu, st, target);
 	if (ret) {
@@ -2488,7 +2488,7 @@ int __cpuhp_setup_state_cpuslocked(enum cpuhp_state state,
 				   int (*teardown)(unsigned int cpu),
 				   bool multi_instance)
 {
-	int cpu, ret = 0;
+	int cpu, ret;
 	bool dynstate;
 
 	lockdep_assert_cpus_held();
-- 
2.18.2


