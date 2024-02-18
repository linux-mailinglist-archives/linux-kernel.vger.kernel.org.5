Return-Path: <linux-kernel+bounces-70269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C637185956E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C6DB22005
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE2A210E1;
	Sun, 18 Feb 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUQuIH1M"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C21D20DC8;
	Sun, 18 Feb 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243113; cv=none; b=Dq1+hf+W8jmzZmEO18PVfeXnoRqu1vuW0RjhkZiGknMMqthvnXl327olKi68FSDDoIhw/dmycJhEhQW9o14NzTpqrTep1NPxkewOWTt/lM87fLhVrPquZMszWUV/gV1FBi06xTlJ+MuXvZG4iq+A5T8CtVr4dcaiQLuTazAMh48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243113; c=relaxed/simple;
	bh=er7cV2uMtVycRBt3k8jVuTVk0/xvZNwEgT5wOaSLlUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oO8Ng1tsLhGhTIKSWDAq485i9dULGHUv0Lxw5cFf8tmqjsNNDJt/Snvcr41NhFyrlyzBzojcXdctd+Eag8CjsjAYLwkGdGsJ6OSQpcOsvy6idSFZKQCMjHxpJoVV8pVlHnKnvhRBIzHKY3QXijQnmuRlZ37Jjk9qytvdRMWYpu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUQuIH1M; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3cc2f9621aso327298466b.1;
        Sat, 17 Feb 2024 23:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708243111; x=1708847911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KV06U1xQkJ+t8rNMhzXp7fjnC3kSl2GuC4K8HSKdH4=;
        b=PUQuIH1MbG9piTV/YOty1WKesyGgsaSTowEHHYnhgDo50Tz2+lMD6j36BjpwwUso+L
         y1ow7T8BOSJBIcWSnRSaGHDiuktKtfL5mK+5UKvUEAXdnKBO2xpSJlAKG84Rg433rBAI
         Gq7kDXUflDGnGkJCBsWr031q0U+JVM2RpwjJvdFhWWB5SW/jjoHhAESC6VdYjBETFy9u
         DoBJq+b9MWIciFw0tS5Aw9mZE3/vf0nu4RjI+8UnK/sUZSeeBy+qJ4963AnaAs+N8hw1
         9NjDRvztYDkPunElswLC7Hgzui26TPqRWbmvt47Z2ZYIrioN7WOIUT3lAcFxAzLNdMgU
         3jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708243111; x=1708847911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KV06U1xQkJ+t8rNMhzXp7fjnC3kSl2GuC4K8HSKdH4=;
        b=vo0qAiaLudG/imDAgMEJ9hbSoZw14oKY1PV7t8QJlK+gOsZbYaM2Y8gfFu5gYU1Syu
         342kKyN6Zm4MYgjeh/L5PVt1K/kyQFwQ4u0SYdZxHtIPyTV76DdmIOutUixHmwsAFdaN
         Hf1tx4GxuYJAbgGdYE4UXXACkPtkZtbO7IFxYq8aRPRCDwKBzdH/MzNG0iZtizbP277z
         4IU471VcVgG1/YJBOpMslXESgPgp3j52umuUCwJFi0j9OCGY8rSD8nSvPkItGGcdv/18
         K7qLH9f7tBZV09wRqNLFhMYSc8XUlPjJaD4SRPyVQyWS2CIcr9ON/tR5+cAgL7xqKCVS
         DdLg==
X-Forwarded-Encrypted: i=1; AJvYcCVpSfFuxRFqmpm38Keinhngb90tiP7TwezGSqBJ2wNsBeVq1Q6ofuowt3GCAyobkH1P55+jcJY5LbHTfTuBDYEaQXY1IGBw8maJ4WYPoJ5aL4wYqNXkktG82+hH8fnvEi0xQrsY
X-Gm-Message-State: AOJu0YxxE0dEFKeG01ssf/Ehbkh/AibUWqO8rEqZ55832b0kYmAz3GpN
	cI4nx/4vqq3OX9uOILxmQ1uZcsUx01u1nwt7swd31T3BSMCfqonM
X-Google-Smtp-Source: AGHT+IG8iMGlxN5K5TYJNC2CsuGgQE8Au70cfbZEx609kRZkjSrjlcRj6qsJK9aUk45M7W+ivsljeA==
X-Received: by 2002:a17:906:a1cd:b0:a3d:14e0:9608 with SMTP id bx13-20020a170906a1cd00b00a3d14e09608mr4792129ejb.39.1708243110830;
        Sat, 17 Feb 2024 23:58:30 -0800 (PST)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id jj12-20020a170907984c00b00a3e64bcd2c1sm458732ejc.142.2024.02.17.23.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 23:58:30 -0800 (PST)
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
Subject: [PATCH v7 net-next 11/14] net: phy: marvell-88q2xxx: switch to mv88q2xxx_config_aneg
Date: Sun, 18 Feb 2024 08:57:48 +0100
Message-Id: <20240218075753.18067-12-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240218075753.18067-1-dima.fedrau@gmail.com>
References: <20240218075753.18067-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to mv88q2xxx_config_aneg for Marvell 88Q2220 devices and remove
the mv88q222x_config_aneg function which is basically a copy of the
mv88q2xxx_config_aneg function.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/net/phy/marvell-88q2xxx.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
index 5bc36cc68a20..58aa10d35731 100644
--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -686,17 +686,6 @@ static int mv88q222x_soft_reset(struct phy_device *phydev)
 	return 0;
 }
 
-static int mv88q222x_config_aneg(struct phy_device *phydev)
-{
-	int ret;
-
-	ret = genphy_c45_config_aneg(phydev);
-	if (ret)
-		return ret;
-
-	return mv88q222x_soft_reset(phydev);
-}
-
 static int mv88q222x_revb0_config_init(struct phy_device *phydev)
 {
 	int ret, i;
@@ -839,7 +828,7 @@ static struct phy_driver mv88q2xxx_driver[] = {
 		.flags			= PHY_POLL_CABLE_TEST,
 		.probe			= mv88q2xxx_probe,
 		.get_features		= mv88q2xxx_get_features,
-		.config_aneg		= mv88q222x_config_aneg,
+		.config_aneg		= mv88q2xxx_config_aneg,
 		.aneg_done		= genphy_c45_aneg_done,
 		.config_init		= mv88q222x_revb0_config_init,
 		.read_status		= mv88q2xxx_read_status,
-- 
2.39.2


