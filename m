Return-Path: <linux-kernel+bounces-19994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B10E8277F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B221B22190
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E4854F94;
	Mon,  8 Jan 2024 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="V638jDil"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD3F5576C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 18:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e43e489e4so19870875e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 10:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1704739922; x=1705344722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1G98vUT1ChYTetTcXeZ4VcG54jTiERw1OKsbY1IV4Sk=;
        b=V638jDilk8NNWOg4LAEEPLfUTt8IwK4sZ4weR+AGeN+t4HqK9d12IjhVTF0kODg/p1
         gmfKn3qBRjD7MmSo2zy9tzsB7ENRaST55j+IvxPlWlcNN/HrlGw8mG5BNKo47yqiey62
         BWaPMWpfugIvTZ3F7DDvoI/7i3dthddXFJUPYzcb+JPU5vypCznW1bnwWGy5618DNX7W
         TDtQAgLimqmae57okMKH2SuCl9xRqbtyGWM50YHrcEFtbi3B2Y2tNj69euVLUctccqYF
         BfaEhyVeuNvqCawg1HOkp5LQJ94R5TZ8IesBUbBjeHwWOKsMLKUPa9Y0fx2yoZhRS6wv
         cSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704739922; x=1705344722;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G98vUT1ChYTetTcXeZ4VcG54jTiERw1OKsbY1IV4Sk=;
        b=E3QbWXyFr3nVBz6vDQ+GkVeu5T4fFQ5Hdldp7nfMiYOxiJoT9yWrn9YjZGkSESdF7d
         8gkMQXLa9UeBv+82RRzmleCHBxGeIS8MErWFZRijEOiVJSYgTlh/FxLheEKusiGAqaCM
         YEyNyphp/YgjmB5nuD5YWJ2lGPFQkrbK3lmTPrprJw8Tz0C4Gd5VpjU0/i9bi+v0UCiM
         eOJH6bPgLmx+FEyP86NLK7A2w6yluOjP6X+dHeveTLKEUSd/8JWIyE0nVOoTRkVTRHe7
         CJ4MUliseqJ42eeS19I6B4D+AQVHi6T7KpOhnkK5kh8vW4XwFuTkXj/Rfmw2gjjs0sCD
         xUXw==
X-Gm-Message-State: AOJu0YyRMKKoCVfIwAMilPPd21aYnh4FbmB0f/i2Nkt3Uyx+6FzLUQgf
	7EV3l5d3JM0mS2bZLbcHuMfCRJ3PfiZ2
X-Google-Smtp-Source: AGHT+IFfv7gLg824ujXXVdEWgZKOYWbuP9lzhfxDa1/3KwbJLme3HMqGda0Yyr74xWfeSQGPtQP1Cw==
X-Received: by 2002:a05:600c:600a:b0:40e:474f:17c8 with SMTP id az10-20020a05600c600a00b0040e474f17c8mr1015345wmb.5.1704739922610;
        Mon, 08 Jan 2024 10:52:02 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s11-20020a05600c45cb00b0040e395cd20bsm11849397wmo.7.2024.01.08.10.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 10:52:01 -0800 (PST)
Message-ID: <8f50f4e6-d815-46c3-be16-5b3c65a80b4f@arista.com>
Date: Mon, 8 Jan 2024 18:51:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: syslog spam: TCP segment has incorrect auth options set
Content-Language: en-US
To: Christian Kujau <lists@nerdbynature.de>
Cc: netdev@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri@arista.com>,
 Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>,
 linux-kernel@vger.kernel.org
References: <f6b59324-1417-566f-a976-ff2402718a8d@nerdbynature.de>
 <fe1752a6-9866-45e6-b011-92a242304fce@arista.com>
 <491b1b19-f719-1aa6-7757-ba4168228bbd@nerdbynature.de>
 <65ad94ae-36a9-f128-ea45-26772772ba31@nerdbynature.de>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <65ad94ae-36a9-f128-ea45-26772772ba31@nerdbynature.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/7/24 19:27, Christian Kujau wrote:
> On Thu, 4 Jan 2024, Christian Kujau wrote:
>> On Thu, 4 Jan 2024, Dmitry Safonov wrote:
>>> Yeah, I guess it's possible to down the severity of these logs, but may
>>> be unexpected by admins: TCP-MD5 messages existed for long time and
>>> there may be userspace that expects them (i.e. in arista there are tests
>>> that look for these specific messages - those would be easy to fix, but
>>> there may be others outside this company).
>>
>> Understood, thanks for explaining that.
>>
>>> While thinking on the origin of your issue, it seems that the logs
>>> produced by either TCP-MD5 or TCP-AO are desired by a user when they
>>> add/use the authentication. Could you try this and see if that solves
>>> the issue for you?
>>
>> Thanks for preparing that patch so quickly, did not expect that :-)
>>
>> I've applied this on top of 6.7.0-rc8 and will report back if I see those 
>> messages again in the next days.
> 
> No messages so far, great!
> 
> Tested-by: Christian Kujau <lists@nerdbynature.de>
> 
> Thanks again for fixing this so quickly,

Thank you for the report and the testing.
It's a bit late to add your tag, but on a good side the patch went in
v6.7 release, so you will not have to have any out-of-tree fix for
this :-)

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4c8530dc7d7d

Thanks,
            Dmitry


