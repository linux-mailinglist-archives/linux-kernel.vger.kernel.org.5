Return-Path: <linux-kernel+bounces-137642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D2E89E4E9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E2E1F22904
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4E8158A0F;
	Tue,  9 Apr 2024 21:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQyqMVJc"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0680E158867;
	Tue,  9 Apr 2024 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697919; cv=none; b=Af7Tj40C4NsoLDdGp81jW/ow6wtMNdXxKSUG26DXlGz9q+QUiE1+/QzJWOaIg+3kOcepmfute3aQiFGqT4tflmxf+mT6VCj+jeMFOTRGf5Xf22O1O7rMhNx0tfPR1jIkj9n2CoCKmO7TnJDNbuT9BrGP5Y+ELkB2uWG0dPE70NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697919; c=relaxed/simple;
	bh=42dEATvNCGaUTGUwu8St96PywXvLOsZrMnMM+/SYvYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ax38f/SwJrlUYiPt7iUvn0mlPoBBCSyNuXRMS96qwiMOZW2TUkkg9XKGnfIRLhfQ+VC1rETDlKTafp2Wcf9dUEn3Ibmknb5tN6gG90scwkbBeT/IY9M9vDxyoIT81YSKCx1SUjQ1Yjf/iLXYdX5pXAYovoIgRUeMCQRkRV3+maU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQyqMVJc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecee5c08e6so5687414b3a.3;
        Tue, 09 Apr 2024 14:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712697917; x=1713302717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3GDUApSH/W0nrKfuiCwASLA+8ArtMKKjr3rZqEOBcuA=;
        b=hQyqMVJc3+7x7d1JRkJgd7SS5ZObIy8HvAVOQ2KQTWLFGx2fIB4KahnbvZhdCLI4y0
         nftr+FjEuWt5GLnKxlRnrArMV8uQHff6OtQQyUzh9ZFL6iFDtoHK0NtGCFeuHSWvox4L
         NFudEsCQG5x7wx2LIn3nPK7kvbHntbV03ZPUu5EHuQhICysUgwC8WBxBdJD3tWx68q+2
         0u3BeJ0TWoGgYVRAYH7JzSrcjqrtwqnEXVyxdzcBnRZiqk9r9rb7Ng75VBvDv7po8sB+
         1JkY3x1NHFuzQBJa0QscE76oli5m0Y9s41e7poJ5j3i1Xh+DDjxlvaSBjN81R0/oR5cr
         kHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712697917; x=1713302717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GDUApSH/W0nrKfuiCwASLA+8ArtMKKjr3rZqEOBcuA=;
        b=Q6wZWVJESNWnjPHibWgdbEY0jepyCBfpZjorETdgBjIc1atv4POZg24ILqNVtWB3G0
         g3GyMOA13+l1ozfVoVakdH0TjKXSnZ6f443F+JsAii5q96OwdAoZLygtXP1CTJ0j2C5N
         YrvhM0n+gWm2w5+oPEJgS3RkdH6UWa5sjHtOl6/xVZmXNcAqBVVO7cc4jiyQxeRP7IJi
         ID9C7gGvkCbLva0T57zaHGDsFZV2PLvZoZNgbzw8A/SugW7RZm06v8dKKgRveQz3I//y
         jrbhdCfohiw7UmE4TLl1E9ziR1e7KY6u2IIXa04vAhKsep1n7GEUSjsz+bgt3MEG7Bzz
         PGdw==
X-Forwarded-Encrypted: i=1; AJvYcCWidN02BVrPvmIeqhBLC8Njli4V0gbTC/M6jlJCh62L1C64PQwIPmNOA2HnYWEmxC2/9qbAkE68V9A7V2DL/Y8gFrAKN0vnXLajxvfVHqY+TBIormqsGbGQvvGkIPrbXsZUedPx
X-Gm-Message-State: AOJu0YzW62D9G4jL5Jdb8lxIS1Y16auSmig58TQi+GyOJCdcSrLRqG3r
	JYyU+neetNPDuNoZGzlf/H0jmEYR20vMLU6+d7XJjiIE+CV73pIr
X-Google-Smtp-Source: AGHT+IHqkSAqfWlo2m0ORVhk3eI74/hRph//F8Kawaq/q4MyOq+BQTbRLlD4f636398l8sAuw5mEjw==
X-Received: by 2002:a05:6a00:9397:b0:6e9:74d7:7092 with SMTP id ka23-20020a056a00939700b006e974d77092mr901144pfb.24.1712697917258;
        Tue, 09 Apr 2024 14:25:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id r24-20020aa78b98000000b006ecfb733248sm9128036pfd.13.2024.04.09.14.25.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 14:25:15 -0700 (PDT)
Message-ID: <5e823d29-fa76-4a23-a514-911bb81df241@gmail.com>
Date: Tue, 9 Apr 2024 14:25:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/254] 6.6.26-rc2 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240409172821.820897593@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240409172821.820897593@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 10:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 254 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 Apr 2024 17:27:40 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.26-rc2.gz
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


