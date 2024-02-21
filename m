Return-Path: <linux-kernel+bounces-73875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 437BB85CCE8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA743285446
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4771320E3;
	Wed, 21 Feb 2024 00:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk36ZSl5"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260F917D2;
	Wed, 21 Feb 2024 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476443; cv=none; b=E/Z509EVkxSqRs1lmCQqsyo+eStis9IvgHnpgpFiSQFjBRTAc+BcbHNBlEPAokp33LAhN+BYufLzwePrsHXAbuNu/QNdwly0eIvXd+aRz7wHW/5OpmgAs511oVfqXYa0ktVA77RE3jhrXnrtZ4M+vc8vRD8wRd2gMaIz9ig5VIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476443; c=relaxed/simple;
	bh=BGYJY3y3cB5MC3o3E10OWDMAwxuaz24DAxY4Svu1vWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jo12uVJ6eaxpUIIZxLUiUDDKAX0exncTAlxKfPcK/3WelJexCRyRhsjNejOJM4aEOszZak49wQgn3AkE4OJkvaufg3sueMok9plY3XtmfWtjt7iDHhLodormKpkk1C0Jy9zfsRe/VHuNgNWN5Wj7Etvs7Yt5A3jdbDc2sao+vXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jk36ZSl5; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-470455b5352so443113137.2;
        Tue, 20 Feb 2024 16:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708476441; x=1709081241; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C6otgqaNPx6Pkm4SppOQT9QY0t3YG7FEfi10dYninQQ=;
        b=Jk36ZSl58E4kAZNioNGLvMLubZJSXZ8ff49pt+IsmxXNArwqju5k5119iQUoRBOXQD
         uead6s7O/0C26BCTjF866YpoV/L19CZby1oG6vfaMpZ2Np2ShuoQQX9KbNmWUiLJ4eiG
         SrjNnW75iuQ4wqoj8XKNRiS6QjNYQAludaMxqWOsrkx5ufu4pqQ0+BaSPUupHPCFpUR/
         t3IQo8EVZw0o/MIo9f7kDpdMb92aAUKQn0+00VQKJZT5CjGEUX1GYkYH6FCuNpTI5AUw
         lARG9JtTdIM53iHqo7mIKL6oFl7nA2+cQB7kn46AkVGxePC6ZG6TymTmlr5jJHPV5cD/
         FiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476441; x=1709081241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6otgqaNPx6Pkm4SppOQT9QY0t3YG7FEfi10dYninQQ=;
        b=kqQsABX9nJk/b3KqhDnDbjEgtm8ccnzb19ZAJyi8S20FCLCbMpqAyKAFr8UZ85aoYZ
         mLdlC4WpHJzlO2ICV7SYV/FTqxQRvZjfy3viF4W9bDjCsdJoCLuEGbBW4UfKBJ01P/Jd
         ZzNHrvaB/GhafK2hCnOVpHymQjQgZhj4O9fQidGCS7055mGCVY6NUmRkBKWZWnrGMcM+
         GeXhLT7zhRor5Gqqj1JiXDUxbShQvUir0he6MvaO/fh1cAlTuJfbndzMS8CecYKY9QDU
         /z5xfFRoPGTxkwzxflQ4Vl6xiRL+G5MLMd4FkzCZSJUE46XYydjvxy5sZxb0bZiH8AKd
         xH5g==
X-Forwarded-Encrypted: i=1; AJvYcCWA0EeE0yuRrkh4zdCVYM/z/4yrn9RSCSdsDm1p/TrFd1kXGthfChUu1R7kVHOyXdrIpiafgsc6a16v1vPluyNyHX3unP6hYu3N/UrR
X-Gm-Message-State: AOJu0YyE1SNIKUdagFX3WQsUKV42MLkUic3rVBRlL9wX3OssSWim4Qu4
	/HiLqRH/2sXLS5STiNzadRIYM1xZk/2PUUUPBrA8evtaeRBWMDhktEhOwU0TamuRkRzcvVoidKj
	uZA5ieVhIFoIk1OsJf9KNr6sNkOw=
X-Google-Smtp-Source: AGHT+IFPYDz0VDhOsDd3s7oO0IBGc0nELsAax2YuwRcJFyZHcHUa7dCHDWdIV6juN44G49l/soy6ajEoJ2v4HXi+oEg=
X-Received: by 2002:a67:fc50:0:b0:470:3a99:fdd5 with SMTP id
 p16-20020a67fc50000000b004703a99fdd5mr10113811vsq.14.1708476441187; Tue, 20
 Feb 2024 16:47:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220205637.572693592@linuxfoundation.org>
In-Reply-To: <20240220205637.572693592@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 20 Feb 2024 16:46:58 -0800
Message-ID: <CAOMdWSJVOR9QcBdSVnWzkuFz6MK_xbQ+yZKx_ZoYpzvKNUOAgw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/331] 6.6.18-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.18 release.
> There are 331 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 Feb 2024 20:55:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.18-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

