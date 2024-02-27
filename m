Return-Path: <linux-kernel+bounces-83588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172F7869BED
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9741C24A84
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1BC149006;
	Tue, 27 Feb 2024 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FILbreyt"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B891474AB;
	Tue, 27 Feb 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050839; cv=none; b=noYenlz1dYI46eoJHiAlbLxFczBnvojopNUg+JzjG8ChZAy63jyUexptSZWRj/F4T3qA7yjDP5ZvJtFFlcyT18/7xnfuo61A+Y/gEFF+HVCP6dL/P2loEK2K1cbP04XrVDehJ3ppWLXxm8Af+MNwJaUJXFylC56VWnXw0fBQluk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050839; c=relaxed/simple;
	bh=KXxwVcUXX/NCPUpbq+k/T5tRwYI2DYglYzGyK3i7BoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1eBcsKv09YgDl3ShKevLOPunNDX1irWGWOgBn6AgeLM9Uy+GdMqUaSU/iq+VmyqOsHGv8C5PyTm6VyUdklBx1FFfC05eZLg+lS5dPGZGIUbPA3dnH5g7sKwow70JhV2H+ok6s/8ejohhMGqa1SNMGWpGPPFiBhj7lPbAcmrzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FILbreyt; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a43488745bcso358980066b.3;
        Tue, 27 Feb 2024 08:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709050836; x=1709655636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS6wZX3tjoDjM5AbS8ksgkr5I5kKbBqtNNcfWgu3gu8=;
        b=FILbreytJoYrnk5v5eRV46JhzgaawHy2I+R48u3TFAzr1VpMme2CciHlQ2Kblly0Ev
         /E1VMNGaQb30fUja9ncrhwU+aFg2NoDdOoGfQzZ18f+JyVSXm/z6yusEiCIBH6K6kjh3
         BXuJYY6ld/o7IDialL8DMuJZgvL6oKdHehzgQ+C+aPI9buvHvx0weYdTys9W21LHQIdU
         Gg7iOIinBxm7gt1ig6KdsT44sJJ4AMiCttQ3ueh200zAbwgU3E+DEgSnxamfoYh+NXci
         lKbGIudKfNwjmG81tiHJIvsdDPxzw89GQzG1u7OERymFHyF6cwayTUYgZdFu9E5TYzlT
         B69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709050836; x=1709655636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kS6wZX3tjoDjM5AbS8ksgkr5I5kKbBqtNNcfWgu3gu8=;
        b=L1T2Rc/S4IoPQNRUc0lELOMNl4B696BLP40DNjRW2Bo9hq1aWuUDaOGSIfat3EEqav
         4NRodSWkDsE/xlPyAeGXjV+Xty9wjY2nenmAlSBfpx9+vSgV+PGTjJA9F40pW+qxdczy
         ZeDZib48dm6HuCepUVIOrqkDo9UGwkfjWBrojJ1xCG9gYBuJhaZMauSo84dbuOBLZ40R
         /aNxd3G6AVkt7Uc5eroecSUUMEtAHOEo8l7g7SgV5NdLid6VavSRMq+sMUf+ykGsOFdX
         W+Go6FSWay17llA9bB8AVGvYfrJIIuGSZpZZ1yHrCJmg+9bxWccJ46tIHxBOd1hwTESa
         Gm/A==
X-Forwarded-Encrypted: i=1; AJvYcCWsMbaZgyVxvvCTsVviot0dIFdtwODDxaLUjsL59HNysV1NMVxdQ/xtIo06QZmVX+cWora5USc6e7N3DzVxw9AjWtxv/pyi2vuUEdtXcMzoxX+/VmXoJ9JUMrGda2+/ZFKvjXl30FHqrGENV70co0PB/l72Ytj1HDcz2c3doQbCWOJmfQ==
X-Gm-Message-State: AOJu0YyT3xSSXhI8DyBXE4EPLvyayN6sKnZsA0vQAGQctCI/J9QwBZeY
	eMgzWNcACR7vISIxxBTIvdQV/1VnXioh589qzfhteo+GL0MlMiU8
X-Google-Smtp-Source: AGHT+IGJd/YZ/ituT9mLXzyX0jTuhVrojP0sl2wpH0eueDaDHXnqFsDQ3KoWsU6AoSfdtTyHv3KZMw==
X-Received: by 2002:a17:906:3793:b0:a40:3aa3:9b8a with SMTP id n19-20020a170906379300b00a403aa39b8amr6515247ejc.15.1709050836194;
        Tue, 27 Feb 2024 08:20:36 -0800 (PST)
Received: from fedora.. (cpe-109-60-83-139.zg3.cable.xnet.hr. [109.60.83.139])
        by smtp.googlemail.com with ESMTPSA id tb25-20020a1709078b9900b00a43df459013sm107570ejc.131.2024.02.27.08.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:20:35 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ansuelsmth@gmail.com
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next 1/2] net: phy: qcom: qca808x: add helper for checking for 1G only model
Date: Tue, 27 Feb 2024 17:19:28 +0100
Message-ID: <20240227162030.2728618-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227162030.2728618-1-robimarko@gmail.com>
References: <20240227162030.2728618-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are 2 versions of QCA808x, one 2.5G capable and one 1G capable.
Currently, this matter only in the .get_features call however, it will
be required for filling supported interface modes so lets add a helper
that can be reused.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/phy/qcom/qca808x.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 2acf852fb4de..16c94e77646f 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -156,6 +156,20 @@ static bool qca808x_has_fast_retrain_or_slave_seed(struct phy_device *phydev)
 	return linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
 }
 
+static bool qca808x_is_1g_only(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_CHIP_TYPE);
+	if (ret < 0)
+		return true;
+
+	if (QCA808X_PHY_CHIP_TYPE_1G & ret)
+		return true;
+	else
+		return false;
+}
+
 static int qca808x_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -350,11 +364,7 @@ static int qca808x_get_features(struct phy_device *phydev)
 	 * existed in the bit0 of MMD1.21, we need to remove it manually if
 	 * it is the qca8081 1G chip according to the bit0 of MMD7.0x901d.
 	 */
-	ret = phy_read_mmd(phydev, MDIO_MMD_AN, QCA808X_PHY_MMD7_CHIP_TYPE);
-	if (ret < 0)
-		return ret;
-
-	if (QCA808X_PHY_CHIP_TYPE_1G & ret)
+	if (qca808x_is_1g_only(phydev))
 		linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported);
 
 	return 0;
-- 
2.43.2


