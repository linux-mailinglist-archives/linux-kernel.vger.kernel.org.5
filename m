Return-Path: <linux-kernel+bounces-68059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87F857572
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBA928796C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4A0125C7;
	Fri, 16 Feb 2024 05:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et6N/g0N"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEDADF46;
	Fri, 16 Feb 2024 05:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708059605; cv=none; b=ph3+7QJV+Tyfav02kmN+ZrZO2aQOUu/JswGdeJbb7JsqwP8TYLMysOHU/qSuehF/iccf/i6lZxistl6aLuDuqqlXVxbH1POXgJcI63g2bposN5mCadPDU8ichw7zsA8A1o3hJIbQfWNQNacgyTdT4KwnpO2BE71hB9lavxdCj4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708059605; c=relaxed/simple;
	bh=oYUDxIM+AIWEDY2ylmlMWzfSu+d3mhJH6COgS6Qise8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnvQIbHVKASyXV/7qgSVEcs4kYfaT2t3F81xUtnumswNnYXsmMBFRuIlY3s1tpE+iuZO+r3oq6FmV6MbECpa7/pxV13a5VQrsS6cbv4uh9QT2ZBoQPO5S0nS7wlXuNyYHkr9vtVsr2E14hpDEwQZu9gP3vqmom1p61oAaRAuwIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et6N/g0N; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-299372abcfeso61735a91.1;
        Thu, 15 Feb 2024 21:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708059603; x=1708664403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=R8rTZJo3XulomWKeBIkALQPOeF/LPkX/QmkMlagT8yU=;
        b=et6N/g0N5W5hN+YHGOJsORs8pILcBtibQVMRZfg5HuVSx4ta2BqQb/vIl+DMNKjp2I
         a10wAOfbuZKNN0gan6bqjKfpjpQcqPDHra5/aWVg4KX2u//bHg6gR8LUSUPyYukDs9TF
         44fGgTYRXa0YHsCkk5XukPXcWQAn9eM9MuAjusEAM+sD4yqIXa/WXs3TX0LzZyUwp+C4
         DuJbC5vWNe1IdXSAf5eUfCG2UaamEYKD+3in9HGIsfws8Uv3mYzcR47NHp1lCSem5g3/
         bhRRenNZkEkGQmlof5d7jEz82Wt83kX26GKdtlNf1yeuZ44C7mMBASDfF3SyN9A23ySl
         5ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708059603; x=1708664403;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R8rTZJo3XulomWKeBIkALQPOeF/LPkX/QmkMlagT8yU=;
        b=wS58wWI+P5IgWh4yw80UumRzF14SfNdWVHsDaB34+83HlsRnXZXjnA5vfw/GxTXAzT
         L5ygiTEdzRGPa8EzI/8UM6wYnHaVEZG/oI0bTUIk4xWyMmvNTlUzwiAz4kABkBEmI1Iv
         DSZBRLKIcCMFB7+HxOUCpqCETBL6OPpdsQCbZm+515HWqZWR+MyCs67ytXUkapI2kaTy
         /ghCRwNDXWpG+RVhN02DUEB3OgIcVVX7JD1sd1lKuGZo69eIodSeSdSGXruIWWG1TAQ5
         KBZNob9rTZ34hD8xOk7IkOxBa9raF4O5BX1TkMSM/CUNt3I7ZQgOEi4JTbCsSaQs4cQw
         6+oA==
X-Forwarded-Encrypted: i=1; AJvYcCU6b4IgpmNRCFx7cjDeQRxcejiq/H7kxYSPNlZU/Ul2noN6ljQ48NU8sgeSMpIviFwio52UQswawF65xmoWsQwJgLpFt1+MQlztHHkQNmYf7F36YAnsaCkiCfUu199FsXB5+4eHdbuAUKFN
X-Gm-Message-State: AOJu0YxMzRFV8RjASu5EKcdw2axyquOXNIkUrhN7J9L0jL6p6+VTWdjv
	vA1sWQfszzldB31gbJvp5qaYtOrI2Lcl30dP7IYnYjhqSyGqM/sK
X-Google-Smtp-Source: AGHT+IFZnMCSZZMHI5HqkHzw0pSkjPfYED8NqoONayVP3+L38l5GkP6xWqyy2Xr6LYeQXAY0lpg4pw==
X-Received: by 2002:a17:90a:ba8e:b0:297:2abd:cf54 with SMTP id t14-20020a17090aba8e00b002972abdcf54mr9976211pjr.5.1708059603361;
        Thu, 15 Feb 2024 21:00:03 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id st13-20020a17090b1fcd00b00298ca3a93f1sm4319619pjb.4.2024.02.15.21.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 21:00:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <21fc345c-9ebf-4057-b0d2-565f65d41490@roeck-us.net>
Date: Thu, 15 Feb 2024 21:00:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: John David Anglin <dave.anglin@bell.net>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
 <a7e9691432374000b9566a0201d004e6@AcuMS.aculab.com>
 <c22f28a2-b042-4abe-b9e4-a925b97073bb@roeck-us.net>
 <4723822c-2acf-4c41-899c-1e3d5659d1d8@bell.net>
 <1e302d8f-4e94-4278-b556-b8fc54956efb@roeck-us.net>
 <e73bdc36-5fb1-4ea8-9f96-608eb1a9b6af@bell.net>
 <a7b70196-2387-4532-94ac-81220fd07088@roeck-us.net> <Zc5pGIDgLrM0uepc@ghost>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zc5pGIDgLrM0uepc@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 11:42, Charlie Jenkins wrote:
[ ... ]
> Seems like a promising direction.
> 
> It feels like we have hit a point when we should "close" this thread and
> start potentially a couple new ones to correct the behavior of
> saving/restoring the PSW and this behavior with unwind.
> 

No need. Found it. It was a qemu problem. Kind of obvious, like hiding in plain sight.
  I'll send a patch shortly.

> I don't know what the proper etiquitte is for reverting back to a
> previous patch, should I send a v9 that is just the same as the v7?
> 

Not sure if there is one. Just go ahead and send v9, and tell the maintainer
to yell at me.

Guenter


