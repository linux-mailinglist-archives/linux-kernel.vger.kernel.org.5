Return-Path: <linux-kernel+bounces-41237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8724B83EDD4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AB528314C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD6328DC3;
	Sat, 27 Jan 2024 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="erE/6TGz"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D707F28DD0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706368532; cv=none; b=iethqRTekYsAhTT5fwKlmr6pbzVCTwXXeeOla4DtWWV5vsUPbQrYkRjy4TQtUzSZPP6Rvip3TQEINuV6mm7TIqSH5pkIqnzueirjZOzSB6o3kzHw62L8kGdMHOpf5h8k73aEwAXv0ZPhE6S5lnGVFBNwF9Hy5VS3OuOnrytuRto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706368532; c=relaxed/simple;
	bh=2RfS1NTT3mAlcDXd2NzAnrdw/nl+hu+8H48V1Vrv/O0=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=uBC9EOvKvBgtTaJG1vnawLMLfoKzSErIh1P4GcILrQuq95NRjARKuol5LOwSz17axDtl5oNTWcimrJInt73wXezLSoYCdZMvqmW7EbP7gEw9N8xohCEwnFizy3r+NbEUbhlvIIfWIE6ZovMquYNqElv2Ugx1R00E+2TDcw5SyEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=erE/6TGz; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OjuS/6K6iRxZGOHXIL2Nqip206PzuqRpaVhiwnYs3cg=;
  b=erE/6TGzN6U+cfWe8YK843Vki2FRvQiLTowC17xPIVW+WmOFNvmAZH0H
   7sGMbMowQo4NGCI0BNsb5OJviwdCNMzTN0s0fnyMk55JkpyI/9CwFURek
   cEmZdh83EVRfWPlOsKCqcbfVdqP7Z5PTB4/eQX2FvTYHLRp5GkSMKkIZl
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,220,1701126000"; 
   d="scan'208";a="77995086"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 16:15:27 +0100
Date: Sat, 27 Jan 2024 16:15:26 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Walker Chen <walker.chen@starfivetech.com>
cc: Mark Brown <broonie@kernel.org>, 
    Claudiu Beznea <claudiu.beznea@microchip.com>, 
    linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: sound/soc/starfive/jh7110_tdm.c:198:16-18: WARNING opportunity for
 max() (fwd)
Message-ID: <alpine.DEB.2.22.394.2401271614550.3247@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Sat, 27 Jan 2024 22:30:10 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: sound/soc/starfive/jh7110_tdm.c:198:16-18: WARNING opportunity for
    max()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Walker Chen <walker.chen@starfivetech.com>
CC: Mark Brown <broonie@kernel.org>
CC: Claudiu Beznea <claudiu.beznea@microchip.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3a5879d495b226d0404098e3564462d5f1daa33b
commit: fd4762b6b5cfa27bf44f5d624ce74b7dce4a479c ASoC: starfive: Add JH7110 TDM driver
date:   8 months ago
:::::: branch date: 15 hours ago
:::::: commit date: 8 months ago
config: openrisc-randconfig-r053-20240127 (https://download.01.org/0day-ci/archive/20240127/202401272205.TWGHvmpR-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202401272205.TWGHvmpR-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> sound/soc/starfive/jh7110_tdm.c:198:16-18: WARNING opportunity for max()
   sound/soc/starfive/jh7110_tdm.c:203:20-22: WARNING opportunity for max()

vim +198 sound/soc/starfive/jh7110_tdm.c

fd4762b6b5cfa2 Walker Chen 2023-05-26  193
fd4762b6b5cfa2 Walker Chen 2023-05-26  194  static int jh7110_tdm_syncdiv(struct jh7110_tdm_dev *tdm)
fd4762b6b5cfa2 Walker Chen 2023-05-26  195  {
fd4762b6b5cfa2 Walker Chen 2023-05-26  196  	u32 sl, sscale, syncdiv;
fd4762b6b5cfa2 Walker Chen 2023-05-26  197
fd4762b6b5cfa2 Walker Chen 2023-05-26 @198  	if (tdm->rx.sl >= tdm->tx.sl)
fd4762b6b5cfa2 Walker Chen 2023-05-26  199  		sl = tdm->rx.sl;
fd4762b6b5cfa2 Walker Chen 2023-05-26  200  	else
fd4762b6b5cfa2 Walker Chen 2023-05-26  201  		sl = tdm->tx.sl;
fd4762b6b5cfa2 Walker Chen 2023-05-26  202
fd4762b6b5cfa2 Walker Chen 2023-05-26  203  	if (tdm->rx.sscale >= tdm->tx.sscale)
fd4762b6b5cfa2 Walker Chen 2023-05-26  204  		sscale = tdm->rx.sscale;
fd4762b6b5cfa2 Walker Chen 2023-05-26  205  	else
fd4762b6b5cfa2 Walker Chen 2023-05-26  206  		sscale = tdm->tx.sscale;
fd4762b6b5cfa2 Walker Chen 2023-05-26  207
fd4762b6b5cfa2 Walker Chen 2023-05-26  208  	syncdiv = tdm->pcmclk / tdm->samplerate - 1;
fd4762b6b5cfa2 Walker Chen 2023-05-26  209
fd4762b6b5cfa2 Walker Chen 2023-05-26  210  	if ((syncdiv + 1) < (sl * sscale)) {
fd4762b6b5cfa2 Walker Chen 2023-05-26  211  		dev_err(tdm->dev, "Failed to set syncdiv!\n");
fd4762b6b5cfa2 Walker Chen 2023-05-26  212  		return -EINVAL;
fd4762b6b5cfa2 Walker Chen 2023-05-26  213  	}
fd4762b6b5cfa2 Walker Chen 2023-05-26  214
fd4762b6b5cfa2 Walker Chen 2023-05-26  215  	if (tdm->syncm == TDM_SYNCM_LONG &&
fd4762b6b5cfa2 Walker Chen 2023-05-26  216  	    (tdm->rx.sscale <= 1 || tdm->tx.sscale <= 1) &&
fd4762b6b5cfa2 Walker Chen 2023-05-26  217  	    ((syncdiv + 1) <= sl)) {
fd4762b6b5cfa2 Walker Chen 2023-05-26  218  		dev_err(tdm->dev, "Wrong syncdiv! It must be (syncdiv+1) > max[tx.sl, rx.sl]\n");
fd4762b6b5cfa2 Walker Chen 2023-05-26  219  		return -EINVAL;
fd4762b6b5cfa2 Walker Chen 2023-05-26  220  	}
fd4762b6b5cfa2 Walker Chen 2023-05-26  221
fd4762b6b5cfa2 Walker Chen 2023-05-26  222  	jh7110_tdm_writel(tdm, TDM_PCMDIV, syncdiv);
fd4762b6b5cfa2 Walker Chen 2023-05-26  223  	return 0;
fd4762b6b5cfa2 Walker Chen 2023-05-26  224  }
fd4762b6b5cfa2 Walker Chen 2023-05-26  225

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

