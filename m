Return-Path: <linux-kernel+bounces-19975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A12538277C5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50725283346
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EE954F8E;
	Mon,  8 Jan 2024 18:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbwm8iGG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546041A8A;
	Mon,  8 Jan 2024 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7831362c9bcso176950785a.1;
        Mon, 08 Jan 2024 10:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704738952; x=1705343752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T93foiordwiOpdmkOjUmX9XqbUurxK9wPfflnhu9UqQ=;
        b=Lbwm8iGGcxyhCTOIMPlqKa/At0g7qM6vq4OY6psWl0++7jnoGMsMK8IQh4h4NF/c8Q
         7RmIxCV0oG0SEIMgqGn1iVxgyFd8IR14M4HByaT5T4nmwgQGi+lwJodaBLEIbj31xkhc
         d47fBgVyVRjBFc3I1X3rGy9ruyhWX3r6ti/zuj/Ope5VNN9Y49a7l8abKrvh9tpfBko4
         4zEUMMMiMywFsg80sY2BfCsT9eJ8pu2Ai/yHGRFtxAT/b5D5C/CFg2+usZvpIQzLWz6L
         UfXLLLahwZXYJJ6hTufkXbtJgNA1/d1M40tWKonoNBdMDTXO+/vEiH5iI6bB0Ppy/KO7
         QPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704738952; x=1705343752;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T93foiordwiOpdmkOjUmX9XqbUurxK9wPfflnhu9UqQ=;
        b=BUuYDw1Dm2Lb6rHKE7EUQQX8nJ3dueCPShmpYM8aKygLRDKSd+sQTC9Su0U4msAcqX
         ZHxeM90FJfsiAjf4ZeZsUyWUnEYtevhzMtFTNGqIsTm0raZX0z73vSzpaNrUZne53CF7
         dqtQFtzin8V75RGvYYjCg2HBUbnN386m1qcPlK9HlneuqLEt29sfcnoWYRyPaH9PgiYt
         nzrwu8laTh7EGWXwhKUbIDrXkv+0aHNHZrpLL8fCZCnx1hDAjxpF4N5kxjOAA+vYsPVl
         npklhmnYM/ULYnwStoAjvcqIMr2UdCDxYzmkOMdRkmAwVdRKeaZ1HLllb7J0h6mbqwmW
         7Y3g==
X-Gm-Message-State: AOJu0YwZu7HuL4dsNn7UX7Pj4XTFgpptfE1c3Y9yFN/8GpZ9oKDYhXiC
	s6kuwp/F+y5oZ0cpc89qQPk=
X-Google-Smtp-Source: AGHT+IFSQ9XY71v02bodO/WFjv5hAgW7/NbDaMC3uP7Ffkxdg86MrH1cwXgASC6B3oqeKAwRHkCLKQ==
X-Received: by 2002:a05:620a:2a03:b0:781:bf72:609e with SMTP id o3-20020a05620a2a0300b00781bf72609emr4171164qkp.90.1704738952367;
        Mon, 08 Jan 2024 10:35:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id q11-20020ae9e40b000000b00781ea9404dfsm99087qkc.90.2024.01.08.10.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 10:35:50 -0800 (PST)
Message-ID: <5d8dcb46-5c59-4b8b-8aef-fb1e5f826aa9@gmail.com>
Date: Mon, 8 Jan 2024 10:35:47 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/150] 6.1.72-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240108153511.214254205@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/24 07:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.72 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 Jan 2024 15:34:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.72-rc1.gz
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


