Return-Path: <linux-kernel+bounces-118488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A0A88BBAF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087E01F3AA57
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8370131BB9;
	Tue, 26 Mar 2024 07:51:07 +0000 (UTC)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604A13175C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711439467; cv=none; b=bcGqfcjPW/XUAB4XO6Osxk1/Mvl8n6NJDX88IZxA6qmXhJIjEoiLraH/RleywO46Shkz9Kl59b1fBn9D+oW0QiJY7NaLLqxbMcExkIqxo/jWvZO0DdUjon1iUiuP3YGoylJZluW9LhuafpamcoF+UocGmM+Bl7mYe9hPq6BJZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711439467; c=relaxed/simple;
	bh=gr9JgkrESZ4jhKkfEzPbJwRvivaU77MYSxc+lDGeHU4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nBKMOnc3BcaQEksVPae3/FVCYH96rOR9jJwg23rmJ6++FfIIKvbb5gDJAYjwO6eLnlzJOKpt+NJMh6dhBcCJUlIyDY6Ryj2ShLQXauKaSi7FijMjcT/KqMRwDZtgUUL7VAq0IzbQQUgrvAOjHEFgVtwboyw/aCo7X4lUEJaSceo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by xavier.telenet-ops.be with bizsmtp
	id 3Kqp2C00C0SSLxL01KqpkN; Tue, 26 Mar 2024 08:50:56 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rp1a5-004zii-Gc;
	Tue, 26 Mar 2024 08:50:49 +0100
Date: Tue, 26 Mar 2024 08:50:49 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: linux-crypto@vger.kernel.org, Chris Zankel <chris@zankel.net>, 
    Max Filippov <jcmvbkbc@gmail.com>, Rob Clark <robdclark@gmail.com>, 
    Abhinav Kumar <quic_abhinavk@quicinc.com>, 
    Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
    linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
    freedreno@lists.freedesktop.org, 
    Lucas De Marchi <lucas.demarchi@intel.com>, 
    Oded Gabbay <ogabbay@kernel.org>, 
    =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
    intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
    linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.9-rc1
In-Reply-To: <20240325200315.3896021-1-geert@linux-m68k.org>
Message-ID: <8d78894-dd89-9f4d-52bb-1b873c50be9c@linux-m68k.org>
References: <CAHk-=wgOw_13JuuX4khpn4K+n09cRG3EBQWufAPBWoa0GLLQ0A@mail.gmail.com> <20240325200315.3896021-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 25 Mar 2024, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v6.9-rc1[1] compared to v6.8[2].
>
> Summarized:
>  - build errors: +8/-8

   + /kisskb/src/crypto/scompress.c: error: unused variable 'dst_page' [-Werror=unused-variable]:  => 174:38

xtensa-gcc13/xtensa-allmodconfig

   + /kisskb/src/drivers/gpu/drm/msm/adreno/adreno_gen7_0_0_snapshot.h: error: 'gen7_0_0_external_core_regs' defined but not used [-Werror=unused-variable]:  => 924:19
   + /kisskb/src/drivers/gpu/drm/msm/adreno/adreno_gen7_2_0_snapshot.h: error: 'gen7_2_0_external_core_regs' defined but not used [-Werror=unused-variable]:  => 748:19

arm64-gcc5/arm64-allmodconfig
powerpc-gcc5/powerpc-allmodconfig
powerpc-gcc5/powerpc-allyesconfig
powerpc-gcc5/ppc32_allmodconfig
powerpc-gcc5/ppc64_book3e_allmodconfig
powerpc-gcc5/ppc64le_allmodconfig
sparc64-gcc5/sparc64-allmodconfig

   + /kisskb/src/drivers/gpu/drm/xe/xe_lrc.c: error: "END" redefined [-Werror]:  => 100

mips-gcc8/mips-allmodconfig
mips-gcc13/mips-allmodconfig

   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0xc), (.fixup+0x4)
   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x18), (.fixup+0x8), (.fixup+0x0), (.fixup+0x20), (.fixup+0x10)
   + error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
   + error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)

sparc64-gcc13/sparc-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/4cece764965020c22cff7665b18a012006359095/ (all 138 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e8f897f4afef0031fe618a8e94127a0934896aba/ (all 138 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

