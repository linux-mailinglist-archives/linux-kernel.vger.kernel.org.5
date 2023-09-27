Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374EA7B0C32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjI0Swa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0Sw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:52:28 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103D4F4;
        Wed, 27 Sep 2023 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1695840744;
        bh=8oZRiC8TvCCvbc1U3s09oWhk9JsHYoBMdt9cosRWsYM=;
        h=From:Date:Subject:To:Cc:From;
        b=UfKTNzBqFvwTJs2Pwg4V20sG3VT8gvUMR6av4BWW2rXDtje/mTHc9piC6RREUTJDe
         g4QNSItmcjQVRmyJ2mM/VgrmKkS8gWwvDJGij3KebLhlsezGogEYq3EKHbrAc/6Z2h
         AxHqNRo7gbrTpAOwu9o/dmNmqyWYKWhfYAK/YlPU=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 27 Sep 2023 20:52:21 +0200
Subject: [PATCH] docs: submitting-patches: encourage direct notifications
 to reviewers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230927-docs-cc-reviewer-v1-1-2af46ceb2d3c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAOR5FGUC/x2MQQqAIBBFryKzbsAUirpKtDAdazYaChWId89aP
 v77r0CmxJRhFgUSXZw5hgZ9J8AeJuyE7BqDkkrLSQ3oos1oLX4y3ZSwDZsetTReaWi3M5Hn508
 ua60vldVHM2IAAAA=
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695840741; l=1607;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8oZRiC8TvCCvbc1U3s09oWhk9JsHYoBMdt9cosRWsYM=;
 b=MnRSaxqNEAbHX1QM+QeisRMxytq2IWJcRAbTtPLCweS9V5xyi6EpajjQePm3w+NO2XQyO60Wv
 CTyCnhRYc6oCgMpoJblHJw8yM9hwZiBgy66btUojD74RSR6MgFJ4l7M
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewers may not receive new versions of patches via the lists.
Without a directed notification to them they might miss those new
versions.

This is frustrating for the patch developers as they don't receive their
earned Reviewed-by.
It is also frustrating for the reviewers, as they might think their
review got ignored or they have to dig up new versions from the archive
manually.

So encourage patch submitters to make sure that all reviewers get
notified also when no Reviewed-by was issued yet.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Documentation/process/submitting-patches.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index efac910e2659..8dca82dfcd69 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -327,6 +327,8 @@ politely and address the problems they have pointed out.  When sending a next
 version, add a ``patch changelog`` to the cover letter or to individual patches
 explaining difference against previous submission (see
 :ref:`the_canonical_patch_format`).
+Notify reviewers and other involved people about new versions of your patch by
+adding them to the patches CC list.
 
 See Documentation/process/email-clients.rst for recommendations on email
 clients and mailing list etiquette.

---
base-commit: 633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
change-id: 20230926-docs-cc-reviewer-023b3730af23

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

