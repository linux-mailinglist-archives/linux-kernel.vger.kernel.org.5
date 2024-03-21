Return-Path: <linux-kernel+bounces-109522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB471881A80
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30872282BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 00:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B785A23;
	Thu, 21 Mar 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vTAFwLAO"
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFAA1851
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 00:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710981699; cv=none; b=dftTNg6I3S3Tfah1X1Eqaedeiwq4pI4gB/ad6ZiSLrHLkV08gcKXvOqlBorU9bNzaaAB820pnbagMEVjrp4AeNg2izf0+i/LAvnHOz43a/dEirilFUR7zOLYBNG40XrOVKIhLqjF+R7eWsUXsfPKN/ehZzVZy//TrkXb5z38uzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710981699; c=relaxed/simple;
	bh=t2Judo73G7ONIv2W5IvAKGPpkOBjuUXVcc3XP+sOXWA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=se2cuCFPmG1O1TdtzBp+mLynDfwwpGvbbtwPoobKY+4RXfIY/y4wVVJBGN0shxP015VQ7ZxCuIVn1yXPpOCwz2WhoLjrj+sLOWX/NR4m0a5CinrDpa3+i8xgaVcpbnL2yCWFE9qGfoFXBfPgdY5VYY34rvKD1M3tG2WWs/yJ0F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vTAFwLAO; arc=none smtp.client-ip=203.205.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710981695; bh=JRowUOv4bGjxwTVDBC2Eby8hssB+O6+EDSOmbRZwsGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vTAFwLAOynFD1I0K8JUghev/LfyNI6vDh+jIpAFlGilnFSANfxIKPn8Vm4ZeBByZr
	 BxSNSoto32NR9WNhX8A4FvQLndYBMgN6n/uIoqoFw7tJSWjT76DZJ3EvinCjvBOFkO
	 V6fIhsJGt6IDWkz9pee3HklIi5f+FDJ+KT+A6WO0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id A1837407; Thu, 21 Mar 2024 08:40:24 +0800
X-QQ-mid: xmsmtpt1710981624trua0qs0y
Message-ID: <tencent_628EA5EC0D8212135DADDD9699154FD18D07@qq.com>
X-QQ-XMAILINFO: OMa626R84mNhFqJPo5nGEDXXPlRP2P9iBJ0xntHuZnBJQoBxpcVeX0xg/oDosJ
	 E+9MTJVzN/i1CVt/1BsGtVicWEcH1oSeQVSLKVweQX6dnhROdoI0C/ay2BePlxMw2QHkxg9RSCnS
	 EqRSeVBEBg9VVIIlGS15wA/+mxWYenfZ4NMpvZBfSnT/9A9xy4wwZd3/MwQhle4RA/TlavbTyRhK
	 CXROXcwBSy84gcxcmlc6tD6f0OvmMJPNC5diJB1io/EXDpA2gJvstOhZjmSf7KqtPQJ1wQNBE9BZ
	 HJmv8TO+Pook6XMXWl9FsZcp9OahfGN34ltscKJA1IPEAAbyUmDFl4AMbyjlaamZVtbHJHByN8Kg
	 tzzrqhHnH6Y2PsALTFu94yN6n+0MQ4b9dyYSoPOGk7XZ6lxDp2rLMg0/A9vwUgkkZv+q6PN7ixiW
	 VKBcHveNK8MfT0FAYIrvbhBvEPGmqepckSOzDi+LnQDF2Mr4SOQbyCC92jziX02+BphZxB2s1qrY
	 Il4MEiGU5PH0di4gthalUsWK4df8pzdkgLdoXDKVIYEMB3pHMukLiTYGpoxEO8LTcGbdQ3E4BGf0
	 8Woa5VTNIxhgzn3PasIBed2jOZFK00r7UMcxkPgJynXQ2/QZOo6vGQ+K9B3ZpsmWb1P3AF9s/DCX
	 183BMooE4cVnkbBuW8ltC1y2FjszPUiSj7LrVAgCh/NKfQ/iomj3IMb5iY4pXZvnt2NhiiWYbint
	 t0Bf6lHhg+3W3vtknDobsgST/shSyDtWLvq/kaXU73MDXZRsh46b1bS4RFKbTz5EtxSGLENSqcXv
	 +OUtfEZTkocc8FAYemSE+vMnkuep6jTEKn3TtjjoiqrTfF1vQewDuI9XLpJ0lgbLTm4Pf5RLOK0y
	 RgNgNc0/2L69We+K/lIExFL2hHtoaPbvKaTsuE15+iDRNvRS/si9XAzbKAkP6mk7mrctQDH50m
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave (4)
Date: Thu, 21 Mar 2024 08:40:24 +0800
X-OQ-MSGID: <20240321004023.1726689-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000096e5980613f4cb96@google.com>
References: <00000000000096e5980613f4cb96@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test dl in _snd_pcm_stream_lock_irqsave

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 15b07d09c4b7..c501faa30040 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -409,7 +409,7 @@ static void snd_timer_close_locked(struct snd_timer_instance *timeri,
 	struct snd_timer *timer = timeri->timer;
 
 	if (timer) {
-		guard(spinlock)(&timer->lock);
+		guard(spinlock_irqsave)(&timer->lock);
 		timeri->flags |= SNDRV_TIMER_IFLG_DEAD;
 	}
 


