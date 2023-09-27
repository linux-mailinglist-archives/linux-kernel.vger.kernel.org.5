Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C70D7B09EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjI0QWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjI0QWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:22:47 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40BDD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:22:46 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 62387CA4DC16; Wed, 27 Sep 2023 09:22:32 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 4/4] mm/ksm: document pages_skipped sysfs knob
Date:   Wed, 27 Sep 2023 09:22:22 -0700
Message-Id: <20230927162222.3827551-5-shr@devkernel.io>
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

This adds documentation for the new metric pages_skipped.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/ksm.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
index 2b38a8bb08af..0cadde17ae0c 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -178,6 +178,8 @@ pages_unshared
         how many pages unique but repeatedly checked for merging
 pages_volatile
         how many pages changing too fast to be placed in a tree
+pages_skipped
+        how many pages did the "smart" page scanning algorithm skip
 full_scans
         how many times all mergeable areas have been scanned
 stable_node_chains
--=20
2.39.3

