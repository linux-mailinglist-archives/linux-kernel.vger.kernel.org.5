Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E458279C62B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjILFIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjILFIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:08:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57570196;
        Mon, 11 Sep 2023 22:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694495321; x=1726031321;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tjdsTIwjijVSVfDuTuBP5wvd+dhM4cQ/bgtRRnJPfGc=;
  b=EU65g8il/0XyVSF7kh6puvXjyBbvBpjMy+3FicJyNVQ5gqz2JuqxyYG1
   NGtPHN7I/U4gZbXwKjURllsmxdj0eNDE6cinLB9aCCpd9oRi+8uKFGF+R
   lj9mmP0BdWX46PO76Cr3KxaX9ZukcFe7RmSvvH2nFAeK2a/oLbJXF7Iyc
   2qODtixmo0b0yecdIaK8RNGvA+YpJjz4wQ16D15GKs5LR8I0N5aVhc4Ob
   PjpLoYxW3FnGc+9lKu1GBwHsHoJ8vaRR/DH+nEPGOlWZe9r0SFedIDVd3
   CjmZX1B0ZlQfM87eeBn8beMjJBwRGm+WrqIvkoOjtcCwaNI7Gnrwu9ggS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="368531371"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="368531371"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 22:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="990365628"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="990365628"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 22:08:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 22:08:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 22:08:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 22:08:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 22:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJhQVHKHKXZcvgNKpX32RjmYfBgEJf3e+Mt9Yuv51B1oPSs3SPmcXNlB8on7NWqHHS6FWlDXZ6wPHIcY3hja/LGM0B2rPN9ovKFrDKxzENG2Cs/ZlmiW1X+wBkkoxLRb4M9r7pcCn0EL3MipmaxwYIVAwkbcUOURAWKp6MAJ81pNc4swWuO6VjZUM8Yw4Ki9gEthUrWdfnJowKZXZoZNQqqGFJAYypjFZrIzW6ixXLex+h7Fv9ZcXZ4T7p2QpvVgxdZFOhbKi5rJorNYzGKNcTihoz2hJkZrTlkZ9khQo/Z3SI7DX9H/c3zD+07lmu1VFa7jHddNQenvDoTY4xaPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhrZ5MCQGp/FYz1/MB61cZV/DUZCfqFQsNMX/FaN6dg=;
 b=PzTirdDq9foss+9EaOzsFmHn3yAW2ag/L9ZigBa/NFF57kSwkZ9zmkqjxO97juLB1aLJq18r3Dbd+L659kfj5MvZC4tKlW9vNRlmPskfUvyrcLOU+m5toiQMQCw1eWJ12Ur0ceI8sGtUQKquTFXKh5Pic1ObzlEVN5dtvNWnP0JhO2lXsUPhyJsQ3M8QAjxaSvIr3ACl59g3roxxXthNejr9ZD0DfamyHqGG7hc1M4O5jIWLOlSlztP/o6wGDMx8phkSGG8sOyk4n2oAsLnG9jcTABsoA0OCxDeEVHiyvBQDhqWlG647cXq2e80l44oqfqR3TvGVWOFflNC443cx1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 05:08:28 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 05:08:28 +0000
Date:   Tue, 12 Sep 2023 13:08:16 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        <linux-block@vger.kernel.org>, <nbd@other.debian.org>,
        <oliver.sang@intel.com>
