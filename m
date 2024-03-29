Return-Path: <linux-kernel+bounces-124593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72579891A56
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEF0287E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EAC15820E;
	Fri, 29 Mar 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TE4GK1XO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F013E055;
	Fri, 29 Mar 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715492; cv=none; b=oIj1ONuDfehcrPP6KoBCDTA9ovLLJKdnK6TREMJqfIf7RFXj0sVzHZON3tM0XKJefLVsw2VmrorqkDTzYm2+UtFJOXnLrvh2W/dgewQnoR5+mCeBe0AUwJO0HRoTSnoC8wwiHMfBx6feGw/agxzQQJyabOZlx9bvFx6JfXiP7Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715492; c=relaxed/simple;
	bh=qRlOuSCNYtTc3XubH63Fwcr/eEV5RWXb6IslqkzmIfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KHC1jnbb5IE8Ft+MJcKtQBWxRyl3B+IEooIq6eGJjwCa+tJziTsMnc6lCiKQ+Ms3i6kMs2VU7qm/iYu4Ub2ND17jdjEbc0HLhXfYl7dvzFi30jLCZLxhhot+hXitup+wT5wPY1T4scnqpn03DeK/LSJZYWCdIxBMZOU9FBXVb+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TE4GK1XO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7C7C433C7;
	Fri, 29 Mar 2024 12:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715492;
	bh=qRlOuSCNYtTc3XubH63Fwcr/eEV5RWXb6IslqkzmIfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TE4GK1XO08m0F29ScKXJYZ/BnVClAcCOTe05aXYfjPibtchje7rnxzH7v2jCKHRqA
	 gOlubbLSpnwH/bBZ1OHrJFB6pTG7WHT4fxUyMogmAH/FpG943N1W7N/hV31VCho0gz
	 WJXP54fCRxTPcoR5T7nwNev+8RUajk/MPqNZeuE7zgY7CDylxrAhTN6C9WM+yFlAn2
	 bAwpvbDXjtO6uRtfNFli+c6mUL3iy9ZbEgusOXFStW8cC2NOkVeg5N48ZoxTkoHYbU
	 CYwmvXMD2jlTHmXLq5El/BGMyYgOXxEmzY9s9KFivCnw7h1lFuKh6h77vLLAvmnftt
	 DLsScJR0IlP4g==
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
Subject: [PATCH AUTOSEL 6.6 42/52] wifi: iwlwifi: Add missing MODULE_FIRMWARE() for *.pnvm
Date: Fri, 29 Mar 2024 08:29:12 -0400
Message-ID: <20240329122956.3083859-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
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
index 8d5f9dce71d58..dc9667586de9e 100644
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
index 42e765fe3cfe1..cc71b513adf98 100644
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


