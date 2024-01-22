Return-Path: <linux-kernel+bounces-33403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AE0836945
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F148F1F21A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9704CDF0;
	Mon, 22 Jan 2024 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEdzEAHq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92584CB3F;
	Mon, 22 Jan 2024 15:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936198; cv=none; b=EadtaVnUrLD5oFEw2j1iULumHP3nA60x+ex4ALIXOiezCiZeL8Un16khUTGeV4wE+mG8/n73ZddzcKzrKzX8bL4Z3H3/eoAxLw0Phgo9zphB7D/JVkI9StzS1cIGhrn3wSzEQanPMFSSgytPriD7R0IThmZhxewEYx7bOrSA64k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936198; c=relaxed/simple;
	bh=5G2vFEVxxjljbx2Tfhpnz8wRhi/UN3fGZcr43JDnvzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahGkZAgm8DFG5vBt+UWLfPNSfhPMaXmXNJpd6qZ5aF8KJxuP0gUV3J2n2lwqvKGYgU719DWcdyzHh6GQBga3jPqrwUGrhx1zGqQNLlKIiUiGWNVDVwlwcHeaMaTW3kCWmBs2LFvfft0WgVYd+fNnlBlLBjbYHXpYsoTnJfftuks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEdzEAHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3895FC433C7;
	Mon, 22 Jan 2024 15:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936197;
	bh=5G2vFEVxxjljbx2Tfhpnz8wRhi/UN3fGZcr43JDnvzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEdzEAHqx53Fvf2HG6PBq0aLeAcUahh+lLOpWc6gYtSYprGFBMD08VigSFx460fEL
	 R3G+jrfSjKxRxlJmfDrykF7e//nKgE4K6XqCXKjs6XdDLk1cFYb6OQc/5iL5gDuUip
	 XcPCoS6rijXh/+aAAH4iNcrjItfKjY3DeeGDVOsdlXkgWR6Umi/g39EXyVzBKEdHQp
	 ZWgNaZmEzzrtunw9zk1ZaLkxpeRNgAEnjSxrJgF9BrLqi58aQCGUIca5wpAMSfqQca
	 DrRRSVvnxpYLsybtmQxL3hoEyomqNGaKlyUyqPm0cF2ij3lN20tLqcVZwNipaS168v
	 jriqrq8cFLtag==
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
Subject: [PATCH AUTOSEL 6.1 03/53] ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument
Date: Mon, 22 Jan 2024 10:08:04 -0500
Message-ID: <20240122150949.994249-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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


