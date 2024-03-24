Return-Path: <linux-kernel+bounces-113076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5065E8893B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064491F2F44A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D5814C588;
	Sun, 24 Mar 2024 22:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsZLlwhv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3610E14AD2F;
	Sun, 24 Mar 2024 22:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319885; cv=none; b=WynrMIarzs/flDB3vVMjlvhqIHjy9Q/M9qo5/Wu0lZBX/YWo4goMD8OdQ0XCiU5mOIPjQOGjR4G0clzy3z2W014QNLlY5I4q3JFayHMugrLamCQhvp2W6/G5vzLF04I1QdtGf9CnJsx3UBQa1U8+8ExaUG9xu8qO1p1E2GWrOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319885; c=relaxed/simple;
	bh=Qqwg4J3ai484A6gC6stXIaNlROAtJFQ5aC1I52Ocx0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4ktnoEOhB86K4wG81xy85fo5/+t8GV8khSKcqVTBMsfIioK7j+SblWJ55tTgJxvrB6FAmJIAyxPDwJxGJ/fY/afekedV5l+OVOZFRoCcdQawtfSYW4M5YN/cUAW+kP9hbfIWr3Nq0jYMGt1OijKeao0XHLSpYpdB22xnTowJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsZLlwhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA50C433C7;
	Sun, 24 Mar 2024 22:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319884;
	bh=Qqwg4J3ai484A6gC6stXIaNlROAtJFQ5aC1I52Ocx0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jsZLlwhvMyy5y/D46Khc/CWfCJLUBx+elJ5LdZ2NgMS/tWhEujV1uuHtGxiJFeG3R
	 9ZBYf0ZU2YyOTFNaadDVT6+uvSgmUlwhHRH2UCaCuU9VOyTmUxNPpoEPNPvk+CaT3b
	 0jlySN53D2oNolgd1LIzespQf7dh4qDPvlkr7MwIzWtAfhjm43RHPHExD9L3WKFSrs
	 lTYyY1JQftzbGXajS+eCcY/lboby6LYAt9Wpx5PD2SnGi4fx+69ccsOeMqvZT1p1nh
	 Md6RkkOkD3OmRSgGUO6mptyGh9lu83/m6qy/9YBvFBTyAf8K5ZmAx8lmkwgDBzgeAe
	 Je77hAx+UweRA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 189/715] arm64: dts: mediatek: mt8192-asurada: Remove CrosEC base detection node
Date: Sun, 24 Mar 2024 18:26:08 -0400
Message-ID: <20240324223455.1342824-190-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

[ Upstream commit 9b49cabe631b0a25aaf8fc2ba81b5b9ea6ff01b7 ]

The commit adding the ChromeOS EC to the Asurada Devicetree mistakenly
added a base detection node. While tablet mode detection is supported by
CrosEC and used by Hayato, it is done through the cros-ec-keyb driver.
The base detection node, which is handled by the hid-google-hammer
driver, also provides tablet mode detection but by checking base
attachment status on the CrosEC, which is not supported for Asurada.

Hence, remove the unused CrosEC base detection node for Asurada.

Fixes: eb188a2aaa82 ("arm64: dts: mediatek: asurada: Add ChromeOS EC")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Link: https://lore.kernel.org/r/20240207-mt8192-asurada-cbas-remove-v1-1-04cb65951975@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index d87aab8d7a79e..d4dd5e8b2e1d3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -1336,10 +1336,6 @@ cros_ec: ec@0 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		base_detection: cbas {
-			compatible = "google,cros-cbas";
-		};
-
 		cros_ec_pwm: pwm {
 			compatible = "google,cros-ec-pwm";
 			#pwm-cells = <1>;
-- 
2.43.0


