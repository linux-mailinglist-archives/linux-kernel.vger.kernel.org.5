Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B147992EB
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbjIHXvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjIHXvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:51:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923B718E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 16:51:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bdbf10333bso21529915ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 16:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694217076; x=1694821876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aFPAFrw06YkFvcW1+oSEgoGL8va6uPxDJtsTprxSrLA=;
        b=hKu8FzfM3G8rZTa3x9Ob4njMRor9LcALxzQVM+1CfVjIyxgN3SXNwfCSoeX308OQ3S
         crSjjXXu+3cb232LSWNgZld+5pF1gRgwxBuDd5L6Al5IWFrWDWolC/7hlNwayJW9f9tX
         yuQZ5yOWuf/0mp48AOq8drnMfuhTRhaDgxyow/5N7iULyXKWKPybZeoKgGlNDAfzKxKv
         M1q7ay63DeYP9W1F4nTqdxmwvb1XtI9vA0fgLSP0472TPvZfP/OBaCFefRLMpyxB8KF3
         vrgUv1hZ6AkeW50l9NAryodrY5kLRmRgRsW5GNv+CLzQjGQqRffDxhjrPiyQkQwgpY3s
         ki7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694217076; x=1694821876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aFPAFrw06YkFvcW1+oSEgoGL8va6uPxDJtsTprxSrLA=;
        b=A4LWemaP/+SZlSpnE+s+na/HKXiPpSlE22B6R0rUQZNtG9hFyWY+FkCJIqXgrMBaD4
         i1aydljjCqBdBEja99/iCN/RqI4+msJWQ4XpKTCNpHYSoLyOflBaImlHvaeXEO+l0b4U
         qdzUkoF0HV8tyRgiGF/j+pfb4w8s3KlD5vyGiAm84J8AqupvQuxFJUcpAutQTRDBOte6
         zp/udwfLH5CQWnM6NPzKhLQb4AecPvBPPXCBPSYal2hnu3cYGTWdko3xwvyUWXLLCOfO
         KnTao0xG1GzCK+iwVFDZkenjVClqcK39uDf2JcZ83y6GQkFjZnT6JHSP3dH6jc7XwUlw
         uJIg==
X-Gm-Message-State: AOJu0YyMP/89l6LZKN3wUQK+eir1shsqbrir3D6JlZFWzfXHYQn5AYVA
        6N2kc3bXn4w64o97lfBiX38=
X-Google-Smtp-Source: AGHT+IFRUIyM1m4pncJ0Nu19lRVBkqXyJ5X3NEe0F5euYr6EwYPMg5RyfxfpoUOAgB6jVFaykr/A1Q==
X-Received: by 2002:a17:902:d505:b0:1bb:59da:77f8 with SMTP id b5-20020a170902d50500b001bb59da77f8mr4512905plg.48.1694217075894;
        Fri, 08 Sep 2023 16:51:15 -0700 (PDT)
Received: from localhost (fwdproxy-prn-113.fbsv.net. [2a03:2880:ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id jf3-20020a170903268300b001bdc208ab82sm2117872plb.97.2023.09.08.16.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 16:51:15 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] zswap: change zswap's default allocator to zsmalloc
Date:   Fri,  8 Sep 2023 16:51:15 -0700
Message-Id: <20230908235115.2943486-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Out of zswap's 3 allocators, zsmalloc is the clear superior in terms of
memory utilization, both in theory and as observed in practice, with its
high storage density and low internal fragmentation. zsmalloc is also
more actively developed and maintained, since it is the allocator of
choice for zswap for many users, as well as the only allocator for zram.

A historical objection to the selection of zsmalloc as the default
allocator for zswap is its lack of writeback capability. However, this
has changed, with the zsmalloc writeback patchset, and the subsequent
zswap LRU refactor. With this, there is not a lot of good reasons to
keep zbud, an otherwise inferior allocator, as the default instead of
zswap.

This patch changes the default allocator to zsmalloc. The only exception
is on settings without MMU, in which case zbud will remain as the
default.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 721dc88423c7..e0217deca084 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -130,6 +130,7 @@ config ZSWAP_COMPRESSOR_DEFAULT
 choice
 	prompt "Default allocator"
 	depends on ZSWAP
+	default ZSWAP_ZPOOL_DEFAULT_ZSMALLOC if MMU
 	default ZSWAP_ZPOOL_DEFAULT_ZBUD
 	help
 	  Selects the default allocator for the compressed cache for
-- 
2.34.1

