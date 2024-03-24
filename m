Return-Path: <linux-kernel+bounces-114167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4928888D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED8E1F26F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF27F247F85;
	Sun, 24 Mar 2024 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8O+rken"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80D72057E3;
	Sun, 24 Mar 2024 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321487; cv=none; b=A5BShMPSSjy0NDAMi7hy2TNZv0Eb/K6S2xF7tb68B3xX8H/1W11H4vtQqYFGFJx36eMvf7sLF2Bm/GhoNGbrVKkG2RsDNS4XBGZk+yxSbF6GJVTYb6Vea1jdAprRCUfCR5WK/85O63l7ouFlKOCbCenfiEBuJZXqF6bRk+UJyVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321487; c=relaxed/simple;
	bh=Fake0jZr2FyKfmP62QvL90r7SBLoesR2rcIVqlQGsqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFb7DbJ78b+guxzYNRm8+oHdaXb7rkzUBiF/Ch7ztR3UTQxOhOiWtEHT2Ai7TrL7U2N+z/kg1qLvtDNwzUlxV9GMTjZO/FRLaCtOR/UA0pq/+x0u9dn8mwHpM+14lYs0Dw+aIssyZlsv20ruz2OMKi2hkP56cjjLR/yQxkNW0Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8O+rken; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12AAC433C7;
	Sun, 24 Mar 2024 23:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321486;
	bh=Fake0jZr2FyKfmP62QvL90r7SBLoesR2rcIVqlQGsqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8O+rken1jXOVSRCG3uv1J1iivRKB5EDa8srJLMzmWAiLTw+1g2XuPmSyv5WcLs7x
	 BRaS4o/WnjGCdaGYqv9ze9J97lH0029/YPSmzLNgmYkfpK7Ndvxn7QEi8JaIGBLenE
	 j8LUEffaIE7s230lVr+rU85VToxIt1t369k09LTNpRRTplNDmZ/oXwTG/qcMVmExI3
	 2+WtKZ/ctijN7Vvh93Og/DMylCRhp7ITlK2Sb6EdCxySN30AA6KLThdB/TXgxDaTyC
	 lB6ZozFDgiezMYilhUGe9P6Xi2SphJaf6edmzwY71uxpCz92UtFU1y2Iy+YeeYlv6M
	 JxVoGTGP1FrWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 211/638] arm64: dts: mediatek: mt8192-asurada: Remove CrosEC base detection node
Date: Sun, 24 Mar 2024 18:54:08 -0400
Message-ID: <20240324230116.1348576-212-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 0e8b341170907..4bd1494b354c0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -1308,10 +1308,6 @@ cros_ec: ec@0 {
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


