Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CD57CDC41
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjJRMvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJRMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:51:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EC3A3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697633492; x=1729169492;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DwAoQFoMloxDsNlx4ZgP1TRaEi4rWSni84whCkg/Eyg=;
  b=PVFkdSltis/JtKeS35MQZEAF/G5kAA5dcTwaA4Zj7MO3SSNbFaHyrxnl
   TyOaCZMwGZJo1f/NsAv7XvWxt4GNMytAcH4BNidXEJYv2l6PFTBf5uE6X
   Cf+2A/qWIEiAjabPuqKzIOMJJBBUkaGBRIIRjTwUZHkDRYgGsCYJa8oQW
   aJHSslQnTtyfecE3JUFfPTQXWGT+I82nvx1/BvEWko6WehrH0zd5RyChm
   91Q/XKcAZzYmjB1rX+PdPpZ4bS65vWVngJYy4X5z2smJgQONpNd9MdU51
   YcbL5vpG6+45Ug9XW+FI553yGmZclSsFQR/u2YrsfcPi/z3cTsoQnOnAD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="450227755"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="450227755"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:51:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="930176646"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="930176646"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 05:51:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 05:51:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 05:51:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 05:51:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXVrkyBo0uCaarPAaEkT/3XSpOyA/mbCFWUrR/pncDKIpGaoi5joQZoKLCFBrPRwppKUZwxv+rZ2f0l4HoQZdKDUQIjPblxNOSzhT9UPoYqvsYQD1KyxLIPtLCnkjOchUqQGf1aBW58eS0D6BET67VOjw9Juvgtw/sYs1TNLseVE1hIBOs1wuW5/JRy+uEQNsHSsLuXEFiN2XVsHTdHm5D5egUyB1xKcN3rSRhohtPwDqQaN1NxHIA/aspDLFwxsw5WQWN1ubhY2yzEvhieBiIGDoY//sTIhbGcGAe6cqeyNmPa0oJ6uXb0eUJuOaKN1BLSsbsmM3wUejiY/ARL90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7SIvSjMxrCkn7Ynf8J7D/CK+o35kKcgZmLgyvBjYLI=;
 b=PwXPKAQsQA5uTuk1Widpd9pUfaKJU5uyzXf5K/mvzrIa4ac5XRqtm3vdBonpwtZ7nIK271DVoqUj5gRdgTc/wGqKI6Bg1N8qFbSb7jklfRt4wpXaSW1o9O/iEXrXiBIltSNLNWA5LzMInKjXr+o6ikdf+rPMAwy1aTvDJdqq1Qov7RJBcGkPxgAkrSqAhRbyBozIVE008l0FlwrzPNcnunYj94aGLnTlYTBExZxQgN3CXKE1YOEXXpFpa6rvtC0ghG4Ce4sBPP7Zv8uX9bjTbXmeKFV/k1phxqVod5VjL9yBpOftKy8nWWb3DOL25FdsyCbi4ZAAE0+BHKa0oVNI6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SN7PR11MB6825.namprd11.prod.outlook.com (2603:10b6:806:2a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 12:51:24 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196%7]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 12:51:23 +0000
Date:   Wed, 18 Oct 2023 20:51:15 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Rob Herring <robh@kernel.org>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0
 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned
 int[]'}
