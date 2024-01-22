Return-Path: <linux-kernel+bounces-33216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E20836661
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8EE1C209E7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1389C4645D;
	Mon, 22 Jan 2024 14:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bK9svh/l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491914642A;
	Mon, 22 Jan 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935377; cv=none; b=tmXnbEGTiIN57h7mmbczKujEHpmFU9Wzbbo1snoZg9xKoaMNEqTYtgKpbhL2ZoU8nPMTLG0QIvbeptbhfOfWutWAqoxGbOZuiXpyj4Rv2lET/bjkBx0T8jBAjOLONB5dbvo7E5Q/dWJ1GOlzQM9RrdWc2saro2lTF7nRGKWgdHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935377; c=relaxed/simple;
	bh=5G2vFEVxxjljbx2Tfhpnz8wRhi/UN3fGZcr43JDnvzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmbAtnu3hmNkstUXYo5+kMa3sndiPHmlS7MAvlZRngZLi7K8Is4obHaS+VWVvEMMSLgnxVfM1P2IkDtTtCHltpDQL4HNKolADzGwTMh3QaaATRfitrGB1dqdvxVUmmgamUWXSSA92RDczj0ZNgwG8CjYmuQI7A1J+YfGx4G8iMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bK9svh/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80939C433B2;
	Mon, 22 Jan 2024 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935376;
	bh=5G2vFEVxxjljbx2Tfhpnz8wRhi/UN3fGZcr43JDnvzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bK9svh/lwjJ3VkMd27CfVk7KwSMiG58+FojQWyIolM62OcCgfrYXfOIi84sp0oOOk
	 SO1VIx1xOUvFIS2IzWO2owtrSXb+bdLrh9JetOX3yK0Q2s6FA3uDmewqPrKTPy4HOJ
	 s8JWOZMr/+adHsX3cg/y6wZYfNOdf0CGp66kXPRc7MxMwE8sKI0ExgXhvDBPTBkcMQ
	 lsaS/e2Ac5E/sVggP01rQ+f+DDLWayx481DdFmKTOPlLiZq1xnZ4h7lT9Y3BQbRxMG
	 cRYUCwbAbxrRyDysEGxjwJS8VkviVtGRwRrna04t2Ej5VW33XAtLK6CNjGQ6q53Xdu
	 hD6tEigb/B5mw==
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
Subject: [PATCH AUTOSEL 6.7 03/88] ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument
Date: Mon, 22 Jan 2024 09:50:36 -0500
Message-ID: <20240122145608.990137-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
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


