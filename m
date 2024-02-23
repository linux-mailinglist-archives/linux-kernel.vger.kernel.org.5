Return-Path: <linux-kernel+bounces-78007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21375860DEE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324161C2161D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A2D5C8E3;
	Fri, 23 Feb 2024 09:26:36 +0000 (UTC)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0435B69A;
	Fri, 23 Feb 2024 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680396; cv=none; b=J7W6FoVYItji9FM8Ubb21+IiDEMLrwu0A1arJ7sZ8RQJer0G7yXis+8TQdtnJMYO+OrphFUkfeVONZPHDbdvzNhY2Vm7T6YXowm8TLFtIQe6zrCtFZUo1/myKp5VG9o1fTTV6qAvPu89vr56MsFuGqR9MV4RobTO87NMgx9+4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680396; c=relaxed/simple;
	bh=dxEZ+oD+Ywd4mmuMoO07G5vV6r8sUVuFCthVA6NL5Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dE5YYOwNpO2QB/yvhHd55iIpe2/VbvqRDUZOKPZHM4W/jWSbgF29DhL7/qvbe9d3n8qiEtVA7NkLtXK+6Bpm+aXIpTgAUdJwa3JJE8pmDsHp418aH54762PlR3MS0TTuUVWa3hJYGHCDmTF+vhP6NNT/2to5Ij7eqTaAXi3+9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512a65cd2c7so959492e87.0;
        Fri, 23 Feb 2024 01:26:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708680392; x=1709285192;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3wSs8YfhmxTb8gou2V9Pt5gbeGf/6qyFAVCFuJPfK4=;
        b=cc4K7SCetGdB0AGSb7CaNkmUkVmOqQfShV0Cnjv41rTtpxVNCmmVV0JoevRaiAZQUT
         V6FR4hCYdqQF7ZkN/tmBsr3tOdmbXKN72tMZDIFnWiPswCtlA3IjLhiB0Vs7AHqCvD/K
         1z7Vl/U3dE7Sbu8X2j2h78mNPYUK9mLEDJCe7gZQ97sOLNC5vyz/uGUrVwHubEQVUezb
         76Zf0Rn9lUWeCyIcBXddhnwdxDU6+JWWQuSbWB/58c5927lQkiRcjrI9MatRDB2RbtfU
         7FjyfdttInnnNEYIJFxQCXZmk/VaL8CgRPOQucF2WmJs77julJbnsUxN5ivsZBmmr/JJ
         4d7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWPfd/MZgzCydiNud0ubIInh6r+GG9CaCkRUVZVV9qrspRHzwERwH8TBDvZWGPL3ltMIO+MOoZcaL57E27QIWZz8sSBY+RauSa2A/L6PUN7rCOEKap+u+XzEwFJ3S0zEAOOjwTAwAovTfwP
X-Gm-Message-State: AOJu0YzrjAU5N4fuH9G2tKrA50cxWUc7WKnfOkulWsr3vvS6zFTpJFMB
	wgNqLkRsgs5ZoXrmrPoxiKlr7CBdI8PW9MIne2R4mqL4TS6OLgNUrHnhjoGwFw8=
X-Google-Smtp-Source: AGHT+IHwumWK1kUJpaVY4MrN2Yv/DHmgjG9NBeLDSmpqLY/eCSIR8gykTQwV1cK+cJfC6wcTExIV5A==
X-Received: by 2002:a19:7701:0:b0:512:e3b4:2955 with SMTP id s1-20020a197701000000b00512e3b42955mr894913lfc.22.1708680392172;
        Fri, 23 Feb 2024 01:26:32 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id bt11-20020a056000080b00b0033d6bc17d0esm2178029wrb.74.2024.02.23.01.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 01:26:31 -0800 (PST)
Message-ID: <254db026-5f9d-497f-ac44-c81d9d5947cf@kernel.org>
Date: Fri, 23 Feb 2024 10:26:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Content-Language: en-US
To: Rengarajan.S@microchip.com, linux-serial@vger.kernel.org,
 gregkh@linuxfoundation.org, UNGLinuxDriver@microchip.com,
 Kumaravel.Thiagarajan@microchip.com, linux-kernel@vger.kernel.org,
 Tharunkumar.Pasumarthi@microchip.com
References: <20240222134944.1131952-1-rengarajan.s@microchip.com>
 <5bf4ba6d-d8e3-4ba6-a889-cfae8c3ddabe@kernel.org>
 <e93048e64c3f8aa2731575d4b296c473e8dadb82.camel@microchip.com>
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <e93048e64c3f8aa2731575d4b296c473e8dadb82.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23. 02. 24, 10:21, Rengarajan.S@microchip.com wrote:
> On Fri, 2024-02-23 at 07:08 +0100, Jiri Slaby wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> On 22. 02. 24, 14:49, Rengarajan S wrote:
>>> Updated the TX Burst implementation by changing the circular buffer
>>> processing with the pre-existing APIs in kernel. Also updated
>>> conditional
>>> statements and alignment issues for better readability.
>>
>> Hi,
>>
>> so why are you keeping the nested double loop?
>>
> 
> Hi, in order to differentiate Burst mode handling with byte mode had
> seperate loops for both. Since, having single while loop also does not
> align with rx implementation (where we have seperate handling for burst
> and byte) have retained the double loop.

So obviously, align RX to a single loop if possible. The current TX code 
is very hard to follow and sort of unmaintainable (and buggy). And IMO 
it's unnecessary as I proposed [1]. And even if RX cannot be one loop, 
you still can make TX easy to read as the two need not be the same.

[1] 
https://lore.kernel.org/all/b8325c3f-bf5b-4c55-8dce-ef395edce251@kernel.org/

thanks,
-- 
js
suse labs


