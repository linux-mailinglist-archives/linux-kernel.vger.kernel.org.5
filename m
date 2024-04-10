Return-Path: <linux-kernel+bounces-139016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE07E89FD82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58195B29FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A2B17B51C;
	Wed, 10 Apr 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX8sRbm4"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A38017B4F2;
	Wed, 10 Apr 2024 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768098; cv=none; b=ox8Cw5kS1ulkai+I1U1x5sws5zeizmTTZlv237TeQCfgp/KhPKcvHvVip4iCBbEI4iHG4MPRC4giU8UHZUyTS605Xld9h1dBJtmOAibXhlcmh+8lWNwZC5Qk9dD0p88b1Z3H5FV4Je2mmz98Mu3lwYtmHsdzXz0VfP+bvyf57ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768098; c=relaxed/simple;
	bh=n/TcQYPfm6/UZ6rJXQxfLCh/AQmNhTjvnXPPsFZqbXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUELYXZbGqAtzP403FDfwV4qtcFEpUV2mDBY/Ek1r3UQEfenWDaTrjJbBcRWyEEyr/rxvQ1yxw/l8iEtBnQjai18M+6DETJr34IlT0oBpjPjjQyZha08lNOaOmbJ3d25PyiQORaygpi3vY1Q00yv29RKq1DTAIfapgTr4fciWR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX8sRbm4; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4dac6802e7aso1182183e0c.0;
        Wed, 10 Apr 2024 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712768096; x=1713372896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rZiEFA9WBXwwleYO92+UArt4+yOxriHtdTPKbUKrFmo=;
        b=NX8sRbm4dAaoGuRp4rm/1f/fPSaIsNakOzB/P4BzKxv1wXnyQAHuVmSIJMuxjfiz7N
         Lf0qBJSc1VrxuphaXGwuat644zn2fnL6v9D9mCbWFlMVe9GXF99KKJ06tNKw3Wolqtv7
         /W9epts+ZQjoQT4l5LGOUoQjaTJ5GIF+OGetfuDsUAEHhOERCTTu0mhW+toxeq13Bezq
         Nv4QhyrPCVSMOAac766Ap+QEkB1myZuIEpWC4JXOFO7dxFK+skfYr83VCUcKce4JZDlI
         W7YikQc3VWwLHXEAWrrIwDZVi1ckmr4yd6AtdjIYqhtgbfqgMQ819bWc91XLNrv5vKzE
         tGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768096; x=1713372896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZiEFA9WBXwwleYO92+UArt4+yOxriHtdTPKbUKrFmo=;
        b=HL9G9Uv8DyGWu3rv66XCTS61drGdjHU3qM4TaqW0jehVlOtYoX8/BK+gH4EKe5/qGt
         UuPxuAvJzUSptF9rbVHvwqyfDNfQ8CHmlBhYRZhttdMWD5M0ApgAk/WdMR3ZtVpAz/bz
         1nHUKihgYn5TYGADhk9dm4cGCjLkMdT+FRJTkPgz0ASCRFjeSkJYHKtzIc8lk1PXeQzJ
         Ey8ZxO/g/GLuOcdo4aS+HWiJ6VscTqOL68JRh/G1I30rhupA8R/l36FDULDaYVHcNFjn
         8X6y0mSz/YplWHzFKykw5FMoEJw+8+B22/z6GV9jm56X5YyiFVlDxm017pPOyiAL1RII
         zsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWK80CkkzPDG5V8zqcR4N2U++sUrxnYSZCG8oaBwGFvbMjDOf3EivubwhxTVnDnrJQh1D/wfye/8FOdn2KRzB10Yt/EIeN3XWoX04WF
X-Gm-Message-State: AOJu0YyG3HJMgpG0tVzsy8wJDjHND09gKY6rpKXTcc8UUfGjU/tiJIyv
	W/UsZkXgY9ckAs+F+3uDg03elQqtTpFsINQwfmKQaQezv/Tiz8nPAfZdPJszswchd2MTYe/m4tH
	Mi8ldCLw61ZABFs7dIaAAGtX4Gao=
X-Google-Smtp-Source: AGHT+IFpgdk+MX3lb/xuXQycRWzWMfP+ZHuH8cpG8+mzc9SfHckTyXjkou/UiZWckDRb+NL+RF9WSDrHmlF5vOt0iFQ=
X-Received: by 2002:a05:6122:219e:b0:4d3:cff6:79dd with SMTP id
 j30-20020a056122219e00b004d3cff679ddmr3001650vkd.12.1712768096145; Wed, 10
 Apr 2024 09:54:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409173524.517362803@linuxfoundation.org>
In-Reply-To: <20240409173524.517362803@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 10 Apr 2024 09:54:45 -0700
Message-ID: <CAOMdWSL=DzM3pSBgbELzQAeDL8Xc_mNJM+AwvdxutDMQY+BqkA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc3 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 Apr 2024 17:35:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc3.gz
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

