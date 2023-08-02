Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6C576D998
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjHBVct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjHBVcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:32:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AFC1BC7;
        Wed,  2 Aug 2023 14:32:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F060961B30;
        Wed,  2 Aug 2023 21:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12A5C433C7;
        Wed,  2 Aug 2023 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691011950;
        bh=hZi4JMj8VgF69C/0cI6pgbuOwe9TusEzinxMwIrTwRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8XK8bu8QUF7j5mokMLp4WthiMSkYqCy1cY7HO0GbwC4arQZLodLipZSG5aSuS0s0
         a3brhyuqU3Czlf8mRzp//Te0l/DLvozy4eCLuUXIeVuGhH9oAjBoGX4Kgw2glbMFfr
         r8ZRcAJavf+7zMP6kgLEFRY5NZlrtUIdQ966iL4IIWKYkl/wj4g46mtFXYANURfcCv
         5ZKTfkfycATaFOVl56xgsVul41YgKaWOm/C1gG2UuYJBSUjCDXbBaSNr7qoX6bnPcX
         aoMTHxcWDg4YbhqjwA9oiUrVf6TTHyEEk+ESpebMbe+tARmMq//AJ+I2leTRzzfyls
         z6yzxG2O4nt8A==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] Docs/ABI/damon: update for tried_regions/total_bytes
Date:   Wed,  2 Aug 2023 21:32:20 +0000
Message-Id: <20230802213222.109841-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802213222.109841-1-sj@kernel.org>
References: <20230802213222.109841-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the DAMON ABI document for newly added
schemes/.../tried_regions/total_bytes file and the
update_schemes_tried_bytes command.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 2744f21b5a6b..3d9aaa1cafa9 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -29,8 +29,10 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		file updates contents of schemes stats files of the kdamond.
 		Writing 'update_schemes_tried_regions' to the file updates
 		contents of 'tried_regions' directory of every scheme directory
-		of this kdamond.  Writing 'clear_schemes_tried_regions' to the
-		file removes contents of the 'tried_regions' directory.
+		of this kdamond.  Writing 'update_schemes_tried_bytes' to the
+		file updates only '.../tried_regions/total_bytes' files of this
+		kdamond.  Writing 'clear_schemes_tried_regions' to the file
+		removes contents of the 'tried_regions' directory.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
@@ -317,6 +319,13 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Reading this file returns the number of the exceed events of
 		the scheme's quotas.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/total_bytes
+Date:		Jul 2023
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Reading this file returns the total amount of memory that
+		corresponding DAMON-based Operation Scheme's action has tried
+		to be applied.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/tried_regions/<R>/start
 Date:		Oct 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.25.1

