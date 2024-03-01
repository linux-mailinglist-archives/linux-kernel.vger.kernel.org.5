Return-Path: <linux-kernel+bounces-88810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5516786E6EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 310D5B2B263
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E83882E;
	Fri,  1 Mar 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="WZJOx2BE"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED37F503;
	Fri,  1 Mar 2024 17:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313045; cv=none; b=QfvR308ofjPc91HwYwSMN3PFOPSw8S57qvDSxEvuUUdKA4rjD/qLk0YuAHKzjCklXNtIPF/wZBpSfRabnk3wkQW270nrIxjWqCZFUkbtqd6aDzqOopnFiQ2Cq0eg8/4Tl5NIO2baeOQZsGiWyfWWBCWylmv1F2nu44D3mMhpw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313045; c=relaxed/simple;
	bh=1f3lWg+pkiYMDBEYhxFCMSCS17hH2ui9obrcK7tKVE8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4BHJV8ECaAS5cBzBk2LuUBv6PZPwpSF2vNsnW+pnAdlw6JT6Yv3/Ap2x25l/lPjJn6A6Ouv9IsQxCmKf7/IVeP5Ietup7S2SLLGc/RNVOIiQV5y2pJClYoe4/cNwKRpTmdodkOUgteqoSwMzdWfe8shtOAwlHDOylqqan1L+Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=WZJOx2BE; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id B0641DD7B446E;
	Fri,  1 Mar 2024 20:10:29 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 9K59O71FHrtq; Fri,  1 Mar 2024 20:10:29 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 7CD77DD7B4472;
	Fri,  1 Mar 2024 20:10:29 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 7CD77DD7B4472
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1709313029;
	bh=a6DlMHYD50bgw5c8dbRDQuJSmrsCV4dJRNHYFXyLCp8=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=WZJOx2BE56ZBTHhYS4Gdw6s8fbuKRWxiG9rvR0s32OSNIiJ8FmqPE0Z9GFqpMBTxV
	 C6OPEUJacpxpp2sgO/cCck0BPtzeX1pc/yh86Tg0Pz7tNk3/JRMwkZtnRGJU90J+iH
	 Pyo4cdUx+fFgUYBVWbEcoFSaCuHDyyXGuxwFZmtI00G0VtefyqpImFc8sZrMyMBkbE
	 dLsnyiXdbhVvH4fBANj+L5AzSJIkulOi5gTXysXVZ83PRsvYqGHggmQuKGibMkdGrO
	 Bh/1VU9M9rac7U5h2ti8+QotSQOkh0LmEW30NuwEx0fuTUf9UEkHc6Lz2R6c7buGqU
	 9x+noiYVLTn0w==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6DYsYvXOHtQm; Fri,  1 Mar 2024 20:10:29 +0300 (MSK)
Received: from localhost.localdomain (unknown [62.217.186.174])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 4C10ADD7B446E;
	Fri,  1 Mar 2024 20:10:29 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: v4l2-tpg: Fix division by zero error in color_to_hsv
Date: Fri,  1 Mar 2024 12:08:36 -0500
Message-ID: <20240301170838.57421-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the color_to_hsv function, division by zero is possible due to
attributes r,g,b are equal so diff_rgb =3D 0.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 54fb15348385 ("[media] vivid: Add support for HSV formats")
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c b/drivers/medi=
a/common/v4l2-tpg/v4l2-tpg-core.c
index a366566f22c3..943aab3ad97c 100644
--- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
+++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
@@ -597,6 +597,11 @@ static void color_to_hsv(struct tpg_data *tpg, int r=
, int g, int b,
 		third =3D third_size * 2;
 	}
=20
+	if (!diff_rgb) {
+		*s =3D 0;
+		return;
+	}
+
 	aux *=3D third_size / 2;
 	aux +=3D diff_rgb / 2;
 	aux /=3D diff_rgb;
--=20
2.39.2


