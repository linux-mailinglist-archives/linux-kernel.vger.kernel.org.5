Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C485799C6C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjIJDlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjIJDk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:40:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E9619E;
        Sat,  9 Sep 2023 20:40:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D67FC433C8;
        Sun, 10 Sep 2023 03:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694317254;
        bh=nsy3XKNul10yj7Y4C7UdRuVcXMAYGZfrN5/ruA9B7bY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yhf4w8t1fRuZJ4OQ8rFWDO3TDcY+USKFEptrVl74C2KL5spB2Zm7tlR/98C/0sNNX
         rhds8nFJ0m+cI7S0M+YwFjbizIG1KlgBowZHNZwfOnTvg1oa99D1XAl9yxeJxHhcey
         l9O9mnGh9UuVDRJHIy/L80hW5C6JnQg8UT/6pyDzRJOvu1tCEwuR8TCMjmHOw/6z2J
         dY7f3eZ15EVtJUXM2gAt8rSYxhJUALgBNhJtxzEC4Pu0Axg7XISKpMseJNSlxYTM0N
         HRTMABvBxWGayiSMvVwnCtijn7zba+kdp3uMX4qtFCl6mmh4DCe+tofNnubO2Twi8L
         lAXzGYDSUTY+g==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 5/8] Docs/mm/damon/design: document DAMOS apply intervals
Date:   Sun, 10 Sep 2023 03:40:45 +0000
Message-Id: <20230910034048.59191-6-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910034048.59191-1-sj@kernel.org>
References: <20230910034048.59191-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update DAMON design doc to explain about DAMOS apply intervals.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 18e9b42673f8..1f7e0586b5fa 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -259,7 +259,8 @@ works, DAMON provides a feature called Data Access Monitoring-based Operation
 Schemes (DAMOS).  It lets users specify their desired schemes at a high
 level.  For such specifications, DAMON starts monitoring, finds regions having
 the access pattern of interest, and applies the user-desired operation actions
-to the regions as soon as found.
+to the regions, for every user-specified time interval called
+``apply_interval``.
 
 
 .. _damon_design_damos_action:
-- 
2.25.1

