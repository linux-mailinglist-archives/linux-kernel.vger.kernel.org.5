Return-Path: <linux-kernel+bounces-85754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD0686BA55
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCAE1C222AC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2300E76EE4;
	Wed, 28 Feb 2024 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VlKeYOdg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lrw8SHtZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07917290F;
	Wed, 28 Feb 2024 22:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157617; cv=none; b=fIqioub60mVSEU4J89Fbjd/ADvbghhjtASkEk+dQfEmg8OghxjV8x2OkE6D1pMa9yyO/s1z1tsdPz/Jc6dWwbNfjwySOEsA4ehFG0Wl9WmLe7db6vC3sM07qkBPQQNW1fzAhLvsoafZsDGDW33tJ1xOSl+WJhZxmmDlVdvrRjRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157617; c=relaxed/simple;
	bh=gaq5TYTqW08ZNeBM939Puu1SQTVAgMBneQ3qgHGe8Go=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zt8dq+71blhgyM+IoqeT4g4HxICrbH+uwa1f8W7R+YCe5HglRG5pl3ZFTJmjDnsWWZYU03laXYSmhuXg81Tj1sujogLz7iD6noJa7BKLHmgJ81qtz2wa1N5poSqQk444szQsm0zu5wN2d1W1rHiWvN3qyYSvZR8X6nGIdBXS9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VlKeYOdg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lrw8SHtZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 28 Feb 2024 22:00:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709157608;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiVaNdwW/PB2K/TUo+duWDQUE2T1VobPhccqg/kHJR0=;
	b=VlKeYOdg2cnDGheb7WAIG+lis5CC6wY+SFHCvXSpwJoVu5x0hleJM88s4EtIpypuSo6OeQ
	tSbdaP18kMIWE42U4VIWjM1n/TTaKXtKW86w1llNMqK9TeKm3joNuLGtgZ6ieaFHNPrwzI
	QtJKgIoi7pGtcF8TYSOk5w4euqFWJSf7l3S71MeArUU1QUMSkMTqN4uvcEIVlFOv0bJmnu
	3A1gmgRWaddGkDYIDRylxJi+YU9QlkR7e8HPVwXSpRlodPiZ72XGIb5eI4nNW2pFeAnSXo
	ARX2yfiglyocy695Gc5qUkjYMOTryZFpAi5+omt0Yy6eSqYADbknGtNZ/bRbCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709157608;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wiVaNdwW/PB2K/TUo+duWDQUE2T1VobPhccqg/kHJR0=;
	b=Lrw8SHtZD/9ttqFfhheA+3QEbSOS6wCNl6eyn2DkYuBBEByt5fvPXGirsfy45/kTMqjNko
	4vyFd/PGIcas6OCA==
From: "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Remove duplicate descriptions from
 TOPOLOGY_SD_FLAGS
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Alex Shi <alexs@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240210113924.1130448-1-alexs@kernel.org>
References: <20240210113924.1130448-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170915760769.398.2928849589357715130.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d654c8ddde84b9d1a30a40917e588b5a1e53dada
Gitweb:        https://git.kernel.org/tip/d654c8ddde84b9d1a30a40917e588b5a1e53dada
Author:        Alex Shi <alexs@kernel.org>
AuthorDate:    Sat, 10 Feb 2024 19:39:19 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 28 Feb 2024 15:29:21 +01:00

sched/topology: Remove duplicate descriptions from TOPOLOGY_SD_FLAGS

These flags are already documented in include/linux/sched/sd_flags.h.

Also, add missing SD_CLUSTER and keep the comment on SD_ASYM_PACKING
as it is a special case.

Suggested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Alex Shi <alexs@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240210113924.1130448-1-alexs@kernel.org
---
 kernel/sched/topology.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 10d1391..0b33f7b 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1551,11 +1551,12 @@ static struct cpumask		***sched_domains_numa_masks;
  *
  * These flags are purely descriptive of the topology and do not prescribe
  * behaviour. Behaviour is artificial and mapped in the below sd_init()
- * function:
+ * function. For details, see include/linux/sched/sd_flags.h.
  *
- *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
- *   SD_SHARE_PKG_RESOURCES - describes shared caches
- *   SD_NUMA                - describes NUMA topologies
+ *   SD_SHARE_CPUCAPACITY
+ *   SD_SHARE_PKG_RESOURCES
+ *   SD_CLUSTER
+ *   SD_NUMA
  *
  * Odd one out, which beside describing the topology has a quirk also
  * prescribes the desired behaviour that goes along with it:

