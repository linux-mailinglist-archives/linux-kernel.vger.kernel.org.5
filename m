Return-Path: <linux-kernel+bounces-109589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00689881B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D412852D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179AC524F;
	Thu, 21 Mar 2024 02:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="noxK8eeg"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478E1FA2;
	Thu, 21 Mar 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710987754; cv=none; b=G33vMncjnFykww/6R8n5y/zg0f4hadExyv6MD/sOrNmMQpWnnrASecr8RJZp12pE3hyTSCoCxAs5QU7HF9DVcUpNSbXX3JUmV/7SF4uAsnAdgLfRRElCR3FMRkkZU9C+4mZgzCHErBi+ccaWbOR8TgXAqPxtLfEnzrLpgZFd/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710987754; c=relaxed/simple;
	bh=jZ+LsTmK95ZdAmRuA0OFABHxkMFYGbBWun3N61Cxfug=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=ELfuIQj/QRwdgp4MWUn+IMQ2p48LoFE4uZeGwn/sImWRPSTuN7aA24EMjhc67MbshEmZWtuPGv6lanu67qJFpH+s+5KKvlYFThc3NqfTQp4bWEjNeR7gr4LqoTvv78sG/8BwCewRZVAYEG6PgrBXp6BX78WfxJt2ZUiv5UGzArM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=noxK8eeg; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710987746; bh=tGduqx86ofJ4VZiMxzvF3DYEia1EIzuyhA5NWgFAAVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=noxK8eegEsMhIzMzk5ZzvHOs6uQgunQPrDD5re8yKdfSVsxUAcvrBVVwzsKBzZPNO
	 ieZpwwYgZsUvUMFFHIJwUBrDRWesSqdnG6hg+ZoNz9YflJOSROVBThWnEmJo7iILke
	 gM2kfJx1n21N+txJPwIxe6ixbexPTv8Y/YdEsq7c=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 597A0486; Thu, 21 Mar 2024 10:22:23 +0800
X-QQ-mid: xmsmtpt1710987743tvsaz0g1f
Message-ID: <tencent_AC7946DBB367A364897F43B2045A37625705@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTh5kaSsJnxvMdWkS/957wfzyIPBAljw4bzj/aSXtxHOo0EAy84O
	 7wkLb7/wfdb5nQbi8SxFgkcZIguPhh4G8keQhitAAfZ/sRoJT9GXFHFbpS81uavFodxfKiUiadPJ
	 Q9N7i0sOgR4p8AHxgVWMHAfD23ilJTnkWur5gVmKli1h4LX5psbS7aOW60VwijVhdkULlbAtUJ9d
	 jssnWg/fOMXDvkylyZ2BICXzW2IsRBoY+oCyOpBf8b1nfW1zZmLAAEgKZjJH6A2MnyCLgqJKEBZF
	 ZRLVVxOLFjOhVImtqhh6NVEIetjMC6FAzJNNXsKTeeFTF3WRjhrU0FbK/4FyVGkHjk6Ni23aP/WE
	 0bkroVHzTEEOldQ5gv7J+Zbpc7qPqYnEuiRtFGKEWtLHiJ22zTxHqVQMuttnvsdlKqvY9duuoB2g
	 v7+2Iv4Bw51LHbN1rO0tKTrZrqpLthkSIwr9lnd9fUoFOF6hLQANGVbUTlDxPL5+ZRktLrCaO18l
	 e5Up9ySaZ7bEiHJ2P+GhBGfl7rbgbYF7/arY+NvWOr/h7WOK556tphYOYWIgZ8kpYvIeZLomuaQx
	 nWjJAzbLMRXUaQXu7KuuaYSJ2A/iJ+wFTUCwRYkfRQsfBShTS6kB5k9QWh643hnxokevjnsOEMDV
	 0of2jcwQiDhII4Qxtiwr73ZyW1qzL/qiwKO07akVDbMjlwu3w9IYx7ljXB5JJvEytRlv1k4qC+qU
	 cknKaKr5ACZbotmaZj93hVTxNV0gnZkug4Qo/9NOtdhUF0b1ujmUUfg69XCEdB5JgKc6CW1UP/eT
	 HWzCLWUks8vANXUi/5pK1oWXgWwHrjZqbhSTa2SO3S6hNOBNJgzacCg2KW2yTNMNM49SimhcjUZw
	 dKnzNGrw1GSSSf5UmYSvq8fYH3eMo2+li1o9IBzobxryHYR5dXRnTK9dQ+ShMn+DWUOKbMpM1iXW
	 mIUzvCCYg=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: [PATCH] ALSA: timer: fix deadlock in _snd_pcm_stream_lock_irqsave
Date: Thu, 21 Mar 2024 10:22:24 +0800
X-OQ-MSGID: <20240321022223.1836044-2-eadavis@qq.com>
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

[Syzbot reported]
swapper/2/0 just changed the state of lock:
ffff88802a304110 (&group->lock#2){..-.}-{2:2}, at: _snd_pcm_stream_lock_irqsave+0xa0/0xd0 sound/core/pcm_native.c:170
but this lock took another, SOFTIRQ-unsafe lock in the past:
 (&timer->lock){+.+.}-{2:2}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&timer->lock);
                               local_irq_disable();
                               lock(&group->lock#2);
                               lock(&timer->lock);
  <Interrupt>
    lock(&group->lock#2);

 *** DEADLOCK ***
[Fix]
Ensure that the context interrupt state is the same before and after using the
timer->lock.

Fixes: beb45974dd49 ("ALSA: timer: Use guard() for locking")
Reported-and-tested-by: syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 sound/core/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
-- 
2.43.0


