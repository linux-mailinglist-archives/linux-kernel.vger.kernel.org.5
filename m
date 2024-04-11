Return-Path: <linux-kernel+bounces-141454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC74C8A1E78
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1823F1C24156
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484BA50278;
	Thu, 11 Apr 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuOoxwwq"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E9C3D0D0;
	Thu, 11 Apr 2024 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858948; cv=none; b=sl9shaenkRu/+Xxm1JrwDXUvZVgwoMT8FFXJckrMeAtF9mhztxLLuUfTbKPkvvdG99C6yG4o920llxIuXlkn/PizsipfQ2M5y8Z6H90bu33LW+fSL8EvGHFeItvsBGkJNnaowlFT0eB9I7VACkt00GzHpP30Rsc2MkGyKYWpOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858948; c=relaxed/simple;
	bh=ONRK5DPl6tc4wVC9RxuPEeSXQSFGntQviOc1GgrtZyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hC05nxp+orm6RKH+umyNeKk23tmiPbYZOlD5rOYmDMtzYVCXmZ7VIWJ69jzZYzNmlpc0u20Tr0k1DkMJkF2biexkR09+K6FVgl/tK3Vlz/DIsn4ZvRDwcKbZd1pAJ0ilIPecdTsRjKOyMR2dRqpfFRdYIcqWfvv6FMG9AX8KFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuOoxwwq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e3ff14f249so860065ad.1;
        Thu, 11 Apr 2024 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712858946; x=1713463746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aW1fSwpFf3nS8PmtpMueULfzNf99ExNq3LAfBfqw9a4=;
        b=MuOoxwwq1nKXFrlA7vgqASuDXRwr0Y1qX3wnQTVaDmmvHLQK1UbFVRbfX2Le7zq3fe
         uT7uE83Zv/fHmpL/YI5bXmoI+0UfFlws6KS3l6uAE79IhGspG8T3HEF/gPr1xrxvMvWa
         vQY7h/oTWbilvNI6acNWuwP3lfvnBZuDUq2hXu8c8Tccm7thnBGtNcBe56BsVaKPwU00
         v0TgPiealqRE5rUne7P6jYV6VtMC6OwcFqXUWXgrpYIdjFGtilc7zZYhKo7Q4kTxNj0x
         VyVOke6emVzrcrEY00vPpu/oooApJorIByFWQ2HB6OjropcIGbc8prf95dCNC1J5B0xi
         xslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858946; x=1713463746;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aW1fSwpFf3nS8PmtpMueULfzNf99ExNq3LAfBfqw9a4=;
        b=WiJrogO+n82yKVkV/e1jGlyLktOYtuoPJ2i7tTRhS2aNfEJnQaOv3ZpGeoNlaXaVzZ
         g4vREieI/9CUFrxSMoZ3eKqxIRRIJHDwKbTtrK1SEa1z3NH72codQDHvz4gb1MbXPZaI
         9tCfIub4qstH5icXRczNqteoDB948gNClwtKXEhOSnBEMD4SQ7UnGBVdr9ClgrT30qDu
         +wJcjYQk8fEKWZ6cFjDj5rDxa7Qhz5MjhHAa0e9Ge3/7egZt8Bx7CrlCiNeUsizcUei2
         EZVNWKdJLbmjmO/15P+XYFbCfUL8aAS9ZPche9yVtk8dmtdg8X3fL9+NevU305S5VNRN
         iZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrhC0I5X6zzLZ+maf05OeRhnIl5rYYQUqfwRgkaFGnkJ0yp+VFf5IvripwVCPF+tCsQbk9qUqWsTWWsNBB+qykP9aDUBhsWXECPwtkINYV0Fl9elJG1grZ7hHB/CqFX4+DGxX7
X-Gm-Message-State: AOJu0YwvPbeaH4VmytzbsrPA02HieyrtC4ukhmH4wfBxLacVcf8bb6E1
	kYZTtyTxt7etJBRjeRuaKISK8TZ1R4N7eoiWvBWFtaeR4CGfUXed
X-Google-Smtp-Source: AGHT+IHVoasH+42WFyT1KotUPe1aBvKRDCaQsY6emb8nFvCsJqJnMKmtJEB0WBmRNP/p7KeZzK5nEg==
X-Received: by 2002:a17:902:f651:b0:1e2:a61e:47fa with SMTP id m17-20020a170902f65100b001e2a61e47famr738899plg.15.1712858946386;
        Thu, 11 Apr 2024 11:09:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k3-20020a170902c40300b001e0afbaf49asm1451945plk.278.2024.04.11.11.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 11:09:04 -0700 (PDT)
Message-ID: <2265b42a-d2f6-46a8-924d-262abb53e3f7@gmail.com>
Date: Thu, 11 Apr 2024 11:09:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/215] 5.4.274-rc1 review
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240411095424.875421572@linuxfoundation.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240411095424.875421572@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 02:53, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.274 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.274-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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


