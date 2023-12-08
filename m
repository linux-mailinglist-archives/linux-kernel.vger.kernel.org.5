Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587078098E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572972AbjLHBzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572952AbjLHBzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:55:15 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C71AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:55:21 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B53215C01F9;
        Thu,  7 Dec 2023 20:55:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Dec 2023 20:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1702000520; x=
        1702086920; bh=PKi9VhuflI7LpDvHoat4EZNxSnaWpvricOV0daR6G7E=; b=L
        joWlRzf3SkeV3uK55L6mYliC0H2xKeUDsrZhxQeDJFarvLIEe+b+KCURe0a7H3wn
        8X4l0R222XbaOdDAqAGpYvdnwnQjMXVKhy2n06FV5HOLhBX9j9BXYwFucehXoN4M
        LILtP0THvdOqbTrnEXAEUaip/YL7Z0pGeTIEcQX3JxzHG32WDhScJwfKBYXlaWR8
        +k+LUzTKjBJBLn6X+HCQ3wOsqmtpH6+lsLmtbF1xoFMWa9D3JUSZ5VZo8vp6+Fiq
        xnJUyY47bNAd58WiiU5xyl4JrGo1pIQF3alXtq+XWg7C9hSM/D+PeUYzd/PQW4cf
        3ezkHabYnR6C1ATQKLCRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1702000520; x=
        1702086920; bh=PKi9VhuflI7LpDvHoat4EZNxSnaWpvricOV0daR6G7E=; b=2
        Emq2YkaWYxH2OKHYHggZerU3SdKBtQRk9Pj+CAXj/A4NPfHKX5xjLUOBD/xFeIfw
        hIstTdwtzveROlZRvvVYJnDup+nmnSV6LNYx7dO1u/eViSn4ijcnyrN7DpjWe39C
        IwzO5Y//ZpE6542kYpP+BQkPqB0V5zNYh4Rn62+mkA/MVgxHGQyYTmjTjVM2mD8h
        0uTZkFme2KGkyUH9PXhoJP+CviQb/RmLi9UATGqy7arpfGPp6oOEI64kaZznsjDG
        IefJQHlrYfG+9sPH+Ugq3wyF1r2X16xg9dKjn55OzVbNBY8ImJLbSBNANjUaCHdr
        6jhox3qyLuPQxixcm1LTw==
X-ME-Sender: <xms:iHdyZe-QvnaTVOQYgwRnvpZ9FK_Vs8wuRpQo7LJEzVh4zDtKSys9Ow>
    <xme:iHdyZeuLpOubtWZPaWsT14bzVtdO_7WcclB7BnmoqxNXulWZOEM6o4isncyVCQK1z
    y7XTCzz-rWaen7GhuQ>
X-ME-Received: <xmr:iHdyZUANyehoCPDT1bNMfLv0OSYTNXbQUSwjoFYqFxza0HaMD5gyQ8mwy93bwuJ6IRu_6uQTESeos5Qv94gtQPK2-lSajItAPPzl0txi7WM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudekgedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:iHdyZWeQZbtVBTpBHdWoB6OjxDC5QEcetXWHVixgQgIeiGRIq2iMOg>
    <xmx:iHdyZTPKMrcr2cjxQy4eT3mmIVo6HU3e9DsOGyJhlnF6g7wQrDEeww>
    <xmx:iHdyZQmGNMRuO3IGuJKY84cqJOgu3ddDMIdcRf6vBdbb4XwAvWXMYA>
    <xmx:iHdyZcpD-sUhqOWISE5fJoLYspXTZXj4CswlE4kxqIvAC7fFhVd1og>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Dec 2023 20:55:20 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/5] staging: rtl8192e: renamed variable CCKOFDMRate
Date:   Thu,  7 Dec 2023 20:55:34 -0500
Message-ID: <20231208015536.21013-4-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231208015536.21013-1-garyrookard@fastmail.org>
References: <20231208015536.21013-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style issue, checkpatch avoid CamelCase,
rename it. CCKOFDMRate -> cck_of_dm_rate

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 633f735bdab1..73c0204303ec 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -116,13 +116,13 @@ static u16 ht_mcs_to_data_rate(struct rtllib_device *ieee, u8 mcs_rate)
 
 u16  tx_count_to_data_rate(struct rtllib_device *ieee, u8 data_rate)
 {
-	u16	CCKOFDMRate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
+	u16	cck_of_dm_rate[12] = {0x02, 0x04, 0x0b, 0x16, 0x0c, 0x12, 0x18,
 				   0x24, 0x30, 0x48, 0x60, 0x6c};
 	u8	is40MHz = 0;
 	u8	isShortGI = 0;
 
 	if (data_rate < 12)
-		return CCKOFDMRate[data_rate];
+		return cck_of_dm_rate[data_rate];
 	if (data_rate >= 0x10 && data_rate <= 0x1f) {
 		is40MHz = 0;
 		isShortGI = 0;
-- 
2.41.0

