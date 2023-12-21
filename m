Return-Path: <linux-kernel+bounces-8622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4948081BA4C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5191F2406B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A7B360BC;
	Thu, 21 Dec 2023 15:11:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A528539E3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 15:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90607C433C8;
	Thu, 21 Dec 2023 15:11:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rGKiv-000000040Uo-12YH;
	Thu, 21 Dec 2023 10:12:33 -0500
Message-ID: <20231221150922.017965539@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 21 Dec 2023 10:09:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-linus][PATCH 0/3] tracing: More fixes for v6.7-rc6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


Tracing fixes for 6.7:

- Fix another kerneldoc warning

- Fix eventfs files to inherit the ownership of its parent directory.
  The dynamic creating of dentries in eventfs did not take into
  account if the tracefs file system was mounted with a gid/uid,
  and would still default to the gid/uid of root. This is a regression.

- Fix warning when synthetic event testing is enabled along with
  startup event tracing testing is enabled

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/urgent

Head SHA1: 88b30c7f5d27e1594d70dc2bd7199b18f2b57fa9


Randy Dunlap (1):
      tracing/synthetic: fix kernel-doc warnings

Steven Rostedt (Google) (2):
      eventfs: Have event files and directories default to parent uid and gid
      tracing / synthetic: Disable events after testing in synth_event_gen_test_init()

----
 fs/tracefs/event_inode.c            | 12 +++++++++---
 kernel/trace/synth_event_gen_test.c | 11 +++++++++++
 kernel/trace/trace_events_synth.c   |  4 ++--
 3 files changed, 22 insertions(+), 5 deletions(-)

