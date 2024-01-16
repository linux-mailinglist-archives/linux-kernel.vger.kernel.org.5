Return-Path: <linux-kernel+bounces-28029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B29282F950
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70D8285EF5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0AF14139F;
	Tue, 16 Jan 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCdZpuIz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775DF14138B;
	Tue, 16 Jan 2024 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434939; cv=none; b=awHfFTVFbGzGUen7DLPXx9T0IYUzSwA/nGu6YE27kIiooiel5bWqkowQj2degjne8boA+L6VSwU63ACM9fJEGwg/EZNWpag0RM70yEqmaDi6j34oiQNjH2tD/0LfzGT8goS24axYm8hCyzkvExxL5K+zAoZlI0wpPrPBTt7UIJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434939; c=relaxed/simple;
	bh=0y769TGzBrbl5VChnyn093dkqOvatr23ZojUupl05OQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=rYHuoYXCqP9eJ+//1Ts0lxLgeGA6gZ58LrSs47CAGeGCVEQbRbWUbW31SEQnYShDoh8WRO1hjAzqYDN8yhnHqYLTpANhUXAvjDCqgxn5T7gbUxhdKlKygNlLIkfA/Dnvn/ehRvbqiqpwFAh+we2ynJlNXddWOl6Lui7ePVF0iZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCdZpuIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C62AC433F1;
	Tue, 16 Jan 2024 19:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434938;
	bh=0y769TGzBrbl5VChnyn093dkqOvatr23ZojUupl05OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCdZpuIzeo7xxyssvPiV4gPXyua3OcvnmNU7oCgYINPYZXPtaSfCoBaHlDJ0wS44d
	 P5cy8Nq4VAlrebOMEGtPen86KUwtd8mjDajb7Pv35WCqcm/UoLHhM/VESa7Ii0JWzj
	 Ur45rUNZCwXAmxPxFmPr/O0rH+BwDw/pHBNjOl4Bx0WNeLnT8Ht/oTIt9heMsOyMcD
	 a0eU8V9unWK6Y6OSLf4H2Cy70Jqiu3NZDFxUcQYxw2vu3JlW7DtEFPOQhxEQ6tmMt1
	 HYHaCJDqcCvt2c4S2ih+hfK2zzu9z7dUxIoJMquJeRrBKbMU3272HZ+MDvtIsCPBfA
	 MN0UORuu5odLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liam Kearney <liam.kearney@morsemicro.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 12/68] wifi: ieee80211: fix PV1 frame control field name
Date: Tue, 16 Jan 2024 14:53:11 -0500
Message-ID: <20240116195511.255854-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Liam Kearney <liam.kearney@morsemicro.com>

[ Upstream commit d3ca4ab4f16eb81dc3e7721251adcba49b229d54 ]

Update PV1 frame control field TODS to FROMDS to match 802.11 standard

Signed-off-by: Liam Kearney <liam.kearney@morsemicro.com>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Link: https://lore.kernel.org/r/20231025002755.1752983-1-liam.kearney@morsemicro.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ieee80211.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 870ae4cd8202..1525d13e3b1f 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -172,11 +172,11 @@
 #define IEEE80211_SN_MODULO		(IEEE80211_MAX_SN + 1)
 
 
-/* PV1 Layout 11ah 9.8.3.1 */
+/* PV1 Layout IEEE 802.11-2020 9.8.3.1 */
 #define IEEE80211_PV1_FCTL_VERS		0x0003
 #define IEEE80211_PV1_FCTL_FTYPE	0x001c
 #define IEEE80211_PV1_FCTL_STYPE	0x00e0
-#define IEEE80211_PV1_FCTL_TODS		0x0100
+#define IEEE80211_PV1_FCTL_FROMDS		0x0100
 #define IEEE80211_PV1_FCTL_MOREFRAGS	0x0200
 #define IEEE80211_PV1_FCTL_PM		0x0400
 #define IEEE80211_PV1_FCTL_MOREDATA	0x0800
-- 
2.43.0


