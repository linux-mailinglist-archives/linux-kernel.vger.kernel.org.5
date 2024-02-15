Return-Path: <linux-kernel+bounces-66493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 128AF855DAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416EAB351E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5313FE7;
	Thu, 15 Feb 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woUs3HEE"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4313ADD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988020; cv=none; b=X4+BW+hj7wYTOqRUT3h6Wa+Oh3ayq8TLX+mGE3bGjrxd9Y3l1Ms30ED5m7GkOK75aZg3cxbu3HEetMcA/F/WmqluLDYYWlV7Y7XtBiG2ryJXN1DFxk4ESGxu7l/VDEIBQezoXxlbi5cb9Qa4d16LheeP3KpKESK2oT8RDejAoL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988020; c=relaxed/simple;
	bh=jI9LqSmuZj4H5TkJ6IK9Ersbmyseu+sPzIbpCKzMIok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giUqsisL3W181amFUXJnL3lobsRnzqKcwDPHTHzasUzBCsRJL9Rzz28eJbXODOeKQ/sslWyzb3uGzmYGyP63mcdySUH+HvaV9dYrsM2PJOgyyUNpVR+zA6EzF3247JeKv3Dn18pF+StCnPuEdi1w14pQ8vpLqdU8bN2EhDLupQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=woUs3HEE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3566c0309fso69080466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707988017; x=1708592817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+/cr0SnJgLt/Y/uPlaXf1y6lLfASp/lHSA1ZZKTjFds=;
        b=woUs3HEEb+Z0RCi/bHu0Cab/Otjvdh9/1Is8kFXy7VbTNV3Jm9cry8tDCRTpsnIRLo
         37wPiW3nLQHzpOG0G8zDvrFYjNe9GAQa73rqQfQS4Z4/QAvND0g6oN5RdmXjQMFa4x5j
         3sy0qnPx6bodciRVeLHpmvMwwjp83EaklHvAjPE/5/rzYjpgtTZeGqxNZ93pejytlRjW
         /+JwULnndDhv/EXpiZSv4K8UjIzIYX5dqIBuPv8363fJ0yW8T7j7+dXrqBvcRObWN5AA
         7DkRXEtOAmdZuQDj4CznHrhoT7VVkoE7aD7ASL/dvYFN/6efZ8NDeKureP5lc/DQjtYD
         0aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707988017; x=1708592817;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/cr0SnJgLt/Y/uPlaXf1y6lLfASp/lHSA1ZZKTjFds=;
        b=mRfMB0bqn8quLnZ3uekjudvyi+JJTXw6Y72lfBYR4vMeb/XBE4JhTLGHm9YwKtxuZK
         xh5xDgzUr3dMdpn30S7yG3zUhC5ghhBY5uLCSyLkNNEDpPrvNhUtsapXZJxrGxsZ5v5Q
         aCU+Y4rhyH0XOiRXi0jRzwN+ELD9XIk9pXnr6eJK3c3TwwKlW2Um5QnRI4+AcM4KPQKb
         6W8+06dE4ZJ7tk+688xr5Etqg1gqlhzFN92YtB1yjpJAeBYFt2ZuOSFFZ5pRdKadXkIk
         Pa9oXDK2RUbPnc1v/v+b1L7vrZmJZ3d+nmm9PbI7fx4qEkHe60rbeonfa2C0crWriSTA
         yKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzKCBKzA/cWnbcFglHJ/GzP9v0LH5p5jSsJ7XA+tLF0DKySmKLYOKapkhw730efN7/ABhAboICdDQJzkexaEZ3yt6hyoMMC7RlTBSw
X-Gm-Message-State: AOJu0YxOpLw+YOeljL7intNSoAuyfrhWRYH+lBVBOeYcSrnGwaVUqOBj
	zSyovohRR4N7p9Us4Rd2iwVUIlGiPy5m8zJpyQuPbp5cCSlHXiAA3S9zoz05PZs=
