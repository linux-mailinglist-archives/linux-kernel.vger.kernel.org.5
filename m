Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF517AD5A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 12:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjIYKNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 06:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjIYKNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:13:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D76DC2697;
        Mon, 25 Sep 2023 03:02:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C943ADA7;
        Mon, 25 Sep 2023 03:02:45 -0700 (PDT)
Received: from [10.57.36.242] (unknown [10.57.36.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C39193F59C;
        Mon, 25 Sep 2023 03:02:06 -0700 (PDT)
Message-ID: <cee6d5cd-e15b-3bb1-f867-de467d96d6b5@arm.com>
Date:   Mon, 25 Sep 2023 11:02:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, zhengyejian1@huawei.com
From:   Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] tracing: document buffer_size_kb more precisely
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

buffer_size_kb no longer shows the requested amount, but the one that
is actually used internally for the ring buffer.

commit 6d98a0f2ac3c ("tracing: Set actual size after ring buffer resize")
changed the sysfs behavior such that value read will always show the
actual size, while previously it showed the size that was requested
through the sysfs interface, even if it was rounded up to fulfill
the request.
So the documentation can state that more precisely now.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 Documentation/trace/ftrace.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 23572f6697c0..2e066b3b6edc 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -191,7 +191,7 @@ of ftrace. Here is a list of some of the key files:
 	A few extra pages may be allocated to accommodate buffer management
 	meta-data. If the last page allocated has room for more bytes
 	than requested, the rest of the page will be used,
-	making the actual allocation bigger than requested or shown.
+	making the actual allocation bigger than requested.
 	( Note, the size may not be a multiple of the page size
 	due to buffer management meta-data. )
 
-- 
2.34.1
