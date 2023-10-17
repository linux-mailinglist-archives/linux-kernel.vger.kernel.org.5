Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9617CC835
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344183AbjJQPz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344236AbjJQPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:55:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E48ED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697558147; x=1729094147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L8bdRBcQJvCzMhol56/HrVo4cdh6VqXD3JOAlKbOt98=;
  b=BwjDqaKdf62oK5LMyAIbPzd2LpL+M3QL2y20UAyzROLdj0f7SspkQR5w
   PM5moEsKGvxRlhBRk8mfPj0pPX5nJDo2PaaaG3VoP43kxQsyGiwx+aRNP
   m79PXzxeq8ZdtKJhg5cWGaTv3rAqDRtUP3d5mzLon/pWLjVODHfnrJWQp
   oolg7nZFUu5I0DpSQHbAFonnnDpKeFSSkVI5N+2n7qyr17a10+vuB0UaH
   +hyuG8oderek0Z9i4pBZ+U2+CLFig8/TotRae2YY9O4r/whO/t74H7we5
   9nsPukjpObfozroHcr1Rjx+AqM7N0EsznQjRkxlJ94XfB86MePVQuP8P+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="385651921"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="385651921"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 08:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="791271129"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="791271129"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Oct 2023 08:55:40 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsmPx-0009lr-2W;
        Tue, 17 Oct 2023 15:55:37 +0000
Date:   Tue, 17 Oct 2023 23:55:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
        hare@suse.de, Mark O'Donovan <shiftee@posteo.net>,
        Akash Appaiah <Akash.Appaiah@dell.com>
Subject: Re: [PATCH v4 1/3] nvme-auth: alloc nvme_dhchap_key as single buffer
Message-ID: <202310172318.IgK0V5EX-lkp@intel.com>
References: <20231017105251.3274652-2-shiftee@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017105251.3274652-2-shiftee@posteo.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

kernel test robot noticed the following build warnings:

