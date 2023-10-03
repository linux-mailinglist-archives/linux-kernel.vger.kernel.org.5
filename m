Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A637B60CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjJCGah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjJCGaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:30:35 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A119E;
        Mon,  2 Oct 2023 23:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696314629;
        bh=hLBoB3YRvSlBpdlzyiN1FFL/R0tXiIaWc9aCqoErf9g=;
        h=From:Date:Subject:To:Cc:From;
        b=Q9BXdLm4iEfaZ5ifJCGaDQHhhmzUBPUnyOP2QiHjs9gsLkvgFR/OqYfCQojbFQJPt
         DvhGdoiD/dphkNACWIFq2LfmpXS73wRpzErAylan6c+fSdVIIrvxGw18yDcrYFcQBA
         UtM9Ee30wereRhb4x96zUitVcdZSn04NcfDBfFvk=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 03 Oct 2023 08:30:03 +0200
Subject: [PATCH v2] docs: submitting-patches: encourage direct
 notifications to commenters
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231003-docs-cc-reviewer-v2-1-f93fb946e21e@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAOq0G2UC/2WNQQ6CQAxFr0K6tgY6BqIr72FYQClON2CmMGgId
 3cgceXy/f7/uoJJUDG4ZSsEiWo6DgnolAH7ZngKapcYKCeXX6nEbmRDZtzLskjAdGhd5fKmJwd
 p9grS6/tQPurEXm0aw+f4EIs9/cmqf1kssEBq+kvJ0lLn+L6Imhn72Z8HmaDetu0LXb+yqrUAA
 AA=
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jani Nikula <jani.nikula@intel.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696314629; l=1773;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hLBoB3YRvSlBpdlzyiN1FFL/R0tXiIaWc9aCqoErf9g=;
 b=W1MIMd5b9zo7ZkjZUFcLd/mT5jkwrbH8J0aRWLcD6+kAtRo/Nz6yBoM2HdHrzactcbzEkWWJP
 eTvhARdO5s/CLPfu017wwUHiaHx075paqbUGMKPYLe2FrdoWh6YAy5R
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

Commenters may not receive new versions of patches via the lists.
Without a directed notification to them they might miss those new
versions.

This is frustrating for the patch developers as they don't receive their
earned Reviewed-by.
It is also frustrating for the commenters, as they might think their
review got ignored or they have to dig up new versions from the archive
manually.

So encourage patch submitters to make sure that all commenters get
notified also when no Reviewed-by was issued yet.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- s/reviewer/commenter/ to avoid ambiguity (Christoph)
- Link to v1: https://lore.kernel.org/r/20230927-docs-cc-reviewer-v1-1-2af46ceb2d3c@weissschuh.net
---
 Documentation/process/submitting-patches.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index efac910e2659..3245b7b38b98 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -327,6 +327,8 @@ politely and address the problems they have pointed out.  When sending a next
 version, add a ``patch changelog`` to the cover letter or to individual patches
 explaining difference against previous submission (see
 :ref:`the_canonical_patch_format`).
+Notify people that commented on your patch about new versions by adding them to
+the patches CC list.
 
 See Documentation/process/email-clients.rst for recommendations on email
 clients and mailing list etiquette.

---
base-commit: 633b47cb009d09dc8f4ba9cdb3a0ca138809c7c7
change-id: 20230926-docs-cc-reviewer-023b3730af23

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

