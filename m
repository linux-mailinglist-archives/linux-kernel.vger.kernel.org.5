Return-Path: <linux-kernel+bounces-74889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C19385DF4C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C193A1F21BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6467C6C0;
	Wed, 21 Feb 2024 14:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="a6Z0xQtB"
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C744C62;
	Wed, 21 Feb 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525592; cv=none; b=RqPX1asokhiRl0S34IzWCIiKYno0zVryM9H2BL5Ij8fgA7DuqDz5J8z5jgszKVoOqVrn18X0MJuj63YVTvGaIyQPt9LPDaHivgv99Bxdhz5s3wiPpcBKcF89ro87zp6PdIqiVEXnbG0D19qxaAoNFqelqEV2/perfNKmS8VnSBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525592; c=relaxed/simple;
	bh=v11Pc7CIFtiDJvtTdFEr5KXDbTe1sppjg1bvGaMcSho=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OsTodSaHXhyT8t2XlcGbOdMEi3fO4zVjFREu9pDag7TC2gcH9Y/MYnVSPBbalF9YoLH8304RDja96fioK42crz9TUGarywvyhprlq3xlqjpMIyEahLf1mbujkNKhyYfgc2sczJBcBzba0JTc9yrAyvha9SpOOnyw+Y4iJz2gz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=a6Z0xQtB; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708525581; bh=pj6LoP7IKnvmbi/dGc8hKKjxVKAxUr0Pi1wWsmEFVu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a6Z0xQtBUzux2mkhM+3ZTBkc7GG9xTbe5w9a3P5Qj9eONYB9lhI+lZ/8y/Xfi10We
	 qC6QKRn0J675XN+M7FRePWYQjtl3gFQuh4XGUkXL7lTKCVGc/wkjvKJMi08Mh7kVZ9
	 M2MHha0CiKjnwuMDuJsIXwyEl7LofK3onaR3rf7M=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 50418A1B; Wed, 21 Feb 2024 22:20:04 +0800
X-QQ-mid: xmsmtpt1708525204t0xgoj2qr
Message-ID: <tencent_941B48254CBA00BB4933069E391B6E4B5408@qq.com>
X-QQ-XMAILINFO: M3ziZXKDk+iOt7Y7H7kR7VuOyouwPtJP/BqzCiDi509G429y8WTRXNEwOEy1HQ
	 KNti5PBaUD73kBsZTMmNaElFH/FiHZ8JaXm+T+38IpASlsWsBNyeBArNa0Pr9w04+SKoRbN8beoy
	 23SB0wvVYLyQLj6gla93Y5kiUbMbv7jXhifKWb6o5zAZe0Df9dhrmcfq29TyvPfz9uyaR//JS8q/
	 WNEB/BotOa/knSUCMDx2B4PX+01xpCsrdA8an0jr8Ien++5gph+y/FMQnTZu0wRYt463ZHjvj+A+
	 4DIbuzCmwlMRS/KF63NEa+5bbh1K6jvCNxYlVJqavgUGa2yge7kHc4gbsb4kNng6xd+78e08Z4QI
	 ZL++SU+WugkOqsPYHguh4yae5/rpUx8ZMgjIppocoljZEpVBlbgd81cbDl88EaciZeJ/iJyS7UNV
	 r0l/AxBa41EJbikFa8R/HTaBis4EHY8BTWSXep2UQmwvOTijwhRK+fCVQetq9TiwVqAj8p4ky32i
	 K3a1ase94OZEsUrCxVyRmXvvLeaTxggMKL+z0ZwS1lBNWM4g72RTyriOr8mKCX4QOchd/auaOk4V
	 AqYX46h4esToenJvpwS3vsKhUsIxOh5j7ytb6iUhrX+GTdCXrsFIKnS2dr/UdFYHrzp69rKAI3ny
	 8IFy7aXOxMuppn94MNIc6HLgmaJMMn5+MJNPn0qNnc20m6iRhAAZJcsU0Q/lI4B6mrEzvLhaE/st
	 ZJEpe8P58ktoFFCsC6uhDxo9D88FpBoaRo8F9RvOLZssOFRZVBGDhbiefKCQfcjgf26KBEPDyx3C
	 ZrryfrzthXJ+lBmlAXevgjnkfrYIU5+YGxNKkK2qLXXQC7SgTB+niI00IUuB3amn4uHHHIpkR2bs
	 fzCgWRjzOCVh+N9KheWwLoENBaZN1hLFlmY2RPwXDGTGHQ7P00VcA=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com
Cc: hverkuil-cisco@xs4all.nl,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] media/cec/core: fix task hung in cec_claim_log_addrs
Date: Wed, 21 Feb 2024 22:20:05 +0800
X-OQ-MSGID: <20240221142004.159200-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000006d96200611de3986@google.com>
References: <0000000000006d96200611de3986@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After unlocking adap->lock in cec_claim_log_addrs(), cec_claim_log_addrs() may
re-enter, causing this issue to occur.

In the thread function cec_config_thread_func() adap->lock is also used, so there
is no need to unlock adap->lock in cec_claim_log_addrs(), and then use adap->lock
in cec_config_thread_func() to protect.

Reported-and-tested-by: syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/media/cec/core/cec-adap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 5741adf09a2e..21b3ff504524 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1436,7 +1436,6 @@ static int cec_config_thread_func(void *arg)
 	int err;
 	int i, j;
 
-	mutex_lock(&adap->lock);
 	dprintk(1, "physical address: %x.%x.%x.%x, claim %d logical addresses\n",
 		cec_phys_addr_exp(adap->phys_addr), las->num_log_addrs);
 	las->log_addr_mask = 0;
@@ -1565,7 +1564,6 @@ static int cec_config_thread_func(void *arg)
 	}
 	adap->kthread_config = NULL;
 	complete(&adap->config_completion);
-	mutex_unlock(&adap->lock);
 	call_void_op(adap, configured);
 	return 0;
 
@@ -1577,7 +1575,6 @@ static int cec_config_thread_func(void *arg)
 	adap->must_reconfigure = false;
 	adap->kthread_config = NULL;
 	complete(&adap->config_completion);
-	mutex_unlock(&adap->lock);
 	return 0;
 }
 
@@ -1602,9 +1599,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 		adap->kthread_config = NULL;
 		adap->is_configuring = false;
 	} else if (block) {
-		mutex_unlock(&adap->lock);
 		wait_for_completion(&adap->config_completion);
-		mutex_lock(&adap->lock);
 	}
 }
 
-- 
2.43.0


