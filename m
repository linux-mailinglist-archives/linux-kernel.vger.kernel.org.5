Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6030F7530FF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbjGNFJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjGNFJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:09:17 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAE830E9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:09:13 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2KJk530LzBR9sc
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:09:10 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689311350; x=1691903351; bh=H+rgnyj87DwTjtQTdUQFNy+33xo
        qckGc9KsUhGfsJZI=; b=sio0iz7kgEYOVQcKsBSq7QvBD+7cUqDw9H0jhxzwE3a
        aKvIDr7XPvV9IJ8nzveXI91yOYi3oyVQSOEXj6I7y9fR+QJ2p/blYzuFOP9wmSkz
        og9/TlQZ5ta16EEjcKr7xs8Z2J7kfYEX5pRDFG73H26wWvS4t4k11rqo2+Vp6ANt
        TYuetqWru77sj+JoBZ9fWfdDJmPKvGkqOY6JW0ANpxlfRopsbMqjvYyQuGyeWbH/
        Xqw+WXrHHOpFZd2WFnqydJZKnBhnaRBQbmmuVPAwkbKHHH8bFIB8cTg1v4jpNg+S
        YD4RLIAMtsqokjhuoj24qTfXLgXBNrDDelUxIG/Yy5A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JT84UfRIjY_a for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 13:09:10 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2KJk2xdNzBHXhS;
        Fri, 14 Jul 2023 13:09:10 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 13:09:10 +0800
From:   chenqingyun001@208suo.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64:#include <linux/cacheflush.h> instead of
 <asm/cacheflush.h>
In-Reply-To: <tencent_6FFBC70CAC8F277E10997551331C8029D006@qq.com>
References: <tencent_6FFBC70CAC8F277E10997551331C8029D006@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <31be9696f7a019a700176a2549992bfd@208suo.com>
X-Sender: chenqingyun001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/cacheflush.h> is a generic header file,
while <asm/cacheflush.h> is an x86
architecture-specific header file

Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
---
  arch/arm64/lib/uaccess_flushcache.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/lib/uaccess_flushcache.c 
b/arch/arm64/lib/uaccess_flushcache.c
index 7510d1a23124..cf8052f6e091 100644
--- a/arch/arm64/lib/uaccess_flushcache.c
+++ b/arch/arm64/lib/uaccess_flushcache.c
@@ -5,7 +5,7 @@

  #include <linux/uaccess.h>
  #include <asm/barrier.h>
-#include <asm/cacheflush.h>
+#include <linux/cacheflush.h>

  void memcpy_flushcache(void *dst, const void *src, size_t cnt)
  {
