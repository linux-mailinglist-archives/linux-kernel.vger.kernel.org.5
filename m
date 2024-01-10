Return-Path: <linux-kernel+bounces-21644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899F382923D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA371F269C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C8815C0;
	Wed, 10 Jan 2024 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="izPl7wUE"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA841370
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704851290; bh=WADTRuNZWVYJEL3cfbTGZCRVmfJ/vhyQUOQ0+rj1YFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izPl7wUE2XkaiVjIYyxDSjwQjt8eWiLEc9n1LzAc3cKLpzru30x/gqRtCuZWtUw8f
	 wQIRGA+a9PC55Y2Xu9MgXhlnjrDEUO8Yw/HfHLTosQrOY8fkCdfxp5+9vweJvpJUb3
	 lwVRibmSt26xRhvH+1r9juuKDtOCwa//D6ietBYk=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id C08334DB; Wed, 10 Jan 2024 09:48:08 +0800
X-QQ-mid: xmsmtpt1704851288t3g396uij
Message-ID: <tencent_509697EE36004A2A752176B767163CE13709@qq.com>
X-QQ-XMAILINFO: NKv2G1wnhDBnqRB1Nzj+yffX5ESIn+rw2d7uk2JfMG3PIbcIAX0toHChd9IwS8
	 xkSH5Q4yF3A5KuVdBNcLMKkyY1AEZr2FMqZ8vWuYbA2XLzouWJOX3oA6MWBoj70EwMx5dWIgbD7P
	 dEhoKukl2Q9/0TpNSZsbbM/bMt0+VTfhyFM+0nk3LoxXVH1wfRbpvQ6qL/i4Wt5xlZ7i0vtTy0bg
	 PrL2ejH+IzHuN0ws2vAAiQiRGy50pttDZKXiWlGbtZgu9kqUhfZr47DwZ3ygTLbOQYBKsAaJnQbu
	 Ee1HDh79MIMT50Kg+1iS1m/E21btY82Eg0SbMlAOcdfYUtdgQIh7w3O5co8mtyh1PeBVLO5Ms7Mx
	 hAb8GbwDe3x8yJO0DmVG9FBcPmH3pEyrim15XBkDM7+5FxDnOtyZWuxWAVyUGfAZSyqeTEC/C4kW
	 vPkH1NSfgduYMtT96VbstV2rZy04zEs8JafPqcOQUOjrtTflftfgsgcbUrRe3o1NgW5Syj7x0Wat
	 FqcMG4849Ach2XNzivTs3CHZk6XjLNPY3ko+ZiJI/dymfAxdf0jGLViwQ1KDuGTE8Ro+GMMELGmy
	 +425uXD5ZK403GkNF0AMedLtDuc6zajmDJV0GHKdRwsFlLggrZSQSY+WPiErHbEC3YHa/uqiJfDl
	 GdHLHlfpgimOitxZ38w0yi9rSQ+htAIFzdpoOrzIdMQLj8bOcYJfrTcK0XMauasDCtg8Lj4Mqxxn
	 n4IgMN8E6Ua8xRgWUYyTJ1ORBIqLPIL1ojP2i70/LgWdo2jXv2Wj1m5HYFrTfhcpBgAHZXDLcmKN
	 7/EPXGxddJAcbJgAWAGc2tDRKB+RsoctZCu9c5IzWeyVqQ9NDn8HLo0HQmu+yL/99yImNgT6IHU1
	 SYbv5kVlfw6TRDGXEYuSQSFDSYuXPib67vwRdJE4BQxoC4wSowfpQ=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_lookup
Date: Wed, 10 Jan 2024 09:48:08 +0800
X-OQ-MSGID: <20240110014808.1250721-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000212ec9060e8754e2@google.com>
References: <000000000000212ec9060e8754e2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in hfsplus_lookup

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 861deac3b092

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 1986b4f18a90..a95a6a2246a3 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -73,6 +73,7 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	HFSPLUS_I(inode)->flags = 0;
 	HFSPLUS_I(inode)->extent_state = 0;
 	HFSPLUS_I(inode)->rsrc_inode = NULL;
+	HFSPLUS_I(inode)->create_date = 0;
 	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID ||


