Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2AD7D22D3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 13:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjJVLQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 07:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjJVLQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 07:16:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D5EB
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 04:16:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DC955C034A;
        Sun, 22 Oct 2023 07:16:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 22 Oct 2023 07:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1697973365; x=1698059765; bh=CWaua0x6Mk
        9aPY5GqHx93n5yiwBj5JDvoi6q+zHqq34=; b=eExA4SgMkS98GusfiDlZCTMFGj
        Xqn1Til/upFxg0rTNtyZQjTF5XdiEd7oHKvO6Sv9240pfjIdu5XEQdalrkseMXQp
        Y5/vK+fKQ9+ZkvD7QvIL6rcJHokzf+gWSys/s3lg7X0XL7IiKdIZtK5nm9ZddWJm
        ib/y314ez3wqs4y5LtWszm2xwIII6E0UWmLRHtnyg4W+OpbtlmQ0DZv2Wuis4O92
        81bptbuW2JIS0bAMgGetrL5syMbkpOSnaeD36LTciO5N19A+vgLSDnrYyO+hcUIT
        DZa1dU9cLODkcmJly6i7X3X0gdT7x3ppVc2IozMttXqq4ZsXx5mlNwm9ZuWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1697973365; x=1698059765; bh=CWaua0x6Mk9aP
        Y5GqHx93n5yiwBj5JDvoi6q+zHqq34=; b=JpU5NuL75vEF+n0JSc2W5u09bMpXm
        fRSlUAigzJ5oevgSw/N3NN6XrHCDjsoy2G3kfBbqDkxEZbgkKq2TcWPWJvKJov55
        KTjmdbb0+m+rIEqP+HBigKwvCoq26RMHI615BwLcFLcrE4jVqrwI2xyAoMLRLIJ9
        mFNyRcUEvQkbJDeUXrNkwKiYJsHLBIpS4OKmq7SNwpdMRzduZ6tZhfvDaHnY8Bg9
        nzYjQWFJVI2OStkXnHqjHe7lMqEHfa0RC9wNSlRq+CS5v6OoM+Gj6Kr8ZZHSpVNc
        llqLYo05yXvakEojOS/HnY67TSfdaORVCED2qZ0DReKFZ82YudW9Yk84w==
X-ME-Sender: <xms:dAQ1ZdfmA9xT8jgOTDE9uE58P3BAIsf3C0x0w4bkztggDHusE4W45g>
    <xme:dAQ1ZbOPOLfUxjio0gPRidZmmV4IxvkCJAvQDy31d7eaIjKysFUjZeUsBuczjSGg3
    EcnaL49FsnUgIBUSg>
X-ME-Received: <xmr:dAQ1ZWhZlH7Qnx81OQPMxd5iDVwXGnfW_qIUZP70YMUgkxaPq2cq142UvsDumZnZZ4XRcb8vqpo8xeCXeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeefgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehkefgtd
    evtedtkeduudeguefgudejheeugfelgeettdfhffduhfehudfhudeuhfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrd
    hish
X-ME-Proxy: <xmx:dAQ1ZW_tQA5GjjM0p_vmlYQcjsVWENWu51zMESXDCYYAChSRzhvbkQ>
    <xmx:dAQ1ZZuWjsflApw1W_5M9Dc0Bf6IiCq-IcSL-fDc15lxR5J7pq7Izw>
    <xmx:dAQ1ZVH-z9QotfCHjjaMkPCHYfZihjAKRjuXTmCfNkaFmxTmaXtwQA>
    <xmx:dQQ1ZXUTN61WF2WsxgsLBe30ZZvVku7EVgi0O8ApPlu9tlYlLrBXHw>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Oct 2023 07:16:04 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
        id 35CC61AB1; Sun, 22 Oct 2023 11:16:02 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>, Scott Wood <oss@buserror.net>
Subject: [PATCH] soc: fsl: qbman: fix null pointer dereference
Date:   Sun, 22 Oct 2023 11:15:37 +0000
Message-ID: <20231022111537.878237-1-hi@alyssa.is>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When called from bman_test_api(), bm_bpalloc may not have been
initialized by fsl_bman_probe(), in which case gen_pool_alloc() would
attempt to dereference a NULL pointer.

Checking that bm_bpalloc is non-NULL allows boot to continue is this
case.

Fixes: 97e0d385b139 ("soc/bman: Add self-test for BMan driver")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 drivers/soc/fsl/qbman/bman.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
index 6cc1847e534a..713a0508678e 100644
--- a/drivers/soc/fsl/qbman/bman.c
+++ b/drivers/soc/fsl/qbman/bman.c
@@ -669,6 +669,9 @@ static int bm_alloc_bpid_range(u32 *result, u32 count)
 {
 	unsigned long addr;
 
+	if (!bm_bpalloc)
+		return -ENXIO;
+
 	addr = gen_pool_alloc(bm_bpalloc, count);
 	if (!addr)
 		return -ENOMEM;

base-commit: 58720809f52779dc0f08e53e54b014209d13eebb
-- 
2.42.0

