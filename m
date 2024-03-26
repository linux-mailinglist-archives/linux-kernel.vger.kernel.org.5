Return-Path: <linux-kernel+bounces-119238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AC788C605
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA2D1F6508C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FC313C82C;
	Tue, 26 Mar 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdLWA5mw"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DCE13C698;
	Tue, 26 Mar 2024 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464971; cv=none; b=gPXX/lSW/kF6yuHXTFpiIH+RHsvwN2cubmKoM8GE99P5uQObF9c4xtdqEjzER1Y8xXN0me1JLtXuOGL87Y2ullpXmurpPP3x+okUKeV2Cz2Bm+1REDOd2I4heuo0gsvaP613AxD36U8EMAuyzLVoR8K3jxJreH1QIdihJpqVPQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464971; c=relaxed/simple;
	bh=Ao9xrtlBjjMHKg6mAXNmAgHvzUgtjPOcVb3C9HD4Ym4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C/OHBB3EDxMx8JLjpA4q35YfhyAicWCADkTOQgn9EQtAxeZhs8pQzInAzTIVTSF4AEVCra/x9pewTtVKmQgVGgSGaU4p7hAJ2xY0tkQLgdbi2Z9ugGTEwPNPUXmsllLyA3TcLXKt1atuEK9AfjpTcwgsS4mRsYyI7mom/YGVyEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdLWA5mw; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e704078860so4028139b3a.0;
        Tue, 26 Mar 2024 07:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711464968; x=1712069768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ea+4Fw+41iIKXXGA7q/TyXxJtlrOYEAjwc3VHw2gqU8=;
        b=jdLWA5mwVzj1M3SH3c2iJjgbbd4ecuL6BK+Uka3QvCFzuf4ZjfnV+9qV+BAaoRgmWv
         EFGEAQHNONtzsGF+86Z0NCjMPQJzwz/C1q/CTtSC2WVAU+6OQVqhBzq3WlXh+61Tx21c
         3gvfeg7+w2wHktigwNPJPhh4w4DotQ6bFEKtZoeRRkX+Qg7qNPq5pCX+Fds+shRDY9Q+
         VSGQBazb+4kMPPPcF17Gtt3ZIy1Dc4SDbBtPp6KtcsGkqfcMQ0CM1fKsC/ILOQHN+1f9
         tNUsnvsjN5CzK35B54F9X2EA8yoZrJF0xQylr9PbhXKerPHPDCcLQ4Lxpp7QyaYr4jOv
         zePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464968; x=1712069768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ea+4Fw+41iIKXXGA7q/TyXxJtlrOYEAjwc3VHw2gqU8=;
        b=Fy4InEuvQHBpAWfJGGvQ8W5UidJXHmz4/IavyaLnYd/wpQH1rc2HbeUfX+h8XqKujG
         edaUEJQYUD8y9qFvw5FlTSOCUp8qGcMSzr3HerFzDKIaFNMQ89M6hALgpaNBTL8KAhFd
         1kIhLs/P2re1+Xlsh4/phmz0r+txiOipTEKUdhESgBo9cl5qMnhRC9nzMumkVRK2p5L8
         RKe9ppPnvFW3tshhWC1JLLcy7RmhrQGsAp+rAVM7Pw8g/Xe6Jxy0A0EgQIsfOJUIfU3O
         uDQ2bhuFP1IkaSuOycGFRwQA3AZs6cIHunXPTFvm+RRB3zafSGFIjXoAR6czIzhufy0U
         wR4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwshkcb3LijR+lwKVc4Pc22nl1SZqW+IMHgQ79iMg7pllf+JgvTnP8/h2+L33WOM4I1PKp43hcYQvoMGaZoujZpijSHYF2iu2Nfhb5eOxNZtg+H0KCkoMkU4qvdTZXcz+Q
X-Gm-Message-State: AOJu0YzbGaLqfA5KjCt7Yoo7VeU7tVWcgMTPXYzHhI1qn1cERTWsjB/Z
	y9AcHmDEuTaYpAILNNx+5gqRzCKyVTz7iE5gKIAoHWPcSCDCFXKM
X-Google-Smtp-Source: AGHT+IHutcjK2KIIFE7BfCUSIhG136DuJ9KPGu7ULPaOdcq2MXtZjrAcep2ywRxg5COswSSU6S9AxQ==
X-Received: by 2002:a05:6a00:4656:b0:6ea:950f:7d25 with SMTP id kp22-20020a056a00465600b006ea950f7d25mr1134370pfb.18.1711464968309;
        Tue, 26 Mar 2024 07:56:08 -0700 (PDT)
Received: from [192.168.0.104] ([117.147.31.37])
        by smtp.gmail.com with ESMTPSA id p23-20020a056a000a1700b006eaafccff73sm2959677pfh.212.2024.03.26.07.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:56:07 -0700 (PDT)
Message-ID: <47529e7e-437e-4601-a5dc-518b38aaf496@gmail.com>
Date: Tue, 26 Mar 2024 22:54:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] libbpf: Add bpf_program__set_section_name api
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240325154737.3754820-1-chen.dylane@gmail.com>
 <CAEf4Bzag72gYXWJ2+mPnWaysyTK0OC3NjnasxNsb+N0NxXY2fw@mail.gmail.com>
From: Tao Chen <chen.dylane@gmail.com>
In-Reply-To: <CAEf4Bzag72gYXWJ2+mPnWaysyTK0OC3NjnasxNsb+N0NxXY2fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Andrii, thank you for your reply. I read the apis again in libbpf.h, 
as you say, it seems that this patch no need. Thanks again.

在 2024/3/26 上午1:25, Andrii Nakryiko 写道:
> On Mon, Mar 25, 2024 at 8:48 AM Tao Chen <chen.dylane@gmail.com> wrote:
>>
>> The new api can be used to reset the function we want to trace in
>> runtime. So we need not to change the code again when we just do
>> minor changes to the trace function in kprobe or other ebpf event
>> type. We can replace the old section with new section passed in via
>> parameter. Maybe the following scenario we can use the api:
>>
>> 1. solve "*.isra.o" issue caused by compiler in new kernel
>> obj = offcputime_bpf__open();
>> bpf_program__set_section_name(*(obj->skeleton->obj),
>> "kprobe/finish_task_switch", "kprobe/finish_task_switch.isra.0");
>>
>> 2. dynamic adjustment for trace function offset
>> obj = offcputime_bpf__open();
>> bpf_program__set_section_name(*(obj->skeleton->obj),
>> "kprobe/finish_task_switch+23", "kprobe/finish_task_switch+45");
>>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.c   | 24 ++++++++++++++++++++++++
>>   tools/lib/bpf/libbpf.h   |  2 ++
>>   tools/lib/bpf/libbpf.map |  1 +
>>   3 files changed, 27 insertions(+)
>>
> 
> This is a wrong approach. SEC() is immutable and serves as a hint to
> libbpf on program type and possibly some attach parameters. But after
> that libbpf allows to override all of them though APIs like
> bpf_program__set_type() and others. Attach APIs always allow to
> specify all the target parameters, including kprobe function name and
> so on.
> 
> Please check all of the libbpf APIs in libbpf.h.
> 
> pw-bot: cr
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 96ff1aa4bf6a..94f32e845c61 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -8576,6 +8576,30 @@ const char *bpf_program__section_name(const struct bpf_program *prog)
>>          return prog->sec_name;
>>   }
>>
> 
> [...]

