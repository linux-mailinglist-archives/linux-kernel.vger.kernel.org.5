Return-Path: <linux-kernel+bounces-98068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62B8774B3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 02:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E0E1F212BB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 01:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FAA4C73;
	Sun, 10 Mar 2024 01:02:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF6217E1;
	Sun, 10 Mar 2024 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710032562; cv=none; b=gW5lVLroqf+8rqsgIzrINbnDkLGcw62DAb/ECL8wRzQmWUxY0n0IQQiW+UD15mQslbRADuWzUoie2StOnuu3suiyYlFm/Am/WGhaEKqMeep33b6oGgEeZFyGbale4+xM50U0mFRDHwR2ElVamV4ErEhRC+Z9t3J+3st+oUE4BK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710032562; c=relaxed/simple;
	bh=i7g3wGJdiq17dLGPes67IDV9eOsXTz6W5zl14/gfpPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DxGSeW3TOtpsWnq5FbKNdk+NYSC/BHa/Sbzj20B/lDgghc0diQf8D1tvo2S1NVWsEvi8MPqtOuldC23nxxF8XuobW4GXqR2N49ma9z0/CyWADAiV/JHbLNv6e8L6t6/lh2R6wbNuPCphhkYuKPQqmzOFqm/VS1LFanFXWO282/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A83CE14BF;
	Sat,  9 Mar 2024 17:03:11 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBB5D3F73F;
	Sat,  9 Mar 2024 17:02:33 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 2/4] dt-bindings: mfd: x-powers,axp152: document AXP717
Date: Sun, 10 Mar 2024 01:02:09 +0000
Message-Id: <20240310010211.28653-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240310010211.28653-1-andre.przywara@arm.com>
References: <20240310010211.28653-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The X-Powers AXP717 is a PMIC used on some newer Allwinner devices.
Among quite some regulators it features the usual ADC/IRQ/power key
parts, plus a battery charger circuit, and some newly introduced USB
type-C circuitry.
Like two other recent PMICs, it lacks the DC/DC converter PWM frequency
control register, that rate is fixed here as well.

Add the new compatible string, and add that to the list of PMICs without
the PWM frequency property.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
index 06f1779835a1e..b8e8db0d58e9c 100644
--- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
+++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
@@ -83,6 +83,7 @@ allOf:
             enum:
               - x-powers,axp313a
               - x-powers,axp15060
+              - x-powers,axp717
 
     then:
       properties:
@@ -99,6 +100,7 @@ properties:
           - x-powers,axp221
           - x-powers,axp223
           - x-powers,axp313a
+          - x-powers,axp717
           - x-powers,axp803
           - x-powers,axp806
           - x-powers,axp809
-- 
2.35.8


