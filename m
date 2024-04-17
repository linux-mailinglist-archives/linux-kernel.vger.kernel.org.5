Return-Path: <linux-kernel+bounces-149205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFDC8A8D28
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A7F2868F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B91E869;
	Wed, 17 Apr 2024 20:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFcEyxHI"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F5838F82;
	Wed, 17 Apr 2024 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386572; cv=none; b=CFLjE1sl3ai9xsoeiih19eJN+x5mBXBfKlMKm5c0TjHfRLy+hxyc21CWpHqokTWp0YM1S4bHNbvk5b7XCSKyN8AWPMMtOBX/8MErkrGbEcsk14/qjHHe/yzTM8ln8Of9K2Kz7t8mlOKPjO45Y9GFSIDYmq5Xu8SPa4NRChiQ+EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386572; c=relaxed/simple;
	bh=ZWfUWZmE+yUAL2efBx5DYACbocPFFiJdjtPZB4NfRfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzWXTlTLJPLlbnK16glAVIJhOi12Qx1piXx7W17m1HiTes2VWXosUpRUwxrbmzALyAzNAHove2Q8qwyxp0REE42sbQW6cE5DaTe6FsRrgLrFuO7mAJR4GjKLkHY22bCmv+kkBN0R4FSX33UAb6XZ945oNKKJ3kYSZn7gUZpIeRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFcEyxHI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713386571; x=1744922571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZWfUWZmE+yUAL2efBx5DYACbocPFFiJdjtPZB4NfRfE=;
  b=iFcEyxHI9EIxMNvuBaM7F0om0RHBSiG2CQmJbw6OXAu7XfYvBOt6JFbz
   RGdlY4fPw317ReeeC/qfOwLM/0HhaqSakijB4nwOKAfqmdPAAMiAOdVvD
   bvo4aVQ42QZLwIUI/zN/mX+XYThjBWN0JtHiKWK9JbMdfiN6pDWOBdu3Y
   9OS4yAiuXDcnlHkKxkj28vjqHDhhZ0V3rqH1aH87RDMHvn2Z82vtj8cDf
   Ye5bFv6iP4UFagqaBPpuD3H2ipJpM5VHt4M7BWxdLzIo9Kldt9jszupa/
   J1rBGR3rKQcMm0F/pWHKAPU5y0Wh1p4Cudyj/GQyuSpwNuJPf8Wia1YGo
   g==;
X-CSE-ConnectionGUID: tYl0BtfkQA+2PfzcwokBMQ==
X-CSE-MsgGUID: As2D50p4RrWf0U9d4ktP7A==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20326076"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="20326076"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 13:42:50 -0700
X-CSE-ConnectionGUID: 3buo29SMSwa8/nehV08Sng==
X-CSE-MsgGUID: fiIZIF5dQoWDJjaaSaPJHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="22825594"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 17 Apr 2024 13:42:47 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rxC7A-0006yq-20;
	Wed, 17 Apr 2024 20:42:44 +0000
Date: Thu, 18 Apr 2024 04:42:07 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Aubin Constans <aubin.constans@microchip.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v1 4/5] mmc: atmel-mci: Incapsulate used to be a platform
 data into host structure
