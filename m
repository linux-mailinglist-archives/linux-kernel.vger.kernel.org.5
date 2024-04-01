Return-Path: <linux-kernel+bounces-126745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C4D893C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAD57B213DF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A26241A8F;
	Mon,  1 Apr 2024 14:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cl3a4PFy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE951C0DF1;
	Mon,  1 Apr 2024 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981913; cv=none; b=TXIR2N77lysChUDtrtUwgOC+OxvohGZsqTd0Ej7s8Xgbj08gJcpyu9hLJZfjb5xS+hBu5/RcRdnLHnXfeKjdWKt+DYFnv59B+qMjONgvV/jzHqe8Afm6nUl33ass46yIrAu+FO9iYGtdFlcW2tCJ89MSUPqwlmLpwxbcjXp1QHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981913; c=relaxed/simple;
	bh=GZJ0qHPwhhIYdtdZ/yXQI/beI8+GkNE90kSPhqbSSQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c5nuj+R4It1GDPRD4hlkDfSdkLEstTgkefmp5JpyzEiGuLQoCWi1LGt31v3TUDDTQCoXCXLlw8lejBJUBq4Zc/29lOS0pzESYF58Qa60AlHkC39ZPuT40q7KljwzgCXIYJTZIhXzm36S8u+HvjH4pJRunpeMAOFzQ0LZZxNgZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cl3a4PFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9970C433C7;
	Mon,  1 Apr 2024 14:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711981912;
	bh=GZJ0qHPwhhIYdtdZ/yXQI/beI8+GkNE90kSPhqbSSQQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=cl3a4PFy9rmvwyZfAgOdn+b8rU3y/xg5TOSBKtZ7unfD/DmGRn6bDLXCdIsEFhAXK
	 2vBa0KbHLazy/ACncf6MPcfswdSwlgEyi+9+MecUuRkqc/73xlU2cGJiMcmpo6kQyj
	 UkySuiN4i5CcMpFLNTsoRs5n0EtzoQdlYhSmBocsRTJbjzI0bv2dRcf8FYNbnyrF1e
	 2RZgAiaqk+jzdRQZUVUmk3WWeCfa7+aK2jRw8zSffXhfLJClQdOrsIY3FmUGrza6gP
	 2GMC/q5G2pq31VPz48Oi7TVGHid/TmhWQfHaGJRR/8miN4WVf00l2ZJ5gbsx7LmWqf
	 AJxr7SEdCCJyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB401CD1292;
	Mon,  1 Apr 2024 14:31:52 +0000 (UTC)
From: Daniel Berlin via B4 Relay <devnull+dberlin.dberlin.org@kernel.org>
Date: Mon, 01 Apr 2024 10:31:30 -0400
Subject: [PATCH] Add support for 2024 ROG Strix G634JZR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-add-rog-strix-16-g634jzr-v1-1-ac396095409e@dberlin.org>
X-B4-Tracking: v=1; b=H4sIAEHFCmYC/x3MQQ5AMBBA0avIrE3SVkm4ilhUO2oskKmIEHfXW
 L7F/w8kEqYEXfGA0MmJtzVDlwX42a2RkEM2GGWsskqjCwFli5gO4Qt1g7Gp7HILtlTbVnkXvBk
 h57vQxNe/7of3/QAvzIPVagAAAA==
To: James Schulman <james.schulman@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Berlin <dberlin@dberlin.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711981912; l=1959;
 i=dberlin@dberlin.org; s=20231103; h=from:subject:message-id;
 bh=OkAb0mgem2LTUaEtI3QpWVORvUHuRQ4HTHDw+7mTmOo=;
 b=YVpBuS/DPGPSMIvGvxBHJw3haqM0JyxXizPd9bNmgUQrCczpAtLBPuXOb2U+cilk8c/JMCLHZ
 djiMPPPiofUCumZT2HN3Y3EM2dPYqLVSXN41TPEjDEE0IspYGoyAv1W
X-Developer-Key: i=dberlin@dberlin.org; a=ed25519;
 pk=cy2fotxgi42vqBilzDOe7Wq2+TsfMspPwg7pfE9Te+M=
X-Endpoint-Received: by B4 Relay for dberlin@dberlin.org/20231103 with
 auth_id=96
X-Original-From: Daniel Berlin <dberlin@dberlin.org>
Reply-To: dberlin@dberlin.org

From: Daniel Berlin <dberlin@dberlin.org>

The windows driver inf says it uses the exact same tunings and setup as the
older G634, and then reuses the data for ID 1043:1CAF.

We do the same here.
Tested on an actual laptop, sound works fine with this patch plus
default fallback firmware.

Signed-off-by: Daniel Berlin <dberlin@dberlin.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 72ec872afb8d..25c117db3317 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -108,6 +108,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F12", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
+	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "17AA38A9", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA38AB", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
@@ -496,6 +497,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F12", generic_dsd_config },
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
+	{ "CSC3551", "10433A60", generic_dsd_config },
 	{ "CSC3551", "17AA386F", generic_dsd_config },
 	{ "CSC3551", "17AA38A9", generic_dsd_config },
 	{ "CSC3551", "17AA38AB", generic_dsd_config },

---
base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
change-id: 20240401-add-rog-strix-16-g634jzr-9e5490cadc2b

Best regards,
-- 
Daniel Berlin <dberlin@dberlin.org>



