Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE83E7B02EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjI0L2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjI0L1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:27:53 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002AE10C6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:27:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4EA195C00AC;
        Wed, 27 Sep 2023 07:27:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Sep 2023 07:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1695814046; x=
        1695900446; bh=9NSleIhNsUxrW/h8HFYlP96OdXovPf5S5nHOqfH/0zM=; b=r
        B/8xiTcjSmzbefkZreagUPFzwfS0exRoEuRA31dQLORO8sis0+J60pqNJvuqhFTG
        mqGn3gM71IxWZxyehbjLfIJxozsCmDj8yXgiLohd3E3509ygX2pSR7zIdVGHj1aj
        H6TT291OPlPwbgbcGA6oJpcQMpMA9vI4QnXm5NfDqNoPQ00qXF6rvcVc8EibutSW
        TFKvLC4G6SUjczIy606S8jYEY+8NLRpj58+1U23IW2YlneNowFxyuADLrSw7GghP
        PyP5+H8BBS2dHEbkoUZ6Qzy+/XRze6CwNUsJWaLeKiBIr/CwsMyre7YIr6CkizCX
        Wij4gv/9aLpbMl7Saxxow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695814046; x=
        1695900446; bh=9NSleIhNsUxrW/h8HFYlP96OdXovPf5S5nHOqfH/0zM=; b=n
        +Oll4JJck8s1WVuR3cNXUpLgPt0SFV2ibknH5xFIDXli/zGW9Jkums2l7h65VMkv
        ykGw/2EK2oWmibOB7J+8+bibAia8cVbrA+00/HQf3njdsOd29vqSn9JvOxSnI/Dx
        x/B0wFuUNdH6UOmLWZM26bkvhDKDWZNMG8i+f7AOrEc6/ztBhjxIZVBmK2zDHD7S
        vosY7a77/Whi/62ntVhYm8nW7uOZpGgkDEBJDMKw0qhBOUvoe2+EjtwUjeSLFlyA
        1gMMICcdXog5OIZ00//hRH1mJ+CGoz06+0ojN54TI7kXrgilLkMwy7HZvkMHfEwt
        kIs9zKDdu1TDb4hO2GvZg==
X-ME-Sender: <xms:nhEUZejLd-HB9gI8JvVd6IVk7NivEfhQKcs-1YytZ7kyfmvPYdkRDg>
    <xme:nhEUZfBdChOpV_fZR4V-L1rToXsH2NpygEukZtntwkUUnDo0UG2lKNIdxI0JwRRl6
    5sjhflhl92LMDImMFo>
X-ME-Received: <xmr:nhEUZWH3bxwFGUO-LmxgfzF-5Klxi6bFnEXkju3BZnyPIvPomjurU-kxRh3vp07YVhmGUO9CKM4cCJ6cFX4DZ0XoIpvMj-2Jl1I_p8Bx1uU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdefgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepifgrrhihucftohhokhgrrhguuceoghgrrhihrhhoohhkrghr
    ugesfhgrshhtmhgrihhlrdhorhhgqeenucggtffrrghtthgvrhhnpeekuedvffeuudekge
    eiueffjeehgfekteefheeuleefudeugfevleelhfefgfejvdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrghrhihrohhokhgrrhgusehfrg
    hsthhmrghilhdrohhrgh
X-ME-Proxy: <xmx:nhEUZXTmPCSvAc0Ihn-7YbxYrDUGGiNCsHuxPFZsPGOavjszQmzFcg>
    <xmx:nhEUZbwbLmz_XL0id962dqzPs_Urk0dcAmBNiaBkcQ_oiAioJboKvw>
    <xmx:nhEUZV5Tw5Ym7YOFLH_uNKyv-7BL6TMuMZzO0uZCQkJWgV1ffwLJuQ>
    <xmx:nhEUZW9kIhhyiSKug-OnQVwkdSjJEzgmVy_P-bfUhrSlbqupKgAO1g>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 07:27:25 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 3/3 v2] staging: rtl8192e: rtllib_module: renamed a referenced variable
Date:   Wed, 27 Sep 2023 07:26:35 -0400
Message-ID: <20230927112635.27637-4-garyrookard@fastmail.org>
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

This patch renames a referenced variable from being of mixed case,
HTUpdateDefaultSetting -> ht_update_default_setting.

Linux Kernel Coding Style "cleanup", no runtime change,
drivers/staging/rtl8192e builds/compiles before and after.

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

