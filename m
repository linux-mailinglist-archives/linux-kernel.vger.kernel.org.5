Return-Path: <linux-kernel+bounces-100707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C20879C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538651C22CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A318142642;
	Tue, 12 Mar 2024 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzlSzqRr"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB06139584;
	Tue, 12 Mar 2024 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710271406; cv=none; b=GODZJac/cIwM1ZW6Rs1rPWtCXO9G2feVA2JPJnbSgpzOuuBUUy41BNqnzLQELsou//a/+DVmSaDc8BPFHIh3oU+0AxfSJfXUhGggfhVcasT8ErkRpGO9nGd24MTQznjE5ghDOwsevgt7w0b3MudFBaIa6gSt/+mN80yu7xQgFX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710271406; c=relaxed/simple;
	bh=Fkz2cYg/UnQpPqJ5/T0UskGLn9+Ts8M5l8TckPJfqSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E9F37f6L+3Y0zXOvUOOeX1VXUhB4Qf7OAwhkiINSEnuwcukhh3eGqQ0CXYSTReZ5U6qUza5xC5Pxgb3rfrNPsv7fT8u62b79qItOyVZtOw9JIXT8fPYJFOvpGsaKQ/Jl8PgKZuEFvmljNMMSHb30eBK34BaqTg+dFcW6iFRpauY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GzlSzqRr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29be5386b74so2116280a91.3;
        Tue, 12 Mar 2024 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710271403; x=1710876203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRX2IqHBUCJP6dnshTrjNT5jXrHx160FIBk6BJm/QvM=;
        b=GzlSzqRrNePAd4Sa8yf9bpt45Ll9FclPjhrkYmfxXTCV3O/KlfLkAIBuc7hVe4aPDz
         lQDI5rDxcgYxMXXWpyJcie/TCT9TuxcY/dBdb8QBmJnji2p3XyENHcmaeXS+mAd+AZBb
         plsy8aaLD/dO+01ypw3ipdALEEI9uANWhnD1MJO9/Q5pml9zbogz9WgsLIPOjWX/rpCM
         356jkYoY6QpOUlBiazkl/+G4UIdYqM7dOS0CAFQ5ifwd7F3LvpPTRQ/R2J0zE4oA7vnC
         7LtANNjlaslXHw/BoByL9u6/jOYby+3oTrO1yIBb5v2RDcN3YPU8MVdC1ftwFOkulYTw
         vXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710271403; x=1710876203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRX2IqHBUCJP6dnshTrjNT5jXrHx160FIBk6BJm/QvM=;
        b=bO86q1r/qXUvGMELzfEHXRhFZ756zV7UfwYRBph2mnSjuZao4T8rQg5p1Ol5RIQBY/
         gtDPl8zd6ZmF7BKpMaF0bdMMlfarTueCrMlnHG4tFDod+19iGUZHLyp62x2rOqslSniC
         HajzLamu9Hm7TtVwb1EP243Pao29wqgbnrNjl3nGi6JbemSSwOmlPbo9jSevNg8xIKUP
         LEcqG98G4MphoN/3JHmbyya3yGENdjkGk8S5WAfrWO7A07EHiD9OhNo//PQunBoHUSkH
         ycT+UV6SV5Chemlw+ZqhN2CT2V7og/g05fSyW58kNJbgnAO0WUdXcURxBmXAuRchqoQQ
         8zEg==
X-Forwarded-Encrypted: i=1; AJvYcCV/OPkUmrsf08JdCtgrSlaN74oKYOao8bjGvpYkUMZzxTDO+Zl0GH/ZAgZOmw1vzm9aWRedopseSxmK1cfwuj6xG6E6F9j96lflAbPSrIMfpHJJSjrEmWFGx6SqtwdDkWlVjH1x
X-Gm-Message-State: AOJu0YyHhMJMQU6VCk1YKXo3lO+PHSnoUQf97K1OYr1tWSxpiBC7AXB2
	xMYZSX17GqDFi1EHKvlKHVVztQvzfYvVJx6dUFFgq8JOKOrkCCBw
X-Google-Smtp-Source: AGHT+IGiHISrqyiGbygnsGOH+T001ziYgxBsvT03/4mPcUqK+Ap3w5HJL0qY0g23WW+kVW1dG14MKw==
X-Received: by 2002:a17:90b:3010:b0:29b:bcea:c17e with SMTP id hg16-20020a17090b301000b0029bbceac17emr2698389pjb.1.1710271403343;
        Tue, 12 Mar 2024 12:23:23 -0700 (PDT)
Received: from [10.69.40.148] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id ay3-20020a17090b030300b0029ba5f434a8sm6164608pjb.26.2024.03.12.12.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 12:23:23 -0700 (PDT)
Message-ID: <b1acf9d0-872c-487a-9938-6d667959d0d3@gmail.com>
Date: Tue, 12 Mar 2024 12:23:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: mdio-bcm-unimac: Cast denominator to
 unsigned long to avoid overflow
To: Florian Fainelli <f.fainelli@gmail.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Daniil Dulov <d.dulov@aladdin.ru>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20240312165358.7712-1-d.dulov@aladdin.ru>
 <ZfCOb4x/+41y+SW3@shell.armlinux.org.uk>
 <df295be9-d33e-45d2-914f-c9c1554e5ac0@gmail.com>
Content-Language: en-US
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <df295be9-d33e-45d2-914f-c9c1554e5ac0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/2024 10:23 AM, Florian Fainelli wrote:
> On 3/12/24 10:18, Russell King (Oracle) wrote:
>> On Tue, Mar 12, 2024 at 07:53:58PM +0300, Daniil Dulov wrote:
>>> The expression priv->clk_freq * 2 can lead to overflow that will cause
>>> a division by zero. So, let's cast it to unsigned long to avoid it.
>>
>> How does casting this help? "unsigned long" can still be 32-bit.
>> Maybe unimac_mdio_probe() should be validating the value it read from
>> DT won't overflow? I suspect that a value of 2.1GHz is way too large
>> for this property in any case.
>>
>> https://en.wikipedia.org/wiki/Management_Data_Input/Output#Electrical_specification
>>
>> (note, this driver is clause-22 only.)
>>
> 
> Had commented on the previous version (not sure why this was not 
> prefixed with v2) that the maximum clock frequency for this clock is 
> 250MHz, the driver could check that to prevent for an overflow, most 
> certainly.

Could also use:
-	div = (rate / (2 * priv->clk_freq)) - 1;
+	div = ((rate / priv->clk_freq) >> 1) - 1;
which is mathematically equivalent without the risk of overflow.

-Doug

