Return-Path: <linux-kernel+bounces-64489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38076853F18
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11B41F245A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBC1627F2;
	Tue, 13 Feb 2024 22:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0EFbQxh"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64516280B;
	Tue, 13 Feb 2024 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864442; cv=none; b=XrtQ4iXtxFVPFP/iZYegQ0cEOYPaGOj3muswXyEQM/YMuS/Az90Uk1mbLa6LbpayyrNMwcJOruVk0DN+9h8jTVt+NKeYwgENFC4EVSYVbiaD4JHs5MmEVzAziuYZ+Dci1iOSJWqPyyz79i1KHbuAht14by+0qy4RG8vvKDt6puc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864442; c=relaxed/simple;
	bh=eVPe262KL5txyrbYMbLzXbUU9gV7aFN2qZYYl4ixgqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wul6aTVX+ySygFxwOjCS7NU8XcPm5k4meC6xl51jBv6prF0nRWPofvcE4hOV6kqp+9hSdhd/2XZyzh85mR6BXznHeoA08f+fkYXShB2KIbgGSgVvABoDklYI9ygXKuGuXgQ/iafqJ/80hXZ14Dvcb24D48B++GhCAzfTXIPRPOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0EFbQxh; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-46d7a67d751so380912137.2;
        Tue, 13 Feb 2024 14:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707864439; x=1708469239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uZJa89RJq9/rdjHSYfpi6Y6tb6r1nGRmowAt4bkZ1HA=;
        b=M0EFbQxh+GaWMmc+gukPRBZhqZj2qqHCjOhIkAN8oarALHuIFR4hJ7hWCt4r7jfNOh
         wvh1m6gAedsmLcA9XD7tdgBnfvFNXl4bQEp+b6nqWkjMm69BdIgbxm87RaSKJQp6RFqi
         EaLhDw70+KJCWEhts3jLuC4VQr8jjR6QJD+d90O86BJsN8+fi5WB2vVht34ts3dv2WzZ
         dF04S1+FzCzTTqY0nkgRfl6LgE5qD+Jxt1TgE/XM0/LGOr/z/LpnwZW9Q5tSdixC0+Ne
         TM1ljOc+Qkf2Nn62JuoNKjjmTaZXGKN7iLRmhk/nDkeTGirpkf3/ZtV+d8JBKJZd7fuc
         8aCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864439; x=1708469239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZJa89RJq9/rdjHSYfpi6Y6tb6r1nGRmowAt4bkZ1HA=;
        b=v4eqsKjS6TbO4+n3BESDsg5dIuLmV8b4uWQJx4tGoO2pPZ3E1Ex6YtYOqM0LeExP9D
         2qDLiFj7oMDN4+kDfx8L4iGRKZzFU7jrcNLPS0XZHqhmiZAm34eH5NQPyTqrOyyiIBjQ
         DG0kfwnZcynVlzo9SE1U7btXIO0uJ9XZY9q6sLjfI1URJr+wTLGuVcIHZ8fktffj42HN
         Dm4i6YVxzbZ5THF117PJZRZVTATuBebGjzGdcGdQyHOQxSD58wq4qIKUkLEN12NkIaku
         nrwqE+0ZeeFTGj/hVchBKPSU1OjtvN3sKp5Nn1asn4s72RjPjt2fnFjKj5gr4vBFcpJZ
         /Bng==
X-Forwarded-Encrypted: i=1; AJvYcCVtAi2sgnAQ+hkclSecoFxBPrirKaeBdqP8o1bPWmFahJ6sajx8ZYKjT3XQHcNQL20PZWh1JGfuReMhNrkCiBWsYN+ASnF50UEbcfDQ
X-Gm-Message-State: AOJu0Yx16WaCP77+sVXsKEmTUX1rfxFbfQDzN7jGMgZPiqchb941wiHe
	CHlRtt4eaNqLJbEVB4VSj2HV5TlEsupdRaeF13wNHO7Aa0/DVw8Jc6Q2blhTEoiTgGP7HfIM+aM
	mjxbPh7+EDflvkOjmVat0EkJQdr0=
X-Google-Smtp-Source: AGHT+IGA2ihD/EaOdHXgEiURlNYNvqcTKKdt6GmT3qrNYNzY+WvIxYeVQDikGToQCdDavXOeirGl2Dg5u4UhYDldlKk=
X-Received: by 2002:a05:6102:742:b0:46d:1785:426c with SMTP id
 v2-20020a056102074200b0046d1785426cmr1014648vsg.0.1707864439577; Tue, 13 Feb
 2024 14:47:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213171853.722912593@linuxfoundation.org>
In-Reply-To: <20240213171853.722912593@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 13 Feb 2024 14:47:08 -0800
Message-ID: <CAOMdWS+0uKLqpPjJFvk0Dgufq8ih391bpbKzDcyFWt-GL_ib7Q@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/124] 6.7.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.7.5 release.
> There are 124 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 15 Feb 2024 17:18:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
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

