Return-Path: <linux-kernel+bounces-134484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EB289B20C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E5F41C203B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93CA13774D;
	Sun,  7 Apr 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUXoJDnO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71C136E1F;
	Sun,  7 Apr 2024 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495644; cv=none; b=X3rCMOa/U4oh3jE2LxWwxYaKxwlTE/3fiGyaiE0PcRXE6uBVIRGgH0hqi4Pu4fKO4CqddfYAAwMKdl3K/43Kr3sH+xKsRqOGl2y42ihthflyqs3hWB+maSKd4yPc7nBRmyM+Z2GFbvY8YPUPQZhJ1eY14Qf5IfEPbwhnQTlhRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495644; c=relaxed/simple;
	bh=85/B+Lx5KnqfgBzHZTPWtL/UpH0Zg7jm/G3nGJhKDKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SChOtWa+tnyoknIIsNgGO27yk1Sls68ebhQdIe/TkoZcoZTKrsaIS+o9JbDi2CCmKNX7QIaGFPY50Sk967Q7BMllppsD/Xxn0LvOXtKvVHE7+2/EDCAwjVn6SzNmoTVoJXm29uIz7cP5spf8x5lDCxEWZ0h3AYiwtvyA+6Aphfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUXoJDnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121EAC433C7;
	Sun,  7 Apr 2024 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495644;
	bh=85/B+Lx5KnqfgBzHZTPWtL/UpH0Zg7jm/G3nGJhKDKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nUXoJDnOVwoFprtTQqpGlQpRrk/hc9bZeZXzZLPKuPS4pEOzWnKGhy+urWL5xEWmn
	 cSY4+BP/l2r/AJdFSBWQZ5GMM64rgGolbt32gZvbniwZIEwoCPEg5z8R7pNSzOXX2/
	 JKlh7USv363Nxw8IOrWHXc3DF8ky9c3Ka9xe5hjxBVXYMoVYpdEZLy28Bv8g0r8ZPu
	 huP19o0Sea+k09PtNgcJZVc8xtd7KIm8yQkULAN3JhDiw6LNojsIbDWf+QHBIgIPLK
	 nIy46BiskUGJuZCatf34WJR8EoNjiMQcZS/ZFyqnQGmcxfWOEU2KHjldgLJlFwUNXu
	 /Qap6CcbjmeKQ==
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
Subject: [PATCH AUTOSEL 5.10 3/7] wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc
Date: Sun,  7 Apr 2024 09:13:54 -0400
Message-ID: <20240407131400.1053377-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131400.1053377-1-sashal@kernel.org>
References: <20240407131400.1053377-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index bd349ae9ee4b4..782ff56c5aff1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -112,7 +112,7 @@ struct ieee80211_bss {
 };
 
 /**
- * enum ieee80211_corrupt_data_flags - BSS data corruption flags
+ * enum ieee80211_bss_corrupt_data_flags - BSS data corruption flags
  * @IEEE80211_BSS_CORRUPT_BEACON: last beacon frame received was corrupted
  * @IEEE80211_BSS_CORRUPT_PROBE_RESP: last probe response received was corrupted
  *
@@ -125,7 +125,7 @@ enum ieee80211_bss_corrupt_data_flags {
 };
 
 /**
- * enum ieee80211_valid_data_flags - BSS valid data flags
+ * enum ieee80211_bss_valid_data_flags - BSS valid data flags
  * @IEEE80211_BSS_VALID_WMM: WMM/UAPSD data was gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_RATES: Supported rates were gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_ERP: ERP flag was gathered from non-corrupt IE
-- 
2.43.0


