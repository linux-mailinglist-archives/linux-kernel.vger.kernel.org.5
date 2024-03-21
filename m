Return-Path: <linux-kernel+bounces-109690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DD0881C76
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCC11F21DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8A33A8F0;
	Thu, 21 Mar 2024 06:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b="ZO6fpmlz"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA36BA46
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711002287; cv=none; b=lOVSk9hVLxKHpPewreFcuAmsvZifqhafXifXy4OiPvIaWsCuRcRzSYc809CaUkMm/shma7n17OzUQ5QpsfJZW5fLZn3NDiDpABQbhQjc3+2ddCkGD4MK2H4hvXE4TcgHAx/3B8GYXzE67W9Alw3r2PyrXl9qTSrNXTDgb5OlmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711002287; c=relaxed/simple;
	bh=u7gy52Zr4WALCYWAKNUwux0AGgQz+4tJN82RhdfsWxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZ/qAO0FrE3SHD6vq7vaDvlpP3Si/t/Uqv2rJtYEvakMWiCia4X0vX5b+95rlg+59bwQFjANUZjx8+bM3//JBZWGOMy9VlN/t8Lq52CbW/b3l1Tx3z5ziy0Mjrnx7TFVglIh2ZXqwlpicaR+dHxouzhxbCLvHfDprY6o2NVue5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com; spf=pass smtp.mailfrom=turingpi.com; dkim=pass (2048-bit key) header.d=turingpi.com header.i=@turingpi.com header.b=ZO6fpmlz; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=turingpi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=turingpi.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-366b3b6d527so5405045ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 23:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=turingpi.com; s=google; t=1711002285; x=1711607085; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3cOWF0tnWKn5tL69BGnqb4RHaXGsDQKgBLpXfmTfh8=;
        b=ZO6fpmlz+NwI3f6e6V/qRAjLt46nbGHzxRMSqwO2I9smXsYzp/E/uFkDdbqOpouPz3
         7wZv1KzUXdmb0WIqWIm1rRPjiodtZ9mCYHgUme2sISdRVnBJU6QQLndacDaRWBi4bNiH
         XT+OleSiRlaX4h6X51i+eUMRIPGW2HP0DzI7MwLUma7VyASnomERF7E8X2qCt7pQxttI
         NSgYjZy4jAyuAaFTV68t1bQSmcVhBv1oUT3IMyyvma71OGb6EyTF/B97RNE1RRGmbWs9
         6PIjFRqMt9C0mRxMCBv0C3smefzofB13pz7VSaSosT6mFIfdmm7AyDRJgRoNwUcnxIiQ
         diRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711002285; x=1711607085;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3cOWF0tnWKn5tL69BGnqb4RHaXGsDQKgBLpXfmTfh8=;
        b=Cq5Nt8g+Pch6CvXfBtRjtk6wjgWtc7XN/HQ0fUTSfmhzVB+4TrZaxwWgcNjrilcZ7r
         lGIFQyweNXE/EE1BmJS9NVrCsc1Gq4InBNsFLZi9euHlSTW4rLJqmM+jCo15GTxZLxzT
         ePbFdXmV/pkNjp5XOOcF7klJ1ziUTK+nrAlfO7LnNHWgI5SeEy3FKeoUWgqoNOo1zq+Q
         oMpSWfBrpWJe4PMHLYAbRrHqBiMX4jlNWqc2HcTVtPXwugahi+uepzyZNkbkYQNmAD69
         r9BDh1aXpe/F1vAPVmpcA/xhmoceVDENNpeiSvHW9RNKv6RyGNvZjid8OOvnT+Euquak
         JXSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7TLBDv7tEuwRFwWrWpUBHZYT4op7YShYLB31qDm5uzipMNvC5GPsegsMDTvWWnr8l0dmiHM54YhGaZ7Cprj7zJeFqLkee8HGhM6y
X-Gm-Message-State: AOJu0YynnqW1QUHIF8DnGxAzsYsVeHSF75Z2bakQHiYmMBx3h//O5aGN
	FGvUzqxQ7ilimLJ2L1kweQ9YuBou7mPVXaUx0MW4HXiyJOTE22krwKIv7j7uEJ+KZC5dEGad4bu
	XUTE=
X-Google-Smtp-Source: AGHT+IFl+3GQbbjSbfeFHZiRrzLet8mSgYnqao2atBSVQewHsUtzoSIIKIiJkL5hOdodXy8uTkCifA==
X-Received: by 2002:a05:6e02:f05:b0:366:b269:f4dc with SMTP id x5-20020a056e020f0500b00366b269f4dcmr1291438ilj.14.1711002284703;
        Wed, 20 Mar 2024 23:24:44 -0700 (PDT)
