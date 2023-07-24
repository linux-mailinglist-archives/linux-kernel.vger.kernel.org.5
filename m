Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D882F75EC7A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGXH1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjGXH1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:27:35 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30939E1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690183654; x=1721719654;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x6bKrwl7oUNAcR5lc0YG/43K6nFhpwki+9eqcsHfnxo=;
  b=SXZK9mUCJSsnPgjed3UcRRsd8HNZoUAVJSSgdiQ27Xu2QSdZqddwrRDo
   b9opL7suKX56cMWcWX/ABH3OrApAdDUqhNHNJsqRc1BBcjMa9IGrP4SLp
   S+Sa6rHZyCT9VLtCQD9Gh+FSBuo06DJqwwgjWqY0gmAGr9IR3n+QgxaMl
   WepjAwIFRp+WowUVZzV6M9UJ/O7wKahrwNoM2zlhq8sz5GVV7MShMfu7W
   gxuZZn6Dlh8laO+sA5cYjymZAPoGePpYyarkcr7Gg9ZJIJMtkxXY4HawL
   C2VXO6Mh0OAP0fEptu9I2cSTF33KM/JK/CDes1DLmdk7JqC6tIUcuE8cu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="364832259"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364832259"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 00:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="719564264"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="719564264"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Jul 2023 00:27:31 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNpyd-0009Z2-02;
        Mon, 24 Jul 2023 07:27:31 +0000
Date:   Mon, 24 Jul 2023 15:26:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: net/wireless/pmsr.c:186:12: warning: stack frame size (2640) exceeds
 limit (2048) in 'pmsr_parse_peer'
