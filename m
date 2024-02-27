Return-Path: <linux-kernel+bounces-83875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60632869FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832CA1C28915
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB4C4EB43;
	Tue, 27 Feb 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FORBMHc0"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C74F896;
	Tue, 27 Feb 2024 18:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060229; cv=none; b=fHMvjjXL0DPHxmgpUnVQJVk4cHRDXebEAmwiFXUdVgqpv2GPK5nOd94+0BPqwtzLWdhWVFqkg12GsSN3rBGRkptJEgcO/FBJxCPFxk63VkMJxZfqP6ap533Tfcm/FEIY7KGvIs5UTN1i/uOLeb6Oh6NUdRGXqhoN+KUt19ytUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060229; c=relaxed/simple;
	bh=AXBz4kP/7t6J4fXp8ubc/s3JFQXCzQmYnOb11VgiyRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKDCYGDzVcu0NVrc9wZnQT1kSpAlO6sgA6b+Qq3NE2BJfujtt5u8wGclOnmYz781GOEt4U4PfU2Kg9ePkh8E8Nzrkv5y0SYU4AgfXZXcRkHPDdUuaAxCSNSjcggAkgwwVkNTweYbzPDSWMXuLUQ/GheRYgN2MmGwHoSAjYvfvbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FORBMHc0; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42e848fc6f6so17236581cf.2;
        Tue, 27 Feb 2024 10:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709060226; x=1709665026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aofZpK47LiWa/UYtovSsW3ZnP3gthntCOqymhA1/Enw=;
        b=FORBMHc0fkBrzS5Gifyd0/xJAmWGdkfA6qCsYd1zSF3MZ6NoCC9D9+bgUCtt/Hzhnh
         6aiBg9lmvicEUn5lkKR69gsMSr4/zzD9Unau480hoCwJaFMceLT4/84U31OFjE9vfjGa
         BPo3Uc838cSm20FeaD6eAglxq1YklyRZLKSfo3CU1JLutjgY7GiwOhxKAfD/f9/rmSJi
         ina0b4mHQLsHJH/OnoyOjeRilmmVfXcpV4rcH7jHKzhTf6Fp4/3oGm4ImsUeXWT+YDkN
         fazPEoDhDdKsFE8k538jFRzDcWcB76GyqOtdH/Hxu19z44sK4KHRGXl3nVD5qv127rpg
         WTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060226; x=1709665026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aofZpK47LiWa/UYtovSsW3ZnP3gthntCOqymhA1/Enw=;
        b=syzt6AZMt6nup439dcLI4vxuPUByaa6KbAQ+F3++s8Vr8O/fbQ0/A7+L3TFs3dCeyz
         /Z2J8zBS1ay1JH4K/sgkAn7YnIbM9+9c/gml+6QL04DR2IJUDA+fzKnon/fwd6I6MlMT
         5ZM0A9teTibdIouwetRvfbSq/0VE6fwGaOy2RPLhqxZ8NxE8EEtk/PRKYDqJ0+533Zv3
         hrwc7pPc2Os/RGNKXVaFiy9cvDLcPbrQSHdDSg/EXOt29qANAQiEV7E371TTpYVqcHhL
         e8DPzOKSrfJuIU4MYmgkr0pLJjBHFuCfgdKIq8vcVurt5KBRUbUTfmVC4+tohJjZDLb5
         O3jw==
X-Forwarded-Encrypted: i=1; AJvYcCXnQQ6pmwEjfl0aoy1JKTjLoenGBulppsmbxmQLPfgs0nw9GdMF3aMTYjMa5K7h6lWrzJb17Hx5uX4sB2M4jMD+6jEMkQPKBN4WE+I54U6z1zOMdsO2irvprk0u4B/Z9J0SYjyc
X-Gm-Message-State: AOJu0Yw1S6csbOKCqp0mF6Ss+sLlzX72DM5yiI2nPvUrn/u3VQWGgI/7
	/dLuHEghoFV8cKqBw/8/5wpUIANV5seapGF/YDtXQwHSh0kwKSwI
X-Google-Smtp-Source: AGHT+IHCvAE1GdoCqVZ2Blvk+6lIcF6dG122oZ8ChHD6bqcyd2gpEzRHTb+91c1EpoxOktev/F2QMg==
X-Received: by 2002:ac8:4888:0:b0:42e:6eac:12e8 with SMTP id i8-20020ac84888000000b0042e6eac12e8mr11012928qtq.0.1709060225672;
        Tue, 27 Feb 2024 10:57:05 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d20-20020ac851d4000000b0042e0620d2afsm3816973qtn.72.2024.02.27.10.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 10:57:04 -0800 (PST)
Message-ID: <564975c5-3b91-476b-82dd-e1821c25cc0d@gmail.com>
Date: Tue, 27 Feb 2024 10:56:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/122] 5.10.211-rc1 review
Content-Language: en-US
To: =?UTF-8?Q?Daniel_D=C3=ADaz?= <daniel.diaz@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, kuniyu@amazon.com
References: <20240227131558.694096204@linuxfoundation.org>
 <0b1b1523-3f26-4ce3-bdeb-4df3c2a8e685@linaro.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <0b1b1523-3f26-4ce3-bdeb-4df3c2a8e685@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/27/24 10:56, Daniel Díaz wrote:
> Hello!
> 
> On 27/02/24 7:26 a. m., Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 5.10.211 release.
>> There are 122 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.211-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> We're seeing new warnings on 32-bits architectures: Arm, i386, PowerPC, 
> RISC-V and System/390:

Seeing the same thing here.
-- 
Florian


