Return-Path: <linux-kernel+bounces-49982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C8E84727E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0F028256F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804B614534D;
	Fri,  2 Feb 2024 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g98pgsAP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7F7E5;
	Fri,  2 Feb 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886125; cv=none; b=QX8PMTnb1ZNcM6d7w6qQuByQHfaLIGKt9SMONvPgq8GmaxjxsXb+S8w42pbzyMmz1srZBcGF7M3mFmJGmKIEaGkdquY1ze4DfAv8hZemTxFd10+HV25XfJmHo1puHDKb7KXoI/KxyTUXBt/UqhTcfFOmwR7xbIohXKkxkiImxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886125; c=relaxed/simple;
	bh=hDylnFMPrzeq70fQAWBU+9OkNShdD6KuDlCXCiW2zIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhAUvxHVxvRgyhJZRWAxT0zbiD9sCjVETL5UxG9EA+6zBwYW0XWIyWjSq7jBTTSilVCFNQlwY91Jrsatp8RJ3BEXxl791vXDLO5KTJ6ux0QZta90IjJ4To0Ig72BQQJm53fkZ9mS5szIZkmRc8RKQLQAObnHLjueAkJoqT+6zA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g98pgsAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7A3C433F1;
	Fri,  2 Feb 2024 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706886125;
	bh=hDylnFMPrzeq70fQAWBU+9OkNShdD6KuDlCXCiW2zIU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g98pgsAPEayS+E5N0BVJ2sHKDfmZTd2ddIs0+VMuVgojD0HTCVv+UPggY9phr+7YZ
	 7i5cpnkUwh+aEasromv254prUWHZMLwW+sUpxpmiW/RSQUam8NRUJqlN56ldIJKfAM
	 d+kC8pxmSeFjgZJlHtpIj1cv883BFG6WFECaWxdusMmBnRoQC9ahwKyJW1ldmKi4xg
	 K+L00Yf0vg0LAIkp/CkrGq945ARV6xwZUUf6fy6/yFM8td3MIjUBVNQIH2gxkHUGsA
	 doom7avwVCDRPK0MyH8kcBGV+kFUNDv3P/j3PWsuGhpt5/WVA2c1MZgkUjVpy4jFLo
	 mujKl0KKF3YPw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5112ea89211so2485423e87.1;
        Fri, 02 Feb 2024 07:02:05 -0800 (PST)
X-Gm-Message-State: AOJu0YwnzUEdBKt3ECFV7umDi5rVU++RuEl7Gm2D9qrY6F5q2Xz6DnRW
	8uCeJ+03mhBcIKpgQxevAmpVMY7FuAmeUO7cWBBedUGY1fHN8u3Y0WWxOcCyQzLG6M7b3uhjppH
	M/Qpw4KmYKflmmgPFu0zxnmLn0Fs=
X-Google-Smtp-Source: AGHT+IEIayGEqSR8Cruf1lHkYrGAyL8KwdaiBpm0SfUPfTpQZ4t7dXr7Q46Dzppc1Bu9MsuwJBwCcHPJW1m1utfUnCo=
X-Received: by 2002:ac2:44b2:0:b0:511:3d02:2641 with SMTP id
 c18-20020ac244b2000000b005113d022641mr156283lfm.53.1706886123633; Fri, 02 Feb
 2024 07:02:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131104851.2311358-1-john.g.garry@oracle.com>
In-Reply-To: <20240131104851.2311358-1-john.g.garry@oracle.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 3 Feb 2024 00:01:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNATDMjzmgpBHZFTOJCkTCqpLPq8jEjdrwzEZ3uu7WMG7jg@mail.gmail.com>
Message-ID: <CAK7LNATDMjzmgpBHZFTOJCkTCqpLPq8jEjdrwzEZ3uu7WMG7jg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] Introduce uts_release
To: John Garry <john.g.garry@oracle.com>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, gregkh@linuxfoundation.org, 
	rafael@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, keescook@chromium.org, nathan@kernel.org, 
	nicolas@fjasle.eu, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:49=E2=80=AFPM John Garry <john.g.garry@oracle.com=
