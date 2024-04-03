Return-Path: <linux-kernel+bounces-129773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 326DD896FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5577F1C26D7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636D5147C7B;
	Wed,  3 Apr 2024 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyFVlrHo"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412FD146D4A;
	Wed,  3 Apr 2024 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149401; cv=none; b=pCW5eBI2Tw1qiAfwgPo9Fz8XdRglePPH88ZGacUgQK0ibNc+IwSBrN586cA/cC8XnsvLcKVi3CB4lqbQ6SGLEHQ9X6RgBWe1W/skozkO2EiCHpkjRI6aqkKET3Sd5rLhna8fLcL3V7otoaeWhVcRLUP/taUTfN+3c2XW/9WAFgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149401; c=relaxed/simple;
	bh=E6lfG13PcnNz58IaAGW7ihADQg139d/SD0LNUyqmxf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PdmqxVuLL3JD5yAhBTsr2XIxfdgMvKzczhPW2zpSEGGPE2oH2yVWrzcKsgVTS9X/7BgByaqfT5OWI86pUXuZ1s2SS6cnbJOl8gU+nxUYhYGQeBVgH9GnkflODoU45jGxfJJGECRdJSdF8jjkTX/U9BqHGwh+thJA/l5iBHvXh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyFVlrHo; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78be9dbeb6fso97112785a.2;
        Wed, 03 Apr 2024 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712149399; x=1712754199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HOnNZBHVIgQkZQazHVoZ3t4kn/GR20CDo5+kjRIKGKg=;
        b=AyFVlrHo+zRKUF+l8q2uaFsvJ9hvZDF/1uNjdVJiwHKEy0n4BQgBgsPvrOQDqHRIB4
         Lzt978BiPO05y9+jO09iWxqfBPXkv5Mq/I1Cc4rPncAy8EPdHQK3mVCHhWwICEsiQk/9
         8RgGkVG1ejlU2C1/28pr+ItKV/bYh0PF4x7zuh/bYFWhRmmdACizXLXU+rAeIeNLFLqs
         gU6VPH51n6I8u98mZv71LNqPxsFJF4NQkqrbtZmu3m+7GfAmnbDl4J7q2JQG/WaK4YNM
         8SmEV/DH15cNdqEq1I1cHox4DBeKN/6/bVqDK8dYoPWS0gc2aRTZzpaFJb+x2qQPJ4vk
         WXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712149399; x=1712754199;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOnNZBHVIgQkZQazHVoZ3t4kn/GR20CDo5+kjRIKGKg=;
        b=nm5V9ZKdceiNQZrJwGMS40ZP47dw0BnN6GLu6XI2nZU9e8DfjVCzjzQoZuWz+5OwfQ
         c0mzVHlg4kdGeEr+1nW+QmuPJGXcfd6LjKw84Akb+f4rj63J4ZCpY8A2hiDE5HuojjtJ
         4UxopX0sJGZge3OMGbrlKbfnZGP9UQO+WqUyENFi2ULVYL6jj6tarB42/wfNfoqLHcBt
         NSu3YkmUEi/H6mBdTAyXsnWbBGcBxQf9XP9lWDBZxRdkSLcNsnxJL0NUfP/inxKDw9lQ
         c4Z8ubFDGTH/OHVtVNDkqo6UIh0UQZGCGz6RcP0QhpfDmUcHfDmzbWNb2VnEeox8N8oI
         J8kw==
X-Forwarded-Encrypted: i=1; AJvYcCWiN9+VVBWy32kqAR68N0uUy8d9jFzWi2RsPTX5hRr8ceup4HyJiDh19f0GvRPVbc4o8MdFzk8wJSst0m1I9L4p92WYPraeRvWKW5yDMNpA+IYuhuGdOMPf7F1W23y/pQn75QQr
X-Gm-Message-State: AOJu0YwvLkUYMfr9ZE5b5nhZtHKj6ruFK/X+xg/HKahDpyu4DdS1dhv7
	AL0oAfGXK7yGdiUVC9b3dp0oqha092vGOp31CHKYkNVFTamgD1FG
X-Google-Smtp-Source: AGHT+IHUog/pgztupp8ZyqL8qHCDryQqBb2z4UJTIzePGn2WF+JrubKXaT35DVuQAp2igVKdPJ8WMQ==
X-Received: by 2002:a05:620a:4507:b0:78a:1a97:f34 with SMTP id t7-20020a05620a450700b0078a1a970f34mr3220668qkp.47.1712149399242;
        Wed, 03 Apr 2024 06:03:19 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id c15-20020a05620a164f00b0078a310ae98asm5059300qko.77.2024.04.03.06.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 06:03:18 -0700 (PDT)
Message-ID: <72225167-0b22-44b6-bb65-09db4995fd1c@gmail.com>
Date: Wed, 3 Apr 2024 06:03:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 6/8] net: dsa: microchip:
 ksz8_r_dyn_mac_table(): ksz: do not return EAGAIN on timeout
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
 =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20240403125039.3414824-1-o.rempel@pengutronix.de>
 <20240403125039.3414824-7-o.rempel@pengutronix.de>
Content-Language: en-US
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
In-Reply-To: <20240403125039.3414824-7-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/2024 5:50 AM, Oleksij Rempel wrote:
> EAGAIN was not used by previous code and not used by  current code. So,
> remove it and use proper error value.
> 
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Acked-by: Arun Ramadoss <arun.ramadoss@microchip.com>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

