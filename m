Return-Path: <linux-kernel+bounces-24125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AC82B7E9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B978D1F21CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13B459156;
	Thu, 11 Jan 2024 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="on00Wa/e"
Received: from relay.smtp-ext.broadcom.com (unknown [192.19.166.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A88EFC08;
	Thu, 11 Jan 2024 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 149C8C001660;
	Thu, 11 Jan 2024 15:15:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 149C8C001660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1705014944;
	bh=RZEbF5rHXIeGL5qadO5zUtwdGFWIxLHURWRU1bfcIJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=on00Wa/eYWwY9KUfqVThcAcSAGtGlQKQfpPqO26SMPA1fjWI7cM3skzrDI+r6JQAt
	 u/adcT61FjMmNBTGEBjsf/BO2PT2lXkOP2ljfUk714Nt18SMB2ACVveoboj7ZwlVkj
	 CFP4rTzLikAqdNUIVvdQbgwy8IMgjWeiYpjdmYes=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 985A418041CAC6;
	Thu, 11 Jan 2024 15:15:42 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] dt-bindings: bus: Document Broadcom GISB arbiter 74165 compatible
Date: Thu, 11 Jan 2024 15:15:38 -0800
Message-Id: <20240111231539.783785-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111231539.783785-1-florian.fainelli@broadcom.com>
References: <20240111231539.783785-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 74165 chip introduces a new layout for the GISB arbiter which is not
identical to previous chips, document the new compatible that we are
going to key off.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
index 3aaefdbe361e..9017c5a3f3d2 100644
--- a/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
+++ b/Documentation/devicetree/bindings/bus/brcm,gisb-arb.yaml
@@ -18,6 +18,7 @@ properties:
           - const: brcm,gisb-arb
       - items:
           - enum:
+              - brcm,bcm74165-gisb-arb  # for V7 new style 16nm chips
               - brcm,bcm7278-gisb-arb  # for V7 28nm chips
               - brcm,bcm7435-gisb-arb  # for newer 40nm chips
               - brcm,bcm7400-gisb-arb  # for older 40nm chips and all 65nm chips
-- 
2.34.1


