Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C519476F448
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjHCUxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjHCUxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:53:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F753272E;
        Thu,  3 Aug 2023 13:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691095979; x=1722631979;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zED3kdg3ZRxf/2pJOvBBe7+N26q1v5zZu+U8ltvXaeI=;
  b=Uro7/8DxWtxJdVOf6pQyOHCveYzdlCwGYp6ltyuhXyIqGnDloAtOFAlL
   8fMNfi9B+OzuEfuVRhzVtodds+lwtV6/pnOLby78bGZ10CcrRQLTErrSl
   rgxSIO77MM0o1q05Ukp8x2PuKzblnGpLkj7b4wkz+JYwmfsuEKodQPB8+
   A/eb7enT9ZktpvbvDy8xG72oLRUynK5OhagrrQ+QyC7Es0kkSz6874n48
   Ug1yP3n+x5FIyTohGXiKaJ0R9Zyw/tOtN2R1fR90DyZleRaN5knFU3E9l
   3DwuJIJamTDrEa+SZ6IP7hPvP+nvrsS/qo7MP2oP82yNId8znPZB+uppS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="400953041"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="400953041"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 13:52:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="1060446752"
X-IronPort-AV: E=Sophos;i="6.01,253,1684825200"; 
   d="scan'208";a="1060446752"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2023 13:52:49 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRfJQ-0002Lb-1Z;
        Thu, 03 Aug 2023 20:52:48 +0000
Date:   Fri, 4 Aug 2023 04:52:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-doc@vger.kernel.org
Subject: arch/powerpc/platforms/pseries/plpks.c:186: warning: This comment
 starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202308040430.GxmPAnwZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7bafbd4027ae86572f308c4ddf93120c90126332
commit: 2454a7af0f2a42918aa972147a0bec38e6656cd8 powerpc/pseries: define driver for Platform KeyStore
date:   1 year ago
config: powerpc-ppc64_defconfig (https://download.01.org/0day-ci/archive/20230804/202308040430.GxmPAnwZ-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230804/202308040430.GxmPAnwZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308040430.GxmPAnwZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/platforms/pseries/plpks.c:186: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Label is combination of label attributes + name.


vim +186 arch/powerpc/platforms/pseries/plpks.c

   184	
   185	/**
 > 186	 * Label is combination of label attributes + name.
   187	 * Label attributes are used internally by kernel and not exposed to the user.
   188	 */
   189	static struct label *construct_label(char *component, u8 varos, u8 *name,
   190					     u16 namelen)
   191	{
   192		struct label *label;
   193		size_t slen;
   194	
   195		if (!name || namelen > MAX_NAME_SIZE)
   196			return ERR_PTR(-EINVAL);
   197	
   198		slen = strlen(component);
   199		if (component && slen > sizeof(label->attr.prefix))
   200			return ERR_PTR(-EINVAL);
   201	
   202		label = kzalloc(sizeof(*label), GFP_KERNEL);
   203		if (!label)
   204			return ERR_PTR(-ENOMEM);
   205	
   206		if (component)
   207			memcpy(&label->attr.prefix, component, slen);
   208	
   209		label->attr.version = LABEL_VERSION;
   210		label->attr.os = varos;
   211		label->attr.length = MAX_LABEL_ATTR_SIZE;
   212		memcpy(&label->name, name, namelen);
   213	
   214		label->size = sizeof(struct label_attr) + namelen;
   215	
   216		return label;
   217	}
   218	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
