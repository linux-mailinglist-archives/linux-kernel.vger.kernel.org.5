Return-Path: <linux-kernel+bounces-45945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A097843835
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8EC1F22295
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C5355772;
	Wed, 31 Jan 2024 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="uZ9dd3K4"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA3054F8B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687217; cv=none; b=l96PAh0VZKLpb7983bD2pAZFd0Zzf8XY4i1OpQAnDbwodn7wdEOJeA2hlS4GYg0cIovAzxKmPZ9o4igmpAtNBfFIHZfxOs++ZmzG9HHrEuNCx8D3iBxjm74iDEPeos7dFFENnUbeIzjnHvAVlvGg0uzlB8a8tljXco0FrHh/j04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687217; c=relaxed/simple;
	bh=FxQ9Jre2mcU7XaTqN74l7zVJhpkULAkElYbYfZ57iBk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=blHUuVHIf2RLVZOjwerzWtDvkUx9dBJhFkvBcwCjiP9WcW0FCQAXMFvjibKo3PQ22c++cxzUqq3pKRaultgT4fN4aR8GeULfwg/sCk0ycWTINiNNlu9AvvxoX8SRz2WLAhsj+jDxtJ2rp5F/hOAVM+mInAnFZlIFlgjG8EDuivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=uZ9dd3K4; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706687207; bh=JUirZKTgDHp+vf97fLkeKsA7EOwU9QcFCW9ZrTrBI7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uZ9dd3K4kZ8vs9QakEQtASNwNJOsvGrBfnFujw8vcZKwA0nUXnpbaUMq601r5KvrD
	 T163pmBE8Gu+3kU1cL9Cpg5KsVACuxWkCadgQ61Rkc+yayIX27L/i6/2GaOcwsF4la
	 DvZuYVU5I3xSB8XNClkNmSTLR7z/JbUXy7f5ol4k=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id A2890663; Wed, 31 Jan 2024 15:40:40 +0800
X-QQ-mid: xmsmtpt1706686840tzqwr58ep
Message-ID: <tencent_7E79026C382CE16C5C96ACE81EEE26CF580A@qq.com>
X-QQ-XMAILINFO: NhUkPfKlCtQwr6nIzfYme0gVY/VUo3bW5nPfroErAIqgfOkOzLzjge2qZHjfv3
	 /azo45/IYux4gqtx/kMCKxM5XyZ8wLQSNOAHgcAYoP/66ytEvKBE/2t7Sq6/InQ8wyyXTr30WmGC
	 /DgIj/dYFOLBXXa8nsQhocfuA8jIxHONMTzZy1BwSeNto1eYLV1dtQCxcBbXacp7oBU1jvBGLbS9
	 Bx1AxvLDIP4ISi5W28a+8v7mXuHKmSz6E6xnfIUJdLrPSF5zhCy/QX332Cpj80kfyrmSHfJv0g7z
	 epB6dt/JWxt6a2kSMHpV1hd5pTmVKbdeePvcjf3wN+sK0sgaGRrNLetqCUoifkA7GrpSMkOnc4x9
	 3YBtybcmLMLp2QUHTrmohKYpjc1DJKw47CnK3SyXDOf4ByjYpdi03ijCiFrBO/NIDcF05Hgx+ePz
	 F7LUpFObqOMW4myRKHl73EwQufYmh7O7O90bLz0vU8It8PDUObXPLPbfE7Dl4jYjJBUdaQN1DHj6
	 +HSogzTot+eE8ON3/2QAOpd8EIkFJBzBKh0el5NKk+anctwmoQVsDp3pIuGXkWY22LZLYk2suEhX
	 iFzzFZB4Sk/x0wASIOFBr1Qui3Hih8xuRePUh+PNeFDtPEoNgrRf45vPay91UMBgqXDAHlqQqEIj
	 zLht7aopCEXosC8mXKHGSIHY0gWChd1V73rX6W7XUFOu/tPucjTDumiBQhy/xXed8/0btMFvvstQ
	 fwPNZ0eHb/s+RVO0F6pv1qCD8YmERsMJRpFchlLMa2M7JOzbZb8puRSHBbeKsD+3wJaT4deobFk7
	 2b3yEe4CH2vzZNWjwtQs5+aUUZPZmzaqRlP07eGkH9//lOCh6Jh+eELXlA3taPn+YpbtRvm4/vfU
	 GMoFf1VFTOE/Q6N5abPg57tqbJPgZ5bCyIbOHwPhkZGH4YUetkw2g/H9OZ2fgJr6o/FfUlvQE8
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+cdee56dbcdf0096ef605@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] [ext4?] general protection fault in jbd2__journal_start
Date: Wed, 31 Jan 2024 15:40:41 +0800
X-OQ-MSGID: <20240131074040.859382-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000d6e06d06102ae80b@google.com>
References: <000000000000d6e06d06102ae80b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test general protection fault in jbd2__journal_start

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index cb0b8d6fc0c6..702312cd5392 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -493,6 +493,9 @@ handle_t *jbd2__journal_start(journal_t *journal, int nblocks, int rsv_blocks,
 		return ERR_PTR(-EROFS);
 
 	if (handle) {
+		if (handle->saved_alloc_context & ~PF_MEMALLOC_NOFS)
+			return ERR_PTR(-EBUSY);
+
 		J_ASSERT(handle->h_transaction->t_journal == journal);
 		handle->h_ref++;
 		return handle;


