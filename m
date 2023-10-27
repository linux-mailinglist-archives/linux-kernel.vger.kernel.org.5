Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A757DA336
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346647AbjJ0WLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346620AbjJ0WLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:11:20 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C9F1B8;
        Fri, 27 Oct 2023 15:11:17 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8C4283200920;
        Fri, 27 Oct 2023 18:11:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 27 Oct 2023 18:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698444676; x=
        1698531076; bh=1fai2oRGpMFX3YIWYq1Mi7aFvcDk/EldREaoCLVKnm8=; b=u
        G36gus0VIZHOXP3fwTFfvT3ycUKwtH5ZLDdCGSBGl6DxvWwVQm8/EZOFRphNk1xS
        c9eEtEXSBQCjvYJKn2LoWwFmkSzvMCidHvfTV24VvkWOtdKumP+SnMsJZgEIIsB4
        LLQQK+9M89X9eCwT5eGZLFdKkzvbRkierTdZWB7Ho/k+8B559kXzdxVRA96+OnVI
        rdyg20bGCht5R5kUKzmXcpi8v0ThkgEtOZCqN9N5Lt+LYxNhpUPTmqHJ7pdkPtZQ
        OueaGVygxQjqw8gszR5cf5p8wvbPgkLVJMhJOegSLhxY9f0p2eDSIG8yFgCrypTE
        JiX09lEgdH60vKnysHBMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698444676; x=
        1698531076; bh=1fai2oRGpMFX3YIWYq1Mi7aFvcDk/EldREaoCLVKnm8=; b=D
        HgNU1kpNAtcmxwitIsmeJFO57dKln7LUPtmUHQdsJoZ1c/GN02odMs4Vqdd9kIZm
        U6ltcSugIIlpLA3nKbgIIJ46Ea5OumSb1db14KVEViHvQUEh225MWSvqfrj53zG1
        pymSbzHD/MosKxvlLlbuBFmpbArwdXBfYz0BZ1YHSmiXOB06xLHMstmvpuwOf/cU
        M9i5wDn5NpHM47FHDz5ncGlOJpO0kQL3zTAZBjc/YiFvR1Xmh7kFFrjI819n7FIA
        CDk4J+d+a59MbY6SMqY/mvYdJ/7bKU1y1/Bgj9dNF1zI7Q5B4WwgIbo2PjPtv0LL
        4ojA0/tShbd265TRdtqfw==
X-ME-Sender: <xms:gzU8ZVWcxf9P31PQD4jvcLAocd8CsvBJiI0rPTtvVl16a92g-uCqVg>
    <xme:gzU8ZVkK6o2ygnPDafTD9exwpzP-joENt_EPp9_FMP0b1U2mSJtTkqBdhHrIlrW4G
    zlvVOkhOABs8uX86Qw>
X-ME-Received: <xmr:gzU8ZRa2XmH0ea_WvQX1k9Un5D8wfAey9xxj1urthaUx8FLUgRw272ClKTSd4QDA9avvEQZoPDs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvuedvvd
    egkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:gzU8ZYW3FsKR-txlmqOEbrJgbGYlrhURONl5i9el3-IosGZuy238tA>
    <xmx:gzU8Zfllbc1VNjGDRFkrDE8su7bJ8Jv5ifC9ODudtkCS_SXWkkWh0w>
    <xmx:gzU8ZVe9pDFEIgrUpRDvNn8HTXMAnF4ZDXQYH1BkaRPKLBs1JzWLjg>
    <xmx:hDU8ZYAp5RN9PRTiO26iVykUq2_6iJ2PNgg7juf5WqUl_kP7rBykvQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 18:11:14 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 02/10] MIPS: spaces: Define a couple of handy macros
Date:   Fri, 27 Oct 2023 23:10:58 +0100
Message-Id: <20231027221106.405666-3-jiaxun.yang@flygoat.com>
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

KSEGX_SIZE is defined to size of each KSEG segment.

TO_CAC and TO_UNCAC are brought to 32bit builds as well,
TO_PHYS remains to be 64bit only as we want people to
use __pa to avoid mixup compat address space.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/addrspace.h           | 5 +++++
 arch/mips/include/asm/mach-generic/spaces.h | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/addrspace.h b/arch/mips/include/asm/addrspace.h
index 59a48c60a065..03a5e2c8b5dc 100644
--- a/arch/mips/include/asm/addrspace.h
+++ b/arch/mips/include/asm/addrspace.h
@@ -47,6 +47,11 @@
  */
 #define KSEGX(a)		((_ACAST32_(a)) & _ACAST32_(0xe0000000))
 
+/*
+ * Gives the size of each kernel segment
+ */
+#define KSEGX_SIZE		0x20000000
+
 /*
  * Returns the physical address of a CKSEGx / XKPHYS address
  */
diff --git a/arch/mips/include/asm/mach-generic/spaces.h b/arch/mips/include/asm/mach-generic/spaces.h
index b247575c5e69..05db19521e81 100644
--- a/arch/mips/include/asm/mach-generic/spaces.h
+++ b/arch/mips/include/asm/mach-generic/spaces.h
@@ -79,11 +79,12 @@
 #endif
 
 #define TO_PHYS(x)		(	      ((x) & TO_PHYS_MASK))
-#define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
-#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
 
 #endif /* CONFIG_64BIT */
 
+#define TO_CAC(x)		(CAC_BASE   | ((x) & TO_PHYS_MASK))
+#define TO_UNCAC(x)		(UNCAC_BASE | ((x) & TO_PHYS_MASK))
+
 /*
  * This handles the memory map.
  */
-- 
2.34.1

