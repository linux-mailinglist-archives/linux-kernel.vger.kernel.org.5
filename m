Return-Path: <linux-kernel+bounces-58787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA4B84EBAF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C71528322A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 22:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF02D4F61D;
	Thu,  8 Feb 2024 22:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBpPUw9p"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E374F60C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 22:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707431167; cv=none; b=fJp9epRKQvYhtZILBFhHvZ+AJ9Q6DYwgfknnag0UWxp4s/rV0yJgJGC4rKl0ymtlPwGClEwljk2DsfPwcbVUkmIR+6RqgLVZaJZXYqRYn1EqhX9UsTvupaJtcU7iSbFmF6VnDKrLvWqj9ZzFL8M5TLnR4vFsTfVcNtRjRpQqK1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707431167; c=relaxed/simple;
	bh=dCSi210em+ERzxJka1CFE7pwlqVeLzmqChGyHa6AbH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q5VER+35TGvG9CesCzNXAEQANOQcg8nNGCy2K0b4bu/gPBW5R8sa+lqntdAcupGfFj6GfAiAG/G1OWun0RrkTZLEoBRPxviJ1Ky1RGwTWN/WvnY50LQvTdcKjkaOuz0h5Wj6xa1/WocYdbPf8rwt2BV0M2IuseC/un/zXeQeYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBpPUw9p; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e02597a0afso237843b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 14:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707431165; x=1708035965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1w4Vi9+3DF+pyTMuSGKmL1segol/08HNS8miH/CGXJQ=;
        b=VBpPUw9peUIKW1I2ycI2gDepP45q/O29US92YCew+/6SKOOT2L2ynlnVq0Xu8YfAPD
         0T0Zs17/6ylsOY/aedDoctu4prTuGz+eih8v318+7gdOoEhWVzRjnEGzqYhk3IiwW7td
         6Kar0fhBzalyZKjZmqEYZbHIqILjAUIwO4LLPJ8/tYCCtpNM9r95tt7s/hK6ZsMY9rcs
         YZqy2SkZlY1rMPksUG1O6t93KmzTcphHGCmGh81W0+tP+TGsOml9mRwYEEo8/a6ybZ1e
         qm5NHbPa85DAmcvyUd3bE7ESJxFksDAsbmG0lbLNlRAL+OmK8byqFbDcOCbqiOOcVaVJ
         cxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707431165; x=1708035965;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1w4Vi9+3DF+pyTMuSGKmL1segol/08HNS8miH/CGXJQ=;
        b=GDaTZ/U1ZKpGcOSXHfwhEj5h3w2WJOmxPDaYwnJNU6RoFPKf8XJYALTahIsdPPjvb4
         FPiItpe6PcPiv+pWmlilIu6jzJq3Q8IJ10NAcHSvZl8OZcVBj+lEzqH/TGwbfAc38mbr
         haEtRArVoIs/a12r+XuNqsw/ddl9pmHdMinuAuzNdsVTZ27AZQosZu1U4QNsVqQs8CVv
         nTxIGbr2dunm1OF8En4n76iGeZA8aVCH9n5j3EnoDvpSCAdrpg4/eewH45L13F7Yuizx
         N5meaKtllaAaIgHssOoxseOgs57ms9YJtoLyBxXKjvB88Kri6W9P9tuOKrG4m+VVMHma
         4dSA==
X-Gm-Message-State: AOJu0Yzw0SlDZl7fl1bSB/jEEayl7vA0p3FZbi0PqzxG0RIMC0x7m7SP
	TZw5sumO4BM2rsLs3n7mzU8GhJ0xWFNp1d+qr4ERYH4iTTFYu+rM
X-Google-Smtp-Source: AGHT+IGTSajMMyO2s94NJrm5g95oFV/G4UgwD8vfLExtXdoBOh2U/Vo53os1YOz7GpQzXJsdlstEMg==
X-Received: by 2002:a05:6a00:10c3:b0:6db:d93e:5cdb with SMTP id d3-20020a056a0010c300b006dbd93e5cdbmr846846pfu.15.1707431164869;
        Thu, 08 Feb 2024 14:26:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u22-20020a056a00125600b006e050644092sm269818pfi.55.2024.02.08.14.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 14:26:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7529115c-d7ea-4c7c-b901-89398d5d8d02@roeck-us.net>
Date: Thu, 8 Feb 2024 14:26:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Sporadic regmap unit test failure in raw_sync
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <dc5e573d-0979-4d7e-ab4a-de18a4711385@roeck-us.net>
 <ZcVRcH/D945GKWjG@finisterre.sirena.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZcVRcH/D945GKWjG@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/24 14:10, Mark Brown wrote:
> On Thu, Feb 08, 2024 at 01:45:13PM -0800, Guenter Roeck wrote:
> 
>>      # raw_sync: EXPECTATION FAILED at drivers/base/regmap/regmap-kunit.c:1305
>>      Expected &hw_buf[6] != val, but
>>          &hw_buf[6] ==
>>           57  30
>>          val ==
>>           57  30
>>          not ok 4 rbtree-big
>>          ok 5 maple-little
>>          ok 6 maple-big
>>      # raw_sync: pass:5 fail:1 skip:0 total:6
>>      not ok 25 raw_sync
> 
>> This is with regmap: 'kunit: fix raw noinc write test wrapping'
>> applied on top of the upstream kernel (v6.8-rc3-47-g047371968ffc).
>> So far I have seen it only once, with the x86_64:q35 emulation in qemu.
> 
> I guess it's possible that we randomly generated the same value for the
> initial and modified values here?

Guess so. Presumably that means we'll see the problem on average once every
65,536 tests or so ? Lucky me ...

Would it make sense to read the value from regmap and invert it instead of
using random numbers ?

Guenter


