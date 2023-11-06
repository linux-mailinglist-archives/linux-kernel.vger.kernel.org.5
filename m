Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B84C7E2640
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjKFOEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFOEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:04:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9854F4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699279481; x=1730815481;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OVsazVCtWSEOGXSa1yu72K5Yd9veBlSrMA1W2rzH0tI=;
  b=nei/ZM0s1yDKYth7G1Lw1W3hAHQJfc3pklkCjbW2EHNNblHi5wGl0n8L
   mWgp4i0r2+/kRia/INqrRDyLno205EqcnT9K392HeejaHVqDQFXGkcH9O
   +cK4rfUAw6eqB6CPQs+m8vor6fntdV/8jrAL6csMBqDhzPKC48ixLpRA9
   7g4yoyaZqvtSo256KWdC75hZrKhyRrSiAiyCgwcKPFrwzBAqrxidMvvDp
   TB+0rco7rZ3E5+hyZ+nAJKN0W60Jl50VaM0flmLMBWUqbkjoigwA10C7x
   ORXveUzZnUhxrB9OhsS0Dv0/Od0DK55C0N5hIRsn3DMsTp0FM/Clw6H1T
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="389090000"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="389090000"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 06:04:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="791477424"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="791477424"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 Nov 2023 06:04:39 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r00DU-0006SO-1z;
        Mon, 06 Nov 2023 14:04:36 +0000
Date:   Mon, 6 Nov 2023 22:01:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@chromium.org>
Subject: drivers/target/target_core_transport.c:1079:59: warning: '%s'
 directive output may be truncated writing up to 253 bytes into a region of
 size 221
Message-ID: <202311062106.HacLsl2Y-lkp@intel.com>
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

