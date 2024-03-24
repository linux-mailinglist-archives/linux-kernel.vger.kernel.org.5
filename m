Return-Path: <linux-kernel+bounces-113278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 438A988830B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F29CE286374
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5366918C230;
	Sun, 24 Mar 2024 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOAzCin5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D00618BC5B;
	Sun, 24 Mar 2024 22:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320078; cv=none; b=uZbvsap59C6NGg2ubmUMCpjP7nBRPVQv1bHRGGlD73WBqpyj+wV65owDe84UHjW8MXZXB8fQ/JfEdEkvyW4vhAvwNjWYyYeuRppC/MPe1FFhWwubw+XiFLGewPqkP/5hvktAXUM9QzCOMdMhhMqXkNTUihzeWBDaviCiBd1XhrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320078; c=relaxed/simple;
	bh=C2Ua5kReEzwTd2V431PjK4bLeRHqCCInHnmeMP3BwsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRmWjJQxx8YqsPUzhdhgwpt0v3FeyCrgkCYM8s5iyOTARriBNntDnlxWBabZvw3jOYSN0NEFM84XP6YTP2xyyaHG/teBrng1B6K3LC7OZmt9i5nGN7dslsQU86swL1pFeCPL1xdtQAYQqeCSxivCxaFk4PU6tCFrtE0BpmIzV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOAzCin5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7B3C433F1;
	Sun, 24 Mar 2024 22:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320078;
	bh=C2Ua5kReEzwTd2V431PjK4bLeRHqCCInHnmeMP3BwsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UOAzCin5tos891UH4qheZ4keI9abxFHk19c9E3ul88RlOGnzOFmNnZxPpbh6+wbX3
	 axTymIR/22NORUR1drsFdyP95gYPsEqCBr9qSYqXUnuzbNFRbG11AUddILjfBkQDks
	 sdZs9rgTRlTh6LSsxjXLS3vlF96ST5g5g2dolnq9mjTFHAFIgz+GYwT2PLDjQRnCry
	 k9pO0edT4HxxynCfTDk6oH+JV7Irxh2H+FyXoTlIKXeCa1tzR3bJA043oj4236/I3B
	 u1wcBfyvzpS01JYDJKK8DykwZBfhawy1eqyAWMNbjzVyT0MzZRHxBiST0SxvuWvVJ7
	 1CMqjVtS5nxdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 387/715] pinctrl: renesas: r8a779g0: Add missing SCIF_CLK2 pin group/function
Date: Sun, 24 Mar 2024 18:29:26 -0400
Message-ID: <20240324223455.1342824-388-sashal@kernel.org>
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

[ Upstream commit 68540257cdf1d07ff8a649aa94c21c5804bbb9b0 ]

R-Car V4H actually has two SCIF_CLK pins.
The second pin provides the SCIF_CLK signal for HSCIF2 and SCIF4.

Fixes: 050442ae4c74f830 ("pinctrl: renesas: r8a779g0: Add pins, groups and functions")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/6352ec9b63fdd38c2c70d8d203e46f21fbfeccdc.1705589612.git.geert+renesas@glider.be
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pfc-r8a779g0.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779g0.c b/drivers/pinctrl/renesas/pfc-r8a779g0.c
index acdea6ac15253..d2de526a3b588 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779g0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779g0.c
@@ -2384,6 +2384,14 @@ static const unsigned int scif_clk_mux[] = {
 	SCIF_CLK_MARK,
 };
 
+static const unsigned int scif_clk2_pins[] = {
+	/* SCIF_CLK2 */
+	RCAR_GP_PIN(8, 11),
+};
+static const unsigned int scif_clk2_mux[] = {
+	SCIF_CLK2_MARK,
+};
+
 /* - SSI ------------------------------------------------- */
 static const unsigned int ssi_data_pins[] = {
 	/* SSI_SD */
@@ -2694,6 +2702,7 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(scif4_clk),
 	SH_PFC_PIN_GROUP(scif4_ctrl),
 	SH_PFC_PIN_GROUP(scif_clk),
+	SH_PFC_PIN_GROUP(scif_clk2),
 
 	SH_PFC_PIN_GROUP(ssi_data),
 	SH_PFC_PIN_GROUP(ssi_ctrl),
@@ -3015,6 +3024,10 @@ static const char * const scif_clk_groups[] = {
 	"scif_clk",
 };
 
+static const char * const scif_clk2_groups[] = {
+	"scif_clk2",
+};
+
 static const char * const ssi_groups[] = {
 	"ssi_data",
 	"ssi_ctrl",
@@ -3102,6 +3115,7 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(scif3),
 	SH_PFC_FUNCTION(scif4),
 	SH_PFC_FUNCTION(scif_clk),
+	SH_PFC_FUNCTION(scif_clk2),
 
 	SH_PFC_FUNCTION(ssi),
 
-- 
2.43.0


