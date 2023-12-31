Return-Path: <linux-kernel+bounces-13621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82258820984
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 03:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB581F223EE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 02:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D082A5E;
	Sun, 31 Dec 2023 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ocn4QGSV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD35A31
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703988233; bh=Ryc9uLSqaO40+myVoBFuW8CGQQrQvdECZvskSiR1baQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ocn4QGSV9jP0VqCIAjBkjorapSO7rVxneJx9tjwM5xKYtOm0fm5FmL4ioqcLunBta
	 JSqVtFuEWrEnvdF1merjw9oYZWCUJJS4NnvbPHyH+NIi5+mIFZsuMc4s7beTl+Za2V
	 elxLj7eGYISQdjNEi8+aDfW55G+OidEcCXSk23WY=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id CDA1E62B; Sun, 31 Dec 2023 09:51:26 +0800
X-QQ-mid: xmsmtpt1703987486t6uhk2p86
Message-ID: <tencent_72978236184B82740F7673674C3CC3360409@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT6SfvEicVD2L+8tzhP/HGQEhHLsuMhQ7vHgGYACKrvHdw4poR2j
	 GVtN5IwZttsE2VqJiwlrylMS8YqqRHhfFqK+QKOq15SAU0VeaPFcB9u6YpfTvVu1Po9MutP0eUGT
	 aGx4T1N5RcGzfN2A85H5YgxQXDII6IGu4O5heaxVDMm9PDV94o+e+eRaX3tJeLC44mld7yoP/UtM
	 3OpIQovoC+gGx+EnKV7oZ71pCCArETJsMNowa+YjM1o2Etk4qYix/U6qczVnYj8MZkIIN4ZsvDiU
	 Ksa5HbYvHY1jKfLmWPBfK1gvFwI7aHideRRu9Dd/NvrhJPFL+unYok3pHpE3t73QpP76cpVLTAPL
	 WdpKSg+4aJfIAZYIwocI7EzEd5LcuBjipm/Mt7Mep1PDrP+ojr6cGKjVyGq6Qt9615SmGsw+/0QM
	 SSeYx0WLZPLW0aBql2l8hIpQWSupHQODs7Jn1F0R6BHfwJjHa6mfwk70o9PqVRr/BIz02N4Smfnc
	 YG6fX9vIDrmyeMQMdCD0qibAhMYl4GsQhJa76Jgf1eIpr6sfQwtS1PfCoL16s9xxciJYxOc6vckO
	 8pF8VTdeyaHdCplHv60IS5aJUayi61Wi1F3C9uwCU3Lpt+baK6X/GFCBoj0QToWf/K2etZo4dSpm
	 snnyy4/tvbf2idp5RmYxcTPoiku7KsWlsbtc40DpcEk4P37kMTqFXluu9DNgJ1C1JAi8DSz78iqq
	 9wrWeMCSghTugdPQCR7itlMxP6b/A0GPq1TfomOK0cXbdeTWxcdw+2MEuDM1Uksj9egIPeEvMJkY
	 7JFX4tnXGIRRiZX044XZiL1pWwqPyweaQ7R+b4IL53vQ1bPYKrcUtsxxBgUEG3WGHVai21h3z9aZ
	 O6a42ilb4BQilDs2AVPIOA69IQXjz42/2LafmzMlVO9PXhWAfB8+PXqUGSA+fwEdWptA0vcaPTLZ
	 iEydk4KVcDxd9wsWG0nw==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+cfc08744435c4cf94a40@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KMSAN: kernel-infoleak-after-free in copy_siginfo_to_user (2)
Date: Sun, 31 Dec 2023 09:51:27 +0800
X-OQ-MSGID: <20231231015126.3106053-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000a9d761060d5ce6cf@google.com>
References: <000000000000a9d761060d5ce6cf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test kernel-infoleak-after-free in copy_siginfo_to_user

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 861deac3b092

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index d8b5e13a2229..8bd346b10c6e 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1033,7 +1033,7 @@ int ptrace_request(struct task_struct *child, long request,
 {
 	bool seized = child->ptrace & PT_SEIZED;
 	int ret = -EIO;
-	kernel_siginfo_t siginfo, *si;
+	kernel_siginfo_t siginfo, *si, *psiginfo;
 	void __user *datavp = (void __user *) data;
 	unsigned long __user *datalp = datavp;
 	unsigned long flags;
@@ -1061,9 +1061,13 @@ int ptrace_request(struct task_struct *child, long request,
 		break;
 
 	case PTRACE_GETSIGINFO:
-		ret = ptrace_getsiginfo(child, &siginfo);
+		psiginfo = kvmalloc(sizeof(kernel_siginfo_t), GFP_KERNEL);
+		if (!psiginfo)
+			break;
+		ret = ptrace_getsiginfo(child, psiginfo);
 		if (!ret)
-			ret = copy_siginfo_to_user(datavp, &siginfo);
+			ret = copy_siginfo_to_user(datavp, psiginfo);
+		kvfree(psiginfo);
 		break;
 
 	case PTRACE_SETSIGINFO:


