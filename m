Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32D275BEDF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGUG3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjGUG3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:29:30 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85B2D58
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:29:27 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6fm21w73zBRDtJ
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:29:22 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689920962; x=1692512963; bh=tDJteWg3Jdb43RW9e1MsfKXwxaa
        RkDZKhkFPyrYOd00=; b=mMZDGWwDRdxO2hCm1HSIqBz8HIVYgwWGpw5lxl+tpX1
        zQMlHsW0Gn7HvNz2yt9U8/R43ydGzXNihMMMr1EjW9ZxHqguJcq6qo1i0YNtPRAK
        1I7LKYRZE+HT3EJeo4RDJfqMTCj6mNcB2u65A3ggIaa3ABzABnvDnVc4uSJX7etg
        XzmOC4wT2OwYbyif/GA7nuwXsUNruWxxDZKtsMm4ZWPl4f5PDVOYtA2oc6vevFeZ
        wOpl8LjqrM7rZ5fW8QxEbFl+iEJJTMAzcdQ4IUaMAlr4lhtrxSlJV3fyR+RpPhYq
        YNrmVyGO7ZZ8YIntxgojj+nb9OxOXyTsV+gefRVmAMg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aMzGug8cI60k for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 14:29:22 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6fm172sGzBRDrq;
        Fri, 21 Jul 2023 14:29:21 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 14:29:21 +0800
From:   hanyu001@208suo.com
To:     stf_xl@wp.pl, helmut.schaa@googlemail.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: wireless: ralink: rt2x00:
In-Reply-To: <tencent_5118A9715146B132F423C8C9B6A3237C9E05@qq.com>
References: <tencent_5118A9715146B132F423C8C9B6A3237C9E05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <3620e0bc76d3715cb8aecb0c7874390e@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:"foo* bar" should be "foo *bar"

./drivers/net/wireless/ralink/rt2x00/rt2x00.h:386: ERROR: "foo* bar" 
should be "foo *bar"
./drivers/net/wireless/ralink/rt2x00/rt2x00.h:513: ERROR: "foo* bar" 
should be "foo *bar"

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/net/wireless/ralink/rt2x00/rt2x00.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00.h 
b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
index 07a6a5a..c883d7f 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00.h
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00.h
@@ -383,7 +383,7 @@ struct rt2x00_intf {
      atomic_t seqno;
  };

-static inline struct rt2x00_intf* vif_to_intf(struct ieee80211_vif 
*vif)
+static inline struct rt2x00_intf *vif_to_intf(struct ieee80211_vif 
*vif)
  {
      return (struct rt2x00_intf *)vif->drv_priv;
  }
@@ -510,7 +510,7 @@ struct rt2x00_sta {
      int wcid;
  };

-static inline struct rt2x00_sta* sta_to_rt2x00_sta(struct ieee80211_sta 
*sta)
+static inline struct rt2x00_sta *sta_to_rt2x00_sta(struct ieee80211_sta 
*sta)
  {
      return (struct rt2x00_sta *)sta->drv_priv;
  }
