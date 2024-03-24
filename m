Return-Path: <linux-kernel+bounces-115875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE29889863
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB0A1F36F75
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAB1264D6D;
	Mon, 25 Mar 2024 03:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRjs/Asu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C714600D;
	Sun, 24 Mar 2024 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322071; cv=none; b=Bc++NYhK14VoDEWhEjEo4tuG7ifLGc0E4eZnxlZ7TSZ5e0L6U+sJ3sB+AtYwrgSlVVkmjJDOr8DHlMGCQjt8SmoFYIWj+g+WanX1lIKqmDFK8TUzikGsHZf0gkN4muE+Ay06TYGru4uXpKzjk1lONYKBwg4Xa7FaQcoj8yBeluc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322071; c=relaxed/simple;
	bh=uJCqv3V1k+2AR08sm/BhVGFMwOgVtPbb1AUTtMRnzpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFIkqkU0T+jnjuQXEXmuybz+WmFxoWWcexZE/TLH8BgIeLp67xOQePn4lldtbMJg2mzEZR/KHHv41+aFvD3g7ba83zqO8/ap5ADR5DoggOaISsM5beuy2yi9TrPZN82iW+OAmaw+8jkHRMiMSgU5T9//iM+E5XCj4b45G/e3ShE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRjs/Asu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E1FC43390;
	Sun, 24 Mar 2024 23:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322071;
	bh=uJCqv3V1k+2AR08sm/BhVGFMwOgVtPbb1AUTtMRnzpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DRjs/AsuPYvEue0GAPQuZHJYWDbckmoA8F1S6k5Gqi9LLiBCrlOCOH1Du+8yQuxUK
	 3NwZMyO0Rt0RjxYS1BxZFG0hE8kYHFTX9vhnTXzvQG4UaF1S3E9HSuATN74FW4+be4
	 FDu4nd09x4/n1flesksOF7AS+F4Z9z1vW4YmLcfFw49riMRHSh0dDeb3+sh3lG7GA5
	 0NOUP2nqpYRUKQy0RqBKHP0ehXWsYMXIv5Z2FhxmxU9fB/QIN0KmbKn3KxDUIf0ikQ
	 spon3J/MosKOes26iiaKsbpgJfxV/7r9AnQ2dD2cjlKHyVikpkcYJUDQqev5BZ9EiN
	 3fRZ6PygxJnBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 144/451] arm64: dts: mediatek: mt8192-asurada: Remove CrosEC base detection node
Date: Sun, 24 Mar 2024 19:07:00 -0400
Message-ID: <20240324231207.1351418-145-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 50367da93cd79..c6080af1e4a30 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -819,10 +819,6 @@ cros_ec: ec@0 {
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


