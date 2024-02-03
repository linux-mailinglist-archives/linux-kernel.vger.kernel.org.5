Return-Path: <linux-kernel+bounces-51175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BF8848755
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD9D1C22A68
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C57B5F54B;
	Sat,  3 Feb 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAOy92ZO"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70DE5F46B;
	Sat,  3 Feb 2024 16:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706976482; cv=none; b=XRayo1vPlmuu6PHdOTAKZ7sZwG+INUBUF5zpEi0DV0r9Mp3goM/c7C9IDkj4V3y2EffvXDprLcVUDARvkHcdBmsVLsk/I4GiVbn+nBXhTQki+RlHEf38c+veVKsjh6rUig5328cpr8NPj7U+d3OqCxiYpq+Ht8ePRfm/7w0Ea1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706976482; c=relaxed/simple;
	bh=kMYtZufsjVxlE3fyO/71eP/QlR0rcEXYso+u7x9flKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gVJKuoKE1zAnJ18oMYRZPRBiXM7UxDWVV6hiC6zu9htAh/4acPwAiZiMt7r9Ao5XK1CWZ7jDn8W1yE3SUghBnQ86JjpFcLsZuhBo1HoRo9lwAQzQCJEevSl20j9V+JdolmkMnqNsmPF+jgWBNCNp3xZg84n2VQvcOY8uLvyzIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAOy92ZO; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-295f9a4a656so2533747a91.1;
        Sat, 03 Feb 2024 08:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706976480; x=1707581280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LZVmrb6PNMGwh3nXmfzsmqwgUOcksE0XAjGL28KC75g=;
        b=IAOy92ZO6wt/5GJhqkkKOLTECfbpjhNERkUq5Fofqxt5FG//yD8GO6y4EdPN13KVyy
         GykxSrYfa3y09cQXptBvCWKdpx+tkorYyEeg9StBXMXxyjomZEdzOJbTK1bHXjgTIg5d
         uasdVoNmKR49V1uGBrzT5VV6aPjGZe4Cb7x7rvkv6BblJJggGBHYWElH7RpdJtFVNgH6
         TmJXHbGQr0vO4fAx+7Qylgp+q4QF48ACsLLRrShXjI/keZIBPu1YivJC/hzILxjiCDQp
         dGpZwXc9bdg0Rs7+PkuxgYQFKTp+YWemZHo5QBqKgtbUvf39rxhaRGATM575dzr2GHw1
         eT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706976480; x=1707581280;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZVmrb6PNMGwh3nXmfzsmqwgUOcksE0XAjGL28KC75g=;
        b=UUzGm2oUH3BMaoybUjYO84CXldSKO2jcvcEo2/CuuJBp6n4tvbilOzd92H1lyfvQ1m
         /jCjXgaCBaEaLkY8Xu0y9yL/IUw2p3NwUgulZSR34fBvEUQmtJEyQGM6fJo22up8AGGQ
         kM2cqCc30P242d3i+LX1qesNuXRCUFV1xaERFCz5IC/0Cg+m1VHITNG4EN7/SbXbFwnP
         B7UkZmnCTCISN1HGFwwjY//ApJ8sS9RHXb2X1yNN6LIFgxv4KCEIMrNHvQuJCX5Ux5hC
         J8jURNJM/vN2k60Kww7YLGNBq7c24XrMDmfRMiiBnhcf4q7/3uVIWh1HmiA7cWuAY0nw
         aC5g==
X-Gm-Message-State: AOJu0YzJ74S1urMAvrMLLFqrXI4Xi3A/RCwqDFnKIyVlhXozQQeBrVKs
	afWF7MdzW4bqeSp95xcnVf8tN+To+vLXYzwYb7iFM3ktl8UiPT1H
