Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FF87DA32B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbjJ0WLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346583AbjJ0WLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:11:19 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18181B6;
        Fri, 27 Oct 2023 15:11:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D0BC43200930;
        Fri, 27 Oct 2023 18:11:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 18:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698444673; x=
        1698531073; bh=QkagzItTcmygJhd+IgCnn6qdrUYk56vVzdHfbFmNb0k=; b=U
        5qTKlfx1FZYPNAKnzlTeLKGKoofCV7h76mwVgJ50l/M6yFvDiBQrVIRc3F3UIamy
        RNdQTuGM3mqjx+YXckktQGhOPZy0iggxdsf59DjA8s2e29ANS/6kMEEfoOiOQEIi
        I0C+R/BuYbWM/InhMq1Y9ZTH8awtTpJG9tgUcySj7KuTFnJlAns2fLgbUnz/RXCk
        xV0Z1vsKuHqotYnHQWDnsCKOL9/6GBvhzmaPeSTTvmn61/gx6VteF2wTx49AErHQ
        J3meEd9xI2tsXBX+0CqLVKzZdLXQd90xrmovm5tBi/kdQDd/dfiDAbw+0pXu9rws
        knnY8gcrDNT2F2kqA+F2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698444673; x=
        1698531073; bh=QkagzItTcmygJhd+IgCnn6qdrUYk56vVzdHfbFmNb0k=; b=e
        cq6gFaFi5FoZ0T12bdQZf0URDU0JWp3hUeKNP5Ien5CVyaSgB+YaR3JdtEy179cg
        ZIPpHfRnST41jiFW9SbwYbObuhqVbHdYRFTMIB9mOqRCk5NqN+Jjx9KUyhHtS2rO
        eOpQBo5ROzqDAlkwbwZse46nHo1WiCcN+wshDLtlkGI2jWA3OyVrpN1OINqmthI6
        Zxp3guM85S8wVpsIZ8Jtfum+0uXb1Mii4+5GIooKn/SrSrj6/av54t7VsIYft6kG
        VeGr2xSZWfvuynaAkROFIOd3ML7wd7U5TjaKHYb1d/BO9T+lxgYqw1s/UuiJKMtg
        waHNVGX1XEZ+zl4gBfV3g==
X-ME-Sender: <xms:gTU8ZSHlf4PqSKbeUEEOBoXPB0wsw2Hrsi4XnAQp64iSfaKINQb6ZA>
    <xme:gTU8ZTVRsgV6PtZhpsoa9X57xIfbTGh6Ludj3FUPFIOR-U-TOcYJSP1GCfT20A-lg
    pVBL8cXvQqTIC2qLaA>
X-ME-Received: <xmr:gTU8ZcKJHmxBhf7_nMSt6qUu6ujs4tsImd6DtLSB8BeEak7OvNO24sIznmiwM2R7e_WDRABeYMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvuedvvd
    egkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:gTU8ZcFfgPhCGYE75ffg29uz6mziHFBYyQkek3Dnym9bYLLm9xGk_w>
    <xmx:gTU8ZYXv3wSEja2EBiKibohJlQzpA2AgwLqyi07FoK1dxC9QR7922A>
    <xmx:gTU8ZfMVDepWTGGip1mGByHWLEMA_ZdGgCNWDd_BXw2iQfBqHaTZ1A>
    <xmx:gTU8ZWxtOOw48qHAeo89s3ESXTeCgLVLwY5JIB7pkaq3vp_53C_CdQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 18:11:12 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 01/10] MIPS: Export higher/highest relocation functions in uasm
Date:   Fri, 27 Oct 2023 23:10:57 +0100
Message-Id: <20231027221106.405666-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
References: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export uasm_rel_{higher,highest} functions.
Those functions can be helpful in dealing with 64bit immediates.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/uasm.h | 2 ++
 arch/mips/mm/uasm.c          | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index 296bcf31abb5..12db6d2fca07 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -196,6 +196,8 @@ void uasm_build_label(struct uasm_label **lab, u32 *addr,
 #ifdef CONFIG_64BIT
 int uasm_in_compat_space_p(long addr);
 #endif
+int uasm_rel_highest(long val);
+int uasm_rel_higher(long val);
 int uasm_rel_hi(long val);
 int uasm_rel_lo(long val);
 void UASM_i_LA_mostly(u32 **buf, unsigned int rs, long addr);
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 125140979d62..6846bf2084c5 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -425,7 +425,7 @@ int uasm_in_compat_space_p(long addr)
 }
 UASM_EXPORT_SYMBOL(uasm_in_compat_space_p);
 
-static int uasm_rel_highest(long val)
+int uasm_rel_highest(long val)
 {
 #ifdef CONFIG_64BIT
 	return ((((val + 0x800080008000L) >> 48) & 0xffff) ^ 0x8000) - 0x8000;
@@ -433,8 +433,9 @@ static int uasm_rel_highest(long val)
 	return 0;
 #endif
 }
+UASM_EXPORT_SYMBOL(uasm_rel_highest);
 
-static int uasm_rel_higher(long val)
+int uasm_rel_higher(long val)
 {
 #ifdef CONFIG_64BIT
 	return ((((val + 0x80008000L) >> 32) & 0xffff) ^ 0x8000) - 0x8000;
@@ -442,6 +443,7 @@ static int uasm_rel_higher(long val)
 	return 0;
 #endif
 }
+UASM_EXPORT_SYMBOL(uasm_rel_higher);
 
 int uasm_rel_hi(long val)
 {
-- 
2.34.1

