Return-Path: <linux-kernel+bounces-144080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CC78A4193
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC24B20C82
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8E923748;
	Sun, 14 Apr 2024 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Szs7QEzZ"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01E21A19
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713087929; cv=none; b=ASWsPBSoiCgDec9S3lIQFk4Qo9urPlewdQZw3tGmytooC+ySpvLkm0dYlVuWrD//x4pvascHfxns8xFHmczykuIwhdVLMGYpthuoCl2vaZJpPooXNTbEJc7MwvtIE1c0xol4PcyGnS+sfvKvj+EluDQ3Dm9po/8tgGo5ayTZWXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713087929; c=relaxed/simple;
	bh=d30nl4nIOk7QCjr7rxh35Y3Dnn/pOgAVaCTbU/MJVJA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TICJB2gpoAR70DTZqH/U1Z4Dvoz6ISzSkX6avI206ZNTWoR4k7LbcKDmhKjM7jjFwD406NHfANTriZRozg2ku6CHQvijulYdp5yH2Fd/bSBXsgpYffjaIWB2uOqRBX7mmY2dSJpKDW4d3NLRhoZiKhcW5kfRfedDUyEebkCyeXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Szs7QEzZ; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713087923; bh=oldp38px2CRIjYnDgK0jCfl97syqalqHdW/5zLyqYEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Szs7QEzZzFt0iCCemIQGaSs2cV5AC/F03uqEqGjPF2zE9RNY3MsOnuJra+GwKqSZH
	 cv1zX/LdUDtqHTghp0E3PKmpH+FoY4DSDypj7ab66+jpPjAG1jV7G4DzWFLmiD5gtP
	 YNqKse2hyBTNIlhEltQOoQXyofhQcHEsmM9DB4F4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id B550F293; Sun, 14 Apr 2024 17:45:21 +0800
X-QQ-mid: xmsmtpt1713087921tl5o8i5gs
Message-ID: <tencent_555E4AEA752577B167583CAB36B696FC3709@qq.com>
X-QQ-XMAILINFO: Nl0S2HjMbZsFBcsVnSgfbGCcDZJH+fKY0vPn0YMNcIdtxGkRH5p4Luy4Rj8XtZ
	 5xBE37D1YjeMHvjJFcFLnaZ3q+2p+VvRGHbP1t80vcC1+EA5sKRcHZoKJcTFyFLZR/SHWelPE3A0
	 GrhGalZgSbdGAMLu7+/1gZtkjQYtA9Tk3F8iXE/CghuDdzBJvqeW1Kz3NV3ppWkw9n6wOjBcfHEA
	 TYive+EUIZ+r18eyA5DnZKC19MyjxrwduVfi6kuNBKcqQiLWJBttd9u5NtjkjVdNy76goXYnqzz8
	 M1Tz0lRdz3jwOuViQ68O/OQ1U6RPR6lC7MQwj/kx3IqZUUWsMqJkZLfWFmpfKAqxEktabAZw18YQ
	 fwil50Wn4pVjcl0vamcR9lqd3U+8D2Vh3sCg2EgN7KWgmzqUlHYHM/eyG4EaZd2of3yDfN7R3DGw
	 pWyL3FRQqMCyc4xxtvOO+T6f8Lwr2d64s3gql2YJqWlM7vmKxBhRbUEdwrOAVvHGRRrcuSQ49JXv
	 2mwF2NlEVbUJZU7bjqudVGMPXxkAFN//cFD71TPlM9F4CbQyoFP2zw1N399Ib5teKSk9siILE3bW
	 JWYuO+w/8RtNwRzK6SKZnRXKlcq1870jq6VH8vM03CxEB5vpVf0F6WXyOgW9kHsFTn44xvxrCNEJ
	 fCXtazLzY0JRvFVye6HyuDYuJ4wO5Z94HbtcFl2qJDvgVaJBxMHEiLx8CLLLWQtsvWCXAm5AU4jt
	 lgXDEGmnD9GbeSF/sTCOA8jO7owEmDLpPfxcTe3D4MQM+haLfGBUEbR0I3dnyZTLVEce4/JLQitS
	 gVGHsSHHWwKJ2vTkp1n+sGtti/AfiHZ87RouZouUQuErmLve7/mIpNNsR4dagVOa+eQ2CXjPF1vX
	 AX6asCaYnPdYtO0ZlzMm8+zAbPmJGP9uy+eYCdS4R3e01nkrd4g57EbYf4jBPlgegw//QrAhc9Xz
	 c0F++hjAW6Z5PoFl+fPpqBwmKaTfEL/JXjH7W1Ee/QSBIPp73JxA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8933e1c7c07fe8f2dcd3@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] inconsistent lock state in snd_hrtimer_callback (2)
Date: Sun, 14 Apr 2024 17:45:22 +0800
X-OQ-MSGID: <20240414094521.3492372-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000000b0bf30616069d1e@google.com>
References: <0000000000000b0bf30616069d1e@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test dl in snd_hrtimer_callback

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
 