X-Google-Smtp-Source: AGHT+IG0Ct+yZqI7+1UXBfdoxvX4aSQmC2oI3+DGIhN2luBFZTFtiXiW6nej5EfwumSj+h6NuoGbAQ==
X-Received: by 2002:a17:906:a40f:b0:a3c:d669:c48e with SMTP id l15-20020a170906a40f00b00a3cd669c48emr788548ejz.2.1707988016905;
        Thu, 15 Feb 2024 01:06:56 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id gt18-20020a170906f21200b00a36c5b01ef3sm338626ejb.225.2024.02.15.01.06.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 01:06:56 -0800 (PST)
Message-ID: <135e3154-2a55-40ac-9ba9-2de00833b903@linaro.org>
Date: Thu, 15 Feb 2024 10:06:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
To: Tanmay Shah <tanmay.shah@amd.com>, Rob Herring <robh@kernel.org>
Cc: andersson@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-remoteproc@vger.kernel.org,
 michal.simek@amd.com, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 ben.levinsky@amd.com, linux-kernel@vger.kernel.org,
 mathieu.poirier@linaro.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240213175450.3097308-1-tanmay.shah@amd.com>
 <20240213175450.3097308-3-tanmay.shah@amd.com>
 <170785205177.2155555.1311787541370066483.robh@kernel.org>
 <b931a24c-f676-4ddb-bb7c-e7a509d5dd4b@amd.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b931a24c-f676-4ddb-bb7c-e7a509d5dd4b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 21:37, Tanmay Shah wrote:
> Hello,
> 
> Thanks for reviews please find my comments below.
> 
> On 2/13/24 1:20 PM, Rob Herring wrote:
>> On Tue, 13 Feb 2024 09:54:48 -0800, Tanmay Shah wrote:
>>> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>>>
>>> Introduce bindings for TCM memory address space on AMD-xilinx Zynq
>>> UltraScale+ platform. It will help in defining TCM in device-tree
>>> and make it's access platform agnostic and data-driven.
>>>
>>> Tightly-coupled memories(TCMs) are low-latency memory that provides
>>> predictable instruction execution and predictable data load/store
>>> timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
>>> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
>>>
>>> The TCM resources(reg, reg-names and power-domain) are documented for
>>> each TCM in the R5 node. The reg and reg-names are made as required
>>> properties as we don't want to hardcode TCM addresses for future
>>> platforms and for zu+ legacy implementation will ensure that the
>>> old dts w/o reg/reg-names works and stable ABI is maintained.
>>>
>>> It also extends the examples for TCM split and lockstep modes.
>>>
>>> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>> ---
>>>
>>> Changes in v10:
>>>   - modify number of "reg", "reg-names" and "power-domains" entries
>>>     based on cluster mode
>>>   - Add extra optional atcm and btcm in "reg" property for lockstep mode
>>>   - Add "reg-names" for extra optional atcm and btcm for lockstep mode
>>>   - Drop previous Ack as bindings has new change
>>>
>>> Changes in v9:
>>>   - None
>>> Changes in v8:
>>>   - None
>>> Changes in v7:
>>>   - None
>>> Changes in v6:
>>>   - None
>>> Changes in v5:
>>>   - None
>>>
>>> Changes in v4:
>>>   - Use address-cells and size-cells value 2
>>>   - Modify ranges property as per new value of address-cells
>>>     and size-cells
>>>   - Modify child node "reg" property accordingly
>>>   - Remove previous ack for further review
>>>
>>> v4 link: https://lore.kernel.org/all/20230829181900.2561194-2-tanmay.shah@amd.com/
>>>
>>>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 192 ++++++++++++++++--
>>>  1 file changed, 170 insertions(+), 22 deletions(-)
>>>
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>> ./Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml:118:13: [warning] wrong indentation: expected 10 but found 12 (indentation)
> Ack. I will fix this.
> 
> However, can I still get reviews on patch itself so if something else needs to be fixed I can fix in next revision as well.

Sorry, I have too many patches to review to provide feedback on work
which does not build/compile/test. First use automated tooling, like
building a C code, to detect as many issues as possible then ask for
reviewing. Not the other way around.

Best regards,
Krzysztof


