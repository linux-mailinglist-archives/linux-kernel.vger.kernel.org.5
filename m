Return-Path: <linux-kernel+bounces-79737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E48625FF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D36FB21327
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F80847A6C;
	Sat, 24 Feb 2024 16:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+mSUysw"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65EBE559;
	Sat, 24 Feb 2024 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708791572; cv=none; b=dhjDQQxn32sq98QcDLKwU7l+tPIENHFhUDsLHTr8VzpzeJZZgV7QkfPyfBbNzbtWg4VpcvsmL9WLjNzdSB7qt/12W5nqBtYT6Am0bxwMAD7cV9BFazIxNg6PU5xw2sE6FvxytMdctb2AUhppFNfLvZOeUWvSu+kgOKjaeiAjubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708791572; c=relaxed/simple;
	bh=R+RLgxsmQRIpqojcm4jtOaje2cFePuTttTDmu000CD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1jUjY/F+WLVS4Dmsj8N39BEanNFQuFL9abibJ7Pi04YbVNyY8qta8kscWiyR8UeJlSvCuTiBvDRB91nASwJ6QmZK60zuafxQdOveczYIZcMMF2IBtZ74XfP8S9RcHhgpF67gKaT7sPLoI6HPiorYdTb85NZ7CxdKX5mf/rBwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+mSUysw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dbb47852cdso15311615ad.1;
        Sat, 24 Feb 2024 08:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708791570; x=1709396370; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=JBNs0Oi94uBYMVQINhZjuNAnoif5ufke1sq/NtRZBoY=;
        b=U+mSUyswagaeA+hb3plFgJtc701Ar0ka727MPT9uIO38KfCh80rxyFft1F9qnyqTyX
         iFxz2t6aYGTHpRMGVqKruUxN/qT2ZVCu8f8cmIPMyVeqGL2jnWGzz8nGCxDcdQ8KZobv
         c7dAajYxZxDrczm9xSdqq6biB7I+ExluvEGa+Ci4ZeRq/mdXQ/X62lc9iwq/8wBD+O0G
         TqHgsqnzhre8gWhk9eWugh3eVb0sJ4eAoATSKc6R29XrPrlSswaUxaeCyV08eVpSHe73
         bk08RZEG3LrV3jdmkPhNP/jN49p2fN+1oh7ejPRMRPdCu94RzRmSUczb8Pb8ORzE6ljI
         uc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708791570; x=1709396370;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBNs0Oi94uBYMVQINhZjuNAnoif5ufke1sq/NtRZBoY=;
        b=VEQf2SmtdEldsHd48Iq/4YSZkwJv3MRTpA5iyXocYOHobDFJvSAiOoC2lcaiKiZldB
         KrtvQyLqXyK/PJQzBvuikodG3C7YugpMo//AEJp79JmjZKHomlD1ClPX+EaMjcwlq/31
         5PO40FC9b+kxAx60kTnQiNHriK3rtWMld0swl1K3r8kzmg+cCWBlvLb9q0e+AN7rQ1Jf
         KqWfRlOX3CmNqQ3NL9UCIc5LWxpi8DoJplhBh0wN42Iuev7E2FBARe03pafcsmy8EDSp
         fR7WDBiOSr7WY83KHrpK/fZQ8rUoH4Q5QpQvK4U+ATxAirzEQfwddwMq4Bi0IWwkAe8/
         V50Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeCR0Waah36J88vQqXEb7FlpVwZUB12F01NSGe9aPOjLL4WoqGrAXXUnlLx/R/Po7uHjDPSZ5V0AAPytmaPVls0Q3jyiaq4rwtwf1AdXQ=
X-Gm-Message-State: AOJu0Ywj/FvOcHblDsHv8VB4vFsS8QssBQVKOQpBsAqsgYhmJEfrzgfK
	M79e8Blkxdb6Q4MPvWqoaysgnUOWCZ35A7p3gsZkOeSXXqglVwee
X-Google-Smtp-Source: AGHT+IGELyXuQzCDZacW1wh/ZUtMTpKs4E9eUXHQ0DkhYJlrkXhBIRf1q5wGtZ8I45vETVfGvG0arA==
X-Received: by 2002:a17:902:ed0d:b0:1dc:78ea:1ae with SMTP id b13-20020a170902ed0d00b001dc78ea01aemr2644698pld.26.1708791569725;
        Sat, 24 Feb 2024 08:19:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z2-20020a170902834200b001dbe88fe462sm1181903pln.220.2024.02.24.08.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 08:19:29 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e6d0fda7-09db-4955-92dd-def2df768da6@roeck-us.net>
Date: Sat, 24 Feb 2024 08:19:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog: add in watchdog for nct6686
Content-Language: en-US
To: Mark Pearson <mpearson-lenovo@squebb.ca>, David Ober
 <dober6023@gmail.com>, wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 David Ober <dober@lenovo.com>
References: <20230912112747.285393-1-dober6023@gmail.com>
 <78da7ad0-cc11-4e6f-bf25-12bd5ec247a0@app.fastmail.com>
 <8458d626-8862-44ed-8966-2f60852c92bb@app.fastmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <8458d626-8862-44ed-8966-2f60852c92bb@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 11:49, Mark Pearson wrote:
> Hi,
> 
> On Tue, Dec 19, 2023, at 3:05 PM, Mark Pearson wrote:
>> On Tue, Sep 12, 2023, at 7:27 AM, David Ober wrote:
>>> This change adds in the watchdog timer support for the nct6686
>>> chip so that it can be used on the Lenovo m90n IOT device
>>>
[ ... ]
> 
> Would it be possible to get feedback on if anything else is needed for this patch please?
> We have customers wanting to use it, and we've ended up having to provide it as an out-of-tree module. Would love to get this integrated into the kernel properly.
> 

The locking in the driver is pretty much pointless since accesses
will be serialized by the watchdog core. At the same time, all
driver-local locking will not prevent access to the chip from the
nct6683 hwmon driver (which also supports nt6686). If both are
instantiated, I don't immediately see how they would not corrupt
each other.

Other than that, there is unexplained code such as nct6686_wdt_set_bank(),
which writes two bytes into the chip, and nct6686_wdt_reset_bank(),
which only writes one byte, but only conditionally if the bank is != 0.
That doesn't really "reset" the bank; at best it selects bank 0xff
unless bank 0 was requested. I don't really understand how that would be
"play safe" since it is not explained what that means. Besides, the hwmon
driver doesn't do that, so I don't understand the implications.

Actually, looking into both the this patch and the hwmon driver, it seems
that they are locking out each other, with "first driver to probe wins",
by reserving the access memory range for themselves. That is not acceptable.

I'll have to study the chip datasheets in detail to understand if
there are other potential issues, and I have not had the time to do that.

Guenter


