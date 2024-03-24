Return-Path: <linux-kernel+bounces-113151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0A48881DE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A22D1F2193D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E545171658;
	Sun, 24 Mar 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCK8DOwe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D318170EC2;
	Sun, 24 Mar 2024 22:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319954; cv=none; b=NE3Ul/CFtHEAS/Jk63zzR3mtbRbZddQ0xs6KCI9RywWWDu04kNp4pwN2v2FSF3RVTfZDbLBpplFOG8Tzizw9Yz6EXuCEI1ZmiHCcl6B6eHGGthsXrDI1jq5HdjFt7FDBP30hYBqSmFU0kgCPYlWMvv9UlH6FlurtyLFhK6keuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319954; c=relaxed/simple;
	bh=hmQWRWL7arDI/JH7/+hDhSSggeI1GZPVqcl3qHGLP78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFBZj8VyVC4HXF0EDc/UxRuWPMthiUVWs1J5WZ3FYqIGh/Ls/5FjsmAXBxegUtdNrvEvw1gzkJTCA5IeEad6W2IHLRQdC7iUzQ3vNQRinGOpQnG6NHQsvVrk6NtnvIWVAJnqy64BKhUH5nVwZQPPs0dAjt4DYsZW9GbAEEfvWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCK8DOwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6F8C433F1;
	Sun, 24 Mar 2024 22:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319953;
	bh=hmQWRWL7arDI/JH7/+hDhSSggeI1GZPVqcl3qHGLP78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OCK8DOwecB+pSABbE/20CLJ8uFi7l1vATwCAlUZZFUQg92TpiXoUWDd+4c7Ai8WsH
	 9aXKPcBrNLPFoKMaQVfOMHSUtP9pJRswjA99yAcPTgqoAgMD7YjOqUnC4qPqIk45P2
	 syLfCDEovlnMPAXaJMZg932doyHPtWlovMFYhc1UDjRwEYIsSssIyS6nW1NnatW18G
	 +Tw6bYGjY3pSRsL4cpNLcLGRBkVs5xoDAz7u8UFR4X6ZEeKht9H3tT6Pyvr8mDpD1J
	 CZVYadhwRJRERV0LLbW+TzA64BLuW1LJuZu+D/66frb9/4ZpqIbK3L9O8KxgumGZxC
	 DUcmquysfQuQQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 260/715] arm64: dts: renesas: r8a779g0: Correct avb[01] reg sizes
Date: Sun, 24 Mar 2024 18:27:19 -0400
Message-ID: <20240324223455.1342824-261-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 7edbb5880dc3317a5eaec2166de71ff394598e6b ]

All Ethernet AVB instances on R-Car V4H have registers related to UDP/IP
support, but the declared register blocks for the first two instances
are too small to cover them.

Fix this by extending the register block sizes.

Fixes: 848c82db56923a8b ("arm64: dts: renesas: r8a779g0: Add RAVB nodes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/83437778614a7c96f4d8f1be98dffeee29bb4a0b.1707660323.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
index 0c83940b3d8a1..d7677595204dc 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
@@ -767,7 +767,7 @@ channel7 {
 		avb0: ethernet@e6800000 {
 			compatible = "renesas,etheravb-r8a779g0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6800000 0 0x800>;
+			reg = <0 0xe6800000 0 0x1000>;
 			interrupts = <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>,
@@ -814,7 +814,7 @@ avb0: ethernet@e6800000 {
 		avb1: ethernet@e6810000 {
 			compatible = "renesas,etheravb-r8a779g0",
 				     "renesas,etheravb-rcar-gen4";
-			reg = <0 0xe6810000 0 0x800>;
+			reg = <0 0xe6810000 0 0x1000>;
 			interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


