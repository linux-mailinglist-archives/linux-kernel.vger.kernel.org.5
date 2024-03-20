Return-Path: <linux-kernel+bounces-108752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C1C880F8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC1D284783
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49BC3C6BA;
	Wed, 20 Mar 2024 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBWP56XL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63703D0A4;
	Wed, 20 Mar 2024 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930060; cv=none; b=ePpUB9gnah4Hkj3yxvEQK/nU36dfSgKqpjbVhvSXhbr43UxxZV8UChoiLOz7SCYbbaXTFXWNNme5hFp/4LQXKWp5ysepAV2GQx/s4qL9jt5hPLe7L2RjA+0YdsWnHCXXDGgVTvOKNa+uwLWYPHPCOc5sgVKHjBPHeNPf9jsO6MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930060; c=relaxed/simple;
	bh=tdQOp6foDlbWDYweV3ONMvZuCnYtnfRlJkFwHm8RCQI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S8/sd6lKUPKmKCKO30IB1qNBcDgiG2cIPgjId8D4Z7fmqRuRb/W4NpMtS3quvHQerX9iZT7aeIkxHxFw6TzBMK3fM2E0K0KPudrcm+y7jEdsN4wNCmTS61+R8O66x4O+me6nBe66TyRM+aGsAh3F9NUOHz/xG+gyQsQ0vy2EBXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBWP56XL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14957C433F1;
	Wed, 20 Mar 2024 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710930059;
	bh=tdQOp6foDlbWDYweV3ONMvZuCnYtnfRlJkFwHm8RCQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rBWP56XLr8eHE+WgSL7Yi0JuOAl3pl5EIuWUMZeRsTAwN2P28BjhEEIWUegp6vVlh
	 OfCfDvKGfWAoO/VK7pSENXg03nXGwyo4ahzwjgG6K3nvDPO0e261GecqVV+ExLN/3l
	 bUR53JtUvw/sWkZmHkKmKWJQhSKep1w8iMdSiWkDcwcGhiHe01oawuJr1kIr0lu6VU
	 bP3U+UWJailPQzgfojRptVHMhakRAvpmjDDyWtyDtSuIlRqmvxXcG2NQ9vV25OTqXX
	 xF7dpfMS3KIcYMteJ4KhVmvDZQ/Zz2ZwnGw88bfHCu/uwmRSSUVmYbaITdiGaZp3Qg
	 d8ScXY1/cViPw==
Date: Wed, 20 Mar 2024 19:20:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/8] support '%pd' and '%pD' for print file name
Message-Id: <20240320192055.6b149d90ca3af255aa7738ab@kernel.org>
In-Reply-To: <20240315065540.1181879-1-yebin10@huawei.com>
References: <20240315065540.1181879-1-yebin10@huawei.com>
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

On Fri, 15 Mar 2024 14:55:32 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Sorry for taking so long to post the V6 version. I thought my email was
> sent successfully. I checked the patchwork and it was not sent successfully.
> 
> During fault locating, the file name needs to be printed based on the
> dentry/file address. The offset needs to be calculated each time, which
> is troublesome. Similar to printk, kprobe supports printing file names
> for dentry/file addresses.

Thanks for updating the series.

There are some nits, but basically this is good to me.
Could you update this series?

Thank you,

> 
> Diff v6 vs v5:
> 1. Add const for 'bufsize' in PATCH [1];
> 2. Move PATCH 'tracing/probes: support '%pd/%pD' type for fprobe' after
> PATCH "tracing/probes: support '%pd' type for print struct dentry's name".
> 3. Add requires '"%pd/%pD":README' for testcase.
> 
> Diff v5 vs v4:
> 1. Use glob_match() instead of str_has_suffix(), so remove the first patch;
> 2. Allocate buffer from heap for expand dentry;
> 3. Support "%pd/%pD" print type for fprobe;
> 4. Use $arg1 instead of origin register in test case;
> 5. Add test case for fprobe;
> 
> Diff v4 vs v3:
> 1. Use "argv[i][idx + 3] == 'd'" instead of "argv[i][strlen(argv[i]) - 1] == 'd'"
> to judge print format in PATCH[4/7];
> 
> Diff v3 vs v2:
> 1. Return the index of where the suffix was found in str_has_suffix();
> 
> Diff v2 vs v1:
> 1. Use "%pd/%pD" print format instead of "pd/pD" print format;
> 2. Add "%pd/%pD" in README;
> 3. Expand "%pd/%pD" argument before parameter parsing;
> 4. Add more detail information in ftrace documentation;
> 5. Add test cases for new print format in selftests/ftrace;
> 
> Ye Bin (8):
>   tracing/probes: add traceprobe_expand_dentry_args() helper
>   tracing/probes: support '%pd' type for print struct dentry's name
>   tracing/probes: support '%pd' type for fprobe
>   tracing/probes: support '%pD' type for print struct file's name
>   tracing: add new type "%pd/%pD" in readme_msg[]
>   Documentation: tracing: add new type '%pd' and '%pD' for kprobe
>   selftests/ftrace: add kprobe test cases for VFS type "%pd" and "%pD"
>   selftests/ftrace: add fprobe test cases for VFS type "%pd" and "%pD"
> 
>  Documentation/trace/kprobetrace.rst           |  8 ++-
>  kernel/trace/trace.c                          |  2 +-
>  kernel/trace/trace_fprobe.c                   |  6 ++
>  kernel/trace/trace_kprobe.c                   |  6 ++
>  kernel/trace/trace_probe.c                    | 63 +++++++++++++++++++
>  kernel/trace/trace_probe.h                    |  2 +
>  .../ftrace/test.d/dynevent/fprobe_args_vfs.tc | 40 ++++++++++++
>  .../ftrace/test.d/kprobe/kprobe_args_vfs.tc   | 43 +++++++++++++
>  8 files changed, 167 insertions(+), 3 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_vfs.tc
> 
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

