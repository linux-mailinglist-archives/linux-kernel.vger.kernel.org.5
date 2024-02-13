Return-Path: <linux-kernel+bounces-64366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE318853D82
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EBD0B2A96A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5982E69D1B;
	Tue, 13 Feb 2024 21:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvMwDxk0"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1625869979;
	Tue, 13 Feb 2024 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860455; cv=none; b=i9QCrGMpveJ7RAAK/qycygXIOsbVTygIGwPjggzO8u+mqsa3+e4dKmkWuNcAS+bZD8yJYmI8w08N6os4XMrah+C3N8dvi5Zg6ThTY0swEzEiEqoFuDouZ7n0wGL+LiHm7jzlGVgC4BblCSkmnWh4ciofCz7pNPrj8Opmz0PfGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860455; c=relaxed/simple;
	bh=buFz+dlNRbQQ6/K1paWq40VmJqIW++d4iyTR0Ulizao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7T0Lg1Zjev4FV6sP3JbUsx/HQhRAxxA2V9zwsHtdDu7Nbfo7R/lr9hXYbjzoea8M+r4dLs2OavrtwZiKVt6N+PhVOBBcsT+QFRu0C70B6MrSeFSsfRnztkIUGyzgjKx8ckbqfVtYzoQS9a7ke7h4msHBu/pXIQ1RUltKzqiG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvMwDxk0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5620f15c3e5so970677a12.2;
        Tue, 13 Feb 2024 13:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860452; x=1708465252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcJJ3FGefuRL57N+0mLK5i+7gqMGAlu+qKUm/Y2d5zY=;
        b=MvMwDxk0btZ8FTwJfft4m8T0BTMX4wMc0/w3Pvc4HES0ichGvDOPF3CqsOa3IgC+Ud
         MyC3gdJHJTGwgYICMXR/qT7DKEjOoBO8MaKhd6MfiuTSMQ4YeCNtcqZmlcV52MK9pOzn
         hEIjDHBYluUtL9XHGySqTmTzwz5JmowxEiX0emkSgQ1Le4TvD6pdFBv0E+BjRpIKa231
         TcERe+msg8VHGHFYGHzTJEzmZSvZpRh2A7HoRjFOBfEc/1FDp5oPDoy4QulizcSyKCtH
         oVX5Yh3b84n6rvk0IhvJsWE76hy0LH0lXlD1PhdyuZt2/q1YJD6WDqIhsfoYvCbQbG/U
         gkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860452; x=1708465252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcJJ3FGefuRL57N+0mLK5i+7gqMGAlu+qKUm/Y2d5zY=;
        b=sMJBLqlWroWu4y5lq9goS3KfmJWqlGJ2TZuv9xWgAJwds2s3/4+zh8E3FFFt8/NoXR
         +h4Yr5ikH/congVPIjyHTGq71VY8MduX7qZL2e0q21EtGc6aiUkwYKP1MesNYb35gitn
         7y2tkKlwn8hZqxJUCvNWsWIN//eeKj+aNRzl0jr7prYOSqeaGO4EPlRTHfrLQx4X/CRZ
         ogM+MTu/BDreBOYSXcJlHWcCQ4v8gOF98EMP+9wvAut4TZo14mS3amDka1gBWVsDEIpk
         QwYth6RS9QSZjDrnJFC02AOGGM3EBQczJTHvNNWbFdBnM07chWZob+x6bAca0UFJfWXn
         a0zw==
X-Forwarded-Encrypted: i=1; AJvYcCUIfQpSAodEq6tt/RWdmZA0CRdhT+WEI8MtjuuKGnXD2vwdrRMDH1saRiKvdL4BRkFH+SCx2PjD2RwyGoJUDoXBdn7IgPNIA5tIahtQzCAhnF4mT1jwAa4Rrq4+cyYYpD1bZ9rz
X-Gm-Message-State: AOJu0Yw0dUVSmSPnd01nkJoekM36I0/dHJqq5VlyNr9GN+KgWM2umCzP
	ETIOUgT/BKZKtTfj2CUNoSPot31bnjPcwHjoJ1laxiUay0z3YbSM
X-Google-Smtp-Source: AGHT+IFDz75KgzZ+6hE0DiIug0nscdHe6JX7Wwu8Oxpc0c8N8TE2FnKBYcAvzKCdYJ5Pdd7Kh3rG3w==
X-Received: by 2002:a05:6402:134f:b0:561:fd3f:d75a with SMTP id y15-20020a056402134f00b00561fd3fd75amr641329edw.28.1707860452326;
        Tue, 13 Feb 2024 13:40:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXV/RznNTpxucTM+oOK+M7Sxp5FheVEFgEBH3Q6MaRjMwlvSU49z/MGADjbpmuhXhckQSQNMjjhW+ZHQje3tAbjZhwqiB+XQJHZXEpIfTfboXNAApacb6isA2aNOd46LAyBAfLrKcGIBnEuPfzBDkYE4ykQk3TMYBr9dCDRQqpB0SUjUm9KdncNDh79oynVPdI9cPWvCN2LF22YBX7Ex0C3mJ7EjJRHW4QkUIuMTSs4GTHgGGcN/7b+pOvGwtF2ShKljJqMRR1J4bCFoXWVH97jlpzlpfi6OpIygB4YcaNAtFHzsA8oOxrldIXjX/IHN/E2ES8zkpUFsy//eA2JYQXR/Aw=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:51 -0800 (PST)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 net-next 14/14] net: phy: marvell-88q2xxx: move interrupt configuration
Date: Tue, 13 Feb 2024 22:39:53 +0100
Message-Id: <20240213213955.178762-15-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213213955.178762-1-dima.fedrau@gmail.com>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move interrupt configuration from mv88q222x_revb0_config_init to
mv88q2xxx_config_init. Same register and bits are used for the 88q2xxx
devices.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 7afaa693316f..dc0f150826f0 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -375,6 +375,14 @@ static int mv88q2xxx_config_init(struct phy_device *phydev)
 	 */
 	phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;
 
+	/* Configure interrupt with default settings, output is driven low for
+	 * active interrupt and high for inactive.
+	 */
+	if (phy_interrupt_is_valid(phydev))
+		return phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
+					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
+					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
+
 	return 0;
 }
 
@@ -700,14 +708,6 @@ static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
-	/* Configure interrupt with default settings, output is driven low for
-	 * active interrupt and high for inactive.
-	 */
-	if (phy_interrupt_is_valid(phydev))
-		return phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
-					MDIO_MMD_PCS_MV_GPIO_INT_CTRL,
-					MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS);
-
 	return mv88q2xxx_config_init(phydev);
 }
 
-- 
2.39.2


