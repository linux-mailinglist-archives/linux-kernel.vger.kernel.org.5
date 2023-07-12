Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2D0751256
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjGLVMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjGLVMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:12:01 -0400
Received: from out-22.mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B877E2123
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FgPTsx8pxcoWZIr644eHDkqshUBzFFLPFWwXDp/ZtBk=;
        b=MaadSe8HAdi5l+GroqZDTiy6Zc9HYZcts9hC2RyMeG8K2XIJm69E1XG5u6QYQa+hjTLtHP
        e24oHmWBgTXlsCfT77PoeFe276ZwnbrDfympEOTD60FMh5VFXOsxQtMVjae4CxTiW9/zv2
        Tw9k+sD22DrofRML8nSy90QSwb5I7v4=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Christopher James Halse Rogers <raof@ubuntu.com>
Subject: [PATCH 10/20] lib: Export errname
Date:   Wed, 12 Jul 2023 17:11:05 -0400
Message-Id: <20230712211115.2174650-11-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

errname() returns the name of an errcode; this functionality is
otherwise only available for error pointers via %pE - bcachefs uses this
for better error messages.

Signed-off-by: Christopher James Halse Rogers <raof@ubuntu.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 lib/errname.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/errname.c b/lib/errname.c
index 67739b174a..dd1b998552 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -228,3 +228,4 @@ const char *errname(int err)
 
 	return err > 0 ? name + 1 : name;
 }
+EXPORT_SYMBOL(errname);
-- 
2.40.1

