Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD345811DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442041AbjLMTDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjLMTDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:03:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD1BE3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:03:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFAEC433C9;
        Wed, 13 Dec 2023 19:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702494230;
        bh=DCzjM8ciFmSW1ZwCtCZzL7l/QtzSRPhWneY+wKj+vU0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hyr+2MY6xPiuvWwHsyk6RV0Torov76tR6btlHqK49UggV0nEVIZ7ovqJ6MqiyQoBT
         GJ6ggkCUIcocYQhX+C89P+Vh9n1X1PnrDZs1fw0/7mW6bDPCgI8S6xipNOcslhVGmf
         OFrxcOB7yW+r6aoNVwiKd6TxmCRcFJdJN6sC2uhEVPUbFUSqM/8TKyhIA/VF2kSaJM
         byTvwbOaaFViPxmxVRJISegjpfBKtMo0iUh7T10NR3wVO+1YRpxRMcSv3FINCQEFxC
         w2Y77OA4sFv5hwpDOHF64Drm8gPpHk4VToAgobXt0zKgYIKbhnxYA9yC2GCMeSeSXg
         sbt3PYCKBjPoA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] Docs/mm/damon/design: place execution model and data structures at the beginning
Date:   Wed, 13 Dec 2023 19:03:35 +0000
Message-Id: <20231213190338.54146-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213190338.54146-1-sj@kernel.org>
References: <20231213190338.54146-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The execution model and data structures section at the end of the design
document is briefly explaining how DAMON works overall.  Knowing that
first may help better drawing the overall picture.  It may also help
better understanding following detailed sections.  Move it to the
beginning of the document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8b4a49ac057d..1bb69524a62e 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -5,6 +5,18 @@ Design
 ======
 
 
+.. _damon_design_execution_model_and_data_structures:
+
+Execution Model and Data Structures
+===================================
+
+The monitoring-related information including the monitoring request
+specification and DAMON-based operation schemes are stored in a data structure
+called DAMON ``context``.  DAMON executes each context with a kernel thread
+called ``kdamond``.  Multiple kdamonds could run in parallel, for different
+types of monitoring.
+
+
 Overall Architecture
 ====================
 
@@ -490,15 +502,3 @@ modules for proactive reclamation and LRU lists manipulation are provided.  For
 more detail, please read the usage documents for those
 (:doc:`/admin-guide/mm/damon/reclaim` and
 :doc:`/admin-guide/mm/damon/lru_sort`).
-
-
-.. _damon_design_execution_model_and_data_structures:
-
-Execution Model and Data Structures
-===================================
-
-The monitoring-related information including the monitoring request
-specification and DAMON-based operation schemes are stored in a data structure
-called DAMON ``context``.  DAMON executes each context with a kernel thread
-called ``kdamond``.  Multiple kdamonds could run in parallel, for different
-types of monitoring.
-- 
2.34.1

