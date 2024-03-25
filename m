Return-Path: <linux-kernel+bounces-116542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B2E88A9E7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E881AB60B05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291E913D602;
	Mon, 25 Mar 2024 07:55:20 +0000 (UTC)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9808413DBBC;
	Mon, 25 Mar 2024 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711345251; cv=none; b=VRG4AiGGTe/wDHigZwq/OyqlkTnNCtU0T9Rr0dUbKZ6660HAKXnMZwIs+A25yivO4TTXyQzoFeJVV/u1m/6zUrmI527rP6VRSgRyOWj93jiFmpd90rjPW07V6KAEeG6/bLazlVV6jWlrj01kwpWHEomOK4Xp9Pk6RUD7XhLI81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711345251; c=relaxed/simple;
	bh=o8lhs5WjRnLwEjNCgrAeZ28LTGyTTXMeBRtuzw8ajNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dq9mquSWtD4JnNeNh32Exrpg+4V3uSCRJYga5srqjbapzvQXXSjeZIhZHma82SRleztxOjKsDrZ9ra6moNoEYlpM9Um0R1dm0FwaXvv1DoPwEQBflaIO+VLbvaCJdfPyA6xBA+5vq4fAsGwZMNwS+azNDZyHpo7aN192gY/rKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56bc5a3aeb9so5087914a12.3;
        Sun, 24 Mar 2024 22:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711345248; x=1711950048;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BBDsWRAfxn16V9JUrxU5fWOrMBwITmAW8YLJ5f7n/o=;
        b=lEusBV7S6R+9b/qaXNLf5iVtfpN9oOcE2pnZwl1YkzY3TqtrIw5IiW1kIcF+O7DLfR
         WaYXVwlxjTFaW4/NlU1pI9ql2ry6CmpeJjFVms7Jp7VQv0k6BkLJlMU63H9hEehuXU8M
         Da0dKn9LdlbBkkemlcVoIJJmn6dUyTziJz0bGhNsgw0JGwGWPMjxNSLPD/pp3R3N3a81
         jRUTMqYarhD0j3kGPjXdKl7JgvoWtmwLwCiyVAlz9FClNTjuc8+7+0ypUu7wmbBwHTm4
         kW5+dGCwLqzcgp8m6vDLYqtHHYDAoQTRQTpl2MmMTRRPD2J9wFTZnl3Pzz5s+h5R25cJ
         6YXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmiW/nUbJj50wO3FRfyKDymxskSS4F1WNagqt+JHJLmZMqrL55V92QhCqdgO/MaWWQ/0F6/zDb0iZqI/f6carMXh1z/zMn2klygVi1wj9CRU9YXrvwDwe3BZDst5RCMeZj2DSk
X-Gm-Message-State: AOJu0YzyPiUCpNWdoIvy1q22TGfQ/kDzZdXQV4nd7BrXKsViHPTJWcXB
	oNQoIDvOYpArECzlmPGsmbUt3ds2QpRhA5YKLcqkQQwk6tI+dKionHK+0aLM93Y=
X-Google-Smtp-Source: AGHT+IEqtflDtqS1HFWDsVwRRO7RhRDn+Q89RELnYDSa9+93l8NQM2xCG3O/TJUIvpypSwzfXF5NIA==
X-Received: by 2002:a50:d5d5:0:b0:568:d74f:bb8e with SMTP id g21-20020a50d5d5000000b00568d74fbb8emr4103611edj.3.1711345247692;
        Sun, 24 Mar 2024 22:40:47 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7de9a000000b0056c08268768sm1431281edv.10.2024.03.24.22.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 22:40:47 -0700 (PDT)
Message-ID: <e35cc021-7f17-479c-bd7c-ea6df836a04b@kernel.org>
Date: Mon, 25 Mar 2024 06:40:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 119/715] libbpf: Add bpf_token_create() API
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-120-sashal@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240324223455.1342824-120-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24. 03. 24, 23:24, Sasha Levin wrote:
> From: Andrii Nakryiko <andrii@kernel.org>
> 
> [ Upstream commit 639ecd7d6247c48a0175f5b458b648f5d4b6dc34 ]
> 
> Add low-level wrapper API for BPF_TOKEN_CREATE command in bpf() syscall.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Link: https://lore.kernel.org/bpf/20240124022127.2379740-13-andrii@kernel.org
> Stable-dep-of: c81a8ab196b5 ("libbpf: Add btf__new_split() API that was declared but not implemented")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   tools/lib/bpf/bpf.c      | 17 +++++++++++++++++
>   tools/lib/bpf/bpf.h      | 24 ++++++++++++++++++++++++
>   tools/lib/bpf/libbpf.map |  1 +
>   3 files changed, 42 insertions(+)
> 
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9dc9625651dcf..d4019928a8646 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1287,3 +1287,20 @@ int bpf_prog_bind_map(int prog_fd, int map_fd,
>   	ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
>   	return libbpf_err_errno(ret);
>   }
> +
> +int bpf_token_create(int bpffs_fd, struct bpf_token_create_opts *opts)
> +{
> +	const size_t attr_sz = offsetofend(union bpf_attr, token_create);
> +	union bpf_attr attr;
> +	int fd;
> +
> +	if (!OPTS_VALID(opts, bpf_token_create_opts))
> +		return libbpf_err(-EINVAL);
> +
> +	memset(&attr, 0, attr_sz);
> +	attr.token_create.bpffs_fd = bpffs_fd;
> +	attr.token_create.flags = OPTS_GET(opts, flags, 0);

With openSUSE config [1], I see:
bpf.c:1293:60: error: ‘union bpf_attr’ has no member named 
‘token_create’; did you mean ‘iter_create’?
bpf.c:1293:60: error: ‘union bpf_attr’ has no member named 
‘token_create’; did you mean ‘iter_create’?
bpf.c:1301:14: error: ‘union bpf_attr’ has no member named 
‘token_create’; did you mean ‘iter_create’?
bpf.c:1302:14: error: ‘union bpf_attr’ has no member named 
‘token_create’; did you mean ‘iter_create’?


[1] 
https://github.com/openSUSE/kernel-source/blob/master/config/x86_64/default

> +	fd = sys_bpf_fd(BPF_TOKEN_CREATE, &attr, attr_sz);

And:

bpf.c:1304:25: error: ‘BPF_TOKEN_CREATE’ undeclared (first use in this 
function); did you mean ‘BPF_ITER_CREATE’?





They are added by:
commit 35f96de04127d332a5c5e8a155d31f452f88c76d
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Tue Jan 23 18:21:00 2024 -0800

     bpf: Introduce BPF token object


But if you should take it or drop this all, I don't know...

thanks,
-- 
js
suse labs


