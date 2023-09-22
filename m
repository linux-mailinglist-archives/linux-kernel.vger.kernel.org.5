Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751BC7AB777
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbjIVRcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjIVRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:32:00 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBBBCCA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:31:15 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id jjzlq1mvsWkeLjjzlquvzJ; Fri, 22 Sep 2023 19:31:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695403873;
        bh=0c+1nrtaYzzyJr/TMUP01Cfy/oTbrxiF1JN1eoAupD0=;
        h=From:To:Cc:Subject:Date;
        b=FoJEE5rScCw656R799hUGXQbCc58OWjIa5E8OZvqmu6yTdTIQQhNJUyZKtGbJahLj
         uGzKNhw2pvojdCk1iB0lsqaf59t160v76sLLD7JIoDichUPuLplCYAc9iTMSgfBkhk
         VXxnBjUqMaNNu5BH75vVfaovAz9m5EAS9EDxpJ3h3GZr4IthvKlZpSzuD6SL9FLbRn
         n+T3HtE0AwUzD56cY/K5qxOY7cUCwwgz9Ij7yqJECG65djgye7BdOXRMQIChjXrZ/4
         p1aGiDCGlFekZW3M0xGCc8cTEh6Cfh97Daz20o2ZdOqwBjf/JRaWH8whK34h2tqYnC
         2zwEcPXPMRB6g==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 22 Sep 2023 19:31:13 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/3] fs: dlm: Fix some issues related to a buffer in dlm_create_debug_file()
Date:   Fri, 22 Sep 2023 19:31:07 +0200
Message-Id: <cover.1695403360.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this serie is to remove a warning when building with W=1.
(details in patch 2)

Patch 1 is a preparation step. It is a no-op. The generated code is the same.
Patch 2 is the real fix.
Patch 3 is an additionnal clean-up.

Christophe JAILLET (3):
  fs: dlm: Simplify buffer size computation in dlm_create_debug_file()
  fs: dlm: Fix the size of a buffer in dlm_create_debug_file()
  fs: dlm: Remove some useless memset()

 fs/dlm/debug_fs.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

-- 
2.34.1

