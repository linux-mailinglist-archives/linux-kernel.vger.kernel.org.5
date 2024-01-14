Return-Path: <linux-kernel+bounces-25413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087FE82CFF1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 08:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2481C1C20DDB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 07:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DAE186A;
	Sun, 14 Jan 2024 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rfMjmtNg"
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E5A1851
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705218233; bh=g4HSzc2M0ny/+L0szdplZvYETEz+7h4AeVQZqAnMmP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rfMjmtNgJCzrsjggjg+ozENAJgfJoN5129bWl/gO8kUDQi2E/Yoo2WSCDDAla8ne/
	 70GfkNrKXtc0lCY7JeJSB8aq1iP6eUfG64mogLu+Y2bnFEhEu9RLpJgGeS8L408sHd
	 IVyCQA5QOgZVCyL6VIx69/ayOKL2A0jEZ6WnNDOc=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 8E52D618; Sun, 14 Jan 2024 15:35:37 +0800
X-QQ-mid: xmsmtpt1705217737tskreob6c
Message-ID: <tencent_A9EB66EDAACD207A7E6CA42D656F1097280A@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeG6JtRWKoTqljrhnatsegM86XQjJFeIurALyP7DZzxF+e5L+egf
	 uqzzOC3TJyrlRtk7lgmFE8zKyFxGV5yQ3InTwsYNTf7KKj1hnRBNDbYOlKHrIdIEGdW3tY0vRNj3
	 BBGwRh2LrH/rONw3SBMDMMai2ZJvexoK69cpjLjZgLepRGuc11pD5P+0DRhwu0PZhzodRr0ns/cF
	 +rVaX5A8yv9L4qd6annb0/i6budywA/8ekQRMQrVkAgGB4BUXHHWKnjWggs0DINbmxENpqGzt2DE
	 qTqa3s9TTw2MwSReyhn3ZYvKYYC2pAY9IRh0UPc2G5VV19hs+NwL9l7tMSU0T2XtOGmRXrp0B11T
	 NXLRWucPHeWHAXxG3163eM9IEezrALcFTU+XUBktu7pctNrpVMJC9lBGymzv6NsI6N86gaZqpSPg
	 PNzMiqjKLCCcApVe6gpq88pVpYUUy1ny1Vp4jC4L/mYsR/QpBP00FXssbv6s8UrUU67QLjnE5c6u
	 16uxxaDPulSljRAl+buKyNONsE+wYARWuNMupE1tyccG+erkLm4nppMkYIdygw5+rIx6gTbxpzDY
	 rsMSp7ae4Vp7OJmqNmcSIzhZyHg1qKZ4uC3YR5DI4N0NV1nu9LVS6pwraPweHHzCKAQoYX9/MZeM
	 oBSsXpV/fZ4NXJLFyshq0eqnNFKqNkn7hbyF5x3vKatQRZa6t3czRldDt1tqkvS+jqrvZyKiuzAk
	 4uXpkbYmZZjlwdegoswzqnhNruokC3a4cn9SjxFwSU0bQUMtCoO+qFcN4qJFPsUJWA90wR+33Kim
	 SYfikVCQ95Z1vtJNgEK+92mX0eYUI0HCdMrSNi2KKSh2FIBjlU8NGr/EBZ4hX1eM3l7voYCZlB0D
	 RIHTALfu0YBrWkwqQvZlCC8KaAY+DxTztJoZdMUxjPrHWcRn3zjta1we2I8qFip4TeQuF79wYI
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [nfc?] INFO: task hung in nfc_targets_found
Date: Sun, 14 Jan 2024 15:35:38 +0800
X-OQ-MSGID: <20240114073537.2627915-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000fb160f060ed71da5@google.com>
References: <000000000000fb160f060ed71da5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test task hung in nfc_targets_found

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git acc657692aed

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 6c9592d05120..9a277228a875 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -145,6 +145,8 @@ inline int nci_request(struct nci_dev *ndev,
 {
 	int rc;
 
+	if (test_bit(NCI_UNREG, &ndev->flags))
+		return -ENODEV;
 	/* Serialize all requests */
 	mutex_lock(&ndev->req_lock);
 	/* check the state after obtaing the lock against any races


