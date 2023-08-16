Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620EF77E605
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344504AbjHPQHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344499AbjHPQHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:07:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76C0E2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692202028; x=1723738028;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dtauJxF42n5sz43g96oPp3RrMjqvOAVmX/L5aAG0kg0=;
  b=aqVi+4ZVOrCIaQSLuOML1JNh3WLWfUDDSgvaxjJd4EDr1D5qqAS9839p
   m6f9i40tFr6NzRJqKhfxPJsxX6HWhTNZrzRQoUloSsRaem+TSx16RYNEc
   yMnCyh1xm1PqiPyS1Hgqgs+kZbDHOHvwkqL6RT7lsGAJ2AIq6nubr7Zom
   YDr43YCLf42m9LB1XZpYPY24zz6h50N4Dq2rOrhJjkoFTMrKc6cPSISQP
   yEnu6Ir4hSonamRM4XJC03VIxQPduAVuatnkcrreOPtbXD1p/NCYeM9VT
   2gmiTUgyu6g6PLauD57Wq3j8oXLXlzWQByDyGr03bjQ5SBFvIcXXLH9cz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362722702"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="362722702"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 09:05:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="804282478"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="804282478"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2023 09:05:03 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWJ14-0000QH-33;
        Wed, 16 Aug 2023 16:05:02 +0000
Date:   Thu, 17 Aug 2023 00:04:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Subject: kernel/trace/bpf_trace.c:1216:17: warning: no previous declaration
 for 'bpf_lookup_user_key'
Message-ID: <202308162316.PIY9owc8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
commit: f3cf4134c5c6c47b9b5c7aa3cb2d67e107887a7b bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
date:   11 months ago
config: x86_64-randconfig-x012-20230816 (https://download.01.org/0day-ci/archive/20230816/202308162316.PIY9owc8-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce: (https://download.01.org/0day-ci/archive/20230816/202308162316.PIY9owc8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308162316.PIY9owc8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/trace/bpf_trace.c:1216:17: warning: no previous declaration for 'bpf_lookup_user_key' [-Wmissing-declarations]
    struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
                    ^~~~~~~~~~~~~~~~~~~
>> kernel/trace/bpf_trace.c:1265:17: warning: no previous declaration for 'bpf_lookup_system_key' [-Wmissing-declarations]
    struct bpf_key *bpf_lookup_system_key(u64 id)
                    ^~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/bpf_trace.c:1289:6: warning: no previous declaration for 'bpf_key_put' [-Wmissing-declarations]
    void bpf_key_put(struct bpf_key *bkey)
         ^~~~~~~~~~~


vim +/bpf_lookup_user_key +1216 kernel/trace/bpf_trace.c

  1185	
  1186	#ifdef CONFIG_KEYS
  1187	__diag_push();
  1188	__diag_ignore_all("-Wmissing-prototypes",
  1189			  "kfuncs which will be used in BPF programs");
  1190	
  1191	/**
  1192	 * bpf_lookup_user_key - lookup a key by its serial
  1193	 * @serial: key handle serial number
  1194	 * @flags: lookup-specific flags
  1195	 *
  1196	 * Search a key with a given *serial* and the provided *flags*.
  1197	 * If found, increment the reference count of the key by one, and
  1198	 * return it in the bpf_key structure.
  1199	 *
  1200	 * The bpf_key structure must be passed to bpf_key_put() when done
  1201	 * with it, so that the key reference count is decremented and the
  1202	 * bpf_key structure is freed.
  1203	 *
  1204	 * Permission checks are deferred to the time the key is used by
  1205	 * one of the available key-specific kfuncs.
  1206	 *
  1207	 * Set *flags* with KEY_LOOKUP_CREATE, to attempt creating a requested
  1208	 * special keyring (e.g. session keyring), if it doesn't yet exist.
  1209	 * Set *flags* with KEY_LOOKUP_PARTIAL, to lookup a key without waiting
  1210	 * for the key construction, and to retrieve uninstantiated keys (keys
  1211	 * without data attached to them).
  1212	 *
  1213	 * Return: a bpf_key pointer with a valid key pointer if the key is found, a
  1214	 *         NULL pointer otherwise.
  1215	 */
> 1216	struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
  1217	{
  1218		key_ref_t key_ref;
  1219		struct bpf_key *bkey;
  1220	
  1221		if (flags & ~KEY_LOOKUP_ALL)
  1222			return NULL;
  1223	
  1224		/*
  1225		 * Permission check is deferred until the key is used, as the
  1226		 * intent of the caller is unknown here.
  1227		 */
  1228		key_ref = lookup_user_key(serial, flags, KEY_DEFER_PERM_CHECK);
  1229		if (IS_ERR(key_ref))
  1230			return NULL;
  1231	
  1232		bkey = kmalloc(sizeof(*bkey), GFP_KERNEL);
  1233		if (!bkey) {
  1234			key_put(key_ref_to_ptr(key_ref));
  1235			return NULL;
  1236		}
  1237	
  1238		bkey->key = key_ref_to_ptr(key_ref);
  1239		bkey->has_ref = true;
  1240	
  1241		return bkey;
  1242	}
  1243	
  1244	/**
  1245	 * bpf_lookup_system_key - lookup a key by a system-defined ID
  1246	 * @id: key ID
  1247	 *
  1248	 * Obtain a bpf_key structure with a key pointer set to the passed key ID.
  1249	 * The key pointer is marked as invalid, to prevent bpf_key_put() from
  1250	 * attempting to decrement the key reference count on that pointer. The key
  1251	 * pointer set in such way is currently understood only by
  1252	 * verify_pkcs7_signature().
  1253	 *
  1254	 * Set *id* to one of the values defined in include/linux/verification.h:
  1255	 * 0 for the primary keyring (immutable keyring of system keys);
  1256	 * VERIFY_USE_SECONDARY_KEYRING for both the primary and secondary keyring
  1257	 * (where keys can be added only if they are vouched for by existing keys
  1258	 * in those keyrings); VERIFY_USE_PLATFORM_KEYRING for the platform
  1259	 * keyring (primarily used by the integrity subsystem to verify a kexec'ed
  1260	 * kerned image and, possibly, the initramfs signature).
  1261	 *
  1262	 * Return: a bpf_key pointer with an invalid key pointer set from the
  1263	 *         pre-determined ID on success, a NULL pointer otherwise
  1264	 */
> 1265	struct bpf_key *bpf_lookup_system_key(u64 id)
  1266	{
  1267		struct bpf_key *bkey;
  1268	
  1269		if (system_keyring_id_check(id) < 0)
  1270			return NULL;
  1271	
  1272		bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
  1273		if (!bkey)
  1274			return NULL;
  1275	
  1276		bkey->key = (struct key *)(unsigned long)id;
  1277		bkey->has_ref = false;
  1278	
  1279		return bkey;
  1280	}
  1281	
  1282	/**
  1283	 * bpf_key_put - decrement key reference count if key is valid and free bpf_key
  1284	 * @bkey: bpf_key structure
  1285	 *
  1286	 * Decrement the reference count of the key inside *bkey*, if the pointer
  1287	 * is valid, and free *bkey*.
  1288	 */
> 1289	void bpf_key_put(struct bpf_key *bkey)
  1290	{
  1291		if (bkey->has_ref)
  1292			key_put(bkey->key);
  1293	
  1294		kfree(bkey);
  1295	}
  1296	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
