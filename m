Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4039479D816
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 19:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjILRxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 13:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbjILRxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 13:53:22 -0400
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB851FE5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 10:52:53 -0700 (PDT)
Received: by devbig1114.prn1.facebook.com (Postfix, from userid 425415)
        id 9C4ADBCD1635; Tue, 12 Sep 2023 10:52:39 -0700 (PDT)
From:   Stefan Roesch <shr@devkernel.io>
To:     kernel-team@fb.com
Cc:     shr@devkernel.io, akpm@linux-foundation.org, david@redhat.com,
        hannes@cmpxchg.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v1 4/4] mm/ksm: document pages_skipped sysfs knob
Date:   Tue, 12 Sep 2023 10:52:28 -0700
Message-Id: <20230912175228.952039-5-shr@devkernel.io>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230912175228.952039-1-shr@devkernel.io>
References: <20230912175228.952039-1-shr@devkernel.io>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for the new metric pages_skipped.

Signed-off-by: Stefan Roesch <shr@devkernel.io>
---
 Documentation/admin-guide/mm/ksm.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
index 1762219baf51..27d949250b67 100644
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

