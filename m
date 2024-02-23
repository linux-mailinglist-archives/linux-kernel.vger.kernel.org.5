Return-Path: <linux-kernel+bounces-78540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A05178614B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12EEBB20C64
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023C382C9B;
	Fri, 23 Feb 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo/XSnnf"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6697C5C60F;
	Fri, 23 Feb 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699786; cv=none; b=MLk2yyUUkn5pLZQ+JsnqdqFL4y3zJWeCJy3/6f6UlaA8oiuLfor915sPZWW/niXpXezOtAKQJXjiUkofqf84bSq2GROYim2f5dDCIUCiFrjsRdPqmHFK+0ahnwnELXYaW8L7anxAcjNxgDj4eh0YLMXo++PvyZmCJVz3xkKVpY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699786; c=relaxed/simple;
	bh=j3fBa9l17xJGeW1zP55U4tHHEO5y3kM0eFEuQCY+ZG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Azmd8U7bHCVpTeIvp1U3bhlSp/MrDlqv4ETca2Y+I85qQX0hN/aSdnt1VI+zhc6Ec2jNJh+AhMI1aESbUX/fl3ZF3sQj1DrCGFGuCm1divKqv4AKJ0AWUL7+vBekOccC0ihrG36KuLW3k5J8wWMYMbY31ovrKxaHubXPKL5FOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo/XSnnf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso358700a12.0;
        Fri, 23 Feb 2024 06:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708699784; x=1709304584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TlbnQOwYBlYMMApmGJ1zXcjNw0sZnUEDXVdJU5fMhSo=;
        b=lo/XSnnfHYmk8lTKX9uc3Asu1kSeAT9V7ioqlQr5JtmTvFXKe2qV4Yn5YQ4QEjHN/h
         kU74/Li69/Ahn5v5J8/UaE2jQ4iE5UAcWuS7+O0jNGaiNe03TlfuO4ZHStTo5iEdK78X
         jgV15t2/a1wL0rNLIopQmNSdAOi09pvea5UblA5D5TBCanQnroGk71YhQ20uGCTqrjqT
         Q63Z5mcTfTgoONgKRgV4Ox96+erNmPVE0nheZiEVzLv/GGAIgNuqlCzTpnTSBDhR27pY
         TuAB5b00v92jmf0Zzw0VzOs5rsM6hy05S8xA5c7SdNM6GlWMNK2nXbSClcfku05kvjwz
         dvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699784; x=1709304584;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlbnQOwYBlYMMApmGJ1zXcjNw0sZnUEDXVdJU5fMhSo=;
        b=Avuj+kIcyqI+/uK0oELQMaaMEr0ffvxzbdpdWgV0xD9XoTTwGv24Is+y0OFce1ewyA
         o6GEoRv1lo9rjnvTOUtIpmiQTaHrAoQCpELXvU4+SrTHoCPHgWh38is8vUGmVLz9Dxph
         y+G9vC1W1NP6rNNfjiV7XL79zzhw5IWPxaR8BO+yvfLFNy4R8YiKqB8Fl7wclw1NK6SD
         zEghKgRIusI1Z1XC42WpJ0rJO4V46hsXDmBsHLmmpypYeiPnRIOnH4R1YpOHTSe1oEnu
         AR16kvJZucR15UFLRCCEubpTIyJGY+sAmYJuNqAOwnFLojIFPyzQaR+9wmzSoVrNLWQg
         XdnA==
X-Forwarded-Encrypted: i=1; AJvYcCUsnXvk+PTAMSqgDt4+ot/4vWkDhu0hoeIGwRG7pQcPtlBf9ERPQWrn03tsgqnNhhIkG7UvvjKMeu959baH2SDR5HgE3oXz3ngfir8zhndSxG0pP78foalc7CK6Vt3nb/xPXuMR
X-Gm-Message-State: AOJu0YxHyXFVia88GYLTTxy/jw9/nI5Y4qnVCgS4yO4CGgE6cMNcWM+T
	vQpzABWJg3HbCuJAKO4dULsI+4PskFM9WP9IdGgZhEmvSRixFBSR
X-Google-Smtp-Source: AGHT+IHwwM8ZjVhLIm1URxzOa4ElRrjB93TN/rJA8UCGM8wc7dzxf2kcSSNBGIoOuite1Am+Tu6LLg==
X-Received: by 2002:a05:6a20:bd01:b0:19e:a36c:36ef with SMTP id fy1-20020a056a20bd0100b0019ea36c36efmr39948pzb.48.1708699783637;
        Fri, 23 Feb 2024 06:49:43 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y5-20020a056a00180500b006e45daf9e89sm10599500pfa.131.2024.02.23.06.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 06:49:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7ee8130c-e27f-42c7-af8e-a0a89bcf78a4@roeck-us.net>
Date: Fri, 23 Feb 2024 06:49:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 'Christophe Leroy' <christophe.leroy@csgroup.eu>,
 Charlie Jenkins <charlie@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20240221-fix_sparse_errors_checksum_tests-v9-0-bff4d73ab9d1@rivosinc.com>
 <20240221-fix_sparse_errors_checksum_tests-v9-2-bff4d73ab9d1@rivosinc.com>
 <30e4f267-86c2-4df6-9f33-d6f5fc77c4db@csgroup.eu>
 <fa37be6a8c014d39ab75978e10995ca8@AcuMS.aculab.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <fa37be6a8c014d39ab75978e10995ca8@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 02:28, David Laight wrote:
> From: Christophe Leroy
>> Sent: 23 February 2024 10:07
> ...
>>> +/* Ethernet headers are 14 bytes and NET_IP_ALIGN is used to align them */
>>> +#define IP_ALIGNMENT (14 + NET_IP_ALIGN)
>>
>> Only if no VLAN.
>>
>> When using VLANs it is 4 bytes more. But why do you mind that at all ?
> 
> Wasn't one architecture faulting on a double-register read?
> Where that had to be aligned (probably 8 bytes) but a normal
> memory read could be misaligned?
> 

That was hppa64, and the problem was with its qemu emulation,
not with this code.

Guenter


