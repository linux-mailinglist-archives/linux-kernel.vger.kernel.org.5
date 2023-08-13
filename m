Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5311F77AA0C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjHMQaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjHMQ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:29:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B071704;
        Sun, 13 Aug 2023 09:29:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686e0213c0bso2259406b3a.1;
        Sun, 13 Aug 2023 09:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691944169; x=1692548969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=peTGhOlgU5WlSEFnWMO0ULAgtfEB/eQ4Ztc466zXy3I=;
        b=GHKOlD5AykX7Dbbg7rzQi3VK+zzIADZciu2Jm2EUYDCaXJ9UZMwtXAfG2d8LBC0EU2
         A7dLajM0KXnsfQ1yoAXpQgtY1yPwLb26nfbtNM2BI0Op0qulF3ZkAzzDGVrGJDpWH0cG
         0cjn6ybAPOWTouEvuo0e97Yb+5CU178zF9JdDZ/QegvpI6h5fvrLXqAQikk3jS1sXzU3
         qDxFm3DCMMQDDFkGtDDgHUBRAJHN7+uiTk+xDkQDoIgBlVERHaOOmK5L4UxwFFUABB/E
         w5NZZ0n8EEDmqMNKhtUTppuKuPl+KL+AsLTLncYBDhdco/BO4gStjQzMsro+glv/NQjh
         8SQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691944169; x=1692548969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=peTGhOlgU5WlSEFnWMO0ULAgtfEB/eQ4Ztc466zXy3I=;
        b=a6+uawZOEWNlsWORN4TTwhe8FlwXfPwkEYU2rrvyS57KziTiKtVpkPh158HoJsURmb
         N5YCRv4d2MBuOPEhy+PPuMluzofajE3mIiTUD+4fFkJB9zKAKnPk7tvZD2Fthn5fZ5vs
         EYjgXyZsNyiWz0qF8gi6ABfUHpQa5lI6m4i1oioAZJACoP/+hlzT/K0K7U7lm6YjCuyT
         fvV6fjXqvqrI4/ERhjcF1r/Jd954VDgFmzQyOa8u9bIIH8JA8geFNSER/x8wyt2i4ifw
         1YHnv5w9/jL67Vrq4Idd625hlqRMtyLx+aLdA6nED3fYgNM5ET3Zm5k2yS011oN/KQe1
         0vLg==
X-Gm-Message-State: AOJu0YyCdoMbLkAdMvIOpudAFOaqGqA218MNc+j5W//Nzue/E14ytErg
        jzWY0Oiwvph38szHeGgYLhE=
X-Google-Smtp-Source: AGHT+IHx5dk6ROvFEUwBYbimO4kGS6p9l3Stci0sl2zzEOPkKEJHp86VCSp9lnpctsjciSJoaooqIg==
X-Received: by 2002:a05:6a20:7d99:b0:13e:fbee:a5d1 with SMTP id v25-20020a056a207d9900b0013efbeea5d1mr7358726pzj.37.1691944169378;
        Sun, 13 Aug 2023 09:29:29 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-78-6.dynamic-ip.hinet.net. [36.228.78.6])
        by smtp.gmail.com with ESMTPSA id e30-20020a63371e000000b0056595ead4c9sm2629952pga.33.2023.08.13.09.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 09:29:29 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Hu Haowen <src.res@email.cn>, Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: [PATCH v2 3/3] docs: sparse: add sparse.rst to toctree
Date:   Mon, 14 Aug 2023 00:29:15 +0800
Message-Id: <20230813162915.39577-4-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230813162915.39577-1-minhuadotchen@gmail.com>
References: <20230813162915.39577-1-minhuadotchen@gmail.com>
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
index e7c83868e780..2fe6832a21c3 100644
--- a/Documentation/translations/zh_TW/index.rst
+++ b/Documentation/translations/zh_TW/index.rst
@@ -70,10 +70,10 @@ TODOlist:
    :maxdepth: 2
 
    process/index
+   dev-tools/index
 
 TODOList:
 
-* dev-tools/index
 * doc-guide/index
 * kernel-hacking/index
 * trace/index
-- 
2.34.1

