Return-Path: <linux-kernel+bounces-158080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C498B1B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991571C20E66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED85A10B;
	Thu, 25 Apr 2024 06:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ri0sHikJ"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042E53E15
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027249; cv=none; b=jmjJbBt6Hu0TKy3K0DVvg8qCxQpZHrYGWrKdePIIs5CsyAF5lc1KffWZ6Wlla+EAj5dx/BtXE6USI7Y1svIf0riw+ZsSxMKDegJKL02ILx9Na7Ws+PGfC2PHwXxCZNfc+uP50a2E1ly0D/LdqtH8km6Sk1mvSCyhLCY67O9YipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027249; c=relaxed/simple;
	bh=7OKYbj4Uuksbo2Qf5HPNw17rjN6Qs+vtlgxGEBAQNdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4JWZnfYRedhgGx6Lp4775ihQ1ERz7tdRrs3ttLgHaiXi2Abi2Kx1dhRnD3KeqGemJ3gw2IdDAtBzQKz7CuJisGirWxdOab1M/lvn9dcyZukFX+0I9tu3VACDnoPAaVDIu4y+Tj4ORQhEXFJtopUqNL2D5uZuPu05ts0QOSwfMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ri0sHikJ; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4daa5d0afb5so234700e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714027246; x=1714632046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHsnE6PXlZIvSfAKFrgueOgWtUt0jTx+nljG77Q1N3I=;
        b=Ri0sHikJwc8crIntCl0kBjujGm4XAHjqV0j0f/l8xrPUPo+I9orCazk3fUMjPLiClg
         qkDSNLg9mliIGbOweyM1Fj5v+whZaxAOM2WRVKhYrXpN7un8chfC0thMhXICZCW1Gs2k
         mdlb7cJgPZnkSJaqCrLConknwBOcaeKD0Lddj9iDHTeUyWyCfbBUTgJQCj+aUsGrFdVV
         QoXQNqzqCtZMiiIMYT+iJvHMJNaEQ+TH/5HQSiW5ubvIpGDL+ybDp9D1fLtGTbcs1+F1
         LN5qDbNMZ6w4jiokal7mJJe28b++50R4X2I7Uy1jukTRqsk/lni7UCYjxIvkYOUafNJE
         MLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714027246; x=1714632046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHsnE6PXlZIvSfAKFrgueOgWtUt0jTx+nljG77Q1N3I=;
        b=rntvwkYiYoXHlEvNx2Jidji4rvtBdeVUyCeozjt47G4WKAnp7cOVZELkdmtfRreuQc
         9RGi+BYesEtVwYpK95YcM3DM4fSvbeELXWjJ3SdhW2m0B9RKyQkRGRyxxkCksDr8REjB
         ztnQ15nXtkaQBcZ591bTfIF9/BXF4mq3k/ky2Wk7ATrQ9rblejUMknmMpAPW1WMXIukr
         LUHW7Tsi2CYNqftVTcgdKCRodSF6/e6fjmpdTUr43TjeigdooxoqddwXwAOvJsXWb1c6
         qe8me0DSMy0A09D5JzuqfB94JMt2nFkQYNZvLNQt+kW2KG+zzL8ChJJ96U9NNgOzdpsN
         z36Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEcAjvPRgJmLM9YUNKCsXRWf+3IZRuscvr2MJX+15iJ/daCD+709Vsi2WCJC46UJP4vq1FMLHJ+2CbF0oOoDfcxDx5M/p6Nt10I8Hx
X-Gm-Message-State: AOJu0YzLkCf3WMJ0O8u7TvkR9Df6Gs+y21/XjsOuYbd9CUqh/bgQ4hC4
	YF4df321zmCLFwgZYnloqVbKF3oe/yPaFxJyb96fCxmRAFL+/IVJw3BLgYe3wZSOLRPwTH2f/gj
	rQJ05rRB406toG7vebLcYWI0mdCtP3LbmX5OVdA==
X-Google-Smtp-Source: AGHT+IHy4yn17l8WHIexhBFucEWjWLbwAWQAgKSltStNJ3dC7QNXsxAi/oLT0hbpvn0uD0kdCJfydjnj6Vo6WxvlaAs=
X-Received: by 2002:a05:6122:4686:b0:4da:aabe:6f6c with SMTP id
 di6-20020a056122468600b004daaabe6f6cmr5538526vkb.7.1714027246474; Wed, 24 Apr
 2024 23:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423213855.824778126@linuxfoundation.org>
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 25 Apr 2024 12:10:34 +0530
Message-ID: <CA+G9fYvB61RTie=PKQau1m2WWQNUQ++ZY+W_of4kXVh5P26B0w@mail.gmail.com>
Subject: Re: [PATCH 6.8 000/158] 6.8.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2024 at 03:11, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.8.8 release.
> There are 158 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.8.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.8.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, x86_64, and i386.

