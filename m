Return-Path: <linux-kernel+bounces-985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF6C8148DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACBC1C23ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49292D7AD;
	Fri, 15 Dec 2023 13:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFyw2OgK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425A347B8;
	Fri, 15 Dec 2023 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso7049185e9.2;
        Fri, 15 Dec 2023 05:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702646140; x=1703250940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkdT4x7u+h8nhlT6vy5UnmJ8k4AsKgQANvq11Zb9QZM=;
        b=NFyw2OgKOBJZlf8rorXfjPxp65W42Ba6sJbzy6/eJ0DvYIihrLnP4re+X126OJhgDu
         d4PcMPKXVmuF2G88j59t8tfhNYsScmHcOjGuEbxPaDSjL5p/fWQ3W7Z5TGE4bMc3x2Tg
         hYOaAVjHBrFusGoyTJLf3MihlQ+6uI6NVdpMS2NQCx5kiEWTrHTsgYwu7os5ShWH2i25
         3c4tUgRmMKr2JhA+kc0d0gO40biqMOuJ0drL6VIfis1QtZ+P9eft5MktKf/8iwngCHE1
         68APCGcJlo5sVqWq0bsdW1S8w/JunWhUFEfdqkvXeLZQk96RKoDvR4HUyqyXKgcKnIr2
         IzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702646140; x=1703250940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rkdT4x7u+h8nhlT6vy5UnmJ8k4AsKgQANvq11Zb9QZM=;
        b=l7wqWeGAgSczbA2djJlRmAG2PTBp8LevnoAr0jsJYLGvHniFayfF75WdauGWOehT+H
         XtQ+o2G5b4DWFPn87UbYVgOjljdNpLcSjEUKv0e7ZyZCjX1NqvgnumcMYeIh4zVg2rwC
         NEOqSbRaLmbK3fa2s96H3bZ8QdZtZhXNRcb8lADBDWYoTrDOcf45rNVjJohI9qju3oPT
         LOmwKHoboin2ZTcxQouPu8oFoCgB10IeuhJHVNr0v0r+7SpnUeVZ7qSwinLGXzICtUUt
         BJ/l1fzbVVkj5RBYFmI6CS+XhQ8l1TCE6C8Ik9e9aOz8p/8klc97ULwp9z3byl8l/uxl
         K+Jw==
X-Gm-Message-State: AOJu0YxTMcBzZe+sWclYaxntIN79wyYbPV6DOh5MNgpmcJ5UC/2JuAx8
	fX/tkLtmvDdDVJNT/4hphf8=
X-Google-Smtp-Source: AGHT+IF+AgEnmZ3p4PV2OjqFiRTJTeCASxbOj7bj5N3yrEyRogHvFDMvqSAzDQa6nUGTdk95oMa+MA==
X-Received: by 2002:a05:600c:378d:b0:40b:3f72:de79 with SMTP id o13-20020a05600c378d00b0040b3f72de79mr4256731wmr.5.1702646139739;
        Fri, 15 Dec 2023 05:15:39 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm21618324wmb.46.2023.12.15.05.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 05:15:38 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Harini Katakam <harini.katakam@amd.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v8 0/4] net: phy: add PHY package base addr + mmd APIs
Date: Fri, 15 Dec 2023 14:15:30 +0100
Message-Id: <20231215131534.7188-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series is required for the upcoming qca807x PHY that
will make use of PHY package mmd API and the new implementation
with read/write based on base addr.

The MMD PHY package patch currently has no use but it will be
used in the upcoming patch and it does complete what a PHY package
may require in addition to basic read/write to setup global PHY address.

(Changelog for all the revision is present in the single patch)

Christian Marangi (4):
  net: phy: make addr type u8 in phy_package_shared struct
  net: phy: extend PHY package API to support multiple global address
  net: phy: restructure __phy_write/read_mmd to helper and phydev user
  net: phy: add support for PHY package MMD read/write

 drivers/net/phy/bcm54140.c       |  16 ++-
 drivers/net/phy/mscc/mscc.h      |   5 +
 drivers/net/phy/mscc/mscc_main.c |   4 +-
 drivers/net/phy/phy-core.c       | 204 +++++++++++++++++++++++++------
 drivers/net/phy/phy_device.c     |  35 +++---
 include/linux/phy.h              |  80 ++++++++----
 6 files changed, 266 insertions(+), 78 deletions(-)

-- 
2.40.1


