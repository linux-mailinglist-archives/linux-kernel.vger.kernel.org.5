Return-Path: <linux-kernel+bounces-118055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072C688B30F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C391F35CAA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A127870CC2;
	Mon, 25 Mar 2024 21:46:11 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD059B52;
	Mon, 25 Mar 2024 21:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403171; cv=none; b=pf1Wjknr0u2XK8aMG+JBKqC6Xg8Po/OLZmPboS/dDnAVS/K2/V1nsJAyCVUKUfjnZVvprP1JLmBPgSrXmFk97gdPSpcXSLZlHOesSnRT45i7bzIPeg6RRwwtanY7DMN9rwexbMiQmHKJaPHft5P+flIKCAcgkgYN2YITOFUHeU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403171; c=relaxed/simple;
	bh=E354mpbtl7kB5B4qPT1fMZPDLn9W0lVPSKhkrego21I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZGZz1HdZN0lnc+Z0jw1wXuDQjS7AHtIXWhqByDZ4L+2Clfo3xcv7Uxg9UxES0wBNH8cvMC2CABW8o4xk+n2hBOxFkwp7e/mGPRxFMFssh65QCm2VANpuFm/xT1Zz0NO9hKeCdhV8WPgguVykQB3UA8OaOFQGw2Q1MLo0/epfb/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3D0C433F1;
	Mon, 25 Mar 2024 21:46:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 9F6BA106074E; Mon, 25 Mar 2024 22:46:07 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 0/3] Convert MIPI HSI DT bindings to YAML
Date: Mon, 25 Mar 2024 22:45:26 +0100
Message-Id: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbwAWYC/x3MPQqAMAxA4atIZgP90Q5eRRyqiW2WKq2IIL27x
 fEb3nuhcBYuMHUvZL6lyJEadN/BFn0KjELNYJQZlDUjxiJIF66SSFJAP5Jzhi05paFFZ+Zdnn8
 4L7V+ubWWK2AAAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1417;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=E354mpbtl7kB5B4qPT1fMZPDLn9W0lVPSKhkrego21I=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBmAfCYhr4JPtRZI9EAxNbkBGBIU58nfKmG25qAd
 z/QFgY6yr+JAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCZgHwmAAKCRDY7tfzyDv6
 mrb4D/44btPAOUN0pSUAJF4d7iQ2w4CbsYI8nS9gZ2sh3Ume3mFxrQ/HmQr252gorf8Ph0KJz1/
 erKejy7NjTZqn9Iw4gjRpo122m0NCUN0p28hmAijlWfjfsVbgdyEKPN3xUg55qBaspKAXYQsLtc
 p63IImKGOjwbiKWCBxopJJxm8N8VaMoM7zD8a0JKwnjq8IsG+sKPsvWN6YpZhOTQV0v1I1vcohP
 MobEiIO/DmjWaWLGtSvR1BdVxJ6LbnZoYqWcMq9Q9IbzV/orGTwavEskBFr7ipBzEjjOM6Mzhdz
 nkbVd4NcYAo4dHrFxjVLjv08TaVetrRYcfqwSLtUrXdL9iKSX5mXQ6890uL61ex0wyOG0+f+ebi
 Z5EkEuevbJrng3NXRry00rsJD3+DdmfV254QU3xAeMsQRZnKM2otfQXonTcvhi+h4wWq3XjJyq+
 d9n/1AiPnQWwRf9+APxY2jXNH9OQf8CT6JcgDa/3hRxkGxss1r6RD25zfyOr43pxUhGy2SWDLW4
 LQCmoTitq/BuZ5tMGEkdl3aLxDJoGodUjO3OepyVtfQ6CIapsIU9roUHlpSAhBqrHnOZy87Frhe
 JRKZ6bNGUbR8ziqb6xr6tZ5UYJK+GrOJRCl2LDlfE5XkFFKxPrTkfDUtTH1txQa6WqMdqhIr2Pj
 L/cyRLH6/5RK2gQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Hi,

This converts all MIPI HSI subystem DT bindings to YAML.
I ran the following tests:

1. Check binding files
   make -j$(nproc) dt_binding_check DT_SCHEMA_FILES=/hsi/
2. Check OMAP3 and nokia-modem DT
   make -j$(nproc) CHECK_DTBS=y ti/omap/omap3-n900.dtb ti/omap/omap3-n950.dtb ti/omap/omap3-n9.dtb
3. Check OMAP4 DT (OMAP4 HSI is not used upstream, so one is enough)
   make -j$(nproc) CHECK_DTBS=y ti/omap/omap4-droid4-xt894.dtb

FWIW I noticed a lots of warnings for OMAP3 & OMAP4, but
none related to HSI/SSI.

Greetings,

-- Sebastian

---
Sebastian Reichel (3):
      dt-bindings: hsi: hsi-client: convert to YAML
      dt-bindings: hsi: nokia-modem: convert to YAML
      dt-bindings: hsi: omap-ssi: convert to YAML

 .../devicetree/bindings/hsi/client-devices.txt     |  44 -----
 .../devicetree/bindings/hsi/hsi-client.yaml        |  84 +++++++++
 .../devicetree/bindings/hsi/nokia-modem.txt        |  59 -------
 .../devicetree/bindings/hsi/nokia-modem.yaml       | 101 +++++++++++
 Documentation/devicetree/bindings/hsi/omap-ssi.txt | 102 -----------
 .../devicetree/bindings/hsi/ti,omap-ssi.yaml       | 196 +++++++++++++++++++++
 6 files changed, 381 insertions(+), 205 deletions(-)
---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240325-hsi-dt-binding-a5d662e3d601

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>


