Return-Path: <linux-kernel+bounces-45428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B2843061
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B5E286657
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4F97EF01;
	Tue, 30 Jan 2024 22:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOvtW1oa"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439117EEEE;
	Tue, 30 Jan 2024 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706654958; cv=none; b=RjX4ikTXbDYyeU79tDBssHBA0y4fLqm37f3Thsomz5gwMHv6ROhrInDD67Z0iyijqqjvAkVl8Eqdvh+XcvNBYq7SPWZpo8Pib9+dZHp3NxxlaZ/2kdXM3f5ar3n9oPf3idRcBwmh/tgVBiey9+XjzLfc9fBFbFINsKFRjxk3r+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706654958; c=relaxed/simple;
	bh=5PEbedCvlPcPx2iTY5riTWdi4LRY/hHKOrHNlonDI+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgTx1ylJwbG3O/5oLqLD8PhwPaFOST7miqNcqdBKhRSDNCcUvbdQHZOgyOpv6TTZ8byWlM4IJxER2+xxbg0G5SBfdKP44kzKdv5hDtGwW9xH+6ovVz6/y9gm7NgECJh8EyeTig7/JkTGPtMXRppSgYSdLNWoWiJWD0puVbyZidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOvtW1oa; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso2792214a12.3;
        Tue, 30 Jan 2024 14:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706654956; x=1707259756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bq2zWShlBmwvfZivQBNk/q3mwb4pxGumX5VXlkn+VXo=;
        b=kOvtW1oawDr4l76aip3RWBvTDZcK278ujp15UtciV8tpbwhmclC06DE3Hrx6idH533
         MmYlooqe1JoToKjmyKRQ1lnbUVM4KFzhjOKAjZP8zHXzjl2DhSe4VlaQ1Q3MS4RlWFG9
         TmDf/VKJBy0e2/2lopaPWfBM8XX0IGKM7EpGSmpydRgnFMPMzEwmZkzzBeVON+Uo4qZO
         UBX8n7/0kwsYM2kROUqurz3z2nkMGHe6bBGp8V0uzt6JUkWi0GyO/RBN8pvPWtf+sTUE
         W1Os5BmqH6L2B9U7qqzsl48AAgUeVUpcU6ITk1KgQNOF65yvOT+B1Ba2fv/kMpNbx99W
         tSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706654956; x=1707259756;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bq2zWShlBmwvfZivQBNk/q3mwb4pxGumX5VXlkn+VXo=;
        b=AEVi/i/gcTudEXjccqFunyMH7DKcwyWUYBa4NLggSa72i5NVbyYvOiihxnva2jAcxX
         EtR510HOddUapZAsEy3RnZgZw2eGdyHC1DIlHWzPlCGItO0AfFHk45nxI/iI0RQlx3++
         OQN2GU2u8H1s7MhjzX5nHes2lFHU+LkD7ASm/1P7wut0DENbsmaveBEqUr0pHeBk02gp
         qt/Hwn/liXyqqhPddY5bIFVVPvjuXddikMcy7qyWGt5gvufYr6hHg7C6bI5VjTyyfzUu
         JeTQ6ybPRHdnqciudYJvLti9jMd7AyAz6L1DuPyxcb45Rh3BI4vRMYcb0V/2q1oHzgYD
         gnkw==
X-Gm-Message-State: AOJu0Yy5vV0IBwaSZKGrDMA0MwLZLjInJ5xS7Y1lOo7FkHKR/xGq96sr
	xsOucDPCzFsxMfe1atBxrkTkPqEA9cE4s3+WVaavt9ELkigfyZex8yYYGNg3
X-Google-Smtp-Source: AGHT+IE5nbC8dbVwlBAa6gngPdGysmSFzxXCWusY8Ypyqkcrhf5f3HuNcFbRnl7n3o/Ym1zWisMCAA==
X-Received: by 2002:a17:90b:e8a:b0:293:f625:1b0b with SMTP id fv10-20020a17090b0e8a00b00293f6251b0bmr63974pjb.5.1706654956398;
        Tue, 30 Jan 2024 14:49:16 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e16-20020a17090ac21000b00290071b5a93sm1064161pjt.0.2024.01.30.14.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 14:49:15 -0800 (PST)
Message-ID: <f681ef24-b854-40b5-8179-eadf69e63a62@gmail.com>
Date: Tue, 30 Jan 2024 14:49:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/186] 6.1.76-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240130183318.454044155@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240130183318.454044155@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/24 10:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.76 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Feb 2024 18:32:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.76-rc2.gz
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


