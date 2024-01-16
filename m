Return-Path: <linux-kernel+bounces-27301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A382ED82
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3673B1C22F0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC11B800;
	Tue, 16 Jan 2024 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="eIa8Mqfn"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DE41B944
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e779f030aso10901515e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 03:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705403757; x=1706008557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1H5fg3qxE1UaJpNN5HcoL7Mi/hW7dGf8hmbTiQkpLjw=;
        b=eIa8Mqfn3dI8UlysShF4k5ZfweEXBAjoMMTGH7J6QiH2YTcEANWOan/dJ0CdN3NxGU
         ib0r9dF89Vn7ZYb5lgc1qQgtzTiTV3VgNrzv1juiPnRquXKDG7qh8Gu4MeaJCfPSIqWK
         WPARAoxmycITF4ColYgWKKz6DRhL7dfmqj1x+zMDyIZlv3Fi3q7b7gN7QBjQPI78zV1c
         pu6ZixnvM94TURGJvlINigtGEzMxPOP3eayK4SIsgcF2IWswnN1gCfj9Ors9oWe32xOS
         GvG3HIlSehlZUGmIwY/HO4v9fVZPJRvA+vOqFuLVIvKs5tWGHuCcFEe2+/ZmL779Cg5x
         CibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705403757; x=1706008557;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1H5fg3qxE1UaJpNN5HcoL7Mi/hW7dGf8hmbTiQkpLjw=;
        b=VCgW39cTvK0MlTzl2DZJo7zDXHCBu6OMsFfy4MDoPcjgITdQpckGZ8jEZCHdZxkFir
         fE8JrQCwrFRqnp/GcaQfMtV6vG1BRpSTYVP5W8mWYNh2AwqXycW7wDS2TGolVs2xFQgY
         S0w29DOXkH1pFjgLpx/birxlhW3rlxrki3fPlP0p3wVSICOk4vwcWUjNOX2jKiKiEvh9
         gr3GwuSAxhZNYozWFptoIPz6LFmDXyyT2IIqSvrFXRCfCNWEsS+lkmKGt9cWIwQmSud2
         VjHJn4UteV3tuCFx7WTKvi4uiDGEDjDugDrGDFNcwhkmFM0o4EgArhY95Fpq7II+iosN
         B5SQ==
X-Gm-Message-State: AOJu0YyuiHAxVrGUsn4xyRtQVgsv9Iusz0OXrtoI0igiiBjOq25KDocq
	BLdHYYkJhjVGQo2KMOIz0u2DbSQyakfSLQ==
X-Google-Smtp-Source: AGHT+IEve4DyvKwEDMYRLCp3u85D28V8f2NtPTS8NynZndR9e2f5xLAWBKp2rzXWSShFDp7Twdi3BA==
X-Received: by 2002:a7b:cc8f:0:b0:40e:8609:621e with SMTP id p15-20020a7bcc8f000000b0040e8609621emr296634wma.5.1705403757591;
        Tue, 16 Jan 2024 03:15:57 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:ef4f:70f3:fab9:b04e? ([2a02:8011:e80c:0:ef4f:70f3:fab9:b04e])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d4562000000b00336471bc7ffsm14282096wrc.109.2024.01.16.03.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 03:15:57 -0800 (PST)
Message-ID: <ec813c26-696f-44c2-8681-6bf13ce6b5d8@isovalent.com>
Date: Tue, 16 Jan 2024 11:15:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1] bpftool: Silence build warning about calloc()
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240116061920.31172-1-yangtiezhu@loongson.cn>
From: Quentin Monnet <quentin@isovalent.com>
Content-Language: en-GB
In-Reply-To: <20240116061920.31172-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024-01-16 06:19 UTC+0000 ~ Tiezhu Yang <yangtiezhu@loongson.cn>
> There exists the following warning when building bpftool:
> 
>   CC      prog.o
> prog.c: In function ‘profile_open_perf_events’:
> prog.c:2301:24: warning: ‘calloc’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
>  2301 |                 sizeof(int), obj->rodata->num_cpu * obj->rodata->num_metric);
>       |                        ^~~
> prog.c:2301:24: note: earlier argument should specify number of elements, later size of each element
> 
> Tested with the latest upstream GCC which contains a new warning option
> -Wcalloc-transposed-args. The first argument to calloc is documented to
> be number of elements in array, while the second argument is size of each
> element, just switch the first and second arguments of calloc() to silence
> the build warning, compile tested only.
> 
> Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thank you!

