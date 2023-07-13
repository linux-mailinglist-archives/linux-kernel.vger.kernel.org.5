Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A867528DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjGMQho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjGMQhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:37:17 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58E72D7B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:36:53 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34642952736so3817165ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689266212; x=1691858212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwG/t09lzKH4vpOX7xC63yDDKsVGwGMxzSidRaMZ9O8=;
        b=oQz7jemHrr2XYquX8nZ71rGqBDKUEoAd0BxLMr4KRTp5s26+Z4cu/z5IZF2Ilth+Ng
         9zElvFOomGQr7F/GNf9vklrxL7z0IxTAZRQ3ML462AAB9DZQqnG1jfaDCwaPGo7JJJNK
         PA7RKvUQnNQtPGi94tU5a+EdJM2NKsvuQukeGidJ0PSwJiZ+kLu0k0MsFR9miZDdfz1I
         2WYBLOGALcUntkD1GMvL50jV0pY5oRxSWz4pYxiIdqySIExQONeHpi7B4YqT5MU6zPEA
         rsDA5zecbw6aI43/NFahUyRaXoqpf4j0ZMlc9HFmU12bWAuM5m+Cf60yPLSdB0lwhOZj
         S06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266212; x=1691858212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwG/t09lzKH4vpOX7xC63yDDKsVGwGMxzSidRaMZ9O8=;
        b=PEdc4N0PUbjfqFFcyRvG3vH9Bs25kw0ZqNaiYE6rDlkPTGxXFmP0jFM043kBMq6PPw
         i2Z+4R+WXOJbIRQLQlj4qhi3vXvoadELsl1GrIMkd2OvLKbJ1qtbBBw6PRBH0/jV8OGz
         yzMU46tUQqXcpV2KfN+E/7umTHhObE1wYK9y2laS5HIeBda2nVm66qGs+ygsztaTiluc
         yrvVH6R+pG0bXeOviwNESp0z0hNPwTr5cwuyHCYynE+bt1ZxZo0ClGCNhMc4v28jYlja
         f3jSAj1mUUhCBhlDZKdEkkE1Nh5NkvaVNxn+1pWGfKwiSQiiKWVqpHbif6nXMnoo0z7d
         P7+w==
X-Gm-Message-State: ABy/qLYwOCuxcXNpbJMAcsEohq5cvxS63kijbQJbypZMlOluJ+PL4hB2
        OkUt35KVbf1ZvE9Mt3L+yCI=
X-Google-Smtp-Source: APBJJlHBQpk6ImGCiGbbiOxPVOnhPMDlVtaVfnNI9bAeTCH/L4kPF+ZUd0ZiUR2jyxFOdl4OiKgHIA==
X-Received: by 2002:a05:6e02:c32:b0:346:e96:7cbb with SMTP id q18-20020a056e020c3200b003460e967cbbmr1798401ilg.30.1689266212641;
        Thu, 13 Jul 2023 09:36:52 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id s7-20020a92d907000000b00345950d7e94sm2147571iln.20.2023.07.13.09.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:36:52 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, daniel.vetter@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     jani.nikula@intel.com, ville.syrjala@linux.intel.com,
        seanpaul@chromium.org, robdclark@gmail.com,
        gregkh@linuxfoundation.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 07/21] dyndbg: drop NUM_TYPE_ARRAY
Date:   Thu, 13 Jul 2023 10:36:12 -0600
Message-ID: <20230713163626.31338-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713163626.31338-1-jim.cromie@gmail.com>
References: <20230713163626.31338-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 596d0664c29f..719c5b6ad0f9 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -104,11 +104,9 @@ struct ddebug_class_map {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
-- 
2.41.0

