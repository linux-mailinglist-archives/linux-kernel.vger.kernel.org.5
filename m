Return-Path: <linux-kernel+bounces-103759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D2E87C415
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EB91F221E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E4176054;
	Thu, 14 Mar 2024 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2mLZQk1"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63676020;
	Thu, 14 Mar 2024 20:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710447302; cv=none; b=HCvSNihYuFKkapnOgt7p41weYq5drkD2SXUQ2GKoeZjwwqE0//ua2F3gFUD4VsbdZI+E4zBI3lm62Fc2puCkOcvE9OD2NNjjGGgszPin7eB7jfrnNOV+C+YGbChmqLbSfecG3QuFna5mW1ocBFLUuKcP1kr1iInMMJyRVl4pKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710447302; c=relaxed/simple;
	bh=3bd/B+sEv9Pgn5c5mzd8TqZT7Y8Ocb0bR2wJa+MOXWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckWuHySyeISUf2HBGd73QSu+eRat1aCp+7lqBczj4JckPfL6b0tg8lKhYfwdE1NiAr/fjT4ho7Qq1jrOfwwcEDejI6O0L0izRF3jMnXtHjIfp0UcF7uEMbY1Mo7PGbbrLe8VAoF5+XleTnKd0a8z5pgcP+mXNZizp20aWY26Az0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2mLZQk1; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e67451b084so415217a34.2;
        Thu, 14 Mar 2024 13:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710447300; x=1711052100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IeulPNcSkRXqJY+9S20Jxxo8S1uCOYWycOOwWH2YZyQ=;
        b=k2mLZQk1Nb6u0ySVDuSJibDfLd1+IU0nl/H1b2/tvNulZCUbZO1KnJOTBZljsgUC2p
         qBc7sX5TT6MRhDs+OCxk5YXHUGsQKhU2Jh60ylGiaU8vnILwzMZ+cH1/FypIrJJs2Txr
         ZEFYhZit/3pNQNR0hr96ZMYZSX075kM/RMu+eUwdrGVBj1GIUrtztlcaXq6GIkNazAIN
         i2azigITHCmvc+vF09eXkwthjvOykb4jj30iNa+P4hRuqKOIm4/fG4Fs6jcxW/hVX+6p
         YwWfw5IPkyGwJ37Zyx90ArfId2+kfXuZCV0Itcla9Xymxync/nazD0OCIo+EOQv875lo
         87bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710447300; x=1711052100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeulPNcSkRXqJY+9S20Jxxo8S1uCOYWycOOwWH2YZyQ=;
        b=RB8xIdHASrKlXInjOfrAbweZehQlyqIQNn0JJ0nJabCFQQiq6zek6DEtbvmrRLSd6L
         zLfXfjXWPSFmhZf62AHqx6/YNGq5m2/cE9UdiRD4RzjVfJpjBGgKTH7YWUP8B28F8f/v
         8U0Yvm14SUSj2blt+QUtXa+b2yAWZCdxKzansfIYxqDXN1DZW38rrMBOYOZsoGNqnp0d
         jKzTCuR+IIDE+0q3irxGnvVGSakmi9ExAI/f3eyy4v9n3uZw9oWQ6qsa/juG0rGzQVIC
         MzFH2JgyPFGtX446bnedDS2ucgNxcsoAecXT8dhRcyMmWUlHnef/toljAyGNZ6PwsF1c
         5l7w==
X-Forwarded-Encrypted: i=1; AJvYcCUUGXu/nJnUZLuOFDOIjaFjJtwZpG6PHsAvQ4uO8VoS4/mgb2ikIu6+qBQtXQ7fFcWluiDHpXVpoRHi2aE7jwGPPluEk0bQYNXJmj8qhlsPK88mGEUISVOL5/7X6WLRm2qfwDG2
X-Gm-Message-State: AOJu0YxY+DcelQNCk4oiZPBLMsalEPnL5UeolrekLiMR6VxKYBaopZi5
	lPJMDpwARoTMPbXJ7fPqQ1YS6ZvTdPA5JX/2/ycqg/afFUUqu5Um
X-Google-Smtp-Source: AGHT+IGYJJWsNUObgPp0gDufXX5C1OZMOiNNXJE/qZAIbdcx1Dw6aEMp65B8znBRV1uMKroPjd02Lw==
X-Received: by 2002:a05:6830:20d7:b0:6e5:37c:b7fa with SMTP id z23-20020a05683020d700b006e5037cb7famr3034235otq.38.1710447300475;
        Thu, 14 Mar 2024 13:15:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id n9-20020a05620a222900b007884a54ffb1sm1193675qkh.135.2024.03.14.13.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 13:14:59 -0700 (PDT)
Message-ID: <9c9a2853-af5d-4eab-be0f-57b3a7138a9a@gmail.com>
Date: Thu, 14 Mar 2024 13:14:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 00/76] 5.15.152-rc1 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de
References: <20240313164223.615640-1-sashal@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 09:41, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.15.152 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:42:22 PM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.151
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


