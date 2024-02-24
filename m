Return-Path: <linux-kernel+bounces-79422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C6C8621DD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 02:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B121F28C9D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EFC28E6;
	Sat, 24 Feb 2024 01:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="u2bcv4Cx"
Received: from out203-205-251-36.mail.qq.com (out203-205-251-36.mail.qq.com [203.205.251.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A87F23BE
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708737693; cv=none; b=cQDQEkPgtBRUzI9ZOEX8NlHE9YNGUObnO1TgxqY96+hR00ehwcsY3r+j/zS+BsiVlVVK2TSftusktIUkejejPjEgg1nfsg2BomC0djK0xuizuOXZI9ZAhcECPjr4Qm/Df5LKsdNmV3VpjRZW/dTLonrnYCjO8UP+Ir6qzVhKs9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708737693; c=relaxed/simple;
	bh=lQHum842ZiJ11WcxLIyoPovfM/sYZCRJhOpfMhbf0JM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cBIsC+IBa1TGm8NDIuwFBUjrFDju02QEOc1+L0SAacogSxffFGQzVLasvfZNExmIp8g+yurf2anZaWmlCGHakl8fDhOpfjhjri+YSUecNxlAjkzI12p5cNNivHsGkbKEq6oIS5gS2b3NRT1wr4XXnDxINfRnGkYL7MRACTHTfmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=u2bcv4Cx; arc=none smtp.client-ip=203.205.251.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708737688; bh=U8KCGo4OAHr5PdN2Uyr5UVkoKqEVQ812FFm5kCyp8f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u2bcv4CxkdBw/lECmZQ8+rKxN6w1ZxUMhG3nfEElBg2jGfEaoiNLYbCggGp5gqj8Z
	 W2PQSKdg4jcmT3Pr5ESZ9BTfFfkr4mhnG568Dl7A1zV1iMpE0sWEqbUaRHvLa5Em9L
	 PV9UzWxcPMdMt27fI0MYT35HwaxPfieBcVkTGGhE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 55A9B81F; Sat, 24 Feb 2024 09:21:26 +0800
X-QQ-mid: xmsmtpt1708737686twpodfs9c
Message-ID: <tencent_9FD786C5D2F74645C989AECE6EF64CA52706@qq.com>
X-QQ-XMAILINFO: Mhz1vieqgy7F3/9ZT+JrZ6MOH+yCucpEzJiSwr2IVkcnhwfmjz3DuySljeFvMk
	 CU81Y3CkjnzJYrKUYDsUQX0eLcyacWy38JeTs02j2CoWWgMlJvns0x/QtIkAuZBmYD4QqOMFEHb2
	 UwhF9zGphX3PnM9zpfueth3b194BP7abDSYuvig/9y2FHmo3PQVd1lWbh53xLP551g7ZV1a/UeaH
	 JssTA+TnmNWubELVry4/euyk2vSvypKSnSHtdFk1cOC3YrWHMycdnsVgdVdwwE7M0OFXNuOMkdlM
	 iEZeUunGqLNB2fBZk8/Zjl6FoGx6XTqA4rMYnmIW23DNqhVFKCisQKvs+KpncGu956s2ykY8i6YB
	 UjsFnOAK87dOdS7wLh+saPdXnfDtUuqntKP+gL6te0FvjJ1YEpXwK8aH92F72z3TBFt/KW6v9/5n
	 TwPmgESENjc8vwD1CuPzcgeDFYaPi+/6dl1yDGMUAP4i/vXeQAJeauKiYUsu+WHaD4VhGEtfzOes
	 ylOSjYV/7cEGFgbPPam6L5RCn9emsZ1zgtSQhLMHY8Mch4B9h4+8YGfNFRSY1/LTLQRrS4lHs2vJ
	 PMpataQNhi6QWyYAMqrp5kx88IvfW7TvrI8xzaQLwqP2XLfp7c98mQpeabWNq/ixtNZJkGdYlgxP
	 dP31SMpVM4dZumSnYvg7fVLlrNWn6HI7T4xnMT4g3bAAIv4ijbyxpJlcBvTItKga2LQUebxgUWaI
	 mlPnz7Ck//OZFq2qjgGWqUN/odGXJhO7NMr2TAgA94AXPIsx9/IUCv+Pp4hqOF3lxGzlLq6XPT+A
	 jR/ybYIQl8qYW+RI2Upyg/Fd8ltauai03MAPTWxK1Bu9j64LejdqSiMCOdSA9lHxls3Wwl6dkBXU
	 z0WXsgU7ixRGpyH9zfkSJifhag0MnuolYpe91GQzprok0iegaQAsycNw0L5AMpYg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+617f4ccb03b9869f6494@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] [input?] WARNING in input_unregister_device (2)
Date: Sat, 24 Feb 2024 09:21:27 +0800
X-OQ-MSGID: <20240224012126.2634093-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000008b34440611929e64@google.com>
References: <0000000000008b34440611929e64@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index c30affcc43b4..74b37b6459cd 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -30,7 +30,7 @@
 
 #define UEVENT_HELPER_PATH_LEN		256
 #define UEVENT_NUM_ENVP			64	/* number of env pointers */
-#define UEVENT_BUFFER_SIZE		2048	/* buffer for the variables */
+#define UEVENT_BUFFER_SIZE		2304	/* buffer for the variables */
 
 #ifdef CONFIG_UEVENT_HELPER
 /* path to the userspace helper executed on an event */


