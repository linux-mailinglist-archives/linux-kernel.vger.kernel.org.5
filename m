Return-Path: <linux-kernel+bounces-132783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E1F899A18
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 962FDB23412
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1BA161914;
	Fri,  5 Apr 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Et5NeLrd"
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25CA161910
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310994; cv=none; b=JhbRvwJh5dkfAdNfBsLYz8ZeWe0yLJaVxTrRd+TYF6Sk8dD3wBDynXxsBk8K5gMvfNOA2GOdrgsShtPi/OvK7wX0oD5/NpjYW7T1D027K2JGi7ab/JA0wT9V1COahXpgjldLAfA0y+7XQv/2FzFkLJbgnuATVSI2HExzieFUAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310994; c=relaxed/simple;
	bh=ZUjt3cn6Jciw9Yzl+9UZycVqc/qXs9Q8GWj5hR5RLZ4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gXKiPhu19YtrY5bLKrv+1NPeyrDsYiArMa1LL4B00OEAR7AyBi0PYSd7y2or6wEdY7fzf1JzBR2jha5ORifpgC0R4ul1bKRcxnwWCadqTbkCFTVWGGI+QxujmzUFEvRglXXsPCtySuferwXGj8WjBFLGPVgGFhkOXrj9gM5wLos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Et5NeLrd; arc=none smtp.client-ip=203.205.251.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712310983; bh=37tWAJ0q0mR8nZCkCCUVBIS8KeNb1ZTR/arOTSOcqzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Et5NeLrdvj2hY+pZBny8nWD2wSW9gS9Tn4t7C9Ia8kcq7s8eQZU3i6+ZPauGanrBm
	 /tkpBBuCFp0oJQBQZqLUvX3HYV3biAApyIhRqxF8T16Ae6RvUPCezkCZ5JloJWedHC
	 GVnUrrLQViFL7Z4KMxqOzElO1AKFd70MxgpVYOzk=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id C94000B1; Fri, 05 Apr 2024 17:50:20 +0800
X-QQ-mid: xmsmtpt1712310620t154w0w6e
Message-ID: <tencent_C1E376696F23B004491777176886D9D37905@qq.com>
X-QQ-XMAILINFO: NnIX2CK8LSsJdzqollVvw54F7RWdteg4akgDllpDD41GdwuxkWGpgMHkitHGn6
	 Ls3l260F4J6G2f0cmrvAfOPBczHa65Ymt3pq5tno9aZLS1i/m2WIW6YUXWkEqS5t8wNxpoCtWqcs
	 +GloxPYYSjsiH5hQP9ga3gcy7nVkYKoc/8WGDh1X87Ie32oQR7LctFQRWv5xETYmYi9VAMYkMh+T
	 IUfIlV7v+GxFBtZuArls2qIYeXy76SrWEMg919t4DmcBsKCf22OvikD+srSHP5dzZoPtN2h0RAmo
	 dG210+e1fiBbASkBuFKIWEPswVBp+mTjQfH9G17qDqEByGWQD+8gATRqJdjQ0JzCBT+lD6q4eeJs
	 yU7KzwwychGgQT/MT2smIe61B2Iy17ws8nH2fa7/Z/bYGYzUGag5Gi7joVpfRnB2qUmwIxUIEg3b
	 pNTbQp5dRhq8EgINmqF8henVEI7YBxQZFsvBvG+5xPsQfjZ+iDHpcDuXALVfuK/ea5Pi3SNxT7Qx
	 O9Lre3XOUMEUYkPtkDmjUElx5KKCb4GucMN9J/IjzKuuLUfbyW2fOGS5J4a8vXZnJys6YNfELiCa
	 HSWQzPMvIRHtO4GPfyXKWLrkKCMwL9vQD1/w2DFsbPY+Wl3XfyIMBjXs5ON0P/QwV1B7wM8Y0f+o
	 8D0kE3midU64c4cq2q5/YveFwOGtdlNMMFIRXSoLbsGTQBlaxf5wDJGbTFNHN758oBWlIqBAtpGm
	 ksIYvKEt44tc1HYjZvtrJxZycdCLbcZ6lTV7kiNWWcgIBVs4vZfH0ZsNOEskvcyFVom3K8l36LrZ
	 9/+vjfWc/9NI89ySvJHJ9TQkgDBcs7dSeQbAD10NNwyll9qNLNKTWoCTc1LMpX9a7PnJqx7fGwM5
	 0v4VcS+RhrIV1KWQdKwDZqQkkaQwObr8Ur7a0/1xi57M3E2mhO31wreoLW5bZ95k4G2hiVlvE///
	 cQeraYKVoypCsnMoxoE1LpoNPD40mJDwuuyELiXF4YGXIDlxJM5XUSnSLelLGN
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8a1d152fba6b41f760ae@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in l2cap_sock_setsockopt
Date: Fri,  5 Apr 2024 17:50:20 +0800
X-OQ-MSGID: <20240405095019.538520-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b48cb0061553f087@google.com>
References: <000000000000b48cb0061553f087@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in rfcomm_sock_setsockopt

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fe46a7dd189e

diff --git a/net/socket.c b/net/socket.c
index e5f3af49a8b6..d5b2ab6c859c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2327,6 +2327,9 @@ int __sys_setsockopt(int fd, int level, int optname, char __user *user_optval,
 	int err, fput_needed;
 	struct socket *sock;
 
+	if (optlen < 4)
+		return -EINVAL;
+
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (!sock)
 		return err;


