Return-Path: <linux-kernel+bounces-26604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FA282E40B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F303E1C223E1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A830A1B80D;
	Mon, 15 Jan 2024 23:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="u5ejN0U8"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A280E1B7FE
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705361895; bh=cz6IinuqhcZZWy7+5NFz+ILkSqS4auojx7jE1pMxmhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u5ejN0U8GLmwakf7b9WsHNnugxNTqBITNK2FyV5WGVox/Fk79QgG7LZdgJvpvgpQr
	 pLoSCv+wTpQ6THQyqEYNiAZhOGdAgsHeFOn1tkgLYs4tFfF7O3EXDVy3jIvX22kI5R
	 /x4zIFuHakYKHEp2uaCKvEyngiBFYoDcZ4dgX6nc=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 8090DECD; Tue, 16 Jan 2024 07:32:09 +0800
X-QQ-mid: xmsmtpt1705361529tio0y97up
Message-ID: <tencent_BDD63DCB3762971636DA4B4474F177116609@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69+OV4WSENK3vpXadt+cQi1jkRzHoxn7eCx7k+C+Z9y/J0bfNC00
	 HeZXzJWnDLYi2TNbzLUENqQCv81K2tpaon7D9BUiAFqtFWmUfpYI12Nt6D5y60jAtU77yCm68Nkd
	 vRYNqMWtIpfptD7JQVuVksuQ9M3x79LeC2Efj3OP/matWrcdbLBv5UFQg5bHhmNqbKcEnbI7lf0I
	 C7PJECx5Gs8KvstfaD6b0fkF0EyLKfkK552Eb8iiCAKSF17xoARQIxrMawdGjA/c54QqrPqd50aL
	 edIrHCcqT34eHQfmSp4ZvlmWyWnHw9M+NFNb8zc8M9u0XgfNeTTryHlk0yl7W48gO1I4pNV0UZ9S
	 169m5mowanaAreXYmS2D9xM+ZLnST6DM3FPqMq46ua6DDBIAgEwgADS1RoGKLkaClwsHZdkGYpqt
	 JEJb0pdg4AX54SUD+U6NeCoPdwjTaqBOKZsFzfOZbDoMB6HPYHL4z2jxoy9vMrIxH67NXFZFYbLd
	 cKk5y/iGPorvRy+7eVuL9VY96dt22hTUwO5Ww98ECzxtihe1nxwkoOKTg2YtyolDgeyiy2Rpps1v
	 WSS3CR1ZfXr7TZ4jYuArJbHzLP6ota+X28cH7TJefYI2iRJDMzvVpVVsDq2f6N03ynCrfbi64mHB
	 kdUxxPYQpyo5iBikD9PoqP4ljYfuQVMqMG8V3To21uPCHyJ7APF6hW7EG++cSL1J+QBP7eBU+5OF
	 l2gJf55POkmCVuE84d5klCXSv4cyn/XmTfPbZPCtAKX0+1gMDFnqY26jTuyT9vzRl7Qv44DhEJhF
	 SddH7WblxeGJENUnwlh1qtG5KxgzlqongiL2FQJX9CIh5uSI5GQ7ttiqoNXte+BelRP44jSnclOG
	 6xXOITsE5Eyd55Rpbv2iitTFGtFgdsWwl3aWdIguxKbCXo1BPo+U4TKsQumnZVxIv35PVYzytS
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 16 Jan 2024 07:32:10 +0800
X-OQ-MSGID: <20240115233209.4164697-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
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
index 1502d664c892..58ffaede8d16 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -741,6 +741,8 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
 	    args->start.tgtdev_name[0] == '\0')
 		return -EINVAL;
+	args->start.srcdev_name[BTRFS_PATH_NAME_MAX] = 0;
+	args->start.tgtdev_name[BTRFS_PATH_NAME_MAX] = 0;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
 					args->start.srcdevid,


