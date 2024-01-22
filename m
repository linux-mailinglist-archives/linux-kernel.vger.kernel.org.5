Return-Path: <linux-kernel+bounces-34166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2952A8374DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9ED1C273A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B41481A3;
	Mon, 22 Jan 2024 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="UoUuw2su"
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B68A2CA8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705957654; cv=none; b=l5ICg8Z4Ny9idXS94HatqB5/FnyAMurkCM2JtDs/USz5If2g7mlvgbWR/JIlaMdzs+0NVv4xOn0Si9jnCTkXE+UmLXCuGKqO08g/OFPWZELNZ+Gkti4I+2aDf9BLdl+JJ19rQVaLGYJYvHX3n5KlD0ynI9yExgroKE/xVv0PXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705957654; c=relaxed/simple;
	bh=9ZAKgwynKYmLmHzZEI2unMAaUO05k1UKaeCJdHvX+3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qS3SF9WmFQMoyaQ/euuTn5Q0pOk5ZKQ4Ph/Qrq8Q3wQ7O3sSvFqsUEyGz3ixk09nRIXK6euQmo3ZiP7nAnokF662sEO3q1FxuL5Tyc3zGna992ESRsO1yKEGh+FZNqzzD9fodlKYW3z7+n7HjdKPh8n6L8iRQox8U53P8AJe9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com; spf=pass smtp.mailfrom=savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=UoUuw2su; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=savoirfairelinux.com
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2AC209C340A;
	Mon, 22 Jan 2024 15:57:46 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id RoIy10GyaVZN; Mon, 22 Jan 2024 15:57:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id B81A39C42AC;
	Mon, 22 Jan 2024 15:57:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com B81A39C42AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1705957065; bh=4Try0d3gARfABB9Khq0TKkInuqkrGo1hSUCaiODzTeU=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=UoUuw2sulRYeHDCrEPw1m033gQXMsDZV/+O1j5ipl0APBORLuCPHJJujWzD5dPyOl
	 XPabEv51jUuHhwAwBkOxTYEE+K3VWzkHGOGNCsQZK/u4FJvtv9HAlh9axhvTgKvOOF
	 YjEgjw1f9Osfp6tCw2D4bmOsqZzGGfmxQeRozXv5pwOux7eNUktwXv9nC28gZVgF2e
	 Revp0tgTQjExl6GPtWB2R8ODJpN52uSJAwNPE9lndn7PU0bi1SeaqXQ1Ly7/uFUBDA
	 BBu4YuS8X3fjRzTIaVusfaU5s6sqg5VRJb5afyE8M799sRT3Of5wAno/wc0tOW3TK6
	 0r++i13iX3TPQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lAyDf_RnOqJi; Mon, 22 Jan 2024 15:57:45 -0500 (EST)
Received: from pcperry.mtl.sfl (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 90EEE9C340A;
	Mon, 22 Jan 2024 15:57:45 -0500 (EST)
From: Charles Perry <charles.perry@savoirfairelinux.com>
To: shawnguo@kernel.org
Cc: robh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	charles.perry@savoirfairelinux.com
Subject: [PATCH] bus: imx-weim: fix imx_weim_gpr_setup()
Date: Mon, 22 Jan 2024 15:57:29 -0500
Message-ID: <20240122205738.2432552-1-charles.perry@savoirfairelinux.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Commit 2a88e4792c6d ("bus: imx-weim: Remove open coded "ranges"
parsing") changes the parsing of the "ranges" field by using
for_each_of_range instead of of_property_for_each_u32. The number of
iteration of the loop is now equal to the number of range within
ranges. It is therefore no longer needed to check that i is divisible
by 4, otherwise, valid configurations will fail imx_weim_gpr_setup().

Fixes: 2a88e4792c6d ("bus: imx-weim: Remove open coded "ranges" parsing")
Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
---
 drivers/bus/imx-weim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index 6b5da73c85417..837bf9d51c6ec 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -120,7 +120,7 @@ static int imx_weim_gpr_setup(struct platform_device =
*pdev)
 		i++;
 	}
=20
-	if (i =3D=3D 0 || i % 4)
+	if (i =3D=3D 0)
 		goto err;
=20
 	for (i =3D 0; i < ARRAY_SIZE(gprvals); i++) {
--=20
2.43.0


