Return-Path: <linux-kernel+bounces-127065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 920EA89465F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 475F71F21EBE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF05954780;
	Mon,  1 Apr 2024 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdeWZ+bE"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF8537F7;
	Mon,  1 Apr 2024 21:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005364; cv=none; b=pXvAwdMEqJF10oGCPgys626MC90AmdhrEbAE50GCo5iqwBwSL5EJ70M08K/5R/89f0kIYtgNXCbPAX4WUP6NRi45/BcG89SRwh5OLtUQ1X22p+9PCKVlvuJd4Kk0sQi4bMx+BcJluuJiBtOI8YckKTnKbtKutLXQmLnYCYubWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005364; c=relaxed/simple;
	bh=L8Wh/UZ8fV0rI4LaC6zoFQSLl3ZeuehQjPS9Zvohfo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gV2Jo/ftPDndZDkDrKSULvbhWP8PrZzZ+lit6DgQIFwHkj3EddCr0Xvkl5IATv8nzPXmYAeVvEXlF6p2wO8OpFqZfRoEL8GtVkVYAo36dnzsLJl8rcdxbGLUtf39aVtJp+Zf4Qqugs+Kdh5fRGizsyM4K7vQ9XNJjVQDNsTfYGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdeWZ+bE; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-432fa3f6847so4990901cf.2;
        Mon, 01 Apr 2024 14:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712005361; x=1712610161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=60igiFkekBblK0WjIxOCyw4MGpCAlBwmaansRQJCJfQ=;
        b=SdeWZ+bEVBtY2JvvUOv5fsTV7FGJtznmxHX890TB2QDemA/43wYN+zCXvsS4L6aflo
         k8nvOqHn5hLsLe0Lw0d03lvTxJWMyI6zdnpQQ0JIdESKzYDp/sTAcktJHQShqM/uBxT4
         TcMQ1C8Ucrksts1YJh4iwZvAFxiPkDazgvBmCSaDH8EQ7dgYAzbL0jcN6EEgsRyUnQC/
         34+fc84/N0RgPUsmni2cOUwOCZyss3KwoE48uPTtzODWPPrkvkp+Fcoin8GeZyEiphSS
         PCDTqJYXsTVGqVDExwr7sFsca0LCtn81hrxOB5Pblg2pqOWuns5BHSPCPNv2i7rFkuxS
         d/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712005361; x=1712610161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=60igiFkekBblK0WjIxOCyw4MGpCAlBwmaansRQJCJfQ=;
        b=FdqA7tiwWHfT+kmCKv3jUpaKDlL4C50ENi/z8QuC1S094dbBvqd1Se/rUZ3rqyAYIn
         J1t/2lO4C6Mm3HDBGjKuI+cgLRjoVe10HKZ9fzL1senoy5lXbXSceCWJl5I5Jr7M42Ic
         bpB3dgI+ZOb1gAH7o+3FT/YJS/eyU9GGjbJmxhprA2cIitUfZQtoHGRP0+LGdflMvHL/
         bvCNQhNmkR9g8y10sFEQuV5By1Xgjhw7BRmdURfNa/q3kx8g0ARQzXBpi3IprTouYlZo
         KolGwhnIEHAwDrD+oBBsz5LMz6S9aOzrPLcuajIatZmYYI7hTIhtDUhu49tcvtTrnM2W
         XBkA==
X-Forwarded-Encrypted: i=1; AJvYcCUmHyvdlwPOm2Kdh+BZHDQZn0KZxa5a+ICojAtLiBD8RW+/vGRCBZQRzwt108/kQuQsc1AEvH6p8+sBQSITvMDgePc2xEREAVLfRqfQRQqn/SUkurzco0HOwkFcCsohhB7vWbAD
X-Gm-Message-State: AOJu0YxNRSWgZuITYQlfxa4mux8LWOkaeTH2lPxPBN3BXKP9wT8y8uXQ
	3wlt93ZlZlnx74dqV2zM7hL6jvA/O5LXvNdcOh2xRAaRmxjCTT97
X-Google-Smtp-Source: AGHT+IGpDjLzeopBVCUJQnng+B1vb/J3Iy4vxL/xCJnbz8Jocgm1bLV/RcsWP0pI82/ZLssPhN4hgw==
X-Received: by 2002:a05:622a:351:b0:432:edf1:2e31 with SMTP id r17-20020a05622a035100b00432edf12e31mr5575749qtw.61.1712005361600;
        Mon, 01 Apr 2024 14:02:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ex9-20020a05622a518900b00432b5c9b9ecsm4745631qtb.14.2024.04.01.14.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 14:02:40 -0700 (PDT)
Message-ID: <78f8f918-5912-43f1-a01f-99060512b87f@gmail.com>
Date: Mon, 1 Apr 2024 14:02:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.8 000/399] 6.8.3-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240401152549.131030308@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/24 08:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.3 release.
> There are 399 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
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


