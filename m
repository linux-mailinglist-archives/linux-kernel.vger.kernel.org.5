Return-Path: <linux-kernel+bounces-100903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BC2879F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD8DB28338C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAC43FBA4;
	Tue, 12 Mar 2024 22:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLO/Y7kd"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5EB2C9D;
	Tue, 12 Mar 2024 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710284015; cv=none; b=J14YSipTsW4/eCZf+5WehGq3wdBxTNkAghlMpfkQGdv5HRuaCegPgRON8p+cy21Wu4aCdW1LLrTD2u+dlTtfvrHSJJn0S76uhqkOeLvfwYti8noL5ncJw55iGdkSZJxcgJIDNbbR98Zykt+FwlY8j0pyP9aCjrOoFlEqQZ2OYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710284015; c=relaxed/simple;
	bh=oiHBupg3hKTNDZyDCbcsnZhSvrtP3cmmac4MXjYgg3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyDELppB+/VYB4fzTYCYaOsIXqjfWyr93j/MintaTltMsLiZCbk1SE97IcH7GQ7ESENUA3rARovjdp5a2fisZdV3nkGpjy39Wo92nu6vwAFt1vXWLPf19g7WPiBJrTYBJbuMq4VBcciAKc+C5hxHKeQW0py7HocrIoKyJYiEeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLO/Y7kd; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce6b5e3c4eso3099391a12.2;
        Tue, 12 Mar 2024 15:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710284013; x=1710888813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ws0GCecP3gtok9CdydFBjF3vhcGqXsT8MJwMPrN7s4I=;
        b=gLO/Y7kdAlWve1YKBH5MCxjA15grt7f56uLYMMXAjHHMlg+b24hiz1Gwya1Hun0F2K
         js0KyRJVuXSYuXbOi6ORzZfuIBrYjaEHUqa/P11Ar5HDUrxRDlKpyG0SKz9oWebiqLgc
         27o1RT33i0JVuEYXGnm1fg3mrR+nL336od1/EJmAT5HaCE/lD+njhdhrWP3LR2PKtP0d
         8H4xsNlkS0QCaqpoU197iH4pnO+I25E7CzWolxx1ZOmIsYzTdc4mgS1Cv7urPl4BRfzD
         7etTjBu57UrrX4dPTjyWfUZMPs1AFut1UiA9NpYAT7TQkilP+tnmvJyo42xMJttMwRxR
         G40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710284013; x=1710888813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ws0GCecP3gtok9CdydFBjF3vhcGqXsT8MJwMPrN7s4I=;
        b=WkPBz1udna+/r4zVx8BNvJQkRKKT/q0JcTWe4EKjIKoam8HDXSkwvfa8vv1dToQdl3
         MZOwzp6r6VpdNAVo50hU5sr2+uVmnTh3hvzheDOxP/xRRZePW79osG4R8zIM70+9WX8f
         19j68OzTYR6inGQ7WCkB6kfc8+LYsikSf5U/EgSsj2e2FoOLAhCz7wTxWF+M/AKL8Toa
         b2GxItj8OQDW+dRLPVDj0lNgPtNHeFsKUz4kcEhHX9NFbAWQt3mdCpOzTJxkZ7C7J9Bw
         EbC1NHh0i+Tefjy6TgipyyJngmfRwbypo+NucICHRpqnYrSGbDxYJZ+wbSo7IB1Q8elY
         WMvw==
X-Forwarded-Encrypted: i=1; AJvYcCVxC5Ofp3dS5+948ni+2Fz2WWMhVYs14vS/xt5x681FNGoFDHFydqGHx2LMHr0C3cYaTtAGHEdFTOQUn5sLQrte8FkuTitU+sCV5PNjGWrUtW2Vvlm257/XPVyQ5vbdxbGF3x6F
X-Gm-Message-State: AOJu0YzWTb/Ylag4t+bBopk9PSx0Z4M+ZIt7jDtPrLynMgn9QTtlpwXW
	DoABlnuNUtwBbaDRYWi2yw80nLgo+GKFc6MJebXbB84dWptMtpGA
