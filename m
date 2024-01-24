Return-Path: <linux-kernel+bounces-37373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB8883AEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCC61C239E5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE257E768;
	Wed, 24 Jan 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek9qd0CP"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCC7E589;
	Wed, 24 Jan 2024 16:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115598; cv=none; b=cbN73FLPFCtfoWs6QeWc+BHyhIyqE6QDbD76NNq+IPYo0efODsiLh5vnnB3fp0UWUrPLcIUlJRBVwP9rR/AqUDF3jPFhHmQWBt5SCqpFePe8bhCrWe00+vF8hm9/r08B1rdtD6bh3zKwsCLlaDRPXhKjhc5lM7pkuQSIzEejhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115598; c=relaxed/simple;
	bh=6X91lMekL01ZmVivh+brw0rHJYy4siRC8QtoCXyWn8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qD2up0Z5NHw+tmn2UEhRpUiq9MNMBpjxJxU2xgh0IwMvTKFTt8pTCgN/OqdeEcSO3Tz13Uv9UOPRohnhMiLtaEiVQb+NrVfkRsIlZPO+Av3YkvdgdBlvQIso2943LB82covmmVLzb86d/aEU3rVVtUHskuh/aD/UqWVfLm6ClmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek9qd0CP; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d2e022ae0cso1315943241.0;
        Wed, 24 Jan 2024 08:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706115596; x=1706720396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=baC3tSGKJf5L9BsT2VeHElLsHskdvqnXXlzRQDL99Ik=;
        b=Ek9qd0CPl1YLPTnprdJ3j4DODogajFGYsOCggo/QEqeIJVYC5+NBY23Xl4C6x+IPrS
         QrNm0XgQAB07vkhdJB61qCLeheyLLLCpdXmuK0Yt0DJqwklJfFccGVsgwytzt3Xm+yoc
         eDfMKwp9pmr6MoCPHWrauvAbMEcMbAOFXNR7Ahc8B4CI20u9Jggbb2PYuaBqXFEWp+3R
         KLJobqzZTJwYXp5iF3df8uNCrriKeRWArnadYnODIjuq/ktPSqucIu6eW17Kfp7samTP
         OvshEJMfkxKynULlR5FxDd1zOdoMKoG0V1PwwiSxFYceuaUcj8tEJXs80pciXo3HnNpN
         VV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706115596; x=1706720396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=baC3tSGKJf5L9BsT2VeHElLsHskdvqnXXlzRQDL99Ik=;
        b=a4Z+ILWld+kjrejDIwmMHKChs/GXugbqBZuguPU0TsfiALKYt2ThMrTCC53C9nfrz/
         irkBjRGRsXXycbwZyDjf0/ScC/013Xd/dZN9USIaAoeZ/JsLK74rc/l8JxzAVmpHzlb6
         ccRawHXBhG7ebK/tSc96Y/ixX0QFrYvakiJK+CowaV4QWumoWjFsFKY5Z6B3R4BWRzmt
         sEXejOOZ6DD8Qad1R7IYKkqipFY7Zhnb1afZnJAJyTt6UnlzpDBSNeIqGe11c8enVjHe
         XjzE0cO3xCLx9/OSqe3H7HbDs0ZdOKa+94R+ODvv049NJYqW/+Lrd53FAfR43kAaaUnw
         zJNg==
X-Gm-Message-State: AOJu0YxDx+HycIFPsZ4Ngt9XtRNR1UO1CO4tKARB4SNSw3PHDgpj+f3e
	pEMaktxKPCN7oEFjifCdSShku4jmgTNMXGg8VJZatekdmy3e9/sa40spJa1tgYXCx0f4gR/yE1v
	1ppR/l+w0bIl3cwxHYVtal+Yknis=
X-Google-Smtp-Source: AGHT+IHHHg6o4mu6bj9LdU87AIAY7nHHo5ilf8npZvOACFjk+qIgHBs3ZbULRshNxsy6GcbyDklWarcJOMR57UiP0Is=
X-Received: by 2002:a05:6102:2263:b0:468:1cc5:ed88 with SMTP id
 v3-20020a056102226300b004681cc5ed88mr2777853vsd.23.1706115595872; Wed, 24 Jan
 2024 08:59:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123174510.372863442@linuxfoundation.org>
In-Reply-To: <20240123174510.372863442@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 24 Jan 2024 08:59:44 -0800
Message-ID: <CAOMdWSLOLKUA3dnmS5HJ5Z28DcmrFJYqpDKVsNW0MAbis4_j8Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/414] 6.1.75-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.75 release.
> There are 414 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.75-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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

