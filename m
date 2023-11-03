Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AEC7DFDA1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjKCAqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKCAqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:46:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B85E191
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 17:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698972386; x=1730508386;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ztYvs5WDgqxxS1zGD5sh29Ifi26GshWrUdXWMM9mOv8=;
  b=Ieujp5U5QDl3tHzWHFqKehGrLK/3PjBKqIz6FerQoUdsch+kCW89shcN
   Qm5RsC+MXOe9jNaFstaFE5hqGxp6wVsWJvqxTPPadjp15kc+IzLCQviX+
   uOxx9s83TfIimdeuA60tZYIMDDnXW7QnpTLuR7Xk+dkmmJkFC5EfQQ43C
   /vgnhbOCoO2GPxkJe5k5LC3RShLyYl6CiLK4MeNwNYNqQ7OZOnl3PHwm/
   NVVIYrVeVbwrFvhJfpYnotsfWTYHsCYG5P5frA2zM686JL1Du6DVaxweO
   IeRjAmITgjr9EqzQGzw4JONugOByonjKi3wruWl96BCE3+DMzRdannEQb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419958323"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="419958323"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 17:46:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="9194733"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 Nov 2023 17:46:24 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyiKL-00023q-1e;
        Fri, 03 Nov 2023 00:46:21 +0000
Date:   Fri, 3 Nov 2023 08:45:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: drivers/xen/xen-front-pgdir-shbuf.c:84: warning: Function parameter
 or member 'buf' not described in 'xen_front_pgdir_shbuf_get_dir_start'
