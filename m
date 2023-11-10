Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E137E7648
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 02:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbjKJBET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 20:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKJBER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 20:04:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC203AA0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 17:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699578255; x=1731114255;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wWQ8L5zvh72IG5VMXG+uMJvdCYw0je9ei7amOqLX6RU=;
  b=j3gJeQL7zHySn2bhs7bXPB+wbx9hjnC247ocLd/MVNjuqjUMrK0jOkeN
   EnU5Ygp191/Jqi5FcVHeZCnkzfi/XHWZVwW9h0ZDwhTdzNi/ZK/22Umdx
   HHD4opBvipkUgbJjjFgMoO1dNJpXqrA1sNtdDK8BNZdoBZNK8ZQshbqgZ
   oztrJX1NAACTr+7rmMaAeTEHe4UXmIWxHQrY6vZik38WWDr1i8G0vznFB
   xOJg1HNLaEXVg59LzQI0IvSsXAyl8uJX0+7X3Wha03TRuTYr5Tv5jtWcz
   jhVXYgyheB/ysKVf1qGNx2L8pL1eDgj9iCW4qoAtylOOAD2gIRp4h6gR7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="454410990"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="454410990"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 17:04:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="713498300"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="713498300"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Nov 2023 17:04:11 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1FwM-0009K2-31;
        Fri, 10 Nov 2023 01:04:06 +0000
Date:   Fri, 10 Nov 2023 09:03:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/journal_io.c:1839 bch2_journal_write_pick_flush() warn:
 inconsistent indenting
Message-ID: <202311100842.OUiGSWxX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a12deb44f9734dc25970c266249b272e44d3d1b5
commit: 80396a47490936f73729548310ad60e9f5df61c9 bcachefs: Break up bch2_journal_write()
date:   4 days ago
config: i386-randconfig-141-20231108 (https://download.01.org/0day-ci/archive/20231110/202311100842.OUiGSWxX-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231110/202311100842.OUiGSWxX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311100842.OUiGSWxX-lkp@intel.com/

New smatch warnings:
fs/bcachefs/journal_io.c:1839 bch2_journal_write_pick_flush() warn: inconsistent indenting

Old smatch warnings:
fs/bcachefs/journal_io.c:132 journal_entry_add() warn: missing error code 'ret'

vim +1839 fs/bcachefs/journal_io.c

  1808	
  1809	static int bch2_journal_write_pick_flush(struct journal *j, struct journal_buf *w)
  1810	{
  1811		struct bch_fs *c = container_of(j, struct bch_fs, journal);
  1812		int error = bch2_journal_error(j);
  1813	
  1814		/*
  1815		 * If the journal is in an error state - we did an emergency shutdown -
  1816		 * we prefer to continue doing journal writes. We just mark them as
  1817		 * noflush so they'll never be used, but they'll still be visible by the
  1818		 * list_journal tool - this helps in debugging.
  1819		 *
  1820		 * There's a caveat: the first journal write after marking the
  1821		 * superblock dirty must always be a flush write, because on startup
  1822		 * from a clean shutdown we didn't necessarily read the journal and the
  1823		 * new journal write might overwrite whatever was in the journal
  1824		 * previously - we can't leave the journal without any flush writes in
  1825		 * it.
  1826		 *
  1827		 * So if we're in an error state, and we're still starting up, we don't
  1828		 * write anything at all.
  1829		 */
  1830		if (error && test_bit(JOURNAL_NEED_FLUSH_WRITE, &j->flags))
  1831			return -EIO;
  1832	
  1833		if (error ||
  1834		    w->noflush ||
  1835		    (!w->must_flush &&
  1836		     (jiffies - j->last_flush_write) < msecs_to_jiffies(c->opts.journal_flush_delay) &&
  1837		     test_bit(JOURNAL_MAY_SKIP_FLUSH, &j->flags))) {
  1838			     w->noflush = true;
> 1839			SET_JSET_NO_FLUSH(w->data, true);
  1840			w->data->last_seq	= 0;
  1841			w->last_seq		= 0;
  1842	
  1843			j->nr_noflush_writes++;
  1844		} else {
  1845			j->last_flush_write = jiffies;
  1846			j->nr_flush_writes++;
  1847			clear_bit(JOURNAL_NEED_FLUSH_WRITE, &j->flags);
  1848		}
  1849	
  1850		return 0;
  1851	}
  1852	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
