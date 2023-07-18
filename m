Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B29757339
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGRFdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGRFdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:33:47 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061ADE43
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 22:33:44 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4ng64vGRzBQslT
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:33:38 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689658418; x=1692250419; bh=4NxoUZnBIAc5dK/IDIJeyTieNoN
        ojCUHKVE8ajj90Xc=; b=LBcikYA+AqgTBO442BIpLgFkCnKUAELplQsg9psX6O2
        gwGWEdcIr7e3rn40nolJneTSqu2qv+/BCfjbVl+Q00HogbjsuN67aPm6Xsk9FCRZ
        wPs88NxlH723QywVsLOywl6k4JGHZ+sSJHlXDk1h+GhZPJG2hjxC4DR2d0ijV1n7
        rpKwcm+/IPcLV6w6XjnM46Z55to2LSAHM+QNi2OeYvJlGafeUVep4VSr1j3d/X9g
        NBilnAM3fChUoWm6fmPa8QS/80lZvLDa/7akL58ROwunipyUlaYNckB3QrPyp7gG
        u781XjSLVXmQR8yXjWC/O4alIGKGsCf7KKIBR6GInOw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WHlbQuF3wHx5 for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 13:33:38 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4ng63w2PzBQslL
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:33:38 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 13:33:38 +0800
From:   shijie001@208suo.com
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] auxdisplay: Fix errors in cfag12864b-example.c
In-Reply-To: <tencent_657C88BFFDAD2116DFE593516118DBD3BF06@qq.com>
References: <tencent_657C88BFFDAD2116DFE593516118DBD3BF06@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <e642ae32a3c9fba43a72e5d6509776b4@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following checkpatch errors are removed:
ERROR: "foo * bar" should be "foo *bar"
ERROR: space prohibited before that '++' (ctx:WxB)
ERROR: trailing statements should be on next line

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  samples/auxdisplay/cfag12864b-example.c | 7 ++++---
  1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/samples/auxdisplay/cfag12864b-example.c 
b/samples/auxdisplay/cfag12864b-example.c
index 2e3bb7375c99..247789c09eb1 100644
--- a/samples/auxdisplay/cfag12864b-example.c
+++ b/samples/auxdisplay/cfag12864b-example.c
@@ -38,7 +38,7 @@
  #endif

  int cfag12864b_fd;
-unsigned char * cfag12864b_mem;
+unsigned char *cfag12864b_mem;
  unsigned char cfag12864b_buffer[CFAG12864B_SIZE];

  /*
@@ -148,7 +148,7 @@ static void cfag12864b_clear(void)
   * Pixel off: src[i] = 0
   * Pixel on:  src[i] > 0
   */
-static void cfag12864b_format(unsigned char * matrix)
+static void cfag12864b_format(unsigned char *matrix)
  {
      unsigned char i, j, n;

@@ -231,7 +231,7 @@ static void example(unsigned char n)
      case 6:
          printf("Do negative not-ing all bits");
          for (i = 0; i < CFAG12864B_WIDTH; i++)
-            for (j = 0; j < CFAG12864B_HEIGHT; j ++)
+            for (j = 0; j < CFAG12864B_HEIGHT; j++)
                  cfag12864b_not(i, j);
          break;
      }
@@ -258,6 +258,7 @@ int main(int argc, char *argv[])
      for (n = 1; n <= EXAMPLES; n++) {
          example(n);
          cfag12864b_blit();
+
          while (getchar() != '\n');
      }
