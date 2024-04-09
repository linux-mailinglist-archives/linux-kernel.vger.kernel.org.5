Return-Path: <linux-kernel+bounces-136861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EC989D921
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9103E281ED5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F3012D744;
	Tue,  9 Apr 2024 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TED4AZaz"
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7C512A14A;
	Tue,  9 Apr 2024 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712665270; cv=none; b=jBy7s7ECE3lmwFx2FQrcK63/szidOfA53bK8wVht6wWuEnwTPIxwvtcB4UtGn5KUAA2nqZGFqcrwQCk0TX41ATMc4If6nrCFMDcXeqi+1fD7VLmQHPuU6ruom7GXdLfP5c7sufhTBQ9tLaISowlsuf2xUR2tqbpxpCc/al/o0to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712665270; c=relaxed/simple;
	bh=jrEVmurNChR635/98zUzfrOEmqHwm6pz2Gs4BB4fM/U=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=awbG4Oshwxl7s0iU8L4+Zxrc7HRkSlgaZ0TR+eSWqs07nSReEXauQul+2WKQM9HoI9SAoLrgxC1o0h5xrdC3QTfzBz2V35Z3pZA8rkGkStICp3/NRW+ynQRl/vpXEDcnIThR2o4qhpWZcvzD7w7sz8V8UKmPA/nNXhuqYymQCVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TED4AZaz; arc=none smtp.client-ip=203.205.251.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712664955; bh=m7LPkZgpaLXkeV+NlINHfY4LTk6VgwNuhgIGOECBU/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TED4AZazadVmz02KoBj9mLpeTYvnEHFfTP8iTBVACg688gtmXlteo8M91K0WkE+1Q
	 HWJcFy6mPs5O4JW98HZ3BMbR/ipDkp6DCjlFF9pbDzaHxqcToYINQvLGeaMC6jQyoE
	 qYUmdJoqByqDc3557fBAie9tqG3UxI1SlqsNIxyk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id 3F42CEE6; Tue, 09 Apr 2024 20:15:52 +0800
X-QQ-mid: xmsmtpt1712664952t56msp9an
Message-ID: <tencent_15CA920ADD9ADDCA19654FBE8DB5A5B88D07@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70cja9QE9nCnfHiWUrmFrx6SyJ6zXMlwqNTeLWeP3YgIknp56w7q
	 JaCfxar0ZIijJg+R38JDABsQpREo2ny8FmA++eunPiHn3wd1f9X+DN8NieKe4181Uwdrv7STZfCx
	 mUySDtHLdAAJS5IWMVWyrgJCKOwL7Kz5liwDAjE2t9lleBP39qER6ARP9Z2JUnQ1moUl5IrGyMs6
	 VRk1ZSyJ0iZJyBD/YSKnyH+1HgHN2XSOvn3lDh2BLVWhSMLq2WlNnKaBZgwQ0wy/yVxK3nFFbGZa
	 CcF0VY0Siw7kGhHQunsrWl+nM+60zyXMuMaHSC9sPLVGO5qjKJpqhQZmCBoXqqSKJaQH3kT5ZTHH
	 m5Gx2u3MTuG8pSQ3Zp9DObbouzrPBO9Yz+uFFPcn01lywH3f6WCNnHMfyIx0IsF+A1oHthWKi3oq
	 53gYYu5kSTJfZG7C+3vtkn4eLKzpWj2Adt/si0TLhweklUBDS5CN0RyBVPa1Z6ZmcVuFbmJpb0MT
	 FL5tsQylDQ3F6mI1Sw6fQhFpT1GgUR66E5KA68Z2rPXFYRDM0TjGDu/CEm80Ld21reoYvT1g4vS+
	 qMM0QJz2vD7omVG3R/rfud8vZ7UqpbN++6/+bS3bV1v17oGN1Kb1XkxmP1svc8J0iFH6oxNgEc9c
	 zLtcMEK4rd34V6ATnDbgkUz1YRXxJVhRwPwMyxetq/eW458H84yXR5x70J6cr0D5fnmR3/c6Mv2r
	 opl4LEHypk/XtdvCAaQIUDq/BM/Afqk+38Y1JsJyq9+r/8oWxbIy+Raqrt1o3HynpC9wsaH9tgfK
	 83TiVjxXNbURyLp1ilnPGyWm8Yw1slm8si/t18J0M/GU4Bo9/FZxYG9w/uv5p6PHCNOYNEgKd7/T
	 vImOuyCNyJrgmBRDiX/UZBTE62Pk1RYBDuMPDFlG154/z0la5/K85nJIs1KDkqp0+qzRBO8t5yKJ
	 NEQVpHh+MzkQ5CzIgRSU7666VU04hT0suaGsGCCZ4QJGe5GwvdKj74yd6JoDxcz4Dkw7VG6lw=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: pmenzel@molgen.mpg.de
Cc: netdev@vger.kernel.org,
	eadavis@qq.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] net/socket: Ensure length of input socket option param >= sizeof(int)
Date: Tue,  9 Apr 2024 20:15:53 +0800
X-OQ-MSGID: <20240409121552.4098965-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <234da60a-709f-4430-b594-386b7c2b65f5@molgen.mpg.de>
References: <234da60a-709f-4430-b594-386b7c2b65f5@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The optlen value passed by syzbot to _sys_setsockopt() is 2, which results in
only 2 bytes being allocated when allocating memory to kernel_optval, and the
optval size passed when calling the function copy_from_sockptr() is 4 bytes.
Here, optlen is determined uniformly in the entry function __sys_setsockopt(). 
If its value is less than 4, the parameter is considered invalid.

Reported-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
Reported-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com
Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/socket.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index e5f3af49a8b6..ac8fd4f6ebfe 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2327,6 +2327,9 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 	int err, fput_needed;
 	struct socket *sock;
 
+	if (optlen < sizeof(int))
+		return -EINVAL;
+
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (!sock)
 		return err;
-- 
2.43.0


