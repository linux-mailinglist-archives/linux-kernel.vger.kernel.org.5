Return-Path: <linux-kernel+bounces-164625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF88B8048
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DD31F23ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCA4194C8B;
	Tue, 30 Apr 2024 19:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVPagNXk"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AC8184122;
	Tue, 30 Apr 2024 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714503939; cv=none; b=hTFq6cj/Npnu+KjGZRt5yEU2YFI+E0dDoNsEFsVQgEtaZN9zfOQCw+bqOkJ50K98/uXGHu3XhT4SbIlT4T4cDJFYI2mEDSJPutQhh6ZUB1Ifg4J1yvEwI06IbS+h/cc/hBC5tv00bmYDQy7qUsqwMUn8MdxuQHbYdyovs0fp0TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714503939; c=relaxed/simple;
	bh=WB+cFY/Oo6dEPImnjyMRPDI5dtWUaU17g78MOKNedr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5RRYs8BN+82i2CNzkQL962hMt9Hjw8YV91p0RUyzXrV0npOWKReEnFMmaDliIQN1xhFwzmugXNZydcHYVxmWE/m1R2kwjSYoMZVoWoWPXAozzzX2lm7wu4z97TxB3BwySXx7i0E4cUFr1zGWlKpGllOYSK1d9VeNQi2U6YT4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVPagNXk; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-437c32af2efso38196751cf.3;
        Tue, 30 Apr 2024 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714503937; x=1715108737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBkZM5+/yCa0yNBxYsm6HArSk5dGVdMk10zv37GIXdQ=;
        b=SVPagNXkCXdEOHefoViOEfpsXQa1IkMXpgOJZSU/Ff2ptj1egZK4BadgnegSc4h9dj
         9St5tsCahaLQgJta7Jr+LdLrpHK5rbnXjtuUfBnohrL6y0Fy6AYHBnnDHHu6TwhCk3Sb
         APQGrJvtB2jlfECu/idsed3TJgEQglQ3xQV8M1tOnmlDAJ4Chn1hybI2+9sYdxj1j+uD
         CEdoAyYcVpNLaVBd4vaJJuzc3QTRzcMQ2s10uA1qeFsseZpAhnpQ0+s9sw3d2IRYwYE+
         BJuIvfhp4U/mCmuyqCpks/9agImqsDTyWVtQ6ex7m3PEYw7fiCYP3gIjr7OdzcbOomPy
         jQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714503937; x=1715108737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBkZM5+/yCa0yNBxYsm6HArSk5dGVdMk10zv37GIXdQ=;
        b=sYmnqv1KbBah/WFkmyF9UmiLsrJTveEFdztL1ZwCrGiXZ1YtfHj1IDhFnkj6mu2KaI
         +a8FhEygMIS3FmbIh148V7bnby+Ufo+w9yjmJhiHJFIfZ3q413H0GwhcA2EAIFmRfH36
         YX4VfwDi0/gANTygFYPdMYFg1df+U95QLXwpY0euvXwFVYrs7oyX69e+O1qNWj+RD62r
         2LoDMu8FEBcXWC5SIP5H1jBPCqEcyOFv8M8TZOsBZijkGceTwOKSf17ZAuDjy3e9HEFI
         vPi/Nwx7HMIMC9g5nAjp0OOMUzvhNGp07Fh8kculzFqQFqDaeRKxtXUeMJZA50jqZnOb
         HVrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUikCiacWsVaVzrQW3pX1jl6xP2XhJ2/fk4NteKWgODTwFHOq9SYMEJ47No5I9Glg9cQMXR055EPnWJOx056n0l9zTPw/1Eg1ItOoFUMQmm/32F+P7oJBNWL2szEIY5OVl+WDWn
X-Gm-Message-State: AOJu0YzackMWugFowUm503ba2+LSTOVmS9pq2XB9GD2jAmoMy2abr7nk
	sFbZOjwWEL26sPuP2trDpI7FnzrnQ6UzuSGESbWiyCTpBCjJAc0N
X-Google-Smtp-Source: AGHT+IEvDIWbNjqKzq2B17rnkN0GdCNyXVkqotY2iwNIEhZVicQbuQlmJyxW2//UeBAFqzO63nGCjA==
X-Received: by 2002:a05:622a:5488:b0:437:bf2f:9bcb with SMTP id ep8-20020a05622a548800b00437bf2f9bcbmr234769qtb.22.1714503936832;
        Tue, 30 Apr 2024 12:05:36 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id o24-20020ac86998000000b00437acb8a6basm11199685qtq.6.2024.04.30.12.05.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 12:05:35 -0700 (PDT)
Message-ID: <a7fd3dcc-2831-4b0b-90bb-1855bf2bc7eb@gmail.com>
Date: Tue, 30 Apr 2024 12:05:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/110] 6.1.90-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240430103047.561802595@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 03:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.90 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.90-rc1.gz
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


