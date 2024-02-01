Return-Path: <linux-kernel+bounces-48256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4814C84592F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046E628D361
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5183B5F461;
	Thu,  1 Feb 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDyGRUj0"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6425CDF9;
	Thu,  1 Feb 2024 13:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706795176; cv=none; b=ZnpMzMkK5wj4fMT1LhbPw0X8M4yn7eJhYZBSQJ4RjPwNOUTmK6PHZNJlRp51L5HORDLwt+fPiDAMsimIX2Q3F+HKxOAO0SxfNixp6lsXPQZ8GbMr4DVbj85fFtU9102JbFl8yfPwMJI7E+0b3r0/r4SfV4JyhgT9gvuJHqA2nAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706795176; c=relaxed/simple;
	bh=phwZqH1fEaM4FYVACYhk06VJK88fgHRIPod217ZwYMo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch5uLN5kRgVEDAfty/61yOXUT4nLs+vZ1XLu5Uh26xcigctxGKM3f8EEGps3oqPHG5CzRSk7y2ZAHVh0blN7xMGPhAEQKx+E1ocf3oTENFhzXe5S1bGJPX4zedzTQzrlThShqzWhlgPlvGGewc4ktHSuUhLrN7XYYnYFyagsqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDyGRUj0; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51032058f17so1087298e87.3;
        Thu, 01 Feb 2024 05:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706795173; x=1707399973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ2XhJ2ku7B00kn4WBK5cWqlj8C1avq/4Iei1MyTst0=;
        b=CDyGRUj0p3SW/S7Wv/0WwL3ULAzTjPGVoAb/yLSscwlYhNiqVzkc7pPBTchcKax8+N
         HpJlMkVR4F+r5H4fYuHpP9++4xbkJbqLAMVQKqRmjIFRgTKMmNkTBaJpZ7OckldasNYN
         9omjKfDmkXEtRrdNkcniQi3Ky6KWmlwlAhza6OMFh4Z9edUQs2iqioifPpQ6B5QBvLy5
         09ba4qTmWCtQkTNAD+xc/JcT5CK27o950bgn+bVahWdYFcmZzc3G5UuICbuZ5wPvcDPn
         nEs3i9ntC7o1bDlWP/K2CgGLlW6Ewm7+5qhl0iAtdzrCX0+VhS1Z86h5qtt6IlrJg5vt
         DWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706795173; x=1707399973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ2XhJ2ku7B00kn4WBK5cWqlj8C1avq/4Iei1MyTst0=;
        b=iBMEA0TmIG9PCYof4exERIr/YiGciKUvwpjsbZ9zQW9w6xd/Xd1NCfxiD/KWYx6p0m
         oe7dpsH3eQtFd4kEuFHupQq93hlozusKZ/gycV2ui0f6YAlMNDOPTCV709SQi4Oi++ZL
         xxFHMR31V9ek84KlilYVUeBO/3UBupy6eBn1LMwwU+n6aHGRQFlwic0wbkFk3A3/K7wY
         iz7YG+RliryII6wSniysIkeN7dKf+kAiDv+hmIQElzu1UmPJMnfTWva8ew8EqQxG3BBy
         BnE7xS5QLuKiZqtAVkwYNpd0Qngcdt5FeYKr52tePGghohA73+Oq7Kig7C2h1MYSFlGI
         QQ/w==
X-Gm-Message-State: AOJu0YzGXPrfZbemIbbZQHxEOBY033ClNGV54OPpq+IADhfGZrG7dxGz
	NDXqcM7zBSL0F+dgO/yrDdv0wLGfbDTq2TJXJFm9JNfxJY7F6MBN
X-Google-Smtp-Source: AGHT+IEa30Xo+/QFE+CgM65n31+y/bk7M2A81JT+y9tnzkp13ytr75BKCJTEByqo3qmekVy0gI8M4A==
X-Received: by 2002:ac2:5999:0:b0:511:16e8:58ba with SMTP id w25-20020ac25999000000b0051116e858bamr2036307lfn.68.1706795172905;
        Thu, 01 Feb 2024 05:46:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWMbucVCeyWt0jHdroOlPbtHYMYzK7ja4URNBQHvKio1l1eks+KFR4oRNtlgNKuIkEvfBLhWSArG7lqVdmMMA6dk7rS2V3TeQoTvsg2Rkp7ObHRv9UbelkMKS9kzkDgtc9rkVKsRTxhjExrbuIfaiaFfJaysAytG4Bn1QSOzWfmt+iGakqVkdoK21/YpxDRN1tt+qRcijD1ZDnCON3UNj53XWxQVVlYavavcK9qxqfu0AtblgONF+/h8/qh5ijedurF5jrcUsf9gw+nSYlUHVKQiT+vszk45pGy2P4D2WUG5NtwBIpZCwZtdXFMw1+j9VnUJvt1v99h2n5ZiarLDBb5ShqFlvsQ2LLFHZcmmfsptTwlZM37h+OCl3Vf3r2HiBTcmjyxY4G1DAYA/ewevZyeEAinrPsv1PcrOM/b68w=
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b16-20020a5d6350000000b0033aeb0afa8fsm11691259wrw.39.2024.02.01.05.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 05:46:12 -0800 (PST)
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
Subject: [net-next PATCH 2/2] net: phy: qcom: qca808x: default to LED active High if not set
Date: Thu,  1 Feb 2024 14:46:01 +0100
Message-ID: <20240201134602.11085-3-ansuelsmth@gmail.com>
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

qca808x PHY provide support for the led_polarity_set OP to configure
and apply the active-low property but on PHY reset, the Active High bit
is not set resulting in the LED driven as active-low.

To fix this, check if active-low is not set in DT and enable Active High
polarity by default to restore correct funcionality of the LED.

Fixes: 7196062b64ee ("net: phy: at803x: add LED support for qca808x")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/qcom/qca808x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 00db4b274264..d88e04278fc4 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -290,8 +290,18 @@ static int qca808x_probe(struct phy_device *phydev)
 
 static int qca808x_config_init(struct phy_device *phydev)
 {
+	struct qca808x_priv *priv = phydev->priv;
 	int ret;
 
+	/* Default to LED Active High if active-low not in DT */
+	if (priv->led_polarity_mode == -1) {
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN,
+				       QCA808X_MMD7_LED_POLARITY_CTRL,
+				       QCA808X_LED_ACTIVE_HIGH);
+		if (ret)
+			return ret;
+	}
+
 	/* Active adc&vga on 802.3az for the link 1000M and 100M */
 	ret = phy_modify_mmd(phydev, MDIO_MMD_PCS, QCA808X_PHY_MMD3_ADDR_CLD_CTRL7,
 			     QCA808X_8023AZ_AFE_CTRL_MASK, QCA808X_8023AZ_AFE_EN);
-- 
2.43.0


