Return-Path: <linux-kernel+bounces-56565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD3684CBCD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C3C1C22A7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A0777F23;
	Wed,  7 Feb 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="txWlce/V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oSC6gHsw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7296578B5B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313281; cv=none; b=ROa5Eg+4YA/ukrHN2lue7wZkXzi+hhzzZu6xjEmXD8nD/pNtdJvv4+2cgKxue1C8dM5E3OdAkKjg2kwU1aa4gztcU+X1lcUFuL2zi7LzYO8Xb/YzkFhXUo22MJNMHEAD9DCWgrL9UrvxcTL26uuuXQ6WIEQGLFyHjdEYwPOuSww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313281; c=relaxed/simple;
	bh=+v9lcDo1j7EbJJddNqySiCuHHXP983V6j+dNnTQRZ8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nKVB/jZwJatW9rNr/hO6WtDV+lpLnYABsMwd6KcngGqBgqUc+Zdz+JRkDRotVcUJuZTXZ65bPPa3Vs5xlh7S6bkBTcFo+xI3Iwcq8HK1NwnbclkSbVHKBX+Rg0UIst7rd2V/bT+pJNIXmMgF2COo2LXSZS/6c9rgulDsJzYAcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=txWlce/V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oSC6gHsw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707313275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzU01CBQ+U6/10NpLEh7xrbRVSxOpjAkPvdRszZv9zc=;
	b=txWlce/Vii9hoEwPitzfHiLrHX8dYflO+WTZZa05ow6wxRxcyBi+r+e0zpCGJdFxKLgycP
	pETt1WlSUikiUaENDIARSd4XOGm3A3HNGGBo+RcSqc6R/5Qn6qvWjI80hEQ8QYhOQzeWc2
	JCoW8dxaWgltKLXdeyssEr02UiLi8EDoa8gLixTFSuzr6+u0r61myBQTknbQZYpTyl5OLz
	ugD+OAiDdnsHD1TwpfnsG6SGOtEbC1N5Snq/kehB32KorrBdHAALY9T4Ms7JtPRzoNso2p
	tNVirLr+FojpGAgu6zEuXaWWp5iGWQ1CyI3Ecn3T/NhT4wS3tI/OpiycCeigWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707313275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzU01CBQ+U6/10NpLEh7xrbRVSxOpjAkPvdRszZv9zc=;
	b=oSC6gHswbJBnqJT4l/nL8NzZGpH8R0m3uRxt0HMyndu/ErXEmIuHdJ0BlrMdR6bSDLs45D
	YWtUOTBd1n22L9Aw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH printk v4 05/14] printk: ringbuffer: Clarify special lpos values
Date: Wed,  7 Feb 2024 14:46:54 +0106
Message-Id: <20240207134103.1357162-6-john.ogness@linutronix.de>
In-Reply-To: <20240207134103.1357162-1-john.ogness@linutronix.de>
References: <20240207134103.1357162-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For empty line records, no data blocks are created. Instead,
these valid records are identified by special logical position
values (in fields of @prb_desc.text_blk_lpos).

Currently the macro NO_LPOS is used for empty line records.
This name is confusing because it does not imply _why_ there is
no data block.

Rename NO_LPOS to EMPTY_LINE_LPOS so that it is clear why there
is no data block.

Also add comments explaining the use of EMPTY_LINE_LPOS as well
as clarification to the values used to represent data-less
blocks.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk_ringbuffer.c | 20 ++++++++++++++++----
 kernel/printk/printk_ringbuffer.h | 16 +++++++++++++++-
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 04c26cca546f..244d991ffd73 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1034,9 +1034,13 @@ static char *data_alloc(struct printk_ringbuffer *rb, unsigned int size,
 	unsigned long next_lpos;
 
 	if (size == 0) {
-		/* Specify a data-less block. */
-		blk_lpos->begin = NO_LPOS;
-		blk_lpos->next = NO_LPOS;
+		/*
+		 * Data blocks are not created for empty lines. Instead, the
+		 * reader will recognize these special lpos values and handle
+		 * it appropriately.
+		 */
+		blk_lpos->begin = EMPTY_LINE_LPOS;
+		blk_lpos->next = EMPTY_LINE_LPOS;
 		return NULL;
 	}
 
@@ -1214,10 +1218,18 @@ static const char *get_data(struct prb_data_ring *data_ring,
 
 	/* Data-less data block description. */
 	if (BLK_DATALESS(blk_lpos)) {
-		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
+		/*
+		 * Records that are just empty lines are also valid, even
+		 * though they do not have a data block. For such records
+		 * explicitly return empty string data to signify success.
+		 */
+		if (blk_lpos->begin == EMPTY_LINE_LPOS &&
+		    blk_lpos->next == EMPTY_LINE_LPOS) {
 			*data_size = 0;
 			return "";
 		}
+
+		/* Data lost, invalid, or otherwise unavailable. */
 		return NULL;
 	}
 
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 2d948cc82b5b..d49460f7578e 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -127,8 +127,22 @@ enum desc_state {
 #define DESC_SV(id, state)	(((unsigned long)state << DESC_FLAGS_SHIFT) | id)
 #define DESC_ID_MASK		(~DESC_FLAGS_MASK)
 #define DESC_ID(sv)		((sv) & DESC_ID_MASK)
+
+/*
+ * Special data block logical position values (for fields of
+ * @prb_desc.text_blk_lpos).
+ *
+ * - Bit0 is used to identify if the record has no data block. (Implemented in
+ *   the LPOS_DATALESS() macro.)
+ *
+ * - Bit1 specifies the reason for not having a data block.
+ *
+ * These special values could never be real lpos values because of the
+ * meta data and alignment padding of data blocks. (See to_blk_size() for
+ * details.)
+ */
 #define FAILED_LPOS		0x1
-#define NO_LPOS			0x3
+#define EMPTY_LINE_LPOS		0x3
 
 #define FAILED_BLK_LPOS	\
 {				\
-- 
2.39.2


