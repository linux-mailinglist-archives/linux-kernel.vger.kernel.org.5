Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E094675A3E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGTB2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGTB2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:28:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BF02102
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689816486; x=1721352486;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E+drKDhReuLt4SexwBU3aDcw0RNxg43bhlCQ63wJx5U=;
  b=Kmapg7RGiAi0sXqenRzq09JybiFG4UPZP0xqcBnnLJpUELoIif6tg/gA
   IFRtpvd/YFR6LKkZhX0TKLKAG58pjF5V6GHRGydsNprTWkw6UBRDxNJ+N
   8SzPFLWlJYnNlcTa3FW4UPdGth30e0aBknx3+puHCgcrnsWl9652xXNKk
   2tLVoAeshFJSACS9PvtefCCe0TtDh2NZH44cfx0Sg42NxpjXc/Qn9S3PS
   sh2X4Cp6aAohHUfUHTl3H/OfkuK2YKaYTniPXnOTH+8wd10+SSwzrnk7h
   pP6DqKPpd0cYzEz7/N/MEYVMHaw4yto5KXoc54bU+ofR8wOPeY7SgNlp8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="365490964"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="365490964"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 18:28:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="794246805"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="794246805"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2023 18:28:04 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMISZ-0005eb-1i;
        Thu, 20 Jul 2023 01:28:03 +0000
Date:   Thu, 20 Jul 2023 09:27:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: drivers/ata/libata-eh.c:2213:13: warning: stack frame size (2336)
 exceeds limit (2048) in 'ata_eh_link_report'
