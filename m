Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069C075A5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGTGE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGTGEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:04:54 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240791724
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:04:53 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R62G72d0nzBRDsB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:04:47 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689833087; x=1692425088; bh=wN9MJCeTp0uLboPfJ3UF4H7+r1d
        VVYUCJ5o5m7snluc=; b=w7GD9fvycDKvEE/BVr0h4oL0VCt1iV+TZbBBasw2Adz
        N37ZxVPt7RLvnSGjMj0ikUYDIv3Y5AAW+i717i7oJyR0xIUj5eqspO8emBISdmdQ
        uAC5c4bOIhRlYshDTa+K6RQDf+la8Jmaj9IOT4H4qXWb7lHUFQ8kAvpdsQFKggg2
        3+dJqLk/R9wwy/5r9kneGfFxieQ6jmrw4+WiMhJe/iZrrl6kYpkRpFvjlpE3VXxX
        gyrk9gIrsqSt3aen0WIPPvbwAN3ULdsn+Xxs38C+gDyg03iYpA0PMXMSy4qNhXMi
        kst1yeCtPl1FFojbCPe+igwFO/J6lWci7ZVAbfBSZ7g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9AMWSr0VeRTr for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 14:04:47 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R62G66P2czBR1P6;
        Thu, 20 Jul 2023 14:04:46 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 14:04:46 +0800
From:   hanyu001@208suo.com
To:     pkshih@realtek.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: rtlwifi: "foo * bar" should be "foo *bar"
In-Reply-To: <tencent_1E1DC9F32D48318BC38ABDA111410EB69808@qq.com>
References: <tencent_1E1DC9F32D48318BC38ABDA111410EB69808@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <cb183c8c82f9bcaa245efb4a8878ba1b@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl error:

./drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c:416: ERROR: "foo 
* bar" should be "foo *bar"

Signed-off-by: Yu Han<hanyu001@208suo.com>
---
  drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c 
b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index b70767e..c86102b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -413,7 +413,7 @@ static void _rtl_rx_process(struct ieee80211_hw *hw, 
struct sk_buff *skb)
      ieee80211_rx(hw, skb);
  }

-void  rtl8192cu_rx_hdl(struct ieee80211_hw *hw, struct sk_buff * skb)
+void  rtl8192cu_rx_hdl(struct ieee80211_hw *hw, struct sk_buff *skb)
  {
      _rtl_rx_process(hw, skb);
  }
