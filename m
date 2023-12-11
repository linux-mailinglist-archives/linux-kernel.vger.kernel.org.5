Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5243780BEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 02:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbjLKBUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 20:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjLKBUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 20:20:13 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AFBCE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:20:19 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5908a63a83fso1804160eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 17:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20230601.gappssmtp.com; s=20230601; t=1702257619; x=1702862419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hz/MrfMXgmVrT9CiBQSZF3wf7//eTcS99U2COnSPC44=;
        b=hedIb1QnNAScnSWnnSjEIMS2X3mPMHNDxunIz+tlDCAU9aqJ8Cf2eOaLiXVo8QNXeQ
         JVYrhmSh/MZu3aaZ8ilM4q+gcd/Ew0zQ3T3cw2yCAeV4QYR5CdkTvTkFgk2nJK96x8Gk
         9vtZ1P3L0YhAF9dPp1JmcWaQdNzw24J+tapM0+36WXY9fF6Vrq877++FWNHd7RLbhdoq
         Kt+id2PXk3MWC9SQ4mRsFk7djwyTn0uH5JukqH9IiknRpBL2Q+MyIyaRijplGfPFY4C3
         +AHaEmtgNAW5giiytnxL47J0ISnxKVTy4ryJwoL8/7TZxpd7Ny1bwLXLabmbsph7qAP4
         lZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702257619; x=1702862419;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hz/MrfMXgmVrT9CiBQSZF3wf7//eTcS99U2COnSPC44=;
        b=fMieMv5/oqMibOY+kjPdDV0nRxeB3s8U26vubn/gnIBv5mFgg6RQIT3UxI9dBqz5A9
         uM/3JnJ6GofzX5uJb7Z2T0SU9kq7kbq6KoM4zLClDG+X+yTVYRBqeLJ/QGGCyyhaIQQY
         YHCTmijnj3K7QBGX2CwsJT/5gejBMQdvRxngm2CufbdmgNSSmgDKbeReBI0oE/yA7Dy4
         zHhe5KEjkbcULLGcmVKOK9aXs4b3gFHlZAuALZCK8S03oKg/rCHqITDELwZvzeMxw+u9
         BEYZXm0RwKjfwvsSYHOqWs1B+uCtlHUeatJ9kgnpk6ZTuY6Lq16ysHbMJC2coIRAMQH+
         ouPA==
X-Gm-Message-State: AOJu0YxoUbfLVsYCTu1zIJqI0r01PTzdYmiIjaVp0+asf5qvREtG6U1a
        QDyMgLFj1hBjgvqG1tO0ls1b5g==
X-Google-Smtp-Source: AGHT+IEhtKouvEr/wVgn8kHMoq6zjNeaM5Zyodtwbt+2BDl/3XjZw3RXGMlkdOMU1rBvcjkDaaJXkg==
X-Received: by 2002:a05:6820:168b:b0:590:66ca:30bb with SMTP id bc11-20020a056820168b00b0059066ca30bbmr2734441oob.9.1702257618995;
        Sun, 10 Dec 2023 17:20:18 -0800 (PST)
Received: from ?IPV6:2603:8080:2300:de:29b1:e1a0:8d3c:63c7? (2603-8080-2300-00de-29b1-e1a0-8d3c-63c7.res6.spectrum.com. [2603:8080:2300:de:29b1:e1a0:8d3c:63c7])
        by smtp.gmail.com with ESMTPSA id e196-20020a4a55cd000000b0058d8b0c4bbdsm1668225oob.32.2023.12.10.17.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 17:20:18 -0800 (PST)
Message-ID: <dcab1e08-c054-441b-8d4e-f46e2f22605c@vt.edu>
Date:   Sun, 10 Dec 2023 19:20:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/1 RESEND] docs: Include simplified link titles in main
 page's index
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
        a.hindborg@samsung.com, aliceryhl@google.com,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <58e78693-82d1-451d-a546-51fb64ef6eb5@vt.edu>
From:   Carlos Bilbao <bilbao@vt.edu>
In-Reply-To: <58e78693-82d1-451d-a546-51fb64ef6eb5@vt.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include simplified link titles in the main page's documentation index to
enhance website's readability and UX. Update the text that directs users to
various documents without changing the actual titles chosen by the authors.

Signed-off-by: Carlos Bilbao <bilbao@vt.edu>
---
 Documentation/index.rst | 50 ++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9dfdc826618c..be395d0a4318 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -22,10 +22,10 @@ community and getting your work upstream.
 .. toctree::
    :maxdepth: 1
 
-   process/development-process
-   process/submitting-patches
+   Development process <process/development-process>
+   Submitting patches <process/submitting-patches>
    Code of conduct <process/code-of-conduct>
-   maintainer/index
+   Maintainer handbook <maintainer/index>
    All development-process docs <process/index>
 
 
@@ -38,10 +38,10 @@ kernel.
 .. toctree::
    :maxdepth: 1
 
-   core-api/index
-   driver-api/index
-   subsystem-apis
-   Locking in the kernel <locking/index>
+   Core API <core-api/index>
+   Driver implementation API <driver-api/index>
+   Subsystems <subsystem-apis>
+   Locking <locking/index>
 
 Development tools and processes
 ===============================
@@ -51,15 +51,15 @@ Various other manuals with useful information for all kernel developers.
 .. toctree::
    :maxdepth: 1
 
-   process/license-rules
-   doc-guide/index
-   dev-tools/index
-   dev-tools/testing-overview
-   kernel-hacking/index
-   trace/index
-   fault-injection/index
-   livepatch/index
-   rust/index
+   Licensing rules <process/license-rules>
+   Writing documentation <doc-guide/index>
+   Development tools <dev-tools/index>
+   Testing <dev-tools/testing-overview>
+   Hacking <kernel-hacking/index>
+   Tracing <trace/index>
+   Fault injection <fault-injection/index>
+   Livepatching <livepatch/index>
+   Rust <rust/index>
 
 
 User-oriented documentation
@@ -72,11 +72,11 @@ developers seeking information on the kernel's user-space APIs.
 .. toctree::
    :maxdepth: 1
 
-   admin-guide/index
-   The kernel build system <bailed/index>
-   admin-guide/reporting-issues.rst
+   Administration <admin-guide/index>
+   Build system <bugled/index>
+   Reporting issues <admin-guide/reporting-issues.rst>
    User-space tools <tools/index>
-   userspace-api/index
+   User-space API <userspace-api/index>
 
 See also: the `Linux man pages <https://www.kernel.org/doc/man-pages/>`_,
 which are kept separately from the kernel's own documentation.
@@ -89,8 +89,8 @@ platform firmwares.
 .. toctree::
    :maxdepth: 1
 
-   firmware-guide/index
-   devicetree/index
+   Firmware <firmware-guide/index>
+   Firmware and Devicetree <devicetree/index>
 
 
 Architecture-specific documentation
@@ -99,7 +99,7 @@ Architecture-specific documentation
 .. toctree::
    :maxdepth: 2
 
-   arch/index
+   CPU Architectures <arch/index>
 
 
 Other documentation
@@ -112,7 +112,7 @@ to ReStructured Text format, or are simply too old.
 .. toctree::
    :maxdepth: 1
 
-   staging/index
+   Unsorted documentation <staging/index>
 
 
 Translations
@@ -121,7 +121,7 @@ Translations
 .. toctree::
    :maxdepth: 2
 
-   translations/index
+   Translations <translations/index>
 
 Indices and tables
 ==================
-- 

