Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A371579D818
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbjILRxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbjILRxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:53:22 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD111FE7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:52:53 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 467C8BCD162E; Tue, 12 Sep 2023 10:52:39 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 3/4] mm/ksm: document smart scan mode
Date:   Tue, 12 Sep 2023 10:52:27 -0700
Message-Id: <20230912175228.952039-4-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230912175228.952039-1-shr@devkernel.io>
References: <20230912175228.952039-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for the smart scan mode of KSM.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 Documentation/admin-guide/mm/ksm.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
index 776f244bdae4..1762219baf51 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -155,6 +155,15 @@ stable_node_chains_prune_millisecs
         scan. It's a noop if not a single KSM page hit the
         ``max_page_sharing`` yet.
=20
+smart_scan
+        By default KSM checks every candidate page for each scan. It doe=
s
+        not take into account historic information. When smart scan is
+        enabled, pages that have previously not been de-duplicated get
+        skipped. How often these pages are skipped depends on how often
+        de-duplication has already been tried and failed. By default thi=
s
+        optimization is disabled. The ``pages_skipped`` metric shows how
+        effetive the setting is.
+
 The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm=
/ksm/``:
=20
 general_profit
--=20
2.39.3

