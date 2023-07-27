Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFC6764356
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjG0BUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjG0BUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:20:23 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896319C;
        Wed, 26 Jul 2023 18:20:22 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id EADD35C013C;
        Wed, 26 Jul 2023 21:20:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 26 Jul 2023 21:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1690420821; x=1690507221; bh=jf
        AHQLCIWpfDdvyeExTMEs7mz5YeHIAIHoJEn9iQiyI=; b=kaPvXonHsvEXHeualV
        aXbyE1LTE2tU3iF6Op7CArDD66B535AhaI/y+0JHrupjoip8EuB7kDjDNewsTG+u
        LpuyfEYsIGP9+AdTzbfhtpXlfiA9aJZbVsyGec9e2gAZiu5JXnxZXoelugxQmfm3
        MBxDimOr+bRBjxTGmGwT4LEKdttfbnlgDF99McN4pLiUqgSa1EmSwnQhEuz1oWqw
        cjxMPXTIcZ+ddhMVZas8iGrZ53M3O2dYzsUPwtE8bVcjIVfhrKjYcbSZPOwmQiAj
        zB9IUIwutJwmd86hEi7GBdz0ZXqkKjsKhKCGHX2ANkk+vCH04po+YY90PlY1d04H
        xu1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690420821; x=1690507221; bh=jfAHQLCIWpfDd
        vyeExTMEs7mz5YeHIAIHoJEn9iQiyI=; b=uhLnwcJTrBx8a2qQNOBfgUtwIv+xT
        5cvWYadrh+YR+M3cR95qzoI5tU27aAKHDXnVC6ANDC6hFdeT1SQrkSC7ewNz8VF3
        pN1ICI3l9OjsqlOUMCOYQ+NfhoIW5uOJkoDIcVjX/DLc31byFSjv8aSHikmnAIxd
        tPSTO+rGezm4T5Tg7VhAC715U9kdDmnlm3ya6mCtp7XBuUrJBP/Hx1P+4+twSan2
        K7zt1cez8MSYhnhntNGlq9Osd5m0UHdn6pmPuzyZHvS3SxkcQUxfnX/Vk4pFhctt
        x7Pr9jWxNTnxPuamV4d+vI8MurCQ37bBafjcsUIzafpP0cuWr7UgWPDyw==
X-ME-Sender: <xms:VcbBZPg6QFSNVHCIgghD_-pzChq5zHMXbT6XXJlLim8WqDqefmUR_Q>
    <xme:VcbBZMAH6kgTBby6lJ4TjDEu-XdbcYy7fC4TPoB73kw4kyBgZ0hwlzkVO4rAOc5Rl
    2fN9qjfY93k4z1Icfk>
X-ME-Received: <xmr:VcbBZPEk_OpoVVPcB4xdRsuPmfAk3rU8zXVVyfEgqHyzAZyMpqRQ2_1Fr5g2i3EAy8gtlvNcLN-YoNGlOYpL4cZPCo8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrieefgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghvihguucft
    vggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrhdrtghomheqnecuggftrfgrthhtvg
    hrnhepheetveetgfdvffehfeffieeugeejhfevieejveeivdeuiefgvdduueffhfefveeh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesuggrvhhiughrvggrvhgvrhdrtghomh
X-ME-Proxy: <xmx:VcbBZMSsm-ctkM59SO09pKqnS8PpoYL18Mo8LDmQAdf75YRRKvM_Bw>
    <xmx:VcbBZMxrdPMFePFZB_yqIGKKhgfIDOaVQksdoXmBKvw0P4LPxz9vqw>
    <xmx:VcbBZC7KYQrP9H2Btu2gNLUUjM47prVbXyya3H6S3ikcMlYzbi-EmQ>
    <xmx:VcbBZDlOkkgoYhH-_mkoPh9YqQB3nN92ZONBwCNokjJAnX4VWO2hgg>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jul 2023 21:20:20 -0400 (EDT)
From:   David Reaver <me@davidreaver.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     David Reaver <me@davidreaver.com>, linux-doc@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dma-buf/sync_file: Fix missing colon in kernel-doc for num_fences
Date:   Wed, 26 Jul 2023 18:19:44 -0700
Message-ID: <20230727011944.327807-1-me@davidreaver.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct sync_fence_info member num_fences was missing a colon in the
kernel-doc, causing this warning when running make htmldocs:

./include/uapi/linux/sync_file.h:77: warning: Function parameter or member 'num_fences' not described in 'sync_file_info'

num_fences was also clearly missing from
https://docs.kernel.org/driver-api/dma-buf.html#c.sync_file_info before
this patch.

Signed-off-by: David Reaver <me@davidreaver.com>
---
 include/uapi/linux/sync_file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
index 7e42a5b7558b..b389a5495181 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -56,7 +56,7 @@ struct sync_fence_info {
  * @name:	name of fence
  * @status:	status of fence. 1: signaled 0:active <0:error
  * @flags:	sync_file_info flags
- * @num_fences	number of fences in the sync_file
+ * @num_fences: number of fences in the sync_file
  * @pad:	padding for 64-bit alignment, should always be zero
  * @sync_fence_info: pointer to array of struct &sync_fence_info with all
  *		 fences in the sync_file
