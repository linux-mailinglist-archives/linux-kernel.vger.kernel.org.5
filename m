Return-Path: <linux-kernel+bounces-74568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A697485D615
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AB71C22136
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28C43CF6B;
	Wed, 21 Feb 2024 10:52:54 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D32A3EA66
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708512774; cv=none; b=D5Wz47aveUnNxbjtHYeuFAFa329V8JfF6ZT6DyfsSKCOtKT7EFt2C36X5+YfXtbJArpB2PDbOzWc/MeFg/Q7Cwyox5ENQramcZpfURSbjGeKiuW/Za8j4UXtpO96csDOKlAKQNJHWa4QnafBIWWvkWgD1YKH3SrI0Wdam088CDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708512774; c=relaxed/simple;
	bh=xdqio47qX0QHz+F+MzyEbD62K3UDC1/NI6DWIDHjdy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=udR6tpKpxs8pSm4OLJt5sv8olzTqL2iJlB2wyB1YYhkOaYyBzCSq9Agb4NZ++XBxqoX6deljkaTjEp8DdO1Ktiw+RqF2BCRQrR4l4fHltzERgG9NlOXLqGuGn1XF6a6xK7CyKYbq+Yqopb3CRXotV+X2IHaKBiNiBVZJTDFRDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5450:2f24:6e58:231d])
	by michel.telenet-ops.be with bizsmtp
	id pmsi2B00C59vpg206msiir; Wed, 21 Feb 2024 11:52:43 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rckDK-001FTk-0D;
	Wed, 21 Feb 2024 11:52:42 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rckDS-00Bltk-9j;
	Wed, 21 Feb 2024 11:52:42 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [net-next] octeon_ep_vf: Improve help text grammar
Date: Wed, 21 Feb 2024 11:52:41 +0100
Message-Id: <b3b97462c3d9eba2ec03dd6d597e63bf49a7365a.1708512706.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing articles.
Fix plural vs. singular.
Fix present vs. future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig b/drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig
index dbd1267bda0c00e3..e371a3ef0c49a1d7 100644
--- a/drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig
+++ b/drivers/net/ethernet/marvell/octeon_ep_vf/Kconfig
@@ -8,12 +8,12 @@ config OCTEON_EP_VF
 	depends on 64BIT
 	depends on PCI
 	help
-	  This driver supports networking functionality of Marvell's
+	  This driver supports the networking functionality of Marvell's
 	  Octeon PCI Endpoint NIC VF.
 
-	  To know the list of devices supported by this driver, refer
+	  To know the list of devices supported by this driver, refer to the
 	  documentation in
 	  <file:Documentation/networking/device_drivers/ethernet/marvell/octeon_ep_vf.rst>.
 
-	  To compile this drivers as a module, choose M here. Name of the
-	  module is octeon_ep_vf.
+	  To compile this driver as a module, choose M here.
+	  The name of the module will be octeon_ep_vf.
-- 
2.34.1


