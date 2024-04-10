Return-Path: <linux-kernel+bounces-139014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FD789FD79
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F32286B9B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC0F17BB04;
	Wed, 10 Apr 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vx6M6kic"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A1117B51E;
	Wed, 10 Apr 2024 16:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768035; cv=none; b=dI1nJoAbj5GHQH7cpijCQCeJYRwTtXKFahQpavHLs6fyV/R0QV9VeV4wjAkRNt3ZmO4r/TApTRs8nH40u/fk2W3Rd3u3VOK6rJPOS2SP8aoNngz/XLBssmrgPqMADqePObnnqLp60SkNA2CbzL8Dyd0rnHNpuAKKO0okVj3S0OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768035; c=relaxed/simple;
	bh=AWrncjZwDA68NvWmjk2SeXSJBylgB9tyJoK1qiZjZZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZLeOowYD/oBSX73Zy6qprXaFy1mpev1VSgtJbVRmtC1RxQ+VN119Y9G2aWFXNWxAoA6xBhqg0oLrVlauqxyoy+WhL3AS3CZuXdasIrixFYYI2hWDusUzccv6D5Q0oS5djs+XmnQFqzxp09WDCdQji1zu0tgrpi+kT/b+0sjPow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vx6M6kic; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7dacc916452so1400064241.0;
        Wed, 10 Apr 2024 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712768033; x=1713372833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IAc/j38UGOp/hftDBPjpYs8Fj3EV6hztR3MkDnZUkeA=;
        b=Vx6M6kicNyzZv2f1J0PffC3Joz/SoSffWT5hI4u52Kp3R9kE80rZbgDccsuo7I4gcf
         2buXEuuWCVg9E+0PgmFiyuuaJ/Cfq75Euy60PgKR2YNt3PY2QKvPgXXiiKuz46TaeopT
         qc+3kNlbYI+HSXCisrRWqraIUJFIMvj2mA5nadlYMGUWXss6iyx7SR2iG4rVIWQXA/x3
         ZTTfX/KK09MdgfQjyyCP0v2t1wBD9rawQfPr6idkS7o/qUc03U7qrMR/KsRE5s7vP83c
         RthbRuheIL8PeyfaqnoV8JQJPO9OFuosWFOo4rhvlvMgX943zxmZh2nLB8Bd7M8H4hgc
         ceBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768033; x=1713372833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAc/j38UGOp/hftDBPjpYs8Fj3EV6hztR3MkDnZUkeA=;
        b=j//4EZmLoTTzB3EOnN29hmGARBR1v+HMt7Q/b6O9/ZGdRonciczvHiK75nEk2aLszu
         KEZKDsMVgjzThipzpZmrDLNnbIFVKdtmAmyD+WtKH2y+KH2XDhWOFD8Am7XKSqup7GCv
         CYkwa0uLXOFWbtCKiv6pOzJt/amK4N4iNc56eTSzJVfkFRJmqBgyegXq1asqZvWt3WoF
         mVaBAjfNXkSBqiQamPy0+AURSGdrbwfjM4m9ATtcDYnvmx1VyGRTr19QGcNJCNh1wvO5
         6ISHWJ7w7GqmZuXZoiHld83GYlgcxnLFbizm18lUuop/YTOAoiCVjZzpA0EZuqRghGQT
         D+dg==
X-Forwarded-Encrypted: i=1; AJvYcCXlLRX3MwhJB3v2rlnhvYIELXpNQpnk74JUIoX8slwSLDQ4G41IB1BVoz21FoHn+ddbnHZsU3H/2c5yKNA+3M3FHXLc5KEPdqDUNeo1
X-Gm-Message-State: AOJu0YxBmrmY8bTD3R7SDWDO0NqqEEErxs5cvfFIx1LLwpg10LB7Pvze
	Lf/u25bFjGn+g/a4HG2TTub2/CNUSJYP8LrXd9S4jNZ1Y3Khyovt35HABdOJNAVZIY1P0PDNrYl
	fsOl+S6JhtfSfuQ/uU5VtmOu0Qrs=
X-Google-Smtp-Source: AGHT+IGr8TxVhMECHrTQdn0cbBNVJDXnFxELEO4vBuVLIbvK2lfh+vnOleOLJi3YUu6CE9zii1McOfPlpD+j+pkIQsc=
X-Received: by 2002:a05:6122:708:b0:4d8:7339:4c35 with SMTP id
 8-20020a056122070800b004d873394c35mr3263912vki.13.1712768033207; Wed, 10 Apr
 2024 09:53:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409173628.028890390@linuxfoundation.org>
In-Reply-To: <20240409173628.028890390@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 10 Apr 2024 09:53:41 -0700
Message-ID: <CAOMdWS+ctWUtRdE+rYTmRGVqqmykcYsiSD0+rg6Y6nzEaGOprg@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/697] 5.15.154-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.154 release.
> There are 697 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.154-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

