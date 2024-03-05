Return-Path: <linux-kernel+bounces-91482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA987122C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD741C2245B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43A2E556;
	Tue,  5 Mar 2024 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kZEHzXKh"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BC7465
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709600215; cv=none; b=saO/oeIIq0j/uuKg2S9+ZjTfKKqgERGBypHnagvCRj4Qa+FDdCSYBbxHkQr6CQIsyQ4XP3DUlllq409uvCKsamayzZb39MkmGmWvuMHVTgEhvi4BPa0dAG73vaewFXBNc/iRwegriRg6vmmkyWZ05JrnlvYexqabXB5VPcDMe8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709600215; c=relaxed/simple;
	bh=8A4tyZ0gAOGQLtCGhqyBPCD2abAB60AjmkhroDUs34c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=sjV8UbE8pk1dMyI9wXjmK6UeTcff//NTTnyuHEH/wWBHBnL9Qn65Li46oYbLwypEXF+HHGNydGWpWUN9Xisv8nSsnAIPd8cO1G00aa4dTypSPVFrsAiBbo/lj4tRCPzkNPqH4x61kLmD6HXAjc3s0gHwTjsRlrBoHE/mw+p4Hgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kZEHzXKh; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709600208; bh=m1jGkAnh193C+1jepoR5r9qSqXCetNMmlr/wrtXENmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kZEHzXKhHMFNps1KzHa5waMYg/9qUYxkYPSqJcgAa8vXkNUjOzxpLppXNfBYWbirk
	 /d5nJnQjWCtTC95RmsGdliIbE/7Q/R2gGSgJytXQJK1kBmtfg/FXHCDKYoPxr0v6lD
	 OXDUjuVRR9OM4hqcB2kXHTiJv2Gj4nf1GTgIsXsg=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id E2E2707D; Tue, 05 Mar 2024 08:56:46 +0800
X-QQ-mid: xmsmtpt1709600206tvnaorjvl
Message-ID: <tencent_2749AC6EC9EEFD0CA1A7D706C792C0467906@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3XwT1tYh3qwEpUlbacKkOr+XyD8Ax/6Omv/onYChOB+4ZY19RMkkw
	 b/ZD1yNbDXfBWypC0MLdgIPAk+j8PrmpIop5NuaFoWTqbQT/Z7IxZaAPzSpHjk3GJM11rayLxGMN
	 4e28QDHbXM/9sLFKiwsV2KfimA3qqV1v2f8di9+9ugU8UlXY2HCjzf8LpZAkL6JOFeOUhm5u2Y52
	 Ogn3y+K5DWOPI4FbFN2te4outko3b/UAOsKjCJj85V9tzAsewMIjwcHe+lNbuSTGdw2wOxCclELg
	 oM9GgxPB9oKZCLi4SpM5hZmBsnlcOWjylHMWGU/hgPfY+WLxL7qLcDEQsBEP4D4G3LmqdWNaozCV
	 tt1wAS5UHyRvV+AxHsCfBiRlicjl+YAyxk4LseFHro+250pCTbRWTpcQqDSgBoi7nNvDWP9r9YKn
	 PTMqQ/nUMRSQzv1Nr2qbnO753TKC1haWQQYsJxaEggbia9WEMmWh8huS4HtTvzGfxXnMRCoguwaU
	 4Q7fehHL6TfGLqacYjT9WX4FJM9d6nUGV6UxIibjHAg6tL9m+t1HIlFQbcI/Z7cylKVOyEH1fS7P
	 3cNWX0yULebdYK23Z2C3Wb/RpHZrBIZAnUIVtavSv2k/vGfDrmfBkiikYjU7urpWrLJr+gIKmrN3
	 DS/hMt9KEaq3Zv0aFDB+kRzUg/qCOntQZhTde6AQ397wKavIwW2iWYoKV432rVKobmmxa7k4diJP
	 +G6jSSLBsX9nQf+6YuvwKwvDtGsSFose1cpAqUXkAoscZwo7bXL8srfQ8wn/2f0IFmCaQFW+++PU
	 p4LrQ5uAEJmtpG9AF9IgzMDs2XK6yi5dd4Iyiqc0p55KbgewDJlYsRWEuQofv059DAqJZCAL7nL+
	 KoVrN4yGC9UX0vgzDUdR2eXrJ7kH0N4iouO0MJaPJLG46b1u293RsyT0lPEWtJ10qPEqevSm35Xz
	 lyIHC2HQZbgGznhn629g==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: null-ptr-deref Write in do_pagemap_cmd
Date: Tue,  5 Mar 2024 08:56:47 +0800
X-OQ-MSGID: <20240305005646.2282887-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000001bc4a00612d9a7f4@google.com>
References: <0000000000001bc4a00612d9a7f4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test null ptr deref in do_pagemap_cmd

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3f78ebbb795f..ab28666956d0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2510,6 +2510,8 @@ static long do_pagemap_cmd(struct file *file, unsigned int cmd,
 
 	switch (cmd) {
 	case PAGEMAP_SCAN:
+		if (!mm)
+			return -EINVAL;
 		return do_pagemap_scan(mm, arg);
 
 	default:


