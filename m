Return-Path: <linux-kernel+bounces-56630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB57B84CCFA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C588B23FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD6F7E76F;
	Wed,  7 Feb 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmF5if72"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2737E76E;
	Wed,  7 Feb 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316783; cv=none; b=uyE0WvtDhKIbDBxfEoFIueYdELeaFvJIyGx0oRsnLhSBWDWltjU2Ul/HT5fijvjkmXK9kIo2qc1yGHJoClTsElQSzt1yWBkP5KoBTK9lZjHUNW19MRJ6qbta+6i4QpXXai9cZAdMUiX4RlRvwOMZrfcp50+grpP8jgYSe4q4JTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316783; c=relaxed/simple;
	bh=5SO8XoghfEJ9kt6J0CSha+AoXUiz+7SvGnwmVDAyX6o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AvZ3aIJVw/aBzqKqqpauxhS/A+TfUC0FHXxZ2WQk//PkQkCuSVRcyLOoqokycZLkMczmjC1TjxJwLGqcnn9q7rwJtdnTlVgLhaFwVlxu7KBVN5a4xWU5zWtsM+gRSQ1GEfFHXdXMucDC0Q67Th8lDs6GE+xl4je/rUx+EP9zUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmF5if72; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81471C433C7;
	Wed,  7 Feb 2024 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707316782;
	bh=5SO8XoghfEJ9kt6J0CSha+AoXUiz+7SvGnwmVDAyX6o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lmF5if72zIVb9Y4JuAHa5pZkhAIxphHTiU26VGqeK3WZRkr/tYp/AHreDIJ6nmqSD
	 ZQyUIpgcDfNdybc4kfqUVCrchug8p87A2no1u/JxXirMYmj3e+lqpHGPRkgfZJRCyc
	 43uYujwS+00u7lnUrpSUf97bUVzFI9kGQWkOra4s5Ng+Y/4YrGB9FQfPJykYbCBBK2
	 ZHJvVmcNnkl7IEyGEuVoGaTtYS/lMrpReHGkQjM2Ew6wVVkfkXPtNsEST/oLRjAX1g
	 zc5zdE2Z9pYItOKUBsnEk95Y+oAf5DBObdFB+gb6q8GRT6dH2rDCdI9iJhmEUsc849
	 uckld7W2zOzyQ==
Date: Wed, 7 Feb 2024 23:39:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 7/8] selftests/ftrace: add kprobe test cases for VFS
 type "%pd" and "%pD"
Message-Id: <20240207233939.0450962199e2f1fdd8655540@kernel.org>
In-Reply-To: <20240125073923.2252057-8-yebin10@huawei.com>
References: <20240125073923.2252057-1-yebin10@huawei.com>
	<20240125073923.2252057-8-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 15:39:22 +0800
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
> index 000000000000..cf0599b90f1a
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> @@ -0,0 +1,43 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Kprobe event VFS type argument
> +# requires: kprobe_events
> +
> +: "Test argument %pd/%pD in README"
> +grep -q "%pd/%pD" README

No. This means, if the kernel doesn't support %pd/%pD, this test fails.
But the latest version of the ftracetest will be used for testing stable
kernels (which will not support this feature).
So you should make test returning 'unsupported' for that case.

You can add a requirement as

# requires: kprobe_events "%pd/%pD":README

(e.g. tools/testing/selftests/ftrace/test.d/dynevent/eprobes_syntax_errors.tc)

Thank you,

> +
> +: "Test argument %pd with name"
> +echo 'p:testprobe dput name=$arg1:%pd' > kprobe_events
> +echo 1 > events/kprobes/testprobe/enable
> +grep -q "1" events/kprobes/testprobe/enable
> +echo 0 > events/kprobes/testprobe/enable
> +grep "dput" trace | grep -q "enable"
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
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

