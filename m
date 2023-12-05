Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2B804D25
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbjLEJE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEJEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:04:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C640120
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701767071; x=1733303071;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vIvQf07bm9CAu932FQA2fzcUIxXMoe9QYTWzA/UzqZU=;
  b=l83yxiwdHk0YqFnFakNUBO/ynIw+49JdHX4X1q6orpaOK/W7cafMo6Hu
   PnUuvoe76M/VB78GyHZG3C1WZ6jqvY6lBOFlwZAhiitno266SaJs9D+m4
   l1221WoHJ/5yI97NqN0wHSmGei/2w0A+Q7DolI0fZnqa9fZq6Wam0pvrt
   54hcO1HTJkEJTjngoPUI44iFAFAm2ICYc5S6jBiEb5E9bh0m214bgVETO
   mpDCtYfmauar7KQ3moxmGQjcNfGUWUOGBVQf1WKtO3F9S9A3aoQ/eZklU
   3av6Gnvyu6/pzF2rUoDdr4xZw29SsfUmE8dB6r+fPPNoqBbys9DY8pOFr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="7208191"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="7208191"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:04:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="894296798"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="894296798"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Dec 2023 01:04:29 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rARLu-0008cM-1x;
        Tue, 05 Dec 2023 09:04:26 +0000
Date:   Tue, 5 Dec 2023 17:04:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/btree_io.c:812:5-8: Unneeded variable: "ret". Return "
  0" on line 900
Message-ID: <202312051654.iKqsZSPl-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 39fb2983c5862933798cdd1b59da180bc9642910 bcachefs: Kill bkey_type_successor
date:   6 weeks ago
config: x86_64-randconfig-104-20231204 (https://download.01.org/0day-ci/archive/20231205/202312051654.iKqsZSPl-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20231205/202312051654.iKqsZSPl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051654.iKqsZSPl-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/bcachefs/btree_io.c:812:5-8: Unneeded variable: "ret". Return "  0" on line 900

vim +812 fs/bcachefs/btree_io.c

   804	
   805	static int validate_bset_keys(struct bch_fs *c, struct btree *b,
   806				 struct bset *i, unsigned *whiteout_u64s,
   807				 int write, bool have_retry)
   808	{
   809		unsigned version = le16_to_cpu(i->version);
   810		struct bkey_packed *k, *prev = NULL;
   811		bool seen_non_whiteout = false;
 > 812		int ret = 0;
   813	
   814		if (!BSET_SEPARATE_WHITEOUTS(i)) {
   815			seen_non_whiteout = true;
   816			*whiteout_u64s = 0;
   817		}
   818	
   819		for (k = i->start;
   820		     k != vstruct_last(i);) {
   821			struct bkey_s u;
   822			struct bkey tmp;
   823			const char *invalid;
   824	
   825			if (btree_err_on(bkey_next(k) > vstruct_last(i),
   826					 BTREE_ERR_FIXABLE, c, b, i,
   827					 "key extends past end of bset")) {
   828				i->u64s = cpu_to_le16((u64 *) k - i->_data);
   829				break;
   830			}
   831	
   832			if (btree_err_on(k->format > KEY_FORMAT_CURRENT,
   833					 BTREE_ERR_FIXABLE, c, b, i,
   834					 "invalid bkey format %u", k->format)) {
   835				i->u64s = cpu_to_le16(le16_to_cpu(i->u64s) - k->u64s);
   836				memmove_u64s_down(k, bkey_next(k),
   837						  (u64 *) vstruct_end(i) - (u64 *) k);
   838				continue;
   839			}
   840	
   841			/* XXX: validate k->u64s */
   842			if (!write)
   843				bch2_bkey_compat(b->c.level, b->c.btree_id, version,
   844					    BSET_BIG_ENDIAN(i), write,
   845					    &b->format, k);
   846	
   847			u = __bkey_disassemble(b, k, &tmp);
   848	
   849			invalid = __bch2_bkey_invalid(c, u.s_c, btree_node_type(b)) ?:
   850				bch2_bkey_in_btree_node(b, u.s_c) ?:
   851				(write ? bch2_bkey_val_invalid(c, u.s_c) : NULL);
   852			if (invalid) {
   853				char buf[160];
   854	
   855				bch2_bkey_val_to_text(&PBUF(buf), c, u.s_c);
   856				btree_err(BTREE_ERR_FIXABLE, c, b, i,
   857					  "invalid bkey:\n%s\n%s", invalid, buf);
   858	
   859				i->u64s = cpu_to_le16(le16_to_cpu(i->u64s) - k->u64s);
   860				memmove_u64s_down(k, bkey_next(k),
   861						  (u64 *) vstruct_end(i) - (u64 *) k);
   862				continue;
   863			}
   864	
   865			if (write)
   866				bch2_bkey_compat(b->c.level, b->c.btree_id, version,
   867					    BSET_BIG_ENDIAN(i), write,
   868					    &b->format, k);
   869	
   870			/*
   871			 * with the separate whiteouts thing (used for extents), the
   872			 * second set of keys actually can have whiteouts too, so we
   873			 * can't solely go off bkey_whiteout()...
   874			 */
   875	
   876			if (!seen_non_whiteout &&
   877			    (!bkey_whiteout(k) ||
   878			     (prev && bkey_iter_cmp(b, prev, k) > 0))) {
   879				*whiteout_u64s = k->_data - i->_data;
   880				seen_non_whiteout = true;
   881			} else if (prev && bkey_iter_cmp(b, prev, k) > 0) {
   882				char buf1[80];
   883				char buf2[80];
   884				struct bkey up = bkey_unpack_key(b, prev);
   885	
   886				bch2_bkey_to_text(&PBUF(buf1), &up);
   887				bch2_bkey_to_text(&PBUF(buf2), u.k);
   888	
   889				bch2_dump_bset(b, i, 0);
   890				btree_err(BTREE_ERR_FATAL, c, b, i,
   891					  "keys out of order: %s > %s",
   892					  buf1, buf2);
   893				/* XXX: repair this */
   894			}
   895	
   896			prev = k;
   897			k = bkey_next_skip_noops(k, vstruct_last(i));
   898		}
   899	fsck_err:
 > 900		return ret;
   901	}
   902	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
