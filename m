Return-Path: <linux-kernel+bounces-73874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4CA85CCE6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 841751C21E2B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4787A1FDD;
	Wed, 21 Feb 2024 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcyXOtnH"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336CE1851;
	Wed, 21 Feb 2024 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476395; cv=none; b=NHa3lgdLrxWZLMOkQBkPirQScPaW6Vj74YS/nSqmoAmbwbFabuVIOL/ATQJFbW7igsLOEAaFnnDF8LhYWMEpw0sG+FUS9KVOXMJ98rsK2NfJ4VzFvpVT/iFIlKgPNKmHp1Y4o2Enm2CC55cBojX9XC8sXtfcxdPVaP3ytlp5BoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476395; c=relaxed/simple;
	bh=rAvVro5JsMZ91WyT3WtUfDUvwGaJ6SlbknAv/TnNdZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/K2hN5dOHJme/qV6qr2QGouScPe+cL1vdHmeXOrPIPdPYMPxzgrpF6osxUjCoJcuvBHFf0DgF3yFQDHxsbT9Kyy8oOJZbdPxrgs7MxMFedsfei6sLSWq5oJi9uEQbXHOMfjw8wfhnphGmNULjvA9lqhZFC+7q9lLMSJimCeF0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcyXOtnH; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d625a3ace6so3939839241.0;
        Tue, 20 Feb 2024 16:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708476393; x=1709081193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pfa5AR7B3B2CvlFBekLtRqUu/kV/9aQmL+KzDlU1BuQ=;
        b=QcyXOtnHc1I4yVwRzYS0vMU55GOra0YzBgdMZJy6D8BiYRWK0l/FzvzpEumNf5a0dk
         vMyJPTTzLLsaG8z6xpDaslugtKwwYuSv4l/VhlmoBSo7nEU+FyswRHRzy9HKrtIJbq2Z
         dh3cQkLt/PvF/6FNo2Q6L94W7HUYbG11KCJCHQQ3bxx8eVrkJQkoDFVFRXwwssdOIL0D
         0kKgzqkNGqyVxTdVeoYiNRJtrNKDipS/fem74aM+vuRcuzf2W5DOuY6P/+cB7OGKSVxG
         gW3lO6VKtIQRNiYXOTH6Rc2wZHFEghIrOFRAR+R3ArdIg27rHyyjtmkqs9aNSMGK4ZsV
         TDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708476393; x=1709081193;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfa5AR7B3B2CvlFBekLtRqUu/kV/9aQmL+KzDlU1BuQ=;
        b=VjAuT0rJGRtVdpuuHAh1eTo+uAQsxcc+q+lwMnMXoXctRag4ZwBbHUYb6Q0EV02QQP
         a0taVkMOzAMmlPmnKb8mmEIfwhlPwMTT9ksNrBscsudF4l83+4448pOYE7xMi+RJKeg2
         rKia3/rrV/AuH4UeviQQt3c/kCz7/6GC5aLjs+Ppli7Ax1o/ulO0zywBmIgoPl8W11nR
         TYvywyovSCIf65z+N6UJs6lQRosLs7CY9wJKJrHU2rfXknuq5ELhYElzEJwe69Yw2OJZ
         HlQ2Qu1U1kxCDXG5pHB+dmtx2FpvzIXkleMILYMed+O81kgcoeZMXIBGibzcTZasDyox
         2F7A==
X-Forwarded-Encrypted: i=1; AJvYcCUBSl7hqhPqHfdT+Hu2yTLu0TvhyoiX1/wDwPv7Wb9+caG+7Xxp9GbQMT5LNjhA81rh2VDz1vVZ4pwx6ZKa6wDeE2USCq2N90j0214C
X-Gm-Message-State: AOJu0YwZvVb05rbUeXLLhraeuacOrPSxTtcgs68CeEJvIEp/i5dwFefA
	necNaOIuRyBws0EycxHcSt4zLn4E44bfjNK1arc6V110PE00cdx1y9ihnyHNCUjAlvlVMZzDkGl
	03kh2ij6i+LB01I7SvWE8Hal0iy4=
X-Google-Smtp-Source: AGHT+IHqZeH3EY6RorUxqti0OnzPLHCax1fAAM/LQXLJOSYcBhDW2pPBbFHwT8ZpYvzFUfHdO2ahDdhMMi1Mnl11/9w=
X-Received: by 2002:a05:6102:12d6:b0:470:5ce1:cee7 with SMTP id
 jd22-20020a05610212d600b004705ce1cee7mr4872679vsb.14.1708476393060; Tue, 20
 Feb 2024 16:46:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220205633.096363225@linuxfoundation.org>
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Tue, 20 Feb 2024 16:46:21 -0800
Message-ID: <CAOMdWSKTfrKgwN=iLWZV3rtXkgbDvdq3-Nv9LO3qS4WkjG-W6w@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/309] 6.7.6-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.7.6 release.
> There are 309 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 22 Feb 2024 20:55:42 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.6-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

