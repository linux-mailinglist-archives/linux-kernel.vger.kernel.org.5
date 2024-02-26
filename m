Return-Path: <linux-kernel+bounces-82147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B433B867FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619CB1F262D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24FB12E1F0;
	Mon, 26 Feb 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrauEQkE"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7143C1DFF4;
	Mon, 26 Feb 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972820; cv=none; b=VQzG68gZVBlKGXY/7bhdm5X+4WuZWlPDkSPJXvLz5N67FM+nYqV/6DNhPBOJPG9XMQXxAKAm9+1TD8mchOctOD0rbW2xGSVI+M5wYphw1hsde39TAUXo5yeo7b+XNLa8wIbGPCcVkJUKptBMUxHwmqf2zUelrASuZ3cIUaHO6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972820; c=relaxed/simple;
	bh=cXc/+xmPvR0VjZbbDhZowKTCWMHmBDmWxjjaJP2Cui8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Inn8+x7f45CC4jqvQAAEiVvIt0Ns6pqML7Z8KFMmD7kzdXwXMMozhQPoQ+7iop+Z3y2TCriQ8MurcRwDP4LPkYFZuGbL1ALAU/SmdaOgdPiwLbwgbe9nVLuGJSpi9/nL/oiJvmuRXaIzBjkZZnlNfVKjfNY+U+BMfWuh2YU4WKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrauEQkE; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21fa97a9c53so1471145fac.3;
        Mon, 26 Feb 2024 10:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708972818; x=1709577618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eLxB+GvOtgSWKQsZijDIQFK/dDqcfNv+aMucy5+mb3w=;
        b=NrauEQkErgjDwsx3GOxK2Tm/lSlc/98rfd95WT3EM97BgD5wx9lg6lyBEwVbAq99nt
         efqcKcjFhPUxsO7hRh9qgdGcvHFLumnNIBb4x+LbZYnz0svlEPz6WPBNb0xnSBOd4N9G
         81q8us+/I1KjeJMSjhYJxlKm6JHmR6/zxPN1GbX9y6Mj+dGuDHCzK+/TV8VHqWyTCwzX
         HV10e1kVP+ilsJ5fl7Pflll9ZWQEcFAKTRltdsERuB4e1tsBH2c4XEioLn7515csnAPD
         pKDfZSpnj7njt2x8DmvtbQVAUe8dbLRXbEkpCvyiX34vJPjmKIX5W13jeO6JXt0wGw6S
         t0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708972818; x=1709577618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eLxB+GvOtgSWKQsZijDIQFK/dDqcfNv+aMucy5+mb3w=;
        b=rcRsLbIJTd8vfX6m5EyT0rzN8SZL+7GTllED9Ul3sAzJfpKk+hi4T7I6PwTfbxxKrh
         phC/cJ/ivlnoSwc1NptZqCbeTZ1TszluOLx6TP2zgG+Pc5QpdMWFUAnLAr3OVODw3zpl
         n+48ULNJxNYR1ZbGiso7CojEfaRTDPJxToCjiDI35aOtDqewILkO0yyAJRwqiCmRKcsq
         ZIOPkRoupj1J5lIEVD5lpvyTS3OWBIl1hEZxi+MAl5Egi2xev0z687cwse0LtzCAbHYR
         12rpOZy5iwBVwlPIqdvrZp8SZSb4bKH7ZD+PeqSwfJHcADH7Xhoo9DySFo4Ls0CCri5x
         zHAg==
X-Forwarded-Encrypted: i=1; AJvYcCWqDoYzSzr4l1Aydh9l72anfQQdGobi8dW2+TtKc9GdON28QdVrikkowXpflYJJjh9sCW9wpG0WNY/MLIoTaLLLng/c3YtGKYTW5Cf3fVUg4gHSmKU1LQ9HruwLr3rHYmSQqqGl5mk=
X-Gm-Message-State: AOJu0Yzk1JKbDJgHF08XdAETG/DBCmNWEEMFPP38vR+TjZwTPEN2e2v2
	8sYpct+GZQUxmGEpFbxqHJuII2W2O/gWbua8PjMPOj9SOLkuS5v9
