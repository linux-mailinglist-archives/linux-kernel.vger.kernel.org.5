Return-Path: <linux-kernel+bounces-27995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8926882F8D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25680289238
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D53813A24B;
	Tue, 16 Jan 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkZvyuEN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D85BAF8;
	Tue, 16 Jan 2024 19:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434802; cv=none; b=t7RpZMbpPMUJ0oikNFujyRGaP8Vf4Ngq27Wp4oOl2EHyQPaofhHOPt7TdspyCIV+tKoiOUBPMmt1Uieg1nJFoQLzZRkWdGThHed7bsA6PKKRmgr4cv7fUr3NyTdRKS33AYJgD3m1DjeJwQmLyoifFU73d+wE9ALYWCRdjTtWXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434802; c=relaxed/simple;
	bh=vL6FaOdMuGmCGoPxudO+asE2oYL++SBY4Tu4nlZtGEY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=NVMeDTsKpICEMj3wOHIS4Bwv8EI4Cir3x5a2t/OlxqkYGFI6BjCgZhgmWa6w7Zn5WML1O/sRWhVOkiHqFK7IdNro8LsxDvtBuYJ7JpvBXvPU+0UuZhoQ5BLy6Tnumvj+d4c88tRaubGYgr9KTi7vOF4Wb1xZCx8TJRq72fu6SqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkZvyuEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DAB8C433C7;
	Tue, 16 Jan 2024 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434801;
	bh=vL6FaOdMuGmCGoPxudO+asE2oYL++SBY4Tu4nlZtGEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PkZvyuENQmrRyJM0YAfX7tr1GxA9u82CQLiGq6vLtGG0//CKh5NiTtiWUTg/xUoIl
	 PArtAI9Q8zGmJ4pY5IBNMokiKIouPmm3vzfBbu7G27GPH4PTWvovgawsc2WkJAE7aB
	 wMLWuBzr94VBDWZ2SHJWjOaz9Gf0imqOo9sQ+sfTg2aXjWWn90cFKz4lwlYhculEZf
	 mDHwj5oG5Si99r1dVSSLenXypfFC0WLiwX5rQg3d7ihRKeVySurEM7noNYqfhEK9M4
	 mxX0CXt3IYVGlh7eP29oSwkpZDckgPMP+q8yr91Nh5bSaEEuwyhLsi/TVZDBzgTu8o
	 SHzHa9R4RxAmw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mao Jinlong <quic_jinlmao@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	konrad.dybcio@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 083/104] arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property
Date: Tue, 16 Jan 2024 14:46:49 -0500
Message-ID: <20240116194908.253437-83-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Mao Jinlong <quic_jinlmao@quicinc.com>

[ Upstream commit ae5ee3562a2519214b12228545e88a203dd68bbd ]

out-ports is a required property for coresight ETM. Add out-ports for
ETM nodes to fix the warning.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
Link: https://lore.kernel.org/r/20231210072633.4243-4-quic_jinlmao@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 32 +++++++++++++++++----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f180047cacb0..f91c58c844af 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -2034,9 +2034,11 @@ etm5: etm@7c40000 {
 
 			cpu = <&CPU4>;
 
-			port {
-				etm4_out: endpoint {
-					remote-endpoint = <&apss_funnel_in4>;
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint = <&apss_funnel_in4>;
+					};
 				};
 			};
 		};
@@ -2051,9 +2053,11 @@ etm6: etm@7d40000 {
 
 			cpu = <&CPU5>;
 
-			port {
-				etm5_out: endpoint {
-					remote-endpoint = <&apss_funnel_in5>;
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint = <&apss_funnel_in5>;
+					};
 				};
 			};
 		};
@@ -2068,9 +2072,11 @@ etm7: etm@7e40000 {
 
 			cpu = <&CPU6>;
 
-			port {
-				etm6_out: endpoint {
-					remote-endpoint = <&apss_funnel_in6>;
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint = <&apss_funnel_in6>;
+					};
 				};
 			};
 		};
@@ -2085,9 +2091,11 @@ etm8: etm@7f40000 {
 
 			cpu = <&CPU7>;
 
-			port {
-				etm7_out: endpoint {
-					remote-endpoint = <&apss_funnel_in7>;
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint = <&apss_funnel_in7>;
+					};
 				};
 			};
 		};
-- 
2.43.0


