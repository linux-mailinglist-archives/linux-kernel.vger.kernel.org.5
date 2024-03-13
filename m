Return-Path: <linux-kernel+bounces-101608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9076887A94E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4682B288492
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCB747A5C;
	Wed, 13 Mar 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WLt2UkdB"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897145C10;
	Wed, 13 Mar 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339348; cv=none; b=remwsuxYWmgx+6jmHVFEf2FIb/NQg+RzIuuKtunwRgxMwBBxQUMKp4wnLqDtDDkffp96MOBLqpzM8+IZVdRfH1UTgpjPX+6gVQe1f+tkn9OTmao9lZ133PSBK7G97oa10fInCoN59dPOLsitd4Vz9uNXLiZk2HOsrb1sjAi4I+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339348; c=relaxed/simple;
	bh=2aHPM6sJ6sr2k1ypbMOTbC3hJmk8XkC7o/w5nWOJzos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xya4KJ0EaHMNRrERyv2cOsZQIyQby4Re/1A/gvGGrtDRbGE6cOVXiD3+dF1YhgSaCjgQBTJBd7QBPagFKV1MwEq10jSD8x/PsU8xS2WOtHpOyOI7sIcnH+cx0Q7OsRzeDP/0+3uB9aUH7zDCSTard1ORnLwmTvo9j57sIDZucGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WLt2UkdB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710339344;
	bh=2aHPM6sJ6sr2k1ypbMOTbC3hJmk8XkC7o/w5nWOJzos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLt2UkdBLu+ggBJcjJJM9749HQcF9AS1rsY79l6NnjQ0Y+AFuvCWj/JbsyynuCitB
	 eiE+7+HjHei0H2CCaU3UuPvI++S4+xa8sqciRVZuJNIvbF/TExWQvWncJOfHFUx9KR
	 ePGs6EnihYK82QW0QqXPvMV0H58ZZi030SGbDdqJPsQ+zQ6Dy7E/eD3yx0JntNVVPv
	 Wii06Mj45xrSA6nPzSTQPC8gnJ0kL6UOgzmjaPLahZr3cFTaAJ0wpvET/GI9J7WI1H
	 MVyn/Swsubhxh5EROmqPENbE8uf8TFxUhWdOJkdJQ6Ab7CTRMwIJDBV/ErjntACGLh
	 s1NYnnMde3COg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 13A2737820D6;
	Wed, 13 Mar 2024 14:15:44 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH 2/2] arm64: dts: mediatek: Add missing chassis-type to MT8192 Chromebooks
Date: Wed, 13 Mar 2024 15:15:38 +0100
Message-ID: <20240313141538.1438167-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313141538.1438167-1-angelogioacchino.delregno@collabora.com>
References: <20240313141538.1438167-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

None of the MT8192 Chromebooks had their chassis-type specified: add
the right definition for each.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts      | 1 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r5-sku2.dts | 1 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts    | 1 +
 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts    | 1 +
 4 files changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
index fd2cb8765a15..ac2673e56fb8 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
@@ -7,6 +7,7 @@
 
 / {
 	model = "Google Hayato rev1";
+	chassis-type = "convertible";
 	compatible = "google,hayato-rev1", "google,hayato", "mediatek,mt8192";
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r5-sku2.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r5-sku2.dts
index 3127ee5f6172..cd86ad9ba28a 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r5-sku2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r5-sku2.dts
@@ -7,6 +7,7 @@
 
 / {
 	model = "Google Hayato rev5";
+	chassis-type = "convertible";
 	compatible = "google,hayato-rev5-sku2", "google,hayato-sku2",
 		     "google,hayato", "mediatek,mt8192";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
index bc88866ab2f5..29aa87e93888 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -8,6 +8,7 @@
 
 / {
 	model = "Google Spherion (rev0 - 3)";
+	chassis-type = "laptop";
 	compatible = "google,spherion-rev3", "google,spherion-rev2",
 		     "google,spherion-rev1", "google,spherion-rev0",
 		     "google,spherion", "mediatek,mt8192";
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts
index 0039158c9e60..5e9e598bab90 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r4.dts
@@ -8,6 +8,7 @@
 
 / {
 	model = "Google Spherion (rev4)";
+	chassis-type = "laptop";
 	compatible = "google,spherion-rev4", "google,spherion",
 		     "mediatek,mt8192";
 
-- 
2.44.0