X-Google-Smtp-Source: AGHT+IGllnUitaOMtULXRGqv0bRi+kscb8ct5UxkwUnmxg/3t49W6m49wHTswa8sbtwn2cvZuSWjRw==
X-Received: by 2002:a17:90a:d489:b0:296:459d:c96e with SMTP id s9-20020a17090ad48900b00296459dc96emr4147119pju.44.1706976480101;
        Sat, 03 Feb 2024 08:08:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUSOcArR5kHu/bT9fz15DgMS5Dfj1/QDkRrETjzrgYRM+qAKfECVY1Gw6N0GP1YZELuwOKToIoU+N7k4qh3sAEixdtkdPcQu+mM9Z3d/hRkud3KD6iSwOKJgWNitwUd7U45ktJXqGq1zHIAkArozSvHcvvOyJI/pDDavKbAdTV12j9x/yNTjFXgoQVDqcdlepa5PeLHL5iRwUsElKGYJkFjFdusQ3Tzu0j6p5SlKRgM9YpeCrufYBeX5dV0hFqsi+0qduAn2dfWoMIixoLflXnr01DCd8nqVwyaZEuZDF6G1DFBkKVwQNooFxxLZK4lsieZ5wWk7nkfkDbwqdZyslXQKPoB2HM/sIBLKyQdV4F7PrOq9hSK04yAWBaz1w2IclMueq6vI5DmC/CWjZFH89f6wVW92LjxbiqCElgO5dA9GOvHIQwRD/jUF6Jzrd55hR4ksKQ901SwyKmrb0lSTyn8v+t19U96Hki4yK6p2hiUeSq/rd5JACBW4m93Bqcik8Ox9DpVCN69mt9nHflSTPCw7UuXSmDleJJI6xWRZGyRlOGMLtDaMsiRXrI/AZY+s9dyZ6SYQU5gyhpaOyYtlX97Yg==
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ee16-20020a17090afc5000b0029625d81d7esm1973303pjb.3.2024.02.03.08.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 08:07:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3d838bba-e04e-4b07-aba6-570885bf8991@roeck-us.net>
Date: Sat, 3 Feb 2024 08:07:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/219] 6.1.77-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 mathias.nyman@linux.intel.com
References: <20240203035317.354186483@linuxfoundation.org>
 <13ddf68c-df25-4f5a-8044-33543a726889@linaro.org>
 <2024020331-confetti-ducking-8afb@gregkh>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2024020331-confetti-ducking-8afb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/3/24 07:42, Greg Kroah-Hartman wrote:
> On Sat, Feb 03, 2024 at 12:23:33AM -0600, Daniel Díaz wrote:
>> Hello!
>>
>> On 02/02/24 10:02 p. m., Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 6.1.77 release.
>>> There are 219 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.77-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> We're seeing lots of build problems and warnings with Clang 17 and Clang nightly:
>>
>> -----8<-----
>>    /builds/linux/drivers/usb/host/xhci.c:1684:37: error: variable 'slot_id' is uninitialized when used here [-Werror,-Wuninitialized]
>>     1684 |                         ret = xhci_check_maxpacket(xhci, slot_id,
>>          |                                                          ^~~~~~~
>>    /builds/linux/drivers/usb/host/xhci.c:1652:22: note: initialize the variable 'slot_id' to silence this warning
>>     1652 |         unsigned int slot_id, ep_index;
>>          |                             ^
>>          |                              = 0
>>    1 error generated.
>>    make[5]: *** [/builds/linux/scripts/Makefile.build:250: drivers/usb/host/xhci.o] Error 1
>> ----->8-----
>>
>> Bisection points to:
>>
>>    commit 37ef029fe9a5639f12250f75f5d1594c6a11e181
>>    Author: Mathias Nyman <mathias.nyman@linux.intel.com>
>>    Date:   Fri Dec 1 17:06:47 2023 +0200
>>
>>        xhci: fix possible null pointer deref during xhci urb enqueue
>>        [ Upstream commit e2e2aacf042f52854c92775b7800ba668e0bdfe4 ]
>>
>> Reverting the patch makes the build pass.
> 
> Thanks, will drop.  Odd that gcc doesn't catch this as well :(
> 

I have never been able to track down the reason, but gcc on many if not
most architectures doesn't catch problems like this. I often see a warning
pointing to a real problem on, say, parisc builds but not elsewhere, even
though the compiler version is the same.

The above problem is seen because commit e34900f46cd6 ("xhci: Reconfigure
endpoint 0 max packet size only during endpoint reset") removed the call
to xhci_check_maxpacket(), but that commit is not in stable releases.

Guenter


