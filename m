Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD4C763EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjGZSv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjGZSv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:51:26 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BBC1FEC;
        Wed, 26 Jul 2023 11:51:25 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7672073e7b9so11358485a.0;
        Wed, 26 Jul 2023 11:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690397484; x=1691002284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHyX3wq0ojFXPUI8SahCi1FQW7IJesz87c8DpSzeOCw=;
        b=kkUQgqr8T6q3+LtXE/B8F6jrpfBEFq856rQ0WmbhThXP00OupGuaodeYaegjscoJap
         whz2SE9rnmKYuX7eq/ABaH+Fl3XQZX29+4RjCKmFygh/dWXbeyrn8THH1hZn8d4OMpsa
         S6xPdiDP/j7DVZ6VbvLq+u0l245iOkEN3mmtf9nuINfdA/S51QzQe6H/qkmgU9bZD5fc
         PM25HJnBOaqhV5gd9+KuAW+fKLtkz1FwSyLeq2v1XCdaq1afihmcsyHNGItpeW5zyMyR
         lIuEhPaX3B9k8Ra+L+OkfEM5PeWXAZ99kG/5ehj/zOtrjvLpSTSOsr7498QJFr9Zt8Kb
         5byA==
X-Gm-Message-State: ABy/qLaKfRxj8QuO4kCCx5fmWcf+n9iHB5TL4AzREuDPPIqX1LpRTb3v
        F8rUQUqEbbsiaDdReabo2T4blv02G+iBTg==
X-Google-Smtp-Source: APBJJlEiIiMrCuHBh5EMrE6WULrKvE/VQouJQAx/LwvKSQ27NngFdA8c3ZBXCKmZCev8BLTyEDFsfg==
X-Received: by 2002:ac8:5bd5:0:b0:403:a4d3:a633 with SMTP id b21-20020ac85bd5000000b00403a4d3a633mr3560424qtb.66.1690397484502;
        Wed, 26 Jul 2023 11:51:24 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a040:199:8930:2c90:cb9e:b154:73dc])
        by smtp.gmail.com with ESMTPSA id b3-20020ac86783000000b0040324785e4csm4939197qtp.13.2023.07.26.11.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 11:51:24 -0700 (PDT)
From:   Costa Shulyupin <costa.shul@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>
Subject: [RFC PATCH v2] docs: rework "Working with the development community"
Date:   Wed, 26 Jul 2023 21:49:37 +0300
Message-ID: <20230726184939.3118350-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <87ila9atuk.fsf@meer.lwn.net>
References: <87ila9atuk.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mission: Make the documentation more readable, organized and maintainable.

NB: no information content is lost of changed on the rendered top page.

This patch demonstrates rework of the only the first section
of the top page for review. The proposal is to rework all sections.

Summary of changes:
- Heading "Working with the development community" is converted into
  branch of toctree and visually moved after the text
  "The essential guides for interacting ..."
- toctree list is split into separated file. Please don't worry, the
  content of the list is incorporated to the top page because of
  `:maxdepth: 2`
- vertical bar '|' add empty line for better visual distribution

Technical explanations:
Template {{ toctree(maxdepth=3) }} in
Documentation/sphinx/templates/kernel-toc.html
uses directives toctree and doesn't use sections on the top page
Documentation/index.rst
to generate expandable toc on the sidebar.

BTW, other template {{ toc }} uses only sections, and doesn't
use directives toctree.

Benefit:
- toc on side bar is expandable and collapsible

---

References:
- https://www.sphinx-doc.org/en/master/development/templating.html#toctree
- https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-toctree
- https://www.sphinx-doc.org/en/master/development/templating.html#toc
- https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
- https://sphinx-rtd-theme.readthedocs.io/

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/index.rst        | 12 +++---------
 Documentation/process/main.rst | 13 +++++++++++++
 2 files changed, 16 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/process/main.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9dfdc826618c..560eb0bc78dd 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -13,21 +13,15 @@ documents into a coherent whole.  Please note that improvements to the
 documentation are welcome; join the linux-doc list at vger.kernel.org if
 you want to help out.
 
-Working with the development community
-======================================
+|
 
 The essential guides for interacting with the kernel's development
 community and getting your work upstream.
 
 .. toctree::
-   :maxdepth: 1
-
-   process/development-process
-   process/submitting-patches
-   Code of conduct <process/code-of-conduct>
-   maintainer/index
-   All development-process docs <process/index>
+   :maxdepth: 2
 
+   process/main
 
 Internal API manuals
 ====================
diff --git a/Documentation/process/main.rst b/Documentation/process/main.rst
new file mode 100644
index 000000000000..40bab4ff8198
--- /dev/null
+++ b/Documentation/process/main.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Working with the development community
+======================================
+
+.. toctree::
+   :maxdepth: 1
+
+   development-process
+   submitting-patches
+   Code of conduct <code-of-conduct>
+   ../maintainer/index
+   All development-process docs <../process/index>
-- 
2.41.0

