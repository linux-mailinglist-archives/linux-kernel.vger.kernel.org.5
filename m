Return-Path: <linux-kernel+bounces-65379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42017854C22
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7410E1C28705
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5CC5B5DB;
	Wed, 14 Feb 2024 15:03:48 +0000 (UTC)
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1435B67A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923028; cv=none; b=XdUOJpfE9LPeLACElXxx0lqlbMkuMhizm8Ti53XaxvOi/Vvep01RwNUmISwvkdHcpQWpSsWxOHKKp4TL5ZY+isBMMbjFhIEKsZsdcgbI+eKjTc46oRxcZnnr2akkJNKrAK0t9KZtolWA5anYXLD+wk8Z2JgbMWS3Oa8/wE9j5Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923028; c=relaxed/simple;
	bh=3vcGEY2nCwbKZOblmIruG0DS1Vlu/ShsWXJ73KL92qs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kPsHVLE6AEoWEV4Oc1dpxwYFwHiaN/r4hylZ0Ppv8XcbRC/fuutCF2WyxK4oSz5np9S5UXQM+nyTdLmpuSTtBFE70TmiFShV9K7VthA8sDG8CeIDehrrN1RwADK7U1nnOkPC+Y3OPckVC4yHooDNk2SGo6f9gIGJyzZwDAYXKRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:ac52:3a54:2a84:d65a])
	by laurent.telenet-ops.be with bizsmtp
	id n33k2B0060LVNSS0133k12; Wed, 14 Feb 2024 16:03:44 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1raGnR-000dDp-Bj;
	Wed, 14 Feb 2024 16:03:44 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1raGnX-00H2FP-VY;
	Wed, 14 Feb 2024 16:03:43 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steve Twiss <stwiss.opensource@diasemi.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: mfd: dlg,da9063: Make #interrupt-cells required
Date: Wed, 14 Feb 2024 16:03:42 +0100
Message-Id: <2212567f4c17251011e5e0bfa4ea0126d9815d39.1707922672.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'#interrupt-cells' is a required property for interrupt providers, hence
make it required.

While at it, move '#interrupt-cells' in the example to match common sort
order.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
index c5a7e10d7d80e8d7..e5ccc2708f0bb0f8 100644
--- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
+++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
@@ -87,6 +87,7 @@ required:
   - reg
   - interrupts
   - interrupt-controller
+  - '#interrupt-cells'
 
 additionalProperties: false
 
@@ -99,10 +100,10 @@ examples:
       pmic@58 {
         compatible = "dlg,da9063";
         reg = <0x58>;
-        #interrupt-cells = <2>;
         interrupt-parent = <&gpio6>;
         interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
         interrupt-controller;
+        #interrupt-cells = <2>;
 
         rtc {
           compatible = "dlg,da9063-rtc";
-- 
2.34.1


