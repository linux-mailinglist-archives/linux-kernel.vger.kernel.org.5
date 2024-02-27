Return-Path: <linux-kernel+bounces-83890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD884869FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7A01C2872F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1E11487E2;
	Tue, 27 Feb 2024 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNNdvdWG"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B61E894;
	Tue, 27 Feb 2024 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060561; cv=none; b=oxNCmX66ZHApEai7MtQu5z4wxTbMVXnxQkQ6cJeqx/RPyzT4DhLPATdtRqguVMI58UikVVcxZn6sylU0/OwouJOLwc6aWIInLvmjBzICODsAQ6EJnZ3TphYW5vEgEVFWcmxQMUBCOSGNnkh1jkfu/uIZFqgIxPBG5HY0Ze8evKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060561; c=relaxed/simple;
	bh=F/T40Ot5q/4XKxuYQ0xwCxn/cFwkxpslhyuDwFRXW6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpNcvd2QmD6KUQLTfZtdXN+gdtUHJrfn6JlcEL0mfL3DTZXWRlXh8/QA9VSeh/+HJNiF2EfHvpGFCS+zv3c3q9a2rLDy99MisMysMrCKFqUbQhhfzrLefVzLsuoKHpME+8xwrhw4S5vczcLNUV9zK2BfqN8IDSesQNQqTtZnpmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNNdvdWG; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7ce55932330so2485822241.0;
        Tue, 27 Feb 2024 11:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709060559; x=1709665359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MaLEEqvT4bweFBtcBLt+DOaN7p030y7OECbpB6T2QUc=;
        b=RNNdvdWG+PQ0ujvX9Zhwfc2h5oru15cX6ipRXERB4pNVO1H1N+p/kfAYLMIG2I3fIy
         xdWIQZQtwRRP+HHfz25bG6tK92KLUk4C+D8l0hU6WSXmRnsED2VE55Hh7DDLXBplI5nW
         HhUrSM1hoXrDkV8qFt9EjSyEPYufGIB3rpjsizKutyC975OLXJylO5qlK38koAg2ntB9
         f99zYRTJz4XzH+0VCQiPTpibKqwesgxmT+D08AX8DvEOp40W9YVckQaQJkBjqZqixf07
         fAb1qZ5JLKPZKeH9ZB9RyH4MDiMwrr1oxi+Ih/CeG9ovTJRie9cVU6JN22ZP4VRLk7NU
         NRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060559; x=1709665359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaLEEqvT4bweFBtcBLt+DOaN7p030y7OECbpB6T2QUc=;
        b=kwuOuKUXFiIqN0uKTLLBS1O/YecrBon8IdeJZNwF9K4WoZH/kZtEyrrcymDATaTXHf
         i6BXcVFE6zhRbkE7+g7X1oBfQETMT8yACEBeqgwJhJjJ33vfpoTfx01oT170j23CN0fy
         IKbYJ0dJotsPV83n7R35vbeiS54bHlmIgG9lNNaFACXQHGVdvgYSR3f+fcfD5G0+XXIV
         czJunXj1amXLxIDYEzFyTZ1PNQqy1V+ANbOBZ+YQs/27fkaJrGTHW19EyhChUckr42lF
         +MxCxHz4cUtjTkl40Fw0P6qhseDZ4tZQGjbVQRecff5JbqKIo4uz8WwzrB7UDITwGYp2
         s55Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjk7mPsBH5fe8F+BZ/N4yG58aYtBDQNCDbq0pAeRgbdkIcTzFCbIGY3Bx4cBT2eTn3sLNFgJFGd1L+CWJe6DUSgNBmbNEaRGxN82rO
X-Gm-Message-State: AOJu0YzdBZW9nyiOzU91bH3n/RXd5hKinyfb3Y900Axh2g0iiRdSJbRi
	zh6bbb7ZMSn+w1Les/DL3MxTa7O11nzABQmkBAaFQ/FhvdhU7jBplna/GhTcNLZS4eLeTYIarS6
	YRxgj5ZacLJ+ldKJMTE4p/SSzvnQ=
X-Google-Smtp-Source: AGHT+IHqgmnLOg0iJqUIsUvNKmzcN/yeqRl09FQa9RsiGWXCbHnEn4YP8yfAQJ6ppywyo6I295VvGNcPJCrvcdq6ejM=
X-Received: by 2002:a1f:49c6:0:b0:4bd:29f7:53c4 with SMTP id
 w189-20020a1f49c6000000b004bd29f753c4mr6706174vka.1.1709060558828; Tue, 27
 Feb 2024 11:02:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227131610.391465389@linuxfoundation.org>
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 27 Feb 2024 11:02:27 -0800
Message-ID: <CAOMdWSJcinmuru4=dYQYDcw9viVRrhJYh4e5kHEPOTagnG7=Mg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/195] 6.1.80-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.80 release.
> There are 195 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 29 Feb 2024 13:15:36 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.80-rc1.gz
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

