Return-Path: <linux-kernel+bounces-155715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F98AF614
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184971F2469C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F498143865;
	Tue, 23 Apr 2024 17:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpD3jBuG"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99E13E404;
	Tue, 23 Apr 2024 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713895168; cv=none; b=Ujo+YG9GIwV+FjxE1f14zMdJtXDNOIifqN+JhFb+Cr2QDUUYXa5zEEIxszBcs8kXoIPsNfmM2CwUWQ2T+FhwG/BWFPzXIyP2gVrugCS7K3ool1sb+1z4MnUoKG9+wfNwlX4L45ACUPfXJp8Zfk3lDK7aXGzU2RplapJp9AFSSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713895168; c=relaxed/simple;
	bh=z3asK9ZnNJBdzXEtrEeLUepWgKog2SPt5U7wD8lPZV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WHIZ1aeV9fF40i0iGVv2iT3WhGGbD5FpIlt0Q3KetV2ZeNOr0FyAVzVnyuuIOrjTbMahavIhC6b25zq+QnDLAOHSsEplh8xU4Zd73nWInnLanBZ91l4JDRuj/VlYU7DkatKftHcKVywXSCQ8C/DqJzFE44Z2IHBZuJvq5XNZyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpD3jBuG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41a5b68ed85so622555e9.1;
        Tue, 23 Apr 2024 10:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713895165; x=1714499965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrHDO3czwVKAabC8YW+PusgYxVVJ2LCvn2W+dun83jA=;
        b=bpD3jBuGyXVnNBF5oKQyUYBj2saMArJ6zWLfdWDuYqrl1VO6IpjAQdGQRYAlHNIzkw
         GaRa9w2Uqrgt8KiwRuw4q7VKHg07pJr2OMblgj1QsoqsDU88DrL/9b2ZuQ+IKsQzrUUy
         CdW/S/zoWY+FUMxQPhihzVlUG5owsDQmIuX/py2gzMJZ44abkWzsbAPe8ZhfmCyd1gdM
         PMcoS5Cl9Jbagoy9xdlxcYWzaSoi94r7MadRf4NJwKSCZ/Wopy7+lq18YzU6K8Vydlq+
         ykkhYkiTcKZoJmBdKqu5mPTm3k//lngx8u4J1TMH1p3GfxDu7hjCJ6M6gwY1GrpdlEhn
         jr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713895165; x=1714499965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrHDO3czwVKAabC8YW+PusgYxVVJ2LCvn2W+dun83jA=;
        b=Mp5eH6dUuaBLsrDN2TrmH3Tnfis7/e5XG0q7T11G0S6/xRaWO8OMCevd7+Wv7HLpaf
         IpsVGk//6kbBQIc+4aKbQN6FoN93hX/H2OgL5qb1400+BkbN3fx8uqBvQO8bg5URZZpW
         S62kEm2avHTNN/nALi36w1PxQMrXUBEr0wOv+6Pm2RFNf5DZSBJ736J0W4yPHf+ELdpJ
         F0EtxozKhcPlsFNmwq7uKty+cIlFYlab9FVfusWLnShkKu9gi6jFPM/YC2dXTS98Rn8D
         QPm7fS9uUetGBJk4/2ACzTmq+7lrE6CS8/pkYiZfowPXLcChzETc1eGb0R82HF7zs3pc
         sWNA==
X-Forwarded-Encrypted: i=1; AJvYcCWJHz7B8cMdM4lpEmfL6//UbeTPJV5Xy/BZQ/woD/gePXdR55tk6eR5VUIW1KkGtxFYmOnpidpemZtYaK8DuEMdrsXMG35HtFZpVybyVK8jR2jxUycCwdwqlJ76dXOz04xdCyi/QA/qP5pK/3woTQl8eohXIkOHvl8PdmKX9k1ppwiyhrsiTz1i1Smp
X-Gm-Message-State: AOJu0YyQZyrvxN0UveEq4VbrbC/O+/4RgovxC9K+EmYLjtKRV70tAS0S
	zNfvUMJXwg/idDp7kd1ADyxa7GtFbiIut/UehcejVc5DTmcFO23Y
X-Google-Smtp-Source: AGHT+IGHykaCU420pnUiRngXe0DX+kV29P+oyaCbX7O8GEiCXyDu5ruf6hLKNfih+uNQlQQJvajEWQ==
X-Received: by 2002:a05:600c:1e2a:b0:41a:b42d:e6cd with SMTP id ay42-20020a05600c1e2a00b0041ab42de6cdmr139906wmb.4.1713895165419;
        Tue, 23 Apr 2024 10:59:25 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2500:a01:cef0:9ed3:1428:f85f])
        by smtp.gmail.com with ESMTPSA id fl5-20020a05600c0b8500b0041abeaaf7f0sm2808145wmb.28.2024.04.23.10.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 10:59:24 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 09/13] pinctrl: renesas: pinctrl-rzg2l: Add support to configure the slew-rate
Date: Tue, 23 Apr 2024 18:58:56 +0100
Message-Id: <20240423175900.702640-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240423175900.702640-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support to configure slew-rate property of the pin.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC->v2
- New patch
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 64648a951323..102fa75c71d3 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -120,6 +120,7 @@
 #define PFC(off)		(0x0400 + (off) * 4)
 #define PIN(off)		(0x0800 + (off))
 #define IOLH(off)		(0x1000 + (off) * 8)
+#define SR(off)			(0x1400 + (off) * 8)
 #define IEN(off)		(0x1800 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
@@ -138,6 +139,7 @@
 #define PFC_MASK		0x07
 #define IEN_MASK		0x01
 #define IOLH_MASK		0x03
+#define SR_MASK			0x01
 
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -1130,6 +1132,13 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		arg = ret;
 		break;
 
+	case PIN_CONFIG_SLEW_RATE:
+		if (!(cfg & PIN_CFG_SR))
+			return -EINVAL;
+
+		arg = rzg2l_read_pin_config(pctrl, SR(off), bit, SR_MASK);
+		break;
+
 	case PIN_CONFIG_DRIVE_STRENGTH: {
 		unsigned int index;
 
@@ -1236,6 +1245,15 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_dev *pctldev,
 			settings.power_source = pinconf_to_config_argument(_configs[i]);
 			break;
 
+		case PIN_CONFIG_SLEW_RATE:
+			arg = pinconf_to_config_argument(_configs[i]);
+
+			if (!(cfg & PIN_CFG_SR) || arg > 1)
+				return -EINVAL;
+
+			rzg2l_rmw_pin_config(pctrl, SR(off), bit, SR_MASK, arg);
+			break;
+
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			arg = pinconf_to_config_argument(_configs[i]);
 
-- 
2.34.1


