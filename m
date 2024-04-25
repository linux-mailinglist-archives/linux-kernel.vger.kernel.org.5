Return-Path: <linux-kernel+bounces-158075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB9D8B1B20
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0E2284C84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA42669D2B;
	Thu, 25 Apr 2024 06:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRqE2eGB"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33E35A0F9;
	Thu, 25 Apr 2024 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027018; cv=none; b=kmxA8ZrIR3hBFjInYNWW8IdQ3/v2zjg0IiRhHkgpUfd1022CVcKgLRNydehUmX93U4eqRapVvhRwalwrOx+nPU85+Z1PbcWCZOv/z90iEZIB8Ai+vgQPuWZQSvk+o2kpMbZUMivQ+Xcpf1pHjSsXMcvrPpVoewwPGIDxwxEdCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027018; c=relaxed/simple;
	bh=QWCdkGr2Sa6mFy4b5dm3GE4RbNC9FFYijFaBo1oHDNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQBfm2uS5YaQObtSftRg8EW0/a4u13K65HMDX6882EXkA8OxGMHtJoxLycWYXitSMa8wlmffL0GtEsPNGQJwDSGujIcLAr/RC1qfJHd6CmggYPjpXpMHUWCwCq//wPcMZVhEGROjg0VCD/ikde+qW7Gla+8Rm1wZ8OQt5dqzaAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRqE2eGB; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-36c30a81507so239995ab.1;
        Wed, 24 Apr 2024 23:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714027016; x=1714631816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yd4LcZFprXOyrbBcAxcpc5S+mv0gDOSjUrdSSl0A9UU=;
        b=GRqE2eGBiZeFviLLun+hmfs0w9ChdXoZtRQomEieylbb0k+iHWyEyaB85smGpeMIpS
         ot3SCbnviUeEGE7JLhDqhuhrO1vuWHFvml7eyPbfI4Xj0mgBc71tiVW0T0vInsfM+nNo
         NgCn5mzHa/6SQK5QpVav5I5E382koL31+/C71Smc8A2SyBk/dyUDcRxbAZ4/k01D+jOP
         HEkUEodJQr0QH6APTv73s7Y+cAjaEStJ7JVQuHNP0svtCCu9i/8VE30soUOG0Lj4Tz0A
         mbtSBNDpclpWlHBQjX9WU5olVoMAQ1OeBG44h9VCtk14460aPIFY5TNgdP/Zn7erv/FN
         ZHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714027016; x=1714631816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yd4LcZFprXOyrbBcAxcpc5S+mv0gDOSjUrdSSl0A9UU=;
        b=XMEsiGBLlYWXjJhfO7Q4Sd3LCipcmziZD6M9D4zAEbGXXfxjRxst+yTMyMFESVhEn+
         g2dcfCZ9Bhf/Jjh7uXay71YM0C9wJFLv1oUQisPvkARnaperuhXlhoqOnQZWWUQlim49
         Z266RVhulVKmouF+7kdZXuYvf3cWRK+iORSzfxk5flzjoV5OhuUfQ/xgqkCCBJmLdOIA
         SJADkmcvfyDYjpENSPTC8L4La2iVsJuNh2uk8AhOzZq5WFGAGUq5Vqbx4uBXJpKnGXxh
         GEnu9s5M2/iYypmweh8n40d3sqmvGwYylCdykzNNLFS+/moJ46hDZL7in7vvs6Be+MEK
         qTew==
X-Forwarded-Encrypted: i=1; AJvYcCUL3plO/Td7hizy+vDafSb7zfYjHKkbyKtQmAzAXAuYXRVT4WaUMISLa4PTb5QO9hcVYWTbg8eulhdFGgueWqD7ucG9caQgJDFx6uF3gCi9oqrS6qaLfVOMftP82wrgNgAqdOnU6xXk
X-Gm-Message-State: AOJu0YwxDboB5KjQ5XT7ifT7exkvDqY2xz85Twki4CJsYhy4vMhuemiy
	Yx73SkoWCGudg0ZpCSGHoqndQCYI6oVjVXchqVaH506Ll30fhWLfryk6/OGvf7ZFOjs/QnfQejm
	8LUio4fsELcsTBK8EY6dquUrijAM=
