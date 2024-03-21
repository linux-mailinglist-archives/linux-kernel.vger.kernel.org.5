Return-Path: <linux-kernel+bounces-109865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A768856D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56F71C218AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E619B54F86;
	Thu, 21 Mar 2024 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tKGF7EGI"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10872C86A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014581; cv=none; b=d9AYfsoeBrF9H+5VIoxCnOh9/3/7MTvTQEIXckYm883vM3nbDLAcxGWa86wZGVjCl9hezNuO7abcgF6pJSqtippzVWCXiDJZc+elAmPXcY8xCwwnSDJeVtS7ujocwWHmdya6qoQs22IMe03YnNHjGEfDt/iX3InYYqu66MZjcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014581; c=relaxed/simple;
	bh=Bf4NuAPDhqMrn5J24FreL4tpQ7ONfil0t3MoZPMed5Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=csvHQWkP3PmVr+0WnVCnJWke+ESmjtSUbYPdZtrnbJfQ0mkrWaaJ+G5lP0Flv5AnEAHmrPX8OKg/Zg7UUjJFjZy1AlhAFlDrM5GrysQ/mLCkXlvVegJzG7yo2guSQmvGhwUR/QkhuATW2yloTfEn/Naz2AJKpEncn1Qk//LKhcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tKGF7EGI; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711014571; bh=HEeC4ByInjM1kRju0iAR0X6ZVteQxEDiMYLCDkSSO+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tKGF7EGIBrnE+lsLx9ko5dR/TwyjXnVJrI08MnXaK/0fBPSq5yt2tsJXfLL7wGUCW
	 cV6Wo3GkUhKgHz/OxygbDESEggUz49uKVksaMyt30sUNCtlW9bhaulvHT7IzSkyfyj
	 mK27581vJDjD4SzxyaiO7Tkq2OiJVbMhq9vMgLzI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id C0FB2457; Thu, 21 Mar 2024 17:48:15 +0800
X-QQ-mid: xmsmtpt1711014495t1570eglk
Message-ID: <tencent_E4CF8DA81272DDA55DD319044F9F8D88A507@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/VlmtfTzmjpg/xvw6jITExioCpsPAWTnxujqSYgHxHKRLAJCy4U
	 WFRzmLBUFzvn226XTy5FGRtojjsTfEWzkuLxrFi8IZumYMJdC7vY+X9jjyE8j3LsTpe+m8089rQ8
	 AIb/gjGifMiQyPc7SL80LDm5PDhixUoBb0ojL5CobDsGYQXydJ9wdWHHptZeFTCENnLoESUsLaPO
	 SaVoGmcrrlOTRrJY15KrhVRJL80mILX8MiPI+OaymAsurYKizO76VNU4i4G2bmgqwkwb6vfm7TFF
	 lDx+dyfN2raBQyFzJ/nvrXsi9sFu1E0vVs3YQyA1BxEHIRSowb1VCbFohryrlLNn5J2QbpgowCLU
	 mqlmspZD2tv1Ku3And9iVw5FJ+MGO+k1qHT+jFMHs9YCG1bMXeTxAjq2ep3jfK/hbm5p/bVw/0Vx
	 qLvA2eNeEnVHnm0UYxAYslESK/hi7SS00oB9OhCpZIFvTKVCjZqcepGzIPKpHTk3+FbNu3guku+d
	 qzdJQfUn+WFXDG2UDdG16QAEnJ2KitB61/FUNsDzRA8m7ynGlT7UDLLFJ3r1heX0PAxMd20x6Hjx
	 CH3loMVMBkdaDB8CISEm6yX2gyrOIZjYMUjvCRcJr9CzySsXbXsvlCuB3Dn3a7iaWxRdaVwzmUZd
	 fFUFKnuDndkiv5MCMHRhI1AMTlx9nwx5Rrz8BodRin7lcf9o5oCamIASWxdjNzYXa2ndoO9GtJwp
	 dvVBNjqElqMM+oH6yMTE2YY3Tn07OYvMDn6/l9Eygp+gvlPEFX4LGhg6IBXLRcvy2S2DXhB1MHmT
	 /DgwMtPyXzLmozeBRShDJBY/FZSbmqDgaM6mhHUnSRRuQprNVTs69LyLUPJA4gXHaQ4G6knhy3/K
	 qHpsrgRoGdx+zb374EuClGdgPfAr3UESx6e8OxuRYF0fT+u+xfyjFy7cP2rrPW48JoK8lh+rgx
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+65f53dd6a0f7ad64c0cb@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_find_1st_rec_by_cnid
Date: Thu, 21 Mar 2024 17:48:16 +0800
X-OQ-MSGID: <20240321094815.2359097-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008fd9bc061428179e@google.com>
References: <0000000000008fd9bc061428179e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in hfs_find_1st_rec_by_cnid

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


