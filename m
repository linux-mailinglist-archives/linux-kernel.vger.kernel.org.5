Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E53F790545
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 07:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351564AbjIBFZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 01:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351559AbjIBFZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 01:25:30 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DBAE5B;
        Fri,  1 Sep 2023 22:25:27 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-571194584e2so1603142eaf.3;
        Fri, 01 Sep 2023 22:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693632327; x=1694237127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hv7UGDGM1H2H8Jdr92+cKOsjwcVr9oID7QXkjAZro20=;
        b=sL6P2Rn6VGTd7u6hAwdODLWt/9ArZEZOHWoCNDQEtVXIT+H6bYj6mLBWRhP1QHB8Us
         Jd+9KElNXDXWbFCjME8WJcb+aOiFCwzyXARdagxVkT+vS0wLvhAuHQlcVE1lS1t19Ja/
         i/CBz5L7wbcf5hpEBFP2+3CHEq5O3pJsZepkrQWSLLm6YisIY5VvCUqXJPwzYHH03b5e
         6/GwaMs4seoddIuCIP5zvuo8QJDDOHvJFe3prAOuPGOnML9nOQtqGQLiGdic/Fo+RSek
         kIUHTSLoeFWY7chZmrccRqwnDwPUInGg1FZy+lQTIuDcW7aDRVCw+KIkl17RytstiKo2
         DZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693632327; x=1694237127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hv7UGDGM1H2H8Jdr92+cKOsjwcVr9oID7QXkjAZro20=;
        b=eTjXJahEJQifh1LgyJ/P7FZto5E4RCWxSIVWNWE9EI2aYC1dTQNEF2UR4P713ISnus
         VtUk+VwdoHWgjt534yK2rLpP5ij7OaD/+qqeSnn4Fq2I1jbz647JbtgR6ymNrbu5GX3m
         ocGmbeM/JekSLGGTj3tYMUsi5039kO8rqQpRQ63rqQuqevNaEhrSfZiMrYcVrLgY0cV6
         izS+LRhrF8ubUi4/raW1Nz6DLiyF0xzjwOaNm3vLeGfMDpSamw1pQCDlIS3r1B0rpd/Q
         k4XnMwN+WOYm/Fe3HmKZ9OuOeri4sG8SIxwLVdTaguZypvBlaHye4+dPoobktXmS2c9a
         QKOg==
X-Gm-Message-State: AOJu0Yzw1s+A0JMK/wcsW1kpMJ7f8BxW+nu/KH/szu1pUhOP6R7mW96a
        xAW1bbcWnNHgHfOXKIFvFMo=
X-Google-Smtp-Source: AGHT+IGDCZS+0D7sXRFdt4w+0K6pGXdC4eexhgJiF/XoDz+UkKvxf4f8yRKylOKZyYWMwjDampnD0g==
X-Received: by 2002:a05:6358:591a:b0:13a:935:9f6d with SMTP id g26-20020a056358591a00b0013a09359f6dmr5467168rwf.25.1693632326932;
        Fri, 01 Sep 2023 22:25:26 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-78-250.dynamic-ip.hinet.net. [36.228.78.250])
        by smtp.gmail.com with ESMTPSA id b15-20020a63714f000000b0056c24c2e23dsm3708320pgn.25.2023.09.01.22.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 22:25:26 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>,
        Hu Haowen <src.res.211@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: [PATCH v3 3/3] docs: sparse: add sparse.rst to toctree
Date:   Sat,  2 Sep 2023 13:25:12 +0800
Message-Id: <20230902052512.12184-4-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230902052512.12184-1-minhuadotchen@gmail.com>
References: <20230902052512.12184-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sparst.rst to toctree, so it can be part of the docs build.

Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 .../translations/zh_TW/dev-tools/index.rst    | 40 +++++++++++++++++++
 Documentation/translations/zh_TW/index.rst    |  2 +-
 2 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_TW/dev-tools/index.rst

diff --git a/Documentation/translations/zh_TW/dev-tools/index.rst b/Documentation/translations/zh_TW/dev-tools/index.rst
new file mode 100644
index 000000000000..8f101db5a07f
--- /dev/null
+++ b/Documentation/translations/zh_TW/dev-tools/index.rst
@@ -0,0 +1,40 @@
+.. include:: ../disclaimer-zh_TW.rst
+
+:Original: Documentation/dev-tools/index.rst
+:Translator: Min-Hua Chen <minhuadotchen@gmail.com>
+
+============
+內核開發工具
+============
+
+本文檔是有關內核開發工具文檔的合集。
+目前這些文檔已經整理在一起，不需要再花費額外的精力。
+歡迎任何補丁。
+
+有關測試專用工具的簡要概述，參見
+Documentation/dev-tools/testing-overview.rst
+
+.. class:: toc-title
+
+	   目錄
+
+.. toctree::
+   :maxdepth: 2
+
+   sparse
+
+Todolist:
+
+ - coccinelle
+ - kcov
+ - ubsan
+ - kmemleak
+ - kcsan
+ - kfence
+ - kgdb
+ - kselftest
+ - kunit/index
+ - testing-overview
+ - gcov
+ - kasan
+ - gdb-kernel-debugging
diff --git a/Documentation/translations/zh_TW/index.rst b/Documentation/translations/zh_TW/index.rst
index d1cf0b4d8e46..ffcaf3272fe7 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -55,11 +55,11 @@ TODOList:
    :maxdepth: 1
 
    process/license-rules
+   dev-tools/index
 
 TODOList:
 
 * doc-guide/index
-* dev-tools/index
 * dev-tools/testing-overview
 * kernel-hacking/index
 * rust/index
-- 
2.34.1

