Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF5F7A0FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjINV3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:29:12 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101B01FD2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1694726946; bh=BV4XLAX1qRKE3joosWKkdrstGC2Xef+ew4wOGJWVraQ=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=MXB3N8iV8fS/QGP7iFxr4/TBKCnOBXtW/For8X4ZgL1ZvyTubd5UHQHDUcbVQWVD5
         TERE2lBRizgX1mSjo9pyq6StmgkLVxsy1WX+APGm7Dj4BDpG3LTlmKrCbnleRgcmPL
         hkUqfyWh9JBengT1g5CtJ/A77X02zeQTuQollVeo=
Received: by b221-5.in.mailobj.net [192.168.90.25] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 14 Sep 2023 23:29:05 +0200 (CEST)
X-EA-Auth: OlP37/JzYx+th6M9PN5TMQDxD5U3rvxw4B/X0nxXCCiTZeq+s7qGkiiORs2Pi13LH5cx3wSKmFm8RAU0ykmSe2U9dLGW9MI7
Date:   Fri, 15 Sep 2023 02:59:02 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     linux-kernel@vger.kernel.org, rostedt@goodmis.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        ivan.orlov0322@gmail.com, skhan@linuxfoundation.org,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] tracing: Fix minor typos in samples header
Message-ID: <ZQN7HiaghPYu4sAl@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following minor corrections in the comments section of the trace
events sample header file.

   - There are 6 parts of the TRACE_EVENT macro instead of 5 (name,
     TP_PROTO, TP_ARGS, TP_STRUCT, TP_fast_assign, TP_printk).

   - The example variable for __field_struct type should be the
     variable name instead of the variable.

   - Improve closing brace alignment to improve readability.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 samples/trace_events/trace-events-sample.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 1c6b843b8c4e..551ecad212c8 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -61,7 +61,7 @@
 #include <linux/tracepoint.h>

 /*
- * The TRACE_EVENT macro is broken up into 5 parts.
+ * The TRACE_EVENT macro is broken up into 6 parts.
  *
  * name: name of the trace point. This is also how to enable the tracepoint.
  *   A function called trace_foo_bar() will be created.
@@ -93,7 +93,7 @@
  *
  *         __field_struct(struct bar, foo)
  *
- *         __entry->bar.x = y;
+ *         __entry->foo.x = y;

  *   __array: There are three fields (type, name, size). The type is the
  *         type of elements in the array, the name is the name of the array.
@@ -410,7 +410,7 @@ TRACE_EVENT_CONDITION(foo_bar_with_cond,

 	TP_STRUCT__entry(
 		__string(	foo,    foo		)
-		__field(	int,	bar			)
+		__field(	int,	bar		)
 	),

 	TP_fast_assign(
--
2.39.2



