Return-Path: <linux-kernel+bounces-161445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F28B4C0E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6597A1C20FE2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DF46EB44;
	Sun, 28 Apr 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iJCxfvPQ"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F721E534;
	Sun, 28 Apr 2024 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714312416; cv=none; b=Cve9urjghhLTsjidgh9XUddFeqhRhQLWrS8xR0aNTdkMtqq4DHEbeKH5y5cT0oAO3DC/8npVu59LIKAa3sTFPe8AzYd2Twufn7kj6yeQ/a+4ELxMqa2H2vurvGwUiLuvO52h+Rsx2z6loEuMQrBIvfNx/2vCtCEC64MQ8qr+TRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714312416; c=relaxed/simple;
	bh=lTFv0Q0Z3uFaOtcQQ+hX7KQXjKB3radCUsB3LqiEqVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bb5I3JxedAauVIhM3GOL3aCTGZmjskH1mfyWxfoUXCCxG5N27cLy9Y8/igLlzTBAxPeHjD4UOgXEYV9SXo0lJRHcgE7L8kDLJjFA3DWeto7iUPw+S48gYMqEN5v0v9TrOETppcEWTl8BL2eLLX7iDWgvUpd6O7addbkfIq+azNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iJCxfvPQ; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 14P4stNDdAF5O14P4souK9; Sun, 28 Apr 2024 15:17:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1714310236;
	bh=5GLdy3SIJPdRWjFGBT9YX8GGLcU1G11y2fVbo+S63bY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iJCxfvPQpjLgWOxQlG7TF1q0zv7Hbq1FYZ1ZAhqXyKYaU1ej0Azkailcxl+NaHnNb
	 kXPvPPxX3D9jT4Br7a9mBbvFYi3ZWp4gu0HvCtvh6a64DhUwLrslTcdnzRWq+lL2dw
	 RFqvk1uO3DwkDBW1G6dkQCYJtVtzCbaq97jlvmfXPIHEdGb7hEDM0qCkweMiLkpUFY
	 zR9Rga4W5OcIWetDkk/BKH3Kdm7c0Zk3Xp6w2UI/m/Ri4W2T8rEjly3m6hX0auNz1+
	 2LJQQZ/AEdxkJjVY69Om6sT6+NHyRSxzQq67OB+7xBzpF/9sVhQ9p8iHDrwKK1+NDA
	 7AFEZQHplx7Ow==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 Apr 2024 15:17:16 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH] wifi: brcmfmac: remove unused niclist structure
Date: Sun, 28 Apr 2024 15:17:04 +0200
Message-ID: <c40be4fd791658bf9e9099237f2b37aa8c51f396.1714310206.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct niclist was added in the initial commit f21fb3ed364b ("Add support
of Cavium Liquidio ethernet adapters").

Apparently it was never used.

So, remove the structure definition now. This saves a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 drivers/net/ethernet/cavium/liquidio/octeon_droq.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
index 0d6ee30affb9..eef12fdd246d 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
@@ -30,11 +30,6 @@
 #include "cn23xx_pf_device.h"
 #include "cn23xx_vf_device.h"
 
-struct niclist {
-	struct list_head list;
-	void *ptr;
-};
-
 struct __dispatch {
 	struct list_head list;
 	struct octeon_recv_info *rinfo;
-- 
2.44.0


