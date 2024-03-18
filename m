Return-Path: <linux-kernel+bounces-106146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D3B87E9D6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDE2B21C36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BE238F80;
	Mon, 18 Mar 2024 13:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlykcDMR"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC41DA23;
	Mon, 18 Mar 2024 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767305; cv=none; b=d4nh1ShB0JeDU5EDRb9RCdtVYrPV81E3O9a1x0yyST1xSOL4sk20cJh3Wbfv1ppujspJoz/WFlAzNS6LcHBM0jw85Vgu1iFUr1LvFzP0oLYeJWfDd3+8drrQn2r+wcEuYHTEW2YgOsqrIISxwbZRmsplBBNcqU0YknTqf9gCT0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767305; c=relaxed/simple;
	bh=9y8WJjFyw32pW/zJbqRdgBfGpHDDLgekVbv5GaetnbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+np8t2Mj+ZxBQVmzxkZLF5CMY3IjsA0tokAKvV3ezafh4qZ9CHqYJwZ3SMXnwg1nw7SWkwI/nCC/eRFek+O3xEfNhKKYJQ090VeSh4QbhpSxVgEWE1ZGYHzLJNghKyZW9A8i3QjtyM68vOWlGaicJ0NeSALI9HW45pJyp22MRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlykcDMR; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c1a2f7e302so2445909b6e.0;
        Mon, 18 Mar 2024 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710767303; x=1711372103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0b3lVbJ/u4Iyr/bGVB60L+I6TRPbyfigHd10qyDtAt8=;
        b=HlykcDMRwV8Y3mbA9rjIDRX0GEs3DCbCc54OLQ3sD2B+AYRBn/FBTeRYXntab2Toyq
         9uxtn53mvPyuvpZxwkZEBWTHgPqRRxjDKWUGT3Odn1W5dDr5Anfd7NERRwng3xGKUIM0
         OLRsVSLzpso8PLJ/0zW5idIa7XxaX+fKM6sm27UHXwFz1LFuwYFbgBlwFkW39+TKnfmm
         xCXjd92QJvoL8TzNCgyuNgq0RMx1WxNB4+7I6cfvXPusnWobo2QC9km963uyWk9F/IX8
         Zyo57EM9D4T6l5QF0D8MC+LSb4AWcnQrKgV/87berIwGkoBaDnFhGuHQSdOxXGFFeAib
         GA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710767303; x=1711372103;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0b3lVbJ/u4Iyr/bGVB60L+I6TRPbyfigHd10qyDtAt8=;
        b=LFZN9qTe0Jif2481Gjwytcw8fXFGMuP31h/+Z6jqdXwaJDeFYyUBVir1hfA9dFAHVn
         mAurXMa8dBTPjSipMk9T49OXxTHERKi4HnxDdf/56ZHL9YgGYUmcb/udHS0NRNIvmrAa
         1HeR+utGR47ioc3UAD/y1g3/BC9p/Vj55NsGXRJe9TcGpYQ1cE/3LcbjhqD6Ft0JcJBJ
         mH+umE5ZaZcf75Az8Az0o96E1tfeMNS8zulnNBUXrnZeFmAfxwgXwK5sJiF1U50Np+YZ
         Zs5TVQkCwjNECCoBzEy3Gne+P/RTybK6yB6827fwIxFJt52FKmpkQfDtcjC7r9fgcWfw
         6I2A==
X-Forwarded-Encrypted: i=1; AJvYcCWust3m/oJ1x+4DDLrDX52gFxnAbYKQGw9CU9TWrC1dW0bUQnYDWADaUlCGYlFElQH7dQGDpKWnNfewaksCtMZTfQ+pgOdhWh8HAxZd4Q8QSgJUTQeBAU/s+deqIv1qP8wVceKp
X-Gm-Message-State: AOJu0Yw+LlrpqVTG+mSJO3mlbnfa1bacecP3Sd3SRF/ZIr8nmAnLYtiL
	kHXzv4L6x+HDbab749DwgMhfWNQh2Ziv7ZYJPfR7fttxdHv+yMm4
X-Google-Smtp-Source: AGHT+IFe50KHFHexAqMvJ0KnSzN5auUkz3ombF0fqCQ23161eDZZjvx9TuaLT4tbp6XDv3V6+OkWNg==
X-Received: by 2002:a05:6808:2289:b0:3c3:82a1:e6e with SMTP id bo9-20020a056808228900b003c382a10e6emr7831238oib.53.1710767302926;
        Mon, 18 Mar 2024 06:08:22 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id l16-20020ac84a90000000b0042ee243ca95sm4953118qtq.50.2024.03.18.06.08.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 06:08:22 -0700 (PDT)
Message-ID: <50d8a099-1274-40a7-937e-b2618bfe65be@gmail.com>
Date: Mon, 18 Mar 2024 06:08:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: phy: mediatek-ge: do not disable EEE
 advertisement
Content-Language: en-US
To: arinc.unal@arinc9.com, Daniel Golle <daniel@makrotopia.org>,
 DENG Qingfang <dqfext@gmail.com>, Sean Wang <sean.wang@mediatek.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
 Russell King <linux@armlinux.org.uk>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>,
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-0-3f17226344e8@arinc9.com>
 <65f7f17d.050a0220.c6db1.02bdSMTPIN_ADDED_BROKEN@mx.google.com>
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
In-Reply-To: <65f7f17d.050a0220.c6db1.02bdSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/18/2024 12:46 AM, Arınç ÜNAL via B4 Relay wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> There's no need to disable Energy-Efficient Ethernet (EEE) advertisement on
> the MT7530 and MT7531 switch PHYs. EEE works fine on MT7530 and MT7531
> switch PHYs. Remove the code where EEE advertisement is disabled.
> 
> This is a bugfix because there's a possible race condition where the
> mediatek-ge driver would kick in after the MT7530 DSA subdriver which would
> have EEE disabled until manually enabled.
> 
> Fixes: e40d2cca0189 ("net: phy: add MediaTek Gigabit Ethernet PHY driver")
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Could we get Sean to chime in, maybe there was a valid reason to disable 
EEE advertisement in the first place?
-- 
Florian

