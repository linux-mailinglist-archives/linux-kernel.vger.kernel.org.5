Return-Path: <linux-kernel+bounces-4632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10651818020
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 04:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92991F241F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491105244;
	Tue, 19 Dec 2023 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SyrxeQUz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BBF4C8A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702955164; bh=FRXwkWkihVo0Oste5YovHtdk7dR7mbNKcJUBOtXQhS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SyrxeQUzF/c2Cpr2IgdcuD+Dj+eJe2xLcW+OFXsPX/fvDNdBnD4g/0e/c6vdfFBro
	 mGCYxMvWKJDocnXtSyQlJk+DAakP1mHkAI+k/CIzEUZpKY6UMh5DxEydhSp7hPLLO/
	 AfutBPo1vmwwPgqUoLA5EJ7KNtVNZWLeGJ8wKr3s=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 1830EAEC; Tue, 19 Dec 2023 11:06:03 +0800
X-QQ-mid: xmsmtpt1702955163tec37c9cz
Message-ID: <tencent_806DC02C6D6C049594E9A2ECAACE187B920A@qq.com>
X-QQ-XMAILINFO: OP01qWhGSBjQgNZFkhrEHnGb3scWg/HSF9Yn8eQHMPAfgRVffTlCR9Nn+Z99Or
	 N/n1/F2+YzzYI2DDfyHALNiEcvbnsn31cD0tL0+r0v0OBRgzolkRGxRMx3X7FcUhUdavljpiXXQh
	 iwHrxWk01dEb+22zMLzXZaKdoDWIPptidrHCAePAya5/mOnctyO/XOI+7HeH23BcH9ITzExk1tB3
	 VVQZZL45LUFQomDjnCHGnxoTEcbVz4f4msDj73xCodlYCIKDHWbiyC/jlyVG0BkEo2TY1p0+kL9K
	 NvcpigLJbbTJOOf6Ncck0RGPPQk46J6xNj9qafo1EACZQvQRNibKJ1k9t+5/FqZ+MacZP5l4hrp+
	 NNsDopaq0mhG6t/lVOi8942DZUcLAPycTOulHaBePtsjotEznjZ3u71UcnQBLlBexzYVhQNK2aTt
	 5+DybwLDOwo8ve9DXWdD21wyYbg5KF7dLktHS5HjddRlFu7KSifjSdfKoXvIBZTTp/B9JOTK/x0X
	 NYYmSHvmzUiS4vKSOeN9l2xbY2BtY4oR5NcDn31JZ8ZSGr35G7pdVemvuXoztj0IjdvEp1HuN1/4
	 I11CtYRLWXXItejz7AjLpW5aAa7uiAVDQ3XjgGCDhfRuZ98XzqHWPrD4uA42mjvLkVWw6LvB5T4e
	 BPtfbOfyIslg1xh8zRWoEUT3ynsHSaHRW40nVnES72oWmwvQAYpidOjs3efKaXyjTygOPL5sFIu6
	 //2+R8X56RLRYENGoHtmPa0yxJszNDHD4en0zv2vF4aTzujogk690h5NJ4Ksi6YNyiBFiazYnO9f
	 IB8bYbWzZeoidcVTZGS/o0JLkLXiF67VWcC2whX53YSfIQvUk8VaVFVRkIY8KHD/EeydT5Wl5/kD
	 NG8aXy19nR+BgRhmHWsrO0mfU8aCJk2/LXSHCs1wCJz1nbBgnwJK+zeFLFroUj84dldakcgQRKjB
	 jC9nAyHiDGpcGbgn5NYt2NhBKQFxWvY5DENKOyVdUBLH7/Dma3BRaaCyYSfwPn
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 19 Dec 2023 11:06:03 +0800
X-OQ-MSGID: <20231219030602.1627674-2-eadavis@qq.com>
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
+	    args->start.tgtdev_name[0] == 0)
 		return -EINVAL;
 
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,


