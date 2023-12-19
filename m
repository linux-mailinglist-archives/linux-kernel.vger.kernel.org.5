Return-Path: <linux-kernel+bounces-5376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF716818A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AB51C2479D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB30208AB;
	Tue, 19 Dec 2023 14:32:00 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41820333
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E1EC433C8;
	Tue, 19 Dec 2023 14:32:00 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFb9W-00000003MDR-3xM0;
	Tue, 19 Dec 2023 09:32:58 -0500
Message-ID: <20231219143233.204534014@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 09:32:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 00/10] tracing: Updates for 6.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: f50345b49b16f7fe6dbebbec065b9248c38556ff


Steven Rostedt (Google) (10):
      tracing: Allow creating instances with specified system events
      ring-buffer: Add offset of events in dump on mismatch
      tracing: Allow for max buffer data size trace_marker writes
      trace_seq: Increase the buffer size to almost two pages
      tracing: Have trace_marker break up by lines by size of trace_seq
      tracing: Increase size of trace_marker_raw to max ring buffer entry
      tracing/selftests: Add test to test the trace_marker
      ring-buffer: Remove 32bit timestamp logic
      ring-buffer: Add interrupt information to dump of data sub-buffer
      ring-buffer: Check if absolute timestamp goes backwards

----
 drivers/scsi/qla2xxx/qla_os.c                      |   2 +-
 include/linux/ring_buffer.h                        |   1 +
 include/linux/trace.h                              |   4 +-
 include/linux/trace_seq.h                          |   9 +-
 kernel/trace/ring_buffer.c                         | 321 +++++++++------------
 kernel/trace/trace.c                               |  79 +++--
 kernel/trace/trace.h                               |   1 +
 kernel/trace/trace_boot.c                          |   2 +-
 kernel/trace/trace_events.c                        |  48 ++-
 kernel/trace/trace_seq.c                           |   3 -
 samples/ftrace/sample-trace-array.c                |   2 +-
 .../ftrace/test.d/00basic/trace_marker.tc          |  82 ++++++
 12 files changed, 328 insertions(+), 226 deletions(-)
 create mode 100755 tools/testing/selftests/ftrace/test.d/00basic/trace_marker.tc

