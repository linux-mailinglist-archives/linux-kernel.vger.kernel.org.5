Return-Path: <linux-kernel+bounces-134491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E30989B222
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01191C21161
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25D9139CE4;
	Sun,  7 Apr 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsyDNYr8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C3C43154;
	Sun,  7 Apr 2024 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495658; cv=none; b=kfqLoQCyzcAbNHcnmLqiwmytG51Psb/KWnGbBpZObG+WYreaxADhMX4SP3vLQORAbS0o3YHABf58VnEOftrwyt2KSjV/nSZWnLtWm6PR2MhHWuLf+1h/+a//Pia1cSgZqCacm76ZDxTph677RHDYwhxAdX02nf+dN+XWu6n19P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495658; c=relaxed/simple;
	bh=ktJmNSl6GKMYKekQMEvCgaRWENj+r3vLsWzHS2wz4cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kN1aRZYjWFFj0hfaYTYQ92bvLKrfZhpzYQon2PuDLceZIMHGqemAsmn2Eae7CvypI2fYJC9fZZEkvvauE4+uMWY1tFw8+2PojmqbbFon6XSIXDI+qWiFmcQh8XiPA7u5kys/ee+KwuHdLdrQE3wn4fKps0LHS2M47cQHbTio8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsyDNYr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249B0C43390;
	Sun,  7 Apr 2024 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495658;
	bh=ktJmNSl6GKMYKekQMEvCgaRWENj+r3vLsWzHS2wz4cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsyDNYr8iNrLD3CCyaOTHbX6y5/gfsOKfrSEpavUbThd69rMibK3dMJoZ+RZnNXPC
	 8Iszwx/DkFr9oXs5gonuDw6CZokqxhtxLzlCyoW9ZYIJHGUU9vmGkGolMFpSBsu1a9
	 J058t5A4k5W3+JAv+hmLpFsrp5a1+0NXyVoGjfEcmHo3N7c7hUdeGzTC0pYm4QhbEw
	 ZGKrlpRkutZ4ye4MMsZQPG4euvsb2lXlga1IeeM+iFi1x8v1I6NHow5IKF73BmQPgr
	 PJOB2Mv07WbcLUxGH812KRLaKeHG6oMSB6z9IPQLf+XMxZBrtEijaw++n352RznX/z
	 HgTW1FfgMZt1g==
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
Subject: [PATCH AUTOSEL 5.4 3/6] wifi: mac80211: fix ieee80211_bss_*_flags kernel-doc
Date: Sun,  7 Apr 2024 09:14:09 -0400
Message-ID: <20240407131414.1053600-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131414.1053600-1-sashal@kernel.org>
References: <20240407131414.1053600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 3b7151501b3ed..e26368fab65d6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -110,7 +110,7 @@ struct ieee80211_bss {
 };
 
 /**
- * enum ieee80211_corrupt_data_flags - BSS data corruption flags
+ * enum ieee80211_bss_corrupt_data_flags - BSS data corruption flags
  * @IEEE80211_BSS_CORRUPT_BEACON: last beacon frame received was corrupted
  * @IEEE80211_BSS_CORRUPT_PROBE_RESP: last probe response received was corrupted
  *
@@ -123,7 +123,7 @@ enum ieee80211_bss_corrupt_data_flags {
 };
 
 /**
- * enum ieee80211_valid_data_flags - BSS valid data flags
+ * enum ieee80211_bss_valid_data_flags - BSS valid data flags
  * @IEEE80211_BSS_VALID_WMM: WMM/UAPSD data was gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_RATES: Supported rates were gathered from non-corrupt IE
  * @IEEE80211_BSS_VALID_ERP: ERP flag was gathered from non-corrupt IE
-- 
2.43.0


