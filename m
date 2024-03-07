Return-Path: <linux-kernel+bounces-95292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAFB874BD6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9737D28258B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7B31292D6;
	Thu,  7 Mar 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="TOcGzGmr"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0E21292D9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805761; cv=none; b=OWi3T41RlwgO8tXh8uK+EKAZGzEWAj2roixdOj+f28nyxE3ib2NeafFcgHglp4gnuBrpeW9MitzD7e2oUvCTG6IaNFccWm8FmIXHa501zN9nMuWr08ge24axWGFugk3R6WBs6DyWZlj6BQ1r4oqvEDwCcNrHMZcr2yw37cYur9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805761; c=relaxed/simple;
	bh=3Wn0tHhJ7B6JwZAL895kM8y1Q1sZYX28Y4p3wQyptXQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TD8QEJx2VpfDatlG0vVmzYLnvUovwoyMImutMeCQNPTbVzEBecLt0Lc5H1EeQVlmMl34bp0wnckwiUzVotuekbLHf0QymNB9zkyFMeTsbQOB0fmssh5qNOPqALe3juPnK+SNR+lfqW3u/NeUPyf2ScUJpJ6BpBmPMq0ZJ/s6/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=TOcGzGmr; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709805757; bh=yud+lLLingW7W9RmmT8X5waWeda+HIRaWpRJ0ENXHtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TOcGzGmrrAPHmdncZIycEXVQmrMp323Z5MUBV9/Bn6ejoz+7QuEQvwR08NYDkidhd
	 deAX6c4pyShogmeoTuonpyYY6JijJ9gxKUv7bAjkan7STSKAwL3YJ6UeGU931hn4xq
	 BEG6wLAtpdwwT9lxtW4V/OcCEpQWRnqQafMN9xb0=
Received: from pek-lxu-l1.wrs.com ([2408:8409:c90:315:7d1b:6e30:5639:5d6c])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 9EAAC10; Thu, 07 Mar 2024 18:02:30 +0800
X-QQ-mid: xmsmtpt1709805750tlz6wg07x
Message-ID: <tencent_5625D5BAC1BB7F334E9E261B494BC71B3808@qq.com>
X-QQ-XMAILINFO: MW5hkHoBpWXy14vldM0dsxpmQ3Mnm6YeXvWrvW2bzYFZc2BH8W+TNQ37dUNp29
	 T6UVzEOXdB6/E7dIaWOox+UU/g3QkH1IlzDLUZQXLmNV1J2IrqDyjzkCHvmWmuRS/5cCKGhCMUO+
	 tpWdH540ATKHWakZ7Jz42vja8vlNy3BFwXuQ2H/14vwRPQAdF2H0/ZhMyt18/elnw+kurIazENLi
	 V1xeRAu5Wl/mvVmKRSECaM0i0c3Nm5fpZroD07dZUUkTcjLO9is52UM2BNFb18hT5oTQvdknHrVI
	 MbLHHnzkJyFg9o9pqniiGh5kc34rqAku4gn+m5obEWL1czZf8/lRtyrzYD5zjxMoH/Q7hlF+o+Xy
	 Gswb3lv01wAfzsc0z4U4d4x6knQVktY8upXuDcDluS8OeCbDRz83Ncu2M0FuxQg2bohkSc7xpbbe
	 VoVBGCT/WK6Sn3OrmfNccgpIoyGT9Be8yKcohbiTc4GRPH22Gxm4A58d9LQsSMze+QN89wi63XnX
	 8/VinJI2smgA1cbwLMpksvqlgG++WhNjWX0bqIsLTC4b++c7RdmPhTBnyIbFryWWsdpJoOEPQGJO
	 VDqoTQ8stMBvuxzLW/qdQLNQwDrdWRMArR47ixW8PWixkhbmGLa7+/rcNB0r9TaRdzRSSjbEsggJ
	 luotBTglDFsrNBuAiJVT7eLXHKsMYnHQirRrVLYCgCX7hDqPhI1++/QC0gLyBbyANEUU5aou4NFh
	 K90GVwUZ5rzPBs1YeXOK4TeMLYzB/R6P4/N7IzJIxW95s2aGeA/bQvgFnh4v1m3H0mTwr8kuO3fk
	 vTtrqP6eOlcHYGi7JxNehd0N+76UCbFP5FLNtwiUmmBe+JO6lYsuOJ/TkLVYU0/gJzYXfrXAbNmr
	 YZ6x11c1+DZ4l0V5bNH2gsl8NVZ+ZrD5TyGITwgSgM9ML0oEwHum1P8qfhH+rP5NXhPI3GXedmzs
	 nF0w+928i7n9rNc31oYw==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3c47b5843403a45aef57@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in team_port_change_check (2)
Date: Thu,  7 Mar 2024 18:02:31 +0800
X-OQ-MSGID: <20240307100230.974510-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000004af86e0612f195c7@google.com>
References: <0000000000004af86e0612f195c7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test dl in team_port_change_check

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index f575f225d417..590412701402 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1212,7 +1212,9 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 		goto err_port_enter;
 	}
 
+	mutex_unlock(&team->lock);
 	err = dev_open(port_dev, extack);
+	mutex_lock(&team->lock);
 	if (err) {
 		netdev_dbg(dev, "Device %s opening failed\n",
 			   portname);
@@ -1309,7 +1311,9 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 	vlan_vids_del_by_dev(port_dev, dev);
 
 err_vids_add:
+	mutex_unlock(&team->lock);
 	dev_close(port_dev);
+	mutex_lock(&team->lock);
 
 err_dev_open:
 	team_port_leave(team, port);


