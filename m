Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2614E807395
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442559AbjLFPRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379162AbjLFPRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:17:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18910DE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701875872; x=1733411872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=waumdTvJZcsBL2ArztxFKebgk3BhCdNk/+PYejbqe8M=;
  b=bqTelXG9lOqvuXjljJjTxJO6VBoEQ3WAx7PYuv1KVzC0GG/GWqitDxrJ
   5qZoU8oOPvD906zF3hTvWgIzYz/W1yuHFp8bXlTWX1IuY5s6awupcctjT
   NzwzQJ5Uhd3Q17imX+TsD7U6xg228PI/5CrVsniq+idaz9MK2EomJ8mGu
   2WHMA6snZA7E8fRHq/v0CNjkuMzwkECVDTQsQhDUyDZQcH8EsUjCHkYt6
   Jzgt7uDa2GUNUgiXMoMIDEiBrsh4QpU8vox4h56EHOsjXHR+blC1tvgEw
   yoTI7ujEuZnOwH3RIYoSSnWrRzph6svDuhrnqJAfwfB0lJF7FJuUV5kLE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="374253692"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="374253692"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 07:17:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="805669853"
X-IronPort-AV: E=Sophos;i="6.04,255,1695711600"; 
   d="scan'208";a="805669853"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 06 Dec 2023 07:17:48 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAtek-000Azq-2D;
        Wed, 06 Dec 2023 15:17:46 +0000
Date:   Wed, 6 Dec 2023 23:17:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     oe-kbuild-all@lists.linux.dev, shr@devkernel.io,
        akpm@linux-foundation.org, david@redhat.com, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/4] mm/ksm: add ksm advisor
Message-ID: <202312062353.lBYSA7Eb-lkp@intel.com>
References: <20231204234906.1237478-2-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204234906.1237478-2-shr@devkernel.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

kernel test robot noticed the following build errors:

[auto build test ERROR on 12d04a7bf0da67321229d2bc8b1a7074d65415a9]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Roesch/mm-ksm-add-ksm-advisor/20231205-075118
base:   12d04a7bf0da67321229d2bc8b1a7074d65415a9
patch link:    https://lore.kernel.org/r/20231204234906.1237478-2-shr%40devkernel.io
patch subject: [PATCH v3 1/4] mm/ksm: add ksm advisor
config: i386-randconfig-011-20231206 (https://download.01.org/0day-ci/archive/20231206/202312062353.lBYSA7Eb-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231206/202312062353.lBYSA7Eb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312062353.lBYSA7Eb-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: mm/ksm.o: in function `scan_time_advisor':
>> mm/ksm.c:423: undefined reference to `__divdi3'
>> ld: mm/ksm.c:435: undefined reference to `__divdi3'
   ld: mm/ksm.c:428: undefined reference to `__divdi3'


vim +423 mm/ksm.c

   383	
   384	/*
   385	 * The scan time advisor is based on the current scan rate and the target
   386	 * scan rate.
   387	 *
   388	 *      new_pages_to_scan = pages_to_scan * (scan_time / target_scan_time)
   389	 *
   390	 * To avoid pertubations it calculates a change factor of previous changes.
   391	 * A new change factor is calculated for each iteration and it uses an
   392	 * exponentially weighted moving average. The new pages_to_scan value is
   393	 * multiplied with that change factor:
   394	 *
   395	 *      new_pages_to_scan *= change facor
   396	 *
   397	 * In addition the new pages_to_scan value is capped by the max and min
   398	 * limits.
   399	 */
   400	static void scan_time_advisor(void)
   401	{
   402		unsigned int cpu_percent;
   403		unsigned long cpu_time;
   404		unsigned long cpu_time_diff;
   405		unsigned long cpu_time_diff_ms;
   406		unsigned long pages;
   407		unsigned long per_page_cost;
   408		unsigned long factor;
   409		unsigned long change;
   410		unsigned long last_scan_time;
   411		s64 scan_time;
   412	
   413		/* Convert scan time to seconds */
   414		scan_time = advisor_stop_scan();
   415		scan_time = div_s64(scan_time, MSEC_PER_SEC);
   416		scan_time = scan_time ? scan_time : 1;
   417	
   418		/* Calculate CPU consumption of ksmd background thread */
   419		cpu_time = task_sched_runtime(current);
   420		cpu_time_diff = cpu_time - advisor_ctx.cpu_time;
   421		cpu_time_diff_ms = cpu_time_diff / 1000 / 1000;
   422	
 > 423		cpu_percent = (cpu_time_diff_ms * 100) / (scan_time * 1000);
   424		cpu_percent = cpu_percent ? cpu_percent : 1;
   425		last_scan_time = prev_scan_time(&advisor_ctx, scan_time);
   426	
   427		/* Calculate scan time as percentage of target scan time */
   428		factor = ksm_advisor_target_scan_time * 100 / scan_time;
   429		factor = factor ? factor : 1;
   430	
   431		/*
   432		 * Calculate scan time as percentage of last scan time and use
   433		 * exponentially weighted average to smooth it
   434		 */
 > 435		change = scan_time * 100 / last_scan_time;
   436		change = change ? change : 1;
   437		change = ewma(advisor_ctx.change, change);
   438	
   439		/* Calculate new scan rate based on target scan rate. */
   440		pages = ksm_thread_pages_to_scan * 100 / factor;
   441		/* Update pages_to_scan by weighted change percentage. */
   442		pages = pages * change / 100;
   443	
   444		/* Cap new pages_to_scan value */
   445		per_page_cost = ksm_thread_pages_to_scan / cpu_percent;
   446		per_page_cost = per_page_cost ? per_page_cost : 1;
   447	
   448		pages = min(pages, per_page_cost * ksm_advisor_max_cpu);
   449		pages = max(pages, per_page_cost * ksm_advisor_min_cpu);
   450		pages = min(pages, ksm_advisor_max_pages);
   451	
   452		/* Update advisor context */
   453		advisor_ctx.change = change;
   454		advisor_ctx.scan_time = scan_time;
   455		advisor_ctx.cpu_time = cpu_time;
   456	
   457		ksm_thread_pages_to_scan = pages;
   458	}
   459	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
