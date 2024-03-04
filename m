Return-Path: <linux-kernel+bounces-90045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D97E286F945
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A01B20E61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 04:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE02611A;
	Mon,  4 Mar 2024 04:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OZTa6+13"
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3427617F3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709527233; cv=none; b=knXdcFZoDPB1gru5dqVkaFIHuVQmCfsPy9uaYJ0D6l7h5jbJInLdScFsg6D4NVUQOfBXqcKNt0sPJ00NMc6O2xNRPpcGD3zwNIJkcE7qaxvcALjTyaJ9aVt3aKCkQGbkPmMRo+iyhQCThw/szCldSmEUPhPO7u984jmNQt2UhJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709527233; c=relaxed/simple;
	bh=GmMaxfZEvoUCYCOOEEkF1Am4MdrTzhShRnC/EZ+PjCE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ZjpgkozR3FiDNmzNM8OPC4BzYRfN5g+YakF5VIMVZ2oaMftSwLXH5IvYIFh4yj8Xq2pZS/pjPVg0K7tbom1BMdkTJQODxCOPgBPXPhGn/NzejVs2iCxLS4mk7xCfI54wlbvCSKmbykAHqS2BX+v77GXV+n78SP6HJd5C+wCkHGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OZTa6+13; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709527228; bh=d/GdG5LWwBWASubgy2s8rEV8kaC/E/Cf568gBstjKkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OZTa6+13E0/s8oXQk9fNV2hG48PSp5CdrmsAdftCczBP98jFSBz242HsfFYq088Xu
	 t748aGG4NPip0nLOPX9kUlPjg/KbDgw1hU5hjAtvBuNxKpaIEXWKzlhBFNaUchCSx1
	 g7GWMwgoNmywSNGILUyD1DcXkxWJhTmvBmvV/XhI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id A1B2F412; Mon, 04 Mar 2024 12:40:27 +0800
X-QQ-mid: xmsmtpt1709527227t7kih9b7n
Message-ID: <tencent_806C802F5D6EE895B4E862EFC6CC947B720A@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69s5jRSlK+Up6TP6WvhUzBE311OsRfcl61NjxsOIaKPPWrr6QgZY
	 PiVdNAt0GTloEWTQgb6oa0aqEZrzl7jgKLzWWb6Z3BTGy6KIKAvrNUyCN19nwMy75cekxiRlG37t
	 k9b2cCCvyZ9AJo55J8mTjB8kPebQorKEwfEVVrnjNoaIfbRDnhwz4PK0vmmN1zIUurMPXbDdz1AI
	 hrgUKvy0hlKaihydFwHgHmeP0ttp6PD3HPX/mR1DQEWZGPx1+8U3g3nntxhiVRscwGRjh4DIzR2c
	 kIrYxtjshYJgQAf9GSxDKVLMB0X7K7e+t67sf14MRaxH19KCRXPNtwE6Hn90V1T+8RYG/MABLrEm
	 TWuAf1W4flU03IgIlDmIEYhkaqBL4iaUrOtRegMV9SAuMA/NV2q5C04Ipnz8g5KANCJAa8hNswAM
	 4Ph/xT46p5pg387BEz1y3U0+JZw743/DHbzjvfM5sqIATzDc2eVbPpxf6pbbBZRlGC9PrHl/8Mof
	 YKEQWcFhsp8WArPH1S6k6v7HtQRjqRfuf0V9TbxewEnQa2PEUXokovpVDm15J8JnAfbju85H1Vnc
	 S2nR437705IxcSXEQyzzkKylPo673N8wmdNHmss70Cd71wmjPIOhcIj9Vrxo+wuzxaio7fuz0CpD
	 DHB6gRcTyqjsbpgzSBOBQlIPjt4a41bX2jigYvYGIjanbUQkaoQBkW6Q9tFAlSvvm0azNsG/dYKm
	 YHbVh5aQvUoYsEvKhqYxWysVHStAXzTFVrJjM055yzXcjd3kUCHX0EoyzQ/BDW4WX+1cbTqIYvxB
	 zCBo2zqp1CIdwOOXjaJFohciJ44/WMhZQuhRlPe2/LgAsw6WZcfRaP8kWrfwhy5+b8qrokPmYmyf
	 URiitePw90lizXiNwTVctnB0PoH2c3NFsZ6PL0OKMdTFkvCONyxmI=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c6d8e1bffb0970780d5c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_attr_bin_cmp_key
Date: Mon,  4 Mar 2024 12:40:27 +0800
X-OQ-MSGID: <20240304044026.1188951-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000037444e0612c39434@google.com>
References: <00000000000037444e0612c39434@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in hfsplus_attr_bin_cmp_key

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82e..b939dc879dac 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,7 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;


