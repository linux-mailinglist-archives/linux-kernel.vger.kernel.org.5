Return-Path: <linux-kernel+bounces-100973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6198887A04C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46891F229E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE678F6F;
	Wed, 13 Mar 2024 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCtO5NE/"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B36FCB;
	Wed, 13 Mar 2024 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710291233; cv=none; b=FCUG+9DWndDL8X5hc4VeKErVOhkyMHiuZoXAwQ/+U+Clj/nl8VqU069BhNWp/hmnlOApxYJPXZwtbOHLlFNQh/WGRcuauVSZPzRuxYveGxwhXlW+82G3kTB2k849TIOa+FRdyVlEC449D2vvTxWnOJiajlL0a3AdHVZsOhusttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710291233; c=relaxed/simple;
	bh=EN3DqD5pQ7mog0RBXk8W0/RBIznhtTREbfQ2U47Wiow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7LGReUqTzXHhnot+abdD8rEd0Cwg2f3W7yHO9NmgT6Ca/QsCyhkm50QPNxO53Ru90KURq88ZR+KfdPR9Ouvz1akxiHfqLuS/nHtLRHS32tO8MwWTmylQuebGbvBgRSK9XlVHJPDalN3U5eSJdoDVerM0Wm7E6R3g5SnwD3QLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCtO5NE/; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so4201880a12.0;
        Tue, 12 Mar 2024 17:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710291231; x=1710896031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCu7qP8kGoacD6jyN5z8MIwYru8L3XakVidOTwO7XFA=;
        b=gCtO5NE/3Gm6/Muutj3OB6F/P2j6ZM5ghA8kn+1+Vr2NJ1Ui3VXkfOYQ8o77U1MrKU
         +VTBPYcPc5Oj7xAaY2AM7FjBM6K8NPmK0Teob2I6EhsnsaldpgHls/LrqUOcDFHtvLyp
         aYhhVk2N1hN8saf9mFHSCSw3ZvizIwpT9ateuvGmGmJ3HuB/SAZmCtNnU0NKkEVVESpa
         645EHywx/Yiq4OxpvwAibCfD3L/EDQW030awEseR/P7+ZSYNcjla078i/tkOO4YX6//S
         dTV3lr+hjTAYwELIWNN5iG4i7Xlw7X6qG5DU/yXXB2VwPQdUZWkvxwy6q9AXoAIogq0Z
         hsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710291231; x=1710896031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCu7qP8kGoacD6jyN5z8MIwYru8L3XakVidOTwO7XFA=;
        b=R+8VO8hI0oQ8OZ+uaoEAPSUoek3oii6PMImHGGK3ZIvlnGuwG2YvVN3FLASeFR6H9M
         6QSeodJTVMRx+ALm22dkwofR2quJ3DE8KPX3odMHUxT+zV/tmlgEhs6NmXUC9wNkiDCB
         h6UGneUkwehaqtHt76Jn9W7xbOISuK1CD2bbpQVMMRfrn6KIhoBhgziRugPXoPOXLORL
         PpNnS801SNH97qh7ph9XvrnkH1T/ajQlnUhH2/H+yPcJG9unZmI9B3y1NtaVFTZ/+hau
         sATpnFzQ1mt3TrHMvnC++nMxHZKZH/7DS9KUmU/sbE2kpLXhZjT5MqnipRgFctHrDaqn
         ZgOg==
X-Forwarded-Encrypted: i=1; AJvYcCXUUvGKyjZShXibxItHvsO7j7WVmOC3xRlLxTP+W1657gjPySJFv0+R2T6L1W5/SyoXyDkT/mmOZ7F6I/eraL0XubVkusnFTAEDoLTks7Vadspw50Ktl9ysASLD8QVNbXLJKvCv
X-Gm-Message-State: AOJu0YxKuYfI9ZJ2bba6zCgKRpXiWQBKwC6E8nMer9b+ANM9Bta0Uu+K
	So2fUy4ZJAZDxhfnvhBx+FxrtjqmGjTa0bftYWxw7cPXobV8AzixxKb/ah9N1eU=
