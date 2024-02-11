Return-Path: <linux-kernel+bounces-60799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1082850992
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2796BB21004
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561E5B5CF;
	Sun, 11 Feb 2024 14:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AroeSt5c"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CD5381E;
	Sun, 11 Feb 2024 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707660559; cv=none; b=IoPLVxxIhvNvRJFwQGNxLJyk/t7DDJwLBxRiO2ww5BxF9hzyyHqswyTPq8su9VyL/Q5gag0b58LLf6UHwt/VjMlUO8+R24mil92luYyDY8EzK3s1passITP/fn4G382sjGPDlHMANYV7gPAG4Vfc4GMJH5Ty0lU0UxT4O/sRMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707660559; c=relaxed/simple;
	bh=yRXVWblo6BxvLZUd62l00fjolp+BeLUa8SCqI54j3J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bxo3VW7wF9P4659BaDCyN6d8RgH9dcomnjKtsFQuM04avHoldFpxKt/34/yx/nP8JeZQRodg6lQVuwvjoHBYnai7vtg7E7GTk11sFVRBI6ylpUv0s5QLuTpf69lH2KFDaOaWDbRiu+3wq82UyDbebAVfMfn6pJZ+tIKKmjZ6ZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AroeSt5c; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d958e0d73dso16429605ad.1;
        Sun, 11 Feb 2024 06:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707660557; x=1708265357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zZHmDtbUcT4NxOTPajRvqYG528tlHB0rEHNDedeqmXo=;
        b=AroeSt5cX8RsJNNGvvhlO/3xNJwIQkvWvbokgvPP58agPNrJBKdKSX9BxMXTxMnhb9
         Xm2Eh7ZgfDVCpWLv4dWb3tLN+xO/oUSeMwKA4pevhlToPIKb2mLGbpbeL/irW/0l1324
         W17dWrxObFCaIqumPq8YZHSsn4087li72nENiCzyXEdZLoYwdar8d6qS+lCStoXVF9GS
         NCT7bNOsoBFLI6Y33sofHfsLmaUy7xHEOVUAlYYIt6Q/bEsMvpzAx4xyr2UJeRWRE5D2
         VOBX+ZkarbRcl4vz2eiqV4wx9HHjvT8qCpVIYuW4L7bpOJMftzXVf4v172FUe1Lj9Sm7
         NPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707660557; x=1708265357;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZHmDtbUcT4NxOTPajRvqYG528tlHB0rEHNDedeqmXo=;
        b=dcqMyKNMsyKS7IZr6dtnD0687SQ1VyX9CSZdVfcqQ2pe0qcyteCDHqH/omguny3Vqk
         S6Gtnxn8eHm/u8PUQJs3WtS6Ee0vWp/rHwU0mzdODNvDPRZtUP9nEykXUlsmVkRoxRbA
         oFsQQApAg4/5JXJi4kdG8nMvN4eJZavvqg41BZdlWSw1nECWCmEty8I+atDWFjAhtBLv
         WBOrdSKjVPpoHt9fS++QN6jV5B7uaxthFGSX4P5bHcBElbITGTUwDOmMDqkDVW4ZCPzk
         gvLjOjJQbVOea79ykqUIBnqeFOVzfx8HhU6NLXf4FeLhgb/RoF5movX57TNhHWmchXyu
         ZZFw==
X-Forwarded-Encrypted: i=1; AJvYcCX2M+MWafuwRJuhEupj6vK/esHlTmWkubtJk3CK9Xf3tdCef/Tsb3zOiOJzUJtCqDX61eatYrxDyq+0rhs8FauttcWsLymGawmaimBd+tz7qYuT2Zp7x3CRah2sF+q1zY+Xtis6EwQktehc
X-Gm-Message-State: AOJu0YyKlP5FTfl2vaKTzoH9zCzDQhSWQ57E4+QiRx5CidhbfFB+2LDo
	9S+TV7jF5GqukC68EUmmFGe20qsC+TmgWV30HRYvfGa96AQvMYU3
X-Google-Smtp-Source: AGHT+IFQmjM7oQT2t+HW9ByReEBgPslTkxbHujKOO2h0fQiPQQ5N0gvHxOli8GQS+UP+vu5fZ/xb8A==
X-Received: by 2002:a17:902:e84b:b0:1d7:836d:7b3f with SMTP id t11-20020a170902e84b00b001d7836d7b3fmr6504630plg.9.1707660556781;
        Sun, 11 Feb 2024 06:09:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAMr4wB5QiiC1rjcvSdZP3hprmFxE/aB+RcTNW0gS5K2s8iMlV3V3T3qrc6QYGwLKZEULp+928O2b93tTR8JPNCsYU8zoTAS37cgbd0T77SMM31fB/xICvzi4+1IXdRrTHaY+4+iG2OCOLPrkxuzipjgERoPp7E0ZidzMOwxCye1HzzW15EtAUkRQMNFPnenC8Of5f5eeUxpNo5NMoyCZsawAruA==
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id li12-20020a170903294c00b001d9ef7f4bfdsm4404116plb.164.2024.02.11.06.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 06:09:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7aa3e2ad-ce91-4b5c-a253-e5fd3c2645b0@roeck-us.net>
Date: Sun, 11 Feb 2024 06:09:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: Fix csum_ipv6_magic on 32-bit systems
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>, Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Charlie Jenkins <charlie@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>
References: <20240210191556.3761064-1-linux@roeck-us.net>
 <dae9f9c428a242368d47ba29561e9455@AcuMS.aculab.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <dae9f9c428a242368d47ba29561e9455@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/11/24 05:57, David Laight wrote:
> From: Guenter Roeck
>> Sent: 10 February 2024 19:16
>>
>> Calculating the IPv6 checksum on 32-bit systems missed overflows when
>> adding the proto+len fields into the checksum. This results in the
>> following unit test failure.
>>
>>      # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:506
>>      Expected ( u64)csum_result == ( u64)expected, but
>>          ( u64)csum_result == 46722 (0xb682)
>>          ( u64)expected == 46721 (0xb681)
>>      not ok 5 test_csum_ipv6_magic
>>
>> This is probably rarely seen in the real world because proto+len are
>> usually small values which will rarely result in overflows when calculating
>> the checksum. However, the unit test code uses large values for the length
>> field, causing the test to fail.
> 
> Isn't length limited by the protocol encoding?
> So this is really a bug in the unit tests for using a length that
> it too large for the function?
> 

Arguable. While the length value passed to the function is not a valid
packet length, it exposes a weakness in the implementation of
csum_ipv6_magic() - after all, folding proto+len into the checksum _may_
overflow even for small(er) values of proto and length. It is just much
less likely to happen if the length is limited to 16 bit.

Guenter


