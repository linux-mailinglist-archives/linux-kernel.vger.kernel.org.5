Return-Path: <linux-kernel+bounces-91283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33552870C43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3604D1C2152C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5B31CA94;
	Mon,  4 Mar 2024 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQdawf3+"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CEE1C6AB;
	Mon,  4 Mar 2024 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587077; cv=none; b=uvsKxkMJVIFVSNQHV5NCivHJXGQ5BKWH/exbBr4YUrjSCvHp9bUdWYFN3GP+eFepnFSGSdh+kJFAP/n4LF371ml6/9Hoo/O0y5pG2D/LlLQVLADIQcNKwjsyNRtlJqcF1x9pjqcxlSpIzSHgVViXRqXGFloR7GQ6rHvSoOaIjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587077; c=relaxed/simple;
	bh=7jAuGE/+EaVPBsvrPZcGHJ81GktKOSGz6Xxy5/x1hDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJdNN+s9kKX0A8CuFlf2x3Egb5Vs5MnLP/PDn3X607N6gHXdSD1EY4Nt0ZagOi5+xPHqs1u9EPbZ1bBNiyILI1aONXakZZiFf6FVFpZoNb8yAgokuyEBI5kkvPs1mNf0CZM0LXrf56xHSR3MFeE17qaa28DVSXK2ZXLyL/SVGSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQdawf3+; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e5dddd3b95so1974974b3a.1;
        Mon, 04 Mar 2024 13:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709587076; x=1710191876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=n6PbsndqMhdr+kbSZx/pY3EeqpGXxBttOp8IgjnIP68=;
        b=gQdawf3+o91teR3/LHin8dgKzYCM/xMWcFujeciWwxWZxfODGwcUvVOwG/RdV01fP9
         PWCP7DD5+zKG70CFQyNC3h7ornU7HtxlK4zAbBRRVBm0ljyFNkNStlCzWehfd6uh5rto
         qdUZQF6H0YwBVNgKArGvTz827Bwm0qsufo7zJ571XVwkd1jADl976IyBA1+/v6Tq7Qif
         F7cRUbeiXyWrhoegOpNQQwGnwvNS5G9Upy1FExzVALq1zuV5Zk+/sHqcM5LGb731gpMx
         wLa35EbiHFp2ev4CR3A2vWqXK8L+BftUv+f+lJ0CoaR75vatYTQDy9BzRBdlFEimHv9w
         WwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709587076; x=1710191876;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6PbsndqMhdr+kbSZx/pY3EeqpGXxBttOp8IgjnIP68=;
        b=W4jkfrSJ9lY4joCkP4xA5HZAvOmqsVhPYgIEnY2AvU9pB6RmJ0bQdEmdKJoxoKStz5
         InVmPRMt8hFxLE+O1mFdq7/qnOiX+NxcXd2Glql/PGFlqQARrts/8AJfOlsYZtVJwreK
         J9Qhx009QpXWM2qEut3L6rlTNVxOtoYkSZFwFxCSxkzTY16zWOWxVeg1G0Amnlvz53zR
         W0cNNIvn5OTdgTSstWwVxlwNqlgqAb13HZPrrw9rIBd9N8/KLouwZ620rWOGJbbG14jU
         ifZLgi47cW8YrR1bN9WVDISJDhikJQkXiaFHeuas6Uw/H834EjKtDj2RSOrVi659Hx+O
         qFoA==
X-Forwarded-Encrypted: i=1; AJvYcCXMdvBMleAFz06diLDC5ZjzDWcuBjVW92OEq1T/x71r7YHQFdkQ26vwGEcbpvYvEgCqiUamCzbVPWT6iN27enbzma+2Qx9L0NrtlCCKqKzLA2PwE0K/LrVo/EBhbI2nhe15AdciFXBko47DY8hBHQ==
X-Gm-Message-State: AOJu0Yw5/op1+KQuQ13fCAw7NEkZOFd5wKVyBOEdZEzXD0TcHaVkw8C0
	O4AAaRSyHaEs4yKFbG/RR2McPxqj/JwzhPiL3dpxO20Coh9/KHhb
X-Google-Smtp-Source: AGHT+IF8a7LBF373kUwtCQ1s3ZQJTVDXWxr8/j/Osz4tLEJRYVY6/73hpr0TEI4A6kWp/JXMtteG2w==
X-Received: by 2002:a05:6a00:2d17:b0:6e4:74d9:6f0f with SMTP id fa23-20020a056a002d1700b006e474d96f0fmr828710pfb.0.1709587075187;
        Mon, 04 Mar 2024 13:17:55 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x53-20020a056a000bf500b006e3b868b8b8sm7686102pfu.130.2024.03.04.13.17.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 13:17:54 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a937b183-32bd-4a92-bc20-57319205b4eb@roeck-us.net>
Date: Mon, 4 Mar 2024 13:17:52 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hw_breakpoint unit test failures with various
 architectures/platforms in qemu
Content-Language: en-US
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Vyukov
 <dvyukov@google.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev
References: <f477329e-4ecf-4c6c-82b1-1e9b84443902@roeck-us.net>
 <CANpmjNMZD7-HY9FNGKnWTzHJ+Kibf2++rHj=j+3UTFKZ+Hr+EQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CANpmjNMZD7-HY9FNGKnWTzHJ+Kibf2++rHj=j+3UTFKZ+Hr+EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/4/24 12:34, Marco Elver wrote:
> On Mon, 4 Mar 2024 at 19:12, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> I see a number of failures and tracebacks when running the hw_breakpoint
>> unit tests on various architectures in qemu. Some examples are below.
>>
>> Is this a potential problem with the unit tests, with the hardware,
>> or with the qemu emulation of that hardware ?
> 
> The test is testing the accounting logic (allocating/deallocating HW
> breakpoints), not actually using the breakpoints. That requires that
> the architecture reports the correct number of HW breakpoints
> available. It looks like it's not doing that.
> 
>> In other words, is it worthwhile to look into this further, or would
>> it make more sense to just disable those tests if they fail on a
>> given hardware/platform ?
> 
> It's an arch bug:
> https://lore.kernel.org/lkml/Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.com/
> 
> Back then we decided to leave the test as-is, given it's reporting an
> actual issue. However, since then nothing has changed and the test
> continues to exist as a reminder the arch code needs fixing. I suspect
> none of us have the time to get to that soon, so we can either leave
> things as is, or skip the test on all the broken architectures.
> 

Thanks a lot for the update and reference. I'll just skip the tests
for now and maybe check once in a while if something changed.

Thanks,
Guenter


