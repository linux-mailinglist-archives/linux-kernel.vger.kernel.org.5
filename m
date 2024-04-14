Return-Path: <linux-kernel+bounces-143935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D659D8A3FDD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 03:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709801F214D7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 01:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C66712E5B;
	Sun, 14 Apr 2024 01:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oLYu6rKw"
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7323BE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 01:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713059304; cv=none; b=SxNKQ5nKMum2jPUBo0rrC1zw351QtlfmQ3C3PPnytMJO1yv59dnfyWJL9CV0cAO05N1Pe565pbqn7ASaKftNSQ8n85BOzUY0rmZTO3DSCUoNBdh+YsrdLzzea/2je0Ze0nmJwKooF4BOK7Q6PsdBg3+D//V0uxay3SUp1kOSHXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713059304; c=relaxed/simple;
	bh=k4JOZGHkmFm+2T93nILHT2p+lfd97i7qu2YGYSMfckU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pS+x385R9jTD2uc+m3Mre/rFTMuWBVVHe5iruQCnsTOQ07l1insZ1p6Vhg/+pc+Gz13gAkuXjxYtYwKh6Tj74lGw3jjwcqCUIOz5FU39RyExRwNVEKiDhlRS92BP4wp59/29M7uCtyNKGOI3CfCX1KgeZ4Lqik2ufYQsil7S/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oLYu6rKw; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713059298; bh=iOkTuXVDqDo07pPQd/7rVcoCyMxK/jspIPJgFuhRKeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oLYu6rKwznp9GNBFDaqHMNZuzcVwFjSrZD8U62M3ETeQdMDB+dOc5XG4LVQcKpMHM
	 /4ZtzPyvY5CGpkkXR7DeY5+iHVKKoPGS8umFdUD6W587MgpPIpravIBLxeQmavd3ub
	 OQWIyEdFQRgAkqaEB7enCGdlXXGvKCiS0TYRLIrM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id C10930FA; Sun, 14 Apr 2024 09:48:16 +0800
X-QQ-mid: xmsmtpt1713059296timm5mm5x
Message-ID: <tencent_5D519E8D1BA04BB71B792555BAB6BBB73308@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jhjE6VrM0t1A9C9Pl2Vpki3o1Dzqx+XUJ6Pqr+gLNKye++AURFG
	 QoQ6tk9WFFSIOz3/WrMb26S965IB1MudRQdg1/zqbM+7UDjr8DN54MoWXuYVoZd+HPOHsdN+yK7U
	 zxuZQLuTUUjdNtjiMpjpk6zdpzRu+La5Ue7GSxorEyJhaApFnmHbtAKxjR7Qpx5LrS4OBuWP2gpv
	 Mopw+LY33VWBjgCOlvYkZ7UhoUmfH+dK/69lI3A8oTXbsqOw31MGeSkOItNCtx231DbOdKCvLy3B
	 Bjqf7Xx2u8WEA34X9DN19zLCAgYjtlfsL96geu5el2tjgx43pryqEBhXxHJOe6Xy8a9Gl3hOqaDT
	 T66OZ7DQa7JmY000rJiwSGXvLUFr4LhE4sPq0B9dsP7PMOZVgxPlZRKiW83ZGeuuP3wLxndXizNX
	 DEkNIBi1S8cA/xZCoUmg8Qyx8WYBTzY1a8zbsgIhkylHKbSOvx8pU6RKjaF7uraSrIW1PBJqa/Kq
	 ecrky925nWoDfDCzPclwoKtvFRQaPJGQVKfaIgRaGy10UtSo5P1CyKpqPJaEVYhbcluy8bgua/dm
	 HoRyCydPevyAmQg5gi9imkEAxCIDH5UQtCB7A8ibRIe6dkbzPLG8bbyDuPwEj9C0vEFluoBKKfz4
	 vrNQ3+Ar4zbW5K0RGfGihqI5NF7x5zIKG1TZpkH+9Judq/DVOU7XL1RYTQp1X05NEQs8xA7jHj2o
	 E5j2ZijE9BW2LlAkTQS0boNmyEf3/+X7gmv7E2tvkRBzMS7A2RPU177EdRWVMp1+jIGHB6p6saE8
	 quZmkLCCNAuUGU/ZTyGGWveZkz0GSzbA+AbTfD3TN9Nqfuja41xYussqjWBIfByQVBe7vFEaC5Bn
	 T7IqaDHLSlzbf8Qhh7lH1ftBiCqMAPv0/CyCWroQIpsOfivtnVSzeoAWV5yxOXGBb7ZHaf0bKOGL
	 LilB/fPeg=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
Date: Sun, 14 Apr 2024 09:48:17 +0800
X-OQ-MSGID: <20240414014816.2867480-2-eadavis@qq.com>
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

diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 192213c7359a..8d169b389dc1 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -202,16 +202,8 @@ void gfs2_trans_add_data(struct gfs2_glock *gl, struct buffer_head *bh)
 	}
 	gfs2_log_lock(sdp);
 	bd = bh->b_private;
-	if (bd == NULL) {
-		gfs2_log_unlock(sdp);
-		unlock_buffer(bh);
-		if (bh->b_private == NULL)
-			bd = gfs2_alloc_bufdata(gl, bh);
-		else
-			bd = bh->b_private;
-		lock_buffer(bh);
-		gfs2_log_lock(sdp);
-	}
+	if (bd == NULL)
+		bd = gfs2_alloc_bufdata(gl, bh);
 	gfs2_assert(sdp, bd->bd_gl == gl);
 	set_bit(TR_TOUCHED, &tr->tr_flags);
 	if (list_empty(&bd->bd_list)) {


