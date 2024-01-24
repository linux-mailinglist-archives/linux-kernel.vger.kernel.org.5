Return-Path: <linux-kernel+bounces-36277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9C9839E4E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CB51F22179
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E3B15C4;
	Wed, 24 Jan 2024 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSZy68Z2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7671396;
	Wed, 24 Jan 2024 01:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706059926; cv=none; b=Ae7Og9mUVtXYCwn2S1mAT8J/gYtt2eF/jgmvxYDSjzwcBxkmrM5UUB1NzeaU6knaMheqsNSkQuOzu3LjukmT58+jT0i0kMmOrE5nqTtz1DAhrCsOavDQvfESMCXhDU0Zh5FMPetnbYWzVmS51hGERWifBUIv3fAFt4TbcrYlsAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706059926; c=relaxed/simple;
	bh=wBc7BoZbGTMbQ1QWsWXSbUPtRHXBQH0+VcToISPS524=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YxtlXNkuFwasBHJklgEVJun6NN+3ZTzp7aUYkLNy/2wcW2P23p0rYyUNz+bYY7aTf3zXQNJQ/QEbyWsNo2AKynKLLVYCcqscdZkS7JXmC01hA8rivDdJP8+wme+0hxSUQsoBJZKCnxl4vIDiqYskg32wYX5sA+ER2KP9XH/kkj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSZy68Z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08DBC433C7;
	Wed, 24 Jan 2024 01:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706059926;
	bh=wBc7BoZbGTMbQ1QWsWXSbUPtRHXBQH0+VcToISPS524=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fSZy68Z2JKU5dW23uvmKGh6d4jv+AAXJcb3GA+EmTzleVtoaNNMsQ2nya7nfuDKbV
	 hyrVc7yvyUvxRjP5KqSokYDISYRpxS25eRpzYQqAcDYQZ/VDtSzjPx6gteb4E0iA5g
	 a0KmlWrp/W2Ou2gmRA+UkEDbNniZuoI8356SuxuN9e5KqnLAuFJp+8umsbwkkWYX+z
	 slXl1DmGyyVhoLfDhPAl6JfEWX0YpH+asX+8l0+GdjRIq1qppf2yD8aS4e57e5ZN4g
	 OBgbLhFJLNfZoaOnHXSt7v8hC4PSOKkDqkgSOdB5E+9ghZhdr0y08JWMk81yrlaPA5
	 fl3VTjCteU9jw==
Date: Wed, 24 Jan 2024 10:32:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 7/7] selftests/ftrace: add test cases for VFS type
 "%pd" and "%pD"
Message-Id: <20240124103201.6dd8d466b1b734796418c1c4@kernel.org>
In-Reply-To: <20240123092139.3698375-8-yebin10@huawei.com>
References: <20240123092139.3698375-1-yebin10@huawei.com>
	<20240123092139.3698375-8-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 17:21:39 +0800
Ye Bin <yebin10@huawei.com> wrote:

> This patch adds test cases for new print format type "%pd/%pD".The test cases
> test the following items:
> 1. Test README if add "%pd/%pD" type;
> 2. Test "%pd" type for dput();
> 3. Test "%pD" type for vfs_read();
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> new file mode 100644
> index 000000000000..1d8edd294dd6
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> @@ -0,0 +1,79 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: Kprobe event VFS type argument
> +# requires: kprobe_events
> +
> +case `uname -m` in
> +x86_64)
> +  ARG1=%di
> +;;
> +i[3456]86)
> +  ARG1=%ax
> +;;
> +aarch64)
> +  ARG1=%x0
> +;;
> +arm*)
> +  ARG1=%r0
> +;;
> +ppc64*)
> +  ARG1=%r3
> +;;
> +ppc*)
> +  ARG1=%r3

You can merge this ppc* and ppc64* cases :)

> +;;
> +s390*)
> +  ARG1=%r2
> +;;
> +mips*)
> +  ARG1=%r4
> +;;
> +loongarch*)
> +  ARG1=%r4
> +;;
> +riscv*)
> +  ARG1=%a0

Anyway, I wonder why don't you use '$arg1' instead of these registers.
Is there any reason?

Thank you,

> +;;
> +*)
> +  echo "Please implement other architecture here"
> +  exit_untested
> +esac
> +
> +: "Test argument %pd/%pD in README"
> +grep -q "%pd/%pD" README
> +
> +: "Test argument %pd with name"
> +echo "p:testprobe dput name=${ARG1}:%pd" > kprobe_events
> +echo 1 > events/kprobes/testprobe/enable
> +grep -q "1" events/kprobes/testprobe/enable
> +echo 0 > events/kprobes/testprobe/enable
> +grep "dput" trace | grep -q "enable"
> +echo "" > kprobe_events
> +echo "" > trace
> +
> +: "Test argument %pd without name"
> +echo "p:testprobe dput ${ARG1}:%pd" > kprobe_events
> +echo 1 > events/kprobes/testprobe/enable
> +grep -q "1" events/kprobes/testprobe/enable
> +echo 0 > events/kprobes/testprobe/enable
> +grep "dput" trace | grep -q "enable"
> +echo "" > kprobe_events
> +echo "" > trace
> +
> +: "Test argument %pD with name"
> +echo "p:testprobe vfs_read name=${ARG1}:%pD" > kprobe_events
> +echo 1 > events/kprobes/testprobe/enable
> +grep -q "1" events/kprobes/testprobe/enable
> +echo 0 > events/kprobes/testprobe/enable
> +grep "vfs_read" trace | grep -q "enable"
> +echo "" > kprobe_events
> +echo "" > trace
> +
> +: "Test argument %pD without name"
> +echo "p:testprobe vfs_read ${ARG1}:%pD" > kprobe_events
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

