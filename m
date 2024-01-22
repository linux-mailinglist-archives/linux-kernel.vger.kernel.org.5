Return-Path: <linux-kernel+bounces-33496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50497836A98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68C07B27A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3FB54F87;
	Mon, 22 Jan 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8/UhyPl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F013A264;
	Mon, 22 Jan 2024 15:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936529; cv=none; b=MbH5Vmh7z7DpBd6Oqx7SNLs+XdQJ+Wi6Hbo4ZN2F7K/UhMbp0kqfY1mLglAHpldtfhIT+vS0QxIABiqfjbKGenAUxuAXNH9tBHhsXctaQ4GdTiWe/yFzzkyowdxAlo4vAZCJdYJi/3yRaWnNVAqPXj1KI7/oZCrNyrwRTxX7sm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936529; c=relaxed/simple;
	bh=5G2vFEVxxjljbx2Tfhpnz8wRhi/UN3fGZcr43JDnvzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FblTnbGEIvghr/i9zSgCXYeyR5uywe0J7j0a80Xlf0xdkXJ/JXgH5DaxgjR2TIZTigc4rqJAUT8IH1rm7ERggUplOUkH9Wm36+FoDZeAOoTO/t1dTgm0kJTAcV8lWZertNK48A9VWWeQpRU86tPoRBk/z1JKFxLxIpSCQ6xQKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8/UhyPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A56C433F1;
	Mon, 22 Jan 2024 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936529;
	bh=5G2vFEVxxjljbx2Tfhpnz8wRhi/UN3fGZcr43JDnvzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8/UhyPlI0ihWVGS2x2XeogwUsIQp2UW4xH+EKyvJeOF3fNOS0WX8V2nTdTgEN1xf
	 xj3h8V6Y+coLorspoeC3Q1NxamD/WL1AL8VhOnSLtZWqS2rNMqpAgbBEVyxYQ23c5b
	 V8u6cM5y4kuvVFoX8rmtt3+xp9GU45aLjAgYfmJ4bodWJW/W6JNjvu9MgqEd6u93nj
	 ie/uolQflcQ9wKtk2ga9aiGc/bZsHg2KYAeHaywvCq3Kz1fISCcIUQT7l4ethc4JMU
	 Cpt+uTPH8L/gJvDiSaODJaptpnNSK9D6qP9KwUq19xwYPNszqFhFiv8nvBYI4Sdo52
	 gNDZutSiWsb6g==
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
Subject: [PATCH AUTOSEL 5.10 03/28] ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument
Date: Mon, 22 Jan 2024 10:14:29 -0500
Message-ID: <20240122151521.996443-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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


