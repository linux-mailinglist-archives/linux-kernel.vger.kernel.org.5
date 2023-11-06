Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DA87E27E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjKFO7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKFO7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:59:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FFDA4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699282787; x=1730818787;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=O20w869uSYexqy71lHu8FiJBQq7i9nqfPW5lxwqi7bM=;
  b=jAQ/YXbRRlSw1BkcteyocY3Z7GcKhikJa2s1aF5D/4zZ7IGtkKD0nh3v
   /JPZTG/gcMJ7mDoKoLGHer1wqHTG5AmVSADGPDUaP5Mm6N/haE5djZpG8
   36hPO218rg6TxvrMorj+Um7cvyooNtQEMNx92ZsT58A21sZG03QtLlUq1
   1kF6UcGamXm1tFvetvlmmORv9GeK3C0/gRCUt8OhAcrrj6HERcVoEFS09
   i9eM9p66+E/08RkdJez4mXj9/+fp7yJbd6sX7LoX/ML98Tyre+eKdHa1X
   5QGkT7/lAfkkbVoZU6wZ6Oi8yaernSF5fBSXmvqdh0z1aHF7A6Hl//WAP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="7921656"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="7921656"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 06:59:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="755874648"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="755874648"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 06:59:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 06:59:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 06:59:45 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 06:59:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePauAEAgQA0M+z4GVogXrBA9TUIaL4Kbk811U2fIu5XpbSczvwvortmzahQi+G4meIus1TBNm882ETfBrNIZvFPGwvNsDLGwMQdm3KbrK/NqgHw5XFO7cUvKTgo8dKWUm34T5RuEiGh+6iKSHlTkXXANTsYd18SqgIZi8MyzSmZkk4h6E0t4iVLojXdJAzjpz2FTtTlj1VOnP01s6Xlr6U9LZ9ysLURc2qad54kt7X5qI764SV01iA+jyhTD8FbcbUNE+xWZutYq7Xh+C0tEBt5bVMGC9YhPOlbNkiaselNjHEQr6w4e8u9IK0MkGOqfgQG3m7iom4l1EW4LZ39BDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDq9fQ/wwb6eavWwp2kj4sqZPio/nQrMTuwLi51qxw0=;
 b=VLDZPeph3Y5hxvo5o7vTsa5hK4l4Gio/r2/k0uRNBzfPnpLfv51zHLYcAOSXTB51JLONpNV7Km/T27tx26HOB6HkYkJZmgyWid2py7eJbc3o4tyJiT9Tr3R/stcE7bMTxmLc26bkORxpVlPy6GXj4DODym6TEOcUNhgjASe5uHah4LZxL+UH6TTHSHSw6sTYpYJWATm2Sn1nhV6KbvqmKaAQI1SemQAEYMyaYPX+KdcDF6mN/h1mmNjffAIpuRWFbs58cgrzHKD8j1hIsJzWB/NSRvA4c8YOiCNzIfYIMxW8uGtQYo32XTiOfukX7BXX/52Dbf+xXJHJ+95A6Nmlxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 14:59:40 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 14:59:37 +0000
Date:   Mon, 6 Nov 2023 22:59:29 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Christoph Hellwig <hch@lst.de>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>
Subject: Re: drivers/target/target_core_transport.c:1079:59: warning: '%s'
 directive output may be truncated writing up to 253 bytes into a region of
 size 221
