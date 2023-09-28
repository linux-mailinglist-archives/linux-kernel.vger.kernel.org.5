Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110F67B1871
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjI1Kn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjI1Kn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:43:56 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB1180;
        Thu, 28 Sep 2023 03:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LUmEFVgYyEJd0Y33BFcDH3/Ea1qs67OuZS/yeIuLfWU=;
  b=BazJQIymVfr5MFVaqLBBi67mhojX2DO/rPD82cWOq356vfv2M/l0jLWg
   oJ8FlNpA9Cx7ICaWWIlXMPfunCGOV7yT7ruP/0K49sedyoeoT91AsWbD0
   wLJs2Xm5jAJ9PUEhj0qWza4Y6JkUwvHXr+1qcgIDUt7bFiygz+tH6V/OV
   4=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,183,1694728800"; 
   d="scan'208";a="67216334"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 12:43:50 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     kernel-janitors@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/eprobe: drop unneeded breaks
Date:   Thu, 28 Sep 2023 12:43:34 +0200
Message-Id: <20230928104334.41215-1-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop break after return.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 kernel/trace/trace_eprobe.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 72714cbf475c..03c851f57969 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -788,12 +788,9 @@ find_and_get_event(const char *system, const char *event_name)
 		name = trace_event_name(tp_event);
 		if (!name || strcmp(event_name, name))
 			continue;
-		if (!trace_event_try_get_ref(tp_event)) {
+		if (!trace_event_try_get_ref(tp_event))
 			return NULL;
-			break;
-		}
 		return tp_event;
-		break;
 	}
 	return NULL;
 }

