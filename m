Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62481799B87
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 23:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345046AbjIIV6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 17:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238203AbjIIV57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 17:57:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47AAD9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 14:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694296673; x=1725832673;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WUGyiajOn+V+p9vzOIY9LOtPAU7g4HKStlh3N1ayrNc=;
  b=fEIxzviuKyzlcvlHG6+uXLt7XkVz+7T4v8rAF2iD975QjqjKzjhlGZaq
   ZCX4RVwkv5eNI6wt+53iIJd3+GI5KLLpRnb/OH+uGF/mtZNs7Sa5frtju
   4pcDsP2oHUFkpxoAE3UEyEHIS99pwqdm7jSTCdDbcwhVQNQ26ttTejCuw
   9lNByBk/6hg1GqXORvKXUCUYBUci1J/k9KmKFFuWUfLc8Dw+z1gBi5t2p
   TnTj2/4gq31+syjNhrc/udfKV+kVrpBi1bqitBqb7HO0htnxY9+aZDr1m
   k8SFVsoObrC1v83GMKRBdzYZszd3WVfvNGpWsSSRnV0SSqLzB9aehu21X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="375219013"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="375219013"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2023 14:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="777962390"
X-IronPort-AV: E=Sophos;i="6.02,240,1688454000"; 
   d="scan'208";a="777962390"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Sep 2023 14:57:51 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qf5xd-0003yn-0I;
        Sat, 09 Sep 2023 21:57:49 +0000
Date:   Sun, 10 Sep 2023 05:57:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: net/netfilter/nfnetlink_log.c:800:18: warning: variable 'ctinfo' is
 uninitialized when used here
Message-ID: <202309100514.ndBFebXN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2a5a4326e58339a26cd1510259e7310b8c0980ff
commit: 83ace77f51175023c3757e2d08a92565f9b1c7f3 netfilter: ctnetlink: remove get_ct indirection
date:   2 years, 7 months ago
config: i386-randconfig-006-20230910 (https://download.01.org/0day-ci/archive/20230910/202309100514.ndBFebXN-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230910/202309100514.ndBFebXN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309100514.ndBFebXN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/netfilter/nfnetlink_log.c:800:18: warning: variable 'ctinfo' is uninitialized when used here [-Wuninitialized]
                                   nfnl_ct, ct, ctinfo);
                                                ^~~~~~
   net/netfilter/nfnetlink_log.c:695:2: note: variable 'ctinfo' is declared here
           enum ip_conntrack_info ctinfo;
           ^
   1 warning generated.
--
>> net/netfilter/nfnetlink_queue.c:601:36: warning: variable 'ctinfo' is uninitialized when used here [-Wuninitialized]
           if (ct && nfnl_ct->build(skb, ct, ctinfo, NFQA_CT, NFQA_CT_INFO) < 0)
                                             ^~~~~~
   net/netfilter/nfnetlink_queue.c:391:2: note: variable 'ctinfo' is declared here
           enum ip_conntrack_info ctinfo;
           ^
   1 warning generated.


vim +/ctinfo +800 net/netfilter/nfnetlink_log.c

