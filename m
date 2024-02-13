Return-Path: <linux-kernel+bounces-64351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74330853D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC06284057
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E4626A0;
	Tue, 13 Feb 2024 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5+yhd7J"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4A6215E;
	Tue, 13 Feb 2024 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707860417; cv=none; b=PdJqEArm/APJh7+Aj2IbG5Wppzulsm27zpoRbRLKvMHGlFWQ748VFXhKjDt5dAKiyTEiH+iLUppDLmtbS55+yLUicntRlKBiMYPmkNdnJrhGqBzzN5UpTyuABFmjOLL/i2wvKKWSTSUCFyauO193FaOVZzjMXNPS14wMiVTbt3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707860417; c=relaxed/simple;
	bh=/WQVGD5RStqq2TMulnJzeOS49hKDoHVe7AeXru/8hBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S3gWONR9oAPMCO8MX6Ym2TgAG+3I+1e6LHQvp2pDgxYdS1kBKzLwpCWKWnpPDVpXE0D8GINrZikr2H723kvYm8112Z27OoM8BcHn16loF2pLiqTMpM7zIM6eQtzbQMpChnLu4z257PCvvJe+VTZ0GyAOzriayYy935dpXV4HvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5+yhd7J; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-561f78f1ba1so1247585a12.0;
        Tue, 13 Feb 2024 13:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707860414; x=1708465214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awRh8a2uyaBPV9HuU86fl9/hVsMJE3K/Mn7kByHoWp8=;
        b=C5+yhd7Jza1ba9wcKR4TsGyHyOpzbvcpFXfTHdRugdcx02wLxcwDXMKr8OfkkSDABd
         Zg6lu2NMCJIRplumzSeoMVaXapRVU6Hsos75wpAbN82D1EMbBSoY9mtiI5poRPKG7oTg
         +VyMrV6LByiglEBwmzhHPr9siIo6xMy2A92hR5iwV197R7FpNTB5UsqNEV3UdYGomElz
         hb4NPnu7ao58f3lP4DunCGjapu9ZLypcvh3hNJYe70oeo8uxdLn1L9exv4M6mQoCnLxi
         ipP7Cg8Xnoo2ykqzZskhF2b14iyB7nv5qT+OnWBTi4dtz3T4DGWvInnLDmNqNJ7Uehrm
         3DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707860414; x=1708465214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=awRh8a2uyaBPV9HuU86fl9/hVsMJE3K/Mn7kByHoWp8=;
        b=kOcsO3bZXlm3bYwdJ/JOkXgMUbwuUhL+mpUfnV/AI19tbRz9wKRcRQh2MYBxIMKs15
         unlp5datRcd+YNyEn3Mr26YQMLe/79PfY0p3+QHx2U/G7vU6/bpmet5+6wBHf45us5TJ
         8wO72jpgag/HHqRd8khvsnFYvMd4dWxBr5PQ7OnjfactoC2ffXnULJy4z1DfNVjZvpXc
         AC8Y0Nnm9RmjFrsatyaTrfdAaZmIrIpzsKZjaYSZinzoYHAaCVTLy5k5MevJETwztsKy
         n6iJhBBdF+jlVCGd6pHmX5hBOX3Su3HP5rB3WH3o22+/r0cjqhdFCZa1FHVEWsZ+yhNP
         WhCA==
X-Forwarded-Encrypted: i=1; AJvYcCWQpe338CMAcdCtMVz39/ZuQKj6sf3UYo9nFdZBrQtMah5pQNB82Cjq7pIuWOLfxVGmfL4BBhJ+8bN2HHo2dEjbx0tox/UpFVOVgle3mSnvbj2gPeEB6QxYKznV9HFKsrlolE6F
X-Gm-Message-State: AOJu0YzFeLH45hY+203rSEaNH7KeR0Hu+Fo39axfqov3Ga9u/fjOSfUl
	/r4WJPFAEDyuOWu/DY5WwTi/F8uoybDddN5wgO704PR8/9avq8he
X-Google-Smtp-Source: AGHT+IEYwFCA39UE7hCEWs4q1hA9X0H3KrPNtsm/C7o7b+Pww/U91YEVPh3Vb/BmSW1ibaT22yy1/A==
X-Received: by 2002:aa7:cc8c:0:b0:560:58f:7148 with SMTP id p12-20020aa7cc8c000000b00560058f7148mr638144edt.34.1707860413619;
        Tue, 13 Feb 2024 13:40:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsaO4u9rpIs+1y8PWd/khMMJCSeZFy0zaJtdye8zgzb5aNPvoFlhWB/HS9Ik1inYAajPpS5SfSkDJfWWpnap0CMXATvTsJc+0cMKAFcQkwoTet9MNakNv5XzS1oPUITsxQfyiHsI6dzFt3LfDVa0GagN372FKTQNBLsGCD0cEvOTCVIR489uULtlBNlgA8UhK9MzvHFPL+0ptHvqMqb87PhVDHor4/KB7Nh6Nh6wYoSyfcjA5YoAjz3wL+9BaEVfOaw+GbkRyJToKcpHpSmIb8qri5ynrA0ivno6PghzohssOWayIcIHjTFL0bMyXBFj4QQvF/DSdyNlqCa49NHRxcNL0=
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id k23-20020a05640212d700b005612987a525sm4003913edx.89.2024.02.13.13.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:40:13 -0800 (PST)
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
Subject: [PATCH v6 net-next 01/14] net: phy: Add BaseT1 auto-negotiation constants
Date: Tue, 13 Feb 2024 22:39:40 +0100
Message-Id: <20240213213955.178762-2-dima.fedrau@gmail.com>
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

Added constants for advertising 100BT1 and 1000BT1 in register BASE-T1
auto-negotiation advertisement register [31:16] (Register 7.515)

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 include/uapi/linux/mdio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index d03863da180e..020ccc810d23 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -348,6 +348,8 @@
 
 /* BASE-T1 auto-negotiation advertisement register [31:16] */
 #define MDIO_AN_T1_ADV_M_B10L		0x4000	/* device is compatible with 10BASE-T1L */
+#define MDIO_AN_T1_ADV_M_1000BT1	0x0080	/* advertise 1000BASE-T1 */
+#define MDIO_AN_T1_ADV_M_100BT1		0x0020	/* advertise 100BASE-T1 */
 #define MDIO_AN_T1_ADV_M_MST		0x0010	/* advertise master preference */
 
 /* BASE-T1 auto-negotiation advertisement register [47:32] */
-- 
2.39.2


