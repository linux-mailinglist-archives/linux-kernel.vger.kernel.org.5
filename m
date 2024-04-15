Return-Path: <linux-kernel+bounces-145326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D476E8A52CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F669282D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4130574C1B;
	Mon, 15 Apr 2024 14:14:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBFB3D0D9;
	Mon, 15 Apr 2024 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190469; cv=none; b=FGFBSupoMSq9PhM49CHuMA7u1k9MFfovVBzDdGwomuNbnwN/cCQHgfzzOv7VKZfSRHpQ4qRIozGnu9Y5457Yb6Gwdn3YNVTOdGeWjVNx3joUOMwVGzqnxAkw+TlnEVs5mBuGGhOw6PWvBfiRlJYq3y0BPHkyHqqqvWQy2CnEoy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190469; c=relaxed/simple;
	bh=eZg8luTq58ZVQoqw75PKydC8EUf3Bss2NVMPDnoHhZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbXXxSMAcDgDU2Nb4yU2GUTPLlL+LZqcfu2/lh7e7je6iBDGtEV0fiXiZRJtykhuBoflLzsdebMwEAtZKmvZFEEBDWLCj38MZlUBUEAsDLl5bdIVDsBnaf4tFjrx45dd9HFqFYpSNOB5JhlBmjeUQGET2aG3EdRfk+jjVmRoWCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 649992F4;
	Mon, 15 Apr 2024 07:14:54 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CDF53F738;
	Mon, 15 Apr 2024 07:14:23 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:14:21 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	sudeep.holla@arm.com, jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 2/2] mailbox: arm_mhuv3: Add driver
Message-ID: <Zh02PYSzbNPN_mSj@pluto>
References: <20240412192801.554464-3-cristian.marussi@arm.com>
 <202404152144.RtJxmEsQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404152144.RtJxmEsQ-lkp@intel.com>

On Mon, Apr 15, 2024 at 09:56:52PM +0800, kernel test robot wrote:
> Hi Cristian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on robh/for-next]
> [also build test ERROR on soc/for-next linus/master v6.9-rc4 next-20240415]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/dt-bindings-mailbox-arm-mhuv3-Add-bindings/20240415-094106
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
> patch link:    https://lore.kernel.org/r/20240412192801.554464-3-cristian.marussi%40arm.com
> patch subject: [PATCH v4 2/2] mailbox: arm_mhuv3: Add driver
> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240415/202404152144.RtJxmEsQ-lkp@intel.com/config)
> compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240415/202404152144.RtJxmEsQ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404152144.RtJxmEsQ-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/mailbox/arm_mhuv3.c: In function 'mhuv3_mbx_comb_interrupt':
> >> drivers/mailbox/arm_mhuv3.c:922:17: error: cleanup argument not a function
>      922 |                 void *data __free(kfree) = NULL;
>          |                 ^~~~

Right, I suppose is missing slab.h to define kfree now that it is using
cleanup.h.

I'll fix in V5, after some more possible feedback comes in...

Thanks,
Cristian

> 
> 
> vim +922 drivers/mailbox/arm_mhuv3.c
> 
>    910	
>    911	static irqreturn_t mhuv3_mbx_comb_interrupt(int irq, void *arg)
>    912	{
>    913		unsigned int i, found = 0;
>    914		struct mhuv3 *mhu = arg;
>    915		struct mbox_chan *chan;
>    916		struct device *dev;
>    917		int ret = IRQ_NONE;
>    918	
>    919		dev = mhu->mbox.dev;
>    920		for (i = 0; i < NUM_EXT; i++) {
>    921			struct mhuv3_mbox_chan_priv *priv;
>  > 922			void *data __free(kfree) = NULL;
>    923	
>    924			if (!mhu->ext[i])
>    925				continue;
>    926	
>    927			/* Process any extension which could be source of the IRQ */
>    928			chan = mhu->ext[i]->chan_from_comb_irq_get(mhu);
>    929			if (IS_ERR(chan))
>    930				continue;
>    931	
>    932			found++;
>    933			/* From here on we need to call rx_complete even on error */
>    934			priv = chan->con_priv;
>    935			if (!chan->cl) {
>    936				dev_warn(dev, "RX Data on UNBOUND channel (%u)\n",
>    937					 priv->ch_idx);
>    938				goto rx_ack;
>    939			}
>    940	
>    941			/* Read optional in-band LE data first. */
>    942			if (priv->ops->read_data) {
>    943				data = priv->ops->read_data(mhu, chan);
>    944				if (IS_ERR(data)) {
>    945					dev_err(dev,
>    946						"Failed to read in-band data. err:%ld\n",
>    947						PTR_ERR(no_free_ptr(data)));
>    948					goto rx_ack;
>    949				}
>    950			}
>    951	
>    952			mbox_chan_received_data(chan, data);
>    953			ret = IRQ_HANDLED;
>    954	
>    955			/*
>    956			 * Acknowledge transfer after any possible optional
>    957			 * out-of-band data has also been retrieved via
>    958			 * mbox_chan_received_data().
>    959			 */
>    960	rx_ack:
>    961			if (priv->ops->rx_complete)
>    962				priv->ops->rx_complete(mhu, chan);
>    963		}
>    964	
>    965		if (found == 0)
>    966			dev_warn_once(dev, "Failed to find channel for the RX interrupt\n");
>    967	
>    968		return ret;
>    969	}
>    970	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

