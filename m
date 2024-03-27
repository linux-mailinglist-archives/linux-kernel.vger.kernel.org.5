Return-Path: <linux-kernel+bounces-122118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D00088F210
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC4F1F223D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 22:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F789153BFF;
	Wed, 27 Mar 2024 22:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E+1FsCRf"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AABEED8;
	Wed, 27 Mar 2024 22:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711579933; cv=none; b=WRe3tf5q8hIxwya1iuqFeEHTkoLQUNkJ+g9NoN/DxzrxbI5jAzw5HCIaXbWkTN1Ia/muDNIRaaFt65hbBq4PBOTV7NHw25zDP38wzMkzE9eUjjmdWCFPep6KU7aV/NdmVvTUxmkigyo5BsX+2LrWo32zdi8fZ3MQKgLrsh6fWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711579933; c=relaxed/simple;
	bh=mimGJEfki4mtm2qPfFyJ0LOrcCBSCnrWzU3LB53JbTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGFDXlX9Zya75g7lRRP4HIk+Xr5VB1VoNno86Qt3m6uHe7OI70ABQoPLloWrCm3+oVXJySA4mDRI6D3y0kKbC3Baf6mOZkNkT25Pd72GK3CcqwkD5D1QswEVAZWNg/cj8drWPClz0DxtO+9Qv8DksA8zOnov3wduDtCk/gRR7bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E+1FsCRf; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711579930;
	bh=mimGJEfki4mtm2qPfFyJ0LOrcCBSCnrWzU3LB53JbTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+1FsCRfFV/qR7blPt1lojTNF4l9vPAkUvKMdTc/iTdDyvYFsDoZ4gPyYED187Aas
	 oDNkAt8ccyEdtDTzXecLWuZ8eTlm9nZT6m6IKVsc/EEJ8W+ovMt66eIkOSmzWBhOVY
	 PY991SytXX5R7wGCN0LGgZODKLvGdbXP5EQJeFS3IbHWCqGKKB6EgD7YitIMzQ8lae
	 sTf9NvHpCp6CzvLJGGk19QF7zSKvjOog+fGdtiaeK3rjqeveRbeIymf0cW2l/P39mu
	 YBKvj4mfHZ9Eg/oTP5LysAlu4sW5/20077z4uKpUGACDEaSh7qF0Eqe65B5qgfcaBk
	 59vCq49X44QBg==
Received: from shreeya.shreeya (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8DA943782111;
	Wed, 27 Mar 2024 22:52:00 +0000 (UTC)
From: Shreeya Patel <shreeya.patel@collabora.com>
To: heiko@sntech.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	jose.abreu@synopsys.com,
	nelson.costa@synopsys.com,
	dmitry.osipenko@collabora.com,
	sebastian.reichel@collabora.com,
	shawn.wen@rock-chips.com,
	nicolas.dufresne@collabora.com,
	hverkuil@xs4all.nl,
	hverkuil-cisco@xs4all.nl
Cc: kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-arm@lists.infradead.org,
	Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v3 2/6] clk: rockchip: rst-rk3588: Add reset line for HDMI Receiver
Date: Thu, 28 Mar 2024 04:20:53 +0530
Message-Id: <20240327225057.672304-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327225057.672304-1-shreeya.patel@collabora.com>
References: <20240327225057.672304-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export hdmirx_biu reset line required by the Synopsys
DesignWare HDMIRX Controller.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
Changes in v3 :-
  - No change

Changes in v2 :-
  - Improve the subject line and commit message description.

 drivers/clk/rockchip/rst-rk3588.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/rockchip/rst-rk3588.c b/drivers/clk/rockchip/rst-rk3588.c
index e855bb8d5413..c4ebc01f1c9c 100644
--- a/drivers/clk/rockchip/rst-rk3588.c
+++ b/drivers/clk/rockchip/rst-rk3588.c
@@ -577,6 +577,7 @@ static const int rk3588_register_offset[] = {
 
 	/* SOFTRST_CON59 */
 	RK3588_CRU_RESET_OFFSET(SRST_A_HDCP1_BIU, 59, 6),
+	RK3588_CRU_RESET_OFFSET(SRST_A_HDMIRX_BIU, 59, 7),
 	RK3588_CRU_RESET_OFFSET(SRST_A_VO1_BIU, 59, 8),
 	RK3588_CRU_RESET_OFFSET(SRST_H_VOP1_BIU, 59, 9),
 	RK3588_CRU_RESET_OFFSET(SRST_H_VOP1_S_BIU, 59, 10),
-- 
2.39.2


