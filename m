Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5F7802152
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 07:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjLCGe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 01:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjLCGeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 01:34:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D587114
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 22:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701585228; x=1733121228;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PdSZvTWOsgnLqAmy0wUew8zktWnmi9+byJvOUyraLuA=;
  b=lfmeTAQ3rjmKD7k0FJkqjWiLbstCwM4ggpwt6cMw//M6DfI8TfLzX1Yy
   i2nxiYAOaXLK0ImxsobAatqTNDgbF6uCAbpkMDEbONwPhLrua2hNcaFtx
   ZMIYFxCbtRGJpJFMFYNNQNWRiAEmKkby76N2e37TU39ss+PdoU+jWaI92
   AgQurAykNFby37uG53mI9mvBYd7yKQ0wCwVnHriPP1CaZepyuTGHHB4Vq
   y+qJozT7NzrtjI1ocYpnorWcoP2JYzyyrb60lqqWKPmgz6vNYy2vxPxiP
   AFIPwxJWSSC31QKNJgsfoqZfaJRNUcCyZbR1zwY/n+9X6fELSfO+nlf8V
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="6906541"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="6906541"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2023 22:32:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="770191168"
X-IronPort-AV: E=Sophos;i="6.04,246,1695711600"; 
   d="scan'208";a="770191168"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2023 22:32:47 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r9g21-0006MQ-0I;
        Sun, 03 Dec 2023 06:32:45 +0000
Date:   Sun, 3 Dec 2023 14:31:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: fs/ubifs/auth.c:30: warning: expecting prototype for
 ubifs_node_calc_hash(). Prototype was for __ubifs_node_calc_hash() instead
