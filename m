Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504FF790F6C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 02:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350039AbjIDA51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 20:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbjIDA50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 20:57:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF72599
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 17:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693789042; x=1725325042;
  h=date:from:to:cc:subject:message-id:reply-to:mime-version;
  bh=whEof6X9965lbAvk6XoxxntHbDKJaCUF4Z6GqCY3IzA=;
  b=PwkHiR6a37w/912SUrZ2rFuosoPZLR54451jKGMoxgboLQEwggKH40WT
   vqtAbV9Xim6U6eKYBopgpHhVIdVC4wR5hrpc8BpHjUZNbcI7R9ZTfUo2k
   rjDCxqSqF2VHOxIW413idGnxR260HYsKdmVmSZTW6sIu6c+6/jS70hFAi
   i1c0hFB8VFvGcbDGeDYeNlBmKHJ6GqWFnSNthSo18vAe6xgSgpCPOjKYb
   hOod/vXKOyd1h6msZLGhCd4cFDBoqF2I54s+aRSPFOVUmh/IeEFYWOg2P
   1yKI8rOh6xwJw+v2SP1w0xj7cS4gYD0IACt3GjEgJhpmsC2sgbfre9x6r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="407489147"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="gz'50?scan'50,208,50";a="407489147"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 17:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="690414997"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="gz'50?scan'50,208,50";a="690414997"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2023 17:57:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 17:57:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 17:57:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 3 Sep 2023 17:57:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 3 Sep 2023 17:57:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrJ7k+rIc91o7D1lbUPIaiMWLOSIst5NsQ6G7YU7s0/0Y8La5DUs7QPO2xpfzgQx9bV4OH9Y5+kPceni8d8prTlJ+nP2oAR3TutZ0yWvQ6Rrui5tqqXvnLfVWzYjeXcUC6rSzFKDlJ2agwhvc2qhAOqqb/GZPKV8l3i1hJER59SUEtfY+kbViR1x64zObpdF1QZvVj5Kp1cjmLnz2Rl3T1k6U0YpVO2j6+/zFmY2upSvlyDrAwcaJSOCrxH2CdUrluf93T+FYX+Syj90xDbyxAIcmCOoKWXwOmEJXhVt1mAO/xioy14EJcwwsadxnZxd3dbAkpR91Nx0Xo/sA4uemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWTLOnKRnfz2twfwTjPfE54g4lg0r8vd54QtkPa5v34=;
 b=lKpPaVtK9I+Oi8POykeSqEqtOury+LNBrBlFqryaMtvejK6M0RrqaPrCVFkpTOWK2ci9dEHxgO4L0paMJu4ZFeADYpW68C7K90s7cSYd/yOOBm0WmMkPVXBSso1/0IENskQteoUmcSYbfG+iMUalcf0nBCN3h4aUdtwgfmfFPwa3Xu9JsWRUhIKZgI9dATb1VX4LAm8X6ykAwkArESE15JXzvt0ntQxMw3ldd191GusDRgUuuHjLjP4YKCpJLFv2fV+KjJMAbHTDpIDAAKzaK9VrRf9Mh6/dXjFGfgwoq+NGp01imQQZpz7mR1nMqL3D/Wl9xbJUdyX2zFgeyhC1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
 by PH7PR11MB8550.namprd11.prod.outlook.com (2603:10b6:510:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 00:57:12 +0000
Received: from SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7633:b736:1e61:890e]) by SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7633:b736:1e61:890e%4]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 00:57:12 +0000
Date:   Mon, 4 Sep 2023 08:57:02 +0800
From:   kernel test robot <philip.li@intel.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: kernel/reboot.c:559: warning: Function parameter or member
 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'
