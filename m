Return-Path: <linux-kernel+bounces-52432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0151849809
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D447F1C2228A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F38175AA;
	Mon,  5 Feb 2024 10:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YIsXeHju"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1171317586;
	Mon,  5 Feb 2024 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707130159; cv=none; b=Xa2Q14HtkXZJOiUjAqzo9VbMvsnZe1dk0wCq+QlXJIMrHJP0LdEi3/7nEgE28PWG4lVIyCAAZ5dht1gs4hi3zuRyqDdJLmFB2E+v7ULyztK+pZs7gawThKENQ8yIGYkXfvbeC50NLbwhHQkEabiKEUoEmuMGj7ME+2PlQ+h+iSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707130159; c=relaxed/simple;
	bh=govUFsIU8oUtrCbGqxjAUy8sqpOQeqhvoaRkgz6Ypo4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B8yQfsj27viKS9vtx5GB3C2nE3XY5w21lcSSOK0woYJ1j3/CtHiy4w2qiWPZ98GpLpnrO1OA/Vc/M2dGTJNmzCXAiYgbjTYBOFzlnjCaRzwLMImsZna1CBGQqsyGSmO7xZRUCHWrLsb6Y3h4RqHow5J5uSafa8NJaLYEHE2Hf3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YIsXeHju; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 30e95b26c41411ee9e680517dc993faa-20240205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=fUeRA0Jda+Lyqu/i6W8IEQOOKZJBQt/IPjmrmBJEcYo=;
	b=YIsXeHjux330gf2denmnvznBQxMRhpKW9FqauUIxZxwLTPkRK2sQjNP2yRp0h3P8fCnaA1cZrnyIS9U6UvuUJrrbDI9nu/5g1AKC2nPQqpwbiJr8F2xhw8+D3iNPbyHMLNqxhsuqjYDXU/fUNLwPPB1FE7kFbV5C3VtySqBLRL4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:2045a737-53c4-4def-862a-8da50850b13b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:a83988fe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 30e95b26c41411ee9e680517dc993faa-20240205
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <alice.chao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1851177890; Mon, 05 Feb 2024 18:49:09 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 5 Feb 2024 18:49:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 5 Feb 2024 18:49:07 +0800
From: <alice.chao@mediatek.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>, "James E.J. Bottomley"
	<jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <wsd_upstream@mediatek.com>, <stanley.chu@mediatek.com>,
	<peter.wang@mediatek.com>, <powen.kao@mediatek.com>,
	<naomi.chu@mediatek.com>, <cc.chou@mediatek.com>, <tun-yu.yu@mediatek.com>,
	<chun-hung.wu@mediatek.com>, <casper.li@mediatek.com>, Alice Chao
	<alice.chao@mediatek.com>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: [PATCH v1 1/1] ufs: core: fix shift issue in ufshcd_clear_cmd
Date: Mon, 5 Feb 2024 18:49:04 +0800
Message-ID: <20240205104905.24929-1-alice.chao@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.721700-8.000000
X-TMASE-MatchedRID: KISk8WdGcXBCI2iUrGleqpdc7I2df+ms2D9FbDg9BP42/UwdvFG5IpBn
	0Y6NyRFo+hJFNJdQq3OnwZyfnQYxDBLekAZjy1WtdXu122+iJtrXAvRa0tfJGvuoLVXE/uWaDbI
	Geo4FmxIppITnGCYXcdLS2IFgBJ3tVQ7O/4REy+v62mDKTRDEUkJfxXUWJFGS31GU/N5W5BB91D
	unZtIaFuLzNWBegCW2xl8lw85EaVQLbigRnpKlKTpcQTtiHDgWu7FQYXTUmCAUzE8GbcbxJmrYG
	6Z2cg1Fe4VlQFoik74zs1tzCvb5Hw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.721700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: CDD062A06CE60E35FB211DAD39DB59CF632CD39BD23F74EAC619151C171A39CD2000:8
X-MTK: N

From: Alice Chao <alice.chao@mediatek.com>

When task_tag > 32 (in mcq mode), 1U << task_tag will out of bound
for u32 mask. Fix this bug to prevent SHIFT_ISSUE (Bitwise shifts
that are out of bounds for their data type).

[name:debug_monitors&]Unexpected kernel BRK exception at EL1
[name:traps&]Internal error: BRK handler: 00000000f2005514 [#1] PREEMPT SMP
[name:mediatek_cpufreq_hw&]cpufreq stop DVFS log done
[name:mrdump&]Kernel Offset: 0x1ba5800000 from 0xffffffc008000000
[name:mrdump&]PHYS_OFFSET: 0x80000000
[name:mrdump&]pstate: 22400005 (nzCv daif +PAN -UAO)
[name:mrdump&]pc : [0xffffffdbaf52bb2c] ufshcd_clear_cmd+0x280/0x288
[name:mrdump&]lr : [0xffffffdbaf52a774] ufshcd_wait_for_dev_cmd+0x3e4/0x82c
[name:mrdump&]sp : ffffffc0081471b0
<snip>
Workqueue: ufs_eh_wq_0 ufshcd_err_handler
Call trace:
 dump_backtrace+0xf8/0x144
 show_stack+0x18/0x24
 dump_stack_lvl+0x78/0x9c
 dump_stack+0x18/0x44
 mrdump_common_die+0x254/0x480 [mrdump]
 ipanic_die+0x20/0x30 [mrdump]
 notify_die+0x15c/0x204
 die+0x10c/0x5f8
 arm64_notify_die+0x74/0x13c
 do_debug_exception+0x164/0x26c
 el1_dbg+0x64/0x80
 el1h_64_sync_handler+0x3c/0x90
 el1h_64_sync+0x68/0x6c
 ufshcd_clear_cmd+0x280/0x288
 ufshcd_wait_for_dev_cmd+0x3e4/0x82c
 ufshcd_exec_dev_cmd+0x5bc/0x9ac
 ufshcd_verify_dev_init+0x84/0x1c8
 ufshcd_probe_hba+0x724/0x1ce0
 ufshcd_host_reset_and_restore+0x260/0x574
 ufshcd_reset_and_restore+0x138/0xbd0
 ufshcd_err_handler+0x1218/0x2f28
 process_one_work+0x5fc/0x1140
 worker_thread+0x7d8/0xe20
 kthread+0x25c/0x468
 ret_from_fork+0x10/0x20

Signed-off-by: Alice Chao <alice.chao@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 029d017fc1b6..c6cff4aa440a 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3057,7 +3057,7 @@ bool ufshcd_cmd_inflight(struct scsi_cmnd *cmd)
  */
 static int ufshcd_clear_cmd(struct ufs_hba *hba, u32 task_tag)
 {
-	u32 mask = 1U << task_tag;
+	u32 mask;
 	unsigned long flags;
 	int err;
 
@@ -3075,6 +3075,8 @@ static int ufshcd_clear_cmd(struct ufs_hba *hba, u32 task_tag)
 		return 0;
 	}
 
+	mask = 1U << task_tag;
+
 	/* clear outstanding transaction before retry */
 	spin_lock_irqsave(hba->host->host_lock, flags);
 	ufshcd_utrl_clear(hba, mask);
-- 
2.18.0