X-Google-Smtp-Source: AGHT+IH0focrPEEYqNBZsj5Q2iozKESVaM9snHzS6o3AZjU0lnhDXEjqW2exevjo0YxDIH0LGF4rXU9FpiDmFS9w3hU=
X-Received: by 2002:a05:6e02:1cad:b0:36c:a4e:9ea8 with SMTP id
 x13-20020a056e021cad00b0036c0a4e9ea8mr5984710ill.17.1714027016039; Wed, 24
 Apr 2024 23:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1711026842-7268-1-git-send-email-shengjiu.wang@nxp.com> <20240424164725.GA18760@francesco-nb>
In-Reply-To: <20240424164725.GA18760@francesco-nb>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Thu, 25 Apr 2024 14:36:45 +0800
Message-ID: <CAA+D8AMxcAOdeSUhLnFdX2tjXSiWKg8-oxfZ8oT06-qQPnNKqA@mail.gmail.com>
Subject: Re: [PATCH v4] clk: imx: imx8mp: Add pm_runtime support for power saving
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, abelvesa@kernel.org, peng.fan@nxp.com, 
	mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-imx@nxp.com, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 12:47=E2=80=AFAM Francesco Dolcini <francesco@dolci=
ni.it> wrote:
>
> On Thu, Mar 21, 2024 at 09:14:02PM +0800, Shengjiu Wang wrote:
> > Add pm_runtime support for power saving. In pm runtime suspend
> > state the registers will be reseted, so add registers save
> > in pm runtime suspend and restore them in pm runtime resume.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Reviewed-by: Peng Fan <peng.fan@nxp.com>
>
> Is this introducing a regression?
>
>   800 13:50:19.713052  <6>[   16.531134] clk: Disabling unused clocks
>   801 13:50:19.727524  <2>[   16.535413] SError Interrupt on CPU2, code 0=
x00000000bf000002 -- SError
>   802 13:50:19.731400  <4>[   16.535421] CPU: 2 PID: 1 Comm: swapper/0 No=
t tainted 6.9.0-rc5-next-20240424 #1
>   803 13:50:19.742514  <4>[   16.535428] Hardware name: Toradex Verdin iM=
X8M Plus on Dahlia Board (DT)
>   804 13:50:19.747157  <4>[   16.535431] pstate: 80000005 (Nzcv daif -PAN=
 -UAO -TCO -DIT -SSBS BTYPE=3D--)