Subject: [linus:master] [nbd]  0c1c9a27ce: blktests.nbd/002.fail
Message-ID: <202309121232.767ff8c4-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|CO1PR11MB4881:EE_
X-MS-Office365-Filtering-Correlation-Id: a566971a-59cd-481a-50fe-08dbb34e4b77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7AVADLL3mOJPK2QB+kF65FgOsSTXfPm7TqTbloapr+SM65kEBehBfEEcPEZy/Ko/sQYyhgBMhuCebA75S54lFdFUEyPGd7Zj5GwyTGNszu24D+m5iJX7jcoAPQNw0cDYYn8jHN6I8U1NmaKFDYzaNl1+xiygZfFyVfQadHDTr7SY5jH2dLoaYbzKhDwmq+vQXy7KfhOZBo8krfyQrYBRK50eibkay6cDFtddKH5R40rB4ag2VzKjM4wnNP7fB220br+wX+8tScF1zRPAQVm5KZMMtgtnrjNqmSxajRpbqdcz5q76x4NMi2J2tV6j/mBYpzkGFoJE9Nmi9iRgrMzDLA5GGU0OI5uZNPC8WhwESp7xcMCgsZItXnq4CPbAn/FzXRBL569RH2hFaqZrmcAVgVEskCr7PJNnWul1Rm8BX5Cxll+iK/Q3SQKbf1usg01lYlzaxzu3ppvW5l0g/P8qo4+2pdp193fv0H9bKZCJ98Yknj5OSllJeb/sLQlfgbdidJQHdwbrQ25grc75XKty+4P865S1kjxzbfRkeuWCDewOU7l+H1LdWFb55iwahcQliI7fKUaUSOGZhpmj3y0Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(346002)(376002)(186009)(1800799009)(451199024)(86362001)(5660300002)(82960400001)(26005)(8936002)(2616005)(8676002)(4326008)(1076003)(107886003)(83380400001)(36756003)(2906002)(38100700002)(6506007)(6486002)(6666004)(6916009)(66946007)(54906003)(66476007)(66556008)(478600001)(966005)(41300700001)(6512007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jHmQBLW2GXSU8OpjcEXJC4gZlf2qW7+OJ9a0gM0S1dg6B3vufqaqU0QZq0Ul?=
 =?us-ascii?Q?Oz/Tkly2540DHmwWGwd0xp09Acu9NEHokskoSwwRwhVxuJYm64z6SoN3Tq8z?=
 =?us-ascii?Q?Xkmpe+tycE3wt85CKbedpNYQ1s7586/Ldn8RDZefNrCSYpCqUpi3cd7YRgH2?=
 =?us-ascii?Q?UwoOqdOcpLBOlKYgmTzF4G/1RdwqFYWT86OTSKo9V1gSPnYc+Q7vvd82YoRr?=
 =?us-ascii?Q?5lxmICPm6l5I2qh0UsEl8vv02B5BVS2rVsJMGQPDtDzjp571V1AZSVKO+H1d?=
 =?us-ascii?Q?7Z6WlKy7S6hShGSr0b9Y8UgWZLYvPUKmyZy2bCih/Qymn6xbXx8LMgPj6+IO?=
 =?us-ascii?Q?MtwwhEpFixfi8SeCdBSws4Ck31K0j6tg+/KRFxLBern8X3odvd32Yds16b4Y?=
 =?us-ascii?Q?bJyW1r9zX7ANp6MdqwMBimJWeKc7y/TG1VGpwKDE/LuzkKaIb8ugkUQQW3BQ?=
 =?us-ascii?Q?Qg6SQRGHbA41+qQDtIPK6yduz4aLq2bCTtIKbNVUBiWkfMDvUegv9qeWTPK6?=
 =?us-ascii?Q?YqEFUSpk03gqZRoxjF12nLBYr/O9eryc6hdlnLz8RuY/YOnwTd8Eq88FoeYj?=
 =?us-ascii?Q?WPK5ks3t0g9Qojy8G7iddr5TjDaNEhatEy23EWrI7zcu1bl5imnS6Uu4KPbd?=
 =?us-ascii?Q?NXF5wsDNXIk8Vy3/NwZGHng6p7chK+0JG8J9oHwliPPwVBsDBzWarE0lFw3n?=
 =?us-ascii?Q?vg5XpcCbKgqs9COwNza7i9GdU5B+igBVKjWnGq2OfxcFW24LqqXmTQ0f2qPL?=
 =?us-ascii?Q?YID0o53aX4Rmvke3JUHrh6b71oG4sy0FMqcWG6igjRvRXEBQ8yi7KFMBgVFZ?=
 =?us-ascii?Q?gKsCwIJtzO+3H3RPBNT4v0uA1uUcSUZUDQsmgufj1v7WM/+52XjltlIqgdc3?=
 =?us-ascii?Q?cRFHcR/LMhfytFO3aspjlArVxQADzuAIJLUVWVHZoyMPIDqHxQleVuKEIyIn?=
 =?us-ascii?Q?kjtMikraDNFRjdxr7LdbaF1dBFfrbkqJw73gsEPEluorNjoUuNJqDhK6DxzZ?=
 =?us-ascii?Q?sNHVfmE62VQEIDBBfqmTutyExsB5ZQw3HYOAYv/NR/0OS4g0FKV0cTZ7Twu0?=
 =?us-ascii?Q?NaWVCaizpgPznbp6n0IHl59KOZallel5y0/wG3oPGJF/SC7Aiof+owYntJM/?=
 =?us-ascii?Q?J8ecA4l9lGAeQ+9KMOtTrOtDR4uUINMIN3xv4P643rMQeAo0u/+cXqyKEJXT?=
 =?us-ascii?Q?qzHkHeqFOOeruJLp1HXaJDzOuzr+Z59CYoj7+Fbb2GOUIiO+q+9i4PL7MUvv?=
 =?us-ascii?Q?DPSHSHfbadLcOgi/9K8rlBWcWmPL2wEbgDbk9yWD6KuQd6mHtlNoPhbZ53/W?=
 =?us-ascii?Q?z4tdKkA1t5OLbJIw5w/oVN3o57QxyI3ZWhDXRiwgpCe+FVS4Hk6sz4QycFx/?=
 =?us-ascii?Q?UOWx80nuNp+y53W5JPPmppBE6MXVdt3M9rm+uUV9atFY5KigmJlqjiWoEEmQ?=
 =?us-ascii?Q?RdpsJH454wc/sXQWQr7hI6q5T7efrzXTlCiSWNZZNWgWr/t8HML6ScJdnF+Y?=
 =?us-ascii?Q?ODVh5tELUtPAubxZeUiW2fZjfs66tMaX31oAOpBLWp8if+Uc0YzFqJbfAYBz?=
 =?us-ascii?Q?4gfngxMdDHt77MKD6F3iLYkXu5ra6RUArDO9yRGXL9aUOXM5BqXRx0opm/hN?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a566971a-59cd-481a-50fe-08dbb34e4b77
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 05:08:27.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /tFb9Pp/3/2npTZC3r248gf5V1bprZ4b/Ja9ZQn78yNigQcnV454o3qFqQ2C5yQCTNEhF+cfCoL/jItsStF7JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "blktests.nbd/002.fail" on:

commit: 0c1c9a27ce909e3988f8c6407e26a22a7e1cd276 ("nbd: call blk_mark_disk_dead in nbd_clear_sock_ioctl")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master 0bb80ecc33a8fb5a682236443c1e740d5c917d1d]
[test failed on linux-next/master 7bc675554773f09d88101bf1ccfc8537dc7c0be9]

in testcase: blktests
version: blktests-x86_64-2045e8d-1_20230905
with following parameters:

	test: nbd-002



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309121232.767ff8c4-oliver.sang@intel.com

2023-09-11 10:11:30 echo nbd/002
2023-09-11 10:11:30 ./check nbd/002
nbd/002 (tests on partition handling for an nbd device)     
nbd/002 (tests on partition handling for an nbd device)      [failed]
    runtime    ...  4.474s
    --- tests/nbd/002.out	2023-09-05 16:51:33.000000000 +0000
    +++ /lkp/benchmarks/blktests/results/nodev/nbd/002.out.bad	2023-09-11 10:11:35.949540198 +0000
    @@ -1,4 +1,4 @@
     Running nbd/002
     Testing IOCTL path
     Testing the netlink path
    -Test complete
    +Didn't have parition on the netlink path



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230912/202309121232.767ff8c4-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

