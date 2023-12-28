Return-Path: <linux-kernel+bounces-12408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE3381F45E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 04:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1551F22368
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1586F1396;
	Thu, 28 Dec 2023 03:21:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A05E8137B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 03:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id B414B6019FAD7;
	Thu, 28 Dec 2023 11:20:52 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: tglx@linutronix.de,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?kernel:=20cpu:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20err?=
Date: Thu, 28 Dec 2023 11:20:51 +0800
Message-Id: <20231228032051.13440-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The err variable is assigned when it does not need to be defined, as it
has already been assigned before use.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index c1f331ddf0dc7..bea9cd176449e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1720,7 +1720,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 
 static int cpu_up(unsigned int cpu, enum cpuhp_state target)
 {
-	int err = 0;
+	int err;
 
 	if (!cpu_possible(cpu)) {
 		pr_err("can't online cpu %d because it is not configured as may-hotadd at boot time\n",
-- 
2.18.2


