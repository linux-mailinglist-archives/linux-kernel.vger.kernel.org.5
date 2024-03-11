Return-Path: <linux-kernel+bounces-99133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 004608783CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC0B284B7D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3484AEF3;
	Mon, 11 Mar 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="GG9w/Ley"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1714AEDF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170955; cv=none; b=gMs3p1hycMppPmLzeKYwpBYXYAy9/F3tv26KcSmgZepDSA5mbZXrbhT+HRaEbbK9sqfyuwQS5C/lk440nFdTfm4dGLwpMNiN0hEpSjMgH/QrFBrMCxSO510fQDXyBj/Zq7ILpCssllVm9DYrDJ9H/1/5BrNGxLEFwBo+4u9KiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170955; c=relaxed/simple;
	bh=e6TFE/1KfvvW7dIxLWV8I/Uiw2fbSncmPD9VPYm2nJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3SXcgdVRqdfbsgkzRx19at4FSgR1o29dWp8F2k9sRMDrrz3L1s9W9IctCXe6zmhjjTqbI1OfrSeHi6wg47bqWCyqi0ruIub5DyGVxX3r3yWIa4JtRc7cyTfkjl4MzXFXcuwlwT/L/42EJOdUFuRCntG+ZV9yQRBKWoieLe0530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=GG9w/Ley; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4132a89a351so5616235e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710170951; x=1710775751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oBRdUgazJ1HnLsYGkRF0jKMpPcVcTcXQbKGRIqRZPjY=;
        b=GG9w/LeyV9WgyjVUjY3zdgyZj3jaaKNt9/reFo/vkrZtW/AhbnLCB64bpzoy6bMHG4
         4m1Y8XgP65NeAZ4/5TkSJ0CdG2ZIjC5y3uq9z9Wk72x2CjQsqKmvIiPo9S3PkjdAtMlZ
         kJeFLaA7luKLc7Fnm1iyKkmLmVtcxgnDAQrB/pknRWhwWdH0ZhgIOfoVma5l7thlR3QJ
         fCZHT/aBtHiv26GWyKx1vJ0+7M9QGArXTTsdWbQepwdsfEfYTHTfQA0EaIIEnCIM9sTH
         i3GrHl6sAt8zPQRGY78IWezjMd6GzJzUDUkULKKh11InxGbdS3pjrvCnvqJjpKp5ohfF
         wXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710170951; x=1710775751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oBRdUgazJ1HnLsYGkRF0jKMpPcVcTcXQbKGRIqRZPjY=;
        b=xI1cctb8IwW0QfNts1a3L7NoWXUm8nUlXkOpIrrLqEiosfD9Tdkw/O1UX0f+xjfKyN
         mUxxaocUebhw+Qe32p83vhZdFqtdqngT2g0kfpnaVggLEzwWx69LbSVU4irnOY1HIV5M
         65iRrPEJdDQGbL5KIMB5/Nf3vnlCQVFkY6YQ11Jkm9Wn6r0rCB54qO3HAIztFVgGxYpX
         dXt+VNeILlbih7NJfTRGlKbQyaYuVua44Klt1ikDxSivrw9sRwetPr+P5ErWp9Ize1kR
         KU/8IQ98asvNoE6dR+/OCamFJBfmSTZ/C1Q6ChKUFgClM+CIIe0Tu/25hzy9NBU9Ih0+
         DH9w==
X-Forwarded-Encrypted: i=1; AJvYcCX8Mshg9VjHjYl6BYavP3R/62a4hCej1bytzyYMRs9JFBtK1GfxBHAcQNigoTTC+SrPYbxSSBT30O73dCqvB3X+UamGjszszH3II8HE
X-Gm-Message-State: AOJu0Yw2TTTi6hNWpxAlDY30oChGt6/toXSqN/aEFqBa40zracJpmAPa
	Q9Hp06xwVUf11MXmREIXgxtsO7lgxmd3vJOCR1Qd/1ZV5YKGPDcb7M2bLY31fJ8=
X-Google-Smtp-Source: AGHT+IEwgdh7H+9crLcV9S5SLA+JZoumOzg/VaQuwX7biWBYjQ6DqPv+BHttGcsj9IyOJw9JoIyg7w==
X-Received: by 2002:a05:600c:4449:b0:413:1f5c:baa6 with SMTP id v9-20020a05600c444900b004131f5cbaa6mr5344265wmn.30.1710170951441;
        Mon, 11 Mar 2024 08:29:11 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:5231:db44:25b0:339e? ([2a02:8011:e80c:0:5231:db44:25b0:339e])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00412ff941abasm15941091wmq.21.2024.03.11.08.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 08:29:11 -0700 (PDT)
Message-ID: <e8f37842-1ddf-4241-97f3-b83ffcb32ddc@isovalent.com>
Date: Mon, 11 Mar 2024 15:29:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 8/9] libbpf: add support for the multi-link of
 tracing
Content-Language: en-GB
To: Menglong Dong <dongmenglong.8@bytedance.com>, andrii@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net,
 dsahern@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-9-dongmenglong.8@bytedance.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240311093526.1010158-9-dongmenglong.8@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-11 09:35 UTC+0000 ~ Menglong Dong <dongmenglong.8@bytedance.com>
> Add support for the attach types of:
> 
> BPF_TRACE_FENTRY_MULTI
> BPF_TRACE_FEXIT_MULTI
> BPF_MODIFY_RETURN_MULTI
> 
> Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> ---
>  tools/bpf/bpftool/common.c |   3 +
>  tools/lib/bpf/bpf.c        |  10 +++
>  tools/lib/bpf/bpf.h        |   6 ++
>  tools/lib/bpf/libbpf.c     | 168 ++++++++++++++++++++++++++++++++++++-
>  tools/lib/bpf/libbpf.h     |  14 ++++
>  tools/lib/bpf/libbpf.map   |   1 +
>  6 files changed, 199 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index cc6e6aae2447..ffc85256671d 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -1089,6 +1089,9 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
>  	case BPF_TRACE_FENTRY:			return "fentry";
>  	case BPF_TRACE_FEXIT:			return "fexit";
>  	case BPF_MODIFY_RETURN:			return "mod_ret";
> +	case BPF_TRACE_FENTRY_MULTI:		return "fentry_multi";
> +	case BPF_TRACE_FEXIT_MULTI:		return "fexit_multi";
> +	case BPF_MODIFY_RETURN_MULTI:		return "mod_ret_multi";
>  	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
>  	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
>  	default:	return libbpf_bpf_attach_type_str(t);

Hi, please drop this part in bpftool.

bpf_attach_type_input_str() is used for legacy attach type names that
were used before bpftool switched to libbpf_bpf_attach_type_str(), and
that are still supported today. The names for new attach types should
just be retrieved with libbpf_bpf_attach_type_str(). And function
bpf_attach_type_input_str() is also only used for attaching
cgroup-related programs with "bpftool cgroup (at|de)tach".

Thanks,
Quentin


