Return-Path: <linux-kernel+bounces-9236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C57E781C2B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 02:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045D31C24770
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48552A5D;
	Fri, 22 Dec 2023 01:27:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA1A23;
	Fri, 22 Dec 2023 01:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC36C433C8;
	Fri, 22 Dec 2023 01:27:09 +0000 (UTC)
Date: Thu, 21 Dec 2023 20:28:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Linux
 selftests <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/selftests: Add ownership modification tests
 for eventfs
Message-ID: <20231221202813.38ef5664@gandalf.local.home>
In-Reply-To: <20231222102148.2aa3863d7c11f3928549335a@kernel.org>
References: <20231221194516.53e1ee43@gandalf.local.home>
	<20231222102148.2aa3863d7c11f3928549335a@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 10:21:48 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> The testcase itself is OK but is there any way to identify the system
> supports eventfs or not? I ran this test on v6.5.13 for checking then
> it failed. We may need to skip (unsupported) this test for such case.

Hmm, honestly, it should technically work on all past versions.

I'll try it out to see what fails for 6.5.13. Perhaps there was another bug
that the stable releases need fixing for?

-- Steve

