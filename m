Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A617E174F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjKEWNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEWNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:13:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4015D9
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 14:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699222407; x=1730758407;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l9ufxr/nwC4olDDer0bAqvrM0xGgfuDItmsHDO/jrh4=;
  b=S5/YKmv5E6htX71vE8AX5w3XXm1pIMBiRJlwN9rUn1gg40nsf7YLbMga
   gz1rWmIbVU1BfunXYl7QER9ZCeqo7OKUaNCRLmukeQMP/ES5OdlM/m2Gf
   Ut9B9HdRHwqLqUi/7q1ItnU6tTUG0h0eHE8aPHnFvqyxHpVp3DzZIAzBX
   P/jYdXIaCxb/TpZAlguKMndUS/Idm/Eq5di2J5eNszTJScNWctwj1e/Wm
   SxDmuxypu1OI8Ld6kb5s4GXSiujv2qj+m2WySAkS+hDoSzw2yXRFvXjWu
   q7nzhcs0iVxfUmySBpM8G/BzA/qLIeKoHHEfoxqrePdTV7YRi4ILikR7n
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2088650"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="2088650"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 14:13:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="712031832"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="712031832"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Nov 2023 14:13:25 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzlMx-0005pc-0S;
        Sun, 05 Nov 2023 22:13:23 +0000
Date:   Mon, 6 Nov 2023 06:12:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Francesco Ruggeri <fruggeri@arista.com>,
        Salam Noureddine <noureddine@arista.com>
Subject: net/ipv4/tcp_output.c:652:1: error: label at end of compound
 statement
