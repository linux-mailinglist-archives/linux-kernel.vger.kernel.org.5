Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9D7D3FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjJWTOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjJWTOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:14:09 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1D3101;
        Mon, 23 Oct 2023 12:14:07 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 31DA45C0003;
        Mon, 23 Oct 2023 15:14:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 23 Oct 2023 15:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698088447; x=
        1698174847; bh=QkagzItTcmygJhd+IgCnn6qdrUYk56vVzdHfbFmNb0k=; b=T
        /E/5+zQuNigcfKSF7CMZ0lO9sjt4sK4g600xMPKbt2UIj9cqjGjyKzAvWavJszQ4
        cNlF4IOTus0xeZg38meeoj4lN9GH9tsGQ02xwDO+kYXN8R8aFZugbL3iZz31ybDD
        CLrvfKOKTdcfE5wUgcVyoaQArKmzWAw7xylbskL5pyDMfkdX7hkOrF8CP/lwHOM4
        yIBeFFb40qHnaqXXN89QiewLVq+ViQ/0N+6W2HKLWxmL20mWChVY2qtpNFox5pLc
        i4QwvaWiu1WanHvFVjA8c3I0v1k6CDGLIASuzq0KjJ0+Z9Z8kB49mujAvjwRR4Rl
        PZeLcixMv78DlUnS5W1Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698088447; x=
        1698174847; bh=QkagzItTcmygJhd+IgCnn6qdrUYk56vVzdHfbFmNb0k=; b=a
        3K19ixhUgYwupkRenvXWOt4P0RKvWT97F34PLsdEaXmBCrJmUsC1cbjF1YaDBjQb
        STsQMZLCKhwx4dhIJDy4vHCzKcrUl7WlrkVW/7mruUMj6IIm14Byw5hxH+Ni/Rjq
        SFZ3e+gWUVLlPxuEKNgKrZE4cbf/ZHuU3Ad1xDzjeyBAm33wTMPC1KpLSyVEqvcS
        Yp4oR/Orq+zKnTPwoA6nzmN9jj8Wbx2iM5PWLiULuIOGnrGs22Cq4kKJYs+XG2T2
        luvvFIEh06VDLIo+H5gHKeckPSWIUkPwE/uhgZlNnP0qH12kINqG6/BvUvWs5/vn
        s6Fra68jeHfTkW+i196TQ==
X-ME-Sender: <xms:_sU2ZbtPIus0vyOeJpXk4IW8WJo6kNl-cO4U7ATE00giJCO9FPrNzw>
    <xme:_sU2ZccQmONSuPxF5Xv3hojWM3CzlfPOMJRA9zCFuBGH6bXvjNpt8y4Epr3uVc4D6
    WZ_uG21aPhXRLi0yic>
X-ME-Received: <xmr:_sU2ZexGpocjYVKGARwI-IbOkikLcpWJOQoBrAKWKYLkqGQZpiBUNB9-oJ0H3X2X1-WejEioV0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:_8U2ZaOm93NRqU6yVfefXeBkKgxTjiGhn4Q8MP_XN7qFfJl8kU-y-w>
    <xmx:_8U2Zb8psBSCYcvSj-leVnIGhPvzhK6xf_VpxjeVAvz77aClI0jWrA>
    <xmx:_8U2ZaX8fbMT_w3OIMccJU7x8Y5V9g_O-b54Wi2Z5i5AiidG-hP9Sg>
    <xmx:_8U2ZXbCFQyO0xOTm8zkB-5BeVv_Wgwx1lZugws2eu_YxTy11CyI6w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 15:14:05 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/5] MIPS: Export higher/highest relocation functions in uasm
Date:   Mon, 23 Oct 2023 20:13:56 +0100
Message-Id: <20231023191400.170052-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
References: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