Message-ID: <ZUj/USPCJ6tm/lg9@rli9-mobl>
References: <202311062106.HacLsl2Y-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311062106.HacLsl2Y-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 6faec694-b925-4b9b-aca8-08dbded8fe90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iLbl6h3fuPU63XYMDJCxJitXXuyVVQ7QVyYb5aYKBNH+KsiY89IKReo9T5r5QjO8JF0nmP5aZuMCQqqK6WzrHJ1zQ0JIFzy+P2fGqrPLfzSUrlTyOd8co4XVXf5w5X5Wb84Y/U9rIbCGt/CKA0Ocejzv+quowKFebNsS5zHVvTO9dh3FMk/bJzYvZ3XpPsUI43RgdSMbdBZR+N/uXWqXZ/+YbFOTR56L/kXGeKRDAJH28x3ExwApVZQGCNAk2nhZJTr5ftu0YmGDz1YMT73s38eM0lOEqNGbS5dTqBD34kIWGrZWEXzeoiwx0jtMqXOvbjrXeOjlVVctVLPYneOF9z5LMrw9QrOZfUWMCU5/eHJ1ifAGv9AU+7V2Bgf5RE2+0bEBBp81KwgklCBngDUVJ3wtlCVJmXzkOtKc/a338X04xQQgc/c+3+fYMKcvHZ25oYNc1VvsCtpU4fdKGHA5+ZhrNCv15Z+pP1Zj9yAEMVIKdWxpnm7FihFX8cB4iAIVKQOc8wO7dG1AOSpsBU+TmkMF7r02wqMOVC7q1mU3o10Sy/T+HCrl2TUz6dihW0qd6oi3qO5INoAvnfMf9Z+tCRWeu+3y/p4gJtd4MLlS1WhEJPk3tn9RuFqrzcK/Snrb0isK7qcaHsE8g5RjOOoHJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(64100799003)(1800799009)(2906002)(30864003)(41300700001)(4001150100001)(4326008)(6862004)(8676002)(8936002)(44832011)(86362001)(5660300002)(33716001)(966005)(6486002)(6666004)(6512007)(478600001)(9686003)(38100700002)(6506007)(83380400001)(82960400001)(66556008)(66476007)(66946007)(26005)(6636002)(316002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xnIGL5EpbShhfS3+E+JcBbWUAxmfZv5YyqT+oRsJC3PaDW12XzRDJCcqvH6d?=
 =?us-ascii?Q?Ht7vwZnhcDZClGdAjPTqQZaftlKtm1X3k053FqAZ3doLv78olTVTdOLMI/4H?=
 =?us-ascii?Q?O780I1j13QViiCdG0efDILTPxtMpn3aAOnOdvV44JYPJ+lqub065gecbsQGw?=
 =?us-ascii?Q?mOPYTs2sxdyDJJimiReg3JdmQPmLsZy8cf0uDIo5rpV1vDfMbVeEBxaEYHyt?=
 =?us-ascii?Q?iFaAny8mQKJiwUwggMmCSIdYTWUWbtfzw2V6Kn/UYDi/lVlva0+BDL43AMdO?=
 =?us-ascii?Q?35RRyQmSjp+t3ns8w6TzK+bHriZIA9L4agNmdzgda3SMZqO0cRZ8KVSUL3sz?=
 =?us-ascii?Q?O1XQO0YhXJn9iMVguZNmMriPTCWHigQMBmaJpgpoe9r/NLfMNocSQUIEMRJw?=
 =?us-ascii?Q?UPfGF70EekM9H0aIJV09jmNGe5ybHy9f6QWOn5z5v4j4Y7r99kQKW5PnUZoa?=
 =?us-ascii?Q?idx8ziePAkYVNrJam2m9zSNCqhEyEqR5arG2PaD81qq7rkTv36F1ciGdkH2q?=
 =?us-ascii?Q?I3+JTdFm9sORK8qmItk2kq3yfO+Vkm5Jv7fM/hFxKJW+uCydQIlTphqwBfha?=
 =?us-ascii?Q?GxdB4jHaggWZXsa5E0WaI/03SylR2jNVFiZK1X/IVFNANQ7ru0FiE8UjvCtc?=
 =?us-ascii?Q?cV/Y+VS/4/dG+Z9xh8c+ewMti2QODvD4jgaiu7QuV4xLHWix7aWTg0nABnx3?=
 =?us-ascii?Q?tG/PIMs8xXIGoRTIUGk8bZdf5SYyApybxZp9BLCPxEvvu2KWBPqzfCi3MAcs?=
 =?us-ascii?Q?e3G2NiCFDHyg0E8zOQ7YGOK10fiqpcw9ybxAS0WnF+15VWb9Gm0LTsoeeymq?=
 =?us-ascii?Q?nAumVqy/WLRQHrPO1aWr7PorpYQnRP7nlAuT4TZWjlTs15fqNloO8D6GP39c?=
 =?us-ascii?Q?HjJPPAZwVqF+ksn8XItEt45rp/4m95C1tI78NZgPyzdqzUrd+AyqE+7qYwDp?=
 =?us-ascii?Q?fhrddBqH9ELR6+wUVBDr3Lq0iofN9DSOpszPwskxIdWJmGQ6UaCEv4L2A+l/?=
 =?us-ascii?Q?F9RAu+zv1KEkd7abkD8wcOEhk/LS3oOFMRz4un0VNMGE52uHhpTuXOdxanx5?=
 =?us-ascii?Q?EGGlG7BbfCepgrVDoPT1HE1DEStZogEmJVMvSJJh7NiZj0I6Yncetkx8KSwl?=
 =?us-ascii?Q?684RjQwsDpW+JE2LnN5L22mrsAmo8qHCFtuA4mHIZ+4Bowr0eZ1PWgkv5l39?=
 =?us-ascii?Q?EWW1c6Y7PzhytaYNOaHXv+KvnPu5YgS9o7ooIGakqHW6m6vlwCEC3apaYgkZ?=
 =?us-ascii?Q?foJb5kK81ZkuovFN9Z95I6OWZ6UUjFJyekH4uXlNKNhaRDBby2d5RuxFyFdB?=
 =?us-ascii?Q?S91XLDgMaiSvbWHKAd7puCso/E1UWPoZ/YOYGy+ZMy7MPlJ+Qvce/YeEPECI?=
 =?us-ascii?Q?vHnXBSjnWOL4lpC3LzG4aqtYZfxrsY9FzR8ljkbQFOy0ylJ0oYwF7X7uIJMV?=
 =?us-ascii?Q?TR0NGAmwIowKgBw/qSFODjYg6H/7B+zgI8LjNIxy41P8+PKErLgkva9oNTuu?=
 =?us-ascii?Q?Tv65HTrWZCc3R4zI6fBxVb0odjcfvQkalrEHKvr/oJ8xRphWX7KegmqEskPW?=
 =?us-ascii?Q?TqoK6Y8U+Yk+7CI91UuMt8dMu/QH59vIuzKGf8kQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6faec694-b925-4b9b-aca8-08dbded8fe90
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 14:59:37.1519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOmRrZ0cHB7UN75yRl1rw+qxKWbiCfk8EVLxGOoxhOHdXLjWYqcWMAHfRZwblwyd+SwA4xeZuRdUXzTW1kWPbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 10:01:44PM +0800, kernel test robot wrote:
> Hi Christoph,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

Sorry for false report, kindly ignore this which is not the cause of initial warning.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d2f51b3516dade79269ff45eae2a7668ae711b25
> commit: 8a39a0478355e9dfdd2f35038d07c4ebe3192441 target: don't depend on SCSI
> date:   5 years ago
> config: x86_64-randconfig-x083-20230515 (https://download.01.org/0day-ci/archive/20231106/202311062106.HacLsl2Y-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311062106.HacLsl2Y-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311062106.HacLsl2Y-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/target/target_core_transport.c: In function 'transport_dump_vpd_ident':
> >> drivers/target/target_core_transport.c:1079:59: warning: '%s' directive output may be truncated writing up to 253 bytes into a region of size 221 [-Wformat-truncation=]
>     1079 |                         "T10 VPD ASCII Device Identifier: %s\n",
>          |                                                           ^~
>    drivers/target/target_core_transport.c:1078:17: note: 'snprintf' output between 35 and 288 bytes into a destination of size 254
>     1078 |                 snprintf(buf, sizeof(buf),
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     1079 |                         "T10 VPD ASCII Device Identifier: %s\n",
>          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     1080 |                         &vpd->device_identifier[0]);
>          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/target/target_core_transport.c:1084:59: warning: '%s' directive output may be truncated writing up to 253 bytes into a region of size 221 [-Wformat-truncation=]
>     1084 |                         "T10 VPD UTF-8 Device Identifier: %s\n",
>          |                                                           ^~
>    drivers/target/target_core_transport.c:1083:17: note: 'snprintf' output between 35 and 288 bytes into a destination of size 254
>     1083 |                 snprintf(buf, sizeof(buf),
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     1084 |                         "T10 VPD UTF-8 Device Identifier: %s\n",
>          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     1085 |                         &vpd->device_identifier[0]);
>          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/target/target_core_transport.c:1074:60: warning: '%s' directive output may be truncated writing up to 253 bytes into a region of size 220 [-Wformat-truncation=]
>     1074 |                         "T10 VPD Binary Device Identifier: %s\n",
>          |                                                            ^~
>    drivers/target/target_core_transport.c:1073:17: note: 'snprintf' output between 36 and 289 bytes into a destination of size 254
>     1073 |                 snprintf(buf, sizeof(buf),
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
>     1074 |                         "T10 VPD Binary Device Identifier: %s\n",
>          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     1075 |                         &vpd->device_identifier[0]);
>          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/target/target_core_transport.o: warning: objtool: transport_init_session()+0x61: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_alloc_session_tags()+0x80: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: target_read_prot_action()+0x156: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_handle_queue_full()+0x2ac: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_lun_remove_cmd()+0x1e3: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: __transport_check_aborted_status()+0x2e2: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: target_setup_cmd_from_cdb()+0x540: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: target_show_dynamic_sessions()+0xf6: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: target_put_nacl()+0x10b: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_free_session()+0x136: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_init_session_tags()+0x66: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: translate_sense_reason.constprop.0()+0x1aa: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_send_check_condition_and_sense()+0x357: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: __transport_wait_for_tasks()+0x245: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_generic_free_cmd()+0x1a5: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: init_se_kmem_caches()+0x2b: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_dump_vpd_ident_type()+0x144: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: target_cmd_size_check()+0x3f3: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_generic_map_mem_to_cmd()+0x7c: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: target_complete_ok_work()+0xa6e: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_complete_qf()+0x266: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_generic_request_failure()+0x4ae: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: target_write_prot_action()+0x156: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_handle_cdb_direct()+0x39: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: target_submit_cmd_map_sgls()+0x3af: sibling call from callable instruction with modified stack frame
>    drivers/target/target_core_transport.o: warning: objtool: transport_send_task_abort()+0x2a7: sibling call from callable instruction with modified stack frame
> 
> 
> vim +1079 drivers/target/target_core_transport.c
> 
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1060  
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1061  int transport_dump_vpd_ident(
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1062  	struct t10_vpd *vpd,
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1063  	unsigned char *p_buf,
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1064  	int p_buf_len)
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1065  {
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1066  	unsigned char buf[VPD_TMP_BUF_SIZE];
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1067  	int ret = 0;
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1068  
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1069  	memset(buf, 0, VPD_TMP_BUF_SIZE);
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1070  
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1071  	switch (vpd->device_identifier_code_set) {
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1072  	case 0x01: /* Binary */
> 703d641d870346 Dan Carpenter      2013-01-18  1073  		snprintf(buf, sizeof(buf),
> 703d641d870346 Dan Carpenter      2013-01-18  1074  			"T10 VPD Binary Device Identifier: %s\n",
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1075  			&vpd->device_identifier[0]);
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1076  		break;
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1077  	case 0x02: /* ASCII */
> 703d641d870346 Dan Carpenter      2013-01-18  1078  		snprintf(buf, sizeof(buf),
> 703d641d870346 Dan Carpenter      2013-01-18 @1079  			"T10 VPD ASCII Device Identifier: %s\n",
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1080  			&vpd->device_identifier[0]);
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1081  		break;
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1082  	case 0x03: /* UTF-8 */
> 703d641d870346 Dan Carpenter      2013-01-18  1083  		snprintf(buf, sizeof(buf),
> 703d641d870346 Dan Carpenter      2013-01-18  1084  			"T10 VPD UTF-8 Device Identifier: %s\n",
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1085  			&vpd->device_identifier[0]);
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1086  		break;
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1087  	default:
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1088  		sprintf(buf, "T10 VPD Device Identifier encoding unsupported:"
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1089  			" 0x%02x", vpd->device_identifier_code_set);
> e3d6f909ed803d Andy Grover        2011-07-19  1090  		ret = -EINVAL;
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1091  		break;
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1092  	}
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1093  
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1094  	if (p_buf)
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1095  		strncpy(p_buf, buf, p_buf_len);
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1096  	else
> 6708bb27bb2703 Andy Grover        2011-06-08  1097  		pr_debug("%s", buf);
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1098  
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1099  	return ret;
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1100  }
> c66ac9db8d4ad9 Nicholas Bellinger 2010-12-17  1101  
> 
> :::::: The code at line 1079 was first introduced by commit
> :::::: 703d641d87034629f8b0da94334034ed5d805b36 target: change sprintf to snprintf in transport_dump_vpd_ident
> 
> :::::: TO: Dan Carpenter <dan.carpenter@oracle.com>
> :::::: CC: Nicholas Bellinger <nab@linux-iscsi.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
