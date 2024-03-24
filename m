Return-Path: <linux-kernel+bounces-116098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6563889943
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B161F314E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844E6178890;
	Mon, 25 Mar 2024 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="modGWoZm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4E27DE17;
	Sun, 24 Mar 2024 23:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323575; cv=none; b=U+F6ZW9nUPrQQv4OQajoz5Ee35/Yhgji35Lt/XzbRoh+CI4NZvf1arqkZiKzpt+3VpU8Jr92R2qIh8DFuhiR+uZ0B9shRMRSOAlCiKiSIKSTwE+EU03pzrISD0CvwW9bj0jC26UddaOCmjLDk3nkCzUPTp/4j/Rp4h6UgjECGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323575; c=relaxed/simple;
	bh=LTiDB7Xc8SEWG4fUaCdA0xEtUOyMZ07qxEs/UNO3qd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3yr8epNCIfp/L5gpNqlYRNxzZkJ0GCGMZrJDVwCZjo/QFNtCY2lWyj5vuRL3R4KtKQ3ZGHj1mh2QxoRRiaJLqcsSkXYnUtg/ao4kDrXJ3x3PfpK/GyRJSiIQ2L+4bauPe14lqOOGGO3ZKtq8xyoARnHO9WXARjP+2rEqWxZ+V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=modGWoZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF5CC433C7;
	Sun, 24 Mar 2024 23:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323574;
	bh=LTiDB7Xc8SEWG4fUaCdA0xEtUOyMZ07qxEs/UNO3qd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=modGWoZmcHIDzMeSrGkMxn0r3qEMA2y9P+g/YMc3MmJxu123unATuDAEgu8nqjrD8
	 3K2jkHeIUIgVhUstRwB3rtFrc87to4QjdVdm3+Vmpt+OZplGU/cCo7dgKIznL7U2qt
	 qLu1w/98dE6G28j/VWVbC+TQ170UB4Ua2w8z/AnoQBIB0JpODgCyR2quS8O5BMbcjT
	 qoo0MjC4cTfELlaPieoRc3SuIEqdcX0xlYEFaCRrfqkclCsgY4xvSBxBZBVnkN6Hww
	 jh1PqPAm6N+ezTryU5Gorl5iHxvh5Qf2k8ghQmZszc7kXDhjoYaJTjGK9n6OgfMDC2
	 yTTz9C2UPPBAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 281/317] arm64: dts: broadcom: bcmbca: bcm4908: drop invalid switch cells
Date: Sun, 24 Mar 2024 19:34:21 -0400
Message-ID: <20240324233458.1352854-282-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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

From: Rafał Miłecki <rafal@milecki.pl>

[ Upstream commit 27058b95fbb784406ea4c40b20caa3f04937140c ]

Ethernet switch does not have addressable subnodes.

This fixes:
arch/arm64/boot/dts/broadcom/bcmbca/bcm4908-asus-gt-ac5300.dtb: ethernet-switch@0: '#address-cells', '#size-cells' do not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/net/dsa/brcm,sf2.yaml#

Fixes: 527a3ac9bdf8 ("arm64: dts: broadcom: bcm4908: describe internal switch")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Link: https://lore.kernel.org/r/20240111115636.12095-1-zajec5@gmail.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
index b7db95ce0bbf2..d8e5796509fc9 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -180,9 +180,6 @@ ethernet-switch@0 {
 				brcm,num-gphy = <5>;
 				brcm,num-rgmii-ports = <2>;
 
-				#address-cells = <1>;
-				#size-cells = <0>;
-
 				ports: ports {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.43.0


