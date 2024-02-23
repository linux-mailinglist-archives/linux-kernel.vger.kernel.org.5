Return-Path: <linux-kernel+bounces-79035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B9A861CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ED571C2314B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B7514601D;
	Fri, 23 Feb 2024 19:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npQiehmU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1B11448DE;
	Fri, 23 Feb 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717025; cv=none; b=FCgTpzewVQVmUKvmQq+l1hdwREkhS7NB4j8hdXGSDYwhnD2diUPOiN+b6cxqJ6o5LNVtE45Qxlc5JBSvI5SJYMbp0BK/2F44KME9hueNlahJjGOVZM3+be0yq08MotWvIXtsHOPDebHKbRkJGXlh+EHcDCVNiY7KMUgS8M0vR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717025; c=relaxed/simple;
	bh=4p4XMrLHxSZnuFW2zgB0x93UQjVZtW3P2Uq2OHqeIIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DijL4qqCA5byPGLZb3/LSyqOmpFDaoxjXO8jwiLBt0GATJfyVdx54ZV94iGkNiuguARcWFybRrIAOJ2Bz6fHq8hSrlH9cnGqM3UudcbnXKjeT4TZTk7njgyN9wO5J0iPCyBeS927/0s4NTFBYwqgNhB/tPs6ob6Zfeeoi8Lpe+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npQiehmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D63A6C43390;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708717024;
	bh=4p4XMrLHxSZnuFW2zgB0x93UQjVZtW3P2Uq2OHqeIIo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=npQiehmUx4lFzJo/rvn50pr5J1DG99Ea2TK6gLmaufaw90GojzLWN3nMDG13mcXtm
	 oxo7H/731ejRRTc7lKzqyRVR7AmuM6HQFi3ZPPjmrGLfSW4Fl9iumLbp6OktjNVPV9
	 6T0NSLFDLYu1fYFLdO65wf0fg1D3QdBF/z+nGvpaJrpdJezYcDwMNQuIIE2Zk9sTFV
	 rtZYUfUbn5fKrcDBhbMLGihRFqtEbBOXDQaROufDIcy0hK6+GAUfvt9Xf3FweZ89y3
	 wdj+nF7ywOu2BFZ/8XS2ym622OaKNxaRFhhlMKssiCHGE2HMV/0pmsCWelBoiZB9+Q
	 nWGzhAz7NMufA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC55BC54E4C;
	Fri, 23 Feb 2024 19:37:04 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Fri, 23 Feb 2024 20:36:49 +0100
Subject: [PATCH 3/6] mtd: maps: sun_uflash: Declare uflash_devinit static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id:
 <20240223-sam-fix-sparc32-all-builds-v1-3-5c60fd5c9250@ravnborg.org>
References:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
In-Reply-To:
 <20240223-sam-fix-sparc32-all-builds-v1-0-5c60fd5c9250@ravnborg.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: sparclinux@vger.kernel.org, linux-parport@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, 
 Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708717023; l=826;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=x2uAqMv58+DpgI3eYVpcudpJwlGuM5xq788IvJ499fo=; =?utf-8?q?b=3DwqNjuoc4O6iR?=
 =?utf-8?q?10ugVZng/NWir9h8I22iG/JoQ0Dc1v9cOvXdZROnE4FJPufIwv1hmdqp3WaYn6on?=
 OHCOKIlgABUBMri0Mmqs42qDdIHPTN0exdx5pM/8IpLNnnO/1ZpO
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

This fixes the following warning:
sun_uflash.c:50:5: error: no previous prototype for 'uflash_devinit'

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 drivers/mtd/maps/sun_uflash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/sun_uflash.c b/drivers/mtd/maps/sun_uflash.c
index f58cfb15d6e8..b69dade3f7ad 100644
--- a/drivers/mtd/maps/sun_uflash.c
+++ b/drivers/mtd/maps/sun_uflash.c
@@ -47,7 +47,7 @@ struct map_info uflash_map_templ = {
 	.bankwidth =	UFLASH_BUSWIDTH,
 };
 
-int uflash_devinit(struct platform_device *op, struct device_node *dp)
+static int uflash_devinit(struct platform_device *op, struct device_node *dp)
 {
 	struct uflash_dev *up;
 

-- 
2.34.1


