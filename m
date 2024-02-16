Return-Path: <linux-kernel+bounces-68963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD618582A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58C0AB21485
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1912FF94;
	Fri, 16 Feb 2024 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6vUJGqD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD3D219ED;
	Fri, 16 Feb 2024 16:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101255; cv=none; b=aFQb2GWjPant1KnYvl2/aSFqUCFMZ4q3PYb+6pfJc6gH1bXj54e/tqXlMqJEwtyRgQTNqH3vXsAm6Kz6JgS8UEV2QxXEPbVnooopo+/41HBv9fs16xEFNH66UJ8mmPxUPIJW+xZzTNk7bWMGQFGHEQYrPAUQlw8a7htwbPv6RX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101255; c=relaxed/simple;
	bh=PAYlbhU4FVr6ISJQH/LWFRXKfSB6vQ8ZEgnzc0wPFNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D0nxr8cgmcZfsd5Qd2CrNQHRmWj9YyLH3rgCQUqljcFib9/lf665To8iuuV32ARomc5uM+ZagF3MpaTPgVbkrNExif9EZukRwvKpPUQPJ8QG/xWXyPEWfjmwfSJ/SG5Z09W/rb/Dny2xlSMxcV11aNF9TnJMH4RiebVXnZLcUn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6vUJGqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3E2C433F1;
	Fri, 16 Feb 2024 16:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708101254;
	bh=PAYlbhU4FVr6ISJQH/LWFRXKfSB6vQ8ZEgnzc0wPFNQ=;
	h=From:To:Cc:Subject:Date:From;
	b=M6vUJGqDo8rcxNxvIhEAwgLujWIjhbZeRj9UBc7p99/yrphFh9puguzZubhEGOcAT
	 wjFEyfFkeGwQWxuQlHM23KEdJ4zfIjwZixpHUFyGNJ6Ym+gNZongWrlaCjdRl6m4yu
	 aielKv3xxsH9rZz6uaCuDnPg7BLB6r5Nsw9Tb734iTcMGAH1EZmLwXtRnsfNHln5DV
	 RzIjJqmfp0BahFDjOloW9Ja0zuGFVnDnl6pA871PCOrApHC3OL+xjix2NPnzkHbJ4C
	 bAAYQjVVlJ0IBACvP4hsW+7+EdEGThqaFdKEh+TNoHekCtKeGzcp0Hy2fWE/WTgj1y
	 TqKg7TO5yRK2Q==
From: Michael Walle <mwalle@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 1/2] dt-bindings: arm64: mediatek: add Kontron 3.5"-SBC-i1200
Date: Fri, 16 Feb 2024 17:34:05 +0100
Message-Id: <20240216163406.1050929-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible string for the Kontron 3.5"-SBC-i1200 single board
computer.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 09f9ffd3ff7b..32896f91ea38 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -357,6 +357,12 @@ properties:
               - radxa,nio-12l
           - const: mediatek,mt8395
           - const: mediatek,mt8195
+      - description: Kontron 3.5"-SBC-i1200
+        items:
+          - enum:
+              - kontron,3-5-sbc-i1200
+          - const: mediatek,mt8395
+          - const: mediatek,mt8195
       - items:
           - enum:
               - mediatek,mt8516-pumpkin
-- 
2.39.2


