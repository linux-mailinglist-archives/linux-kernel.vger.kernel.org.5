Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75EE80B0DD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574833AbjLIAPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLIAPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:15:38 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA2F171F;
        Fri,  8 Dec 2023 16:15:44 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 81D1E5CC;
        Sat,  9 Dec 2023 00:15:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 81D1E5CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1702080944; bh=G+BZb1YJhO7EnX9yCvRFq6Nfa15LkoN+WflbTEHxZlw=;
        h=From:To:Cc:Subject:Date:From;
        b=gNMJw0Mo1k6tb71Yy0jKIGRdcqpmxO01J9dVgeRtVqlGMWTxoYtdUH5GRlG+jYCHJ
         vSKmBc2nnDqxAMRTbpcUwl6eYuRb4/0Yn5p1623oYEVHYyHex6xWZklndA78aZOjiW
         3JTHpDp8s7vhM0HTW+2pc7y9gc1eTkR9kyUq4vbMdyzBhvIBw2m0UGL8wW9RsX5FYH
         I/RhB4Dgkhyoa/neGO6EJXc2NOXTil3BM2HJDd09UW+aw/Jxc0J1EIwgSGKeUnFry0
         4CfSSj7DdLi3aPq4vImjYBR4cgRw4HKLVmoi5/0VIPIGvCWj6ct0HGhqzAB/uAHoq/
         gA0B7rNAZOPIg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC] Rework the top-level process page
Date:   Fri, 08 Dec 2023 17:15:43 -0700
Message-ID: <87msuk2pu8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The process book is arguably the most important documentation we have; the
top three trafficked pages on docs.kernel.org are found here.  Make a
beginning effort to impose a more useful organization on this page to ease
developers into the community.
---
This is a version of the reworked page I showed briefly during the
kernel-summit documentation session.  Perhaps more useful than the patch
itself is the rendered version of the page, which can be seen at:

  https://static.lwn.net/kerneldoc/process/index.html

There is a lot to do to turn this book into a coherent set of
documentation, but this seems like a plausible step in that direction.

 Documentation/process/index.rst | 84 ++++++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 21 deletions(-)

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index a1daa309b58d..0751c8c05023 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -15,49 +15,96 @@ to learn about how our community works.  Reading these documents will make
 it much easier for you to get your changes merged with a minimum of
 trouble.
 
-Below are the essential guides that every developer should read.
+An introduction to how kernel development works
+-----------------------------------------------
+
+Read these documents first: an understanding of the material here will ease
+your entry into the kernel community.
 
 .. toctree::
    :maxdepth: 1
 
-   license-rules
    howto
-   code-of-conduct
-   code-of-conduct-interpretation
    development-process
    submitting-patches
-   handling-regressions
+   submit-checklist
+
+Tools and technical guides for kernel developers
+------------------------------------------------
+
+This is a collection of material that kernel developers should be familiar
+with. 
+
+.. toctree::
+   :maxdepth: 1
+
+   changes
    programming-language
    coding-style
-   maintainer-handbooks
    maintainer-pgp-guide
    email-clients
+   applying-patches
+   backporting
+   adding-syscalls
+   volatile-considered-harmful
+   botching-up-ioctls
+
+Policy guides and developer statements
+--------------------------------------
+
+These are the rules that we try to live by in the kernel community (and
+beyond).
+
+.. toctree::
+   :maxdepth: 1
+
+   license-rules
+   code-of-conduct
+   code-of-conduct-interpretation
+   contribution-maturity-model
    kernel-enforcement-statement
    kernel-driver-statement
+   stable-api-nonsense
+   stable-kernel-rules
+   management-style
+   researcher-guidelines
 
-For security issues, see:
+Dealing with bugs
+-----------------
+
+Bugs are a fact of life; it is important that we handle them properly.
+The documents below describe our policies around the handling of a couple
+of special classes of bugs: regressions and security problems.
 
 .. toctree::
    :maxdepth: 1
 
+   handling-regressions
    security-bugs
    embargoed-hardware-issues
 
-Other guides to the community that are of interest to most developers are:
+Maintainer information
+----------------------
+
+How to find the people who will accept your patches.
+
+.. toctree::
+   :maxdepth: 1
+
+   maintainer-handbooks
+   maintainers
+
+Other material
+--------------
+
+Here are some other guides to the community that are of interest to most
+developers are:
 
 .. toctree::
    :maxdepth: 1
 
-   changes
-   stable-api-nonsense
-   management-style
-   stable-kernel-rules
-   submit-checklist
    kernel-docs
    deprecated
-   maintainers
-   researcher-guidelines
-   contribution-maturity-model
 
 These are some overall technical guides that have been put here for now for
 lack of a better place.
@@ -65,12 +112,7 @@ lack of a better place.
 .. toctree::
    :maxdepth: 1
 
-   applying-patches
-   backporting
-   adding-syscalls
    magic-number
-   volatile-considered-harmful
-   botching-up-ioctls
    clang-format
    ../arch/riscv/patch-acceptance
    ../core-api/unaligned-memory-access
-- 
2.42.0

