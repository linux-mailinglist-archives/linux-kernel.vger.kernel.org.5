Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA38A7DA33A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346723AbjJ0WLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346679AbjJ0WLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:11:36 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1507D4F;
        Fri, 27 Oct 2023 15:11:27 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 82BD53200959;
        Fri, 27 Oct 2023 18:11:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 18:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698444686; x=
        1698531086; bh=U85JK5asZNHXyazqwXB2WH7hdrGFnY8ew4l7GY3z8ws=; b=s
        4NE1qnOSBoS2iVrpYr9QuYwILsmugVjmKkQHUkY7J8eFHX0hrCQSvoopDEwBotlW
        75gmShT5g5E4tvz1UMAqNrwhCfiAy7gPeH6liU8fgyG7ONmzaNwxhM6iTWVKolBh
        7wk5MMtqkFneXOkP52T2QwM7zTBi3plmrHeFLW32f17mrdv00SCDrSMiDxhffARR
        UTLAyqB/E2ntdb5neEVMIXttkOhNB9bfiYRXLwaDi7n+IU4tGLVhV2LzDnH38R7T
        /sMJ/Iw9g2d4OYh6ta6PxiUnTzO5P7p163VAgfpkPoarMqyIyHD6bk24vf5LDA3Y
        me42xe4N4+v9qUtQlL8qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698444686; x=
        1698531086; bh=U85JK5asZNHXyazqwXB2WH7hdrGFnY8ew4l7GY3z8ws=; b=q
        WaspJFc/VKdZJFR+rB5R4nwxBOUuy/43Y/PQaXS4k8QznexnhItpphmt8CEOEvV/
        3CQMgFX28dzc466fVcmMl7zLGoflURVfkm52jqNXskWpLmEv8dLbZXjtqYniJqeO
        XbYrc8H5MdcYWnyvAlnSb7sGfsqIupovxoibt0LP+VzuT3YA6WVRf94Q53nWAb0N
        6ueWERQ1SlYKivZWlIWe76PT25zXu0OmCGiTgNQo5f7o4Pc61ozOT6AbQIEft5XH
        9ggqr/gTkNrYZszsGPNIsdvGTKOm5adOefx2T4qa7/Kp1jJZhZp2a4zm98TFysw5
        cdAb9K4ONijFXwE2puxbQ==
X-ME-Sender: <xms:jTU8Zao4bMxe9mh_EZMsay3IqM-KFH1OB8GroqCTNDANGxlMnHxOoQ>
    <xme:jTU8ZYr4qjUEbb_JC_Iohi1VPEKpwW3x0cux0C-5jBvK_0q6HgDhLAjKQnQM8gD1u
    3_c84Pq0uyWp7cnehQ>
X-ME-Received: <xmr:jTU8ZfMmsDc79NeK56DQSjAX3qH6_rw43t2jEoAXcUqB7s-mkWesNVHRFoGwjy5Uzf1-pDY1aI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvuedvvd
    egkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhiiigv
    pedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:jTU8ZZ5T5t8wyktrDy1Q2cPyyb3ZQlGBO6v6vqNfHyVTm08IZSp_HA>
    <xmx:jTU8ZZ5SHZqoLED862ywuo-o8aQIwLjs1lU3KJ_iXCVv0dQY-I8ung>
    <xmx:jTU8ZZi9RKWAFV4yhlbCHBWbBvgmkqbxb9WGTIBGJpKrtKkemV09vQ>
    <xmx:jjU8Zc1Th004v-0svwgPtFqU4MGS6IXKtVIF169iLg7hLf0ojcfCxw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 18:11:24 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 06/10] MIPS: Allow kernel base to be set from Kconfig for all platforms
Date:   Fri, 27 Oct 2023 23:11:02 +0100
Message-Id: <20231027221106.405666-7-jiaxun.yang@flygoat.com>
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

There are some platforms in wild that generic loading address won't
work with them due to memory layout.

Allow PHYSICAL_START to be override from Kconfig, introduce
PHYSICAL_START_BOOL symbol as powerpc did.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/Kconfig | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bc8421859006..bfedc8b48a81 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2884,12 +2884,22 @@ config ARCH_SUPPORTS_KEXEC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config PHYSICAL_START_BOOL
+	bool "Set physical address where the kernel is loaded"
+	default y if CRASH_DUMP
+	help
+	  This gives the CKSEG0, KSEG0 or XKPHYS address where the kernel
+	  is loaded.
+
+	  Say N here unless you know what you are doing.
+
 config PHYSICAL_START
-	hex "Physical address where the kernel is loaded"
-	default "0xffffffff84000000"
-	depends on CRASH_DUMP
+	hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
+	default "0xffffffff84000000" if CRASH_DUMP
+	default "0xffffffff80100000"
 	help
-	  This gives the CKSEG0 or KSEG0 address where the kernel is loaded.
+	  This gives the CKSEG0, KSEG0 or XKPHYS address where the kernel
+	  is loaded.
 	  If you plan to use kernel for capturing the crash dump change
 	  this value to start of the reserved region (the "X" value as
 	  specified in the "crashkernel=YM@XM" command line boot parameter
-- 
2.34.1

