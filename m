Return-Path: <linux-kernel+bounces-112517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F04E887B15
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42FB8281FCD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597E95B697;
	Sat, 23 Mar 2024 23:17:18 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC509523C;
	Sat, 23 Mar 2024 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711235837; cv=none; b=Aks6kEuL2saqWcpnY239OjtMB+ibwz6am8BfiJAZPxIP7varlCfnYVBEZqTF++TefT+DRzFC9WHhk8jQ09+IYC/Z25EjA34/BlHHadMejX797HFLmSP+3djT4mc6oPKUG1Q0gKNQzcV3xVQq5uFSd6Ro/h2YxKIlXT38cSg7FL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711235837; c=relaxed/simple;
	bh=tQV3luiGuHVFjRtP9OLC3m2pIMUgpw3uWFJOcbLDuc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oV/6e2yHgVPZ7/N+LNzxZUIf0VUi507GOxEZj/f8U42z0fsMTL4+Wb0EAvNxpbgokcENHf40yVmjw83PA/1MmQ4M98YFIif1i6YxfuypX81qE1NMk3ulpESHaDOASaBYv7wYbpLXIyY50RkG/yBaLDSgALklFqcIhvwHLpMelzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id EF3BF72C8CC;
	Sun, 24 Mar 2024 02:17:07 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id E06BB36D071C;
	Sun, 24 Mar 2024 02:17:07 +0300 (MSK)
From: Vitaly Chikunov <vt@altlinux.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	"Steven Rostedt (Red Hat)" <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vitaly Chikunov <vt@altlinux.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] tracing: Fix documentation on tp_printk cmdline option
Date: Sun, 24 Mar 2024 02:17:04 +0300
Message-ID: <20240323231704.1217926-1-vt@altlinux.org>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kernel-parameters.txt incorrectly states that workings of
kernel.tracepoint_printk sysctl depends on "tracepoint_printk kernel
cmdline option", this is a bit misleading for new users since the actual
cmdline option name is tp_printk.

Fixes: 0daa2302968c ("tracing: Add tp_printk cmdline to have tracepoints go to printk()")
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bb884c14b2f6..623fce7d5fcd 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6599,7 +6599,7 @@
 			To turn off having tracepoints sent to printk,
 			 echo 0 > /proc/sys/kernel/tracepoint_printk
 			Note, echoing 1 into this file without the
-			tracepoint_printk kernel cmdline option has no effect.
+			tp_printk kernel cmdline option has no effect.
 
 			The tp_printk_stop_on_boot (see below) can also be used
 			to stop the printing of events to console at
-- 
2.42.1


