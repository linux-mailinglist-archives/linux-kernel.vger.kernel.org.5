Return-Path: <linux-kernel+bounces-82154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DB4868002
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E9C1F2AD4E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714CD12F586;
	Mon, 26 Feb 2024 18:47:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C1512C522
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973271; cv=none; b=okV/X2NL3Z6Rpy+cTN9FpA/ThClYG1YN7mGZfkwhB9V6sGaciiUqmN8R/WhCHkfGz4IvN0Gk5mrN5gjY/rCCgCl33q6W0Z23LNu6p0tPSiabxe/0A/yGsUPKxCAdmXCD1Vp4zY9TPd+uUzuiMeBdOaFYAmbuN6bieOdHuqNwo5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973271; c=relaxed/simple;
	bh=DhBxRRCb3yw9uoCMT602u5jMeR9weM1a6tcS9atLVT4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=gaMcRfmb4T999J+JwT17ism2afoiq609gtwKhBJwZ2fTOf0O+Cu9KIfzl/WdDsYaHw/mRco+Z3Jm/LVGDOyaNXYgg9HmdOZ9kBOZ+1YjNt44eiztK7pzmjM9LjZhwL7EupEjJlb1AzLkuF1TBJqymx84Mzv4OyLerGVuXLwhATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7976BC433F1;
	Mon, 26 Feb 2024 18:47:50 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1reg2w-000000090Yw-3DlP;
	Mon, 26 Feb 2024 13:49:50 -0500
Message-ID: <20240226184932.303400070@goodmis.org>
User-Agent: quilt/0.67
Date: Mon, 26 Feb 2024 13:49:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/5] tracing: More updates for 6.9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Randy Dunlap (1):
      ftrace: Fix most kernel-doc warnings

Steven Rostedt (Google) (4):
      tracing: Remove __assign_str_len()
      tracing: Add __string_len() example
      tracing: Add warning if string in __assign_str() does not match __string()
      tracing: Remove second parameter to __assign_rel_str()

----
 fs/nfsd/trace.h                              |  8 +--
 include/trace/stages/stage6_event_callback.h | 31 ++++------
 kernel/trace/ftrace.c                        | 90 ++++++++++++++--------------
 samples/trace_events/trace-events-sample.h   | 18 +++---
 4 files changed, 74 insertions(+), 73 deletions(-)

