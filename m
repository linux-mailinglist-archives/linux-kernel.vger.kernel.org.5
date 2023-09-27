Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942847B02EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjI0L2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjI0L1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:27:51 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE95ACF2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:27:24 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 152145C2751;
        Wed, 27 Sep 2023 07:27:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 27 Sep 2023 07:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1695814044; x=
        1695900444; bh=BRpPi50hjJUOf5UE0EKv6PB4F0teNhUMG/rF07uWWX8=; b=n
        KHAF44qDtMOAuEs0h9O35XhfDomRKzYVkGULqo5JCXNjjwTJP0O0lx08wmWkStLA
        vb9Kfb+ViDIkz+OkphmLDwpxFDCYiZC8sfbToUICFjb4bJnPsiqgKVo4qkHqG/3J
        a6JTO73O6pnusTEPvagqOlNrEVCVZABOwT9ZO7SJLn5x5zmQRyFPC0X5Xkh/mQao
        0ws0OQMyWWc0wJkxudl9P6TfR/MKBVczC43JOoJh6x4S/W5Pqcko7rvF4z4ZojZf
        lKpZXX2dxNVMOU654tXeiom1TGU357XR7L4Ii2W4wc+RVklFla0bbV4/SMvctDHd
        O6wKdEW+j/Z/B3Yz0kVOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695814044; x=
        1695900444; bh=BRpPi50hjJUOf5UE0EKv6PB4F0teNhUMG/rF07uWWX8=; b=G
        pKuaGI3Wk3q3QIc3mvi249yCHhAoOG9XR7EaU4yalOdqi9+Ty075OlsA6MmIJ1zP
        dXfvxPgnSeCVvhajzrnYrbG+2Uf8RthF63A76xaFSfmNwxjHnmp+gRRKjoLxX+B7
        1KlVcwXTLmw2A79vqlmWxxkdA+QinvgnImwBNe2vIn7FN1T1xjDA4lxhNb4IE7y5
        uWuSRQRJCDg4Yy7kx9zyFl/KxFCRi5ntQml96ACpNbFTZfW0T/8Q3BVo/f8ulcbK
        fRhM5RX1VTtCiD97nUpprUXJzl/AOJss9N+6CkPOuJz96uB7i7WUHA15PNCB3p9B
        N/sd4L1XNcREcBU+E9sdQ==
X-ME-Sender: <xms:mxEUZdBWy9hdt4MwVaXreQ3HjD3B1g1irG_H2H8DrMT2R-MLzhKzlg>
    <xme:mxEUZbjySK7lpM9eAbAfU9gVbgcR83WmOHMnMrsGPWh0l2Y_IMjQ0cVsVrMzOQ9vP
    bbihZzqDBGkSSQleZY>
X-ME-Received: <xmr:mxEUZYkAIQgIZDtHxoDJVmN1FRY6U3Uhkte4Svl5hHjO5Sxu3pmfRWoFWHjKeLWG6XquYFUnWT7X2a3gzGgMJxLte0IBGIM0Cpldk04B_-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdefgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghr
    ugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuudekge
    eiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrg
    hsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:mxEUZXy8t60-vRbUogk8EdqJDcX954cB47dHZYg_OL3fs62lJLLZ4w>
    <xmx:mxEUZSRtJpFBe1SxTYR6S3IhPQkgxC1hXvSDvLVms7evu4GAW4myDw>
    <xmx:mxEUZaZsgaljL8prMrLx9DXq9BrdZKUCE2Scl-WSNjwGtot4evoenw>
    <xmx:nBEUZdd6vHLMXfBHj0RlblV_ZEAXWF-wK_VDfJNVn3BUlS48RUsMOA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 07:27:23 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 2/3 v2] staging: rtl8192e: rtl819x_HTProc: renamed a function variable
Date:   Wed, 27 Sep 2023 07:26:34 -0400
Message-ID: <20230927112635.27637-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927112635.27637-1-garyrookard@fastmail.org>
References: <20230927112635.27637-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames a function variable from being of mixed case,
HTUpdateDetaultSetting -> ht_update_default_setting.

Linux Kernel Coding Style "cleanup", no "runtime" change,
drivers/staging/rtl8192e builds/compiles before and after.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f19feea46158..630acfaf6d55 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -67,7 +67,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
 
 static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
 
-void HTUpdateDefaultSetting(struct rtllib_device *ieee)
+void ht_update_default_setting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-- 
2.41.0

