Return-Path: <linux-kernel+bounces-25297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F89A82CD0C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8F21F22586
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 14:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543B521375;
	Sat, 13 Jan 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZfFcZgB"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4E521363;
	Sat, 13 Jan 2024 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-28bcc273833so6385555a91.1;
        Sat, 13 Jan 2024 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705156198; x=1705760998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EVg40E4XeqqJS5SMyAUeTLAJhHVnIRgLTwa/mm1S4mo=;
        b=XZfFcZgBHdHnRyfL1EnJfxX6h71titfhdJ9nSaz7LJcUmJFv/7rnB5fWSy+ZwD+BNb
         BiEimRlbpUqvy+4Qm6E3QWIpGji91DZIaxJZB4ZuTpHHcNCyaGD1TmrfcM0GFyElwapL
         rp/jn/xXJWDbLDH7usIOjYtbN7R2LIRxaG+92//myi3Tq4k6JXy3s9FWzANXC97KsCJs
         8H/EOFlqpOLITxPCo9FMZadBfPt3Y+Vbt/Lr/zcqIY9LgtJCznwNqACnty0l/fANBGU3
         /9Lj7GRKD0gR1H9xHWeOaYlLmtxpKlaTltIfIOS6z5shpuqoykmX+dhmRa0QSBNjR+GX
         fkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705156198; x=1705760998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVg40E4XeqqJS5SMyAUeTLAJhHVnIRgLTwa/mm1S4mo=;
        b=rJ11Cn78fSu9Yz2hMziEsIckNFTK10c8Wf72OFO4BP+t6lnjmEZcIGbqLdrUG3g+Rs
         4kgD6zu/cGGUTVPwgC8XYIp2rzho6OEH+O3jQKVqARSsUG8g4mcKJ44RovL4XLoc4LIE
         4/ArRQvoNx6UoA2fmb5ffdRcKkUCTBK+9lK9EX5BLSxESPMEFSaX8p/0HLmO/J83rHIR
         Kt4K/mLdO7SF19UrQeXHB7gN2q3tc+4xfbadxcPZoo+5ABED1lToKZjs5UDiQvF8ndAK
         owrjqPn7OalvfL/m8lCUfsEK2Ew/hCIpaQhUamN5k0DUleDr+kwRR2lR8gGCg+h6T1G0
         O9Hg==
X-Gm-Message-State: AOJu0Yw6xdjbzujtDVHSc52KsARwDRnUrh5GzyY8qgHpQsf2mAT0UZB3
	V5snBCkIP7rj4irzo+VBuBp4VunLtc3UCf0nvSU=
X-Google-Smtp-Source: AGHT+IFwO6yKJkGhDveSPCt4cYpW/amwmDt3tr43kd1fTgkArl7JjdOlewpOPFtotjVBg5stIReUpjzodTdWASED1os=
X-Received: by 2002:a17:90b:1241:b0:28c:5a10:f31d with SMTP id
 gx1-20020a17090b124100b0028c5a10f31dmr2524393pjb.45.1705156197692; Sat, 13
 Jan 2024 06:29:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113094204.275569789@linuxfoundation.org>
In-Reply-To: <20240113094204.275569789@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Sat, 13 Jan 2024 14:29:44 +0000
Message-ID: <CADo9pHh9biZyxKTLU37ArKp4RvqvebkP5XGPekz=bTpdtj0KBg@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/1] 6.6.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Works fine on my Dell Latitude 7390 laptop with model name    :
Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz
and Crystal Linux: https://getcryst.al/site

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den l=C3=B6r 13 jan. 2024 kl 10:02 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.6.12 release.
> There are 1 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 15 Jan 2024 09:41:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.6.12-rc1
>
> Jeff Layton <jlayton@kernel.org>
>     nfsd: drop the nfsd_put helper
>
>
> -------------
>
> Diffstat:
>
>  Makefile         |  4 ++--
>  fs/nfsd/nfsctl.c | 31 +++++++++++++++++--------------
>  fs/nfsd/nfsd.h   |  7 -------
>  3 files changed, 19 insertions(+), 23 deletions(-)
>
>
>

