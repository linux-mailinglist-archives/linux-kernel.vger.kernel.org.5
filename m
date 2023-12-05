Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973728049A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbjLEGBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEGBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:01:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261A2C0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701756117; x=1733292117;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TyUDS73daW/pq8VVNOAFKhiSYv08dVS3P96+YwOifA8=;
  b=RRsCnRyn2M+v8OXZpRJKsGN9SxgP9rAMuATt7FsrpoB/hylMl2nTyKPg
   OWN3nD9O3gFGHlzfxAS2TT0YVYurHzZej29sZ3yK6tenjKuwEBqCjlEbW
   Vp/dmRtVFr29/zzb0XwlyPKM6BEZxi3mBYx4Kfo87FEtakgcQOK8GceKx
   9zSqdjEqFuOkaTrUNVqQcAztlong22LbgGeMMDRqZbseSy3SvkFy1NBLv
   WNctJQ5zb4teehg+a674hN26+4phvCd5m/3Hs1mlbpGbdwCSIWeuHgIxy
   FRVRRPqimLbOX7xMT5maSIwOuDV26Mj7AjLtDEGrXN+7YUZ2T8sWXNSqs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="726464"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="726464"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 22:01:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="770795590"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="770795590"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 22:01:56 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 22:01:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Dec 2023 22:01:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 22:01:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7KidtmNVWqFjowXwWbBvm/EmccCXVcE8Pm+6vA0iKF6y4cKswXnRsAShhAJvlqemL4kY/5JNDL/DWRL1c6/9lenP2r2anwVX+YfB5YxDH33OwM/TItj8/XIH99fKF8sMh9SZuWhktv+4SVnPnlOYEqVxJylpg+etxI6MM5pGgJYoJsnw/uGkmHer7D0CrJwoSIARVhXeTBGfghFGHm840h4QlR8YHLQi3iPd5s52n/QunYJNWrvzbJ0RzYnUZGskRBIjYM9ly4OjGnjcBx/BDm319gFgLE925M8S5RCz/Hsof8LNIs08eyb40J6CqLyUz5K/bxEn8Q/3ijSntQX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyZsjeDRwE4dH62R4bpTAklxdVGVCx9NmN3l6z2qzvg=;
 b=X/gQMSuSXgxzTli5y5mYxy6sEyHVTvcLQ6jEYfTNeBtsZkVgw+/nZZVm+f8hPjTyqROXfhwXpNDij34j5BUzvBYyzKZEXckFeIUlVW4e3GIMB2hEXZd12sqMvPsthxm/sk+2DF3iWj7T8PV6RQt7jHwTMMzrVXWV+NBmLoXf5LqdVOiWLWcOeY5WI4b3/VhU+HXHtXCCfcFwDhy+zufVsUAyKMFGHCCTm/TrwLR36lYmWDLDy219cdrI6R5NQ0P4FTY5Xx0ULO3OnCXhn/WJ/UrhlqgNd5hCvIzKosIwyam2qn8ZG9zL7UPcJyQzeegrAwPNLoDdsMQ4AAjo/0wRww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by DS0PR11MB6445.namprd11.prod.outlook.com (2603:10b6:8:c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Tue, 5 Dec
 2023 06:01:54 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 06:01:54 +0000
Date:   Tue, 5 Dec 2023 14:01:46 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Michal Marek <mmarek@suse.com>
Subject: Re: fs/nilfs2/btree.c:1863: warning: No description found for
 parameter 'btree'
Message-ID: <ZW68yrp+tDpafdE1@rli9-mobl>
References: <202312051316.CGxfBMux-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202312051316.CGxfBMux-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|DS0PR11MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: b999a088-4503-47f7-9aa0-08dbf557ae4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+oA3w44Hc+iIgbAEEk2vGY7s0JDfF7eQQR6mzGMvcD1bNMNDvnzYoLR+FmIksZmAKOlLWu69Pkc1geBsz2j+NCtCxTIMleMleId/VfZMNdduXU8yjlhS1xvDQu6H2hK2+cvfGLSgTCsN0zKPzguVg/z52eWpSpBEMCCcZ7CBTKw2mgBKHFcDUUHnVufhO+4gDUXCBa129crZtue2dR4BMdcLWSxr1w1LTNloLm070GlpjSB4i8yta55WNljv/NSg8xSRS12dYmCFgayuJAxEdEGV4AyO/+FdFHlZHQ+3xfm6CGxqMK86nKRFN9dlc5DJ0kwkvwaD4rBGshO2NgnhW9axq6jtQFZwcqZe6H0MMjh0FdO+BCZCohRBwFiaomAMQ1ZVz4eWYZP0st6z/KHJRcvQwhwK0klWXgHiWb4p2X4mKOsELk7cuwlT8WoEeiFVosYMMU9NFxNFZX6tk1jyydPtXJFw4yCJngPVx5icZFvP57dTF0ZG7k+RLxRa4yAy/VG6GEXjGXhMLZkBlZGfwYVi2p9A5xHb5gazfRAObr1jZ7eY/x6E+YD1RXr2cwDq8shmMSMXU5DhRrWysonRENiVMcinQ2uWRuvBUP35Z2W6lydff6TKREZa5xZ5BY//OwAwaSHdfoKLqgwlUWxq7dwCvEylh/nhrs+BZCtySnhUOWL4RI5L+BpGGoH6wqW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(39860400002)(366004)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(44832011)(30864003)(86362001)(6666004)(5660300002)(2906002)(83380400001)(66476007)(6862004)(4326008)(966005)(8936002)(316002)(8676002)(54906003)(66556008)(6636002)(66946007)(33716001)(6506007)(478600001)(6486002)(6512007)(9686003)(26005)(82960400001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VPmrPxEtaY+vO/dOOUWxWm2yHKZke5MzffbwlSFLvZPoViYLGBiz+MWaoTs?=
 =?us-ascii?Q?7YwVnA64N6ccZ9/dXpdiJdtq8kmjYy2Uv/giEwJs2KVmp20gGibNzdCdlspR?=
 =?us-ascii?Q?GKixLJh9z1X0hb4Vp6wVcuOJUB0IYys7RQKONEhBtD39OHpR1u3PdUBeo7u2?=
 =?us-ascii?Q?XdJBbA7Dr++F6eWwiz/hXJTlWJWV9iecvOAy1fJoXAIEZqSmPSD/omPrEtgp?=
 =?us-ascii?Q?spguSp7BQdyuwUhe9A/Ly1WJdw2krg69o7z22NlaEQ7bmesyjpH+7+myTQv9?=
 =?us-ascii?Q?HGBhDlLjKMV8YB2uTe7gF0kV7esR5hrWQK3QE8nsfmNXkq267m26iQSdwxQB?=
 =?us-ascii?Q?KKtuwRJE6yTAT9m42SOGrqc2uwuUgARCw4ZI4c0pS2M1NU54JOXHyP+K98CS?=
 =?us-ascii?Q?ayyYpDmqVNSR0QzksGYVcJR3qSJdyzp+/wTXB7RxOJ4w/kmXemS9nKa87l+q?=
 =?us-ascii?Q?7QUzvpLAmZHIguE3/QdewlcIUZnO0SmSasVXqTeGLOWGmv4qBKzS9S8kDuG6?=
 =?us-ascii?Q?0fIno8L83dDvNKtFTz1RR+BgONHmzsppcDZ2vPM2dpCAm2xTOPs8lzJELhQ9?=
 =?us-ascii?Q?wibB/CTl9aXleIp3lvx0vE0GhRoEdNz79GCYhidlnxLbfzgPgchEh/okCXr+?=
 =?us-ascii?Q?xmWBslL8YpaTp0E6vtbvvpzq8JVem5G8l+nU57+b66MMbUXGsAFhJezVHRvq?=
 =?us-ascii?Q?70N55wvQGUe/PsthxVzxl/hBwPDjXyDlK38CzNfMoxY3xDZI2gJWnbI2ShBV?=
 =?us-ascii?Q?kOlgEjkoHRChiBD+BWxuVGGBaGdpyZK6ruZvW/IluH/MyxpoqSV9ZAoi3KYr?=
 =?us-ascii?Q?TUZH6z5YxAE23dqcQ6uUOY2nvWLLs49f7auT3/vSQ2OTTQHweLtNLVhJ1cwS?=
 =?us-ascii?Q?Xw/bWHou2WCm/5OYRIBnhi2cCw21X28IvET4VE7RsukLajGr+RYRDurwSfJY?=
 =?us-ascii?Q?V2JOHmqN9HIjlPscwjVTvAiMDwyInetOcIgonHgAZ7CqxmrGR70OnGTy1tP4?=
 =?us-ascii?Q?uPb8Dure7N1ELviHLluN6zLPYLj85pzprsD94Iv9rt56IRD24HWhQVIP7j4D?=
 =?us-ascii?Q?zpPDRR0vrmSHw0/0sL0VkARGjfkeW+MGUsEpoRy/UlaS5AkUtPIBm5qfZlvB?=
 =?us-ascii?Q?ckuwipfRmQZ+YmhPjP3PcH6M4O5v/TD0f6wb78PK4yjI5OkHfvOUhPSBQydm?=
 =?us-ascii?Q?gP4jbJNZPAiYeQ7FUn9ulvP1Qn1AE99GpV4YDkJv3QAdk8M/YvhGxszCqckh?=
 =?us-ascii?Q?HTI8NMuTA5OOjqfD/dqJfMMvaebocPKcI1I/grJeKPuzW6OsC1dYvV2jDp5h?=
 =?us-ascii?Q?/TNYfntDcp/Bwe/OhsdZeTHx9N30oYBAG3CXFfp1zir6xBC/N2JdUeuo537E?=
 =?us-ascii?Q?w8GDvsQBlIJcfAgF8sJpn9GkMeGmqmFtkSJlCjel8+5gey0EPyyRPg30M19g?=
 =?us-ascii?Q?wWYU/ORLqzJJRbkSPVIQU7iLNadc/TQlJx3ufDFbO1Uu6Kg6XwBEjduGnCa0?=
 =?us-ascii?Q?UvGymAVxn9QSrnbekGnt+Vn133tol34NTmbRGNgLfmDU+s+pd0IhZFSdO3rt?=
 =?us-ascii?Q?m26ZX7pk2/eynEHJd9+FqDXSqLo2TgJr0OXZlI6/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b999a088-4503-47f7-9aa0-08dbf557ae4e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 06:01:54.1778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNTqv/u6Y4dWa4UtGa+r+8JH5r1Ztje5azo/zabFZ6s9Ap5vT1GnxxqbCfq9+mPevEKbqB8OI1bm8m4q7c5U2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6445
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

On Tue, Dec 05, 2023 at 01:53:10PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
> commit: 4efca4ed05cbdfd13ec3e8cb623fb77d6e4ab187 kbuild: modversions for EXPORT_SYMBOL() for asm
> date:   7 years ago
> config: i386-buildonly-randconfig-005-20231120 (https://download.01.org/0day-ci/archive/20231205/202312051316.CGxfBMux-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051316.CGxfBMux-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of

Kindly ignore this report, the found commit is not related to the warnings.
Sorry about the false report.

> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312051316.CGxfBMux-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'btree'
> >> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'key'
> >> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'ptr'
> >> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'keys'
> >> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'ptrs'
> >> fs/nilfs2/btree.c:1863: warning: No description found for parameter 'n'
> --
>    arch/x86/include/asm/bitops.h: Assembler messages:
>    arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
>    arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
>    arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
>    arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
> >> fs/nilfs2/btnode.c:167: warning: No description found for parameter 'btnc'
> >> fs/nilfs2/btnode.c:167: warning: No description found for parameter 'ctxt'
>    fs/nilfs2/btnode.c:237: warning: No description found for parameter 'btnc'
>    fs/nilfs2/btnode.c:237: warning: No description found for parameter 'ctxt'
>    fs/nilfs2/btnode.c:278: warning: No description found for parameter 'btnc'
>    fs/nilfs2/btnode.c:278: warning: No description found for parameter 'ctxt'
> --
> >> fs/nilfs2/recovery.c:580: warning: No description found for parameter 'root'
> --
> >> fs/nilfs2/sufile.c:575: warning: No description found for parameter 'sustat'
>    fs/nilfs2/sufile.c:575: warning: Excess function parameter 'stat' description in 'nilfs_sufile_get_stat'
> --
> >> fs/nilfs2/bmap.c:387: warning: No description found for parameter 'bh'
>    fs/nilfs2/bmap.c:387: warning: Excess function parameter 'bhp' description in 'nilfs_bmap_assign'
> --
>    arch/x86/include/asm/bitops.h: Assembler messages:
>    arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
> >> fs/nilfs2/ioctl.c:128: warning: No description found for parameter 'inode'
> >> fs/nilfs2/ioctl.c:128: warning: No description found for parameter 'argp'
>    fs/nilfs2/ioctl.c:139: warning: No description found for parameter 'inode'
> >> fs/nilfs2/ioctl.c:139: warning: No description found for parameter 'filp'
>    fs/nilfs2/ioctl.c:139: warning: No description found for parameter 'argp'
>    fs/nilfs2/ioctl.c:193: warning: No description found for parameter 'inode'
>    fs/nilfs2/ioctl.c:193: warning: No description found for parameter 'argp'
> --
> >> fs/nilfs2/super.c:124: warning: No description found for parameter 'sb'
> >> fs/nilfs2/super.c:124: warning: No description found for parameter 'function'
> >> fs/nilfs2/super.c:124: warning: No description found for parameter 'fmt'
> --
>    arch/x86/include/asm/bitops.h: Assembler messages:
>    arch/x86/include/asm/bitops.h:257: Warning: no instruction mnemonic suffix given and no register operands; using default for `btr'
>    arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
> >> fs/nilfs2/inode.c:81: warning: No description found for parameter 'inode'
> >> fs/nilfs2/inode.c:81: warning: No description found for parameter 'blkoff'
> >> fs/nilfs2/inode.c:81: warning: No description found for parameter 'bh_result'
> >> fs/nilfs2/inode.c:81: warning: No description found for parameter 'create'
> >> fs/nilfs2/inode.c:153: warning: No description found for parameter 'file'
> >> fs/nilfs2/inode.c:153: warning: No description found for parameter 'page'
>    fs/nilfs2/inode.c:167: warning: No description found for parameter 'file'
> >> fs/nilfs2/inode.c:167: warning: No description found for parameter 'mapping'
> >> fs/nilfs2/inode.c:167: warning: No description found for parameter 'pages'
> >> fs/nilfs2/inode.c:167: warning: No description found for parameter 'nr_pages'
> >> fs/nilfs2/inode.c:985: warning: No description found for parameter 'flags'
> --
> >> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'cpfile'
> >> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'cnop'
> >> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'mode'
> >> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'buf'
> >> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'cisz'
> >> fs/nilfs2/cpfile.c:573: warning: No description found for parameter 'nci'
>    fs/nilfs2/cpfile.c:590: warning: No description found for parameter 'cpfile'
> >> fs/nilfs2/cpfile.c:590: warning: No description found for parameter 'cno'
>    fs/nilfs2/cpfile.c:916: warning: No description found for parameter 'mode'
>    fs/nilfs2/cpfile.c:916: warning: Excess function parameter 'status' description in 'nilfs_cpfile_change_cpmode'
> >> fs/nilfs2/cpfile.c:955: warning: No description found for parameter 'cpstat'
>    fs/nilfs2/cpfile.c:955: warning: Excess function parameter 'stat' description in 'nilfs_cpfile_get_stat'
> --
>    arch/x86/include/asm/bitops.h: Assembler messages:
>    arch/x86/include/asm/bitops.h:211: Warning: no instruction mnemonic suffix given and no register operands; using default for `bts'
> >> fs/nilfs2/gcinode.c:189: warning: No description found for parameter 'nilfs'
> --
> >> drivers/iio/dac/ad7303.c:50: warning: No description found for parameter 'vdd_reg'
> >> drivers/iio/dac/ad7303.c:50: warning: No description found for parameter 'vref_reg'
> >> drivers/iio/dac/ad7303.c:50: warning: No description found for parameter '____cacheline_aligned'
> >> drivers/iio/dac/ad7303.c:50: warning: Excess struct/union/enum/typedef member 'data' description in 'ad7303_state'
> ..
> 
> 
> vim +/btree +1863 fs/nilfs2/btree.c
> 
> 17c76b0104e4a6 Koji Sato       2009-04-06  1850  
> 17c76b0104e4a6 Koji Sato       2009-04-06  1851  /**
> 17c76b0104e4a6 Koji Sato       2009-04-06  1852   * nilfs_btree_convert_and_insert -
> 17c76b0104e4a6 Koji Sato       2009-04-06  1853   * @bmap:
> 17c76b0104e4a6 Koji Sato       2009-04-06  1854   * @key:
> 17c76b0104e4a6 Koji Sato       2009-04-06  1855   * @ptr:
> 17c76b0104e4a6 Koji Sato       2009-04-06  1856   * @keys:
> 17c76b0104e4a6 Koji Sato       2009-04-06  1857   * @ptrs:
> 17c76b0104e4a6 Koji Sato       2009-04-06  1858   * @n:
> 17c76b0104e4a6 Koji Sato       2009-04-06  1859   */
> e7c274f8083793 Ryusuke Konishi 2010-07-10  1860  int nilfs_btree_convert_and_insert(struct nilfs_bmap *btree,
> 17c76b0104e4a6 Koji Sato       2009-04-06  1861  				   __u64 key, __u64 ptr,
> 3033342a0b7604 Ryusuke Konishi 2009-05-24  1862  				   const __u64 *keys, const __u64 *ptrs, int n)
> 17c76b0104e4a6 Koji Sato       2009-04-06 @1863  {
> 4f05028f8d1af7 Ryusuke Konishi 2015-11-06  1864  	struct buffer_head *bh = NULL;
> 17c76b0104e4a6 Koji Sato       2009-04-06  1865  	union nilfs_bmap_ptr_req dreq, nreq, *di, *ni;
> 17c76b0104e4a6 Koji Sato       2009-04-06  1866  	struct nilfs_bmap_stats stats;
> 17c76b0104e4a6 Koji Sato       2009-04-06  1867  	int ret;
> 17c76b0104e4a6 Koji Sato       2009-04-06  1868  
> 17c76b0104e4a6 Koji Sato       2009-04-06  1869  	if (n + 1 <= NILFS_BTREE_ROOT_NCHILDREN_MAX) {
> 17c76b0104e4a6 Koji Sato       2009-04-06  1870  		di = &dreq;
> 17c76b0104e4a6 Koji Sato       2009-04-06  1871  		ni = NULL;
> 17c76b0104e4a6 Koji Sato       2009-04-06  1872  	} else if ((n + 1) <= NILFS_BTREE_NODE_NCHILDREN_MAX(
> e7c274f8083793 Ryusuke Konishi 2010-07-10  1873  			   1 << btree->b_inode->i_blkbits)) {
> 17c76b0104e4a6 Koji Sato       2009-04-06  1874  		di = &dreq;
> 17c76b0104e4a6 Koji Sato       2009-04-06  1875  		ni = &nreq;
> 17c76b0104e4a6 Koji Sato       2009-04-06  1876  	} else {
> 17c76b0104e4a6 Koji Sato       2009-04-06  1877  		di = NULL;
> 17c76b0104e4a6 Koji Sato       2009-04-06  1878  		ni = NULL;
> 17c76b0104e4a6 Koji Sato       2009-04-06  1879  		BUG();
> 17c76b0104e4a6 Koji Sato       2009-04-06  1880  	}
> 17c76b0104e4a6 Koji Sato       2009-04-06  1881  
> e7c274f8083793 Ryusuke Konishi 2010-07-10  1882  	ret = nilfs_btree_prepare_convert_and_insert(btree, key, di, ni, &bh,
> 17c76b0104e4a6 Koji Sato       2009-04-06  1883  						     &stats);
> 17c76b0104e4a6 Koji Sato       2009-04-06  1884  	if (ret < 0)
> 17c76b0104e4a6 Koji Sato       2009-04-06  1885  		return ret;
> e7c274f8083793 Ryusuke Konishi 2010-07-10  1886  	nilfs_btree_commit_convert_and_insert(btree, key, ptr, keys, ptrs, n,
> 3033342a0b7604 Ryusuke Konishi 2009-05-24  1887  					      di, ni, bh);
> be667377a8b8cd Ryusuke Konishi 2011-03-05  1888  	nilfs_inode_add_blocks(btree->b_inode, stats.bs_nblocks);
> 17c76b0104e4a6 Koji Sato       2009-04-06  1889  	return 0;
> 17c76b0104e4a6 Koji Sato       2009-04-06  1890  }
> 17c76b0104e4a6 Koji Sato       2009-04-06  1891  
> 
> :::::: The code at line 1863 was first introduced by commit
> :::::: 17c76b0104e4a6513983777e1a17e0297a12b0c4 nilfs2: B-tree based block mapping
> 
> :::::: TO: Koji Sato <sato.koji@lab.ntt.co.jp>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
