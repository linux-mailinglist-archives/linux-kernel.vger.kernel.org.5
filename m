Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC974811DED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjLMTDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLMTDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:03:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B5899
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 11:03:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F30CC433CA;
        Wed, 13 Dec 2023 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702494224;
        bh=J/iaoXT0rpbsPwoHcTcG3htMVyXBLicckUfUlL8eBn4=;
        h=From:To:Cc:Subject:Date:From;
        b=A2fmWay4DvFOhNXj+ErJHs9KGh6CL0CiA9Rrig1Af/yTt6bVBxPQRh3WrazeExAdt
         BwpZLqi4FvCUXp0UtWXdHGJQHwjisx9TLgsGXO3lmE3tVnO9XyJb6PNLXhkWjlcntK
         bTFDo6HmybRrFTlD+9FPg12pm5Eit9PYTF8sTDMC05N2Ax+Vf4WhFZ2L8srfD6970U
         pqKRiTHVjV2R41pjqYebWf3KTZ2vJTG4MJJ7+81YhRPoiaF6FfYzLDgUS1sUujPjnY
         iCXltYXanMEKj86HlbuGUvlL4WEIMKIvbFgXeZlOM/VXOlxv2dUm4aZIYzjfUGFQzo
         YqCgRsTuuTqrw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] mm/damon: misc updates for 6.8
Date:   Wed, 13 Dec 2023 19:03:32 +0000
Message-Id: <20231213190338.54146-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Update comments, tests, and documents for DAMON aiming to be merged in
the next merge window for Linux v6.8.

SeongJae Park (6):
  mm/damon: update email of SeongJae
  mm/damon/core-test: test max_nr_accesses overflow caused
    divide-by-zero
  Docs/mm/damon/design: place execution model and data structures at the
    beginning
  Docs/admin-guide/mm/damon/usage: update context directory section
    label
  Docs/admin-guide/mm/damon/usage: add links to sysfs files hierarchy
  Docs/admin-guide/mm/damon/usage: use a list for 'state' sysfs file
    input commands

 Documentation/admin-guide/mm/damon/usage.rst | 123 +++++++++++--------
 Documentation/mm/damon/design.rst            |  24 ++--
 include/linux/damon.h                        |   2 +-
 mm/damon/core-test.h                         |  13 +-
 mm/damon/core.c                              |   2 +-
 mm/damon/dbgfs-test.h                        |   2 +-
 mm/damon/dbgfs.c                             |   2 +-
 mm/damon/modules-common.c                    |   2 +-
 mm/damon/vaddr-test.h                        |   2 +-
 mm/damon/vaddr.c                             |   2 +-
 10 files changed, 106 insertions(+), 68 deletions(-)


base-commit: def619f2545d0286e6f4ed6c09fac8f863a70da1
-- 
2.34.1