Message-ID: <202307241512.oEYN9ZOx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6eaae198076080886b9e7d57f4ae06fa782f90ef
commit: 8341dcfbd8dda98a3b2836a421016f7d88e35b1c riscv: Enable Undefined Behavior Sanitizer UBSAN
date:   1 year, 11 months ago
config: riscv-randconfig-r042-20230724 (https://download.01.org/0day-ci/archive/20230724/202307241512.oEYN9ZOx-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307241512.oEYN9ZOx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307241512.oEYN9ZOx-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/wireless/pmsr.c:186:12: warning: stack frame size (2640) exceeds limit (2048) in 'pmsr_parse_peer' [-Wframe-larger-than]
     186 | static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
         |            ^
   1 warning generated.
--
>> net/wireless/reg.c:2437:13: warning: stack frame size (2352) exceeds limit (2048) in 'wiphy_update_regulatory' [-Wframe-larger-than]
    2437 | static void wiphy_update_regulatory(struct wiphy *wiphy,
         |             ^
   1 warning generated.
--
   kernel/sched/fair.c:5438:6: warning: no previous prototype for function 'init_cfs_bandwidth' [-Wmissing-prototypes]
    5438 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |      ^
   kernel/sched/fair.c:5438:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    5438 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         | ^
         | static 
   kernel/sched/fair.c:11457:6: warning: no previous prototype for function 'free_fair_sched_group' [-Wmissing-prototypes]
    11457 | void free_fair_sched_group(struct task_group *tg) { }
          |      ^
   kernel/sched/fair.c:11457:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    11457 | void free_fair_sched_group(struct task_group *tg) { }
          | ^
          | static 
   kernel/sched/fair.c:11459:5: warning: no previous prototype for function 'alloc_fair_sched_group' [-Wmissing-prototypes]
    11459 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
          |     ^
   kernel/sched/fair.c:11459:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    11459 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
          | ^
          | static 
   kernel/sched/fair.c:11464:6: warning: no previous prototype for function 'online_fair_sched_group' [-Wmissing-prototypes]
    11464 | void online_fair_sched_group(struct task_group *tg) { }
          |      ^
   kernel/sched/fair.c:11464:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    11464 | void online_fair_sched_group(struct task_group *tg) { }
          | ^
          | static 
   kernel/sched/fair.c:11466:6: warning: no previous prototype for function 'unregister_fair_sched_group' [-Wmissing-prototypes]
    11466 | void unregister_fair_sched_group(struct task_group *tg) { }
          |      ^
   kernel/sched/fair.c:11466:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    11466 | void unregister_fair_sched_group(struct task_group *tg) { }
          | ^
          | static 
   kernel/sched/fair.c:450:20: warning: unused function 'list_del_leaf_cfs_rq' [-Wunused-function]
     450 | static inline void list_del_leaf_cfs_rq(struct cfs_rq *cfs_rq)
         |                    ^
   kernel/sched/fair.c:5419:20: warning: unused function 'sync_throttle' [-Wunused-function]
    5419 | static inline void sync_throttle(struct task_group *tg, int cpu) {}
         |                    ^
   kernel/sched/fair.c:5444:37: warning: unused function 'tg_cfs_bandwidth' [-Wunused-function]
    5444 | static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
         |                                     ^
   kernel/sched/fair.c:5448:20: warning: unused function 'destroy_cfs_bandwidth' [-Wunused-function]
    5448 | static inline void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |                    ^
>> kernel/sched/fair.c:9712:12: warning: stack frame size (2320) exceeds limit (2048) in 'load_balance' [-Wframe-larger-than]
    9712 | static int load_balance(int this_cpu, struct rq *this_rq,
         |            ^
   10 warnings generated.
   /tmp/fair-295e8c.s: Assembler messages:
   /tmp/fair-295e8c.s:6618: Error: unrecognized opcode `csrrc s9,0x100,2', extension `zicsr' required
   /tmp/fair-295e8c.s:6631: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/fair-295e8c.s:20948: Error: unrecognized opcode `csrrc s5,0x100,2', extension `zicsr' required
   /tmp/fair-295e8c.s:21087: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/fair-295e8c.s:24185: Error: unrecognized opcode `csrrc s4,0x100,2', extension `zicsr' required
   /tmp/fair-295e8c.s:24567: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/fair-295e8c.s:25097: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/fair-295e8c.s:25149: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/fair-295e8c.s:25164: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/fair-295e8c.s:25188: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/fair-295e8c.s:26611: Error: unrecognized opcode `csrc 0x100,2', extension `zicsr' required
   /tmp/fair-295e8c.s:26711: Error: unrecognized opcode `csrs 0x100,2', extension `zicsr' required
   clang: error: assembler command failed with exit code 1 (use -v to see invocation)
--
>> drivers/mmc/host/sdhci.c:3411:20: warning: stack frame size (2816) exceeds limit (2048) in 'sdhci_irq' [-Wframe-larger-than]
    3411 | static irqreturn_t sdhci_irq(int irq, void *dev_id)
         |                    ^
   1 warning generated.
   /tmp/sdhci-da405a.s: Assembler messages:
   /tmp/sdhci-da405a.s:22550: Error: unrecognized opcode `csrrc a0,0x100,2', extension `zicsr' required
   /tmp/sdhci-da405a.s:22731: Error: unrecognized opcode `csrrc s2,0x100,2', extension `zicsr' required
   /tmp/sdhci-da405a.s:22883: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/sdhci-da405a.s:22894: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/sdhci-da405a.s:45515: Error: unrecognized opcode `csrrc s3,0x100,2', extension `zicsr' required
   /tmp/sdhci-da405a.s:45672: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   clang: error: assembler command failed with exit code 1 (use -v to see invocation)
--
>> net/mac80211/rx.c:3819:13: warning: stack frame size (7392) exceeds limit (2048) in 'ieee80211_rx_handlers' [-Wframe-larger-than]
    3819 | static void ieee80211_rx_handlers(struct ieee80211_rx_data *rx,
         |             ^
   1 warning generated.
--
>> net/mac80211/tx.c:3586:17: warning: stack frame size (2544) exceeds limit (2048) in 'ieee80211_tx_dequeue' [-Wframe-larger-than]
    3586 | struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
         |                 ^
   1 warning generated.
--
>> net/mac80211/util.c:995:1: warning: stack frame size (2256) exceeds limit (2048) in '_ieee802_11_parse_elems_crc' [-Wframe-larger-than]
     995 | _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
         | ^
   1 warning generated.
--
>> fs/f2fs/debug.c:326:12: warning: stack frame size (5328) exceeds limit (2048) in 'stat_show' [-Wframe-larger-than]
     326 | static int stat_show(struct seq_file *s, void *v)
         |            ^
   1 warning generated.
--
>> fs/nilfs2/segment.c:2008:12: warning: stack frame size (4576) exceeds limit (2048) in 'nilfs_segctor_do_construct' [-Wframe-larger-than]
    2008 | static int nilfs_segctor_do_construct(struct nilfs_sc_info *sci, int mode)
         |            ^
>> fs/nilfs2/segment.c:1479:12: warning: stack frame size (2192) exceeds limit (2048) in 'nilfs_segctor_collect' [-Wframe-larger-than]
    1479 | static int nilfs_segctor_collect(struct nilfs_sc_info *sci,
         |            ^
   2 warnings generated.
   /tmp/segment-a6eb20.s: Assembler messages:
   /tmp/segment-a6eb20.s:3732: Error: unrecognized opcode `csrrc s5,0x100,2', extension `zicsr' required
   /tmp/segment-a6eb20.s:3766: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/segment-a6eb20.s:4416: Error: unrecognized opcode `csrrc s3,0x100,2', extension `zicsr' required
   /tmp/segment-a6eb20.s:4450: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   /tmp/segment-a6eb20.s:4476: Error: unrecognized opcode `csrrc s5,0x100,2', extension `zicsr' required
   /tmp/segment-a6eb20.s:4510: Error: unrecognized opcode `csrs 0x100,a0', extension `zicsr' required
   clang: error: assembler command failed with exit code 1 (use -v to see invocation)


vim +/pmsr_parse_peer +186 net/wireless/pmsr.c

9bb7e0f24e7e7d Johannes Berg 2018-09-10  185  
9bb7e0f24e7e7d Johannes Berg 2018-09-10 @186  static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
9bb7e0f24e7e7d Johannes Berg 2018-09-10  187  			   struct nlattr *peer,
9bb7e0f24e7e7d Johannes Berg 2018-09-10  188  			   struct cfg80211_pmsr_request_peer *out,
9bb7e0f24e7e7d Johannes Berg 2018-09-10  189  			   struct genl_info *info)
9bb7e0f24e7e7d Johannes Berg 2018-09-10  190  {
9bb7e0f24e7e7d Johannes Berg 2018-09-10  191  	struct nlattr *tb[NL80211_PMSR_PEER_ATTR_MAX + 1];
9bb7e0f24e7e7d Johannes Berg 2018-09-10  192  	struct nlattr *req[NL80211_PMSR_REQ_ATTR_MAX + 1];
9bb7e0f24e7e7d Johannes Berg 2018-09-10  193  	struct nlattr *treq;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  194  	int err, rem;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  195  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  196  	/* no validation needed - was already done via nested policy */
8cb081746c031f Johannes Berg 2019-04-26  197  	nla_parse_nested_deprecated(tb, NL80211_PMSR_PEER_ATTR_MAX, peer,
8cb081746c031f Johannes Berg 2019-04-26  198  				    NULL, NULL);
9bb7e0f24e7e7d Johannes Berg 2018-09-10  199  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  200  	if (!tb[NL80211_PMSR_PEER_ATTR_ADDR] ||
9bb7e0f24e7e7d Johannes Berg 2018-09-10  201  	    !tb[NL80211_PMSR_PEER_ATTR_CHAN] ||
9bb7e0f24e7e7d Johannes Berg 2018-09-10  202  	    !tb[NL80211_PMSR_PEER_ATTR_REQ]) {
9bb7e0f24e7e7d Johannes Berg 2018-09-10  203  		NL_SET_ERR_MSG_ATTR(info->extack, peer,
9bb7e0f24e7e7d Johannes Berg 2018-09-10  204  				    "insufficient peer data");
9bb7e0f24e7e7d Johannes Berg 2018-09-10  205  		return -EINVAL;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  206  	}
9bb7e0f24e7e7d Johannes Berg 2018-09-10  207  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  208  	memcpy(out->addr, nla_data(tb[NL80211_PMSR_PEER_ATTR_ADDR]), ETH_ALEN);
9bb7e0f24e7e7d Johannes Berg 2018-09-10  209  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  210  	/* reuse info->attrs */
9bb7e0f24e7e7d Johannes Berg 2018-09-10  211  	memset(info->attrs, 0, sizeof(*info->attrs) * (NL80211_ATTR_MAX + 1));
8cb081746c031f Johannes Berg 2019-04-26  212  	err = nla_parse_nested_deprecated(info->attrs, NL80211_ATTR_MAX,
9bb7e0f24e7e7d Johannes Berg 2018-09-10  213  					  tb[NL80211_PMSR_PEER_ATTR_CHAN],
d15da2a2e81367 Johannes Berg 2020-04-30  214  					  NULL, info->extack);
9bb7e0f24e7e7d Johannes Berg 2018-09-10  215  	if (err)
9bb7e0f24e7e7d Johannes Berg 2018-09-10  216  		return err;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  217  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  218  	err = nl80211_parse_chandef(rdev, info, &out->chandef);
9bb7e0f24e7e7d Johannes Berg 2018-09-10  219  	if (err)
9bb7e0f24e7e7d Johannes Berg 2018-09-10  220  		return err;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  221  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  222  	/* no validation needed - was already done via nested policy */
8cb081746c031f Johannes Berg 2019-04-26  223  	nla_parse_nested_deprecated(req, NL80211_PMSR_REQ_ATTR_MAX,
8cb081746c031f Johannes Berg 2019-04-26  224  				    tb[NL80211_PMSR_PEER_ATTR_REQ], NULL,
8cb081746c031f Johannes Berg 2019-04-26  225  				    NULL);
9bb7e0f24e7e7d Johannes Berg 2018-09-10  226  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  227  	if (!req[NL80211_PMSR_REQ_ATTR_DATA]) {
9bb7e0f24e7e7d Johannes Berg 2018-09-10  228  		NL_SET_ERR_MSG_ATTR(info->extack,
9bb7e0f24e7e7d Johannes Berg 2018-09-10  229  				    tb[NL80211_PMSR_PEER_ATTR_REQ],
9bb7e0f24e7e7d Johannes Berg 2018-09-10  230  				    "missing request type/data");
9bb7e0f24e7e7d Johannes Berg 2018-09-10  231  		return -EINVAL;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  232  	}
9bb7e0f24e7e7d Johannes Berg 2018-09-10  233  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  234  	if (req[NL80211_PMSR_REQ_ATTR_GET_AP_TSF])
9bb7e0f24e7e7d Johannes Berg 2018-09-10  235  		out->report_ap_tsf = true;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  236  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  237  	if (out->report_ap_tsf && !rdev->wiphy.pmsr_capa->report_ap_tsf) {
9bb7e0f24e7e7d Johannes Berg 2018-09-10  238  		NL_SET_ERR_MSG_ATTR(info->extack,
9bb7e0f24e7e7d Johannes Berg 2018-09-10  239  				    req[NL80211_PMSR_REQ_ATTR_GET_AP_TSF],
9bb7e0f24e7e7d Johannes Berg 2018-09-10  240  				    "reporting AP TSF is not supported");
9bb7e0f24e7e7d Johannes Berg 2018-09-10  241  		return -EINVAL;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  242  	}
9bb7e0f24e7e7d Johannes Berg 2018-09-10  243  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  244  	nla_for_each_nested(treq, req[NL80211_PMSR_REQ_ATTR_DATA], rem) {
9bb7e0f24e7e7d Johannes Berg 2018-09-10  245  		switch (nla_type(treq)) {
9bb7e0f24e7e7d Johannes Berg 2018-09-10  246  		case NL80211_PMSR_TYPE_FTM:
9bb7e0f24e7e7d Johannes Berg 2018-09-10  247  			err = pmsr_parse_ftm(rdev, treq, out, info);
9bb7e0f24e7e7d Johannes Berg 2018-09-10  248  			break;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  249  		default:
9bb7e0f24e7e7d Johannes Berg 2018-09-10  250  			NL_SET_ERR_MSG_ATTR(info->extack, treq,
9bb7e0f24e7e7d Johannes Berg 2018-09-10  251  					    "unsupported measurement type");
9bb7e0f24e7e7d Johannes Berg 2018-09-10  252  			err = -EINVAL;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  253  		}
9bb7e0f24e7e7d Johannes Berg 2018-09-10  254  	}
9bb7e0f24e7e7d Johannes Berg 2018-09-10  255  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  256  	if (err)
9bb7e0f24e7e7d Johannes Berg 2018-09-10  257  		return err;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  258  
9bb7e0f24e7e7d Johannes Berg 2018-09-10  259  	return 0;
9bb7e0f24e7e7d Johannes Berg 2018-09-10  260  }
9bb7e0f24e7e7d Johannes Berg 2018-09-10  261  

:::::: The code at line 186 was first introduced by commit
:::::: 9bb7e0f24e7e7d00daa1219b14539e2e602649b2 cfg80211: add peer measurement with FTM initiator API

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Johannes Berg <johannes.berg@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
