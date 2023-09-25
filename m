Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C017ADB12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjIYPNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjIYPNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:13:01 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749C2107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:12:54 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id A4B193200313;
        Mon, 25 Sep 2023 11:12:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Sep 2023 11:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1695654773; x=
        1695741173; bh=EJ2NcWcPWuMqwyglwvZXQxRzjKLKxClZFTcTgrTgHQs=; b=d
        TQjKl4W2acycNiyyyoVJE+JZi6Ad182aZS7C2n2cVP6M+BGblNH0G6U10yoRZO0m
        M9ILQeNell/f0zWM2HHGBh1+Db2Jz0wFydWBgMakSxGUTqg7AdFusUAtQ27RDHVs
        /26r6D2dWXlGYdqif2BsYjd2ztbKwpoS4vdNO0zqqw3eKNmmNnD6KKVthad5EJ24
        YWnwUpDumX0Os1yAGNQaEdqcoQ1Nzinc0jW01T0FzhrvGXvk3PpNbG7aI7MLTp4f
        3LQObHAev3yTzIcp9ngJCWCmmNDAVSaRjsO46nPYqGkzE1z4qOxWiZfCyNmZQRds
        4idP85ooNftNUIMxNZ1/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695654773; x=
        1695741173; bh=EJ2NcWcPWuMqwyglwvZXQxRzjKLKxClZFTcTgrTgHQs=; b=g
        9H6qh2zJo7VTpHTigwBmqlTTQd0+xzIJ6pHKtxduQ4zZ6BQkE4NAe2obDNrL+P4X
        Ggk9cpPtGeMQ4U2aEZQtvncj3W/jyJFRlORAC6P8lsMSfBpocuNEdzwzfx3iBzj9
        faNrADw8zJz6Dhcfid/oAADx2TThjwDmiAQSfk9wSK+sfn8y74dI1O2KMrbBu6Uh
        iiVOVYXWzxVPznyVXIyeS5WDkTVbDb0eK6Dl4lPW+Fm8NbJvs7Jg+dS2MyVamkTl
        su7+LGnBjzXf/CirEi072Z8jgok1YtUuz13IPjW4NHEF9iSpoe01QFfTEvv6af2+
        Z0ljt4wkL09mxzAVUimbg==
X-ME-Sender: <xms:daMRZcjZRosSFRqccY7Iu7iHu7bR-GKeLSzkwCLEA0RDb2fWUZ1big>
    <xme:daMRZVCGKnH0ncWVaayEW6bK69yTxRPACHFGzbM1DM5L-ERksek51EaTU7zoHK9gP
    AKRXsiFpbwehCuCK9U>
X-ME-Received: <xmr:daMRZUFo54yEt07g5tMjNe-qf97C1e_oNHV2p301IT8Yd2m5tqG2IqzZUcLpKfN52KiTzjQr1dBO96NEOkRm4v7cRIjHSLfVNRzNUm7UFt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:daMRZdQ1AaUsCe-z-XPoIK2mWk_0UvxwPBx4D63tAKopzODKtIrwug>
    <xmx:daMRZZwnlAsdEwLViJEUuNpYjhd55FWrUPjEzmPtS7K0-4Lap0EIPg>
    <xmx:daMRZb6hYVbcn2u9Cn-nkATguZj7pya5dwJIfKH9qJbLaFf3TVo4DQ>
    <xmx:daMRZU8MCt2IqG1-w6MFy_QhaMfzLOTEmcEJa8DX8GOWFBowYTVSvg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 11:12:52 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 1/3] rtl8192e: renamed (1) mixed case variable
Date:   Mon, 25 Sep 2023 11:11:55 -0400
Message-ID: <20230925151157.3893-2-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925151157.3893-1-garyrookard@fastmail.org>
References: <20230925151157.3893-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed (1) prototype variable that was written in mixed case.
HTUpdateDefaultSetting -> ht_update_default_setting

Linux kernel coding style "cleanup".
No change in runtime logic.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtllib.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 5517b9df65be..1a3dd4dcad81 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1807,7 +1807,7 @@ int rtllib_wx_get_rts(struct rtllib_device *ieee, struct iw_request_info *info,
 void HTSetConnectBwMode(struct rtllib_device *ieee,
 			enum ht_channel_width bandwidth,
 			enum ht_extchnl_offset Offset);
-void HTUpdateDefaultSetting(struct rtllib_device *ieee);
+void ht_update_default_setting(struct rtllib_device *ieee);
 void HTConstructCapabilityElement(struct rtllib_device *ieee,
 				  u8 *posHTCap, u8 *len,
 				  u8 isEncrypt, bool bAssoc);
-- 
2.41.0

