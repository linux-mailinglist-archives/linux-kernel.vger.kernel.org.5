Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6287D8E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbjJ0F0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0F0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:26:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3BF93
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 22:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698384380; x=1729920380;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=2Ptf/QMCE0QhW7PlrBHrqOjHyVIp6N6u4dmfptugzZY=;
  b=I/Cdcm+ChJfON5q8GpcPl0TxHrwdhYULjYuJPAEDmWjSq1OsMT88NPFg
   kPYhfriEys6OED9Rsj/S3wqW/Zprm0HZbPAyTcmXaDLP/XphH74pgDiBU
   IgbZQt67A4Y7dZMfl7yMz2Emsf4pLbbhmMiTU0rkbD5TO13eclkW2Cjxk
   eJ4ZQMyeBKx2TJGPpiJfpF1f5Jg5V/TK+KDkU6Q+/3/q3utKMeVGSFpik
   RhG6boEGg8XJZaBzyWQvmYGqSTl+MwP2fhrRSD5FnRoSwxsoyWfqqLP4h
   A/5T1uXQM9o9M8+VqmrUCuDvpxXD+CCwFklP6giPC/jW1kTSrG6YRX1PR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="367055642"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="367055642"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 22:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="794473566"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="794473566"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 22:26:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 22:26:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 22:26:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 22:26:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 22:26:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vg+EyKqgXnB/h16fj/TAkTUG6uSuKID5/SEP2g1eY0zXW+l6ak18dofMBje13MfltUUrUbiVZeDANWkZO67QyXQPOAYgDjn/6jk3QTw5vaHmSVzOrNwjSudSVEFkKco6f99Dp9ESsRpzNJv7fxyIkz9qGBj5CNXoPRWC9JyljcdphbCHOpJNoHAEWdcPibc779hhyVQMxEzbZTHf3jsQvl33pNr0jVBS4g1AhF57+F16/9X4hV2Lt8FlqlI3RbIKEv5EacYsZoamc896UN/VsiuZa45hDpexqwxbimIjkXvfHdZHqX5eYEDefnwZbjUtNQwf4+ckPPJ4iP01wRDejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHS/V0vmuy0zk2JYOcgB/vGFiVRoFiYjVGon064mkkE=;
 b=H+w3xdFrCOAyr4BUfaIDa9RaBqisplqRCiobuzrWPAbgfFW8zING8P9OYo0VweZY2yTDg4zm3Mt1m+bBX2ux3G/i6EkB7hhxA/U6ejnZmAA5uWH8ug0BAuULbD7FGJ/xSiIYmQFvROHWZkaJZQ4+fiDphZHsx6Zn+jmjsbnrls9QuZ1XlXayrsF81DAnpOQBM8rcUAL5Gzv3O9mtE68sW8IJU4lkAEriJp24FpC78IuvdKYNQw+k1YbNV9PzLtBsgYrC7h3YDy7UREm57ORZVB0XwEHZk86lBILGf3aEKBhDHbW93zOczh5KqJ2hKFtJnP7fyLWo73b4ipHzpE1YNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA0PR11MB7815.namprd11.prod.outlook.com (2603:10b6:208:404::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 05:26:16 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 05:26:16 +0000
Date:   Fri, 27 Oct 2023 13:26:06 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     <chengming.zhou@linux.dev>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
        <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>, <linux-kernel@vger.kernel.org>,
        <chengming.zhou@linux.dev>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        <oliver.sang@intel.com>
Subject: Re: [RFC PATCH 1/5] slub: Introduce on_partial()
Message-ID: <202310271308.9076b4c0-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231017154439.3036608-2-chengming.zhou@linux.dev>
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA0PR11MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c67359e-09b1-4975-2261-08dbd6ad3dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xKy9z7Jf9r/tDkGdxaKQLeAG48kuxXNaXLb1BIeNJuBOhCKVGbNmvctNyyM9SeogYfTQjiD0hBjFgMUeIjg/AFGES3aMuWuRtrq2YpiMAYrDdEQuuaXy4wkSyeZQ8uqG2PAgBhIXLdxwpNEXlmj3MT1bvxRcLtS1HpbHKNrlJmWGdO9py/aukChNmU3CWW5WN22co0T6YPv7J52qsAumlSisdZsQ0IURVl4CI0z4jj3YlW/AiZRk4dwpwsErN6cCdIf/R0kAOi+tFtovtx7JT7oPoX3tXa+4erAMH1vWbFkC3PwRGixuNIrP2rc/RH7F4ryv1Qo6yu2YuXNrWvCWR4eFzI0LQIIU3XAwLPAgF0j3nlGzvRurwUHueQ4VRmeqte/kYcpo+EjONLfzS76IGUez0IrQbtKIazJFdBq1DQ/Ev16oS1C5iJtfU2OfPQYTWYTT6aLdwGTajDQENeejhpq5XnS2a8EXwzlH5FkZG+viVPqbuI0T3r8fYwkMFXmu+EfR0a7H8a2hmeifiOWrN12RSrj+yzKMLdTtBq8TFN1ABBk6mDk1i+OLLiDMIJZhOqMBofGoW9/pP2dSqzMgZ0wAKV99FrWKeQE0VUZTR0mroMRxE6EmL+ZmWD9akGo2woW02MCHLk0Z/VoeOGvaQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799009)(64100799003)(451199024)(6666004)(45080400002)(6506007)(6512007)(478600001)(966005)(6486002)(83380400001)(2616005)(107886003)(1076003)(26005)(41300700001)(2906002)(5660300002)(7416002)(6916009)(66476007)(66556008)(316002)(66946007)(4326008)(8676002)(8936002)(36756003)(86362001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4P4bXFCfbraumurrW9RLMq3PoIbQeYP5TRF/u3vMKjj8oisNCtDFuTCsTyWO?=
 =?us-ascii?Q?qaBuvMqjHyhcG6f9bNBQZYdl8MZ3GlBohxIuF7HgJoGquUUoZS/0VQtPtOp/?=
 =?us-ascii?Q?MQAQxrnnq3N4dHKn++Cd95hyWZxi7Sb9qKnaYCEyJGBeCSKc1lmxAQVgvVoc?=
 =?us-ascii?Q?zSs+/8YKEhr+Jj9rjLEkrY5Urn0At2j13xf7Ai72XrbYSN6WE0pjSfzhQnP/?=
 =?us-ascii?Q?S5I9oYp1ANVaN3dFyJECbf1m1lhDyVGrwNq2s0m3tWDWfJnqWmYrYdaFZap8?=
 =?us-ascii?Q?0WNlnB22LwJXyy4/AQuJoa/oRoLbKAoszmfQA8GM3Hy/J3Kgs0l4303IOad0?=
 =?us-ascii?Q?2vJ/2Gb5DsaM3TLA6w20qJS6A+vMEx52zPjQp77gOaV7zH5C1+F8cQjWqDHa?=
 =?us-ascii?Q?Yx+wRmkWBQkGZ7UOcmSXJZKMLVyOUb9rxbLnTLVGbtqpfO9jmFwiLW3/Ge4K?=
 =?us-ascii?Q?8/zicHICoONZjsb1z5lRsg/hDoLmG2CMOkbgEx4n7KGw6ZgwyOiK0zjFQzDn?=
 =?us-ascii?Q?Qo24xbkoDHd8KeTAjGuiET40TBnJgubT+ilwzfIJ3iwILqHz1EDLQGsDmPoo?=
 =?us-ascii?Q?mhXwTrPOFNGqM6H+4IKTpgiVTl7lff03xh6FC+MQy51i3v5vZMEA7gu3DWOH?=
 =?us-ascii?Q?AjIxxfzh/8Td3PAoWRzyvv+7m/SI3NafyOCS5F9GjwT8ETFv+VzIDb3el/Jp?=
 =?us-ascii?Q?BsEqIm4QWc35MFB1U5qKAFdj+Bdv8cTVp72AVqnhfraMlpSFQmWUa/qLRqQh?=
 =?us-ascii?Q?UVEp+UMl7TjkOwnRg8AhkU7rausUZVg02x03YfqV3huIg+oj+D3kotFnrE4A?=
 =?us-ascii?Q?AHjDlxv+Gme/A0SS5pFK/cBjXJxid8vD1s3wSazQdA6567MDx72ERBSr/5uO?=
 =?us-ascii?Q?9p/oqPMw+Z1CQSgJfgzdjmEB4nZlo9GBnhaeyWLfEd6Cx40QIogopNF8rJhw?=
 =?us-ascii?Q?zzl1NaodZTZagzEVHSn64oPsPq6vzBuTJixuPC7KZ66mddjhP4zy9zCd/oHE?=
 =?us-ascii?Q?HActHQx0Viy//ZOdF8HhvKyJcRA18DvvVKBV5YbD1c3JdsxDArtH7NlQ41GC?=
 =?us-ascii?Q?krT1pfqomKwG+OfRSG344pVVjFp06gZBSPHF7DSh5OERLlHTG3lVfXWJ+2Q/?=
 =?us-ascii?Q?91bavmO4eNuSLURmUSzQKRaDODbo4QfM03S6tg5O0gqCkGgaRO6eFZc3F5a9?=
 =?us-ascii?Q?0CPPivwDx9mU6DqCMVMbAhEMnAlSQ4JSp3sTXg1KNA6dY71pM8DfgyV/x4pR?=
 =?us-ascii?Q?fuegDTJmgetsknNXXmRIIZ/gQCY6WhzXJhrWEnLjeQGlHnz+2DjI10O31B/4?=
 =?us-ascii?Q?TdBlEkMjsysm8+1JglAdc7MDnaDPj9o9ryxTvYuuzpco9HbCkr379tkVOLpH?=
 =?us-ascii?Q?IeZ1Ri94YEqTrGL2BSwaJwBTQTUmpAGGLanA0UGlCjEK4iOMkNPC00ri6+Pe?=
 =?us-ascii?Q?6AZF42jhLXris0mZo+pFYTYp1Wsz4RfmQwgI0mmrVyJ2jMGfLlqDDO6g30pM?=
 =?us-ascii?Q?Lu+YKgYu+XYghi8H/hehnYHks2tn1/S3t3ljJsVgs32sq6l9VwVHj4n7Iu1k?=
 =?us-ascii?Q?EdvxATmwDElrGpbIntYzcCLlVKy2msoc/u7/PVf2QHhuXqCWmU5cgd33yb4Q?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c67359e-09b1-4975-2261-08dbd6ad3dab
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 05:26:15.8156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuciBtX7ivJB1tylc6ypVzN2Hw+IRy35DLyJw+jXZWxv1t5VhhBF1YOYb5142urrRFTRPtrIU9D8GkgPzj9rOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7815
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_mm/slub.c:#___add_partial" on:

commit: 0805463ab860a2dde667bd4423a30efbf650b34b ("[RFC PATCH 1/5] slub: Introduce on_partial()")
url: https://github.com/intel-lab-lkp/linux/commits/chengming-zhou-linux-dev/slub-Introduce-on_partial/20231017-234739
base: git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-next
patch link: https://lore.kernel.org/all/20231017154439.3036608-2-chengming.zhou@linux.dev/
patch subject: [RFC PATCH 1/5] slub: Introduce on_partial()

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------+------------+------------+
|                                            | e050a704f3 | 0805463ab8 |
+--------------------------------------------+------------+------------+
| WARNING:at_mm/slub.c:#___add_partial       | 0          | 16         |
| RIP:___add_partial                         | 0          | 16         |
+--------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310271308.9076b4c0-oliver.sang@intel.com


[    2.344426][    T0] ------------[ cut here ]------------
[ 2.345095][ T0] WARNING: CPU: 0 PID: 0 at mm/slub.c:2132 ___add_partial (mm/slub.c:2132) 
[    2.346072][    T0] Modules linked in:
[    2.346555][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 6.6.0-rc5-00008-g0805463ab860 #1 e88a4d31ac7553ddd9cc4ecfa6b6cbc9ab8c98ab
[    2.348039][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 2.349271][ T0] RIP: 0010:___add_partial (mm/slub.c:2132) 
[ 2.349920][ T0] Code: 05 52 3f fb 05 53 48 89 f3 85 c0 75 0a 83 4b 30 01 5b e9 28 3c 06 03 48 83 c7 18 be ff ff ff ff e8 6a ec 02 03 85 c0 75 e4 90 <0f> 0b 90 83 4b 30 01 5b e9 08 3c 06 03 0f 1f 84 00 00 00 00 00 f6
All code
========
   0:	05 52 3f fb 05       	add    $0x5fb3f52,%eax
   5:	53                   	push   %rbx
   6:	48 89 f3             	mov    %rsi,%rbx
   9:	85 c0                	test   %eax,%eax
   b:	75 0a                	jne    0x17
   d:	83 4b 30 01          	orl    $0x1,0x30(%rbx)
  11:	5b                   	pop    %rbx
  12:	e9 28 3c 06 03       	jmp    0x3063c3f
  17:	48 83 c7 18          	add    $0x18,%rdi
  1b:	be ff ff ff ff       	mov    $0xffffffff,%esi
  20:	e8 6a ec 02 03       	call   0x302ec8f
  25:	85 c0                	test   %eax,%eax
  27:	75 e4                	jne    0xd
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	83 4b 30 01          	orl    $0x1,0x30(%rbx)
  31:	5b                   	pop    %rbx
  32:	e9 08 3c 06 03       	jmp    0x3063c3f
  37:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  3e:	00 
  3f:	f6                   	.byte 0xf6

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	83 4b 30 01          	orl    $0x1,0x30(%rbx)
   7:	5b                   	pop    %rbx
   8:	e9 08 3c 06 03       	jmp    0x3063c15
   d:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  14:	00 
  15:	f6                   	.byte 0xf6
[    2.352308][    T0] RSP: 0000:ffffffff86407dd8 EFLAGS: 00010046
[    2.353078][    T0] RAX: 0000000000000000 RBX: ffffea0004001000 RCX: 0000000000000001
[    2.354058][    T0] RDX: 0000000000000000 RSI: ffffffff84e8e940 RDI: ffffffff855b1ca0
[    2.355041][    T0] RBP: ffff888100040000 R08: 0000000000000002 R09: 0000000000000000
[    2.355978][    T0] R10: ffffffff86f35083 R11: ffffffff819fd2f1 R12: 0000000000000000
[    2.356822][    T0] R13: ffff888100040048 R14: 0000000000000015 R15: ffffffff886073e0
[    2.357702][    T0] FS:  0000000000000000(0000) GS:ffff8883aec00000(0000) knlGS:0000000000000000
[    2.358674][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.359469][    T0] CR2: ffff88843ffff000 CR3: 00000000064dc000 CR4: 00000000000000b0
[    2.360402][    T0] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.361328][    T0] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.362305][    T0] Call Trace:
[    2.362722][    T0]  <TASK>
[ 2.363087][ T0] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 2.365499][ T0] ? __warn (kernel/panic.c:673) 
[ 2.366034][ T0] ? ___add_partial (mm/slub.c:2132) 
[ 2.366627][ T0] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 2.367200][ T0] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 2.367743][ T0] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 2.368309][ T0] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 2.368930][ T0] ? kasan_set_track (mm/kasan/common.c:52) 
[ 2.369529][ T0] ? ___add_partial (mm/slub.c:2132) 
[ 2.370121][ T0] ? ___add_partial (mm/slub.c:2132 (discriminator 1)) 
[ 2.370706][ T0] early_kmem_cache_node_alloc (include/linux/list.h:169 mm/slub.c:2156 mm/slub.c:4308) 
[ 2.371471][ T0] kmem_cache_open (mm/slub.c:4340 mm/slub.c:4578) 
[ 2.372060][ T0] __kmem_cache_create (mm/slub.c:5140) 
[ 2.372688][ T0] create_boot_cache (mm/slab_common.c:654) 
[ 2.373317][ T0] kmem_cache_init (mm/slub.c:5075) 
[ 2.373936][ T0] mm_core_init (mm/mm_init.c:2786) 
[ 2.374519][ T0] start_kernel (init/main.c:929) 
[ 2.375103][ T0] x86_64_start_reservations (arch/x86/kernel/head64.c:544) 
[ 2.375763][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:486 (discriminator 17)) 
[ 2.376353][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:433) 
[    2.377096][    T0]  </TASK>
[    2.377447][    T0] irq event stamp: 0
[ 2.377916][ T0] hardirqs last enabled at (0): 0x0 
[ 2.378794][ T0] hardirqs last disabled at (0): 0x0 
[ 2.379684][ T0] softirqs last enabled at (0): 0x0 
[ 2.380551][ T0] softirqs last disabled at (0): 0x0 
[    2.381441][    T0] ---[ end trace 0000000000000000 ]---
[    2.384117][    T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231027/202310271308.9076b4c0-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

