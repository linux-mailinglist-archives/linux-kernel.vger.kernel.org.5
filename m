Return-Path: <linux-kernel+bounces-137771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EA489E6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD73284054
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B451FB4;
	Wed, 10 Apr 2024 00:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JaL6oEGI"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877301C2D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 00:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709137; cv=none; b=uTeZeRYoReXURB7KdbwRy2vtZRSeLevw4FlkucQS/sEc+Ek1jKev9AieZ2uT5NnH6h0NsydyFX70w1eS6INWsxsD0NvrNVn2RQXsyp3y79PHGJWqfJ5TqO6LpcewUtDS07P35bo7xRQfP29J43QqNHnGa+vZyTURHBkxyUGgikw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709137; c=relaxed/simple;
	bh=1Exgi+JLL+QO+d2hti+19dm0FiYFViJaiPvbpGc8XJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cl3oxDjTIqp/1fmy76YXM5k6htOlalIsTDQ8WIQYAGTKEPA4BQ9Zt3GWMTEztxICY0s4bjqXwhMntRS6LPi6TxKH9UOOoc5Ni/19swV4fM7FSdf7JkrdjgldOPe/zy7EarMn0M/dYxqCX0NEAJomURVfx/t6FemV8oATKnWRtmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JaL6oEGI; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7cb9dd46babso64065939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 17:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712709134; x=1713313934; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fH2gqC5dLvzkZJc67eDj37ebZ1ZnAJYQHjhTciwIjkU=;
        b=JaL6oEGIfkgOCcxqe1xkRRenn6oCPvhberFzYRXylZdIotELj8VBlHEECfbumTB9e0
         4qPCvrP2mv/0OH2UY3CQLV7g/KWti/4ER9gXiAMFNjzmu/Otisr09nXdvC6nTSQAOlYQ
         2Z5fV+OiERK2A0dL73Qi25ItCQqy61ko5wKG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709134; x=1713313934;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fH2gqC5dLvzkZJc67eDj37ebZ1ZnAJYQHjhTciwIjkU=;
        b=ZmyqBlFNI+2IiDtB4EZwYTwPN4rqqRgBARuJKGF2k9ASwPhxO1R1jz4nNDn1fKLxpC
         2+PJUCKFlL3CxZU69yOiCY2Mc8/lNfqobXLUHQcloBdnysStMBAeoFm0d0jHt1V1ZpiI
         7mFYLE/rUNT3nQ8MREb9WMfu132Wjoxp3/rCjm5ymouQnly5nHtuTqIRRgp+6yGZAYcH
         SOjBoj/n6ZOdOazhCTxWtXbJa6ZYM7v6AzRcI1Zx6X0orcOL/ECSEEATkJbLEQQK9dDI
         ufqBoNUpNadWROrjxtncez0enNHghRT3bM6w7Kx9QUULp6sw88Vpn1XQk6Vh8Dh9vi5Y
         njXg==
X-Forwarded-Encrypted: i=1; AJvYcCXLmf9r1rFLGmXY0awikU1ZvTfb9Ksh0igYuTD2AjnETdRBbCUVSokl6gpotDz2p76XlEk27DXwfKzVfm0jJGIB1trPe1mIH8FktXY1
X-Gm-Message-State: AOJu0YwdLvWLEm8mHz1ZfbTrjnKQq0xxbRMZm2943zaLEgFFnzIsBiRj
	9s7RZMDuPRIrc+blRNmDGXRU3c8yvF/GD96abtLXp18k/bVd2r4JGA4lcdPfcDI=
X-Google-Smtp-Source: AGHT+IH7BSYmyscHz7vHJtvD9eJkudLF4tWaNfGG1dnEvB6mShpdylQuwZUbV8Oy3sTctHyrzW6kVg==
X-Received: by 2002:a05:6e02:1d99:b0:36a:38bf:5fb2 with SMTP id h25-20020a056e021d9900b0036a38bf5fb2mr1612736ila.2.1712709134686;
        Tue, 09 Apr 2024 17:32:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id p5-20020a92da45000000b003686160b165sm2843156ilq.75.2024.04.09.17.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 17:32:14 -0700 (PDT)
Message-ID: <99cc80f1-9ea6-4acc-a320-2cac6f7035df@linuxfoundation.org>
Date: Tue, 9 Apr 2024 18:32:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/690] 5.15.154-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 06:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.154 release.
> There are 690 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

