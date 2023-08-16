Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19D77E90F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345650AbjHPSvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345581AbjHPSux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:50:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143B026A8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 11:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692211852; x=1723747852;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BJnGWMTUIRj7VZgxLzvKiEU/GU1/R6JKhRF2Bw2VdeA=;
  b=oDAbt82V9GVbM9iwQrNMkg6pdd25lE8Cq4ELKKGxfDyV9oNYzvOjMUwi
   F+gS+hQ1NtnvX7eLLjo+Zcs4cRnELLogZoyccd+6NVjh/UMTBDGsaUFDm
   j8qZ3d+ErnGBQ87AIxPAX09V0vfJRnhAlgjv2y63be76CZYbGhxVPqN+B
   n4lpFG4RDgOuG/yQL+ZSHDZ/M/Y7RgX9mfZ9KiivR64B/sEfTkE4n8Rap
   mFuu/lGdGj8Hdl7e6/ILuEhEBz/KqAhYMoJuWhKu+QV+UcBSuFabAIV3M
   wr6x0kqQ9v0tc41hS6IC9Sp0lnBq2X5BL8svZoHmrSGs63uN8xZ319eaF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371516874"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="371516874"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 11:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711221390"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="711221390"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Aug 2023 11:50:49 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWLbV-0000VF-0i;
        Wed, 16 Aug 2023 18:50:49 +0000
Date:   Thu, 17 Aug 2023 02:50:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/trace/bpf_trace.c:1309:5: warning: no previous declaration
 for 'bpf_verify_pkcs7_signature'
Message-ID: <202308170254.vZfr8Zuo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: 865b0566d8f1a0c3937e5eb4bd6ba4ef03e7e98c bpf: Add bpf_verify_pkcs7_signature() kfunc
date:   11 months ago
config: x86_64-randconfig-x012-20230816 (https://download.01.org/0day-ci/archive/20230817/202308170254.vZfr8Zuo-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308170254.vZfr8Zuo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308170254.vZfr8Zuo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/trace/bpf_trace.c:1216:17: warning: no previous declaration for 'bpf_lookup_user_key' [-Wmissing-declarations]
    struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
                    ^~~~~~~~~~~~~~~~~~~
   kernel/trace/bpf_trace.c:1265:17: warning: no previous declaration for 'bpf_lookup_system_key' [-Wmissing-declarations]
    struct bpf_key *bpf_lookup_system_key(u64 id)
                    ^~~~~~~~~~~~~~~~~~~~~
   kernel/trace/bpf_trace.c:1289:6: warning: no previous declaration for 'bpf_key_put' [-Wmissing-declarations]
    void bpf_key_put(struct bpf_key *bkey)
         ^~~~~~~~~~~
>> kernel/trace/bpf_trace.c:1309:5: warning: no previous declaration for 'bpf_verify_pkcs7_signature' [-Wmissing-declarations]
    int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bpf_verify_pkcs7_signature +1309 kernel/trace/bpf_trace.c

  1296	
  1297	#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
  1298	/**
  1299	 * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
  1300	 * @data_ptr: data to verify
  1301	 * @sig_ptr: signature of the data
  1302	 * @trusted_keyring: keyring with keys trusted for signature verification
  1303	 *
  1304	 * Verify the PKCS#7 signature *sig_ptr* against the supplied *data_ptr*
  1305	 * with keys in a keyring referenced by *trusted_keyring*.
  1306	 *
  1307	 * Return: 0 on success, a negative value on error.
  1308	 */
> 1309	int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
  1310				       struct bpf_dynptr_kern *sig_ptr,
  1311				       struct bpf_key *trusted_keyring)
  1312	{
  1313		int ret;
  1314	
  1315		if (trusted_keyring->has_ref) {
  1316			/*
  1317			 * Do the permission check deferred in bpf_lookup_user_key().
  1318			 * See bpf_lookup_user_key() for more details.
  1319			 *
  1320			 * A call to key_task_permission() here would be redundant, as
  1321			 * it is already done by keyring_search() called by
  1322			 * find_asymmetric_key().
  1323			 */
  1324			ret = key_validate(trusted_keyring->key);
  1325			if (ret < 0)
  1326				return ret;
  1327		}
  1328	
  1329		return verify_pkcs7_signature(data_ptr->data,
  1330					      bpf_dynptr_get_size(data_ptr),
  1331					      sig_ptr->data,
  1332					      bpf_dynptr_get_size(sig_ptr),
  1333					      trusted_keyring->key,
  1334					      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
  1335					      NULL);
  1336	}
  1337	#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
  1338	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
