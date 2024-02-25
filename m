Return-Path: <linux-kernel+bounces-79911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D1C862890
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 01:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4EA1C20DDF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 00:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288673D76;
	Sun, 25 Feb 2024 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="gynejmae"
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF3A3201
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708820863; cv=none; b=s6/1gahLAe5/OczQIOkz5y5+b9UOOSVZySRYlNCAeoga99STYVmGmcSI0Stg1qRTNcBiWTmBlkBwGKMjuUlFvKXLKhy31hv/usw7ialDeeMh/4zrOMQ57tC9lPmYQmvY/bmMcajGq0MpEhhQCxZlyzonTwIa6Cd009mc2Pbe7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708820863; c=relaxed/simple;
	bh=a6op9LPxVP1ZhRrCX4RbtmUjIO7c/n3poBMwBZV3+k8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TrDbazz8OkMCxY2X2hGea/Byk0ogLAj96jhVjWKeWo9iUW3Q+xI7Hp2p1ZoCB7cwZDAzhM1Bj9hOIlKMh5GyF1b+8TM55siUGeEckylZrlnNkUEbgUPbDhyw7j7e4x4mldHS9k82yn7qxKqnQHcO/E1AgDvY1IIeOeJShJjAmFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=gynejmae; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708820857; bh=IHXGFFtTc5ApnKkLXjHpqPnI2sMbwHYVwz4fmBEB8T0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gynejmaeDjdN6cLG5Sh5GkYjUNy7q5jO6bKP/jfyemDvX+76VTYJl1E1ztF8y8haf
	 3D3MuqdhD1C6+BDggMKdEijWpIQ/wccg+zuZOA2pRR0WvlDP59EMji5bL6zk2RGzFK
	 rdanr1X08oyknR3pSTmSUcqOK773Gl/o5Jum2+Uo=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 6E3ABE52; Sun, 25 Feb 2024 08:27:35 +0800
X-QQ-mid: xmsmtpt1708820855t7xdroyp1
Message-ID: <tencent_651B062576BAD9BBBE336A9E551B294BF608@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/VlmtfTzmjpgUsAUexGqRV/NAbW1rEMuz8EzPSUBlb0Mooew1Vt
	 crPzNDMkE/UwtMtzvq86heeh2XwfOc646AuMTSi0jhVC91mJ0EIYqhGDG3Oy5vEeX0j0LCxPi9NS
	 g4OLaawUgsLQMKwnxVlqjCmae7iB1lWlRIp5UdgNQMPkRK5vIfSD16zLJWIT5lP9dXwP6njbIQuD
	 FFPGNeHOMcPgEzBRJDvcsRdirdnhp9/1yPzO91R99W6dofZ58EwZR3PRxXh92Lzc0krV5oiWdESt
	 IbhxOySJBfJOklBn2ejGt5Cm0rDWCzQgzw+bVIhzZXPzs20KSqc5oPK/YcNhF+62/dNXe4tjc4Kb
	 87oNVEqYIsj3unSYfl1f4rAUpVmWoCo5bfkDr/ub/c2+aKYCP6GtP3Bwz0nhRTjbLsVJDsQ4mlXb
	 8Ku/KJRJhG35LBuo17P/3aKHTDryE25fmV0W7MeWR/4XTnirR8n07VNSL1o4D5PjXe2CHgyHYzkf
	 fhsdtiDUbwzzEA7Qbf/Dqa+pUWF9sbhENaRQdTqRHDlqlTOaQ43xx2JK3HtNQINsrPnrgy5/GMUV
	 mBs9G7Zn5axnbnMeTo2f4/kCvXEAW/GTCkSaEqtOuQvR8BsbwCe+EMP519eNeEIkyGUB3G3cQGGL
	 fUFQY3syiGvTBt+jlaIq3IzTxNDi5LsNA9lSKhOE2T2sEKGnCVv1acW0C5JL3gKCf2w+c7y+Da07
	 FVXXMYDTeyMF5CW034RJTNs+le+FqvO3Etw8qiez8DUXukx1QM3ukTMyvI56TKL2491yy9tBwPEa
	 oNo3cSFTug/GsbAWj5jhuHrY1GKHhGnWcMWxt/HvSPjZrtoHRnRqjodAKtVbnsLvgzR5lBXd8L1S
	 NaYhstrKgun1ikR++9i6JX7yZsRCf02Zjg+u7VzPzJT98td3MtorRxB3R2rp5yh5M/uD5JJv5f
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add (4)
Date: Sun, 25 Feb 2024 08:27:36 +0800
X-OQ-MSGID: <20240225002735.3817720-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000fd588e060de27ef4@google.com>
References: <000000000000fd588e060de27ef4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uninit-value in virtqueue_add (4)

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.7

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 9d1bdcdc1331..4ca6627a7459 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -427,7 +427,7 @@ static int __virtscsi_add_cmd(struct virtqueue *vq,
 			    size_t req_size, size_t resp_size)
 {
 	struct scsi_cmnd *sc = cmd->sc;
-	struct scatterlist *sgs[6], req, resp;
+	struct scatterlist *sgs[6], req = {}, resp = {};
 	struct sg_table *out, *in;
 	unsigned out_num = 0, in_num = 0;
 


