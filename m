Return-Path: <linux-kernel+bounces-126709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0B1893BDA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD08B213A7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2C6405EB;
	Mon,  1 Apr 2024 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+9ovB+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3B4087B;
	Mon,  1 Apr 2024 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980562; cv=none; b=Y6+yqxoRGbbUK8PxAI6vsoJxFbXdZyHis1Z3eF3+ZfTqquabAIuLmVBYfqYamEmAt34Ow5Q9qk6Sv7D3VSqtWs3L4o4fv3BY2RoCTnCuyJjfIP2KLnTIinnBj5j9eJD8l9RTFbgKLDLEGpe5/pezxS4p5jKf2UGO3WO0FHKYl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980562; c=relaxed/simple;
	bh=MjLn/ZxyEKXQfrDIAdoaC68bOk5pn6t3AV30coNsd9s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cLaJmbDTkl7N6Ojknj1T+cdz9aqDUvq7yCY/52BcWZVc/JqKvWsxHu0ovOrfe/CAdNvnvLPReENGfjOj0vpzgP2+qY/Ac+PhIGgB5PMsVDfyjs9M8KFmroci44mspGX/JmjrspVCF5bmo382mM6MzFZ/6Do8vq2DsCGwjdpPH7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+9ovB+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648FCC433C7;
	Mon,  1 Apr 2024 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980561;
	bh=MjLn/ZxyEKXQfrDIAdoaC68bOk5pn6t3AV30coNsd9s=;
	h=From:To:Cc:Subject:Date:From;
	b=i+9ovB+PyjIWn2YU6RHz8rug6DSnIutLiQW+d+IQlPaN9x+1UGpQcAWeXNKnCjZeb
	 lK+Fn9rOWKtKysvE0kJSZZ9LfzWwFSI0Bemd6kJbK9orRMRB8hRwUIeWgZBgzPLgU3
	 IBEERvwiE8OrUgXtxe9Ug0ek8c6Z4VGkpLJIU5vpZ3DDVVS1jfy0IchgzNJvl/Tfbl
	 WbZPN0WA6ljD3k3NL2w5Db9nWEXUblPm/c7T8TV82iB/cELZvADKQ33w1JNEVUCSqG
	 d2p/njWcmiNrb00Nh/06BzuzbEsTjI7BfLQIm8mz7VimVQmt/EmqCv/f6F5SHT/XsI
	 bXw9CnMQwxhxQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-realtek-soc@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/3] arm64: dts: realtek: rtd129x: add missing unit address to soc node
Date: Mon,  1 Apr 2024 16:09:10 +0200
Message-Id: <20240401140912.97157-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"soc" node has "ranges" property thus add matching unit address to fix
dtc W=1 warnings:

  rtd129x.dtsi:51.6-122.4: Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index 39aefe66a794..ba50e292bdbb 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -48,7 +48,7 @@ osc27M: osc {
 		clock-output-names = "osc27M";
 	};
 
-	soc {
+	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.34.1


