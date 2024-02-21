Return-Path: <linux-kernel+bounces-75161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4919285E400
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD785B2216E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EEF83A05;
	Wed, 21 Feb 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QO2zwjOH"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4482D9E;
	Wed, 21 Feb 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535126; cv=none; b=OWlE0K3LhLvjiqhtM3yLPK7isfj3onltSnfexwrYLKSgkhbIY6ujVh7AjEZvUYKaM9vvwuv9U/+GqUa/vSGx+x6mDcte1N/kblINiY/X99KD8nIE74nyOuOTgPsadR5KXTtH5EjcROxCeuRItFsHKPIZKmDMIlXKNr4w6EzrUlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535126; c=relaxed/simple;
	bh=2AWOZdlq9d1Ev2hEWqSh3j9LcS9/vxYxTlNEp52OHNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5450Ox3Eh0P7f3QUNdi7JPbwfUgqnrkU77D9GCAnbfhS8L0sQDChhAhlubOJ2yWJ8lOPe4vGnuNKZsay/v3nS9L6y+8NqbKKENwgwZ6unsE3x8hVylwJTjPBTzKcQjNdB9zLVDIlvtI4XySl+3loWTUcYK2YiOOhfTKSE9LY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QO2zwjOH; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3c03d6e5e56so6670339b6e.1;
        Wed, 21 Feb 2024 09:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708535124; x=1709139924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NK0pwsoq+YKtjhn57MpnM34e2fssw5x7LbdgD5uuZIU=;
        b=QO2zwjOHrOEhHryoHmmnyzczlhsBX9Rx+DTdKAflFUu4Zml+FfYclY7fQ5et+ObNXI
         UTclYLBLdxwK4F+2xs0vEvnLVGoHw9DlAcyvs8NrYerfx+q8nGOgfavIqw3NmVQ0o7Gk
         VkW06nFTqB+++ObxVyxXaNQgx6T0l4DZUZO5b8tDHm9zl4CLfVr40tNjOnd0RzRWKi7t
         8HY8eGV1WFfo1RGUVlylbByM6bw8sIJ2DdjU2uCv6s8T9wrB6P4Z751wLTqvY97pqNNW
         dzjMQIiCVrr1x115adeBS8AdR4KHcpkaeqyZ8QlelS6WHO2sItR9Y7TjOIy3hBN221G9
         Cpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708535124; x=1709139924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NK0pwsoq+YKtjhn57MpnM34e2fssw5x7LbdgD5uuZIU=;
        b=i5wFtEz2rkflpAucmIGKCyrJlAd6qWUsHFcc+68qXnmzp+QzdbpocxqSJ/b97wwIXv
         AT9XgjiwxWLru53V3bGXFaT6fzg7y3oGcwbsA0kaG/bau89J5x1yg9x8oCx7gCdUYK2e
         +mhGQLQCEsisHr6GkuyW76i6/0bA2yPNvFXzzIrMqwN3PzdXIY4QJUHb+lJSDdnfqe8b
         Ey4AJXIWu5lzf0b3loYsUzKJ0smK4BkMD2uFJmS7RWWEPvr/9jc9yxEvO2cURcol374b
         hq+u3nnc1kW+D1D07cVOgZaIkb3eSeoHRGJ6Gwm47Jrz+vddbByAP4j9Bjp6GB6CEjQj
         sO4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWK7QU7W4L4Q5KR1bK1B34eApCHhBiSBc/d2lIhdpubePr8d5uNAcM80TyIbkdEVyxO5oKoq53+pAHEQeZkOMpbIY6ebK816Ad3ppd+
X-Gm-Message-State: AOJu0Ywp2mkD+pkietcsRxrDAMBgyvIk7P4nOho207wptvp3a5rc2uZ0
	P2XLn5SIbKrc0iGrlipqZeKgsiQH9duMttA/cAzT1KsqQs0CjX8o/r5TF883rGjtOvAdzq7qQ/F
	s7FxK4ioy/15MpByo3CvDcYsi7RSbGDBUf7I=
X-Google-Smtp-Source: AGHT+IE8UlrnQBXD5zkp8qRzHhiO5bB30V3fME3fGKOe7wgnbi1im4ppnXqbzyg9qNLuSfqQJ1/RGwoRwcVUiiHXX9s=
X-Received: by 2002:a05:6808:f09:b0:3c1:4ba0:b8d1 with SMTP id
 m9-20020a0568080f0900b003c14ba0b8d1mr16067249oiw.44.1708535124189; Wed, 21
 Feb 2024 09:05:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125953.770767246@linuxfoundation.org>
In-Reply-To: <20240221125953.770767246@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 21 Feb 2024 09:05:11 -0800
Message-ID: <CAOMdWSJofuZeb4tm7jVQ3kQvuaR2zZQ=NeCtJyEPq9-NAuDnTg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/338] 6.6.18-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> This is the start of the stable review cycle for the 6.6.18 release.
> There are 338 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.18-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

