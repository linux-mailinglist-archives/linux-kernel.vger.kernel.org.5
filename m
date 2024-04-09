Return-Path: <linux-kernel+bounces-136736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFCD89D7BC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98C37283925
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34E9127B7B;
	Tue,  9 Apr 2024 11:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="1Jkrsrvy"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B5D86130
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661580; cv=none; b=Tswg7fM/NphN8eYEGgynq8Rl36CnL9vACUBnedk3P61LomKso1a4IcpW92I9Aeqqq20nCI0RuTOoLOwVB83g/fYIHOpe0EsYEHXBfFOaenuo5iPlwIGK5NG0gF1bYrWPreiWbk+fbLl1X46DJ8tx0Wwn6XBNHuhSQFC9TDsG0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661580; c=relaxed/simple;
	bh=T2ZN1fcFBKzVjK4bQW41mMKN3tCyZQojwExRN2pmPi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOnQGRXRv63XHkthprpTq9Co1KAa7v1Xnr73iL8Aq2+9pdW4M2Lm4CpyfmE46stgk39wXSdph/Is52J3k5auJ00+0QAIIxcOJVbStN3/k6q3IJpUNAcvsNoVIOi6OCwLfv2orBZlU9U3efRI6bxBNSSZv/VTKXS49it01AfOHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=1Jkrsrvy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed627829e6so1251279b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1712661578; x=1713266378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKGPr03TnWQbKb2+d6UQO6L19uRixEs4WkWvOdztkEU=;
        b=1JkrsrvyWzLEjR63ZG+manb0L/MuP19jWbXhG+MjR5jdSIgcENODtTOBx4WXsFmTtQ
         eJ7GoTgSJRui/mK6g/DR7M3QIvlOckXuCvxLGva/8fgqx2M7AAkbcNRFwZ3AZN/mHaML
         bokNcJXx4OQ61s37TOCKsG3Kk4oXgXR0DhmRCK1z1GmPT7Z0o5bwIGDsE5fr+4EuOo2m
         0G5uRIYqPI4mxHCDS03JQt11ZqLZ5ZcNVGnVHQ5XwflUKD6pujoI1t7DftLrBK6Yb5gh
         PI7Ej20WDKkwPFSdVL5665lI5+hKA/A77FOzGbsnf+LunPvfTFOBvwma5sZBtaskevmv
         Iovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712661578; x=1713266378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKGPr03TnWQbKb2+d6UQO6L19uRixEs4WkWvOdztkEU=;
        b=pa+Kdk1BYPsovmOSOzBO2mqBSE5rC2aHk45z3zmFORAmv9zc/k/1qNaZ9G9r3g3h0w
         eXYn3cdYJitGLyoB/5gs/d/PPJoI0wUAaOYLeldthcka85Y2cFFxHJsVDNiQH4BOTzFQ
         4ByILHV26eQ5gamgcpEf/FfOSZ3bdMEaOuUmhcQjTEuINzxdwt9moAL00TCVH9GCmfja
         y2HH2pkxd0msNbDDIU3CWFJEQPDoURa5kPB4uIvE5uCZXSIpcgwzBVzNg3JvXgPvCw4y
         C6uiStv1JIF6khhz3o8j0zKEfLDORiGXKlPMmQbPeXHFJHqBMLlaY/FZhp5VNaBLnZ1D
         S7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJidKgMQizM4Jeo2GbeWmE2phARVFSU5iKkFsfTSDds2qowuyR4fA0DaWzGvbslh9v4nMGnAA46TEI7wVmCFh0xY8XcVnYT2XdDZ5d
X-Gm-Message-State: AOJu0Yyz+vR4W16QsCn9KpJ7y73z4Uyq/YDDkLOoMXVCCrw7kr5bVeBB
	6kRrP/Kca9SpGMIN+frygBtR03m+YuuklfcWIoZQ4Z6wCuGkx6WIKjZptL7hhMEfc3BgPB7K5v3
	l+twLbrxf3kaH7G54YTDonPkMs1Sp8RXsFvuC2A==
X-Google-Smtp-Source: AGHT+IFYVza6STxF9UXGu/0jGiQJfaimoc1s/2/nhDZ7qqm817g4DPhfwqBgbtR8wIeNhe4Qttdd+G+PzX658TMBJUo=
X-Received: by 2002:a05:6a20:da95:b0:1a7:a86a:113a with SMTP id
 iy21-20020a056a20da9500b001a7a86a113amr1813290pzb.6.1712661577550; Tue, 09
 Apr 2024 04:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125306.643546457@linuxfoundation.org>
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 9 Apr 2024 20:19:26 +0900
Message-ID: <CAKL4bV6ANTv+DwtQAjQYFW+9d4Ur_yk_xdm_PQ2HQiZW+vbjdg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/252] 6.6.26-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Mon, Apr 8, 2024 at 10:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.26 release.
> There are 252 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.26-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.26-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.26-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue Apr  9 18:54:11 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

