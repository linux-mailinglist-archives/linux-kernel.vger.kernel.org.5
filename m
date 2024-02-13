Return-Path: <linux-kernel+bounces-64323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E9C853D10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F4F9B26EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A4627FD;
	Tue, 13 Feb 2024 21:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhYmxRIb"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9973627F4;
	Tue, 13 Feb 2024 21:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858936; cv=none; b=de9r9qhqAAeCfZuj+PK5hm8mOS4F0aDakixtd/u2UL0vbdagc1YlL/eZmlnPbPrFuD9QvoPmokT4TKKyuhF/yfHwAlOF9nJzRXRTp7cpzZ7Qoe+cWhRQe43KTbKkAC9WLFL7LBa20wmNEDuz6sD1jMt4kR1ItejdFsJQ6G/RzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858936; c=relaxed/simple;
	bh=EbEBam2DPhvqop6UPMlhU9nHqFEE/WOYvpjAwdknIyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfluEzzW0MY0q+oWfYmdTkn2G1ZHPGvFB/Xby/6t2bNVQOCkW1Yfw45Wh2nq1tbxiqS7f6jwPk9zuRtYwRmPDQouTKwMqIgvB3hJLgnHcw552yOXr/cD34ME0B8DbqcER8lDwmeWN4T/zbqPH1p8wrdKo2Z85fzBRnQG8HIrnIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhYmxRIb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e0f4e3bc59so1110197b3a.0;
        Tue, 13 Feb 2024 13:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707858934; x=1708463734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCH4mpJrtdkHcy5Gp3rBryy4KbkaCk76Oc9ftECoQB0=;
        b=DhYmxRIbs/jntz2S3Ae3CUSlz15TxesZuDK4/slfyrpi/JRnjjG3w5a9srXoyK1vHN
         fZaLxVlHo1IWBHpJrJRamGbxvi/TWIS2t6wuTb2Frlz32LKf3+i1eBZcGFN0Xhl8CbHl
         VqsRigRHYyJljzg6Cbu+ZZoolJ2xEyP7gVntmj6t3fCjwafZWMlAix8W8eK5pIJSrxGi
         JrUgqytQVH+X43jD4Z1f44SC22eVFNaWdywLKOIqsRa1iY1PG76WAOm9mnir/q18/3m0
         hLHse+YSg/+oORMB/ouJIBoBn1yV4wqLLY4cvJcQ9dpOAIjZxu4n/PeVvg86GUA9zJF3
         +zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707858934; x=1708463734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCH4mpJrtdkHcy5Gp3rBryy4KbkaCk76Oc9ftECoQB0=;
        b=Al4ypYcIMX1emtx7kYt/reQ0S5bwVIchNdjiMjW8tU6PjNSLrxeCUUP6ofgpX6/kO8
         7hceitkeB6OhgGJcZAxrj/X6L8rDl8lZMyum6l6LHzJk5+wW1LVvO2xiXf9MsJD8rXS3
         Ki/XN9qrNZ0QxUSf5pB34P/1D+KwFEq2r4SaeDdz1bFzoIXq8K5EE+Ejn/z2UJs8t45R
         q+MWECFi5nHQP1AobM7NDRS66WTULr6zKKT/VZkWv9+pNSuPSAJWhcH176Ad7KoVkkYE
         u6A4oFc3m56Grh+pL1TnVAf2B3sqOt97IEEPlLWIU86T8J3Malhfq06elt33pj4+uQCv
         JYdg==
X-Forwarded-Encrypted: i=1; AJvYcCUQWkZMvHRb7Q87qePKZh09m8dPO9v2B4ZxXbq6fA7ZbQF1n28nSJvht5eotYl4kdYBL7PNj8T1lamSDp2meA1KYgHSxYx6kJYfMJCLwVSptSVJratKjF9oYCIzD80pshIVFmh0
X-Gm-Message-State: AOJu0YzCkvGpyqTPfoOS/kFCgnV//A1U5/YclFsSsChKSJO3YqqHbTzE
	5O8+GABqpv041FxSmnHm1EKUoUqbJxh4cItj04Yav7DQdwIimr+ohc7tJD1faHw=
X-Google-Smtp-Source: AGHT+IGMozuO4ZP0nMkADvUX4ufkSliK3mf9oJHd92aYPZ65CwU4TZenkgsud0N4B7N3eB0WZm8/YA==
X-Received: by 2002:a05:6a00:9381:b0:6dd:da40:948d with SMTP id ka1-20020a056a00938100b006ddda40948dmr545635pfb.25.1707858933002;
        Tue, 13 Feb 2024 13:15:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8XUpZd/YAPzW6iYQ6tCsx5stATh8kC0YbNlBIcaDgobZPKh2cA1T2EG8lJU4QutuO/nhD8Mt+huYQP19ha4iF4sCUIa1Xlk3OLK+/L1lWnEIYGYMinF4+RGT+ET5R/WFU0UVLhCNykVM9GYZTQxOsW/lLeTnER8+pxGr8Upg57yc3JHyA0L279wZCQAAAETRGKSMI2vVFm0NGRR7nuC75FzzXW06J40pM3RYQSrmPRNDohtMPCpe3KWignFkC2t9BKKXt3NG5/YeXa5JJbzUyxpJ6OykYZo7Gyhyrc2GKE7guaafmYRUzXG4+3lrS7r7LnzIQQ6CVnMaxg1U2/xTDkJnoz8abMAUmj/6CgfflwOUQ6ACdpBDV0yms88DVuxEUrUkZBzEBi+bU+DUFMtt6mqf6Sa0Z6CwxaIRf4QC18PiPHuPvFjnW8Nk3IEJBxAfUIANl/zKBRDNz/2kjfPddO9PTtPThK5SQjG5I285XJP/x6WYo6tg1LkNGSOj/6rVqv/9EbJ1K
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q6-20020aa79826000000b006e07eb192ffsm7838008pfl.44.2024.02.13.13.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 13:15:32 -0800 (PST)
Message-ID: <bc81f220-8e88-47f3-b8a0-fc4ea23284df@gmail.com>
Date: Tue, 13 Feb 2024 13:15:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 00/64] 6.1.78-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240213171844.702064831@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240213171844.702064831@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 09:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.78 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.78-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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


