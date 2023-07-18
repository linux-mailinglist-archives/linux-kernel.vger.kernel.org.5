Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310E375716A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 03:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjGRBiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 21:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjGRBiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 21:38:20 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BD1A2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 18:38:19 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4hRR0lD0zBL0tK
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 09:38:11 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689644290; x=1692236291; bh=YNzkMpFygonZQdD3j0VkRH+C5+f
        s9pYcu0u06jOhQho=; b=WPtR+NB7cWKQU3w/mzX1dgCd+zW5BnOsf4y0jha4Lbi
        pHvyQrQonlrL6B5pap3EoP1Iu4nOvqE2EvD52XPAnviXaJzkZhnHlv0VR1JH5y7w
        qao9VpjaxxCLVd+cNtigFYj+mTFOPnE4eZulQvnTQPEEuS1IVthMPZDyjbYFTYZc
        d12MOXPFHnFaBeOKDhWmsTTsPr4AGVgTrG5n9o1jGJWBf8my1jEBCXjHnlzBxa7X
        4R326jt3WQYGbRAC4buINTEtV7wSoYu/QPpl4YIzxSQ+aEep9GXWI4KCsXiANK2h
        ZLh4nbmuVmyi71gEPO0j/Lmzv3G8LXSiJqXICIFgbhQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wG_U4Eun8tj0 for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 09:38:10 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4hRQ5nhTzBJqBP;
        Tue, 18 Jul 2023 09:38:10 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 09:38:10 +0800
From:   shijie001@208suo.com
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/dtc: Fix errors in yamltree.c
In-Reply-To: <tencent_C2E29E92E4A5FCCF6F6BB14E2ED98DC6C309@qq.com>
References: <tencent_C2E29E92E4A5FCCF6F6BB14E2ED98DC6C309@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <40586276d1294a4d8c81db3cd5dcd4ac@208suo.com>
X-Sender: shijie001@208suo.com
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

The following checkpatch errors are removed:
ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  scripts/dtc/yamltree.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/scripts/dtc/yamltree.c b/scripts/dtc/yamltree.c
index 55908c829c98..dd22858d1bb1 100644
--- a/scripts/dtc/yamltree.c
+++ b/scripts/dtc/yamltree.c
@@ -57,7 +57,7 @@ static void yaml_propval_int(yaml_emitter_t *emitter, 
struct marker *markers,

          switch(width) {
          case 1:
-            sprintf(buf, "0x%"PRIx8, *(uint8_t*)(data + off));
+            sprintf(buf, "0x%"PRIx8, *(uint8_t *)(data + off));
              break;
          case 2:
              sprintf(buf, "0x%"PRIx16, dtb_ld16(data + off));
@@ -80,11 +80,11 @@ static void yaml_propval_int(yaml_emitter_t 
*emitter, struct marker *markers,

          if (is_phandle)
              yaml_scalar_event_initialize(&event, NULL,
-                (yaml_char_t*)"!phandle", (yaml_char_t *)buf,
+                (yaml_char_t *)"!phandle", (yaml_char_t *)buf,
                  strlen(buf), 0, 0, YAML_PLAIN_SCALAR_STYLE);
          else
              yaml_scalar_event_initialize(&event, NULL,
-                (yaml_char_t*)YAML_INT_TAG, (yaml_char_t *)buf,
+                (yaml_char_t *)YAML_INT_TAG, (yaml_char_t *)buf,
                  strlen(buf), 1, 1, YAML_PLAIN_SCALAR_STYLE);
          yaml_emitter_emit_or_die(emitter, &event);
      }
@@ -119,7 +119,7 @@ static void yaml_propval(yaml_emitter_t *emitter, 
struct property *prop)

      /* Emit the property name */
      yaml_scalar_event_initialize(&event, NULL,
-        (yaml_char_t *)YAML_STR_TAG, (yaml_char_t*)prop->name,
+        (yaml_char_t *)YAML_STR_TAG, (yaml_char_t *)prop->name,
          strlen(prop->name), 1, 1, YAML_PLAIN_SCALAR_STYLE);
      yaml_emitter_emit_or_die(emitter, &event);

@@ -127,7 +127,7 @@ static void yaml_propval(yaml_emitter_t *emitter, 
struct property *prop)
      if (len == 0) {
          yaml_scalar_event_initialize(&event, NULL,
              (yaml_char_t *)YAML_BOOL_TAG,
-            (yaml_char_t*)"true",
+            (yaml_char_t *)"true",
              strlen("true"), 1, 0, YAML_PLAIN_SCALAR_STYLE);
          yaml_emitter_emit_or_die(emitter, &event);
          return;
@@ -194,7 +194,7 @@ static void yaml_tree(struct node *tree, 
yaml_emitter_t *emitter)
      /* Loop over all the children, emitting them into the map */
      for_each_child(tree, child) {
          yaml_scalar_event_initialize(&event, NULL,
-            (yaml_char_t *)YAML_STR_TAG, (yaml_char_t*)child->name,
+            (yaml_char_t *)YAML_STR_TAG, (yaml_char_t *)child->name,
              strlen(child->name), 1, 0, YAML_PLAIN_SCALAR_STYLE);
          yaml_emitter_emit_or_die(emitter, &event);
          yaml_tree(child, emitter);
