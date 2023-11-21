Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3BC7F233D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjKUBlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjKUBlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:41:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2F2C3;
        Mon, 20 Nov 2023 17:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700530857; x=1732066857;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cPzLkAjUvJHEUSUwneebWHjCl5NvCrkYrwmMYX6CqvU=;
  b=UqNPhJnwsINvGaSIgNNJa/vEzuf5wPweHCc9MLD2QzBFTOZO+cFcqIP8
   m7VvGsaezwKFZJPIVd+WaUGh/ek7Vg8wGm2LmSkiz0zXn6w82pe2fZI7E
   4twrqSUDiNairLQ1PDrxUVy2z9CXfS4HCrtt7zZ1ZG3yHi2rwWx/VIZgh
   GcPRmNuWnGTVf9BEfQWhHBVdc0qHqItvWPiBUylWnGQZYIAH5ttxT9nKg
   XXXchsuovqSPduj6pNGWBXQojEopAqj3rbZeeTtDqI4DfLSx9Qegsthnf
   R+9R8ChMuMD+RxDBjWQ4jf/o4sT8d/efzOn1bZo//VgB6yGnLCwwlfxn7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="456079394"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="456079394"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 17:40:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="716385152"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="716385152"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 17:40:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 17:40:57 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 17:40:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 17:40:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVXGrx0PUrpeo5tqKhs+Sqvh3hR23bB6v34F9vCHhAmJyK/7S6bbe1mLOoxQ838JASQAhpGhTDqFJH3kFWe5+o4i/9zBLKVRgdFAyWE2yLbT09WEMT0menaYixoiXMPYtSWuMTRO7uo70xSkjKI7/Bcv6FFpcWpZPBHrdoAuwkcnSssKN0hKtsE3kroAzzb6FKH5poZZWMGJ2Uhk5vbdVk3tKn07mcEFYG++Xbrw3FYlsfrCJNOnk/p4m+34kGzkTmriEuouUAGB+w4kl0DGr/c7lLqYcl49BGMub03462Wdw72en/VWP37TjR17b/1SmPUpW8LPbrFPsmDjMng0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWOPlK3FuvHrrkpM7YtbvyOy1VPp/MvoypM+gG1MsSs=;
 b=njlKU06tSAshmVVMlO2ri4aRcLbzLKHrpFJbfmpfSYiYxRBVOvFVW1ofgky6Z3Hlrhi1J4BQUW+1TejFn/Sv+rcUFezwskKt5IgmScSuYj3vqN1Utjt9xbZElzAMJqM8l33R40naMbkHCvxOkeujJMexVrjC7D6yjGDG0R0h6+4N3CYj91TVNrQFKG4EzkGXPznXBeO2kBtaxjmEUBF1UtW2Ae28HIBb/9K6vNqIqiiJnUEGQwRqYc78KcYmfZN/jHmuWWAoPW90xNhVftjn3iHTFHfU5KWb5VdbSkd01WFVK/NoOW24ZwPD+UI4Gq+FeMBud+tfdRYXZzAzzE2GFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 01:40:52 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 01:40:52 +0000
Date:   Tue, 21 Nov 2023 09:36:14 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Larry Finger" <Larry.Finger@lwfinger.net>,
        <linux-doc@vger.kernel.org>
