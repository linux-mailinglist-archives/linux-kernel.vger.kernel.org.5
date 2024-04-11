Return-Path: <linux-kernel+bounces-141396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2EC8A1DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA271C245BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5199224D8;
	Thu, 11 Apr 2024 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1nuJfjU"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05117C72;
	Thu, 11 Apr 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856283; cv=none; b=X1RbNEz1CVWh+g4fqowYuIj9dvaKr7YHOdFs0Aj4EB84NSdDWeGNzIrIqClFDECVvkMxp6+o+DyXVOa5MSoTbSPgy4pV3F6hxXUR48P76zswWVQvCyRYG9uq6b8iC0AAih7Er1vCyK3iQPmjCJmw5usEorZRzOZ+ZQbWmHckHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856283; c=relaxed/simple;
	bh=3CrqLFN0sU4j3EisFD3rui+nSRvGpntYJwF4YCA+1DQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uOdTqzDRPAnrPgteEJpbTxM7ajCyWA+dLYMVNNMLEescvrpIyMLKk6DODHChZjFAq9vA2ptjwA5ue3QMXo+iqwhkrusaktcLYSyYfxOf05Pw9avYR4WvrT9+bpfNCn8B6U8BtkqMdCzvF+bcbb8PrClhyQQl/p+rc9OPLEyWAH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1nuJfjU; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so42165276.2;
        Thu, 11 Apr 2024 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712856280; x=1713461080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3aU+VDcnxdJAiLiKhNqs0MWODsXShfL8imzNJx8uWYI=;
        b=Q1nuJfjU2wEw/pqUw2jvSlMLG9/zGKRXlrgY3Kgoljreh5M9Pc+oMFIKc2lKu1pkHc
         wOF7elvzTBvyYoH+w77ZnxTPJf0pguHQYI4ewxGyzICS2pBQGZ9kEXCGoQaPOv4G2eAH
         3jqgYl22gG9uvaP8j/4O4lBBCJJ/jGakk2ghnxGXlDZauQMRGCU0/Zk2zZK/OgVbTmQ5
         VfAdLsN+61c+COS28VmX8n18I2KRCg/tQfl2gS1J/jqZfGVf0IpklwaFFrLUtpOwiX5i
         At+sxaes0ek3zgzBZV+T6AMDu8EJzDhdmLoOxGLKpkx2BusDDl6wMUErHUHvmJro7FyL
         OrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712856280; x=1713461080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3aU+VDcnxdJAiLiKhNqs0MWODsXShfL8imzNJx8uWYI=;
        b=t+jP1DZaHIAnNIBjmyi0NfkXDuLOyIK6/Qj1YWdc98AuSCUQ+o9k9S8ioe8rNYBG4R
         1R5JhEX6PC+JE1MH/9M4wpvgOeo3ggEayz5ZdIilQDn5Yz9D/LsqvhOe94Y10DqRHdhG
         Wv64YtCRGmbV02ow09UnOsXPfRLFJ81+4EN/wAZs5d+JaY1h5H1mGiharTLdRPgbcyxU
         JZ0TOYWh+y++ZDe6LbCO5FObH8f8YpN9/GL9rUiqJMR8aBJXRxD03MUY1PFOizLU5vHD
         NZjBF3SADZBc7PlG2f0cdsIm0oFvxvmiUPTCvP7/g28IEJq7kfUovuN4zOByNUgBMywg
         8Img==
X-Forwarded-Encrypted: i=1; AJvYcCVQubd1zrD3ePdXFy3E3osJK2hASq35EqOCBvAuHbUHpN4LVts2hVf31MCGtgFLlPAY9YgyweN2GAC5xxMjsIwgZlHDPcrz8cpRpbADTNqPW5EmBEcapk6JI7FSf9U7EGM4vs/KMJz77Q==
X-Gm-Message-State: AOJu0Yz0hZxK3H/agGxCuGM8MwIW+N2MzC+rL1MZe5VTRPfXXm4FESKa
	NYjWHCdlw704GTMmuE/hG0M7k+1TCJD7r+6s4WUEm7STIOG+da5f
X-Google-Smtp-Source: AGHT+IHwtXI6RPcAx6JYyAqjw9V9RWwxVxik8CVr64O0+hIJzbXQ+BRGV5uoANxfOjFaDBQ5uvvq2Q==
X-Received: by 2002:a05:6902:150b:b0:dc6:4d0c:e9de with SMTP id q11-20020a056902150b00b00dc64d0ce9demr210219ybu.0.1712856280449;
        Thu, 11 Apr 2024 10:24:40 -0700 (PDT)
