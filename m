Return-Path: <linux-kernel+bounces-16217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79DF823AE9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE641C24233
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226BC5231;
	Thu,  4 Jan 2024 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UopDqbQ+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA2A111A7;
	Thu,  4 Jan 2024 02:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0FEC433C7;
	Thu,  4 Jan 2024 02:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704337157;
	bh=S4RcSiGNRUEo1bLQ+DCAtGqoJ+Ocd7RzusHa9Z6/S3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UopDqbQ+INwcjQVb6DhX1f1yd5IK10B1nwdKVyu7wN7Pcx9qZ0wLee1g1jnpK4Ve+
	 oOsfH7hBdzvmPSiZ1+FzFDwO4vwcIuiyJ6OkcuGSN90jX/wQERlretO4ouM3Qi9VeI
	 Ih/zIY7at3aYnF36joNqyCDS7cnn+8OLxpVx/v5G8mLO7T8k4UhOrVbxWdAOWKh5P2
	 Aq8JQh7cqwKmM/5gitO5o6iBYe9CfaSgiAwHOtgOsNmdqCtXbVvk3sC+UB0FOoc/MK
	 OIsdIaUGvwGSgrvEfSDGNynRsGDy2HjAL9xeufZELvk9QHNS5YfNllew/fDMEjPwc7
	 mQW6WQwwTlVIA==
Date: Thu, 4 Jan 2024 11:59:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] docs, kprobes: Add loongarch as supported
 architecture
Message-Id: <20240104115913.2b8839bff660e34e280079aa@kernel.org>
In-Reply-To: <20231219062330.22813-3-yangtiezhu@loongson.cn>
References: <20231219062330.22813-1-yangtiezhu@loongson.cn>
	<20231219062330.22813-3-yangtiezhu@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 14:23:30 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> After the following three changes at the beginning of the year:
> 
>   commit 6d4cc40fb5f5 ("LoongArch: Add kprobes support")
>   commit 3f5536860086 ("LoongArch: Add kretprobes support")
>   commit 09e679c28a4d ("LoongArch: Add kprobes on ftrace support")
> 
> it is appropriate to add loongarch as supported architecture in
> kprobes documentation.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  Documentation/trace/kprobes.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
> index 968ae080accd..e1636e579c9c 100644
> --- a/Documentation/trace/kprobes.rst
> +++ b/Documentation/trace/kprobes.rst
> @@ -321,6 +321,7 @@ architectures:
>  - mips
>  - s390
>  - parisc
> +- loongarch
>  
>  Configuring Kprobes
>  ===================
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

