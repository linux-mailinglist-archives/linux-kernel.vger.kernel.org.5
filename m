Return-Path: <linux-kernel+bounces-114118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A5988888C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D83C31C27857
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4129023E408;
	Sun, 24 Mar 2024 23:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/0OuFoJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9381131E4B;
	Sun, 24 Mar 2024 23:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321424; cv=none; b=Opi2egj2gkxntDfHDmGaa5birv4FHiPclZ0ZAvZd8mAkHBnT0eF97ysu632rvYhCLVgU2298bZ2AD2YldCEJLDRZRPRykdpoEKlh4fk4isftmlEPFeq456liZ1zcb+HIbVYt4cQicEndEtDsElKxQfIm7dbU4qxkKV4P0cPx+M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321424; c=relaxed/simple;
	bh=PVJc8pZkxA6f9s1tPFz0NNoNpg3KVXp8BIXzJI4bG6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipr73xURXbh0uww/VDQjG00BhNY8PECX5AEn8zagkjGebdHRdSto8hLPDmuArgbRp95qs+t98tCBBTTHXaAHNwkZWj/ZudVPgZ6iLkR7jWCBDv9+laSooqmk3SSucLatcSYYfwtL0Esyu6LaZd8dA39dWIfgYRVaAF+fybhpyFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/0OuFoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34CEC433A6;
	Sun, 24 Mar 2024 23:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321424;
	bh=PVJc8pZkxA6f9s1tPFz0NNoNpg3KVXp8BIXzJI4bG6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/0OuFoJK/IsPCNNN9MIkZc4WkgGg/tOYfwjk3Vrg8M3VD7QX1pSZfNQSAFQylD+w
	 XC4TezcOIMd3QWE0S6Z3QcAnIsN4WF4lbBUiymKB6hoZzZFUadbYiukMFtur9jsST/
	 jkSmvmYqpVIA6+oFC4Hc37XIJjS6ShmunqHaMh5GPaT9fJE+oaifMqhyWEVuvtjHPw
	 jK8mK0OCQF5usjXTTtCWkZcLV0wC1n2yaJSJ+rXU8DPd6Owm+rVueK+Go0Hzx/i2WY
	 i4bO5jnigJCG32/iBcARH4BTMA1kmc2HD8fH23RViAdkJKbqWvVxGfvF48ahgZg9hd
	 ZaVfKlZeI9GDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	Luca Weiss <luca@z3ntu.xyz>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 148/638] arm64: dts: qcom: sdm845-oneplus-common: improve DAI node naming
Date: Sun, 24 Mar 2024 18:53:05 -0400
Message-ID: <20240324230116.1348576-149-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Heidelberg <david@ixit.cz>

[ Upstream commit afe9867a0c0e10ba618c15d4ef6f8699872f6cc3 ]

Make it easier to understand what the reg in those nodes is by using the
constants provided by qcom,q6dsp-lpass-ports.h.

Name nodes according to dt-binding expectations.

Fix for
```
arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb: service@4: dais: Unevaluated properties are not allowed ('qi2s@22', 'qi2s@23' were unexpected)
```

Fixes: b7b734286856 ("arm64: dts: qcom: sdm845-oneplus-*: add audio devices")
Signed-off-by: David Heidelberg <david@ixit.cz>
Reviewed-by: Luca Weiss <luca@z3ntu.xyz>
Link: https://lore.kernel.org/r/20231229200245.259689-1-david@ixit.cz
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
index 122c7128dea9d..9322b92a1e682 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-oneplus-common.dtsi
@@ -485,13 +485,13 @@ &pmi8998_charger {
 };
 
 &q6afedai {
-	qi2s@22 {
-		reg = <22>;
+	dai@22 {
+		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <1>;
 	};
 
-	qi2s@23 {
-		reg = <23>;
+	dai@23 {
+		reg = <QUATERNARY_MI2S_TX>;
 		qcom,sd-lines = <0>;
 	};
 };
-- 
2.43.0


