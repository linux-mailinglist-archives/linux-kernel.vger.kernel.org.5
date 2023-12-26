Return-Path: <linux-kernel+bounces-11192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2548981E306
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E7828258D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAD2626;
	Tue, 26 Dec 2023 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cFh6lGmf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6CE366
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 00:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703549868; bh=gCHC1u+UirgvogljmF47d1Z8vbG+ztWSGQix0ZYoz/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cFh6lGmf3/37ztqu2TaRZISTfXQWxAB6kbvhX3IaflzTc8O46rV5a2Xoa3kb8idUN
	 NmMBJtVVUQQ/2//FWjpWqZmToIDRNnR/KX10QEBOGIePILb+MqB2mmtJja1c9TjgL+
	 tyop7O+WyFXFohKIf6Ckt1yaC4YBFVLg7ai9Acig=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 2EDAB686; Tue, 26 Dec 2023 08:11:45 +0800
X-QQ-mid: xmsmtpt1703549505tqsah00gg
Message-ID: <tencent_58740777F766DE3C91376296D4363A4A8A09@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNojI959x8ksgEG42gFiczVC2OswizoVWSG0/jECPHWPg/xBuEIjl
	 GrcSdLkBcZCToWx7TpjGCl57wIjDfBmjs2snBLclmH1l4naRx3YX71df2t6u8SP2h1KuAlFy1M8J
	 A6wzCPvDe+DsdB1jA09zk3sTZRdP3R/eTY4sjJS5XfOSJmnsYHkx+CjI6Ht0wcCZgxJtNXI3ze5q
	 MHdO+MX6/DdvC0ZV2UAjjBlE80kQOhCn3tkliSyUevubg1B1eL3sSuj327fGO72UDpQ34h+gDhyt
	 LSIcNSVA8uNP+8BmzlMzeH5xYmbg9ZLkn8xSTvhTrZlVV15Ab2M+A6WJGMFZZhlaep/tNXl87MTy
	 0WpHBo3hWBPBGxNN2u/O+l4qjMArDjc3OeZKSBoiNKh1C0LZZsoe4P2QCsdM0YTRo/Ewm+K1jsXt
	 za6pxIRiDGhMG+ae5YuZpM/fL0Gwv0boZ54wzkU2onOY55Q9TuQv4wumXwieC2HEk25jSvn1pxCc
	 ayn5SURWgnJ7XsNSXzSD0+D8shl4Q2McNqJCCwzwKK/22JRx4+0dCCNU6LJTvZLDtfvNyIMfPJIx
	 vAZj3RPM8bHOqna0zoaXLRP/5jycDgDM1eEZK5+Q65vvtMzv/iAPfWYkpAV+g+oPMUx1hhv3zjlN
	 +wSu2ZWpNnZwFXk1BLLWU5EVceUZbQ1Ex7CSSy8kifOTzhZsUfyv3aCkk7+OVAG5HuQZwzpZBft1
	 gtwdtj7ADBXZkTaIOnCwcBWeMLNF0kdrxo85+yxOvsE6/+Kuw9Nvz8cvbBp27myqo+IL/8wOeTXZ
	 1OsRGSNcvnVcSK/A2LskMUgVmHU8PIsH21vAjfMY5T0DAn3DMnGrvJTfxZTcdJ9VWQsUNK6Bss72
	 yJlnWmvfRVYZG1JB35MvPVvTFYi97J1NVZr7MSoOgJHFc4U49No4yl+Ux8CDkvSg==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b3b14fb9f8a14c5d0267@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] KASAN: slab-out-of-bounds Read in search_by_key (2)
Date: Tue, 26 Dec 2023 08:11:46 +0800
X-OQ-MSGID: <20231226001145.871933-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000434c71060d5b6808@google.com>
References: <000000000000434c71060d5b6808@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test slab-out-of-bounds Read in search_by_key

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 861deac3b092

diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 2138ee7d271d..5faf702f8d15 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -1407,7 +1407,7 @@ void reiserfs_delete_solid_item(struct reiserfs_transaction_handle *th,
 	INITIALIZE_PATH(path);
 	int item_len = 0;
 	int tb_init = 0;
-	struct cpu_key cpu_key;
+	struct cpu_key cpu_key = {};
 	int retval;
 	int quota_cut_bytes = 0;
 