One regression on arm,
the TI BeagleBoard-X15 device kunit test boot failed and
it is always reproducible.

Not a problem on qemu-armv7.

However, I am bisecting this problem and let you know shortly.

Links:
---
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2fWFwcz=
HZDFUGnjqyT1mZ6wIeS9
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.=
8.7-159-g9919cd9ab988/testrun/23660959/suite/boot/test/gcc-13-lkftconfig-ku=
nit/details/

log:
--=20
[   45.931457] BUG: KASAN: slab-out-of-bounds in
krealloc_more_oob_helper+0x464/0x4c0
[   45.950073] Write of size 1 at addr cacc68eb by task kunit_try_catch/176
[   45.956817]
[   45.958312] CPU: 0 PID: 176 Comm: kunit_try_catch Tainted: G    B
W        N 6.8.8-rc1 #1
[   45.966735] Hardware name: Generic DRA74X (Flattened Device Tree)
[   45.972869]  unwind_backtrace from show_stack+0x18/0x1c
[   45.978149]  show_stack from dump_stack_lvl+0x6c/0x8c
[   45.983245]  dump_stack_lvl from print_report+0x158/0x510
[   45.988677]  print_report from kasan_report+0xc8/0x104
[   45.993865]  kasan_report from krealloc_more_oob_helper+0x464/0x4c0
[   46.000183]  krealloc_more_oob_helper from kunit_try_run_case+0x224/0x59=
8
[   46.007019]  kunit_try_run_case from
kunit_generic_run_threadfn_adapter+0x84/0xe4
[   46.014556]  kunit_generic_run_threadfn_adapter from kthread+0x378/0x410
[   46.021331]  kthread from ret_from_fork+0x14/0x28
[   46.026062] Exception stack(0xf219bfb0 to 0xf219bff8)
[   46.031158] bfa0:                                     00000000
00000000 00000000 00000000
[   46.039367] bfc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[   46.047607] bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
[   46.054260]
[   46.055755] Allocated by task 176:
[   46.059173]  kasan_save_track+0x30/0x5c
[   46.063049]  __kasan_krealloc+0xf0/0x13c
[   46.067016]  krealloc+0xb8/0xfc
[   46.070190]  krealloc_more_oob_helper+0xd4/0x4c0
[   46.074829]  kunit_try_run_case+0x224/0x598
[   46.079040]  kunit_generic_run_threadfn_adapter+0x84/0xe4
[   46.084472]  kthread+0x378/0x410
[   46.087738]  ret_from_fork+0x14/0x28
[   46.091339]
[   46.092834] The buggy address belongs to the object at cacc6800
[   46.092834]  which belongs to the cache kmalloc-256 of size 256
[   46.104736] The buggy address is located 0 bytes to the right of
[   46.104736]  allocated 235-byte region [cacc6800, cacc68eb)
[   46.116363]
[   46.117858] The buggy address belongs to the physical page:
[   46.123474] page:af853d8a refcount:1 mapcount:0 mapping:00000000
index:0x0 pfn:0x8acc6
[   46.131439] head:af853d8a order:1 entire_mapcount:0
nr_pages_mapped:0 pincount:0
[   46.138885] flags: 0x840(slab|head|zone=3D0)
[   46.143005] page_type: 0xffffffff()
[   46.146514] raw: 00000840 c6801500 00000122 00000000 00000000
80100010 ffffffff 00000001
[   46.154663] raw: 00000000
[   46.157287] page dumped because: kasan: bad access detected
[   46.162902]
[   46.164398] Memory state around the buggy address:
[   46.169219]  cacc6780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   46.175781]  cacc6800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   46.182373] >cacc6880: 00 00 00 00 00 00 00 00 00 00 00 00 00 03 fc fc
[   46.188934]                                                   ^
[   46.194885]  cacc6900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   46.201446]  cacc6980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   46.208038] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   46.215454] hub 1-1:1.0: 4 ports detected
[   46.215637] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   46.226745] BUG: KASAN: slab-out-of-bounds in
krealloc_more_oob_helper+0x458/0x4c0
[   46.234374] Write of size 1 at addr cacc68f0 by task kunit_try_catch/176
<common> [   46.570037]  krealloc_less_oob_helper from
kunit_try_run_case+0x224/0x598
<common> [   46.576873]  kunit_try_run_case from
kunit_generic_run_threadfn_adapter+0x84/0xe4
<common> [   46.584411]  kunit_generic_run_threadfn_adapter from
kthread+0x378/0x410

## Build
* kernel: 6.8.8-rc1
* git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
* git branch: linux-6.8.y
* git commit: ea4e35f1afd7d7d003c345bf14862183910ecc6b
* git describe: v6.8.7-159-gea4e35f1afd7
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.7=
-159-gea4e35f1afd7

--
Linaro LKFT
https://lkft.linaro.org