> wrote:
>
> When hacking it is a waste of time and compute energy that we need to
> rebuild much kernel code just for changing the head git commit, like this=
:
>
> > touch include/generated/utsrelease.h
> > time make  -j3
> mkdir -p /home/john/mnt_sda4/john/kernel-dev2/tools/objtool && make O=3D/=
home/john/mnt_sda4/john/kernel-dev2 subdir=3Dtools/objtool --no-print-direc=
tory -C objtool
>   INSTALL libsubcmd_headers
>   CALL    scripts/checksyscalls.sh
>   CC      init/version.o
>   AR      init/built-in.a
>   CC      kernel/sys.o
>   CC      kernel/module/main.o
>   AR      kernel/module/built-in.a
>   CC      drivers/base/firmware_loader/main.o
>   CC      kernel/trace/trace.o
>   AR      drivers/base/firmware_loader/built-in.a
>   AR      drivers/base/built-in.a
>   CC      net/ethtool/ioctl.o
>   AR      kernel/trace/built-in.a
>   AR      kernel/built-in.a
>   AR      net/ethtool/built-in.a
>   AR      net/built-in.a
>   AR      drivers/built-in.a
>   AR      built-in.a
>   ...
>
> Files like drivers/base/firmware_loader/main.c needs to be recompiled as
> it includes generated/utsrelease.h for UTS_RELEASE macro, and utsrelease.=
h
> is regenerated when the head commit changes.
>
> Introduce global char uts_release[] in init/version.c, which this
> mentioned code can use instead of UTS_RELEASE, meaning that we don't need
> to rebuild for changing the head commit - only init/version.c needs to be
> rebuilt. Whether all the references to UTS_RELEASE in the codebase are
> proper is a different matter.
>
> For an x86_64 defconfig build for this series on my old laptop, here is
> before and after rebuild time:
>
> before:
> real    0m53.591s
> user    1m1.842s
> sys     0m9.161s
>
> after:
> real    0m37.481s
> user    0m46.461s
> sys     0m7.199s
>
> Sending as an RFC as I need to test more of the conversions and I would
> like to also convert more UTS_RELEASE users to prove this is proper
> approach.
>
> John Garry (4):
>   init: Add uts_release
>   tracing: Use uts_release
>   net: ethtool: Use uts_release
>   firmware_loader: Use uts_release
>
>  drivers/base/firmware_loader/main.c | 39 +++++++++++++++++++++++------
>  include/linux/utsname.h             |  1 +
>  init/version.c                      |  3 +++
>  kernel/trace/trace.c                |  4 +--
>  net/ethtool/ioctl.c                 |  4 +--
>  5 files changed, 39 insertions(+), 12 deletions(-)
>
> --
> 2.35.3
>





As you see, several drivers store UTS_RELEASE in their driver data,
and even print it in debug print.


I do not see why it is useful.
As you discussed in 3/4, if UTS_RELEASE is unneeded,
it is better to get rid of it.


If such version information is useful for drivers, the intention is
whether the version of the module, or the version of vmlinux.
That is a question.
They differ when CONFIG_MODVERSION.


When module developers intend to printk the git version
from which the module was compiled from,
presumably they want to use UTS_RELEASE, which
was expanded at the compile time of the module.

If you replace it with uts_release, it is the git version
of vmlinux.


Of course, the replacement is safe for always-builtin code.



Lastly, we can avoid using UTS_RELEASE without relying
on your patch.



For example, commit 3a3a11e6e5a2bc0595c7e36ae33c861c9e8c75b1
replaced  UTS_RELEASE with init_uts_ns.name.release


So, is your uts_release a shorthand of init_uts_ns.name.release?



I think what you can contribute are:

 - Explore the UTS_RELEASE users, and check if you can get rid of it.

 - Where UTS_RELEASE is useful, consider if it is possible
   to replace it with init_uts_ns.name.release



--=20
Best Regards
Masahiro Yamada

