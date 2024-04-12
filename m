Return-Path: <linux-kernel+bounces-142724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EF08A2F67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65DD1C20F50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257E782888;
	Fri, 12 Apr 2024 13:29:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B13824A7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928572; cv=none; b=AUg6CKsza3Ez4LCCDl/z+67sH1f20kyy+JbsjAswCk8Woquu1oBRpcgs6tu4mciacFup3qKyBaRcmdoayqESAq7d3RK02/bcLQ9j4W4/Z29PLNUXdL/NMR6zB9Zmkk8AekOiFTQ6bNz6SxKd8xkEX7Lv1uPBQuHOPrOOTYnuilA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928572; c=relaxed/simple;
	bh=0TOkjBaTj5it68Im/6giqJjimq/460uMEJuzqUrd+Zk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Vnmuyvt6uvaE9JdTjDJ/2xnoA83Of/pYhw+prKWzK1s79JWAFrpWaCn4Y2QxwCeXM+WNSV3PDnkmvz/SyDRboBhLiH48rE+R4d6tearFkMN+61k4sijcWDSANxSzQURpZY8p2P0QItd+JY6vfn0LJk1obITm6MfH3W4HR9WsD58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4851BC2BD10;
	Fri, 12 Apr 2024 13:29:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rvH0o-000000012pu-0YH3;
	Fri, 12 Apr 2024 09:32:14 -0400
Message-ID: <20240412133213.994663842@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 12 Apr 2024 09:31:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Prasad Pandit <pjp@fedoraproject.org>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: [for-linus][PATCH 2/4] tracing: Fix FTRACE_RECORD_RECURSION_SIZE Kconfig entry
References: <20240412133152.723632549@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Prasad Pandit <pjp@fedoraproject.org>

Fix FTRACE_RECORD_RECURSION_SIZE entry, replace tab with
a space character. It helps Kconfig parsers to read file
without error.

Link: https://lore.kernel.org/linux-trace-kernel/20240322121801.1803948-1-ppandit@redhat.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 773c16705058 ("ftrace: Add recording of functions that caused recursion")
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..47345bf1d4a9 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -965,7 +965,7 @@ config FTRACE_RECORD_RECURSION
 
 config FTRACE_RECORD_RECURSION_SIZE
 	int "Max number of recursed functions to record"
-	default	128
+	default 128
 	depends on FTRACE_RECORD_RECURSION
 	help
 	  This defines the limit of number of functions that can be
-- 
2.43.0