X-Google-Smtp-Source: AGHT+IGgUc908mpe9CvZd5TjoTqUBzD5lc8ql9iD5ivS6tRq+62jKxgFTufh2kq7KuswUAkIOKSchw==
X-Received: by 2002:a05:6a21:998e:b0:1a3:318f:bc69 with SMTP id ve14-20020a056a21998e00b001a3318fbc69mr442423pzb.4.1710284013162;
        Tue, 12 Mar 2024 15:53:33 -0700 (PDT)
Received: from [10.69.40.148] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id c12-20020a17090aa60c00b0029c0cc16888sm104797pjq.1.2024.03.12.15.53.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 15:53:32 -0700 (PDT)
Message-ID: <ae35799d-5560-4761-848f-578051a9fca3@gmail.com>
Date: Tue, 12 Mar 2024 15:53:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: mdio-bcm-unimac: Cast denominator to
 unsigned long to avoid overflow
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Daniil Dulov
 <d.dulov@aladdin.ru>, Jakub Kicinski <kuba@kernel.org>,
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
 <b1acf9d0-872c-487a-9938-6d667959d0d3@gmail.com>
 <ZfCwGF3JRiFdJ353@shell.armlinux.org.uk>
From: Doug Berger <opendmb@gmail.com>
In-Reply-To: <ZfCwGF3JRiFdJ353@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/12/2024 12:42 PM, Russell King (Oracle) wrote:
> On Tue, Mar 12, 2024 at 12:23:20PM -0700, Doug Berger wrote:
>> On 3/12/2024 10:23 AM, Florian Fainelli wrote:
>>> On 3/12/24 10:18, Russell King (Oracle) wrote:
>>>> On Tue, Mar 12, 2024 at 07:53:58PM +0300, Daniil Dulov wrote:
>>>>> The expression priv->clk_freq * 2 can lead to overflow that will cause
>>>>> a division by zero. So, let's cast it to unsigned long to avoid it.
>>>>
>>>> How does casting this help? "unsigned long" can still be 32-bit.
>>>> Maybe unimac_mdio_probe() should be validating the value it read from
>>>> DT won't overflow? I suspect that a value of 2.1GHz is way too large
>>>> for this property in any case.
>>>>
>>>> https://en.wikipedia.org/wiki/Management_Data_Input/Output#Electrical_specification
>>>>
>>>> (note, this driver is clause-22 only.)
>>>>
>>>
>>> Had commented on the previous version (not sure why this was not
>>> prefixed with v2) that the maximum clock frequency for this clock is
>>> 250MHz, the driver could check that to prevent for an overflow, most
>>> certainly.
>>
>> Could also use:
>> -	div = (rate / (2 * priv->clk_freq)) - 1;
>> +	div = ((rate / priv->clk_freq) >> 1) - 1;
>> which is mathematically equivalent without the risk of overflow.
> 
> What's the point when the maximum clock frequency that the driver should
> allow fits within u32, nay u28?
I'm assuming this question is rhetorical since I agree there is little 
point to this change.

However, in case it's not, the point is to make the SVACE tool happy. 
The tool has correctly identified that it is possible for the devicetree 
to specify values that would produce an intermediate overflow. The fact 
that there is no existing hardware for which those values are legitimate 
may be very relevant, but the binding documentation does not specify any 
such limitations and the future has a tendency to make numbers that seem 
ludicrous today less ludicrous ;). The brcm,unimac-mdio IP could find 
itself in some future piece of silicon where it would be capable of 
dividing such unlikely clocks since software has a knack for outliving 
the hardware for which it may have been originally written.

My suggestion was merely an attempt to remove the possibility of 
overflow (the unrealized bug) without altering existing functionality 
and without needlessly promoting to a larger data type.

Best regards,
     Doug

