Return-Path: <linux-kernel+bounces-124538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22309891986
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B02B23B23
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971E5149011;
	Fri, 29 Mar 2024 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqbPdho2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C08135A50;
	Fri, 29 Mar 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715339; cv=none; b=fEHSTY3xKq/pXHhrQKo/oVgiLgCDymmVJ9ttTy84zY5SpF/HI/zacF/8DsqFWYNCGPWJZG78LFM4CAMMGh2+aMH5xiVilBVewJmFtyS7T1UGQSIuE6Nj9DuH51WO91LjbHDlDxRjwhsNiZPvHxxzhwMCxX8BBT1+COY3fPLKASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715339; c=relaxed/simple;
	bh=2blYHZzTgc/Bt86ve41KFu0JQMEdKOXO3SMGTZkGYg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B24HromVRlf1/W7ndpZshPiFpvzLDpaO62ivnpFoOCwYiu8yoy+77lOKY2LS+OMHnyr+2bgd7XyuUu89LHDxPt9w8sqqDlkEHxih5sC1yVoPWgbvrZicyx07YP4pvF1VH2c2K2I3tOY5Gc5CFC5XBMrbZVqM7kr3DA7akFfTuSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqbPdho2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99188C433C7;
	Fri, 29 Mar 2024 12:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715339;
	bh=2blYHZzTgc/Bt86ve41KFu0JQMEdKOXO3SMGTZkGYg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqbPdho2P8BTGlG8b+CDlKQDPldse6c/L583JImTyRD7NafIBBoklJAiBWWdcX4o5
	 Fd6przGtyLFALm0v1hK5wjqOr8W2Z1TRgMTD42YroC5xwVMBQ2YwNP3PHjg20+Ab+e
	 cCwpBzLW718KK282VHDNUSFzt0QW1K919Ijlbi5KK+sW4USEcfHks6A+ZYIk+Tan0E
	 NS2Wh2dcDny/QAK5wT/HlDnAGFdYwXn8MhiYhlIslmulYmFNaRPhh/RDnlWPBCJ03R
	 M+xH0pC5jqTU4Fwz+9mAf1PndSdCUlsRG7ZLVW8+mkSgb7MPPIogVVS53pBGkdIhpd
	 mH7CTachJ8z/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	mukesh.sisodiya@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 57/68] wifi: iwlwifi: Add missing MODULE_FIRMWARE() for *.pnvm
Date: Fri, 29 Mar 2024 08:25:53 -0400
Message-ID: <20240329122652.3082296-57-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122652.3082296-1-sashal@kernel.org>
References: <20240329122652.3082296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 4223675d2b5912060a85e48fd8fee51207e00957 ]

A few models require *.pnvm files while we don't declare them via
MODULE_FIRMWARE().  This resulted in the breakage of WiFi on the
system that relies on the information from modinfo (e.g. openSUSE
installer image).

This patch adds those missing MODULE_FIRMWARE() entries for *.pnvm
files.

type=feature
ticket=none

Link: https://bugzilla.opensuse.org/show_bug.cgi?id=1207553
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://msgid.link/20240228163837.4320-1-tiwai@suse.de
[move to appropriate files]
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 6 ++++++
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 134635c70ce85..73cbb120a49b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -299,3 +299,9 @@ MODULE_FIRMWARE(IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(IWL_AX210_UCODE_API_MAX));
+
+MODULE_FIRMWARE("iwlwifi-so-a0-gf-a0.pnvm");
+MODULE_FIRMWARE("iwlwifi-so-a0-gf4-a0.pnvm");
+MODULE_FIRMWARE("iwlwifi-ty-a0-gf-a0.pnvm");
+MODULE_FIRMWARE("iwlwifi-ma-b0-gf-a0.pnvm");
+MODULE_FIRMWARE("iwlwifi-ma-b0-gf4-a0.pnvm");
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 82da957adcf6e..1b6249561cd58 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -179,3 +179,5 @@ MODULE_FIRMWARE(IWL_BZ_A_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_C_FM_C_MODULE_FIRMWARE(IWL_BZ_UCODE_API_MAX));
+
+MODULE_FIRMWARE("iwlwifi-gl-c0-fm-c0.pnvm");
-- 
2.43.0