X-Google-Smtp-Source: AGHT+IGbB9EAMh2Cns5yRNX7ITItrtBERakI51ryjoKsmZyDY7ZpXMVW517iENepPMfv+28xd+2MfQ==
X-Received: by 2002:a05:6a21:9217:b0:1a1:1f7b:9b08 with SMTP id tl23-20020a056a21921700b001a11f7b9b08mr1822683pzb.47.1710291230564;
        Tue, 12 Mar 2024 17:53:50 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:ba1:c5e3:e8e1:573:b323? ([2600:8802:b00:ba1:c5e3:e8e1:573:b323])
        by smtp.gmail.com with ESMTPSA id w20-20020a1709027b9400b001db3361bc1dsm7328885pll.102.2024.03.12.17.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 17:53:50 -0700 (PDT)
Message-ID: <3e84e1c9-f680-47fa-aa59-615ce57b65da@gmail.com>
Date: Tue, 12 Mar 2024 17:53:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake option
 flags configuration sequences
Content-Language: en-US
To: Ronnie.Kunin@microchip.com, andrew@lunn.ch
Cc: Raju.Lakkaraju@microchip.com, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
 Bryan.Whitehead@microchip.com, richardcochran@gmail.com,
 UNGLinuxDriver@microchip.com
References: <20240226080934.46003-1-Raju.Lakkaraju@microchip.com>
 <20240226080934.46003-4-Raju.Lakkaraju@microchip.com>
 <78d7e538-9fa0-490e-bcfb-0a5943ad80c9@lunn.ch>
 <LV8PR11MB87008454A629EE15B9CE14099F272@LV8PR11MB8700.namprd11.prod.outlook.com>
 <PH8PR11MB79656DCF7806D7390C7100DE95272@PH8PR11MB7965.namprd11.prod.outlook.com>
 <fd22d022-cad4-489c-9861-36765dd98a87@lunn.ch>
 <PH8PR11MB79655416A331370D3496854A952A2@PH8PR11MB7965.namprd11.prod.outlook.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <PH8PR11MB79655416A331370D3496854A952A2@PH8PR11MB7965.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/12/2024 5:22 PM, Ronnie.Kunin@microchip.com wrote:
> 
>> -----Original Message-----
>> From: Andrew Lunn <andrew@lunn.ch>
>> Sent: Tuesday, March 12, 2024 5:41 PM
>> To: Ronnie Kunin - C21729 <Ronnie.Kunin@microchip.com>
>> Cc: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>; netdev@vger.kernel.org;
>> davem@davemloft.net; kuba@kernel.org; linux-kernel@vger.kernel.org; Bryan Whitehead - C21958
>> <Bryan.Whitehead@microchip.com>; richardcochran@gmail.com; UNGLinuxDriver
>> <UNGLinuxDriver@microchip.com>
>> Subject: Re: [PATCH net 3/3] net: lan743x: Address problems with wake option flags configuration
>> sequences
>>
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>>> I understand that the TI devices give the *impression* of supporting
>>> both, but based on what I explained above, even if you accept
>>> WAKE_MAGIC and WAKE_MAGICSEGURE on a set and report them both back as
>>> enabled on a get; whatever behavior your hardware does will not be
>>> fully compliant to both specs simultaneously anyway. I discussed this
>>> with Raju and what we decided to do for our driver/device is that if
>>> you pass both WAKE_MAGIC and WAKE_MAGICSEGURE flags to us we will
>>> report them back as both being enabled in a subsequent get as you
>>> suggested, but the behavior of our driver/hardware will be as if you
>>> had only enabled WAKE_MAGIC.
>>
>> So i agree having WAKE_MAGIC and WAKE_MAGICSECURE at the same time seems very odd. So i see no
> 
> To me it is not just a little odd, *strictly speaking* as mentioned before it is an impossibility, since no
> hardware can do both at the same time because they have mutually exclusive requirements
> for some frames.

Agreed, this is definitively the case for the hardware that I maintain.

