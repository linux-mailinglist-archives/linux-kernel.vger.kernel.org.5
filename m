Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BEF7E1A26
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjKFGSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjKFGSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:18:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD4BB8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 22:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699251497; x=1730787497;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jwLrjPJM8W4EgWXVhJEDJ381+U00fzbVSM4E3ev4aA8=;
  b=GusTfXZjDLzxrtyoPWpEqVtTmiyPNaP6ameFwTTkJ9harTUPBnQoMcP6
   X8Q7al3osF5uAlAgRA+aqxS/nuH3bGjCANNmR9UWyLEve9nnHlUphLkmn
   hX40v1EIszMHiOi9zWfPtRZtLHkcSb0353WIL6P4iKjYmTQPJLMEtFg/v
   S4KH5dJU2sN2AQf+Xovom79nJtx7Dgg9xjt9k0DW9Ph/5QV8wxTBpLrJq
   JJi5kokcLU/XHFa8V5LM618BH7xuK0218c3zfxJFwK39bpS1p6+qx7XXu
   gayOgaNW0+con1zPhu8uYTZlVcb673VRnth+LsfShO25nwgzSMHkNurOp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="374245399"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="374245399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 22:18:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="791376095"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="791376095"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2023 22:18:08 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 22:18:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 22:18:07 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 5 Nov 2023 22:18:07 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 5 Nov 2023 22:18:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG98vhS8IKweJlGi/Lpw3pCmOuJuKYQAUf7+XHUuSReBvL8LUyNuhWNA/XTOtvixp0tsIcnY3a8C8iZBcAbhRx9p5heJ6FCVm54iETdoWqhRJNCmcbgfk098CF1XM4JBUFHvB3UrbO+Uhxbn2dQxWVU3c43RD2m+S9w+OBzEambQo9u/FJdFQMl+rSK/8YYBK4f7Xc2Yx8l4JGWogq+nymPd4ET9gVblCSLwAqfdK3AE4/nQ8nqAC2JYMWZi+Z6sRqMlrUCJXGMognWbHXjDWcqSIS6o2rxS+BDGCCSspooQZyYhFB2u55IZof0o8/kSpZFpAbasPzF4E4/9GGFwyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VVisqA0u1g+kP/cEAir2IOimTL9Y9nZb/a4p/yGIGQ=;
 b=cmUmtewlGDiedHc6x58QUdrjiOvtD7Spe8Zlm2fWJoe3Zs/LOguT8J7TW7Z4N1vKFAOUALCpLcD5qc5NucQn1upZCWEfCWlB9GRm9dMAZS8ycxbaXCiCMBQZmQLibK6zfONUMcTDeY7E7EddHr/DfWF9bsjm2gxsV/UVptdyu93Z4KrmW0HKEhCPY/HmpnAE/MC+3EC5Acr0jNTNZ/jB1hCYtIuksLC/k2A99m5HDQ7jvFjsJgLV2/Pfs0DSUD2ETip2AHMg4+jpblVMwtBSJ/GVOTFeVrgSBT7l1zFf5GT68nfuyCZIKyXkqRiqFNITEx1XAphNdVlR48Z98pmObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MN2PR11MB4520.namprd11.prod.outlook.com (2603:10b6:208:265::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 06:18:00 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Mon, 6 Nov 2023
 06:18:00 +0000
Date:   Mon, 6 Nov 2023 14:13:17 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Sean Anderson <sean.anderson@seco.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: drivers/tty/serial/uartlite.c:79: warning: Function parameter or
 member 'reg_ops' not described in 'uartlite_data'
Message-ID: <202311061059.NUeUar9b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MN2PR11MB4520:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a15e8ce-ff22-45ce-7e4d-08dbde902046
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYJH1NoI/KvkpbgxotZ9ERX3khZw47Y0HE3qiQ91fsG3eEgpWMlXgFcd9fvAXRSBSs2pMSuJSHXWtc5xMoDZRIjURB6mMEaRgeBrqYy15vrFSLu1u5fD9dT3ZNrVW44qHbZ+LOGItRpXayzL41EG1E/bdn4w5aU4m5T019LdpvFyVCQ5C8HDBOXdwZfcfC84ks8ZPvKq0f3tdQWcsUNvU6+Lo4RuV1zCwKwi0OrdiNOv1y49gQuwThmbfiWnoOdhiizEFal1aENRSU3DWRJCmy6R434SiSSbZ5WhgWzP6IkbfG34uEjtIOvVgK9OU/Hnt4AGm+yVjLOk8qj+xFRiE/MedrVbp84XGfFuCWG2cQ5e/vHC4zC9XNCOvG9GOfLdcX9aVhNHyYdaxtqcCB6pWELf4WlIBS64TuS6R7DkKa67ukyvZuCxHszxbug4LJX28fIkyEXUtx89ybhXxshJopFlxWK73186TXgz9/NLKFMh+9SYxjXzuJjsPtMeqMGwOMBo6nHJODUUmD5CwhfnyLi2rOyP1XlwzIrbx9ur4zaOxB9PsRhNN/b3EblTkpziWjUNrMfdJKepJXO9uVAS9udYXNXgv3MQPW0I52WF/2PaQ5gTg5DNE09bc87ZHwqk1OlXE29HKHsOn0w0LGS5yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799009)(6506007)(478600001)(2616005)(6512007)(6666004)(966005)(6486002)(36756003)(38100700002)(82960400001)(86362001)(66946007)(5660300002)(66476007)(316002)(66556008)(41300700001)(83380400001)(2906002)(26005)(1076003)(8676002)(4326008)(6916009)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KBTSJ8n7YTj9unyPlzdZbvDm4M9RZ+9UwV4soGjggLfMqE6qGK/xgU2AfmCy?=
 =?us-ascii?Q?cxEXcz+5Hv0fJ6GrA2eJFhRc+0i5qcSoRky9V688+2rYajdU9DlFKiRQhJJQ?=
 =?us-ascii?Q?t2u8BShOU0An/HiOFv16PI2h00PzDCLBNZVuM6H8+FzfO+VN9NfpXfjkhjLp?=
 =?us-ascii?Q?5IomaJTlqNeKIw8J5xjAbX8GYZdm6ESWz99tyvDGNWOLtCyd3Cf8N0WGRxaW?=
 =?us-ascii?Q?7PN/X4m/RLTWOLkYiBFYWgoFhkBrCWdtH6JGQL2/uv6OLGKk4zKiHffQCon5?=
 =?us-ascii?Q?5VL8LE4gw0s57G5XIRGu+IXiLfu5ysjNhOC6OZRUY372kcOsZcoblDwD2iFV?=
 =?us-ascii?Q?kxfZWU2swhngEeCp/05d0KWsrEDzYfRBAplYqiHNNgWeDdusZDkTaVNUBiPr?=
 =?us-ascii?Q?s9ov33oE2SRE35ZZgJXjh2Rz/FGL8BrpKaqbkNZnQZKkc8oWla7dwJUfynVZ?=
 =?us-ascii?Q?SV4F7rILwJLuh1MHR3AOba2XLVe7h2DmL1WEq1Bw6TA6pZxi9M7JOzJ3QzoW?=
 =?us-ascii?Q?eUNijFMuibdGQY96lYXvA+SEMXufaASPEvXdylUpN9CQ39kzXCV/8JuZ5bkt?=
 =?us-ascii?Q?pL4CAAFg6Ky2tpyF9iqt6btXGL91CiPm0U8eV3xDCIlkqkb7+uy7kox5kADs?=
 =?us-ascii?Q?lZ5502oWu7L65aXNtsDdpLecs+rD7D5ULWS4gnzc+B3fynbc3i/DRtSlQzGt?=
 =?us-ascii?Q?rquh7GmQdPsVzuOAiNVHaXMKOnXLND9EH0Zsn9swELObOGNO/aZEinL5dTc0?=
 =?us-ascii?Q?Sg2rJ8VTFWeC4XnuV/exk0q1UFP9Z22iLJKXA0whyqdrb/k4iP9aiCT6BI/u?=
 =?us-ascii?Q?tgqITL7asxuHWE6g4jlf2f/pXZp5dWfjPVo5YrQTKaUy0piziztUuEQ+uaK+?=
 =?us-ascii?Q?JcJxNerp/voeoMqD1BDoXPG4wmDj8ghUkrrQ53b4iSj8QeczkSMN6latV2MV?=
 =?us-ascii?Q?WQYgQ+qV2T0dezWESx77W/ZA+GLcX3KoEC52CBCqmupMZXF58/iZZLqCUbFc?=
 =?us-ascii?Q?GAZudrQro7/CGLb8PujglKTf+WI3QHK0RYqC/QRCanHfqIl1HlePXmUUwvia?=
 =?us-ascii?Q?RdSK8jw1cgzrNNe4chlYfXvlSxmQ9oZ9okekv4Orqmijzm+/6UDHgb/lbpxl?=
 =?us-ascii?Q?Dsh5iGPtfyKCsE8VyQc3s/bKODtr5zGE8O/BDhCpGEFfLsDmt9u3l9+sSQFq?=
 =?us-ascii?Q?n80mjXuhYg7mexLmTfJ1hrwSmoBkoJqA3U0zhVuh4fVrOUc7Rx4heIAhHVDK?=
 =?us-ascii?Q?dCOdXaH2IUHZpZJe1hNxBO6OgQKqb5YDu7xybphiAClmVfXnpvKtB7bOJhw/?=
 =?us-ascii?Q?7bHDTvR+75Au50IffyeGsZ4Ost67C9kiEONhbR4cmSCup2GnwN4NEoaMzeng?=
 =?us-ascii?Q?UPA/Vme+2rpfryxRMKUS4XcDL84RshHmv5bio/xIvC+MvYReTBdZKYDzIOyC?=
 =?us-ascii?Q?0knN7ooG2egiC49EVIohcxTBnJdfpWz3vE/3FxmoqcNMdQNM5Kjfh+cN9Nui?=
 =?us-ascii?Q?+ME5goGkHR+77abE0Lpdj3bXyY8RV4/n1jL8TD5lTR/FF5k+OsgplIJYjJvl?=
 =?us-ascii?Q?oA/2za8/MaRTd5yaepxS6h8v5fPILXHJkLqGLgLy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a15e8ce-ff22-45ce-7e4d-08dbde902046
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 06:18:00.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYFKoL4Q3anDVbdZlYHRpO0T3GaTQTGIK2W6ftsOkJruG6h3YwYL+iPwdxCjpUIVObMaa41iRsD5FfepJ5lkjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4520
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: ea017f5853e9a6a11cfa9bdc61ba823a1ed54ee8 tty: serial: uartlite: Prevent changing fixed parameters
date:   2 years, 2 months ago
config: i386-randconfig-004-20231101 (https://download.01.org/0day-ci/archive/20231106/202311061059.NUeUar9b-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061059.NUeUar9b-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311061059.NUeUar9b-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'reg_ops' not described in 'uartlite_data'
>> drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'clk' not described in 'uartlite_data'
   drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'baud' not described in 'uartlite_data'
   drivers/tty/serial/uartlite.c:79: warning: Function parameter or member 'cflags' not described in 'uartlite_data'


vim +79 drivers/tty/serial/uartlite.c

deeb33e8fdd834 Shubhrajyoti Datta 2018-08-06  66  
ea017f5853e9a6 Sean Anderson      2021-08-26  67  /**
ea017f5853e9a6 Sean Anderson      2021-08-26  68   * struct uartlite_data: Driver private data
ea017f5853e9a6 Sean Anderson      2021-08-26  69   * reg_ops: Functions to read/write registers
ea017f5853e9a6 Sean Anderson      2021-08-26  70   * clk: Our parent clock, if present
ea017f5853e9a6 Sean Anderson      2021-08-26  71   * baud: The baud rate configured when this device was synthesized
ea017f5853e9a6 Sean Anderson      2021-08-26  72   * cflags: The cflags for parity and data bits
ea017f5853e9a6 Sean Anderson      2021-08-26  73   */

"@" is required before each struct member.

da7bf20e775804 Shubhrajyoti Datta 2018-07-21  74  struct uartlite_data {
da7bf20e775804 Shubhrajyoti Datta 2018-07-21  75  	const struct uartlite_reg_ops *reg_ops;
14288befeb572b Shubhrajyoti Datta 2018-07-21  76  	struct clk *clk;
ea017f5853e9a6 Sean Anderson      2021-08-26  77  	unsigned int baud;
ea017f5853e9a6 Sean Anderson      2021-08-26  78  	tcflag_t cflags;
da7bf20e775804 Shubhrajyoti Datta 2018-07-21 @79  };
da7bf20e775804 Shubhrajyoti Datta 2018-07-21  80  

:::::: The code at line 79 was first introduced by commit
:::::: da7bf20e7758042eb3931ff68fc96bdfaf94d881 tty: serial: uartlite: Add structure for private data

:::::: TO: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

