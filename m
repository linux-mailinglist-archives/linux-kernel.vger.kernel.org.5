Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B637907AD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352120AbjIBLv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352077AbjIBLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35A710F8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3513B82782
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2E0C433BB;
        Sat,  2 Sep 2023 11:51:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qcP9s-000K1D-1Y;
        Sat, 02 Sep 2023 07:51:20 -0400
Message-ID: <20230902115120.303318989@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 02 Sep 2023 07:50:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [for-linus][PATCH 11/11] tracing/filters: Fix coding style issues
References: <20230902115035.786076237@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Schneider <vschneid@redhat.com>

Recent commits have introduced some coding style issues, fix those up.

Link: https://lkml.kernel.org/r/20230901151039.125186-5-vschneid@redhat.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 09b4733a2933..33264e510d16 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1360,7 +1360,7 @@ int filter_assign_type(const char *type)
 			return FILTER_DYN_STRING;
 		if (strstr(type, "cpumask_t"))
 			return FILTER_CPUMASK;
-		}
+	}
 
 	if (strstr(type, "__rel_loc") && strstr(type, "char"))
 		return FILTER_RDYN_STRING;
@@ -1731,7 +1731,9 @@ static int parse_pred(const char *str, void *data,
 		maskstart = i;
 
 		/* Walk the cpulist until closing } */
-		for (; str[i] && str[i] != '}'; i++);
+		for (; str[i] && str[i] != '}'; i++)
+			;
+
 		if (str[i] != '}') {
 			parse_error(pe, FILT_ERR_MISSING_BRACE_CLOSE, pos + i);
 			goto err_free;
-- 
2.40.1
