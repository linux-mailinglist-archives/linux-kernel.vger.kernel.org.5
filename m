Return-Path: <linux-kernel+bounces-118979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140E688C22A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4637E1C3BD30
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C3C139E;
	Tue, 26 Mar 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="u/nHwhSb"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A856B6D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456372; cv=none; b=hP4686KjwILawxZqVUyU9MM7MAoIYJcpo9X4iqbXH3/uWaRpNe6VS63vrlv3FzjWtQDoSyZDre8b3r3vF4nxqF4vd8DZBh3cyCbAV8OeA5vC/1U5v6I6NHSVgfgs9y3uA4C8qUC6dMeYlzzwqVoxrMVbQyMHHdb8rHxLxnbuULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456372; c=relaxed/simple;
	bh=+TTMS6GstYCX8enwCzaDrp4EKZyUaw11ymfdNiKNLI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M1cGEHiDEHYQmIiQH6xOWY3KF2IRDpai/vEuyw7hPqKNjdHbAFnLcfzpz7PHKFEv6VRxDDgRw7xXxLUl8lfz2xjK3EDci63phk6sC0xWqiC2FH0ijEh0EjZU36iydWCDClgQSbD0UJK5mS4krp2nrqaUG6wfsQrdvz4ve22amiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=u/nHwhSb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29dd91f3aaeso3858768a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 05:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1711456370; x=1712061170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK+6QXN4TcCCwm2JgFdztpoGu8OOn8ysvZ847fB5fws=;
        b=u/nHwhSb6cpQ58U//kywD+E0dn9OLxluyNSsYWGzPHqJgHEAXD1ANqtsMGvhbZneG8
         DPXdLJW3SNLVxs8HnTpee2x6x2pEsBTmhUn0YyDmXcbZSHCIvTapdecb78LO9KJFcKhy
         ZjPiJxlFsYvnvMXzNwOQwGtYCgDifvtXrnUrS8JKgaaL/T/8Ekwq3BkDBDnpf8Y4+wML
         wHlnp7QSk84b+t21mE/CN3sNXY1UiAoOZniYz2iCOC8TYopsK9yrU87Exu+v5KSuqQVc
         T5jb8UHy9nZph3dXDWWZw2yh36ypmP+aZWpi7LkIsLSZxEzs2CL8FFiNUSkQLjubVtRN
         7lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711456370; x=1712061170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK+6QXN4TcCCwm2JgFdztpoGu8OOn8ysvZ847fB5fws=;
        b=NfAIRl4Ul3WpLRONLRlA1d7ECof8uscPU2HXs5l2PgmIvtwFq0h6pIVrjZrLh2pxl/
         qI5d/veMQGY9lzEpE7hRDw37XE2pBf56NRHRae6WqZR6EUiet8MG/3KiIvyHCz3O0sQv
         7533gZyTFchWNlMC1EA7PDpkS321ZIyuIKz0BeVP9IPAii5NKCaw6pOBO3I7o+IQ2k28
         UF9Z+xLU3GK8a60VrBIRLaqRfBVv1iJCCnjArJ3+Idbll8VVFHr6riEGMkfcpOGrRRlv
         kj2SxEy5dfwwjwyOMck+FtUcvN4FqFaHRLD+fgbONcxnlUUrLWXOQupieTY8kfj6MW18
         PsmA==
X-Gm-Message-State: AOJu0Yw4aA1LvGwZJP1fuyivh2lmDpNllLfCVwCEDj7LvWKK4VD656P7
	zULbh1iWe1YwzlnMmY9fagtoCOh+B9xFDh8ptM9c+bDddUODYa0bV0ysrG2NYeSsaFIjGH/vaSQ
	fPrUbR4Dkm8G4Y5HZgHkTb1zTi9SEoqm7QhIXdw==
X-Google-Smtp-Source: AGHT+IEeX6I08TajZ7onirE65m1mprFAA5BwwUaMFPC+mgRyFceOIoabWAxxwy62vLG91qYBhgDQwVg4RWugkzvK/NA=
X-Received: by 2002:a17:90b:128a:b0:29c:3c24:a5da with SMTP id
 fw10-20020a17090b128a00b0029c3c24a5damr6999204pjb.27.1711456370525; Tue, 26
 Mar 2024 05:32:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325115951.1766937-1-sashal@kernel.org>
In-Reply-To: <20240325115951.1766937-1-sashal@kernel.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 26 Mar 2024 21:32:39 +0900
Message-ID: <CAKL4bV4hB=mWzgSyw7direNfzP+42faVPdEAC88RzZ1Nf3GKaA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/632] 6.6.23-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha

On Tue, Mar 26, 2024 at 2:59=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
>
> This is the start of the stable review cycle for the 6.6.23 release.
> There are 632 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar 27 11:59:50 AM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.6.y&id2=3Dv6.6.22
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha
>

6.6.23-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.23-rc2rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.42.0) #1 SMP PREEMPT_DYNAMIC Tue Mar 26 20:27:44 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

