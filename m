Return-Path: <linux-kernel+bounces-157348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E478B1028
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37A9284E47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB48516C6B0;
	Wed, 24 Apr 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="rgIlnbQP"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA1A15EFA8;
	Wed, 24 Apr 2024 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977262; cv=none; b=tUqePdLAeysdUDHzMOqZlNDKTraAW73cASwzpFjp4cSrcNYY5w1RrUFTYFGBcSl2WdTbiq8iBsXpq53zsH1BaL4Db+IH93OuvrvXeov1ksidPm/dNh10lp6FTmNn4Qxj+ANYJHm44NjMh54xxXJzHq3YG2MYur313aGNmg9mXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977262; c=relaxed/simple;
	bh=W2hSu3Tw2jrGRs62685kwdip1Rqx3/KD21TSZKvKPWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulrGWX02g1JuvjN3yKDlrxq4xlFiYSm9UyhiQYqm5ZxTpZBM4f7N8Uaks0fE1t/ZB+W6sPFhsAbuNmFMYPnrVUP7bi9GNTPHqfl9ZdQdhWWvSzrqXb0vDKXKe/LYvkAdWiHSTAnC1ktK02qLboeJGsX7rmaiBFfGcRL+J8Uo0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=rgIlnbQP; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 6A9651F91A;
	Wed, 24 Apr 2024 18:47:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1713977250;
	bh=CEyIxy0Pu5MvS9161KdT+XnMhANEJ56b0Hj+87k4Oac=; h=From:To:Subject;
	b=rgIlnbQPeqqHdzuyHXQ3WE4jCmOjVnzJgOftURdCJxnddar+i3SfncEERDq1GxQ75
	 GqNrEsEPtIVh5gxeb/V6jhIq9t/ohR17vmJ2vU04BcYWrWY1YnJcgNEL0t/JivefPS
	 v5tNAE9STFF5xy5GFMD2DebOHrAaOC9rxt4PRGA/CSljkdn2UJPeUZwswIvUbpAU4z
	 MxTKeuijoCKnOE3AS6+zZ0FClOOHcKy6CpNcKknHrPKTtzmWDUY9+nVX1hAuATgWcB
	 zeglH+Dul3AzPj7ykrjkw7idf5QCeOIy5f+ocEjd8FqsGmQCdjYSODOSbnKgocBSY/
	 Tig4Kupqo2Cfg==
Date: Wed, 24 Apr 2024 18:47:25 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	shengjiu.wang@gmail.com, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] clk: imx: imx8mp: Add pm_runtime support for power
 saving
Message-ID: <20240424164725.GA18760@francesco-nb>
References: <1711026842-7268-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711026842-7268-1-git-send-email-shengjiu.wang@nxp.com>

