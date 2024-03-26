Return-Path: <linux-kernel+bounces-119709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B2388CC4C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC401F856AF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E6C13C836;
	Tue, 26 Mar 2024 18:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUknMdlJ"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B513CFA0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478837; cv=none; b=RZbm9tpJ9o1ZZLVqtzMUZGMygDSFMDPDvSKnIT3UpTmPJIQcFzlBOrLbdJsea66TEEm4E18ys3qWFBobQeX3mi2mpIVD59cjq88J88ns3JTTQdAeJ/CKefv2fAHTZEDZ8945LZ7oQ5tUyC52TAjuVHrSIAei0HRk9c4vLLy+hJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478837; c=relaxed/simple;
	bh=qJq0cSG6/Z2CaYD7aH9kWyOyMhGjPxTKdVQgOaB8aU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QpKkxBr6bIbhDMpY2yLp1+YcIW4SRENd3l/oBQIDKCPMDhK3rs82KhMqbcyQYTjJENIX0tww9iP/SBmyWtOiwaNAi0bt1H5qjI5c529GECuISzDQNaTx1KfP9qzg2CVjSVogAPrrOhtySPJsJw//J9i3o3z3P0W583wXjXsiNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUknMdlJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5101cd91017so6926441e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711478833; x=1712083633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VycL5qDrPHCDWWbHqXExQCkFHxLflz/cf4MtnxAQLPE=;
        b=YUknMdlJYzRpnMfixv93oT0M6Lgd6wxErkSu9vJ+dcc3ZS6pTxp0HREqyQjfTumst0
         R843qcROEMUvce+I1Ix3N82Z1KZLST+Bp14e7O+/grfsSjBP62jdlvRMUy7fyx29YV0b
         R0o+QvNFHUwF9Koe3SCcfNVRIM8K5ynbip7Y47XaK4IjGh+UKMsHsyAGoAHAeHHqfXYn
         iZRxvyZpCuM0Zko4dGfvkJTPqgZWgvIsrmfYl83fMRnMdpuIktK20LorJqbPaCv2K1y4
         HolBQvZP/10apWcISRTepF6wqVooeQT75NeVEE9DEPsVpTGFzf4cjyaCRQ/AJ8jMq1zU
         S4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711478833; x=1712083633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VycL5qDrPHCDWWbHqXExQCkFHxLflz/cf4MtnxAQLPE=;
        b=d0psBC8AFUgFyhH0bRD6gda5KHOloHXqI/8bb/nn1JdFVfE0P0aSZldHLIO3WjTpXv
         jelI+lFBoyKVr6mndjlZCnky9MIRqRsF2SSADtAI+3M+EVGUvmSyvBvZGpiy/IoQV9Zo
         mD34pbREdmb9NI8owNrwF2g0tQtU0w2AKn+bRbtPDBzsI+6HTwl22GamXeGaCs7NPaQn
         fhff2YjqZyMalkS3Gv3DYU/FPPwpGHHy8PnWHosDraLk9wU1K+LRfWclAHqluA6yfhiK
         TtyeVnSyE1pAwX9W17Azmj5vdGSWQDB5yiZeBGfPfFZUw+Lgl/HCNahivlrCF7sZ3o/8
         chvQ==
X-Gm-Message-State: AOJu0YyJknuUvu564NB8zzFirjj3nWZQ5qQcWCsnBM8FvcT8neuo6Cvf
	FHcYrfOAgEErlFsbE2ZJwPBFS9WBQCmdCGrQa4OyHBo1Ka3yrhlqlx1WlY2H
X-Google-Smtp-Source: AGHT+IF5J7Ksbagb52c2AWvuyqGKYpcRR+4uDFGY23w4k3s/FSuJLokWRE9iE9uJg2YSIfdloe1UQg==
X-Received: by 2002:a19:6a0e:0:b0:513:dba5:ac67 with SMTP id u14-20020a196a0e000000b00513dba5ac67mr1666249lfu.32.1711478833471;
        Tue, 26 Mar 2024 11:47:13 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
        by smtp.gmail.com with ESMTPSA id i12-20020a0565123e0c00b00515acc50f71sm890424lfv.260.2024.03.26.11.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:47:13 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: linux-kernel@vger.kernel.org
Cc: maximmosk4@gmail.com,
	Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: [PATCH 6/8] locking: replace seq_puts by seq_putc
Date: Tue, 26 Mar 2024 21:47:10 +0300
Message-Id: <20240326184710.8799-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
References: <20240326184514.8478-1-Maxim.Moskalets@kaspersky.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using seq_putc for single characters is faster and more appropriate
than seq_puts, since only one character is passed and there is no need
to use a more powerful and less fast function.

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
---
 kernel/locking/lockdep_proc.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index e2bfb1db589d..4612d1c4f45e 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -101,17 +101,17 @@ static int l_show(struct seq_file *m, void *v)
 
 	seq_printf(m, ": ");
 	print_name(m, class);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
 		list_for_each_entry(entry, &class->locks_after, entry) {
 			if (entry->distance == 1) {
 				seq_printf(m, " -> [%p] ", entry->class->key);
 				print_name(m, entry->class);
-				seq_puts(m, "\n");
+				seq_putc(m, '\n');
 			}
 		}
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 
 	return 0;
@@ -175,9 +175,9 @@ static int lc_show(struct seq_file *m, void *v)
 
 		seq_printf(m, "[%p] ", class->key);
 		print_name(m, class);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	return 0;
 }
@@ -379,7 +379,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 	/*
 	 * Zapped classes and lockdep data buffers reuse statistics.
 	 */
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	seq_printf(m, " zapped classes:                %11lu\n",
 			nr_zapped_classes);
 #ifdef CONFIG_PROVE_LOCKING
@@ -422,10 +422,10 @@ static void seq_line(struct seq_file *m, char c, int offset, int length)
 	int i;
 
 	for (i = 0; i < offset; i++)
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	for (i = 0; i < length; i++)
 		seq_printf(m, "%c", c);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 }
 
 static void snprint_time(char *buf, size_t bufsiz, s64 nr)
@@ -512,7 +512,7 @@ static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
 		seq_lock_time(m, &stats->write_waittime);
 		seq_printf(m, " %14lu ", stats->bounces[bounce_acquired_write]);
 		seq_lock_time(m, &stats->write_holdtime);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 
 	if (stats->read_holdtime.nr) {
@@ -521,7 +521,7 @@ static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
 		seq_lock_time(m, &stats->read_waittime);
 		seq_printf(m, " %14lu ", stats->bounces[bounce_acquired_read]);
 		seq_lock_time(m, &stats->read_holdtime);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 
 	if (stats->read_waittime.nr + stats->write_waittime.nr == 0)
@@ -561,9 +561,9 @@ static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
 			   ip, (void *)class->contending_point[i]);
 	}
 	if (i) {
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 		seq_line(m, '.', 0, 40 + 1 + 12 * (14 + 1));
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 }
 
-- 
2.39.2


