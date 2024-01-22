Return-Path: <linux-kernel+bounces-33346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6545836898
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D50F1F20DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E341E64CD1;
	Mon, 22 Jan 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwMc6i1d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C064CCA;
	Mon, 22 Jan 2024 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935943; cv=none; b=TrryukFkXN18f/cQdLSv9sUHB5N+NqlNFQX69yfwP8oWTAw4K53v274EiyVfXTWhkCZrUEoZBVVLsQt6XfXSkxsqKVneAGTpjqFiEHxBDyjNxMPgLM1yItJzKp0xTX7wxSiavovlfSHHOCALaD6OZN52MWXj+FshnTByCJDsitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935943; c=relaxed/simple;
	bh=mffbkzHlo1dRtSyGv7nXJoDRClT1ASsbWgHYVSITlFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDUT4+eRunzLIxwzasLmUjvvYBHpfRnjJY1G21GDMc5EM8FHQ/04D+XAyKRMXqjodSbQVlo366RDlPnTFhn0GaJyx8/rhroUdI2ctAxnfSgj3Alx9rWzELl6jxVSZchvNLxW3siEIYMNheXsdvPtlflBgrBHtuuujrqMUHjzhLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwMc6i1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A41EC43390;
	Mon, 22 Jan 2024 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935942;
	bh=mffbkzHlo1dRtSyGv7nXJoDRClT1ASsbWgHYVSITlFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwMc6i1df+z8CXdBqPxBPNExp5hkXs0HtAFnDgbshmZoHGU2BQUj6vf0FN78bWRps
	 YRV0O2s6Y34ZKyAYZZ5duAJlQaqlE6pntoc8dkZ3JZmnsX+1GQM7w/p0jiOaMTDqmK
	 zdFoslNrxWtPJNpFyRFdZMNBGw+DzvcWua4JazdZ/rWU0FG8iHS3OHxycyCEcs/kde
	 RQ40ewoUKthFBu8Ju1CFcWHx5/qvO5UirAheXHNJtBenE0mUvq3PXKaT5pEiIKYK+N
	 /ez2GLkYEPlx9+fI7cYOmohSUzTRqKAyLfTdebGfUqW6P9uh7YymynHfl+oRc1IY3P
	 fq62QY1qlG2BA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	maarten.lankhorst@linux.intel.com,
	siyanteng@loongson.cn,
	amadeuszx.slawinski@linux.intel.com,
	jasontao@glenfly.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 24/73] ALSA: hda: Intel: add HDA_ARL PCI ID support
Date: Mon, 22 Jan 2024 10:01:38 -0500
Message-ID: <20240122150432.992458-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit a31014ebad617868c246d3985ff80d891f03711e ]

Yet another PCI ID.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20231204212710.185976-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 75148485b755..55d3a78112e0 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2504,6 +2504,8 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_LNL_P, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
 	/* Arrow Lake-S */
 	{ PCI_DEVICE_DATA(INTEL, HDA_ARL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
+	/* Arrow Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_ARL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Gemini-Lake */
-- 
2.43.0


