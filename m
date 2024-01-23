Return-Path: <linux-kernel+bounces-36087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F20839B63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221CD1F2594B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DC23E47F;
	Tue, 23 Jan 2024 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzlnRknR"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD93620F1;
	Tue, 23 Jan 2024 21:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046465; cv=none; b=ULPqh7VL9YM4/mXCv6nJeKzgkQmT/+ghC9OkuSDt38bm2OqFiX+C56onm18Px3gPzyXxajSyBMLL9eG2On0fVdM+srPfjxXjohjdrgLeKC5HZwoSFtLjm4bB9mSfv075Mc3J//UyKWiNPGvqvpEaofoZPJcHz2a7npHU4H2vU2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046465; c=relaxed/simple;
	bh=7E3YVZzzXAbjUcjPgylzTyklVGOBXlBAL15X5b1iNJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngkRm2kDa3g1oHqznT7Bv43lb92PCnMINJoBkgT+WzRr6CDyDBdKhYytzxLRquAQCE4p+LkR/xejjgVuLLxEGkoDwCUBbpHH1/+qCxrPFM5E+gzmkDZKQ3NvUy3r5YNg7vvOOlnUMorcKTKY8kgj4bQLu+rPGiJrBptYe7kys2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzlnRknR; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so4078183a12.1;
        Tue, 23 Jan 2024 13:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046463; x=1706651263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aopPrOg9IfHu/8HlGzikxm2eVGOvpCFKpLoXHZfm0CQ=;
        b=EzlnRknRP1QUfYh0h1bRLEmtiGhzL8e7/oM5rEso/BIlVH57fr7sjorDIEUtHSAFFt
         MBVr0+3/440HgGzS7EOU6MtkmpbNmjxTb7o4vAP142M7RjPiY2yF4cSGOwNBmXAYdJLv
         ARt92ieP9TDlj8SU0Wb6OBJEI2DYUCS4cBpO6MOL8ueEc439r0EIHJ9iKyd9lVMhvSRb
         GP2w4ACsrJmyCbSt7jiijv9VZNmCx/oGawhHg5LiabEZPArnwRs2QEgFi4nSdFx+fu92
         yRWAWP9k1gGU3OAjY+kjbw0U4xFmfRC+eIL+EM6iu/2murYO623L93fXgBccmW69aPsj
         bwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046463; x=1706651263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aopPrOg9IfHu/8HlGzikxm2eVGOvpCFKpLoXHZfm0CQ=;
        b=OwtFTJXX1Xz9Q7xG9fVgdMSnT1XUKJDrI6rYrvkeDfk4DJ1gsAPo4M+7mVsWf2UKhr
         vL548fwvbFwIPwM6LrIZ/s+ZohS1HxZTFw8eSSI5vFejBJn8olQ65lvbsQs+hh0AvBZP
         kkOKBW4vsqYAHuHcoVX9ESDKsxDlkQYFBHZ6wNIpJwKgria4PiTyaJbnEFAz/mJnofQQ
         eFbYCTBVWgcOk586rtyV7gumrYrghQvm+/WKHO2tpk5ZGOyaYZ/YUJsML5VxTYpr6zZD
         OPurNvjBLNtyiCG7u4W1P/tgDzsNsA0VvD4h63UKtjm4zzo0lTAR2Dr1ZuDKWlL+toxK
         znOQ==
X-Gm-Message-State: AOJu0YzSjsJbiF0cA3y9+63DvpInqS26NBO/NL100H2ae3GFFCICjfh5
	4wpB6PK0ALQjBCVkpBGNlRj2JerpykUuD8uee6lDQJmeiEMPZ11d
X-Google-Smtp-Source: AGHT+IGcgc35znDY6cVDFy3PwGVXEd7jCbUBfwp/3XnamNiSfMv+XJTh7GTu/MJKZ8xpoVspgITTZQ==
X-Received: by 2002:a17:90b:1e44:b0:28b:5031:55f6 with SMTP id pi4-20020a17090b1e4400b0028b503155f6mr289155pjb.47.1706046463068;
        Tue, 23 Jan 2024 13:47:43 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id js4-20020a17090b148400b0028e7577015asm820519pjb.0.2024.01.23.13.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 13:47:42 -0800 (PST)
Message-ID: <ff991af0-9e13-4cbf-9223-b49470dc1776@gmail.com>
Date: Tue, 23 Jan 2024 13:47:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/371] 5.15.148-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240123174500.819179356@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240123174500.819179356@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/23/24 09:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.148 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.148-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


