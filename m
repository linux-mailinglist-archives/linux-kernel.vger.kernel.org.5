Return-Path: <linux-kernel+bounces-154973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ED68AE3C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C9C2844E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0967E573;
	Tue, 23 Apr 2024 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="MpmH7SB5"
Received: from out0-210.mail.aliyun.com (out0-210.mail.aliyun.com [140.205.0.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54B7C6DF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871520; cv=none; b=XV00/SdU2ehdG7DamdOYT352de4hHAU5rYJGwPLDzgq7UTI/41AsWeGVIe/FDAFUzZ/s793BusE9c5mPv2mPHduvb0k88edLJDDl1oNBhQx+Q8ClBXdJvAnsLShrhjQmHc1cmXK2C+VyljfzcLU0J+4+751SojfdTWqh4M4WdVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871520; c=relaxed/simple;
	bh=VUK1qW4vcuTcnbfvkh2ig+AROuk8bCOr9JBsTl9lZiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAYY0oYYjURRjz09tu0OJsEnTMsWEAusOZu/PDyCFgj9y8XNiZ9NhR9EDAusbdaW7LBuwILkm+/18t7K+QWbrl4alVpAd03Hs+zRXPgoOYAGrHWO6yXPDFDLrjis1TAldLYR8WzysBhQdjCwTpngJTVHDFtXVIm5c/Z0KNBd6UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=MpmH7SB5; arc=none smtp.client-ip=140.205.0.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1713871514; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=lumfKnRDCzxzbmj8wJ/Hznk5zzPAE/pxByFtYHy06AQ=;
	b=MpmH7SB5+6BXEFfaDQ9mgGy6Dp764bxncYmjedGK55dqCZbDF676g0a+vZN7yo0K/xwB+YBXfiq8N5D0nPZJV/pkoBoeJAMrar6zpze5W4oPNFWPurKkP9a/mnsTmgYm+ManzYymshzvs6/h7Opt5cAx9/HEWIHLCYgi2+TlY3s=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047203;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.XJTUYiJ_1713871513;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XJTUYiJ_1713871513)
          by smtp.aliyun-inc.com;
          Tue, 23 Apr 2024 19:25:14 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 7/7] um: Remove unused do_get_thread_area function
Date: Tue, 23 Apr 2024 19:24:57 +0800
Message-Id: <20240423112457.2409319-8-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
References: <20240423112457.2409319-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

It's not used since it was introduced by commit aa6758d4867c ("[PATCH]
uml: implement {get,set}_thread_area for i386"). Now, it's causing a
-Wmissing-prototypes warning:

arch/x86/um/tls_32.c:39:5: warning: no previous prototype for ‘do_get_thread_area’ [-Wmissing-prototypes]
   39 | int do_get_thread_area(struct user_desc *info)
      |     ^~~~~~~~~~~~~~~~~~

The original author also had doubts about whether it should be used.
Considering that 18 years have passed, let's just remove it.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/x86/um/tls_32.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
index ba40b1b8e179..d301deee041f 100644
--- a/arch/x86/um/tls_32.c
+++ b/arch/x86/um/tls_32.c
@@ -36,22 +36,6 @@ static int do_set_thread_area(struct user_desc *info)
 	return ret;
 }
 
-int do_get_thread_area(struct user_desc *info)
-{
-	int ret;
-	u32 cpu;
-
-	cpu = get_cpu();
-	ret = os_get_thread_area(info, userspace_pid[cpu]);
-	put_cpu();
-
-	if (ret)
-		printk(KERN_ERR "PTRACE_GET_THREAD_AREA failed, err = %d, "
-		       "index = %d\n", ret, info->entry_number);
-
-	return ret;
-}
-
 /*
  * sys_get_thread_area: get a yet unused TLS descriptor index.
  * XXX: Consider leaving one free slot for glibc usage at first place. This must
@@ -231,7 +215,6 @@ int arch_set_tls(struct task_struct *new, unsigned long tls)
 	return ret;
 }
 
-/* XXX: use do_get_thread_area to read the host value? I'm not at all sure! */
 static int get_tls_entry(struct task_struct *task, struct user_desc *info,
 			 int idx)
 {
-- 
2.34.1


