Return-Path: <linux-kernel+bounces-51304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2450A848910
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4381F232E6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664F1134D8;
	Sat,  3 Feb 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="baNxXuWK"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB3134C5;
	Sat,  3 Feb 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706997395; cv=none; b=T5+3bG8tdDsrR1ZQvFPqUZ5ZGa8ZqTuLZHWict1PLDwS8P+0WgG4Jd2NU9z/ktSX67WryglVK/aTqY2oEmdPjfjxCAa4HqNbbyexIGuJNAlG1vx+JBwsvSs6Esc4p+yNjYT6b+XA/w0wjeZUfahFatL2d+nyS2DOaEpQ3XJvkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706997395; c=relaxed/simple;
	bh=oPiHuL7R+vkA095SZL64km4wfSqPTATslzLvOlfzXlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=muQKEOKl/FKOSTLpkem4HcJUzjXHh03yvREu2cmbqxGJov70u/WvQ7GSrcq9orSsOtfZSmPEiyFV0g2Hf+C+xhvgtmIkTWUzLSL4oEiWVk09UBqIlaPaY407QjExGyZC1ScJ7/2h8VXOhMt0bHydl/crPQtFCnttl4o6NlY2fzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=baNxXuWK; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783f0995029so210947085a.1;
        Sat, 03 Feb 2024 13:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706997393; x=1707602193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XlJORjV0cMXk8TeZ5ODKyQU7XXUQGwVFK1QhooGB8ms=;
        b=baNxXuWKIYJ3x+3V53PdPGdOSzm6VaNPSKHZPnVt1KULQe1710UlUmqVc/UZVutCDl
         NFhrJM7SoZTCn8vHN/TZme9mEjZDuWiaRZPOzmjzFBjtEV1YuyVPzpgwD28CxEw+llyg
         QZul5q9jOIoAs3yHr47lcJx4lLpyU2w0hof7jAZqOIHq3Uq1ZaH7dMYTecOuNiRgZ7jK
         vuFNvIRdJwyxq9/HViCje/Rb1acuwsua2u/Dup9RDFDyAYbyReRbnCgJLZn5FJMHKaYg
         Ehum1beovgH3vNRZYmok/g/URFFlx74nSP7cHBTHivY0/FQsy23mjlUNXqQYAxUHA7ZN
         moVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706997393; x=1707602193;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XlJORjV0cMXk8TeZ5ODKyQU7XXUQGwVFK1QhooGB8ms=;
        b=es878WBq0qQ+8hgKaiTAmiAP/n1do2alMgOwBSyJ4Gl1oeDChLwhVFrIk0krDXvj9N
         h1t3Fc1TxIPKKsejM5VO7ZJ448RSQOE/PH0VkDz4z3A9zt41XhyldfmLqyZ+rO9teZv4
         nTJas4cz11YSDQhGo8wR6KlEtL63oFKr6aMkSDIr2NCo3n7R2Vcdmfkx0uFwBIK4/haJ
         5jzVr51D3knWWsAWlIHycYk3YcagJjEGbxZuLQjwQY2dU6goOEKyh0hMTf9aglxoZoRl
         WbIdM8aOW6mQjvM+ebt5P3Po9U8RUWm8H8OGf220yFTllHsLyIYe3ZwgUTLa17H6Q3X8
         3kfg==
X-Gm-Message-State: AOJu0YykzeGwxnyzhnTn7od5xhxbZzPHcuZ8nbC+aM2JUxeE7djWW9XU
	VG8zTarP2WX/apatwEeyC/ILHEDMOUhaZPvqkDjLY9jstqqAscUp
X-Google-Smtp-Source: AGHT+IGAOcEH3n+j1N34lCv6qXlG2Sn1UWAlfEqhLr/IwErxbW69Bxp1xKWo68098ckgeeNUh7Dpeg==
X-Received: by 2002:a05:620a:3913:b0:785:6fea:906c with SMTP id qr19-20020a05620a391300b007856fea906cmr2091213qkn.16.1706997392864;
        Sat, 03 Feb 2024 13:56:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW52quavIiaDvF7UuLWuuSylr5aHyKuO38AwJApZvz3vh0kcfoyBCW/G066/FJ45tH3uvtriGHRjVzvCnybPRrhcO/jmvjLPMjhPeiuaLtfpok9CdactCgGsxnqMgpGAE11hYUnls3/28cOaLiMTU8vBUS+1JNSAw+XPW6a1UvSHhi1nbiSQa/2xeqJfApdM72m3oWsRJo8Vn6TN7xVvmZxMWu3MQMzkJriU0Z7t+h3d1R/tw4/8vDhry0FQtrlyd4oUfuWv+Od5lX8WJFfvhCjJTUzF5CssCEauzBMlWD1KqSLzZu8UIRajZpbUlHhEVgBRFKH+YegjT0sK4jZnrIJB03RBApHFRyKf6vyGN/yEHpYHDDOCDwxXlTazTrZXaEfsioTKVYlHyASpkH67Zm6UBdc8cpYpAWwAwAVKJ1GAL55LD3lHYHTuOX98qO/MJTWcFb/yZb/6+z554mpctKioImNU3VlVQMHHXn/Mgp2UUNekhCRhuiR7lgLR/eNdkmC7rmHujyb
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id o18-20020a05620a22d200b00783fb468e7bsm1732958qki.44.2024.02.03.13.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 13:56:32 -0800 (PST)
Message-ID: <e638c370-e3b4-40a6-9d6b-0de9fff63c28@gmail.com>
Date: Sat, 3 Feb 2024 13:56:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/355] 6.7.4-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240203174813.681845076@linuxfoundation.org>
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
In-Reply-To: <20240203174813.681845076@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/3/2024 9:53 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.4 release.
> There are 355 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.4-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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

