Return-Path: <linux-kernel+bounces-157317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E48228B0FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6567C1F2657B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0AE165FB3;
	Wed, 24 Apr 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXjElKKt"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D86161911;
	Wed, 24 Apr 2024 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976020; cv=none; b=tcVE/p7cWCrfZo9U92owu69PVBvOpzjqhMQOD6+hYqP6FPLzMO3KizVZsmlVRxQiRhV2XNLNjGJNuEvLA7BG5H2s7UTtdXVzCqF4jyWCuXsIbnubQeGEz0tpV4+VHvGMROOp9EzOyQ3avDplnG0Fu8NDiUJu3FWAmUZkH/5MS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976020; c=relaxed/simple;
	bh=MrekQsd6OaTvzphSNX4kb5YxwQEH0aINbyb83pngJpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KYWBqx6zyRapqTMvd+3sEO1nWHjirX+/RrrqZwXqEor0Uck5bMLJXMvmqfu67XL7V/6S22z2RS/3QINyeQZpT8/uQHbn+B/4wzwQxzjNjNUp/VsiXaM9E2mQQM86YvVw6gyDCUz1Mz8i1CbcXIzU990E86H5KS7M44bef80sV80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXjElKKt; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-790605809cbso393818185a.3;
        Wed, 24 Apr 2024 09:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713976018; x=1714580818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=re1VA/XQsH0motUnZZSRX7lW+nnZ1gYeiybIgvu9m1o=;
        b=cXjElKKt61psJ/ALh931FrU0WSmdP0NeZpBJz4Koog2AUdo2c1wYZWt1d4aMtmtmkA
         qmKUzJGSW3R4sBuZ6zo6q0CZcbzezHu7wj2wLzmbRATuvxWXE/6fwU2JeSIJyo4jJH92
         kgXVhTJKqIBv9pBJCFfh1eAbfVU0S3wmksAjo/HPOZ/WFmq/GK/lp+kFBF+YPZpA083Z
         Y8/BDmV5nbB4cv1nztZZmzAlJL0JXJy2GhJjDnzukeRTaZ0TWjT7vH/o/6E20OysGNeL
         iG7wAMmSAsp2lfMq9Iz5RZhHpLPuDkdmF3nsw6zI9K3CkEb5SysP5qh5ixBzzK6PBG2Z
         mm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713976018; x=1714580818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=re1VA/XQsH0motUnZZSRX7lW+nnZ1gYeiybIgvu9m1o=;
        b=pHKbEpKnF2I0DfnS81XI4GDStMTMKCy23HZ5CFxwhovCyHIWi3t2l6zEXHqGr3WmRS
         r3SG8VoGl56tGaElx3LZzv9NASeDwXTvrCg0MXzsRJp9BbyQuBsysvi0uxKPHVi+eoFT
         pDcfWrsWgpFMLJ4zWdn336xXtWF7K8911EgR8IDBtguI3qkIwD3SabGMCeN1QDiJp+zk
         ffSf90euepo/3bvFwTL3iU0DNC9nS1P5a1X1eYS6sxxILRV03ryXJ7WB0N2qoUF73vBZ
         8WYAqpqdF5Sa+cmQ+HLh8MIIh2UvH5qkAm/ZxaZsKI8euiHTXfi9zSx/EPIGRyxrzbtT
         Ih3A==
X-Forwarded-Encrypted: i=1; AJvYcCUCysQfum2N3lvP4T3X0jTn/fR3F1BvcPuWT060jbfx1pNrSmP69jxYP2sJOHwjFFGi7UlV1DmEMou6S+D1cx4nUhZ1Shnp9oGL2xkqTu6lcPQ7ddeReJJzGeocMd4bdx56CAZf
X-Gm-Message-State: AOJu0YygWkMDdPPDsUKXb5us+/jseCDVFf1yUk9+8rpoZXJv6QbsXZvZ
	69AtopV+aGf0uc74HJyYE2ZQsLc3fLf3Nz3k3QcGXclKVxFTDb3D
X-Google-Smtp-Source: AGHT+IFM6NLmoPFoH6FJDBLabYzNV7CTdH+SzP4ipMiUJV0Fnx0XZAUUqt01+8Hm5ti+FGIm3K2t2A==
X-Received: by 2002:ae9:f714:0:b0:790:9792:ccf9 with SMTP id s20-20020ae9f714000000b007909792ccf9mr97187qkg.26.1713976018075;
        Wed, 24 Apr 2024 09:26:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id y16-20020a37e310000000b0078d5fdc929fsm6230425qki.104.2024.04.24.09.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 09:26:57 -0700 (PDT)
Message-ID: <0886a749-c834-4f52-a25d-fc700dc26334@gmail.com>
Date: Wed, 24 Apr 2024 09:26:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/141] 6.1.88-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240423213853.356988651@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/24 14:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.88 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.88-rc1.gz
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