Message-ID: <202404180428.bZDYDFAE-lkp@intel.com>
References: <20240417165708.2965612-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417165708.2965612-5-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.9-rc4 next-20240417]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/mmc-atmel-mci-Get-rid-of-platform-data-leftovers/20240418-005915
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240417165708.2965612-5-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 4/5] mmc: atmel-mci: Incapsulate used to be a platform data into host structure
config: arm-defconfig (https://download.01.org/0day-ci/archive/20240418/202404180428.bZDYDFAE-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240418/202404180428.bZDYDFAE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404180428.bZDYDFAE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/mmc/host/atmel-mci.c:378: warning: Function parameter or struct member 'pdata' not described in 'atmel_mci'


vim +378 drivers/mmc/host/atmel-mci.c

65e8b083fc8ec3 Haavard Skinnemoen 2008-07-30  245  
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  246  /**
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  247   * struct atmel_mci - MMC controller state shared between all slots
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  248   * @lock: Spinlock protecting the queue and associated data.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  249   * @regs: Pointer to MMIO registers.
796211b7953bd1 Ludovic Desroches  2011-08-11  250   * @sg: Scatterlist entry currently being processed by PIO or PDC code.
f51874b7ec92cb Lee Jones          2020-07-01  251   * @sg_len: Size of the scatterlist
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  252   * @pio_offset: Offset into the current scatterlist entry.
7a90dcc2d7ceb6 Ludovic Desroches  2012-05-16  253   * @buffer: Buffer used if we don't have the r/w proof capability. We
7a90dcc2d7ceb6 Ludovic Desroches  2012-05-16  254   *      don't have the time to switch pdc buffers so we have to use only
7a90dcc2d7ceb6 Ludovic Desroches  2012-05-16  255   *      one buffer for the full transaction.
7a90dcc2d7ceb6 Ludovic Desroches  2012-05-16  256   * @buf_size: size of the buffer.
f51874b7ec92cb Lee Jones          2020-07-01  257   * @buf_phys_addr: buffer address needed for pdc.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  258   * @cur_slot: The slot which is currently using the controller.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  259   * @mrq: The request currently being processed on @cur_slot,
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  260   *	or NULL if the controller is idle.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  261   * @cmd: The command currently being sent to the card, or NULL.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  262   * @data: The data currently being transferred, or NULL if no data
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  263   *	transfer is in progress.
796211b7953bd1 Ludovic Desroches  2011-08-11  264   * @data_size: just data->blocks * data->blksz.
65e8b083fc8ec3 Haavard Skinnemoen 2008-07-30  265   * @dma: DMA client state.
65e8b083fc8ec3 Haavard Skinnemoen 2008-07-30  266   * @data_chan: DMA channel being used for the current data transfer.
f51874b7ec92cb Lee Jones          2020-07-01  267   * @dma_conf: Configuration for the DMA slave
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  268   * @cmd_status: Snapshot of SR taken upon completion of the current
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  269   *	command. Only valid when EVENT_CMD_COMPLETE is pending.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  270   * @data_status: Snapshot of SR taken upon completion of the current
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  271   *	data transfer. Only valid when EVENT_DATA_COMPLETE or
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  272   *	EVENT_DATA_ERROR is pending.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  273   * @stop_cmdr: Value to be loaded into CMDR when the stop command is
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  274   *	to be sent.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  275   * @tasklet: Tasklet running the request state machine.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  276   * @pending_events: Bitmask of events flagged by the interrupt handler
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  277   *	to be processed by the tasklet.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  278   * @completed_events: Bitmask of events which the state machine has
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  279   *	processed.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  280   * @state: Tasklet state.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  281   * @queue: List of slots waiting for access to the controller.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  282   * @need_clock_update: Update the clock rate before the next request.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  283   * @need_reset: Reset controller before next request.
24011f346471f7 Ludovic Desroches  2012-05-16  284   * @timer: Timer to balance the data timeout error flag which cannot rise.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  285   * @mode_reg: Value of the MR register.
74791a2dc8dc2a Nicolas Ferre      2009-12-14  286   * @cfg_reg: Value of the CFG register.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  287   * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  288   *	rate and timeout calculations.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  289   * @mapbase: Physical address of the MMIO registers.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  290   * @mck: The peripheral bus clock hooked up to the MMC controller.
d9faa6e8381c3a Andy Shevchenko    2024-04-17  291   * @dev: Device associated with the MMC controller.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  292   * @slot: Slots sharing this MMC controller.
796211b7953bd1 Ludovic Desroches  2011-08-11  293   * @caps: MCI capabilities depending on MCI version.
796211b7953bd1 Ludovic Desroches  2011-08-11  294   * @prepare_data: function to setup MCI before data transfer which
796211b7953bd1 Ludovic Desroches  2011-08-11  295   * depends on MCI capabilities.
796211b7953bd1 Ludovic Desroches  2011-08-11  296   * @submit_data: function to start data transfer which depends on MCI
796211b7953bd1 Ludovic Desroches  2011-08-11  297   * capabilities.
796211b7953bd1 Ludovic Desroches  2011-08-11  298   * @stop_transfer: function to stop data transfer which depends on MCI
796211b7953bd1 Ludovic Desroches  2011-08-11  299   * capabilities.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  300   *
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  301   * Locking
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  302   * =======
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  303   *
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  304   * @lock is a softirq-safe spinlock protecting @queue as well as
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  305   * @cur_slot, @mrq and @state. These must always be updated
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  306   * at the same time while holding @lock.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  307   *
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  308   * @lock also protects mode_reg and need_clock_update since these are
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  309   * used to synchronize mode register updates with the queue
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  310   * processing.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  311   *
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  312   * The @mrq field of struct atmel_mci_slot is also protected by @lock,
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  313   * and must always be written at the same time as the slot is added to
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  314   * @queue.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  315   *
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  316   * @pending_events and @completed_events are accessed using atomic bit
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  317   * operations, so they don't need any locking.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  318   *
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  319   * None of the fields touched by the interrupt handler need any
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  320   * locking. However, ordering is important: Before EVENT_DATA_ERROR or
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  321   * EVENT_DATA_COMPLETE is set in @pending_events, all data-related
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  322   * interrupts must be disabled and @data_status updated with a
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  323   * snapshot of SR. Similarly, before EVENT_CMD_COMPLETE is set, the
25985edcedea63 Lucas De Marchi    2011-03-30  324   * CMDRDY interrupt must be disabled and @cmd_status updated with a
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  325   * snapshot of SR, and before EVENT_XFER_COMPLETE can be set, the
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  326   * bytes_xfered field of @data must be written. This is ensured by
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  327   * using barriers.
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  328   */
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  329  struct atmel_mci {
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  330  	spinlock_t		lock;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  331  	void __iomem		*regs;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  332  
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  333  	struct scatterlist	*sg;
bdbc5d0c60f3e9 Terry Barnaby      2013-04-08  334  	unsigned int		sg_len;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  335  	unsigned int		pio_offset;
7a90dcc2d7ceb6 Ludovic Desroches  2012-05-16  336  	unsigned int		*buffer;
7a90dcc2d7ceb6 Ludovic Desroches  2012-05-16  337  	unsigned int		buf_size;
7a90dcc2d7ceb6 Ludovic Desroches  2012-05-16  338  	dma_addr_t		buf_phys_addr;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  339  
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  340  	struct atmel_mci_slot	*cur_slot;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  341  	struct mmc_request	*mrq;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  342  	struct mmc_command	*cmd;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  343  	struct mmc_data		*data;
796211b7953bd1 Ludovic Desroches  2011-08-11  344  	unsigned int		data_size;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  345  
65e8b083fc8ec3 Haavard Skinnemoen 2008-07-30  346  	struct atmel_mci_dma	dma;
65e8b083fc8ec3 Haavard Skinnemoen 2008-07-30  347  	struct dma_chan		*data_chan;
e2b35f3dbfc080 Viresh Kumar       2012-02-01  348  	struct dma_slave_config	dma_conf;
65e8b083fc8ec3 Haavard Skinnemoen 2008-07-30  349  
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  350  	u32			cmd_status;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  351  	u32			data_status;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  352  	u32			stop_cmdr;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  353  
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  354  	struct tasklet_struct	tasklet;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  355  	unsigned long		pending_events;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  356  	unsigned long		completed_events;
c06ad2580dca4e Haavard Skinnemoen 2008-07-31  357  	enum atmel_mci_state	state;
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  358  	struct list_head	queue;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  359  
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  360  	bool			need_clock_update;
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  361  	bool			need_reset;
24011f346471f7 Ludovic Desroches  2012-05-16  362  	struct timer_list	timer;
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  363  	u32			mode_reg;
74791a2dc8dc2a Nicolas Ferre      2009-12-14  364  	u32			cfg_reg;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  365  	unsigned long		bus_hz;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  366  	unsigned long		mapbase;
7d2be0749a5909 Haavard Skinnemoen 2008-06-30  367  	struct clk		*mck;
d9faa6e8381c3a Andy Shevchenko    2024-04-17  368  	struct device		*dev;
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  369  
e20b1c52f08695 Andy Shevchenko    2024-04-17  370  	struct mci_slot_pdata	pdata[ATMCI_MAX_NR_SLOTS];
2c96a293bbd6b3 Ludovic Desroches  2011-08-11  371  	struct atmel_mci_slot	*slot[ATMCI_MAX_NR_SLOTS];
796211b7953bd1 Ludovic Desroches  2011-08-11  372  
796211b7953bd1 Ludovic Desroches  2011-08-11  373  	struct atmel_mci_caps   caps;
796211b7953bd1 Ludovic Desroches  2011-08-11  374  
796211b7953bd1 Ludovic Desroches  2011-08-11  375  	u32 (*prepare_data)(struct atmel_mci *host, struct mmc_data *data);
796211b7953bd1 Ludovic Desroches  2011-08-11  376  	void (*submit_data)(struct atmel_mci *host, struct mmc_data *data);
796211b7953bd1 Ludovic Desroches  2011-08-11  377  	void (*stop_transfer)(struct atmel_mci *host);
965ebf33ea5afb Haavard Skinnemoen 2008-09-17 @378  };
965ebf33ea5afb Haavard Skinnemoen 2008-09-17  379  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

