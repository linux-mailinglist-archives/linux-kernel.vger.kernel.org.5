Return-Path: <linux-kernel+bounces-113506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CE88884DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D2528517A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADD01BA67B;
	Sun, 24 Mar 2024 22:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0X7Ky55"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE81B9DD7;
	Sun, 24 Mar 2024 22:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320307; cv=none; b=Kke1+w9DgqSngmtQzzzq7P+kkcy3XgPLh6UbriHtDq6B4PC0IeEt/P7FdTUI9QxCqhLIL0FiJyUubNsXirklCIOasFLXmbKSa8EpQ2WKNWFeaEr2OaezONAc1vqrBVr31Dr96sF8G/Wlmyyi6xznIV2/dQiTJY33aiojBmDaiYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320307; c=relaxed/simple;
	bh=5zjY/KlVyzCbKB6HOQyFACW1AXvTWRQ0DVbNGJ0liSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbgpjdDkX2JWG0T7ikjuA5HHplxJcmvaQEQ6Vtm+ZtWcrCxwqcDej3zF+USMyApxiK6CH/oWfaxip1ZbDfgZ7W6TW6V6IriZ3t4WX5tJQkjYXZp3Lcjbdj015QW1/LQ3Yppi6f3OnpX5tTPlT7mnhrfHI2oMhEYDj+gVqBtcTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0X7Ky55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8520C433C7;
	Sun, 24 Mar 2024 22:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320307;
	bh=5zjY/KlVyzCbKB6HOQyFACW1AXvTWRQ0DVbNGJ0liSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0X7Ky55f3P3Y20fjXT7uZw3ATOt957scEVpMUhStsSvNQ2fh/TPbanYjl3xXzQsL
	 BiyVmX210BKRvoug662Uu+ujLnbG5aNmSGengfDiI/G/RxYPkhS0qK/CLCHgyHWSaI
	 lRpxYd9hKCTlIkI90xhvJ3koZYGrOus1Pw9r8qAuePWg7dsG81h4Ht8yTctD4+q2QD
	 dG9ILpF33l/jGgixvhqmT5b7kslw0koKDOAwP0sH5bWAnBGtK8XQAy7cDIzAJRej2B
	 xeVOPoQSiwdcVy37fxrG2zJn8jmgrMk5iZ76qdUZpGg5byZyGup6eMbK/FSMrdR9h8
	 EFve9HwXODm+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 615/715] arm64: dts: broadcom: bcmbca: bcm4908: drop invalid switch cells
Date: Sun, 24 Mar 2024 18:33:14 -0400
Message-ID: <20240324223455.1342824-616-sashal@kernel.org>
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
index 2f124b027bbf0..aadfa0ae05252 100644
--- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
@@ -227,9 +227,6 @@ ethernet-switch@0 {
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


