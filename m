Return-Path: <linux-kernel+bounces-116736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3505D88A31A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE76C1F3CB7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B51113CFB6;
	Mon, 25 Mar 2024 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5w5+4O5"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F553171085
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357839; cv=none; b=iWaGN7aY4OeQhvw8+W49Jtw/JfzcEsAot3nDbY3qzYg3PLrO9dVrEq1VsjJg2aHb/N9JoY9Hf2NbNmwFFq5FKoiDaNpuHniTYZjk+meZTP+bWRreLRY9DKCcdkl+IRHrQynEB+ZHm9BGSpujwB1o4A5lM++SLaL0VBT4MrPiUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357839; c=relaxed/simple;
	bh=4g9y7fWZZhKWcfjGK7AMAe4W9UEiPvX33kC4Qx/w7GI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3s9Eg4Y1MUHWwuLJLVcvXzBSZ160L1EDIDX/RvQK2VzmX96im61q13gn8v0iFKzHUWOol37FPFCBb9kql+Am0kSjoER93gl7MsL1a3s955m4/u6C7qYqjvMKa7NSskF+YaOwb64VfoHeS3qCCi2rG1p7AECKSeNpM7b45Aj6NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S5w5+4O5; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-47603a066daso1341708137.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711357836; x=1711962636; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gWKcgBymVfcMGzSPm2nkofpFZCVMFh18a6+Ovp4P0c0=;
        b=S5w5+4O50/Ud1LzT9ztDJFEquObFK0K42w+4TkaW1obVCz03NeGnNHVfxiG7Pq5MiL
         Jg734gNbVvFzLz3IJwUeE3L9A0OcLH2T7pPA/wqwDD8AGJ/qDDz0i8Galv0D1XkNAvQR
         jvvVfWs2Vccu52HQsekbbj5o1pbw6/r4htV3x1o0Jm0AcsHOfGqsCJC7NV7jFBJaPUrj
         lbuNC8zOjqYMqlPrysXNkEbjAbz7p+LOvLXDOqxoxHJuCXAQF/uRVwr/VseRFPPoumBH
         PGTFglivW3zMsJpVpL0YGCK5P6Ohg0g4Y+dSAr/UsUI8GUQskfLIed66hhFi8qnGkxUj
         9jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711357836; x=1711962636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWKcgBymVfcMGzSPm2nkofpFZCVMFh18a6+Ovp4P0c0=;
        b=P8t0ip/mseI6FZja3QzldhMQ5jOTKC1xDt2RobLtYiZstzjZsTgpASDznOJ2ycBfoH
         JGnZet8JgyCgpl/js1bIS4jPl33kSXRh0gh/j8YyEikvusoNXKWgqzFDi6tOxKoGHZID
         zDqFdPeOekeOr35k3/Y0F+dAQrTY6dKq936v7PSIQ+mDcj6xfqQTq6M/iLLTWbC+EWoz
         aVSjKzJL+Nbbrpq3N5Ab5wsUqvsqorWb2bi0zaM64OkUWcF7VMUlpuAx1TlrI1aeOIFX
         6CMZdGHM7PyBWT5HtEe9Xd2XkGJOoUfLolu4OgDQ+noENdbtn3pFRQPXkjWoeIh60uFm
         6gPA==
X-Gm-Message-State: AOJu0YwG+JCGmP2gmBzFpesapZpyPxrZUhC2pDB8o3X5DzOYvoFAuLf0
	reNd26XuaiRd9yxekui+5tcxTihvGM4OaCUAN5SuJ74kqt7dCWcE5W70vnLKD6kBj9xYHm4P2X8
	FDEw3FnqavHOtmF/nu+a+Hhjo7aFQovGUkKkW4g==
X-Google-Smtp-Source: AGHT+IG0YZib+WB/NMmxynOCM60coYyDxh5w6Q78maFdEwJWHWlRmqdd5blGlH9z7xzmvrRh5ffusZFxKDkeqsjx6EM=
X-Received: by 2002:a05:6102:3592:b0:476:c65b:10a1 with SMTP id
 h18-20020a056102359200b00476c65b10a1mr5149223vsu.2.1711357836117; Mon, 25 Mar
 2024 02:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324233458.1352854-1-sashal@kernel.org>
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 14:40:24 +0530
Message-ID: <CA+G9fYvzw6_Rp-hH2f=S-xVT-TM8waqJ0F5Fg607YZqcGNYh-Q@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/317] 5.15.153-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, 
	Anastasia Belova <abelova@astralinux.ru>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 05:05, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 5.15.153 release.
> There are 317 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 11:34:43 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.152
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

The regression detected while building allmodconfig builds with
gcc-12 and clang-17 failed on all the architectures.

> Anastasia Belova (1):
>   cpufreq: brcmstb-avs-cpufreq: add check for cpufreq_cpu_get's return
>     value

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
------------
drivers/cpufreq/brcmstb-avs-cpufreq.c: In function 'brcm_avs_cpufreq_get':
drivers/cpufreq/brcmstb-avs-cpufreq.c:486:9: error: ISO C90 forbids
mixed declarations and code [-Werror=declaration-after-statement]
  486 |         struct private_data *priv = policy->driver_data;
      |         ^~~~~~
cc1: all warnings being treated as errors


Steps to reproduce:
 # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-12
--kconfig allmodconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.152-317-g6f6f22f11928/testrun/23155933/suite/build/test/gcc-12-allmodconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.152-317-g6f6f22f11928/testrun/23155933/suite/build/test/gcc-12-allmodconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.152-317-g6f6f22f11928/testrun/23155933/suite/build/test/gcc-12-allmodconfig/history/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eAPAG6nyiRjJbnJJ0JGiVy4otR/

--
Linaro LKFT
https://lkft.linaro.org

