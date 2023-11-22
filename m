Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE47F4B84
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235358AbjKVPsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjKVPsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:48:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E1A47B7;
        Wed, 22 Nov 2023 07:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700667992; x=1732203992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jR7nXrT/MznIEATtzqOZvdfyVsT5TGUuHhBxaf2q+AA=;
  b=GoiuWhP+3wVQYNbxNbGFJh0NIP5I6uZSMt9BdOT3jIzYqY0WWYNIo5Ps
   O+VQyD2AZW50rs+ZIaa2ktoNs7iFNFxlAj+G5k6vYWbF/EGiXhqr0nXAE
   +H3tU2+N3Nz3ZwMS9UHOBjDhAaK+TOCdNirjnFaVuH6rzsf+6UvZS7MuR
   oFyi06Qj3QliFPaZPgSrT3Tdf3m5fxfkA/SgC6L6rpNuZKrhL9ETmHnNT
   EqO4PbITI4neSJ/YtCVY0hsTcQWQ8JZmeDGGx8WqB9hwN4ZAA6balJoZN
   VSUgOfNysdy81MNvNnmtsVn35mo69Ix1eHmcp3jGNY3IGxtFXYIB+iH9m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="13623157"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="13623157"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 07:46:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="8510496"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 22 Nov 2023 07:46:23 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5pQj-0000dK-0V;
        Wed, 22 Nov 2023 15:46:21 +0000
Date:   Wed, 22 Nov 2023 23:45:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] misc: fastrpc: Add fastrpc multimode invoke
 request support
Message-ID: <202311222004.ycVXExec-lkp@intel.com>
References: <20231121094844.5764-2-quic_ekangupt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121094844.5764-2-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ekansh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ekansh-Gupta/misc-fastrpc-Add-fastrpc-multimode-invoke-request-support/20231121-175147
base:   linus/master
patch link:    https://lore.kernel.org/r/20231121094844.5764-2-quic_ekangupt%40quicinc.com
patch subject: [PATCH v7 1/5] misc: fastrpc: Add fastrpc multimode invoke request support
config: mips-randconfig-r122-20231122 (https://download.01.org/0day-ci/archive/20231122/202311222004.ycVXExec-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311222004.ycVXExec-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311222004.ycVXExec-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/misc/fastrpc.c:607:59: sparse: sparse: non size-preserving integer to pointer cast
>> drivers/misc/fastrpc.c:1318:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1451:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1515:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1663:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1694:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1741:40: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1771:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1874:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:1972:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:2053:33: sparse: sparse: non size-preserving pointer to integer cast
   drivers/misc/fastrpc.c:2124:33: sparse: sparse: non size-preserving pointer to integer cast

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
