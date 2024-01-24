Return-Path: <linux-kernel+bounces-36912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FCE83A896
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46D1C1C21E75
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09AE60DC8;
	Wed, 24 Jan 2024 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="hYv6FJLu"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBC860DC0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097520; cv=none; b=BbTGN9vN9+y7p8uZzVkw0I9B6NkjmjrOryABY1EMx+rPhOng2IQtyn7DA+laC1EbJ/FqVNmnKCuWOo4PHbzdCMn/Y68cDGDQBCS7EMspLGKhgkSxrXJB8PmUG/btxSN3xLkvGWwjXq67kac2WuxMt8tr1VpKXEyUnQn6L0hzOJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097520; c=relaxed/simple;
	bh=2OMwQYIyKYq2QrymAVBBUuMzBZrJ/QI+2BLpsSS/wEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkpXRYkRQMolDaZ7eQUCvLiaVRB1OHUxhDI/cmZex/Iv75e5mNpd2dz8P2ByEsq32c7JSjmeMCv7i/TJdH/aV1uKUjloD4fFCAGm0hjdhe6772jNE3uuuMYXbeBFPnZspaHOmgBiqsgOLBuqoO4xypqB1kqquGYkJFcyEHEA0Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=hYv6FJLu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d50d0c98c3so51140365ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1706097518; x=1706702318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NSIi9kYH4kmkxlVRt8YH0clIrcU+K+qQZf81qv0t48=;
        b=hYv6FJLucgaJBAbNkrDO8Hy3mFz68KEvwUynp5hKBHAJvJU/X72leKZgTL+htReLM8
         MwGaBSO+Dmb0NQxJ5c9stagYe+fUaWOoqirTs364D8eM/naeuMCskH6E1Td6BRL5ySgS
         LQ8q8eJsVwyytv2OJiE67UxwpkD/r+tSW7DcEcANheDDs3U3nKBgvuBmbAdIRIjPJ54c
         fmL1VgKwWKmdbmkaltQfjlSosuDPlyktpIGScEgRqwZmDc73eU7jUulbh8DPoFUfPuGx
         6leJpCNld1UQiqu+mYpUkTITBl+K1ay59NmnBb7FFkmffKxrf4vTKUi4xp0rB9eycYxR
         BXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706097518; x=1706702318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NSIi9kYH4kmkxlVRt8YH0clIrcU+K+qQZf81qv0t48=;
        b=tT5Pt5JRrCf9xBjDGztbXxRFQo8b/PwfpMfFOJSvnMWvTrmA+mkE+Q8oEr5mC4AWm9
         gYfJJnBIrT7gAcSOHLXmgCXjbH0krgKeZNX02SMyuOk4QHhlNmjQs8L4A5kSLsN7veyu
         R8ugCQMsz8j/YpEykyO5PnRaj1hAsyv5UXR53/T++kkgRDrm+9b7lB3/aem3WdtPPgMx
         +VSYh4VpP7ahhPTCQz4X2SLhKZ8tv5eAvRIBy9RZraTFMSIpxbiAxZtv91MG4qJyVI7m
         1p7/2hUCmL7/C+5e4yRCU7m4IMldSuvL5IKBTzQBqo5QKFA2cIydUFsavabv0Mcvs36K
         fuLw==
X-Gm-Message-State: AOJu0YzNs+X6BWhjohN0r7ZBsOpZEVI2nk5kYxa7VatyLxkZZfREgkDf
	4sXB5qRTvzaRTrltKV/PFACqOn6W+C9KyuOPFq+7BWUt7qjU/u/YMZsadsf6Ysgfaw1CYmMhyAa
	hxnWRZ9FdY2cC/T9SzRuHZGV4Ii+zJiIQMpTV7w==
X-Google-Smtp-Source: AGHT+IHtGgZ55t56cQPQMUGbeBxtNl46eMANJ70ZzKQDIlpS1pOQaJViGbCIAFKqVyUH2zZvzMGT36QM/s/9q3Aii6U=
X-Received: by 2002:a17:90a:7101:b0:28e:84d4:6ca0 with SMTP id
 h1-20020a17090a710100b0028e84d46ca0mr1491924pjk.20.1706097517811; Wed, 24 Jan
 2024 03:58:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123174533.427864181@linuxfoundation.org>
In-Reply-To: <20240123174533.427864181@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 24 Jan 2024 20:58:26 +0900
Message-ID: <CAKL4bV5AXGh4DD8fBjYF1gCuFcKTSYcXxdg1wh_1OsorV-TqZg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/580] 6.6.14-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Wed, Jan 24, 2024 at 2:47=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 580 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.14-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.14-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.14-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Wed Jan 24 20:06:42 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

