Return-Path: <linux-kernel+bounces-44557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8134484242F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B72B23F57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B1467749;
	Tue, 30 Jan 2024 11:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="ItHmt0V5"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4067E67
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615682; cv=none; b=aAHBveF8pLJiFNC8pclVfvgfnFxSlzSQ6FmZ6A8Dwhyf0rqf/vuTwV0jjzp2/9C3ucq5MpSvNiYuU4bzA3xS33oGailn3ak1LNGD11ljf3y+k8lo1D6c/FQb9TBabVq2siTVAaJ5f2VVD0BTL04exDDBr0TlLlssuLzwErahwxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615682; c=relaxed/simple;
	bh=vNdnIux1xX62xc2eKT/WMUKc9JQEqx7tiep7+FUX95I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLMPIgb8DnRg/Z2gJMqMatmJD55cMU7jasz4SZGeW3tQfTeW630NCIhyCBRPxLQ87C7fJsRvWpJO3C5yMhJxXqM0C0rCtkF9gqG+3O2T7/Sj0UFwIeiw2qWTUkifpA5c6EgTkJzOdKFPnzmyjaz5RVjIVFztyla8J/ZgQGSvFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=ItHmt0V5; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29036dc3a63so1964287a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1706615680; x=1707220480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWvxEqM2sAiMA41B2v7Y3h0SQJvpGs9/4DqAKQgags4=;
        b=ItHmt0V5q7JLG9KagljCoZK0mymRJXBl0424EjvO5JWt5Ubif18K182kpm6L4J6uGH
         2dltNAhjmv/P70t/WpIOfq0hWsKp5iR249LfpOz3bPQuZDvGHYzZdtI1eFkvas6FzZEv
         wiPcTsfHK7JTbmk9jJCzsmOF77vgEV1EBiIOlwMXNIWYQclqZbVgXPNliScg8iRa1hbz
         m83HOkioD8LdGD4JFTEugogf0ebWYwffI4tAFU57wWaCDq9G5I0WRxo4owhWx0kigDF/
         s3H9uR5ATp39n/txt9K0npUASQpQw04W4cH4yKJMF3XEkK/QVfIWpFJAA30EdLSvnGXm
         2wpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706615680; x=1707220480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWvxEqM2sAiMA41B2v7Y3h0SQJvpGs9/4DqAKQgags4=;
        b=BPAB+0yLtbVwCLJlTYtHNli9eyeYSg0Onrv+7HWJdDQQy473OQZx7rECugyJPHKkMA
         aveRa+o+gwrULhmaLbeQc0SMIQQBshqYF0uZ7h96Q/J5p3GR4ZbuS/oH86Vi6spmuyZ1
         W+P7TC7nyqWX3zPlbxIpFtrIytE7DkjU+jJM4fEl83c6dI713rgV51+G8SD9/9dxEk8i
         eH6X9JeQDVXoL9baVe5Jh10jJ+wrGmFgrANLSLUk23FeMQIzhfA6OjgWoYy4yaIPw7YT
         AD5FTLi+2wJC8hylDrrAGVLphVeP5N+Tbfavg3OgIsiaQ0edPZ3HcEKFt9tXFOPKwcy4
         MbMw==
X-Gm-Message-State: AOJu0YwJEOGVNqENxZ8C6nkHFyLdKabDHTgxrDHwCfeBONm5CvYqwGUL
	ckDFv1xq6ufNZnjnc4UH/bJ45kOF+NaQb3xkumYKVMV6YewrUVwqShUdookdxhlOZDoaV4b3IdA
	aMLneIdSOYdYKo3w68SYp4dJa4m02ZiRCwvkLkw==
X-Google-Smtp-Source: AGHT+IH9c3sIo7Ld5jc0z4sK97HzRMshtPUDQAZ0vZw+NLsRxgD8BOaqACZQUS5hFwA6GvRwGajwBgs7ZIKruDMHNBQ=
X-Received: by 2002:a17:90a:bb12:b0:290:304f:e651 with SMTP id
 u18-20020a17090abb1200b00290304fe651mr4886258pjr.39.1706615680339; Tue, 30
 Jan 2024 03:54:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129170014.969142961@linuxfoundation.org>
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 30 Jan 2024 20:54:29 +0900
Message-ID: <CAKL4bV6poHN0WqBN7Z=TZ9E3uaLz=h=5Ovn9xHm8y6E-mabKfA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/331] 6.6.15-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Jan 30, 2024 at 2:22=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.15 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.15-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.15-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.15-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Tue Jan 30 20:22:49 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

