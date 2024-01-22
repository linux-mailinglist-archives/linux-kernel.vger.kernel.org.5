Return-Path: <linux-kernel+bounces-33422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A739836983
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79A7289375
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20324E1A2;
	Mon, 22 Jan 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGDrwyFU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061882D60;
	Mon, 22 Jan 2024 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936249; cv=none; b=f+JP267NEzoFa4Een+WXAs7Y3IhhMiSm9P49i+CLqphUfGSQPkWui3kVY456R+9RGnWuP2282gEHxN/Um9DClnZWQCBXRyHHWJm1gLDpboLwQfrct3NXH+EwIbrylA/6/6vB/Hpni8C5tQARr3heoumOsXatj5QBI9o3hNv2BTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936249; c=relaxed/simple;
	bh=OJjXB/5FspsmZ8uU/a34WatNa5xcLh9JyGW1AbzYDJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7t4KMS9COqq+s1+LMm7hlPNsgLpSzUAndudjJ8Sjd4qkw7t1u84gvyRktZmx69etLpBtmY9yulGFVyrohUgN//T0rIxffIhdPVC4eAZ/688o9Yc3MxzTfX8UnJsqlB9fu5Ax719QbFLCWuF/hvJ6q9hp0Q3pbjOMrDaT5ApIf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGDrwyFU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5740AC43394;
	Mon, 22 Jan 2024 15:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936249;
	bh=OJjXB/5FspsmZ8uU/a34WatNa5xcLh9JyGW1AbzYDJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eGDrwyFU+ie63dLMH2Hs9ssZeTiIoZkBgBK2zfpSNojXkGXgHSAED9mmOiRS4mbdM
	 Q9BbzY+csdXBaVNIMtCSLFk8NFx/RenMfUra14ep+XXmRgUcvWKMs65VKKbgNdZg1J
	 Y8XXeDa0YTIhRtjXXBm+axtvNxPG7bMfZuHMbAs2z+2gwzY0mBaj/7miRPGixUUuMc
	 vPo9sSAmQpzEaJY+VjdGsUgSrDdB6WN1Um316Bp5ekW6eOqvSeU7v4L4ExKWZv+uwQ
	 pNXDBoW79Opa2jeg8cAzO1w76XIRebHmUSBQV4g9vbo3S9tqNleHNG2b1IAVFPdQcL
	 gav066w91WCHw==
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
Subject: [PATCH AUTOSEL 6.1 22/53] ALSA: hda: Intel: add HDA_ARL PCI ID support
Date: Mon, 22 Jan 2024 10:08:23 -0500
Message-ID: <20240122150949.994249-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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
index 5aaf3dcecf27..a26f2a2d44cf 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2549,6 +2549,8 @@ static const struct pci_device_id azx_ids[] = {
 	/* Lunarlake-P */
 	{ PCI_DEVICE(0x8086, 0xa828),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* Arrow Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_ARL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
-- 
2.43.0