Message-ID: <ZS/Uw3RnfLVUxRku@rli9-mobl>
References: <202310181943.y4q7XNsm-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202310181943.y4q7XNsm-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SN7PR11MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: f3caa0a4-4d73-46e1-1e42-08dbcfd8eefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WE7AO8bEBcABhlTv+ttyl4+Gl7QaXDGjQFETASgVRptEVrArT7cmHGmvOrSsEPPgIuTKHtInvrZRM61GBmwwwn5ttbGbd/CecgVzftP2rN6Cfas7ajPuyI+KztSmLp4kr9ujnTgo0XNCS93yxsUfvkdWxiyQf2noI6xcshH5yfEty3wBVMAnSqSLehiJciaR/ZXT2fLnya+S+wAh8cLM22ayid1PcsYWMzVLlrQvFQUTwcEzDmExeaiOWx/AMq2b8Mszj7/JDVLPDMHK6aYWZyGR5G0o34eT9SWJeT5uaIV+5lZHYmGIo6/tPQ5ZuqC2qfHH2fwDqGcK3seQPZp7B9lnxAi9nXSBL53nAYUQQpMitTCLDEoud8EHXb5lUOimfnI9Ahk1aMAZrlDz+jFDVFdLhcE1lQRM7WQ0gF1sSG4U+lDnjrXONqKMs3DpVG8C6jK3vhjvayt9Lv2nR/G351QLNdYcYQFsj8arwF0iNQXSRDryP/ClRpGYkLMyLaSTZ7Ay7z0aTIrlc+8pRPigzC5jaPTQ/S1UaZTiO13ix/n8rrzKrnA3OKNt6UOOYUhm85H33thinQkz+YgmrYVr3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(9686003)(26005)(966005)(6506007)(6666004)(8936002)(83380400001)(6512007)(5660300002)(41300700001)(44832011)(6862004)(4326008)(8676002)(2906002)(478600001)(6486002)(33716001)(316002)(66946007)(66476007)(54906003)(38100700002)(6636002)(66556008)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nJSgOOa3cqLg1q9avcv/iWg9lBnySLMztOOjCp/NafFneh/+62CN17yjHepS?=
 =?us-ascii?Q?3KyCV+/35/4yW1CeMyiRG5OkAB7NehkY0RuNNDnvyoRjzhK5dy+I2fafPtQp?=
 =?us-ascii?Q?yncn4azUrheSVP89RHbX5CdD6cx9tFmG4h7+EA8p4Q4bcuv4nym849cw2e9O?=
 =?us-ascii?Q?CgAPhFrcQE8b69a6gGZkW1X5L2nZnIUH6/JVxBlfeOhL5cRjl/G5g/Sume9h?=
 =?us-ascii?Q?9aMTXqzPRYdDmKpsGXbitOhw2PBr/0V9hlKs/vzvIr1NsGsHZY3ECULPSwwX?=
 =?us-ascii?Q?+/YPiMOGFfACiKNzkG0buj6meG0iJI3gyFHR9r1TKM4v/3VBFh4CJU2VeTq6?=
 =?us-ascii?Q?jP99hTnLOp7oZR50bFVEpBSIwCow3ueBApKLT4CN7aw4VBYDOigvJ/8CKXsg?=
 =?us-ascii?Q?xxz8Wpt0A58wPawfCK//ktR3YbkrDDQgTsbeaOVmqEHo1GkgABUVLlUHswRr?=
 =?us-ascii?Q?ISutO2GqlU4yerio+WS28iTjJ0+RpuoMTq+CBC+Dwa91h82gd8aKJK/COPXE?=
 =?us-ascii?Q?8j6t6X4AF9adYN5/exOsOEj8hSokcXhG9Ariwg99NWIw06nXttQ+tIWkMhMK?=
 =?us-ascii?Q?TQCbPCudV8Q1wYSFfzOLZsx0wJQ2xm2+le0qN56SFYFrof3vvwjmF5wpeDca?=
 =?us-ascii?Q?h50XzHJKiqJVihLK6BemQ9vVkjMMCyQ6k7dxkaVj9nThCZSEE8wdheQPZ4Sn?=
 =?us-ascii?Q?IHINjeanuhHrSFUzAM4w49pgSRLB0HkqMBf54VwR9SCynLWUf4wDqJMt6O7A?=
 =?us-ascii?Q?WtKSqcii8WHi4AP2HB9oTjWFheVfJC5jtjkdVpBBMg5Z1v/n4Y+Z5oJAo4g/?=
 =?us-ascii?Q?wuNc/zrb78SKzj2mlQaqoqFD6av7/ssPNsEG6Ddy59VrLfJbn4nvem4LeVmm?=
 =?us-ascii?Q?5WmcdVoALWV9GJvOD3MqY4VJJ4oSlkRbdyqFJ/AsWqPHGtWcS/+XJhgHhzfA?=
 =?us-ascii?Q?DUQKZM6PAb3H7nLDEPot1MmRhmA9pyg0T/EflRA3h4y7C9Hh8aSgSmuPRirR?=
 =?us-ascii?Q?QF4l7/y3jrmWcRfJVprJgglfXO5xUsnaLLhkKpU4YHC1y2M0RM6mjm+ydUsl?=
 =?us-ascii?Q?RlZGYISEe3WvhmCNoA8Za+4s/dt1g2NvtKcFpdw/DcF1h7Pr6ALha2eSj8A8?=
 =?us-ascii?Q?lpiV8flQ/mM/9KqRLQedo4DReJ6IJNgC7FlefdfoKDrlJG/DiZH5XcjdKj9q?=
 =?us-ascii?Q?peIgzdpbJi5ij0vOatAqeX7Z3K/ZS7/jVLTbz3OjqLvmGH0taLpl5fcG+g6b?=
 =?us-ascii?Q?HqOHj/DAUZq2d1fI3BA87prEp5T5M1HdIxENgTGIt5E0Ons50VGvcHETyTw1?=
 =?us-ascii?Q?OY3sNw6c8o2qjfVg8Xoqrnz2qNWnB8QO1S60fFRgOcHXKGTkCIpdxU9tPWGP?=
 =?us-ascii?Q?voJqgXE2GXT1TuvTQrBU970A0UWBwACo9n9RK7qvIAks6wmGtcvsEUDp64BW?=
 =?us-ascii?Q?ihYxQMPtM7NhAayEvg411kYTY2JFyQAagApV92hMYjBwX5xGqxveYtwihKWx?=
 =?us-ascii?Q?ztj9MBdtv9ly9YNfQ7zTFwzLIJMrB96WhrC9tV8PE12BYjUgOUf5z8nnAhwa?=
 =?us-ascii?Q?2dglUl9tfN17zCDxaY3AAAMc/Sg8wJnLnDU5Y567?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f3caa0a4-4d73-46e1-1e42-08dbcfd8eefb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:51:23.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUmFs9JmyQ+KAL+jVrYFiaCEbqQupt/quMQAh8+cUQ26OwQxiTmG7B5gTer4yLWdqHzrYPdzVD+l9kIdWVStjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6825
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 08:06:07PM +0800, kernel test robot wrote:
> Hi Rob,