Message-ID: <202311060601.Zxb8wIrg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: 1e03d32bea8e782b7d31769c25a5fae8a5044488 net/tcp: Add TCP-AO sign to outgoing packets
date:   10 days ago
config: x86_64-buildonly-randconfig-005-20231106 (https://download.01.org/0day-ci/archive/20231106/202311060601.Zxb8wIrg-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060601.Zxb8wIrg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060601.Zxb8wIrg-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/ipv4/tcp_output.c: In function 'tcp_options_write':
>> net/ipv4/tcp_output.c:652:1: error: label at end of compound statement
     652 | out_ao:
         | ^~~~~~


vim +652 net/ipv4/tcp_output.c

   603	
   604	/* Write previously computed TCP options to the packet.
   605	 *
   606	 * Beware: Something in the Internet is very sensitive to the ordering of
   607	 * TCP options, we learned this through the hard way, so be careful here.
   608	 * Luckily we can at least blame others for their non-compliance but from
   609	 * inter-operability perspective it seems that we're somewhat stuck with
   610	 * the ordering which we have been using if we want to keep working with
   611	 * those broken things (not that it currently hurts anybody as there isn't
   612	 * particular reason why the ordering would need to be changed).
   613	 *
   614	 * At least SACK_PERM as the first option is known to lead to a disaster
   615	 * (but it may well be that other scenarios fail similarly).
   616	 */
   617	static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
   618				      struct tcp_out_options *opts,
   619				      struct tcp_key *key)
   620	{
   621		__be32 *ptr = (__be32 *)(th + 1);
   622		u16 options = opts->options;	/* mungable copy */
   623	
   624		if (tcp_key_is_md5(key)) {
   625			*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
   626				       (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5SIG);
   627			/* overload cookie hash location */
   628			opts->hash_location = (__u8 *)ptr;
   629			ptr += 4;
   630		} else if (tcp_key_is_ao(key)) {
   631	#ifdef CONFIG_TCP_AO
   632			struct tcp_ao_key *rnext_key;
   633			struct tcp_ao_info *ao_info;
   634			u8 maclen;
   635	
   636			ao_info = rcu_dereference_check(tp->ao_info,
   637					lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
   638			rnext_key = READ_ONCE(ao_info->rnext_key);
   639			if (WARN_ON_ONCE(!rnext_key))
   640				goto out_ao;
   641			maclen = tcp_ao_maclen(key->ao_key);
   642			*ptr++ = htonl((TCPOPT_AO << 24) |
   643					(tcp_ao_len(key->ao_key) << 16) |
   644					(key->ao_key->sndid << 8) |
   645					(rnext_key->rcvid));
   646			opts->hash_location = (__u8 *)ptr;
   647			ptr += maclen / sizeof(*ptr);
   648			if (unlikely(maclen % sizeof(*ptr))) {
   649				memset(ptr, TCPOPT_NOP, sizeof(*ptr));
   650				ptr++;
   651			}
 > 652	out_ao:
   653	#endif
   654		}
   655		if (unlikely(opts->mss)) {
   656			*ptr++ = htonl((TCPOPT_MSS << 24) |
   657				       (TCPOLEN_MSS << 16) |
   658				       opts->mss);
   659		}
   660	
   661		if (likely(OPTION_TS & options)) {
   662			if (unlikely(OPTION_SACK_ADVERTISE & options)) {
   663				*ptr++ = htonl((TCPOPT_SACK_PERM << 24) |
   664					       (TCPOLEN_SACK_PERM << 16) |
   665					       (TCPOPT_TIMESTAMP << 8) |
   666					       TCPOLEN_TIMESTAMP);
   667				options &= ~OPTION_SACK_ADVERTISE;
   668			} else {
   669				*ptr++ = htonl((TCPOPT_NOP << 24) |
   670					       (TCPOPT_NOP << 16) |
   671					       (TCPOPT_TIMESTAMP << 8) |
   672					       TCPOLEN_TIMESTAMP);
   673			}
   674			*ptr++ = htonl(opts->tsval);
   675			*ptr++ = htonl(opts->tsecr);
   676		}
   677	
   678		if (unlikely(OPTION_SACK_ADVERTISE & options)) {
   679			*ptr++ = htonl((TCPOPT_NOP << 24) |
   680				       (TCPOPT_NOP << 16) |
   681				       (TCPOPT_SACK_PERM << 8) |
   682				       TCPOLEN_SACK_PERM);
   683		}
   684	
   685		if (unlikely(OPTION_WSCALE & options)) {
   686			*ptr++ = htonl((TCPOPT_NOP << 24) |
   687				       (TCPOPT_WINDOW << 16) |
   688				       (TCPOLEN_WINDOW << 8) |
   689				       opts->ws);
   690		}
   691	
   692		if (unlikely(opts->num_sack_blocks)) {
   693			struct tcp_sack_block *sp = tp->rx_opt.dsack ?
   694				tp->duplicate_sack : tp->selective_acks;
   695			int this_sack;
   696	
   697			*ptr++ = htonl((TCPOPT_NOP  << 24) |
   698				       (TCPOPT_NOP  << 16) |
   699				       (TCPOPT_SACK <<  8) |
   700				       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
   701							     TCPOLEN_SACK_PERBLOCK)));
   702	
   703			for (this_sack = 0; this_sack < opts->num_sack_blocks;
   704			     ++this_sack) {
   705				*ptr++ = htonl(sp[this_sack].start_seq);
   706				*ptr++ = htonl(sp[this_sack].end_seq);
   707			}
   708	
   709			tp->rx_opt.dsack = 0;
   710		}
   711	
   712		if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
   713			struct tcp_fastopen_cookie *foc = opts->fastopen_cookie;
   714			u8 *p = (u8 *)ptr;
   715			u32 len; /* Fast Open option length */
   716	
   717			if (foc->exp) {
   718				len = TCPOLEN_EXP_FASTOPEN_BASE + foc->len;
   719				*ptr = htonl((TCPOPT_EXP << 24) | (len << 16) |
   720					     TCPOPT_FASTOPEN_MAGIC);
   721				p += TCPOLEN_EXP_FASTOPEN_BASE;
   722			} else {
   723				len = TCPOLEN_FASTOPEN_BASE + foc->len;
   724				*p++ = TCPOPT_FASTOPEN;
   725				*p++ = len;
   726			}
   727	
   728			memcpy(p, foc->val, foc->len);
   729			if ((len & 3) == 2) {
   730				p[foc->len] = TCPOPT_NOP;
   731				p[foc->len + 1] = TCPOPT_NOP;
   732			}
   733			ptr += (len + 3) >> 2;
   734		}
   735	
   736		smc_options_write(ptr, &options);
   737	
   738		mptcp_options_write(th, ptr, tp, opts);
   739	}
   740	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
