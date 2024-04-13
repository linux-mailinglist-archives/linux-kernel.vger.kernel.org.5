Return-Path: <linux-kernel+bounces-143589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C578A3B2B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76CE2B22D18
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C3B1CD26;
	Sat, 13 Apr 2024 05:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NRuEffM+"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5D41CD02
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 05:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712987304; cv=none; b=fHWkRMBhcOJFNXlgjdAiH4SUvdvPcOWUWy4FhGjny6MtGg+XgI7umjv3AY2pYSS+DcwK1q5x0+tOIGiAjUmpxd8gEswJCkQ7ra/rlaVUdiI7ksACFk+HBwrlhi9LrBRXBY43m/frraJ5jWik7LrNtd5/S1UBOTVsdx2q64BrGqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712987304; c=relaxed/simple;
	bh=Y4BFVp6nyddlIhzK1wcJhlAfkvM9MhdHQSUVR5BItCg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ptaEZiIyv/zlquS3wFtMb6DAUcAPSQP3qCFQY1Vb266TwWEx0aR94JjqR1UXJIthjTVwQ57yJeBqKWCH8wdJ+scRdO5SoIS1PQYLmgELjlgTw7i1wOHP7/sr52P7eJNxVdoadgp41HZIK9bf0LD3GL+dpM6zFfftgUWp68OyQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NRuEffM+; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712987286; bh=Oh0zkVJaY6wf49fbeUnHcgU5M6hHHm+Wn+/3kIS7Zcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRuEffM+Ib5/NRpsmrKjtVBcHfDN0YVaUdveHv8Ut+JEF1vG8P6HOl9/gDupK2/DV
	 IrmPVnBRZVwbUomncnH+lNN1PXTLz6DhLRHHvpN1Ff48BhBhKuCYNn6udRM/ai0pgz
	 exuEhmffz+4IZxbtZ4YBRgagx9/zkc8NgRJeod3g=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza15-0.qq.com (NewEsmtp) with SMTP
	id A770020C; Sat, 13 Apr 2024 13:41:55 +0800
X-QQ-mid: xmsmtpt1712986915tq1bofvmj
Message-ID: <tencent_2E487A6E6D182D096F0097E4EA8AEDFACC0A@qq.com>
X-QQ-XMAILINFO: MmPNY57tR1Xn0bG6a/PZp+7Q/QjdG42sixtr2YbVKC2Zv18XAXG3+uDMaERWaW
	 Vk6bsIn0q8d13Oya2pr+A9T0LKLxxAOii4xqm/2RhR8lkszQZVOD5roezomT83ENa6y/ZK7QobJq
	 xG1ABR+3w6IbsaXc8CpYhg3eF26aDk5uH5Qfz3EoqbYboxZuyco36jMQptlIot+x5/+5dJjz53wc
	 7rUQhUC8DyTd+tfc2mpnhjcx+qHg91WFwH4vwzTYrjUcNXSPCt6udyKZE0BRSESIdBY/wx+qtne7
	 y6AWIYB14hMXObpKJbCBCHy84mhUXQcWKgeJH/3LUCSN9O9ddqcKg9nRcx7sAFVfNiak0liol4x5
	 WgbvPWeQ9DOgwQ03cLK1U7YzAOR/zlx2QxdevvwmgX4t7uJ6Jcv4+O2UUbJKewV9rmJtx1uYPiVd
	 oex0vmdRhNJdvKzxT4cIYYkVDKP+1/+Z4sw97JzHUYKo7nvTEn+yZiFkIwpQOm+/1dVH29qFZPaf
	 RJ+jXtOU2EXzcof5Zo8nA+GX65wIghyDmzMXuP5/gGfNj9G7TWnswcvZbDwOjq4LR0NcPcQKaH1l
	 EVClh0mQnz+9Cl2vp+cJgesoWUxJzLliIT8vgZE/H7jRkDplnqkT0Q3EXCdf81+FRsTS/S64C8SZ
	 7qR48Zqgo/2TTSdeDOWs1OGX1F5wT12nlanLwUBarfhjd8pl3EaUjJv8he2GobHLAxHzHXte6N/H
	 Et1JRpDzUlIMTs/TxTgp7MQA292HrxdUpHaR/41x0HctQ6Rvy3rQ4EoWDOBnWZP1aF1xw0mVEnrj
	 Rt21XQGSr2Zv6K0nlUQaEc42bQI2nANGduV8Rf5vrSbQPKE/cHSOFOQjmklGE1mQwKmUCnEPPygz
	 Qk9p8FSJvppyVwi+hHNOwp0S6IztLW53gg8hUB+NINNJwN5WLJ00LXAETOA+wqKVNz/TFSZ/Jn
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
Date: Sat, 13 Apr 2024 13:41:55 +0800
X-OQ-MSGID: <20240413054154.1998625-2-eadavis@qq.com>
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
index 8cddf955ebc0..5585f92e4319 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1007,6 +1007,7 @@ static void trans_drain(struct gfs2_trans *tr)
 {
 	struct gfs2_bufdata *bd;
 	struct list_head *head;
+	struct buffer_head *bh;
 
 	if (!tr)
 		return;
@@ -1022,6 +1023,8 @@ static void trans_drain(struct gfs2_trans *tr)
 	head = &tr->tr_databuf;
 	while (!list_empty(head)) {
 		bd = list_first_entry(head, struct gfs2_bufdata, bd_list);
+		bh = container_of(bd, struct buffer_head, b_private);
+		bh->b_private = NULL;
 		list_del_init(&bd->bd_list);
 		if (!list_empty(&bd->bd_ail_st_list))
 			gfs2_remove_from_ail(bd);


