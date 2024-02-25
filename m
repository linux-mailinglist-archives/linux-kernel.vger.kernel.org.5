Return-Path: <linux-kernel+bounces-79969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E79C86290D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 05:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6B3281FFE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC35944F;
	Sun, 25 Feb 2024 04:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="FkmMbDvo"
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65F8F62
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708834014; cv=none; b=i2xzJw+YmBlUjcQqfxG6LLtTlq7ueC53FQRF9/wpSzIN2Y8w1tCESo/j1eyCRKyjmbzVFmK+RC1h7BOlied7RIGs5VCPZ52BDKxVKTBPkqNDXnscMiBFjnimeifK3WBHmMq89gtpA4U8RSYXEh5prA9Cww/dat2ev9vgcQq4lD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708834014; c=relaxed/simple;
	bh=nl6JrIjTW9p7TPesqi0hV03UyD+xxb/MCo2BW1hhADk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KEvPaX5w/ph5uoXKLPBvkO2Eq8PBHCvWQjM4YOnLP3Jqp5yg/K/Yjsr3776mYODF7LtmDqj60K3gzOWf0sTNB9AP/CHg4A0XcgtzbWW3PldJTfpw+to0l1lyvGLGfEmE5eDIZlOfCNFzzn/hsBxY+cyP/VfZLF1XKZTr03ytq7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=FkmMbDvo; arc=none smtp.client-ip=203.205.221.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1708834005;
	bh=lyd4BJhGuWqkAac72xN5ek4zfvslYVDWkTEArCiCrHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FkmMbDvojZ0eWmUnIg5V2SxOEM8mOv6IRIbtpyPpNnooJ18QYrbfwEMVL1qaZofq2
	 UIVtnFnfkWeojNHiIc/fMrv4Up1kJucrQtObPM2gH1gOifA25exToCkUvbtZ7PEDUs
	 2RS6gjDESzC/HsrzR2YRQF+puw3GNDL14XWnihdQ=
Received: from localhost.localdomain ([2409:8a60:2a61:ef40:480f:5c56:cca3:1b20])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 18993038; Sun, 25 Feb 2024 12:06:09 +0800
X-QQ-mid: xmsmtpt1708833991trfqdn3cd
Message-ID: <tencent_2BAA25EAD320DD49BA7409E637BFAB67A007@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujmsZj7kv/BX/km4RTGT/ZU29tTDppZKQ5uf/jeKwf9fXjTgI4Hc
	 U9DQZymPezehEusK6HO1/E6ei3QaFgURYHbb5yIYGF8SG6Et1kZej7Szl65jyYp9CyzFqC5Qv6mR
	 KCNh17ZrCGSZb3vInOXirdmOuDPq6SD2Y7MMSdITDOVLseWILKYfD9iPaYpD8+7zKmXCYXuRKZzy
	 MkEZAwtSO7ISe3KuEEeo6jwlOKv+MNQ3l7YRfEhi68SKUa5qrUm2PGnt+5Mjy5xbJITUMrj4qeNG
	 iwKqq4OYkqCQKPvt5mpk6BzjSgQsCS7RM+gOP20GubVI1qtc9Wza3q5lo5M5wgx+O7lmlqxyoV5K
	 Z1Aj9RBLn6lswXQYUypTTIRaPQT5DnLMCLTx1tHcktX0/kUDu8QrMNARna1mptSO4dtMMyY5YgVv
	 zBef83J4rvN2HWr0C2RQTkAVnXm/quRtQFyiL3N0vL+cCXmIYECfP+Pr1mJo7ktuwlppq/I7Bs7P
	 vabR0GqG8YqfwjJzRUlQSu/jbZJjV8EEr/mt3+kng1pcgMIdn/L7FXiGmlpYIxyL6pITa3od1xFY
	 xhkGzHa+JWziGI7TT9qBZTYtj04l+uJAbPpv4E3dcxoJLIJ6q0LKlDKMyQZl41YNVV2jjttg1zLa
	 tB/2e+txbsl5ZOvGLuQ6ymlN+xwbhCPyrMIHwdxGEFUvmZIDmWYwjWezhCDQ9SrSTCLVfJtAGPB7
	 B92XYwcQvtf194o1OCPLPd7g4C3h+Ooekqxkd0K+3WorVxQ7mk5vQ/Rz/BuSVlpDZWSiVm6rOArV
	 7Pl2YCrqslnkFq29IRRGIiUj/u+JvD5XF67wuzbgXKfPbmcWBTHnQDcuJbra7JQtLQbtBSK/dxKI
	 JBj5VFNQqt0z7hwY5+Lq6b6teQ7p2pcp99igQYX3LM2sYKpgdC6/t5mMrM+HHh0APOo3Ypw2Iksv
	 hL0CYM7wVDUYBrKnWrK1s9CdnYTpHPtCGXt0PcD2mCrwBRQ9oqZmBvkzLPyiFMJOqH04zKu+cBnJ
	 ET5llkjQjEq9hIVwZ+a8q/GxHSCJp1A2wQzOw5jKPnTEGLGtZaOpC1yxd5G8COxzMjB2KCI6QSwQ
	 HVVcnRjDagpQ80WPdnk+M/jBRF1A==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: wenyang.linux@foxmail.com
To: Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>,
	davem@davemloft.net,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Wen Yang <wenyang.linux@foxmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] net: ipv6: delete these duplicate static variables two_five_five and minus_one
Date: Sun, 25 Feb 2024 12:05:33 +0800
X-OQ-MSGID: <20240225040538.845899-4-wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240225040538.845899-1-wenyang.linux@foxmail.com>
References: <20240225040538.845899-1-wenyang.linux@foxmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Since these static variables (two_five_five and minus_one) are only used
for boundary checks and will not be changed, remove them and use the ones
in our shared const array.

Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 net/ipv6/addrconf.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index d63f5d063f07..1d55df7d34ed 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -6660,8 +6660,6 @@ static int addrconf_sysctl_disable_policy(struct ctl_table *ctl, int write,
 	return ret;
 }
 
-static int minus_one = -1;
-static const int two_five_five = 255;
 static u32 ioam6_if_id_max = U16_MAX;
 
 static const struct ctl_table addrconf_sysctl[] = {
@@ -6678,8 +6676,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ONE,
-		.extra2		= (void *)&two_five_five,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_U8_MAX,
 	},
 	{
 		.procname	= "mtu",
@@ -6722,7 +6720,7 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= &minus_one,
+		.extra1		= SYSCTL_NEG_ONE,
 	},
 	{
 		.procname	= "router_solicitation_interval",
@@ -7061,8 +7059,8 @@ static const struct ctl_table addrconf_sysctl[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= (void *)SYSCTL_ZERO,
-		.extra2		= (void *)&two_five_five,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_U8_MAX,
 	},
 	{
 		.procname	= "rpl_seg_enabled",
-- 
2.25.1


