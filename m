Return-Path: <linux-kernel+bounces-152059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6628AB826
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 02:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3301F21677
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141E6749F;
	Sat, 20 Apr 2024 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UgLUGUDM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5561B7FD
	for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2024 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713573383; cv=none; b=rS2jD52v/3pdG2WHbx+KgFLCKiiupIxgVceEnQlS3DF5qtVrWNm8KyBcNgETWv9b7Zf9SdCbFX5wjL/P5oE/1oRx5ctoBr8yEUje21J/n3CkbvllmbvgICt9ounqQ4ClpdiZeLX+pxr987YGt4H5no8Se7wWtO3wQ3x16CU50oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713573383; c=relaxed/simple;
	bh=m51NSbeRW1aR2kCl5AYiN8+JkNorVMGlZphwn7wu5zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJnxBEZrxx5kt51PCsow+pUS6GAsYXULsWMB+Usnu5tXXsRNqZpx5NaA0q9Tsd6df4pMaEX8V5s7T29WrblMvHye9jvDP6rc7n3W0MaHGWc0XkKTXGaYUq/dTsa76niM+3c0WS8OzRrYsodxQwEFn2Habvlj0bqmkTG66PrdESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UgLUGUDM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713573381; x=1745109381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m51NSbeRW1aR2kCl5AYiN8+JkNorVMGlZphwn7wu5zk=;
  b=UgLUGUDMpFbGJAZDFCndCsY8HW1wropnAefcHhXbQqMX19F80q4QNyio
   yBdyEDmzcDFWeKn/PZEk/kszvXteM7Mr6xaQZ038dd1FQp6+eyY40vL3B
   LBVCKe86Wm3RitBo02qakgRWeMop8FWfKGSsO7PCkm/FOslQ6umKogZWd
   SX6Ku0IGgFg2m7B5jIV2dKgSltt3jM6pErDaain/pACs3Jwrh17P0HRK4
   qj9lgAP0iNPUIpLtyoRGoSd6tvglCuasIrJeZ0OtPfGCPHImqQEban7ye
   MVTlhluNxmrIRmFs+iXQV1hARkDEChQUCVO6nSVHWyc0DiaWmqvfxFm6C
   A==;
X-CSE-ConnectionGUID: XXIuO2wXThqK4iaEDCa1Nw==
X-CSE-MsgGUID: tHldw57GRPqJTiUJem/XIQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="9114260"
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="9114260"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 17:36:18 -0700
X-CSE-ConnectionGUID: XKo1LpvoS5KRAz13pVyjZQ==
X-CSE-MsgGUID: yqADTWoNThajbc9tYTRdaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,215,1708416000"; 
   d="scan'208";a="23546754"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 19 Apr 2024 17:36:16 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxyiD-000AbO-0z;
	Sat, 20 Apr 2024 00:36:13 +0000
Date: Sat, 20 Apr 2024 08:35:22 +0800
From: kernel test robot <lkp@intel.com>
To: srinivas.kandagatla@linaro.org, broonie@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, perex@perex.cz,
	tiwai@suse.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, steev@kali.org,
	jenneron@postmarketos.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 3/4] ASoC: qcom: sc8280xp: add Display port Jack
