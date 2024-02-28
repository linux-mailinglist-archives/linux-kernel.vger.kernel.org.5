Return-Path: <linux-kernel+bounces-84641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CB386A964
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E771C23F42
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A69625625;
	Wed, 28 Feb 2024 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYl74bz4"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BEC25601;
	Wed, 28 Feb 2024 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107172; cv=none; b=n770QfDpUwQ+k9aJ0O19OsCp63IUCK8tc4DwdmiJmssrmwfKrNfqNwZ6DX2qTuGbI9LNrImbqe7rDVKuWY1JQ6laRusxlESiAB4N3cM7ogEWBT1faO+ymmJbaBPBYYgehe7Qnmf0Or4cQaFupEwr0Q60ohbLn2Jf1dEn3uoSQL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107172; c=relaxed/simple;
	bh=s+MTxz3XZi58tmfPU4UEzhWO91JXf7GqfJkKcYbl45g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXczge1SEykw+e0UdIqKR/HyDA5qKYpzOZB9Q5AsLVXbQz6zC3INHblpYK6zqT/pqLlpqGpgD1VM+cJfzUXoAptExAjYRSzJEJUZcCoaeFbwPXbMYUm0/OR9jI11nkwh5qzJIbN/Xm8wwXyJHV2edqnY7A4aF5dMiA1shsmnQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYl74bz4; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5a058b9bd2dso2461792eaf.2;
        Tue, 27 Feb 2024 23:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709107170; x=1709711970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=26+dqjvjj4vr1Nm47nzBeWoRybtvVYDtXt2JoODqBl4=;
        b=EYl74bz485YDkncCkJErnSHIL5DNPvZ3XoLkQAW5vki9j659P7C9mcgxp/VbFY8B9n
         UT6ChUmcisX7WZ47jGMCLAfLkrrE7pWmXk/BvRYKDeMHw5YLbPzJ2mIwVRqDfuhddnnX
         PrYAFS+S07i85pYFf+QrMHLqd5JO00TgbyxVUP7nPbXQNg9yRKeqgb03pf008jCLiqAx
         TBObt4SqU4K2VbISClPSAb1k2xhVUCKbUFVTehkXsIkJvMyiH3d9ePKHkAYR4WlaArQe
         sWmIFv9TVtKsfG8KiOEnmmOJI1smMXEmAQL7ZlWz3y4RiTVsyxaUP6HjhoLgZbqPKJvq
         fPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709107170; x=1709711970;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26+dqjvjj4vr1Nm47nzBeWoRybtvVYDtXt2JoODqBl4=;
        b=Z5nICP+i7uSU7dijrnAXfzWQmTtGBE0sX9PeVKZHH34vBoAEq9UKU0UFamdc2OaOnK
         hacd6Iko5+x0QXMRI1e3YkAHMBvoFvVgL7Uj4/wTYB31AjKxl92B1giO1pHpGycpqka/
         +z78XbzP2gEFpP/Z0xxJz0bT2prLqxaRNxa54vjHzeVItnYjKz8PdXxnHzK6qprxEpKp
         EtKid+mNelHyjlvPPwpw4pLaM857BlV7VHumMuQEOGpZiOQ25ON/ZG1l8/5F2DFG/ayf
         L1+ZS6Ax3PL0O3LjTYpDenqNf+Vpz5Uh6S+H7Zp0QwgAHKsPdsFKTaBVtDCdIGS7i1j9
         4kHA==
X-Forwarded-Encrypted: i=1; AJvYcCVvZmtVBEaaQIuCYcTpqDUk8Q/wn3Ic22ypwy7j/B25RYrwXJyYxXECjpEJI1XqKhIiB4J9J+gpj9yepsFNaYqv95cHpeLLBHl/MoKD0HBMfGPtB47ulJuPUkC1nWYkyD6LhgpI07nfKP/+
X-Gm-Message-State: AOJu0YxJpWk/Fod4BQ9YmbbK7eAC9i+vkP1jYJSlE7+brubAzy2CYuWN
	YkGZvnSfhOgwaEVNa/Ru2OziaJUDyo7+MLbDmA8CqLgXTQpCchRY
X-Google-Smtp-Source: AGHT+IEx6reRBTmrhs+IVZ6DfccJmCzi8W4flQcW+LUK9CctDitl3PYulhop178jQEaokbrd0Mtj1A==
X-Received: by 2002:a05:6358:5623:b0:17b:5dd1:a38d with SMTP id b35-20020a056358562300b0017b5dd1a38dmr15297176rwf.1.1709107169924;
        Tue, 27 Feb 2024 23:59:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j23-20020a632317000000b005dc4fc80b21sm6971886pgj.70.2024.02.27.23.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 23:59:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <02bb92c3-a14c-4a77-a3b0-a7c857d1d60d@roeck-us.net>
Date: Tue, 27 Feb 2024 23:59:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Charlie Jenkins <charlie@rivosinc.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk> <Zd58jvN3PjQSe+yt@ghost>
 <c0449c0a-33bc-49c4-97e3-56a79a6ce93e@csgroup.eu>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c0449c0a-33bc-49c4-97e3-56a79a6ce93e@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 23:25, Christophe Leroy wrote:
[ ... ]
>>
>> This test case is supposed to be as true to the "general case" as
>> possible, so I have aligned the data along 14 + NET_IP_ALIGN. On ARM
>> this will be a 16-byte boundary since NET_IP_ALIGN is 2. A driver that
>> does not follow this may not be appropriately tested by this test case,
>> but anyone is welcome to submit additional test cases that address this
>> additional alignment concern.
> 
> But then this test case is becoming less and less true to the "general
> case" with this patch, whereas your initial implementation was almost
> perfect as it was covering most cases, a lot more than what we get with
> that patch applied.
> 
NP with me if that is where people want to go. I'll simply disable checksum
tests on all architectures which don't support unaligned accesses (so far
it looks like that is only arm with thumb instructions, and possibly nios2).
I personally find that less desirable and would have preferred a second
configurable set of tests for unaligned accesses, but I have no problem
with it.

Guenter


