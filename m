Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB0779A310
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjIKF5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjIKF5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:57:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6510D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 22:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694411831; x=1725947831;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Kww4x7buINZ4V4/C0NfS1DMNk8c7fnPKZ8tti2Lshpc=;
  b=G3hicqDrbH/tHyQ+s+eHJZsFgfQ+NaPd1Zg2UUuVRKFMFgrBavMVKQDX
   H+lJa2mNqkpX+HPHGjFwuPWSQq/3Flkqkbu9Lx3+o2oQNC/Z6jixHE/gy
   ijxdOwx1MLrHpMkKc4Nbgekf4rbW+X2jVwhnBWcBx3oZ1E13Ubii3S2Vv
   WffiDfqYWiWbYE0mC/mEBpHXrlC/kWzkv27MhbLZp4aqfq6Klgt13kexY
   LIL244bNrMo/9/vXS4TxYrWoGqD93OvB7iik/LAeIhWthW5FiZIDyDS6d
   kHv9ECqo+j1WHfz45O5RJ0Qq127X9AalTOUSQwgQarfLzXqPkioyb5r4+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="358305078"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="358305078"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2023 22:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="1074013788"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="1074013788"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2023 22:57:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 22:57:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 10 Sep 2023 22:57:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 10 Sep 2023 22:57:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 10 Sep 2023 22:57:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFRqgFPxZpFuamfblzWnQ/sFkebep4u84aFMugyEi6Ocw4LSrgswB8aZp/hIj7DHSBU1f9WX/QvyWSk6B44C4htweI/nn/WXx1kwK0UvMCofti8mWUsa31lLJljU2dshPhmupuRfPLdDSDYCLQEI2vd9uECRey1BYV1MlzlOL+qh41j6kV1os+1SMQQcNxTfgwraU4Yk0S2W7YcqZ5IQgsolKgDdaVjKyFXn2roKmKQq0euCC6vND0djGqIlQf33pYldjnY2l9dFYFtS7CvhAXSnp0bJNVbFzScWbQfqtIzkJhmB8MxXyQvHQnr1x/YY65bLZgkj54e2uOKQIZgkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMCt0nmQ0Ce8pSipzksGcoeEAnps2CA4FfWwZB2XmNc=;
 b=bJu+QYSRkkeZOmnwpSCUNKyYjuzotX0bX0c0LSdPXO3XRx8gsWu+V/J3byRU3Vg1xcP2pvaqvQOoRNgZfJ6w0FwXHsQv9OcSgphZLV/1i+ZRsTzkdRcx1npUmGSkqy+mtuPKk4UH+z8KqYH41EJHdAPR7bKdV5K3TzdtCHwoy4fK7cZrvLDhNrabfMC4OrRUAbVde8B/JL6hrLTMC/bP2HL57tjJ24tBuCwSIR1NV00uSRZBVHxyzmh1eEd2bsBGXP5hDn3UdxJHz2hVwT8ryogzzO0WJZnUxT70WlOKqJoNf/5D/N6NrEDjfMYtqRAzV88S9oXWzq5pAvz118+AiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Mon, 11 Sep 2023 05:57:04 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 05:57:04 +0000
Date:   Mon, 11 Sep 2023 13:56:52 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
        "David Rientjes" <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        "Hyeonggon Yoo" <42.hyeyoo@gmail.com>,
        Jay Patel <jaypatel@linux.ibm.com>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <oliver.sang@intel.com>
Subject: Re: [PATCH 4/4] mm/slub: refactor calculate_order() and
 calc_slab_order()
