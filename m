Return-Path: <linux-kernel+bounces-110961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67688664F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE5A1C236A8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32162BA3F;
	Fri, 22 Mar 2024 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eq5jPgtV"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558448C1F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086051; cv=none; b=ts7pSwybK7FQd+9UnxaH1dCp5xdtCuPKqRslOhkN+MtQGwxOhjHm2P1nOLUAo4hWixh1l2Rd1d35XQsxvjlRq4B/yza1yK+FsFFH1QZ0VIxubDo4htFtjPzAQMFpgZh4rLR+KfydO2/GMTWk12eWJiuTCwt3bXaidtH3a0xpg34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086051; c=relaxed/simple;
	bh=FaXVFsApl7dblUMKMUDUIpzrwE5ABcfu9Hq6RbVdq64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAjZF2IE3HaXND6HGveCInTEp36y/7oy/WYOySzJXFuRMU6sqTwHS2CYwBs0SiaHMYAyvrLhI56EC9n1zzh5rfwMMhk0/uR4YSjeupkQmyNaUU662MyIxxJTTl0VrKOXilrKfu2kmEAgj6iOd0H5sjjU2JR6v6MZKSUdG1zQquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eq5jPgtV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51381021af1so2736138e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711086047; x=1711690847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BROMpVHLCWSHO69sYcqHfhDhJzuRwH9THVcSjAEu5o4=;
        b=eq5jPgtVez0zzO+UAoHwSd9BXULrkVyOitAncaDPa4Tc0ZbF0FglJQYt74WlRSAdA3
         S/Z5QP7Uql8ZTwONkcOmtc7+KR4RnHCn9L4fHsLpye4qkFFZ5CkgFWZbKxkktknuabup
         0qLDpvEHWtpmGjN/b/6hWjEPnCR6HHH/YIYSHeZvQxoSUZS0kIOByom2tzbu79nR7OSD
         ZD8Ra0ntKfnLyb0BlhmFabUPnv4R0R8lqB6na9cOawFEx6W8b6eiA2XCZLwnS3MO0/Lb
         Spk3gWWUDaGpRE0qJAqkTmUgSh6H5xJbKvPJ0lb0VvwrWUPjEPTYEjUhM7wKWoIA3LrV
         RM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711086047; x=1711690847;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BROMpVHLCWSHO69sYcqHfhDhJzuRwH9THVcSjAEu5o4=;
        b=emM8UhToP3ZkL6GsPlJATO+Se8fO4OEFxmMkx1UfvdI13fPs1c6ScqlRYUZtLfwaja
         xuIzSnihnr44MbfVDMZnE502Mclzmr3Hh5Zf+6ZMsEzhu5Uo42oeSAdrYqE9g/16HqrB
         e1yNpPH1ur4fFP1p1kiBdcqwH50F6C223HXIes15UZSnC6IeH0TN1wz+l8aIw3y7IJVD
         mjYCZGJcXl+QFIHARxL8bo0/rPPHqqGnt8SHDLi/yk0IlLwI+ngR34m3NSphkeLcI6sd
         MtJMkOCuewn1SltPQRE2dR5MhmcoAkHTT/22hlcj9jFy2W1c66y+K9P4sd6DtWMOaGYr
         shcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkBoZasxwaXZCzdguKKOh26kWFLKx8nljysi97niCwL5LoVeWj7cHbmVuyrT+EvmdPCAx8lNWj9yb9YnSkYYFY5JBklWW1/TYyRtzo
X-Gm-Message-State: AOJu0YzYjWRDc6MhsOW0T5RMZX7KtrbhyjXEMVgoruM4x7pZGsKiOZae
	YEmri/packGdG6goZx3wCKIbhtxyPjPRHQzUWD+oQE9YXp+tOcfXQ29ax6VC3LY=
