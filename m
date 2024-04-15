Return-Path: <linux-kernel+bounces-145308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 379AE8A526F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B10284188
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3500473530;
	Mon, 15 Apr 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="COmuzEfp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB13573191;
	Mon, 15 Apr 2024 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713189429; cv=none; b=oDApnSIqs1CK8Yi6INrauP6ylHnMyihfXZAFbjyTu1atZHzmc3oTj1HFN/5BxT3cpuevkCXJu6N05K9Gx6qERCf+EZQAvKP5pEgzcMyNG/wEAD7lm6eRj35I1CcQeDfo9GYUH5RZRUf2+/8RrCxv0K5DK2YXtIGdTKkN3nATkiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713189429; c=relaxed/simple;
	bh=FFFmuk3Sh3rIjA2N2SIYnU2di8Sv7qRk0RmCi36RXX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrx2TPp5xz6VMwT31ewgSrkULKTX+7uHAK6/TJpVucxuRxLT7BC/L4+1jhcgOS178GBNpgTO9IZCMM/IyAw+LEz8We7Y1TVNDo1GGSm8bOoG7nI6fpFZWJi4TW/ECjDFKc7LRi8FRp6u/J7kagvettxX/4KB4nstaLT1+ieG8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=COmuzEfp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713189427; x=1744725427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FFFmuk3Sh3rIjA2N2SIYnU2di8Sv7qRk0RmCi36RXX8=;
  b=COmuzEfp4RVYN18BF7FPy+b0fnoQYPYfaJ8jCAmRmKPgf5US4qVSdBkm
   wI21NRHzdfBD/J5PvdHhFQMSmAlLAHAyHzX1nuB+CmSiN3NHA2T7SWvS1
   dphZM4TVNOWuEZd7eCXeXUjZ4upfnBUABbGKdnimqLMp1BqYbfOsbybl0
   pPCnDTTMsB9Bpx5eghiqJKpYre1SbZRQ8ukULj+xzu2chA3vu9C+xPFI/
   0WNRhwm9Hjywacpo52edBmrev6kYEtMeIaHfy150R8w8GpUeu/FWdhg7g
   Hxd85VVopF2WFkvbPEKMt1XXMk75SYhITA2RU/JfFpvE6pABo9Dmath6V
   Q==;
X-CSE-ConnectionGUID: 8wwhY1sgRcCEIu+tzFv37A==
X-CSE-MsgGUID: YSWmDJT1Ra6vy6AVLGs5ew==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="19972042"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="19972042"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:57:06 -0700
X-CSE-ConnectionGUID: 7+1nZ9cnT7+N2KghsnO28Q==
X-CSE-MsgGUID: T2yAK3UEQfSyJQcpT7LylA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="26485040"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 15 Apr 2024 06:57:03 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rwMpR-0004Cs-0C;
	Mon, 15 Apr 2024 13:57:01 +0000
Date: Mon, 15 Apr 2024 21:56:52 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sudeep.holla@arm.com,
	cristian.marussi@arm.com, jassisinghbrar@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 2/2] mailbox: arm_mhuv3: Add driver
Message-ID: <202404152144.RtJxmEsQ-lkp@intel.com>
References: <20240412192801.554464-3-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412192801.554464-3-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on soc/for-next linus/master v6.9-rc4 next-20240415]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/dt-bindings-mailbox-arm-mhuv3-Add-bindings/20240415-094106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240412192801.554464-3-cristian.marussi%40arm.com
patch subject: [PATCH v4 2/2] mailbox: arm_mhuv3: Add driver
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240415/202404152144.RtJxmEsQ-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240415/202404152144.RtJxmEsQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404152144.RtJxmEsQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mailbox/arm_mhuv3.c: In function 'mhuv3_mbx_comb_interrupt':
>> drivers/mailbox/arm_mhuv3.c:922:17: error: cleanup argument not a function
     922 |                 void *data __free(kfree) = NULL;
         |                 ^~~~


vim +922 drivers/mailbox/arm_mhuv3.c

   910	
   911	static irqreturn_t mhuv3_mbx_comb_interrupt(int irq, void *arg)
   912	{
   913		unsigned int i, found = 0;
   914		struct mhuv3 *mhu = arg;
   915		struct mbox_chan *chan;
   916		struct device *dev;
   917		int ret = IRQ_NONE;
   918	
   919		dev = mhu->mbox.dev;
   920		for (i = 0; i < NUM_EXT; i++) {
   921			struct mhuv3_mbox_chan_priv *priv;
 > 922			void *data __free(kfree) = NULL;
   923	
   924			if (!mhu->ext[i])
   925				continue;
   926	
   927			/* Process any extension which could be source of the IRQ */
   928			chan = mhu->ext[i]->chan_from_comb_irq_get(mhu);
   929			if (IS_ERR(chan))
   930				continue;
   931	
   932			found++;
   933			/* From here on we need to call rx_complete even on error */
   934			priv = chan->con_priv;
   935			if (!chan->cl) {
   936				dev_warn(dev, "RX Data on UNBOUND channel (%u)\n",
   937					 priv->ch_idx);
   938				goto rx_ack;
   939			}
   940	
   941			/* Read optional in-band LE data first. */
   942			if (priv->ops->read_data) {
   943				data = priv->ops->read_data(mhu, chan);
   944				if (IS_ERR(data)) {
   945					dev_err(dev,
   946						"Failed to read in-band data. err:%ld\n",
   947						PTR_ERR(no_free_ptr(data)));
   948					goto rx_ack;
   949				}
   950			}
   951	
   952			mbox_chan_received_data(chan, data);
   953			ret = IRQ_HANDLED;
   954	
   955			/*
   956			 * Acknowledge transfer after any possible optional
   957			 * out-of-band data has also been retrieved via
   958			 * mbox_chan_received_data().
   959			 */
   960	rx_ack:
   961			if (priv->ops->rx_complete)
   962				priv->ops->rx_complete(mhu, chan);
   963		}
   964	
   965		if (found == 0)
   966			dev_warn_once(dev, "Failed to find channel for the RX interrupt\n");
   967	
   968		return ret;
   969	}
   970	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

