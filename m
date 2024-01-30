Return-Path: <linux-kernel+bounces-43661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B08841759
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14224282527
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A8CD2FA;
	Tue, 30 Jan 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpjJI8pF"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BCFEC4;
	Tue, 30 Jan 2024 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573565; cv=none; b=XHeVJZA9vzucNyoTbRnOPMHYjBhZ/TeJRrYZMFbs0ZTWqiErebwUu7lFkThXoWTWvLfS8fBrrUcT2p3IFoAHCScMtIG640LZzrU+pCqdqCiL/+Q6SP/O3OpRkjVNZaN+8KzT8gmjuFs0e2XgkgOzTyJWDaW9s3VmoTYlyOi+S/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573565; c=relaxed/simple;
	bh=qFY9pvpSAh8/gTd6U+ZRGFBZtHBuUqVyYA/q01yohwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocRhydAg9wtUCboSFZGpKQ2c99MTLpuEnlJEweoFWFya6uORJImpwBK8dU0K3lVQxr54rxXdL1XAxMHgybCdtG22jvlFDXWv+vxL0+El8eqGcoUhOwzzpJTqUIEwtmxz7oXs1jwdSWKZQVAmaEOrUEANfQfPTELDfPPoN7p8W3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpjJI8pF; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7d2e16b552dso1568710241.1;
        Mon, 29 Jan 2024 16:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706573563; x=1707178363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B0ayNobXDIvlzXhxPnNo/lChDplPwaQVlQw1cYzK7mw=;
        b=XpjJI8pFniGjeLKss2G8w3zaZb2IO4Zz53BwSQL1GUQO+AtnWgWLGhRKmvZVeN1RYc
         9KSt08CbtS2RtIjfbmbWrbrw1BCX/WdNad6+zg2cvvrnUE/skAskcQ4eGEUZ0uSqUOL4
         hqBHZ+a4qJvo4J9qZmHA8RZZx1lyidyNDmaY4C0Rv2yjQ3bM34YWX5RwMqEUVe2/4ZKU
         Ft1KkeAv2p8TwbCDjPphd0dWRxjtsSc9VU9WwIJg2c6d0Lr3bgCwt8tjla0SQMkgq0BU
         ywc0us7X3NPvKZSO+1bJ6B35h87WEc/j9UesyYbCjKLaFxs1f53qgcezMzpbOw0IWgrc
         cR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706573563; x=1707178363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0ayNobXDIvlzXhxPnNo/lChDplPwaQVlQw1cYzK7mw=;
        b=eY3sEPgijUjy6AwB2IqaJSdMfaB+Lp1f4ye2SC0tPH9riWNHFyFctobemyy6zI9EZg
         WYByL94sTdxguvGMoLzPPbjcjcsWx8aGwPQTCrJJXpoVcK27lrQ4QvVVCnSUZchbHOQq
         5PHlPBb2sKVxyxM374s7kJ2xDcpivQCWWiv+FG71ChWF8pKgvH8EVoAuT6eTgryJPbdo
         kvf0Q8LsoFa6bYdcQAFniHgmZ3B3g5JqIbpgdZL0upzL8f7MSdPKPFuaGMrxqZdxR0pr
         xgV2092jueWNND6G6p8HISvenltJxOPQRNLmlR6tPMNwbHUMzSe95n+E+fSMTj/gWgxQ
         KJFA==
X-Gm-Message-State: AOJu0YyM6FjOmBCje6hbjLyDHu1NhBBkP/eXYups7QpyCucyy5WF58E8
	8xepOc7LYjq2HA6bwfntU6WJxAGbhIpoBLoP3ibuXwIBBavnM4NdvDZF5yuc4XovWHpA9x4P47D
	ixyGJIweul2U2Bfa8vV2XPe6t5J8=
X-Google-Smtp-Source: AGHT+IGrqkqJqJ9naDETyV7iL4vzSRMYrGIwK5tCdF0UslTpl75d6dZ6B/x5ega8sa2iXpABKPK69EuVSGZmXtU1sR0=
X-Received: by 2002:a05:6102:1953:b0:46b:22c5:fad0 with SMTP id
 jl19-20020a056102195300b0046b22c5fad0mr4993454vsb.19.1706573562808; Mon, 29
 Jan 2024 16:12:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129170014.969142961@linuxfoundation.org>
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Mon, 29 Jan 2024 16:12:31 -0800
Message-ID: <CAOMdWS+Nvj_9z-2tL5UZNBpw1pMzBC4DXPT2dp=okuKV+gZ_vA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/331] 6.6.15-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.15 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 31 Jan 2024 16:59:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.15-rc1.gz
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

