Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F14B804982
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 06:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344285AbjLEFxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 00:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344284AbjLEFxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 00:53:36 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D76116
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 21:53:42 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4SkqTX6GY7zQ66
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:53:36 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4SkqTX2RBRzB5NLQ
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:53:36 +0800 (CST)
Received: from mxct.zte.com.cn (unknown [192.168.251.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4SkqTS6nF9z5B14c
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:53:32 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4SkqTG0zc9z4xKRy;
        Tue,  5 Dec 2023 13:53:22 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl2.zte.com.cn with SMTP id 3B55rH00034082;
        Tue, 5 Dec 2023 13:53:17 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp05[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 5 Dec 2023 13:53:19 +0800 (CST)
Date:   Tue, 5 Dec 2023 13:53:19 +0800 (CST)
X-Zmail-TransId: 2b07656ebacfffffffffd6f-81e38
X-Mailer: Zmail v1.0
Message-ID: <202312051353196253358@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>, <cl@linux.com>
Cc:     <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <jiang.xuexin@zte.com.cn>,
        <fan.yu9@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBkb2NzOiBBQkk6IHVwZGF0ZSBwZXJtaXNzaW9uIGRlc2NyaXB0aW9ucyBmb3Igc2xhYiBwYWdlIG9yZGVy?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3B55rH00034082
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 656EBADF.000/4SkqTX6GY7zQ66
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fan Yu <fan.yu9@zte.com.cn>

The page allocation order is now read-only, and cannot be 
changed by /sys/kernel/slab/<cache>/order file at run time,
see the following commit:

32a6f409b693 ("mm, slub: remove runtime allocation order changes")

But the ABI documetation have not been modified along with the code,
so they need to be updated, which will help readers better understand
the code.

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 Documentation/ABI/testing/sysfs-kernel-slab | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
index cd5fb8fa3ddf..8f0fc1cb3dc0 100644
--- a/Documentation/ABI/testing/sysfs-kernel-slab
+++ b/Documentation/ABI/testing/sysfs-kernel-slab
@@ -342,15 +342,14 @@ Contact:	Pekka Enberg <penberg@cs.helsinki.fi>,
 		Christoph Lameter <cl@linux-foundation.org>
 Description:
 		The order file specifies the page order at which new slabs are
-		allocated.  It is writable and can be changed to increase the
-		number of objects per slab.  If a slab cannot be allocated
-		because of fragmentation, SLUB will retry with the minimum order
-		possible depending on its characteristics.
+		allocated. It is read-only and cannot be changed at run time.
+		If a slab cannot be allocated because of fragmentation, SLUB
+		will retry with the minimum order possible depending on
+		its characteristics.

 		When debug_guardpage_minorder=N (N > 0) parameter is specified
 		(see Documentation/admin-guide/kernel-parameters.rst), the minimum possible
-		order is used and this sysfs entry can not be used to change
-		the order at run time.
+		order is used.

 What:		/sys/kernel/slab/<cache>/order_fallback
 Date:		April 2008
-- 
2.25.1