Message-ID: <ZPUrXvIVwtVmPvzI@rli9-mobl>
Reply-To: kernel test robot <lkp@intel.com>
Content-Type: multipart/mixed; boundary="9LOwINS5GLkJwne8"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0153.apcprd04.prod.outlook.com (2603:1096:4::15)
 To SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3006:EE_|PH7PR11MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: baa06219-e382-4e09-60a4-08dbace1dfbd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8EysUDyWuSAsimshMPDz+c/WXxxIcu2dngAZVroJYEWUCsU7HTyGkKqIuIgmV3irhEd25TvB0LOXNMjJ5RV1VA6nE6OlDYUY9sdbMV6+AhPGxOhNB5WWUqVW8WeMRzdpLScdi3wpsqHhJOmcrQgsmeVP42NobC/aog6EIfACk7eP9xGmWn/m+mOJtYW9uSFY4Evj+varrggSm57pFu1t3aRioymGT1smif10ttm6AVwv5usu68h06W4CiZNTBwFzSpr2IBo/160LN27BSV5h0SgqxGQ3iGyHSbgIysa0DgBCWtTBvISqKxm8u5ZylSONb1VpblhNVkEKLEOif/8oVO5OLeaiXfQjpmGiOWyUw07OSi0pKFE0CHd4ipFwipvqqinGBIC8ehFBjdJ9K5UaUBpmXG2iE3lobgk6+QKfKp2+kuiSEtzMw7UERymotqk8lkEz0GM3uT8azsrODrohjCyqwsLXMdO68WCGFbGlqt4twmBrDSZDkkPaoSCD4GH9a9NuLC4dA3XiUfUkvm0OKfgS5rFM4n4qiswaUnYI0N2jA+V74l4qVwfSU5dlVdWe3NkJpbRDQWRbMnPMDU1XKQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(396003)(346002)(376002)(1800799009)(451199024)(186009)(8936002)(8676002)(5660300002)(316002)(66476007)(66946007)(2906002)(110136005)(66556008)(4326008)(235185007)(41300700001)(44144004)(6486002)(6506007)(26005)(9686003)(6512007)(38100700002)(33716001)(6666004)(82960400001)(478600001)(966005)(83380400001)(86362001)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r7p8mucMD9AVCNdN4G3iXwEKe4EmMJd+toWc2YxtdzDwp88qnc8svM3QxktK?=
 =?us-ascii?Q?XMLmi8MIMz5/xCYVc8xwOI8T//9HU4pyw/fUzgv9JKz079Gie0DPV5C7bC2w?=
 =?us-ascii?Q?bQyjhYIGwn3luyU9v5M0LWP9QyKR3ZvZd/TtmsP2oESeZj4Uy7CSPvViVaCT?=
 =?us-ascii?Q?Wzr/6cHBwyN0TO9YvsqlwbRUijuMIHwQbOjJDhJT9o/5QmaHY+S3Gghjmxgm?=
 =?us-ascii?Q?WhJnukXiyKkEWHRh1G878c6wczRXZ7ALmBNzVH4iuXisFfbW7hrI88hbRdhc?=
 =?us-ascii?Q?HgXHYJcZkqiDxXbfR83bvEMXTExhVrj5YsXV717VxzFRbvF9naiCuyybePI+?=
 =?us-ascii?Q?aAzg0SLHA+TrQEY4TpKG8aYzQTYqJ3JgExUfEHUl5XaPaavu3boKvghax/UR?=
 =?us-ascii?Q?+MtU3RHgueRQv+aAUy1oka5We6Ij4/IlSYPffeCMFB5wnwkL+6CSW4n2Y/J+?=
 =?us-ascii?Q?LuDHvY7xtVpOS4cxRplJXk+Ok4NTTZCouRhmw74HYQLRnvv1o9zvHY/gGXhb?=
 =?us-ascii?Q?Im90uG9sxTn1HyxQxmZ0mtSBLzD95iwvG9FDLDl2TepfRBQYaKdrlNVInphZ?=
 =?us-ascii?Q?Qi+PTZFyf66mBVfzlUmK2Zf1zx8PzVntT+zW7HKnnTSUyRFMwzyfr69ra0nB?=
 =?us-ascii?Q?ng6SIgsuc1VHM5jTCjcSa1CXGROFD8YdgpihH8M4zDrjnPm5psbbEPpJwrHL?=
 =?us-ascii?Q?r4qBdXRgKJcheBb+xmbg4lqRYK2NHQ1AZWSEjRoYGa2IHjGoPOEQ2asZ+JEO?=
 =?us-ascii?Q?MYqpMhvFWQxEQUvEMvy2BB3he41w43fdjlQ0yBVngIA+0adnoElngXcqIw7A?=
 =?us-ascii?Q?3Og5Ask7cHvqBfM0d8SB25gQbmDYHib3+y28LGEsv05NhrdQ3MDE0aqo/6QB?=
 =?us-ascii?Q?r5gT9LScR59BinfT9rzCr0OSG97xUk5cfxq1HPCI4ZmZqlkoGy9rqU6isC2b?=
 =?us-ascii?Q?3YWoziwywk5gMrge50ObPEiTWMhnl61SD5EjH7FR2cRw5OF6Gb8KsO/pbyNy?=
 =?us-ascii?Q?rlF+Qm4k+2JV/6oro7tDw53BewpG04+0DSaZMRdS4wUPGHA9vn6Osz7twOrT?=
 =?us-ascii?Q?pppMvjGpBZzQTAWolWtMUDjzIGO3nDBzetc4xPEl8YGQXlFAk2o2hOCZO1Rm?=
 =?us-ascii?Q?3i0l+az2CvTCC/tawdkb5y2s25Q5pqW7hzd9A97D+4z7Y/HQg31/22iMTiSo?=
 =?us-ascii?Q?lSelC0dHG/vXzb/4CLyR9NSWqB+YvTbNwl/lSPFn8SXejxikGJNd8yuWpBp6?=
 =?us-ascii?Q?Ky+DjJtjjCTtkHJwIABQMFJKEfrihbe9eE59TH71rLzL0a9tYbSRzgA2a4WS?=
 =?us-ascii?Q?vFvUyR3NOPtASzWzDlzAbboicjJ0TFs3zYzbC2J+v4PG5M7qVDvPblRF8Bbh?=
 =?us-ascii?Q?tPt5BRD+rNf9EV6WA4CDIzMadNvbGLvYF0sCW5XUp0jM41zua35fpYBmBTeH?=
 =?us-ascii?Q?xyvVR4K5cQGOWMeG0Td58ptnx8hRFNyumjnYSpPNAK+ttxh6eZaZebvoeQpi?=
 =?us-ascii?Q?rJqfVBIcs58LMLWTlRBWq63WAGSLUT24sj0uZnOJdDPQk606jnf1S3x5eCpi?=
 =?us-ascii?Q?rsFvEAEFdl4rPe0QACdMvotdeYdx7AXP5w5zNDLv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: baa06219-e382-4e09-60a4-08dbace1dfbd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 00:57:12.6215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ELPAtvVPh+fn3hzsx8oMiZJzvSmobBtafTLkO+All4rAtDBz6YAu9kuyOf+Po5Y4fzAGmUrjIUQMhseWOk+NwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--9LOwINS5GLkJwne8
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92901222f83d988617aee37680cb29e1a743b5e4
commit: dfa19b11385d4cf8f0242fd93e2073e25183c331 reboot: Add hardware protection power-off
date:   2 years, 2 months ago
:::::: branch date: 21 hours ago
:::::: commit date: 2 years, 2 months ago
config: i386-allnoconfig (attached as .config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (attached as reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309040349.HLOK1O5I-lkp@intel.com/

All warnings (new ones prefixed by >>):

   kernel/reboot.c:215: warning: Function parameter or member 'cmd' not described in 'do_kernel_restart'
>> kernel/reboot.c:559: warning: Function parameter or member 'poweroff_delay_ms' not described in 'hw_failure_emergency_poweroff'


vim +559 kernel/reboot.c

dfa19b11385d4cf Matti Vaittinen 2021-06-03  548  
dfa19b11385d4cf Matti Vaittinen 2021-06-03  549  static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
dfa19b11385d4cf Matti Vaittinen 2021-06-03  550  			    hw_failure_emergency_poweroff_func);
dfa19b11385d4cf Matti Vaittinen 2021-06-03  551  
dfa19b11385d4cf Matti Vaittinen 2021-06-03  552  /**
dfa19b11385d4cf Matti Vaittinen 2021-06-03  553   * hw_failure_emergency_poweroff - Trigger an emergency system poweroff
dfa19b11385d4cf Matti Vaittinen 2021-06-03  554   *
dfa19b11385d4cf Matti Vaittinen 2021-06-03  555   * This may be called from any critical situation to trigger a system shutdown
dfa19b11385d4cf Matti Vaittinen 2021-06-03  556   * after a given period of time. If time is negative this is not scheduled.
dfa19b11385d4cf Matti Vaittinen 2021-06-03  557   */
dfa19b11385d4cf Matti Vaittinen 2021-06-03  558  static void hw_failure_emergency_poweroff(int poweroff_delay_ms)
dfa19b11385d4cf Matti Vaittinen 2021-06-03 @559  {
dfa19b11385d4cf Matti Vaittinen 2021-06-03  560  	if (poweroff_delay_ms <= 0)
dfa19b11385d4cf Matti Vaittinen 2021-06-03  561  		return;
dfa19b11385d4cf Matti Vaittinen 2021-06-03  562  	schedule_delayed_work(&hw_failure_emergency_poweroff_work,
dfa19b11385d4cf Matti Vaittinen 2021-06-03  563  			      msecs_to_jiffies(poweroff_delay_ms));
dfa19b11385d4cf Matti Vaittinen 2021-06-03  564  }
dfa19b11385d4cf Matti Vaittinen 2021-06-03  565  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--9LOwINS5GLkJwne8
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--9LOwINS5GLkJwne8
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="reproduce"

reproduce (this is a W=1 build):
        mkdir -p ~/bin
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dfa19b11385d4cf8f0242fd93e2073e25183c331
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout dfa19b11385d4cf8f0242fd93e2073e25183c331
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang ~/bin/make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

--9LOwINS5GLkJwne8--
