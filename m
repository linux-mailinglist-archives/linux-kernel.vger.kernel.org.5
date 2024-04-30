Return-Path: <linux-kernel+bounces-163357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3348B69C7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF6E1F22D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3E175A6;
	Tue, 30 Apr 2024 05:15:35 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315A199D9;
	Tue, 30 Apr 2024 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714454134; cv=none; b=A8rUA5I97ccCnyqPRp6HAnuRLA3UljQKelgRhjv0R753rmaFCgHrBrtLWb5Zh4JFbyTNwtj1zLGQ84Wcvuv/dmUqJ69v93vc2Dt6QzveFdf9IqU7RqqeT8nAFzrhyd+xuVrT+Rr1zaSnBzqZ2kLLg/ZYsutEc+z0t/S2999X5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714454134; c=relaxed/simple;
	bh=K/Trbl5Hys+WHbMtuQ3ZdMwcnFERxG2HBEWXhzrFVOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkEP3zbKvI4mYmn6NMphtunxgergW58Ix6qnAgPCChkwXCENs1OVJqc/UzFoutztwfrgiVKMvB5MqDXB8+8YKCzqu+ToXd6laIo+aZguwlrQOe1EOtg99yhJk9hY7DLlg5Kf6LUtOiPFWa/CMTc4WpRGul/+MGKYDL9D7j0WE0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5726ccca4c8so3270883a12.3;
        Mon, 29 Apr 2024 22:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714454131; x=1715058931;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aoR7iLYPrGYLCsHQuPiM+/n3J7qjHQUGOA9mseIQEqs=;
        b=cdclYVzRy7NSAva2NWsI9PB8hgXWj55tqaJxZ8Mj+4Iv+tj+lOX/1md7/X8JNzS15a
         mA/2WcQr5Cf5OGsCeT45UhyCVXJmxA8pe+THQuzpV5i7Ne8vovyoruRMC4vtAQ1qA4pp
         J1ObARZwu012ecxyaZx3BI//Nb/ZmdhXy7Ew75akU7x5eQMbcVcUez70hwG1N0QhZ8VA
         V41Yo8QjIpgzFibA7fpeqv+O6q+R1QYt9XF66n79ymADMHiGqXS3Gv0FLSBZmxxHwYz0
         Zs9HY3UoUfp8G/Ypz06BYnTYpD2REnD7N1uYhf7cskhF/5eXFOpZCawPqV4qcFUUUwVt
         UOOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1AqGDr50I2VyaPjPKAhou54AsJMGj0Ve7gNHxwHBCPtrTr6YGVnjoRaZuNmDfogcVGouFbZC9PfAQgyxIq6upSEmLLD3DN13vH8C/PxCUWVO2lwb4aRhORy/lAVtaDWab6NaY
X-Gm-Message-State: AOJu0YzyeRl+aCorHdCJi349uwDBJ8bZ14r8sJIbuipaeIR231WwdhMX
	SsGWkLNL1CPGr/r/T6V8WsH3o/lnPoKzDTr75ojPMaL+3g4eecjy
X-Google-Smtp-Source: AGHT+IEaDlYEmS6Iv6psRELi1epqO2BGnZZCKdjWcXOvoMTJ+x8riL/Ylim/jhsvnJ6xQRD49p35/A==
X-Received: by 2002:a50:bb6f:0:b0:56d:b687:5a45 with SMTP id y102-20020a50bb6f000000b0056db6875a45mr9111555ede.1.1714454131234;
        Mon, 29 Apr 2024 22:15:31 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id g1-20020a056402428100b00571bbaa1c45sm13795878edc.1.2024.04.29.22.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 22:15:30 -0700 (PDT)
Message-ID: <4ce6cf96-685d-4792-b2fd-949c07eff707@kernel.org>
Date: Tue, 30 Apr 2024 07:15:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/purgatory: Switch to the position-independent small
 code model
To: Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Song Liu <song@kernel.org>, Ricardo Ribalda <ribalda@kernel.org>,
 Fangrui Song <maskray@google.com>, Arthur Eubanks <aeubanks@google.com>,
 stable@vger.kernel.org
References: <20240418201705.3673200-2-ardb+git@google.com>
 <3f23b551-4815-4a06-9217-ff5beeb80df2@kernel.org>
 <20240420131717.GAZiPAXY9EAYnHajaw@fat_crate.local>
 <836c267f-a028-acce-8b19-180162a5febc@suse.de>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <836c267f-a028-acce-8b19-180162a5febc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 29. 04. 24, 14:05, Michael Matz wrote:
> On Sat, 20 Apr 2024, Borislav Petkov wrote:
> 
>> Interesting. I thought gcc doesn't have problems here yet and was
>> talking to Matz on Thu about it and it seems he's forgotten about his
>> statement too that "you should simply stop using -mcmodel=large.  Noone
>> should use it." :-)
> 
> It may be so ingrained in my brain that I'm not _always_ saying it when
> talking about the large code model over a beer.  And indeed I know of no
> particular problems with it vis GCC,

Of course you do :). That bsc#1211853 I linked earlier. I.e. gcc-13 + 
-fstrict-flex-arrays=3 + -mcmodel=large + some asm() expecting __FILE__ 
to be constant (not true with the large model).

regards,
-- 
js
suse labs