Received: from [192.168.7.169] (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id j127-20020a255585000000b00dcc7b9115fcsm383512ybb.3.2024.04.11.10.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 10:24:39 -0700 (PDT)
Message-ID: <144398ae-42ae-b816-62d6-a90738544ca4@gmail.com>
Date: Thu, 11 Apr 2024 12:24:38 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 5/7] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add
 ipq9574 gen3x2 PHY
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
 <20240409190833.3485824-6-mr.nuke.me@gmail.com>
 <019180df-67b9-438b-a10d-f92fd4ddec03@linaro.org>
 <33461c22-21a3-023b-4750-c69304471ea8@gmail.com>
 <2379377e-ca1c-453f-bb74-186ab738ce39@linaro.org>
 <a23adb9c-6377-467b-ac3c-0ec51fc97253@linaro.org>
 <d827ec3c-84fd-9352-b321-79bdc4bdcd40@gmail.com>
 <27b4b37b-c736-4d6b-98f0-0856e09ec5b6@linaro.org>
From: mr.nuke.me@gmail.com
In-Reply-To: <27b4b37b-c736-4d6b-98f0-0856e09ec5b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 14:36, Krzysztof Kozlowski wrote:
> On 10/04/2024 18:29, mr.nuke.me@gmail.com wrote:
>>
>>
>> On 4/10/24 02:02, Krzysztof Kozlowski wrote:
>>> On 10/04/2024 08:59, Krzysztof Kozlowski wrote:
>>>> On 09/04/2024 22:19, mr.nuke.me@gmail.com wrote:
>>>>>>
>>>>>>
>>>>>>>     
>>>>>>>       clock-names:
>>>>>>>         items:
>>>>>>>           - const: aux
>>>>>>>           - const: cfg_ahb
>>>>>>>           - const: pipe
>>>>>>> +      - const: anoc
>>>>>>> +      - const: snoc
>>>>>>
>>>>>> OK, you did not test it. Neither this, nor DTS. I stop review, please
>>>>>> test first.
>>>>>
>>>>> I ran both `checkpatch.pl` and `make dt_binding_check`. What in this
>>>>> patch makes you say I "did not test it", and what test or tests did I miss?
>>>>>
>>>>
>>>> ... and no, you did not. If you tested, you would easily see error:
>>>> 	clock-names: ['aux', 'cfg_ahb', 'pipe'] is too short
>>>>
>>>> When you receive comment from reviewer, please investigate thoroughly
>>>> what could get wrong. Don't answer just to get rid of reviewer. It's
>>>> fine to make mistakes, but if reviewer points to issue and you
>>>> immediately respond "no issue", that's waste of my time.
>>>
>>> To clarify: "no issue" response is waste of my time. If you responded
>>> "oh, I see the error, but I don't know how to fix it", it would be ok, I
>>> can clarify and help in this.
>>
>> I apologize if I gave you this impression. I tried to follow the testing
>> process, it did not turn out as expected. Obviously, I missed something.
>> I tried to ask what I missed, and in order for that question to make
>> sense, I need to describe what I tried.
>>
>> It turns out what I missed was "make check_dtbs". I only found that out
>> after an automated email from Rob describing some troubleshooting steps.
> 
> No, the dt_binding_check fails. You don't need to go to dtbs_check even,
> because the binding already has a failure.
> 
>>
>> If I may have a few sentences to rant, I see the dt-schema as a hurdle
>> to making an otherwise useful change. I am told I can ask for help when
>> I get stuck, yet I manage to insult the maintainer by aking for help. I
>> find this very intimidating.
> 
> I don't feel insulted but I feel my time is wasted if I tell you to test
> your binding and you immediately within few minutes respond "I tested",
> but then:
> 1. Bot confirms it was not tested,
> 2. I apply your patch and test it and see the failure.

Thank you for double checking, and I am sorry this escalated in this 
manner. I believed you the first time that something is wrong, and I had 
a hard time figuring out what.

I am now able to repro the errors, and the below changes appear to work. 
Is that sufficient?

    clocks:
      minItems: 3
      maxItems: 5

    clock-names:
      minItems: 3
      items:
        - ... (5 clock names here)

For ipq6018/ipq8074:

       properties:
         clocks:
           maxItems: 3
         clock-names:
           maxItems: 3

For ipq9574:

       properties:
         clocks:
           minItems: 5
         clock-names:
           minItems: 5