Message-ID: <202311030829.XIMWb8FF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4652b8e4f3ffa48c706ec334f048c217a7d9750d
commit: 58f9d806d16a38ed3bae11e2ada83393436a4956 ALSA: xen-front: Use Xen common shared buffer implementation
date:   4 years, 11 months ago
config: x86_64-buildonly-randconfig-002-20231101 (https://download.01.org/0day-ci/archive/20231103/202311030829.XIMWb8FF-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030829.XIMWb8FF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030829.XIMWb8FF-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/xen/xen-front-pgdir-shbuf.c:39: warning: cannot understand function prototype: 'struct xen_page_directory '
   drivers/xen/xen-front-pgdir-shbuf.c:50: warning: cannot understand function prototype: 'struct xen_front_pgdir_shbuf_ops '
>> drivers/xen/xen-front-pgdir-shbuf.c:84: warning: Function parameter or member 'buf' not described in 'xen_front_pgdir_shbuf_get_dir_start'
>> drivers/xen/xen-front-pgdir-shbuf.c:104: warning: Function parameter or member 'buf' not described in 'xen_front_pgdir_shbuf_map'
>> drivers/xen/xen-front-pgdir-shbuf.c:125: warning: Function parameter or member 'buf' not described in 'xen_front_pgdir_shbuf_unmap'
>> drivers/xen/xen-front-pgdir-shbuf.c:140: warning: Function parameter or member 'buf' not described in 'xen_front_pgdir_shbuf_free'
   drivers/xen/xen-front-pgdir-shbuf.c:168: warning: Function parameter or member 'buf' not described in 'get_num_pages_dir'
   drivers/xen/xen-front-pgdir-shbuf.c:179: warning: Function parameter or member 'buf' not described in 'backend_calc_num_grefs'
   drivers/xen/xen-front-pgdir-shbuf.c:191: warning: Function parameter or member 'buf' not described in 'guest_calc_num_grefs'
   drivers/xen/xen-front-pgdir-shbuf.c:210: warning: Function parameter or member 'buf' not described in 'backend_unmap'
>> drivers/xen/xen-front-pgdir-shbuf.c:257: warning: Function parameter or member 'buf' not described in 'backend_map'
   drivers/xen/xen-front-pgdir-shbuf.c:335: warning: Function parameter or member 'buf' not described in 'backend_fill_page_dir'
   drivers/xen/xen-front-pgdir-shbuf.c:362: warning: Function parameter or member 'buf' not described in 'guest_fill_page_dir'
>> drivers/xen/xen-front-pgdir-shbuf.c:406: warning: Function parameter or member 'buf' not described in 'guest_grant_refs_for_buffer'
>> drivers/xen/xen-front-pgdir-shbuf.c:406: warning: Function parameter or member 'priv_gref_head' not described in 'guest_grant_refs_for_buffer'
   drivers/xen/xen-front-pgdir-shbuf.c:406: warning: Function parameter or member 'gref_idx' not described in 'guest_grant_refs_for_buffer'
   drivers/xen/xen-front-pgdir-shbuf.c:433: warning: Function parameter or member 'buf' not described in 'grant_references'
>> drivers/xen/xen-front-pgdir-shbuf.c:478: warning: Function parameter or member 'buf' not described in 'alloc_storage'
>> drivers/xen/xen-front-pgdir-shbuf.c:518: warning: Function parameter or member 'cfg' not described in 'xen_front_pgdir_shbuf_alloc'


vim +84 drivers/xen/xen-front-pgdir-shbuf.c

b3383974fee272 Oleksandr Andrushchenko 2018-11-30   71  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   72  /**
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   73   * Get granted reference to the very first page of the
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   74   * page directory. Usually this is passed to the backend,
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   75   * so it can find/fill the grant references to the buffer's
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   76   * pages.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   77   *
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   78   * \param buf shared buffer which page directory is of interest.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   79   * \return granted reference to the very first page of the
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   80   * page directory.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   81   */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   82  grant_ref_t
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   83  xen_front_pgdir_shbuf_get_dir_start(struct xen_front_pgdir_shbuf *buf)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  @84  {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   85  	if (!buf->grefs)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   86  		return GRANT_INVALID_REF;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   87  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   88  	return buf->grefs[0];
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   89  }
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   90  EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_get_dir_start);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   91  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   92  /**
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   93   * Map granted references of the shared buffer.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   94   *
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   95   * Depending on the shared buffer mode of allocation
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   96   * (be_alloc flag) this can either do nothing (for buffers
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   97   * shared by the frontend itself) or map the provided granted
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   98   * references onto the backing storage (buf->pages).
b3383974fee272 Oleksandr Andrushchenko 2018-11-30   99   *
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  100   * \param buf shared buffer which grants to be maped.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  101   * \return zero on success or a negative number on failure.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  102   */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  103  int xen_front_pgdir_shbuf_map(struct xen_front_pgdir_shbuf *buf)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30 @104  {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  105  	if (buf->ops && buf->ops->map)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  106  		return buf->ops->map(buf);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  107  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  108  	/* No need to map own grant references. */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  109  	return 0;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  110  }
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  111  EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_map);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  112  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  113  /**
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  114   * Unmap granted references of the shared buffer.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  115   *
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  116   * Depending on the shared buffer mode of allocation
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  117   * (be_alloc flag) this can either do nothing (for buffers
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  118   * shared by the frontend itself) or unmap the provided granted
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  119   * references.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  120   *
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  121   * \param buf shared buffer which grants to be unmaped.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  122   * \return zero on success or a negative number on failure.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  123   */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  124  int xen_front_pgdir_shbuf_unmap(struct xen_front_pgdir_shbuf *buf)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30 @125  {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  126  	if (buf->ops && buf->ops->unmap)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  127  		return buf->ops->unmap(buf);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  128  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  129  	/* No need to unmap own grant references. */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  130  	return 0;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  131  }
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  132  EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_unmap);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  133  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  134  /**
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  135   * Free all the resources of the shared buffer.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  136   *
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  137   * \param buf shared buffer which resources to be freed.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  138   */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  139  void xen_front_pgdir_shbuf_free(struct xen_front_pgdir_shbuf *buf)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30 @140  {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  141  	if (buf->grefs) {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  142  		int i;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  143  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  144  		for (i = 0; i < buf->num_grefs; i++)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  145  			if (buf->grefs[i] != GRANT_INVALID_REF)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  146  				gnttab_end_foreign_access(buf->grefs[i],
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  147  							  0, 0UL);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  148  	}
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  149  	kfree(buf->grefs);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  150  	kfree(buf->directory);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  151  }
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  152  EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_free);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  153  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  154  /*
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  155   * Number of grefs a page can hold with respect to the
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  156   * struct xen_page_directory header.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  157   */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  158  #define XEN_NUM_GREFS_PER_PAGE ((PAGE_SIZE - \
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  159  				 offsetof(struct xen_page_directory, \
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  160  					  gref)) / sizeof(grant_ref_t))
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  161  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  162  /**
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  163   * Get the number of pages the page directory consumes itself.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  164   *
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  165   * \param buf shared buffer.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  166   */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  167  static int get_num_pages_dir(struct xen_front_pgdir_shbuf *buf)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  168  {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  169  	return DIV_ROUND_UP(buf->num_pages, XEN_NUM_GREFS_PER_PAGE);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  170  }
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  171  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  172  /**
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  173   * Calculate the number of grant references needed to share the buffer
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  174   * and its pages when backend allocates the buffer.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  175   *
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  176   * \param buf shared buffer.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  177   */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  178  static void backend_calc_num_grefs(struct xen_front_pgdir_shbuf *buf)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  179  {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  180  	/* Only for pages the page directory consumes itself. */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  181  	buf->num_grefs = get_num_pages_dir(buf);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  182  }
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  183  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  184  /**
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  185   * Calculate the number of grant references needed to share the buffer
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  186   * and its pages when frontend allocates the buffer.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  187   *
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  188   * \param buf shared buffer.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  189   */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  190  static void guest_calc_num_grefs(struct xen_front_pgdir_shbuf *buf)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  191  {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  192  	/*
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  193  	 * Number of pages the page directory consumes itself
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  194  	 * plus grefs for the buffer pages.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  195  	 */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  196  	buf->num_grefs = get_num_pages_dir(buf) + buf->num_pages;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  197  }
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  198  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  199  #define xen_page_to_vaddr(page) \
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  200  	((uintptr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  201  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  202  /**
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  203   * Unmap the buffer previously mapped with grant references
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  204   * provided by the backend.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  205   *
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  206   * \param buf shared buffer.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  207   * \return zero on success or a negative number on failure.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  208   */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  209  static int backend_unmap(struct xen_front_pgdir_shbuf *buf)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  210  {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  211  	struct gnttab_unmap_grant_ref *unmap_ops;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  212  	int i, ret;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  213  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  214  	if (!buf->pages || !buf->backend_map_handles || !buf->grefs)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  215  		return 0;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  216  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  217  	unmap_ops = kcalloc(buf->num_pages, sizeof(*unmap_ops),
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  218  			    GFP_KERNEL);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  219  	if (!unmap_ops)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  220  		return -ENOMEM;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  221  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  222  	for (i = 0; i < buf->num_pages; i++) {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  223  		phys_addr_t addr;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  224  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  225  		addr = xen_page_to_vaddr(buf->pages[i]);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  226  		gnttab_set_unmap_op(&unmap_ops[i], addr, GNTMAP_host_map,
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  227  				    buf->backend_map_handles[i]);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  228  	}
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  229  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  230  	ret = gnttab_unmap_refs(unmap_ops, NULL, buf->pages,
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  231  				buf->num_pages);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  232  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  233  	for (i = 0; i < buf->num_pages; i++) {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  234  		if (unlikely(unmap_ops[i].status != GNTST_okay))
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  235  			dev_err(&buf->xb_dev->dev,
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  236  				"Failed to unmap page %d: %d\n",
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  237  				i, unmap_ops[i].status);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  238  	}
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  239  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  240  	if (ret)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  241  		dev_err(&buf->xb_dev->dev,
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  242  			"Failed to unmap grant references, ret %d", ret);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  243  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  244  	kfree(unmap_ops);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  245  	kfree(buf->backend_map_handles);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  246  	buf->backend_map_handles = NULL;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  247  	return ret;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  248  }
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  249  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  250  /**
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  251   * Map the buffer with grant references provided by the backend.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  252   *
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  253   * \param buf shared buffer.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  254   * \return zero on success or a negative number on failure.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  255   */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  256  static int backend_map(struct xen_front_pgdir_shbuf *buf)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30 @257  {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  258  	struct gnttab_map_grant_ref *map_ops = NULL;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  259  	unsigned char *ptr;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  260  	int ret, cur_gref, cur_dir_page, cur_page, grefs_left;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  261  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  262  	map_ops = kcalloc(buf->num_pages, sizeof(*map_ops), GFP_KERNEL);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  263  	if (!map_ops)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  264  		return -ENOMEM;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  265  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  266  	buf->backend_map_handles = kcalloc(buf->num_pages,
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  267  					   sizeof(*buf->backend_map_handles),
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  268  					   GFP_KERNEL);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  269  	if (!buf->backend_map_handles) {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  270  		kfree(map_ops);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  271  		return -ENOMEM;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  272  	}
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  273  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  274  	/*
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  275  	 * Read page directory to get grefs from the backend: for external
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  276  	 * buffer we only allocate buf->grefs for the page directory,
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  277  	 * so buf->num_grefs has number of pages in the page directory itself.
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  278  	 */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  279  	ptr = buf->directory;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  280  	grefs_left = buf->num_pages;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  281  	cur_page = 0;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  282  	for (cur_dir_page = 0; cur_dir_page < buf->num_grefs; cur_dir_page++) {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  283  		struct xen_page_directory *page_dir =
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  284  			(struct xen_page_directory *)ptr;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  285  		int to_copy = XEN_NUM_GREFS_PER_PAGE;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  286  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  287  		if (to_copy > grefs_left)
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  288  			to_copy = grefs_left;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  289  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  290  		for (cur_gref = 0; cur_gref < to_copy; cur_gref++) {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  291  			phys_addr_t addr;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  292  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  293  			addr = xen_page_to_vaddr(buf->pages[cur_page]);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  294  			gnttab_set_map_op(&map_ops[cur_page], addr,
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  295  					  GNTMAP_host_map,
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  296  					  page_dir->gref[cur_gref],
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  297  					  buf->xb_dev->otherend_id);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  298  			cur_page++;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  299  		}
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  300  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  301  		grefs_left -= to_copy;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  302  		ptr += PAGE_SIZE;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  303  	}
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  304  	ret = gnttab_map_refs(map_ops, NULL, buf->pages, buf->num_pages);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  305  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  306  	/* Save handles even if error, so we can unmap. */
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  307  	for (cur_page = 0; cur_page < buf->num_pages; cur_page++) {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  308  		buf->backend_map_handles[cur_page] = map_ops[cur_page].handle;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  309  		if (unlikely(map_ops[cur_page].status != GNTST_okay))
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  310  			dev_err(&buf->xb_dev->dev,
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  311  				"Failed to map page %d: %d\n",
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  312  				cur_page, map_ops[cur_page].status);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  313  	}
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  314  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  315  	if (ret) {
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  316  		dev_err(&buf->xb_dev->dev,
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  317  			"Failed to map grant references, ret %d", ret);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  318  		backend_unmap(buf);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  319  	}
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  320  
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  321  	kfree(map_ops);
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  322  	return ret;
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  323  }
b3383974fee272 Oleksandr Andrushchenko 2018-11-30  324  

:::::: The code at line 84 was first introduced by commit
:::::: b3383974fee272ad0d444a2d083f456879447cd8 xen: Introduce shared buffer helpers for page directory...

:::::: TO: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
:::::: CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
