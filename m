Return-Path: <linux-kernel+bounces-44185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7B5841E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305BE1F291FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AE759160;
	Tue, 30 Jan 2024 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="LSJoA0a0";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="n58TGot3"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D8858AB4;
	Tue, 30 Jan 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604940; cv=none; b=A1xEqetSXhQzb3ZpyQTECDWVmOiBHZym7pixIipfaEkeC1VZlKjRDKrcyOOfy3xzGOWbP17A3YY/BDOiG1idcNac+nmjM3cHcJc8XTWyGkMPRHRXcgUqzBS61QAVP5p7THQzDPrDbfeB5PZaokioPiX8F4XxWfoNdcvvCW3w1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604940; c=relaxed/simple;
	bh=VaUtochClCSBzwjeApM8D3I4o77tKUb0XFdxMvcCM/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZsz/LQfIXqXVi31DaSlzsH5UaaUjEgriXd7dT4JpIHSfq9PJ2u74HhKuaCCi44giccpBVW+oWgaCnQuISy7BUXiUETBvLyDxnwjx9Rs+uv3SHvTkZ8Yk4ISkL2KzBhEUARp+S03hfFHNNj8PKJWiR+amxjG3mOOkJmuSeEZ6A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=LSJoA0a0; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=n58TGot3; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1706604931; bh=VaUtochClCSBzwjeApM8D3I4o77tKUb0XFdxMvcCM/g=;
	h=From:To:Cc:Subject:Date:From;
	b=LSJoA0a0B8QRvFgO0YvWpKpbMywLfEyCUDBw844ZHPqG036b4Eu7buaFIErJsNrxY
	 OhI+zzHkKPNDhymXj4zCQ2WnL8dMCsTKNBDMtwCKYQcTi5fXwC2R0muSHieNfq0eGz
	 L8yVO8Aw/omJuSs/r8qZk/zCfxtP6Mk6Yfw13aUmVDB2j1DNpOiBbHLMzGP/aYBmJ5
	 X57J87yzQq8mm0sk9kteUyxstvGlqykJd0icq9VSBBDdA3pPk6xmk21nzEpRat8tIx
	 NAA6SJiYARtZF7ofZGFVWVrhXZK2GbDnVAdHMdAa3YGL4KDi6+6Gw/0V0t7ufdf55c
	 wKzVm2TrHH/ew==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 2DE2D100741; Tue, 30 Jan 2024 08:55:31 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1706604929; bh=VaUtochClCSBzwjeApM8D3I4o77tKUb0XFdxMvcCM/g=;
	h=From:To:Cc:Subject:Date:From;
	b=n58TGot3ClKZ9/J0KKiVpvlsiXlE+utSyizWm3JGYP/MNVQTJJYSgTF91cW0woE5L
	 2OfPTV2GQEqFjPHxtrUdUooimGYP8qPlGx4A3bHduguZJj4m+ffsn2JL94378khiCB
	 NklzzO4l2t/NYYtZliSSuYWUYNsHf+WXz+RpGWtIhVFtsM+dZ+j7uy4r+2VRObBE5B
	 8BQxkNYg25Z/fNjnUByAYyYEikx8VnzaAjT6LJS8364pcAE8dM2Pg/bqvpe2iwwXsd
	 An3a3rq1C0tJu/cMz14GKpmiUZ/4tIonRq/lbZqTDg9OReWKSBvwYPdX1DP8ucfY9x
	 aPberFDx8qoow==
Received: from bigcore.mess.org (bigcore.local [IPv6:2a02:8011:d000:212:bc3c:1b4a:a6fa:362f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id CC6691000B2;
	Tue, 30 Jan 2024 08:55:29 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: pwm-ir-tx: Depend on CONFIG_HIGH_RES_TIMERS
Date: Tue, 30 Jan 2024 08:55:25 +0000
Message-ID: <20240130085525.6222-1-sean@mess.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 363d0e56285e ("media: pwm-ir-tx: Trigger edges from
hrtimer interrupt context"), pwm-ir-tx uses high resolution timers
for IR signal generation when the pwm can be used from atomic context.
Ensure they are available.

Fixes: 363d0e56285e ("media: pwm-ir-tx: Trigger edges from hrtimer interrupt context")
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/Kconfig b/drivers/media/rc/Kconfig
index 2afe67ffa285e..74d69ce22a33e 100644
--- a/drivers/media/rc/Kconfig
+++ b/drivers/media/rc/Kconfig
@@ -319,6 +319,7 @@ config IR_PWM_TX
 	tristate "PWM IR transmitter"
 	depends on LIRC
 	depends on PWM
+	depends on HIGH_RES_TIMERS
 	depends on OF
 	help
 	   Say Y if you want to use a PWM based IR transmitter. This is
-- 
2.43.0


