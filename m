Return-Path: <linux-kernel+bounces-56626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED1984CCCE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A0AB25EB0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108E57A723;
	Wed,  7 Feb 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLmYWPV6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA17D400;
	Wed,  7 Feb 2024 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707316381; cv=none; b=qaS8a/T5B0jyBQlRDEB/SFHFwmGgjXZznnBs5nr/cUp5yP8CCGn5it1HHeEkHbWOX+pIjPq5Sx2UKKYzeTAGZbDiy1pKQAmBiYwiVX4Lg+aHOCR4Y0y/n2K+oi3PZJJJg5naiGn5bpeFK9hduGh0Z1KA55Wu00fG0nQrXSBfQgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707316381; c=relaxed/simple;
	bh=bxJjQ8zp5/wZKAbX888sLrtd1GMsGHbQwFH2TFebIu4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bUFjPzebDKhwJ4g84L2ogxDntnKpwMOMim9LoHc+DYoiIRPui/VFLocex3EJDIktJk/mmjCHP90vRmzvD9qnxAsW1HgUW6Y7X9SWgSF45iI0yJ68v2jBLLIg1a/r+6LrnQb1TspRmtx6yqHmEtl9YI3Pjkj7KSJnb2pByz/AGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLmYWPV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552A5C433F1;
	Wed,  7 Feb 2024 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707316380;
	bh=bxJjQ8zp5/wZKAbX888sLrtd1GMsGHbQwFH2TFebIu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jLmYWPV6/fdm2GhyY4zcVd6HgReI0ZB643YZyPfHeJFnoIVNWL8agn9BuQ0yCnF6p
	 wth+Ov6bgfMxWLjC10FJFU/DPrOpgqTyImbfV4h52d6P/ewbfgJE7CtyB1gHLoqOBE
	 MkmMBkDDYGwxni3Qeyoo3LjI4naUbnMiN/I4zD+eIRFlo7z08svxe9bh+QF+0ode73
	 tkP1e7FYr4oIGEfit58tzrY4WLLDKe1H7czBjr8kBCaDHuDoJhKLYPjlb8x80PMgNL
	 OS5bH/0hCMurWyPH/US5ZB871BiN952jcv48y1yDriT81U6IrJOrIoJxn375ijrhBs
	 +Bkm3ZGB4JQnw==
Date: Wed, 7 Feb 2024 23:32:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/8] tracing: add new type "%pd/%pD" in readme_msg[]
Message-Id: <20240207233256.10fe8dbc8451d5be8bb6ecd1@kernel.org>
In-Reply-To: <20240125073923.2252057-6-yebin10@huawei.com>
References: <20240125073923.2252057-1-yebin10@huawei.com>
	<20240125073923.2252057-6-yebin10@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jan 2024 15:39:20 +0800
Ye Bin <yebin10@huawei.com> wrote:

> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2a7c6fd934e9..13197d3b86bd 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5745,7 +5745,7 @@ static const char readme_msg[] =
>  	"\t           +|-[u]<offset>(<fetcharg>), \\imm-value, \\\"imm-string\"\n"
>  	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, char, string, symbol,\n"
>  	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
> -	"\t           symstr, <type>\\[<array-size>\\]\n"
> +	"\t           symstr, %pd/%pD <type>\\[<array-size>\\]\n"

Almost! you missed the ',' after %pd/%pD. :)

Thank you,


>  #ifdef CONFIG_HIST_TRIGGERS
>  	"\t    field: <stype> <name>;\n"
>  	"\t    stype: u8/u16/u32/u64, s8/s16/s32/s64, pid_t,\n"
> -- 
> 2.31.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

