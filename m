Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9643B759220
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGSJ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGSJ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:56:41 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1F5EC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 02:54:37 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5WPj4zrFzBRDrQ
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:54:33 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689760473; x=1692352474; bh=iZ7MHDXMAeTe21V130fRphXLFoc
        oLkF9T3oPe8TXaRU=; b=A7FrCShP8IWzWnXTNctVB5FUbpvV3i7boTOXyu0+Rrf
        6EjkxZQwKnlCi3OwEOofgQunTbAQcEWuFIrKqfmmqcKw4F4qSa5MiiIx+QAeYRZZ
        r8L8qwJcFmagKCzdJ9O3hcRDreEJ5ohA679Z4j+wMYUceng2+qF6cFPjkFPrep55
        XhF1lZUkTfbCkA4ixJCypzCpfRETwUamm1mcTg1hWybaLEyvvLx1C220uVK+21FI
        U09KhGw4bhD6pothBSubf3GWomiQciRggHESM3B+QD7BsNKKrPCl3/5iMB+NxC4d
        E6u7vuyaFLzQnuPQBF+It3DFBu4VPfYmKexUgA6H8Wg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S-LwKX8xerZ0 for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 17:54:33 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5WPj3JmgzBRDrF;
        Wed, 19 Jul 2023 17:54:33 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 17:54:33 +0800
From:   hanyu001@208suo.com
To:     pkshih@realtek.com, kvalo@kernel.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtlwifi: rtl8192de: phy: "foo * bar" should be "foo *bar"
In-Reply-To: <tencent_56B12E143DA8D1D6A9C3669E04C963914905@qq.com>
References: <tencent_56B12E143DA8D1D6A9C3669E04C963914905@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <8ef50a4e96014949bbfde956edd07108@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the checkpatch.pl error:

./drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c:2434: ERROR: "foo 
* bar" should be "foo *bar"

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c 
b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index d18c092..27b029b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -2431,7 +2431,7 @@ static bool _rtl92d_is_legal_5g_channel(struct 
ieee80211_hw *hw, u8 channel)
  }

  static void _rtl92d_phy_calc_curvindex(struct ieee80211_hw *hw,
-                       u32 *targetchnl, u32 * curvecount_val,
+                       u32 *targetchnl, u32 *curvecount_val,
                         bool is5g, u32 *curveindex)
  {
      struct rtl_priv *rtlpriv = rtl_priv(hw);
