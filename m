Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81777A86DB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236578AbjITOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236679AbjITOgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:36:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AA51B4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695220572; x=1726756572;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I10aoSQlZ6pxyqVufgdRp+AeoMeNfKu6tkS3p74lezI=;
  b=lJq3O5Z1hTvv3Vfu24zeZdAi91sE/GBujVzbc8m7RKDkoVxPHEYsH87U
   oVAf1RLdAnis2f6bRsKi1jT/em7nq1GImJkbvo+hxsETFcjVcUfFQLWsB
   UJsRNgfvbUPgKzI4nQVQcG9hVEMk3xJWdoLHcLUEzdqDJ3OrXgejzFomA
   sPG42oV+d60uLCH7V5pjj0WYxZO2hNjNjRxfv+sO3GgBf6PddNb9NxeAY
   rHfA9D9I6/pkzosJiqIgdJK6XKyxdXGj6dr9CJaFQ8EslXnF050b22/N3
   wraLZKqk7Ac0C4sTPf/TIrGmAGiIO5bioGO+JOroLOZ4UVmPxmx0DW975
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="379122359"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="379122359"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 07:35:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740229739"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="740229739"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 07:35:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 07:35:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 07:35:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 07:35:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1KB6ameNo+iSSQwceNwgTMBDJNuCtOVy27EAQ21M8bwy/O6Haa9hfWUdDAmD/13D5i0eLAxtKlzL3t03zHyFG1m6EfBh1ELCJdozrdIBtvNno1S671rZ+wlcSEYvVzt3XyYOFQXpNRUPgBqpmGGFjxK+gPksqvZZ7vGB3JNcFk/lHBAtj33SUKWFv/tJHeTqKJDaRy50JELWQel4m2dZ8IRxqQ7eIYTHkoyECLgEbCDPIH0RKXQXdoG/fHzLszCciXbIJEak9X3DA9wlT7sA2OUvek3VGSX/hnh9bhxta9Lsw/z+ve2m1d8O26/qimon8euqj2c4pdZzoR/PJiTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkJfjYMFuYrRVdAJMntoUSaFui6eLZKv2j+y8otrE4Q=;
 b=KxVyagWdOW7ZjVQMSesafuxuQqR/aRGZ1ZtXgSeCNFWPDgYGENuX2zVP2P01BYDoNVVO72v9O/OP0neWvGAmPXgs2hZ5M86pXlGtuje3SuMM1Nw3smSuxPHGNuhFI1ppFiNUzfkr1TX8PFimk3aKWcfJUtJ7tNy7Kh5pbOcMBJ2zWGBWR3FCjzj9+S7O3iNWRWelO6GG8Vi4EyxFd62l+oHpIhPM2L9F+NcMN40fvOuDKGttu8EAer9REsjstCd35KcwL0QKJQSEOR0tDeI4Iwqr3fwQqjVyHwhKwwfYQuIu350ZS2mPbOWB0LiciLgCVFSq/WdNV/7nVzP2J5TieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB5277.namprd11.prod.outlook.com (2603:10b6:5:388::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 14:35:23 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 14:35:23 +0000
Date:   Wed, 20 Sep 2023 22:35:13 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [paulmck-rcu:dev.2023.09.15a] [locktorture] 31f96f3c93:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202309202238.bf86a734-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4b2822-72ad-4b28-8ccd-08dbb9e6d29d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ggHUIr4Tp+zCVtGyD4wb+Z7XdAOAuJhUEHvVSJyjmhQE0rgOReTPF4bfRBr+MmvRXf2ijsh41NjteaEN3M8gmIRr/XbgXg34ibLKMAXsLUyWLiOEiH+LRBr8ycONCzFpezCqFcDOhD8T2AT9pMOuD7r4chwzkRXZym+kr+1S7nNemcVZaQm72xGjEncc4Tweqf93+og86SwiTJlFAD93yEsyRJnqUeLi/EwHDFvcj2x5xO/Hd+TT01auGlI1MJtPNFBvlb0IajWtY+L8Kt9bTcNcOFumLrJp+Tbcjn33IcM+qx2jEzR5v6+cu1FQ20P+bk8QpeIuJoTRuJy7qOiMiS7w9pIIEuZo+QSRhlBHzCp6g/ZsglF3Ye5fxaowLYQKLfL5jJP3PEnEDQNcM2MQTw74qo+3sQA9qzi058K4OTSzJEMi42Ysc//IhIBwXnMjHNQ+y4WSRqPHrq7AzYgTQNGgZUedzRBljDT7CdIm6U27MDSppUvrwbUCRaPCbJYqULti88oyju+/kJw5NHS/U8Bl1KldIVBHivIa9TNGoIDjDGCyBZUktnQWKso+KlUlwaq2GyFKPKNEy7KEnY9VZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(186009)(451199024)(1800799009)(38100700002)(6666004)(6506007)(6486002)(478600001)(82960400001)(36756003)(1076003)(86362001)(8936002)(2906002)(26005)(107886003)(5660300002)(6512007)(966005)(83380400001)(41300700001)(4326008)(6916009)(8676002)(316002)(66556008)(66946007)(66476007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qKZ8IgVKG43fTEIBeluSu5EC4AgZjpWqfzWlbs4st3zH5ynLb4c+Wdq/NL/O?=
 =?us-ascii?Q?SZ6goy9zYrKsSl9/TTvaCEcJ2FBIXJxQiPdwiWsL6YfLxinqmCBK7h/+rfzu?=
 =?us-ascii?Q?ZASiN3gu1g1qEut/MkRue0DjCzGIv+mKNeu/DXT5xY46jqpNtvvluEmuZsbF?=
 =?us-ascii?Q?Is7RT+HwkpryM/Do1ySWp95mIzays3hqsYv6WcgkltJ9UFHrwUA6QR4vITIJ?=
 =?us-ascii?Q?y/hhimq5G5XnvExYu9BQXnEnAwG4ZvymLdpBZiXB++F9qWKKZWdZGMEEFk5O?=
 =?us-ascii?Q?3iK6LO3QMMqomQA6A0fDoL1roh7MLFiSmD3cHBzwXApqTgD5aVd3b6zR4FbT?=
 =?us-ascii?Q?fj6nzEkxiu9iS+1vzYqvOufTWyltIVGmT2cjJLtTxWsHXK5SFnTZqndV5Crn?=
 =?us-ascii?Q?1cQ70bs2HV5nqYD7kRCFdzhXEGBMqYVA8AnfzKxWxZjIASeiC2T3fM6jxXcH?=
 =?us-ascii?Q?YZAYpSLONokzx4LqSSZkME+hy2qrjn1+toXzEM7V/8XO1bvTNPbmbkFvYKaZ?=
 =?us-ascii?Q?79LwArCkhl26mUctGGYUHKz+sv5svqgMr9RJgqPsu6NqxHJ712GtKu7e8d2l?=
 =?us-ascii?Q?SSNq3+av2zvt+aeMT7aKz/N6u55QfoHs5JTyajoNOQmY9+Tc5LvygrIaHyI5?=
 =?us-ascii?Q?JA3K4gP9g01Po6kp/c2ZEZagtcXt5WVGy+QGLbSphHHblW7nLUeer5zoLP5j?=
 =?us-ascii?Q?rSabzRrmOchhCxaC5FzFDPS9PFTStC5zmeJFX/Edb4dsAfoRKJjzEkh1f0es?=
 =?us-ascii?Q?9oA4gAs9GwaJ2QOFBlq8SWZyeWnd5a960vFOeZWAWHNeGfDGVVI/sZ8DRT5o?=
 =?us-ascii?Q?ed27Uxo1kvqaELXyvWV8UFQxpGbghxDnCShon7HtcALtPGZZ6rClrmDkMhzo?=
 =?us-ascii?Q?a+US/LVRYLbI4E2kyk89ebtCKLGimBdIud5LGLDIfBPqyiOTOF6DkLAFTcUa?=
 =?us-ascii?Q?mSP5MH5IUTtquZhyr+9veH1xmSsBWzCgr/BOudifhzzTO++0rfKBZQW99c77?=
 =?us-ascii?Q?JDKVbSegHUWW+/6OMMBvGWssIoW+yCC4ZdkY4pLQj3oStsIvQSZQbfSDxgX9?=
 =?us-ascii?Q?wl8IVoQsSqvWwKHhLkn40c0Y1JktrplIxo9x5XzrmwHhTzMbYoOSQ00e/RPw?=
 =?us-ascii?Q?w+Qt8TbAHDDc/M2p7zbxH1lLXjggT8MJTXkLAV/+sywbGvvkeKO5N5QQYvb4?=
 =?us-ascii?Q?M5hS2sMyuMY8tTc0fUAFJEMOGDCuqdVU+3M2X9Zd0YKP9KOpyWe6rHYOE8oe?=
 =?us-ascii?Q?edOrOj3zhyV5DEJt5KYfBMlSyqDhHzjCISimRZWpAXi4W3x/vDf81gI6+QAw?=
 =?us-ascii?Q?j0VZ6xSE1EJUeDubbkYAVqtTn/PVINY81G3Y2Gb36ssPOgatSoVgxm/crA6t?=
 =?us-ascii?Q?H7iO3E0z5AUMPJS/vc40PPCWHMVb75qvMXY66EdXpV+ZFNWRfeIi4Z+mRPf0?=
 =?us-ascii?Q?K1vfus26B7GWSBz1TP+sOVcIJruf6j2jixYHc++vrd5V4ajDcPFSmPmz5kKj?=
 =?us-ascii?Q?LnB59rMb2VoDB7ohydLxyYbmzXdXP7Doqo5G4hGwCVdi+QG3+Z6Bvw7E2Ky2?=
 =?us-ascii?Q?yM4B0+vY+oQHN3haM7PNhzhgNp3L5Gmurge357s/ODFbNrv4sGr96/goqnYl?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4b2822-72ad-4b28-8ccd-08dbb9e6d29d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 14:35:23.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FlA5RKeyg/6oUhXTNMBzCfx416CZ3pK6GCLgJNmw+nC4ZfTi7L30wxyNdHy3v/EjuvFATpHmXcnJ9LCmT4s5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5277
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 31f96f3c93f79c901c06a805e8e23383d0cd4a6c ("locktorture: Dump CPUs running writer tasks when RCU stalls")
https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2023.09.15a

in testcase: boot

compiler: gcc-7
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309202238.bf86a734-oliver.sang@intel.com


[  163.797412][    C1] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  163.797412][    C1] #PF: supervisor read access in kernel mode
[  163.805375][    C1] #PF: error_code(0x0000) - not-present page
[  163.805375][    C1] PGD 0 P4D 0
[  163.805375][    C1] Oops: 0000 [#1] SMP
[  163.805375][    C1] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc1-00062-g31f96f3c93f7 #1
[  163.805375][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 163.813385][ C1] RIP: 0010:_find_next_bit (lib/find_bit.c:133 (discriminator 2)) 
[ 163.813385][ C1] Code: fd 40 0f b6 f6 48 c7 c7 a0 13 6d 83 e8 98 01 92 ff 4c 39 e3 76 5e 4c 89 e2 48 c7 c6 ff ff ff ff 44 89 e1 48 c1 ea 06 48 d3 e6 <48> 23 74 d5 00 75 30 48 83 c2 01 48 89 d1 48 c1 e1 06 48 39 d9 73
All code
========
   0:	fd                   	std
   1:	40 0f b6 f6          	movzbl %sil,%esi
   5:	48 c7 c7 a0 13 6d 83 	mov    $0xffffffff836d13a0,%rdi
   c:	e8 98 01 92 ff       	call   0xffffffffff9201a9
  11:	4c 39 e3             	cmp    %r12,%rbx
  14:	76 5e                	jbe    0x74
  16:	4c 89 e2             	mov    %r12,%rdx
  19:	48 c7 c6 ff ff ff ff 	mov    $0xffffffffffffffff,%rsi
  20:	44 89 e1             	mov    %r12d,%ecx
  23:	48 c1 ea 06          	shr    $0x6,%rdx
  27:	48 d3 e6             	shl    %cl,%rsi
  2a:*	48 23 74 d5 00       	and    0x0(%rbp,%rdx,8),%rsi		<-- trapping instruction
  2f:	75 30                	jne    0x61
  31:	48 83 c2 01          	add    $0x1,%rdx
  35:	48 89 d1             	mov    %rdx,%rcx
  38:	48 c1 e1 06          	shl    $0x6,%rcx
  3c:	48 39 d9             	cmp    %rbx,%rcx
  3f:	73                   	.byte 0x73

Code starting with the faulting instruction
===========================================
   0:	48 23 74 d5 00       	and    0x0(%rbp,%rdx,8),%rsi
   5:	75 30                	jne    0x37
   7:	48 83 c2 01          	add    $0x1,%rdx
   b:	48 89 d1             	mov    %rdx,%rcx
   e:	48 c1 e1 06          	shl    $0x6,%rcx
  12:	48 39 d9             	cmp    %rbx,%rcx
  15:	73                   	.byte 0x73
[  163.813385][    C1] RSP: 0000:ffff88842fc05dc8 EFLAGS: 00010046
[  163.813385][    C1] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 0000000000000000
[  163.813385][    C1] RDX: 0000000000000000 RSI: ffffffffffffffff RDI: ffffffff836d13a0
[  163.813385][    C1] RBP: 0000000000000000 R08: 0000000000000010 R09: 0000000000000002
[  163.813385][    C1] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
[  163.826802][    C1] R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff84ce1520
[  163.826802][    C1] FS:  0000000000000000(0000) GS:ffff88842fc00000(0000) knlGS:0000000000000000
[  163.826802][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.833375][    C1] CR2: 0000000000000000 CR3: 0000000002ea4000 CR4: 00000000000406a0
[  163.833375][    C1] Call Trace:
[  163.833375][    C1]  <IRQ>
[ 163.833375][ C1] ? __die_body (arch/x86/kernel/dumpstack.c:421) 
[ 163.833375][ C1] ? page_fault_oops (arch/x86/mm/fault.c:702) 
[ 163.833375][ C1] ? kernelmode_fixup_or_oops+0x103/0x140 
[ 163.841375][ C1] ? exc_page_fault (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:67 arch/x86/include/asm/irqflags.h:127 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1561) 
[ 163.841375][ C1] ? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:570) 
[ 163.841375][ C1] ? _find_next_bit (lib/find_bit.c:133 (discriminator 2)) 
[ 163.841375][ C1] ? _find_next_bit (lib/find_bit.c:133) 
[ 163.841375][ C1] torture_spin_lock_dump (kernel/locking/locktorture.c:295 (discriminator 1)) 
[ 163.841375][ C1] notifier_call_chain (kernel/notifier.c:95) 
[ 163.849372][ C1] atomic_notifier_call_chain (kernel/notifier.c:231) 
[ 163.849372][ C1] rcu_sched_clock_irq (kernel/rcu/tree_stall.h:791 kernel/rcu/tree.c:3875 kernel/rcu/tree.c:2253) 
[ 163.849372][ C1] ? account_system_index_time (include/linux/cgroup.h:423 include/linux/cgroup.h:492 include/linux/cgroup.h:733 kernel/sched/cputime.c:113 kernel/sched/cputime.c:176) 
[ 163.849372][ C1] ? tick_sched_handle+0x70/0x70 
[ 163.849372][ C1] update_process_times (arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2073) 
[ 163.857379][ C1] tick_sched_timer (kernel/time/tick-sched.c:1492) 
[ 163.857379][ C1] __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kernel/time/hrtimer.c:1752) 
[ 163.857379][ C1] hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
[ 163.857379][ C1] __sysvec_apic_timer_interrupt (arch/x86/include/asm/jump_label.h:27 include/linux/jump_label.h:207 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1081) 
[ 163.857379][ C1] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074 (discriminator 14)) 
[  163.857379][    C1]  </IRQ>
[  163.857379][    C1]  <TASK>
[ 163.865377][ C1] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
[ 163.865377][ C1] RIP: 0010:_raw_spin_unlock_irqrestore (kernel/locking/spinlock.c:195) 
[ 163.865377][ C1] Code: 0f 95 c6 48 89 c5 31 c9 31 d2 40 0f b6 f6 e8 0e 6e 17 ff 48 85 ed 74 05 e8 94 9d fe ff 48 85 db 74 01 fb 65 ff 0d 3f 20 0a 7e <5b> 5d c3 0f 1f 40 00 e8 5b 64 fb fe 53 48 89 fb 65 ff 05 28 20 0a
All code
========
   0:	0f 95 c6             	setne  %dh
   3:	48 89 c5             	mov    %rax,%rbp
   6:	31 c9                	xor    %ecx,%ecx
   8:	31 d2                	xor    %edx,%edx
   a:	40 0f b6 f6          	movzbl %sil,%esi
   e:	e8 0e 6e 17 ff       	call   0xffffffffff176e21
  13:	48 85 ed             	test   %rbp,%rbp
  16:	74 05                	je     0x1d
  18:	e8 94 9d fe ff       	call   0xfffffffffffe9db1
  1d:	48 85 db             	test   %rbx,%rbx
  20:	74 01                	je     0x23
  22:	fb                   	sti
  23:	65 ff 0d 3f 20 0a 7e 	decl   %gs:0x7e0a203f(%rip)        # 0x7e0a2069
  2a:*	5b                   	pop    %rbx		<-- trapping instruction
  2b:	5d                   	pop    %rbp
  2c:	c3                   	ret
  2d:	0f 1f 40 00          	nopl   0x0(%rax)
  31:	e8 5b 64 fb fe       	call   0xfffffffffefb6491
  36:	53                   	push   %rbx
  37:	48 89 fb             	mov    %rdi,%rbx
  3a:	65                   	gs
  3b:	ff                   	.byte 0xff
  3c:	05                   	.byte 0x5
  3d:	28 20                	sub    %ah,(%rax)
  3f:	0a                   	.byte 0xa

Code starting with the faulting instruction
===========================================
   0:	5b                   	pop    %rbx
   1:	5d                   	pop    %rbp
   2:	c3                   	ret
   3:	0f 1f 40 00          	nopl   0x0(%rax)
   7:	e8 5b 64 fb fe       	call   0xfffffffffefb6467
   c:	53                   	push   %rbx
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	65                   	gs
  11:	ff                   	.byte 0xff
  12:	05                   	.byte 0x5
  13:	28 20                	sub    %ah,(%rax)
  15:	0a                   	.byte 0xa


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230920/202309202238.bf86a734-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

