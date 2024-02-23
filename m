Return-Path: <linux-kernel+bounces-77988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDE2860DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 506BF1C211FD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE77159166;
	Fri, 23 Feb 2024 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JxAMC7yT"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB69381B8;
	Fri, 23 Feb 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679799; cv=none; b=izbU0HdFj0szate0WGZ83qTFHMRUBbf0E9BemwMhVOwdPnzk5wRGZXUQyy6r4Zvc+NsEeEL7wce29gcMholeMQM1PjZHRnIeX38Fk466v5z+3SNc/eNl5sFNMqD34u8G68Fv16wcbqwAkREICdJMMbof6vM5QhRJd7ZpjSuQz7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679799; c=relaxed/simple;
	bh=LCWP4a2omDbbmLAqYznvcYjUFf3rSAvzhTGo0BcCY3Y=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rTfag7kuwsTzVkBgiBs/UYe4dbBoyXE1piQRX84Yxn2Zuz5gsxQqa5fvGqMp2OzfR3jWBxWlc0pF5LeLUiL/FdHkUt5wIqm7JWtbitLM+ZlYh04+SB4yxXO90O/J4Ne+w1YihVKArjnyCbYCWhrLSUZVESnhIz1nBBdHYCPFEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JxAMC7yT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708679797; x=1740215797;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=LCWP4a2omDbbmLAqYznvcYjUFf3rSAvzhTGo0BcCY3Y=;
  b=JxAMC7yT5fBeNsFVYoERdyEPKIaF7OMu1Q7JRUXJYOuZC/7s7Klh0rj+
   rJQVtZPmXvW79rUpMplBtwFGIwsTKOSFdrUjrk/twZqIDr108+HsRIAs7
   0Od9/oR281nus3/zKQzr64YXXqyrjAXrBjfvFz5nwpA5h/1+jgtQvI/P1
   /euWKZs+O3z7AHjohy/yXYweOarQtoFKCGwmyX5fBtc6sC3GMCuSAdfhF
   gIlhc2cN/HnNvwiHEobWy5F/6H0ikcXVLzcuIrl2mnSmfAQ3VswBIJy/x
   WGJNJGjCnSOoSveq494ZAKl9Hd3Y5qautEnAahazCBiBwPKZbChBOd/dA
   A==;
X-CSE-ConnectionGUID: SUKQ20MbQ6GrA9O5LD3Fww==
X-CSE-MsgGUID: 9qux/SodTzWHmZbl6D18lg==
X-IronPort-AV: E=Sophos;i="6.06,179,1705388400"; 
   d="scan'208";a="183987161"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 02:16:36 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 02:16:18 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 23 Feb 2024 02:16:13 -0700
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Subject: [PATCH v2 0/2] Convert atmel-flexcom to json-schema
Date: Fri, 23 Feb 2024 14:46:21 +0530
Message-ID: <20240223-b4-sama5d2-flexcom-yaml-v2-0-7e96c60c7701@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGVi2GUC/x3MTQqEMAxA4atI1gZqRvHnKuIitnEMWJUWpCLef
 cosv8V7D0QJKhGG4oEgl0Y99gwqC7Ar719BddlAhmpD9MG5xsieG0e4bJLs4fFmv+Fs2spS57h
 vesj1GWTR9D+P0/v+AFGqTWNpAAAA
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, "Lee
 Jones" <lee@kernel.org>, Kavyasree Kotagiri
	<kavyasree.kotagiri@microchip.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Balakrishnan Sambath
	<balakrishnan.s@microchip.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0

The yaml DT bindings for the atmel-flexcom driver were submitted
upstream in a separate patch series in 2022 [1] which was Acked-by
Krzysztof Kozlowski. However, it has been observed recently that the
patch has not been merged into the mainline codebase.When attempting to
apply the patch to the latest upstream kernel,a conflict arose due to a
recent addition to the original device tree binding in text format. The
conflict has now been resolved and we are sending a updated version of
the patch.Also updated the DTS changes as recommended in [2].

[1]https://lore.kernel.org/linux-arm-kernel/22063373-6060-d605-62af-35d82ba1729c@linaro.org/
[2]https://lore.kernel.org/lkml/0798f21e-1ab6-4fd2-b7e3-18f35163fad1@tuxon.dev/

Note: The patch "[PATCH 2/2] dt-bindings: mfd: Convert atmel-flexcom to
json-schema" has dependency on "[PATCH 1/2] ARM: dts:microchip: sama7g5:
add sama7g5 compatible"

Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
---
changes in v2:
--------------
- Added sama7g5 specific compatible in DT with fallbacks.
- Added sam9x7, sama7g5 compatible in DT bindings.
- Replaced "Atmel" with "Microchip" in DT bindings.
- Link to v1:https://lore.kernel.org/lkml/20240214-sama5d2-flexcom-yaml-v1-1-5dedd0eba08e@microchip.com/

---
Balakrishnan Sambath (2):
      ARM: dts: microchip: sama7g5: add sama7g5 compatible
      dt-bindings: mfd: Convert atmel-flexcom to json-schema

 .../bindings/mfd/atmel,sama5d2-flexcom.yaml        | 99 ++++++++++++++++++++++
 .../devicetree/bindings/mfd/atmel-flexcom.txt      | 64 --------------
 arch/arm/boot/dts/microchip/sama7g5.dtsi           | 16 ++--
 3 files changed, 107 insertions(+), 72 deletions(-)
---
base-commit: ffd2cb6b718e189e7e2d5d0c19c25611f92e061a
change-id: 20240223-b4-sama5d2-flexcom-yaml-b071c28da959

Best regards,
-- 
Balakrishnan Sambath <balakrishnan.s@microchip.com>


