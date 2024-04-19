Return-Path: <linux-kernel+bounces-150908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5998AA697
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5731C21AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7C7460;
	Fri, 19 Apr 2024 01:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+sy9HyZ"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A4D137E;
	Fri, 19 Apr 2024 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713490726; cv=none; b=kYrvyavn8V1gmrWzd6daj/t5S06qiqhJf3RkoGLlEzGeKx9mmBpCS3hTGqO4D6ygUk9gnq5xzacUuGr6QHy3n8F22Sfz1tlgXQUnan96ZW4KSSN9IilGj5YLQADbv/IkyGCpZGFQ3bvYkE59d/XC/NLsRTP5ldkm5OE+VbVyqj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713490726; c=relaxed/simple;
	bh=GEWSZZ3vvOSe6AkDVJislZ1FHZ520OZtFm4gPShQLEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEzknFgix39wAZz0Pr3GFgeBVr2WzeB49u9x1hO0vJtjNd7EWtYF4Rwihgly31BPZwzNzgcrYU8AKeyYSneEyMecHa7gA4Wg7M/3OxPJIAgxrFYzRjY41vVDJhVGeiNN5Snw/oOYcX6fshNoGJxrp1bsmF2JMlQQn12Cr+yrUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+sy9HyZ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c6f6c5bc37so818730b6e.1;
        Thu, 18 Apr 2024 18:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713490724; x=1714095524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GPo2YBoXEtUt5FR3hk3RQoIHxRhTHP8ecG0sGnnf1Bs=;
        b=D+sy9HyZxRufj6JYHQB/KUXFgUXDpPbRfWWPQQcwxsS3xy8TEtgtxux8A8mx4g8npn
         /Ar5ldxivPAGDksVGUR8rNnxJBBZSIUXsHWJSI8SKSaosmrmdLHCwm6zpFP94WikSc23
         F2r743s1rGlHU4ajVyjGYqsVJdc6G4WVudBpmTMPQ0GZraLxlAmvmeSmjI7xi1Zj/AgO
         5arWEHqMqWcCYfQvJcCzSeuj1r+g8dpcxapecnuspOn0VTDcVvZBQuaLyTdHJnkPj8lz
         FYuIaVfrLtTn4Q9fzKs+xzS75k4RUQxGNC4YZVtIWom7r/FhnTsr7ml6vmMs4ntiJWvy
         sf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713490724; x=1714095524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPo2YBoXEtUt5FR3hk3RQoIHxRhTHP8ecG0sGnnf1Bs=;
        b=KPqHf/1dDwEhzcWVLCc7O1O1/Zdih8ljDI30NeaWuwtqXkOQ0ey6iCrKM1d3PGZyhm
         EVn9pgyn5aqAU8xD+yzr92sZWSYI2Q6iUUPSeKM/Uzf+ucE5eKWX3+Z7TmbKDaLqPyG8
         CsL3Q7mIuLadQkbmSK3BfMcK1/KQYiHCm+t5oafbygZiu8tckF3xVJ9inYKTdNO62f+4
         WnI/sM4U1QRJv/YtfIAraAnT8DbfpDCIVIESK13tX/pBb0fJ/JY1qXX4u2+w6VROiPJg
         8MVM5+QyiiDQsFp9mo1rRDr5ywpFo1l6fWxNaRCvcy9AeQqeqldHSmDeDgJoRw2npsvw
         Jiaw==
X-Forwarded-Encrypted: i=1; AJvYcCU21w3ab+snocOaSTahKPVTCvYI3ngn9xajCvs9SydWk8FSOKGQI//cq/SSmIwe65JkYl4QgbKRJWqo0uMQvQuVstB9cdKK6RXj42U+I6tlKkqoKzFfdodfkG5TdP4SO3CS03xsUy0Cj6uT5W7Zfs6b6g==
X-Gm-Message-State: AOJu0Yw19yZguA5ffxUpxuPLoUJ1N/D5PGqkhDY4gxAU3jHalahB90qW
	0gn6wgihWc4qbwQQVIgT1pNvnQPM4tvFmz6d70X0qdelNeP5EeKw
