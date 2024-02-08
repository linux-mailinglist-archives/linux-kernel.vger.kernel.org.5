Return-Path: <linux-kernel+bounces-57709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0055384DCA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F2E1F25096
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6D66BFA6;
	Thu,  8 Feb 2024 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qp3HMjv/"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA56BB3E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383851; cv=none; b=OLDBUm9sGc9YSABYxlJWGOuU/wqofKsanknBHAuCpcPJRNlFs6CwUy4QUDVAwLrfRU5M50lTGiT7fRDhUZpoHNqGWOn6C/kFNfhSxGoeSrlE3rJdLrpVGHTDkV5hSdTptf+pmdlywYrlYJM+rmXQ6pmLCZWii4RESxNdpH1IDCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383851; c=relaxed/simple;
	bh=jl1qFn7KygfZP7XYH22ByoKZ29rrLk8m8y9vBun5BHY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LGaRIOjBs3jAuBcomuEGSXvfEXa1GUSqrKc5V9NCd7e4+sZkSFL6/knrUZsmqbnHLBOj6DJde/ZQ/EQAwX3SkC6xlDnscXb+b2RXfa2HQn8SY1TwTKpbLi6BPWHkr1dR5RB45APdG6vzBHDohy82QfMknC+DCjcmVsChok+GaIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qp3HMjv/; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707383840; bh=KgD99Zm00rPH/pUVtHezKrRTRH7/qWomVrVQedM9/E0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qp3HMjv/c/iEGphtLTRRY47Lz6dCTR0H7iz8BvMYnOR+rN4nCC5M7mbglntK1V5Or
	 xmUjI03KYrM7M/oT0PC9de15zhP7FrOQlyl/LLKqvKvjFqi+5fexJyVMELnhvCJOyR
	 xUMJDmcI3FgvF46jYSkWfNO0c3MYqUw7GW+EflaQ=
Received: from pek-lxu-l1.wrs.com ([117.61.184.234])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id E333D057; Thu, 08 Feb 2024 16:56:51 +0800
X-QQ-mid: xmsmtpt1707382611tdkfr7iz1
Message-ID: <tencent_E9DD8E5D8799084FFF8DBA25EC0D84921407@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2HboevtdY5IQaJqgvOoXehTYjJvo1eNu1tXQGPZL+GV6A4iO1Dz
	 XoXhfH6UlMjkteJKBmyOFDIvyzXyAqpTyO4QNP/0yPehqgB2U+MVJzGlKf7U6V9ldyyCw4Urf6f+
	 zIMHAQRqUwKPhqasj4Fj95gLRzsrjBAPovV0XeFXf0IBWOuVkvmk7DwmLWr7bVGZTAr2g5zfa4QR
	 vpfXw1bvJfizOrXfKIn2LI458PMROaBW5sLTOfIE9pcYtUdOjW0O82PjWqwj1jo0J1Uu7CNUegrs
	 26IPJcpb1oh1Aj4Ugo5JyKqmiyz39yEI4TXc823LB8HIX/Vl+tKqLJajSggfGP87ADAk9WwMfhLU
	 l5g0diAHDBtG4qB2FFuTgRPpe+g1fpwDoO2i/gmk+9wdLaHiWy7YQMaz7JmLDDoIgQQYWdZIuCNb
	 6ZQgaGnARhz8EVHORd+pysFRUkflh+aZorFg/apqSPDG7SZLfvsI23HqXjMAtT65L1BWm4nDRN/M
	 +AeH12sGMbgWVSLNuNkpL0QhJh6Obpa4ADZv+21FM3Gi0DO76fEVmxlcOlm6uctrw0IgGVaZsDzM
	 8UlGJfcla2e8r6sjr8rN1SsCtX9+zXigByo6gm6MGgTOO+ym1WtlprPRCsHPECY24VUS/mhPRP/W
	 6gxsCAC961zCc3NdcvoC5SFHLv7TFlbqviYCQ3iCx8izoOmU/WmHlbrKHa28qnallgfgNxFhj8EG
	 ASxATc32Sh4AY9VoDXtTw6h6ECor4doGSUW3Gez1ixIEYoEI4KjsFgJpyXWKO3liuwwkqGn3lSbU
	 2SF3FkJCvInOoPNmdux1begVOYHKDt5hfbmGjTPTADUeVVE2T8nmoedRC+yqY7M6JbeO0IlQA3Kh
	 I3OKF1HCJCIYfja6iw/JkBAUdjq6kkD0Jm/TpOPgBIQEiG7xYLU1p4WpfKF2pR5A==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] [usb?] WARNING in input_register_device (2)
Date: Thu,  8 Feb 2024 16:56:51 +0800
X-OQ-MSGID: <20240208085650.3654140-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000047631d0610d010c1@google.com>
References: <00000000000047631d0610d010c1@google.com>
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
+#define UEVENT_BUFFER_SIZE		2560	/* buffer for the variables */
 
 #ifdef CONFIG_UEVENT_HELPER
 /* path to the userspace helper executed on an event */


