Return-Path: <linux-kernel+bounces-162192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D956E8B577E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D8C1C21925
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D017E54745;
	Mon, 29 Apr 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jreTv6z5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7D537E0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392562; cv=none; b=RIYYfjFXWpH18/WpGwpvwwIy/QkOdCRO7ngr7Oj1/st0t8ycrRjEDzr4iIr7itYe8CcT9AQ3e8eAZAe8QKhFMCf/NXTzuEgjTkLLwUgIiklMT8J14vsgMKJqEv/XXny/uUit9XVtTmLTnwE+icDbw/6q7ei1i3NmMJxwxUCqNXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392562; c=relaxed/simple;
	bh=ni7xzfycKKP1MKVU8EmsUqb3361Wz7LPiZp+v1kH+eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zo6gRadhUwG1yJ4MLyVoCDWJeOx/sMwlPYuuZkEhRg90I7xOIQoS0DP4H7ZOw4/iwNj3FQrmYnYZXrxR0lsP3Nc8uUBGlvHU3C0sN0qEOmbw0Bw0PDWXcI1+A1W7eKx/1StAEesLLew7zStrqGVq3XwEFC6A3LRkMQcUWmTdXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jreTv6z5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714392561; x=1745928561;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ni7xzfycKKP1MKVU8EmsUqb3361Wz7LPiZp+v1kH+eQ=;
  b=jreTv6z5Lqtst1K42qZvld9Fa+GCShFYJs7t3IXdihuQZDFqk7gRM3X3
   izeARhTxnCyL4zhBbbki6qlI8/6zS3ww6Jvknm12ZOViygSYi/KsUeg2C
   BiXbKgv1B/R+tsqmT70IYR4aKI+FbKOS+lu57WHyw/zEUoPqkHylz+dSW
   BqUKdi1hH4OEFndeY0rUHoF476nRBWVStSavAHQWGRd4y4FvOIzud+D0Z
   UwEsqJSP/zFfFcMVKlNnGuD/lCNM4tTEu/0ZjMBwMy2k5B80/rVKkpjjM
   Q7xfyouwPaJlw1TNmvR6GsOa6gsabs52nxzZwLTZhwQTRwwUwikaDYIMQ
   A==;
X-CSE-ConnectionGUID: f6oHwzDtTAC26JueOoaVsQ==
X-CSE-MsgGUID: Tq31DkfqS7an3uRoxS4eiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9908216"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9908216"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 05:09:21 -0700
X-CSE-ConnectionGUID: 9kqqu18kRXa+a8BUdZFOEA==
X-CSE-MsgGUID: ZvehNrR7T0+syPKBda//Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26166609"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmviesa010.fm.intel.com with ESMTP; 29 Apr 2024 05:09:18 -0700
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mikhail Lappo <miklelappo@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 02/14] stm class: Add source type
Date: Mon, 29 Apr 2024 15:08:56 +0300
Message-ID: <20240429120908.3723458-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
References: <20240429120908.3723458-1-alexander.shishkin@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Lappo <miklelappo@gmail.com>

Currently kernel HW tracing infrastrtucture and specifically its SyS-T
part treats all source data in the same way. Treating and encoding
different trace data sources differently might allow decoding software
to make use of e.g. ftrace event ids by converting them to a SyS-T
message catalog.

The solution is to keep source type stored within stm_source_data
structure to allow different handling by stm output/protocol.
Currently we only differentiate between STM_USER and STM_FTRACE sources.

Signed-off-by: Mikhail Lappo <miklelappo@gmail.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/stm/console.c   |  1 +
 drivers/hwtracing/stm/ftrace.c    |  1 +
 drivers/hwtracing/stm/heartbeat.c |  1 +
 include/linux/stm.h               | 12 ++++++++++++
 4 files changed, 15 insertions(+)

diff --git a/drivers/hwtracing/stm/console.c b/drivers/hwtracing/stm/console.c
index a00f65e21747..097a00ac43a7 100644
--- a/drivers/hwtracing/stm/console.c
+++ b/drivers/hwtracing/stm/console.c
@@ -22,6 +22,7 @@ static struct stm_console {
 	.data	= {
 		.name		= "console",
 		.nr_chans	= 1,
+		.type		= STM_USER,
 		.link		= stm_console_link,
 		.unlink		= stm_console_unlink,
 	},
diff --git a/drivers/hwtracing/stm/ftrace.c b/drivers/hwtracing/stm/ftrace.c
index 3bb606dfa634..a7cea7ea0163 100644
--- a/drivers/hwtracing/stm/ftrace.c
+++ b/drivers/hwtracing/stm/ftrace.c
@@ -23,6 +23,7 @@ static struct stm_ftrace {
 	.data	= {
 		.name		= "ftrace",
 		.nr_chans	= STM_FTRACE_NR_CHANNELS,
+		.type		= STM_FTRACE,
 		.link		= stm_ftrace_link,
 		.unlink		= stm_ftrace_unlink,
 	},
diff --git a/drivers/hwtracing/stm/heartbeat.c b/drivers/hwtracing/stm/heartbeat.c
index 81d7b21d31ec..e9496fe97baa 100644
--- a/drivers/hwtracing/stm/heartbeat.c
+++ b/drivers/hwtracing/stm/heartbeat.c
@@ -78,6 +78,7 @@ static int stm_heartbeat_init(void)
 		}
 
 		stm_heartbeat[i].data.nr_chans	= 1;
+		stm_heartbeat[i].data.type	= STM_USER;
 		stm_heartbeat[i].data.link	= stm_heartbeat_link;
 		stm_heartbeat[i].data.unlink	= stm_heartbeat_unlink;
 		hrtimer_init(&stm_heartbeat[i].hrtimer, CLOCK_MONOTONIC,
diff --git a/include/linux/stm.h b/include/linux/stm.h
index 3b22689512be..2fcbef9608f6 100644
--- a/include/linux/stm.h
+++ b/include/linux/stm.h
@@ -30,6 +30,16 @@ enum stp_packet_flags {
 	STP_PACKET_TIMESTAMPED	= 0x2,
 };
 
+/**
+ * enum stm_source_type - STM source driver
+ * @STM_USER: any STM trace source
+ * @STM_FTRACE: ftrace STM source
+ */
+enum stm_source_type {
+	STM_USER,
+	STM_FTRACE,
+};
+
 struct stp_policy;
 
 struct stm_device;
@@ -106,6 +116,7 @@ struct stm_source_device;
  * @name:	device name, will be used for policy lookup
  * @src:	internal structure, only used by stm class code
  * @nr_chans:	number of channels to allocate
+ * @type:	type of STM source driver represented by stm_source_type
  * @link:	called when this source gets linked to an STM device
  * @unlink:	called when this source is about to get unlinked from its STM
  *
@@ -117,6 +128,7 @@ struct stm_source_data {
 	struct stm_source_device *src;
 	unsigned int		percpu;
 	unsigned int		nr_chans;
+	unsigned int		type;
 	int			(*link)(struct stm_source_data *data);
 	void			(*unlink)(struct stm_source_data *data);
 };
-- 
2.43.0


