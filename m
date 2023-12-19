Return-Path: <linux-kernel+bounces-4616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5550817FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850071F23F70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C05E749F;
	Tue, 19 Dec 2023 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AdBz5rUb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16806FB4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702954211; bh=fx4Vq1IRsoxvEZorGn+e25uwOhwhE3vurKzrsuuY8xE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AdBz5rUbq9xM0IhO7sJc5Po8qLSkPYx1sCtUwk3K3LPHeH+jjlGhhXW9QONPWqvE1
	 GSONWVgqi1pNG7HmIbWGfpJx9dewCB8odYa8GqHrUj909gZmvW0Kc4HVUDLIEkls7J
	 avR4quLD9OKzfAItEtabrqn4fSzmA7Nk+EJvmuNA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id B08AA66F; Tue, 19 Dec 2023 10:44:08 +0800
X-QQ-mid: xmsmtpt1702953848td32815ne
Message-ID: <tencent_6AF1DDEC19024FA58DF5A59C8D8D1263DD07@qq.com>
X-QQ-XMAILINFO: OQhZ3T0tjf0aO645nJ9CGVGCZ0peyCcOfUaHu+z1G2hkBfNYqSB4zFQ9uaT41o
	 B4s03/R4AYmnwsEKje1NuFoJJG8jhBb19IL7bRP0qWh/lNZ4M3Y8+zU4je5rrUig0SoUK0HkZNIX
	 L1fhIoaxrT5k8XUrneEZ8TAmwf/BWhOX71sguovwvk/ne2Aue5Xx6tDO9OT6rzB7gZXym7AY/vGy
	 KJjINiVyU5uZix2ztbfoA/qY7IaVmS85CWkfg71GJfcKPCSUd7YDJg3/Ll7vpYquEYXIue+4lihg
	 FSPC176NsC93z9uOrpJfw2KsClW8YA1R9XRofRz1c8QW0gU5yG7xBymZFaVJlFiMG73pQrdPMNRe
	 YDheZfGZVLJ8rHRwJ9J8J+gNMnDgiFHZEh+sVv4Wf8F9RJyFCxbIAJECEW8ilIBkBddZovbR8N0L
	 btC25yPyo2UFFRBbV/J6P23LJ51gVvDwHPMqCTNp9O2Ro7+RIwEmozNaBI55tQwl1K6DRxj4bJqw
	 k9Jxpz00BuLda1ZspE1PY0vxvTpPg5PoS8D0k8vj/MX4MmTV/b5yZMsGZgrkDFCZrvsyhkmqJzg9
	 xvYWCnvcPDGem5oUh5t9TGGj1At6t55I4Zq/oDDrE9WPeuJU+6/SGzf/8XZ00CEp4YyS3ir03MI5
	 rzKDbQbm8+UonNchLUz5A2dgjtriC6AirnyIPGyQ7rCE2mo2Ea3DIAaio8XwlHj05be/YdAas+O8
	 6RLOf2HqQxp029C1w/Kx7QteTTo8v0d4uEHA2mVboEpr2Smda3gjLC1KZUXbrbhTpx5p85Dx90zI
	 DsSKoTNkEOHUOLzKnttksWkiz1fDO1+Wi2WSeZfmQpaZsBQlJssw5b9ArPuPp5TG5jh0rgyjeOMB
	 GtJgVBPN/qanC+zyXMoQ3ItSqyddKjdWg9ZPaVEz2yDsL1jjCZuNw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 19 Dec 2023 10:44:09 +0800
X-OQ-MSGID: <20231219024408.1603815-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000d1a1d1060cc9c5e7@google.com>
References: <000000000000d1a1d1060cc9c5e7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test slab-out-of-bounds Read in getname_kernel

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3bd7d7488169

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f9544fda38e9..b7e8392d34dc 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -741,7 +741,8 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 	}
 
 	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
-	    args->start.tgtdev_name[0] == '\0')
+	    args->start.tgtdev_name[0] == '\0' ||
+	    args->start.tgtdev_name[0] == '')
 		return -EINVAL;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,


