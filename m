Return-Path: <linux-kernel+bounces-67678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D84A856F06
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E6D1C23965
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0851C13DBA4;
	Thu, 15 Feb 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxURP0X0"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1D13B7BE;
	Thu, 15 Feb 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708030824; cv=none; b=KWqDxy8KYUZTW1eMr9oYkdWiDa2lquDKp7IfrG6SBDzBu5EgTkoPAZO8/ZrFXi9RKkBtD6TlujsxUvxEN2eslB5cVVCe/bW05QEtj4xOHq3izclxD3VnOwxIF9m6d4DTTVJsKPKr5IPJR0KgyhjrX+Ega46Ri0GTaTNcxcClrCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708030824; c=relaxed/simple;
	bh=53Mu9cGB5wb1HJfNAn5BsQa78TDz+/wkO5uV8c2hdn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GvWH2ratI1cbYizNlBsSjmvThsnyUjdPSRBjK9mrxDhharRxvG0g8qexnlQKzAWCN8IEvok2ha4QDXjU/yBKdem3yNbC1/KNrpCTA5KuEOmDYAJunPNHE6UZQu7GDelI++/Nq838gFuKsTarb+dtC3E5NTXAv2S89Vq+YNzh6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxURP0X0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d8aadc624dso11402365ad.0;
        Thu, 15 Feb 2024 13:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708030821; x=1708635621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fEgnRWaAtEdivkp/3IziVxJ4IsdiQ4k5jTNKo7VrRLA=;
        b=BxURP0X0VyBfAKoueD6pNCRaZfVAX5AtenNG15B+XIHdMIDRZufyhy8oTB1xkXS1nK
         5gjnRr5PLaF/mzM0nxAZdQiPV7DvUhqmR0Tsfkx3DGx+3lGihfMA8XyIM56bl/iGJo0z
         wLea9UEc+UCf03NLIip7uv60b6vMN1TSKbhxgYd4o8V0fjIy2CweosGTB1CJzd26uCH8
         g8aVH61qOLcHcjsq5o72NCrUzJpdm5FAaN6bHVTp/lv0WtefL+xg1DvMBjUFxqcpzwYn
         xcp1UloUa1erfiljeXVMQVicqdwQ4yFhifRhi1gDT3Sa96vZgCk0B9Iy+WTOhiN1zWIz
         r3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708030821; x=1708635621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fEgnRWaAtEdivkp/3IziVxJ4IsdiQ4k5jTNKo7VrRLA=;
        b=gfAnuLCUxIq6O8e90jpUo6z2ry5STnd345t1w1mBZqBOjOXP9Bfxyj1rpzxJPqg9OM
         E8McxNgecu2IJdtnELNVeP0HCTQaeDe8KmF6w9shZ2Dft39jMSAZ5h6d8aP6jcJoxHXN
         acR+9YOljPDlgbMoSMpu2tkHwaOKsO3UGmRpfTBnT2l5ldjmHI2T9BMZ6xtrWKPSk4Kp
         y0CESlayxxyXFxRFd1d5ex6W8U56VCgK9DUV1Kv9zpEod2om/Ettjg0rJj2YCQLYng5a
         x0JSvLfp8Ku7kdYsKn+GMCYRn/9RUlN/5ZFt4+DLSfcQK5bc6jgCzNXuA8wn7qist91D
         l37g==
X-Forwarded-Encrypted: i=1; AJvYcCXKsvt0B4T1pbsFPm1xTSgV7azc0ChlJetxQWd+14/Hs47qPlblilgp3n9t8lSHbRnQbE+ts3n1ut9fMlIfk0++ZtDHHb/t0Ngc2q57
X-Gm-Message-State: AOJu0YxW9/jCIgmSRZMCpfNj6xVmCxfyVAduFpmwViwOpiFO18UGo4pR
	CM6J2oHTI9De6dynRXAPgV8/o2wVGWK2lIK1hyirQFqz0l0TBBWm
X-Google-Smtp-Source: AGHT+IFVCP1SmmHnE4CKqqQYAQZhzEkkJgWrHJWUH/t9c8xbrhb/3k5bd0u1J8TAputAPiIZpBblqQ==
X-Received: by 2002:a17:902:70c3:b0:1da:1559:cdc6 with SMTP id l3-20020a17090270c300b001da1559cdc6mr2848960plt.44.1708030820384;
        Thu, 15 Feb 2024 13:00:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902ef0400b001db3a0c52b1sm1701380plx.88.2024.02.15.13.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 13:00:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f61d981f-e548-4c59-a013-5f17bca869d5@roeck-us.net>
Date: Thu, 15 Feb 2024 13:00:18 -0800
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
To: John David Anglin <dave.anglin@bell.net>,
 David Laight <David.Laight@ACULAB.COM>,
 Charlie Jenkins <charlie@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
 <a7e9691432374000b9566a0201d004e6@AcuMS.aculab.com>
 <c22f28a2-b042-4abe-b9e4-a925b97073bb@roeck-us.net>
 <4723822c-2acf-4c41-899c-1e3d5659d1d8@bell.net>
 <1e302d8f-4e94-4278-b556-b8fc54956efb@roeck-us.net>
 <e73bdc36-5fb1-4ea8-9f96-608eb1a9b6af@bell.net>
 <34c8d6f6-3449-4a5f-b8c8-50faf1621714@roeck-us.net>
 <405791f1-7e51-4ccd-8ec3-b0be6ee8f203@bell.net>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <405791f1-7e51-4ccd-8ec3-b0be6ee8f203@bell.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/15/24 10:56, John David Anglin wrote:
[ ... ]
>> It looks like commit 8e0ba125c2bf ("parisc/unwind: fix unwinder when
>> CONFIG_64BIT is enabled") might have messed this up. No idea how to fix
>> it properly, though.
> This is Helge's code...  I'll let him fix it.
> 

I need the code anyway to be able to debug the other problem, so I'll give it
a shot and send a patch. Helge can then go from there.

Thanks,
Guenter


