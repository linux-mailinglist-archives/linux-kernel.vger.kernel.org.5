Return-Path: <linux-kernel+bounces-92508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D60F687215C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052DA1C22CFB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAEB8663E;
	Tue,  5 Mar 2024 14:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBDqGrd9"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306F086620;
	Tue,  5 Mar 2024 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648453; cv=none; b=CVgKTa3PT/7+mJNieoMWb0GCKmoQ223gmbE7P7MXow1hRLBizvrTPcgKIDRaj1/JUIpkxC7fsWVYb4Cb2WSy/BO/fo6KffcPnF+HKgC9Q3+ISa1XEFGdGFuEguHTQkWgN/zBGMvNlb7vwTb8rt2ZUy/NG9sK3gNPBXSNunY9JQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648453; c=relaxed/simple;
	bh=/mWh2OD6uRPtHKCljyC+mTHt2RIMIS82/N/otIi/3C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+edBKpM7pcbVAnf02VE/Bq/ARlnYH98RQAhe22vLXk9EP4OsF/WelWkyeXRs6Vz0tXCavO/4As3iOyVLKwpuZLouQ1MjPpRwmD8OG/5hN3ReKPr+8K25mzVSqzUrs9UI7saR+u20Lfx+DZb8z1mJFN7teSXKqZAF+Hphx8WVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBDqGrd9; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc0e5b223eso49088685ad.1;
        Tue, 05 Mar 2024 06:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709648451; x=1710253251; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gygWpWy8v8mJ49lyWmrXwRjYqvXWve2mLTt3rfiyYYM=;
        b=VBDqGrd9an0j/SvRZnCV+3Y8YvWU/SarWlVye2HjFpuO5HKsIRRx4Vuj6uQZsLvmEq
         rdWFLKuqNf3NiBaGrxglFqihpnTXmP/bHWsg6FitBJd6hbSjjpb9FiZK8/clkTBlhkDR
         vygUWzhxCEWFKmobIllKWOVo6/QzjhIzd5rMpATd1m8tlRfp2V9mpJsRD0jEviHuYaCt
         CwFA6jdqG8QZSKrwonhfGzSkuTWMJPB2lK+SjsVlAwyobgXtYmdX80u+jSJiM4kr4pEc
         kinuymwRDDKz5no3P9mXnY4pzRnpdnaXNImISlI8506pWhOSXlwHj24AaGBCnPxL8bO6
         SuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709648451; x=1710253251;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gygWpWy8v8mJ49lyWmrXwRjYqvXWve2mLTt3rfiyYYM=;
        b=H2lNYZ7ySvr3oMYDzud653n13kBn6Qfdyv0iYmR9SgNrWVt9x9ygSGOGnKIwBSx+mZ
         b9knfKCYKstohlAwDYSUR1VQzI7DP6YVVkRAwaga5/nZd5nEYtZlf2fwvyzINGJc/0NQ
         zzYkafa/XpUuw2atumjNfIDRvxQBPGUlBWpcsDkBxtLRx/UEGUuiMzVj8Be7Vc9TMapV
         P+rVtxOkVdnOF2SvIrDCh2popkhzhK1xslWo+v+RSMP3MBYsUAp2b0udozZd+Gi71QYJ
         y5yrZncsHm+mP+1PWCIiXuB+Ui0KexvFo3+y9tuuJX1NZRI4x76k1rIWuNBz4Ym2gLAD
         QC/g==
X-Forwarded-Encrypted: i=1; AJvYcCWUZ2DHbbhwUJiEKB1ew4b7+5fVOr1U2IaIgMukEYMwMMJizeztq1erdMgxgZyMTV6s9eZYad14YOdQ5LxlE1vEj0fpoNan0IRe/rin8Ghto/wTONXfqNx33Db7CDwgELoq82pEf49jTBXCPXfH1g==
X-Gm-Message-State: AOJu0Yz7bBt1VcfSezkKF+zrSZJRVQhw0QsEAAh6vnOqWXpIkuf+raph
	8HcaC3QJa9Y89x3qr5OGAO2r3oqYBW2TFo5hkqOIPzdix7DlSp3FsiBqljIY
