Return-Path: <linux-kernel+bounces-116804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F0D88A41E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0971F3D420
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF08E12F5A4;
	Mon, 25 Mar 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9V+hUhS"
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1A2182EE1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361697; cv=none; b=qVZxHXvo5N7ea3vYGO7KIGecnW6JMhgssGBg97nFyhRkpvo/DP7qMeyLEuhccUC06RbpucPgKxrZF2wOO9pXVa7LY+hUEv2q2cEAOzhbJCIi/sC3mKsr0Xof/bpCI4YOR5H7ASfnLDEcFMY7YxUZVZnMZAf3FQENCHcIQfPKnvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361697; c=relaxed/simple;
	bh=0m4OvaG4TjQncz6CeAce4N9xOv37QnwgrtsxOEC72DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWAqwfpvupLrnmKQ4zzvWeJlwmQEC3lEcsHFnvheUkiqbIBolcMqTEovw3Fd51szoRgeCg0ZV+m1zJkFUOFD8uTukyqEx30zNTylpAOyW4bPtwfv2G5ALLdgVO/HjCUY46s2iOLNb2Qkgztec9aTq1hB3sxhUcOsomAm+Mza2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9V+hUhS; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-476d13e405fso1045606137.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711361692; x=1711966492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dviW0LXOA189cguARshIw5Rs0U+dfA78oWLA/wEMZ9w=;
        b=b9V+hUhSTri52MOQV4O9SAS49O7q8vzGOamgrGcMX5UFWxU0oryv40YiGIm2IH8hfc
         VcYNxn+kxSl0wWQl3LmK1SYEWiqp/WJDIs/sGGpnswwHP0g7g4LyleQ5e/ySdlLcVw0n
         HDiCjviIyP+rxq6IKpUQ0jBjiOgoqCRO1ck+884Z9yqqlCFBOAkZuvHF6qTsTlzui40w
         goLbwrqbPUyfol0kfoXfQs7j0IKuIHi+5g0AyOffmV4uVPt8L+p/g0qFvKnd4gGdcxxJ
         XfPR2EvzWJijbN+bdmM/ZoCexD01tAZn5V0BFe2Qm7isGWa1dqOhPWQSHdBf/OGf/nIP
         5aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711361692; x=1711966492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dviW0LXOA189cguARshIw5Rs0U+dfA78oWLA/wEMZ9w=;
        b=cXMKm1hMrbflvI9cQzATcN8jotl8vxnUmywUI1lLWyp6nUBqzc2nvfHRTBZVObMvue
         Hx4Mf/EVc10mnlxo/17irMRzeXDctezNJhOGqjz28YGS+kkqhL7oKWPKtSiGjWQE7IPQ
         OcyipiOCMJLEgN/8ZrL3OE3aaYzfHDJeKVSBr5ONc0UbGlx9d7ew3lbSPBe0bupaYF1U
         +x/922i6WXSrw8agzEONWLhH5XrsUND3RuVEhNlySxdJHfQBqSK466hnODbsWzO6KuNr
         +IUvH0N0EcFo+RfhYDSDonTGE5lEzixrWYpMEqvUzDR4fyvHxjPCbyWTkzOQ+NZFhNE4
         Uc+g==
X-Gm-Message-State: AOJu0YxoC//GZd5h58qPcmzSacAlUBQjxoiy4PX840BpDCjf7hBXsINc
	N6OuYRoK+HumVSDVOdckFl9fl2nNkwm35GraDQ/ixXTVAJKbwptmAXl+IAoVaP2p+/PruSg9s1+
	K/2kQaK39xkrhv+5q8PkLAK4CYslWpsW8kwqnDA==
X-Google-Smtp-Source: AGHT+IE7UuJbdo/Q7mpnTl38KiQR38Lr7QPsY1r8hICE+qSu1pk5jF1m+963Bm6mVEV1ywLMunOIjDDA1DcsD4vlKMw=
X-Received: by 2002:a05:6102:a46:b0:478:619:342f with SMTP id
 i6-20020a0561020a4600b004780619342fmr748178vss.24.1711361692535; Mon, 25 Mar
 2024 03:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324223455.1342824-1-sashal@kernel.org>
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 15:44:41 +0530
Message-ID: <CA+G9fYu1G1+LKu0mOhppUbVcAJ2DaC-zSh2GBhfShR_No9T=9g@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/715] 6.8.2-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, 
	Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 04:05, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.8.2 release.
> There are 715 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 10:34:31 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.8.y&id2=v6.8.1
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

The Powerpc ppc6xx_defconfig build regressions stable rc branches

Build details,
 - ppc6xx_defconfig - linux-stable-rc-linux-6.8.y - gcc-13 - Failed
 - ppc6xx_defconfig - linux-stable-rc-linux-6.7.y - gcc-13 - Failed
 - ppc6xx_defconfig - linux-stable-rc-linux-6.6.y - gcc-13 - Failed
 - ppc6xx_defconfig - linux-stable-rc-linux-6.1.y - gcc-13 - Failed

 - ppc6xx_defconfig - linux-stable-rc-linux-5.15.y - gcc-12 - Failed
 - ppc6xx_defconfig - linux-stable-rc-linux-5.10.y - gcc-12 - Failed


Build error:
-----------
drivers/macintosh/via-pmu-backlight.c:21:20: error:

'FB_BACKLIGHT_LEVELS' undeclared here (not in a function)
   21 | static u8 bl_curve[FB_BACKLIGHT_LEVELS];
      |                    ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/init.h:5,
                 from include/linux/printk.h:6,
                 from include/asm-generic/bug.h:22,
                 from arch/powerpc/include/asm/bug.h:116,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:13,
                 from arch/powerpc/include/asm/ptrace.h:342,
                 from drivers/macintosh/via-pmu-backlight.c:11:
drivers/macintosh/via-pmu-backlight.c: In function 'pmu_backlight_curve_lookup':
include/linux/minmax.h:31:9: error: first argument to
'__builtin_choose_expr' not a constant
   31 |
__builtin_choose_expr(__is_constexpr(is_signed_type(typeof(x))),
 \
      |         ^~~~~~~~~~~~~~~~~~~~~


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
------------
# tuxmake --runtime podman --target-arch powerpc --toolchain gcc-13
--kconfig ppc6xx_defconfig


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.1-715-gb0f6de60d946/testrun/23136379/suite/build/test/gcc-13-ppc6xx_defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2e9dGALLBbylr7k4kq5DMdvqISo/


--
Linaro LKFT
https://lkft.linaro.org

