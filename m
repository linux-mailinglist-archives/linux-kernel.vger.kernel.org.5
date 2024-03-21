Return-Path: <linux-kernel+bounces-110718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89718862D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A407A285E24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A616A13667B;
	Thu, 21 Mar 2024 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b="fjbZNqCR"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583BD136664
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058456; cv=none; b=FaVXeDjZ90Hr3ogrcJ/SQleTXPBcbckXuyjwFMhGD4gXDFijinDFFEnw9cmJhAmi1pCoHTGeCkPnATnKMh5VjjtYvRfDq1KOvaFrep6vtmq215igzqjaBjVhyBVT908/t40+A6QOmhmBAr7FlgVFImaWQmPe9LMMBGy7PUB2+IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058456; c=relaxed/simple;
	bh=XjhRN1+WliKb2nvUCXcCau0ZReNDce3iYf1kyUq3i3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCLddIA4bw0dH7MPwXbvZupalry92hVn41di0oNObn5p1O/3XATqZU2wG7LgLaPvipt2RBKKkeMSN28XPVxuVv246pzX/PyGI1wruMJf4fMgf5OxYydvymxvixBmbeaLnZn7uZsZvw/9XkWCCPOoNbsthQ5SaVq1jYZDcsWllQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com; spf=pass smtp.mailfrom=turingpi.com; dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b=fjbZNqCR; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=turingpi.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c8d2e0e9cfso46866039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=turingpi.com; s=google; t=1711058454; x=1711663254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDnR0b5/BmLqe7zAvxDaQSE6Q7NTU8rgOYXFYBY8gfs=;
        b=fjbZNqCRxHgQZImxUQkjRzQ1rznmLz44q27VcG0EMd1bSvvJ1A+0p1nM2kwh5jeu6e
         1x/1B6RgH9XLVKIfWvx9QYf/sCp0mry8QjeHdrZmCyw3devuXB1/YcrcFdNP60T+fsVY
         1bvX4BF+SZvvBN3rC45rW1SelsWF+RYQCMadbJF4J+/WbBoi/LU4/be2Dmx2ftgv0uqZ
         Tdk58DZ13RcyOvwvfNLDzjVIYoYwBcRrKmcUkWZo1dy4WbcavB2Nwi4ZduuAbKynTTtK
         j+82nkJ76/NqryWYVdlRbxXn4Ppu0prddtcFubvmuNVxMwV9FoaE2fW03zfGYw7T/kLC
         XFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711058454; x=1711663254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDnR0b5/BmLqe7zAvxDaQSE6Q7NTU8rgOYXFYBY8gfs=;
        b=m2U6zQpGWRmGufOmYgOortrTRdpCneiuuySKJK9lmP/Lg8SBrk+bzc8aO7vepVdl/W
         pMD3St1OtbxICvqwEmxstf5IejtbeSrja2yFujkl7+m+bUnqSAq4qr4bybasPd5qG+tV
         ntY+6Q7Hltdb5pr3D05yJWDp1SkbjZcNAlpaVHW6ZYPTf3ZW0S8tiyfVomJhl7teeAb2
         46PO4sGfj6O0L+6q8ffDWCz3byuUsucuL8CxXb8DLNXr2zfwnfKT0UesDaSdrUl5djl7
         9cmmnlYahdfLoOMsqSp0ZrpWSXn7jV7qX2sSkqFxCf8pGqiKZS25ZxDHxdJAI0FQ8iik
         XH1g==
X-Forwarded-Encrypted: i=1; AJvYcCUOlQu/rviGdNJKc2tbEWSE357HY7Zx7BtRrgjycV3YZQPAfBh/+SDh7VlVQjbCoDqHn0ncL6uM6buLSZbbxSxm75hGjLyYTxe/4zhT
X-Gm-Message-State: AOJu0YzQAYWzwvfqLw/9PEwOsGE1x4B8+M/50aNowjk2LPGdoaBsh5ME
	1TgpQLOArE8BswsDuJ+gASyDt4yLGfy+9OtpevobqD/Jy1gnPboismAeIB8Wz00=
X-Google-Smtp-Source: AGHT+IFZmr8k83heK3kERn+YqBvzq+IWT5js+OQoZpX6PhjnSxOryVi8zm4Z1y68gxiLg2m/CRXmfg==
X-Received: by 2002:a6b:6e1a:0:b0:7cb:ffd4:6784 with SMTP id d26-20020a6b6e1a000000b007cbffd46784mr782605ioh.21.1711058454357;
        Thu, 21 Mar 2024 15:00:54 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:5977:3c90:314a:e5da? ([2001:470:42c4:101:5977:3c90:314a:e5da])
        by smtp.gmail.com with ESMTPSA id l24-20020a056638221800b00476e6c429e5sm140358jas.121.2024.03.21.15.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 15:00:53 -0700 (PDT)
Message-ID: <7f7866f8-514b-4659-920a-30b566ad157d@turingpi.com>
Date: Thu, 21 Mar 2024 16:00:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH 0/5] Enhancements for mv64xxx I2C driver
Content-Language: en-US
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAF8uH3tYaUwhkkeFuY+PdsnSPqeTtWtOsB_hy9oOjF=f-2Hdaw@mail.gmail.com>
 <p37qqpplxgmfzlq6wz7fvmvnrsumy6ra5nivzi4hd2gbvlbezx@dlh6ygyjbk24>
 <4a043be8-8e88-4b92-913c-abd8f138b90d@turingpi.com>
 <wdpnjnuahedvbakhfavoobukdkocjfpfrgsu374sgjhkyy7exz@er4lyeadftyz>
From: Sam Edwards <sam@turingpi.com>
In-Reply-To: <wdpnjnuahedvbakhfavoobukdkocjfpfrgsu374sgjhkyy7exz@er4lyeadftyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andi,

On 3/21/24 14:54, Andi Shyti wrote:
> so that it's the [RFC v2 ...] the right series... are you sure?

[RESEND v2 RFC ...] -- it's the second resend (thus third send), not the 
second RFC (in retrospect I definitely should have used # instead of v)

> 
> The order of arrival is:
> 
>   1. Date: Tue, 19 Mar 2024 16:51:51 -0600
>   2. Date: Tue, 19 Mar 2024 19:40:51 -0600
>   3. Date: Tue, 19 Mar 2024 22:19:53 -0600
> 
> Anyway, I will take "1" as the good one, being a v2. I will
> discard "2" and "3".
> 
> Then, please, do not forget next time the patch 0 and the
> changelog.

Patch 0 was probably separated by the lack of threading but can be found 
here: https://www.spinics.net/lists/linux-i2c/msg68235.html

There is no changelog as there were no changes to the patch content vs. 
either of the first two sending attempts; I was only trying a different 
way of navigating the minefield of mail agents that make whitespace 
changes without my consent. :)

> 
> ...
> 
>>> Can you please make sure, next time (unless someone asks to
>>> resend them again), that the patches are threaded? You can send
>>> them to yourself first and see if they are really threaded.
>>
>> Yes, definitely. I take it from your phrasing that you're willing to collect
>> the scattered mails yourself this one time only? If so, thank you for
>> cleaning up after my mess. :)
>>
>> If not (and/or if someone else doesn't like the mess), I can always resend.
>> I have already made one cleanup (removing the useless `default:` at the end
>> of the FSM) so I guess it would technically be an "RFC v2" at this point.
> 
> For now no need to resend (unless someone complains). Let's give
> it some time for review.
> 
> Andi

Thanks again,
Sam