X-Google-Smtp-Source: AGHT+IFPslJAzt8t6fwf7l4FRWO+/BZKadxr4PCvyq9DBD7dU+cemCW3lroB9iRSoo+rQtO/x/40KA==
X-Received: by 2002:ac2:4652:0:b0:513:572f:88f1 with SMTP id s18-20020ac24652000000b00513572f88f1mr1086426lfo.27.1711086047335;
        Thu, 21 Mar 2024 22:40:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090624cc00b00a46aac377e8sm636880ejb.54.2024.03.21.22.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 22:40:46 -0700 (PDT)
Message-ID: <17611183-f288-47fe-a5e1-91ee16168db0@linaro.org>
Date: Fri, 22 Mar 2024 06:40:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] virt: vmgenid: Add devicetree bindings support
To: "Landge, Sudan" <sudanl@amazon.co.uk>, Rob Herring <robh@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Sudan Landge <sudanl@amazon.com>, tytso@mit.edu, Jason@zx2c4.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, thomas.lendacky@amd.com,
 dan.j.williams@intel.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, graf@amazon.de, bchalios@amazon.es,
 xmarcalx@amazon.co.uk, ardb@kernel.org, benh <benh@kernel.crashing.org>
References: <20240319143253.22317-1-sudanl@amazon.com>
 <23692c07-98bd-477d-b244-bba14c50352c@linaro.org>
 <38aad6c0e698c8e804694276d1762d61f2068ce8.camel@infradead.org>
 <20240320161531.GA1810860-robh@kernel.org>
 <60404403932a984d1f75d111ff53b9053af03579.camel@infradead.org>
 <20240321133250.GA1600070-robh@kernel.org>
 <db5a1027-93b7-4630-b679-8a654905dc48@amazon.co.uk>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <db5a1027-93b7-4630-b679-8a654905dc48@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 18:39, Landge, Sudan wrote:
> 
> 
> On 21/03/2024 13:32, Rob Herring wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> On Wed, Mar 20, 2024 at 04:55:45PM +0000, David Woodhouse wrote:
>>> On Wed, 2024-03-20 at 11:15 -0500, Rob Herring wrote:
>>>> On Wed, Mar 20, 2024 at 01:50:43PM +0000, David Woodhouse wrote:
>>>>> On Tue, 2024-03-19 at 16:24 +0100, Krzysztof Kozlowski wrote:
>>>>>> On 19/03/2024 15:32, Sudan Landge wrote:
>>>>>>> This small series of patches aims to add devicetree bindings support for
>>>>>>> the Virtual Machine Generation ID (vmgenid) driver.
>>>>>>>
>>>>>>> Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
>>>>>>> ("virt: vmgenid: notify RNG of VM fork and supply generation ID") as an
>>>>>>> ACPI only device.
>>>>>>> We would like to extend vmgenid to support devicetree bindings because:
>>>>>>> 1. A device should not be defined as an ACPI or DT only device.
>>>>
>>>> This (and the binding patch) tells me nothing about what "Virtual
>>>> Machine Generation ID driver" is and isn't really justification for
>>>> "why".
>>>
>>> It's a reference to a memory area which the OS can use to tell whether
>>> it's been snapshotted and restored (or 'forked'). A future submission
>>> should have a reference to something like
>>> https://www.qemu.org/docs/master/specs/vmgenid.html or the Microsoft
>>> doc which is linked from there.
>>
>> That doc mentions fw_cfg for which we already have a binding. Why can't
>> it be used/extended here?
> QEMU has support for vmgenid but even they do not pass vmgenid directly 
> to the guest kernel using fw_cfg. QEMU passes the vmgenid/UUID via 
> fw_cfg to an intermediate UEFI firmware. This UEFI firmware, running as 
> a guest in QEMU, reads the UUID from fw_cfg and creates ACPI tables for 
> it. The UEFI firmware then passes the UUID information to the guest 
> kernel via ACPI.
> This approach requires yet another intermediary which is UEFI firmware 
> and adds more complexity than ACPI for minimalist hypervisors that do 
> not have an intermediate bootloader today.

What stops you from passing fw_cfg not to UEFI FW? BTW, no actual VM
name was used in your posting, but now suddenly it is a talk about QEMU.

Best regards,
Krzysztof


