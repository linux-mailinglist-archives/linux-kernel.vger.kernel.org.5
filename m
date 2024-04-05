Return-Path: <linux-kernel+bounces-132784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50959899A1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C815BB216C4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F5E160886;
	Fri,  5 Apr 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b="cqx7WcJW";
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="k47nb2PZ"
Received: from e3i57.smtp2go.com (e3i57.smtp2go.com [158.120.84.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9015FCEB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.84.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311282; cv=none; b=E/2xNJWtKJKJ5QeJBVzJPtKBwo/f2RxyqOGDtsB3KF8L3E6uxMbVD+6NJYcnurCSyqFcE5/FSHjBFW2NIVjrzdAnIQM5Pub7iHZLztg8cR/qVU6Q9ouEvmCzIuLWYhViyL+sTiDfK9fOkkDMlg9mj3gP2ZGP5BVE/UldMoTre/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311282; c=relaxed/simple;
	bh=B7RcvbnNf5GZ+FZLekSTBvetz0v/1b6qxp4sDie0PL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7AxWgNINR8EGW54OnbMX6IuwdNrFv9+OmEG0guWf1Wxs3HS/rVnN7ZUKdr2AAJbkNvpQiOs2vRekIlQNfq0GZfklnV+E5Dsgmb8WOYkX4e3ZFEi9dkXMDnmSBDbhspgNzLqUM4e0xoYc26c5LINMjIzdp7GqstKhwx5Qbg5gLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=em1174574.asem.it; dkim=pass (2048-bit key) header.d=smtpcorp.com header.i=@smtpcorp.com header.b=cqx7WcJW; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=k47nb2PZ; arc=none smtp.client-ip=158.120.84.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1174574.asem.it
Received: from [10.86.249.198] (helo=asas054.asem.intra)
	by smtpcorp.com with esmtpa (Exim 4.96.1-S2G)
	(envelope-from <f.suligoi@asem.it>)
	id 1rsgNl-rloBri-0r
	for linux-kernel@vger.kernel.org;
	Fri, 05 Apr 2024 10:01:13 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Fri, 5 Apr 2024 12:01:10 +0200
From: Flavio Suligoi <f.suligoi@asem.it>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb entry
Date: Fri,  5 Apr 2024 12:01:04 +0200
Message-Id: <20240405100104.480779-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405100104.480779-1-f.suligoi@asem.it>
References: <20240405100104.480779-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Apr 2024 10:01:10.0828 (UTC) FILETIME=[2FAB8EC0:01DA8740]
X-smtpcorp-track: 1rsgN_r_oUri0r.DxvoHifH3s9bU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpcorp.com;
 i=@smtpcorp.com; q=dns/txt; s=a1-4; t=1712311275; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe;
 bh=gbk6GEaZFm2CqJE8OhLPw9fpnMMZjNb43lrAdGQwPeQ=;
 b=cqx7WcJWdO4oJOiF/fJILhoJc3iSPoyOGeqlPDJ+ZaMT2aJTzV3iRuWpstMpfzh8hX3i6
 3y/5a+JDyVZX4t9neyK4gF2qTz28wnPko1UNi222kS7Tq+BQuWm/ju2HTQne55N3ArO3R+w
 oaFMW7MgvTjnrLukRHp6D231u+trBWKSdTr5f+9m+pY0sshx3etWyS2WaFzY5V2PoIwTi/W
 FI160K1C0gtSbBWpNDsnZ4t7cOIc8wcad+W//njiv7fx2sAXNSaog5DDI+5xuO0/G8O2QPX
 R3M6cuJn/Bq2bC4lhgjMkXSi6fB2UpWDnREy9wgahhyXrv767/10BDNOJVxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it;
 i=@asem.it; q=dns/txt; s=s1174574; t=1712311275; h=from : subject : to
 : message-id : date; bh=gbk6GEaZFm2CqJE8OhLPw9fpnMMZjNb43lrAdGQwPeQ=;
 b=k47nb2PZPZRi2q59n+PFQ0W/bT6Bhx1rH5btXQoOQ2Z1FZbkUE4zvfywnYB2PFNvVr4r3
 He1z5X96brjpNk+qPi71V1EJ91ohfxXoICT0mTudNRO2RYbb1Wx/HY4X/5nDA0y/Pp7emax
 gQ2VX1MDMiGzdvv2Fs5Cz2v/CikB4BaXo7WC7+nzltSr6F1wRTSKTSd+ndHpcbPWeQoSnR3
 hOnIjonOMyBO3MO2ysvubpD3JzsJceZVIIfTiSEPLo8d/9ViDjgluYIDKI8G48ZYlMLuFaY
 y0CovG34Huj+3/AN6rHc5vYolap0GeBubfgiGkYVW1XjCJqq4TB37a+IP9Dw==

Add the Everspin EM0004LXB 4Mb (512KB) Industrial STT-MRAM Persistent
Memory.
This device is JEDEC compatible (JESD251 and JESD251-1), but it is not
able to provide SFDP information.

Link: https://www.everspin.com/file/158244/download

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/mtd/spi-nor/everspin.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
index 5f321e24ae7d..4741930ce9a8 100644
--- a/drivers/mtd/spi-nor/everspin.c
+++ b/drivers/mtd/spi-nor/everspin.c
@@ -31,6 +31,14 @@ static const struct flash_info everspin_nor_parts[] = {
 		.size = SZ_512K,
 		.sector_size = SZ_512K,
 		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+	}, {
+		.id = SNOR_ID(0x6b, 0xbb, 0x13),
+		.name = "em004lxb",
+		.size = SZ_512K,
+		.sector_size = SZ_512K,
+		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR | SPI_NOR_HAS_LOCK |
+			 SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6,
+		.no_sfdp_flags = SPI_NOR_SKIP_SFDP,
 	}
 };
 
-- 
2.34.1


