Return-Path: <linux-kernel+bounces-57883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85DF984DE99
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 423FB284671
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C906E2BF;
	Thu,  8 Feb 2024 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ac6vJ6/s"
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A8C6D1CA;
	Thu,  8 Feb 2024 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389233; cv=none; b=ZFgf7Xz9SGb9Gwlh29JNHpr/ccgG2Jm+EYVz9WSqcBnTifC2uPHyubjpWO9FfJh8Soay9wwBClBNOmJOz585IbXQRw4vd+GFGdik4ST8+B57Wa6luUF7pmdxFCOAcALwQDliGLP6heyxwMwDuIXD22CbZrhjCdCdcGfBjQT2kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389233; c=relaxed/simple;
	bh=h7tpdDW4CcqCKn6XE4h5OZ+mpFGC6zQVQuoEeBaQ7bs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iSWZ0fA8h8abFlN3CZ9zKBZzbVjxjwnPh+ubGAbnyVDzRXjqAJCn8Js2rjwyzrQfZeJ5BgL8ZvuZ+0MELtAeWn6IxkAzyfTxvTpC5V2OENaTzyXgVny58xZ+7TDKSXNKfJ/G4XOmIaPPRJjj55IqXgOaDKz4k9SLA1+ki96CY08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ac6vJ6/s; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707389218; bh=hcbbJhAls5Uesp7NyjBSOyZ/XNieAhW/QJoPzNlPnlQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ac6vJ6/sCj8BTEThK4epPx9UY1M539mgYjxNZeZLBmCAJXTI2kxgox85oxT6Dk8Th
	 wvOsO5koDxJl9IgHxzXdKZ3h2+1RcgO29os9V2lhvZr22/3Miqpef/K7ypv2xj15Gl
	 0JwDH8DJjhbQXI7PaWILj5gT13DixyDTIimvINik=
Received: from pek-lxu-l1.wrs.com ([117.61.184.234])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id BB7060B2; Thu, 08 Feb 2024 18:46:55 +0800
X-QQ-mid: xmsmtpt1707389215tzz8xjd5x
Message-ID: <tencent_AF9E941B3D4BEF1B2625D4BA18BBDA332108@qq.com>
X-QQ-XMAILINFO: OG0c0cMNDXpT/PABBA6BB72RIf0nVSzum1KsQAwIrzegiKAVPbaEAo0EP8zB5O
	 j11mS800jDnC53o4K1MxB1EwZHZL+dKnHTHScDmIuOtCyH0fTAd5tOsvte1bGE7iA9B4AzmeiHBw
	 263vSIt3ZMrTfjhjo8i0grrzCPzhCfe/5pzWLgva+0fTIVNk3n7vY+919WjSxbU73yjX1mf/kx3x
	 Tnp/lEN7NtFo79eQcJv+KYdFl+CypOiuuSMhkjXqXGLgK2E12GhZqJmAsH5yfBygYW57QCknmA+R
	 G5JtVoXkJQ0jFNAd51SW7cZtebBV6zpeUBXFmS8sRd8ILo2I2UxJ/GMaMdrgks9SNRYkULS3/vL7
	 vipOxx6B8onz9GPZhfpAvkedCHj0YCSmbTNFzzqb11XUNrHOt2Tg6QmogUw/lkIelwkVhtxRQNQC
	 8rsJ0oE70dfDiBEsA76N1AiXwEtoiGkm54k+liMJzcoQDIKXN0sQ/xHEA2AY0MU007GpoYIEi3Nu
	 iqQcXXmrmi8Jf+Rq+Q5pewdbbTCycy29SvqxsDvUqI1EzdLt1l1MrzqQ43WCCVWnI2cKogLwAs/7
	 N6T7zZZKaxtO4/iwkntrQCgMIzSrE6vXPL+6vblb4MqB7gNVrXoqjiU5l1CTlEb1Fq717LlI7vKn
	 lckAJBO6nomDL+nyWaXFgbrK7BXWvbbZIPEDhD9WtSvcb2Tb5aC5Gmhc0aShJ0MAxl6LWXVPUfD6
	 lowP1P/TJdrjdL/0SHFvujr2eXeYqT/pcdBDr5tWTH82sSF+vho4J2lAB9i2I6FIB3Sp4fLndRY4
	 I9hxllZgp5iPOyZi1iLRf+1krkTOKLZJrF3+rhBBn5N5Pjhgq0fLDqSPsjmqTmtwG6+YNL5zBXtm
	 GlL7YSG90usv4QEhWyyTtcI2gk7/A8cRoQYZtUqcYGQrSr/nI7n7XM877A4w4CiA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com
Cc: gregkh@linuxfoundation.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	rafael@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH riscv64] kobject: fix WARNING in input_register_device
Date: Thu,  8 Feb 2024 18:46:55 +0800
X-OQ-MSGID: <20240208104654.3757719-2-eadavis@qq.com>
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

The input_add_uevent_modalias_var()->input_print_modalias() will add 1684 bytes
of data to env, which will result in insufficient memory allocated to the buf 
members of env.

Reported-and-tested-by: syzbot+8e41bb0c055b209ebbf4@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 include/linux/kobject.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.43.0


