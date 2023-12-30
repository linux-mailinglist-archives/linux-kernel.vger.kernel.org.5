Return-Path: <linux-kernel+bounces-13367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2FF820413
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6873B21041
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627931FCF;
	Sat, 30 Dec 2023 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="kPtzuGcU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB322291D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M3IbXD47V+68pz6eRVZ5zyb6qExz4Zb8clyjB1ECu2c=;
  b=kPtzuGcUZn4BJZXKFnhzJC6swibobBy8sKGy1f6n8fQBdusFsJaTVUex
   qgrypwgGUM9nOB1D2NnA+bbszVU14Abz85G10S829Qc6MhAsaFXuZvxfA
   4VIhz40rPx3Lrsb2VBfJarruL9ji5LRErW/9qDHgFmqsbXe7w/kfyo3NV
   0=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,317,1695679200"; 
   d="scan'208";a="144357072"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2023 09:56:00 +0100
Date: Sat, 30 Dec 2023 09:56:00 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Thomas Zimmermann <tzimmermann@suse.de>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: drivers/video/fbdev/core/fb_logo.c:67:41-42: WARNING opportunity
 for min() (fwd)
Message-ID: <alpine.DEB.2.22.394.2312300955341.3057@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Sat, 30 Dec 2023 15:22:13 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/video/fbdev/core/fb_logo.c:67:41-42: WARNING opportunity for
    min()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Thomas Zimmermann <tzimmermann@suse.de>

Hi Thomas,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f016f7547aeedefed9450499d002ba983b8fce15
commit: 8887086ef2e0047ec321103a15e7d766be3a3874 fbdev/core: Move logo functions into separate source file
date:   4 months ago
:::::: branch date: 11 hours ago
:::::: commit date: 4 months ago
config: hexagon-randconfig-r052-20231228 (https://download.01.org/0day-ci/archive/20231230/202312301511.93E0cv5e-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project d3ef86708241a3bee902615c190dead1638c4e09)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202312301511.93E0cv5e-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/video/fbdev/core/fb_logo.c:67:41-42: WARNING opportunity for min()
   drivers/video/fbdev/core/fb_logo.c:68:41-42: WARNING opportunity for min()
   drivers/video/fbdev/core/fb_logo.c:69:41-42: WARNING opportunity for min()

vim +67 drivers/video/fbdev/core/fb_logo.c

8887086ef2e004 Thomas Zimmermann 2023-09-07  49
8887086ef2e004 Thomas Zimmermann 2023-09-07  50  static void  fb_set_logo_truepalette(struct fb_info *info,
8887086ef2e004 Thomas Zimmermann 2023-09-07  51  					    const struct linux_logo *logo,
8887086ef2e004 Thomas Zimmermann 2023-09-07  52  					    u32 *palette)
8887086ef2e004 Thomas Zimmermann 2023-09-07  53  {
8887086ef2e004 Thomas Zimmermann 2023-09-07  54  	static const unsigned char mask[] = {
8887086ef2e004 Thomas Zimmermann 2023-09-07  55  		0, 0x80, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc, 0xfe, 0xff
8887086ef2e004 Thomas Zimmermann 2023-09-07  56  	};
8887086ef2e004 Thomas Zimmermann 2023-09-07  57  	unsigned char redmask, greenmask, bluemask;
8887086ef2e004 Thomas Zimmermann 2023-09-07  58  	int redshift, greenshift, blueshift;
8887086ef2e004 Thomas Zimmermann 2023-09-07  59  	int i;
8887086ef2e004 Thomas Zimmermann 2023-09-07  60  	const unsigned char *clut = logo->clut;
8887086ef2e004 Thomas Zimmermann 2023-09-07  61
8887086ef2e004 Thomas Zimmermann 2023-09-07  62  	/*
8887086ef2e004 Thomas Zimmermann 2023-09-07  63  	 * We have to create a temporary palette since console palette is only
8887086ef2e004 Thomas Zimmermann 2023-09-07  64  	 * 16 colors long.
8887086ef2e004 Thomas Zimmermann 2023-09-07  65  	 */
8887086ef2e004 Thomas Zimmermann 2023-09-07  66  	/* Bug: Doesn't obey msb_right ... (who needs that?) */
8887086ef2e004 Thomas Zimmermann 2023-09-07 @67  	redmask   = mask[info->var.red.length   < 8 ? info->var.red.length   : 8];
8887086ef2e004 Thomas Zimmermann 2023-09-07  68  	greenmask = mask[info->var.green.length < 8 ? info->var.green.length : 8];
8887086ef2e004 Thomas Zimmermann 2023-09-07  69  	bluemask  = mask[info->var.blue.length  < 8 ? info->var.blue.length  : 8];
8887086ef2e004 Thomas Zimmermann 2023-09-07  70  	redshift   = info->var.red.offset   - (8 - info->var.red.length);
8887086ef2e004 Thomas Zimmermann 2023-09-07  71  	greenshift = info->var.green.offset - (8 - info->var.green.length);
8887086ef2e004 Thomas Zimmermann 2023-09-07  72  	blueshift  = info->var.blue.offset  - (8 - info->var.blue.length);
8887086ef2e004 Thomas Zimmermann 2023-09-07  73
8887086ef2e004 Thomas Zimmermann 2023-09-07  74  	for (i = 0; i < logo->clutsize; i++) {
8887086ef2e004 Thomas Zimmermann 2023-09-07  75  		palette[i+32] = (safe_shift((clut[0] & redmask), redshift) |
8887086ef2e004 Thomas Zimmermann 2023-09-07  76  				 safe_shift((clut[1] & greenmask), greenshift) |
8887086ef2e004 Thomas Zimmermann 2023-09-07  77  				 safe_shift((clut[2] & bluemask), blueshift));
8887086ef2e004 Thomas Zimmermann 2023-09-07  78  		clut += 3;
8887086ef2e004 Thomas Zimmermann 2023-09-07  79  	}
8887086ef2e004 Thomas Zimmermann 2023-09-07  80  }
8887086ef2e004 Thomas Zimmermann 2023-09-07  81

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

