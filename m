Return-Path: <linux-kernel+bounces-31266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA05832B79
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B74E284421
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A1953E05;
	Fri, 19 Jan 2024 14:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFBrrBmG"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20304EB5B;
	Fri, 19 Jan 2024 14:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705675383; cv=none; b=m52yS6tj0YIiwr4dEZNXgPWZnj+zlEwwiZm7E3mRkH8c7EgmkW35Ys1ndEA+OwQHC0kaHEFrJCYAJLMlxkmAWAKP1YtPRMkfZBR4hyRJUsIeVOL/hz8AQblhqv2ZAnG18OnGYvEt2hMiLFyN9sO2++cd8y0u7VS5pv5vuvbiZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705675383; c=relaxed/simple;
	bh=P/iDfs1r4OMgOVX6uIoWqiz4AsKrEFdzTkeMea2vANg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oss+Lz58UUMErGYG95+miFGSFZOE9vyShVXOLYIAL2t9jVH8U4cgG4fKYSI2zTa/qZEuFknV2jCUSERvTITKSZyp8RJbTEzfzGsTC2YBhRZ9Z7scvjRjE8WLNIcoFHzHHYIRzQq0VFHtjSMn8jAIOTJr02jS4HhWGd8CcYJMC0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFBrrBmG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6daf694b439so694931b3a.1;
        Fri, 19 Jan 2024 06:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705675381; x=1706280181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sa1sXPdFvr+b0W/h4FKPzOX5tpwwugPKaIt9F3h4/as=;
        b=JFBrrBmGPWXOT6Nxbwg7ZAh0ArwnDXBU8Ll2O3RcInZL5yp6jqgqatQLI/FtcyXKzw
         8g/u4TIfsYdTZrYBr+pIYUrKfBb3nSx3md53cuVrVUX/ZF0K60P4nLTLbdsXww9gdlWL
         RcHdKbc+iOFfDVhD1koq4+M5ptx7JA4z0fMNS4Zlo1Ojbw5OONGGjg/qVImKQ9hcmXvo
         mCHb9ejyYaPFA+o/kuowl4bFFy7n98Ri/MRDPEcwZNfDTZ7aDCQOLuUGfWvm4hoOPTKt
         EhE0mOetF3V6e56HX4xxc89sfU7oDtDSI+3RcirfYJNPSMfngN8AJITlKYnqWvvIJNA+
         eNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705675381; x=1706280181;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sa1sXPdFvr+b0W/h4FKPzOX5tpwwugPKaIt9F3h4/as=;
        b=at+4m/7yTQCcw9khXqF9bnR20cn/YpqVLmDruwxarDPm0NB7IL3U2zutFL6PEC7ktq
         qNcvIoXg9c8UBMPGdfuJkWGqunOiGvaUWaoFMyH2EpmlnW/7lMjwS1/49HRYIRfKESXI
         9TDDhHf8Moz3PhfZafmp+znjSewGRgcEuBMtfz6vHT4E0XIQ8En81MDPPOAK1Tgfv5UT
         23fePvZUiFX4RF1HTrWUXvzhY1wRILLgWAO9fcBCn1cfJoAYMZQ8eqsIxaPBEzfe5NFw
         0wmqcVG0oO3NPoqBU8drSa7QGvW62x34J5IhALt9dHTIb8iBSRaBL4Omab7yDCitPSfk
         hcuA==
X-Gm-Message-State: AOJu0YzSFJZfiYZEV4HKpPTfMMh985Wj7OK4Y9FuKG/bTH4Y2SjauGyO
	Dd7wXu2ZgvB8S3C/0NEcHRbM1FE4NGZvaSGLQ2FQMsaL6j1sV/SP
X-Google-Smtp-Source: AGHT+IF7LeD6NBaGz3j6ZFdSNQqpzKu6IXYTJAgQvtVxmlB0o4e2NSwqhWPyJgXu9EM92JjVtMPJ/A==
X-Received: by 2002:a05:6a21:4994:b0:199:b4ef:f8e with SMTP id ax20-20020a056a21499400b00199b4ef0f8emr1858905pzc.65.1705675381161;
        Fri, 19 Jan 2024 06:43:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n10-20020a056a000d4a00b006db05a51868sm5348857pfv.99.2024.01.19.06.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 06:43:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b65b46a7-c65d-49bc-a5ce-5085da2fc112@roeck-us.net>
Date: Fri, 19 Jan 2024 06:42:58 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Introduce EC-based watchdog
Content-Language: en-US
To: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Tzung-Bi Shih
 <tzungbi@kernel.org>, Radoslaw Biernacki <biernacki@google.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Lee Jones <lee@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
References: <20240119084328.3135503-1-lma@chromium.org>
 <d2329494-2c57-41bb-a9ea-2c9903500d1e@roeck-us.net>
 <CAE5UKNrU9YHoCQr8HLFf9-T4-NobQ4jWtryVqq9okFz8nVezgQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAE5UKNrU9YHoCQr8HLFf9-T4-NobQ4jWtryVqq9okFz8nVezgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/19/24 06:10, Łukasz Majczak wrote:
> On Fri, Jan 19, 2024 at 1:50 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 1/19/24 00:43, Lukasz Majczak wrote:
>>> Chromeos devices are equipped with the embedded controller (EC)
>>> that can be used as a watchdog. The following patches
>>> updates the structures and definitions required to
>>> communicate with EC-based watchdog and implements the
>>> driver itself.
>>>
>>> The previous version of this patch was sent here:
>>> https://patchwork.kernel.org/project/linux-watchdog/list/?series=817925
>>>
>>> Changelog
>>> V2->V3:
>>> * drop "-drv" from driver name
>>> * use format #define<space>NAME<tab>value
>>>
>>
>> I am a bit lost here. You dropped my Reviewed-by: tags, even though
>> I specifically said that they applied with those changes made.
>> Also, according to the above patch 1/3 was not changed at all.
>>
>> What else did you change that warrants dropping the tags ?
>>
>> Guenter
>>
> The "-drv" change was related to patch 2 and 3, and I have used
> "format #define<space>NAME<tab>value" only in patch 3 (as
> ec_commands.h is mixing those)
> Sorry for dropping your "Reviewed-by" tag :( I've assumed (wrong) that
> I cannot take it for granted sending V3.

 From Documentation/process/submitting-patches.rst:

Both Tested-by and Reviewed-by tags, once received on mailing list from tester
or reviewer, should be added by author to the applicable patches when sending
next versions.  However if the patch has changed substantially in following
version, these tags might not be applicable anymore and thus should be removed.
Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
in the patch changelog (after the '---' separator).

> Alos in such a case if there are changes in patch 2 and 3 and 1
> remains untouched shall I send only 2 and 3 in the next version ?
> 

Again, from Documentation/process/submitting-patches.rst:

.. the patch (series) and its description should be self-contained.
This benefits both the maintainers and reviewers.  Some reviewers
probably didn't even receive earlier versions of the patch.

Note that the same document also says:

Wait for a minimum of one week before resubmitting or pinging reviewers
- possibly longer during busy times like merge windows.

I could just send another series of Reviewed-by: tags, but quite frankly
by now I am wary that you might drop those again, so I guess I'll wait
a while to see if there is another version of the series.

Guenter