Hi Christoph,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: 8a39a0478355e9dfdd2f35038d07c4ebe3192441 target: don't depend on SCSI
date:   5 years ago
config: x86_64-randconfig-x083-20230515 (https://download.01.org/0day-ci/archive/20231106/202311062106.HacLsl2Y-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311062106.HacLsl2Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311062106.HacLsl2Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/target/target_core_transport.c: In function 'transport_dump_vpd_ident':
>> drivers/target/target_core_transport.c:1079:59: warning: '%s' directive output may be truncated writing up to 253 bytes into a region of size 221 [-Wformat-truncation=]
    1079 |                         "T10 VPD ASCII Device Identifier: %s\n",
         |                                                           ^~
   drivers/target/target_core_transport.c:1078:17: note: 'snprintf' output between 35 and 288 bytes into a destination of size 254
    1078 |                 snprintf(buf, sizeof(buf),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
    1079 |                         "T10 VPD ASCII Device Identifier: %s\n",
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1080 |                         &vpd->device_identifier[0]);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/target/target_core_transport.c:1084:59: warning: '%s' directive output may be truncated writing up to 253 bytes into a region of size 221 [-Wformat-truncation=]
    1084 |                         "T10 VPD UTF-8 Device Identifier: %s\n",
         |                                                           ^~
   drivers/target/target_core_transport.c:1083:17: note: 'snprintf' output between 35 and 288 bytes into a destination of size 254
    1083 |                 snprintf(buf, sizeof(buf),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
    1084 |                         "T10 VPD UTF-8 Device Identifier: %s\n",
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1085 |                         &vpd->device_identifier[0]);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/target/target_core_transport.c:1074:60: warning: '%s' directive output may be truncated writing up to 253 bytes into a region of size 220 [-Wformat-truncation=]
    1074 |                         "T10 VPD Binary Device Identifier: %s\n",
         |                                                            ^~
   drivers/target/target_core_transport.c:1073:17: note: 'snprintf' output between 36 and 289 bytes into a destination of size 254
    1073 |                 snprintf(buf, sizeof(buf),
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
    1074 |                         "T10 VPD Binary Device Identifier: %s\n",
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1075 |                         &vpd->device_identifier[0]);
         |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/target/target_core_transport.o: warning: objtool: transport_init_session()+0x61: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_alloc_session_tags()+0x80: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: target_read_prot_action()+0x156: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_handle_queue_full()+0x2ac: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_lun_remove_cmd()+0x1e3: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: __transport_check_aborted_status()+0x2e2: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: target_setup_cmd_from_cdb()+0x540: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: target_show_dynamic_sessions()+0xf6: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: target_put_nacl()+0x10b: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_free_session()+0x136: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_init_session_tags()+0x66: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: translate_sense_reason.constprop.0()+0x1aa: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_send_check_condition_and_sense()+0x357: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: __transport_wait_for_tasks()+0x245: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_generic_free_cmd()+0x1a5: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: init_se_kmem_caches()+0x2b: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_dump_vpd_ident_type()+0x144: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: target_cmd_size_check()+0x3f3: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_generic_map_mem_to_cmd()+0x7c: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: target_complete_ok_work()+0xa6e: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_complete_qf()+0x266: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_generic_request_failure()+0x4ae: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: target_write_prot_action()+0x156: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_handle_cdb_direct()+0x39: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: target_submit_cmd_map_sgls()+0x3af: sibling call from callable instruction with modified stack frame
   drivers/target/target_core_transport.o: warning: objtool: transport_send_task_abort()+0x2a7: sibling call from callable instruction with modified stack frame


vim +1079 drivers/target/target_core_transport.c

c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1060  
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1061  int transport_dump_vpd_ident(
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1062  	struct t10_vpd *vpd,
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1063  	unsigned char *p_buf,
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1064  	int p_buf_len)
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1065  {
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1066  	unsigned char buf[VPD_TMP_BUF_SIZE];
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1067  	int ret = 0;
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1068  
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1069  	memset(buf, 0, VPD_TMP_BUF_SIZE);
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1070  
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1071  	switch (vpd->device_identifier_code_set) {
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1072  	case 0x01: /* Binary */
703d641d870346 Dan Carpenter      2013-01-18  1073  		snprintf(buf, sizeof(buf),
703d641d870346 Dan Carpenter      2013-01-18  1074  			"T10 VPD Binary Device Identifier: %s\n",
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1075  			&vpd->device_identifier[0]);
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1076  		break;
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1077  	case 0x02: /* ASCII */
703d641d870346 Dan Carpenter      2013-01-18  1078  		snprintf(buf, sizeof(buf),
703d641d870346 Dan Carpenter      2013-01-18 @1079  			"T10 VPD ASCII Device Identifier: %s\n",
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1080  			&vpd->device_identifier[0]);
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1081  		break;
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1082  	case 0x03: /* UTF-8 */
703d641d870346 Dan Carpenter      2013-01-18  1083  		snprintf(buf, sizeof(buf),
703d641d870346 Dan Carpenter      2013-01-18  1084  			"T10 VPD UTF-8 Device Identifier: %s\n",
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1085  			&vpd->device_identifier[0]);
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1086  		break;
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1087  	default:
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1088  		sprintf(buf, "T10 VPD Device Identifier encoding unsupported:"
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1089  			" 0x%02x", vpd->device_identifier_code_set);
e3d6f909ed803d Andy Grover        2011-07-19  1090  		ret = -EINVAL;
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1091  		break;
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1092  	}
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1093  
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1094  	if (p_buf)
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1095  		strncpy(p_buf, buf, p_buf_len);
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1096  	else
6708bb27bb2703 Andy Grover        2011-06-08  1097  		pr_debug("%s", buf);
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1098  
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1099  	return ret;
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1100  }
c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1101  

:::::: The code at line 1079 was first introduced by commit
:::::: 703d641d87034629f8b0da94334034ed5d805b36 target: change sprintf to snprintf in transport_dump_vpd_ident

:::::: TO: Dan Carpenter <dan.carpenter@oracle.com>
:::::: CC: Nicholas Bellinger <nab@linux-iscsi.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
