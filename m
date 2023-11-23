Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97E67F5AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjKWJHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWJHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:07:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7909D10E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 01:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700730475; x=1732266475;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SqaDaKg3D+jkt9tkvZ0+rS4CxIodxvith7w9+ojroDY=;
  b=JoBZhgjPOJImJFv+K9bjIwGvcCIVpJlS5L4kEc2xAswPXbdVQGdZqpdo
   fUDwYawB+rH9FBSqPAHa5feot+qwHGBnXIGz/6pf0ewu1Mr9VIFjrdPvn
   qoEdJyYaSyniThOVhXUIwh0LaIBaGPa8oY+rGkbO8zCEazPm7oY24NCTZ
   RSWkosFB01Hk1Xh/NBTVWnB4T7S4iu07Gh2PfJFgTKOBgPGvT2ujAAYkA
   FvtQABTY2Cod4sZQpfQx50UQoVZRTSIi+rdBzalXcxn316R+1lxZML56e
   lnNneC6WBK1ME+yi754dF7stsIb1hRXF0VDIXXgb4iX0y6yP2NeVbNEnZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456566794"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="456566794"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 01:07:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="743553982"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="743553982"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 01:07:49 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 01:07:48 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 01:07:48 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 01:07:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThbTJYQAFgVppiO2HDO+DNLtMR+5t3JNDGMqyDOkKGSujyKN3lx/e/482vEeJcljknd1yEwROmqRZZVm72G5ayVAuZW1StrzC7b+P6/r59SsXjI+sWzJejwUnHOpEso0rDRq5iaFiDQ0zQyIWfAHhONBajiCZIGKkNLNPDVz45lnKCH4+Hl8gi8FuLg9bpd817wDKrBA08tqkHbDL3sQ1M5h0xeIgQqwWYWNK4udp6Gi9Gf0YDq9b9DkCLKG5Zjh1DiwXXwLt1nx8lIvyoN9r11jhLuHvOUS+4bWNmIwb6bkNo4awauQdoEIIMJTQsgBaa+Kwx940G+PumZMWrKlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rrln17RaKnx6Oay6ow2SMB6jAB5CoVCkC/DlmAHbBs=;
 b=RrS9JQAsmpgExvfwuB14R1y7GU409gzyWGHKi9lvwsbtuP3RYiDPqJSYCdv/uUjie1Z+0BUuggLjsw2jJ4LlgKBrNP+Cdid7VlfWAXfkUpfmt6deLZOXnVhxQt6S7CQ/0ZkOnkc9rY52XCQ6tqRLx/YgCKmkdbGksitjpxF2zHf2RcphxRzCWnusplJbLJ02pkiJ5NRoaAxGGvcE0+zRr/KUG80tL+u9+kTTrijICzdwlhVRaUMH52oALQXAFB00U7Xbzc9sMdxxCcOnHQ7JSjhMYFA8B8k94NhmEUz8+8zorRGeQafxXGTskNAZiynsafjSECjHlP6x9q+OBSUJmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DM4PR11MB5550.namprd11.prod.outlook.com (2603:10b6:5:38b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 09:07:40 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 09:07:40 +0000
Date:   Thu, 23 Nov 2023 17:03:03 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/net/ethernet/3com/3c589_cs.c:581:2: warning: performing
 pointer arithmetic on a null pointer has undefined behavior
Message-ID: <202311230749.rddGc0Js-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DM4PR11MB5550:EE_
X-MS-Office365-Filtering-Correlation-Id: a6da9b1e-948f-47d5-ee35-08dbec03a4ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VTulC7K1cfVGLjHXQ3/dQCjfYvf6NA69okru1dJgGy38ecsJ3PAosP0X8gbRHmzEByf5BrjYaqaAyferP1PoGaTgsanIOr2e1Fjhozr+lOtTvvNRqD0O+itah4emKbkdHOhZacJiIDsHjZZ+vbrX2pPs/b+eTmjuNa2dp8VKNukl4p+Fkg+MiN5up6O1/6rIfRIp09Nk6tErQ8GrPXe34mtCuroeFVFAdi++VgyzyitVWnCapwCdB2FPiFaLpZw46p1QVxIt/CBAqUHCFoUH/g9HIAcVBa+fOe4UR+F6w5tO+h+lBBueTb+WPyxftjNrIzh3QVUrs6eyvwejMgp+mU7joEGuPpGIKmYZWOX2LKsprsHiNDRNdwf2QJnAUr1Au6lx7oAPpbkJGFQm0nZILHnMtVdL4OCUt5IarwRFjBWFcccLUisR58eIl7olzhKRFBrPNbjqSf2Fi6fEdmGXnjyWKzCpI4D0taiS1mkptm4WaEf6SiNkqvbj4byR8fje6x3Zn7iYpXW6Y2Aesz3l5qN6uGQToC/tWoQIfz/TLQ+gRP0dc/NF3aFi1naZgQUk3J7wn2CUGNM/jfB4wz1LlNzWHgBXgDO3V7yuwVLZJTuYkrLg213dR6E4JCG6hlWg9EqJ6+nU3G99bX8eixqsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(451199024)(186009)(6916009)(316002)(54906003)(66556008)(66476007)(66946007)(6512007)(6506007)(36756003)(6666004)(26005)(1076003)(2616005)(478600001)(38100700002)(82960400001)(83380400001)(86362001)(6486002)(966005)(30864003)(2906002)(5660300002)(8676002)(8936002)(41300700001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yafPVA/veNUSe1mhNS3pJ1GbIFLlYa9p6NpZeFFadM9zSqWsDYU0fC9a7ZTs?=
 =?us-ascii?Q?LBkN4ze0fd6pjMRSPIgaIr7eD/oBXbFlDoLO+H7vdOgymoTX0V/TUBBvu7DR?=
 =?us-ascii?Q?ovnfCk3EprxhXPV+oZzYC+1z1AnbrNHlVt2mIEzoqzLnDFW0yWoaL/Pcl0QB?=
 =?us-ascii?Q?QKvFoxsxFucDwCavxWqadhOcsDaH8uYsvnlOL/6N7vDn/7hkktNa8dlSBNl7?=
 =?us-ascii?Q?+PLPmHSadhC4xLp+PFsWGDACGX5Uj/GBXOppc7IQpx7SJgztoh2b+F67jRdq?=
 =?us-ascii?Q?zS9Kq79LW3f3lfqKpwuHELZsg7BwJ0oxX9TLbcxGnZ61XLQkpX45hnpxzFf6?=
 =?us-ascii?Q?mQsxgr/xTIUrwfWK9ASfxKDdi19yA5m3cZUuYG3TtaS6a5F5qu5IGx50D+DD?=
 =?us-ascii?Q?YTwrJfhyzRoQGjXVHJf6L/mNgRMvhzK1L5wvHOLKjmWuNiMH/biUDJ+NttLO?=
 =?us-ascii?Q?D/Pj632Pv7dXydO2oAVMGw1HQwIzzxdy/zzq3EoV1HBJBtJJHw++3GItvMjc?=
 =?us-ascii?Q?0fqdNKgF2KixNzHNVJL8Y+AyqBcLlXBDsyNMmhDzXgmmaDEZlWFgrGfn4wjZ?=
 =?us-ascii?Q?VkyOJtM2kBeAfrcApCKhS79UgTkz9OMH8nXacW0dgXtHerKayF/RfG2sVt4w?=
 =?us-ascii?Q?Y1VzzhAxL0VuAEqDbJwQ01GINIvylnnjl2bs+wsaNbfT+6AMg5CbZpRdlF9D?=
 =?us-ascii?Q?nmmrv3ROW3SCaJhP3TA38fA7Y1obQZMUOKCgRVqlQMp8DaKiXpz1ipCxj4bi?=
 =?us-ascii?Q?xR4k/UVxGne7vc4e08k+iDv3AcuE28+szrtAPH5PejQoFcDmkZ/e9cjOSqlx?=
 =?us-ascii?Q?PLOLQw/bORq5V/wFm/Dn1nXRXO0b/4NIvDE5kbF9YttCBfMcNm0pL+zmtCyi?=
 =?us-ascii?Q?B99Xycz0jwp0wSUx2YKQgVLT+euNfIj58GbAtv+iVNu213thSvbok5R29Qxo?=
 =?us-ascii?Q?DutPwWy6anLGIEcyFabMCTKSK9ZTdeJaHR17mKwMvgxRHmPF+ORgbRA3bB4T?=
 =?us-ascii?Q?2ibF4iHXGrzZo++KuhE6FXWTgC7BzPgNmjZgpb6oMT3UJh0wypxHdmwS3Rfl?=
 =?us-ascii?Q?nlRTOCdOeKLL1Hh5hGCA55AboJNc4t/rKn/GqB1cLr6ZSTkl6eJcvHMrZr6R?=
 =?us-ascii?Q?qJ2vqgssiUzrBos2C0/z3KKUxNKkkLLED1qziQmupsP7gGV5HciW1wbeKq2s?=
 =?us-ascii?Q?kE0eLy+D3aXdtHrWKbO3nxGxzElMQg/lD4OTfgmKJ5gRZlT1d2A2Qo+45hSl?=
 =?us-ascii?Q?6kRLqbxUpzyrnfpPzpP4J71GDHOJ/RgKpCtkQJC2ADpDDg2KsewVpNpLL/p4?=
 =?us-ascii?Q?syrI9mH5ULtF9IqOwPr2DpA8bp6wC1UNrGT5sJqvO/P1u6aPysmkYJmxxJiE?=
 =?us-ascii?Q?jvbaViyUQ3/TrS9U/+SZzkvqOJVUEXTi1SZaPvgyMAbZTsBpiQkQKozPzLp3?=
 =?us-ascii?Q?qzHkb5XW5dky/5sjwi/FuXb2vUDnc2Xz/6EiHT0C8S4l5Prm/xs5uwvyfYOM?=
 =?us-ascii?Q?2Br9ZQvy0+VRLXhmqd8RNhn91EXgdzu5nIXlXYwEN0kLzu/LY9ohGrmd5B7F?=
 =?us-ascii?Q?qccYYBnMbL3Sve1rJVc/Q/jaesZuWtbcVJ30fCgR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6da9b1e-948f-47d5-ee35-08dbec03a4ff
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 09:07:40.3059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvHhvxSUNFgILJLtg43TlG4JDYNv7K7CNEaylLgEY5DbWAysTcoNUBhrCixw+O6BindscbTYNGf4UfSxpCtM6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

kernel test robot noticed the following build warnings:

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b6de136b5f0158c60844f85286a593cb70fb364
commit: 9cc205e3c17d5716da7ebb7fa0c985555e95d009 RISC-V: Make port I/O string accessors actually work
config: riscv-randconfig-r133-20231123 (https://download.01.org/0day-ci/archive/20231123/202311230749.rddGc0Js-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231123/202311230749.rddGc0Js-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311230749.rddGc0Js-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:743:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     743 |         insb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
     104 | #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c589_cs.c:33:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:751:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     751 |         insw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
     105 | #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c589_cs.c:33:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:759:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     759 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c589_cs.c:33:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:768:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     768 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
     118 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c589_cs.c:33:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:777:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     777 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
     119 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c589_cs.c:33:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:786:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     786 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c589_cs.c:33:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1134:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1134 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/net/ethernet/3com/3c589_cs.c:581:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     581 |         outsl(ioaddr + TX_FIFO, skb->data, (skb->len + 3) >> 2);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   drivers/net/ethernet/3com/3c589_cs.c:861:5: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     861 |                                 insl(ioaddr+RX_FIFO, skb_put(skb, pkt_len),
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     862 |                         (pkt_len+3)>>2);
         |                         ~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   15 warnings generated.
--
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:743:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     743 |         insb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:104:53: note: expanded from macro 'insb'
     104 | #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c574_cs.c:79:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:751:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     751 |         insw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:105:53: note: expanded from macro 'insw'
     105 | #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c574_cs.c:79:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:759:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     759 |         insl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c574_cs.c:79:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:768:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     768 |         outsb(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:118:55: note: expanded from macro 'outsb'
     118 | #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c574_cs.c:79:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:777:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     777 |         outsw(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:119:55: note: expanded from macro 'outsw'
     119 | #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c574_cs.c:79:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:786:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     786 |         outsl(addr, buffer, count);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   In file included from drivers/net/ethernet/3com/3c574_cs.c:79:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:1134:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1134 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/net/ethernet/3com/3c574_cs.c:748:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     748 |         outsl(ioaddr + TX_FIFO, skb->data, (skb->len+3)>>2);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:120:55: note: expanded from macro 'outsl'
     120 | #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
         |                                            ~~~~~~~~~~ ^
   drivers/net/ethernet/3com/3c574_cs.c:1015:5: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1015 |                                 insl(ioaddr+RX_FIFO, skb_put(skb, pkt_len),
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    1016 |                                                 ((pkt_len+3)>>2));
         |                                                 ~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/io.h:106:53: note: expanded from macro 'insl'
     106 | #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
         |                                          ~~~~~~~~~~ ^
   15 warnings generated.


vim +581 drivers/net/ethernet/3com/3c589_cs.c

^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  562  
dbf02fae406daf4 drivers/net/pcmcia/3c589_cs.c Stephen Hemminger 2009-08-31  563  static netdev_tx_t el3_start_xmit(struct sk_buff *skb,
dbf02fae406daf4 drivers/net/pcmcia/3c589_cs.c Stephen Hemminger 2009-08-31  564  					struct net_device *dev)
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  565  {
906da809c5be30b drivers/net/pcmcia/3c589_cs.c Olof Johansson    2008-02-04  566  	unsigned int ioaddr = dev->base_addr;
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  567  	struct el3_private *priv = netdev_priv(dev);
d08d283974f96cb drivers/net/pcmcia/3c589_cs.c Komuro            2006-12-02  568  	unsigned long flags;
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  569  
f64e96973a1fa88 drivers/net/pcmcia/3c589_cs.c Alexander Kurz    2010-03-31  570  	netdev_dbg(dev, "el3_start_xmit(length = %ld) called, status %4.4x.\n",
f64e96973a1fa88 drivers/net/pcmcia/3c589_cs.c Alexander Kurz    2010-03-31  571  	       (long)skb->len, inw(ioaddr + EL3_STATUS));
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  572  
d08d283974f96cb drivers/net/pcmcia/3c589_cs.c Komuro            2006-12-02  573  	spin_lock_irqsave(&priv->lock, flags);
d08d283974f96cb drivers/net/pcmcia/3c589_cs.c Komuro            2006-12-02  574  
cd65284f6ec4826 drivers/net/pcmcia/3c589_cs.c Paulius Zaleckas  2008-04-30  575  	dev->stats.tx_bytes += skb->len;
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  576  
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  577  	/* Put out the doubleword header... */
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  578  	outw(skb->len, ioaddr + TX_FIFO);
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  579  	outw(0x00, ioaddr + TX_FIFO);
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  580  	/* ... and the packet rounded to a doubleword. */
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16 @581  	outsl(ioaddr + TX_FIFO, skb->data, (skb->len + 3) >> 2);
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  582  
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  583  	if (inw(ioaddr + TX_FREE) <= 1536) {
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  584  		netif_stop_queue(dev);
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  585  		/* Interrupt us when the FIFO has room for max-sized packet. */
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  586  		outw(SetTxThreshold + 1536, ioaddr + EL3_CMD);
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  587  	}
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  588  
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  589  	pop_tx_status(dev);
d08d283974f96cb drivers/net/pcmcia/3c589_cs.c Komuro            2006-12-02  590  	spin_unlock_irqrestore(&priv->lock, flags);
63ac9b915924d12 drivers/net/pcmcia/3c589_cs.c Patrick McHardy   2007-07-02  591  	dev_kfree_skb(skb);
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  592  
6ed106549d17474 drivers/net/pcmcia/3c589_cs.c Patrick McHardy   2009-06-23  593  	return NETDEV_TX_OK;
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  594  }
^1da177e4c3f415 drivers/net/pcmcia/3c589_cs.c Linus Torvalds    2005-04-16  595  

:::::: The code at line 581 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

