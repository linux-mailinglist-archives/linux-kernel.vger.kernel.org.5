Return-Path: <linux-kernel+bounces-113193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A357B888233
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33943B24169
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0F257308;
	Sun, 24 Mar 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZTvSIb0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E28179FC5;
	Sun, 24 Mar 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319997; cv=none; b=OYXnCPnYarlm7riv20HC7SeUJpwWP0ycTY2PzVHCsE01u7GYq6rh5/V46lfC/bjBUf1VRgY9KPPsi10/MfGLyDRuUUWO0WRX5n7OWHqFjLZSGin0G4uYG1jdVz4GZgl2Ga079jCfXjYaVsPy2+XmmXGmTjrX9FyHM6ISeuCdnX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319997; c=relaxed/simple;
	bh=n0ZZGalvuA0PD6jzMmVDBM2mpyQqpmLP63G0KklBvQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=df6VaHJ/5vGD09ROJqc74ZlCYIvaDeKu6M5rRzHct0khoblh0lmLT53f8rV+X/3Bcmc2/zHNLnhZ+DSil7KzqgFvF6jHRYAnRXUYzAzgrSeCX1jF8MdZ+35BFBBbHeyyjOTPeqLMZ9DRuxjaCYCpFFNi3y2SL3XBXofFG/RT4Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZTvSIb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CEBC433B2;
	Sun, 24 Mar 2024 22:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319997;
	bh=n0ZZGalvuA0PD6jzMmVDBM2mpyQqpmLP63G0KklBvQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZTvSIb0qsdVsHz2aitxCc/ru/iBh4HqVvfsA33qHVOduBtJozK32deH3Hm0T3nSx
	 tA4dNzBXHpBcAbH+VBfTli+hXdSRBXjEK0p3DwWxUFngu6fyB+YaAoF6OUmIN3Giq6
	 ktdqdUphVgUBl+GaNZeALDvKKAlFvJM73sHQyabZ5rArJm8P1gOSJeeFcBHqSMoFIz
	 ukDHoxMxeHpzKMBMMERytedX7npYO5uRhFK0Umw5HwoP6+gAL0Eom530u2kNeJ1eJa
	 eCW9mJp+2tINaCI1gYqYSQQQKjarISOxsrwMnGElC5X3ETU7pquiy4JnDd0HsP7g+u
	 e3DZG9soO6BuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 302/715] Bluetooth: Remove HCI_POWER_OFF_TIMEOUT
Date: Sun, 24 Mar 2024 18:28:01 -0400
Message-ID: <20240324223455.1342824-303-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jonas Dreßler <verdre@v0yd.nl>

[ Upstream commit 968667f2e0345a67a6eea5a502f4659085666564 ]

With commit cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED"),
the power off sequence got refactored so that this timeout was no longer
necessary, let's remove the leftover define from the header too.

Fixes: cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/bluetooth/hci.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bdee5d649cc61..f7918c7551834 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -437,7 +437,6 @@ enum {
 #define HCI_NCMD_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
-#define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 
-- 
2.43.0


