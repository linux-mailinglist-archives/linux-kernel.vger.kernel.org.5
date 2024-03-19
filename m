Return-Path: <linux-kernel+bounces-108219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A4E8807EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F2C1C22830
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D5A57339;
	Tue, 19 Mar 2024 23:00:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D69D5F86E;
	Tue, 19 Mar 2024 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889237; cv=none; b=YR3XafHx2a4QANNiNju4N+ShYIR+QlRtTSRAl1hcVQVW87ueheM8ZZHrjI+TNhTk5Yh4jcb8iHhIDt0pYz+xjXe5xZNSRVSeS3QaIqsabO5kerK4wMWImS8XaA6msf3Y8tYKhVp66woOwSRYWirATbpq6T/v1wf6pWrLwxLcfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889237; c=relaxed/simple;
	bh=Rg9kLOe7EynCjlAo/kFPcMuXUbZElAONgC515/UjszU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2vvZU7523glgpQSdDYipKngGMNnUyzVaKFe5iZ2y68GvLkADfiESU4l45qyshNSyA1gAbksWhdqSa7rT4hQPpXavxZaAU7tXObw2VBJd8USb3RDhWmAlmzRLiyT5ltmZXkZ4BY0Y96VOZLZNqeqO3ZdpWtTUOwNIqjii8wUf7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45471C433C7;
	Tue, 19 Mar 2024 23:00:36 +0000 (UTC)
Date: Tue, 19 Mar 2024 19:02:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [GIT PULL] tracing/tools: Updates for 6.9
Message-ID: <20240319190259.0086706f@gandalf.local.home>
In-Reply-To: <20240318174116.420584-1-bristot@kernel.org>
References: <20240318174116.420584-1-bristot@kernel.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Mar 2024 18:41:13 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> Steven,
> 
> Tracing tooling updates for 6.9
> 
> Tracing:
>         - Update makefiles for latency-collector and RTLA,
>           using tools/build/ makefiles like perf does, inheriting
>           its benefits. For example, having a proper way to
>           handle dependencies.
> 
>         - The timerlat tracer has an interface for any tool to use.
>           rtla timerlat tool uses this interface dispatching its
>           own threads as workload. But, rtla timerlat could also be
>           used for any other process. So, add 'rtla timerlat -U'
>           option, allowing the timerlat tool to measure the latency of
>           any task using the timerlat tracer interface.
> 
> Verification:
>         - Update makefiles for verification/rv, using tools/build/
>           makefiles like perf does, inheriting its benefits.
>           For example, having a proper way to handle dependencies.
> 
> 
> Please pull the latest trace-tools-v6.9 tree, which can be found at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bristot/linux.git
> trace-tools-v6.9

Looks like you just built on top of a random commit from Linus's tree:

commit f6cef5f8c37f58a3bc95b3754c3ae98e086631ca
Merge: 906a93befec8 8f06fb458539
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun Mar 17 16:59:33 2024 -0700

    Merge tag 'i3c/for-6.9' of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux

Linus prefers basing off of real tags or previous pulls from us.

Can you rebase your changes on v6.8 and resend?

  $ git checkout v6.8
  $ git cherry-pick f6cef5f8c37f58a3bc95b3754c3ae98e086631ca..trace-tools-v6.9

Appears to work fine.

Thanks!

-- Steve


> 
> Tag SHA1: 2eb09a97c56af3c27bd9dcebccb495f70d56d5c0
> Head SHA1: 9c63d9f58a42b979a42bcaed534d9246996ac0d9
> 
> 
> Daniel Bristot de Oliveira (4):
>       tools/tracing: Use tools/build makefiles on latency-collector
>       tools/rtla: Use tools/build makefiles to build rtla
>       tools/verification: Use tools/build makefiles on rv
>       tools/rtla: Add -U/--user-load option to timerlat
> 
> ----
>  .../tools/rtla/common_timerlat_options.rst         |   6 +
>  tools/tracing/latency/.gitignore                   |   5 +-
>  tools/tracing/latency/Build                        |   1 +
>  tools/tracing/latency/Makefile                     | 105 ++++++++--
>  tools/tracing/latency/Makefile.config              |  30 +++
>  tools/tracing/rtla/.gitignore                      |   7 +-
>  tools/tracing/rtla/Build                           |   1 +
>  tools/tracing/rtla/Makefile                        | 217 +++++++--------------
>  tools/tracing/rtla/Makefile.config                 |  47 +++++
>  tools/tracing/rtla/Makefile.rtla                   |  80 ++++++++
>  tools/tracing/rtla/Makefile.standalone             |  26 +++
>  tools/tracing/rtla/sample/timerlat_load.py         |  74 +++++++
>  tools/tracing/rtla/src/Build                       |  11 ++
>  tools/tracing/rtla/src/timerlat_hist.c             |  16 +-
>  tools/tracing/rtla/src/timerlat_top.c              |  14 +-
>  tools/verification/rv/.gitignore                   |   6 +
>  tools/verification/rv/Build                        |   1 +
>  tools/verification/rv/Makefile                     | 207 +++++++-------------
>  tools/verification/rv/Makefile.config              |  47 +++++
>  tools/verification/rv/Makefile.rv                  |  51 +++++
>  tools/verification/rv/src/Build                    |   4 +
>  21 files changed, 650 insertions(+), 306 deletions(-)
>  create mode 100644 tools/tracing/latency/Build
>  create mode 100644 tools/tracing/latency/Makefile.config
>  create mode 100644 tools/tracing/rtla/Build
>  create mode 100644 tools/tracing/rtla/Makefile.config
>  create mode 100644 tools/tracing/rtla/Makefile.rtla
>  create mode 100644 tools/tracing/rtla/Makefile.standalone
>  create mode 100644 tools/tracing/rtla/sample/timerlat_load.py
>  create mode 100644 tools/tracing/rtla/src/Build
>  create mode 100644 tools/verification/rv/.gitignore
>  create mode 100644 tools/verification/rv/Build
>  create mode 100644 tools/verification/rv/Makefile.config
>  create mode 100644 tools/verification/rv/Makefile.rv
>  create mode 100644 tools/verification/rv/src/Build
> ---------------------------