X-Google-Smtp-Source: AGHT+IGIWBYv4w1MWAuEuFYpTLCSI870YIdFhk3NLHHmv51vms+PoFdErd/aZXB2zxG9JKTTT8dumw==
X-Received: by 2002:a05:6871:4d4:b0:21e:e476:9170 with SMTP id n20-20020a05687104d400b0021ee4769170mr9309412oai.43.1708972818485;
        Mon, 26 Feb 2024 10:40:18 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x15-20020a05620a0ecf00b00787aaf9578dsm2733323qkm.33.2024.02.26.10.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 10:40:17 -0800 (PST)
Message-ID: <3208c5b9-5286-48d1-81ab-cc3b2bc4303e@gmail.com>
Date: Mon, 26 Feb 2024 10:40:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
Content-Language: en-US
To: Guan-Yu Lin <guanyulin@google.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com,
 gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
 petr.tesarik.ext@huawei.com, rdunlap@infradead.org, james@equiv.tech,
 broonie@kernel.org, james.clark@arm.com, masahiroy@kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20240223143833.1509961-1-guanyulin@google.com>
 <a299118d-eeec-40b4-9a3d-48dc40f34e12@gmail.com>
 <CAOuDEK3wP6zhEwgUn5zSedtwTYVFaJeBfeXkSg897EhpGP9=ig@mail.gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAOuDEK3wP6zhEwgUn5zSedtwTYVFaJeBfeXkSg897EhpGP9=ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/24 02:28, Guan-Yu Lin wrote:
> On Sat, Feb 24, 2024 at 2:20 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>> On 2/23/24 06:38, Guan-Yu Lin wrote:
>>> In systems with a main processor and a co-processor, asynchronous
>>> controller management can lead to conflicts.  One example is the main
>>> processor attempting to suspend a device while the co-processor is
>>> actively using it. To address this, we introduce a new sysfs entry
>>> called "conditional_skip". This entry allows the system to selectively
>>> skip certain device power management state transitions. To use this
>>> feature, set the value in "conditional_skip" to indicate the type of
>>> state transition you want to avoid.  Please review /Documentation/ABI/
>>> testing/sysfs-devices-power for more detailed information.
>>
>> This looks like a poor way of dealing with a lack of adequate resource
>> tracking from Linux on behalf of the co-processor(s) and I really do not
>> understand how someone is supposed to use that in a way that works.
>>
>> Cannot you use a HW maintained spinlock between your host processor and
>> the co-processor such that they can each claim exclusive access to the
>> hardware and you can busy-wait until one or the other is done using the
>> device? How is your partitioning between host processor owned blocks and
>> co-processor(s) owned blocks? Is it static or is it dynamic?
>> --
>> Florian
>>
> 
> This patch enables devices to selectively participate in system power
> transitions. This is crucial when multiple processors, managed by
> different operating system kernels, share the same controller. One
> processor shouldn't enforce the same power transition procedures on
> the controller – another processor might be using it at that moment.
> While a spinlock is necessary for synchronizing controller access, we
> still need to add the flexibility to dynamically customize power
> transition behavior for each device. And that's what this patch is
> trying to do.
> In our use case, the host processor and co-processor are managed by
> separate operating system kernels. This arrangement is static.

OK, so now the question is whether the peripheral is entirely visible to 
Linux, or is it entirely owned by the co-processor, or is there a 
combination of both and the usage of the said device driver is dynamic 
between Linux and your co-processor?

A sysfs entry does not seem like the appropriate way to described which 
states need to be skipped and which ones can remain under control of 
Linux, you would have to use your firmware's description for that (ACPI, 
Device Tree, etc.) such that you have a more comprehensive solution that 
can span a bigger scope.
-- 
Florian


