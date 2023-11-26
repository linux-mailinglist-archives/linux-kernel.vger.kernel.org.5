Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9417F9395
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 16:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjKZPxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 10:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjKZPxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 10:53:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59825107
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 07:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701014004; x=1732550004;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J4qv2ql+1zzHn5Z8Y2+SZJzeh9F0L09fi8OrDASwhYE=;
  b=cN/VVlInf1tx6Ru26sA4byBF+xW9vjsK/Qq/e3hMkW7GFQUU9ZASIAlt
   y+CNRRoOm/aJl2E1XZ+wDZ4gi55MsTQ6ATL5cKgf7aqfRUyUsg7bRz7kp
   q0qcJiOC/OjM+WFFyXFpAJJ2Jf/dyjZD2B2Oh1/f9QGIUoVKpOGq3hyyy
   +oF0wVlrqZdpzzkmb2uHO4NA2sZa6VzGrDVngaPPgeOfiVwMCQp5coGSk
   hx5l1oz1B2hR7xMAsNH5IFw2f/decFgIwa7m+jtZB/bZoZd0uct7thJxq
   BzqW9FnVP3dixHRNOkKO7byCIYDTfhFJ0g3qm3Takuw1GakXcbmo2+2Lc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="5827499"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="5827499"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 07:53:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="1099540712"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="1099540712"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2023 07:53:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 26 Nov 2023 07:53:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 26 Nov 2023 07:53:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 26 Nov 2023 07:53:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkqcMmNF/2CU2JuCPVwqZRyaFYDp8fc3xCDwFtnqM2uLN3ifXuGcWhYLhWRbE42+2LkvkuZNBO4kjwOoD8zY+jrjMYeqOBWg8JKwT2PuoVj0XowgfrekCl8N5J4wHIRNY2dqotKbSBQYuLrcwQ7FnMxFcOVCLji86gUFHSvsSHzeMoLSs0BU5xZd/k/s4IVV8xezPUZZ/tFD7gHR/vl+AFoRbW4woccY4Ivlx4Nyw0P8sVxijRh0JtDAweHgePMR4DTfAKZHEb6BU4UZtdy3Hj6ZKoympC7dwa3HSPBGnAEmyzI0GPmmhZ+5vtID/Qyf0cv896SqLfr4uB6E8gJrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I86oGh+0qAUANhGk4BFEf0K3BEDAkbkWiGfIUlpba5Q=;
 b=DrxXHNIi1vGuVmxWtJG10f4PmlRLmdeZscNpyifLvIcKflrHb8rRMKVoJSfiB1e+iNTPJ2iPbo4MCbi3HPbAc8eMYViJsu802dK92eiEQFMx1RkZMQmSJ/3xmGZKDhywz+uewCZASj2pEa3jDGmuMwz1Zc4UMN5PpGXYVDos75bGJ6LFsMYBmUr125p0SiUMKXhPCbpXZRLqfXvttDyHPsJrn36c0uI9kazScVdELHN5fKpbQ/p+NZzqAi9sVLrhCjEK23pLeF7RxopPhtLGJ44wORkbhN5rTTxIp2fP96muoquovpvcBk3pqiKPJvmPhcdbromXwJhI7Woeo16QwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 15:53:13 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 15:53:13 +0000
Date:   Sun, 26 Nov 2023 23:48:37 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Kiran Gunda <kgunda@codeaurora.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Stephen Boyd" <sboyd@codeaurora.org>
Subject: drivers/spmi/spmi-pmic-arb.c:215: warning: No description found for
 parameter 'pmic_arb'
