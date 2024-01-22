Return-Path: <linux-kernel+bounces-34001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903F78371CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A1A296692
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05785C60C;
	Mon, 22 Jan 2024 18:46:15 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2685BAFF;
	Mon, 22 Jan 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949175; cv=none; b=krrcYOZTHxFh4WLvjdBSFtm1C3LRBrQOrbokR0y5x8EI15Btg0fvUjM1CGz+IEWwOegVuXfQ42JBdIiSo8J6jcLSJDms3mXbGZOVYuGyYiJEHvu7w/N+Gv8Ygtnj6p7arGYSfar59y+TAUdXCHRSqsOhc9J9WOpJ/DqZLpGA2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949175; c=relaxed/simple;
	bh=NcxuZqC+E1xEpc49xIY4E115wKLTJ5ClsYrC0q9rTfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DA33MpVF/jZ4IzCcehfsPum3NjUHo+QSgExr9eJ2yqH+ualTREPMonkcxqpv1lphyB0zOK/ZJCa2jAGzZ+ffG9VSeyNqBQn65i4YU+0VMrMIHsTfhm9pB9jEQIscfIpthY4xFObssvH1mT3YPFxEplqMqG1IceZe5Lwb6XkhX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e67e37661so4785424e87.0;
        Mon, 22 Jan 2024 10:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949172; x=1706553972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VpxnwueBq4GNEX/wpNVnMayvbC9rT4Nzqh1oycVmTeU=;
        b=X0R0y/alLiLuPWQfoF0BKAfijW0rlm3chrXVqnnCr5xx6ckDuUAsYJ9IUzhYkQLQks
         OJqfohj092pAuXeo7gYm7FcJJHnK+WUZHONk3QLtjgRnSD/rkoFOufLLbwVLpFPlScOh
         cOLRgaQSson+Z+X6D9yqYKss5Pp72Rca4tE3njEHHjrjcoqDkMXXM2xDt09GylxuHDiT
         1D4IY2fO6jhoFwBxPgXh1M4w00EQe6aMo1IZ12XdqLb1xnI1uRgMQNSJO3EuXXifddCH
         ttMuKf9Jo50OX3B7Ji8DB66phxw0m8TuHhTLJZsPafOhWBLJdAnesMmct0rRvkZmvS6r
         dN3Q==
X-Gm-Message-State: AOJu0YxAIM5x8CEEVVuOzy8+KbBtIy/1ywT/TBvChkdqFF+EdRS3WLvC
	HHi/Bp09XlawVqhV5+9Jmr7vt0EitXjcw5+Dxk4fhH1y+GAxl9Rw8D2Q5vivl4Ra7w==
X-Google-Smtp-Source: AGHT+IFzyQpUAh/B3tFlqvgxnHIp0mSQ2ZOjy0kaRngrxG4UCaG0U5PVBPhvqrnmhorc77PgzQlbWg==
X-Received: by 2002:a05:6512:1082:b0:50e:c845:5be6 with SMTP id j2-20020a056512108200b0050ec8455be6mr2283475lfg.107.1705949172021;
        Mon, 22 Jan 2024 10:46:12 -0800 (PST)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id w14-20020a170907270e00b00a2b2c1a1b45sm13629218ejk.162.2024.01.22.10.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	abeni@redhat.com,
	edumazet@google.com,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Daniel Golle <daniel@makrotopia.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>
Cc: dsahern@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org (open list:LYNX PCS MODULE),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH net-next 03/22] net: fill in MODULE_DESCRIPTION()s for PCS Layer
Date: Mon, 22 Jan 2024 10:45:24 -0800
Message-Id: <20240122184543.2501493-4-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122184543.2501493-1-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the LynxI PCS MediaTek's SoC.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/pcs/pcs-lynx.c      | 1 +
 drivers/net/pcs/pcs-mtk-lynxi.c | 1 +
 drivers/net/pcs/pcs-xpcs.c      | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index dc3962b2aa6b..d51d09beaab3 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -398,4 +398,5 @@ void lynx_pcs_destroy(struct phylink_pcs *pcs)
 }
 EXPORT_SYMBOL(lynx_pcs_destroy);
 
+MODULE_DESCRIPTION("MediaTek SGMII library for Lynx PCS");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 8501dd365279..4f63abe638c4 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -303,4 +303,5 @@ void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs)
 }
 EXPORT_SYMBOL(mtk_pcs_lynxi_destroy);
 
+MODULE_DESCRIPTION("MediaTek SGMII library for LynxI");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 31f0beba638a..9c020dd3c766 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1456,4 +1456,5 @@ struct dw_xpcs *xpcs_create_mdiodev(struct mii_bus *bus, int addr,
 }
 EXPORT_SYMBOL_GPL(xpcs_create_mdiodev);
 
+MODULE_DESCRIPTION("Synopsys DesignWare XPCS helpers");
 MODULE_LICENSE("GPL v2");
-- 
2.39.3


