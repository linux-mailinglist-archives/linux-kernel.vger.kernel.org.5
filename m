Return-Path: <linux-kernel+bounces-26808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D882E664
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F060728538A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01ACB749D;
	Tue, 16 Jan 2024 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rqemMBSp"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0720779C0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 00:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705365989; bh=AaWRhfFRqMRx8OraIcHJJr5JSRNlzcYHNh8VVa2Pf4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rqemMBSpE8A8BDhyCiAm+cpo2No+kJ68Ja1FazuJVNM4PC+xU8niAIOfMD9RDwsI4
	 GZQqOj6fRHmALmyKqFlbnqILTkzI+45oIzOZUPTJ1Q/cRAQmF3uefhSWm8/16GMHMM
	 cjkunhJ0WtBZfGlKh9kbUJbffVJ8WSlG3zsbTZcM=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id B9B390FD; Tue, 16 Jan 2024 08:46:27 +0800
X-QQ-mid: xmsmtpt1705365987t46ebr0jl
Message-ID: <tencent_6543A4C44A9773F777A6CCB372437DE97905@qq.com>
X-QQ-XMAILINFO: N26DAMVpW7UEELg1dy+GMZBv7LJgSjgJQ/S2AF4DiZ/3aw6QNPj3K5zURTibns
	 QiZGucUVkN6bwHXpDT7RV13BTgDCG/6gB6n1IOKxuiFQQzbLPipNRnfNejGMgzJqDPJMtnc9RMe7
	 IO7Ggm/9NYSCPf0AJb/XuibU5L2rQum8AW/0Z7pAoFrcpm9X7/W46/oVhD4JD21chhF4CK18qhKJ
	 boIaOcNMYv+f6rJ0Knz67UCLLUw8pNVxm7TCd58fddk+gB2bNSzMhZAGfojn2669kk279WCaPAvy
	 +T2Mt+pEhvMfSvkN9ZklrIhz8GasYDEJCyUwV/mvbHoH1mSNG3nRpkSdUHhyS6pc4LsNlPht7FtP
	 oOOaSaXXUmCvlOXJc3yrFYFldSzBAm3rD9Wn2+i2PRdmADrYqpMmOU2FL8opym0r2oXqa7iTSuzO
	 3bQd80iUq39GtaBkvlKgfpD3udp1KfdXewNi/vjSgEjVLeQJ+vl6nIBS2BcvTQ1EdLZUB75ZYOoh
	 MbN8Z02uWB8ceQea/Cs5g8tfyiDFCOQ9pp5vWD2tf/ZJ1u9MWGHBEMv7DEcbn1ml0f8u7eRwZ8Di
	 wiknBkZxPl3yqs780+xhbzt+oZDks08xf7VcTN94Qmlm37VoV1xDq0nieGDleB2Yn9nVN4APV2BW
	 TvnGRSenmxdl2JyBbuoIpNU5ZWOIx4C0eCwSvjD07tkV5GViJ/boqO4FcYRd2Kgwwr7Hik5tYECD
	 HUXy49ETrpCPR30+NsSBymK8dg+EoceXtKXupHwBgPALAx39t4/ju1/AINSYF0s8AQNRH8z3Qt2/
	 WvUyggNUgSQrteHqoimSHeUrnzYgKUmohYYBVAgEY+QwIhGen+UbOUw3M7c02ax9lT2C5pasFTMr
	 y380tiLKRexueQQSS8d3IB31MATucCmSashmdT27oVBCupCFKoRU6onH9xtQvST+9p1+poYuKInx
	 zn7c7m2Dw8KhuKS6fGAmUzoKJ1vIujgMcsY4Y78d/YF4JPOoZyHiONifjDxkZG
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+33f23b49ac24f986c9e8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KASAN: slab-out-of-bounds Read in getname_kernel (2)
Date: Tue, 16 Jan 2024 08:46:28 +0800
X-OQ-MSGID: <20240116004627.35201-2-eadavis@qq.com>
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
index 1502d664c892..fe6172707151 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -742,6 +742,7 @@ int btrfs_dev_replace_by_ioctl(struct btrfs_fs_info *fs_info,
 	    args->start.tgtdev_name[0] == '\0')
 		return -EINVAL;
 
+	args->start.tgtdev_name[BTRFS_DEVICE_PATH_NAME_MAX] = '\0';
 	ret = btrfs_dev_replace_start(fs_info, args->start.tgtdev_name,
 					args->start.srcdevid,
 					args->start.srcdev_name,