Message-ID: <202312030417.66c5PwHj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   815fb87b753055df2d9e50f6cd80eb10235fe3e9
commit: d8a22773a12c6d78ee758c9e530f3a488bb7cb29 ubifs: Enable authentication support
date:   5 years ago
config: x86_64-randconfig-x051-20230728 (https://download.01.org/0day-ci/archive/20231203/202312030417.66c5PwHj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231203/202312030417.66c5PwHj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312030417.66c5PwHj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ubifs/auth.c:158:5: warning: no previous prototype for '__ubifs_shash_final' [-Wmissing-prototypes]
     158 | int __ubifs_shash_final(const struct ubifs_info *c, struct shash_desc *desc,
         |     ^~~~~~~~~~~~~~~~~~~
>> fs/ubifs/auth.c:30: warning: expecting prototype for ubifs_node_calc_hash(). Prototype was for __ubifs_node_calc_hash() instead
   fs/ubifs/auth.c:80: warning: Function parameter or member 'inhash' not described in 'ubifs_prepare_auth_node'
   fs/ubifs/auth.c:80: warning: Excess function parameter 'hash' description in 'ubifs_prepare_auth_node'
   fs/ubifs/auth.o: warning: objtool: ubifs_init_authentication()+0x219: sibling call from callable instruction with modified stack frame

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for BACKLIGHT_CLASS_DEVICE
   Depends on [n]: HAS_IOMEM [=y] && BACKLIGHT_LCD_SUPPORT [=n]
   Selected by [y]:
   - ACPI_CMPC [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y] && INPUT [=y] && (RFKILL [=n] || RFKILL [=n]=n)
   - SAMSUNG_Q10 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI [=y]


vim +30 fs/ubifs/auth.c

49525e5eecca5e Sascha Hauer 2018-09-07   19  
49525e5eecca5e Sascha Hauer 2018-09-07   20  /**
49525e5eecca5e Sascha Hauer 2018-09-07   21   * ubifs_node_calc_hash - calculate the hash of a UBIFS node
49525e5eecca5e Sascha Hauer 2018-09-07   22   * @c: UBIFS file-system description object
49525e5eecca5e Sascha Hauer 2018-09-07   23   * @node: the node to calculate a hash for
49525e5eecca5e Sascha Hauer 2018-09-07   24   * @hash: the returned hash
49525e5eecca5e Sascha Hauer 2018-09-07   25   *
49525e5eecca5e Sascha Hauer 2018-09-07   26   * Returns 0 for success or a negative error code otherwise.
49525e5eecca5e Sascha Hauer 2018-09-07   27   */
49525e5eecca5e Sascha Hauer 2018-09-07   28  int __ubifs_node_calc_hash(const struct ubifs_info *c, const void *node,
49525e5eecca5e Sascha Hauer 2018-09-07   29  			    u8 *hash)
49525e5eecca5e Sascha Hauer 2018-09-07  @30  {
49525e5eecca5e Sascha Hauer 2018-09-07   31  	const struct ubifs_ch *ch = node;
49525e5eecca5e Sascha Hauer 2018-09-07   32  	SHASH_DESC_ON_STACK(shash, c->hash_tfm);
49525e5eecca5e Sascha Hauer 2018-09-07   33  	int err;
49525e5eecca5e Sascha Hauer 2018-09-07   34  
49525e5eecca5e Sascha Hauer 2018-09-07   35  	shash->tfm = c->hash_tfm;
49525e5eecca5e Sascha Hauer 2018-09-07   36  	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
49525e5eecca5e Sascha Hauer 2018-09-07   37  
49525e5eecca5e Sascha Hauer 2018-09-07   38  	err = crypto_shash_digest(shash, node, le32_to_cpu(ch->len), hash);
49525e5eecca5e Sascha Hauer 2018-09-07   39  	if (err < 0)
49525e5eecca5e Sascha Hauer 2018-09-07   40  		return err;
49525e5eecca5e Sascha Hauer 2018-09-07   41  	return 0;
49525e5eecca5e Sascha Hauer 2018-09-07   42  }
49525e5eecca5e Sascha Hauer 2018-09-07   43  
49525e5eecca5e Sascha Hauer 2018-09-07   44  /**
49525e5eecca5e Sascha Hauer 2018-09-07   45   * ubifs_hash_calc_hmac - calculate a HMAC from a hash
49525e5eecca5e Sascha Hauer 2018-09-07   46   * @c: UBIFS file-system description object
49525e5eecca5e Sascha Hauer 2018-09-07   47   * @hash: the node to calculate a HMAC for
49525e5eecca5e Sascha Hauer 2018-09-07   48   * @hmac: the returned HMAC
49525e5eecca5e Sascha Hauer 2018-09-07   49   *
49525e5eecca5e Sascha Hauer 2018-09-07   50   * Returns 0 for success or a negative error code otherwise.
49525e5eecca5e Sascha Hauer 2018-09-07   51   */
49525e5eecca5e Sascha Hauer 2018-09-07   52  static int ubifs_hash_calc_hmac(const struct ubifs_info *c, const u8 *hash,
49525e5eecca5e Sascha Hauer 2018-09-07   53  				 u8 *hmac)
49525e5eecca5e Sascha Hauer 2018-09-07   54  {
49525e5eecca5e Sascha Hauer 2018-09-07   55  	SHASH_DESC_ON_STACK(shash, c->hmac_tfm);
49525e5eecca5e Sascha Hauer 2018-09-07   56  	int err;
49525e5eecca5e Sascha Hauer 2018-09-07   57  
49525e5eecca5e Sascha Hauer 2018-09-07   58  	shash->tfm = c->hmac_tfm;
49525e5eecca5e Sascha Hauer 2018-09-07   59  	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
49525e5eecca5e Sascha Hauer 2018-09-07   60  
49525e5eecca5e Sascha Hauer 2018-09-07   61  	err = crypto_shash_digest(shash, hash, c->hash_len, hmac);
49525e5eecca5e Sascha Hauer 2018-09-07   62  	if (err < 0)
49525e5eecca5e Sascha Hauer 2018-09-07   63  		return err;
49525e5eecca5e Sascha Hauer 2018-09-07   64  	return 0;
49525e5eecca5e Sascha Hauer 2018-09-07   65  }
49525e5eecca5e Sascha Hauer 2018-09-07   66  
49525e5eecca5e Sascha Hauer 2018-09-07   67  /**
49525e5eecca5e Sascha Hauer 2018-09-07   68   * ubifs_prepare_auth_node - Prepare an authentication node
49525e5eecca5e Sascha Hauer 2018-09-07   69   * @c: UBIFS file-system description object
49525e5eecca5e Sascha Hauer 2018-09-07   70   * @node: the node to calculate a hash for
49525e5eecca5e Sascha Hauer 2018-09-07   71   * @hash: input hash of previous nodes
49525e5eecca5e Sascha Hauer 2018-09-07   72   *
49525e5eecca5e Sascha Hauer 2018-09-07   73   * This function prepares an authentication node for writing onto flash.
49525e5eecca5e Sascha Hauer 2018-09-07   74   * It creates a HMAC from the given input hash and writes it to the node.
49525e5eecca5e Sascha Hauer 2018-09-07   75   *
49525e5eecca5e Sascha Hauer 2018-09-07   76   * Returns 0 for success or a negative error code otherwise.
49525e5eecca5e Sascha Hauer 2018-09-07   77   */
49525e5eecca5e Sascha Hauer 2018-09-07   78  int ubifs_prepare_auth_node(struct ubifs_info *c, void *node,
49525e5eecca5e Sascha Hauer 2018-09-07   79  			     struct shash_desc *inhash)
49525e5eecca5e Sascha Hauer 2018-09-07   80  {
49525e5eecca5e Sascha Hauer 2018-09-07   81  	SHASH_DESC_ON_STACK(hash_desc, c->hash_tfm);
49525e5eecca5e Sascha Hauer 2018-09-07   82  	struct ubifs_auth_node *auth = node;
49525e5eecca5e Sascha Hauer 2018-09-07   83  	u8 *hash;
49525e5eecca5e Sascha Hauer 2018-09-07   84  	int err;
49525e5eecca5e Sascha Hauer 2018-09-07   85  
49525e5eecca5e Sascha Hauer 2018-09-07   86  	hash = kmalloc(crypto_shash_descsize(c->hash_tfm), GFP_NOFS);
49525e5eecca5e Sascha Hauer 2018-09-07   87  	if (!hash)
49525e5eecca5e Sascha Hauer 2018-09-07   88  		return -ENOMEM;
49525e5eecca5e Sascha Hauer 2018-09-07   89  
49525e5eecca5e Sascha Hauer 2018-09-07   90  	hash_desc->tfm = c->hash_tfm;
49525e5eecca5e Sascha Hauer 2018-09-07   91  	hash_desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
49525e5eecca5e Sascha Hauer 2018-09-07   92  	ubifs_shash_copy_state(c, inhash, hash_desc);
49525e5eecca5e Sascha Hauer 2018-09-07   93  
49525e5eecca5e Sascha Hauer 2018-09-07   94  	err = crypto_shash_final(hash_desc, hash);
49525e5eecca5e Sascha Hauer 2018-09-07   95  	if (err)
49525e5eecca5e Sascha Hauer 2018-09-07   96  		goto out;
49525e5eecca5e Sascha Hauer 2018-09-07   97  
49525e5eecca5e Sascha Hauer 2018-09-07   98  	err = ubifs_hash_calc_hmac(c, hash, auth->hmac);
49525e5eecca5e Sascha Hauer 2018-09-07   99  	if (err)
49525e5eecca5e Sascha Hauer 2018-09-07  100  		goto out;
49525e5eecca5e Sascha Hauer 2018-09-07  101  
49525e5eecca5e Sascha Hauer 2018-09-07  102  	auth->ch.node_type = UBIFS_AUTH_NODE;
49525e5eecca5e Sascha Hauer 2018-09-07  103  	ubifs_prepare_node(c, auth, ubifs_auth_node_sz(c), 0);
49525e5eecca5e Sascha Hauer 2018-09-07  104  
49525e5eecca5e Sascha Hauer 2018-09-07  105  	err = 0;
49525e5eecca5e Sascha Hauer 2018-09-07  106  out:
49525e5eecca5e Sascha Hauer 2018-09-07  107  	kfree(hash);
49525e5eecca5e Sascha Hauer 2018-09-07  108  
49525e5eecca5e Sascha Hauer 2018-09-07  109  	return err;
49525e5eecca5e Sascha Hauer 2018-09-07  110  }
49525e5eecca5e Sascha Hauer 2018-09-07  111  
49525e5eecca5e Sascha Hauer 2018-09-07  112  static struct shash_desc *ubifs_get_desc(const struct ubifs_info *c,
49525e5eecca5e Sascha Hauer 2018-09-07  113  					 struct crypto_shash *tfm)
49525e5eecca5e Sascha Hauer 2018-09-07  114  {
49525e5eecca5e Sascha Hauer 2018-09-07  115  	struct shash_desc *desc;
49525e5eecca5e Sascha Hauer 2018-09-07  116  	int err;
49525e5eecca5e Sascha Hauer 2018-09-07  117  
49525e5eecca5e Sascha Hauer 2018-09-07  118  	if (!ubifs_authenticated(c))
49525e5eecca5e Sascha Hauer 2018-09-07  119  		return NULL;
49525e5eecca5e Sascha Hauer 2018-09-07  120  
49525e5eecca5e Sascha Hauer 2018-09-07  121  	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(tfm), GFP_KERNEL);
49525e5eecca5e Sascha Hauer 2018-09-07  122  	if (!desc)
49525e5eecca5e Sascha Hauer 2018-09-07  123  		return ERR_PTR(-ENOMEM);
49525e5eecca5e Sascha Hauer 2018-09-07  124  
49525e5eecca5e Sascha Hauer 2018-09-07  125  	desc->tfm = tfm;
49525e5eecca5e Sascha Hauer 2018-09-07  126  	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
49525e5eecca5e Sascha Hauer 2018-09-07  127  
49525e5eecca5e Sascha Hauer 2018-09-07  128  	err = crypto_shash_init(desc);
49525e5eecca5e Sascha Hauer 2018-09-07  129  	if (err) {
49525e5eecca5e Sascha Hauer 2018-09-07  130  		kfree(desc);
49525e5eecca5e Sascha Hauer 2018-09-07  131  		return ERR_PTR(err);
49525e5eecca5e Sascha Hauer 2018-09-07  132  	}
49525e5eecca5e Sascha Hauer 2018-09-07  133  
49525e5eecca5e Sascha Hauer 2018-09-07  134  	return desc;
49525e5eecca5e Sascha Hauer 2018-09-07  135  }
49525e5eecca5e Sascha Hauer 2018-09-07  136  
49525e5eecca5e Sascha Hauer 2018-09-07  137  /**
49525e5eecca5e Sascha Hauer 2018-09-07  138   * __ubifs_hash_get_desc - get a descriptor suitable for hashing a node
49525e5eecca5e Sascha Hauer 2018-09-07  139   * @c: UBIFS file-system description object
49525e5eecca5e Sascha Hauer 2018-09-07  140   *
49525e5eecca5e Sascha Hauer 2018-09-07  141   * This function returns a descriptor suitable for hashing a node. Free after use
49525e5eecca5e Sascha Hauer 2018-09-07  142   * with kfree.
49525e5eecca5e Sascha Hauer 2018-09-07  143   */
49525e5eecca5e Sascha Hauer 2018-09-07  144  struct shash_desc *__ubifs_hash_get_desc(const struct ubifs_info *c)
49525e5eecca5e Sascha Hauer 2018-09-07  145  {
49525e5eecca5e Sascha Hauer 2018-09-07  146  	return ubifs_get_desc(c, c->hash_tfm);
49525e5eecca5e Sascha Hauer 2018-09-07  147  }
49525e5eecca5e Sascha Hauer 2018-09-07  148  
49525e5eecca5e Sascha Hauer 2018-09-07  149  /**
49525e5eecca5e Sascha Hauer 2018-09-07  150   * __ubifs_shash_final - finalize shash
49525e5eecca5e Sascha Hauer 2018-09-07  151   * @c: UBIFS file-system description object
49525e5eecca5e Sascha Hauer 2018-09-07  152   * @desc: the descriptor
49525e5eecca5e Sascha Hauer 2018-09-07  153   * @out: the output hash
49525e5eecca5e Sascha Hauer 2018-09-07  154   *
49525e5eecca5e Sascha Hauer 2018-09-07  155   * Simple wrapper around crypto_shash_final(), safe to be called with
49525e5eecca5e Sascha Hauer 2018-09-07  156   * disabled authentication.
49525e5eecca5e Sascha Hauer 2018-09-07  157   */
49525e5eecca5e Sascha Hauer 2018-09-07 @158  int __ubifs_shash_final(const struct ubifs_info *c, struct shash_desc *desc,
49525e5eecca5e Sascha Hauer 2018-09-07  159  			u8 *out)
49525e5eecca5e Sascha Hauer 2018-09-07  160  {
49525e5eecca5e Sascha Hauer 2018-09-07  161  	if (ubifs_authenticated(c))
49525e5eecca5e Sascha Hauer 2018-09-07  162  		return crypto_shash_final(desc, out);
49525e5eecca5e Sascha Hauer 2018-09-07  163  
49525e5eecca5e Sascha Hauer 2018-09-07  164  	return 0;
49525e5eecca5e Sascha Hauer 2018-09-07  165  }
49525e5eecca5e Sascha Hauer 2018-09-07  166  

:::::: The code at line 30 was first introduced by commit
:::::: 49525e5eecca5e1b4a83ac217868e8d8b843539f ubifs: Add helper functions for authentication support

:::::: TO: Sascha Hauer <s.hauer@pengutronix.de>
:::::: CC: Richard Weinberger <richard@nod.at>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
