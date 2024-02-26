Return-Path: <linux-kernel+bounces-80401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C292F8667D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625291F21E35
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881E9DF60;
	Mon, 26 Feb 2024 02:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="Vy/IF6A5"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0BB14F7F;
	Mon, 26 Feb 2024 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913458; cv=none; b=E4b4M++nqC5XrIBRnqImwV+YKNKi6qSgHKEucceNxuUQ2kuCimfJnn3TD3Jl/x5w8WQitnYvaqojLBFPfFLjwF643tz5qoFl5osmISJcTnSmRg16fnxVC8TPNKw3VJqtkNqYDBy+iISvCDDP56Y/bEeo3r6DKCNRoXXzyMkYduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913458; c=relaxed/simple;
	bh=1PGDAlwqkKduNR0qATzDOgp6IwGGdfJr+451JYSH7vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXSoir5UR5RnRIRiCjyXFJ06pDzlqwRrG1HzX2vrN+W8OLE4iPF+GOnkLygm06z9jyRaZal9bxkZwWC2N0hO70qmCQ827c/NazoNXx8UgD2HGkcqB/9WFdYqxUks1wqjKXJ1Xu8udhVEJV8ZFRcbWpx/Z4DNf+gZe4z9F1UeIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=Vy/IF6A5; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Tobias Schramm <t.schramm@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708913446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uByT/CuH2FQvqhN2Aqa6wrgcmxTYFdlYUbt9MyV6+lw=;
	b=Vy/IF6A5rHclKRF+PcTbsTLrMGt7tTjCwvRu8wxHuShA9zbSvDEZ5LdRmiqIw0KfDaME0n
	q31XKSx2JKtOUSuKJFuwzHLkvwbfsSeIklP0fPxNBIhK51uALmSW8k8YYF3s+tZH8nv2pA
	Bdl+IjQhvVKwAanIKGWZchxT23dC4jkPCDLqbpSITeCyVB1IHueopWPeL80wsYbUUF0ZK2
	B4Y8X0EeR0J1cKZ+JbrX1vn5Plht3FkpWsQ6nih9CiLnnY65id4nP6gNi+g6MpEi6YYJQE
	T5nJek/aAp/xs3mnG6JG40yZTBCcjMasQ2zJ7pfvFxU6J36eYxjD/EYvdoej6w==
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH] dt-bindings: nvmem: fix tlv layout I2C eeprom example
Date: Mon, 26 Feb 2024 03:10:17 +0100
Message-ID: <20240226021017.1470869-1-t.schramm@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=t.schramm@manjaro.org smtp.mailfrom=t.schramm@manjaro.org

24Cxx eeproms are I2C devices, not SPI.

Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 .../devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
index ee8ac322332d..4c981935f76b 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
@@ -104,7 +104,7 @@ additionalProperties: false
 
 examples:
   - |
-    spi {
+    i2c {
         #address-cells = <1>;
         #size-cells = <0>;
 
-- 
2.43.2