X-Google-Smtp-Source: AGHT+IHQfQt4GCuvBYtoUPk+xf9yTZtrSLqla6f1Xt7igcViuaIi/iZSooLWfZ3w/wi53+ZkeRqHoA==
X-Received: by 2002:a17:902:9009:b0:1dc:cd2e:fc68 with SMTP id a9-20020a170902900900b001dccd2efc68mr1651067plp.27.1709648451315;
        Tue, 05 Mar 2024 06:20:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001da001aed18sm10782840pln.54.2024.03.05.06.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 06:20:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9e0a8efd-9af8-49eb-a9b9-950ee582921b@roeck-us.net>
Date: Tue, 5 Mar 2024 06:20:48 -0800
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
To: Huacai Chen <chenhuacai@kernel.org>, Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Vyukov
 <dvyukov@google.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, loongarch@lists.linux.dev
References: <f477329e-4ecf-4c6c-82b1-1e9b84443902@roeck-us.net>
 <CANpmjNMZD7-HY9FNGKnWTzHJ+Kibf2++rHj=j+3UTFKZ+Hr+EQ@mail.gmail.com>
 <CAAhV-H4KoFLM1Kf-42CuWbkvRuHOJkBzkudWUNpAY0KMUBqUkA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAAhV-H4KoFLM1Kf-42CuWbkvRuHOJkBzkudWUNpAY0KMUBqUkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/24 01:05, Huacai Chen wrote:
> Hi, Marco,
> 
> On Tue, Mar 5, 2024 at 4:34 AM Marco Elver <elver@google.com> wrote:
>>
>> On Mon, 4 Mar 2024 at 19:12, Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> Hi,
>>>
>>> I see a number of failures and tracebacks when running the hw_breakpoint
>>> unit tests on various architectures in qemu. Some examples are below.
>>>
>>> Is this a potential problem with the unit tests, with the hardware,
>>> or with the qemu emulation of that hardware ?
>>
>> The test is testing the accounting logic (allocating/deallocating HW
>> breakpoints), not actually using the breakpoints. That requires that
>> the architecture reports the correct number of HW breakpoints
>> available. It looks like it's not doing that.
>>
>>> In other words, is it worthwhile to look into this further, or would
>>> it make more sense to just disable those tests if they fail on a
>>> given hardware/platform ?
>>
>> It's an arch bug:
>> https://lore.kernel.org/lkml/Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.com/
>>
>> Back then we decided to leave the test as-is, given it's reporting an
>> actual issue. However, since then nothing has changed and the test
>> continues to exist as a reminder the arch code needs fixing. I suspect
>> none of us have the time to get to that soon, so we can either leave
>> things as is, or skip the test on all the broken architectures.
>>
>> No idea what's going on with loongarch.
> LoongArch's problem comes from QEMU, I have tested on real machine.
> 
> [    7.222500] KTAP version 1
> [    7.226067] 1..1
> [    7.228795]     KTAP version 1
> [    7.232737]     # Subtest: hw_breakpoint
> [    7.237512]     # module: hw_breakpoint_test
> [    7.237520]     1..9
> [    7.442899]     ok 1 test_one_cpu
> [    7.443912]     ok 2 test_many_cpus
> [    7.451298]     ok 3 test_one_task_on_all_cpus
> [    7.456486]     ok 4 test_two_tasks_on_all_cpus
> [    7.462291]     ok 5 test_one_task_on_one_cpu
> [    7.468293]     ok 6 test_one_task_mixed
> [    7.474405]     ok 7 test_two_tasks_on_one_cpu
> [    7.479884]     ok 8 test_two_tasks_on_one_all_cpus
> [    7.485699]     ok 9 test_task_on_all_and_one_cpu
> [    7.491488] # hw_breakpoint: pass:9 fail:0 skip:0 total:9
> [    7.496985] # Totals: pass:9 fail:0 skip:0 total:9
> [    7.503179] ok 1 hw_breakpoint
> 
> Huacai
> 

That is good to know. Thanks a lot for testing!

Guenter


