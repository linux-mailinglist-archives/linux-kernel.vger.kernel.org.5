Return-Path: <linux-kernel+bounces-130683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2088897B9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D28B2837C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73990156984;
	Wed,  3 Apr 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acp3noKY"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C29156966;
	Wed,  3 Apr 2024 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712183147; cv=none; b=WSTAkEQbrRRAfT4iLweQz8ziH+gWV0QADCenSJZHS/3BJWTTLzZCF0CgykCuMB0ek41rnF7xu0jMpuymi4b3g0NUDqym/lhWrNEYLmu0tNBOU7bY21QefbmpbpmG3sygd3j6kGZ2CvhRJIpfcV7aOHs9dJaqNyMm+qnY4Om+77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712183147; c=relaxed/simple;
	bh=+jvrPu3Zzy3xz4f0e+F0SzQY0JxQx8mrXaA0C+/nwTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zq0MPGtz7OvPmjmQAeGQdZkGocxVoZPLE9uImT4gf3WzRqdVjDbERaukGGGf9RE7JCtJjlDbhNk8bUPHs3Mb1/bSGsNaWefHP15LTJss0/DpO4myaPIvq4Lh0jiQxmfuoOVmaEIzj6XoLlizLmCsBH8Y2+eQIyvbk27Dnx7cXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acp3noKY; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516c5c39437so389356e87.1;
        Wed, 03 Apr 2024 15:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712183144; x=1712787944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLajy1Q9xVKBjLw8NB/zHA8NnAkziwigu3iuNpIIZ6s=;
        b=acp3noKYj1c/V3yGlipTxnxIq8xETnEWbPpCUV4LDCZRRLf1S0dzPa3rPNdzyBkOcH
         Npt2m/L0yVv4m5p4KEBWzrmnNOa2xw/fomUQIiMC7XNLp1+GkgDSdlHCUpviDLyYX+dZ
         XGEIol03DRGN3ppnUssVCjFe+dBUIOFSKaIRMFR4jqVbfjxKsHpH+qnHhmjOIaaoF/rk
         ZyToJTBl+O8Qsyrs+R1LiZz8YT9vzsRwZKE7HqPmbE79W/4kCBLTN/Q70jgGeJnilRmL
         df9OiUoZ3sJVznvcrlAps5/D+lh74W8Qb/9LbMlvX4u6uB9yagKqeejQ6jIyvsMifnHl
         A/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712183144; x=1712787944;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLajy1Q9xVKBjLw8NB/zHA8NnAkziwigu3iuNpIIZ6s=;
        b=NaUIJt1SC8h/pdvf4wG7UrS2/JB1nqOtY8y9avtFg2oc3nG3KbfzwpvTxyBbQxArjI
         Oa3Jtps03+MwMyqk2R07PgqE0lkiAWor7qplFkIMAZDngfCkBYyzZwwkK1FZx+SVgHXb
         4dGtyzLzp9LTIb3zrWjrX+jE5zozFoyFwY/0DXSAo8IyJZShxlPkkdyQQUHbwPiLpykw
         go3IIhHoT5keQceKue34I1XoCoVJuMZtc1qK8ddiy3I+xbqYulGxDHe/lqX6AFnYdp5G
         lvyfE4egTJ70hcHssESdbHVBdsRJnd3WWiMkRQPWR3VSIIRoXm0OlHDM7Djx6z6fn3uw
         aeWA==
X-Forwarded-Encrypted: i=1; AJvYcCWSq9HLyJUoN/i/mMvczPw9cO4s2sQgkMCmE92dzlLuzux+0kIP7STQbNwDbW+AOu6LDAIAlPr5cwKImYTGwfi8kpckgfTs0DcRHIaV3nrUh79yTAgaOfAite44eCnUdrogxGLKtcs+hkSbN76Ut2s=
X-Gm-Message-State: AOJu0YxPJzRJglDs3lM6Wzu39sZHiXzgBq6ygovXeaTQCDdOglWt32uN
	owrlsv4div7rGWfJuO1AFk0oLdLlh/CDmq6UyroJWAVsE+A2zlZm
X-Google-Smtp-Source: AGHT+IGS54h51rDaIWIxna+ijj3SuIAnNbSOCM0n2rvmjJc1n/UzM6TnNacg5wF7HX5RETuFUTrVLw==
X-Received: by 2002:a05:6512:36d1:b0:513:ccda:bc86 with SMTP id e17-20020a05651236d100b00513ccdabc86mr444352lfs.4.1712183143962;
        Wed, 03 Apr 2024 15:25:43 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1204:59b2:75a3:6a31:61d8? (soda.int.kasm.eu. [2001:678:a5c:1204:59b2:75a3:6a31:61d8])
        by smtp.gmail.com with ESMTPSA id t22-20020a192d56000000b00516cbd3e982sm14491lft.178.2024.04.03.15.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 15:25:43 -0700 (PDT)
Message-ID: <edefa2e5-c320-4021-bf8c-c6b1adf87441@gmail.com>
Date: Thu, 4 Apr 2024 00:25:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] x86/retpoline: Ensure default return thunk isn't used
 at runtime
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, "Kaplan, David"
 <David.Kaplan@amd.com>, Ingo Molnar <mingo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-tip-commits@vger.kernel.org" <linux-tip-commits@vger.kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "x86@kernel.org" <x86@kernel.org>, David Howells <dhowells@redhat.com>
References: <20240104131210.GDZZauqoeKoZGpYwDd@fat_crate.local>
 <20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local>
 <20240104132623.GFZZax/wyf5Y3rMX5G@fat_crate.local>
 <20240207175010.nrr34b2pp3ewe3ga@treble>
 <20240207185328.GEZcPRqPsNInRXyNMj@fat_crate.local>
 <20240207194919.qw4jk2ykadjn5d4e@treble>
 <20240212104348.GCZcn2ZPr445KUyQ7k@fat_crate.local>
 <78e0d19c-b77a-4169-a80f-2eef91f4a1d6@gmail.com>
 <20240403173059.GJZg2SUwS8MXw7CdwF@fat_crate.local>
 <f37a111b-f5c5-4337-8eaf-46a2c28f01da@gmail.com>
 <20240403204113.GLZg2-6f0nH0Ne9CQt@fat_crate.local>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <20240403204113.GLZg2-6f0nH0Ne9CQt@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-03 22:41, Borislav Petkov wrote:
> On Wed, Apr 03, 2024 at 10:26:19PM +0200, Klara Modin wrote:
>> Probably, I don't have much knowledge about this stuff. The machine can at
>> least be useful for testing still :)
> 
> I wouldn't use it if I were you as it wouldn't even justify the
> electricity wasted. No one cares about 32-bit x86 kernels anymore and we
> barely keep them alive.
> 
> It'll be a lot more helpful if you'd test 64-bit kernels on 64-bit hw.
> 
> :-)
> 
> Thx.
> 
All the more reason to continue then, even if only for nostalgia ;)

Jokes aside, I do run -next kernels regularly for my daily drivers 
(which are x86_64), but it's honestly not very often I notice bugs there 
that affect me. They have all been pretty minor or very obvious and 
would probably have been caught regardless, but I'll of course still 
report them.

