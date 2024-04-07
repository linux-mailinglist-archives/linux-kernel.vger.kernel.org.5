Return-Path: <linux-kernel+bounces-134420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC5989B146
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811741F23A1B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98C6524BB;
	Sun,  7 Apr 2024 13:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h08z1BQQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01445339A;
	Sun,  7 Apr 2024 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495506; cv=none; b=UznvAd5+YN4oCw0nKm/J1EPBJHUJIfqNZdEt1/zxQO5x/Yck7ZMSby4u1X8BmbI0ov0LqiZmuJzCpXzpMFTUK7p0qWsJjrW6hM9eJp44wd3IpF9IKfMqqQVb3HuzbYYrzM9zokL0Szvq04qdNYLIBQhp62BXhn/KJmNhJtiu2v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495506; c=relaxed/simple;
	bh=smB4+dfmgAl3I29F+yPOdtM5wIwU5cQLYW7uZ2y6HNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqGyUUzcDk3smJtN8YHRXJbPu/8VEOm/kez0P+cdIXXV4y7G7lSUcBgNghcFs/HWdjw6eWNPhgtNW+PnUjoeq3c+2OE2YlodkgfjBjtKWvZQIuE+plPzs1FKWIYDwyi3EK/TauXVs2h233Ijcwj65E6/Pm3hd/yyZ7rMGwXxho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h08z1BQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149D6C43390;
	Sun,  7 Apr 2024 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495505;
	bh=smB4+dfmgAl3I29F+yPOdtM5wIwU5cQLYW7uZ2y6HNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h08z1BQQ1zsWyPUw+2GKs8Whcxmr8dI7fyKTucJGDJ5uTqOThvOhlPac1KaSSAucb
	 fzpfXzIiP3KMEqkJWV3SRpAKmhBn6eEwG2b0ReeDSjpXoyxd41BGLc+0aKF2APxMUL
	 vTODADiauR524lySTw8Q9It20D42fDP7dA4kwjizt/bEDA861rhCY//X+nl1nk0CA8
	 xkxzRnw85nuigHwdhkT1Qgb+DRpW/RYnLSc+Z9c6kikjYzd1ABGpnOVGc0jrUL/sMO
	 qwDnOY8zRKlWsBAktVn8eGGQEkTGXGqIiYZgqM6sBCNBfAnSHvdY/+qCd/d/ncwHBd
	 0RgLYIMvbaeVw==
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
Subject: [PATCH AUTOSEL 6.8 10/25] wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc
Date: Sun,  7 Apr 2024 09:10:58 -0400
Message-ID: <20240407131130.1050321-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
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
index 0b2b53550bd99..c649ee6c4815d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -131,7 +131,7 @@ struct ieee80211_bss {
 };
 
 /**
- * enum ieee80211_corrupt_data_flags - BSS data corruption flags
+ * enum ieee80211_bss_corrupt_data_flags - BSS data corruption flags
  * @IEEE80211_BSS_CORRUPT_BEACON: last beacon frame received was corrupted
  * @IEEE80211_BSS_CORRUPT_PROBE_RESP: last probe response received was corrupted
  *
@@ -144,7 +144,7 @@ enum ieee80211_bss_corrupt_data_flags {
 };
 
 /**
- * enum ieee80211_valid_data_flags - BSS valid data flags
+ * enum ieee80211_bss_valid_data_flags - BSS valid data flags
  * @IEEE80211_BSS_VALID_WMM: WMM/UAPSD data was gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_RATES: Supported rates were gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_ERP: ERP flag was gathered from non-corrupt IE
-- 
2.43.0


