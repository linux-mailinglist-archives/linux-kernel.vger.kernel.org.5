Return-Path: <linux-kernel+bounces-16961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B5C82468F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE271F25601
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358712555C;
	Thu,  4 Jan 2024 16:46:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF024B26
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477B1C433C7;
	Thu,  4 Jan 2024 16:46:32 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rLQsc-00000000uIk-1GaJ;
	Thu, 04 Jan 2024 11:47:38 -0500
Message-ID: <20240104164703.808999991@goodmis.org>
User-Agent: quilt/0.67
Date: Thu, 04 Jan 2024 11:47:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 0/3] tracefs/eventfs: Updates for 6.8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
eventfs/for-next

Head SHA1: 8186fff7ab649085e2c60d032d9a20a85af1d87c


Steven Rostedt (Google) (3):
      eventfs: Remove "lookup" parameter from create_dir/file_dentry()
      eventfs: Stop using dcache_readdir() for getdents()
      tracefs/eventfs: Use root and instance inodes as default ownership

----
 fs/tracefs/event_inode.c | 320 +++++++++++++++++++++++------------------------
 fs/tracefs/inode.c       | 198 ++++++++++++++++-------------
 fs/tracefs/internal.h    |   3 +
 3 files changed, 270 insertions(+), 251 deletions(-)

