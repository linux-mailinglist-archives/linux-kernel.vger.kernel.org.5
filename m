Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC60796F1F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjIGC7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjIGC7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:59:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256B910CA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 19:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694055568; x=1725591568;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MnuUkiJ5r3KBB3QzIg251rcYaxMshvxl3T6g00jpx3Y=;
  b=HQ27VqWoBswLcTEMeYT9kf4lYwsIf1L+X/6lkkzyXF7DOpkx/dlqZjKo
   nPsdP9mtHcMHrHrdWQAu+P/x1cRPJZgBTmt8l9boV8IfT4Fkz4p2vV7qO
   lnBHyh72zyGMrcfroZN5wcVg/Ouz1FA1T2RUiwhIeWhsqodZ2Siy9snDq
   VJTUlNK/h4OW9bdfPwUx3x9TorUx+8tat1dxuLDHjFjgTjflpwPHpubhF
   iEqj9IG19UGBSNhzR6IB8mKHVqKubOmo+TUyQiU8TeRIMBdQAoyXQzLJz
   qPEYfx+8rvyH2aqRNDq1eDO6Q2V6l7wh9f+LxU5ak20QKsAKNhGikINxF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="362273873"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="362273873"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 19:59:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="988558690"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="988558690"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 19:59:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 19:59:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 6 Sep 2023 19:59:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 19:59:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN9vWxKp+9xh6I3ImmWyTJXAAnOBCMow0lrn26A27ggn3c0rSP81kJmTt/Y0GqHSjS0ts97biZYUjiTmcY4maw3TvfgvcNlxRhywAugYTtGmBgegDUsafDhOATc4VzXaGt27l4hZnzIqyxOniaiguZF+5nU3ODansYOIPwkjooWcnZZe0ej+8/mbpUXo5oEeRExKlzRi47XW9wzD2tABaQS6blyopjpJmE500rPc1Me9fH8n0Nqzlc2zlhKZ7djSHl9c7FCu5WaLkHat97M32wueC7DTnl6J/WXfIX9piTnNnk90Zg+1Thi+aJRB3upldQCx9OUej00Ji9nEAoRU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBiSUcybXaZY6hwXPIkv4xJD/7rQv1p7W0eSylsiQZo=;
 b=XSXh7cmJ3k7Q7tYzuyMUS21g/uiD9l+1RKeznYhEfsZ1TmSADphsMmsjaNy/ui/DuwK6AcGejIbpCuS2QzscgkTO374GBeNHRkd0JQ4klNoP+X9h1XsV/sQyiVDLtElO/8J7uBB7gvIKjJD/eFdSYMMVyf0lrGMHaImhG1eLs+qWV2HVuPd5rM15009IDW7tG8TmiYD3SSxkvebh4D7f64UDUVRKdsGwlOl5yRR4abKduxmJZUCx9q19sEL87xlue0yOLFQnJe/0/kFoHnVGH0EHk0YqQSHrswRcfeMOm+RcZsWP1SXP692247MEY8cdIiBLpQvhCh6EvwXvJPLp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by SA0PR11MB4703.namprd11.prod.outlook.com (2603:10b6:806:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 02:59:17 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 02:59:16 +0000
Date:   Thu, 7 Sep 2023 10:59:04 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Jeff Layton <jlayton@kernel.org>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        <ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [linus:master] [tmpfs]  d48c339729: ltp.mount03.fail
Message-ID: <202309071017.a64aca5e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|SA0PR11MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: db71db78-4616-419c-a6b1-08dbaf4e6c21
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5rMej3XkrjgcNsjqckuKxgTa3ayo/57p4vjhwoWYoA6h7CRcFD8ZHAuDy6emC90LYyCaMQZEDByyE/ij01dAWUjMptRro3CboRDSA1VIRBuUfgMVg/A89IZGexJP798RTnZaV0rCwaQNsOcCqgatXGB0aLdONl7ZzwhTHYIBwkkR/lq+srouc19NWKFfhk5ZVe3Cx80eGSmIntWvjNIczAe5VPNCRCBGIEnsn3nzNWtUWbxnU0S0WQO4fUFXl1CSoIp3Ea9diI5k6oIXYG6KI2OIjMBwUjy0XtZKpKXL7hVOMqDPxK/9YD3QYl1ZT+ROsM6jAuDLYgvDOTPWT2wO6X4LIGv/vIvsjNssHwqk9i/dP4h2tcFhxnub0X1vAoeTQmZCxFb0TxsRQMMjlfcyZBITGWvJYc7cQri9+HsluYADrrXwwVDvp6pXDz7VkKGZO0b5aBfbxYcHCbdCJY1Wmp3oLBSnbQ0K1goufE6ryludMeLoMbyv7gFWawtsfdPGbuKgWcIO0WXRQnRIANDLHkGVa4mJoOYsBDlXecidhD6lqM/lcTBluFo5RcdrRqhK3hSTvCQpm3ZHwEwASNLNDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(66476007)(54906003)(6916009)(316002)(2616005)(1076003)(107886003)(6666004)(86362001)(66946007)(66556008)(2906002)(8676002)(41300700001)(4326008)(8936002)(30864003)(5660300002)(38100700002)(966005)(478600001)(6512007)(26005)(6506007)(6486002)(83380400001)(82960400001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aFybFRVgFQNdphclBaRfyxnu3zGhEzOHFuZ84vI96RScZjliiZZvbr+lVWR8?=
 =?us-ascii?Q?m8KWr7LWWMrLULWt0ET7NgRIGzWh4tFTAWEGk8ERThmQuHMm2FNKgTRZ+V4o?=
 =?us-ascii?Q?5vvPUCOl31CoJMmcRaAjGDhtdo5SG72WEKiu66i9obsGtyjXbrhzzEombpco?=
 =?us-ascii?Q?rpLc6f4nspfcNTwiAMdTl9VeLPSudS3hdC0slISswtiFrz6ZyCEKdHbNeP0w?=
 =?us-ascii?Q?oyU9nPS5n6IstHfGDy5T+j1IMvftXzvtel4quK0dAkUPECIGNhOEOues+blW?=
 =?us-ascii?Q?2G8n9IW978Srbc853ieRrgemy9VZD7LnJn7R+R6lVJzJjC0vLaiKLi558DVY?=
 =?us-ascii?Q?fJWavro7RecZoQur2vvdLdEYufQJmbo6S6NDb3If46hqOI71P4jCdMtTweor?=
 =?us-ascii?Q?F9TtXPylros8OU0L3x56xWN48r6QCdB3rYJ0S+2LSFjwTQh4yZcjOjP8xWOQ?=
 =?us-ascii?Q?w0D9mdjYGNH3kwCOg7qLh0hLxbYasV6rrC1DJFpqMpzQ7cph4gjFbHJgxABC?=
 =?us-ascii?Q?SIpgNNumYJn1V1GnPzNgjAE65wgJvGz39wie+GntOvATPDzuLUpZaRQMeLnu?=
 =?us-ascii?Q?NxWdRSGK3y57tlBsBLtJji48fXKSEDMW6ntTOR0I3AtT3i0JwvTikZqnxwq5?=
 =?us-ascii?Q?ehmKAb3wXZGPnUupNjOcT7OI4u6tjyszoLrzOoyuozX5vjh6L5RCh/5AVDg/?=
 =?us-ascii?Q?f9hIseXkkD7u+IPLOUET15pBw8T5KhA35zJsMGNUIecvETM9hnv07El11hGh?=
 =?us-ascii?Q?y/IFCmb0fr74kg2dLdzGcfzf1GyLxvvbgZ4fP7ryeLJLMTuFT6RErlYTAqaN?=
 =?us-ascii?Q?g4Or0lx5h1i4JnH3QFDzcZeTBU7ksqK1kZcyghcpJolClYxtmLxnfZL3SZta?=
 =?us-ascii?Q?JW2x4unQ0NyTT69GoiKTG0wIZso3H7FB35FU3kyv3cgk1wyD3lTPPlIWCcA9?=
 =?us-ascii?Q?3C6gVhft3nT5M0D8bEkyIhD+2GpFIvcIO7VzCTLmkgYSWuuJF7Ic6Wy5yIWO?=
 =?us-ascii?Q?OT57MsQulwnPH4PjsKynSA+ZrQAfYkIxcdtV8EzH3nT0f5eyP57N5PXtd1eO?=
 =?us-ascii?Q?6uP+CWXlfgjSnoQ7pIbcX4piEsKarsAP4zRXoOFkBEND3QiPZZ9PoDZSrRP+?=
 =?us-ascii?Q?LrTUR4IMCkR7iJpNDEj+VpbPrHiDADTxP40jBiq0aBkAmADUdLzjwzP25UBI?=
 =?us-ascii?Q?zxWDfza+/ygAt0MafYDj0uFJX5q09dEoZ+TWxQXXOU2Kte1si8KYmZq0GKNW?=
 =?us-ascii?Q?htwp9Cy5YtTRMnZWzFt9H22cOKhJ5UAm06OqcKfF2bss/dC6+lDq+GL6N8wA?=
 =?us-ascii?Q?KzQKVjogZU4jX4G4lv9yszW1lWHR5dyLzpdDn4QAqe7onVIon+L7Kf/8dASt?=
 =?us-ascii?Q?HOkxplOuBObiWDEuVndZMi+vJi4WVsnlwIUImSfd6OSYCcrIMTZwdMRmjWFA?=
 =?us-ascii?Q?q4Z1kmW0zx1DdNW8+hyEuEXH9VeWsPSi0MGizlwr89XINYNRO86BE7lP25QM?=
 =?us-ascii?Q?7zRoJvIjxhee7Ez27OHFwhvQ6KqoecJB17pwJ5geIvXQSFVGFX2Y8GRj9IPA?=
 =?us-ascii?Q?RLeGr47BwQGiCZoeeKjY/wIXKIrq93Uqn8xIwz4z2xHYVt+VyGD0DcfTyFz+?=
 =?us-ascii?Q?Tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db71db78-4616-419c-a6b1-08dbaf4e6c21
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 02:59:16.1493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fcMy4gnciL1niN5SwfzwBsZQxLcoiT2XL9ysEjZsr2cr1ByDuHjfAK2LszBwJH91YNx+7wRVxmzz5fifkBz1aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4703
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "ltp.mount03.fail" on:

commit: d48c3397291690c3576d6c983b0a86ecbc203cac ("tmpfs: add support for multigrain timestamps")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 708283abf896dd4853e673cc8cba70acaf9bf4ea]
[test failed on linux-next/master a47fc304d2b678db1a5d760a7d644dac9b067752]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20230715
with following parameters:

	disk: 1HDD
	fs: f2fs
	test: syscalls-00/mount03



compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309071017.a64aca5e-oliver.sang@intel.com


we also noticed this issue doesn't always happen, as below, on d48c339729,
13 out of 30 runs failed, while others can pass.
and on parent commit, we didn't observe the failure on 30 runs.

ffb6cf19e0633406 d48c3397291690c3576d6c983b0
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :30          43%          13:30    ltp.mount03.fail


when failure happens, it shows
tst_test.c:1634: TINFO: === Testing on tmpfs ===
...
mount03.c:214: TINFO: Testing flag MS_STRICTATIME
mount03.c:140: TFAIL: st.st_atime(1694017088) < atime(1694069961)


when it pass:
mount03.c:214: TINFO: Testing flag MS_STRICTATIME
mount03.c:137: TPASS: st.st_atime(1693999383) > atime(1693999381)


below detail log while running mount03:

Running tests.......
<<<test_start>>>
tag=mount03 stime=1694017062
cmdline="mount03"
contacts=""
analysis=exit
<<<test_output>>>
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
tst_supported_fs_types.c:90: TINFO: Kernel supports ext2
tst_supported_fs_types.c:55: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports ext3
tst_supported_fs_types.c:55: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports ext4
tst_supported_fs_types.c:55: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports xfs
tst_supported_fs_types.c:55: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:90: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:55: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:157: TINFO: Skipping vfat as requested by the test
tst_supported_fs_types.c:157: TINFO: Skipping exfat as requested by the test
tst_supported_fs_types.c:157: TINFO: Skipping ntfs as requested by the test
tst_supported_fs_types.c:90: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:42: TINFO: mkfs is not needed for tmpfs
tst_test.c:1634: TINFO: === Testing on ext2 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.46.6-rc1 (12-Sep-2022)
mount03.c:214: TINFO: Testing flag MS_RDONLY
mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODEV
mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOEXEC
mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_REMOUNT
mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=ext2 flags=20
mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOSUID
mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOATIME
mount03.c:143: TPASS: st.st_atime == atime (1694017064)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017064)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODIRATIME
mount03.c:137: TPASS: st.st_atime(1694017066) > atime(1694017064)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017064)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_STRICTATIME
mount03.c:137: TPASS: st.st_atime(1694017067) > atime(1694017066)
mount03.c:148: TPASS: dir_st.st_atime(1694017067) > dir_atime(1694017064)
mount03.c:229: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
tst_device.c:442: TINFO: No device is mounted at mntpoint
tst_test.c:1634: TINFO: === Testing on ext3 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.46.6-rc1 (12-Sep-2022)
mount03.c:214: TINFO: Testing flag MS_RDONLY
mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODEV
mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOEXEC
mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_REMOUNT
mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=ext3 flags=20
mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOSUID
mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOATIME
mount03.c:143: TPASS: st.st_atime == atime (1694017068)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017068)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODIRATIME
mount03.c:137: TPASS: st.st_atime(1694017070) > atime(1694017068)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017068)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_STRICTATIME
mount03.c:137: TPASS: st.st_atime(1694017072) > atime(1694017070)
mount03.c:148: TPASS: dir_st.st_atime(1694017072) > dir_atime(1694017068)
mount03.c:229: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
tst_device.c:442: TINFO: No device is mounted at mntpoint
tst_test.c:1634: TINFO: === Testing on ext4 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.46.6-rc1 (12-Sep-2022)
mount03.c:214: TINFO: Testing flag MS_RDONLY
mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODEV
mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOEXEC
mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_REMOUNT
mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=ext4 flags=20
mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOSUID
mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOATIME
mount03.c:143: TPASS: st.st_atime == atime (1694017073)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017073)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODIRATIME
mount03.c:137: TPASS: st.st_atime(1694017075) > atime(1694017073)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017073)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_STRICTATIME
mount03.c:137: TPASS: st.st_atime(1694017076) > atime(1694017075)
mount03.c:148: TPASS: dir_st.st_atime(1694017076) > dir_atime(1694017073)
mount03.c:229: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
tst_device.c:442: TINFO: No device is mounted at mntpoint
tst_test.c:1634: TINFO: === Testing on xfs ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
mount03.c:214: TINFO: Testing flag MS_RDONLY
mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODEV
mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOEXEC
mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_REMOUNT
mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=xfs flags=20
mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOSUID
mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOATIME
mount03.c:143: TPASS: st.st_atime == atime (1694017077)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017077)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODIRATIME
mount03.c:137: TPASS: st.st_atime(1694017080) > atime(1694017077)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017077)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_STRICTATIME
mount03.c:137: TPASS: st.st_atime(1694017081) > atime(1694017080)
mount03.c:148: TPASS: dir_st.st_atime(1694017081) > dir_atime(1694017077)
mount03.c:229: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
tst_device.c:442: TINFO: No device is mounted at mntpoint
tst_test.c:1634: TINFO: === Testing on btrfs ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
mount03.c:214: TINFO: Testing flag MS_RDONLY
mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODEV
mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOEXEC
mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_REMOUNT
mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=btrfs flags=20
mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOSUID
mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOATIME
mount03.c:143: TPASS: st.st_atime == atime (1694017082)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017082)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODIRATIME
mount03.c:137: TPASS: st.st_atime(1694017084) > atime(1694017082)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017082)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_STRICTATIME
mount03.c:137: TPASS: st.st_atime(1694017085) > atime(1694017084)
mount03.c:148: TPASS: dir_st.st_atime(1694017085) > dir_atime(1694017082)
mount03.c:229: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
tst_device.c:442: TINFO: No device is mounted at mntpoint
tst_test.c:1634: TINFO: === Testing on tmpfs ===
tst_test.c:1093: TINFO: Skipping mkfs for TMPFS filesystem
mount03.c:214: TINFO: Testing flag MS_RDONLY
mount03.c:52: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) : EROFS (30)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODEV
mount03.c:59: TPASS: otfd = open(file, O_RDWR, 0700) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOEXEC
mount03.c:67: TPASS: execlp(file, basename(file), NULL) : EACCES (13)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_REMOUNT
mount03.c:72: TINFO: Mounting /dev/loop0 to /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint fstyp=tmpfs flags=20
mount03.c:74: TPASS: otfd = open(file, O_CREAT | O_RDWR, 0700) returned fd 4
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOSUID
mount03_suid_child.c:22: TPASS: setreuid(getuid(), 0) : EPERM (1)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NOATIME
mount03.c:143: TPASS: st.st_atime == atime (1694017085)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017085)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_NODIRATIME
mount03.c:137: TPASS: st.st_atime(1694017087) > atime(1694017086)
mount03.c:154: TPASS: dir_st.st_atime == dir_atime (1694017086)
mount03.c:235: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
mount03.c:214: TINFO: Testing flag MS_STRICTATIME
mount03.c:140: TFAIL: st.st_atime(1694017088) < atime(1694069961)
mount03.c:148: TPASS: dir_st.st_atime(1694017088) > dir_atime(1694017087)
mount03.c:229: TPASS: statfs() gets the correct mount flag
mount03.c:205: TINFO: Umounting /fs/sda2/tmpdir/ltp-YGq2uVXRd6/LTP_mouxTci2R/mntpoint
tst_device.c:442: TINFO: No device is mounted at mntpoint

Summary:
passed   113
failed   1
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=26 termination_type=exited termination_id=1 corefile=no
cutime=5 cstime=284
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20230516-75-g2e582e743

       ###############################################################

            Done executing testcases.
            LTP Version:  20230516-75-g2e582e743
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230907/202309071017.a64aca5e-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

