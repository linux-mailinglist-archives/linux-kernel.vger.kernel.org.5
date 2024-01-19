Return-Path: <linux-kernel+bounces-31267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE2B832B80
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DE71F25AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B03753E0C;
	Fri, 19 Jan 2024 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7z2tB1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF2853E05;
	Fri, 19 Jan 2024 14:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705675441; cv=none; b=oTd6WTgr2sUDEl0z7NSj7NzawpSDO/4uXwLqVtpzThAN2XeeZ7o12d6v3CqMk+GwIrzksGeVK/zhICDwVY+JkzbfduQ2Uvcky2Tws3odT6HC2XlWvi6pMRF6kLbStNeVnM59uuYeO1rvn322QXYM1k9GA8IAqaAdpwVKHWdb6nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705675441; c=relaxed/simple;
	bh=giuelcDxoe3oEfiTmrX+KQXnevAJ1smfRGB8PM+8Adg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mpn/GnjEaHF8LiMEx06lNgfSJYCK160Of0bu/dSsSPSqWwVfObCf0RlBwqpJqlPBKAO4bq3w0bJ/STWqXa53IW1kd9PI5+e4e0qJTngzTxEhhAz/OFV+1nK6sj5hTjwq+5lOaidL9CCrVXlqFQ1IA2mrV4MJ72ymXZ5+KHHthJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7z2tB1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEDAC43390;
	Fri, 19 Jan 2024 14:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705675440;
	bh=giuelcDxoe3oEfiTmrX+KQXnevAJ1smfRGB8PM+8Adg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U7z2tB1HM2Mscia1BP49rUvb2Pm0QJAEwzhItzgbUvZolkTju6FMB9KMN01GKaNqX
	 zzEUKyWstHcd8bQAnYDjk6xdowuYUfc8KdPcUG2rZ+DTd2DCTxHmFTQDdRoDVbhRZ1
	 MvS/6PBFmgj8EryvmC67XeZMP/oG6dmtOnkntl48QkIKwclBz93F6VzjUYmkCOZKB0
	 UEC7p82/eeVs6hZIMvg+Man3IS1LhKr23s5w957zvZQ+hdbFW7eUC3fxCryAjRfDyv
	 HfGjKqFJMPEK+7pz/nvrQgrDlY496wS5GA0EnC8fJZDtF7DMrDo3eXtyX8Ivm2HdcR
	 B1CQ5hOYhIj9Q==
Date: Fri, 19 Jan 2024 23:43:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] support '%pd' and '%pD' for print file name
Message-Id: <20240119234356.1598e760edbfa58f5440a941@kernel.org>
In-Reply-To: <20240119013848.3111364-1-yebin10@huawei.com>
References: <20240119013848.3111364-1-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jan 2024 09:38:45 +0800
Ye Bin <yebin10@huawei.com> wrote:

> During fault locating, the file name needs to be printed based on the
> dentry/file address. The offset needs to be calculated each time, which
> is troublesome. Similar to printk, kprobe supports printing file names
> for dentry/file addresses.

Hi Ye,

Thanks for your proposal!

Generically, I think this type of hack is not good for the tracing
because there are already some ways to do that. e.g.
 - Use perf probe to specify dentry->name:string or file->name:string 
 - Use BTF to specify in the same way (but only for function entry)
And those are more obvious what it does.

However, if this is implemented in more generic syntax, it will be
acceptable.
For example, type specifying with "arg1:printfmt(%pD)" will be
more generic because it is apparently one of the printfmt and output
string. Or, maybe we can just allow to use ":%pD" as a fetch type
(start with '%' means the printfmt)

Also, could you update readme_msg[] in kernel/trace/trace.c if
you add a type, and add a testcase of selftests/ftrace, for this
feature? Documentation should also be updated with more syntax
information.

Thank you,

> 
> Ye Bin (3):
>   tracing/probes: support '%pd' type for print struct dentry's name
>   tracing/probes: support '%pD' type for print struct file's name
>   Documentation: tracing: add new type 'pd' and 'pD' for kprobe
> 
>  Documentation/trace/kprobetrace.rst |  3 +-
>  kernel/trace/trace_probe.c          | 50 +++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+), 1 deletion(-)
> 
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

