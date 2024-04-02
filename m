Return-Path: <linux-kernel+bounces-128635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58584895D49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3891F227F6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0715E1EA;
	Tue,  2 Apr 2024 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut7BQuHg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74715DBD8;
	Tue,  2 Apr 2024 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088481; cv=none; b=k1WNvZ03ehpdJ++hZlv6LMBDrUjmv+XQBdmLHS0r/EX+GvCJL8fhzdfOB5D14YFGt1NXA0glIJQUl339Jn97ml44Bo80Mwz5ivK0tp5Uyv2Ss16xcE6yQJha6bEIrkh+pmFNj8RXhudh8T5u5Rw+lCyg9FXI5qgQhTg7alLUq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088481; c=relaxed/simple;
	bh=RL4g3QKraMr4ilCufB+YzxuJP5dqpsp6P4ivPx03p/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tCuZalLMGgE2OjKAp8qxEIWMKcU3JeFyWo4/sFZmTRi9Xu9BBO2/36Va/sPFrfjxDas21nr8+1oTZZmYu4VMgrV6PltQWnDgfDIothewr69k8Zv9qigomS1l9AKb4yKE8uqfAQWInraH0Q3H1ctJFLdaSnMPySDNJ7dG4gce41c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ut7BQuHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915B5C433C7;
	Tue,  2 Apr 2024 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712088481;
	bh=RL4g3QKraMr4ilCufB+YzxuJP5dqpsp6P4ivPx03p/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ut7BQuHg/R5DzNWFOvRyngGAhDUEg5Z+n7LDUYmflTCyBtU3EuLjlpgOMqbCBjFRC
	 +AioEQnfSAo6DQHLnYb5EHOvbu6XdI6bbq9/wZhgeKS2QfpgncNext7vUSDbyGx7Q4
	 IFG9THAgSKaNhaA8jjhlJojKLjkFbCIFSX76fuN80j6TNg5czU2KSTDfwRx1f8YFBw
	 AK07/g4daXGRo04KMbfztO5o9nExS+HDY3nWz80imOziJQwc6pwxuIhn6sWRNezY3w
	 jmof1rb7i5Z1Q6VqpyceQ6l1kotAV6oXX2erOH/ovraitliUv96xCaYVAyfDdh4syc
	 deX9Rvob6+L8g==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/5] arm64: dts: amazon: alpine-v3: drop cache nodes unit addresses
Date: Tue,  2 Apr 2024 22:07:43 +0200
Message-Id: <20240402200744.79349-4-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240402200744.79349-1-krzk@kernel.org>
References: <20240402200744.79349-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cache device nodes within cpus do not have "reg" property, so should not
have unit address, as reported by dtc W=1 warnings:

  alpine-v3.dtsi:247.24-254.5: Warning (unit_address_vs_reg): /cpus/cache@0: node has a unit name, but no reg or ranges property
  alpine-v3.dtsi:256.26-263.5: Warning (unit_address_vs_reg): /cpus/cache@100: node has a unit name, but no reg or ranges property
  alpine-v3.dtsi:265.26-272.5: Warning (unit_address_vs_reg): /cpus/cache@200: node has a unit name, but no reg or ranges property
  alpine-v3.dtsi:274.26-281.5: Warning (unit_address_vs_reg): /cpus/cache@300: node has a unit name, but no reg or ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/amazon/alpine-v3.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
index 0ab40741f697..3099fdfa9520 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v3.dtsi
@@ -244,7 +244,7 @@ cpu@303 {
 			next-level-cache = <&cluster3_l2>;
 		};
 
-		cluster0_l2: cache@0 {
+		cluster0_l2: cache-0 {
 			compatible = "cache";
 			cache-size = <0x200000>;
 			cache-line-size = <64>;
@@ -253,7 +253,7 @@ cluster0_l2: cache@0 {
 			cache-unified;
 		};
 
-		cluster1_l2: cache@100 {
+		cluster1_l2: cache-100 {
 			compatible = "cache";
 			cache-size = <0x200000>;
 			cache-line-size = <64>;
@@ -262,7 +262,7 @@ cluster1_l2: cache@100 {
 			cache-unified;
 		};
 
-		cluster2_l2: cache@200 {
+		cluster2_l2: cache-200 {
 			compatible = "cache";
 			cache-size = <0x200000>;
 			cache-line-size = <64>;
@@ -271,7 +271,7 @@ cluster2_l2: cache@200 {
 			cache-unified;
 		};
 
-		cluster3_l2: cache@300 {
+		cluster3_l2: cache-300 {
 			compatible = "cache";
 			cache-size = <0x200000>;
 			cache-line-size = <64>;
-- 
2.34.1


