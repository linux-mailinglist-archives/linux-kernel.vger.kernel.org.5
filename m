Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB8B7DA33F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346687AbjJ0WMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346731AbjJ0WLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:11:53 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72986170F;
        Fri, 27 Oct 2023 15:11:35 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D888532008FE;
        Fri, 27 Oct 2023 18:11:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 18:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698444693; x=
        1698531093; bh=Tr/TAb04SGgGEOsJanw3F3kr/0Ce06JzReERHar06zI=; b=D
        I3igvTc0X3IIXEx9TqmJrqMHtqRy0ldREmqW7oPdW2oX088sqJOPLdhQToP/Z/SX
        66ddy/mLaTGkDySXh94EPIe7TdiGvrEI61CPHk09nM32WbKD/ZDEmP6S1sjPe+8p
        Cq23UghDFcyIe5HtsuUzjcCZE0AsHmwnF76SWHi2NAxMLH/2T9zhC1w4hLa7G4Kr
        1+JofBWB2KkVrqtYc551rufoTof3WttjChngXJpnXaO8eEwm+RaX7WGkKCb4Gpsl
        47TJ9Q1K6dPM1CRxNZIlzgu9BqqSffSEWYG5BJ//lFpV6a2SWJyBCk8NPoYPiuqz
        btoBi4NxD2HHIEihrPqAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698444693; x=
        1698531093; bh=Tr/TAb04SGgGEOsJanw3F3kr/0Ce06JzReERHar06zI=; b=L
        50aUpiouRR02XAY0YNvD36dCLMlJLUcVmnlBQavFz4vu3mtBVhmAnxIKcX3vyJip
        Pxc7MwO2vk02SnYqjUS3Z/gojfcaZdZg7DNDyZJtubI9JSTNVtsHuf0m96ATuRsO
        fDxGkIy3TpRk3DidfX0K/PJVnF/+hjnfxblGhQHWEh/51Z5AzFQgIpZ6SXi4IJ1s
        qnxB+8ZNhpxIHGXtOeT2E6vSL9+WdtxPwZwjs8IjOmmPI+qhGN61PsXllnfKI5eH
        lzOCv65BoIhtRG1s+y589Nt7Ns3YkwqrsPfL2lFYpiQT2BH1WK5YjHwaB7f/zv40
        w+uSVxL5zIe4ndve6xTvg==
X-ME-Sender: <xms:lTU8ZXV5EQpRtEFQ672NCza0Frx5OwzN_s1ks-AveFedtbxUJkMvNA>
    <xme:lTU8ZfnwYbJpqMS3-4_YnLNAZrgRGxJ2KxijteNt_W6FKDN9aMw_G9_UXglFuDb1o
    WQbdRrT5aIcQjjRSAE>
X-ME-Received: <xmr:lTU8ZTaoH_3ydylnjifH1-q6I5SsCz7RTrgRzVbL461w3hY2842gZTuFA8TVGl-h9Nu2ZnVdsoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvuedvvd
    egkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:lTU8ZSWPRmJ2nl9btRCujZ4A7-0Rgaj2jeulPdRAffkWgo1oHs6rGA>
    <xmx:lTU8ZRn1BYWsxVSizrgAray4ktOZUHrTVu6xaS0fEn9bZuz8wyGB9Q>
    <xmx:lTU8ZfdtsB9wB-roRnCIaFFvuYUn63QNGuR9frkbY3FgnYtVnjzsrg>
    <xmx:lTU8ZaCBjZ-nUFP8mcA2Svxo6DtvoYqSf0ktCOIyrFdCsinAEapEIw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 18:11:32 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 09/10] MIPS: traps: Enhance memblock ebase allocation process
Date:   Fri, 27 Oct 2023 23:11:05 +0100
Message-Id: <20231027221106.405666-10-jiaxun.yang@flygoat.com>
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

We try to allocate from KSEG0 accessible space first, and
then if we really can't allocate any memory from KSEG0 and
we are sure that we support ebase in higher segment, give
it another go without restriction.

This can maximize the possibility of having ebase in KSEG0.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/traps.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index b6e94654f621..68f1dd54cde1 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2399,7 +2399,12 @@ void __init trap_init(void)
 		memblock_reserve(ebase_pa, vec_size);
 	} else {
 		vec_size = max(vec_size, PAGE_SIZE);
-		ebase_pa = memblock_phys_alloc(vec_size, 1 << fls(vec_size));
+		ebase_pa = memblock_phys_alloc_range(vec_size, 1 << fls(vec_size),
+						     0x0, KSEGX_SIZE - 1);
+
+		if (!ebase_pa && (IS_ENABLED(CONFIG_EVA) || cpu_has_ebase_wg))
+			ebase_pa = memblock_phys_alloc(vec_size, 1 << fls(vec_size));
+
 		if (!ebase_pa)
 			panic("%s: Failed to allocate %lu bytes align=0x%x\n",
 			      __func__, vec_size, 1 << fls(vec_size));
-- 
2.34.1

