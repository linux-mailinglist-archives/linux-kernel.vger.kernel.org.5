Return-Path: <linux-kernel+bounces-143649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5120C8A3BE7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01241F21B99
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74121321B4;
	Sat, 13 Apr 2024 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="O8YIbcsn"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9E42C695
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713000275; cv=none; b=Bskh5vCbtwGvzm+4MUZLTdneh9wAyDTpPMoX1NQqIfZKZk6ogysuwLYjRGwEr/QBRDyL5xElVA62TA3bmQBrXpQUqBsT1Wpiw6r9l27NpBCGQ4V8Gyv82CPVio1EuuBaua/ATQiIYFcC4qUaqy631rUj3CvyRIF+AfwpSOdEGto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713000275; c=relaxed/simple;
	bh=l46MXnhC2u19RXq1Wz3lUGvrN/61SBL0e/sJf+7k9oQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Sbtj6LWHAInMonGv94iHJmcBUjfRsofiiKThP8pkUQPZ16fjq3cYnfQFqqrZzWJ78heSeO18n6oZZAfHX8/pQ7lyTGN+nr7UfaE8zLqU7tTL/kXF+AKh3gCY1pJPzI8GGYfHB+5DJ7TMKjITufPEulQ01UtX+/OtIbcsd5+nrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=O8YIbcsn; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712999961; bh=Q7kwnaIuI1db8rYJ74Oy5gBkZEV1lOcuhUvY4UDWwd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O8YIbcsnzwlRx1HLGKUJLtzbpWK1XqCxSeUTrFWLIDBHJ01BKCC9vwjvjy2Osqoiy
	 ydxjl4gHH+3GgZQO1UZL3mo1jiVG5iYCUR+ob5oi4KEGnSl4oAz9WeK6u50ruUPVDb
	 6oG02g/Lmn1CZKK8pUlCZD+NLJj75We6DhkemyO4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza15-0.qq.com (NewEsmtp) with SMTP
	id 4D3076D7; Sat, 13 Apr 2024 17:19:19 +0800
X-QQ-mid: xmsmtpt1712999959tdcxlmpxv
Message-ID: <tencent_A6684B2C74B976B5674C3DC1375496EC3709@qq.com>
X-QQ-XMAILINFO: OJYupdf7O4Wt2vYterHmwDfCRmzNMuHNF4qlv+gSDC2kKjUyJJmfrkrwm5+x7V
	 kfK98qym4iITALVEqueKc1xa0p+iXZM+OBw+vyqn/RDMKycWjifSkuXAGHGkeaMDFZt/rgM0l1y7
	 STXINFTYxZi/q2XvX49vb5byImSu1ckzT/4mjdccPr86wI3k1TUyqbWD5i4jcqDskeMOcaU5GuJV
	 nvNaHhllKKvvZ3RY6WJV9pIpHIj699EeSUj6YgC+fwgZ/K6nBExOdnichX4tkwK0nWJX5SvDnm+J
	 kcXUrXKrfujV6A7beJOA3ss0VVIlKXx2p56BiqAg+sxBPmY6gLKc6QbbqfUEUsqTlxxEPDtpWBDt
	 RDdhr52PPI+rB0ILU/Fpfqi6pdYMDgwEwlTOH0sw6PAl/6Rl5K54r7wCCAzBFxxkmp79axnbAMkh
	 pB/TBBjO/bXnnnPMtPgy/QbrBcIAs1g4SZpMtZ6h0A4IADIATOqiXn7LduTZ3EL2YaLzehfWOMKk
	 Q9SzjNyQO0A2DAOKuAvnvwq12iuF4P4yzINzFAw8TWEzWTRrGFT7NBbnKaswqVc8Dy2h2GGqHfdz
	 UEAaUyCxMqdLWrcKtSoTjDg+bxuFMbGbpFQCkMdHdHWZ1Omw9wQFzbmhLBGQEVWEOFmph+u4COEw
	 6EUzLCu3SnX7TgvNBIDguLQQ7zj299WVuA2Qq9xuRdMfJs31yR2x0LITE2ivf6nJaPCpUbjXNn9k
	 BIXLiI7SnUv/249hASEKJLi1KiL6izPCLg7yqwXQXOWatHRZryzrMZsYEIgHOttNSf2yGtTP0g4D
	 hpirwsEtGfNK+oxdHXBQkNHaLyNWXdo1IemL7i4DwhLtLe2JioQMJNS39SOpGybpYoP/wKAJKfSD
	 ncTEbx+o6lfRsE5Sxe9XU+5qKk+4N0hEhT2C89ILbS9gT86S0jUbRCieDJq/JjJS5HnNjOrf8n6Q
	 xQ1cE+xLmaVeeN0ufU3bxJwxVVqOVOZ/0kpMwTfbfPvTIbIHkHzA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
Date: Sat, 13 Apr 2024 17:19:20 +0800
X-OQ-MSGID: <20240413091919.2346828-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004f557c0615d47e6d@google.com>
References: <0000000000004f557c0615d47e6d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in gfs2_invalidate_folio

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e8c39d0f57f3

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8cddf955ebc0..698c9d1bfe20 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1007,6 +1007,7 @@ static void trans_drain(struct gfs2_trans *tr)
 {
 	struct gfs2_bufdata *bd;
 	struct list_head *head;
+	struct buffer_head * bh;
 
 	if (!tr)
 		return;
@@ -1022,6 +1023,8 @@ static void trans_drain(struct gfs2_trans *tr)
 	head = &tr->tr_databuf;
 	while (!list_empty(head)) {
 		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
+		bh = container_of((void *)bd, struct buffer_head, b_private);
+		bh->b_private = NULL;
 		list_del_init(&bd->bd_list);
 		if (!list_empty(&bd->bd_ail_st_list))
 			gfs2_remove_from_ail(bd);


