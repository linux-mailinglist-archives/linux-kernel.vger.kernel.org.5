Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A9B79F0C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjIMSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIMSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:00:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8312A19AE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694628000; x=1726164000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9qCurJ+jOiH/i/Kxtn+yRMCnJIKseSSgx4bXEEjv/jA=;
  b=TXwIgjtNsjf1amF4sIvyvr8w7yraa3PjL+AlunSJYOtlXgze2UBYSlcN
   aIGC8nReGB0T54MEwHZ3g6P5vc/hwZfwTc6/hLcHRe7qg7248OC9bmESg
   i6ILEwtQnOGdNkCvFP/TKnb16HeuNBtMCZEtYfE2YJwqBbsyQTBradZY4
   gbAuEbTWmvjm6yw1UOZcT0tCXVQtlB2cMuppwkoyG4Krhhj3fhc8XUaFT
   qbhlO02iALU1YVcp9xGQj12SPJz1ULfetHnGvp2YTbPYIbUe0M/82+gme
   R8IeApgQ75vkXORfcvhmVr/PCAcMLSLA49GwRz8RKsYtkWrkgiZEzQ76c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377649739"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="377649739"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 10:59:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="859357719"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="859357719"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Sep 2023 10:59:55 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgU9Z-0000Qr-2i;
        Wed, 13 Sep 2023 17:59:53 +0000
Date:   Thu, 14 Sep 2023 01:59:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oleg Nesterov <oleg@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] seqlock: change __seqprop() to return the function
 pointer
Message-ID: <202309140156.adz3K06E-lkp@intel.com>
References: <20230913154956.GA26245@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913154956.GA26245@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on tip/sched/core linus/master v6.6-rc1 next-20230913]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oleg-Nesterov/seqlock-simplify-SEQCOUNT_LOCKNAME/20230913-235245
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20230913154956.GA26245%40redhat.com
patch subject: [PATCH 2/5] seqlock: change __seqprop() to return the function pointer
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20230914/202309140156.adz3K06E-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230914/202309140156.adz3K06E-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309140156.adz3K06E-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:20,
                    from arch/parisc/kernel/asm-offsets.c:18:
   include/linux/fs.h: In function 'i_size_read':
>> include/linux/fs.h:867:43: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:867:23: note: in expansion of macro 'read_seqcount_begin'
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/fs.h:869:38: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:869:18: note: in expansion of macro 'read_seqcount_retry'
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                  ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
--
   In file included from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from kernel/fork.c:16:
   include/linux/fs.h: In function 'i_size_read':
>> include/linux/fs.h:867:43: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:867:23: note: in expansion of macro 'read_seqcount_begin'
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/fs.h:869:38: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:869:18: note: in expansion of macro 'read_seqcount_retry'
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                  ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_begin':
   include/linux/u64_stats_sync.h:170:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     170 |         return read_seqcount_begin(&syncp->seq);
         |                                    ^~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/u64_stats_sync.h:170:16: note: in expansion of macro 'read_seqcount_begin'
     170 |         return read_seqcount_begin(&syncp->seq);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_retry':
   include/linux/u64_stats_sync.h:176:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     176 |         return read_seqcount_retry(&syncp->seq, start);
         |                                    ^~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/u64_stats_sync.h:176:16: note: in expansion of macro 'read_seqcount_retry'
     176 |         return read_seqcount_retry(&syncp->seq, start);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
--
   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:20,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from kernel/panic.c:14:
   include/linux/fs.h: In function 'i_size_read':
>> include/linux/fs.h:867:43: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:867:23: note: in expansion of macro 'read_seqcount_begin'
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/fs.h:869:38: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:869:18: note: in expansion of macro 'read_seqcount_retry'
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                  ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   kernel/panic.c: In function '__warn':
   kernel/panic.c:666:17: warning: function '__warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     666 |                 vprintk(args->fmt, args->args);
         |                 ^~~~~~~
--
   In file included from include/linux/mmzone.h:17,
                    from include/linux/gfp.h:7,
                    from include/linux/mm.h:7,
                    from kernel/audit.c:38:
   include/linux/fs.h: In function 'i_size_read':
