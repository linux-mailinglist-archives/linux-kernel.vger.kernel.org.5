Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83843796EE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243087AbjIGC3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240631AbjIGC3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:29:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3112719A8;
        Wed,  6 Sep 2023 19:29:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4271BC43391;
        Thu,  7 Sep 2023 02:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694053779;
        bh=DPwXZPd8fZ7k76FJchCmgeNiFjKUbh+BZTC85e+typU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VfeGOqRlnm1Nvu7Y2kpqlsGEtfB0Kla59hAm6h5Y/p0nAKX8Y+yr52/mK2U5nrH+2
         hfS//w3W7c4ET/DXTDnly0qtrnvotoU8irI8jZt6PdrASx/nf/QCHupesbiS82wbFj
         KiEcIUhAXFG2uDrfO7LiMuLy2Rl8udgQmP0xafcIhBpkH7aY7lDryUSN0oIFlsieQ6
         w46kYv6osQmpIdkqCMMZ7FT6hb0JL4NY4ZUNEszYWhQrH29kzmKstStqhSqFr9tdTC
         teVpDaZxwOf9lyI69y4dN4BLbnN/YZPQNcQueIoGSoDt4n070hfVug2XT9bl33UsZ8
         IXUNAIM0JHyvA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] Docs/admin-guide/mm/damon/usage: move debugfs intro to the bottom of the section
Date:   Thu,  7 Sep 2023 02:29:21 +0000
Message-Id: <20230907022929.91361-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907022929.91361-1-sj@kernel.org>
References: <20230907022929.91361-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the DAMON usage introduction section, the introduction of DAMON
debugfs interface, which is deprecated, is above kernel API, which is
actively supported.  Move the DAMON debugfs intro to bottom, so that
readers have less chances to read it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index bffe9dd9b0d6..e48101c777e1 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -20,18 +20,18 @@ DAMON provides below interfaces for different users.
   you can write and use your personalized DAMON sysfs wrapper programs that
   reads/writes the sysfs files instead of you.  The `DAMON user space tool
   <https://github.com/awslabs/damo>`_ is one example of such programs.
-- *debugfs interface. (DEPRECATED!)*
-  :ref:`This <debugfs_interface>` is almost identical to :ref:`sysfs interface
-  <sysfs_interface>`.  This is deprecated, so users should move to the
-  :ref:`sysfs interface <sysfs_interface>`.  If you depend on this and cannot
-  move, please report your usecase to damon@lists.linux.dev and
-  linux-mm@kvack.org.
 - *Kernel Space Programming Interface.*
   :doc:`This </mm/damon/api>` is for kernel space programmers.  Using this,
   users can utilize every feature of DAMON most flexibly and efficiently by
   writing kernel space DAMON application programs for you.  You can even extend
   DAMON for various address spaces.  For detail, please refer to the interface
   :doc:`document </mm/damon/api>`.
+- *debugfs interface. (DEPRECATED!)*
+  :ref:`This <debugfs_interface>` is almost identical to :ref:`sysfs interface
+  <sysfs_interface>`.  This is deprecated, so users should move to the
+  :ref:`sysfs interface <sysfs_interface>`.  If you depend on this and cannot
+  move, please report your usecase to damon@lists.linux.dev and
+  linux-mm@kvack.org.
 
 .. _sysfs_interface:
 
-- 
2.25.1

