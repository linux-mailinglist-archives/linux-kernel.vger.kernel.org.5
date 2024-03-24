Return-Path: <linux-kernel+bounces-114668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3C7888BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA811C297E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362EB2B16B5;
	Sun, 24 Mar 2024 23:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss+Lmdhx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575D15ECC1;
	Sun, 24 Mar 2024 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322310; cv=none; b=a1FVPr2/taDlsaaFmYEskT1+ZFVlo2ncFsgsEcT888vuf+++uu1OvkcXpcljDJd3rW/t1YzcpEh1tIZgHiI9QKTqAyiZAYbN5jbVBA8DHFPgE0V7s2yI0KqwTb4v4W/NhJjbpc998yRNFXe1h372f/YmJOiKOkfQAYAsjbpSRE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322310; c=relaxed/simple;
	bh=mak0ga7Yr91BHq0DwvHo0cEhFpzKXI8ueUt7PKSBons=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0K0emObTtlvn5g4C3MwJ1I5iaA7a0fZ9RXQStezBLhFsehnImmDYTxGjE2o2pb79OxgyP9ziASR03HBJ6vXKUZBo4kEPicwybGo+WOzyeX6mV/djc6nMO4Fq4C2splYnkvfRyKFWMwTePfAhgdl1cZv6c6BXSptg5UXqiBlwKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss+Lmdhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63FD4C433B1;
	Sun, 24 Mar 2024 23:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322310;
	bh=mak0ga7Yr91BHq0DwvHo0cEhFpzKXI8ueUt7PKSBons=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ss+LmdhxUQ+/eT2rx8CvQE5D4pUBibbDIez9FVWgQt43oSajzS46VdfDTRa0aNmOi
	 pfOEu7+qN9pjy8etMgeKhdolyWlfJdlAaLCZScBDNDgQbnLMwRs3IeRMmKkMnGgjYJ
	 IIcJI94IOz2R118JNOPlzw0Z6EnsE5GDVdL6lDItQGUS3xRzuvRS5tkgykfhYx3IPv
	 ZZAXfm/5XO6t0JzmbMHmvMDj1eGEClh3204qsL4g2ma3xy6Y2zMKQgr5e4SYuau4iU
	 wQzU7M/vwWLedhNTDafKQaZn0I3u81WrIDcTjvndpz8D65r+SUmn4Efwqc78WvwYrj
	 MM/qm5qaqmh+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 393/451] arm64: dts: broadcom: bcmbca: bcm4908: drop invalid switch cells
Date: Sun, 24 Mar 2024 19:11:09 -0400
Message-ID: <20240324231207.1351418-394-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index df71348542064..a4c5a38905b03 100644
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


