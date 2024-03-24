Return-Path: <linux-kernel+bounces-115891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CFC889882
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFA729DE6B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CBB384868;
	Mon, 25 Mar 2024 03:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnsg/u6h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23721474A6;
	Sun, 24 Mar 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322085; cv=none; b=I0Xsv4jRsrOUqeLmpRzjNAX3WCXjRDZcjCfDUHZWUqL4qJQdGN+S8fTwiuAgOc1lYWPiKdm9Imp8WDq8r7ETRmCA06kspngBKuY0LP4V5FXryKhxhnNnBHqoAKhVLpNkwthii23wx7nM5xUE/DpoqLs2kDdKAz3lzMkNg+s2KoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322085; c=relaxed/simple;
	bh=VNclXew3OYmQdcZ91mzGQyicAkl80ociEU8G6DjugSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uOnnjBVvUBwbKf34XRlNMptfrATbkyMmwzO8ccKDcgs/0zuX9pPXsogG+PwsENrzzwUAekWxNE44EKa0GX6Kupt1ufHOgcA+E8Q6tCy4Mb0y7fwkSQC3ZmvMQE0g5zmk8et8LzzN2go7Lj09sWEzQkSTvTaavhMqyv+c29kkhOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnsg/u6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9C1C43394;
	Sun, 24 Mar 2024 23:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322084;
	bh=VNclXew3OYmQdcZ91mzGQyicAkl80ociEU8G6DjugSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnsg/u6hxFDSt7rMKUZ80bOdvgFl8lVkd0LhHqPu1J+NfP0PqNg/GgDW1pray/OQU
	 smZgFu+TlWHQdFhxu8IpM60Dr8W8h1xb4RjS4hp4VEdG5YnuBQzgX3BrnipJkE6ckN
	 vwgJBowe62UFzVlWn4gMrYN6BpUxl6r0aD8ez17ES/92BUptqGTEXoFJHs1TrmQn9O
	 XwiYAK4phKFTij2dOkv5eAFIY8cBejYF2ScWU+foA5rmWCn3jzjOJDeAyHe5T/Bu9T
	 SZX+Mw7nP8Dc/6dnrVki1yjpIcGNr3D3BReIhqehKvP5NsH2kLtjR0HkxwX6bKMRLy
	 y7PwOJeQfb5RQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 158/451] arm64: dts: qcom: sm8150: use 'gpios' suffix for PCI GPIOs
Date: Sun, 24 Mar 2024 19:07:14 -0400
Message-ID: <20240324231207.1351418-159-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit af6f6778d34cb40e60368e288767f674cc0c5f60 ]

Linux handles both versions, but bindings expect GPIO properties to
have 'gpios' suffix instead of 'gpio':

  sa8155p-adp.dtb: pci@1c00000: Unevaluated properties are not allowed ('perst-gpio' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20231111164229.63803-3-krzysztof.kozlowski@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Stable-dep-of: 7c38989d0f7a ("arm64: dts: qcom: sm8150: correct PCIe wake-gpios")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index eb1a9369926d2..b829a9ebc5670 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1822,7 +1822,7 @@ pcie0: pci@1c00000 {
 			phys = <&pcie0_lane>;
 			phy-names = "pciephy";
 
-			perst-gpio = <&tlmm 35 GPIO_ACTIVE_HIGH>;
+			perst-gpios = <&tlmm 35 GPIO_ACTIVE_HIGH>;
 			enable-gpio = <&tlmm 37 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
@@ -1925,7 +1925,7 @@ pcie1: pci@1c08000 {
 			phys = <&pcie1_lane>;
 			phy-names = "pciephy";
 
-			perst-gpio = <&tlmm 102 GPIO_ACTIVE_HIGH>;
+			perst-gpios = <&tlmm 102 GPIO_ACTIVE_HIGH>;
 			enable-gpio = <&tlmm 104 GPIO_ACTIVE_HIGH>;
 
 			pinctrl-names = "default";
-- 
2.43.0


