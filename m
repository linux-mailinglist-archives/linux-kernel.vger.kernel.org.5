Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACBE78F494
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347585AbjHaV1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347509AbjHaV1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:27:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96373E79;
        Thu, 31 Aug 2023 14:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693517231; x=1725053231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wDJDgkpzCa0Dj2A44lk0VL2Xq1n0Zp7FUI5JTQBRV3Y=;
  b=Sr4aOx+y8j43U+FQCs3KRv/gL5ddRQzp5xCwYfch8GCeXXCluXwhaZp7
   VhJ8YlnsJXdjlVB1W1Rm+/FAmPhHv19pNK6B226/9ZaOwArluM6jEfbD6
   X9x4dDYJoO6CmF8MNoBjLv1fiMLQS6O/tV1rj/gdB6woV6pixTiXleZCp
   tvfWyBlru/+ZcrfJRXu1kTkBcA3MhAAozIeoWCVt0MM9JlRREWxiqwX1a
   27kVZv+VOtb4RAZMOWuHEKJ7rrQrfNZPER+/9h81WmRM06eVGFHu9h5x/
   JxTSpt22l0l63Apa2VIMVzdNQihBHP/wrS7pX+JZu25zd7Z7Ve1I01CX0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="374974886"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="374974886"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 14:27:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="805184902"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="805184902"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 31 Aug 2023 14:27:08 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbpBy-0000Yx-2K;
        Thu, 31 Aug 2023 21:27:06 +0000
Date:   Fri, 1 Sep 2023 05:26:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH v1 1/5] misc: fastrpc: Add fastrpc multimode invoke
 request support
Message-ID: <202309010543.Xc8XI7oZ-lkp@intel.com>
References: <1693499292-19083-2-git-send-email-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1693499292-19083-2-git-send-email-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ekansh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ekansh-Gupta/misc-fastrpc-Add-fastrpc-multimode-invoke-request-support/20230901-002929
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/1693499292-19083-2-git-send-email-quic_ekangupt%40quicinc.com
patch subject: [PATCH v1 1/5] misc: fastrpc: Add fastrpc multimode invoke request support
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230901/202309010543.Xc8XI7oZ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230901/202309010543.Xc8XI7oZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309010543.Xc8XI7oZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/misc/fastrpc.c: In function 'fastrpc_context_alloc':
>> drivers/misc/fastrpc.c:607:29: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     607 |                 ctx->args = (struct fastrpc_invoke_args *)invoke->inv.args;
         |                             ^
   drivers/misc/fastrpc.c: In function 'fastrpc_init_create_static_process':
>> drivers/misc/fastrpc.c:1320:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1320 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_init_create_process':
   drivers/misc/fastrpc.c:1453:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1453 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_release_current_dsp_process':
   drivers/misc/fastrpc.c:1517:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1517 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_init_attach':
   drivers/misc/fastrpc.c:1665:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1665 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_invoke':
   drivers/misc/fastrpc.c:1696:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1696 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_multimode_invoke':
   drivers/misc/fastrpc.c:1732:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1732 |                 einv.inv.args = (__u64)args;
         |                                 ^
   drivers/misc/fastrpc.c: In function 'fastrpc_get_info_from_dsp':
   drivers/misc/fastrpc.c:1762:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1762 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_munmap_impl':
   drivers/misc/fastrpc.c:1865:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1865 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mmap':
   drivers/misc/fastrpc.c:1963:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1963 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_unmap_impl':
   drivers/misc/fastrpc.c:2044:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2044 |         ioctl.inv.args = (__u64)args;
         |                          ^
   drivers/misc/fastrpc.c: In function 'fastrpc_req_mem_map':
   drivers/misc/fastrpc.c:2113:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2113 |         ioctl.inv.args = (__u64)args;
         |                          ^


vim +607 drivers/misc/fastrpc.c

   573	
   574	static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
   575				struct fastrpc_user *user, u32 kernel, u32 sc,
   576				struct fastrpc_enhanced_invoke *invoke)
   577	{
   578		struct fastrpc_channel_ctx *cctx = user->cctx;
   579		struct fastrpc_invoke_ctx *ctx = NULL;
   580		unsigned long flags;
   581		int ret;
   582	
   583		ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
   584		if (!ctx)
   585			return ERR_PTR(-ENOMEM);
   586	
   587		INIT_LIST_HEAD(&ctx->node);
   588		ctx->fl = user;
   589		ctx->nscalars = REMOTE_SCALARS_LENGTH(sc);
   590		ctx->nbufs = REMOTE_SCALARS_INBUFS(sc) +
   591			     REMOTE_SCALARS_OUTBUFS(sc);
   592	
   593		if (ctx->nscalars) {
   594			ctx->maps = kcalloc(ctx->nscalars,
   595					    sizeof(*ctx->maps), GFP_KERNEL);
   596			if (!ctx->maps) {
   597				kfree(ctx);
   598				return ERR_PTR(-ENOMEM);
   599			}
   600			ctx->olaps = kcalloc(ctx->nscalars,
   601					    sizeof(*ctx->olaps), GFP_KERNEL);
   602			if (!ctx->olaps) {
   603				kfree(ctx->maps);
   604				kfree(ctx);
   605				return ERR_PTR(-ENOMEM);
   606			}
 > 607			ctx->args = (struct fastrpc_invoke_args *)invoke->inv.args;
   608			fastrpc_get_buff_overlaps(ctx);
   609		}
   610	
   611		/* Released in fastrpc_context_put() */
   612		fastrpc_channel_ctx_get(cctx);
   613	
   614		ctx->sc = sc;
   615		ctx->retval = -1;
   616		ctx->pid = current->pid;
   617		ctx->tgid = user->tgid;
   618		ctx->cctx = cctx;
   619		init_completion(&ctx->work);
   620		INIT_WORK(&ctx->put_work, fastrpc_context_put_wq);
   621	
   622		spin_lock(&user->lock);
   623		list_add_tail(&ctx->node, &user->pending);
   624		spin_unlock(&user->lock);
   625	
   626		spin_lock_irqsave(&cctx->lock, flags);
   627		ret = idr_alloc_cyclic(&cctx->ctx_idr, ctx, 1,
   628				       FASTRPC_CTX_MAX, GFP_ATOMIC);
   629		if (ret < 0) {
   630			spin_unlock_irqrestore(&cctx->lock, flags);
   631			goto err_idr;
   632		}
   633		ctx->ctxid = ret << 4;
   634		spin_unlock_irqrestore(&cctx->lock, flags);
   635	
   636		kref_init(&ctx->refcount);
   637	
   638		return ctx;
   639	err_idr:
   640		spin_lock(&user->lock);
   641		list_del(&ctx->node);
   642		spin_unlock(&user->lock);
   643		fastrpc_channel_ctx_put(cctx);
   644		kfree(ctx->maps);
   645		kfree(ctx->olaps);
   646		kfree(ctx);
   647	
   648		return ERR_PTR(ret);
   649	}
   650	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