Message-ID: <202309111340.f59c3f22-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230908145302.30320-10-vbabka@suse.cz>
X-ClientProxiedBy: SI2PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:194::15) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DS0PR11MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ea0523-b276-40b3-57b0-08dbb28bec7c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuaSz+rqWPK/sd6LVG0Y5YghT36TxkAiCbZ04Y5aX+er6KCH+8ZeOKuDvaOgX78pVrW4ekyuOOdUQt7dCBsVKgf6GUH3CBEWQjfGaHU7DI6bzuSz08Kil1YLj6Bh+jc4IB5oz+Aa1kxJmaF21jzKreiD4bsF+1HNf8Kng1MLxAb0ZIGLhjGG+ENnWiGUcXjTAw7Kt9nxI16mk2y3moM8Z46xrk4FtFdLLGPJswZKMZ/6zF4OPHk0qAzNIXLGTwZ6eZFQgslf4fEdFmLgND5jb5renaFxlREl4xIbMYEvgP5iCB0w+lcH0y6tHqZx9328+QUFZc1j405IP5XDNDQoblOV8PSUNqmFm33xHZ+02/3CsjEYwJIk501yPrsxueR/zZ0mtGTtgNmRd2mWyABXAfpCU/4Z8ooEpgjvq2gWjc/gTDAW33UxREhclyhAUbrCI9UGDXwrzX+/00ubbmwKwQyJci/Frsa1WnH+7rBWeF9ofvl7XHjkcPwqBW+UNHambfMHSy9zNrprfWy2mdGFjnxtd/qm1JKhuEu/D2feDg2iIJIV4wPvt/r9n9gOve0XZZOUoOSYmLlRuNRSsb7tZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(82960400001)(38100700002)(36756003)(86362001)(478600001)(2906002)(6512007)(4326008)(966005)(316002)(6666004)(8936002)(6506007)(8676002)(6486002)(5660300002)(66556008)(54906003)(66946007)(6916009)(41300700001)(66476007)(7416002)(83380400001)(1076003)(107886003)(2616005)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TCFzg3txeeR3ayGQ/AELmIcyU+HdcDvd5Ll53yyGNsnoFweipUV4PS2KiaXK?=
 =?us-ascii?Q?8W2KY/tMsnxiUBGxL99jWt1nk8AZSqvMhKXI+oCXnjbBvF83q4OgHblXM1ie?=
 =?us-ascii?Q?j4Lkq1aMmn6vYJ88QM9pH3WH+oqMJ7mchRmUqKmjLNFqVQEA7nEFCHtaEj5a?=
 =?us-ascii?Q?UPeXFFodKQlG01nuXkFXp1cIHenW7oS2FuLdngcXN7+AqKHCqbKYK9bb32CQ?=
 =?us-ascii?Q?dCkQYygKDdIerdt7gfK9cf8KGaebjx5QU3hVcyOk/H666xT1X5cSn0bbWIZU?=
 =?us-ascii?Q?yNJO5DvvlgRig/+FHuf2aEDjLArNrrzoqIlZ1AO9ixh42RbjMfZr/8b/Kckf?=
 =?us-ascii?Q?1RL6m56U5FfKsO4Zh1DmGkN1gOmy1deTL4IqbHbTSTvY4Syy8T9SVPmZgWxJ?=
 =?us-ascii?Q?11X+/gg1FSyAe63XvRPGtaETit/ix0lhS7UXdp4c9S+IVOq4WlZruC2dug05?=
 =?us-ascii?Q?ua4lnRtxA9YMJf2PnMUvi6z5Ml2JfHUsdb7dol7qVLJWasq02IKwbjV6dtFK?=
 =?us-ascii?Q?yUHoZXCeSB6e7iQbCWdB4NF+pL+kXMclGK4WaWZ6YgkxZP5DTs5zIf+JyKnF?=
 =?us-ascii?Q?WwzUPw+hugi9iGt06iwWU/LH8GARHH9QmRNXCE/sfZT/csnuWFhEJvd4IKGh?=
 =?us-ascii?Q?M1qXfX+UsSrr9lxajvrunMfsS1dMqR9lDfnHffp/5mC2kDbvfJjwjK51A73i?=
 =?us-ascii?Q?qZ8uon9QlsCXiHrFWuA08qyZ1XdeMrt7GyuJYLjhXUZagzirxjgOJ4wTo7d4?=
 =?us-ascii?Q?/L3hLrbPtXciGoloQL8McL52MfN1SPsqlabbt7qRyTtxvllsyuerf87vsM3H?=
 =?us-ascii?Q?cYwjxAB2Imy/VU3mIlGJ1SF50SFu2k3mPbTDzhSDO7SmS6f8DB3tyOq8m7SD?=
 =?us-ascii?Q?ggNU7lD3Bokq6ao0rCDTRYVXWwEW2koE5C6bLOwILCZr/fRRL+iqcDqk8rmZ?=
 =?us-ascii?Q?3SBn7Vzv5EFFau8NUXooyp/94bQJWJNBJlsxIjtM2DIY/ZTwrL68GBbaG8Di?=
 =?us-ascii?Q?LdYpgB8Uok2A/2xKPbGPcnbEWJ6ajHiOED+V3jq489PIgLksU2e5EzjpUiSx?=
 =?us-ascii?Q?zYKLKPupWDxMBsE4PMM3TSCrBPEU4l0bGNTan6h1CUjf3xsesjnmQvwAo3OK?=
 =?us-ascii?Q?bwSErFj3FNdITxgg0jC2n0ClUGw5+EjIKOSRwHHFl3uRygFeplmKRNehIJ5p?=
 =?us-ascii?Q?0UHamIzK6BRHjxYqxBH4vZwF/rp8hgp9vnryPJ9xjEqWI3ctA5daDdu8T/Rt?=
 =?us-ascii?Q?k1aaOrFpMf6SpVQ87yhA5W3yi6P8SYBPbKN0H9z/L0lW7/saI1ychR7/VTKM?=
 =?us-ascii?Q?08oFDd8uNH6tU+dv44Ywbcxlhw+AbEAC+giywoZ1dmo53riNJPhc1boUoNBB?=
 =?us-ascii?Q?qTQhxkQeED+E4ailcK9iZ5e0FeSBse+j55T9rWvNOKyCeJtGqfn/80BDt+YX?=
 =?us-ascii?Q?8U4YUxk/wrXMes4GFj8Ilw/MHrXahYWnKasZPdZegwOFNCNJP/tm+MonvE/2?=
 =?us-ascii?Q?1YGP/d96cvgjvNkYCLNZye1ELjKYH26qmBswQ/w9w5GKB1noyGYhfuPc8RXQ?=
 =?us-ascii?Q?NGAFbVo/X4eJ0mDFMVaZXtQHUED6Nio1xBuHAV1n6j4NFhzllveJbEDsQPe0?=
 =?us-ascii?Q?EQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ea0523-b276-40b3-57b0-08dbb28bec7c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 05:57:04.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rORd6ZPzI5rvhVM6e//1TU1tQNryEjco1YYouMdbfZ07Qt9t7tRvTznkvZTgxIFLzubwEZuUCHz4aK1cFklPdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6399
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "UBSAN:shift-out-of-bounds_in_mm/slub.c" on:

