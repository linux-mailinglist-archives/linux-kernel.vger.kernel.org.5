Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805957D8D0E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 04:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbjJ0CNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 22:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0CNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 22:13:11 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4A23C194;
        Thu, 26 Oct 2023 19:13:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 20EFA6027FD55;
        Fri, 27 Oct 2023 10:13:06 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?power:=20swap:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=980=E2=80=99=20values=20from=20ret?=
Date:   Fri, 27 Oct 2023 10:13:03 +0800
Message-Id: <20231027021303.26187-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ret 'is first assigned a value and then used, it does not need to be
assigned at definition time.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/power/swap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 90bb583c57bf7..32e8cb6ceaea4 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -679,7 +679,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
                           unsigned int nr_to_write)
 {
 	unsigned int m;
-	int ret = 0;
+	int ret;
 	int nr_pages;
 	int err2;
 	struct hib_bio_batch hb;
@@ -1060,7 +1060,7 @@ static int load_image(struct swap_map_handle *handle,
                       unsigned int nr_to_read)
 {
 	unsigned int m;
-	int ret = 0;
+	int ret;
 	ktime_t start;
 	ktime_t stop;
 	struct hib_bio_batch hb;
@@ -1166,7 +1166,7 @@ static int load_image_lzo(struct swap_map_handle *handle,
                           unsigned int nr_to_read)
 {
 	unsigned int m;
-	int ret = 0;
+	int ret;
 	int eof = 0;
 	struct hib_bio_batch hb;
 	ktime_t start;
-- 
2.18.2

