Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F7F77934B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbjHKPgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjHKPgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:36:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D166127;
        Fri, 11 Aug 2023 08:36:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6873a30d02eso1586758b3a.3;
        Fri, 11 Aug 2023 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691768165; x=1692372965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrSPKnMPxUyxdZ56A/Ymf1Wam2Yx6ql1R/ZidYXYTho=;
        b=jva4C7cpDg8zRAMDDZAAUrdwUtQLPFDSXloW+ftgp+L3aCe32CrqEXRQKgf2G7n9A6
         1PUbLC0t6OBnX6m97EpeRXKv9EEjp/d/Qy2US5bVuc5Q/DEo5eKQJLUPP0B3s4nXd+qU
         quCtsw8qVdSvB6PBsA+B1Kn+UoMljYxecAv+wdGx1ZQ7QxNEVnyLNVKd38gbBIkPbij3
         cVtZiX+eaz81nwOC7Jqu0ek6lXkiS2KikgLZ0tm5G12nq/YkEhvugpr6ngVnbdZiVNAn
         nlHD9dobvEEiQ5/oafOkF7xZ7UoceVddeaf2h70UEiyIj5gJKXYWzF9qPREMJOwTSBq9
         pS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691768165; x=1692372965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrSPKnMPxUyxdZ56A/Ymf1Wam2Yx6ql1R/ZidYXYTho=;
        b=IZLjSUKfLSWnjsK+xUbLv+8g3DzhdTIrWSAInJ/gxfRwhuiKDUlwjIVqnnJacsRTTH
         2tLrmILIfBBOG1NOSggC8hs7Gl+OKNDhTNmgYUCKoprmaYET4vH86eCl9Jm1STxswoSY
         FBr+BzUiQVKdkLVRgjEOR3h4j4eI7q7qkr1gtzgAj2m0Dp7sKJN0w/FA5BywoGWl2jaD
         VMN8lRdcRwI6CEAt1L9A11EnCJe9Fi30RQGv+ZCKWnUOPM+ny5R+XqPuBYDfqBsTFRLA
         6TspcsOE9RyZ2xYFOA6moXAcPKouDd3dZHjLNZfiLsNgx+xCu39XBjCjDnrO0SA7ltBx
         EFzA==
X-Gm-Message-State: AOJu0YwmpxBd0Mc2jfuofl4lugHiRse7+yv7IiLURx1iWfQS+6UL15ZQ
        Y/pADvc0RtO1ul6Uj2tNLBg=
X-Google-Smtp-Source: AGHT+IGp0UrcmUhKYMgZpTaA902zqyyJ4NP8WEf9QX1vWOwJXbN06e0AboUaUqgLmSlLBlpUtAjacQ==
X-Received: by 2002:a05:6a00:21d6:b0:687:5bd6:b6d1 with SMTP id t22-20020a056a0021d600b006875bd6b6d1mr2262941pfj.3.1691768164884;
        Fri, 11 Aug 2023 08:36:04 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-78-6.dynamic-ip.hinet.net. [36.228.78.6])
        by smtp.gmail.com with ESMTPSA id c15-20020aa78c0f000000b006826c9e4397sm3467602pfd.48.2023.08.11.08.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:36:04 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs: sparse: convert TW sparse.txt into sparse.rst
Date:   Fri, 11 Aug 2023 23:35:54 +0800
Message-Id: <20230811153554.84571-3-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811153554.84571-1-minhuadotchen@gmail.com>
References: <20230811153554.84571-1-minhuadotchen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Follow Randy's advice [1] to move
Documentation/translations/zh_TW/dev-tools/sparse.txt
to
Documentation/translations/zh_TW/dev-tools/sparse.rst

[1] https://lore.kernel.org/lkml/bfab7c5b-e4d3-d8d9-afab-f43c0cdf26cf@infradead.org/

Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 .../dev-tools/{sparse.txt => sparse.rst}      | 31 ++++++-------------
 1 file changed, 10 insertions(+), 21 deletions(-)
 rename Documentation/translations/zh_TW/dev-tools/{sparse.txt => sparse.rst} (71%)

diff --git a/Documentation/translations/zh_TW/dev-tools/sparse.txt b/Documentation/translations/zh_TW/dev-tools/sparse.rst
similarity index 71%
rename from Documentation/translations/zh_TW/dev-tools/sparse.txt
rename to Documentation/translations/zh_TW/dev-tools/sparse.rst
index 6d2d088b1060..2f632f6ce8e8 100644
--- a/Documentation/translations/zh_TW/dev-tools/sparse.txt
+++ b/Documentation/translations/zh_TW/dev-tools/sparse.rst
@@ -1,33 +1,22 @@
-﻿Chinese translated version of Documentation/dev-tools/sparse.rst
-
-If you have any comment or update to the content, please contact the
-original document maintainer directly.  However, if you have a problem
-communicating in English you can also ask the Chinese maintainer for
-help.  Contact the Chinese maintainer if this translation is outdated
-or if there is a problem with the translation.
+﻿Copyright 2004 Linus Torvalds
+Copyright 2004 Pavel Machek <pavel@ucw.cz>
+Copyright 2006 Bob Copeland <me@bobcopeland.com>
 
-Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
----------------------------------------------------------------------
-Documentation/dev-tools/sparse.rst 的繁體中文翻譯
+.. include:: ../disclaimer-zh_TW.rst
 
-如果想評論或更新本文的內容，請直接聯繫原文檔的維護者。如果你使用英文
-交流有困難的話，也可以向繁體中文版維護者求助。如果本翻譯更新不及時或
-者翻譯存在問題，請聯繫繁體中文版維護者。
+:Original: Documentation/dev-tools/sparse.rst
 
-繁體中文版維護者： 胡皓文 Hu Haowen <src.res@email.cn>
-繁體中文版翻譯者： 胡皓文 Hu Haowen <src.res@email.cn>
+:翻譯:
 
-以下爲正文
----------------------------------------------------------------------
+Traditional Chinese maintainer: Hu Haowen <src.res@email.cn>
 
-Copyright 2004 Linus Torvalds
-Copyright 2004 Pavel Machek <pavel@ucw.cz>
-Copyright 2006 Bob Copeland <me@bobcopeland.com>
+Sparse
+======
 
 使用 sparse 工具做類型檢查
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-"__bitwise" 是一種類型屬性，所以你應該這樣使用它：
+"__bitwise" 是一種類型屬性，所以你應該這樣使用它::
 
         typedef int __bitwise pm_request_t;
 
-- 
2.34.1

