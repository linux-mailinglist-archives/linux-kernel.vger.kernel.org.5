Return-Path: <linux-kernel+bounces-37375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2339E83AEFE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6C428316A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2897E77A;
	Wed, 24 Jan 2024 17:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4ytBszd"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C37E768;
	Wed, 24 Jan 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115646; cv=none; b=b9XhBP+5i/tenJj4wEJ2rosvQ7iDSWq7pIfvDplSgr7zeD8nhQzXFWG3GNKbHKLIiN6K+saGuaw9lzj8+q5GG9aKeb9gS+pPQw4b+zaEGcdJV6LCQ3eT/WuN6vb4P0VxAEK3NYSnqECJBu0mFYcJIk2V3wENHeNWaJcCm4XEKXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115646; c=relaxed/simple;
	bh=1kyIDfJabV6lwazMpxM8CPtpStKPapFOQUDAe+cwJWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwbaeofZ6xSyAO/FkcGsuOdovLZECFTWYtCj6CJbLvr13ww8pzYCh9nleTu2I5vrcqeOvG3VI0e8+XLdBOfCt53bgxeccBXcXdv2/0oC5/talh0lbq+zV/96fUnGDvblkZXGiRJApPdaB4q5tv3pUWjoLVx8C3trI2S2LeBKPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4ytBszd; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4bd84b96feeso70064e0c.1;
        Wed, 24 Jan 2024 09:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706115643; x=1706720443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f5qJWQaQ6Ftn2s0qa7GtyUkE0k/qzZPL1w9AnZckfKo=;
        b=e4ytBszdcL8EOYTxv7hTqNSPA4smeES2PSjJMmIjq4nOCtgg8ySDXKRG3Ovg0XsvJh
         /oy3utpbeR7F18iXKB2tWOysxDnfwVqEcLHEWKmbJT/BpxlXdbegzRDm52pJQDJIROBf
         bWb3QGC299TjD/HZkK+mtwQ514eMHBJqUK3QMYMEZqcY1odUV4nZ/QNPcJUHlZJMNvey
         oWj+Q9JaRxe4qr6MXRR38BtUCxwoqc6bh1/nZjPu3X7kPnwCnVxL9FXJ5cas3bA/ohA1
         GaYs1DPWUrShYzaaOfX5Nl6ehBoI5ZuFyHd1RccwckD2cNiApDTwDyzhLzJH/NEcyjnl
         ZUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706115643; x=1706720443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5qJWQaQ6Ftn2s0qa7GtyUkE0k/qzZPL1w9AnZckfKo=;
        b=v5QbVrW7YOc/HbWrOlFTkunX2//Bv57W3Xh4M27o3ohTohEqqNybIXbfgUahPstuqq
         +fvvPqG58P0AT67rLFHI4TN8LlLUmcbcINjqZt3PxBmFt934gzuuEx6VSmsJg2NFuVQa
         gvkAaXO9F/y+aZfBGF1pcq7q8XMUQKiFIYU+77UktY3qLgPEdWehMg7/QYJkCY5VfIb4
         qbr9YDb/7mXP6Cgv/Q9EBNzbhlnmFM0lt3EMrKX2g8he4Dkiw4H2AuMaeJChP1o20FyY
         XrufospD43G1pxwN4bcBz9dsIYyCgmS94F/rbLszjDjpJLQmhPDdrdmjARFDrgrx/KdC
         cClg==
X-Gm-Message-State: AOJu0YzkGlc++wq8+gMhU3Q4u2VFhT44P9auch0UIHMsgiZ9GBaQL82+
	8hoMuD9jkV727fv6g0THCILA3gkPRO0Ce+sN59OQ1UfhNLoUyfTQ+H5L4Bw0oPSCcWhrJtPPC/q
	fNcCJyZdLOPqQUbRS6jKreIC+zVk=
X-Google-Smtp-Source: AGHT+IFlIVFnROaZ1a54V5nFAgBGV89wOM5M/npkbfrCexiktOJgxnmU9rhTkjRO81X0lYzGRR7MqLDp1V5vbEbcts4=
X-Received: by 2002:a05:6122:c99:b0:4bd:7bdf:31d3 with SMTP id
 ba25-20020a0561220c9900b004bd7bdf31d3mr584729vkb.23.1706115643187; Wed, 24
 Jan 2024 09:00:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123174500.819179356@linuxfoundation.org>
In-Reply-To: <20240123174500.819179356@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 24 Jan 2024 09:00:31 -0800
Message-ID: <CAOMdWS+Ch1QKhcYUSVo+Wpuz4=C_D9hc4vob6cyXGVj9uhCb0g@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/371] 5.15.148-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 5.15.148 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:14 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.148-rc2.gz
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

