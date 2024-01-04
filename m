Return-Path: <linux-kernel+bounces-16137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CE6823986
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65551F25DEB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDCE7FE;
	Thu,  4 Jan 2024 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YJeT7fYw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B04366
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso9037839f.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 16:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704327499; x=1704932299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SuD1D14mJpZxgunpN2GoPeJomdi3lVYstSMBtTROq7o=;
        b=YJeT7fYwnu574GGgKEGgLj8Zl/8/6BuaFkhltV7ig4GIxKjHUwqWicLBa5djmDi4tZ
         pP1WiZop1MhiyBtXRaO0EPAlxupWqRATl1uyWrncaetp/9dA/5vlnxXM0Bt31Z3JInoH
         rOB8Z8/4zVtk2tuV81mG69ZlzWq7FGoJ1zcD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704327499; x=1704932299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SuD1D14mJpZxgunpN2GoPeJomdi3lVYstSMBtTROq7o=;
        b=ONMs2jfa/xa1m95ZuMBpG62S+3nM8gQVeuwIajeDJrHiBEe4M/6tpO7PP+1YnxdsyD
         JJwSam0AJbTk3eqpFEvlwpfT5/PT7HMrvlecFHQoZBifG8ONYiQN0uoV0/MK/M5noqHZ
         38jcZlodOxqmdB0cykqfpXdnfufDyfgwxbThwi0ij7pOlit+lQd3T34I4kOt7P9f5+hn
         0188QX2EqL/EkuZEn+SBwvCuuG3KafQ5G1ZXHzZBkh8imyC5PaITKwoUge2JEGsm+lxV
         jGvHnlqfk3uiE/4KKgllfoIqK5omEouG8yMMpA8Sp5qfUhyID0V4GRiE5HXb0C+RLHdR
         Ij2g==
X-Gm-Message-State: AOJu0YzKyLyEVr4/tywKVxWiMo12+vd7vh5OZvZUZncdmvtpsqBVJlJu
	NhjHznW2t5VnNF0XEYjeszHiQIOxFC4noA==
X-Google-Smtp-Source: AGHT+IFBl+paPAGn0wPchVPzxKzuWnrgImKUlT+cEf0osTlbByFRoRzHPU245Q7vGRg2ejxjDhiaRg==
X-Received: by 2002:a92:cdac:0:b0:35f:f683:f76e with SMTP id g12-20020a92cdac000000b0035ff683f76emr27999742ild.3.1704327499572;
        Wed, 03 Jan 2024 16:18:19 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id bg11-20020a056e02310b00b0035faf00c555sm8776442ilb.31.2024.01.03.16.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 16:18:19 -0800 (PST)
Message-ID: <72d36089-147c-42aa-afe4-5b3fa681dc65@linuxfoundation.org>
Date: Wed, 3 Jan 2024 17:18:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/49] 6.6.10-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240103164834.970234661@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240103164834.970234661@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 09:55, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.10 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 05 Jan 2024 16:47:49 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

