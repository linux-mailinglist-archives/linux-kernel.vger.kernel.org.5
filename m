Return-Path: <linux-kernel+bounces-14363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F819821C1A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A5171C21E94
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C16F517;
	Tue,  2 Jan 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="FxQgKHCj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D251FBE9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qQxJbCIkmDYYJnQt+0XBTATvSbhlYbOVPvjbeGHG/ok=;
  b=FxQgKHCjEBD3m2QdjbsRhNqnWgBKUeY+/z+6yRsbt9qF4HEX/dX4bQ26
   HdqlALWwlnucuuzUoqEQvlm3nqoS4kNRkDQPC2Ny+0UOGvaS/yY+/XNeP
   IP8ai8d6KGSi+A47TSB3fcTMhYIekcRYKGmrcHbPpWPlTRLhz7HnLmKy6
   I=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,325,1695679200"; 
   d="scan'208";a="144567861"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 13:55:38 +0100
Date: Tue, 2 Jan 2024 13:55:38 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Shenghao Ding <13916275206@139.com>, Mark Brown <broonie@kernel.org>
cc: linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Subject: sound/soc/codecs/tas2781-i2c.c:255:26-27: WARNING opportunity for
 min() (fwd)
Message-ID: <a378fc2-7cf4-a7bf-f8d5-8260223a4f@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



---------- Forwarded message ----------
Date: Tue, 2 Jan 2024 19:53:21 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: sound/soc/codecs/tas2781-i2c.c:255:26-27: WARNING opportunity for min()

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Shenghao Ding <13916275206@139.com>
CC: Mark Brown <broonie@kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   610a9b8f49fbcf1100716370d3b5f6f884a2835a
commit: ef3bcde75d06d65f78ba38a30d5a87fb83a5cdae ASoC: tas2781: Add tas2781 driver
date:   7 months ago
:::::: branch date: 2 days ago
:::::: commit date: 7 months ago
config: sparc64-randconfig-r051-20240102 (https://download.01.org/0day-ci/archive/20240102/202401021929.eW58tuKw-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202401021929.eW58tuKw-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> sound/soc/codecs/tas2781-i2c.c:255:26-27: WARNING opportunity for min()
   sound/soc/codecs/tas2781-i2c.c:365:14-15: WARNING opportunity for min()

vim +255 sound/soc/codecs/tas2781-i2c.c

ef3bcde75d06d6 Shenghao Ding 2023-06-18  223
ef3bcde75d06d6 Shenghao Ding 2023-06-18  224  static int tasdevice_create_control(struct tasdevice_priv *tas_priv)
ef3bcde75d06d6 Shenghao Ding 2023-06-18  225  {
ef3bcde75d06d6 Shenghao Ding 2023-06-18  226  	struct snd_kcontrol_new *prof_ctrls;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  227  	int nr_controls = 1;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  228  	int mix_index = 0;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  229  	int ret;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  230  	char *name;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  231
ef3bcde75d06d6 Shenghao Ding 2023-06-18  232  	prof_ctrls = devm_kcalloc(tas_priv->dev, nr_controls,
ef3bcde75d06d6 Shenghao Ding 2023-06-18  233  		sizeof(prof_ctrls[0]), GFP_KERNEL);
ef3bcde75d06d6 Shenghao Ding 2023-06-18  234  	if (!prof_ctrls) {
ef3bcde75d06d6 Shenghao Ding 2023-06-18  235  		ret = -ENOMEM;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  236  		goto out;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  237  	}
ef3bcde75d06d6 Shenghao Ding 2023-06-18  238
ef3bcde75d06d6 Shenghao Ding 2023-06-18  239  	/* Create a mixer item for selecting the active profile */
ef3bcde75d06d6 Shenghao Ding 2023-06-18  240  	name = devm_kzalloc(tas_priv->dev, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
ef3bcde75d06d6 Shenghao Ding 2023-06-18  241  		GFP_KERNEL);
ef3bcde75d06d6 Shenghao Ding 2023-06-18  242  	if (!name) {
ef3bcde75d06d6 Shenghao Ding 2023-06-18  243  		ret = -ENOMEM;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  244  		goto out;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  245  	}
ef3bcde75d06d6 Shenghao Ding 2023-06-18  246  	scnprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "Speaker Profile Id");
ef3bcde75d06d6 Shenghao Ding 2023-06-18  247  	prof_ctrls[mix_index].name = name;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  248  	prof_ctrls[mix_index].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  249  	prof_ctrls[mix_index].info = tasdevice_info_profile;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  250  	prof_ctrls[mix_index].get = tasdevice_get_profile_id;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  251  	prof_ctrls[mix_index].put = tasdevice_set_profile_id;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  252  	mix_index++;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  253
ef3bcde75d06d6 Shenghao Ding 2023-06-18  254  	ret = snd_soc_add_component_controls(tas_priv->codec,
ef3bcde75d06d6 Shenghao Ding 2023-06-18 @255  		prof_ctrls, nr_controls < mix_index ? nr_controls : mix_index);
ef3bcde75d06d6 Shenghao Ding 2023-06-18  256
ef3bcde75d06d6 Shenghao Ding 2023-06-18  257  out:
ef3bcde75d06d6 Shenghao Ding 2023-06-18  258  	return ret;
ef3bcde75d06d6 Shenghao Ding 2023-06-18  259  }
ef3bcde75d06d6 Shenghao Ding 2023-06-18  260

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

