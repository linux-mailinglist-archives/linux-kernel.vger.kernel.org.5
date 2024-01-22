Return-Path: <linux-kernel+bounces-33320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FAC83685C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BC8D288869
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C4C605C0;
	Mon, 22 Jan 2024 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOGW06pd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BFA605AA;
	Mon, 22 Jan 2024 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935880; cv=none; b=AjYx2aeOQfl24pMEyGCtODZmCEE9KvQI5n/osZ+vRabCMnDHGVVmqLvHr5WMsDdhQ7FkL/1Hx34rL07WP2o9FniqpNHxb1gmUjfSxsY2+Ln6VTOcFZpsRCh7R/eT4imiZ7JMqH6Vh90eaQ0nm+A7M2nr5GFdnlDP2el3MfyHunQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935880; c=relaxed/simple;
	bh=5G2vFEVxxjljbx2Tfhpnz8wRhi/UN3fGZcr43JDnvzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdEYDr4xXYH30ccXYvh64G3McIqh9sXCSP1yxbYsIDfoWo1QvzJzePQUZyeG14E1bB1Y4ndFyhYSNA8BDlnSXYzF0XH0y8136RGQkpESMmums+AQGw3TEICNV+BZ5gosl4EgmPMUwtM7CBZmUBIovZp5NOItvhFJ470vvCKWmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOGW06pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645FFC43399;
	Mon, 22 Jan 2024 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935879;
	bh=5G2vFEVxxjljbx2Tfhpnz8wRhi/UN3fGZcr43JDnvzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nOGW06pdrzZBZm3Gk+2It+kb41RpSxwGU3muNh1BpnD6iG4BfAZrsrAO7PoNzeM2f
	 IjyI01xY7enbO9tVtrr7//G2F+fb9GA1cXZojsjKthpf4NZtZ+GSlnlOF+Uf26wjqt
	 xzOxHgkEHFDVkSy8b5rvnt/3VB7+y/RxwNbnI1Si0REgjEb9RDQG7wac0uRwPjTQgr
	 OWRgZXo2WRsXN071cQBDsXkWW3SXw/pQOr1tSfqPhpUUxryhOUbpfxpoXKMEzVgbiw
	 mBDrAepDCkC4Waank4PiOFc5BBl9v1eh6LuQBiZZugutkGAfu8IDb65v2Clg17lCKN
	 2eEMCO2xSpGMg==
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
Subject: [PATCH AUTOSEL 6.6 03/73] ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument
Date: Mon, 22 Jan 2024 10:01:17 -0500
Message-ID: <20240122150432.992458-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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


