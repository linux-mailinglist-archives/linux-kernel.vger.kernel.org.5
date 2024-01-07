Return-Path: <linux-kernel+bounces-18752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A286682628B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58EE1C20B93
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9359415A6;
	Sun,  7 Jan 2024 00:54:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286F138D;
	Sun,  7 Jan 2024 00:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28cec7ae594so679832a91.3;
        Sat, 06 Jan 2024 16:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704588885; x=1705193685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07EwMmHf0Kbina4nYu91Rh7NfrieYISV1KY8Y5DE2tI=;
        b=APKFHkYYScfNGjW5zj8aJkoBTiNVcU9Z1yfMdbfr284IldYJezkW97Hsn6HNYwSpUd
         L7S0DdkhuAD1Mw1tz3oDsLqwIFr7tUZ7gcLg+UHKanMjZLc2J8OiBGMi2nXAqN5Fbjjb
         kh0LMs8nclzDgPxy3OOf/bQtqmBlq4pkTsPHZq9ZBgzu3jJ36SAd1P2gygUvu5hhD+dy
         IhObTPkiKFkVJ0FxhrLyjRR4pB4xG5C/7N1jEk+An572SwM18B4ejMzvEd4MwvQ+GSQT
         5GdmRoX0mqLX6zrqIXsFg45JXw15MrSVlB8mfL8Rf84qh2b0nKlGzWn68wHc5Y6pPu4S
         4kpA==
X-Gm-Message-State: AOJu0Yww+QDbsU8GhbatCAz2pHxAs4duSASOD3zs0paCWrABiJj16qB4
	qKzwIOO6pARDpt0ollk7sOdSz1wCRzjNWWg3LPnunmUI
X-Google-Smtp-Source: AGHT+IF9UcMCzcFSRZQYyyd4CXlp0lYPRrL/+ha+GXNlKOa3Xrd7IhaPIdXp1xe1dbYwH9xG8D/PX8jwiVjBaK+Lk9o=
X-Received: by 2002:a17:903:32c7:b0:1d4:a179:13f9 with SMTP id
 i7-20020a17090332c700b001d4a17913f9mr1978986plr.101.1704588885262; Sat, 06
 Jan 2024 16:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205031519.853779502@linuxfoundation.org> <c8ebf598-4d9a-4ce0-bccf-2109150919dc@oracle.com>
 <2023120618-around-duplicity-8f8f@gregkh>
In-Reply-To: <2023120618-around-duplicity-8f8f@gregkh>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sat, 6 Jan 2024 16:54:34 -0800
Message-ID: <CAM9d7cjNgbLPbKV11045zH8ULJxwPWUr3wikFU2Ex1cH_0XxQA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, 
	Vegard Nossum <vegard.nossum@oracle.com>, Darren Kenny <darren.kenny@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Dec 5, 2023 at 10:17=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 05, 2023 at 12:46:43PM +0530, Harshit Mogalapalli wrote:
> > Hi Greg,
> >
> > On 05/12/23 8:46 am, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.15.142 release=
.
> > > There are 67 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.142-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > > Adrian Hunter <adrian.hunter@intel.com>
> > >      perf inject: Fix GEN_ELF_TEXT_OFFSET for jit
> > >
> > >
> >
> > ^^ This commit is causing the perf/ build failure:
> >
> > In file included from util/jitdump.c:29:
> > util/genelf.h:5:10: fatal error: linux/math.h: No such file or director=
y
> >     5 | #include <linux/math.h>
> >       |          ^~~~~~~~~~~~~~
> > compilation terminated.
> >
> > This was previously reported on 5.15.136-rc:
> >
> > Vegard shared his analysis on ways to fix here:
> >
> > https://lore.kernel.org/stable/fb1ce733-d612-4fa3-a1e4-716545625822@ora=
cle.com/
>
> Now dropped from here and 4.19.y

Sorry for the super late reply and happy new year!

As Vegard noted we can change the header to <linux/kernel.h>
to avoid the build issue.  I don't expect more changes in this
code so it's unlikely we have conflicts here.  Let me know if
it happens later.

Anyway this code is needed to handle JIT-dump binaries
generated by perf inject.  I'll send a patch if it's ok to you.

Thanks,
Namhyung