Message-ID: <202311260405.YL0cVHtZ-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CO1PR11MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bccb17-28f5-4d78-7af0-08dbee97cb7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FtpWjfH5oTU5JNH5EKYVaFdz26z99lU/DkeP509feopl9QGgnfvezZKi+nTj2ibRxMdj8MoVW1w3oDWWA3jhaAFx8xWKhD6faWlw8IUQax5uDZtA8jEDICW/okf0k32ibD/r5uDf2DsCsRXOr3185Z/mOJJdRU1MkC7qrOZq36lP2gDh7a8Wzu8owsKHpnmHvObkrXP0qjjpPmy8jKjiA9OooN6B4BvT4aZ6d2sDRtjRNnjqK6T3YIp+PRj3vRLvJoeaca+RiRpf7cKWOtQl8YNM47ustA3+xMWq9nPq48OlZyc07gz9hwYpfaZXC4O1BD5Y4pOLTK7yeVpTeFXxaMGoij30cVtIU6NUEUvKTpHUEuaII967it2fF926Dgrakv1qPJxlwGLT5yeZN4Ne2IadcKzWtk1IVwaR0G+rC2OM0/A93EjLFNn2JIWsKIV5vhQ3Saerw5yYM+S86u5axpl3PdI4aMBOpV5Jla6o9q5T5CH2ZvkRWFkO/Hb6t63Wb6IfKXUpWq44lmJEmu+1qWAjkRxoBsMo5KH4M+jfO5Iz7HGDajpSaDIW8Fwx4uJ6qF4jxxuBGz9bvnmIq1dol+LQ7Q8LgseW12kugjblDQAYsRtbkS/Oqc+NG/Gx9LdLIkonhxMH4aUk5SMyPGK10tIln0QkO+A7JDL9WV5eFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6666004)(8676002)(8936002)(4326008)(6512007)(6506007)(6916009)(316002)(66556008)(66946007)(966005)(6486002)(478600001)(2906002)(36756003)(38100700002)(41300700001)(1076003)(86362001)(26005)(66476007)(2616005)(83380400001)(82960400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1SxO4wEfq+gmkI/4bDAn6E0mDQQ1jB6rsXDNzOOCQRJtgonQtBrVJUQgFy7?=
 =?us-ascii?Q?qGRKl6Cfos10GEVOBFMlrD8/6mCAXdbFFzrn/11M2Lnc5zdYUJ2meeLf1TIn?=
 =?us-ascii?Q?dDcQyliF6dQ3j/JKSzbwohKF8NBZh8mCrWsPUj6HZn6b72hmpTLLJjVWhmAs?=
 =?us-ascii?Q?3aTDJ9g3MUAWMwRZ0x61yNDBJCIRttWomBoobptS/e4ZOgfr9yf7qLcVockp?=
 =?us-ascii?Q?0zzeyRoxnELrsfQ+z5BRvjhKxDqwXlcqQQ+hzMIRKMOCd7MlF0O8VMYtGO+/?=
 =?us-ascii?Q?qmlTJSOTlOSsJYgT+hv5oADEk9daUgrqiPty594LR7etfuXPAYuYVuMIA7n/?=
 =?us-ascii?Q?tudASCHLzMghUQHkXVd+ZOC0U+CBjJQh+t8azg98IiQE6lIh3gON9wDLP6Dn?=
 =?us-ascii?Q?PccxIVxzJ3XJ1qQ8WzkTgrmmGiHqqATh5Jzf/UduS6NeH1QZen+abKhZ4oR8?=
 =?us-ascii?Q?/A7d+3TkdtqLPfQtTyo1o1Ju/SAaHvr4kIfX/MLZkLvK7XRIavTVyJnWZqOL?=
 =?us-ascii?Q?BOXD5YISr56KuTcqjnvW0nUJTR67pLWuDlH4e3+XcOEMRczdKrf/fRImBUpx?=
 =?us-ascii?Q?mySLz0N7WOcVwpp7OkT2Nen8mOjM2nNC/BNZIDIqqGGdWTiw2L3ZLC1gDGlA?=
 =?us-ascii?Q?YwdHplWPkeSSFmQi/NfcrVO1mxyLY8lzs9XhNyewdZfPjYguGP2dsmmxyjcs?=
 =?us-ascii?Q?3T6kolxXrCQS94WBFkiv8+jMGU5U6Pj+Ey4V/Rj55Or1FMvE+jhygmAEe2ID?=
 =?us-ascii?Q?yTjUr0jfJfOsmEwVh7b7BG0X3Q88gC72638X/XpIa75ZT7HZyox51JAhcjsK?=
 =?us-ascii?Q?yitLbur2KA8gqM78qh5w3dVMuYuUwiGgIAPGrzXEBmRVpB33kSEcVW0/sMFX?=
 =?us-ascii?Q?cJL+pRmK8tAAdbOOKGOBKqFmUOTyzCb950XslFk2V+HDPdIDh2eco+NMxRuW?=
 =?us-ascii?Q?1IdJNwuLc984kCO+WstH7eMGkDX6jQ+KyU8W/HAFYI9VMzr8O35VPSgGeVei?=
 =?us-ascii?Q?6ADRUarLmVvKr+OCmPYzvnluw1wJVRqztl/x/MI8GgvnAV4PRaCLaUOJHTqM?=
 =?us-ascii?Q?4y8bfUX/ODaxuJ1nmgD1y4u5pPg0YCWv2y+fKSmsRyFHB/En5J6PLEJn3F3B?=
 =?us-ascii?Q?T6l7fN1oQFa6hKvuaO66J4+6/UDdZ/O2zf5ccRwjrdg2N10U0c5daQKjdebL?=
 =?us-ascii?Q?atxVfPHKAjfNPZGAv97SSV1hL5OjYpq8DOVRv5VsIQyJQH422X6VMpEdpMKI?=
 =?us-ascii?Q?bQ3RwaeBdy9WOkdjSwRNCyZiKZ0T3bt4i8wJjyOrw9JQseIYVdzffRmJPdpx?=
 =?us-ascii?Q?cLaU3+Ks3L9zpUWMPlvsqxqLuqgQSlsao+sQuzHfXC29pPEdgnVo0axPhgic?=
 =?us-ascii?Q?y1H2E9kzTB/GFhmqRH9cdkFjI6kPSPX91qdM97s9yVTPO2hP3AY+vOkOuABn?=
 =?us-ascii?Q?Zr8OcK6woMQunbDnudHIY0p2INtQj1D83gbd3r2lz9eoXgrrLpnLfBbgKCiL?=
 =?us-ascii?Q?jTM2qgF7LHWtwrgnfO6SdJEocjlb1ZxfAfiIL3il1ZafVU7rMkJeo4ndY7p1?=
 =?us-ascii?Q?Jim8o6qJE5vt3wgCMUUWkWNmuyeXlUcd6R0y/xxm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bccb17-28f5-4d78-7af0-08dbee97cb7b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 15:53:13.2225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18MxxAge4NHLBogf2MBvTwrz19Nu2EZLeI1s5ScMu7gDhgHDVXr1gp4jY2Yq8jvgO+TgJxRq3BEK/setbXx6Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5042
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kiran,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0f5cc96c367f2e780eb492cc9cab84e3b2ca88da
commit: 02abec3616c1b2027efc7e08abf7fc0d2436a837 spmi: pmic-arb: rename pa_xx to pmic_arb_xx and other cleanup
config: arm-randconfig-001-20231123 (https://download.01.org/0day-ci/archive/20231126/202311260405.YL0cVHtZ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231126/202311260405.YL0cVHtZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311260405.YL0cVHtZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/spmi/spmi-pmic-arb.c: In function 'pmic_arb_write_cmd':
   drivers/spmi/spmi-pmic-arb.c:399:15: warning: comparison is always true due to limited range of data type [-Wtype-limits]
     else if (opc >= 0x00 && opc <= 0x0F)
                  ^~
   drivers/spmi/spmi-pmic-arb.c:137: warning: cannot understand function prototype: 'struct spmi_pmic_arb '
   drivers/spmi/spmi-pmic-arb.c:179: warning: cannot understand function prototype: 'struct pmic_arb_ver_ops '
>> drivers/spmi/spmi-pmic-arb.c:215: warning: No description found for parameter 'pmic_arb'
   drivers/spmi/spmi-pmic-arb.c:229: warning: No description found for parameter 'pmic_arb'


vim +/pmic_arb +215 drivers/spmi/spmi-pmic-arb.c

39ae93e3a31d0c Kenneth Heitke         2014-02-12  206  
39ae93e3a31d0c Kenneth Heitke         2014-02-12  207  /**
02abec3616c1b2 Kiran Gunda            2017-07-28  208   * pmic_arb_read_data: reads pmic-arb's register and copy 1..4 bytes to buf
39ae93e3a31d0c Kenneth Heitke         2014-02-12  209   * @bc:		byte count -1. range: 0..3
39ae93e3a31d0c Kenneth Heitke         2014-02-12  210   * @reg:	register's address
39ae93e3a31d0c Kenneth Heitke         2014-02-12  211   * @buf:	output parameter, length must be bc + 1
39ae93e3a31d0c Kenneth Heitke         2014-02-12  212   */
02abec3616c1b2 Kiran Gunda            2017-07-28  213  static void
02abec3616c1b2 Kiran Gunda            2017-07-28  214  pmic_arb_read_data(struct spmi_pmic_arb *pmic_arb, u8 *buf, u32 reg, u8 bc)
39ae93e3a31d0c Kenneth Heitke         2014-02-12 @215  {
02abec3616c1b2 Kiran Gunda            2017-07-28  216  	u32 data = __raw_readl(pmic_arb->rd_base + reg);
111a10bf3e53ae Abhijeet Dharmapurikar 2017-05-10  217  
39ae93e3a31d0c Kenneth Heitke         2014-02-12  218  	memcpy(buf, &data, (bc & 3) + 1);
39ae93e3a31d0c Kenneth Heitke         2014-02-12  219  }
39ae93e3a31d0c Kenneth Heitke         2014-02-12  220  

:::::: The code at line 215 was first introduced by commit
:::::: 39ae93e3a31d0c9ca99e35b754a9f3c6f1db2bee spmi: Add MSM PMIC Arbiter SPMI controller

:::::: TO: Kenneth Heitke <kheitke@codeaurora.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

