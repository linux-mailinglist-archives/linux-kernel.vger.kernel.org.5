Return-Path: <linux-kernel+bounces-13809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5900A821289
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 01:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A16A280E97
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 00:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6206ED9;
	Mon,  1 Jan 2024 00:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eu/oa86J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8687F9;
	Mon,  1 Jan 2024 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704070472; x=1735606472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bq5FZFx3Ptya3CmiaIHeqnx7z0srP/JD06vcWqWmOB0=;
  b=Eu/oa86JrGTgl3RxOPFXfovB025Ii62YJWnKuC2o6HnwXl6quJVUWFdB
   4UiPG/WV40m+p3ILRzn5TLu4BPTYCcB3L/4jpFaD3mgjsZUofAXbLy4bK
   nntvEdY5jFKTqR5x4r3mzOvYpAxfrW3nn02GY/L4WAQHutqKDWNzYUMZV
   Gy5qCOXGKegnsK2TFqugnlmMH1QRlwsrlQjSEk/Cnn0IqsVqOzS8iZXVo
   fto3J45jWWWP4yXwUU4dakCuu9K9nwOcF6S2jbO2/mZyvbHJHceB6wi9j
   lgB1GkoBfGqQEX7nGBOClmJ4nv2KlzikEqe+P+h8bCHPEzOrDjJKAq8gA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="463176669"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="463176669"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2023 16:54:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="772469584"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="772469584"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 31 Dec 2023 16:54:27 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rK6ZU-000Jsa-24;
	Mon, 01 Jan 2024 00:54:24 +0000
Date: Mon, 1 Jan 2024 08:54:14 +0800
From: kernel test robot <lkp@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] netlink: Move =?utf-8?Q?an?=
 =?utf-8?Q?_assignment_for_the_variable_=E2=80=9Csk?= =?utf-8?B?4oCd?= in
 __netlink_kernel_create()
Message-ID: <202401010855.4iU6im1B-lkp@intel.com>
References: <223a61e9-f826-4f37-b514-ca6ed53b1269@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <223a61e9-f826-4f37-b514-ca6ed53b1269@web.de>

