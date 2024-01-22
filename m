Return-Path: <linux-kernel+bounces-33459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616378369F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3F328735A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D8412F588;
	Mon, 22 Jan 2024 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Thr16msh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4D250A6F;
	Mon, 22 Jan 2024 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936392; cv=none; b=cpZW2KRuhUJLuJiIbicDdMpaisu3OG1OPJpwZ8Nggc1T12fvhnRcjykfxryZ1+UbXX0VhFLbUaSaPxE3m5A170+SU8U2b7Ps2Pw9R1q2D0cEdm+Tq+q2TWZTW9VWJCuUP8HFXrKHp90cra9t99KGuDT3+IZSB7auxQEeuM843Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936392; c=relaxed/simple;
	bh=5G2vFEVxxjljbx2Tfhpnz8wRhi/UN3fGZcr43JDnvzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLPwAMAI2dR4qDYXxNHsZoisXMaSPSJI+cp0wM4mBPwhCekXVrstSj07Wjwbxe7EWnWjrc5/8Q7O9ro6+Ch4LW1YUGwWHZmQMywAKdKx6zGw6LyHvSb7EOdR/cW5rx6g+xby9hXItW0p3RMPpXZ83QSSlCBLdlMP51j2gQTmiYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Thr16msh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CE3C433C7;
	Mon, 22 Jan 2024 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936392;
	bh=5G2vFEVxxjljbx2Tfhpnz8wRhi/UN3fGZcr43JDnvzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Thr16mshlWRaPBk9Ko/Uf7ZFe2O2xXJP/FYYt/SyS4swybohrq6u3MXK6e3Vc1xCJ
	 vwpQyLV5KzomxUz59G/tAvCeZBwIfKMynTUuqJ8Ak9F7iASE/p2CwbO3eYcRYsfDRL
	 WpxgUgKZhxt8mtKNXnGWhg+Fk3rGE85vfl6iUb4/0ppWELC4fMAOEXRXT0KLQR5o3y
	 AL9av+W0nvcZGF/K0N9OvjDaZldqUSxWx5PaHn88Y7+3hchNeyzsQPHPkGvrUwbipE
	 uDru+qLmhg3Du+lSmQgqX9Rm8tXa91E9u0PWVWmucrCNtrDLIwIUd6a8w9cNYDHLRx
	 KGBEbGNIg8nIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	corbet@lwn.net,
	linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/35] ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument
Date: Mon, 22 Jan 2024 10:12:00 -0500
Message-ID: <20240122151302.995456-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 67c7666fe808c3a7af3cc6f9d0a3dd3acfd26115 ]

The virtual widget example makes use of an undefined SND_SOC_DAPM_NOPM
argument passed to SND_SOC_DAPM_MIXER().  Replace with the correct
SND_SOC_NOPM definition.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Link: https://lore.kernel.org/r/20231121120751.77355-1-cristian.ciocaltea@collabora.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/sound/soc/dapm.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/dapm.rst
index 8e44107933ab..c3154ce6e1b2 100644
--- a/Documentation/sound/soc/dapm.rst
+++ b/Documentation/sound/soc/dapm.rst
@@ -234,7 +234,7 @@ corresponding soft power control. In this case it is necessary to create
 a virtual widget - a widget with no control bits e.g.
 ::
 
-  SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_DAPM_NOPM, 0, 0, NULL, 0),
+  SND_SOC_DAPM_MIXER("AC97 Mixer", SND_SOC_NOPM, 0, 0, NULL, 0),
 
 This can be used to merge to signal paths together in software.
 
-- 
2.43.0


