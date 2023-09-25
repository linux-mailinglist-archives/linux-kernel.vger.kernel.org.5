Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E887ADB14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjIYPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjIYPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:13:10 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C9D124
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:13:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 7E6EE3200313;
        Mon, 25 Sep 2023 11:13:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Sep 2023 11:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1695654782; x=
        1695741182; bh=WNyIeVm6Jnga28R9pgeL04yBUoXDsruhsSMafZb8Qb4=; b=m
        KbvEmrex9in2SenyD+O3tpVJYJb9ImjLlZ9k1+oNnElSC8mU/s4VgKGJp9jVt9B2
        onjmvue0R8+ijk3DEjdpsFDxOYlxg59rdN9DRksVztNW1ygghUVFvpArtyZuvfqP
        XjeVPLEjtoVtEUK8kYUaefrF1zr1MAeeXIJuZXxdQmlpujuqoRfySpRsZxYhDFtU
        nmqPGY/Rz6lj3a6JxTtPr4WW6lnHbYKxSJOdSYNwqej7G0sS1Q4sruW3iFRDY1O5
        HhMyCFBTVAk26UNifsB5X6OJ1rfUA+AYtNElcehjM3k6hdmEynDhGdVoGwHkzBx7
        34EY/3sxX9H2rL2lUcBPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695654782; x=
        1695741182; bh=WNyIeVm6Jnga28R9pgeL04yBUoXDsruhsSMafZb8Qb4=; b=D
        LisKG2I4/SiQv37IbzKhzRcCBP6kmcB21lfvaqbKP412IkY+ptrii0Y7lVKWpTl3
        M8bo3jl2ShR6O1dpXyqUiBw9ddKpn71+/N8AtCP7AQkAWeMd/bkPK7ffSJImiEg4
        Q2FE1QOZG8hzhENqO/wPhTTCd8s5O7nTcen4Ef8PENMTtCEdsmn7zOMz7hNWQPXq
        kwtTD86E5Qnuzia9gj24G52WcFGdyJGtrKB4tljY/nbfmKPaxZO3obUT+TtpfL6I
        s6ikMN/fkuEInOcV5WhOFdOjw6GLngq9s7UCULPXVur/I09sTwZR22Xbi2gdtMXl
        jqJ7EY3rHCsn3RLCBC+Zw==
X-ME-Sender: <xms:faMRZaZ3ddYqiCsbtVUiOB-9hKRa3xh3IEHEHeLdJcTRgoopt8yn9Q>
    <xme:faMRZdYxgWKL3V9g3vVVpSz2WBbJXQmhcsTSgaOLxvAMkwzy5txAGgtOcboRGAXT2
    Bh_FwpyrPTzT8bqRf4>
X-ME-Received: <xmr:faMRZU_UcIDgOxHOqn8cxkPpNm1glf0fLPHF9zsp724tdEjxSr6R06Bzr70l_cscJhZVuA_VU0QKYE-LMJh03m2Q_UgXsvaXqJ2TSWBWIEY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:faMRZcrLgI7VKfXc6eAOsvINgwcNXbZIxO5jWIZKoLTg0bdM0vIhfA>
    <xmx:faMRZVoFaqrkSpezonilyNRYanWBgwmqwj5mXuOquJFkEdrYbmeyWg>
    <xmx:faMRZaS_0UuXYqaeoMp882g69nPND87FDPBCmPK3GfvFI4G90X5SJg>
    <xmx:fqMRZc2jyjk-le_B-P4NSz1S4VtXjZ2LdRlbnXxrkKACSElH4S36GQ>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 11:13:01 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/3] rtl8192e: renamed (1) mixed case variable
Date:   Mon, 25 Sep 2023 11:11:57 -0400
Message-ID: <20230925151157.3893-4-garyrookard@fastmail.org>
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

Renamed (1) referenced variable that was written in mixed case.
HTUpdateDefaultSetting -> ht_update_default_setting

Linux kernel coding style "cleanup".
No change in runtime logic.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtllib_module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_module.c b/drivers/staging/rtl8192e/rtllib_module.c
index 2416e0c60255..fc0cc4657fee 100644
--- a/drivers/staging/rtl8192e/rtllib_module.c
+++ b/drivers/staging/rtl8192e/rtllib_module.c
@@ -126,7 +126,7 @@ struct net_device *alloc_rtllib(int sizeof_priv)
 	if (!ieee->ht_info)
 		goto free_softmac;
 
-	HTUpdateDefaultSetting(ieee);
+	ht_update_default_setting(ieee);
 	HTInitializeHTInfo(ieee);
 	TSInitialize(ieee);
 	for (i = 0; i < IEEE_IBSS_MAC_HASH_SIZE; i++)
-- 
2.41.0

