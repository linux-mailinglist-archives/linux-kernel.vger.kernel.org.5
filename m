Return-Path: <linux-kernel+bounces-75741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3229F85EE40
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF787281FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4547B10A1D;
	Thu, 22 Feb 2024 00:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW9KHpML"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B08F5C;
	Thu, 22 Feb 2024 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562699; cv=none; b=Co+m0CfuYLzK8OtF4nynUkV86YEkDlnhltHCtasBRXtQy9Qsx53cDw2b2JnALamoO2D7090UCnpQC121j6HNUpoTHlh6CqIaNXNBtrR9+uOxgzDF6DFW4By6m5LXeDcu3L9A49/Uk3In3mUki3QUsn0J+Q+Y62C7F6CmNFtrrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562699; c=relaxed/simple;
	bh=FTQVWoTN4udNIev/o61f7h3z6g9hy9brkZh6+BJLBuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJnUVoY4oGMxo9Tokw+rlM2My7dAEmgDTpPI4oLOrRsxzFv6ZA/a+tswrdOBUW5cqZzbU6pskTn1K/GNG0N9Ry9XQTMKhLXZ6YLehafFn6ViFAmS6Nz0htLeIstk+yDbMpCaMot9qrBtiN4mH41wgIxQe8I0GQVCSRawOVTMp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW9KHpML; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68fb71fc886so1856176d6.3;
        Wed, 21 Feb 2024 16:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708562697; x=1709167497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p3b/ZWjoEVuTPYpZDzQMf2PYiptTKxj9oR1blBf+Uz0=;
        b=eW9KHpMLDOzWLvQSDZ0/ghz3Ny3Kr7LYEOO3cx/UkWMRM6TXXA7/kgWGWNL4PRLezF
         6uWcubUfjKzM2UlmGjxj8BlYuDECl3a23h/+mPZpuC3gc0Uh6t1SYHVCWNlOSRx+Wz2k
         dRK/jk61DVFRY8k51eOuZZrnZOKJ+KToRxD4ZJWKeVYX+quXaFmgXF0Ct71u17QfprQQ
         3yHETS2DnT/wIfZbUs9hRRxaNpq0Lj7pBsCL+4KZAci6Gil8x/fQ80TT7qovR1pFn4YP
         jnafYsZ4J9HU/tN0G8E4hd73XolwiC6qSWYSg0NUb67e2QNTJuk/9aFd9e6f9ZgNSs5l
         KRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708562697; x=1709167497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3b/ZWjoEVuTPYpZDzQMf2PYiptTKxj9oR1blBf+Uz0=;
        b=xM69Pxnj1FfHsnZ8kLM+gZsUwDLiEjCnCj9vmlTMGgISHOrNb2DYW5Mdm74ooLeV0r
         IXDdR5ul3wlA9xXZ+01txQgsEBmG/Uc2Ujm7/Scg8clcrXyUXfY7EPlk9FELHbmxA1JL
         JjvVC4vyOG94iuL2P7uV9unvNlIObbWYZ+LPnBEhUtOd+pmGEtI7dP/+eDTon7L5yjxq
         HOXVTeWLRImfl3r2DzlpJBTgOZWrbxeoT3iomc9yQjgbWzMK/bHaAMVq5CoXLFSod8Ci
         cvbG4xaeKFPg4RDm/HRzNBeu6S4t5s4eR+0yChJXIXbMIlNgVlAVmJxcCwIfR/DBsVBY
         nbZA==
X-Forwarded-Encrypted: i=1; AJvYcCXLZOk6/lyKZjhaNilV6O1QdtyQjP6CWaCaCBsqEO+ViuWDGPS0uES+cGGivq5psm+dDHkp21Bl28wOdoj7XKBTSlwid1qa1DCue7h8c6ttjKXvIw94QlplbtjCxWqON4qOyzSS
X-Gm-Message-State: AOJu0YymHPhoI1jrrXXU00Kt1dpWMj3SUTHiSOWN+i6iHr1RpRZ+uZEc
	/FnJUY8QFWmvp6+z9bgFhoG9Kd9z/z1jf+VFklgft3umW7C15jVn
X-Google-Smtp-Source: AGHT+IHP7ox0/cmyfpIm9AiYc/3Y4/0B0F+cltZOxZ3nrUw0EDHOpAnz7iXfd2eJAokwNVKN2sNoLA==
X-Received: by 2002:a0c:e0cf:0:b0:68f:601b:9001 with SMTP id x15-20020a0ce0cf000000b0068f601b9001mr2928662qvk.23.1708562697083;
        Wed, 21 Feb 2024 16:44:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s9-20020ad45009000000b0068f11430971sm6107220qvo.35.2024.02.21.16.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 16:44:56 -0800 (PST)
Message-ID: <0bf4806e-0648-4c35-aaa0-7b3f1c177f0d@gmail.com>
Date: Wed, 21 Feb 2024 16:44:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/338] 6.6.18-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com
References: <20240221125953.770767246@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240221125953.770767246@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 05:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 338 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.18-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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


