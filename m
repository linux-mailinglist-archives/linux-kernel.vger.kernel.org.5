Return-Path: <linux-kernel+bounces-113810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35741888E97
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B4628AA65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746DF14EC7A;
	Sun, 24 Mar 2024 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxM6jxoh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278631E6F5E;
	Sun, 24 Mar 2024 22:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320858; cv=none; b=QPrdfizGRLxQfN5lgrYvHrIzZEneph7z6UcEff9KrZIBW3+KI5hLIRa9wYAil4Gq/xjfj+jwQfUiXq8e6G6iPKNEAwrW1snuBjB+LTblMTsOvKKXAP3wtX5NXddZEhxUb88EGpfc0rWdsPpvFMuPWuz6MzV+B+Ud2M5gO9++9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320858; c=relaxed/simple;
	bh=C2Ua5kReEzwTd2V431PjK4bLeRHqCCInHnmeMP3BwsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hY7cMH/oaU4uodvAW7Htv8Nw0W3Jk68kNsOZu+0AgpU8sG8fqFlJyQqKoJLmWi+DPC00dPg/6LFbneMkG/St0i/n1U0zUfSRaVIhsDmuFRlcO2ttFqhP/4zj77xF2sCCmizCj22cJk4E7w4S5yErhhplUbD0cSsHbdY64Wrktpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxM6jxoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E524C43390;
	Sun, 24 Mar 2024 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320857;
	bh=C2Ua5kReEzwTd2V431PjK4bLeRHqCCInHnmeMP3BwsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxM6jxohRztoFxg+LK2x7oYaJ/EReQ28NsQewXit1aAY/13NU8cB2QRRcDxfRH+34
	 uOJiT28FWDV+aVRlaR1380OejI6nw0ek6xyvNk/6budx1fcAnf5PGkrYarB1oKFREf
	 1geXqvXkk1IYbYHWR3a4fWqIRJ5qFPNcC1G63VPfDW0fawlIK+4WSDWPt8tK3rOAEt
	 ZJIJB9G4IInFLbdBVVwAUGd1CCIknx3f/SLxTvelwfXl+B1UX2g8ebs2hFiS0tYAfD
	 qm5IJyWFg+FiK9QD13juMMykMwJS66GWOLX1GY6kliHOZGGvUUTQ7MvcJDvsn8G2Wu
	 Yqo2ooHue+22w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 421/713] pinctrl: renesas: r8a779g0: Add missing SCIF_CLK2 pin group/function
Date: Sun, 24 Mar 2024 18:42:27 -0400
Message-ID: <20240324224720.1345309-422-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


