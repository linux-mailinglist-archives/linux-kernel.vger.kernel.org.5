Return-Path: <linux-kernel+bounces-108408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A75F880A22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 04:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25191B21F45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 03:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A4F1170B;
	Wed, 20 Mar 2024 03:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJW7Gk2e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901E10A26;
	Wed, 20 Mar 2024 03:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710905306; cv=none; b=WbsU9PYs3ONr+CpqDG3whnm14XjgrJgTKdFOocwrUUa5gFzpaLmyaPlZsCTiTeLpMdXs6E7j284x1h2vIj2UxWpmnjRs/hxFsFznBPGrn1qln1Q4zp+OkXUlpLubR0Slel2G5XzR2EGT9VA27BIDynR3CGfOLSPfuoIos/qHvEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710905306; c=relaxed/simple;
	bh=Bd719awzmUDesPXDyzTkf/a6fUS4L0Q2LSPYF3fDvK0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eLKTj9f9/rLYz/xLkxWB0EX3kjE3F76a49pUqtOzemDch5/0FbX/W8EyquG+MNcGTtnDo5xdUsTPFtyWdGmEvO+PP7NJa8FtWrJXq8eDzIZwuqxThlgLMZHFCrx3yjz1q64nr3mxPxLUl3rW9p9o+CFIpb8ID4fWZ5y55NKasGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJW7Gk2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A338AC433F1;
	Wed, 20 Mar 2024 03:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710905306;
	bh=Bd719awzmUDesPXDyzTkf/a6fUS4L0Q2LSPYF3fDvK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aJW7Gk2eCPGCyej4zpPE6W4UK56SX7SY3GpX7VuxAUfjE6eDeuXP60BwA77XlEOhP
	 7h060w/OYXg/DLqcMh3R8dj2ofxEwHVLDrSx9CHysIvmvti7UV1K4T1XRwptfve6kK
	 Yq+ThzUfRNf9aCoH6yfEQYn0VLB/7c4PrywcLN2VHgUAIzZmxD6KgzA1vlFCfRc14w
	 bqpViOzuMYA+FaGSxHqS45Lke9bZtHx83QeVraOsm55WDpwM/NpAI1yzsteScLtCK6
	 FtlZdilujzDH2wVkKSOHrFokxvHJE0TeY76xj6rO7Hug27e47d2NmNtOisF8fFmFuI
	 XZ7tFtGPSZAdg==
Date: Wed, 20 Mar 2024 12:28:22 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 7/8] selftests/ftrace: add kprobe test cases for VFS
 type "%pd" and "%pD"
Message-Id: <20240320122822.50fd238753278798881464ae@kernel.org>
In-Reply-To: <20240315065540.1181879-8-yebin10@huawei.com>
References: <20240315065540.1181879-1-yebin10@huawei.com>
	<20240315065540.1181879-8-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ye,

Sorry for replying late.

On Fri, 15 Mar 2024 14:55:39 +0800
Ye Bin <yebin10@huawei.com> wrote:

> This patch adds test cases for new print format type "%pd/%pD".The test cases
> test the following items:
> 1. Test README if add "%pd/%pD" type;
> 2. Test "%pd" type for dput();
> 3. Test "%pD" type for vfs_read();
> 
> This test case require enable CONFIG_HAVE_FUNCTION_ARG_ACCESS_API configuration.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> new file mode 100644
> index 000000000000..8bea9a75a331
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Kprobe event VFS type argument
> +# requires: kprobe_events "%pd/%pD":README
> +
> +: "Test argument %pd/%pD in README"
> +grep -q "%pd/%pD" README

If you put this check in "# requires" line, you don't need to check it again.

> +
> +: "Test argument %pd with name"
> +echo 'p:testprobe dput name=$arg1:%pd' > kprobe_events
> +echo 1 > events/kprobes/testprobe/enable
> +grep -q "1" events/kprobes/testprobe/enable

So accessing "enable" file here,

> +echo 0 > events/kprobes/testprobe/enable
> +grep "dput" trace | grep -q "enable"

and check it.

OK, the test case itself looks good to me.

Thanks,

> +echo "" > kprobe_events
> +echo "" > trace
> +
> +: "Test argument %pd without name"
> +echo 'p:testprobe dput $arg1:%pd' > kprobe_events
> +echo 1 > events/kprobes/testprobe/enable
> +grep -q "1" events/kprobes/testprobe/enable
> +echo 0 > events/kprobes/testprobe/enable
> +grep "dput" trace | grep -q "enable"
> +echo "" > kprobe_events
> +echo "" > trace
> +
> +: "Test argument %pD with name"
> +echo 'p:testprobe vfs_read name=$arg1:%pD' > kprobe_events
> +echo 1 > events/kprobes/testprobe/enable
> +grep -q "1" events/kprobes/testprobe/enable
> +echo 0 > events/kprobes/testprobe/enable
> +grep "vfs_read" trace | grep -q "enable"
> +echo "" > kprobe_events
> +echo "" > trace
> +
> +: "Test argument %pD without name"
> +echo 'p:testprobe vfs_read $arg1:%pD' > kprobe_events
> +echo 1 > events/kprobes/testprobe/enable
> +grep -q "1"  events/kprobes/testprobe/enable
> +echo 0 > events/kprobes/testprobe/enable
> +grep "vfs_read" trace | grep -q "enable"
> +echo "" > kprobe_events
> +echo "" > trace
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

