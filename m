Return-Path: <linux-kernel+bounces-134463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA8F89B1CB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55037281D42
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E2C3FB39;
	Sun,  7 Apr 2024 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="To4kqDTN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42412E1C6;
	Sun,  7 Apr 2024 13:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495605; cv=none; b=Ot9d2qcWy16aF5Q1a8hSbBQC5PWO0uko2GRjCr6gDJiJO2frT+x1Yw04bLZ6mnC9evWedviao0KeMBAV3J1y8CoCTmgJMLpXJUm5gZxGUwt7o6f4MrFgkoJq0WYzx7BJmkPMZ1JvlRYfdBbnQfyR1J6p9Xldf1xTWbWQOAkPdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495605; c=relaxed/simple;
	bh=64vWe5CBIQmeZPfSYXbVoTRfmze5W6UKNJFOeHC74UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KT0zKmEousjPxs94DF4rLzSh7quwXON0XChlD7Hk4vVfgf8gQrOeuoTsd713Mmev0T1e7S0eoelOqJYjxlTByelEPgGrgXhqPyHm6Bs8Dmr7eaUO5xhO7GK9tezj66LlGqIjujzoBMpGCNFATF3TOyvVEY81aXl6hFo9qYL+Vqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=To4kqDTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4D1C433F1;
	Sun,  7 Apr 2024 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495605;
	bh=64vWe5CBIQmeZPfSYXbVoTRfmze5W6UKNJFOeHC74UU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=To4kqDTNAetP+9w/PMcXDC8FW6it97+WY4ztWfMvJADctRBgFSMb63xFS+mfgMNcQ
	 lwrvjCFXoxmJfm0ZJEKKrnbhaFC84skldSVH5xQGrltbVk1Nv89JhsEVJIUTs3jVkw
	 SWdiac5O3adiC5q3vV7cLMxBVsHHz5onF400WhBI3BKya8z2ZK5p5zedgG6bMmD6UU
	 psQy8nVg2HI122W3IRkSb/qrevcz3oC7QjcUiIVTOmcCpxolu8TdJlUXK0a5WzfOOz
	 qDKlSl20L0K+ztFkEgmKGyYe1XJt0biDhaRgSUtV2GorUciMq30rScESMmqTPXmcrN
	 CkXCWJTFWdBiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Simon Horman <horms@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/13] wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc
Date: Sun,  7 Apr 2024 09:13:05 -0400
Message-ID: <20240407131316.1052393-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131316.1052393-1-sashal@kernel.org>
References: <20240407131316.1052393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
Content-Transfer-Encoding: 8bit

From: Jeff Johnson <quic_jjohnson@quicinc.com>

[ Upstream commit 774f8841f55d7ac4044c79812691649da203584a ]

Running kernel-doc on ieee80211_i.h flagged the following:
net/mac80211/ieee80211_i.h:145: warning: expecting prototype for enum ieee80211_corrupt_data_flags. Prototype was for enum ieee80211_bss_corrupt_data_flags instead
net/mac80211/ieee80211_i.h:162: warning: expecting prototype for enum ieee80211_valid_data_flags. Prototype was for enum ieee80211_bss_valid_data_flags instead

Fix these warnings.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://msgid.link/20240314-kdoc-ieee80211_i-v1-1-72b91b55b257@quicinc.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/ieee80211_i.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d5dd2d9e89b48..3e14d5c9aa1b4 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -120,7 +120,7 @@ struct ieee80211_bss {
 };
 
 /**
- * enum ieee80211_corrupt_data_flags - BSS data corruption flags
+ * enum ieee80211_bss_corrupt_data_flags - BSS data corruption flags
  * @IEEE80211_BSS_CORRUPT_BEACON: last beacon frame received was corrupted
  * @IEEE80211_BSS_CORRUPT_PROBE_RESP: last probe response received was corrupted
  *
@@ -133,7 +133,7 @@ enum ieee80211_bss_corrupt_data_flags {
 };
 
 /**
- * enum ieee80211_valid_data_flags - BSS valid data flags
+ * enum ieee80211_bss_valid_data_flags - BSS valid data flags
  * @IEEE80211_BSS_VALID_WMM: WMM/UAPSD data was gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_RATES: Supported rates were gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_ERP: ERP flag was gathered from non-corrupt IE
-- 
2.43.0


