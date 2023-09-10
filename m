Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC9799C6E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbjIJDl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344260AbjIJDlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:41:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAC119E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 20:40:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF92C43395;
        Sun, 10 Sep 2023 03:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694317256;
        bh=eynGbeHbTWCoAAQx22o6QCyTrP+ceLiyJPZLaUvkSBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8Q9uAD8o9PcqFqVFXtN8GWHciJp1oKA9CHvzkSpgw2OPWsaRycMdldPI1RynQ5wX
         n3N+eRILhlbnDGLvA8HdsQknJrO7Yo5eOR6l2ePhuVATnpcYyhgx59gEiewNFrOVaB
         G7Xy+AuwGCx0+pXOdCLAuicPvGAqLNGAR1zzACOgQ+DBqMaRkLOWe+t7Xme9gU04WO
         91IxlBNu0x8dHZrcbT6+TuwF2Jh7/H819njkFGH23Xml9mRdyUU0Wn7ffzt7rkujyp
         omII1CcYj4RI/3WxnO4vlWDtMvA/Ub6lqgD1orJJPnkmG4/OlkdKgQmZPNzXEtI8zf
         m+eV7d+nCJ4VQ==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 8/8] Docs/ABI/damon: update for DAMOS apply intervals
Date:   Sun, 10 Sep 2023 03:40:48 +0000
Message-Id: <20230910034048.59191-9-sj@kernel.org>
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

Update DAMON ABI document for the newly added DAMON sysfs file for DAMOS
apply intervals (apply_interval_us file).

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 420b30f09cf0..b35649a46a2f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -151,6 +151,13 @@ Contact:	SeongJae Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the action
 		of the scheme.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/apply_interval_us
+Date:		Sep 2023
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing a value to this file sets the action apply interval of
+		the scheme in microseconds.  Reading this file returns the
+		value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/access_pattern/sz/min
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.25.1

