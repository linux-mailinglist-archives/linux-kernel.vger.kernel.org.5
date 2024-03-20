Return-Path: <linux-kernel+bounces-108735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7F8880F54
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2BFCB22494
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E83F3BB36;
	Wed, 20 Mar 2024 10:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH/k5sXQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7613BBFD;
	Wed, 20 Mar 2024 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929369; cv=none; b=A5Ig5hLin3hBuXIrO767e7lk+rKM6tre0jHv4QqJO7ZCPRAUjqKQThmNUpwqeiAN8MVVfRgVoD82WHduWsmgvdRISiUBY6BU/TGFR764DRGp+6HxHcCnuW0KBL7SB16RhSVQYBcrvVn1sosb1PfuMWbf04BbOjjBg2i49Nsrk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929369; c=relaxed/simple;
	bh=Ayfv7sOH9+/jMv+oBB6PGU32y7pnnX4B0L2yy0LZzQE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IKJkiCIW9GMFmGP0GAj3uwvNJU26TX3zNerN2bWSpk4ssGmsTKAvK15nfDvtvTE4CfmejfG2BgcqH1TbnCt9uAGq6c6kzvaV7Y0kE9XUEPNDSb9ZrpUyIxAtfn7swmPh/dOROTn1XRll1RfAclJ5pNK4ITASrRo5DmrvM6bfWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH/k5sXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1626C433F1;
	Wed, 20 Mar 2024 10:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710929369;
	bh=Ayfv7sOH9+/jMv+oBB6PGU32y7pnnX4B0L2yy0LZzQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kH/k5sXQdXbYMr3qonhINs97CLFbkkiaJHOL/mrd0rQ6p8DnhNU2c4KeSfZcW7R0M
	 ckKff6eMZdSQbqwm5DZxDk5Whrj9eoFQ0xtpiM3iFVy3eddpaNxocRFVh3qQCAY2Zu
	 L8rH+W0fJt0PWIVPNk/h6DsK+4TRhQEixaszu9lH20Q3QGK8HmnmkDjhvT07CoidAm
	 vEZ60H+OEiCOF/nDXivm0Uhl4ETqU52Ls77epw1IVND/VDgghVXMfk8HAAwayjAv0T
	 lOXn3NjBXEkQuyi86dZdmI4tDe/SHZuOHqhzq3DBgBgc2WMEA7cpMjs/LUF60QlME4
	 lFx/drFxqy99g==
Date: Wed, 20 Mar 2024 19:09:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 5/8] tracing: add new type "%pd/%pD" in readme_msg[]
Message-Id: <20240320190925.eb67348ecd08ed73d58cdc2d@kernel.org>
In-Reply-To: <20240315065540.1181879-6-yebin10@huawei.com>
References: <20240315065540.1181879-1-yebin10@huawei.com>
	<20240315065540.1181879-6-yebin10@huawei.com>
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

Can you split this into 

(1)
> -	"\t           symstr, <type>\\[<array-size>\\]\n"
> +	"\t           symstr, %pd, <type>\\[<array-size>\\]\n"

and 

(2)
> -	"\t           symstr, %pd, <type>\\[<array-size>\\]\n"
> +	"\t           symstr, %pd/%pD, <type>\\[<array-size>\\]\n"

And merge (1) into [PATCH 3/8], (2) into [PATCH 5/8], so that
the feature patch itself updates the readme text?

This is because even if one of the patch drops, others can
show its feature on readme.

Thank you,

On Fri, 15 Mar 2024 14:55:37 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index b12f8384a36a..831dfd0773a4 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5510,7 +5510,7 @@ static const char readme_msg[] =
>  	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
>  	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
>  	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
> -	"\t           symstr, <type>\\[<array-size>\\]\n"
> +	"\t           symstr, %pd/%pD, <type>\\[<array-size>\\]\n"
>  #ifdef CONFIG_HIST_TRIGGERS
>  	"\t    field: <stype> <name>;\n"
>  	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
> -- 
> 2.31.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

