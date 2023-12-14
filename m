Return-Path: <linux-kernel+bounces-49-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A8C813B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFAE2822CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8811C6A030;
	Thu, 14 Dec 2023 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G5Si/9mY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD3E6A006
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702584494; x=1734120494;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jvt91SMcn8yyhiJqBU5TbtmOPzk6vSSVSGlVaWrIMCQ=;
  b=G5Si/9mYAxoLik0ZNNO/GnL1MyL7eaoWN0qYp2AmimOJXgK7RT3nZo52
   rHRv/Z2do5l7xMFV9BhnyTCUB+R1lQDuOMZHie7x0oItIgNAvfLT2GfRz
   YANb8iSbuHR5/q4N3h/QKNYvLlLNI/kbX5nLuCePr51WpfyYRhBh/SecB
   02/gnVYTZPZ44GQF34HjMZpnCmItfbnP55SZBVqSbSiS4isA1rlo+QXKr
   bqjFzeNcfhYCYjzJbM+xdA/YpooHTK9qDUf7yLInENoAnjxNBkpbKJCf3
   387LvoJckkpRtj5pwmicB3XZtV8QkNTgLuu9mOzO8eZFg9xcjSAVFgm6+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392356767"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="392356767"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 12:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="918168045"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="918168045"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Dec 2023 12:08:11 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rDs09-000MZG-2Y;
	Thu, 14 Dec 2023 20:08:09 +0000
Date: Fri, 15 Dec 2023 04:07:46 +0800
From: kernel test robot <lkp@intel.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/at_hdmac.c:384: warning: Excess struct member
 'atdma_devtype' description in 'at_dma'