Received: from ?IPV6:2001:470:42c4:101:5977:3c90:314a:e5da? ([2001:470:42c4:101:5977:3c90:314a:e5da])
        by smtp.gmail.com with ESMTPSA id l5-20020a92d945000000b00366940cfba6sm3786271ilq.58.2024.03.20.23.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 23:24:44 -0700 (PDT)
Message-ID: <4a043be8-8e88-4b92-913c-abd8f138b90d@turingpi.com>
Date: Thu, 21 Mar 2024 00:24:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH 0/5] Enhancements for mv64xxx I2C driver
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAF8uH3tYaUwhkkeFuY+PdsnSPqeTtWtOsB_hy9oOjF=f-2Hdaw@mail.gmail.com>
 <p37qqpplxgmfzlq6wz7fvmvnrsumy6ra5nivzi4hd2gbvlbezx@dlh6ygyjbk24>
Content-Language: en-US
From: Sam Edwards <sam@turingpi.com>
In-Reply-To: <p37qqpplxgmfzlq6wz7fvmvnrsumy6ra5nivzi4hd2gbvlbezx@dlh6ygyjbk24>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/20/24 20:28, Andi Shyti wrote:
> Hi Sam,
> 
> Thanks for your patches.
> 
>> Sorry about the resend; it seems my mail client "helpfully" swallowed the
>> newlines on any line consisting only of whitespace, garbling the patches.
> 
> I received three series from you:
> 
>   1. [RESEND v2 RFC 1/5] i2c: mv64xxx: Clear bus errors before transfer
>   2. [RFC PATCH 0/5] Enhancements for mv64xxx I2C driver
>   3. [RESEND RFC PATCH 0/5] Enhancements for mv64xxx I2C driver
> 
> By the versioning, 1. is good, the rest is not good. Standing to
> the time sent and comments in patch '0', 3. is good, the rest
> not.
> 
> Which one should be discarded? Can you please state it clearly?

Hi Andi,

Thanks so much for your patience -- this is the first series I sent with 
this particular mail client and it really didn't go as smoothly as a 
plain git-send-email. I'll get it nailed down in time for the non-RFC 
series.

I sent the series in the order 2-3-1, so 1 is the version to look at 
(though I made no content changes between resends as I was only fighting 
my mail client's formatting).

> 
> Besides, youre mails are not threaded, They look like:
> 
>     Mar 19 Sam Edwards     (2.3K) [RESEND RFC PATCH 0/5] Enhancements for mv64xxx I2C driver
>     Mar 19 Sam Edwards     (2.3K) [RESEND RFC PATCH 1/5] i2c: mv64xxx: Clear bus errors before transfer
>     Mar 19 Sam Edwards     (2.3K) [RESEND RFC PATCH 2/5] i2c: mv64xxx: Clean up the private data struct
>     Mar 19 Sam Edwards     ( 15K) [RESEND RFC PATCH 3/5] i2c: mv64xxx: Refactor FSM
>     Mar 19 Sam Edwards     (5.2K) [RESEND RFC PATCH 4/5] i2c: mv64xxx: Allow continuing after read
>     Mar 19 Sam Edwards     ( 11K) [RESEND RFC PATCH 5/5] i2c: mv64xxx: Implement I2C_FUNC_NOSTART
> 
> instead of
> 
>     Mar 19 Sam Edwards     (2.3K) [RESEND RFC PATCH 0/5] Enhancements for mv64xxx I2C driver
>     Mar 19 Sam Edwards     (2.3K) ├─>[RESEND RFC PATCH 1/5] i2c: mv64xxx: Clear bus errors before transfer
>     Mar 19 Sam Edwards     (2.3K) ├─>[RESEND RFC PATCH 2/5] i2c: mv64xxx: Clean up the private data struct
>     Mar 19 Sam Edwards     ( 15K) ├─>[RESEND RFC PATCH 3/5] i2c: mv64xxx: Refactor FSM
>     Mar 19 Sam Edwards     (5.2K) ├─>[RESEND RFC PATCH 4/5] i2c: mv64xxx: Allow continuing after read
>     Mar 19 Sam Edwards     ( 11K) └─>[RESEND RFC PATCH 5/5] i2c: mv64xxx: Implement I2C_FUNC_NOSTART
> 
> Which is the default of "git format-patch".
> 
> Can you please make sure, next time (unless someone asks to
> resend them again), that the patches are threaded? You can send
> them to yourself first and see if they are really threaded.

Yes, definitely. I take it from your phrasing that you're willing to 
collect the scattered mails yourself this one time only? If so, thank 
you for cleaning up after my mess. :)

If not (and/or if someone else doesn't like the mess), I can always 
resend. I have already made one cleanup (removing the useless `default:` 
at the end of the FSM) so I guess it would technically be an "RFC v2" at 
this point.

> If you are using some weird mail client, you can also check the
> mail header, making sure that mails from 1 to 5 have the field:
> 
>     In-Reply-To: <Message-Id of patch 0>
> 
> Andi

Cheers,
Sam

