Return-Path: <linux-kernel+bounces-51305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6C848912
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1971F1F22D35
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063D3134D1;
	Sat,  3 Feb 2024 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVQxEwZm"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3E8134C6;
	Sat,  3 Feb 2024 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706997439; cv=none; b=K3OFUz3LgNpFolDCutFj7OpvP74Z1fj/Agh/vaoDTj9od3ct7i03icx/KPDT9+Ox5VeNfNNZrfNYenNzTXSDVlM7ybDO9aT0CFPcb4lS4iNfGNdw7dAeqHTusSro9cgs2ewYfDeCZSosFkx3bC0gO1ycFq0RCxiVwdErd5Cm6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706997439; c=relaxed/simple;
	bh=lyHp8wLQstzCzlNPWs1HTrdybbdJ/t1MCH/dc51Y51Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIROOTU9cBURLX+j64/m9+o9/09trKdD55Q/LCvvYqzC0IWkiY9dji9lKEBRDKbP15RfaSNQP9NFCBNQ2vzeLBxuGGNtDDKk2xaQgQHy8obdGCGp2I+TAij4r/cqGryHgUeMC3Q6CQB9vywivVq4QG4O9Uxqfcez8PkD/HGpac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVQxEwZm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783e22a16d4so330370885a.0;
        Sat, 03 Feb 2024 13:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706997436; x=1707602236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xiL1Z6KfFXP14fdmKAGU65p3FcgIDh0V3E0P0l9b9g=;
        b=DVQxEwZmuBZx7Yms7+NuCkMz8vEbPRh32ba9vAcCz7PX75XhwWNgk08hEBeAXw9vz4
         fr+0gXRGo17FGNDHV+YSYmRdxHwfvRm2yNoIy8xhYzOjfWU3TV/wMcmoIcQafuyyZ03c
         yQ2sRxTwDPTuByAOZCN2lTVXF+H6H0mg+9xM5m801HZS4uDHUkhD9EGiLMzjT7UiNnJY
         tdZgaXDVbX+Mf11bdWk64QiLcGAusYTeUnL7fWme5njqCMTE1MUp6tIhNoQzB94mAYej
         91wzw64Z2EDq9SAIRV7xw0Zh2R5E+lgfTKfrKsGKl7kVuQTX+afEaz8zat9I3IzyAWbj
         iaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706997436; x=1707602236;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xiL1Z6KfFXP14fdmKAGU65p3FcgIDh0V3E0P0l9b9g=;
        b=FgH9G+9Uqz+uY9uqIGtYZCmTT61rQfEV/p96U/VPcbcU6i9KFnNPvS9i3ykWPbNSCX
         Bd0vlmHt6rbI38AJDKVtt6wO91JR/d34975hhQJ2a/oNg+ceBnM/2HGyos2Rvki4jKem
         4ulLD+6nQfZQPlN3Q//6lIQHZsy3vp0tRmXakxsT9b2pzfMAg768qQLWwyhZ6JRAbUyz
         j8ywdIeAIJeElwcYKgOjSA7EkhTaR1ELAXAFR+5qjezkf37Wtf492t3zFJkb7jriXHiW
         MGxx0fVvw7Q56QKn//DWHwOIehaYYdXFwgcsI/Et76esy/2ITA/JfvvUC5L0L1n9lnOt
         ABug==
X-Gm-Message-State: AOJu0YzzYrqlCzXCJBjR31GSt1MOCbmOcWhDzHY7V8ngXcuYQLJ1K7od
	Fr8aYSFknxNUCl22LJy1Qk5v+nZ8mAmec0yAvlcZr6YXoqNfj1BV
X-Google-Smtp-Source: AGHT+IGZZjeNgub5QaH9Fv0vuHw9eKGkEb0HsW66wIyt7WHsnLOZA28BpurzTr9sNTK1/gMuboCDPw==
X-Received: by 2002:a05:620a:4586:b0:783:ddf9:ffd5 with SMTP id bp6-20020a05620a458600b00783ddf9ffd5mr4384165qkb.36.1706997436665;
        Sat, 03 Feb 2024 13:57:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWtc/TER8rw8fAYtcxpzJdcRpyCj0NYDbS/GjVGiA51AWzN8RStFscidMC3reJBoffMDLRmaMelyPh/A4fRjhfYxG4H0+zbKx7VRYJ7DQR8Dfc0JmuMzM3faTweNJxZ6poXlJu1dAZ0xVT3c4aQgnjnR3zzv11rZBTA0J8NcEXM9tI72ygKoUkbnLKL7A9KdOGw8xLNAD4l3rSEeaJH5oLXPUWaXd9VVeX9Ag7XAoeRfR6lzVboJQm5+IUTADT1h8/cHwiE9A52ZcMQ5kCsLmjCfnN9XYr43AcWL/ti4fTsENMNa636IG4qq/Y/QJcuE7hS5q29gkJpTyXyfH6xwFM3Py7Fmn4iU4CRQ79KahgtNB1/ANU49+at4BIKbol6boDqJWeoRhxIlgeX1mruoi8zVlGk8DNS1HlZPR0dvkp5D1S2OyLd/+8ZzaNW33Uz8tVDfWZ9OpoQNfkfnITSHvhwrYW6sR+jWyj7w8xOC4rJ1jHrMgOKmjwtlnTcAAdwbLFEUds/uVl/
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a22d200b00783fb468e7bsm1732958qki.44.2024.02.03.13.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 13:57:16 -0800 (PST)
Message-ID: <39c4ebbf-c0f8-49ab-944b-a71bd85d8abf@gmail.com>
Date: Sat, 3 Feb 2024 13:57:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/326] 6.6.16-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240203174810.768708706@linuxfoundation.org>
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
In-Reply-To: <20240203174810.768708706@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/2024 9:52 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.16 release.
> There are 326 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.16-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

