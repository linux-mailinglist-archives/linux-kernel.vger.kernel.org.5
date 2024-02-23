Return-Path: <linux-kernel+bounces-78824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF015861959
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8BF1F23C98
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B782C12F5B5;
	Fri, 23 Feb 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Xh136TwB"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402DD186A;
	Fri, 23 Feb 2024 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708997; cv=none; b=f/AfU4g2vvYNUyF9ovOAJiZYUoE/I8IB/p7IguQnpeePRO1q9pl5QaZIHHshntvTyeGxKX78RHo3PJiXMFD0TF8LWz20gmPQPxYBzod7F7pFdvuL3YUYMNdAicNphMN4XuDN5203QxjXSWRrwHVCVS7KQcwHYy9QXDtREdqXSTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708997; c=relaxed/simple;
	bh=N3JiGSIuHPDoA9DuIr7Vrwk1kYjucAxaD+67rAGm5Lw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roOngCr34mAmAeFKfIsBZqVZ/YKk6KAO5ijR+utUS4ej3e7tbdZLfNCwBwzLp3SM9YUJnSXAzJ8m3Snr6lRIGir/mEgIpT1Ck9as19wz23HpjCK/b9bdQRHxTEySrttGQhbbPCF4Heemn+GYLiFtezY21xRjjkzI6sXHclnHQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Xh136TwB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708708996; x=1740244996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N3JiGSIuHPDoA9DuIr7Vrwk1kYjucAxaD+67rAGm5Lw=;
  b=Xh136TwBENiFRm4Q27ncYrZNQf6033W3YrgMaJnh8OwdB0QEIayWf59C
   Xzn9euZjmDe3ywIQZe3cjuMNmvQF8ODz4ZdqXi3wfsBX5O1HrJ4TT4z7n
   jebrdi932F/QVt0Zgq3tI+6tfSFxKmY8kJDjW6KpB60IAebQf0OhobjNo
   PVSOJdmnYb5ZO2Apy0OCx2i0oJv52J+tECD/GtaWIohqyrmfQOyVeuF3H
   A9f1kS4I4Poi2T24Njhtl/9S9YmpgnSqdsnwEeEH1FNV+fqL2jbXU5CHZ
   IMMgwn1oVNxl6Po3Bl9JXMC9esr4F3lTwWY+QkPMwVfILeJ+lkB2azZET
   g==;
X-CSE-ConnectionGUID: aMpctv24Qgyd0lLqchzPeA==
X-CSE-MsgGUID: FQ6J8jJpQr+9AOQUIOPwGw==
X-IronPort-AV: E=Sophos;i="6.06,180,1705388400"; 
   d="scan'208";a="247481201"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 10:23:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:22:50 -0700
Received: from che-lt-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:22:45 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH v4 01/39] dt-bindings: net: cdns,macb: add sam9x7 ethernet interface
Date: Fri, 23 Feb 2024 22:52:28 +0530
Message-ID: <20240223172228.671553-1-varshini.rajendran@microchip.com>
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

Add documentation for sam9x7 ethernet interface.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v4:
- Changed the fallback compatible as const as per the comment.
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index bf8894a0257e..2c71e2cf3a2f 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -59,6 +59,11 @@ properties:
           - cdns,gem                  # Generic
           - cdns,macb                 # Generic
 
+      - items:
+          - enum:
+              - microchip,sam9x7-gem     # Microchip SAM9X7 gigabit ethernet interface
+          - const: microchip,sama7g5-gem # Microchip SAMA7G5 gigabit ethernet interface
+
   reg:
     minItems: 1
     items:
-- 
2.25.1


