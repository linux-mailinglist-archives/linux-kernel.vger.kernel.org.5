Return-Path: <linux-kernel+bounces-52662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80651849B28
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08361B268D1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FAF1CD0C;
	Mon,  5 Feb 2024 12:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY4wD4NG"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F11C290;
	Mon,  5 Feb 2024 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137628; cv=none; b=A1KHdtkVgD6KAmeywJMDrppgbb8z9XKmk7VcgDT/bRNVuqAEXZgfpGbRZ3OSUOfV+CmMwAfNbPxL9GYGH4mFM2WxmhDwJL+BOC9D0O2XiPQm6ueGGKZf1x4+q6Aj5W0W7fJJYKDZnBuJQQZNBmh127+Rz1bZYbFiwK3QPz94voQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137628; c=relaxed/simple;
	bh=OVP0jm241xg6FXKPFRapsumIO+jdWqiTr5kgFWFV+mU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fRKpgSM+TtWnwTp4/CpMCUZA+MfkAHxGIo6TDEcR7Eq9t8cMh2dQZ6adj4b1DAGLT2dJcQHka6gpe5AT/naREVyHf5Eg1Dim6qBtrh7Cl1ohRBkKbezMbGMfiUIURHF+7ncicHIKoOqRtNkUnPZv0TBEJcp/h406Kvo4z8bfwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QY4wD4NG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-511538be947so617451e87.3;
        Mon, 05 Feb 2024 04:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707137625; x=1707742425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OVP0jm241xg6FXKPFRapsumIO+jdWqiTr5kgFWFV+mU=;
        b=QY4wD4NGC/eLsovmEr5qz7FK+vQHuvRdgiwBw6xZpySkvJI2+ETZwvhNtaJ9OqfRnR
         ZZfivhWV7q3ec4H6oOOXNOWlvvt7gc3HQxuL3bHd15wU4toPsZbyASvhsSOIUTIBgsyH
         LZXBFphG9rhBlC1Em66lRQUIAjMQj179YO/3gijs14vnCEiBv9ulqGKiqjNMZHUQPpRR
         /COKwDgQ/JFAxc5TXklyDPgAjYcusW/c1kOAYkb4+0+rszuL77SyA/km/OXEUcuwTVT9
         FWTt8+zts3kbCPgw9OaMt6xx8jn3TawyqUWpf0QzmW4Arc0j4ikim/B2rAMss24mi0nC
         1bUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137625; x=1707742425;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVP0jm241xg6FXKPFRapsumIO+jdWqiTr5kgFWFV+mU=;
        b=lza426a5TPe/UC7JQF0vyrjTTLZ8eoqvC59lk0NgYhJZuWbbomxhIQJI7YFeeTmN+3
         MHavIoF2NHlvXSAzgfQnkU8ir3RNSbKehvSH9OUeKbpBLIedtDUEn3U0l1mDb7f/Dkbp
         k75vjfw511R2GHZKMzEFYZes8CSNh5JScA6Huwi2h2HkmmCyKOp6RoI/5gAc1MOP9Zua
         nDJhFCR6Na8dLpLvu6dtMEzLnba8n30hEOji22Wwa5fl6VvO5+fHCqvavYyVVBVrTgLp
         fmrEx8nc/H0DFRAReoJUHLe9GMzb0umjRSoEVYBnI8PMr46Nvxxq0FghbtakFxiBtDNw
         rp7Q==
X-Gm-Message-State: AOJu0YzCwD/l5tKVNTUFvHbBqnB1x4GO5ydROLikMWt7cpq7ALPtFQQz
	ujlITG2+wIWBk/eJJ7gxJNq4Nnz+j0HvSeFiUfaOvy+yf+vtMdifg8w3YMkoSSY=
X-Google-Smtp-Source: AGHT+IFzm42w/bTXEZZa5pmalyww7RKGGz4XMqCQvCZzL49dJRWuXsaAuxtvenBIUQJDjUf6b3HHcQ==
X-Received: by 2002:a19:7605:0:b0:511:5660:69d4 with SMTP id c5-20020a197605000000b00511566069d4mr171522lff.36.1707137624637;
        Mon, 05 Feb 2024 04:53:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUigzN0DY7OYH0RoVMhHYOrb3szqBh/xBaF8YmvwhpptML//gx5SSEk3d2Uq8SZ1TFzXQxAY/GDHivG23G7uPSNLE/AH1Zg8OtWvNlutI8M9AfePYYfVE2wAHIk1VbrsM6N06TlGgid4s4G/YElijvvLo9dvfj0tA==
Received: from ?IPV6:2a02:6b8:83:1506:8b8c:af7e:d3ba:a153? ([2a02:6b8:83:1506:8b8c:af7e:d3ba:a153])
        by smtp.gmail.com with ESMTPSA id i11-20020a056512318b00b00511525b9d57sm230097lfe.43.2024.02.05.04.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 04:53:44 -0800 (PST)
Message-ID: <95711933-415e-4a49-a55b-8477a990a0e7@gmail.com>
Date: Mon, 5 Feb 2024 13:54:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add UBSAN section
To: Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240130234634.work.003-kees@kernel.org>
 <202402020154.0266109CBF@keescook>
Content-Language: en-US
In-Reply-To: <202402020154.0266109CBF@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/2/24 10:55, Kees Cook wrote:
> On Tue, Jan 30, 2024 at 03:46:38PM -0800, Kees Cook wrote:
>> The kernel hardening efforts have continued to depend more and more
>> heavily on UBSAN, so make an actual MAINTAINERS entry for it.
>>
>> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
>
> I don't see Andrey on lkml in almost a year, so I'll drop the entry for
> now. Andrey, if you want to be added, just say the word! :)
>
> -Kees
>

I occasionally read that stuff, so I'd appreciate if you'd kept me in ;)

