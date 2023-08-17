Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3AA77F109
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348427AbjHQHPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348487AbjHQHOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:14:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB462D53
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 00:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692256463; x=1723792463;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CgSnIWU3ZH/8V2ZmTGHEb+s4MdUWu15iP0vaFinJZgY=;
  b=YWsT4Iq3W8HvYhBYxRpvZnkOcGIIuiX9gb6Ve4agJO68Pk3qmCRqMgXN
   z8HoAJcWyI4Pyr9xdvTPT5k+AGO3ZQNzM8K8Ynr3CgZshPOgXzWeGKHVh
   pyYMFQZsCxWLss+HgeSgv3unkMGRIe7yA5lNMRGrhysOSfNtd4GfiVWc/
   9Sain6hU86w0+5+jO1+lh/F+6zncdChMe8rYppPmuBrrSxfkTaF4glkU1
   xpzM9LfDXtj3sMkH/zqog3O9QMqB8GEZf2F3f1dRipHQxdetZFtQFoR3t
   Nsz/A8HfQgybOuDRyP8nQfkFCzN7QQtSzcx7NypGB+qCXPw8TAlUr1YDd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375500521"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="375500521"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 00:14:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734560523"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="734560523"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2023 00:14:20 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWXCr-0000t9-1s;
        Thu, 17 Aug 2023 07:14:15 +0000
Date:   Thu, 17 Aug 2023 15:11:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: drivers/dma/at_hdmac.c:253: warning: Function parameter or member
 'boundary' not described in 'at_desc'
Message-ID: <202308171548.l6HjJSEy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 5cecadc3e2a4fb72ab37d9420df0a9e1179b8a3e dmaengine: at_hdmac: Keep register definitions and structures private to at_hdmac.c
date:   9 months ago
config: arm-randconfig-r046-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171548.l6HjJSEy-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171548.l6HjJSEy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171548.l6HjJSEy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'lli' not described in 'at_desc'
   drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'tx_list' not described in 'at_desc'
>> drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'boundary' not described in 'at_desc'
>> drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'dst_hole' not described in 'at_desc'
>> drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'src_hole' not described in 'at_desc'
>> drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'memset_buffer' not described in 'at_desc'
>> drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'memset_paddr' not described in 'at_desc'
>> drivers/dma/at_hdmac.c:253: warning: Function parameter or member 'memset_vaddr' not described in 'at_desc'
>> drivers/dma/at_hdmac.c:269: warning: cannot understand function prototype: 'enum atc_status '
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
 > 269	enum atc_status {
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
