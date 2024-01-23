Return-Path: <linux-kernel+bounces-35775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63A0839656
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA8C288954
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DAE80027;
	Tue, 23 Jan 2024 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChNhpYMJ"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919A07FBCA;
	Tue, 23 Jan 2024 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706030733; cv=none; b=SORqBRJnVPfUfqRBRYFWyJhHtt8kQ8p2594Sc5im/r1mKBa8/hs8X6uoiTTblr2b2sE5ya/IN867FNlQSRuWPq8pLgmTDlJYljeniz5zYHRS4zKLpft1F3Krpwkp93Hz1yvT2NFPew/UTjTLNd2QuEtFgeltQNzrCf+vPuoHHMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706030733; c=relaxed/simple;
	bh=DN4WENUc4MsSSYl06gk8TP+YIxrGOlef2AHZVAyLDnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozXEsJ5M/Iw3EZYCI3Rpl1W1pcRYFoB9e0okYs5JAU+IgW+CAv17lEYU6rA8rZCizH8ZKr1sITatl/unOIihndwFJYCA9y/4F3N8JcfMRqmDO48EtLlgw4qxSNj1wyEl004J6NEDMXWPsNNrNS/kHZLXvGZWkiEj3Faa9A/gpj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChNhpYMJ; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d2e16b552dso1096853241.1;
        Tue, 23 Jan 2024 09:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706030730; x=1706635530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U/HCJ5AzaWgbdtZfIl+oZilfRmZKIIXAk9H/FfZ0fUY=;
        b=ChNhpYMJP5SY9YW8TLr/cEfL+f9qtwWsuIPh3ac16k3TS51Xi39QWDbBxRhA4TMbdS
         4isWB7/YkRvsA589U+izes/VeVWqV+FlY7r8seHh8SbUc6q1nfAYle1GE5ViaL6S9Ysy
         dXb1Vp962f2YW8NC+AjTcuPagej/zs2wo4H9+WQr9wALEM+Jg19gyNryPP1feoRJ0PSL
         FojHDo6B/q+zHOoR/NkGukm6oKW6DzEuoqUhczNPFfWxGKuJZTVrtmCFJQJEqSF1tM99
         Q7ErDy6MleIplLEIQOUpIcyFaxxXgISBTfTQrgRACf4mCsmVF2ZCo2msuVsyMhKODN0F
         DYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706030730; x=1706635530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/HCJ5AzaWgbdtZfIl+oZilfRmZKIIXAk9H/FfZ0fUY=;
        b=T+L8+6JFqU0y9prn3cWcJRkU5NhJ3Clnq0LxCvCKFa5OlBNO6mj4xE+m8GoN8EvdGM
         rIY7RrUVJz6T6HUoZpluGP4D4M772jJtc3dAv+9nUq0o9u6CWCSxkfXF+Rgw6DHo0q5m
         qyMqeAGcWmdjHh+RIiOm33oKeDH0Er3bcPoSnv3XOMAJy0DDhLayic80Oatp2iwV8cIb
         twDoJwx+rR7osFf/iBlmCn5B0jdz7qORcjGl8qj8xkwxqml6FngXN9l001P1FOX0j3Gr
         JXhiSd9ohBujW+59lSda/ab48u/eHZl1pHyEzo6ntjXKfnfwwuMZEyKo6nfYIHpRa2Yp
         MdKw==
X-Gm-Message-State: AOJu0YzblfDMvk2xxVw1aStJVWN68D7GXGdz6mNNCOE1u+KklyhyohQs
	suMba0rt8vG+nJBASZI9o/kxRE9o0yQbht103/DhC/BIYpx8oaUVzoO/esOPeTUQTmRjNN25cxF
	Yk2Yzg+QZ4AXMQbY6pU6tMnW5MYQ=
X-Google-Smtp-Source: AGHT+IGH0ByYIyMyTwM+KJ/xVrRcWkiXemQa0A3WurIOXLLE10kZajdVmAftNg4oXG1iwLNr64w0B7acqvvmNdaFBqc=
X-Received: by 2002:ac5:c939:0:b0:4b7:4136:f0d2 with SMTP id
 u25-20020ac5c939000000b004b74136f0d2mr2664009vkl.29.1706030730508; Tue, 23
 Jan 2024 09:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235818.091081209@linuxfoundation.org>
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 23 Jan 2024 09:25:19 -0800
Message-ID: <CAOMdWSLnk9YmdsPX69jL7XrWOsbx+Ua75Z8P8E2x8+Pxsgte3Q@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/641] 6.7.2-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.7.2 release.
> There are 641 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.2-rc1.gz
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

