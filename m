Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673207D8DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 06:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345276AbjJ0ESE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 00:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0ESD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 00:18:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01471AA;
        Thu, 26 Oct 2023 21:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698380280; x=1729916280;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VB0nfCH/N7YJT0+H9sBd9b04Zg5nBw9CuKbABzwzJQI=;
  b=BlNUx3WH9xBZuMYgR0raXyPPhaavy+Zzi1wUh5jatIwtZ60FvFzS9dfS
   g/zZKJiIo/20HB1Nw4vhXSzaWyDMjiwuMfTwEiklNJcZVvHwsOV24kio1
   z14w4I9pJtTmP/kuZvhE0I7jS8idJb18f1OhXJ+D3MHJYRi9yp2UEfXy6
   JVV9x8qNkK6ry0SPCfRchi8udqo21n7EsEgmoO1tfF4JMnVEFu2DA14Or
   9Ruj6miPq43cDFf71UGMYGFfewDIPlz9LLxt76zWjfHZOtmZR4s7a+nFB
   rION7Hgn9N4VBDh8BZqfcAaNy7QrC47e4IQ8U+BXrbM8+PKntbxrXNnZs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="390562805"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="390562805"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 21:17:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="794462482"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="794462482"
Received: from yujie-x299.sh.intel.com ([10.239.159.77])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 21:17:57 -0700
From:   Yujie Liu <yujie.liu@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] tracing/kprobes: Fix the description of variable length arguments
Date:   Fri, 27 Oct 2023 12:13:14 +0800
Message-Id: <20231027041315.2613166-1-yujie.liu@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following kernel-doc warnings:

kernel/trace/trace_kprobe.c:1029: warning: Excess function parameter 'args' description in '__kprobe_event_gen_cmd_start'
kernel/trace/trace_kprobe.c:1097: warning: Excess function parameter 'args' description in '__kprobe_event_add_fields'

Refer to the usage of variable length arguments elsewhere in the kernel
code, "@..." is the proper way to express it in the description.

Fixes: 2a588dd1d5d6 ("tracing: Add kprobe event command generation functions")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310190437.paI6LYJF-lkp@intel.com/
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
---
 kernel/trace/trace_kprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a8fef6ab0872..95c5b0668cb7 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1007,7 +1007,7 @@ EXPORT_SYMBOL_GPL(kprobe_event_cmd_init);
  * @name: The name of the kprobe event
  * @loc: The location of the kprobe event
  * @kretprobe: Is this a return probe?
- * @args: Variable number of arg (pairs), one pair for each field
+ * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
  * rather use the kprobe_event_gen_cmd_start() wrapper, which automatically
@@ -1080,7 +1080,7 @@ EXPORT_SYMBOL_GPL(__kprobe_event_gen_cmd_start);
 /**
  * __kprobe_event_add_fields - Add probe fields to a kprobe command from arg list
  * @cmd: A pointer to the dynevent_cmd struct representing the new event
- * @args: Variable number of arg (pairs), one pair for each field
+ * @...: Variable number of arg (pairs), one pair for each field
  *
  * NOTE: Users normally won't want to call this function directly, but
  * rather use the kprobe_event_add_fields() wrapper, which
-- 
2.34.1

