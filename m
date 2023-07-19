Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F909759AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGSQgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjGSQgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:36:23 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1301D2116
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 09:36:04 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5hJ65pM0zBR5CB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:35:18 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689784516; x=1692376517; bh=hPTO/WVcHjEJY1ukCjZ8Wi3zNwo
        p42ersZdHV50Mlto=; b=PGe9ZnmWhFNFTFH8gr/KuOLDkU/TueoQynAVu9ju+rX
        9sif1irON2gaCTHv0pLc5no3Wy67V1l+y+bsY/Y0ad0BQCV4XL+ppCTOFas87XxL
        ClqtYVnefohDzkP8XAU5Mep7t8RRShlRYoY1d5EYMitW1MiJCeFtLcyoad6L9HOM
        oaeq5pjpC9Q2kPaZG2vwfYPuacEFNUgmNnfi0RtRt0cmliMhEqI8eh9uxSSY8EGG
        xOc9iUwG4Gfua/bgTK5I3AJjZt11IjNfVel4fwrEi32CtVSjVAFvCCi8mLewJFju
        HRoD2VINSdhMPjUvm3pfLDDh1XxhDfoScjRQXT5p51A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NVqaqa5GTm4d for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 00:35:16 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5TvM2QKNzBHXhQ;
        Wed, 19 Jul 2023 16:46:39 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 16:46:39 +0800
From:   hanyu001@208suo.com
To:     dlemoal@kernel.org
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ata: libata-transport: "foo* bar" should be "foo *bar"
In-Reply-To: <tencent_32D2DDE2B4E272A84BD087AD7487D4BC2706@qq.com>
References: <tencent_32D2DDE2B4E272A84BD087AD7487D4BC2706@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <a9e118eaa7da62f41a1d0ce3a5a2ff94@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_INVALID,DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings:

./drivers/ata/libata-transport.c:528: ERROR: "foo* bar" should be "foo 
*bar"

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  drivers/ata/libata-transport.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libata-transport.c 
b/drivers/ata/libata-transport.c
index 4ccafcf..e80bdd7 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -525,13 +525,13 @@ static DEVICE_ATTR(field, S_IRUGO, 
show_ata_dev_##field, NULL)
  ata_dev_simple_attr(spdn_cnt, "%d\n", int);

  struct ata_show_ering_arg {
-    char* buf;
+    char *buf;
      int written;
  };

  static int ata_show_ering(struct ata_ering_entry *ent, void *void_arg)
  {
-    struct ata_show_ering_arg* arg = void_arg;
+    struct ata_show_ering_arg *arg = void_arg;
      u64 seconds;
      u32 rem;
