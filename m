Return-Path: <linux-kernel+bounces-35872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C118397D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51D01C26A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE9F823B0;
	Tue, 23 Jan 2024 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYBw+EGz"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F33081AB7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035049; cv=none; b=qJEpprCk20nAn2vugTpo5jspx40tdx78cL6TNHb8QwOWK+W9EDfgE3sieleapJJKIgDTEhgVaul80m0fpDXmy4djlsGWjzkpfOy4ZwagE/IyYhtzsXrRVUiZmSPAkz/iH7AQsN9mXOxO4K4D8palcMWCEb7v1CT5fIlsKyFK0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035049; c=relaxed/simple;
	bh=Ws0qJ7T6hmIJBBtfjJFD9PXXxGcginQP0/lng4q35BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vmq/vIARUa4CfsOW4+92eV3FGS7fSsiXir342EZ682yORmUMPeX7aUNLXHuymc4Rtcf3Q4M6EYuK+am8BhBkL+z4f5OWa/c0+EMD0eAUUgTUx9t7Kj79N9Wg5RyabgTIfOzb4eeCjUp4e9Qk6WZB5s6wOgy9Z6c3PxbowsLk6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SYBw+EGz; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5100c2f7a16so595820e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706035046; x=1706639846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LN9h9o0TvW1Z8h064Gtg6LetJEg8QEPXg0Gw2KimOwA=;
        b=SYBw+EGzdDL7n2x3ElGBThcY+ooGcXCpPJ8eUwVWSBbnhKkQ9KEr4LAGNn3uUXQy/w
         jeNUA+XJeu8vVpmd1Dh8Dyb2iyYR7rPdo1o8QhgWJekTqur4ysoy7yXXsduoZHx+r+hz
         jVYkQ0Bv9zXFD+jHFV07tMzE2LcSqOYIGEqBx2ESC16kWJ8QUs/MnIVgX7RcOOXWFUzC
         7ljtH9Mjp1cWAJz7LVVYiCtxPB8cpC8Z5mmb0kWTCLosfScJOdRyMtdv7oiqQpDSz27t
         HRJWSYN06twDExHVd6rL6d/FYf2p6Pf/xeVVTZ+pKOZZYRN+UHSfElyvjiUbaNB3voUj
         QyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035046; x=1706639846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LN9h9o0TvW1Z8h064Gtg6LetJEg8QEPXg0Gw2KimOwA=;
        b=DvuJEzCI1t2gLq2J2cWj8xxInRRO+KF5llzRFWrmF/dGxdhx58iT7SdcNqGb6O3ulX
         6qg5m/+TpAYRA2fKwYnjbaGDe2Vim4UHLC2MnS9SOXllKgHZV1OhtA8uBz5VIGPipAva
         AtFLNRqJNnS1mBBayTXXvJUQTldiJOdiTJmA+QAppBFB6oH+kNNozJJw71oXSe75HiN/
         gJZhrI9/vq5Ew7iOuhGzpmPhTzZJ30diVdePM6dH+ofRqTPEtJOclx8PdOUeKleyPvU5
         IySW6TxWydOg71yragryOgXC5aHfl6dN4eXZ4y+X6VOtmIOyUcKxpfhwJqIABTMOdv3h
         QxwQ==
X-Gm-Message-State: AOJu0YwfnzuleQiK2A3/RLmzGa8AT7hpmCSOwAB+xOpm9ZAUYhMegPPH
	KFn5P5/DRd8sHwZbcxXw38YTc9FH46RtwylrAg6c1pSGwcI7PRcg37OYg00X82w=
X-Google-Smtp-Source: AGHT+IGdznjU130QhfIccD1XLAGBKrrNO4kH7ylydwv58ERSbXCSfMuJ71lukUQeKfBodk6G4hrvRQ==
X-Received: by 2002:ac2:5b92:0:b0:50e:7fb1:6433 with SMTP id o18-20020ac25b92000000b0050e7fb16433mr4738283lfn.28.1706035045728;
        Tue, 23 Jan 2024 10:37:25 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c26-20020a19761a000000b0051009ef42a7sm199123lff.287.2024.01.23.10.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:37:25 -0800 (PST)
Message-ID: <c8d8de26-ad21-499a-a0a8-f435d7518ee3@linaro.org>
Date: Tue, 23 Jan 2024 19:37:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] soc: qcom: aoss: Add debugfs interface for sending
 messages
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20240117-qcom-aoss-debugfs-v2-v3-1-1aa779124822@quicinc.com>
 <2b43e7f9-9394-4ed2-b6d7-46fdc1e515c5@linaro.org>
 <20240123002932.GC2936378@hu-bjorande-lv.qualcomm.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123002932.GC2936378@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 01:29, Bjorn Andersson wrote:
> On Mon, Jan 22, 2024 at 11:44:30AM +0100, Konrad Dybcio wrote:
>> On 18.01.2024 03:31, Bjorn Andersson wrote:
>>> In addition to the normal runtime commands, the Always On Processor
>>> (AOP) provides a number of debug commands which can be used during
>>> system debugging for things such as preventing power collapse or placing
>>> floor votes for certain resources. Some of these are documented in the
>>> Robotics RB5 "Debug AOP ADB" linked below.
>>>
>>> Provide a debugfs interface for the developer/tester to send some of
>>> these commands to the AOP, which allow the user to override the DDR
>>> frequency, preventing power collapse of cx and ddr, and prevent AOSS
>>> from going to sleep.
>>>
>>> Link: https://docs.qualcomm.com/bundle/publicresource/topics/80-88500-3/85_Debugging_AOP_ADB.html
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> ---
>>
>> [...]
>>
>>>   
>>> +struct qmp_debugfs_entry {
>>> +	const char *name;
>>> +	const char *fmt;
>>> +	bool is_bool;
>>
>> This can also be const
>>
>>> +	const char *true_val;
>>> +	const char *false_val;
>>
>> All of these strings can be const ptrs to const data
>>
> 
> These are all const data now, but what would the reason for enforcing it
> in the struct definition be?

I've just written too much rust lately and I'm simply paranoid
about mutability, it seems ;)

Konrad