commit: f04d441027621c16081803832a54f59272112cf5 ("[PATCH 4/4] mm/slub: refactor calculate_order() and calc_slab_order()")
url: https://github.com/intel-lab-lkp/linux/commits/Vlastimil-Babka/mm-slub-simplify-the-last-resort-slab-order-calculation/20230908-225506
base: git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-next
patch link: https://lore.kernel.org/all/20230908145302.30320-10-vbabka@suse.cz/
patch subject: [PATCH 4/4] mm/slub: refactor calculate_order() and calc_slab_order()

in testcase: boot

compiler: clang-16
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-------------------------------------------------+------------+------------+
|                                                 | a17847b835 | f04d441027 |
+-------------------------------------------------+------------+------------+
| UBSAN:shift-out-of-bounds_in_mm/slub.c          | 0          | 12         |
+-------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309111340.f59c3f22-oliver.sang@intel.com


[    0.901457][    T0] UBSAN: shift-out-of-bounds in mm/slub.c:463:34
[    0.902458][    T0] shift exponent 52 is too large for 32-bit type 'unsigned int'
[    0.903477][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G                T  6.5.0-rc1-00009-gf04d44102762 #1
[    0.904450][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    0.904450][    T0] Call Trace:
[    0.904450][    T0]  <TASK>
[ 0.904450][ T0] dump_stack_lvl (lib/dump_stack.c:107) 
[ 0.904450][ T0] dump_stack (lib/dump_stack.c:114) 
[ 0.904450][ T0] ubsan_epilogue (lib/ubsan.c:218) 
[ 0.904450][ T0] __ubsan_handle_shift_out_of_bounds (lib/ubsan.c:?) 
[ 0.904450][ T0] ? tdx_handle_virt_exception (arch/x86/include/asm/shared/tdx.h:60 arch/x86/coco/tdx/tdx.c:375 arch/x86/coco/tdx/tdx.c:430 arch/x86/coco/tdx/tdx.c:650 arch/x86/coco/tdx/tdx.c:666) 
[ 0.904450][ T0] ? kmemleak_alloc (mm/kmemleak.c:977) 
[ 0.904450][ T0] __kmem_cache_create (mm/slub.c:? mm/slub.c:4159 mm/slub.c:4473 mm/slub.c:4507 mm/slub.c:5104) 
[ 0.904450][ T0] ? kmem_cache_alloc (mm/slub.c:3502) 
[ 0.904450][ T0] kmem_cache_create_usercopy (mm/slab_common.c:236 mm/slab_common.c:340) 
[ 0.904450][ T0] fork_init (kernel/fork.c:1048) 
[ 0.904450][ T0] ? kmem_cache_create (mm/slab_common.c:395) 
[ 0.904450][ T0] start_kernel (init/main.c:1046) 
[ 0.904450][ T0] x86_64_start_reservations (??:?) 
[ 0.904450][ T0] x86_64_start_kernel (arch/x86/kernel/head64.c:486) 
[ 0.904450][ T0] secondary_startup_64_no_verify (arch/x86/kernel/head_64.S:441) 
[    0.904450][    T0]  </TASK>
[    0.904457][    T0] ================================================================================
[    0.905560][    T0] LSM: initializing lsm=lockdown,capability,landlock,yama,safesetid,integrity
[    0.906497][    T0] landlock: Up and running.



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230911/202309111340.f59c3f22-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

