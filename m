Return-Path: <linux-kernel+bounces-17928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548382553F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDC1E1F23C03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DA82DF98;
	Fri,  5 Jan 2024 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="S7zw8bNc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27AB2DF93
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704464587; bh=h0GBTsgWnL2yaff7yr+0eEDxJJsYYg9m6vev/+xv9mE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S7zw8bNc0uo8o+UqvuoNo33msGd1JYgIzfSf8o46MG4NaVViks/wKzK8ryUJl6NdN
	 w/Ooqf2hugS/0nMSiCgt0nmfC0zoawMLrHL6IAiPkrPJId3AiHTaEmT2LrYk92+2sq
	 eT8yjUOcWGMc/OZtGZHolqTPMkWaBhteBKX+pCRo=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 5C501A7D; Fri, 05 Jan 2024 22:23:05 +0800
X-QQ-mid: xmsmtpt1704464585t3cgvrdck
Message-ID: <tencent_E0365C961437B24AA074DD76D3674A3C5D09@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0ae1WvG5xAKJGEBXzgxrXsVI87cMnnoU3WO7ullLyv5eK8JGTKt0
	 3NigrNnUQntE7rIQQwneOb1/NF/s8CjR3WvC2eu0WaTGAmcDplDzH3J4aBPt9KYmQPEUOyfGlkzb
	 ebZCp164zTME3rMcAsiEkJAweBWn2/Ooc2PKYznyRr53GkMcspxAmO8a6RnHa2K0eIhklt88wADc
	 3c1Hplghr4p0oEGE6VkeREp273bytChGEYvBJ8BADf1AIKu74hduQM2dsnmhoMNshhgHyP93RFT4
	 NrOEFFd6xisen05ozcBo7OYytbTOFnkqAgM4AFGwLyXLtq2GdkCWWUlKIhCmehbKFEROsTbRCWB5
	 RgXeAlyCuDVmwHYWaK8qSBQ5zxtBcLF4FFSkb6mL826Elg0tM5R3c7FA6A54tbZw58Rq5RsVkk0m
	 DuMgFqEsLjhsoMN9Ki64z6gE93GFNmHmVYP/9u7NmpWvmh83OVS8LNqSMUSbhvKuEPuhbraRL1hQ
	 3TzDYDUT1Xv7nRw7aMX4ZUkWO91xoVxCnPpIyzlFuW3tAxpNVOMZXu/2T/k+3fXRyScU2dFG1SEB
	 /UHBGvj04nyJGuUraA4F6RXu0pvdjv2TdqkKapw0esQgqcAIubqxEdNh3es0pjm3kBJnlQJu3iJ7
	 bImSmbX1DHh2XRSKxEVKFYBVxYINCaCn+v7KnXvayx+plSJ4p3VICzNiUm+vokw+9eWLmcmG8VfO
	 0P89aLidmHQ6R01kEXjMfn35CV3X9cibOEYVhpmP7goFh0EAsgDaeSohpN1IVNg5I+U9s1MeCJW7
	 QNU5X1z+3O63mEjFzKmjIyrJMjItDVpDoXurZbzILkH0EBgkJX2/WfPr2y/VYRyA7xZJi0sATLNd
	 aqxYSK10pQPk53o1QnACCkcjR7Jj2u2FLvAm2lMtRLZtbd0yXl+N97Rexgn0I2bgiBYX9baLSUO4
	 ocCH0ZUNQRD+towZ5ZWA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_quota_write
Date: Fri,  5 Jan 2024 22:23:06 +0800
X-OQ-MSGID: <20240105142305.728654-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000c8a56a060de13553@google.com>
References: <000000000000c8a56a060de13553@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test task hung in ext4_quota_write

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f5837722ffec

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1f..cd9531db8472 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -7248,6 +7248,10 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 		brelse(bh);
 		return err;
 	}
+	if (test_bit(BH_Lock, &bh->b_state)) {
+		brelse(bh);
+		return -EIO;
+	}
 	lock_buffer(bh);
 	memcpy(bh->b_data+offset, data, len);
 	flush_dcache_page(bh->b_page);


