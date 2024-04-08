Return-Path: <linux-kernel+bounces-135728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D0789CA72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45F6288076
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101EC143882;
	Mon,  8 Apr 2024 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKa3+5XH"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97383142E9F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596248; cv=none; b=RGGPtv9hZcVkhrejGdjKoKPVsHzj+H5ito+MYcyNBm2I13Jjn+1ptPvRJto+VhWoPEHKN8Q1WA7/L3DG4IeH7iqwpc5o4rjuMAgi9nJ3blHwBBD1K25boBPqbgQhg4QiecMNqJU+zcXDp4lxFQqCive3EWesZFfFV+z1uuwYdfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596248; c=relaxed/simple;
	bh=cylWH1nnV2bxqs+WbEQuW213MzLnqSLV8ZuKW654Nsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kq2TkxlsFt4G1CCJPjzgz2aAcfH31Io8FMgRmYURGyh01iY1V5JoBNS+xa2SP05VrersrYKf/q1063mDcpkZPcGWPo8f0+Dcm0yMPfu/lzuGH9y5WiCMMWZY3LaBg+JWwp7Tpbu4LkXgTi0L493wJtRZDW8076cAGoq8pUqnoKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uKa3+5XH; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-479c9c2d2b0so1379153137.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712596245; x=1713201045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dgNLDg69yxbLlzA2rtbGSv5XoBTDQC7WuQwQX8jNXm4=;
        b=uKa3+5XH9/wqnndhQovMxVcKGitMuVXwcJbN41BDJpfFUJrYqQ6CXYNVYRIV7jjABC
         enBwsUBy0qpqqzHZ8O0Yvzpx2RIxx5adVAG/oNiBsilolZwzopxpwL+fvCXe07Y0OyXN
         whh61H4HZ0JKpx9ehnWd9eHd47aiD6Rrv5uU3fn8ht6OPh0oG9FqHlg+rpePYu2DIdhJ
         45K4itBOC7V6DhoHyHbXbQ+NWiy53q91Umk4MgsBPbbulwD3Q/nxZwB9W5D3uLGheg00
         LrVtZoBNH7gT25BturHv/WEAB8qAnFatS/V2OmSIqNSCoDZXlD7hwx+LETdUhpSmU2PG
         JxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596245; x=1713201045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgNLDg69yxbLlzA2rtbGSv5XoBTDQC7WuQwQX8jNXm4=;
        b=HF4dsnS4JHNPDHIi8Wb9xsSP8ZJYSYQKUu87Dx+KMRS/SoLe6QkeG0bs5wWmacJ87h
         1lt0QGQYwTU6cWkl704SXzoRzCTDa/B1vAd2iUHCbyx3EqsTl93DxNynjf0MO5WDulrk
         h2uPBWiJeGXdVuOb+56K88cEjHXEQmEKAdlaqA3CVm3T7CYzSXqSHPYarEqbTd4KvRBO
         /vorh/JwxbairaCMd/FxkiVl/sDYdbZ+Q/SqVgeChetPLjewVuyc4/ZX6LLg39AoDOBj
         hikMbOLN1S9HiiTdXvtiAkuQs39Z3Hr3vU4dPXHYMK61OCWas5xrc7MUYovzcQWS0hPR
         3XtA==
X-Forwarded-Encrypted: i=1; AJvYcCWlYVF7ZzsPigzuZk4KcuOu1C1crLcoEOh3czpZNcfh4FxxkiWMVW/0v3mS2tLs3eYYwGjt50wyxq1ZudMJIjJ8o+18f3m+vO3jb0tY
X-Gm-Message-State: AOJu0YwepEkhSi3QI9Fo+4dXJtBgWhqzUDetgBG9cjijsRpbYuZAHgxF
	nb93XY14O6VDaeOz5CyVZ4t328M1cPpAriSP7COumLSL3vgjzo0UM4gohukF423eUNGVBH54oxX
	3CPH+6oXNLaDfRwNbfJAm6lPIZaKzUd81upFHCw==
X-Google-Smtp-Source: AGHT+IE4rZuhK6L+sff4J6NG4CwRQVKSfgKAx18voJzxhLCWPvTOZ87xJxM9RoHsSuBANnjuKv9ClsQST7QStSFG6TU=
X-Received: by 2002:a1f:eec2:0:b0:4da:9aa1:dd5e with SMTP id
 m185-20020a1feec2000000b004da9aa1dd5emr6423714vkh.10.1712596245531; Mon, 08
 Apr 2024 10:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408125256.218368873@linuxfoundation.org>
In-Reply-To: <20240408125256.218368873@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Apr 2024 22:40:34 +0530
Message-ID: <CA+G9fYvt2MTfghC9OtdV-bFF+dN9sY3MzgpcQ608tSTt3XUBNQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/138] 6.1.85-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Apr 2024 at 18:30, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.85 release.
> There are 138 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 Apr 2024 12:52:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.85-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The s390 defconfig build failed with gcc-13 and clang-17 due following
build warning / errors on Linux stable-rc linux-6.1.y.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
--------
arch/s390/kernel/perf_pai_crypto.c:40:26: error: field 'mode' has
incomplete type
   40 |         enum paievt_mode mode;          /* Type of event */
      |                          ^~~~


Commit detail,
  s390/pai: rework pai_crypto mapped buffer reference count
  [ Upstream commit d3db4ac3c761def3d3a8e5ea6d05d1636c44c2ba ]

Steps to reproduce:
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig


Links:
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.84-139-g76e1877fe563/testrun/23349327/suite/build/test/gcc-13-defconfig/log
  - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.84-139-g76e1877fe563/testrun/23349327/suite/build/test/gcc-13-defconfig/details/


--
Linaro LKFT
https://lkft.linaro.org

