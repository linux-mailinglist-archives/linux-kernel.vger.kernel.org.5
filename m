Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11587F788A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjKXQFK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Nov 2023 11:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjKXQFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:05:07 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3A11B5;
        Fri, 24 Nov 2023 08:05:11 -0800 (PST)
Received: from lhrpeml500003.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ScKZ640DQz684Xd;
        Sat, 25 Nov 2023 00:05:02 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 24 Nov 2023 16:05:08 +0000
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Fri, 24 Nov 2023 16:05:08 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     kernel test robot <lkp@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "david@redhat.com" <david@redhat.com>,
        "Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
        "leo.duran@amd.com" <leo.duran@amd.com>,
        "Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "jiaqiyan@google.com" <jiaqiyan@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
        "erdemaktas@google.com" <erdemaktas@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>
Subject: RE: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Thread-Topic: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Thread-Index: AQHaHjSmCJSxSfmspkqILDwEeyXpzrCJdYKAgAAt7ZA=
Date:   Fri, 24 Nov 2023 16:05:08 +0000
Message-ID: <6629bb080d9d4edea68866860d73fad7@huawei.com>
References: <20231123174355.1176-2-shiju.jose@huawei.com>
 <202311241526.R8n6AibH-lkp@intel.com>
In-Reply-To: <202311241526.R8n6AibH-lkp@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.147.215]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These warnings are fixed. Will add in the next version.

Thanks,
Shiju

>-----Original Message-----
>From: kernel test robot <lkp@intel.com>
>Sent: 24 November 2023 13:20
>To: Shiju Jose <shiju.jose@huawei.com>; linux-cxl@vger.kernel.org; linux-
>mm@kvack.org; dave@stgolabs.net; Jonathan Cameron
><jonathan.cameron@huawei.com>; dave.jiang@intel.com;
>alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com;
>dan.j.williams@intel.com
>Cc: oe-kbuild-all@lists.linux.dev; linux-acpi@vger.kernel.org; linux-
>kernel@vger.kernel.org; david@redhat.com; Vilas.Sridharan@amd.com;
>leo.duran@amd.com; Yazen.Ghannam@amd.com; rientjes@google.com;
>jiaqiyan@google.com; tony.luck@intel.com; Jon.Grimm@amd.com;
>dave.hansen@linux.intel.com; rafael@kernel.org; lenb@kernel.org;
>naoya.horiguchi@nec.com; james.morse@arm.com; jthoughton@google.com;
>somasundaram.a@hpe.com; erdemaktas@google.com; pgonda@google.com;
>duenwen@google.com; mike.malvestuto@intel.com
>Subject: Re: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES
>mailbox command
>
>Hi,
>
>kernel test robot noticed the following build warnings:
>
>[auto build test WARNING on krzk-mem-ctrl/for-next] [also build test WARNING
>on linus/master v6.7-rc2 next-20231124] [If your patch is applied to the wrong
>git tree, kindly drop us a note.
>And when submitting patch, we suggest to use '--base' as documented in
>https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
>url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/cxl-
>mbox-Add-GET_SUPPORTED_FEATURES-mailbox-command/20231124-014622
>base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git
>for-next
>patch link:    https://lore.kernel.org/r/20231123174355.1176-2-
>shiju.jose%40huawei.com
>patch subject: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES
>mailbox command
>config: i386-randconfig-061-20231124 (https://download.01.org/0day-
>ci/archive/20231124/202311241526.R8n6AibH-lkp@intel.com/config)
>compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git
>ae42196bc493ffe877a7e3dff8be32035dea4d07)
>reproduce (this is a W=1 build): (https://download.01.org/0day-
>ci/archive/20231124/202311241526.R8n6AibH-lkp@intel.com/reproduce)
>
>If you fix the issue in a separate patch/commit (i.e. not just a new version of the
>same patch/commit), kindly add following tags
>| Reported-by: kernel test robot <lkp@intel.com>
>| Closes:
>| https://lore.kernel.org/oe-kbuild-all/202311241526.R8n6AibH-lkp@intel.
>| com/
>
>sparse warnings: (new ones prefixed by >>)
>>> drivers/cxl/core/mbox.c:1317:30: sparse: sparse: cast from restricted
>>> __le32
>
>vim +1317 drivers/cxl/core/mbox.c
>
>  1305
>  1306	int cxl_get_supported_features(struct cxl_memdev_state *mds,
>  1307							struct
>cxl_mbox_get_supp_feats_in *pi,
>  1308							void *feats_out)
>  1309	{
>  1310		struct cxl_mbox_cmd mbox_cmd;
>  1311		int rc;
>  1312
>  1313		mbox_cmd = (struct cxl_mbox_cmd) {
>  1314			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
>  1315			.size_in = sizeof(*pi),
>  1316			.payload_in = pi,
>> 1317			.size_out = (size_t)pi->count,
>  1318			.payload_out = feats_out,
>  1319			.min_out = sizeof(struct cxl_mbox_get_supp_feats_out),
>  1320		};
>  1321		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>  1322		if (rc < 0)
>  1323			return rc;
>  1324
>  1325		return 0;
>  1326	}
>  1327	EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
>  1328
>
>--
>0-DAY CI Kernel Test Service
>https://github.com/intel/lkp-tests/wiki
