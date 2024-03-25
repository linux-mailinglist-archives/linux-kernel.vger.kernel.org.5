Return-Path: <linux-kernel+bounces-117262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B4C88A961
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2131F33F95
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719F514D29D;
	Mon, 25 Mar 2024 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnYD5G/Y"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F0149C6F;
	Mon, 25 Mar 2024 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377245; cv=none; b=q+8ao3IvSkzxHgc2RzOb9gDH4O5pNVxVg+uAePRPmhMPzjHsnEB1MAI+doMdGtnDgwO0UNidQtv5+RhE1C02oNv4Ab+5fRF1fnJO2d716Jlm/rGPnqMKi44eioK88QWf5BZkshowqzheVI//rXM5w5e1MrzjvhxE1+MTBLM8vgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377245; c=relaxed/simple;
	bh=aF/hdXoyuNEwdg8VhhYA2uJcT6yAdCvCXHWAaiYyXA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mANbpmxKdOdJHDsXNlwMAMjmKAEBkerzr8E8ymfL01fCJdEYXTYseDtRAG6/1bWRoxhvwh52WvE7ZpiFw1kG9d3Q9qn235OrY7mhXhQT8K5xiUht+fWL1znMg2NRPbvBdDlU7ED2oFD/pFAAcCk7vGJyRCPcvl9JVUU/OUNG+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnYD5G/Y; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so3042046a12.2;
        Mon, 25 Mar 2024 07:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711377243; x=1711982043; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=W2Ae/aRm+R6KLtdEOaXVq1DYIYz+SFJsnYdm+gzisEw=;
        b=mnYD5G/YzHhFW1/97EO3/qCp7mLlvytWOp0lN6F0t3E8m2HY5r3j5LLWfZKgVCiXSD
         KOY2X3RFUnj01ow3LJgau9QUGscj+IbkXir0KPVux2eHnjAxpuPI0stj99LzdEjWalYI
         sZgwbRZr7dM04yfvPbRcdyLLSsmMxosVLw8EGHFMubL5sNalA6OVY0X7Ad0LZYfOe41Z
         2n5EPYoPsRWi21Ysycb0Vdi61SAf3eqGDvVRIf/JSlJ8bXaP1bn5XAMu6UvAe1QDZOyA
         rLfpRwfaJJdsDkZiALopy9J1ZXw2mAwIif4t59ypYjmdh/ftzgTvEEo63OTh6pecbLYr
         8EPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711377243; x=1711982043;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2Ae/aRm+R6KLtdEOaXVq1DYIYz+SFJsnYdm+gzisEw=;
        b=mH/PZUAw77fMM/gF8dbiEU6IpteTWni+mBecDyellXJvdcgVl3OiRc1B4i0II0By6Q
         K0T2hR9In2s5vSxiYu2SyRc5h+RtF8NnOoyO+RQgpDhL9ZuZUBypZwqKN8ZKsVyDxg0k
         Vbk6skEzpU5Lp6Kxm7Hsq6Cc+Sa+hez+ajDgV9NBZq5bc0FPKReL7vRiy0gk1vkxXWx5
         QWWyUR4ldl8Bct1c5ASuY5ZSwTEvSgJKItmRU6XoVhStWn9fsCVUNe5UxnhNnTWsc8LG
         dxB/lfeP2x5TNKvCcgeNc9TtgTPKM1/sBpVt9BOaX/9cG5L0LzctTN0JRMG0vT6Cp7t7
         zBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnyhuI50qY11R9gW1IHwnP7kshUYIgddlMtUgBQjjBEFNlTrkDkCyTWl/F55aQEKcJB58DWdpozBLEIr1KIrXrzXu47+kt+3DLJWf+XVagXIBhoBPn9EGW5UvkAtFpDZiEhhxYs7U=
X-Gm-Message-State: AOJu0Yx6aB93Bm/TMF6WIDNMCrY3apRANaZVNT0VcLV5Nt8Ot5fGUUIZ
	GF6+toD9v+7OvHsc4wbl939ksqAndcRVteO/i+2Z4h+zQdxE5olr+0OF7llL
X-Google-Smtp-Source: AGHT+IHq5nUELyoTy6vMa40FVVCmP/FIFIZe6eQK0C5vBEG4Rq9Og5p0mHaUAkZmDLP/ugK/5Mszrg==
X-Received: by 2002:a17:902:934a:b0:1e0:3b5b:ed5 with SMTP id g10-20020a170902934a00b001e03b5b0ed5mr51783plp.56.1711377242917;
        Mon, 25 Mar 2024 07:34:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b001e0937a77e8sm4686250plh.200.2024.03.25.07.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 07:34:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a9ac59cd-82db-45a0-9f85-ec3880c54dbf@roeck-us.net>
Date: Mon, 25 Mar 2024 07:34:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "sh: Handle calling csum_partial with misaligned
 data"
Content-Language: en-US
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240324231804.841099-1-linux@roeck-us.net>
 <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <059d03a5da257660fa0bc188c6cc8d0152e97704.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 00:39, John Paul Adrian Glaubitz wrote:
> Hi Guenter,
> 
> On Sun, 2024-03-24 at 16:18 -0700, Guenter Roeck wrote:
>> This reverts commit cadc4e1a2b4d20d0cc0e81f2c6ba0588775e54e5.
>>
>> Commit cadc4e1a2b4d ("sh: Handle calling csum_partial with misaligned
>> data") causes bad checksum calculations on unaligned data. Reverting
>> it fixes the problem.
>>
>>      # Subtest: checksum
>>      # module: checksum_kunit
>>      1..5
>>      # test_csum_fixed_random_inputs: ASSERTION FAILED at lib/checksum_kunit.c:500
>>      Expected ( u64)result == ( u64)expec, but
>>          ( u64)result == 53378 (0xd082)
>>          ( u64)expec == 33488 (0x82d0)
>>      # test_csum_fixed_random_inputs: pass:0 fail:1 skip:0 total:1
>>      not ok 1 test_csum_fixed_random_inputs
>>      # test_csum_all_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:525
>>      Expected ( u64)result == ( u64)expec, but
>>          ( u64)result == 65281 (0xff01)
>>          ( u64)expec == 65280 (0xff00)
>>      # test_csum_all_carry_inputs: pass:0 fail:1 skip:0 total:1
>>      not ok 2 test_csum_all_carry_inputs
>>      # test_csum_no_carry_inputs: ASSERTION FAILED at lib/checksum_kunit.c:573
>>      Expected ( u64)result == ( u64)expec, but
>>          ( u64)result == 65535 (0xffff)
>>          ( u64)expec == 65534 (0xfffe)
>>      # test_csum_no_carry_inputs: pass:0 fail:1 skip:0 total:1
>>      not ok 3 test_csum_no_carry_inputs
>>      # test_ip_fast_csum: pass:1 fail:0 skip:0 total:1
>>      ok 4 test_ip_fast_csum
>>      # test_csum_ipv6_magic: pass:1 fail:0 skip:0 total:1
>>      ok 5 test_csum_ipv6_magic
>>   # checksum: pass:2 fail:3 skip:0 total:5
>>   # Totals: pass:2 fail:3 skip:0 total:5
>> not ok 22 checksum
> 
> Can you tell me how the tests are run so I can try to verify this on real hardware?
> 

Enabling CONFIG_KUNIT and CHECKSUM_KUNIT and booting with those tests enabled
should do it.

Thanks,
Guenter


