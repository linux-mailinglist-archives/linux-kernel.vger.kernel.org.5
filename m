Return-Path: <linux-kernel+bounces-30399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF20831E35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF3E1C22B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C12C842;
	Thu, 18 Jan 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBssr8jY"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA76E2C843;
	Thu, 18 Jan 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597974; cv=none; b=SCWlpEIf63r3T6ZMpePtI1Fsz3DzD9MH82LRkBw+bTaW0EJsMTwIa/as3Rlkp+UeAVzj6hWh0yg/QYFAbnHiSsgLAt61gfRwppRJmuaH64aqOy5gDCx0yTVtqFD+hLiTM6WMGXtTxamCS5Yu6bwe9Ol9LxRwmbEhEKXFSle6wCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597974; c=relaxed/simple;
	bh=BBxghMMGlXNVOZyw3Q9osEVQvQYCUfuF2q+P8DaL2ag=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=SDOaPKnhtMF+UWjpmu9t67f/pg9ouzQ0qPMWEfA8JWcjy2VJA7KiAgE0oJWqmSl3PKtSMmHDYM6/qpwePbVbzkMviPxR1Q0q7dYUEtw09MU5P8eH1lKh+JnxxIRyHaqJlYDITSE+WDK7TqlFug5RQZJzWxyGyVC4PQK2wq+F2Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBssr8jY; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-4b79c5d035fso2998787e0c.0;
        Thu, 18 Jan 2024 09:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705597971; x=1706202771; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4AdGFlJ4DhT7muHzakQ8cGddPk88COkAxuUIVnIUfDc=;
        b=YBssr8jYCMcdwWFNqnhuAcefkSNY3PAV0Diw84VWE6HNsk5GSi0X+66WnNp/TNAEvk
         FgilCo0CWuPTTYFZRSipMTt/rJEiMst+ASRCZV8CHIF0pnuVkHZ/pNdes9jzoNGZZXbr
         MCGGgf0iRA3gO46j1uXbwhn4vzlmRt1HitNALOWc4eLkcZPTE2B80wux32qdc5Q3qq4Y
         fAyueJuVa/59oLrIyfxOSoR918Ano8mIAZDGwcQQi3E8Jjf3EBKutG1l8I5RuMvitqr8
         2uNwHCadyNo0KWj9QBpGKE1Z17vrsQGf3cQiWAm7Lx91svyUts+I2JNBSCHT/WKIW4Is
         3zXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597971; x=1706202771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4AdGFlJ4DhT7muHzakQ8cGddPk88COkAxuUIVnIUfDc=;
        b=h2BZcKLWsmf8bWDjFjiZHvSDAIZ9UHdWkf/tsg3xs8IV4+Z3J0jU8Dcxc8I8QMciPS
         Mx/hnllXKFn++wZkaRy21vqtyDHW1H3/qRH3YCt3pUuBXp50xahwZ7WuvK5km5uP53qQ
         8HVhDkPub/zrO5M9miXGjllx5Fng4k7ch9HC6EKtf4MJ7wpTOeodzVAq9ekgyJgntdhM
         DeFAsRt1iKZjrxHDN0tmlNFbPddXcHOH/y2nQy5tfXPbnpN5YyWPVArZ7UYWUYbNWGoO
         Zmi4WgRNHBE43py1E7PhXJREQ7uEvugnCaQumxgg+b3If8nsGLJzFUYiexEpVFSFxjiT
         p7hw==
X-Gm-Message-State: AOJu0YyWerkO8KQxQCHB5tPdhji0FXREhDqkybPzjMjOiZuBjOSxYmx2
	q0vNizrvxhJeeGz4AzZgcZdZ7XscvDj00KeJMwzLZpkek01RWw01Wq1i2ljzNW7esTL6b6LUCnZ
	/Qp9Lj9I7EO1svQl/kMWUYjwis7A=
X-Google-Smtp-Source: AGHT+IGmkC3B/dAyIjW4ywRmjABIZnyBByHvvtUw+LnR2JrcFmsnFYVncSqYWLeUXP3jAsxm8FeRPuWmmDC8OZcCvno=
X-Received: by 2002:ac5:c0d9:0:b0:4b6:dce2:23c3 with SMTP id
 b25-20020ac5c0d9000000b004b6dce223c3mr1015218vkk.26.1705597971720; Thu, 18
 Jan 2024 09:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104320.029537060@linuxfoundation.org>
In-Reply-To: <20240118104320.029537060@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Thu, 18 Jan 2024 09:12:40 -0800
Message-ID: <CAOMdWSK13P=CoZqo-VfyPc8wMBJ0+o6SRmk+s2QDNetPkPmrDw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/150] 6.6.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.6.13 release.
> There are 150 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.13-rc1.gz
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

