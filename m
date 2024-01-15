Return-Path: <linux-kernel+bounces-26609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED4982E423
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7967C283001
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF161B7F0;
	Mon, 15 Jan 2024 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="raE6CprY"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582EB1B7E2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705363130; bh=Jb5O5MGflDvcfNpuHjcT/KRKcHZFWEHaF82bFDCdDv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=raE6CprYuUxJ4VIpfSw4/181rOJeAM6Ph0hNKtB4IEjDYFBMO+gAoJ8ya8W24L1vZ
	 JqpIx61zxw8z3E5bNR5zKkQkAMXr2u4n1B/YVntxjs1kHdXmSbSlPBvgvEPt1Pdytr
	 R9wj9+9s0L2SXbBF3Luru69+rUuT0xeb0mXKKPzI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id EAE816B1; Tue, 16 Jan 2024 07:58:46 +0800
X-QQ-mid: xmsmtpt1705363126tvwdgz4i9
Message-ID: <tencent_6C6006C093630366C97083A2C44897777705@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjvwR1Hog5YpqyMwOCXzzfnsG9Rl6NX6g67J+7lG2za6gFQtCsLC
	 MTNRNzQqhlfJLt6wrkiw83QMoU+gpXEykf3LipgCpi9/fllztdXgEmRve/xHTb0kdJMGfpbMii3Y
	 BOFic0Jygqu/BdJEeU2qH0NFqFD9Yfykp+auV0kCuq3EKBT6oAd3WEbJ+dJsMyF85QthXoXg5s8s
	 b1XtRG0UtTwkY7EQnA6oZUQlDCnVmp/YNmC8+JFQ94i78X6HQXyppr443No5pK0BRTBvaq+JuZqJ
	 7OuX+ohvD33hQB82VKQfmp/MNovi8zqY8jmy4xvBmcU534jwV9Am3oTvAo+EOKAIA/Wdxo+3llpv
	 77GvJUxC8A9b+tG6c1EjxSzEc8QKV5YHzXaHp7GVgDGAWSM8iwDgroq9VMqQxO8cf5tYG1eqiVCM
	 iuQKL+dvf0Hr4Je/MqHTeth7pilf02Lo+rmnL3YkQfYD1Otrw+n1G1Spb15f8dIZTRCYra9ebnS1
	 F41HhtuO4MVpFmFQsKYEJ6L/3GsD56epkYg1vlQfRL1CxvMxv8IfDPS/E8pOG2oRM+en/+li7j6M
	 j7tJoq08DPOTd6bS74uDDCxcI1S5W7807FsHlsM1SdsoDbGVW+1q6bsMzReOPBstfFp+NrhzA4ih
	 0+VLhOVbEWteRHQDIws/crmoY17Hwb7S8v5xRchEMIJ86+8v2Qi8mABzktAuUfn/MPa6BkZk49cl
	 XB7myc31LCBRkiTrjk7nCUcq6B0U4kkFT+a1+nfN51oN7O1jrZ253eUz1nkU0fOjTtbt3MxS1z1O
	 jxfZi4qdkYRRvPzQP5IIcyRGnjet/CIycN0vyw37tixP7ZQAeRhhBbP4yJlypj+CteW3T1DxaPWW
	 cHm4PoY/9qsWwbyUjspT0zOhfeaN9AVvRMXfB00spgdB7pNFXyFsonWBMyIgH+4uvnz8E0a8Olq0
	 y7Y01tiboOhroExEkJFGAkurcde+KmwBbTjmomJK0=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 16 Jan 2024 07:58:47 +0800
X-OQ-MSGID: <20240115235846.4186025-2-eadavis@qq.com>
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
index 1502d664c892..7a1d3c7a895b 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -741,6 +741,7 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 	if ((args->start.srcdevid == 0 && args->start.srcdev_name[0] == '\0') ||
 	    args->start.tgtdev_name[0] == '\0')
 		return -EINVAL;
+	args->start.tgtdev_name[BTRFS_PATH_NAME_MAX] = '\0';
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
 					args->start.srcdevid,