Sorry for the wrong bisection that the commit is not the initial cause
of the warning, kindly ignore this report.

> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
> commit: f1a43aadb5a690e141a3b6700e2a40c1d4dbe088 watchdog: Enable COMPILE_TEST for more drivers
> date:   9 weeks ago
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20231018/202310181943.y4q7XNsm-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310181943.y4q7XNsm-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310181943.y4q7XNsm-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/m68k/include/asm/io_mm.h:25,
>                     from arch/m68k/include/asm/io.h:8,
>                     from include/linux/io.h:13,
>                     from drivers/watchdog/machzwd.c:39:
>    In function 'zf_set_timer',
>        inlined from 'zf_timer_on' at drivers/watchdog/machzwd.c:218:2:
> >> arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned int[]'} [-Warray-bounds=]
>       91 |         __w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v >> 8)<<1)))); \
>          |         ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/m68k/include/asm/io_mm.h:228:20: note: in expansion of macro 'rom_out_le16'
>      228 |                  : rom_out_le16(isa_itw(port), (val)))
>          |                    ^~~~~~~~~~~~
>    arch/m68k/include/asm/io_mm.h:356:42: note: in expansion of macro 'isa_rom_outw'
>      356 | #define outw(val, port) ((port) < 1024 ? isa_rom_outw((val), (port)) : out_le16((port), (val)))
>          |                                          ^~~~~~~~~~~~
>    drivers/watchdog/machzwd.c:74:53: note: in expansion of macro 'outw'
>       74 | #define zf_writew(port, data)  { outb(port, INDEX); outw(data, DATA_W); }
>          |                                                     ^~~~
>    drivers/watchdog/machzwd.c:173:17: note: in expansion of macro 'zf_writew'
>      173 |                 zf_writew(COUNTER_1, new);
>          |                 ^~~~~~~~~
>    In function 'zf_timer_on':
>    cc1: note: source object is likely at address zero
>    In function 'zf_set_timer',
>        inlined from 'zf_timer_on' at drivers/watchdog/machzwd.c:218:2:
>    arch/m68k/include/asm/raw_io.h:87:13: warning: array subscript 0 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned int[]'} [-Warray-bounds=]
>       87 |         __w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v & 0xFF)<<1)))); \
>          |         ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/m68k/include/asm/io_mm.h:227:20: note: in expansion of macro 'rom_out_be16'
>      227 |         (ISA_SEX ? rom_out_be16(isa_itw(port), (val))   \
>          |                    ^~~~~~~~~~~~
>    arch/m68k/include/asm/io_mm.h:356:42: note: in expansion of macro 'isa_rom_outw'
>      356 | #define outw(val, port) ((port) < 1024 ? isa_rom_outw((val), (port)) : out_le16((port), (val)))
>          |                                          ^~~~~~~~~~~~
>    drivers/watchdog/machzwd.c:74:53: note: in expansion of macro 'outw'
>       74 | #define zf_writew(port, data)  { outb(port, INDEX); outw(data, DATA_W); }
>          |                                                     ^~~~
>    drivers/watchdog/machzwd.c:173:17: note: in expansion of macro 'zf_writew'
>      173 |                 zf_writew(COUNTER_1, new);
>          |                 ^~~~~~~~~
>    In function 'zf_timer_on':
>    cc1: note: source object is likely at address zero
> 
> 
> vim +91 arch/m68k/include/asm/raw_io.h
> 
> ^1da177e4c3f41 include/asm-m68k/raw_io.h      Linus Torvalds     2005-04-16  49  
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  50  /*
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  51   * Atari ROM port (cartridge port) ISA adapter, used for the EtherNEC NE2000
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  52   * network card driver.
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  53   * The ISA adapter connects address lines A9-A13 to ISA address lines A0-A4,
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  54   * and hardwires the rest of the ISA addresses for a base address of 0x300.
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  55   *
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  56   * Data lines D8-D15 are connected to ISA data lines D0-D7 for reading.
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  57   * For writes, address lines A1-A8 are latched to ISA data lines D0-D7
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  58   * (meaning the bit pattern on A1-A8 can be read back as byte).
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  59   *
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  60   * Read and write operations are distinguished by the base address used:
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  61   * reads are from the ROM A side range, writes are through the B side range
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  62   * addresses (A side base + 0x10000).
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  63   *
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  64   * Reads and writes are byte only.
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  65   *
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  66   * 16 bit reads and writes are necessary for the NetUSBee adapter's USB
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  67   * chipset - 16 bit words are read straight off the ROM port while 16 bit
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  68   * reads are split into two byte writes. The low byte is latched to the
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  69   * NetUSBee buffer by a read from the _read_ window (with the data pattern
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  70   * asserted as A1-A8 address pattern). The high byte is then written to the
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  71   * write range as usual, completing the write cycle.
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  72   */
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  73  
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  74  #if defined(CONFIG_ATARI_ROM_ISA)
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  75  #define rom_in_8(addr) \
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  76  	({ u16 __v = (*(__force volatile u16 *) (addr)); __v >>= 8; __v; })
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  77  #define rom_in_be16(addr) \
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  78  	({ u16 __v = (*(__force volatile u16 *) (addr)); __v; })
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  79  #define rom_in_le16(addr) \
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  80  	({ u16 __v = le16_to_cpu(*(__force volatile u16 *) (addr)); __v; })
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  81  
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  82  #define rom_out_8(addr, b)	\
> 30b5e6ef4a32ea arch/m68k/include/asm/raw_io.h Geert Uytterhoeven 2022-05-20  83  	(void)({u8 __maybe_unused __w, __v = (b);  u32 _addr = ((u32) (addr)); \
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  84  	__w = ((*(__force volatile u8 *)  ((_addr | 0x10000) + (__v<<1)))); })
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  85  #define rom_out_be16(addr, w)	\
> 30b5e6ef4a32ea arch/m68k/include/asm/raw_io.h Geert Uytterhoeven 2022-05-20  86  	(void)({u16 __maybe_unused __w, __v = (w); u32 _addr = ((u32) (addr)); \
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  87  	__w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v & 0xFF)<<1)))); \
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  88  	__w = ((*(__force volatile u16 *) ((_addr | 0x10000) + ((__v >> 8)<<1)))); })
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  89  #define rom_out_le16(addr, w)	\
> 30b5e6ef4a32ea arch/m68k/include/asm/raw_io.h Geert Uytterhoeven 2022-05-20  90  	(void)({u16 __maybe_unused __w, __v = (w); u32 _addr = ((u32) (addr)); \
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06 @91  	__w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v >> 8)<<1)))); \
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  92  	__w = ((*(__force volatile u16 *) ((_addr | 0x10000) + ((__v & 0xFF)<<1)))); })
> 84b16b7b0d5c81 arch/m68k/include/asm/raw_io.h Michael Schmitz    2013-04-06  93  
> 
> :::::: The code at line 91 was first introduced by commit
> :::::: 84b16b7b0d5c818fadc731a69965dc76dce0c91e m68k/atari: ROM port ISA adapter support
> 
> :::::: TO: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
> :::::: CC: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
