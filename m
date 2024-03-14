Return-Path: <linux-kernel+bounces-103047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED1387BA5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FED1B2345A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAD26CDC3;
	Thu, 14 Mar 2024 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EveSoR15";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="hxDGIgTL"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1036CDAA;
	Thu, 14 Mar 2024 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408406; cv=none; b=IXn7EC100nIWWSmPX3ZEIFKOXoy3kaW5Rt+A+Vl2L7qZODkwOC0CXCVnaOXXjK3xEwcc2ttneZGZwjliakTVkosszcg8kocWTNacAF3U4nlN8gLgLMc/U/pYMEj4X573yXPlezMTEhhBkub+2/PGP1PszXPY8A34OuJoddDfLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408406; c=relaxed/simple;
	bh=GtdGMaGlOqd8YnCeRxL1pdean0HNUs9CwrpBwyhyj8c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DxB2/wBzm09llfPLYCgc5m0kV+EttNxwCJBCFEylIG73k1/1wE92Qf07RsLTxq2WuhQ4/oSBr/FW7TUreOGEctgfIU6pHSfWtZxuOgQ9Bh35ISFhAnGKi7I1GktTiTeQUsiuHAwsAOz3yMuQ0hrJtaok91Sv1Tw3Xg8xsKoJWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=EveSoR15; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=hxDGIgTL reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1710408403; x=1741944403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BINM8nk0+9lReE+wDNfi5X4NNgZwosYeCRM2pL/Dyp4=;
  b=EveSoR15zL3hsM276ZOdE4puvnIo6/sGOvelI00JJfRMbPPd7nuXAPz+
   pZVtrIaSFKPSe56LwqZ16I6WMM9TnrMZ0uIOsPpMyPtgkyX/Z0sWeFy6G
   Tg/lQzVPhL0I6WUydjLPMG3bYtOVqMmmyrNf/v41iz6Q3q3GEmynYFxIl
   p0vNr/7zbaI6JZ7f1Zlb6QhURw4r14Fqm1e9eTPLX6g7CAuXPAUqz+A37
   a1XcX1wWTioHIr9mHGlxcOo4H9wzRzq82UxNGK2hbkFmJ6q+taqo2QBeS
   ClFUdurLDTYZomlkdRpA8SYPZfdwfeuUui/4SSVK3XsX5FWet+6vSHrtj
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,125,1708383600"; 
   d="scan'208";a="35907474"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 14 Mar 2024 10:26:34 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 761C216E684;
	Thu, 14 Mar 2024 10:26:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1710408389; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=BINM8nk0+9lReE+wDNfi5X4NNgZwosYeCRM2pL/Dyp4=;
	b=hxDGIgTLVmCZPueyCNHsfO82t4HPRJFas02KypfP0qt7ftSeMa8H3vbJln72WjcdSIVYa4
	XfuHD36l+ElcU3HwFpqLyks0peT4HWBTl2pkJgWsz7Bdj5noOucGPMa2TFCp8/qlLGI2E2
	S13NZxNzjXB9JkO7+x2W4Q7pKxl0hTWDhgJT6VUatBtdZi30+4uqobhAf/p2jeysOQPQId
	BsE5uuXwPI4aYQRICgDmYI4ktyoZwg2AYRCpfcT/Lv3H2MI1YDyKYoMZpXh94v9//3FdDi
	tPipm9fNp6tknJshFBnBU3gBBjpRh3wfmUhTqBz/Frm8vOUB46iye7yTftlE4w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sean Anderson <sean.anderson@seco.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 usb-next] Revert "usb: phy: generic: Get the vbus supply"
Date: Thu, 14 Mar 2024 10:26:27 +0100
Message-Id: <20240314092628.1869414-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This reverts commit 75fd6485cccef269ac9eb3b71cf56753341195ef.
This patch was applied twice by accident, causing probe failures.
Revert the accident.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
See [1] for details. This applies only to usb-next.

[1] https://lore.kernel.org/linux-usb/3469745.QJadu78ljV@steina-w/

 drivers/usb/phy/phy-generic.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/usb/phy/phy-generic.c b/drivers/usb/phy/phy-generic.c
index 8f735a86cd19..fdcffebf415c 100644
--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -262,13 +262,6 @@ int usb_phy_gen_create_phy(struct device *dev, struct usb_phy_generic *nop)
 		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
 				     "could not get vbus regulator\n");
 
-	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
-	if (PTR_ERR(nop->vbus_draw) == -ENODEV)
-		nop->vbus_draw = NULL;
-	if (IS_ERR(nop->vbus_draw))
-		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
-				     "could not get vbus regulator\n");
-
 	nop->dev		= dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";
-- 
2.34.1


