Return-Path: <linux-kernel+bounces-156804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB5B8B0861
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422A6287C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE015A4AD;
	Wed, 24 Apr 2024 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dyjNgCLI"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F51A15A488
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958479; cv=none; b=YvSRCphP4hXhm01dk8Vo5BpyP7mDZGw2JnY0OivgYbcz8lXoctwAziYkWJH3uvNcPbL/dr7w8fJFXrVtzgiCOeAmy6tqok1Ab3Tou856CwsJHqv+Lkex0oS/Kph/y0OSQJuT/REC53q/kv+po3yQdK0vAHhy2qx7oDg5VMcty5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958479; c=relaxed/simple;
	bh=YcUfxhUcQApT1mNwyIlAfJBq0C+KxLwY6/CxV7Yz34E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1XX+syIjRPrOqqgavUMg/21cc3E7//cQwvzT1zjnfXMl1sfmM5nDLADgViz346YP6juNpLmsOTMsUmXiTw/PiRIzXyv0wPRvIDWYJNXcC7p23DADPx5lPdiJhzvOWVWCJrsTd8k644hvVVI6NWH/NwWUV+91NOBK1Ba9U7aek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dyjNgCLI; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34be34b3296so88187f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713958476; x=1714563276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k25tPjMFnxZGYgnKJKp0dkB0J/d5Y8BkULxm1XocePE=;
        b=dyjNgCLI+8hS8qaZyK26/0ZFyeQ+xfIIbktz7Em+kwHxKinVXEZaki3lbDs9vN09RC
         bBjCXHvKVSIgLIRNdL+jSSA+N+98qhJcgC20Pn8a6Vxrm8wUaw/Lfl31dvkdvpQZJ41p
         V/j1nvSuAsuIdBxgWjWAmK7MlpSzDFur6m6nv/ExOPOskb4N+pskqD7uzJxgMInQUioo
         BdCe67LvXk8hngA+tfbJNb3IA73R6B2w4DazvbHU+f66eJyvYaiB2RYsxzxcjMciuTAR
         FDZ0aDLhpxyM4YHkp921wVLMvrRqpWzyEUrN00knLwx6+gQibRdF9PsrqP2WSCadJRNf
         dAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713958476; x=1714563276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k25tPjMFnxZGYgnKJKp0dkB0J/d5Y8BkULxm1XocePE=;
        b=mfXu39QC/TLp5LoDLp0pL2IiJhDND+4s82+4ruCzrhQGmIzCvb0MpaUPhqH7aTMqmG
         kXbHmeZd9BeZzcaRZ/Sxw82nlV37S0Tdh4SIA1TEWaW2ShNc8T10/Id3jPfQqTqROM56
         kVRfUS7iLUsDX+q5uNvGgDOmdGGh+W/U8xBeZqtGT462mmjZmMmy6/Zg7AhvoA+DBtPK
         2v1bYmaQlgldDFq+qIiUckXR5NdBRmPW1rLLvj2K9+Zg+504W3vlFwrhfKGRCvlVUmtS
         ttudGU1ixeePD678pg3dT9WzRd3pf2OX7PFWj/3y9Fo2K4uO7qRaZCNGZHOJb5Yn4YTq
         ipmw==
X-Forwarded-Encrypted: i=1; AJvYcCWDS1JCEavYTGkydMqDeQfFWjhmmjj69ZnRieCOZU6uV1ghUPpV1MR0y+zY3Hp0otPMLNtFgq9OWSTCkjXVT/ll0XgBN8RmOuYlc0Zl
X-Gm-Message-State: AOJu0Yw7bte7SGcZrnwciU+ngBBLTIg4JlNmuhPNoCXgKOOnvXFmdBwe
	VR29gtlzZtRgpbWZBxx16H6R1VvfQ8+RTPnngVEUtT3E+ctqCxmmTSaIR6ZR7qBHJU0ubxRl8Lz
	h
X-Google-Smtp-Source: AGHT+IF7nndGnjcSyHSKcy0fsxfNLV5bYy8H6C5JEFkHVts2E5ZYVuz34KpOvWk+i4MbUAfOVCjbxw==
X-Received: by 2002:a5d:6709:0:b0:341:d3b0:ae7d with SMTP id o9-20020a5d6709000000b00341d3b0ae7dmr1725373wru.45.1713958475772;
        Wed, 24 Apr 2024 04:34:35 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ea7-20020a0560000ec700b0033e91509224sm17003566wrb.22.2024.04.24.04.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:34:35 -0700 (PDT)
Message-ID: <917f9bec-80f3-4d10-9781-7b27f361101d@linaro.org>
Date: Wed, 24 Apr 2024 13:34:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 14/16] thermal: gov_user_space: Use .trip_crossed()
 instead of .throttle()
Content-Language: en-US
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <13515747.uLZWGnKmhe@kreacher> <15186663.tv2OnDr8pf@kreacher>
 <ZijNj7DzL9e01Vnt@mai.linaro.org>
 <e565a9c3-9244-4a0b-9ad8-4beebd03d681@linux.intel.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e565a9c3-9244-4a0b-9ad8-4beebd03d681@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/04/2024 13:32, Srinivas Pandruvada wrote:
> 
> On 4/24/24 02:14, Daniel Lezcano wrote:
>> On Wed, Apr 10, 2024 at 07:03:10PM +0200, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Notifying user space about trip points that have not been crossed is
>>> not particuarly useful, so modity the User Space governor to use the
>>> .trip_crossed() callback, which is only invoked for trips that have been
>>> crossed, instead of .throttle() that is invoked for all trips in a
>>> thermal zone every time the zone is updated.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> I would also consider removing this governor which is pointless now 
>> that we
>> have the netlink notification mechanism
> 
> That is a good goal, But, not there yet to deprecate.

What can be done to deprecate it ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