Hi Markus,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master horms-ipvs/master v6.7-rc8 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Markus-Elfring/netlink-Improve-exception-handling-in-__netlink_kernel_create/20240101-015025
base:   net/main
patch link:    https://lore.kernel.org/r/223a61e9-f826-4f37-b514-ca6ed53b1269%40web.de
patch subject: [PATCH 2/4] netlink: Move an assignment for the variable “sk” in __netlink_kernel_create()
config: arm-randconfig-001-20240101 (https://download.01.org/0day-ci/archive/20240101/202401010855.4iU6im1B-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 8a4266a626914765c0c69839e8a51be383013c1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240101/202401010855.4iU6im1B-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401010855.4iU6im1B-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/netlink/af_netlink.c:2044:6: warning: variable 'sk' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
    2044 |         if (!listeners)
         |             ^~~~~~~~~~
   net/netlink/af_netlink.c:2081:25: note: uninitialized use occurs here
    2081 |         netlink_kernel_release(sk);
         |                                ^~
   net/netlink/af_netlink.c:2044:2: note: remove the 'if' if its condition is always false
    2044 |         if (!listeners)
         |         ^~~~~~~~~~~~~~~
    2045 |                 goto out_netlink_release_sock;
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/netlink/af_netlink.c:2021:17: note: initialize the variable 'sk' to silence this warning
    2021 |         struct sock *sk;
         |                        ^
         |                         = NULL
   1 warning generated.


vim +2044 net/netlink/af_netlink.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  2009  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2010  /*
^1da177e4c3f41 Linus Torvalds    2005-04-16  2011   *	We export these functions to other modules. They provide a
^1da177e4c3f41 Linus Torvalds    2005-04-16  2012   *	complete set of kernel non-blocking support for message
^1da177e4c3f41 Linus Torvalds    2005-04-16  2013   *	queueing.
^1da177e4c3f41 Linus Torvalds    2005-04-16  2014   */
^1da177e4c3f41 Linus Torvalds    2005-04-16  2015  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2016  struct sock *
9f00d9776bc5be Pablo Neira Ayuso 2012-09-08  2017  __netlink_kernel_create(struct net *net, int unit, struct module *module,
a31f2d17b331db Pablo Neira Ayuso 2012-06-29  2018  			struct netlink_kernel_cfg *cfg)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2019  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  2020  	struct socket *sock;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2021  	struct sock *sk;
77247bbb309424 Patrick McHardy   2005-08-14  2022  	struct netlink_sock *nlk;
5c398dc8f5a58b Eric Dumazet      2010-10-24  2023  	struct listeners *listeners = NULL;
a31f2d17b331db Pablo Neira Ayuso 2012-06-29  2024  	struct mutex *cb_mutex = cfg ? cfg->cb_mutex : NULL;
a31f2d17b331db Pablo Neira Ayuso 2012-06-29  2025  	unsigned int groups;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2026  
fab2caf62ed03d Akinobu Mita      2006-08-29  2027  	BUG_ON(!nl_table);
^1da177e4c3f41 Linus Torvalds    2005-04-16  2028  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2029  	if (unit < 0 || unit >= MAX_LINKS)
^1da177e4c3f41 Linus Torvalds    2005-04-16  2030  		return NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2031  
^1da177e4c3f41 Linus Torvalds    2005-04-16  2032  	if (sock_create_lite(PF_NETLINK, SOCK_DGRAM, unit, &sock))
^1da177e4c3f41 Linus Torvalds    2005-04-16  2033  		return NULL;
13d3078e22f565 Eric W. Biederman 2015-05-08  2034  
13d3078e22f565 Eric W. Biederman 2015-05-08  2035  	if (__netlink_create(net, sock, cb_mutex, unit, 1) < 0)
23fe18669e7fda Pavel Emelyanov   2008-01-30  2036  		goto out_sock_release_nosk;
23fe18669e7fda Pavel Emelyanov   2008-01-30  2037  
a31f2d17b331db Pablo Neira Ayuso 2012-06-29  2038  	if (!cfg || cfg->groups < 32)
4277a083ecd2c8 Patrick McHardy   2006-03-20  2039  		groups = 32;
a31f2d17b331db Pablo Neira Ayuso 2012-06-29  2040  	else
a31f2d17b331db Pablo Neira Ayuso 2012-06-29  2041  		groups = cfg->groups;
4277a083ecd2c8 Patrick McHardy   2006-03-20  2042  
5c398dc8f5a58b Eric Dumazet      2010-10-24  2043  	listeners = kzalloc(sizeof(*listeners) + NLGRPSZ(groups), GFP_KERNEL);
4277a083ecd2c8 Patrick McHardy   2006-03-20 @2044  	if (!listeners)
90ae404765d263 Markus Elfring    2023-12-31  2045  		goto out_netlink_release_sock;
4277a083ecd2c8 Patrick McHardy   2006-03-20  2046  
e547df909ec09d Markus Elfring    2023-12-31  2047  	sk = sock->sk;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2048  	sk->sk_data_ready = netlink_data_ready;
a31f2d17b331db Pablo Neira Ayuso 2012-06-29  2049  	if (cfg && cfg->input)
a31f2d17b331db Pablo Neira Ayuso 2012-06-29  2050  		nlk_sk(sk)->netlink_rcv = cfg->input;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2051  
8ea65f4a2dfaaf Herbert Xu        2015-01-26  2052  	if (netlink_insert(sk, 0))
77247bbb309424 Patrick McHardy   2005-08-14  2053  		goto out_sock_release;
4fdb3bb723db46 Harald Welte      2005-08-09  2054  
77247bbb309424 Patrick McHardy   2005-08-14  2055  	nlk = nlk_sk(sk);
8fe08d70a2b61b Eric Dumazet      2023-08-11  2056  	set_bit(NETLINK_F_KERNEL_SOCKET, &nlk->flags);
4fdb3bb723db46 Harald Welte      2005-08-09  2057  
4fdb3bb723db46 Harald Welte      2005-08-09  2058  	netlink_table_grab();
b4b510290b056b Eric W. Biederman 2007-09-12  2059  	if (!nl_table[unit].registered) {
4277a083ecd2c8 Patrick McHardy   2006-03-20  2060  		nl_table[unit].groups = groups;
5c398dc8f5a58b Eric Dumazet      2010-10-24  2061  		rcu_assign_pointer(nl_table[unit].listeners, listeners);
af65bdfce98d79 Patrick McHardy   2007-04-20  2062  		nl_table[unit].cb_mutex = cb_mutex;
77247bbb309424 Patrick McHardy   2005-08-14  2063  		nl_table[unit].module = module;
9785e10aedfa0f Pablo Neira Ayuso 2012-09-08  2064  		if (cfg) {
9785e10aedfa0f Pablo Neira Ayuso 2012-09-08  2065  			nl_table[unit].bind = cfg->bind;
6251edd932ce3f Hiroaki SHIMODA   2014-11-13  2066  			nl_table[unit].unbind = cfg->unbind;
a4c9a56e6a2cde Anjali Kulkarni   2023-07-19  2067  			nl_table[unit].release = cfg->release;
9785e10aedfa0f Pablo Neira Ayuso 2012-09-08  2068  			nl_table[unit].flags = cfg->flags;
9785e10aedfa0f Pablo Neira Ayuso 2012-09-08  2069  		}
ab33a1711cf60b Patrick McHardy   2005-08-14  2070  		nl_table[unit].registered = 1;
f937f1f46b6d2f Jesper Juhl       2007-10-15  2071  	} else {
f937f1f46b6d2f Jesper Juhl       2007-10-15  2072  		kfree(listeners);
869e58f87094b1 Denis V. Lunev    2008-01-18  2073  		nl_table[unit].registered++;
b4b510290b056b Eric W. Biederman 2007-09-12  2074  	}
4fdb3bb723db46 Harald Welte      2005-08-09  2075  	netlink_table_ungrab();
77247bbb309424 Patrick McHardy   2005-08-14  2076  	return sk;
77247bbb309424 Patrick McHardy   2005-08-14  2077  
4fdb3bb723db46 Harald Welte      2005-08-09  2078  out_sock_release:
4277a083ecd2c8 Patrick McHardy   2006-03-20  2079  	kfree(listeners);
90ae404765d263 Markus Elfring    2023-12-31  2080  out_netlink_release_sock:
9dfbec1fb2bedf Denis V. Lunev    2008-02-29  2081  	netlink_kernel_release(sk);
23fe18669e7fda Pavel Emelyanov   2008-01-30  2082  	return NULL;
23fe18669e7fda Pavel Emelyanov   2008-01-30  2083  
23fe18669e7fda Pavel Emelyanov   2008-01-30  2084  out_sock_release_nosk:
4fdb3bb723db46 Harald Welte      2005-08-09  2085  	sock_release(sock);
77247bbb309424 Patrick McHardy   2005-08-14  2086  	return NULL;
^1da177e4c3f41 Linus Torvalds    2005-04-16  2087  }
9f00d9776bc5be Pablo Neira Ayuso 2012-09-08  2088  EXPORT_SYMBOL(__netlink_kernel_create);
b7c6ba6eb1234e Denis V. Lunev    2008-01-28  2089  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

