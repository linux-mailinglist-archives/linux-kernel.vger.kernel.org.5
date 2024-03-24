Return-Path: <linux-kernel+bounces-114208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ECA888923
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E4AD288B44
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58998158D7A;
	Sun, 24 Mar 2024 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iFHOWFJc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8A2081E3;
	Sun, 24 Mar 2024 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321541; cv=none; b=d6rvY5fbHJfq+EZVhCV5W+eqEIonZ0PHLdvBzmLT7l+PJ8LlyBqAtfX3lyiaBGvG45tSkHBqX+Yb5MYvFG5hfR/YG1Uk304zZbMihZ28OuxPRtHzQz3l7644zkBiDlEKx2cK9O4Avnha/svHKMtD4PXmCxWB+3RmxHEnF8EUv50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321541; c=relaxed/simple;
	bh=ND4MKUcYcMyYShL2dADwCd1T3/24PLG/95Zp8DoRkb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCmxn9YYSHPGgs/b41tt7AsZI6WOQPGkeIJi1aExXUaZl8ib/VhbsBZo6QTJQfoD6jznGWXZukXqFvcS4vYmfLFUOhM3P1wQUPLuyLUz+OSfqlA5ZewfI9BZARUfWd9m4tJldh4F5dnVbQgONuyBPM87DiZ5JtYbRMm56gkxHiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iFHOWFJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D59C43390;
	Sun, 24 Mar 2024 23:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321539;
	bh=ND4MKUcYcMyYShL2dADwCd1T3/24PLG/95Zp8DoRkb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFHOWFJcuHqjOWLMBQi55spAsz5aCa+8mvR7BUpb4RxTqFKfJwdFqZtQsxceRSMDZ
	 ewJUmop5Q9Wb0zfm9uVsbUU5e9xHFg0T/PLVNUq8eHEsB1JvYwCJIOlydEUz+BlvfP
	 BRHTKmjJzzNlRb8462dZBHZ+dZfKzgoGYHj9neZo3whRWxTdwalf8wjJx1nW3XNiee
	 H0vkngiia91kyJhJwXXj5y2V9bJaf68tjuS20IEBCGRuDKui2X79rWyWoLA/pjOCZt
	 juJBXvivupqO5mJ7tmiNfA0w9B/zoIjAmBgyPoBjoEdxA706OCaaDT+jOMV+Fe//ic
	 zd7F0LljWkArA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 267/638] ARM: dts: imx6dl-yapp4: Fix typo in the QCA switch register address
Date: Sun, 24 Mar 2024 18:55:04 -0400
Message-ID: <20240324230116.1348576-268-sashal@kernel.org>
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

From: Michal Vokáč <michal.vokac@ysoft.com>

[ Upstream commit 023bd910d3ab735459f84b22bb99fb9e00bd9d76 ]

This change does not have any functional effect. The switch works just
fine without this patch as it has full access to all the addresses
on the bus. This is simply a clean-up to set the node name address
and reg address to the same value.

Fixes: 15b43e497ffd ("ARM: dts: imx6dl-yapp4: Use correct pseudo PHY address for the switch")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
index 3be38a3c4bb11..d2b3e09eb7df8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-yapp4-common.dtsi
@@ -127,7 +127,7 @@ phy_port3: phy@2 {
 
 		switch@10 {
 			compatible = "qca,qca8334";
-			reg = <10>;
+			reg = <0x10>;
 			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 
 			switch_ports: ports {
-- 
2.43.0


