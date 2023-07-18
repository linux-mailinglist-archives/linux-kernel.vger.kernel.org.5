Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1654757678
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGRIXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGRIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:23:49 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AD710E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:23:46 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4sRN1XM9zBQslb
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:23:44 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689668624; x=1692260625; bh=knM9vNIC6wtRw5GXn30pAFyZgpa
        AyMvsMM3ZIxyfDlo=; b=vIcEbUcOoQ22wXcMwYeUzctJaoVHCfT9cR4gNumNP0B
        +eG4hawQsALpfVSJYublkZgq6ElLMYaVrpd7sIC+MDgdIAFMcd8Q1Nlp+4MglSRL
        IC7AK8Hmf+bXhb29SVm+tHuaQxk+mh/g8FzYr5zT3c3ygF9vO57JeB7gYWkXaLC7
        H2KL2zRuD5V2zIH277d7ldZZq+erOfhzv3RNR7pbcKBJrHAzw/qIYR2+SUCeU1JG
        0bGOiCdbgR/lnro/p1Esjt9UNjG3y+2TtNmHRgQ5Jk3we31J2jC9fcjzLg4lFOt1
        u+Qav2wAdHJZDJP2JRgSbo+cDIjs1Bpu14M9EYXomRw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id guqyGcJqdrvh for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 16:23:44 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4sRM6wgBzBJBf8;
        Tue, 18 Jul 2023 16:23:43 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 16:23:43 +0800
From:   hanyu001@208suo.com
To:     geoff@infradead.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?=5BPATCH=5D_powerpc=3A_platforms=3A=C2=A0insert_space_?=
 =?UTF-8?Q?before_the_open_parenthesis_=27=28=27?=
In-Reply-To: <tencent_3F18E701022BD5039554E35C440CB48FB508@qq.com>
References: <tencent_3F18E701022BD5039554E35C440CB48FB508@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <6562b8964af1e6de9d8c70190d529a64@208suo.com>
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

arch/powerpc/platforms/ps3/setup.c:107:ERROR:space required before the 
open parenthesis '('

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/ps3/setup.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/setup.c 
b/arch/powerpc/platforms/ps3/setup.c
index 5144f11359f7..3a22a26912db 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -104,7 +104,7 @@ static void ps3_panic(char *str)
      printk("\n");
      panic_flush_kmsg_end();

-    while(1)
+    while (1)
          lv1_pause(1);
  }
