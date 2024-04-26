Return-Path: <linux-kernel+bounces-160773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B6A8B42AD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BF42826EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F613BBF0;
	Fri, 26 Apr 2024 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enGuhxas"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17583A29A;
	Fri, 26 Apr 2024 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173753; cv=none; b=H0M78zT9eL8b3pO7SMbpSerzr4nnXoPW73aO29EBtMIX0n0oSt6YKrT8cLVRUBVWfLe59iR1VB42OXf4hy22Z9x+u/Tn1p+hIHzp1nbzvuGluaZOeNbiowI2cVCMhRYzz6b5rd07zFhgUIloeqG7N2FGL1MUKwqoKAlZ48i+vh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173753; c=relaxed/simple;
	bh=40TMRkC/fuLPx/5ddsriVxpu2/8lWWIfnIWnMa9CuOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmTk2hCEywnz/AAI59157sNBGS3ECdRw/cZUptufXEC5SOwc70EaomUURir1zfG/5hzCPH4USoFbolyyMaFIHeXV2yHkK9kBLbUpeNCDlVVjvF/CNuaV6Vwkg8lH7JYYUpJL0CFT9UTStAe5lAclCjAtu+R3S5ACAwZ5ZFsMUZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=enGuhxas; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4188cda2e77so48915e9.2;
        Fri, 26 Apr 2024 16:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714173750; x=1714778550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iY/WWi0Cde+1RuQH0g65soHztJhsZe8t9qNdEVQN2vc=;
        b=enGuhxasl7OaVpWz9IC9C0EKPFa0Wp7J8mA0glJHj7nH/zo0nu3PDLrDMIZ+MiZ44k
         iuDLuaKWA7gn/YPFr5odbj8PWTECj52ryl3LbhoS0PJMHRYVhEsFaT3QQS+oIGT2fS+L
         CBAP3H8oWYCOq2QN+puI+S29jr3MYI80Nx/aenOQkZsdEC5n6e4RV7Q/Ezu5LO04Yhrt
         jIM5XBIMs7VMmXaekZ9z5Ir60gG2tvUZLyBO3KEo5fSfmdK99o1hf1T2YBtyNSlfxCOZ
         ZZlJZJ/pPRgWY7KCJkOTrccUUJfCAdYcluAco2PTAnyX7XvunDNAgu+AWDM8vNiIIPHj
         fxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714173750; x=1714778550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iY/WWi0Cde+1RuQH0g65soHztJhsZe8t9qNdEVQN2vc=;
        b=wjeJNeW2kR4PLFT21QCi4KATbg5tkCtbJOI0VP0u+T65lB+LVcQbu/z4WBFiFzrisP
         phMsDE5dUGsgI0t/8G670aOrBBjsEo4l0/7sOL4aLVmhJQuxMP8+cw6Q5zA9eUUlqr7Z
         jhvOE2xXu7z44IrTSzTKKWC4dBOz4CFO41HB3bzQmSnMZ2yP9EQMoTnBm0/QWunf4o/M
         bZp5/HOTNPXHe2i2rcsrk/4w0Jaw0bu/faw7pCZ5bx0MLGyePTC8BFoWIW12GZ3CU8TE
         wLNxrjpzVDdx5J1eYSUGEtqIO5cZAre/7BggKX6RzXG/mum/At4WauyxvlbBaCKLQxhx
         uKsA==
X-Forwarded-Encrypted: i=1; AJvYcCU7MF2me/lJ296h9vRXLmYknCbLsSrqvVjPFmCHfX8h8EXAytoGdjHnkHjGmn4dQp/1c67WnRpkdHM40XK9T/WSwvvbNOJVke/wWBW1SgTVtJSPnTVcBkbJR7zTLTJ2F46TsFQsBIxP/V6UjL1OYGFf/bhD2/XXzxaZpYvqbizzh29wFVRq9ScgobY=
X-Gm-Message-State: AOJu0Yy6WI7BaG0bRPgSydtGk6WDNGkqxvMt1FpExZih7z0qJj5cZrnH
	6rD55iIdQuWoM2Hf1YLa5sRZ6+YY6Em4hTXSgyXcivyZQtrqrRjy
X-Google-Smtp-Source: AGHT+IE89/bvkFG+6ShpcqPuCTvy7/Aglbbu9aLaprfqPHDvl17E4830gcwMAX5pfWZo0/eA/bXuLw==
X-Received: by 2002:a05:600c:1c9e:b0:419:f4d6:5044 with SMTP id k30-20020a05600c1c9e00b00419f4d65044mr2895218wms.2.1714173749966;
        Fri, 26 Apr 2024 16:22:29 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:f1d3:7133:ba99:885d? ([2a01:4b00:d20e:7300:f1d3:7133:ba99:885d])
        by smtp.gmail.com with ESMTPSA id k41-20020a05600c1ca900b00417e8be070csm32632799wms.9.2024.04.26.16.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 16:22:29 -0700 (PDT)
Message-ID: <f97f2dfc-38d0-47be-aef2-6d3baf481a5e@gmail.com>
Date: Sat, 27 Apr 2024 00:22:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ALSA: kunit: make read-only array buf_samples
 static const
To: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Colin Ian King <colin.i.king@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240425160754.114716-1-colin.i.king@gmail.com>
 <20240425232250.GA205425@workstation.local>
 <81a9e3c2-2c44-406e-af19-90d9dcfe4a92@gmail.com>
 <87il042mbn.wl-tiwai@suse.de>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <87il042mbn.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/24 16:08, Takashi Iwai wrote:
> On Fri, 26 Apr 2024 14:05:34 +0200,
> Ivan Orlov wrote:
>>
>> On 4/26/24 00:22, Takashi Sakamoto wrote:
>>> Hi,
>>>
>>> On Thu, Apr 25, 2024 at 05:07:54PM +0100, Colin Ian King wrote:
>>>> Don't populate the read-only array buf_samples on the stack at
>>>> run time, instead make it static const.
>>>>
>>>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>>>> ---
>>>>    sound/core/sound_kunit.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
>>>> index eb90f62228c0..e34c4317f5eb 100644
>>>> --- a/sound/core/sound_kunit.c
>>>> +++ b/sound/core/sound_kunit.c
>>>> @@ -167,7 +167,7 @@ static void _test_fill_silence(struct kunit *test, struct snd_format_test_data *
>>>>      static void test_format_fill_silence(struct kunit *test)
>>>>    {
>>>> -	u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
>>>> +	static const u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
>>>>    	u8 *buffer;
>>>>    	u32 i, j;
>>>
>>> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>>
>>> We can see the other similar cases in the kunit file. I'll post the fix
>>> later.
>>>
>>
>> Hi Takashi,
>>
>> Hmm, correct me if I'm wrong, but I don't see any other significant
>> allocations on the stack in the test.
> 
> I guess he meant slightly different ones
>    https://lore.kernel.org/r/20240425233653.218434-1-o-takashi@sakamocchi.jp
> 

Ah, alright, found it. Thank you!

-- 
Kind regards,
Ivan Orlov


