Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86AD7E925D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 20:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjKLTqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 14:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjKLTqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 14:46:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81BF1BFF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 11:46:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC19C433C7;
        Sun, 12 Nov 2023 19:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699818377;
        bh=eYWOuBaRm7gUBwsw8MKJnCTGV0ZszqASzlgqM1IUQmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYH0rlFsJBrDrANNHDdlzS61wIc8bZdp2hUgWOgsXWFKJCZ3KnMObjtCni4f0diDU
         g2Z4RT4NsvLxJILjF6kRSpebeBN+wmwGsk58Lo7CXP1WrEiSR2/Dq7VqVB6IBgpJGb
         F3Bj+xKTXSGqZK3VdTW/ILQW9PbdUvedatn13RqucpgrvVjXD6L+LPlOl1yyR9bBpW
         N3JNbYtPri7PhmBeUfaRkXqN1HPMpZVTSY4rrXAW/LFEJjVpkDBvYOXg1dTYa48TfP
         D5vOtEL2SFxCEtfCEhA1zNN/2mlo4BWYjCz8S2hcrEyCty/qC9MOg8mCmaFsRwY3qG
         TPdccTEqa+wWA==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 7/8] Docs/mm/damon/design: Document DAMOS quota auto tuning
Date:   Sun, 12 Nov 2023 19:46:06 +0000
Message-Id: <20231112194607.61399-8-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231112194607.61399-1-sj@kernel.org>
References: <20231112194607.61399-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the DAMOS quota auto tuning feature on the design document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 1f7e0586b5fa..3e1b34f55bb8 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -346,6 +346,17 @@ the weight will be respected are up to the underlying prioritization mechanism
 implementation.
 
 
+.. _damon_design_damos_quotas_auto_tuning:
+
+Aim-oriented Feedback-driven Quotas Auto-tuning
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Automatic feedback-driven quota tuning.  Instead of setting the absolute quota
+value, users can provide feedback about how well DAMOS is achieving their goal.
+If the feedback says DAMOS is still not achieving the goal, DAMOS increases the
+quota.  If DAMOS is over-achieving the goal, DAMOS decreases the quota.
+
+
 .. _damon_design_damos_watermarks:
 
 Watermarks
-- 
2.34.1