X-Google-Smtp-Source: AGHT+IHvWdtljGzkpyRy9juDffeZQxeStoqibKWESrgiGIXKc46p52JCVHa+vIEguRUBhxW+K+Ax6Q==
X-Received: by 2002:a05:6808:3d3:b0:3c7:4577:f31f with SMTP id o19-20020a05680803d300b003c74577f31fmr669710oie.58.1713490724434;
        Thu, 18 Apr 2024 18:38:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:70:f702:9c77:c230:a0ba:a1a1? ([2600:1700:70:f702:9c77:c230:a0ba:a1a1])
        by smtp.gmail.com with ESMTPSA id 11-20020a54418b000000b003c5f66569c9sm451204oiy.46.2024.04.18.18.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 18:38:43 -0700 (PDT)
Message-ID: <569ad84d-4876-4d10-bdf9-a0b65aa76ddb@gmail.com>
Date: Thu, 18 Apr 2024 20:38:43 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86/amd: Don't allow HSMP to be loaded on
 non-server hardware
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Carlos Bilbao <carlos.bilbao@amd.com>,
 "open list:AMD HSMP DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240416182057.8230-1-superm1@gmail.com>
 <ca6e0dc7-f5ea-4c0a-b9fe-0667fadc78a6@redhat.com>
 <1071ea83-7919-469a-ac5b-3209fe9e018c@gmail.com>
 <85728284-d771-bf06-9ed3-333633ebf8b0@linux.intel.com>
From: Mario Limonciello <superm1@gmail.com>
In-Reply-To: <85728284-d771-bf06-9ed3-333633ebf8b0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/18/24 08:51, Ilpo Järvinen wrote:
> On Thu, 18 Apr 2024, Mario Limonciello wrote:
>> On 4/18/24 04:04, Hans de Goede wrote:
>>> On 4/16/24 8:20 PM, Mario Limonciello wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> If the HSMP driver is compiled into the kernel or a module manually loaded
>>>> on client hardware it can cause problems with the functionality of the PMC
>>>> module since it probes a mailbox with a different definition on servers.
>>>>
>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2414
>>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3285
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>> v1->v2:
>>>>    * use pm preferred profile instead
>>>
>>> Thanks, patch looks good to me:
>>>
>>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> Mario, should this go in as a fix for the 6.9 cylce, or is
>>> this for-next material ?  (I'm not sure what to do myself)
>> The main risk with this patch is if there are servers that previously loaded
>> amd-hsmp no longer working because of a BIOS bug to exporting the incorrect
>> profile.  I think this is quite unlikely but not non-zero.
>>
>> To at least give some time for anything like that to be raised I feel this
>> should go to for-next.
> 
> I was also thinking it would be better to route this through for-next.
> 
>> Ideally I do want to see it go to stable kernels after we're all sufficiently
>> happy though.  Random bug reports to me like the ones I added to the commit
>> message get raised mostly by people who compile their own (stable) kernels and
>> enable all the AMD stuff because they have AMD hardware.
>>
>> So how about we target for-next, but also add a stable tag for when it gets
>> merged in the 6.10 cycle?
> 
> That's possible but if you want to retain true control over it, don't add
> stable tag at all now. You can send it on your own volition into stable
> address later once the change is in Linus' tree and your "happy" condition
> is met (Option 3 in Documentation/process/stable-kernel-rules.rst).
> 
> Otherwise, stable will autoselect it the moment it lands into Linus' tree
> and you don't have much control over the timeline from that point on (I've
> seen stable folks to grumble when somebody asked to delay including a
> patch marked for stable, their reasoning was that their autotools keep
> reselecting the patch over and over again).
> 

I don't feel a strong need for a specific timing.  The timeline of of it 
going to the stable trees when 6.10-rc1~ish seems fine by me.

