Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E387C99F8
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjJOQS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjJOQS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:18:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE5FA3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697386704; x=1728922704;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rATI1Hmy6yiVcD0qBZP/oh/fcJkEVdB9U91QYMV0CHs=;
  b=jF2G6Xd0JHHaVvs24UuDewUHb/F2n8JoOl7ZGFlQ/eWEEwfxorRLl9c7
   HAefX22XpdWff+nlO6kho4haLJwXAIgltoMofQTCDXIC+8zSflAOOSN/K
   k9n923QvwcaJR4hQGoc7/t7dv8oc9DSLZq8+DKEgwh/cJ/Zub2HEepBh9
   EjnTObWb+2zQAgBXTb1801nTnd7mSc61C4F75hFglUje6jBcqRfP7xdo2
   OVMn/z4FAVyk2QxNw7JrDkpE+FioujkNZA6yJxNpTIqbxQGlNH4ibEQll
   sBEhryZ3wA2ygXD4jiIpc2TRdbPrOcxKsqfYGoCsspeItLuvS1uQSuF0+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="389261375"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="389261375"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 09:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="825712711"
X-IronPort-AV: E=Sophos;i="6.03,226,1694761200"; 
   d="scan'208";a="825712711"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Oct 2023 09:18:21 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qs3op-0007Yb-0i;
        Sun, 15 Oct 2023 16:18:19 +0000
Date:   Mon, 16 Oct 2023 00:17:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Bartosz Szczepanek <bsz@semihalf.com>
Subject: include/linux/tpm_eventlog.h:165:6: warning: variable 'mapping_size'
 set but not used
Message-ID: <202310160026.eOXhKeWr-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9a3dad63edbe9a2ab2be1e7361a2133f519f855b
commit: c46f3405692de1ac82240d927b9c7a0f9d6a4a36 tpm: Reserve the TPM final events table
date:   4 years, 4 months ago
config: x86_64-randconfig-013-20230909 (https://download.01.org/0day-ci/archive/20231016/202310160026.eOXhKeWr-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231016/202310160026.eOXhKeWr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310160026.eOXhKeWr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   clang-16: warning: argument unused during compilation: '-mno-global-merge' [-Wunused-command-line-argument]
   In file included from drivers/char/tpm/eventlog/common.c:20:
>> include/linux/tpm_eventlog.h:165:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
           int mapping_size;
               ^
   1 warning generated.
--
   clang-16: warning: argument unused during compilation: '-mno-global-merge' [-Wunused-command-line-argument]
   In file included from drivers/char/tpm/eventlog/tpm1.c:24:
>> include/linux/tpm_eventlog.h:165:6: warning: variable 'mapping_size' set but not used [-Wunused-but-set-variable]
           int mapping_size;
               ^
   drivers/char/tpm/eventlog/tpm1.c:253:6: warning: variable 'len' set but not used [-Wunused-but-set-variable]
           int len = 0;
               ^
   2 warnings generated.


vim +/mapping_size +165 include/linux/tpm_eventlog.h

   138	
   139	/**
   140	 * __calc_tpm2_event_size - calculate the size of a TPM2 event log entry
   141	 * @event:        Pointer to the event whose size should be calculated
   142	 * @event_header: Pointer to the initial event containing the digest lengths
   143	 * @do_mapping:   Whether or not the event needs to be mapped
   144	 *
   145	 * The TPM2 event log format can contain multiple digests corresponding to
   146	 * separate PCR banks, and also contains a variable length of the data that
   147	 * was measured. This requires knowledge of how long each digest type is,
   148	 * and this information is contained within the first event in the log.
   149	 *
   150	 * We calculate the length by examining the number of events, and then looking
   151	 * at each event in turn to determine how much space is used for events in
   152	 * total. Once we've done this we know the offset of the data length field,
   153	 * and can calculate the total size of the event.
   154	 *
   155	 * Return: size of the event on success, <0 on failure
   156	 */
   157	
   158	static inline int __calc_tpm2_event_size(struct tcg_pcr_event2_head *event,
   159						 struct tcg_pcr_event *event_header,
   160						 bool do_mapping)
   161	{
   162		struct tcg_efi_specid_event_head *efispecid;
   163		struct tcg_event_field *event_field;
   164		void *mapping = NULL;
 > 165		int mapping_size;
   166		void *marker;
   167		void *marker_start;
   168		u32 halg_size;
   169		size_t size;
   170		u16 halg;
   171		int i;
   172		int j;
   173	
   174		marker = event;
   175		marker_start = marker;
   176		marker = marker + sizeof(event->pcr_idx) + sizeof(event->event_type)
   177			+ sizeof(event->count);
   178	
   179		/* Map the event header */
   180		if (do_mapping) {
   181			mapping_size = marker - marker_start;
   182			mapping = TPM_MEMREMAP((unsigned long)marker_start,
   183					       mapping_size);
   184			if (!mapping) {
   185				size = 0;
   186				goto out;
   187			}
   188		} else {
   189			mapping = marker_start;
   190		}
   191	
   192		event = (struct tcg_pcr_event2_head *)mapping;
   193	
   194		efispecid = (struct tcg_efi_specid_event_head *)event_header->event;
   195	
   196		/* Check if event is malformed. */
   197		if (event->count > efispecid->num_algs) {
   198			size = 0;
   199			goto out;
   200		}
   201	
   202		for (i = 0; i < event->count; i++) {
   203			halg_size = sizeof(event->digests[i].alg_id);
   204	
   205			/* Map the digest's algorithm identifier */
   206			if (do_mapping) {
   207				TPM_MEMUNMAP(mapping, mapping_size);
   208				mapping_size = halg_size;
   209				mapping = TPM_MEMREMAP((unsigned long)marker,
   210						     mapping_size);
   211				if (!mapping) {
   212					size = 0;
   213					goto out;
   214				}
   215			} else {
   216				mapping = marker;
   217			}
   218	
   219			memcpy(&halg, mapping, halg_size);
   220			marker = marker + halg_size;
   221	
   222			for (j = 0; j < efispecid->num_algs; j++) {
   223				if (halg == efispecid->digest_sizes[j].alg_id) {
   224					marker +=
   225						efispecid->digest_sizes[j].digest_size;
   226					break;
   227				}
   228			}
   229			/* Algorithm without known length. Such event is unparseable. */
   230			if (j == efispecid->num_algs) {
   231				size = 0;
   232				goto out;
   233			}
   234		}
   235	
   236		/*
   237		 * Map the event size - we don't read from the event itself, so
   238		 * we don't need to map it
   239		 */
   240		if (do_mapping) {
   241			TPM_MEMUNMAP(mapping, mapping_size);
   242			mapping_size += sizeof(event_field->event_size);
   243			mapping = TPM_MEMREMAP((unsigned long)marker,
   244					       mapping_size);
   245			if (!mapping) {
   246				size = 0;
   247				goto out;
   248			}
   249		} else {
   250			mapping = marker;
   251		}
   252	
   253		event_field = (struct tcg_event_field *)mapping;
   254	
   255		marker = marker + sizeof(event_field->event_size)
   256			+ event_field->event_size;
   257		size = marker - marker_start;
   258	
   259		if ((event->event_type == 0) && (event_field->event_size == 0))
   260			size = 0;
   261	out:
   262		if (do_mapping)
   263			TPM_MEMUNMAP(mapping, mapping_size);
   264		return size;
   265	}
   266	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
