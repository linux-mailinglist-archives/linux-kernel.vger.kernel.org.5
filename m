Return-Path: <linux-kernel+bounces-159336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3128B2D42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81664281F17
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EB3155A43;
	Thu, 25 Apr 2024 22:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCQoLXcj"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716714D71D;
	Thu, 25 Apr 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085184; cv=none; b=i34OddVfIkSGl2yMlOXFxP87IHWXjowX+9bMpo1BVzcpRk2TiamBoJV7ZF5iMzdKxQTdOdi60qh2vfO4kyovb/jMLtjvp1qCloFTVaIVkVsHJqoHLtBGbTaAjQoTQ71FiDoIBnG9vuoW2QI+1Bwh0pIAM3Yl1gfx/M63BhsDTLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085184; c=relaxed/simple;
	bh=Z6nU7lbWOTTN+NCxDdujT3oh3WSOzUSrm6mKzzrFw+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0N2MEtFBmyWrsvivIter71DoIUeg4c5IKeZvFF6nQLKJxcywJ/tRyE4Il8HzFqlxvkAliiiNL6PKUfpTNpUkMTQcvUC2Yl84q6Kz3jaibEnpu5JRrBeG/gRBJi4umxSCy/+gMqUyuK97nOe7NTIjqb48NlM6c5sT38lCLEZBWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bCQoLXcj; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so1509125b3a.0;
        Thu, 25 Apr 2024 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714085182; x=1714689982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PgFJG1Itox1fQPNxhvEkQd/nM/OoaOolYDxHiZpfmkY=;
        b=bCQoLXcjkW6FuCUeaP4S+sDJEciXaK2KTB06LHQVSuCqsu/nk5b4Nfl9sm2E2K1kbJ
         qNNONEON8QlZCbn+aqbj9IahEe6XmuYwPgDxAG/odKfn3XAG9NNGitn00lan4xNH43kg
         gMyjo0O1MkAt1ucZjAMH8iNhf/cRFS/h+zsvMfA4syvN2W6QdiIQv7Scbd72BsHjYRoC
         REtGhqOYK+P/ZMliiPgM+8D6R0ArtoH8S6BJnqbVqUUdcV5yN4WFCJjZHCJn+SUSwc1o
         ndU4VIQVsbkVnNV/Xxu53ID3BrTH/P4amsDdcUBZmO8G50O7u9PKoz6amlL4Gj5vDExi
         fcPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714085182; x=1714689982;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgFJG1Itox1fQPNxhvEkQd/nM/OoaOolYDxHiZpfmkY=;
        b=go6yMijGPpl8fCrrElbNXUnKA93A/Cqa3qL6A8D2+7IeUvo+7FmUh0PtMe6U4qRA/J
         AyGXHRO3CXfKWEX9U1gm0w3kZeO+GrsPSH/cRIlO/VLUVha+NXVd//qEg5zcqzuQzgAS
         J+L1VgPQsMJ9TAo8h/Upe9gExWf82oTPiHwHGY7Y1BP00tBwwKpi90wL9UImA6b+asPl
         OLqKMQ/E0MOSpjB4BepWf3PfEWvi5CDGCf+I1I0B2tQXXv1WQzxiLJVaDUIppXQgAOuf
         IRpApssTfRZnpzpyx2RoN3BPFzzlWuJPIK/avTttvEKIBfH61YNQG9U36so4IN4QT9AI
         SBHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc1WcV3HY7xsDUOLhmlH/wPs6spVbakcrL/feNjwVfgIvNbKMzLq1c+qMoNJwVJMnAm7sfCtvm8uykEGy2jmmreFGAEFlET8yMV62I8IkIzBHE33Iuqfer83gZDok0yHMFOoyH
X-Gm-Message-State: AOJu0Yz+yaLdMuwtR1u2d8I60UBpydslbG7qpsv9ewUEAEJdop4xAD8Y
	dwVfhDre3RZYhDJrQk0o9+4psYp9D3WobmGQSTy/QibbWP/uc3Yl
X-Google-Smtp-Source: AGHT+IFIfNH/jI/8f8S2VlfYkOiJqN4G3ytrJqJwIdUzj+9PDvyLGom2q7RrxrIQgQhrSUMx0Cxo7g==
X-Received: by 2002:a05:6a00:39a0:b0:6ea:8e89:7faf with SMTP id fi32-20020a056a0039a000b006ea8e897fafmr1333246pfb.28.1714085181881;
        Thu, 25 Apr 2024 15:46:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a000b4a00b006e5597994c8sm13703797pfo.5.2024.04.25.15.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 15:46:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aceda6e2-cefb-4146-aef8-ff4bafa56e56@roeck-us.net>
Date: Thu, 25 Apr 2024 15:46:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/476] 5.15.149-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, dianders@google.com, briannorris@google.com,
 momohatt@google.com, Herbert Xu <herbert@gondor.apana.org.au>
References: <20240221130007.738356493@linuxfoundation.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2/21/24 05:00, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.149 release.
> There are 476 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
> 
[ ... ]

> Herbert Xu <herbert@gondor.apana.org.au>
>      crypto: api - Disallow identical driver names
> 

This patch results in a severe performance regression on arm64 systems;
there is more than 50% throughput loss on some sequential read tests.
The problem affects v5.15.y and older kernel branches.

Analysis shows that v5.15.y and older kernel _do_ try to register the same
crypto algorithm twice, once through

  __crypto_register_alg
  crypto_register_alg
  crypto_register_skciphers
  aes_init

and then again through

  __crypto_register_alg
  crypto_register_alg
  crypto_register_skcipher
  simd_skcipher_create_compat
  aes_init

After above patch was applied, the second registration fails, resulting
in the regression.

The problem is not seen in later kernels due to commit 676e508122d9
("crypto: arm64/aes-ce - stop using SIMD helper for skciphers"). Applying this
commit or reverting above commit fixes the regression in v5.15.y and older.

Thanks is due to Momoko Hattori for reporting the problem and finding the
offending patch, Doug Anderson for finding the duplicate registration attempt,
and Brian Norris for finding the fix. I copied them on this e-mail in case
there are further questions.

Thanks,
Guenter


