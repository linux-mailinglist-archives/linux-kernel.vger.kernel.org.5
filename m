Return-Path: <linux-kernel+bounces-87610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9305A86D673
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218BB284862
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4517F6D53E;
	Thu, 29 Feb 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqIhjWur"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3E6D521;
	Thu, 29 Feb 2024 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709243939; cv=none; b=YiPskSYI3OcnkRPUcV9hFhJ9oHwcFvHPI6BRHXqiEcQxqEidDr+q2wTjyGDAnM/HSy9TSHgLM+cuP+qu9F5g6vNfbWaUZS93K5bAy/4bTDT6qHHoizQyPoixQ3vXKQ5WdEzWJ0ejNDrMMQLgkdsPLX+4xONLHhBUx2N9BIDC8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709243939; c=relaxed/simple;
	bh=u7emfAwG3izXFa50N+MC/c19/H8pMfUWBq0jlVhc5kc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAmn2/IrAU/QhX5CsRkCs0Cp3qsjYYPgAei0UcG8ENL8O3zvrkZmDeRpMSwje4/MeS5tB8Ga7mGZOzstOuDz8l7X3nyY2QBlqrLJuVsz/9OqR7HSuq3YfzwHGM05uZML9tgeCmwkQVBWZLSo9GmSZ45v/3aF8cb90YNxxw5kgVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqIhjWur; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so265822266b.2;
        Thu, 29 Feb 2024 13:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709243936; x=1709848736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YLB+AEOoGVHORFz2CPSFygKm0JXbti6HkSl+J6gRIxA=;
        b=RqIhjWurkRxbaRi4Yd7F9VZsarPBQsSLs/BmStXTXf0YhrSiXBR2KUBOX/55xOG52o
         0sS8ifaJQ/xUw/G62GldgMY6Fay8pcsIsyeQcRCHA6KYgqOzEKgZ8VquVVYOn5ru19zc
         s4U9XgUUdWJicLU1eVhekKR9pn7nq3y3G/i4wgRlFbf5/1zQr3wRBiIfNu3d7v0HqcEq
         JvBg71qsIEf0ZeXjjiuGKaNxg6bd+oKa+Ogdc03u3v97O8qTio1eUHvHhl4kEvoIOb4t
         XzDLWQ90vEA+EEcciv+7SvYKl61S26b+x2oQVpwExZ/YvUluABgiI1UiPgDcovn6u3vP
         dp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709243936; x=1709848736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLB+AEOoGVHORFz2CPSFygKm0JXbti6HkSl+J6gRIxA=;
        b=V99pb5bkLxKq1jMauA8c7l6dTcgckA0gSDTsc+6It3a9POzmCYJjoi/etdWppxOlX2
         LT+MapE9cKie/LLwy1LM8IaAehh/plJbnqpHMzhC2e34MNRk3S2SqrFaKTTGrgeO8sTT
         u4uDD8d5Ofv9iww2eYYlhJ5VGcwnxC2RTobqBoLtrMvxT4cxrVj6uACyHY6GFlnSTuby
         RBSP6MOUq/admwq0TM7enCz8hghIc6bX4RnGqvtbWnbyXP5JvpykCHixokBrvFuA0H2U
         byzB4+a+pqYPf7repcZ4QGOogrb0fZuEcj45Sx+a6Fov4ItQP9W8qCLjlZC1IVo6vQ3O
         qTpg==
X-Forwarded-Encrypted: i=1; AJvYcCX0GBbiysMMkbfuo4sFw+StjoH8eCsnUaIExRVmUQfbQ0S+806r72kOwpVSizflsm9hqLJUs4L8Veb3y3P4fMq77rX8x9gIx8NG9ANClc6kUnGhIa0YoP3pVrCNsIcJ/cwOZndtm2wkVfwGxOWs+9Kv
X-Gm-Message-State: AOJu0Yy1q7bNfziQ94Lgdnq0fhnnhsCXYKcX2jhNtR0X68Sy0xSfekGP
	yrpDfbTJLJU3RPaRezF/xA+/ByiO5jEs/88GUZGvFkCGPNePfyHsH3qmoNwu
X-Google-Smtp-Source: AGHT+IGYvPEPGx1GzuuMu3WIOb3s2/UGCtmhtiTQFmVB3GgBAz8SOjLpVIUdUFdzdb47NctxLQy4Iw==
X-Received: by 2002:a17:906:1689:b0:a3d:e2e9:a7f7 with SMTP id s9-20020a170906168900b00a3de2e9a7f7mr118482ejd.27.1709243935911;
        Thu, 29 Feb 2024 13:58:55 -0800 (PST)
Received: from krava ([83.240.61.14])
        by smtp.gmail.com with ESMTPSA id ty8-20020a170907c70800b00a3ed975968esm1072293ejc.28.2024.02.29.13.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 13:58:55 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 29 Feb 2024 22:58:54 +0100
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, Jiri Olsa <olsajiri@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fprobe: Fix to allocate entry_data_size buffer with
 rethook instances
Message-ID: <ZeD-HkC7bsAn_YgK@krava>
References: <170920576727.107552.638161246679734051.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170920576727.107552.638161246679734051.stgit@devnote2>

On Thu, Feb 29, 2024 at 08:22:47PM +0900, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to allocate fprobe::entry_data_size buffer with rethook instances.
> If fprobe doesn't allocate entry_data_size buffer for each rethook instance,
> fprobe entry handler can cause a buffer overrun when storing entry data in
> entry handler.
> 
> Reported-by: Jiri Olsa <olsajiri@gmail.com>

Tested-by: Jiri Olsa <olsajiri@gmail.com>

thanks,
jirka

> Fixes: 4bbd93455659 ("kprobes: kretprobe scalability improvement")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 6cd2a4e3afb8..9ff018245840 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -189,9 +189,6 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
>  {
>  	int size;
>  
> -	if (num <= 0)
> -		return -EINVAL;
> -
>  	if (!fp->exit_handler) {
>  		fp->rethook = NULL;
>  		return 0;
> @@ -199,15 +196,16 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
>  
>  	/* Initialize rethook if needed */
>  	if (fp->nr_maxactive)
> -		size = fp->nr_maxactive;
> +		num = fp->nr_maxactive;
>  	else
> -		size = num * num_possible_cpus() * 2;
> -	if (size <= 0)
> +		num *= num_possible_cpus() * 2;
> +	if (num <= 0)
>  		return -EINVAL;
>  
> +	size = sizeof(struct fprobe_rethook_node) + fp->entry_data_size;
> +
>  	/* Initialize rethook */
> -	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler,
> -				sizeof(struct fprobe_rethook_node), size);
> +	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler, size, num);
>  	if (IS_ERR(fp->rethook))
>  		return PTR_ERR(fp->rethook);
>  
> 