>> include/linux/fs.h:867:43: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:867:23: note: in expansion of macro 'read_seqcount_begin'
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/fs.h:869:38: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:869:18: note: in expansion of macro 'read_seqcount_retry'
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                  ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_begin':
   include/linux/u64_stats_sync.h:170:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     170 |         return read_seqcount_begin(&syncp->seq);
         |                                    ^~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/u64_stats_sync.h:170:16: note: in expansion of macro 'read_seqcount_begin'
     170 |         return read_seqcount_begin(&syncp->seq);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_retry':
   include/linux/u64_stats_sync.h:176:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     176 |         return read_seqcount_retry(&syncp->seq, start);
         |                                    ^~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/u64_stats_sync.h:176:16: note: in expansion of macro 'read_seqcount_retry'
     176 |         return read_seqcount_retry(&syncp->seq, start);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   kernel/audit.c: In function 'audit_log_vformat':
   kernel/audit.c:1963:9: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1963 |         len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args);
         |         ^~~
   kernel/audit.c:1972:17: warning: function 'audit_log_vformat' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    1972 |                 len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
         |                 ^~~
--
   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:20,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/trace_recursion.h:5,
                    from include/linux/ftrace.h:10,
                    from include/linux/kprobes.h:28,
                    from kernel/kprobes.c:23:
   include/linux/fs.h: In function 'i_size_read':