On Thu, Mar 21, 2024 at 09:14:02PM +0800, Shengjiu Wang wrote:
> Add pm_runtime support for power saving. In pm runtime suspend
> state the registers will be reseted, so add registers save
> in pm runtime suspend and restore them in pm runtime resume.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Is this introducing a regression?

  800 13:50:19.713052  <6>[   16.531134] clk: Disabling unused clocks
  801 13:50:19.727524  <2>[   16.535413] SError Interrupt on CPU2, code 0x00000000bf000002 -- SError
  802 13:50:19.731400  <4>[   16.535421] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5-next-20240424 #1
  803 13:50:19.742514  <4>[   16.535428] Hardware name: Toradex Verdin iMX8M Plus on Dahlia Board (DT)
  804 13:50:19.747157  <4>[   16.535431] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  805 13:50:19.758468  <4>[   16.535442] pc : clk_imx8mp_audiomix_runtime_resume+0x24/0x48
  806 13:50:19.759372  <4>[   16.535456] lr : pm_generic_runtime_resume+0x2c/0x44
  807 13:50:19.759587  <4>[   16.535465] sp : ffff800082b8bb90
  808 13:50:19.774512  <4>[   16.535468] x29: ffff800082b8bb90 x28: 0000000000000000 x27: 0000000000000000
  809 13:50:19.775367  <4>[   16.535482] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
  810 13:50:19.790567  <4>[   16.535495] x23: ffff0000c0f7a4e0 x22: ffff0000c26922f8 x21: 0000000000000000
  811 13:50:19.791308  <4>[   16.535508] x20: ffff0000c2692000 x19: ffff0000c0e30c10 x18: 0000000000000000
  812 13:50:19.794834  <4>[   16.535521] x17: 000000007e4712cb x16: ffff80008296f800 x15: 0000000000000030
  813 13:50:19.807341  <4>[   16.535532] x14: ffff0000c00b8080 x13: 00000000000003f9 x12: 0000000000000000
  814 13:50:19.810740  <4>[   16.535545] x11: 0000000000000000 x10: 0000000000000aa0 x9 : ffff800082b8bb20
  815 13:50:19.822528  <4>[   16.535559] x8 : ffff0000c00b8b00 x7 : 0000000000000000 x6 : ffff0000c00b8000
  816 13:50:19.827173  <4>[   16.535570] x5 : ffff8000836b0000 x4 : ffff0000c2f3a488 x3 : ffff8000813660d0
  817 13:50:19.838446  <4>[   16.535583] x2 : 0000000000000004 x1 : 0000000000000001 x0 : 00000000ff777777
  818 13:50:19.839321  <0>[   16.535597] Kernel panic - not syncing: Asynchronous SError Interrupt
  819 13:50:19.839983  Matched prompt #9: Kernel panic - not syncing
  820 13:50:19.840155  Setting prompt string to ['end Kernel panic[^\\r]*\\r', '/ #', 'Login timed out', 'Login incorrect']
  821 13:50:19.854524  <4>[   16.535601] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5-next-20240424 #1
  822 13:50:19.855261  <4>[   16.535609] Hardware name: Toradex Verdin iMX8M Plus on Dahlia Board (DT)
  823 13:50:19.858660  <4>[   16.535613] Call trace:
  824 13:50:19.870455  <4>[   16.535616]  dump_backtrace+0x94/0xec
  825 13:50:19.870763  <4>[   16.535626]  show_stack+0x18/0x24
  826 13:50:19.871258  <4>[   16.535635]  dump_stack_lvl+0x38/0x90
  827 13:50:19.874714  <4>[   16.535647]  dump_stack+0x18/0x24
  828 13:50:19.874964  <4>[   16.535656]  panic+0x388/0x3c8
  829 13:50:19.886551  <4>[   16.535667]  nmi_panic+0x48/0x94
  830 13:50:19.888318  <4>[   16.535679]  arm64_serror_panic+0x6c/0x78
  831 13:50:19.888531  <4>[   16.535688]  do_serror+0x3c/0x78
  832 13:50:19.892592  <4>[   16.535693]  el1h_64_error_handler+0x30/0x48
  833 13:50:19.902540  <4>[   16.535703]  el1h_64_error+0x64/0x68
  834 13:50:19.903437  <4>[   16.535709]  clk_imx8mp_audiomix_runtime_resume+0x24/0x48
  835 13:50:19.907712  <4>[   16.535719]  __genpd_runtime_resume+0x30/0xa8
  836 13:50:19.918505  <4>[   16.535729]  genpd_runtime_resume+0xb4/0x29c
  837 13:50:19.918770  <4>[   16.535741]  __rpm_callback+0x48/0x198
  838 13:50:19.919372  <4>[   16.535749]  rpm_callback+0x68/0x74
  839 13:50:19.922715  <4>[   16.535754]  rpm_resume+0x3cc/0x680
  840 13:50:19.934495  <4>[   16.535762]  __pm_runtime_resume+0x4c/0x90
  841 13:50:19.934784  <4>[   16.535769]  clk_pm_runtime_get_all+0x58/0x164
  842 13:50:19.935344  <4>[   16.535780]  clk_disable_unused+0x2c/0x178
  843 13:50:19.938873  <4>[   16.535793]  do_one_initcall+0x6c/0x1b0
  844 13:50:19.950539  <4>[   16.535799]  kernel_init_freeable+0x1c8/0x290
  845 13:50:19.951360  <4>[   16.535812]  kernel_init+0x20/0x1dc
  846 13:50:19.951585  <4>[   16.535821]  ret_from_fork+0x10/0x20
  847 13:50:19.954803  <2>[   16.535831] SMP: stopping secondary CPUs
  848 13:50:19.966688  <0>[   16.535838] Kernel Offset: disabled
  849 13:50:19.967221  <0>[   16.535841] CPU features: 0x0,00000040,00100000,4200421b
  850 13:50:19.967360  <0>[   16.535845] Memory Limit: none
  851 13:50:19.985117  <0>[   16.788060] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

from

https://storage.kernelci.org/next/master/next-20240424/arm64/defconfig/gcc-10/lab-broonie/baseline-imx8mp-verdin-nonwifi-dahlia.html
https://lore.kernel.org/all/66293535.170a0220.21fe.a2e7@mx.google.com/

Francesco