> 
>> real problem limiting the driver to only one or the other. However, if the user does ask for both, i would
>> say silently ignoring one is incorrect. You should return -EOPNOTUPP to make it clear you don't support
>> both at the same time.
>>
>> I would also say that silently ignore the Secure version is probably the worst choice. Things should be
>> secure by default...
>>
>>       Andrew
> 
> We were just trying to accommodate your previous request to accept both "if the hardware supports it".
> And even though I didn't like it, this was an attempt to answer my previous question: "what does it
> mean to support both magic and secure magic at the same time ?" in some way that might make sense.
> It is not that the purpose was to "silently ignore" the secure flag (that's why we would still return it as being
> set on a subsequent get), we just took the interpretation that both flags together meant the user wanted
> to do an "OR" of both matching conditions (secure and non secure). I see your preference would be to do
> an "AND" of the two matching conditions citing security concerns. Honestly, I don't think there is a best or
> worse way, in my opinion the user does not really understand what he is doing if he Is asking to enable both
> secure and non-secure behaviors simultaneously, so security is probably down the drain already anyway.
> 
> In that sense I would have agreed with your recommendation that the best course of action would have
> been to only accept one flag individually and fail with -EOPNOTUPP if both come simultaneously.  And
> being mutually exclusive at the definition level that really should have applied to all drivers and hardware
> (not just Microchip's).
> 
> But then I looked at the actual definition of the flags themselves in the header file and I see this:
> https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/ethtool.h#L1993
> 
> #define WAKE_MAGIC		(1 << 5)
> #define WAKE_MAGICSECURE	(1 << 6) /* only meaningful if WAKE_MAGIC */
> 
> And even the ethtool manual says this
> 
>                    g   Wake on MagicPacket(tm)
>                    s   Enable SecureOn(tm) password for MagicPacket(tm)
> 
> So the "only meaningful" comment seems to imply the original intention of these flags was that
> WAKE_MAGICSECURE is an optional  modifier for WAKE_MAGIC. Since as Raju showed the ethertool
> application always overwrites previous settings (does not preserve anything) then you can only use
> WAKE_MAGICSECURE *simultaneously* with WAKE_MAGIC and not in a standalone manner.
> The ethtool manual seems to me to reinforce this since if says "Enable SecureOn password FOR magic
> packet", rather that "Enable SecureON MagicPacket", so the 's' option is something that enables the
> addition of a password to the 'g' Option.
> 
> So back to the beginning it is unclear what should happen...
> I'd say we seem to have 3 different approaches. Which way should we go now?
> 1. Follow the definition of the flags in ethtool.h and ethtool manual:
>       - accept WAKE_MAGIC standalone and wake on regular magic packet matching
>       - accept WAKE_MAGIC and WAKE_MAGICSECURE simultaneously and only wake on secure magic
>          packet with valid password matching.
>       - reject WAKE_MAGICSECURE standalone
>       Note that this is not how any of the current drivers work and does not follow the conclusions from your
>       last email either

This seems reasonable to me, and as you say it matches the header 
comment. Question is whether the enforcement of WAKE_MAGICSECURE implies 
WAKE_MAGIC at the core ethtool level, or if this is up to individual 
drivers. Also, how many drivers need to be fixed?

> 2. Treat WAKE_MAGIC as a request for magic packet behavior; and WAKE_MAGICSECURE as a request for
>       secure-on magic packet behavior. Since they are mutually exclusive only accept them individually and
>       reject it if they come simultaneously. This does not match the flags definitions or documentation, and
>       it is not how any of the existing drivers work, but it has consistency to it and it is the way you were
>       leaning in the last email based on what we knew by them.

I suspect this might be breaking user-space in surprising ways and we 
would eventually get a report about that requesting the behavior to be 
changed.

> 3. Follow some of the other existing drivers' code behavior (Broadcom,  TI or MSCC), which do not seem to
>      match the flag definitions (because they all accept WAKE_MAGICSECURE standalone) and we do not really
>      know what the hardware exactly does in some of the flag combinations / received frame stimuli. I'd rather
>      not do this since we (Microchip) will probably end up behaving in yet some different behavior from
>      everybody else for at least some frame stimuli and not match any documentation either.

I agree about the not clear behavior though for bcm-phy-lib.c, 
specifying both will eventually have WAKE_MAGICSECURE "win" given how 
the code is structured (assuming I can remember my own code properly).

> 
> My opinion with this latest info from headers / man is that we should follow #1. What do you think Andrew?

That would be my inclination for new drivers, or drivers that we are 
fixing, like lan743x. For existing drivers unfortunately we might have 
to preserve the incorrect behavior.
-- 
Florian

