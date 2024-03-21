Return-Path: <linux-kernel+bounces-109538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A1881AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CFFC1F21F24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356B74A1D;
	Thu, 21 Mar 2024 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="SHgrL2VM"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244353A1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710984659; cv=none; b=sLgw+xlOw/johK0JOUCXyQYtDbHYohaig9t9U4E0D2lnWLZ1p7dZchYy6ZgIxWKZlbmwybKpQ19ZPzA5SzGlbz6ocXHDeg0ecnRWMC5DGmsjzDgqT1EsX8hWS00aYc9A+wOM3cxaSlkkjw14kDf2IAAPnd2K8ewfuMX6obQecEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710984659; c=relaxed/simple;
	bh=pV7ahaGIemw1j5hZGQAz0tCVo6kmDYrAEp6ydQuo+Sw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=kZAG+qNFFXmNcxDdx7kJ/QiW2R501vLFEUNfSyHyInSXd01vkOfbkeTp/FAV/O08TUeBi151jVKZnGith4h1KacLdMG7TjzFlnGuVKdrfzXXv1E9O1cWYnKuRGhUcdTmfjKq0psxZpVNjF8VceY7FXnQ/gGDDrDrNXhypq8xfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=SHgrL2VM; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710984652; bh=b8uiz9+V2+Fvh4SmZjLlpcxudpBHnV2ToDJ3AyZtqbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SHgrL2VMswmaPKWEEYMdYZ8bIeu8rBV0OSdG6FFI6Y4PGy4QK16OwtEEcIDyPyM9r
	 pXkxUYvkgN10Um7q7QjdptoZBIWhNUOWXyKWb++HAPzRdSoXtQumudLbqGvwCy3BoS
	 OthqpXqDA1uGWHd+8g+sCESzn2u9yaCfThMBngzY=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 7B2328B7; Thu, 21 Mar 2024 09:30:50 +0800
X-QQ-mid: xmsmtpt1710984650tjn4u6dp8
Message-ID: <tencent_164B6A74DD764D66063CFF36AE96A2372609@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntuj9WoC9EoF/opJBvcLydBwb/JqSz3mnFPSU+VzmNE5xe4oq4g9XE
	 mICwpG576FGyhrQxBowYHpQtoZ82ELs4fum83sB3wh1kXMfRdy9e/SUgYrtNgT80zVlmjcJggY4O
	 hUldqaFHBodAj7F3iQAysz43fEnwbwUzjDR5FnekJdYHN/MiOV2e3gK66mIjSR3F9IAsg9Qrk6xo
	 5/KwhWp/SGHjaoxKd81kMFTfHapQo1YDhEW63bcfmhV2kxG3QwTRQWIOsv2TMGq9yeu0BtYOeujM
	 BcfU+xK3QkRzDjl3C++VcVrjvxWWk3asfE41sZzoeQQV8yMINajUoX72vYiUvDtaXjdTSErXeGKS
	 bGxmFaMDE4n/mBHmUYGdhFp0zGrmv8/0gsHNk02zzCuCv/CWr/Iq86qz0huy2Jwz/UmJuNqUa+Bj
	 B/L8D7nUppt+d2DO33V27zEIllB4LqtcxdL3EIBZ5jy+PKHtSWyGr+E9DgCSA4ZjKJeOr/In4+vB
	 2SXynuOOE/3SE4DFg2OlZBScizYa3Zc59sscMrLNpNr+YW9+NMMnJ0mlWAlD9m1iJQieCS0LEuMN
	 ydStVj5dPzJNXvPezYWh8UNVJDxPoB2ojSaqgwVGkTwGRO2ufNCZr3/nyxjfB9XmhS/teWVo4evj
	 Lmt+4GDU8eQC5CT4qDUcSuQn4D8tWJf862Ki1SdifgMb/FY3m9NpivvQ86K2g3kkYgEmWoYOu4HX
	 Zd0yTKPPm/FxZfHhbkGQYc8xvSEIDEDAW53+36j+OYay12sjiCaxYX3ijqT8185LeeSjwgbi15fq
	 oeO7toR3Qrqe/Jt+DWrXY8cOlSs1vG5DecDEzKuzNbmSFkZs1g3vAKH9iBss/Ok+UJE9dfUO+win
	 LTWyvjmm8Lps/HWSDyVPi+IxYWtfKVOc43HN64lm+Ru+pI5+90/p/RY/Zm+nyGcMO1tthfvbUj2o
	 6TRqqHlqqIqwoLCxFUxDPGTb22x9TzFM+8h38MlaYTIZzlWMAOKoR1aStEtuNx
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+18840ef96e57b83b7fea@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave (4)
Date: Thu, 21 Mar 2024 09:30:51 +0800
X-OQ-MSGID: <20240321013050.1777046-2-eadavis@qq.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

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
 


