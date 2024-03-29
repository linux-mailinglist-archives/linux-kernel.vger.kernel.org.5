Return-Path: <linux-kernel+bounces-124836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B3891D02
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBA11F26776
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38911B882D;
	Fri, 29 Mar 2024 12:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvxcvI7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D113A3E7;
	Fri, 29 Mar 2024 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716261; cv=none; b=XSfGYxY2Ht/lj5boj3E40JIIuWqa4X8+/iKQOaIPnH0COvEG9IZEaKcFlCKz59ShwwUNDDcNf6GzM92vKBrb/u3LUIxKpungKw7LgD2HvjTgn2r6toLsFfZjv04tjEffO2aH5jkC+INAxrGF7GofQx2ngcWz3JR8Az1Uo7Z7aDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716261; c=relaxed/simple;
	bh=Zf9SH2KKIcmGWom4kI0psGsCEjWWApaXl+hwf9Dc73U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVoGB8xyzuGoAo018lxypPn1IHLTzog3aGpCGcwi6BFLrde/ipxkZZ1EkkIHdRY3QSPb/hwBLG93h64vMTJWTC+wYR06qivELdvqha0hhWdksfUqZbqL6LYafBsE+E9jNCnDdJV5xq5QN3uf0egDKbM0FwPGnydUF6ehR0Frp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvxcvI7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C124C433C7;
	Fri, 29 Mar 2024 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716261;
	bh=Zf9SH2KKIcmGWom4kI0psGsCEjWWApaXl+hwf9Dc73U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JvxcvI7S3QXd0xIiWZfd7ZWXdHy6gTu5Mhh12cUUoigI2dobiCmJ7+JPUswMq+2uC
	 CK4bkYwAD1z/U5JYgHaFPtwY4TO/Snzgh83UriCEWiUzgwTDRF/x4NBjoRXrK9OaE/
	 CTyHlF0WlEpOW3091JxftIAo8Ai/ebv123bEfZcYdYrES7yku6nXE/Fbbyk8zD+Lcr
	 ZJFqeimsGxhgLmDpcnQaBK4JOzKdbmfh6nW9H7Cq7WMsRTi1hwWi1xAtho91K2T+0c
	 8uT17W4rzlxvV3wp2Aa+K6wDShghPqU5UX8wGG3FrWjxBpxIP9vDppO1eZ59G9wkiv
	 AyRtlhlkAZ0BQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 27/75] arm64: dts: sm8550: correct DMIC2 and DMIC3 pin config node names
Date: Fri, 29 Mar 2024 08:42:08 -0400
Message-ID: <20240329124330.3089520-27-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit c6e5bf9278749eaa094dc944add747f10a15dceb ]

Correct the TLMM pin configuration and muxing node names used for DMIC2
and DMIC3 (dmic01 -> dmic23).  This has no functional impact, but
improves code readability and avoids any confusion when reading the DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20240212172335.124845-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 076715ef09d56..48c7dcca62764 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2290,7 +2290,7 @@ data-pins {
 				};
 			};
 
-			dmic02_default: dmic02-default-state {
+			dmic23_default: dmic23-default-state {
 				clk-pins {
 					pins = "gpio8";
 					function = "dmic2_clk";
-- 
2.43.0