Subject: drivers/virt/vboxguest/vboxguest_linux.c:65: warning: This comment
 starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202311210515.oI9mxbKB-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SJ0PR11MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: f45609c7-71d2-4d5a-5627-08dbea32e562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Or8ruSRPJ39ohoB6xAj4sclVJNro7J5VkLSUYwc7wLBT4MN4wrVxcgiEpg9uY6tI4AC4AixvH0J3JxA+uvytcSifjfzxGvNMA+phio7BicmW5wH8FljNhZOcSrkNmVe7DFK91tJvv2XByZnPploDqvtL2poHC4GYgA+VSPOdxIVu7QrerQiT7Tx57m301ClpE6eSWEwDsG1/Eu5IAVPjKOiIoQjUQGjRrNg+BgtHndSslnzh7p7sLYP8UuGur+xA3PCItMjHYCR58X7aCvHhM07aUaRL6KdbJ/bLxziZwBsEAXy+qQ87PX5ped4xuFyQVe3aQbdWZ3PYn5Z3gg2nRj3zcOLOEvrjNVd3jaK9Hz4UHaaItffvKaxMr3cq3Heai6mDnIRhOATpLFfew42xvtX+fbEA4mLJj8TNM9NIyYXiEKmWKVgDscv+r887E7+VKm/8jQnYBOs7wkN/DcWTlbn5pTxyP95VNJjJw848kbw5Z7pytZOz9RZuE5LTbtvEEQX18BUnhAfdcZMOtdcgiy1ZVnowFspSLzAp3s6vg6itpDqvV2AL/ypNO+LsWtjU9JKnG2Xeu1ukQxYwZSw1DGpxoONTwbiKpPW/g9EuADaGjn74WP8o4FH0Cg+ARzoB7QW6FXs936MsOqyeR/rHyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(66946007)(66556008)(316002)(6916009)(66476007)(26005)(8936002)(4326008)(8676002)(36756003)(38100700002)(4001150100001)(41300700001)(82960400001)(86362001)(2906002)(30864003)(5660300002)(966005)(83380400001)(6486002)(478600001)(6512007)(6666004)(6506007)(2616005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/kwOuvMnPSKaU3V645eLtQkwcPNa7IWWMuW1xh1OLQHFkvk6Pla7z1bSOM49?=
 =?us-ascii?Q?ghdqxDO6po7U/uATtFQ7L+niHM3gnUElEb12QJBbaiPN8+JTkYbuOng5Ecrc?=
 =?us-ascii?Q?m2TBkN52Eq9jsvmxjTKFUPy/hxeBYV1AeIoDZEA0LytXW6tmoSislsJXLNSy?=
 =?us-ascii?Q?UTNTIfneKUmoRsGgygo+hN/O1XVS8zuxBJ+GcDfJ86i5ceewyGMbIWElwqH0?=
 =?us-ascii?Q?Ia73gihlKM4bH7RnMMeQHzOXYe7jsmPB0F1bm1w/bV67FcELLvtqCbA2O9S7?=
 =?us-ascii?Q?jPF3r+azXEaPuUJuI2lY5CVhOelmYkPS02ptB38nyp8cpr5S/EvOaSiSYPVz?=
 =?us-ascii?Q?TEw9Oh/e5J/y4Wv+VdcYGszPEzLYnfT2PSJZtRmAPyd5/J7TF9nCS6UxNTuc?=
 =?us-ascii?Q?a4GylBw1UgyATY32FiUXbaw6d41L3vHdje/42lZDiuEjOmIET0dzzWi/AKoT?=
 =?us-ascii?Q?jVW9Wd7QGomAKZIxffa6YdznARlCokTO046D6ava7IQrRqQIK8GkzyPnEP2/?=
 =?us-ascii?Q?mEpJZ8nXeWd3XTWaXnjBB3aNHjDZYx/guGIwJwyJbS/FvbYw8qXiQKTB4EBg?=
 =?us-ascii?Q?rC4l+4x0Z3WJA1mfehLT+9j0fz6kk1n+1yWNcHyDFFRH0qxgUuIHvVRH+NY6?=
 =?us-ascii?Q?Fwqa+V0erF+IotI2EeyUT6qC2BcgUoaqnyt+aGf8sMbJQYFWoxJB2CCSe86B?=
 =?us-ascii?Q?AXI3voc6VmksL/Y6yVRwGujRA4QuIRil6Bc36t3TsQS80HsXxykFOfiqnEk9?=
 =?us-ascii?Q?/qT46I59RK6QdeWvKSLoLKbawZdlFz6Zi145dKIJcAQw3yeJYBocPTiC3SvA?=
 =?us-ascii?Q?C2Eppu552uso7JJ6pPajPQruWEXhZeGGtGUE13soKR6VqecXBfYsn1Pjy3is?=
 =?us-ascii?Q?zlK63+P1d+GCjSHMbyEu+ux5f4jVto0ldQgu72iWuwvT8mp3QB+swEH/nBRU?=
 =?us-ascii?Q?MDpyVj1K2YHoaMjZdr6cM30foNgQA3+ZKMMke5wHSt3Zxrc1Z3+Bgkq1xkjY?=
 =?us-ascii?Q?HkpjIrtCV6VCqkGpb7UmWEZgD9FfJhYgS0Lt9zaXoeX/PeZRLTakQQN9K/NV?=
 =?us-ascii?Q?61wc8wAOQfuQ3PxKl+x3GjiBIbdPBUZsj9OhlBY+lD4p3gZCr14kDSk8PhCj?=
 =?us-ascii?Q?cTP1Dg/rkpNce+GZ2aTHk8KMB/maGlDSF/cETh+awgjBmOUexvECwa7TwXWb?=
 =?us-ascii?Q?qOpGptQ5CeK4azK4QxK0PG7Ap2u3azqRwsDfeGuWuGyS8WL8icYKF68qGRIt?=
 =?us-ascii?Q?f9yCiBGNjviAVgNUpzF7xk9aw6YQ1Tnq1NpslYXXQ2FJN4iznRewoj/5Ghd0?=
 =?us-ascii?Q?u/xp/az1MlU+9lgBfPwiim0TJIlZ/XbycSCCzMDUOdCOBu3yBatckxUFha0U?=
 =?us-ascii?Q?4tSwcAC7g96kNuCkGIeEUxDi5tHJM3fnud88M2COuox8HyDb6CiW1lQhs3XK?=
 =?us-ascii?Q?w1aDWdZP7kMQC47C9JfIDbByxjwDKZ3K19OW2C0st+6JD3eqz2DVRZKxR3dM?=
 =?us-ascii?Q?aZ7MFu8lOfvd21g1LlaebHK4/949IgWA6rsnqKfh3QnZiM2m5fE6wBWmQGQk?=
 =?us-ascii?Q?PamjAoksH9yPrW+jFLb1QYshM2dT/A2J6yZ05CH/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f45609c7-71d2-4d5a-5627-08dbea32e562
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 01:40:52.2455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/5KUyHXy5V00boxG0OKIzLcDowDMbLfa7KIdBQYVETfFO8f1UK1sZVzq6ACEowq0KPl0w/lpMm1DRlbn03wHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   98b1cc82c4affc16f5598d4fa14b1858671b2263
commit: 0ba002bc4393dcfae031fc707b11c094b46a5048 virt: Add vboxguest driver for Virtual Box Guest integration
config: x86_64-buildonly-randconfig-001-20231012 (https://download.01.org/0day-ci/archive/20231121/202311210515.oI9mxbKB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231121/202311210515.oI9mxbKB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311210515.oI9mxbKB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/virt/vboxguest/vboxguest_linux.c:65: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Close device.
   drivers/virt/vboxguest/vboxguest_linux.c:78: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Device I/O Control entry point.
   drivers/virt/vboxguest/vboxguest_linux.c:161: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Called when the input device is first opened.
   drivers/virt/vboxguest/vboxguest_linux.c:179: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Called if all open handles to the input device are closed.
   drivers/virt/vboxguest/vboxguest_linux.c:191: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Creates the kernel input device.
   drivers/virt/vboxguest/vboxguest_linux.c:243: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Does the PCI detection and init of the device.
   drivers/virt/vboxguest/vboxguest_linux.c:424: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Callback for mouse events.
--
>> drivers/virt/vboxguest/vboxguest_core.c:31: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Reserves memory in which the VMM can relocate any guest mappings
   drivers/virt/vboxguest/vboxguest_core.c:122: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Undo what vbg_guest_mappings_init did.
   drivers/virt/vboxguest/vboxguest_core.c:162: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Report the guest information to the host.
   drivers/virt/vboxguest/vboxguest_core.c:223: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Report the guest driver status to the host.
   drivers/virt/vboxguest/vboxguest_core.c:254: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Inflate the balloon by one chunk. The caller owns the balloon mutex.
   drivers/virt/vboxguest/vboxguest_core.c:304: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Deflate the balloon by one chunk. The caller owns the balloon mutex.
   drivers/virt/vboxguest/vboxguest_core.c:337: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Respond to VMMDEV_EVENT_BALLOON_CHANGE_REQUEST events, query the size
   drivers/virt/vboxguest/vboxguest_core.c:402: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Callback for heartbeat timer.
   drivers/virt/vboxguest/vboxguest_core.c:414: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Configure the host to check guest's heartbeat
   drivers/virt/vboxguest/vboxguest_core.c:440: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Initializes the heartbeat timer. This feature may be disabled by the host.
   drivers/virt/vboxguest/vboxguest_core.c:477: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Cleanup hearbeat code, stop HB timer and disable host heartbeat checking.
   drivers/virt/vboxguest/vboxguest_core.c:489: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Applies a change to the bit usage tracker.
   drivers/virt/vboxguest/vboxguest_core.c:525: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Init and termination worker for resetting the (host) event filter on the host
   drivers/virt/vboxguest/vboxguest_core.c:551: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Changes the event filter mask for the given session.
   drivers/virt/vboxguest/vboxguest_core.c:626: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Init and termination worker for set guest capabilities to zero on the host.
   drivers/virt/vboxguest/vboxguest_core.c:650: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Sets the guest capabilities for a session. Takes the session spinlock.
   drivers/virt/vboxguest/vboxguest_core.c:721: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * vbg_query_host_version get the host feature mask and version information.
   drivers/virt/vboxguest/vboxguest_core.c:757: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Initializes the VBoxGuest device extension when the
>> drivers/virt/vboxguest/vboxguest_core.c:866: warning: expecting prototype for Call this on exit to clean-up vboxguest(). Prototype was for vbg_core_exit() instead
   drivers/virt/vboxguest/vboxguest_core.c:883: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Creates a VBoxGuest user session.
   drivers/virt/vboxguest/vboxguest_core.c:905: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Closes a VBoxGuest session.
   drivers/virt/vboxguest/vboxguest_core.c:1063: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Checks if the VMM request is allowed in the context of the given session.
   drivers/virt/vboxguest/vboxguest_core.c:1423: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Common IOCtl for user to kernel communication.
>> drivers/virt/vboxguest/vboxguest_core.c:1500: warning: expecting prototype for Report guest supported mouse(). Prototype was for vbg_core_set_mouse_status() instead
   drivers/virt/vboxguest/vboxguest_core.o: warning: objtool: vbg_report_guest_info()+0x80: sibling call from callable instruction with modified stack frame
--
>> drivers/virt/vboxguest/vboxguest_utils.c:225: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Preprocesses the HGCM call, validate parameters, alloc bounce buffers and
   drivers/virt/vboxguest/vboxguest_utils.c:289: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Translates linear address types to page list direction flags.
   drivers/virt/vboxguest/vboxguest_utils.c:357: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Initializes the call request that we're sending to the host.
   drivers/virt/vboxguest/vboxguest_utils.c:413: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Tries to cancel a pending HGCM call.
   drivers/virt/vboxguest/vboxguest_utils.c:447: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Performs the call and completion wait.
   drivers/virt/vboxguest/vboxguest_utils.c:528: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Copies the result of the call back to the caller info structure and user
   drivers/virt/vboxguest/vboxguest_utils.o: warning: objtool: vbg_info()+0x6e: sibling call from callable instruction with modified stack frame
   drivers/virt/vboxguest/vboxguest_utils.o: warning: objtool: vbg_warn()+0x6e: sibling call from callable instruction with modified stack frame
   drivers/virt/vboxguest/vboxguest_utils.o: warning: objtool: vbg_err()+0x6e: sibling call from callable instruction with modified stack frame
   drivers/virt/vboxguest/vboxguest_utils.o: warning: objtool: vbg_info.cold()+0x2a: return with modified stack frame
   drivers/virt/vboxguest/vboxguest_utils.o: warning: objtool: vbg_warn.cold()+0x2a: return with modified stack frame
   drivers/virt/vboxguest/vboxguest_utils.o: warning: objtool: vbg_err.cold()+0x2a: return with modified stack frame


vim +65 drivers/virt/vboxguest/vboxguest_linux.c

0ba002bc4393dc Hans de Goede 2017-11-30  63  
0ba002bc4393dc Hans de Goede 2017-11-30  64  /**
0ba002bc4393dc Hans de Goede 2017-11-30 @65   * Close device.
0ba002bc4393dc Hans de Goede 2017-11-30  66   * Return: 0 on success, negated errno on failure.
0ba002bc4393dc Hans de Goede 2017-11-30  67   * @inode:		Pointer to inode info structure.
0ba002bc4393dc Hans de Goede 2017-11-30  68   * @filp:		Associated file pointer.
0ba002bc4393dc Hans de Goede 2017-11-30  69   */
0ba002bc4393dc Hans de Goede 2017-11-30  70  static int vbg_misc_device_close(struct inode *inode, struct file *filp)
0ba002bc4393dc Hans de Goede 2017-11-30  71  {
0ba002bc4393dc Hans de Goede 2017-11-30  72  	vbg_core_close_session(filp->private_data);
0ba002bc4393dc Hans de Goede 2017-11-30  73  	filp->private_data = NULL;
0ba002bc4393dc Hans de Goede 2017-11-30  74  	return 0;
0ba002bc4393dc Hans de Goede 2017-11-30  75  }
0ba002bc4393dc Hans de Goede 2017-11-30  76  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