Message-ID: <202404200850.ZXhk0PO1-lkp@intel.com>
References: <20240419150140.92527-4-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419150140.92527-4-srinivas.kandagatla@linaro.org>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on linus/master v6.9-rc4 next-20240419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/srinivas-kandagatla-linaro-org/ASoC-qcom-q6dsp-parse-Display-port-tokens/20240419-230514
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
patch link:    https://lore.kernel.org/r/20240419150140.92527-4-srinivas.kandagatla%40linaro.org
patch subject: [PATCH 3/4] ASoC: qcom: sc8280xp: add Display port Jack
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240420/202404200850.ZXhk0PO1-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7089c359a3845323f6f30c44a47dd901f2edfe63)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240420/202404200850.ZXhk0PO1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404200850.ZXhk0PO1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from sound/soc/qcom/sc8280xp.c:7:
   In file included from include/sound/soc.h:19:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from sound/soc/qcom/sc8280xp.c:7:
   In file included from include/sound/soc.h:19:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from sound/soc/qcom/sc8280xp.c:7:
   In file included from include/sound/soc.h:19:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from sound/soc/qcom/sc8280xp.c:7:
   In file included from include/sound/soc.h:24:
   In file included from include/sound/pcm.h:15:
   In file included from include/linux/mm.h:2208:
   include/linux/vmstat.h:522:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     522 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> sound/soc/qcom/sc8280xp.c:54:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
      54 |         default:
         |         ^
   sound/soc/qcom/sc8280xp.c:54:2: note: insert 'break;' to avoid fall-through
      54 |         default:
         |         ^
         |         break; 
   8 warnings generated.


vim +54 sound/soc/qcom/sc8280xp.c

295aeea6646ad6 Srinivas Kandagatla 2022-09-16  25  
295aeea6646ad6 Srinivas Kandagatla 2022-09-16  26  static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
295aeea6646ad6 Srinivas Kandagatla 2022-09-16  27  {
295aeea6646ad6 Srinivas Kandagatla 2022-09-16  28  	struct sc8280xp_snd_data *data = snd_soc_card_get_drvdata(rtd->card);
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04  29  	struct snd_soc_dai *cpu_dai = snd_soc_rtd_to_cpu(rtd, 0);
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04  30  	struct snd_soc_card *card = rtd->card;
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  31  	struct snd_soc_jack *hdmi_jack  = NULL;
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  32  	int hdmi_pcm_id = 0;
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04  33  
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04  34  	switch (cpu_dai->id) {
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04  35  	case WSA_CODEC_DMA_RX_0:
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04  36  	case WSA_CODEC_DMA_RX_1:
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04  37  		/*
c481016bb4f8a9 Johan Hovold        2024-01-22  38  		 * Set limit of -3 dB on Digital Volume and 0 dB on PA Volume
c481016bb4f8a9 Johan Hovold        2024-01-22  39  		 * to reduce the risk of speaker damage until we have active
c481016bb4f8a9 Johan Hovold        2024-01-22  40  		 * speaker protection in place.
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04  41  		 */
c481016bb4f8a9 Johan Hovold        2024-01-22  42  		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 81);
c481016bb4f8a9 Johan Hovold        2024-01-22  43  		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 81);
c481016bb4f8a9 Johan Hovold        2024-01-22  44  		snd_soc_limit_volume(card, "SpkrLeft PA Volume", 17);
c481016bb4f8a9 Johan Hovold        2024-01-22  45  		snd_soc_limit_volume(card, "SpkrRight PA Volume", 17);
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04  46  		break;
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  47  	case DISPLAY_PORT_RX_0:
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  48  		hdmi_pcm_id = 0;
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  49  		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  50  		break;
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  51  	case DISPLAY_PORT_RX_1 ... DISPLAY_PORT_RX_7:
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  52  		hdmi_pcm_id = cpu_dai->id - DISPLAY_PORT_RX_1 + 1;
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  53  		hdmi_jack = &data->hdmi_jack[hdmi_pcm_id];
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04 @54  	default:
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04  55  		break;
716d4e5373e9d1 Srinivas Kandagatla 2023-12-04  56  	}
295aeea6646ad6 Srinivas Kandagatla 2022-09-16  57  
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  58  	if (hdmi_jack)
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  59  		return qcom_snd_dp_jack_setup(rtd, hdmi_jack, hdmi_pcm_id);
8dd5623cc9d92b Srinivas Kandagatla 2024-04-19  60  
295aeea6646ad6 Srinivas Kandagatla 2022-09-16  61  	return qcom_snd_wcd_jack_setup(rtd, &data->jack, &data->jack_setup);
295aeea6646ad6 Srinivas Kandagatla 2022-09-16  62  }
295aeea6646ad6 Srinivas Kandagatla 2022-09-16  63  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

