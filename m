Return-Path: <linux-kernel+bounces-24852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 283DA82C36E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4495B216C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D69C745D5;
	Fri, 12 Jan 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TikfNHgX"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EEC73198
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so79946439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 08:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705076326; x=1705681126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGo5Qib9p/CMqmc2qVWW+nsxV9z3k+DvCQknh7gy4Ww=;
        b=TikfNHgXxUFCbvfBPpEhlkO8PQD/CPuLpqY+r9fugo9iaLEktnSFF4jGJRk3Ws2DXc
         HsCOYiLGDFBIRTG96xHJZPzdyUz/oQPUZyXLhjuM7zBTeg+4FUbM2WFsZJ9FHR3bGJMa
         teqdxwU1ovOC2+DZb/QILZfqDqcAUKWZn0jy+LlBj7pnUD3s/Exa4/9St0h64Ll/g0KQ
         dAf0T4qajiIljjJICcNlTzwoketYubIsrqoOOmkiAw43Ucelom4DVHrM9ZCIf25ezn/y
         3o8h851xjLMvMHPHeI8juQA/7jyuKSaopN7Z+92PmquuikGyDkdDeyklPZAp7zGoQrjH
         5zSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705076326; x=1705681126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGo5Qib9p/CMqmc2qVWW+nsxV9z3k+DvCQknh7gy4Ww=;
        b=HZ/Attzu+JWt21jawloP+Rnf3dllWBwuaDdU8b66C/7owGAeg9ehNAFR1+ESv6bBbp
         cb/pAZOPBINo47GB4P0UOU+1dyufWyuJ9Qpi6LF2In7AEn2/gjGUvMzgz3XljoHSn6u8
         XjFTDjGr7TVNZOjEWDpHmfLDAD8VFHF4hAHj9ajfx1ZgSZ5Pkn9Jj5JPN3QA+6U67ZHh
         Cep6YMgcEWGc1qV7ZbHopDsbudIOHzT3hplLHsybAIIBCtmMFBX1b0YhImJ+QBrxeELs
         a6DMTqQmf/+qNpkjNDEXHSEsP+gAxCRXbnvnh8VSfxXF367VaTN8FcORpThFsE8Nh7nN
         hRxQ==
X-Gm-Message-State: AOJu0YwuBfd5IjtvLhdhVQ4gMGv1yaYjEIj3nWixGYJ8g7dlgmclUiwR
	JjIV6Xdicm4WcTKM+Mluj32sbTWXlMHJ+w==
X-Google-Smtp-Source: AGHT+IHOgGtZvSj8dp3Ed1gkngzNUSPm5tUfa1e4J5SEfUWYdU8tbSUFQ/gTEZJG343OrT8yf+lERw==
X-Received: by 2002:a05:6602:14c7:b0:7be:edbc:629f with SMTP id b7-20020a05660214c700b007beedbc629fmr2513957iow.0.1705076326471;
        Fri, 12 Jan 2024 08:18:46 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s23-20020a02c517000000b0046d98c3cd7bsm964739jam.14.2024.01.12.08.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 08:18:45 -0800 (PST)
Message-ID: <c17648db-469c-4d3c-8c2e-774b88e79f07@kernel.dk>
Date: Fri, 12 Jan 2024 09:18:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] io_uring: Delete a redundant kfree() call in
 io_ring_ctx_alloc()
Content-Language: en-US
To: Gabriel Krisman Bertazi <krisman@suse.de>,
 Markus Elfring <Markus.Elfring@web.de>
Cc: io-uring@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>, LKML <linux-kernel@vger.kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <aa867594-e79d-6d08-a08e-8c9e952b4724@web.de>
 <878r4xnn52.fsf@mailhost.krisman.be>
 <b9c9ba9f-459e-40b5-ae4b-703dcc03871d@web.de>
 <edeafe29-2ab1-4e87-853c-912b4da06ad5@web.de>
 <87jzoek4r7.fsf@mailhost.krisman.be>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87jzoek4r7.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 7:25 AM, Gabriel Krisman Bertazi wrote:
> Markus Elfring <Markus.Elfring@web.de> writes:
> 
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Wed, 10 Jan 2024 20:54:43 +0100
>>
>> Another useful pointer was not reassigned to the data structure member
>> ?io_bl? by this function implementation.
>> Thus omit a redundant call of the function ?kfree? at the end.

This is just nonsense...

On top of that, this patch is pointless, and the 2nd patch is even worse
in that it just makes a mess of cleanup. And for what reasoning?
Absolutely none.

There's a reason why I filter emails from this particular author
straight to the trash, there's a long history of this kind of thing and
not understanding feedback.

-- 
Jens Axboe