Message-ID: <202312150403.iyj7xzX1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: 5cecadc3e2a4fb72ab37d9420df0a9e1179b8a3e dmaengine: at_hdmac: Keep register definitions and structures private to at_hdmac.c
date:   1 year, 1 month ago
config: arm-defconfig (https://download.01.org/0day-ci/archive/20231215/202312150403.iyj7xzX1-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231215/202312150403.iyj7xzX1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312150403.iyj7xzX1-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'lli' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'tx_list' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'boundary' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'dst_hole' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'src_hole' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'memset_buffer' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'memset_paddr' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'memset_vaddr' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Excess struct member 'at_lli' description in 'at_desc'
   drivers/dma/at_hdmac.c:269: warning: cannot understand function prototype: 'enum atc_status '
   drivers/dma/at_hdmac.c:384: warning: Function parameter or member 'dma_common' not described in 'at_dma'
   drivers/dma/at_hdmac.c:384: warning: Function parameter or member 'regs' not described in 'at_dma'
   drivers/dma/at_hdmac.c:384: warning: Function parameter or member 'memset_pool' not described in 'at_dma'
   drivers/dma/at_hdmac.c:384: warning: Excess struct member 'chan_common' description in 'at_dma'
>> drivers/dma/at_hdmac.c:384: warning: Excess struct member 'atdma_devtype' description in 'at_dma'
>> drivers/dma/at_hdmac.c:384: warning: Excess struct member 'ch_regs' description in 'at_dma'


vim +384 drivers/dma/at_hdmac.c

   224	
   225	/**
   226	 * struct at_desc - software descriptor
   227	 * @at_lli: hardware lli structure
   228	 * @txd: support for the async_tx api
   229	 * @desc_node: node on the channed descriptors list
   230	 * @len: descriptor byte count
   231	 * @total_len: total transaction byte count
   232	 */
   233	struct at_desc {
   234		/* FIRST values the hardware uses */
   235		struct at_lli			lli;
   236	
   237		/* THEN values for driver housekeeping */
   238		struct list_head		tx_list;
   239		struct dma_async_tx_descriptor	txd;
   240		struct list_head		desc_node;
   241		size_t				len;
   242		size_t				total_len;
   243	
   244		/* Interleaved data */
   245		size_t				boundary;
   246		size_t				dst_hole;
   247		size_t				src_hole;
   248	
   249		/* Memset temporary buffer */
   250		bool				memset_buffer;
   251		dma_addr_t			memset_paddr;
   252		int				*memset_vaddr;
 > 253	};
   254	
   255	static inline struct at_desc *
   256	txd_to_at_desc(struct dma_async_tx_descriptor *txd)
   257	{
   258		return container_of(txd, struct at_desc, txd);
   259	}
   260	
   261	
   262	/*--  Channels  --------------------------------------------------------*/
   263	
   264	/**
   265	 * atc_status - information bits stored in channel status flag
   266	 *
   267	 * Manipulated with atomic operations.
   268	 */
   269	enum atc_status {
   270		ATC_IS_ERROR = 0,
   271		ATC_IS_PAUSED = 1,
   272		ATC_IS_CYCLIC = 24,
   273	};
   274	
   275	/**
   276	 * struct at_dma_chan - internal representation of an Atmel HDMAC channel
   277	 * @chan_common: common dmaengine channel object members
   278	 * @device: parent device
   279	 * @ch_regs: memory mapped register base
   280	 * @mask: channel index in a mask
   281	 * @per_if: peripheral interface
   282	 * @mem_if: memory interface
   283	 * @status: transmit status information from irq/prep* functions
   284	 *                to tasklet (use atomic operations)
   285	 * @tasklet: bottom half to finish transaction work
   286	 * @save_cfg: configuration register that is saved on suspend/resume cycle
   287	 * @save_dscr: for cyclic operations, preserve next descriptor address in
   288	 *             the cyclic list on suspend/resume cycle
   289	 * @dma_sconfig: configuration for slave transfers, passed via
   290	 * .device_config
   291	 * @lock: serializes enqueue/dequeue operations to descriptors lists
   292	 * @active_list: list of descriptors dmaengine is being running on
   293	 * @queue: list of descriptors ready to be submitted to engine
   294	 * @free_list: list of descriptors usable by the channel
   295	 */
   296	struct at_dma_chan {
   297		struct dma_chan		chan_common;
   298		struct at_dma		*device;
   299		void __iomem		*ch_regs;
   300		u8			mask;
   301		u8			per_if;
   302		u8			mem_if;
   303		unsigned long		status;
   304		struct tasklet_struct	tasklet;
   305		u32			save_cfg;
   306		u32			save_dscr;
   307		struct dma_slave_config dma_sconfig;
   308	
   309		spinlock_t		lock;
   310	
   311		/* these other elements are all protected by lock */
   312		struct list_head	active_list;
   313		struct list_head	queue;
   314		struct list_head	free_list;
   315	};
   316	
   317	#define	channel_readl(atchan, name) \
   318		__raw_readl((atchan)->ch_regs + ATC_##name##_OFFSET)
   319	
   320	#define	channel_writel(atchan, name, val) \
   321		__raw_writel((val), (atchan)->ch_regs + ATC_##name##_OFFSET)
   322	
   323	static inline struct at_dma_chan *to_at_dma_chan(struct dma_chan *dchan)
   324	{
   325		return container_of(dchan, struct at_dma_chan, chan_common);
   326	}
   327	
   328	/*
   329	 * Fix sconfig's burst size according to at_hdmac. We need to convert them as:
   330	 * 1 -> 0, 4 -> 1, 8 -> 2, 16 -> 3, 32 -> 4, 64 -> 5, 128 -> 6, 256 -> 7.
   331	 *
   332	 * This can be done by finding most significant bit set.
   333	 */
   334	static inline void convert_burst(u32 *maxburst)
   335	{
   336		if (*maxburst > 1)
   337			*maxburst = fls(*maxburst) - 2;
   338		else
   339			*maxburst = 0;
   340	}
   341	
   342	/*
   343	 * Fix sconfig's bus width according to at_hdmac.
   344	 * 1 byte -> 0, 2 bytes -> 1, 4 bytes -> 2.
   345	 */
   346	static inline u8 convert_buswidth(enum dma_slave_buswidth addr_width)
   347	{
   348		switch (addr_width) {
   349		case DMA_SLAVE_BUSWIDTH_2_BYTES:
   350			return 1;
   351		case DMA_SLAVE_BUSWIDTH_4_BYTES:
   352			return 2;
   353		default:
   354			/* For 1 byte width or fallback */
   355			return 0;
   356		}
   357	}
   358	
   359	/*--  Controller  ------------------------------------------------------*/
   360	
   361	/**
   362	 * struct at_dma - internal representation of an Atmel HDMA Controller
   363	 * @chan_common: common dmaengine dma_device object members
   364	 * @atdma_devtype: identifier of DMA controller compatibility
   365	 * @ch_regs: memory mapped register base
   366	 * @clk: dma controller clock
   367	 * @save_imr: interrupt mask register that is saved on suspend/resume cycle
   368	 * @all_chan_mask: all channels availlable in a mask
   369	 * @dma_desc_pool: base of DMA descriptor region (DMA address)
   370	 * @chan: channels table to store at_dma_chan structures
   371	 */
   372	struct at_dma {
   373		struct dma_device	dma_common;
   374		void __iomem		*regs;
   375		struct clk		*clk;
   376		u32			save_imr;
   377	
   378		u8			all_chan_mask;
   379	
   380		struct dma_pool		*dma_desc_pool;
   381		struct dma_pool		*memset_pool;
   382		/* AT THE END channels table */
   383		struct at_dma_chan	chan[];
 > 384	};
   385	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

