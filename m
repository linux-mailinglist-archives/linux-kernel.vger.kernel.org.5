Return-Path: <linux-kernel+bounces-109531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E203881A97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E89E1F21A5E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 01:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E0B17D2;
	Thu, 21 Mar 2024 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EtScc1NF"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C07EC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 01:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710983730; cv=none; b=aGedD2hB/FcoTiGStWFgVmamUIp61M6Csx0cte+n2y6RaUPMgVyN5gzhYcAC7sf2VZh6ghfOR3cW/dADarUQEnu0vLbZqyA8Z8rliGwsl9BNlN14V9bBjt4O/BOgS4kMEzLEarO3cq8Qxntlp8e49zF8USNfOdao/HIe/iTCY+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710983730; c=relaxed/simple;
	bh=HHpznCrhYtztnHnFzCQzgSGyOLDLRTRMRNVVTFzItjg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=BG+nuICyqBGY2kvJTFjycy/Uy7GnzwZbwS2JvihDjPBFsJDQErja9E/t7o8DHxJGrY+0EZAvWxyvjMufwh3Th+SSDzjZhlRHjjOulk4qffcX4ndM2Pk7vnadMxS3HdmVDYNI36vrEBqP1VcptrN+panvmCYpQOGwM0GBsPAmB7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EtScc1NF; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710983723; bh=V5Uy3G9cXF8cCacZcQvWvWkHFFe7KPOcDI4JRgGuZoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EtScc1NFASwVZfMhrAFvMQ3JHja6MsSXHFOhsnLXzlDX5FV1qWTgj6NY+hrnx/r4e
	 58GavSnW7LSADOmrC6IbWcZ+MAZxyoSkUzx2340YjeNU1Ra600MpbANRrRM0dldw/x
	 +pd+BrMcF7R193sY8mPCViM3rJEO68p8hQKuXdgE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 3D61FEC7; Thu, 21 Mar 2024 09:15:22 +0800
X-QQ-mid: xmsmtpt1710983722tw1r937ch
Message-ID: <tencent_C6AB9264DD87DDB41946CFFA8DAA25B10D07@qq.com>
X-QQ-XMAILINFO: OOPJ7pYMv25tgvdvorGif4D2M5N7YwPKrwZXC5BhDLvFFKYonofyWCJkPxRB6R
	 dofHPzBwYu206F5dRdmrvJzU16mk4i+V0Xn9CROuQlAaZI+l+1C5LvChrrv4fw/gRy4zCurAlpEj
	 Sye5fu3gqP5+AB1LknbhW3e3RoktSj6VZVmKbCauhK2O+2tl+zCdRYPAphfajHsrMeafjTCbYSjF
	 DHYrQxoBA/jTwOY/EEkM7dQAzyiVZsct285l5s4bSy6uQsMah3Jc51oRdAzeDWRyxSphtJLe/e0R
	 IQ6ckzXGm9NdEjWMbIqpHis4DfuET53XY5AWfndmecNHE6t3b17gGKu0FXazGvIOkkQi5DyYhNZE
	 lfvWrBD1Z98F6oMLseRtimEyeHu5u1xf+RAsdSUCSeGeS/Hbz8mj+HGpfli2r9kqDbuVU1Emn0E2
	 amd54+W62cojxBcvJ2t416RxdTzCvrzgTQjYZgPyoGE09I7/S50k4VKqf9rG/huNOaAcdTibrGh1
	 h3vDb906Xk226ETvNuSmctz/gSsLdFjgfYm9fAXJ7NZE5CHMrKrljyEFK75ZzoNd3geLTlHpwo5P
	 uwU7OFfM58+kKPJvAv/5j4vH7EnFJBuC2JebAyQPWnJeyjV8zSGfZby4m2HeEbHneFMZcOYBfbVb
	 zeHTVA5K1W9JAGIwN4862cGZU+PPnDvKHweTs0TsdvNATQIOj37BJhZkisXt3ti9fplPJEPmOFJt
	 wv6EoFhAgvF3nJNcX//DUW5snRAiqHsai8CvkupjVuhjsTU9jbAjV0h8mQ9ICyTk2i8rvhio0OLl
	 jydoeEKo92+4T+6rzbwx3t+IHCPBFfbkD7ctE8I09r93sqKptP61IlLsCh2gmHbp5xqjaLr6HldR
	 hYnNg1OiF18x90PlWymFTN/zoritCZ+6DHR8/kUlzO1401d6SXUT97K1PgqdozYoXVfah0LIOBFA
	 jHJzvaNZyBOpKW1D4xvP+Ajjntj8P6P0Op9KV4V2Q=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] [usb?] UBSAN: array-index-out-of-bounds in htc_issue_send
Date: Thu, 21 Mar 2024 09:15:22 +0800
X-OQ-MSGID: <20240321011521.1761927-2-eadavis@qq.com>
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/net/wireless/ath/ath9k/wmi.c b/drivers/net/wireless/ath/ath9k/wmi.c
index 805ad31edba2..5d531aacedbc 100644
--- a/drivers/net/wireless/ath/ath9k/wmi.c
+++ b/drivers/net/wireless/ath/ath9k/wmi.c
@@ -275,6 +275,7 @@ int ath9k_wmi_connect(struct htc_target *htc, struct wmi *wmi,
 	connect.service_id = WMI_CONTROL_SVC;
 
 	ret = htc_connect_service(htc, &connect, &wmi->ctrl_epid);
+	printk("ret: %d, wmi: %p, epid: %d, %s\n", ret, wmi, wmi->ctrl_epid, __func__);
 	if (ret)
 		return ret;
 
@@ -304,6 +305,9 @@ static int ath9k_wmi_cmd_issue(struct wmi *wmi,
 	wmi->last_seq_id = wmi->tx_seq_id;
 	spin_unlock_irqrestore(&wmi->wmi_lock, flags);
 
+	printk("wmi: %p, epid: %d, %s\n", wmi, wmi->ctrl_epid, __func__);
+	if (wmi->ctrl_epid < 0 || wmi->ctrl_epid > ENDPOINT_MAX)
+		return -EINVAL;
 	return htc_send_epid(wmi->htc, skb, wmi->ctrl_epid);
 }
 