>   805 13:50:19.758468  <4>[   16.535442] pc : clk_imx8mp_audiomix_runtime=
_resume+0x24/0x48
>   806 13:50:19.759372  <4>[   16.535456] lr : pm_generic_runtime_resume+0=
x2c/0x44
>   807 13:50:19.759587  <4>[   16.535465] sp : ffff800082b8bb90
>   808 13:50:19.774512  <4>[   16.535468] x29: ffff800082b8bb90 x28: 00000=
00000000000 x27: 0000000000000000
>   809 13:50:19.775367  <4>[   16.535482] x26: 0000000000000000 x25: 00000=
00000000000 x24: 0000000000000000
>   810 13:50:19.790567  <4>[   16.535495] x23: ffff0000c0f7a4e0 x22: ffff0=
000c26922f8 x21: 0000000000000000
>   811 13:50:19.791308  <4>[   16.535508] x20: ffff0000c2692000 x19: ffff0=
000c0e30c10 x18: 0000000000000000
>   812 13:50:19.794834  <4>[   16.535521] x17: 000000007e4712cb x16: ffff8=
0008296f800 x15: 0000000000000030
>   813 13:50:19.807341  <4>[   16.535532] x14: ffff0000c00b8080 x13: 00000=
000000003f9 x12: 0000000000000000
>   814 13:50:19.810740  <4>[   16.535545] x11: 0000000000000000 x10: 00000=
00000000aa0 x9 : ffff800082b8bb20
>   815 13:50:19.822528  <4>[   16.535559] x8 : ffff0000c00b8b00 x7 : 00000=
00000000000 x6 : ffff0000c00b8000
>   816 13:50:19.827173  <4>[   16.535570] x5 : ffff8000836b0000 x4 : ffff0=
000c2f3a488 x3 : ffff8000813660d0
>   817 13:50:19.838446  <4>[   16.535583] x2 : 0000000000000004 x1 : 00000=
00000000001 x0 : 00000000ff777777
>   818 13:50:19.839321  <0>[   16.535597] Kernel panic - not syncing: Asyn=
chronous SError Interrupt
>   819 13:50:19.839983  Matched prompt #9: Kernel panic - not syncing
>   820 13:50:19.840155  Setting prompt string to ['end Kernel panic[^\\r]*=
\\r', '/ #', 'Login timed out', 'Login incorrect']
>   821 13:50:19.854524  <4>[   16.535601] CPU: 2 PID: 1 Comm: swapper/0 No=
t tainted 6.9.0-rc5-next-20240424 #1
>   822 13:50:19.855261  <4>[   16.535609] Hardware name: Toradex Verdin iM=
X8M Plus on Dahlia Board (DT)
>   823 13:50:19.858660  <4>[   16.535613] Call trace:
>   824 13:50:19.870455  <4>[   16.535616]  dump_backtrace+0x94/0xec
>   825 13:50:19.870763  <4>[   16.535626]  show_stack+0x18/0x24
>   826 13:50:19.871258  <4>[   16.535635]  dump_stack_lvl+0x38/0x90
>   827 13:50:19.874714  <4>[   16.535647]  dump_stack+0x18/0x24
>   828 13:50:19.874964  <4>[   16.535656]  panic+0x388/0x3c8
>   829 13:50:19.886551  <4>[   16.535667]  nmi_panic+0x48/0x94
>   830 13:50:19.888318  <4>[   16.535679]  arm64_serror_panic+0x6c/0x78
>   831 13:50:19.888531  <4>[   16.535688]  do_serror+0x3c/0x78
>   832 13:50:19.892592  <4>[   16.535693]  el1h_64_error_handler+0x30/0x48
>   833 13:50:19.902540  <4>[   16.535703]  el1h_64_error+0x64/0x68
>   834 13:50:19.903437  <4>[   16.535709]  clk_imx8mp_audiomix_runtime_res=
ume+0x24/0x48
>   835 13:50:19.907712  <4>[   16.535719]  __genpd_runtime_resume+0x30/0xa=
8
>   836 13:50:19.918505  <4>[   16.535729]  genpd_runtime_resume+0xb4/0x29c
>   837 13:50:19.918770  <4>[   16.535741]  __rpm_callback+0x48/0x198
>   838 13:50:19.919372  <4>[   16.535749]  rpm_callback+0x68/0x74
>   839 13:50:19.922715  <4>[   16.535754]  rpm_resume+0x3cc/0x680
>   840 13:50:19.934495  <4>[   16.535762]  __pm_runtime_resume+0x4c/0x90
>   841 13:50:19.934784  <4>[   16.535769]  clk_pm_runtime_get_all+0x58/0x1=
64
>   842 13:50:19.935344  <4>[   16.535780]  clk_disable_unused+0x2c/0x178
>   843 13:50:19.938873  <4>[   16.535793]  do_one_initcall+0x6c/0x1b0
>   844 13:50:19.950539  <4>[   16.535799]  kernel_init_freeable+0x1c8/0x29=
0
>   845 13:50:19.951360  <4>[   16.535812]  kernel_init+0x20/0x1dc
>   846 13:50:19.951585  <4>[   16.535821]  ret_from_fork+0x10/0x20
>   847 13:50:19.954803  <2>[   16.535831] SMP: stopping secondary CPUs
>   848 13:50:19.966688  <0>[   16.535838] Kernel Offset: disabled
>   849 13:50:19.967221  <0>[   16.535841] CPU features: 0x0,00000040,00100=
000,4200421b
>   850 13:50:19.967360  <0>[   16.535845] Memory Limit: none
>   851 13:50:19.985117  <0>[   16.788060] ---[ end Kernel panic - not sync=
ing: Asynchronous SError Interrupt ]---
>
> from
>
> https://storage.kernelci.org/next/master/next-20240424/arm64/defconfig/gc=
c-10/lab-broonie/baseline-imx8mp-verdin-nonwifi-dahlia.html
> https://lore.kernel.org/all/66293535.170a0220.21fe.a2e7@mx.google.com/
>

Sorry that I didn't use a clean community kernel for the test.
On my local side I added delay in drivers/pmdomain/imx/gpcv2.c
so there was no such issue.

But according to drivers/pmdomain/imx/gpcv2.c, seems that I need
to add delay in this driver, like this:

 static int clk_imx8mp_audiomix_runtime_resume(struct device *dev)
 {
+       /*
+        * According to the drivers/pmdomain/imx/gpcv2.c
+        * need to wait for reset to propagate
+        */
+       udelay(5);
+

I will submit a patch for it.

Thanks for reporting it

Best regards
Shengjiu Wang



> Francesco
>

