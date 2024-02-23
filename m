Return-Path: <linux-kernel+bounces-79323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDF98620C2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C27B2406F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9759714DFE9;
	Fri, 23 Feb 2024 23:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPYq7mXA"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B21D250E5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708731998; cv=none; b=NlX/jKTYxnuh3DAPuw6FAl2fk7OeVrjiQslgMUTTaMs8vULR6j6eBxSsGnFT9yCCTRY9GG43u2b4Qn2z1fUOf5wLR/zN4gLsVlgNr+FKXdRA07shSLiRmV0el861TwUNG6gOQVyiKnuT49nct/YmthUfD+AtpJP7zWNe3pLljHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708731998; c=relaxed/simple;
	bh=mgHqWgnzX8YgCtUVgGyFblbfkBZfwH2hQtNerw34L/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wveay5sgCAjllINgdQnR4y5PgmJO1xy1Pd5DdZADjCBZiTmxcu5tMhM8cx9yKqlz8fDxVhnMySFCWARbt2Vo53S7K9MwPzko6jcM1ivs44qalu0wSaCCq7v6Dlss3kGfU8QH23HnKguub8BEbabAvP118V03o3qW+nBI7CYnr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WPYq7mXA; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a293f2280c7so154740466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708731995; x=1709336795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NIAGIlOyfdPQGzUhuhBTCj1fg0Ra/brIZfOUyFxv3go=;
        b=WPYq7mXA4GS5XMA1VDMZ5ZAmWyn84fNBhQFINGtYcK4i6ywGXwFC1qzi0mpc+vO8wT
         kNfaqDU04031cp+L85JZNK3iajGT92DI5MS+vOicJm/FpdXbpxcd0z3KNiIeKRLFUyQt
         tqLFcrAr5Vnnm7yCjDPQ8L+vaOlPa8r8o840iqMi7BA6VZUNbTct1oHrNNheMDG2jXri
         M4/ySjPMFCcfnd9BChafx5RtXhUmedzJkNozQJmDgl0eolgniE4oFaavi+jr/OqD5IJm
         OcXwdBUCLITcdT9t5MMRpdarSMXIqhcwEkZx1/lPGn9Q1CK9qxDo2RS7gJe19HPFqLcH
         ACpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708731995; x=1709336795;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIAGIlOyfdPQGzUhuhBTCj1fg0Ra/brIZfOUyFxv3go=;
        b=GFFiSa1iQOHT1wZtRuFOpM4VtOI6GlNFnoRY3Rf4cKHyNh8HEK8f3QPMGDVFoEXd38
         c0eS90b/JAA2l6JY8iYdlv1r1IATKCKQolfJ+HjkBm1jnb73UJUXtEJjoC0Bqe5zaQ3p
         8mAxX6jn93Vm73o8+CHO+GcJjos/hrncMj/fGL3kpsrANl49bTaWp9TmAjCluRRiNnN1
         OmJnQoJzuifghHJqWHWMk6POEAR7H0HXsCQKVb/V631tHXb3icUWkP56J/iLI0z+9f/z
         cszBelARDyP8LsLIMTlGIwA7I1b4l0vIuNPooPSNAP7wn6vMLajzVZULQOtI28xXLgmT
         bMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNhrqLj3AZlVL3sg6OIc1et/yuIxJhSJoDyHtxYiwPEytzvMlc+ZY/3yvTZIXgXV1kTPrI7MXdMJq9eT9Scr4eCjwlHE43/V5G08Qi
X-Gm-Message-State: AOJu0YxALJ95VlFBPPmqlnpHFI5rZFriCZGHqp9ecgqYswFSi/tV1GXS
	iTNiIDIzN2w0ci2Iywww2R6tsyodIN+1CSg273r/yAeJSg8Sg1nxSZD1CgyV74I=
X-Google-Smtp-Source: AGHT+IE0+tL8hH0wqn2x+/epyE+ZkG3YGes2J0uLaDyxWp2Ro/Yw07l0+8CizphqXDIS10sDl1t62Q==
X-Received: by 2002:a17:906:d923:b0:a41:30be:4a82 with SMTP id rn3-20020a170906d92300b00a4130be4a82mr677228ejb.61.1708731994017;
        Fri, 23 Feb 2024 15:46:34 -0800 (PST)
Received: from [192.168.179.2] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id u22-20020a1709060b1600b00a3fbe13e2absm52810ejg.211.2024.02.23.15.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 15:46:33 -0800 (PST)
Message-ID: <b50aae99-151b-47ed-b610-99f4748790bf@linaro.org>
Date: Sat, 24 Feb 2024 00:46:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 05/35] virt: gunyah: Add hypervisor driver
To: Alex Elder <elder@linaro.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Murali Nalajal <quic_mnalajal@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>,
 Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
 Carl van Schaik <quic_cvanscha@quicinc.com>,
 Philip Derrin <quic_pderrin@quicinc.com>,
 Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
 Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Fuad Tabba
 <tabba@google.com>, Sean Christopherson <seanjc@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-arm-msm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-5-1e9da6763d38@quicinc.com>
 <a3356079-bd55-4852-9bb3-b5362a1c953e@linaro.org>
 <20240223144844667-0800.eberman@hu-eberman-lv.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240223144844667-0800.eberman@hu-eberman-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.02.2024 23:58, Elliot Berman wrote:
> On Fri, Feb 23, 2024 at 10:10:47PM +0100, Konrad Dybcio wrote:
>> On 23.02.2024 00:16, Elliot Berman wrote:
>>> Add driver to detect when running under Gunyah. It performs basic
>>> identification hypercall and populates the platform bus for resource
>>> manager to probe.
>>>
>>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>>> ---
>>
>> [...]
>>
>>> +
>>> +	/* Might move this out to individual drivers if there's ever an API version bump */
>>> +	if (gunyah_api_version(&gunyah_api) != GUNYAH_API_V1) {
>>> +		pr_info("Unsupported Gunyah version: %u\n",
>>> +			gunyah_api_version(&gunyah_api));
>>
>> Weird for this not to be an error, but it's probably not worth resending
>> over if it's the only thing
> 
> It is an error, but maybe I misunderstood:

Sorry, I meant "pr_info might have been pr_err"

Konrad

> 
>>> +	/* Might move this out to individual drivers if there's ever an API version bump */
>>> +	if (gunyah_api_version(&gunyah_api) != GUNYAH_API_V1) {
>>> +		pr_info("Unsupported Gunyah version: %u\n",
>>> +			gunyah_api_version(&gunyah_api));
>>> +		return -ENODEV;
>>> +	}
> 

