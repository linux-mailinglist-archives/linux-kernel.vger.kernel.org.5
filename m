Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0542D757695
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbjGRIci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjGRIce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:32:34 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C6310F1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:32:16 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4sd92975zBR9sk
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:32:13 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689669133; x=1692261134; bh=EqLROmlyi0yh+aRK+N3VVUL43pP
        ivKLh2Na2E4mvWUc=; b=o2Dm7gdiJsFRR2dNtzBEiGo+lTrrPCK3QbVQuYvZC/w
        Mo5eM7R1OWJClmqd9qpCHg4VDZIvhIuYHPvatKmrYd31UrL6MOEoZXJ90n+0k36m
        3WWZfSWvK7jUateSUxs2bFdL0sJhPXurQitvLhVfUkvNrIw17eaXxScNYP7VVK0E
        U6cH9YlMtinH9ilHIEXsqvQCidcuXY7wrOxNiTrG4Wu7DUEvD6jDoJXE3ytKr1Jp
        HwiB7fE79Hy5X1/OiWcMx6+lejIeDD4m20oXZQ/H7zP7/MY5V8mtrC8ED/3mONTZ
        sLACyHReW1uoPy1NIW1BB+w84nvMQ26cs2e/MOMICJA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y74ZsN6OMQIQ for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 16:32:13 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4sd90W54zBR7bp;
        Tue, 18 Jul 2023 16:32:13 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 16:32:13 +0800
From:   hanyu001@208suo.com
To:     geoff@infradead.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: platforms: ps3: insert space before the open
 parenthesis '('
In-Reply-To: <tencent_0D690D6B9BCEE104E6AA932AE7C69B89B809@qq.com>
References: <tencent_0D690D6B9BCEE104E6AA932AE7C69B89B809@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <61a4541834be2d507744af7d969bb475@208suo.com>
X-Sender: hanyu001@208suo.com
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

Fixes checkpatch error:

powerpc/platforms/ps3/os-area.c:782:ERROR: space required before the 
open parenthesis '('

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/ps3/os-area.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/os-area.c 
b/arch/powerpc/platforms/ps3/os-area.c
index b384cd2d6b99..237a76d1c92f 100644
--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -779,7 +779,7 @@ void __init ps3_os_area_init(void)
          os_area_get_property(node, &property_av_multi_out);
      }

-    if(!saved_params.rtc_diff)
+    if (!saved_params.rtc_diff)
          saved_params.rtc_diff = SECONDS_FROM_1970_TO_2000;

      if (node) {
