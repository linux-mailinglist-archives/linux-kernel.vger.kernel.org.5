Return-Path: <linux-kernel+bounces-104609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B8287D0E4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A412F1C2169D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A7C44C86;
	Fri, 15 Mar 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SC6rGy6w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SC6rGy6w"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBD24086B;
	Fri, 15 Mar 2024 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710518539; cv=none; b=iMwLz/b5c/OxhvrsAwxc66t4n9oITjtongjj3jBmQVfj+YIwrqsKheyo+HzIdiUTX5UOqVLdlkbSHFm5x1BX0riMBA30B554+XUrS+jNyGIC00SdVTLzZHA4wpFWVjv9i/LLOOjUBzPaokGDzgVh1NPmQqLa3G7QYxrHI95HPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710518539; c=relaxed/simple;
	bh=6Ule3JN0U15LHh3rH6IkUT0Y0+A+gb7QON59wG/WH1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cWD1ea0VU9WwzuMvOs576FasD6SE+z611Zc6CE9yu+gDMzoS8ITcKNGlwXM7FVsnfeFGvunN6KjHaFY3OkxN6ILeOkvlIJhPcYMM1PZkoJrgVJZV23RutG/wwR+fSfLP+a4AJZC6+SDLnwjnQ/im/SArHv67ND0+f5+NkgkrREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SC6rGy6w; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SC6rGy6w; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D3EFF1FB6D;
	Fri, 15 Mar 2024 16:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710518531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=faiaAnTe6lOY2CBUd6zMN/hZKSHWHcaRYL1tD6+DLRk=;
	b=SC6rGy6wppVPzsUIuTEShsqR7wG141w9vLma94akKnEXqQjKdQriAhyq7O2BMymjvrDrpS
	2BhAD3iMSJY9nukgfaShrFuXYUMhzjZRSzoEglx0RNBGmI50G0oUoPAGf40gWKybK44yRG
	4KK5EQ7Wz+tlRN8ysUQ/9ndVDiADtOo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1710518531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=faiaAnTe6lOY2CBUd6zMN/hZKSHWHcaRYL1tD6+DLRk=;
	b=SC6rGy6wppVPzsUIuTEShsqR7wG141w9vLma94akKnEXqQjKdQriAhyq7O2BMymjvrDrpS
	2BhAD3iMSJY9nukgfaShrFuXYUMhzjZRSzoEglx0RNBGmI50G0oUoPAGf40gWKybK44yRG
	4KK5EQ7Wz+tlRN8ysUQ/9ndVDiADtOo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C712513460;
	Fri, 15 Mar 2024 16:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5mBtMANx9GVUXgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 15 Mar 2024 16:02:11 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH] net/sched: Add module alias for sch_fq_pie
Date: Fri, 15 Mar 2024 17:02:10 +0100
Message-ID: <20240315160210.8379-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.10
X-Spamd-Result: default: False [1.10 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.10)[65.70%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: *
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

The commit 2c15a5aee2f3 ("net/sched: Load modules via their alias")
starts loading modules via aliases and not canonical names. The new
aliases were added in commit 241a94abcf46 ("net/sched: Add module
aliases for cls_,sch_,act_ modules") via a Coccinele script.

sch_fq_pie.c is missing module.h header and thus Coccinele did not patch
it. Add the include and module alias manually, so that autoloading works
for sch_fq_pie too.

(Note: commit message in commit 241a94abcf46 ("net/sched: Add module
aliases for cls_,sch_,act_ modules") was mangled due to '#'
misinterpretation. The predicate haskernel is:

| @ haskernel @
| @@
|
| #include <linux/module.h>
|
)

Fixes: 241a94abcf46 ("net/sched: Add module aliases for cls_,sch_,act_ modules")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 net/sched/sch_fq_pie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 5b595773e59b..358cf304f4c9 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/jhash.h>
+#include <linux/module.h>
 #include <linux/sizes.h>
 #include <linux/vmalloc.h>
 #include <net/pkt_cls.h>
@@ -563,6 +564,7 @@ static struct Qdisc_ops fq_pie_qdisc_ops __read_mostly = {
 	.dump_stats	= fq_pie_dump_stats,
 	.owner		= THIS_MODULE,
 };
+MODULE_ALIAS_NET_SCH("fq_pie");
 
 static int __init fq_pie_module_init(void)
 {

base-commit: ea80e3ed09ab2c2b75724faf5484721753e92c31
-- 
2.44.0


