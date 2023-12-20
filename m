Return-Path: <linux-kernel+bounces-6124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A11068194E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 453FBB238AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3973C17E2;
	Wed, 20 Dec 2023 00:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PKTFgcrd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26623BE4C;
	Wed, 20 Dec 2023 00:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 61D837DA;
	Wed, 20 Dec 2023 00:01:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 61D837DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1703030500; bh=jTG5dpMX6psNetWgHqT85RaanezwkMuMisj0ITm0ioU=;
	h=From:To:Cc:Subject:Date:From;
	b=PKTFgcrdEopAi67xnqTUoADR0ekAwSZca5EQZXRiu0s0VCrnJUSZH2jw0hKdL2XJr
	 IvqONFHTjtT16Oaw8iLyEqeT37Lis2UYUH7FFM2s6SMD3+ymsLSXCuBjnppnSXtkGw
	 VK/VxIGgopdoBXQfhTxuBd2AYIIK6lRbEok5KLAnsNqskfkHMU5qdGXzwCBaWkAapx
	 /mBsniOra91aEquQtW9L73957O6dP6pvnDDujjlYcQVRkhGRurPpYUOJWOLGp0BJW3
	 tSxIISBkmZvZfG0XN5vjgRM05ri1mabw8vJKzY1R39TVUbFucNYm8gheFr14Hz3itV
	 1J3896O74KWdg==
From: Jonathan Corbet <corbet@lwn.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: address several kerneldoc warnings
Date: Tue, 19 Dec 2023 17:01:39 -0700
Message-ID: <87plz1g2sc.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

include/net/cfg80211.h includes a number of kerneldoc entries for struct
members that do not exist, leading to these warnings:

  ./include/net/cfg80211.h:3192: warning: Excess struct member 'band_pref' description in 'cfg80211_bss_selection'
  ./include/net/cfg80211.h:3192: warning: Excess struct member 'adjust' description in 'cfg80211_bss_selection'
  ./include/net/cfg80211.h:6181: warning: Excess struct member 'bssid' description in 'wireless_dev'
  ./include/net/cfg80211.h:6181: warning: Excess struct member 'beacon_interval' description in 'wireless_dev'
  ./include/net/cfg80211.h:7299: warning: Excess struct member 'bss' description in 'cfg80211_rx_assoc_resp_data'

Remove and/or repair each entry to address the warnings and ensure a proper
docs build for the affected structures.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 include/net/cfg80211.h | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b137a33a1b68..81c46c8e2a68 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3180,8 +3180,8 @@ struct cfg80211_ibss_params {
  *
  * @behaviour: requested BSS selection behaviour.
  * @param: parameters for requestion behaviour.
- * @band_pref: preferred band for %NL80211_BSS_SELECT_ATTR_BAND_PREF.
- * @adjust: parameters for %NL80211_BSS_SELECT_ATTR_RSSI_ADJUST.
+ * @param.band_pref: preferred band for %NL80211_BSS_SELECT_ATTR_BAND_PREF.
+ * @param.adjust: parameters for %NL80211_BSS_SELECT_ATTR_RSSI_ADJUST.
  */
 struct cfg80211_bss_selection {
 	enum nl80211_bss_select_attr behaviour;
@@ -6013,7 +6013,6 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
  *	wireless device if it has no netdev
  * @u: union containing data specific to @iftype
  * @connected: indicates if connected or not (STA mode)
- * @bssid: (private) Used by the internal configuration code
  * @wext: (private) Used by the internal wireless extensions compat code
  * @wext.ibss: (private) IBSS data part of wext handling
  * @wext.connect: (private) connection handling data
@@ -6033,8 +6032,6 @@ void wiphy_delayed_work_flush(struct wiphy *wiphy,
  * @mgmt_registrations: list of registrations for management frames
  * @mgmt_registrations_need_update: mgmt registrations were updated,
  *	need to propagate the update to the driver
- * @beacon_interval: beacon interval used on this device for transmitting
- *	beacons, 0 when not valid
  * @address: The address for this device, valid only if @netdev is %NULL
  * @is_running: true if this is a non-netdev device that has been started, e.g.
  *	the P2P Device.
@@ -7270,8 +7267,6 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
 
 /**
  * struct cfg80211_rx_assoc_resp_data - association response data
- * @bss: the BSS that association was requested with, ownership of the pointer
- *	moves to cfg80211 in the call to cfg80211_rx_assoc_resp()
  * @buf: (Re)Association Response frame (header + body)
  * @len: length of the frame data
  * @uapsd_queues: bitmap of queues configured for uapsd. Same format
@@ -7281,6 +7276,8 @@ void cfg80211_auth_timeout(struct net_device *dev, const u8 *addr);
  * @ap_mld_addr: AP MLD address (in case of MLO)
  * @links: per-link information indexed by link ID, use links[0] for
  *	non-MLO connections
+ * @links.bss: the BSS that association was requested with, ownership of the
+ *      pointer moves to cfg80211 in the call to cfg80211_rx_assoc_resp()
  * @links.status: Set this (along with a BSS pointer) for links that
  *	were rejected by the AP.
  */
-- 
2.43.0



