Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB7E75C062
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjGUHuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjGUHt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:49:58 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4B119AD;
        Fri, 21 Jul 2023 00:49:54 -0700 (PDT)
X-UUID: ff14eda7f0934741a23db9006c625495-20230721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.28,REQID:089c6898-c99c-4694-97ea-33c64382b269,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-INFO: VERSION:1.1.28,REQID:089c6898-c99c-4694-97ea-33c64382b269,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-META: VersionHash:176cd25,CLOUDID:2e61e187-44fb-401c-8de7-6a5572f1f5d5,B
        ulkID:2307211549211PU76SGO,BulkQuantity:1,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: ff14eda7f0934741a23db9006c625495-20230721
X-User: guodongtai@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
        (envelope-from <guodongtai@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1614632383; Fri, 21 Jul 2023 15:49:40 +0800
From:   George Guo <guodongtai@kylinos.cn>
To:     masahiroy@kernel.org, nathan@kernel.org, martin.lau@linux.dev,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] btf: Remove unnecessary header file inclusions
Date:   Fri, 21 Jul 2023 15:50:07 +0800
Message-Id: <20230721075007.4100863-1-guodongtai@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary header file inclusions in btf.c

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 kernel/bpf/btf.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 817204d53372..e5ea729ba6b8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1,20 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2018 Facebook */
 
-#include <uapi/linux/btf.h>
-#include <uapi/linux/bpf.h>
-#include <uapi/linux/bpf_perf_event.h>
-#include <uapi/linux/types.h>
-#include <linux/seq_file.h>
-#include <linux/compiler.h>
-#include <linux/ctype.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
 #include <linux/anon_inodes.h>
-#include <linux/file.h>
-#include <linux/uaccess.h>
-#include <linux/kernel.h>
-#include <linux/idr.h>
 #include <linux/sort.h>
 #include <linux/bpf_verifier.h>
 #include <linux/btf.h>
@@ -22,9 +9,6 @@
 #include <linux/bpf_lsm.h>
 #include <linux/skmsg.h>
 #include <linux/perf_event.h>
-#include <linux/bsearch.h>
-#include <linux/kobject.h>
-#include <linux/sysfs.h>
 
 #include <net/netfilter/nf_bpf_link.h>
 
-- 
2.34.1

