Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60247B09EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjI0QWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjI0QWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:22:47 -0400
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1229C
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:22:46 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 5401DCA4DC14; Wed, 27 Sep 2023 09:22:32 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 3/4] mm/ksm: document smart scan mode
Date:   Wed, 27 Sep 2023 09:22:21 -0700
Message-Id: <20230927162222.3827551-4-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230927162222.3827551-1-shr@devkernel.io>
References: <20230927162222.3827551-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_NEUTRAL,
        TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for the smart scan mode of KSM.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/ksm.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
index 776f244bdae4..2b38a8bb08af 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -155,6 +155,15 @@ stable_node_chains_prune_millisecs
         scan. It's a noop if not a single KSM page hit the
         ``max_page_sharing`` yet.
=20
+smart_scan
+        Historically KSM checked every candidate page for each scan. It =
did
+        not take into account historic information.  When smart scan is
+        enabled, pages that have previously not been de-duplicated get
+        skipped. How often these pages are skipped depends on how often
+        de-duplication has already been tried and failed. By default thi=
s
+        optimization is enabled. The ``pages_skipped`` metric shows how
+        effective the setting is.
+
 The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm=
/ksm/``:
=20
 general_profit
--=20
2.39.3

