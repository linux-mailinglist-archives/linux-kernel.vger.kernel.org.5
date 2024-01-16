Return-Path: <linux-kernel+bounces-27794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB9B82F603
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CD791C24111
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9070523745;
	Tue, 16 Jan 2024 19:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHdbVOWQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA6523760;
	Tue, 16 Jan 2024 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434211; cv=none; b=ooKejz0I87AUsRbuBMGI2cRA7xiWL8sxXk6zg5qXdTnT3x1w0F/9bHPdDseUa3VxyffChBAvo2J35xi4vNEa705sRdkgPSBBfdZVWDa4SDTIR/Z6BgTaCInW46vxqsMB2qGVgwz0A204nPNUufT6YOb0GyKQLIt8wmqiY0BJOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434211; c=relaxed/simple;
	bh=wyZa3E9kkaTYHOzAGOsnMry6daIbrAsrJoMr9QEIqaU=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=OoJgm89hQeEsrfrjcIScEuXAT3j+5HxD7/eW+FK9YPJu8t+qIbV0zZ1HDCTHlX1ELJvbrM0P2ksk6PkINy2aq60rCOXGepjkJl2HE9AVuv7Tdh0KRnK6U1sHn0I8pXoyJx2Q718nVCP7nV5boM7qJJDGQiqdpATjTrphc3cPWT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHdbVOWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA224C433F1;
	Tue, 16 Jan 2024 19:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434211;
	bh=wyZa3E9kkaTYHOzAGOsnMry6daIbrAsrJoMr9QEIqaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHdbVOWQLxyQG2vXxt0fFn9RkXmlxCuBWIPE6DXbMHPU4e4HXtvbrChendw2AWiM1
	 5Y8QgQ3a2tkr+pme6Jms3ZYpAcZpZEcwR6W5dClJ9HOC7t9OrVHegO1eqi1BOOia9S
	 xGkEQv2uT8F5Y29iXKpxNWrGOzGGOVkSpnxahaqMMW+805dlswhgHmaQp8Ikp9HhGQ
	 6QXk6hLr+L3/nbFAlGL+xjrQtbij3KRknBjmHzX5AXd1UCNbikpcminsIdXqCjcaHE
	 4UFJVuv4QwiqTETv4iEY2z6yVkGlNUqzVtmnD8IMv0xN2kRADnlqZamWpVKuY02VvB
	 /5EgbfVt2vTAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liam Kearney <liam.kearney@morsemicro.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 024/108] wifi: ieee80211: fix PV1 frame control field name
Date: Tue, 16 Jan 2024 14:38:50 -0500
Message-ID: <20240116194225.250921-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index 2b5e500bf093..52808dd22513 100644
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


