Return-Path: <linux-kernel+bounces-64600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADC8540BB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00571C26897
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE01635;
	Wed, 14 Feb 2024 00:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J4JtaeP/"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2F78801
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869612; cv=none; b=GpbtXL4pNMLHmUHJR8NchIPuJmgnIPUTd26kGckxim7xX/1uJmpzXXXT0Iu6xkBo7SQccjtNEvJlAwG9HzIapT9Vr9dFzYvpOvCAYcjSspO2ZW1PD4PUveVXY1JBSa8feJjq43Dys3FDt7hWeISepi2BcNLDoPI0BOA7Ep7UsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869612; c=relaxed/simple;
	bh=blGoqFSG+bM4MY2OkxkXog0upiI3/Y+AsY70uk/SFk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaVd6d97TzNYi3o5CTU9IWCxDiWV+0fm+Q0EQQZbIzsgAcYZY7APZq+FYlK93D9dc6dmDD5fpK/SFZVaqgmjHIimsKrJuhxrrayqxJOH8nzdbAB0/2xxOMmYreC+e1sC6PUmYvLqhcsVCd4UB87QDbBJo7AG3bfjoNzJrhtkKjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J4JtaeP/; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-363e7d542f4so4491625ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707869608; x=1708474408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yPDqGsGVRBXi/v9PW7ctsmPDNaShTV4LQ+ip6JTA0Hk=;
        b=J4JtaeP/x+wuBKqvEEml+awb8N6ipO6TEuNzML7LOHwn8uofV6SX7YHnGSlNXBwZXd
         +DgkjEkH4DusgRJl8yU3eR8lX1sEJTpKHeclf2X35Kyq5Kmk/FAjLnccSrvEwVrbacDq
         h7d+C4/4jOj13rsJ5OpuvnTXw4QV1cUabFY24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869608; x=1708474408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPDqGsGVRBXi/v9PW7ctsmPDNaShTV4LQ+ip6JTA0Hk=;
        b=M/yoT+IkyaSbCLjiZcnoNQpXUGBEKLZ+mQH3wilW/D71hn3Kcph3J7dl/CEEMhI+p0
         i7zrk6Ek1MX6CD393CgDfjH6Dg1GtHmNPHFcBccmrkxxMK8ApzHxYjnaGYItoPNLRJJx
         /Pn/71QMFW8wjtvlHo9OrcOw++naaw6omc4CHntH03N5N7ZbHqgpun3B14GwiPDR82J/
         lY9fy3PQl8rRla8FtZo64+aPiAywnx2+fAEeok7UzbzrJjSRUSJxrCBg0ybotTJfq/jM
         dMLLaIy2InyaceqC8udE5kQFVcZw4t+oW/UIFznAck/gd0z2g7l8TgTq+qUUiVyIUYc1
         4NfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJkoonKjDE9oLqbNN1EF79aDwJji7+Yz90h0WATuWSgGRw6yQ4ZbWHWfYetRCRhftlzW9j83He06HJp4F06yIYxvPJriwWkdL+9XAs
X-Gm-Message-State: AOJu0Yxk5schYFEh30b9fPR/cHmlZL1QWYuSgryBPU2tjiJfZcmTZpC/
	2WYETCWCZkCtaH2/gQHwYug50PZcY/Wbzbu/TOUIo4KQGngyv9lg5tXtyDfKlM8=
X-Google-Smtp-Source: AGHT+IFj3DIzE8TUG3KuUciUIn0QgQ8h3JK6FQ/JtamGNxaKJ+e6Cs9gS1k8YQ4vLigeLUxYKfVwKA==
X-Received: by 2002:a05:6e02:1b8e:b0:35f:bc09:c56b with SMTP id h14-20020a056e021b8e00b0035fbc09c56bmr1410174ili.2.1707869608280;
        Tue, 13 Feb 2024 16:13:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUlRfBRzl53Qpa1e5k4sZBQjm6mmkehiuSVkzvDmLjCCxZQ6dHTfpladZ0qu8fqLi1FYonvVXAq6JIvnnis3b9fJP2R9/PyLh/9m1L8dIuVQyxdu7uF7RDTs93CIzbrWK+VWnsngZyogbd8xrT7rObS57nyqilAWdEJ5ZDDSBVcsjE/qnFrLF82j9BPBVfawKiua8L/me31gsAVPjjS8Dq6M/qqFfRIeJOvopZdAVFd9a4TgwmChgW4H94d/N6Or9jquGBsAsehslOf/e3hZoC5j2nh2+EsICBXI/VdXAMoZMEt5n93zilacIgQO3aamtPQ8qHCqZrlLvVErTIHIjsUpQkTNplO9dGK1h4STPhC1jRuGb5Frc7wewX5OeaZV55ynWOza4hEWEbI1KruA6q4f5/NxBAytyaajsCoEb9jCDV/LOx4whuZHuFE/KPnC46iNS+xgNcAj5lpY444OMhrU98CAV6OleVbascJRkIuHGBPakBcOM/VBgvHx93G14retu6GQQujrRtL8mfGENKH4n4HvNksgyfD3Mn1CxsgYbSAzykZXyCCgr8xuDUBM0qcbuM1epZcJw==
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id z11-20020a92da0b000000b00363ea1209basm2752707ilm.11.2024.02.13.16.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 16:13:28 -0800 (PST)
Message-ID: <5ff3912d-abb5-4049-831c-81a3bc8da929@linuxfoundation.org>
Date: Tue, 13 Feb 2024 17:13:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/124] 6.7.5-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240213171853.722912593@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240213171853.722912593@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 10:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.5 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

