Return-Path: <linux-kernel+bounces-109618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEB6881B6E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62F01C215B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B879C0;
	Thu, 21 Mar 2024 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JT/sppwU"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405381C05
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710991135; cv=none; b=r9EQmxT5pZOz5XFBBYQYWQUS3fV9/7VLoO7IK3lLp2uKx6UuCHp80d6rg7M4+JlyXEjbqp05u49sjgGUuPpr3rxn8q1DYLzoYApBicIUzUzm7ZABavIjVE2QRpkgPAQSXK2AGka/qMqIg+mkZv+hG7a3rv3vGvxcs1bXsBbE6SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710991135; c=relaxed/simple;
	bh=GzSDKQhiRCQSt0L09OfmSYnjlXAOvmpt8J1zOXRAbyk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=N+lIBnfJieMYHGgDg2LVSEsYsw75EUFn3eH1JxGNfFn3GFXYfkWsbFWRblkDN/4icaBJzbTspfZfvcN/jbQC1Suj8hLVctWHS9yTAKWBNHkfpVENzwWp7bfpWZ5cWEyo50AQzpZAa/edNloYShdADH/YqlyN8Gz6yhWplD/yhUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JT/sppwU; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710991123; bh=8m/CAoX3eEJt7qH5krqwbAsWAww+IK1kpegYgkGAcOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JT/sppwUNCEHJjKil//r2ksy8E06Pkipapw9rLPxtXcIDxrptv52a172y7F3337Bw
	 ODvH+9uY9TPCVeQ/pYmN7LT15z5nVq+VCYoCCQsHHctNTRE5SztLgG+TANFPJWCGMT
	 WH2hJ5k6zWULBjOK4sqTWfGCZdDRkdzwlIqG55Hs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 4A9236EB; Thu, 21 Mar 2024 11:18:41 +0800
X-QQ-mid: xmsmtpt1710991121tnvyk21kg
Message-ID: <tencent_3436E64BE674C577BF66883D6937C4979409@qq.com>
X-QQ-XMAILINFO: M5WvXNp9ZPrQqp2hrqdfAOiKfuaGMJkB2PvE4B1HNqQsKwGf753UnOcJSDG9kA
	 uOPl2wzgpG73FxU8/MqHm9uYG2PXc/s85BLy0AopL4vcsHayhjalgPMrgCYf+NfDz+V7S88iwrCw
	 LsEpP9bH1NbnFKVeFzzQNdSuFcmcrjaUfuEF4S4s2C+J+icl8zCEfv83ABpjV6UaDbpplplQSF0p
	 /aiifv5bImiJYEeYTr7EXYCHvxpZ7ckJ2KQ2Ohjl60bIJmqPRSSxqDPWK/osK1zB49KAvaRQCLeS
	 u/7mVOMYft9nSRd1ztZcPWYg4ZFjiE0I8WDThDLHakN/MG4pnnf8EnfdK0giUsXWXkkfAhlETGNT
	 cAxF4gK3HUMSkUd+lrqR3v5DdLI38CnYYnhMOPEf6BTULvknObqoVGukwVk7s7qFYFrOa6ccLn69
	 iwlkSIO7LWs/fp+5DQhUTdtfRmUdZn0iTSpMEA4Ji/K+AyhFBcMB+XKOeqqSyQYdW7O9hs2CjYDb
	 A0q1bDiVSU+rTB1fYk52cBQRoXnx4JiNfveeaOawTv6d8mQfpxLm+Ii+JwKYaC5lXiODQixUiWyB
	 B5ZeMiUuWCniYG2xQRmAHPYJfRdpxbZekeSdHEJi0cB74FNxYRa/0qQTLaykMPz+JyB820F4GD+c
	 QObqN+q4q4fjSlz06hqfuLp+6+lobOfNfwAQosoo23TMmXd5wUGdnlWIlxUvbpPMCwlL23bKmguK
	 wEdvc8vhSo8V45SYtix1c2T7GxRB79iUcQBfB09oLOfut1Rp11h6U7NVRbS8pVrylAiS/2IHCanu
	 j0MYVahTDQRq7bSLgspwI8r6EzD+pRtNO0sGqSUTSeUbyDE4sPg8HpThwKbOReBqnAnaUt9hJS2h
	 EJyJNOvVAUrB68stB4KEtcZy/E8xpLKcZuYFN7akbRTJfL0Uwo7ncR7k1l4mTyv+46kI3zO5e/RT
	 /5H+xJQPnOnQSvMhHx/9A6MxxAVBAMUg0KduNxlSwWFQf2C8/qQSnOkN9CSoQfxjmQvFKmKO3DfR
	 /1oxfKspiWpl0tUh22
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] [usb?] UBSAN: array-index-out-of-bounds in htc_issue_send
Date: Thu, 21 Mar 2024 11:18:42 +0800
X-OQ-MSGID: <20240321031841.1890167-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004e41110614187d35@google.com>
References: <0000000000004e41110614187d35@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in htc_issue_send

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing

diff --git a/drivers/net/wireless/ath/ath9k/htc_hst.c b/drivers/net/wireless/ath/ath9k/htc_hst.c
index eb631fd3336d..0d1115d1cc29 100644
--- a/drivers/net/wireless/ath/ath9k/htc_hst.c
+++ b/drivers/net/wireless/ath/ath9k/htc_hst.c
@@ -295,6 +295,9 @@ int htc_connect_service(struct htc_target *target,
 	}
 
 	*conn_rsp_epid = target->conn_rsp_epid;
+	if (*conn_rsp_epid < 0 || *conn_rsp_epid > ENDPOINT_MAX)
+		return -EINVAL;
+
 	return 0;
 err:
 	kfree_skb(skb);


