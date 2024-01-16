Return-Path: <linux-kernel+bounces-27932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F86482F7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022A2288AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1517E12B286;
	Tue, 16 Jan 2024 19:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRpaY4wK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8E12B26E;
	Tue, 16 Jan 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434608; cv=none; b=jMD3Q8I8sR5crYQ7IXlXYCffkOiwBNqXhKrPfXP/2ISMRqpyl3FTxL07VS4KshPBp1plDLpzmPozRbNHMkiCSWMduzNj2Z8NMeTpxcSSykx2+F4zVNTyDpDTEQxpu947Jef+qvlTnoHszncs2haSEiL9XcAMyPax/w4fpyOdHhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434608; c=relaxed/simple;
	bh=cJGYlldTel1uQEJ7kxUG0hRGUgTJAHqp//e4+amNOzU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=j8pts87HwWEIoWJASplp2IQiHw5jmMOweW6g5I/3npuos5qkyGjvnwZX+TQRBvhrrH64gt9owacQmqyj8A1aufu6OAm0lP+LuY5aWjPtHB2zcTM0KLn7wQK3MRNHr0q3LxcsJVCDSXvGxhJ+lforlRKdKHl+DGNBIfVnUMQFoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRpaY4wK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C44CC433F1;
	Tue, 16 Jan 2024 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434608;
	bh=cJGYlldTel1uQEJ7kxUG0hRGUgTJAHqp//e4+amNOzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qRpaY4wKK4h5ee4pE3jOAi9nCKKv1imWhHVI9JG1tHIp+3Ka0FFhitBBB25/oWjUQ
	 eoxiNPdTaA+rg9ZsuaU6QyIiJC+zzeev7o+o8og5P2Id+eMcQAZ7KZPlsmnUv7QbpC
	 lW8hUcgF2EQyGlQ93MOIdRGdeqrYA3yLj7eg34TKI4uaT1a8qBdwkgWf9FZQ14EbTy
	 YKv6sfWyLfHAYlSonZdrrgzT/k/54OGM8uK2H22OkRIGAMMXSJ7Fe+ol/6VRyogdWB
	 htyOmHVlM1mW3GEuMByvGR4HHlQ7HK2iE9qW7q+t7wwGvLLZhrl/FwRZDcAS4G0YnU
	 of0TNqZcktrcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liam Kearney <liam.kearney@morsemicro.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 024/104] wifi: ieee80211: fix PV1 frame control field name
Date: Tue, 16 Jan 2024 14:45:50 -0500
Message-ID: <20240116194908.253437-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 2b0a73cb7cbb..e8e5b2fd50d5 100644
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


