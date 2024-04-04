Return-Path: <linux-kernel+bounces-131011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AB88981EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5072869E2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510F05BAC1;
	Thu,  4 Apr 2024 07:07:02 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A485B692;
	Thu,  4 Apr 2024 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214421; cv=none; b=gj4+ZvBgBxZl4ILUYBR1gZm7pg05NUDHvBLTpAkQiNXt07C74iD9mvJDDnowz+rRMSa91XI4p5iiSmlmLIUA6bi05ZlRNm8WaH9jtM9bXJC19dSWctmGq5EShAnpT9BFZZ6BqR2ED/b6vQAWzojlfMKrPRw3HLb1uzwiPSwZxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214421; c=relaxed/simple;
	bh=iJNBXTcSlH5hX4YkrYUQfbDd+0D0nMu+ek8U7j+DqQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PwRX9/28gBoOsCseGDnR3IqVe1WRizABSLy+TiiGsxjjCI/Al9IiqoENYk6HTQUabDJpZ5UVZMn1cFth0disveXdFDNJVf5djvzGcbGAtfQddJKbCc0miIcz/uqKTwUD6xYbvZbQvRTYUzg330/MEH34eGVL6DQ6JwNrsjoezUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3437d3db788so355967f8f.3;
        Thu, 04 Apr 2024 00:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214418; x=1712819218;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R/WbbIJxE3KiRdxycKoXuLC2El6J2Qohm1c//uHfdeY=;
        b=qHWx5wWQQdHgcdlplJYykxBY/tpxcH0qtfnBg00UknOMLEvalN7j8Q50VskizfYQI0
         vt0sYLv0aprNY8CRk/5RjNgHryQYbcggqYGwZ9gM72NGlOrPTlWe90BCu3EhLkzDMRUG
         0gr+af5Eo5NRH9zzc4JRIQ77f55bR6/xZndSb+c1vbWbk/fBatJagfoviO2kdTeQuicI
         ZZOCDIOk1pAm/vY0hbufbT4TkzXamnHjyHbGDs/6IPqu+JbKnu69LrFRwDEcka+aXRfF
         yhdUJO2V10XTnfmjEL9XPsJ4EEoTVToTGuZspwxG3qaunYqUN7BDQJ7f1cUeCHrMQCee
         BaZA==
X-Forwarded-Encrypted: i=1; AJvYcCUtLEOIBdNr441utzMoN0QxEZq3i+1HmRcN/jevR53k7ngRVJFePjOqBnnCgWpfb6rK932aPLzmQTKNMPSmylhcIn7A0KLTgGLmy528lf/VERIWkVoJnNtPuNfo+IYFbJBBPkg9
X-Gm-Message-State: AOJu0YyO12bDe6kudcU9QlaRMBo+i25Jk7CKeryYDOX0AdBTNWksmJzT
	gqA8yQs37aNlh4+AuvWdaZ3/OJcIPpMRhLn4VJtIuWB48xFWq94F
X-Google-Smtp-Source: AGHT+IGYoYN8Mcqk4AIUOe14ERt2YLVlbQL14hEvq6QsjfQBdQT3/qFIJsV02QjReavdrJOwd5CLKA==
X-Received: by 2002:adf:ee90:0:b0:343:9b68:d9a3 with SMTP id b16-20020adfee90000000b003439b68d9a3mr1257369wro.64.1712214418126;
        Thu, 04 Apr 2024 00:06:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id en19-20020a056000421300b0034365152f2asm6682170wrb.97.2024.04.04.00.06.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 00:06:57 -0700 (PDT)
Message-ID: <29df48ef-aafe-4918-b903-0aabda94fd0b@kernel.org>
Date: Thu, 4 Apr 2024 09:06:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 015/715] io_uring: remove unconditional looping in
 local task_work handling
To: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240324223455.1342824-1-sashal@kernel.org>
 <20240324223455.1342824-16-sashal@kernel.org>
 <bcf80774-98c2-4c14-a1e7-6efcb79a7fee@kernel.org>
 <2ff5d891-2120-475d-be8e-82bf20a8b7b7@kernel.dk>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2ff5d891-2120-475d-be8e-82bf20a8b7b7@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02. 04. 24, 15:41, Jens Axboe wrote:
> On 4/2/24 2:12 AM, Jiri Slaby wrote:
>> On 24. 03. 24, 23:23, Sasha Levin wrote:
>>> From: Jens Axboe <axboe@kernel.dk>
>>>
>>> [ Upstream commit 9fe3eaea4a3530ca34a8d8ff00b1848c528789ca ]
>>>
>>> If we have a ton of notifications coming in, we can be looping in here
>>> for a long time. This can be problematic for various reasons, mostly
>>> because we can starve userspace. If the application is waiting on N
>>> events, then only re-run if we need more events.
>>
>> This commit breaks test/recv-multishot.c from liburing:
>> early error: res 4
>> test stream=1 wait_each=0 recvmsg=0 early_error=0  defer=1 failed
>>
>> The behaviour is the same in 6.9-rc2 (which contains the commit too).
>>
>> Reverting the commit on the top of 6.8.2 makes it pass again.
>>
>> Should the test be updated or is the commit wrong?
> 
> The commit is fine, it's the test that is buggy. Sometimes test cases
> make odd assumptions that are just wrong but happen to work, for some
> definition of work. Eg it would work fine on an idle system, but not
> necessarily if not. For this one, the fix is in liburing:
> 
> https://git.kernel.dk/cgit/liburing/commit/test/recv-multishot.c?id=a1d5e4b863a60af93d0cab9d4bbf578733337a90

Thanks, that worked.

Any plans to release 2.6 with the above?

Note that for 2.4->2.5 update I also needed to take 9dc95a03e4a76 from 
post-2.5.

thanks,
-- 
js
suse labs


