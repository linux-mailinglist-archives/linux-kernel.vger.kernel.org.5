Return-Path: <linux-kernel+bounces-162590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4628B5DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A2528A671
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193A882C7D;
	Mon, 29 Apr 2024 15:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="FtTKzxqI"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D90745C5;
	Mon, 29 Apr 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404615; cv=none; b=ak1t2Lke0ytoXjY+EpwZ4Cj/YfG2hMbWXGHrUhgk/b4OIwuyhR+zQNOCquLbFymnX4TOwwIBDn0YmisR4dm1DrC9KVzZtSun1gbyrgAnQ8FDw/1cW2D34066ze8LCvZBv76pF9EqlQd4Wm1T3LUfiamrsQCFfeBMIfF7+MsA6aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404615; c=relaxed/simple;
	bh=TqiYQJmqdFV9zXlq9q0pmNJsGn5PO0G4Y2blC9CxpQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiT5DBc2J+SQFzGWIChqYOpn8eUWpioat46OsIeGKFBYfKTkcFsAEgLnQU3COj4oHZjbu8evQfzDqNJLeEL0ZL6/CO8UJ8dYPtCDrsR2UlmDFIudxKScvvL9jMm46+xShqEyva5AVtjSYR3yA2sNf+1EhAbJwsRKYIcQiBFal6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=FtTKzxqI; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=/TMieuIYSHO4gvXYmD/QV218MQNhKby9ucs7zLNNfzE=;
	t=1714404613; x=1714836613; b=FtTKzxqIiZAafQN3OMRBOshhhAPZ0SjJ5Hpnnmrfv0zBHTi
	l6ITfErsouZkYWpvghQLhGUydygUc15/iWIC+D4EjkYn9bAcLEoptWQ4NLfriA3y+L2JbcAGBzAC2
	YUxKE2YUQV7xMpbLzHkOEQPB2RTl4VX6qh/85y2/gr3TeUmex+x4JbFDTsSFt7Hu5arWc8D8Jfogu
	0hYW5VOk59yosBxS6OGsKJu4LKbBR6rCDpImOnkfJtFH250gX4I22o7zQm0bgTwn5BSUBsHnVFnpG
	iT05a3P6X8AZOeQekvymJf2k2KT4k1d1bygQxKAyFbNmF+wpWiMkigcKSdFLHTsA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s1SxD-00069R-Fy; Mon, 29 Apr 2024 17:30:07 +0200
Message-ID: <c819df1c-4215-41bb-b24b-563a912d160f@leemhuis.info>
Date: Mon, 29 Apr 2024 17:30:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nouveau: r535.c:1266:3: error: label at end of compound statement
 default: with gcc-8
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org, Linux Regressions
 <regressions@lists.linux.dev>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Timur Tabi <ttabi@nvidia.com>, Danilo Krummrich <dakr@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYu7Ug0K8h9QJT0WbtWh_LL9Juc+VC0WMU_Z_vSSPDNymg@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CA+G9fYu7Ug0K8h9QJT0WbtWh_LL9Juc+VC0WMU_Z_vSSPDNymg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714404613;50dc93e5;
X-HE-SMSGID: 1s1SxD-00069R-Fy



On 29.04.24 17:06, Naresh Kamboju wrote:
> Following build warnings / errors noticed on Linux next-20240429 tag on the
> arm64, arm and riscv with gcc-8 and gcc-13 builds pass.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Commit id:
>  b58a0bc904ff nouveau: add command-line GSP-RM registry support
> 
> Buids:
> --
>   gcc-8-arm64-defconfig - Fail
>   gcc-8-arm-defconfig - Fail
>   gcc-8-riscv-defconfig - Fail
> 
> Build log:
> ----
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c: In function 'build_registry':
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.c:1266:3: error: label at
> end of compound statement
>    default:
>    ^~~~~~~
> make[7]: *** [scripts/Makefile.build:244:
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/r535.o] Error 1

TWIMC, there is another report about this in this thread (sadly some of
its post did not make it to lore):

https://lore.kernel.org/all/162ef3c0-1d7b-4220-a21f-b0008657f8a5@redhat.com/

Ciao, Thorsten

> metadata:
>   git_describe: next-20240429
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_short_log: b0a2c79c6f35 ("Add linux-next specific files for 20240429")
>   arch: arm64, arm, riscv
>   toolchain: gcc-8
> 
> Steps to reproduce:
> ----
> # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> --kconfig defconfig
> 
> Links:
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2flcoOuqVJfhTvX4AOYsWMd5hqe/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240429/testrun/23704376/suite/build/test/gcc-8-defconfig/history/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240429/testrun/23705756/suite/build/test/gcc-8-defconfig/details/
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 
> 