>> include/linux/fs.h:867:43: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:867:23: note: in expansion of macro 'read_seqcount_begin'
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/fs.h:869:38: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:869:18: note: in expansion of macro 'read_seqcount_retry'
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                  ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_begin':
   include/linux/u64_stats_sync.h:170:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     170 |         return read_seqcount_begin(&syncp->seq);
         |                                    ^~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/u64_stats_sync.h:170:16: note: in expansion of macro 'read_seqcount_begin'
     170 |         return read_seqcount_begin(&syncp->seq);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_retry':
   include/linux/u64_stats_sync.h:176:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     176 |         return read_seqcount_retry(&syncp->seq, start);
         |                                    ^~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/u64_stats_sync.h:176:16: note: in expansion of macro 'read_seqcount_retry'
     176 |         return read_seqcount_retry(&syncp->seq, start);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   kernel/kprobes.c: At top level:
   kernel/kprobes.c:1853:12: warning: no previous prototype for 'kprobe_exceptions_notify' [-Wmissing-prototypes]
    1853 | int __weak kprobe_exceptions_notify(struct notifier_block *self,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:20,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from kernel/iomem.c:2:
   include/linux/fs.h: In function 'i_size_read':
>> include/linux/fs.h:867:43: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:867:23: note: in expansion of macro 'read_seqcount_begin'
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/fs.h:869:38: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:869:18: note: in expansion of macro 'read_seqcount_retry'
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                  ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   kernel/iomem.c: At top level:
   kernel/iomem.c:9:22: warning: no previous prototype for 'ioremap_cache' [-Wmissing-prototypes]
       9 | __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
         |                      ^~~~~~~~~~~~~
--
   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:20,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from kernel/time/hrtimer.c:25:
   include/linux/fs.h: In function 'i_size_read':
>> include/linux/fs.h:867:43: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:867:23: note: in expansion of macro 'read_seqcount_begin'
     867 |                 seq = read_seqcount_begin(&inode->i_size_seqcount);
         |                       ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/fs.h:869:38: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/fs.h:869:18: note: in expansion of macro 'read_seqcount_retry'
     869 |         } while (read_seqcount_retry(&inode->i_size_seqcount, seq));
         |                  ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_begin':
   include/linux/u64_stats_sync.h:170:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     170 |         return read_seqcount_begin(&syncp->seq);
         |                                    ^~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/u64_stats_sync.h:170:16: note: in expansion of macro 'read_seqcount_begin'
     170 |         return read_seqcount_begin(&syncp->seq);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   include/linux/u64_stats_sync.h: In function '__u64_stats_fetch_retry':
   include/linux/u64_stats_sync.h:176:36: warning: passing argument 1 of '__seqprop_ptr' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     176 |         return read_seqcount_retry(&syncp->seq, start);
         |                                    ^~~~~~~~~~~
   include/linux/seqlock.h:304:59: note: in definition of macro 'seqprop_ptr'
     304 | #define seqprop_ptr(s)                  __seqprop(s, ptr)(s)
         |                                                           ^
   include/linux/u64_stats_sync.h:176:16: note: in expansion of macro 'read_seqcount_retry'
     176 |         return read_seqcount_retry(&syncp->seq, start);
         |                ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:250:53: note: expected 'seqcount_t *' {aka 'struct seqcount *'} but argument is of type 'const seqcount_t *' {aka 'const struct seqcount *'}
     250 | static inline seqcount_t *__seqprop_ptr(seqcount_t *s)
         |                                         ~~~~~~~~~~~~^
   kernel/time/hrtimer.c: At top level:
   kernel/time/hrtimer.c:120:35: warning: initialized field overwritten [-Woverride-init]
     120 |         [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:120:35: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
   kernel/time/hrtimer.c:121:35: warning: initialized field overwritten [-Woverride-init]
     121 |         [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
         |                                   ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:35: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
   kernel/time/hrtimer.c:122:35: warning: initialized field overwritten [-Woverride-init]
     122 |         [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:35: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
   kernel/time/hrtimer.c:123:35: warning: initialized field overwritten [-Woverride-init]
     123 |         [CLOCK_TAI]             = HRTIMER_BASE_TAI,
         |                                   ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:35: note: (near initialization for 'hrtimer_clock_to_base_table[11]')
..


vim +867 include/linux/fs.h

375e289ea85166 J. Bruce Fields 2012-04-18  843  
7506ae6a7033f6 Jan Kara        2021-05-24  844  void filemap_invalidate_lock_two(struct address_space *mapping1,
7506ae6a7033f6 Jan Kara        2021-05-24  845  				 struct address_space *mapping2);
7506ae6a7033f6 Jan Kara        2021-05-24  846  void filemap_invalidate_unlock_two(struct address_space *mapping1,
7506ae6a7033f6 Jan Kara        2021-05-24  847  				   struct address_space *mapping2);
7506ae6a7033f6 Jan Kara        2021-05-24  848  
7506ae6a7033f6 Jan Kara        2021-05-24  849  
^1da177e4c3f41 Linus Torvalds  2005-04-16  850  /*
^1da177e4c3f41 Linus Torvalds  2005-04-16  851   * NOTE: in a 32bit arch with a preemptable kernel and
^1da177e4c3f41 Linus Torvalds  2005-04-16  852   * an UP compile the i_size_read/write must be atomic
^1da177e4c3f41 Linus Torvalds  2005-04-16  853   * with respect to the local cpu (unlike with preempt disabled),
^1da177e4c3f41 Linus Torvalds  2005-04-16  854   * but they don't need to be atomic with respect to other cpus like in
^1da177e4c3f41 Linus Torvalds  2005-04-16  855   * true SMP (so they need either to either locally disable irq around
^1da177e4c3f41 Linus Torvalds  2005-04-16  856   * the read or for example on x86 they can be still implemented as a
^1da177e4c3f41 Linus Torvalds  2005-04-16  857   * cmpxchg8b without the need of the lock prefix). For SMP compiles
^1da177e4c3f41 Linus Torvalds  2005-04-16  858   * and 64bit archs it makes no difference if preempt is enabled or not.
^1da177e4c3f41 Linus Torvalds  2005-04-16  859   */
48ed214d10ae3c Jan Engelhardt  2006-12-06  860  static inline loff_t i_size_read(const struct inode *inode)
^1da177e4c3f41 Linus Torvalds  2005-04-16  861  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  862  #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
^1da177e4c3f41 Linus Torvalds  2005-04-16  863  	loff_t i_size;
^1da177e4c3f41 Linus Torvalds  2005-04-16  864  	unsigned int seq;
^1da177e4c3f41 Linus Torvalds  2005-04-16  865  
^1da177e4c3f41 Linus Torvalds  2005-04-16  866  	do {
^1da177e4c3f41 Linus Torvalds  2005-04-16 @867  		seq = read_seqcount_begin(&inode->i_size_seqcount);
^1da177e4c3f41 Linus Torvalds  2005-04-16  868  		i_size = inode->i_size;
^1da177e4c3f41 Linus Torvalds  2005-04-16  869  	} while (read_seqcount_retry(&inode->i_size_seqcount, seq));
^1da177e4c3f41 Linus Torvalds  2005-04-16  870  	return i_size;
2496396fcb4440 Thomas Gleixner 2019-10-15  871  #elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPTION)
^1da177e4c3f41 Linus Torvalds  2005-04-16  872  	loff_t i_size;
^1da177e4c3f41 Linus Torvalds  2005-04-16  873  
^1da177e4c3f41 Linus Torvalds  2005-04-16  874  	preempt_disable();
^1da177e4c3f41 Linus Torvalds  2005-04-16  875  	i_size = inode->i_size;
^1da177e4c3f41 Linus Torvalds  2005-04-16  876  	preempt_enable();
^1da177e4c3f41 Linus Torvalds  2005-04-16  877  	return i_size;
^1da177e4c3f41 Linus Torvalds  2005-04-16  878  #else
^1da177e4c3f41 Linus Torvalds  2005-04-16  879  	return inode->i_size;
^1da177e4c3f41 Linus Torvalds  2005-04-16  880  #endif
^1da177e4c3f41 Linus Torvalds  2005-04-16  881  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  882  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
