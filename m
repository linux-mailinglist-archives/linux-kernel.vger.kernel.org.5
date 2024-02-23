Return-Path: <linux-kernel+bounces-78874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224978619F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B705EB22FE5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF47146E6A;
	Fri, 23 Feb 2024 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sJQ8j/wf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224811339B6;
	Fri, 23 Feb 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709501; cv=none; b=tDsP4sSLauvaTLaF3+r7kD8HD57f/ZNq88cz4zl78uSTodHg/INsQ+dfOHemuVeqJ6t5TM/4sQimbROww4or/4lz/h2uc+K8flU3LawoGcyDmNFeAzAjCKWeMTyG6PEptpnRx8vGLwL1Vdhzl5CpalAiz2mQF0rZfAHEABidVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709501; c=relaxed/simple;
	bh=NQDjiuxhF58mXKyJWxYmj/hWyCK7vQdrQN7AeSUfKd8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THycquKGhKCGz7eHch+L4btETHAL3E7+x8tfhh25Spgw6S4luDyiR5qD3k0ba9mb/Jjk4ZSrE3eNvYrPaWGFJmQbNkGdPArSaIn4TcRMPWv61VqFX4zDVqqiMlx3h/n06PDsB+kBOfB6BguC6SUoOmA0CZfujfV4P8XuwRiBqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sJQ8j/wf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708709500; x=1740245500;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=NQDjiuxhF58mXKyJWxYmj/hWyCK7vQdrQN7AeSUfKd8=;
  b=sJQ8j/wfx1oMty+s1BjuQc3vif4kzDVVIUuE2IRXhHqnWk5hWfJsNfu2
   GDjB/xTlxmOzTBHyXhQD5rdD5r3dqmOS+RYxWs9bnKAUeK7lOFv8kb/I8
   iG3THTB6qNF2i+4TYHQ6vtnMS5A1JAWzdzcVovfYWneg522p8pgfXG6qE
   D6kv0xmLbIWI/Iuw12f4fHCO+8VdSF+pzkeBlCdZxZ+PB7/HJGOqO4Z72
   LC2JLSIEnNIn+3bZc0HY4QpcagttnH6kIatDj+gqJrCCSh0AkH/jRs/1N
   gcgOlBfy+VE8YjiCYI8PIwp2gXmn0FE9r9dY2Vs8/ZMGtSrWdyNfmOLi8
   Q==;
X-CSE-ConnectionGUID: cmnte8hcQ+amw+QRaFDAqQ==
X-CSE-MsgGUID: /yQMBuK0QdWwiPxwTUPgng==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="17267535"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:31:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:31:12 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:31:07 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<mihai.sain@microchip.com>, <varshini.rajendran@microchip.com>,
	<andrei.simion@microchip.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 38/39] dt-bindings: arm: add sam9x75 curiosity board
Date: Fri, 23 Feb 2024 23:01:00 +0530
Message-ID: <20240223173100.673543-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223171342.669133-1-varshini.rajendran@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add documentation for SAM9X75 Curiosity board.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
index 89d75fbb1de4..d74d3a4701ac 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
@@ -106,6 +106,12 @@ properties:
           - const: microchip,sam9x60
           - const: atmel,at91sam9
 
+      - description: Microchip SAM9X7 Evaluation Boards
+        items:
+          - const: microchip,sam9x75-curiosity
+          - const: microchip,sam9x7
+          - const: atmel,at91sam9
+
       - description: Nattis v2 board with Natte v2 power board
         items:
           - const: axentia,nattis-2
-- 
2.25.1