0597f2680d666a Harald Welte          2005-08-09  674  
0597f2680d666a Harald Welte          2005-08-09  675  /* log handler for internal netfilter logging api */
ce20cdf498bdfa Taehee Yoo            2018-04-09  676  static void
8cdb46da06ea94 Hans Schillstrom      2013-05-15  677  nfulnl_log_packet(struct net *net,
8cdb46da06ea94 Hans Schillstrom      2013-05-15  678  		  u_int8_t pf,
0597f2680d666a Harald Welte          2005-08-09  679  		  unsigned int hooknum,
0597f2680d666a Harald Welte          2005-08-09  680  		  const struct sk_buff *skb,
0597f2680d666a Harald Welte          2005-08-09  681  		  const struct net_device *in,
0597f2680d666a Harald Welte          2005-08-09  682  		  const struct net_device *out,
0597f2680d666a Harald Welte          2005-08-09  683  		  const struct nf_loginfo *li_user,
0597f2680d666a Harald Welte          2005-08-09  684  		  const char *prefix)
0597f2680d666a Harald Welte          2005-08-09  685  {
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  686  	size_t size;
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  687  	unsigned int data_len;
0597f2680d666a Harald Welte          2005-08-09  688  	struct nfulnl_instance *inst;
0597f2680d666a Harald Welte          2005-08-09  689  	const struct nf_loginfo *li;
0597f2680d666a Harald Welte          2005-08-09  690  	unsigned int qthreshold;
ce20cdf498bdfa Taehee Yoo            2018-04-09  691  	unsigned int plen = 0;
9368a53c471b42 Gao feng              2013-03-24  692  	struct nfnl_log_net *log = nfnl_log_pernet(net);
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  693  	const struct nfnl_ct_hook *nfnl_ct = NULL;
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  694  	struct nf_conn *ct = NULL;
3f649ab728cda8 Kees Cook             2020-06-03  695  	enum ip_conntrack_info ctinfo;
0597f2680d666a Harald Welte          2005-08-09  696  
0597f2680d666a Harald Welte          2005-08-09  697  	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
0597f2680d666a Harald Welte          2005-08-09  698  		li = li_user;
0597f2680d666a Harald Welte          2005-08-09  699  	else
0597f2680d666a Harald Welte          2005-08-09  700  		li = &default_loginfo;
0597f2680d666a Harald Welte          2005-08-09  701  
9368a53c471b42 Gao feng              2013-03-24  702  	inst = instance_lookup_get(log, li->u.ulog.group);
0597f2680d666a Harald Welte          2005-08-09  703  	if (!inst)
0597f2680d666a Harald Welte          2005-08-09  704  		return;
0597f2680d666a Harald Welte          2005-08-09  705  
d7a5c32442ed3d Patrick McHardy       2006-11-29  706  	if (prefix)
881dbfe8accc94 Patrick McHardy       2007-03-06  707  		plen = strlen(prefix) + 1;
d7a5c32442ed3d Patrick McHardy       2006-11-29  708  
0597f2680d666a Harald Welte          2005-08-09  709  	/* FIXME: do we want to make the size calculation conditional based on
0597f2680d666a Harald Welte          2005-08-09  710  	 * what is actually present?  way more branches and checks, but more
0597f2680d666a Harald Welte          2005-08-09  711  	 * memory efficient... */
573ce260b385a4 Hong zhi guo          2013-03-27  712  	size = nlmsg_total_size(sizeof(struct nfgenmsg))
df6fb868d61186 Patrick McHardy       2007-09-28  713  		+ nla_total_size(sizeof(struct nfulnl_msg_packet_hdr))
df6fb868d61186 Patrick McHardy       2007-09-28  714  		+ nla_total_size(sizeof(u_int32_t))	/* ifindex */
df6fb868d61186 Patrick McHardy       2007-09-28  715  		+ nla_total_size(sizeof(u_int32_t))	/* ifindex */
1109a90c01177e Pablo Neira Ayuso     2014-10-01  716  #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
df6fb868d61186 Patrick McHardy       2007-09-28  717  		+ nla_total_size(sizeof(u_int32_t))	/* ifindex */
df6fb868d61186 Patrick McHardy       2007-09-28  718  		+ nla_total_size(sizeof(u_int32_t))	/* ifindex */
fbcd923c3e0c8e Harald Welte          2005-08-09  719  #endif
df6fb868d61186 Patrick McHardy       2007-09-28  720  		+ nla_total_size(sizeof(u_int32_t))	/* mark */
df6fb868d61186 Patrick McHardy       2007-09-28  721  		+ nla_total_size(sizeof(u_int32_t))	/* uid */
76aa1ce139f649 Patrick McHardy       2007-12-17  722  		+ nla_total_size(sizeof(u_int32_t))	/* gid */
df6fb868d61186 Patrick McHardy       2007-09-28  723  		+ nla_total_size(plen)			/* prefix */
df6fb868d61186 Patrick McHardy       2007-09-28  724  		+ nla_total_size(sizeof(struct nfulnl_msg_packet_hw))
9dfa1dfe4d5e5e Florian Westphal      2014-10-23  725  		+ nla_total_size(sizeof(struct nfulnl_msg_packet_timestamp))
9dfa1dfe4d5e5e Florian Westphal      2014-10-23  726  		+ nla_total_size(sizeof(struct nfgenmsg));	/* NLMSG_DONE */
0597f2680d666a Harald Welte          2005-08-09  727  
eeff9beec3d256 Pablo Neira Ayuso     2009-05-27  728  	if (in && skb_mac_header_was_set(skb)) {
eeff9beec3d256 Pablo Neira Ayuso     2009-05-27  729  		size += nla_total_size(skb->dev->hard_header_len)
eeff9beec3d256 Pablo Neira Ayuso     2009-05-27  730  			+ nla_total_size(sizeof(u_int16_t))	/* hwtype */
eeff9beec3d256 Pablo Neira Ayuso     2009-05-27  731  			+ nla_total_size(sizeof(u_int16_t));	/* hwlen */
eeff9beec3d256 Pablo Neira Ayuso     2009-05-27  732  	}
eeff9beec3d256 Pablo Neira Ayuso     2009-05-27  733  
0597f2680d666a Harald Welte          2005-08-09  734  	spin_lock_bh(&inst->lock);
0597f2680d666a Harald Welte          2005-08-09  735  
0af5f6c1eba4a1 Harald Welte          2006-03-20  736  	if (inst->flags & NFULNL_CFG_F_SEQ)
df6fb868d61186 Patrick McHardy       2007-09-28  737  		size += nla_total_size(sizeof(u_int32_t));
0af5f6c1eba4a1 Harald Welte          2006-03-20  738  	if (inst->flags & NFULNL_CFG_F_SEQ_GLOBAL)
df6fb868d61186 Patrick McHardy       2007-09-28  739  		size += nla_total_size(sizeof(u_int32_t));
83ace77f511750 Florian Westphal      2021-01-20  740  #if IS_ENABLED(CONFIG_NF_CONNTRACK)
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  741  	if (inst->flags & NFULNL_CFG_F_CONNTRACK) {
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  742  		nfnl_ct = rcu_dereference(nfnl_ct_hook);
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  743  		if (nfnl_ct != NULL) {
83ace77f511750 Florian Westphal      2021-01-20  744  			ct = nf_ct_get(skb, &ctinfo);
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  745  			if (ct != NULL)
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  746  				size += nfnl_ct->build_size(ct);
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  747  		}
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  748  	}
83ace77f511750 Florian Westphal      2021-01-20  749  #endif
65af4a10743b76 Michael Braun         2019-08-20  750  	if (pf == NFPROTO_NETDEV || pf == NFPROTO_BRIDGE)
65af4a10743b76 Michael Braun         2019-08-20  751  		size += nfulnl_get_bridge_size(skb);
0af5f6c1eba4a1 Harald Welte          2006-03-20  752  
0597f2680d666a Harald Welte          2005-08-09  753  	qthreshold = inst->qthreshold;
0597f2680d666a Harald Welte          2005-08-09  754  	/* per-rule qthreshold overrides per-instance */
5ca431f9ae8db8 Eric Leblond          2009-02-18  755  	if (li->u.ulog.qthreshold)
0597f2680d666a Harald Welte          2005-08-09  756  		if (qthreshold > li->u.ulog.qthreshold)
0597f2680d666a Harald Welte          2005-08-09  757  			qthreshold = li->u.ulog.qthreshold;
0597f2680d666a Harald Welte          2005-08-09  758  
5ca431f9ae8db8 Eric Leblond          2009-02-18  759  
0597f2680d666a Harald Welte          2005-08-09  760  	switch (inst->copy_mode) {
0597f2680d666a Harald Welte          2005-08-09  761  	case NFULNL_COPY_META:
0597f2680d666a Harald Welte          2005-08-09  762  	case NFULNL_COPY_NONE:
0597f2680d666a Harald Welte          2005-08-09  763  		data_len = 0;
0597f2680d666a Harald Welte          2005-08-09  764  		break;
0597f2680d666a Harald Welte          2005-08-09  765  
0597f2680d666a Harald Welte          2005-08-09  766  	case NFULNL_COPY_PACKET:
0597f2680d666a Harald Welte          2005-08-09  767  		data_len = inst->copy_range;
7643507fe8b5bd Vishwanath Pai        2016-06-21  768  		if ((li->u.ulog.flags & NF_LOG_F_COPY_LEN) &&
7643507fe8b5bd Vishwanath Pai        2016-06-21  769  		    (li->u.ulog.copy_len < data_len))
7643507fe8b5bd Vishwanath Pai        2016-06-21  770  			data_len = li->u.ulog.copy_len;
7643507fe8b5bd Vishwanath Pai        2016-06-21  771  
7643507fe8b5bd Vishwanath Pai        2016-06-21  772  		if (data_len > skb->len)
7643507fe8b5bd Vishwanath Pai        2016-06-21  773  			data_len = skb->len;
0597f2680d666a Harald Welte          2005-08-09  774  
df6fb868d61186 Patrick McHardy       2007-09-28  775  		size += nla_total_size(data_len);
0597f2680d666a Harald Welte          2005-08-09  776  		break;
0597f2680d666a Harald Welte          2005-08-09  777  
f5c5440d40a24c Eric Dumazet          2010-06-14  778  	case NFULNL_COPY_DISABLED:
0597f2680d666a Harald Welte          2005-08-09  779  	default:
55b5a91e172328 Michal Miroslaw       2007-03-23  780  		goto unlock_and_release;
0597f2680d666a Harald Welte          2005-08-09  781  	}
0597f2680d666a Harald Welte          2005-08-09  782  
9dfa1dfe4d5e5e Florian Westphal      2014-10-23  783  	if (inst->skb && size > skb_tailroom(inst->skb)) {
0597f2680d666a Harald Welte          2005-08-09  784  		/* either the queue len is too high or we don't have
0597f2680d666a Harald Welte          2005-08-09  785  		 * enough room in the skb left. flush to userspace. */
e35670614d1058 Michal Miroslaw       2007-09-28  786  		__nfulnl_flush(inst);
55b5a91e172328 Michal Miroslaw       2007-03-23  787  	}
0597f2680d666a Harald Welte          2005-08-09  788  
55b5a91e172328 Michal Miroslaw       2007-03-23  789  	if (!inst->skb) {
afff14f6089ac5 Gao feng              2013-09-23  790  		inst->skb = nfulnl_alloc_skb(net, inst->peer_portid,
afff14f6089ac5 Gao feng              2013-09-23  791  					     inst->nlbufsiz, size);
55b5a91e172328 Michal Miroslaw       2007-03-23  792  		if (!inst->skb)
0597f2680d666a Harald Welte          2005-08-09  793  			goto alloc_failure;
0597f2680d666a Harald Welte          2005-08-09  794  	}
0597f2680d666a Harald Welte          2005-08-09  795  
0597f2680d666a Harald Welte          2005-08-09  796  	inst->qlen++;
0597f2680d666a Harald Welte          2005-08-09  797  
9368a53c471b42 Gao feng              2013-03-24  798  	__build_packet_message(log, inst, skb, data_len, pf,
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05  799  				hooknum, in, out, prefix, plen,
a29a9a585b2840 Ken-ichirou MATSUZAWA 2015-10-05 @800  				nfnl_ct, ct, ctinfo);
0597f2680d666a Harald Welte          2005-08-09  801  
d63b043d955c26 Michal Miroslaw       2007-09-28  802  	if (inst->qlen >= qthreshold)
d63b043d955c26 Michal Miroslaw       2007-09-28  803  		__nfulnl_flush(inst);
0597f2680d666a Harald Welte          2005-08-09  804  	/* timer_pending always called within inst->lock, so there
0597f2680d666a Harald Welte          2005-08-09  805  	 * is no chance of a race here */
d63b043d955c26 Michal Miroslaw       2007-09-28  806  	else if (!timer_pending(&inst->timer)) {
0597f2680d666a Harald Welte          2005-08-09  807  		instance_get(inst);
0597f2680d666a Harald Welte          2005-08-09  808  		inst->timer.expires = jiffies + (inst->flushtimeout*HZ/100);
0597f2680d666a Harald Welte          2005-08-09  809  		add_timer(&inst->timer);
0597f2680d666a Harald Welte          2005-08-09  810  	}
0597f2680d666a Harald Welte          2005-08-09  811  
ed32abeaf3a3da Michal Miroslaw       2007-03-04  812  unlock_and_release:
ed32abeaf3a3da Michal Miroslaw       2007-03-04  813  	spin_unlock_bh(&inst->lock);
ed32abeaf3a3da Michal Miroslaw       2007-03-04  814  	instance_put(inst);
0597f2680d666a Harald Welte          2005-08-09  815  	return;
0597f2680d666a Harald Welte          2005-08-09  816  
0597f2680d666a Harald Welte          2005-08-09  817  alloc_failure:
0597f2680d666a Harald Welte          2005-08-09  818  	/* FIXME: statistics */
ed32abeaf3a3da Michal Miroslaw       2007-03-04  819  	goto unlock_and_release;
0597f2680d666a Harald Welte          2005-08-09  820  }
0597f2680d666a Harald Welte          2005-08-09  821  

:::::: The code at line 800 was first introduced by commit
:::::: a29a9a585b2840a205f085a34dfd65c75e86f7c3 netfilter: nfnetlink_log: allow to attach conntrack

:::::: TO: Ken-ichirou MATSUZAWA <chamaken@gmail.com>
:::::: CC: Pablo Neira Ayuso <pablo@netfilter.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
