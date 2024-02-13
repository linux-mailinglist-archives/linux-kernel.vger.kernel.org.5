Return-Path: <linux-kernel+bounces-63366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23D4852E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3852836FF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666E4286A6;
	Tue, 13 Feb 2024 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="X59T67pM"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205A424B23
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821038; cv=none; b=DfiMU/2wOeOVafHtdq9qF6dPlHpP5KJMxK4NSedH4FmODsD3GYKeCTrScOVkCKq4mLayyUhODjohDDQPNOuI9+33uOU22JhQSNOGTzn6dM50vU2KXsDYmZKY9oizqc4yCTuMwaml+NU1Fs/us1MT0AJGZl6kaJmbfHMzWsjUiMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821038; c=relaxed/simple;
	bh=h3vHrYD7hhov7txanSMDe7pCpaatJhH7Xwj2ojnf8Rg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BXuM/AlzXJ768B5qXSHRjUWYr7YREZX7RhyQVLjkXggZhpOeswouIcaglgwvaZsVoZ6YvmdB3MjJ7Rt6KYFBltRBSeCBMvab7LEfKFtxQ4RKtrzL5Cp7uKoVrs4G8Ynd7hbQGQbI4n0HvZLTPoOoi0E1Sr2vOYSCaDM6/6jL5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=X59T67pM; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707821027; bh=sEZ6YMGniVm+AtqGa4bZU5AbsOVmzpZP7amUT7bfhUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X59T67pMbYsdeIQ2s35KjiKzNz96km9WTfhgnl5Bz4b5n8iR04Y4vQY1Olg1EvJpZ
	 fzHf9FT9sf0HRkEyRjkDHg7jwCD256Pgr2/8//uYdQXyJtMs0Jq3akXFCrEbjWylis
	 mSdOgvcNOFGeHVSYATvm2imKQ4LHnMJVufvSZrGM=
Received: from pek-lxu-l1.wrs.com ([36.129.58.158])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 961908ED; Tue, 13 Feb 2024 18:37:33 +0800
X-QQ-mid: xmsmtpt1707820653tv66kw34l
Message-ID: <tencent_E2FE25978DA612195DF45DCD191D4FAF8D07@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2lMdCi18gEdOs0z7aETiwKrih2512wr3PfbM2scpmQRortbAmgR
	 RAH/flE3RMECRy4iV0ookU809CcnopizHysyNuPqhNZ1birOD/82ycS2khAhqNoFsuFPiIgGU07f
	 SZ4b+RaygMakxnHsfeUSRxuWGvp5O6fj3bjU98TWzuFAahFGyh/gngb2oilRB8/Ml8qXKCCYOW/a
	 mKfxE4ZXPCaqzhk0ZhrpQ1DdhqECtyQhb9izj+2Wg4s9Zy10Cq+qLBm1NEBzqUZnJNOoiuylGLI6
	 +CtUVTcV/AWfEphp9fs0JiVOXO0VKL2B7G+bgekbIn+DUVhd5cJfXsN325ubSTwhBcOC5nYojgH0
	 Wssb59LhM+08nwOms2FHVQ1Z4iKl9/b1s1WZ8p5KPryDUuqLDK9XTG8WMzYzl8iR6p7HZly/2jE5
	 7EgJLCYC5W4A06FFpLA5elwv9ApBn3qwHZmIKFKU7zP2r/yrTLfIFbsUjvEl6o9OlTOn2aWl1F3a
	 jAQGHZdF6w3OeX/KCqU+2Hp7oJbqRep82Km5UZYyev3RyU4wqD5GZSq1xOc4UuywQKabmrXVXWhE
	 hElCrD1PGf1E+KHS70c/1HQzZxZgnRWB24/WK1A3L23x2GXYMkdpy4OAZ9vnlUcnYoKDU9zHD3pV
	 NBvUKNWEX0cVQO5pCv2h+UAXu/+jfaI7vZwRq1IP7L0vhJUTdwHzeRgkkc1bQsm+QL4b8+/WESVy
	 RKJGklchCTkGL/6SacOp+nFNEIop8eo7dkWXxVyUKQDg54RFIGidaTPmb0tkqS2Kt1/3X+vuiYxD
	 SbTx/RipNaG8Cxbd2IeUWq4Vf7b1eJrHZuF1/ORmrjmX2y+IQniQFdEvD7JAQNEfiwZMZdB+nCQ8
	 bYYoZ9C5Xd7StO6L74h8XlT3chC6s8wyO1aL2s6VBFbI9M4cputIFicP+VuuXuUQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c2ada45c23d98d646118@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ntfs3?] possible deadlock in ntfs_set_state (2)
Date: Tue, 13 Feb 2024 18:37:34 +0800
X-OQ-MSGID: <20240213103733.997747-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000998cff06113e1d91@google.com>
References: <000000000000998cff06113e1d91@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test deadlock in ntfs_set_state 

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 3b42938a9d3b..1dfc933b58ad 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3210,7 +3210,6 @@ static bool ni_update_parent(struct ntfs_inode *ni, struct NTFS_DUP_INFO *dup,
 
 		/* Check simple case when parent inode equals current inode. */
 		if (ino_get(&fname->home) == ni->vfs_inode.i_ino) {
-			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
 			continue;
 		}
 


