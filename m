Return-Path: <linux-kernel+bounces-30687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65253832308
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 02:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B619286C38
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E288A1C15;
	Fri, 19 Jan 2024 01:36:20 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F25EDF;
	Fri, 19 Jan 2024 01:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705628180; cv=none; b=Cm3io+4BMM6tvXu1j4CkV1ew1a8w9qnQc54NyC30/ar4gEI0L0vBN1W9HenkEzzXbZFs3R3vjw13zz9aLQLgeDblU5pWndfKnh/NlXJjVDIdlF6LCtmbqPwfnUd+wm/Zs79eqWs02bi7lm4g42SMc6qNs7gJa98vpITcmXRYi5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705628180; c=relaxed/simple;
	bh=gvMic+SUaGsheZzeoA0LsnGF1GeRG6IfE+uPM9oLPYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tTeHpfek5Rbn/nKQFAhOy9Va5bseWzLWOqSROJNaTgkjvHGrQUvyFlDv828v0tiCJAmp99Z64QW/ee8x4LD48IX/weZxqgGfGxylk70GGzXeJ3hMBrwFFJjgXPp+JjdI3EPHw6FrJAneZ5GpzgI9TQS0zdtJcVmVKUnBICNYKKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4TGMbw2BPpz1V4MQ;
	Fri, 19 Jan 2024 09:34:36 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 3585418001A;
	Fri, 19 Jan 2024 09:36:16 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 09:36:15 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH 3/3] Documentation: tracing: add new type 'pd' and 'pD' for kprobe
Date: Fri, 19 Jan 2024 09:38:48 +0800
Message-ID: <20240119013848.3111364-4-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240119013848.3111364-1-yebin10@huawei.com>
References: <20240119013848.3111364-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)

Similar to printk() 'pd' is for print dentry's name, and 'pD' is
for print file's name.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 Documentation/trace/kprobetrace.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index bf9cecb69fc9..c46c5d0a25e6 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -58,7 +58,8 @@ Synopsis of kprobe_events
   NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
   FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
 		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
-		  (x8/x16/x32/x64), "char", "string", "ustring", "symbol", "symstr"
+		  (x8/x16/x32/x64), VFS layer common type(pd/pD) for print
+                  file name, "char", "string", "ustring", "symbol", "symstr"
                   and bitfield are supported.
 
   (\*1) only for the probe on function entry (offs == 0). Note, this argument access
-- 
2.31.1


