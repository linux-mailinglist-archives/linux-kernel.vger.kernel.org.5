Return-Path: <linux-kernel+bounces-8415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B345381B6D2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6965D1F2131D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B16A768F4;
	Thu, 21 Dec 2023 12:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNiAhckn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9081B768E4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 12:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d3ea5cc137so6352165ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703163449; x=1703768249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=musVmUuCpnjPGleACL/byj1kr0cfsw28MzXrnkX6PJs=;
        b=kNiAhcknrsaulNoamg9HtCowisepmly5eG4OTukjL5VZXmDkMggH9zwgRrAStI1hR8
         BvWDv6j8aSp0PX0psVvZf4gWFM7ek3CBR6YESalB5VDZB7ab++PPOEgFXCfJkEqLR0al
         hflV/vA2aTk+O4BSNME77ZNYDPAf0xXnajyxy0+UXuEq6wM7jbyNtM81uinwuCqxzIXc
         Ws07LGKxwTzND9v2F6rWrSuU9iC+ZByOvN0Qr1vwGtXL2PNLfJsrYZ3afktRJC8A7dH4
         7vAJi1+ht9izeGz00EW5fLsxy/WSaXqgiz/GE3/UWxThD0GPXi3mM65QfechuSoM0Myn
         A7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703163449; x=1703768249;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=musVmUuCpnjPGleACL/byj1kr0cfsw28MzXrnkX6PJs=;
        b=ktRzJ8dU12q3yO7rCimTVJqPJ4943dimXbVP0bFULhwIF1xo4zHc9EPaDrr7ej/NTX
         i2Vh29KxNWI6wN8cZKyMn1U9MCJrzObjPoaPHyXKtHsrGLoV/5mOH0WwN+JXeUpcyfKJ
         x5NwrtGFINKwMWV/80l/4vxePJklcSamWE97870jEJ18T3LQ6g1dk32a2ejjVcnacgiI
         bopV54Zc0JZk/nb+OsYz+mR+c2uPXVQucphXc6S4BQEnQ1fVpuN1iXM2aEywqpuUpDJT
         jE3f2ZNriDVC5HUzNi/EtI9cDZV1xwBQHbLfo3NQ1O/BKsdXHbcWH8INSHiS2XYT9qc6
         Kx0A==
X-Gm-Message-State: AOJu0YxGkaT6+XvmAFkZppi0dM5L7IdoMA1+AW093CvVb0huWaKEf9Os
	NM1RErNW15fwQ5NHwHjd+Io=
X-Google-Smtp-Source: AGHT+IE83WLqTmJQCap1InNLacVDE0wJkQuQau2txCTQEmJoSOqYP0pm7IV5mVJnb29ieMz3zYuT/g==
X-Received: by 2002:a17:902:f68b:b0:1d0:6ffe:9f7 with SMTP id l11-20020a170902f68b00b001d06ffe09f7mr27771648plg.85.1703163448802;
        Thu, 21 Dec 2023 04:57:28 -0800 (PST)
Received: from [192.168.0.106] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id g24-20020a1709029f9800b001d0696e9237sm1560048plq.118.2023.12.21.04.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 04:57:28 -0800 (PST)
Message-ID: <cc276c0e-99bb-4422-9771-d864db4287cb@gmail.com>
Date: Thu, 21 Dec 2023 19:57:21 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "Link in bio" instead of Link:/Closes: trailer
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Staging Drivers <linux-staging@lists.linux.dev>
References: <ZYQeZjN_3bPOdKKf@archie.me>
 <2023122112-rigging-january-7618@gregkh>
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <2023122112-rigging-january-7618@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/23 18:51, Greg Kroah-Hartman wrote:
> On Thu, Dec 21, 2023 at 06:15:50PM +0700, Bagas Sanjaya wrote:
>> Hi all,
>>
>> Let's say that there is a content creator who submits her first kernel
>> patch (touching drivers/staging/ of course to get her feet wet).
>> The patch supposes to fix a reported bug, with appropriate Fixes: tag.
>> But instead of using Link: or Closes: tag to the actual bug report in
>> the patch, she instead writes "Link to the bug report in my bio", as
>> it is the norm in social media world. Here in the context, her bio is
>> LinkedIn profile (IDK if there is a way to add arbitrary link there).
>> The link in LinkedIn profile, when clicked, will list many links
>> (including her usual social media campaigns and of course the bug report),
>> which makes reviewers confused about which link to the bug report she
>> means. In some cases, she may disambiguate by saying in the patch,
>> "Link to the bug report no. 99", to refer to the specific link number.
>>
>> Is such practice a good idea?
> 
> No.

why?

I'm confused...

-- 
An old man doll... just what I always wanted! - Clara