Message-ID: <202307200936.XBJIgHpV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bfa3037d828050896ae52f6467b6ca2489ae6fb1
commit: 742bef476ca5352b16063161fb73a56629a6d995 ata: libata: move ata_{port,link,dev}_dbg to standard pr_XXX() macros
date:   1 year, 6 months ago
config: riscv-randconfig-r042-20230720 (https://download.01.org/0day-ci/archive/20230720/202307200936.XBJIgHpV-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230720/202307200936.XBJIgHpV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307200936.XBJIgHpV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ata/libata-eh.c:2213:13: warning: stack frame size (2336) exceeds limit (2048) in 'ata_eh_link_report' [-Wframe-larger-than]
    2213 | static void ata_eh_link_report(struct ata_link *link)
         |             ^
>> drivers/ata/libata-eh.c:2443:5: warning: stack frame size (2416) exceeds limit (2048) in 'ata_eh_reset' [-Wframe-larger-than]
    2443 | int ata_eh_reset(struct ata_link *link, int classify,
         |     ^
   drivers/ata/libata-eh.c:3550:5: warning: stack frame size (4336) exceeds limit (2048) in 'ata_eh_recover' [-Wframe-larger-than]
    3550 | int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
         |     ^
   3 warnings generated.


vim +/ata_eh_link_report +2213 drivers/ata/libata-eh.c

6521148c644972 drivers/ata/libata-eh.c  Robert Hancock 2009-07-14  2203  
9b1e2658faf3f3 drivers/ata/libata-eh.c  Tejun Heo      2007-08-06  2204  /**
9b1e2658faf3f3 drivers/ata/libata-eh.c  Tejun Heo      2007-08-06  2205   *	ata_eh_link_report - report error handling to user
0260731f018784 drivers/ata/libata-eh.c  Tejun Heo      2007-08-06  2206   *	@link: ATA link EH is going on
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2207   *
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2208   *	Report EH to user.
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2209   *
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2210   *	LOCKING:
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2211   *	None.
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2212   */
9b1e2658faf3f3 drivers/ata/libata-eh.c  Tejun Heo      2007-08-06 @2213  static void ata_eh_link_report(struct ata_link *link)
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2214  {
0260731f018784 drivers/ata/libata-eh.c  Tejun Heo      2007-08-06  2215  	struct ata_port *ap = link->ap;
0260731f018784 drivers/ata/libata-eh.c  Tejun Heo      2007-08-06  2216  	struct ata_eh_context *ehc = &link->eh_context;
258c4e5c65b21b drivers/ata/libata-eh.c  Jens Axboe     2018-06-19  2217  	struct ata_queued_cmd *qc;
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2218  	const char *frozen, *desc;
462098b090897f drivers/ata/libata-eh.c  Levente Kurusa 2013-10-29  2219  	char tries_buf[6] = "";
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2220  	int tag, nr_failed = 0;
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2221  
94ff3d54080975 drivers/ata/libata-eh.c  Tejun Heo      2007-10-09  2222  	if (ehc->i.flags & ATA_EHI_QUIET)
94ff3d54080975 drivers/ata/libata-eh.c  Tejun Heo      2007-10-09  2223  		return;
94ff3d54080975 drivers/ata/libata-eh.c  Tejun Heo      2007-10-09  2224  
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2225  	desc = NULL;
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2226  	if (ehc->i.desc[0] != '\0')
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2227  		desc = ehc->i.desc;
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2228  
258c4e5c65b21b drivers/ata/libata-eh.c  Jens Axboe     2018-06-19  2229  	ata_qc_for_each_raw(ap, qc, tag) {
b1c72916abbdd0 drivers/ata/libata-eh.c  Tejun Heo      2008-07-31  2230  		if (!(qc->flags & ATA_QCFLAG_FAILED) ||
b1c72916abbdd0 drivers/ata/libata-eh.c  Tejun Heo      2008-07-31  2231  		    ata_dev_phys_link(qc->dev) != link ||
e027bd36c14658 drivers/ata/libata-eh.c  Tejun Heo      2007-10-26  2232  		    ((qc->flags & ATA_QCFLAG_QUIET) &&
e027bd36c14658 drivers/ata/libata-eh.c  Tejun Heo      2007-10-26  2233  		     qc->err_mask == AC_ERR_DEV))
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2234  			continue;
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2235  		if (qc->flags & ATA_QCFLAG_SENSE_VALID && !qc->err_mask)
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2236  			continue;
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2237  
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2238  		nr_failed++;
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2239  	}
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2240  
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2241  	if (!nr_failed && !ehc->i.err_mask)
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2242  		return;
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2243  
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2244  	frozen = "";
b51e9e5db0e362 drivers/scsi/libata-eh.c Tejun Heo      2006-06-29  2245  	if (ap->pflags & ATA_PFLAG_FROZEN)
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2246  		frozen = " frozen";
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2247  
a1e10f7e68a544 drivers/ata/libata-eh.c  Tejun Heo      2007-08-18  2248  	if (ap->eh_tries < ATA_EH_MAX_TRIES)
462098b090897f drivers/ata/libata-eh.c  Levente Kurusa 2013-10-29  2249  		snprintf(tries_buf, sizeof(tries_buf), " t%d",
a1e10f7e68a544 drivers/ata/libata-eh.c  Tejun Heo      2007-08-18  2250  			 ap->eh_tries);
a1e10f7e68a544 drivers/ata/libata-eh.c  Tejun Heo      2007-08-18  2251  
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2252  	if (ehc->i.dev) {
a9a79dfec23956 drivers/ata/libata-eh.c  Joe Perches    2011-04-15  2253  		ata_dev_err(ehc->i.dev, "exception Emask 0x%x "
a1e10f7e68a544 drivers/ata/libata-eh.c  Tejun Heo      2007-08-18  2254  			    "SAct 0x%x SErr 0x%x action 0x%x%s%s\n",
a1e10f7e68a544 drivers/ata/libata-eh.c  Tejun Heo      2007-08-18  2255  			    ehc->i.err_mask, link->sactive, ehc->i.serror,
a1e10f7e68a544 drivers/ata/libata-eh.c  Tejun Heo      2007-08-18  2256  			    ehc->i.action, frozen, tries_buf);
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2257  		if (desc)
a9a79dfec23956 drivers/ata/libata-eh.c  Joe Perches    2011-04-15  2258  			ata_dev_err(ehc->i.dev, "%s\n", desc);
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2259  	} else {
a9a79dfec23956 drivers/ata/libata-eh.c  Joe Perches    2011-04-15  2260  		ata_link_err(link, "exception Emask 0x%x "
a1e10f7e68a544 drivers/ata/libata-eh.c  Tejun Heo      2007-08-18  2261  			     "SAct 0x%x SErr 0x%x action 0x%x%s%s\n",
a1e10f7e68a544 drivers/ata/libata-eh.c  Tejun Heo      2007-08-18  2262  			     ehc->i.err_mask, link->sactive, ehc->i.serror,
a1e10f7e68a544 drivers/ata/libata-eh.c  Tejun Heo      2007-08-18  2263  			     ehc->i.action, frozen, tries_buf);
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2264  		if (desc)
a9a79dfec23956 drivers/ata/libata-eh.c  Joe Perches    2011-04-15  2265  			ata_link_err(link, "%s\n", desc);
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2266  	}
022bdb075b9e1f drivers/scsi/libata-eh.c Tejun Heo      2006-05-15  2267  

:::::: The code at line 2213 was first introduced by commit
:::::: 9b1e2658faf3f3095a96558c333b333c0e29dbc0 libata-link: update EH to deal with PMP links

:::::: TO: Tejun Heo <htejun@gmail.com>
:::::: CC: Jeff Garzik <jeff@garzik.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
