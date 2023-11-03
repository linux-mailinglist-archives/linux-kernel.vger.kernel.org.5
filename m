Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E03C7E0AAE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 22:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjKCVNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 17:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 17:13:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F88D62
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 14:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699045921; x=1730581921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UkpB6elc68EYwlr+CzIcXG1AiXLGuc8u6SFRvi0+x0M=;
  b=UiankCYIHeeAVSj7fVokQUAT5XikEqF/uzuQDpAx3EmL1y3Y4SQnXU6L
   X+bUPymQfApD4PILNGXpyC+7FvjUz9yei1c9A35t5o10RxzGbc6i60v0X
   gZ9QxS24XSUgGT+Wn5ofHdwq55e93RqE5N82Le2i2dsYVv5UfeBH4d3+U
   H35q5MvPsTCFfogzf48fc5vnOFXVZfxZ9XsktWPuyto1/8Efm8j9M/fmd
   UnSW9CZcQ5fu5/f7x1++p1ZjEnCGhEewfcC9rA3e/K0j47s/vDxgtxg3I
   5jqLQ1ii0dXBNwEDzsSXJP2zs6mV34Urpt83BbpBGT7DCXgyPg76FJ1sB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="379416339"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="379416339"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 14:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="790876669"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="790876669"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 Nov 2023 14:10:42 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz1R9-0002wV-2j;
        Fri, 03 Nov 2023 21:10:39 +0000
Date:   Sat, 4 Nov 2023 05:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/at_hdmac.c:253: warning: Function parameter or member
 'memset_buffer' not described in 'at_desc'
Message-ID: <202311040526.kDfcpu0x-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bdfe2d88b9ff8b0cce32ce87cd47c0e9d665f48
commit: 5cecadc3e2a4fb72ab37d9420df0a9e1179b8a3e dmaengine: at_hdmac: Keep register definitions and structures private to at_hdmac.c
date:   12 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040526.kDfcpu0x-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040526.kDfcpu0x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040526.kDfcpu0x-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'lli' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'tx_list' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'boundary' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'dst_hole' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'src_hole' not described in 'at_desc'
>> drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'memset_buffer' not described in 'at_desc'
>> drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'memset_paddr' not described in 'at_desc'
>> drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'memset_vaddr' not described in 'at_desc'
   drivers/dma/at_hdmac.c:269: warning: cannot understand function prototype: 'enum atc_status '
   drivers/dma/at_hdmac.c:384: warning: Function parameter or member 'dma_common' not described in 'at_dma'
>> drivers/dma/at_hdmac.c:384: warning: Function parameter or member 'regs' not described in 'at_dma'
>> drivers/dma/at_hdmac.c:384: warning: Function parameter or member 'memset_pool' not described in 'at_dma'


vim +253 drivers/dma/at_hdmac.c

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
