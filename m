Return-Path: <linux-kernel+bounces-68088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515828575D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65359B21988
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DED13AEE;
	Fri, 16 Feb 2024 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0xrzjya"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6980A134B6;
	Fri, 16 Feb 2024 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708063788; cv=none; b=FQKWMFh+qHEY+M4+wo3DfSMS951Sn8Bnb8N5/41BvRX6A8nlZ9prYIDezizuLvezxuv3NqcKMS2KeZkrHheX6kGtjxn+laufQcU3FER1WIQbwe2ohWKM2qacTTWb6SVmL5iNA5qn4z/Ftsg/Fj5DrMD0KnJZaxUHmuRFfv+M7Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708063788; c=relaxed/simple;
	bh=NsAaHY7jLv2O2fwYO5I5CPld086jq0tUMy2kVhqw8fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lltCGQlBAvotoZzcE1k6fh3dWwEPR7APhFF9ORZPQ1kQ+esoQpZo2X8UPF68Amm83IPL7ZF64Bd1seeQlr25VbqFluE+FRT3IhrNljNsfUESgE0YmiiOofT5fhPX6Ly4i/QzW50M2SiDjgUVwj2bRA6bWt14xZSh/dN9fMXLTtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0xrzjya; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e08dd0fa0bso1397113b3a.1;
        Thu, 15 Feb 2024 22:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708063785; x=1708668585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XJT2O5R18NRjacBCDgRTZDqocBDMWv89oyfM7l/Sab0=;
        b=m0xrzjyanmKsYeM4ZyZ7XpCXnK1NErikwXw0oLFxaXsTqXjKejmvJv0iIpIl6RfBjX
         zPNvHZLbCZJrBzJ9oj4vCbRZcbH6zcUpwwqu3dtmGbc2ZWvPluoOx8UjEeyfNuRzjLKr
         HUyLHwzwGW6Vrp3swF4cX/+UMRmxN/qEaqo9P25mw2BBgWYrGFqWGy2/YVrk8SG6R6WB
         5q4mU2iCsFa8+c2QzrbbXPi+9VyiEnZ6bTv1C+IML8d61bu04FdH6Ol/n7xVZwi79nUc
         MR+0drnT/N5SIjQLK4l1IIJALfXIa0Cjcih3+Vd7f2Re1iuvN4K3pNpV38txSfYyrKai
         BL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708063785; x=1708668585;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJT2O5R18NRjacBCDgRTZDqocBDMWv89oyfM7l/Sab0=;
        b=GJANoCT8TCLVehaToPMHmg1+gfRWFMhxtWjTh+gJ4/wbEP07EOEV9ntdjTvZKlaT8q
         pzz3QBh3LO16MErVRXqnZQejYdASSg6SUVsCFTaMjUtrjBnPRHGXCI5/t1783pCRVsAr
         vn4UCc6HzR+XCXKUbVrg8H3pSDt9UnPjyf5yPrsppGPKhzRW/PwREO4LOXLYcRdOB/kI
         nbnDRx45c7TBzcd7N+B7umC9JikufYAw3YWsvi8DHHN9DE7pbyCHKrsOYvSelY9GCk7L
         8n6s7A4C9tDEcOzcRHfMj4P/NjS40YdOEA5jtU79j3JPRjekVcolyfEeSHCLQizv1/70
         rtzA==
X-Forwarded-Encrypted: i=1; AJvYcCXYH3w31GvOm85oL5PDaOxuOzeL8I9Z+fIZNQ1LyykyQZhlStU1ZImTzx2ck5iFKqQcqzsJ2XWSA1+nQZg9wlbSQbl+xKDp9dDafynpVWVy0D6rPT/ONzCT2EP2l7XoqQm5PPmODptSyJ00
X-Gm-Message-State: AOJu0YwgAu069rKJZHQi+wc+kwLkGB2lP10hvw+I9fvDQ/xqnifblHGm
	OBXnzoiZc3ihjf/ki4BCXa+ZNYHFpjZmCt0QwtrecSgTkFbCmn1H
X-Google-Smtp-Source: AGHT+IE4L9wo8piz+NqyEXDhzJ/JFu0Y/VCML36qBzQfu0wFUdwE7FeztWuAqurDL4OLNyTRklFoaw==
X-Received: by 2002:a05:6a00:2d04:b0:6e0:a346:834b with SMTP id fa4-20020a056a002d0400b006e0a346834bmr7162486pfb.1.1708063785051;
        Thu, 15 Feb 2024 22:09:45 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x10-20020a056a000bca00b006ddc03c425bsm2310025pfu.180.2024.02.15.22.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 22:09:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6aaa4b89-a967-4b19-b4bf-a1ad5c8e9faa@roeck-us.net>
Date: Thu, 15 Feb 2024 22:09:42 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net> <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
 <25f108d1-827f-4a18-bee4-4105fbd45974@gmx.de>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <25f108d1-827f-4a18-bee4-4105fbd45974@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 21:54, Helge Deller wrote:
[ ... ]
> 
> Can you please give a pointer to this test code?
> I'm happy to try it on real hardware.
> 
You should also see the problem if you use v7 of Charlie's checksum
unit test fixes.

I submitted the qemu fix (or at least what I think the fix should be)
a couple of minutes ago.

https://patchwork.kernel.org/project/qemu-devel/patch/20240216053415.2163286-1-linux@roeck-us.net/

>> It is quite easy to show that carry is always set after executing ldd
>> on an unaligned address. That is also why I know for sure that the
>> problem is not seen with ldw on unaligned addresses.
> Interesting.

Ultimately it wasn't surprising, with the unusual carry bit
implementation on hppa. The upper 8 carry bits were not masked
correctly when returning from a trap or interrupt.

> In general I think it's quite important to differentiate between
> running on qemu or running on physical hardware.

I know, that makes testing always tricky (not just with this
architecture) because it is often not obvious if the problem
is a problem in the tested code or a problem in the emulation.

> Qemu just recently got 64-bit support, and it's not yet behaving
> like real hardware. One thing I noticed is, that read hardware
> does not seem to jump into the exception handler twice, while
> qemu does. So, if you run into an exception (e.g. unaligned ldd)
> then if a second exception happens in the fault handler (e.g. second
> unaligned ldd to resolve wrongly-coded code lookup), you will
> get different behaviour between hardware and emulation.

Hmm, interesting. Makes me wonder how the real hardware handles such
double traps.

> This is also the reason why qemu still fails to emulate newer
> 64-bit Linux kernels which uses kernel modules.
> 
I don't use modules in my testing, so I'll leave that alone for
anther day.

Cheers,
Guenter


