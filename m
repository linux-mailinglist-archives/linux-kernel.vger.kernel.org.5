Return-Path: <linux-kernel+bounces-48255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB784592C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD3128D218
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477A35CDF0;
	Thu,  1 Feb 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnpWIJUh"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DE55B680;
	Thu,  1 Feb 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795175; cv=none; b=axp6arzz/tgNgCZ7r9hgvfejtUO+J4ZoNWkX0utAEMhhH4WM9ebbvY0rN/RaMKOSsBq6Bjg0Wdb6Vzx8/rvTSbL8Kkplqo/4GYZX2SgS+iv8cCsL/0mja49emIDuqwVERuqTTnDEeAPoRXDn8vUjM73giVtmRC9I4rV5UtOhfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795175; c=relaxed/simple;
	bh=8yshVBdG6yyHyf6kHZbatq/nmG8GO2JLF6m2JCHdA7c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGDCq6dALsjIJDvuVBZmOa86XT9VjjwsQv7n0w9j9r5nqNfBreQ2lM+YMRM9UpBB/aY+4Sb4+tTdIpeF2Mf53QQZZCfyj3FMSaL0H0xoeitkNlevnHKuu4pcRGavOBv8wWEHfna8FYQFMtAFaaBtY2ucfYoKitZB2zKB5MVkWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnpWIJUh; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b18099411so335050f8f.0;
        Thu, 01 Feb 2024 05:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706795172; x=1707399972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WI57s8xyw/VuqwwATztcVrR0u1zGyJD6fjAnhGWvRH0=;
        b=SnpWIJUhrjNxx0fXsX2IZ+fr/oYrEdOaUhpRTbpTl7dawfIIo6vVgzhOOwaI8aglG0
         t0zwR53S2cYRm8wN+7hjtTOCmoGids/JVW8Ye2Yzy09r5FwDWmEJFZLG3tof/VC3zaMB
         4vaQXu41sG6kI9iclqWAX0yGMlDSGX5VeCPE7VkFJgikPb7b/KbU/JR8lk8mlr+amjev
         T+cFutMl986rzApsrI2YBJiwec+pWHx9v/+5j58fr8zQ3LsvHGAdbDjmaOG+b77LfhjL
         hf4Lc8XHZPmFT2Il6wjD2c1yxaw5JSO0MW4P0ODUhHNsny65j8AOc39BylN1vJCLSPuE
         fWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706795172; x=1707399972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WI57s8xyw/VuqwwATztcVrR0u1zGyJD6fjAnhGWvRH0=;
        b=qd6JzC8hmt5anEGW0geljRdzPGV8bz6YOJeBNJtXecX3PSHrP92uWt9QMReTHCPnpB
         PhrAqZN+Q3bJ7AgleJS8ISRhQZIEl8Rz93/rGDotUQnmHVC3si92z4iPe6dB2jVoqQ4Z
         bqy/zMB6+JMpFAZIwELsCOiGz3O3eVQHZY8bfDsEIt/dr3ON6mpB5V9jy6YESqgrYJwo
         1OOOwsQ3FJ+sXFoLWakxbwhCJTJMwzFEmlrtZ5gyDJdR4j/5sWP/iu3f663UHkvCq1wU
         dC1Vf/FtrU3utpFaRyyVHMaUbNugVF3K3fYeqpbrEqisYvyJuN4Vin5GJqYVh1ZSXInO
         dMhQ==
X-Gm-Message-State: AOJu0YyCLo99xoyFbku+Uq03hIQf7BU3diV+aQ4sz7hFXYTpNHxIyiDB
	eMHAQH/a+XzXnWROVtqwc8OCBPwCkdOzZcsJxQpTxenyJ3ThcdJJ
X-Google-Smtp-Source: AGHT+IFDKcy9I/PlWx1YrgkkaDWAk/kwcNWYX3XgFZD2li9As1TQCHHsVUpu97FjxwrxBFk1RzZYIQ==
X-Received: by 2002:a5d:6481:0:b0:33b:1b14:a93a with SMTP id o1-20020a5d6481000000b0033b1b14a93amr600789wri.69.1706795171927;
        Thu, 01 Feb 2024 05:46:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXQq1KKiH4YUpiZz6T97SMNSIrGvfYkCGSUEWqTTAPjRIP3miTnFwqPl6HLjUy/HlvupXtSbLZlcl3yoL1aeETzf3d7qhup5+CYV/YSEx05YfhDWCAb1BPhmRBOuHXhV1ILD80X0uojgOs/jA4GWfmikSpcyuvfzoKJ2XKP0WZQc1gmoPzJEX38znRRJM4ArJds1FIScDxL1KorbrOwjRK5htwkvLRH13xq553Spb10P2o06USmuQW/U7d9LP/bPecVwvtgzXpSUyuBTEym1eqp1TgHDeebbXPtOFnkSoX9I0twrqmcewojUbgBtloOnlOB4nPEd/ObCrcv0MyH9tpfifcTAllWctMKKycF55o+2UA52jIp6nyEF+UC9eUNyD3XOPrCsw7ilzVOcA0DjQlyEhqafTP0rOmmXU+PgAI=
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b16-20020a5d6350000000b0033aeb0afa8fsm11691259wrw.39.2024.02.01.05.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 05:46:11 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH 1/2] net: phy: qcom: qca808x: fix logic error in LED brightness set
Date: Thu,  1 Feb 2024 14:46:00 +0100
Message-ID: <20240201134602.11085-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201134602.11085-1-ansuelsmth@gmail.com>
References: <20240201134602.11085-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In switching to using phy_modify_mmd and a more short version of the
LED ON/OFF condition in later revision, it was made a logic error where

value ? QCA808X_LED_FORCE_ON : QCA808X_LED_FORCE_OFF is always true as
value is always OR with QCA808X_LED_FORCE_EN due to missing ()
resulting in the testing condition being QCA808X_LED_FORCE_EN | value.

Add the () to apply the correct condition and restore correct
functionality of the brightness ON/OFF.

Fixes: 7196062b64ee ("net: phy: at803x: add LED support for qca808x")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/qca808x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 0f549027d899..00db4b274264 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -820,8 +820,8 @@ static int qca808x_led_brightness_set(struct phy_device *phydev,
 
 	return phy_modify_mmd(phydev, MDIO_MMD_AN, reg,
 			      QCA808X_LED_FORCE_EN | QCA808X_LED_FORCE_MODE_MASK,
-			      QCA808X_LED_FORCE_EN | value ? QCA808X_LED_FORCE_ON :
-							     QCA808X_LED_FORCE_OFF);
+			      QCA808X_LED_FORCE_EN | (value ? QCA808X_LED_FORCE_ON :
+							     QCA808X_LED_FORCE_OFF));
 }
 
 static int qca808x_led_blink_set(struct phy_device *phydev, u8 index,
-- 
2.43.0


