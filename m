Return-Path: <linux-kernel+bounces-147323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D61E8A7283
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C79F1F22BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DDA133987;
	Tue, 16 Apr 2024 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="pf4YBwr/"
Received: from msa.smtpout.orange.fr (msa-215.smtpout.orange.fr [193.252.23.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C59131737;
	Tue, 16 Apr 2024 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289164; cv=none; b=sYh1wB9eC7N/RD6fNJApGYJPlYKnEnvYyA3QthMUplxQis245pNxC+/M3jEUxfbbJa+cmSXBZv+E/hK7I1R5TCC5hFvfdCAEz0kUirUuAqVvLiNSr0Ivj/IxoV4jNnvV6abDNa1CFGwGQbtS00KqC+YXEsKToFIEmVU7Z3zIHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289164; c=relaxed/simple;
	bh=Qll9DbzHvcRZxQAViJ3Ues+BjKsh1eoXV2v7hi7sKA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iGd9Zantyv4A3Vw92GYa/1d4KsUHsNhVOcBlkO69ozmVMkWil00xD3JtfiD+dGnY3+YOfLTIgCG+O2cgr6SbPxVoOTfSQD27miNFe3+SHOLuea8QX2rrjmnL+kRjl7xzGa/m5WxCrdDQ5bn/O5OT8AHl1+nrVJQyj8slZG6nY3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=pf4YBwr/; arc=none smtp.client-ip=193.252.23.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id wmlzrLAy9o2EHwmlzrvVAj; Tue, 16 Apr 2024 19:39:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713289154;
	bh=U43Gs7s+4BWLSZzPuZsEnIb/F72Ohs3d3kKx1m0cYEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=pf4YBwr/L9plZdChLf677KHCrfO7QM70lqCmEiD962iWnKgS3W0lFH8guE0o2z1G2
	 2dBP8xxezYIK4FlsqJOjjmxSieD9h1jlb7PvWJ4sFBoEgKVry0KWZP53XSVVISS5/Z
	 5XPJrsMXittrnTpWMrDSEdBK1fZBm6ksire+/fQLDloTcWyLDTe++Aup9vIJ5PMcmC
	 4cGolyuFnjy9inujS47dRUzbIehOLqXWsY1vK35dX1eWU/wXGL/717QBwMgx75Rba3
	 nX8g8Wdr+ZTMKdZoFEmFrgB/1dznRxdnuR4pzHNsa0zJ8oMjroK33EWJLcQbG+pH/S
	 O4RQ+3NVg+BGg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 16 Apr 2024 19:39:14 +0200
X-ME-IP: 86.243.17.157
Message-ID: <3a4e0543-fc40-41dc-8aaa-19811b96f1cb@wanadoo.fr>
Date: Tue, 16 Apr 2024 19:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hwmon: (max31790): Support config PWM output
 becomes TACH
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>,
 Chanh Nguyen <chanh@os.amperecomputing.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Justin Ledford
 <justinledford@google.com>, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>,
 Open Source Submission <patches@amperecomputing.com>
Cc: Phong Vo <phong@os.amperecomputing.com>,
 Thang Nguyen <thang@os.amperecomputing.com>,
 Quan Nguyen <quan@os.amperecomputing.com>
References: <20240414042246.8681-1-chanh@os.amperecomputing.com>
 <20240414042246.8681-3-chanh@os.amperecomputing.com>
 <79bef664-b191-4905-896c-afab341b982b@wanadoo.fr>
 <9bc38f67-01e0-4a38-8db8-4086a215b474@amperemail.onmicrosoft.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <9bc38f67-01e0-4a38-8db8-4086a215b474@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/04/2024 à 07:27, Chanh Nguyen a écrit :
> 
> 
> On 14/04/2024 15:03, Christophe JAILLET wrote:
>> Le 14/04/2024 à 06:22, Chanh Nguyen a écrit :
>>> PWMOUT pins on MAX31790 can be configured as a tachometer input pin by
>>> setting bit[0] in the Configuration Register. When the bit[0] of a 
>>> channel
>>> is set, the PWMOUT pin becomes the tach input pin for the channel 
>>> plus six.
>>>
>>> This commit allows the kernel to set those pins when necessary if the
>>> maxim,pwmout-pin-as-tach-input DT property exists.
>>>
>>> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
>>> ---
>>> Changes in v2:
>>>   - Update the vendor property name to 
>>> "maxim,pwmout-pin-as-tach-input"   [Rob]
>>
>> ...
> 
> Hi CJ, what does it mean?

Hi,
just a shortcut of my name : Christophe Jaillet.

CJ

>>
>>> @@ -528,6 +532,33 @@ static int max31790_probe(struct i2c_client 
>>> *client)
>>>       if (err)
>>>           return err;
>>> +    if (device_property_present(dev, 
>>> "maxim,pwmout-pin-as-tach-input")) {
>>> +        err = device_property_read_u8_array(dev, 
>>> "maxim,pwmout-pin-as-tach-input",
>>> +                            pwmout_to_tach, NR_CHANNEL);
>>> +        if (err) {
>>> +            /* The maxim,pwmout-pin-as-tach-input is an array of six 
>>> values */
>>> +            dev_warn(dev, "The maxim,pwmout-pin-as-tach-input 
>>> property exist but malform");
>>
>> Nit: exists
>> Nit: malformed or "is malformed"
>>
> 
> Thank CJ,
> 
> I'll update that in the patch v3
> 
>> CJ
> 
> 