[auto build test WARNING on hch-configfs/for-next]
[also build test WARNING on linus/master v6.6-rc6 next-20231017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mark-O-Donovan/nvme-auth-alloc-nvme_dhchap_key-as-single-buffer/20231017-185421
base:   git://git.infradead.org/users/hch/configfs.git for-next
patch link:    https://lore.kernel.org/r/20231017105251.3274652-2-shiftee%40posteo.net
patch subject: [PATCH v4 1/3] nvme-auth: alloc nvme_dhchap_key as single buffer
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310172318.IgK0V5EX-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172318.IgK0V5EX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172318.IgK0V5EX-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/common/auth.c: In function 'nvme_auth_transform_key':
>> drivers/nvme/common/auth.c:253:21: warning: the comparison will always evaluate as 'true' for the address of 'key' will never be NULL [-Waddress]
     253 |         if (!key || !key->key) {
         |                     ^
   In file included from drivers/nvme/common/auth.c:15:
   include/linux/nvme-auth.h:14:12: note: 'key' declared here
      14 |         u8 key[];
         |            ^~~


vim +253 drivers/nvme/common/auth.c

f50fff73d620cd Hannes Reinecke 2022-06-27  244  
f50fff73d620cd Hannes Reinecke 2022-06-27  245  u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
f50fff73d620cd Hannes Reinecke 2022-06-27  246  {
f50fff73d620cd Hannes Reinecke 2022-06-27  247  	const char *hmac_name;
f50fff73d620cd Hannes Reinecke 2022-06-27  248  	struct crypto_shash *key_tfm;
f50fff73d620cd Hannes Reinecke 2022-06-27  249  	struct shash_desc *shash;
f50fff73d620cd Hannes Reinecke 2022-06-27  250  	u8 *transformed_key;
f50fff73d620cd Hannes Reinecke 2022-06-27  251  	int ret;
f50fff73d620cd Hannes Reinecke 2022-06-27  252  
f50fff73d620cd Hannes Reinecke 2022-06-27 @253  	if (!key || !key->key) {
f50fff73d620cd Hannes Reinecke 2022-06-27  254  		pr_warn("No key specified\n");
f50fff73d620cd Hannes Reinecke 2022-06-27  255  		return ERR_PTR(-ENOKEY);
f50fff73d620cd Hannes Reinecke 2022-06-27  256  	}
f50fff73d620cd Hannes Reinecke 2022-06-27  257  	if (key->hash == 0) {
f50fff73d620cd Hannes Reinecke 2022-06-27  258  		transformed_key = kmemdup(key->key, key->len, GFP_KERNEL);
f50fff73d620cd Hannes Reinecke 2022-06-27  259  		return transformed_key ? transformed_key : ERR_PTR(-ENOMEM);
f50fff73d620cd Hannes Reinecke 2022-06-27  260  	}
f50fff73d620cd Hannes Reinecke 2022-06-27  261  	hmac_name = nvme_auth_hmac_name(key->hash);
f50fff73d620cd Hannes Reinecke 2022-06-27  262  	if (!hmac_name) {
f50fff73d620cd Hannes Reinecke 2022-06-27  263  		pr_warn("Invalid key hash id %d\n", key->hash);
f50fff73d620cd Hannes Reinecke 2022-06-27  264  		return ERR_PTR(-EINVAL);
f50fff73d620cd Hannes Reinecke 2022-06-27  265  	}
f50fff73d620cd Hannes Reinecke 2022-06-27  266  
f50fff73d620cd Hannes Reinecke 2022-06-27  267  	key_tfm = crypto_alloc_shash(hmac_name, 0, 0);
f50fff73d620cd Hannes Reinecke 2022-06-27  268  	if (IS_ERR(key_tfm))
f50fff73d620cd Hannes Reinecke 2022-06-27  269  		return (u8 *)key_tfm;
f50fff73d620cd Hannes Reinecke 2022-06-27  270  
f50fff73d620cd Hannes Reinecke 2022-06-27  271  	shash = kmalloc(sizeof(struct shash_desc) +
f50fff73d620cd Hannes Reinecke 2022-06-27  272  			crypto_shash_descsize(key_tfm),
f50fff73d620cd Hannes Reinecke 2022-06-27  273  			GFP_KERNEL);
f50fff73d620cd Hannes Reinecke 2022-06-27  274  	if (!shash) {
f50fff73d620cd Hannes Reinecke 2022-06-27  275  		ret = -ENOMEM;
f50fff73d620cd Hannes Reinecke 2022-06-27  276  		goto out_free_key;
f50fff73d620cd Hannes Reinecke 2022-06-27  277  	}
f50fff73d620cd Hannes Reinecke 2022-06-27  278  
f50fff73d620cd Hannes Reinecke 2022-06-27  279  	transformed_key = kzalloc(crypto_shash_digestsize(key_tfm), GFP_KERNEL);
f50fff73d620cd Hannes Reinecke 2022-06-27  280  	if (!transformed_key) {
f50fff73d620cd Hannes Reinecke 2022-06-27  281  		ret = -ENOMEM;
f50fff73d620cd Hannes Reinecke 2022-06-27  282  		goto out_free_shash;
f50fff73d620cd Hannes Reinecke 2022-06-27  283  	}
f50fff73d620cd Hannes Reinecke 2022-06-27  284  
f50fff73d620cd Hannes Reinecke 2022-06-27  285  	shash->tfm = key_tfm;
f50fff73d620cd Hannes Reinecke 2022-06-27  286  	ret = crypto_shash_setkey(key_tfm, key->key, key->len);
f50fff73d620cd Hannes Reinecke 2022-06-27  287  	if (ret < 0)
80e2768496a494 Dan Carpenter   2022-07-18  288  		goto out_free_transformed_key;
f50fff73d620cd Hannes Reinecke 2022-06-27  289  	ret = crypto_shash_init(shash);
f50fff73d620cd Hannes Reinecke 2022-06-27  290  	if (ret < 0)
80e2768496a494 Dan Carpenter   2022-07-18  291  		goto out_free_transformed_key;
f50fff73d620cd Hannes Reinecke 2022-06-27  292  	ret = crypto_shash_update(shash, nqn, strlen(nqn));
f50fff73d620cd Hannes Reinecke 2022-06-27  293  	if (ret < 0)
80e2768496a494 Dan Carpenter   2022-07-18  294  		goto out_free_transformed_key;
f50fff73d620cd Hannes Reinecke 2022-06-27  295  	ret = crypto_shash_update(shash, "NVMe-over-Fabrics", 17);
f50fff73d620cd Hannes Reinecke 2022-06-27  296  	if (ret < 0)
80e2768496a494 Dan Carpenter   2022-07-18  297  		goto out_free_transformed_key;
f50fff73d620cd Hannes Reinecke 2022-06-27  298  	ret = crypto_shash_final(shash, transformed_key);
80e2768496a494 Dan Carpenter   2022-07-18  299  	if (ret < 0)
80e2768496a494 Dan Carpenter   2022-07-18  300  		goto out_free_transformed_key;
80e2768496a494 Dan Carpenter   2022-07-18  301  
80e2768496a494 Dan Carpenter   2022-07-18  302  	kfree(shash);
80e2768496a494 Dan Carpenter   2022-07-18  303  	crypto_free_shash(key_tfm);
80e2768496a494 Dan Carpenter   2022-07-18  304  
80e2768496a494 Dan Carpenter   2022-07-18  305  	return transformed_key;
80e2768496a494 Dan Carpenter   2022-07-18  306  
80e2768496a494 Dan Carpenter   2022-07-18  307  out_free_transformed_key:
80e2768496a494 Dan Carpenter   2022-07-18  308  	kfree_sensitive(transformed_key);
f50fff73d620cd Hannes Reinecke 2022-06-27  309  out_free_shash:
f50fff73d620cd Hannes Reinecke 2022-06-27  310  	kfree(shash);
f50fff73d620cd Hannes Reinecke 2022-06-27  311  out_free_key:
f50fff73d620cd Hannes Reinecke 2022-06-27  312  	crypto_free_shash(key_tfm);
80e2768496a494 Dan Carpenter   2022-07-18  313  
f50fff73d620cd Hannes Reinecke 2022-06-27  314  	return ERR_PTR(ret);
f50fff73d620cd Hannes Reinecke 2022-06-27  315  }
f50fff73d620cd Hannes Reinecke 2022-06-27  316  EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
f50fff73d620cd Hannes Reinecke 2022-06-27  317  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
