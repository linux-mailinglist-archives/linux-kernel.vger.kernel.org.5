Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467137BF9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjJJLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjJJLjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:39:40 -0400
Received: from out0-209.mail.aliyun.com (out0-209.mail.aliyun.com [140.205.0.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE2299;
        Tue, 10 Oct 2023 04:39:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047198;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---.UxYjvU3_1696937965;
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.UxYjvU3_1696937965)
          by smtp.aliyun-inc.com;
          Tue, 10 Oct 2023 19:39:34 +0800
From:   "Tiwei Bie" <tiwei.btw@antgroup.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org
Cc:     <ayushranjan@google.com>, "Tiwei Bie" <tiwei.btw@antgroup.com>,
        "Chao Yu" <chao@kernel.org>, "Yue Hu" <huyue2@coolpad.com>,
        "Jeffle Xu" <jefflexu@linux.alibaba.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] erofs: fix inode metadata space layout description in documentation
Date:   Tue, 10 Oct 2023 19:39:15 +0800
Message-Id: <20231010113915.436591-1-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xattrs, extents, data inline are _placed after_, not _followed by_ the
corresponding inode. This patch fixes it.

Fixes: fdb0536469cb ("staging: erofs: add document")
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 Documentation/filesystems/erofs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index f200d7874495..57c6ae23b3fc 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -199,7 +199,7 @@ may not. All metadatas can be now observed in two different spaces (views):
                                         |                  |
                                         |__________________| 64 bytes
 
-    Xattrs, extents, data inline are followed by the corresponding inode with
+    Xattrs, extents, data inline are placed after the corresponding inode with
     proper alignment, and they could be optional for different data mappings.
     _currently_ total 5 data layouts are supported:
 
-- 
2.34.1

