Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487997676E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjG1USo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjG1USa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:18:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B20423B;
        Fri, 28 Jul 2023 13:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E462E621FB;
        Fri, 28 Jul 2023 20:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5926C433C7;
        Fri, 28 Jul 2023 20:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690575508;
        bh=hZi4JMj8VgF69C/0cI6pgbuOwe9TusEzinxMwIrTwRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyGP4+cb8vPs1cOqldkfI60vHEt6GW58BND6QKRpWnpRyPcnJjNzbMiHvKbL9sr2f
         Gd89fZUVgnWzXVJE8Ov8HLUGJen9Lw5jd0RX+XIcilGNjDfRSNkWXm209E2KRuCtPa
         F8UY4Eqc6arjvEGTVzBSN1mw2IhBvPs0jAE5IqeK9kzyWeAGdTwB3M2ErhdHYFsl4G
         WV9PSZKsagHHQaKljpGc9LWz6H+qSthGrI3dMvNDLEQyaQblO9+IIv3nDwE6+65d83
         cboN3H1SPsHUB2yduqbBqlYlsgiU5j7gNat2nzF1OVPsWcoAlJN+yhrt+M1hPRY6Y1
         cPpjkWwWV1JSQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/5] Docs/ABI/damon: update for tried_regions/total_bytes
Date:   Fri, 28 Jul 2023 20:18:16 +0000
Message-Id: <20230728201817.70602-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728201817.70602-1-sj@kernel.org>
References: <20230728201817.70602-1-sj@kernel.org>
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

