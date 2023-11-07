Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3E7E32A9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 02:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjKGBok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 20:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGBoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 20:44:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD4C11F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 17:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699321472; x=1730857472;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=DWaVWjkX9ij4JVC1KM2yJ8OE2/OipC+4o5X8WvzkSn8=;
  b=l9i6JvkUAgrrRiAKIZAlrXCu7hvC6Pl33juhzT+fYQWsCrjyZqZaQxZX
   DGmIgqRntHB8/aa9lMlWSUVO9Mh6Got7NOIWZ0OoaQeKuCd74okJGQHjz
   t/tnswj7I53rbc6CvyjP7rZ/8OXUmhQisGniJ+u/y1t5gUu0W7SZbyD7s
   mm9XXYxWpnVVh1QenCDSS6khwn4SolUAVfVXGOeDB/6XhIbHoelyEtvki
   LvuV6WcDfunlm295h4HozbiV7S/yuYJe3X1FILDuWvaNwy7Zhl6UQZ3i2
   I3Rqbn4wUA2iy9Ko+k+qZ0ep38R2F+rDut6oLRWTNxevTZp520qc2RBXj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="475648709"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="475648709"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 17:40:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="879635735"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; 
   d="scan'208";a="879635735"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 17:40:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 17:40:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 17:40:58 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 17:40:58 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 17:40:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odK1PO7WCf5W93yr7KG4UcctofLo9f54ofCiSiWL2rxsSc9Dp5YpLoJEzDneuuFp8HkKFjzD7f2invJjK3gLGx0Pl86Sh3y/RjhgDuVDhTUSB40OClDarmb1roQ/6svAno8+n9Rt3C0V36QzCdLgOnKK7/heYcgiRlQcEHVAze4HpWMzE0aJ8XqT6DhUH6nc8oyxeM8nfpzQ2GnFHU5wcfj7ujQ898T8y+IC1nmhHd8Gj5e/7XK8LdeFbm1MwqhKhFka57FJ3DZhlSYw1ARcGGAna2O1KiZ/vECiQXNGNlEj5eLKvO0OwAL/ynifRuftzmPSqo+LvKDCHaUsb8L3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1CkmkZsmH7yBBSEYct1z+vojqiTu+tPLRunvJ+lsA4=;
 b=PtUpT5jlSQDp9DV16WMKBjxq892c/wvIbgbvXe1W8Lf5HF8EZdcg6zZJomXOHGFRyCzgbGXoP64tHfyM3Zywa606b1o9KFSbnAWJtMnnBzEfUaUBh2OCDeje4etIfDwGLR3/uZaHvaBdSoEvoHQLCxwbTcI6uDs40zGYqAmR7Z8hMXRlAqnpFz7BKPpoABpyzX+A1Ys/+n4ghMnd7RY2cN7Pea5UaBnft/kn81Xy5zL3Ceow7ctvYLzWE3JDKDZ0wtXWXikdPWJvG8sNTHxE63vJEuNqU98ZrV3GCgJTovnTBM5vFC+FlcARjbHkv/R1+oPrlT/dHttvIu66ClmhVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM4PR11MB7253.namprd11.prod.outlook.com (2603:10b6:8:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 01:40:50 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 01:40:50 +0000
Date:   Tue, 7 Nov 2023 09:40:41 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     David Howells <dhowells@redhat.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David Laight" <David.Laight@aculab.com>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <oliver.sang@intel.com>
Subject: [linus:master] [iov_iter]  c9eec08bac:  vm-scalability.throughput
 -16.9% regression
Message-ID: <202311061616.cd495695-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0084.apcprd02.prod.outlook.com
 (2603:1096:4:90::24) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM4PR11MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b70b14f-7854-4e53-72ca-08dbdf32927e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MuNlorjCvbEirJdeZlp/qhF8ICHy3hlqmOkzTR+NhkPS7gSIySrzJ9+lBqztR80bTKH2y+iKsdVLDbYds6xVKeoNXj+lywuFMUg0UzfRx94vFZvGnxyK3CnRULLsWmCTSCvgVQLJ6FT9i2uSm7p3nHSaZBFlw9a5qAOzzAqOzpywv/PZYgxiURngLxur7SemV0v03xcxC8NONAKeRxTkkc0LJGHy3nzWf5bj5iaEPKTcKG29CshYCRZV+VsQIskbvqCxIjmz/OlBiUu9kcGDR/6lwmYSRFz9+Zl0elpGUi6CtytPWljZGZ1maJmlyyQUEOi+YkkRLi75jJxg7ZXFbqWfnZEjG2a/R2tZcQJrnDd3HMNSo2qQq91CI+yAS0LrNsgtE2f9iKILJ8at1ubJwmhj4pYmJwAjOrmTpVZjvxjn+pEm7y0gBWjEhlzfeVvkPXwaTDghwgeJdVkI7X/A4K/TuQ1YjHGCc6lBTv7zR36wsixebzvxyJS8352D9FSsK6EnelJzYC8z11p9BvP4IyVCAJqxYoecJDdsdrHX+gNnnOUdSPSsyAJKEGN1+ngDzjujsAqJ5nBNJuwupEr0SigRZlSf4owLzoiMpVSpeCnrjDIlD0glPXK8H7oETMYZY5OS15XcCdO9z9EiwILMPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230473577357003)(230922051799003)(230373577357003)(64100799003)(451199024)(1800799009)(186009)(2906002)(38100700002)(30864003)(4326008)(8936002)(8676002)(41300700001)(5660300002)(83380400001)(7416002)(86362001)(82960400001)(6512007)(107886003)(2616005)(66899024)(1076003)(316002)(66556008)(66476007)(54906003)(6916009)(66946007)(6506007)(6666004)(966005)(26005)(6486002)(478600001)(36756003)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MSixIKM62vBboq3cFmcO6IvEMTQhAHFBoS5x4Hw4SEFSJzhdRQtw/EgFvV?=
 =?iso-8859-1?Q?OCj84EzMhyqpTT8VnZKZAhfxjAFsnWX9HGSBy3xQfHFfeXSHoiOtvf3HMU?=
 =?iso-8859-1?Q?+WyBE3MwwrmpMceaYpWhpjsa3FsAgiGWn7AcsG+EQ8WUJLPWD/VW9ONZye?=
 =?iso-8859-1?Q?KR/v/X62etTqR+2ytO3XEJFqoG8vS9j5z067I5I1BLy0YSBZYvICX6+LPC?=
 =?iso-8859-1?Q?W4Jjjnuz7WdKo0IBBkHJo00Yq9LZv3+o4hqeTEecPYKU7JgkEGzt8vLmKZ?=
 =?iso-8859-1?Q?SCdTTSVfeHCtS/1kG+Kk5j0suodcPfEnv/Av60mXWzcBcUjgmjIdWJ9xlW?=
 =?iso-8859-1?Q?sP9t85rm7KMQZQAWYwS5f+WM1rmy2X7gnCLsPUis0hiHOuos1UKRcxF0/r?=
 =?iso-8859-1?Q?nZDorf6P4bmBgFKZLWWo1ehNRSNCwu0prJKU/gD25POBqqc7FD4KwMb6Pc?=
 =?iso-8859-1?Q?rDVG/wvGOzYsUOEnsMeHkvyK2cUVPSuvso3PT+VMdxnN0POfA7qocDUVkT?=
 =?iso-8859-1?Q?dzVX4Gojg1xtDKYLEoZMJIHHrgbcPoigcCWGvYv0y8eGipcfyo1ITX69ZQ?=
 =?iso-8859-1?Q?lcmFVNwXi9qTGT75TjcNy5o7HRIYbuxpD1oaZxo70wtJ+NNFd6zGcQj1gk?=
 =?iso-8859-1?Q?eedo5lY1j3cQTb/Ya5rCqaPxvCggkRZ8yeSAKbp5nFANVy0/n5sLdr8naO?=
 =?iso-8859-1?Q?XmzKzErW6nKP8epncBA4b0dud9KX1+AGVJmD4BlgDNOkOuWJjlqPj6olRR?=
 =?iso-8859-1?Q?Hv6bedd4khYmq197r/SBSvAL6iyZ/rFM0+HHL7hdufBKxER9HJ21vfy5mM?=
 =?iso-8859-1?Q?WKvo5swoY+DTVrrLfLXll4o4Idm9NONeNDt3lQX3EgDR2bdE+1swZcwa/r?=
 =?iso-8859-1?Q?nzeNBEF0qodVODltWVC2K21fks98INVN9eZdyrnxv6amgiFrkLZfh9ANj/?=
 =?iso-8859-1?Q?SBRFPkNBLw0okOrwagwx2ozpsP40AFaym8nJEjfGmsklwB+NIHSJ/P6M1i?=
 =?iso-8859-1?Q?HwkZGM9x8FYUYK7d6PqCWlS6wQssPFDBrQ3UMCXrvigwdzhjMktKj8Krr9?=
 =?iso-8859-1?Q?nBB3TjmVFelmS7UMGTpHLUn2arKdr6BCB3XnZvBRYt+46JC1mB5TaxNE6v?=
 =?iso-8859-1?Q?T6dm/TTEYxUQGbVQMUVMdPwjfO+CJgAUAcGZsYAcx4WgH0VwN/d4afGAp7?=
 =?iso-8859-1?Q?1D/VrCRTsA5H649Zc6pGBS8k4zw49dHnvADHaIK1Ph8jwFrzjn9jTK3vBK?=
 =?iso-8859-1?Q?V0Aheb5bU6yLN3oMP4Z4UUs2ufSv4fb1I2YxCGYKKpOJU0dqEU1qiEgYm4?=
 =?iso-8859-1?Q?BH5rvDc8HcPROV5Nhbn0ahYTfjJ036yf7uTL/2Ul1llGEWc65+pqTepI+m?=
 =?iso-8859-1?Q?cS2W3InzKla4Ls5i/CBRPPM/PQkS9j3FJYXdDkxKBntV8qywzwLCeery6F?=
 =?iso-8859-1?Q?JO8jBMCghHOmpcyEOt1EbNQ/BzOCPwQvyMVtdJe2iPupLMjxoAb8VRYatP?=
 =?iso-8859-1?Q?8i6+qets1xeHVbOfmF5M6Ad34HP4rx564392Mk9GintHa1r7/T0lCot9wl?=
 =?iso-8859-1?Q?LB4OZ5fKuLhZik4li9bKJNZFS5X0hqMBV5v3Mq0fXt5WbBh/j2g4NGJuLr?=
 =?iso-8859-1?Q?txoqdEN/rgAx4TFPSNPNQ6jDDVy98vy/+z?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b70b14f-7854-4e53-72ca-08dbdf32927e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 01:40:50.6895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tHcaia9jZYU0iSJJsevbdRgTFsfmzzpVJNa9QHaEU/7aclLatHDOfpFJxblm14OwiUVp/fPzQNSGYCQHpFqJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7253
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



Hello,

kernel test robot noticed a -16.9% regression of vm-scalability.throughput on:


commit: c9eec08bac96898573c236af9cb0ccee765684fc ("iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: vm-scalability
test machine: 224 threads 4 sockets Intel(R) Xeon(R) Platinum 8380H CPU @ 2.90GHz (Cooper Lake) with 192G memory
parameters:

	runtime: 300s
	size: 256G
	test: msync
	cpufreq_governor: performance

test-description: The motivation behind this suite is to exercise functions and regions of the mm/ of the Linux kernel which are of interest to us.
test-url: https://git.kernel.org/cgit/linux/kernel/git/wfg/vm-scalability.git/



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311061616.cd495695-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231106/202311061616.cd495695-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
  gcc-12/performance/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/300s/256G/lkp-cpl-4sp2/msync/vm-scalability

commit: 
  f1982740f5 ("iov_iter: Convert iterate*() to inline funcs")
  c9eec08bac ("iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()")

f1982740f5e77090 c9eec08bac96898573c236af9cb 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     17367           -16.8%      14444        vm-scalability.median
      6.13 ± 26%      +4.3       10.39 ± 18%  vm-scalability.stddev%
   6319269           -16.9%    5252011        vm-scalability.throughput
    309.64            +6.3%     329.22        vm-scalability.time.elapsed_time
    309.64            +6.3%     329.22        vm-scalability.time.elapsed_time.max
  1.77e+09           -11.1%  1.574e+09        vm-scalability.time.file_system_outputs
 2.357e+08           -11.1%  2.095e+08        vm-scalability.time.minor_page_faults
    595.33           -15.1%     505.50        vm-scalability.time.percent_of_cpu_this_job_got
      1452            -9.9%       1308        vm-scalability.time.system_time
    392.26 ±  2%      -8.9%     357.20 ±  3%  vm-scalability.time.user_time
   1369046            -4.4%    1308968        vm-scalability.time.voluntary_context_switches
 9.952e+08           -11.1%  8.846e+08        vm-scalability.workload
     95.00 ±  5%     +37.9%     131.00 ±  4%  perf-c2c.DRAM.local
      2.17            -0.3        1.90        mpstat.cpu.all.sys%
      0.39 ±  2%      -0.1        0.34 ±  2%  mpstat.cpu.all.usr%
    264231 ±  7%     +20.1%     317338 ±  9%  numa-meminfo.node1.Writeback
   3161539 ±  6%     +11.1%    3513478 ±  3%  numa-meminfo.node2.Inactive(anon)
   2798749           -16.1%    2347030        vmstat.io.bo
      7.61 ±  4%     -12.7%       6.64 ±  6%  vmstat.procs.r
     16971           -10.4%      15204        vmstat.system.cs
   1378902 ± 38%    +389.9%    6755495 ± 45%  numa-numastat.node0.numa_foreign
   4177825 ± 40%     -64.1%    1500551 ±107%  numa-numastat.node0.numa_miss
   4264407 ± 39%     -63.4%    1562785 ±101%  numa-numastat.node0.other_node
   5590015 ± 78%     -62.7%    2085869 ±113%  numa-numastat.node3.numa_foreign
    169.33 ±  2%     -10.4%     151.67        turbostat.Avg_MHz
      4.47 ±  2%      -0.5        4.00        turbostat.Busy%
    435.99            -1.9%     427.64        turbostat.PkgWatt
     21.64            -3.5%      20.88        turbostat.RAMWatt
    124185 ± 13%     -32.3%      84070 ± 10%  sched_debug.cfs_rq:/.avg_vruntime.min
    124185 ± 13%     -32.3%      84070 ± 10%  sched_debug.cfs_rq:/.min_vruntime.min
    105.08 ± 37%     -61.2%      40.75 ±  7%  sched_debug.cfs_rq:/.runnable_avg.avg
    164.08 ± 14%     -32.5%     110.71 ±  4%  sched_debug.cfs_rq:/.runnable_avg.stddev
    104.27 ± 38%     -61.2%      40.49 ±  7%  sched_debug.cfs_rq:/.util_avg.avg
    162.41 ± 15%     -32.4%     109.74 ±  4%  sched_debug.cfs_rq:/.util_avg.stddev
      2781 ± 24%     -44.3%       1549 ± 14%  sched_debug.cpu.curr->pid.stddev
      0.59 ±  7%     +12.4%       0.66 ±  4%  sched_debug.cpu.nr_uninterruptible.avg
  55282809 ±  6%     -13.7%   47726748 ±  6%  numa-vmstat.node0.nr_dirtied
   1145143 ±  9%     -20.4%     912102 ± 17%  numa-vmstat.node0.nr_free_pages
  55282809 ±  6%     -13.7%   47726748 ±  6%  numa-vmstat.node0.nr_written
   1378902 ± 38%    +389.9%    6755495 ± 45%  numa-vmstat.node0.numa_foreign
   4177825 ± 40%     -64.1%    1500551 ±107%  numa-vmstat.node0.numa_miss
   4264407 ± 39%     -63.4%    1562785 ±101%  numa-vmstat.node0.numa_other
     65521 ±  8%     +20.8%      79128 ± 10%  numa-vmstat.node1.nr_writeback
  56237202 ±  6%     -11.8%   49599462 ±  4%  numa-vmstat.node2.nr_dirtied
    789922 ±  6%     +11.2%     878674 ±  3%  numa-vmstat.node2.nr_inactive_anon
   7363130 ± 14%     -25.5%    5486565 ± 13%  numa-vmstat.node2.nr_vmscan_immediate_reclaim
  56237202 ±  6%     -11.8%   49599462 ±  4%  numa-vmstat.node2.nr_written
    789923 ±  6%     +11.2%     878673 ±  3%  numa-vmstat.node2.nr_zone_inactive_anon
  56312677 ±  5%     -13.8%   48559691 ±  7%  numa-vmstat.node3.nr_dirtied
  56312677 ±  5%     -13.8%   48559691 ±  7%  numa-vmstat.node3.nr_written
   5590015 ± 78%     -62.7%    2085869 ±113%  numa-vmstat.node3.numa_foreign
     10311 ± 35%     -68.9%       3204 ± 72%  proc-vmstat.compact_success
  14371045 ±  2%      +3.7%   14896466        proc-vmstat.nr_active_file
     98005            -1.9%      96096        proc-vmstat.nr_anon_pages
 2.213e+08           -11.1%  1.967e+08        proc-vmstat.nr_dirtied
   3160899            +9.1%    3447334 ±  2%  proc-vmstat.nr_inactive_anon
  27214352 ±  2%     -14.1%   23369413 ±  2%  proc-vmstat.nr_vmscan_immediate_reclaim
 2.213e+08           -11.1%  1.967e+08        proc-vmstat.nr_written
  14371387 ±  2%      +3.7%   14896745        proc-vmstat.nr_zone_active_file
   3160900            +9.1%    3447332 ±  2%  proc-vmstat.nr_zone_inactive_anon
     19216 ± 11%     -71.2%       5539 ±  4%  proc-vmstat.numa_hint_faults
      9725 ± 31%     -70.0%       2917 ± 59%  proc-vmstat.numa_hint_faults_local
      1996 ± 71%     -76.8%     462.83 ± 80%  proc-vmstat.numa_pages_migrated
 3.344e+08           -11.4%  2.964e+08        proc-vmstat.pgactivate
 2.646e+08           -10.0%  2.382e+08        proc-vmstat.pgalloc_normal
 1.158e+08 ±  4%     -13.7%   99968494 ±  3%  proc-vmstat.pgdeactivate
 2.374e+08           -11.1%  2.111e+08        proc-vmstat.pgfault
 2.673e+08           -10.1%  2.402e+08        proc-vmstat.pgfree
      3693 ±  3%     -12.6%       3227 ±  3%  proc-vmstat.pgmajfault
 8.853e+08           -11.1%  7.869e+08        proc-vmstat.pgpgout
 1.158e+08 ±  4%     -13.7%   99968494 ±  3%  proc-vmstat.pgrefill
    127095 ±  2%     -10.4%     113877        proc-vmstat.pgreuse
  28337584 ±  2%     -14.4%   24247338        proc-vmstat.pgrotated
  61733485 ±  2%     -11.9%   54360975 ±  4%  proc-vmstat.pgscan_file
  45323460 ±  5%      -9.5%   40999529 ±  8%  proc-vmstat.pgscan_kswapd
   6262367 ±  4%     -20.7%    4965325 ± 11%  proc-vmstat.pgsteal_direct
  31649958 ±  3%     -11.4%   28049294 ±  6%  proc-vmstat.pgsteal_file
  11627904            -6.8%   10841344        proc-vmstat.unevictable_pgs_scanned
   6985805 ±  2%     -18.0%    5728058 ± 10%  proc-vmstat.workingset_activate_file
   7061865 ±  3%     -12.0%    6214389 ±  5%  proc-vmstat.workingset_refault_file
   6985038 ±  2%     -18.0%    5727368 ± 10%  proc-vmstat.workingset_restore_file
      9.17            -9.3%       8.31        perf-stat.i.MPKI
 5.443e+09           -17.6%  4.486e+09        perf-stat.i.branch-instructions
  13498005 ±  4%     -13.9%   11626468 ±  2%  perf-stat.i.branch-misses
     80.16            -2.8       77.38        perf-stat.i.cache-miss-rate%
 1.985e+08           -26.1%  1.467e+08        perf-stat.i.cache-misses
 2.439e+08           -24.0%  1.854e+08        perf-stat.i.cache-references
     16944           -10.7%      15132        perf-stat.i.context-switches
      1.41           +12.8%       1.60 ±  5%  perf-stat.i.cpi
 3.482e+10 ±  2%     -11.4%  3.086e+10        perf-stat.i.cpu-cycles
    360.77            -6.1%     338.94        perf-stat.i.cpu-migrations
      0.02 ±  5%      +0.0        0.02 ±  3%  perf-stat.i.dTLB-load-miss-rate%
    826726            -9.6%     747639 ±  3%  perf-stat.i.dTLB-load-misses
 5.721e+09 ±  2%     -21.9%  4.467e+09        perf-stat.i.dTLB-loads
      0.13            +0.0        0.15        perf-stat.i.dTLB-store-miss-rate%
   3828019 ±  2%     -17.2%    3168599        perf-stat.i.dTLB-store-misses
 2.814e+09           -26.4%  2.071e+09        perf-stat.i.dTLB-stores
     55.13            -0.7       54.40        perf-stat.i.iTLB-load-miss-rate%
   4113741           -10.8%    3670976 ±  2%  perf-stat.i.iTLB-load-misses
   3278251            -8.8%    2989968        perf-stat.i.iTLB-loads
 2.171e+10           -20.0%  1.736e+10        perf-stat.i.instructions
      5084           -10.0%       4578        perf-stat.i.instructions-per-iTLB-miss
      0.85           -13.1%       0.74 ±  3%  perf-stat.i.ipc
      1448 ±  5%     -14.8%       1233 ±  9%  perf-stat.i.major-faults
      0.15 ±  2%     -11.4%       0.14        perf-stat.i.metric.GHz
    925.09           -11.4%     819.35        perf-stat.i.metric.K/sec
     62.72           -21.4%      49.31        perf-stat.i.metric.M/sec
    703868           -16.4%     588183        perf-stat.i.minor-faults
     80.84            -5.4       75.47        perf-stat.i.node-load-miss-rate%
  10635123           +18.7%   12623931        perf-stat.i.node-load-misses
   2610552           +59.3%    4158136 ±  2%  perf-stat.i.node-loads
     76.21            -2.7       73.54        perf-stat.i.node-store-miss-rate%
  46019985 ±  2%     -36.6%   29187579        perf-stat.i.node-store-misses
  16991220 ±  3%     -26.7%   12448792        perf-stat.i.node-stores
    705316           -16.4%     589415        perf-stat.i.page-faults
      9.21            -7.2%       8.54        perf-stat.overall.MPKI
     81.37            -2.2       79.20        perf-stat.overall.cache-miss-rate%
      1.65           +10.7%       1.82        perf-stat.overall.cpi
    178.71           +19.4%     213.30        perf-stat.overall.cycles-between-cache-misses
      0.01 ±  2%      +0.0        0.02 ±  4%  perf-stat.overall.dTLB-load-miss-rate%
      0.14            +0.0        0.15        perf-stat.overall.dTLB-store-miss-rate%
      5329           -10.1%       4789        perf-stat.overall.instructions-per-iTLB-miss
      0.61            -9.7%       0.55        perf-stat.overall.ipc
     80.15            -5.0       75.17        perf-stat.overall.node-load-miss-rate%
     72.82            -2.9       69.89        perf-stat.overall.node-store-miss-rate%
      6918            -4.2%       6625        perf-stat.overall.path-length
 5.505e+09           -17.4%  4.549e+09        perf-stat.ps.branch-instructions
  13649952 ±  4%     -13.7%   11775243 ±  2%  perf-stat.ps.branch-misses
 2.023e+08           -25.6%  1.506e+08        perf-stat.ps.cache-misses
 2.487e+08           -23.6%  1.901e+08        perf-stat.ps.cache-references
     16976           -10.7%      15156        perf-stat.ps.context-switches
 3.616e+10 ±  2%     -11.2%  3.211e+10        perf-stat.ps.cpu-cycles
    364.05            -6.1%     341.97        perf-stat.ps.cpu-migrations
    836446            -9.5%     756895 ±  3%  perf-stat.ps.dTLB-load-misses
 5.773e+09 ±  2%     -21.7%  4.521e+09        perf-stat.ps.dTLB-loads
   3873256 ±  2%     -16.9%    3216923        perf-stat.ps.dTLB-store-misses
 2.862e+09           -26.0%  2.119e+09        perf-stat.ps.dTLB-stores
   4124868           -10.7%    3682495 ±  2%  perf-stat.ps.iTLB-load-misses
   3267583            -8.7%    2983240        perf-stat.ps.iTLB-loads
 2.198e+10           -19.8%  1.763e+10        perf-stat.ps.instructions
      1468 ±  4%     -15.2%       1245 ±  9%  perf-stat.ps.major-faults
    711215           -16.2%     596020        perf-stat.ps.minor-faults
  10655899           +18.5%   12627905        perf-stat.ps.node-load-misses
   2638928           +58.0%    4170441 ±  2%  perf-stat.ps.node-loads
  47247465 ±  2%     -35.7%   30389920        perf-stat.ps.node-store-misses
  17634674 ±  3%     -25.7%   13094211 ±  2%  perf-stat.ps.node-stores
    712683           -16.2%     597265        perf-stat.ps.page-faults
 6.885e+12           -14.9%  5.861e+12        perf-stat.total.instructions
      0.00 ± 35%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
      0.02 ± 52%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      0.00 ± 17%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00 ± 62%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.page_cache_ra_order.filemap_fault.__do_fault
      0.00 ± 28%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.down_read.xfs_ilock_for_iomap.xfs_read_iomap_begin.iomap_iter
      0.00 ± 31%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.shrink_active_list.shrink_lruvec.shrink_node_memcgs.shrink_node
      0.02 ± 43%     -78.5%       0.00 ± 22%  perf-sched.sch_delay.avg.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.02 ± 24%     -91.6%       0.00 ±100%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      3.27 ± 12%     -51.4%       1.59 ± 73%  perf-sched.sch_delay.avg.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_cleanup_planes
      0.01 ± 21%     -61.2%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.01 ± 12%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.01 ±  9%     -41.5%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.01 ± 32%     -54.5%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.00 ± 10%     -50.0%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.02 ±  7%     -73.9%       0.01        perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.01 ± 26%     -67.9%       0.00 ±108%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.01 ± 58%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.00 ± 56%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.01 ± 27%     -82.2%       0.00 ±141%  perf-sched.sch_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.01 ± 11%     -36.8%       0.00        perf-sched.sch_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      0.01 ± 13%     -68.8%       0.00 ±141%  perf-sched.sch_delay.avg.ms.kswapd_try_to_sleep.kswapd.kthread.ret_from_fork
      0.01 ± 15%     -69.3%       0.00 ±  9%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.02 ±  9%     -62.6%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.01 ±  8%     -44.6%       0.01 ±  9%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.01 ± 82%     -77.3%       0.00 ± 50%  perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xfs_map_blocks
      0.00 ± 63%   +3966.7%       0.06 ± 68%  perf-sched.sch_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.01 ± 10%     -31.7%       0.00 ± 10%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.01 ± 10%     -58.9%       0.00 ±  9%  perf-sched.sch_delay.avg.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
      0.01 ±  9%     -25.6%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.sigsuspend.__x64_sys_rt_sigsuspend.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.03 ±  7%     -65.2%       0.01 ±  5%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 12%     -45.2%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.00 ± 11%     -40.7%       0.00 ± 17%  perf-sched.sch_delay.avg.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
      0.25 ± 11%     -82.4%       0.04 ± 35%  perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 51%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xfs_extent_busy_flush.xfs_alloc_ag_vextent_near.xfs_alloc_vextent_near_bno
      0.01 ± 23%     -33.3%       0.00 ± 14%  perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xfs_log_force_seq.xfs_file_fsync.__do_sys_msync
      0.01 ± 50%     -49.2%       0.01 ±  7%  perf-sched.sch_delay.avg.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
      0.01 ± 34%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_slowpath.constprop.0.__alloc_pages
      0.01 ± 58%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
      0.03 ± 39%     -79.6%       0.01 ± 17%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.03 ± 60%     -95.7%       0.00 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.__xfs_filemap_fault.do_page_mkwrite.do_fault.__handle_mm_fault
      0.01 ± 68%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.balance_pgdat.kswapd.kthread.ret_from_fork
      0.02 ± 45%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      0.05 ± 49%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff
      0.00 ± 20%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.page_cache_ra_order.filemap_fault.__do_fault
      0.01 ± 31%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.down_read.xfs_ilock_for_iomap.xfs_read_iomap_begin.iomap_iter
      0.03 ± 38%     -65.9%       0.01 ± 27%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.shmem_file_write_iter.do_iter_readv_writev.do_iter_write
      0.01 ± 51%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.shrink_active_list.shrink_lruvec.shrink_node_memcgs.shrink_node
      0.03 ± 31%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.shrink_node_memcgs.shrink_node.shrink_zones.constprop
      0.79 ± 77%     -96.4%       0.03 ±169%  perf-sched.sch_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.57 ± 29%     -99.7%       0.00 ±100%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      6.22 ± 36%     -70.0%       1.87 ± 70%  perf-sched.sch_delay.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_cleanup_planes
      0.04 ± 45%     -82.6%       0.01 ± 38%  perf-sched.sch_delay.max.ms.__x64_sys_pause.do_syscall_64.entry_SYSCALL_64_after_hwframe.[unknown]
      0.02 ± 18%    -100.0%       0.00        perf-sched.sch_delay.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      0.10 ± 58%     -82.7%       0.02 ±  7%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
      0.03 ± 53%     -78.9%       0.01 ± 25%  perf-sched.sch_delay.max.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      0.51 ± 36%     -94.9%       0.03 ±129%  perf-sched.sch_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.89 ± 90%     -98.6%       0.01 ± 17%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.06 ± 41%     -94.9%       0.00 ±108%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_exc_page_fault
      0.06 ± 48%     -90.4%       0.01 ± 22%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.04 ± 84%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      0.02 ± 38%    -100.0%       0.00        perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.03 ± 57%     -95.4%       0.00 ±141%  perf-sched.sch_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
      0.01 ± 43%     -80.7%       0.00 ±142%  perf-sched.sch_delay.max.ms.kswapd_try_to_sleep.kswapd.kthread.ret_from_fork
      0.28 ± 94%     -97.0%       0.01 ± 16%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.73 ±161%     -98.3%       0.01 ± 32%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      0.18 ±119%     -91.8%       0.02 ± 13%  perf-sched.sch_delay.max.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      0.06 ± 65%     -95.5%       0.00 ± 46%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xfs_map_blocks
      0.01 ± 48%   +6086.4%       0.45 ± 32%  perf-sched.sch_delay.max.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      0.04 ± 47%     -81.9%       0.01 ± 20%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
      0.07 ± 35%     -78.7%       0.01 ± 87%  perf-sched.sch_delay.max.ms.schedule_timeout.xfsaild.kthread.ret_from_fork
     13.32 ± 13%     -71.3%       3.83 ±  4%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.10 ± 46%     -82.0%       0.02 ± 23%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
      0.02 ± 40%     -71.1%       0.01 ± 45%  perf-sched.sch_delay.max.ms.wait_for_partner.fifo_open.do_dentry_open.do_open
     20.07 ± 28%     -76.3%       4.76 ± 58%  perf-sched.sch_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±145%    +320.0%       0.00 ± 27%  perf-sched.sch_delay.max.ms.xlog_force_lsn.xfs_log_force_seq.xfs_file_fsync.__do_sys_msync
      0.01 ± 51%    -100.0%       0.00        perf-sched.sch_delay.max.ms.xlog_wait_on_iclog.xfs_extent_busy_flush.xfs_alloc_ag_vextent_near.xfs_alloc_vextent_near_bno
      0.03 ± 62%     -74.2%       0.01 ± 22%  perf-sched.sch_delay.max.ms.xlog_wait_on_iclog.xlog_cil_push_work.process_one_work.worker_thread
      0.03 ±  3%     -75.6%       0.01 ± 14%  perf-sched.total_sch_delay.average.ms
     52.36 ±  2%     +16.5%      61.01 ±  2%  perf-sched.total_wait_and_delay.average.ms
     56658 ±  4%     -21.4%      44529 ±  5%  perf-sched.total_wait_and_delay.count.ms
     52.33 ±  2%     +16.6%      61.01 ±  2%  perf-sched.total_wait_time.average.ms
      0.15 ± 15%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_read.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff
      0.50 ± 30%     +92.1%       0.95 ± 20%  perf-sched.wait_and_delay.avg.ms.__cond_resched.loop_process_work.process_one_work.worker_thread.kthread
      0.95 ± 50%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.shrink_node_memcgs.shrink_node.shrink_zones.constprop
     26.03 ± 10%    +166.5%      69.36 ± 14%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.09 ± 31%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      0.06 ± 31%    +675.6%       0.44 ± 59%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.72 ± 65%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.write_cache_pages.iomap_writepages
     67.31 ±  6%    +771.1%     586.35 ± 10%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      8.78 ± 21%   +1848.5%     171.11 ± 33%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
      3.98 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     43.48 ±  3%     +12.9%      49.09 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
    111.19 ± 16%     -89.7%      11.50 ±223%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.kswapd_try_to_sleep.kswapd.kthread
      4.66 ±  5%    +171.8%      12.67 ± 16%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    194.78 ±  8%     +71.6%     334.26 ±  6%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    369.50 ±  7%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_read.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff
      1208 ± 22%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.shrink_node_memcgs.shrink_node.shrink_zones.constprop
      9.00 ± 40%     -83.3%       1.50 ±120%  perf-sched.wait_and_delay.count.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_cleanup_planes
    421.00 ±  7%     -89.9%      42.67 ± 49%  perf-sched.wait_and_delay.count.devkmsg_read.vfs_read.ksys_read.do_syscall_64
    848.50           -73.3%     226.17 ± 20%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1048          -100.0%       0.00        perf-sched.wait_and_delay.count.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      1875 ± 36%    -100.0%       0.00        perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.write_cache_pages.iomap_writepages
    411.67 ± 13%    +379.1%       1972 ± 91%  perf-sched.wait_and_delay.count.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
      9.67 ± 22%     -91.4%       0.83 ±175%  perf-sched.wait_and_delay.count.kswapd_try_to_sleep.kswapd.kthread.ret_from_fork
    188.33 ±  2%     -87.9%      22.83 ±  6%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      1268           -92.1%      99.83 ± 56%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
    433.67 ±  6%     -87.1%      56.00 ± 46%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    341.50          -100.0%       0.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     39.33 ± 17%     -94.9%       2.00 ±223%  perf-sched.wait_and_delay.count.schedule_timeout.kswapd_try_to_sleep.kswapd.kthread
      1003 ±  7%     -61.6%     385.67 ± 21%  perf-sched.wait_and_delay.count.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
    422.17 ±  6%     -90.0%      42.33 ± 49%  perf-sched.wait_and_delay.count.syslog_print.do_syslog.kmsg_read.vfs_read
      4337 ±  7%     -47.9%       2261 ±  6%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2.86 ± 48%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_read.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff
    206.38 ±172%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.shrink_node_memcgs.shrink_node.shrink_zones.constprop
    799.81 ± 24%     -62.8%     297.34 ±108%  perf-sched.wait_and_delay.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_cleanup_planes
      2688 ± 42%     -62.8%       1000        perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    198.42 ±181%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     87.70 ± 27%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.write_cache_pages.iomap_writepages
    108.24           -67.7%      34.93 ±141%  perf-sched.wait_and_delay.max.ms.kswapd_try_to_sleep.kswapd.kthread.ret_from_fork
      1386 ± 21%     -26.7%       1015        perf-sched.wait_and_delay.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
     20.54 ± 18%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     59.91 ±  3%      -7.5%      55.43        perf-sched.wait_and_delay.max.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
    484.94 ± 15%     -96.4%      17.50 ±223%  perf-sched.wait_and_delay.max.ms.schedule_timeout.kswapd_try_to_sleep.kswapd.kthread
     20.82 ±  4%   +1402.3%     312.82 ± 16%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2686 ± 28%     +45.1%       3897 ± 11%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      9.41 ±165%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.folio_alloc.page_cache_ra_order.filemap_fault
      6.01 ±143%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.folio_alloc.page_cache_ra_unbounded.filemap_fault
      0.48 ± 49%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages_slowpath.constprop.0.__alloc_pages
      0.14 ± 12%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
     11.89 ±142%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.ifs_alloc.isra
     28.12 ± 52%    -100.0%       0.00 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.balance_pgdat.kswapd.kthread.ret_from_fork
      1.65 ± 83%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.cgroup_rstat_flush.do_flush_stats.prepare_scan_count.shrink_node
     31.34 ± 44%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      0.15 ± 15%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff
      0.14 ± 41%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.page_cache_ra_order.filemap_fault.__do_fault
      0.45 ± 98%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.down_read.xfs_ilock_for_iomap.xfs_read_iomap_begin.iomap_iter
      0.49 ± 30%     +92.1%       0.95 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.loop_process_work.process_one_work.worker_thread.kthread
     16.59 ± 84%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shrink_active_list.shrink_lruvec.shrink_node_memcgs.shrink_node
      3.71 ± 98%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shrink_folio_list.shrink_inactive_list.shrink_lruvec.shrink_node_memcgs
     22.01 ±144%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shrink_lruvec.shrink_node_memcgs.shrink_node.balance_pgdat
      2.88 ± 70%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shrink_lruvec.shrink_node_memcgs.shrink_node.shrink_zones
      0.95 ± 50%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shrink_node_memcgs.shrink_node.shrink_zones.constprop
      1.75 ±217%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.shrink_slab.shrink_node_memcgs.shrink_node.shrink_zones
      0.10 ± 25%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
      0.02 ± 63%    -100.0%       0.00        perf-sched.wait_time.avg.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
     11.83 ±  6%    +614.1%      84.45 ± 33%  perf-sched.wait_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
     26.02 ± 10%    +166.5%      69.36 ± 14%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      1.07 ± 32%     -63.2%       0.40 ±  3%  perf-sched.wait_time.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
      5.52 ± 36%    +867.7%      53.45 ± 96%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      6.45 ±157%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
      6.30 ± 91%    -100.0%       0.00        perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
      0.66 ±  9%  +26159.1%     172.08 ± 32%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.06 ± 33%    +704.8%       0.44 ± 59%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      3.29 ±  6%     +24.0%       4.08 ±  8%  perf-sched.wait_time.avg.ms.rcu_gp_kthread.kthread.ret_from_fork.ret_from_fork_asm
     67.30 ±  6%    +771.3%     586.35 ± 10%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      8.77 ± 21%   +1851.8%     171.10 ± 33%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_select.core_sys_select.kern_select
     22.02 ±  5%    +469.1%     125.31 ± 28%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
      3.90 ±143%    -100.0%       0.00        perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.xfs_ilock
      0.23 ±144%   +1155.4%       2.93 ± 70%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
      3.97 ±  2%     -87.0%       0.52 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     43.47 ±  3%     +12.9%      49.09 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
    111.18 ± 16%     -89.7%      11.50 ±223%  perf-sched.wait_time.avg.ms.schedule_timeout.kswapd_try_to_sleep.kswapd.kthread
      4.65 ±  5%    +172.1%      12.66 ± 16%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
     11.82 ±  6%    +611.7%      84.14 ± 33%  perf-sched.wait_time.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
    194.53 ±  8%     +71.8%     334.21 ±  6%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.73 ± 35%    -100.0%       0.00        perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xfs_extent_busy_flush.xfs_alloc_ag_vextent_near.xfs_alloc_vextent_near_bno
      2.84 ±141%    +460.6%      15.94 ± 71%  perf-sched.wait_time.avg.ms.xlog_wait_on_iclog.xfs_file_fsync.__do_sys_msync.do_syscall_64
     14.04 ±140%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.folio_alloc.page_cache_ra_order.filemap_fault
     14.40 ±140%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.folio_alloc.page_cache_ra_unbounded.filemap_fault
     43.33 ±  5%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages_slowpath.constprop.0.__alloc_pages
      0.89 ± 26%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__get_user_pages.populate_vma_page_range.__mm_populate.vm_mmap_pgoff
     14.41 ±139%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.ifs_alloc.isra
    335.74 ± 32%    -100.0%       0.00 ±223%  perf-sched.wait_time.max.ms.__cond_resched.balance_pgdat.kswapd.kthread.ret_from_fork
     28.27 ± 70%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.cgroup_rstat_flush.do_flush_stats.prepare_scan_count.shrink_node
     44.68 ±  7%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.cgroup_rstat_flush_locked.cgroup_rstat_flush.do_flush_stats.mem_cgroup_wb_stats
      2.83 ± 48%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.__mm_populate.vm_mmap_pgoff.ksys_mmap_pgoff
      0.23 ± 54%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.page_cache_ra_order.filemap_fault.__do_fault
     15.76 ±131%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.down_read.xfs_ilock_for_iomap.xfs_read_iomap_begin.iomap_iter
    261.27 ± 84%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shrink_active_list.shrink_lruvec.shrink_node_memcgs.shrink_node
     20.86 ± 98%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shrink_folio_list.shrink_inactive_list.shrink_lruvec.shrink_node_memcgs
    114.79 ±142%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shrink_lruvec.shrink_node_memcgs.shrink_node.balance_pgdat
     35.78 ± 44%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shrink_lruvec.shrink_node_memcgs.shrink_node.shrink_zones
    206.37 ±172%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shrink_node_memcgs.shrink_node.shrink_zones.constprop
      7.04 ±218%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.shrink_slab.shrink_node_memcgs.shrink_node.shrink_zones
      3.32 ± 38%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
    794.55 ± 24%     -62.7%     296.03 ±108%  perf-sched.wait_time.max.ms.__cond_resched.ww_mutex_lock.drm_gem_vunmap_unlocked.drm_gem_fb_vunmap.drm_atomic_helper_cleanup_planes
      0.09 ± 49%    -100.0%       0.00        perf-sched.wait_time.max.ms.d_alloc_parallel.__lookup_slow.walk_component.link_path_walk.part
      2688 ± 42%     -62.8%       1000        perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
    198.19 ±181%     -87.0%      25.83 ±  2%  perf-sched.wait_time.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
     47.05 ±  5%     +48.0%      69.64 ± 61%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
     22.53 ± 99%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
     38.60 ± 34%    -100.0%       0.00        perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
     16.45 ± 39%   +4001.0%     674.63 ± 19%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
    108.23           -67.7%      34.92 ±141%  perf-sched.wait_time.max.ms.kswapd_try_to_sleep.kswapd.kthread.ret_from_fork
      1386 ± 21%     -26.7%       1015        perf-sched.wait_time.max.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
    121.93 ±134%     -82.0%      21.99 ± 84%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xfs_map_blocks
      8.42 ±177%    -100.0%       0.00        perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.xfs_ilock
      2.00 ±173%   +1142.8%      24.86 ± 44%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_workqueue.xlog_cil_push_now.isra
     20.49 ± 18%     -94.7%       1.09 ±  5%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
     59.90 ±  3%      -7.5%      55.43        perf-sched.wait_time.max.ms.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
    484.93 ± 15%     -96.4%      17.50 ±223%  perf-sched.wait_time.max.ms.schedule_timeout.kswapd_try_to_sleep.kswapd.kthread
     20.82 ±  4%   +1402.6%     312.82 ± 16%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      2686 ± 28%     +45.1%       3897 ± 11%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.73 ± 35%    -100.0%       0.00        perf-sched.wait_time.max.ms.xlog_wait_on_iclog.xfs_extent_busy_flush.xfs_alloc_ag_vextent_near.xfs_alloc_vextent_near_bno
      3.34 ±142%    +804.0%      30.21 ± 72%  perf-sched.wait_time.max.ms.xlog_wait_on_iclog.xfs_file_fsync.__do_sys_msync.do_syscall_64
     11.14 ±  5%     -11.1        0.00        perf-profile.calltrace.cycles-pp.memcpy_from_iter_mc.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.do_iter_readv_writev
     11.12 ±  5%     -11.1        0.00        perf-profile.calltrace.cycles-pp.memcpy_orig.memcpy_from_iter_mc.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter
     27.39 ±  2%      -5.6       21.82 ± 12%  perf-profile.calltrace.cycles-pp.do_access
     17.96 ±  2%      -3.7       14.22 ± 12%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
     13.46 ±  3%      -3.1       10.38 ± 10%  perf-profile.calltrace.cycles-pp.do_rw_once
     12.32 ±  2%      -2.4        9.88 ± 11%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
     12.22 ±  2%      -2.4        9.78 ± 11%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
     10.75 ±  2%      -2.2        8.60 ± 12%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
      9.73 ±  2%      -2.0        7.78 ± 12%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      8.89 ±  2%      -1.8        7.14 ± 12%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      3.51 ±  2%      -0.7        2.81 ± 12%  perf-profile.calltrace.cycles-pp.do_page_mkwrite.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      3.45 ±  2%      -0.7        2.78 ± 12%  perf-profile.calltrace.cycles-pp.__xfs_filemap_fault.do_page_mkwrite.do_fault.__handle_mm_fault.handle_mm_fault
      1.10 ± 25%      -0.6        0.51 ± 72%  perf-profile.calltrace.cycles-pp.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback
      1.10 ± 25%      -0.6        0.51 ± 72%  perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb
      1.10 ± 25%      -0.6        0.51 ± 72%  perf-profile.calltrace.cycles-pp.wb_workfn.process_one_work.worker_thread.kthread.ret_from_fork
      1.10 ± 25%      -0.6        0.51 ± 72%  perf-profile.calltrace.cycles-pp.wb_do_writeback.wb_workfn.process_one_work.worker_thread.kthread
      1.10 ± 25%      -0.6        0.51 ± 72%  perf-profile.calltrace.cycles-pp.wb_writeback.wb_do_writeback.wb_workfn.process_one_work.worker_thread
      1.10 ± 25%      -0.6        0.51 ± 72%  perf-profile.calltrace.cycles-pp.__writeback_inodes_wb.wb_writeback.wb_do_writeback.wb_workfn.process_one_work
      1.10 ± 25%      -0.6        0.51 ± 72%  perf-profile.calltrace.cycles-pp.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_do_writeback.wb_workfn
      1.10 ± 25%      -0.6        0.51 ± 72%  perf-profile.calltrace.cycles-pp.__writeback_single_inode.writeback_sb_inodes.__writeback_inodes_wb.wb_writeback.wb_do_writeback
      1.10 ± 25%      -0.6        0.51 ± 72%  perf-profile.calltrace.cycles-pp.iomap_writepages.xfs_vm_writepages.do_writepages.__writeback_single_inode.writeback_sb_inodes
      1.10 ± 25%      -0.6        0.51 ± 72%  perf-profile.calltrace.cycles-pp.write_cache_pages.iomap_writepages.xfs_vm_writepages.do_writepages.__writeback_single_inode
      0.86 ± 12%      -0.5        0.32 ±100%  perf-profile.calltrace.cycles-pp.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.fault_dirty_shared_page.do_fault
      0.86 ± 12%      -0.5        0.32 ±100%  perf-profile.calltrace.cycles-pp.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.fault_dirty_shared_page
      2.56 ±  2%      -0.5        2.02 ± 11%  perf-profile.calltrace.cycles-pp.iomap_page_mkwrite.__xfs_filemap_fault.do_page_mkwrite.do_fault.__handle_mm_fault
      0.83 ± 13%      -0.5        0.31 ±100%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.io_schedule_timeout.balance_dirty_pages.balance_dirty_pages_ratelimited_flags
      0.83 ± 13%      -0.5        0.31 ±100%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.io_schedule_timeout.balance_dirty_pages
      1.55 ±  7%      -0.4        1.18 ± 15%  perf-profile.calltrace.cycles-pp.balance_dirty_pages.balance_dirty_pages_ratelimited_flags.fault_dirty_shared_page.do_fault.__handle_mm_fault
      0.62 ±  5%      -0.3        0.28 ±100%  perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.filemap_fault.__do_fault.do_fault
      0.82 ±  5%      -0.3        0.56 ± 46%  perf-profile.calltrace.cycles-pp.sync_regs.asm_exc_page_fault.do_access
      1.26            -0.3        1.01 ± 11%  perf-profile.calltrace.cycles-pp.iomap_iter.iomap_page_mkwrite.__xfs_filemap_fault.do_page_mkwrite.do_fault
      0.98            -0.2        0.79 ± 13%  perf-profile.calltrace.cycles-pp.xfs_buffered_write_iomap_begin.iomap_iter.iomap_page_mkwrite.__xfs_filemap_fault.do_page_mkwrite
      0.66 ±  5%      -0.2        0.46 ± 45%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.filemap_fault.__do_fault.do_fault.__handle_mm_fault
      0.66 ±  5%      -0.2        0.47 ± 45%  perf-profile.calltrace.cycles-pp.finish_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.30 ±  9%      +0.2        1.54 ± 10%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.37 ± 70%      +0.3        0.65 ±  4%  perf-profile.calltrace.cycles-pp.__intel_pmu_enable_all.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times
      1.60 ±  4%      +0.3        1.94 ±  4%  perf-profile.calltrace.cycles-pp.perf_adjust_freq_unthr_context.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle
      1.64 ±  4%      +0.3        1.98 ±  4%  perf-profile.calltrace.cycles-pp.perf_event_task_tick.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer
      3.00 ±  6%      +0.5        3.48 ±  7%  perf-profile.calltrace.cycles-pp.scheduler_tick.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues
      0.09 ±223%      +0.5        0.58 ± 10%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.46 ± 74%      +0.5        1.00 ± 25%  perf-profile.calltrace.cycles-pp.folio_mkclean.folio_clear_dirty_for_io.write_cache_pages.iomap_writepages.xfs_vm_writepages
      0.44 ± 74%      +0.5        0.97 ± 25%  perf-profile.calltrace.cycles-pp.page_mkclean_one.rmap_walk_file.folio_mkclean.folio_clear_dirty_for_io.write_cache_pages
      0.42 ± 74%      +0.5        0.96 ± 25%  perf-profile.calltrace.cycles-pp.page_vma_mkclean_one.page_mkclean_one.rmap_walk_file.folio_mkclean.folio_clear_dirty_for_io
      0.44 ± 74%      +0.5        0.98 ± 25%  perf-profile.calltrace.cycles-pp.rmap_walk_file.folio_mkclean.folio_clear_dirty_for_io.write_cache_pages.iomap_writepages
      0.59 ± 50%      +0.6        1.17 ± 21%  perf-profile.calltrace.cycles-pp.folio_clear_dirty_for_io.write_cache_pages.iomap_writepages.xfs_vm_writepages.do_writepages
      4.49 ±  5%      +0.7        5.15 ±  8%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.36 ± 70%      +0.7        1.02 ± 25%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.36 ± 70%      +0.7        1.02 ± 25%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      0.09 ±223%      +0.7        0.80 ± 27%  perf-profile.calltrace.cycles-pp.ptep_clear_flush.page_vma_mkclean_one.page_mkclean_one.rmap_walk_file.folio_mkclean
      0.17 ±141%      +0.7        0.90 ± 40%  perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit
      0.18 ±141%      +0.8        0.95 ± 39%  perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write
      0.18 ±141%      +0.8        0.95 ± 39%  perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write
      0.18 ±141%      +0.8        0.96 ± 38%  perf-profile.calltrace.cycles-pp.vprintk_emit.devkmsg_emit.devkmsg_write.vfs_write.ksys_write
      0.18 ±141%      +0.8        0.96 ± 38%  perf-profile.calltrace.cycles-pp.devkmsg_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.18 ±141%      +0.8        0.96 ± 38%  perf-profile.calltrace.cycles-pp.devkmsg_emit.devkmsg_write.vfs_write.ksys_write.do_syscall_64
      0.19 ±141%      +0.8        0.97 ± 37%  perf-profile.calltrace.cycles-pp.write
      0.18 ±141%      +0.8        0.97 ± 37%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.18 ±141%      +0.8        0.97 ± 37%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.18 ±141%      +0.8        0.97 ± 37%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.write
      0.18 ±141%      +0.8        0.97 ± 37%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.write
      0.09 ±223%      +0.8        0.93 ± 25%  perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm
      0.09 ±223%      +0.9        0.94 ± 25%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
      0.09 ±223%      +0.9        0.94 ± 25%  perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail
      0.09 ±223%      +0.9        0.94 ± 25%  perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail
      0.09 ±223%      +0.9        0.94 ± 25%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      0.09 ±223%      +0.9        0.95 ± 25%  perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty
      0.09 ±223%      +0.9        0.95 ± 25%  perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      0.09 ±223%      +0.9        0.96 ± 24%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      0.09 ±223%      +0.9        0.96 ± 24%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.09 ±223%      +0.9        0.96 ± 24%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      0.18 ±141%      +1.1        1.26 ± 36%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.18 ±141%      +1.1        1.26 ± 36%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.1        1.12 ± 38%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      0.00            +1.1        1.15 ± 38%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      0.00            +1.1        1.15 ± 38%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      0.00            +1.1        1.15 ± 38%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      0.00            +1.2        1.18 ± 37%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      0.00            +1.2        1.18 ± 37%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      0.00            +1.2        1.18 ± 37%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.00            +1.2        1.21 ± 37%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.21 ± 37%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +1.2        1.21 ± 37%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      6.62 ±  7%      +1.2        7.85 ±  8%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      9.43 ±  6%      +1.7       11.11 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      9.45 ±  6%      +1.7       11.13 ±  6%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +1.9        1.95 ± 28%  perf-profile.calltrace.cycles-pp.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
      0.00            +1.9        1.95 ± 28%  perf-profile.calltrace.cycles-pp.write_cache_pages.iomap_writepages.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc
      0.00            +2.0        1.98 ± 30%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync
      0.00            +2.0        1.98 ± 30%  perf-profile.calltrace.cycles-pp.xfs_vm_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range
      0.00            +2.0        1.98 ± 30%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.__do_sys_msync.do_syscall_64
      0.00            +2.0        1.98 ± 30%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.file_write_and_wait_range.xfs_file_fsync.__do_sys_msync
      0.00            +2.0        2.01 ± 30%  perf-profile.calltrace.cycles-pp.file_write_and_wait_range.xfs_file_fsync.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.0        2.02 ± 30%  perf-profile.calltrace.cycles-pp.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      0.00            +2.0        2.02 ± 30%  perf-profile.calltrace.cycles-pp.xfs_file_fsync.__do_sys_msync.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      0.00            +2.0        2.02 ± 30%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.msync
      0.00            +2.0        2.02 ± 30%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.msync
      0.00            +2.0        2.02 ± 30%  perf-profile.calltrace.cycles-pp.msync
     13.56 ±  4%      +2.1       15.67 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
     15.08 ±  4%      +2.5       17.59 ±  7%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     16.61 ±  3%      +2.7       19.34 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     16.61 ±  3%      +2.7       19.34 ±  5%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     16.61 ±  3%      +2.7       19.34 ±  5%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     14.27 ±  5%      +2.8       17.05 ±  5%  perf-profile.calltrace.cycles-pp.loop_process_work.process_one_work.worker_thread.kthread.ret_from_fork
     14.06 ±  5%      +2.8       16.85 ±  5%  perf-profile.calltrace.cycles-pp.do_iter_write.lo_write_simple.loop_process_work.process_one_work.worker_thread
     14.20 ±  5%      +2.8       16.99 ±  5%  perf-profile.calltrace.cycles-pp.lo_write_simple.loop_process_work.process_one_work.worker_thread.kthread
     16.33 ±  3%      +2.8       19.12 ±  5%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     13.91 ±  5%      +2.8       16.71 ±  5%  perf-profile.calltrace.cycles-pp.do_iter_readv_writev.do_iter_write.lo_write_simple.loop_process_work.process_one_work
     16.19 ±  3%      +2.8       19.00 ±  4%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     13.30 ±  5%      +2.8       16.12 ±  5%  perf-profile.calltrace.cycles-pp.generic_perform_write.shmem_file_write_iter.do_iter_readv_writev.do_iter_write.lo_write_simple
     13.74 ±  4%      +2.8       16.56 ±  5%  perf-profile.calltrace.cycles-pp.shmem_file_write_iter.do_iter_readv_writev.do_iter_write.lo_write_simple.loop_process_work
     11.27 ±  5%      +3.7       14.93 ±  5%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.shmem_file_write_iter.do_iter_readv_writev.do_iter_write
     11.14 ±  5%     -11.1        0.00        perf-profile.children.cycles-pp.memcpy_from_iter_mc
     11.20 ±  5%     -11.1        0.10 ± 16%  perf-profile.children.cycles-pp.memcpy_orig
     26.79 ±  2%      -5.6       21.19 ± 12%  perf-profile.children.cycles-pp.do_access
     14.94            -3.4       11.59 ± 11%  perf-profile.children.cycles-pp.do_rw_once
     15.77 ±  2%      -3.2       12.54 ± 11%  perf-profile.children.cycles-pp.asm_exc_page_fault
     12.39 ±  2%      -2.4        9.94 ± 11%  perf-profile.children.cycles-pp.exc_page_fault
     12.30 ±  2%      -2.4        9.87 ± 11%  perf-profile.children.cycles-pp.do_user_addr_fault
     10.82 ±  2%      -2.1        8.67 ± 12%  perf-profile.children.cycles-pp.handle_mm_fault
      9.79 ±  2%      -1.9        7.84 ± 12%  perf-profile.children.cycles-pp.__handle_mm_fault
      8.93 ±  2%      -1.8        7.17 ± 12%  perf-profile.children.cycles-pp.do_fault
      1.06 ± 10%      -0.9        0.20 ± 12%  perf-profile.children.cycles-pp.shmem_write_end
      1.06 ± 10%      -0.8        0.23 ± 17%  perf-profile.children.cycles-pp.folio_unlock
      3.52 ±  2%      -0.7        2.82 ± 12%  perf-profile.children.cycles-pp.do_page_mkwrite
      3.51            -0.7        2.82 ± 12%  perf-profile.children.cycles-pp.__xfs_filemap_fault
      2.58 ±  2%      -0.5        2.03 ± 11%  perf-profile.children.cycles-pp.iomap_page_mkwrite
      1.10 ± 25%      -0.4        0.66 ± 26%  perf-profile.children.cycles-pp.wb_workfn
      1.10 ± 25%      -0.4        0.66 ± 26%  perf-profile.children.cycles-pp.wb_do_writeback
      1.10 ± 25%      -0.4        0.66 ± 26%  perf-profile.children.cycles-pp.wb_writeback
      1.10 ± 25%      -0.4        0.66 ± 26%  perf-profile.children.cycles-pp.__writeback_inodes_wb
      1.10 ± 25%      -0.4        0.66 ± 26%  perf-profile.children.cycles-pp.writeback_sb_inodes
      1.10 ± 25%      -0.4        0.66 ± 26%  perf-profile.children.cycles-pp.__writeback_single_inode
      1.55 ±  7%      -0.4        1.19 ± 15%  perf-profile.children.cycles-pp.balance_dirty_pages
      0.89 ± 13%      -0.3        0.55 ± 24%  perf-profile.children.cycles-pp.schedule_timeout
      0.86 ± 12%      -0.3        0.52 ± 24%  perf-profile.children.cycles-pp.io_schedule_timeout
      1.27            -0.3        1.02 ± 11%  perf-profile.children.cycles-pp.iomap_iter
      0.86 ±  5%      -0.2        0.65 ± 16%  perf-profile.children.cycles-pp.sync_regs
      0.99            -0.2        0.80 ± 13%  perf-profile.children.cycles-pp.xfs_buffered_write_iomap_begin
      0.69 ±  8%      -0.1        0.55 ±  7%  perf-profile.children.cycles-pp.iomap_dirty_folio
      0.64 ±  6%      -0.1        0.51 ±  8%  perf-profile.children.cycles-pp.__perf_sw_event
      0.56 ±  4%      -0.1        0.43 ± 12%  perf-profile.children.cycles-pp.filemap_dirty_folio
      0.66 ±  5%      -0.1        0.54 ± 13%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.49 ±  8%      -0.1        0.37 ±  6%  perf-profile.children.cycles-pp.ifs_set_range_dirty
      0.68 ±  4%      -0.1        0.56 ±  9%  perf-profile.children.cycles-pp.finish_fault
      0.42 ±  6%      -0.1        0.33 ± 13%  perf-profile.children.cycles-pp.lock_mm_and_find_vma
      0.52 ±  7%      -0.1        0.43 ±  6%  perf-profile.children.cycles-pp.___perf_sw_event
      0.48 ±  6%      -0.1        0.40 ±  9%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.34 ±  7%      -0.1        0.26 ± 15%  perf-profile.children.cycles-pp.xfs_ilock
      0.27 ±  6%      -0.1        0.21 ± 15%  perf-profile.children.cycles-pp.handle_pte_fault
      0.19 ±  4%      -0.0        0.14 ± 17%  perf-profile.children.cycles-pp.down_read_trylock
      0.22 ±  4%      -0.0        0.17 ± 12%  perf-profile.children.cycles-pp.iomap_iter_advance
      0.17 ±  7%      -0.0        0.13 ± 17%  perf-profile.children.cycles-pp.pte_offset_map_nolock
      0.17 ± 13%      -0.0        0.13 ± 16%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.15 ± 10%      -0.0        0.11 ± 13%  perf-profile.children.cycles-pp.run_timer_softirq
      0.19 ±  7%      -0.0        0.16 ± 11%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.14 ± 11%      -0.0        0.10 ± 13%  perf-profile.children.cycles-pp.call_timer_fn
      0.14 ± 12%      -0.0        0.10 ± 10%  perf-profile.children.cycles-pp.down_read
      0.09 ± 10%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.06 ± 11%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
      0.06 ± 17%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.x86_pmu_disable
      0.05 ± 46%      +0.0        0.08 ±  7%  perf-profile.children.cycles-pp.timerqueue_add
      0.07 ± 16%      +0.0        0.10 ±  9%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.18 ±  6%      +0.0        0.22 ±  7%  perf-profile.children.cycles-pp.read_tsc
      0.29 ±  7%      +0.0        0.33 ±  8%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.04 ± 75%      +0.1        0.10 ± 18%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.18 ± 10%      +0.1        0.23 ± 20%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.10 ± 14%      +0.1        0.16 ± 28%  perf-profile.children.cycles-pp._find_next_bit
      0.10 ± 16%      +0.1        0.19 ± 14%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.00            +0.1        0.09 ± 41%  perf-profile.children.cycles-pp.free_swap_cache
      0.07 ± 12%      +0.1        0.17 ± 37%  perf-profile.children.cycles-pp._compound_head
      0.00            +0.1        0.10 ± 46%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.03 ± 70%      +0.1        0.14 ± 31%  perf-profile.children.cycles-pp.release_pages
      0.08 ± 16%      +0.1        0.19 ± 33%  perf-profile.children.cycles-pp.wait_for_xmitr
      0.00            +0.1        0.13 ± 43%  perf-profile.children.cycles-pp.io_schedule
      0.06 ± 50%      +0.2        0.22 ± 39%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.10 ±  9%      +0.2        0.26 ± 29%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      1.31 ±  9%      +0.2        1.55 ± 10%  perf-profile.children.cycles-pp.rebalance_domains
      0.15 ± 22%      +0.3        0.48 ± 39%  perf-profile.children.cycles-pp.page_remove_rmap
      1.65 ±  4%      +0.3        2.00 ±  3%  perf-profile.children.cycles-pp.perf_adjust_freq_unthr_context
      1.67 ±  3%      +0.3        2.02 ±  4%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.16 ± 33%      +0.4        0.52 ± 35%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.08 ± 19%      +0.4        0.46 ± 26%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.00            +0.4        0.39 ± 49%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.10 ± 16%      +0.4        0.52 ± 27%  perf-profile.children.cycles-pp.flush_tlb_func
      0.54 ± 13%      +0.4        0.98 ± 36%  perf-profile.children.cycles-pp.wait_for_lsr
      0.43 ± 22%      +0.5        0.88 ± 19%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.56 ± 14%      +0.5        1.03 ± 37%  perf-profile.children.cycles-pp.serial8250_console_write
      0.47 ±  9%      +0.5        0.94 ± 25%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.47 ±  9%      +0.5        0.94 ± 25%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      0.47 ±  9%      +0.5        0.94 ± 25%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.47 ±  9%      +0.5        0.94 ± 25%  perf-profile.children.cycles-pp.memcpy_toio
      0.47 ±  9%      +0.5        0.94 ± 25%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      0.48 ±  8%      +0.5        0.95 ± 25%  perf-profile.children.cycles-pp.commit_tail
      0.48 ±  8%      +0.5        0.95 ± 25%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.48 ±  8%      +0.5        0.96 ± 24%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.48 ±  8%      +0.5        0.96 ± 24%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.48 ±  8%      +0.5        0.96 ± 24%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.49 ± 12%      +0.5        0.97 ± 37%  perf-profile.children.cycles-pp.write
      0.48 ± 11%      +0.5        0.97 ± 37%  perf-profile.children.cycles-pp.vfs_write
      0.48 ± 11%      +0.5        0.98 ± 37%  perf-profile.children.cycles-pp.ksys_write
      0.47 ± 11%      +0.5        0.96 ± 38%  perf-profile.children.cycles-pp.devkmsg_write
      0.47 ± 11%      +0.5        0.96 ± 38%  perf-profile.children.cycles-pp.devkmsg_emit
      3.06 ±  6%      +0.5        3.56 ±  7%  perf-profile.children.cycles-pp.scheduler_tick
      0.59 ± 14%      +0.5        1.09 ± 36%  perf-profile.children.cycles-pp.console_unlock
      0.59 ± 14%      +0.5        1.09 ± 36%  perf-profile.children.cycles-pp.console_flush_all
      0.52 ± 22%      +0.5        1.02 ± 19%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.59 ± 14%      +0.5        1.10 ± 35%  perf-profile.children.cycles-pp.vprintk_emit
      0.00            +0.5        0.51 ± 47%  perf-profile.children.cycles-pp.__rq_qos_throttle
      0.00            +0.5        0.51 ± 47%  perf-profile.children.cycles-pp.wbt_wait
      0.00            +0.5        0.51 ± 47%  perf-profile.children.cycles-pp.rq_qos_wait
      0.51 ±  8%      +0.5        1.02 ± 25%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.51 ±  8%      +0.5        1.02 ± 25%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      0.21 ± 24%      +0.5        0.73 ± 31%  perf-profile.children.cycles-pp.iomap_add_to_ioend
      0.00            +0.5        0.52 ± 47%  perf-profile.children.cycles-pp.blk_mq_get_new_requests
      0.73 ± 23%      +0.6        1.28 ± 16%  perf-profile.children.cycles-pp.page_vma_mkclean_one
      0.74 ± 23%      +0.6        1.29 ± 17%  perf-profile.children.cycles-pp.page_mkclean_one
      0.00            +0.6        0.56 ± 46%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      0.00            +0.6        0.56 ± 46%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.78 ± 24%      +0.6        1.34 ± 17%  perf-profile.children.cycles-pp.folio_mkclean
      0.76 ± 23%      +0.6        1.33 ± 17%  perf-profile.children.cycles-pp.rmap_walk_file
      0.41 ± 23%      +0.6        1.02 ± 24%  perf-profile.children.cycles-pp.iomap_writepage_map
      0.85 ± 23%      +0.6        1.46 ± 17%  perf-profile.children.cycles-pp.folio_clear_dirty_for_io
      4.57 ±  5%      +0.7        5.25 ±  8%  perf-profile.children.cycles-pp.tick_sched_timer
      0.35 ± 20%      +0.8        1.15 ± 38%  perf-profile.children.cycles-pp.unmap_vmas
      0.35 ± 20%      +0.8        1.15 ± 38%  perf-profile.children.cycles-pp.unmap_page_range
      0.34 ± 20%      +0.8        1.15 ± 38%  perf-profile.children.cycles-pp.zap_pmd_range
      0.34 ± 20%      +0.8        1.15 ± 38%  perf-profile.children.cycles-pp.zap_pte_range
      0.38 ± 19%      +0.8        1.19 ± 37%  perf-profile.children.cycles-pp.__mmput
      0.38 ± 19%      +0.8        1.19 ± 37%  perf-profile.children.cycles-pp.exit_mmap
      0.37 ± 20%      +0.8        1.18 ± 37%  perf-profile.children.cycles-pp.exit_mm
      0.39 ± 19%      +0.8        1.21 ± 37%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.39 ± 19%      +0.8        1.21 ± 37%  perf-profile.children.cycles-pp.do_group_exit
      0.39 ± 19%      +0.8        1.21 ± 37%  perf-profile.children.cycles-pp.do_exit
      6.74 ±  6%      +1.3        8.00 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.35 ± 23%      +1.3        2.61 ± 19%  perf-profile.children.cycles-pp.iomap_writepages
      1.35 ± 23%      +1.3        2.61 ± 19%  perf-profile.children.cycles-pp.write_cache_pages
      1.35 ± 23%      +1.3        2.64 ± 20%  perf-profile.children.cycles-pp.do_writepages
      1.35 ± 23%      +1.3        2.64 ± 20%  perf-profile.children.cycles-pp.xfs_vm_writepages
      9.59 ±  6%      +1.7       11.30 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      9.57 ±  6%      +1.7       11.28 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.25 ± 18%      +1.7        1.98 ± 30%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
      0.25 ± 18%      +1.7        1.98 ± 30%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
      0.27 ± 17%      +1.7        2.02 ± 30%  perf-profile.children.cycles-pp.__do_sys_msync
      0.27 ± 17%      +1.7        2.02 ± 30%  perf-profile.children.cycles-pp.xfs_file_fsync
      0.26 ± 16%      +1.8        2.01 ± 30%  perf-profile.children.cycles-pp.file_write_and_wait_range
      0.27 ± 17%      +1.8        2.02 ± 30%  perf-profile.children.cycles-pp.msync
     13.72 ±  4%      +2.1       15.87 ±  6%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
     16.61 ±  3%      +2.7       19.34 ±  5%  perf-profile.children.cycles-pp.kthread
     16.61 ±  3%      +2.7       19.34 ±  5%  perf-profile.children.cycles-pp.ret_from_fork_asm
     16.61 ±  3%      +2.7       19.34 ±  5%  perf-profile.children.cycles-pp.ret_from_fork
     14.27 ±  5%      +2.8       17.05 ±  5%  perf-profile.children.cycles-pp.loop_process_work
     14.06 ±  5%      +2.8       16.85 ±  5%  perf-profile.children.cycles-pp.do_iter_write
     14.20 ±  5%      +2.8       16.99 ±  5%  perf-profile.children.cycles-pp.lo_write_simple
     16.33 ±  3%      +2.8       19.12 ±  5%  perf-profile.children.cycles-pp.worker_thread
     13.92 ±  5%      +2.8       16.72 ±  5%  perf-profile.children.cycles-pp.do_iter_readv_writev
     16.19 ±  3%      +2.8       19.00 ±  4%  perf-profile.children.cycles-pp.process_one_work
     13.32 ±  5%      +2.8       16.13 ±  5%  perf-profile.children.cycles-pp.generic_perform_write
     13.76 ±  4%      +2.8       16.57 ±  5%  perf-profile.children.cycles-pp.shmem_file_write_iter
      1.50 ±  9%      +3.1        4.60 ± 29%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.50 ±  9%      +3.1        4.60 ± 29%  perf-profile.children.cycles-pp.do_syscall_64
     11.28 ±  5%      +3.7       14.94 ±  5%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
     11.10 ±  5%     -11.0        0.10 ± 16%  perf-profile.self.cycles-pp.memcpy_orig
     12.38            -2.8        9.61 ± 11%  perf-profile.self.cycles-pp.do_rw_once
      7.73 ±  4%      -1.8        5.95 ± 11%  perf-profile.self.cycles-pp.do_access
      1.05 ± 10%      -0.8        0.21 ± 11%  perf-profile.self.cycles-pp.folio_unlock
      0.85 ±  5%      -0.2        0.65 ± 15%  perf-profile.self.cycles-pp.sync_regs
      0.56 ±  5%      -0.1        0.42 ± 10%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.38 ± 10%      -0.1        0.30 ± 11%  perf-profile.self.cycles-pp.handle_mm_fault
      0.36 ±  3%      -0.1        0.28 ± 17%  perf-profile.self.cycles-pp.iomap_page_mkwrite
      0.46 ±  7%      -0.1        0.38 ±  6%  perf-profile.self.cycles-pp.___perf_sw_event
      0.26 ±  3%      -0.1        0.20 ± 15%  perf-profile.self.cycles-pp.filemap_fault
      0.14 ±  9%      -0.1        0.09 ± 21%  perf-profile.self.cycles-pp.ifs_set_range_dirty
      0.18 ±  8%      -0.0        0.14 ± 12%  perf-profile.self.cycles-pp.asm_exc_page_fault
      0.11 ±  4%      -0.0        0.07 ± 20%  perf-profile.self.cycles-pp.do_fault
      0.23 ±  7%      -0.0        0.18 ± 11%  perf-profile.self.cycles-pp.xfs_buffered_write_iomap_begin
      0.21 ±  4%      -0.0        0.17 ± 14%  perf-profile.self.cycles-pp.iomap_iter_advance
      0.19 ±  5%      -0.0        0.14 ± 17%  perf-profile.self.cycles-pp.down_read_trylock
      0.17 ±  8%      -0.0        0.13 ±  7%  perf-profile.self.cycles-pp.filemap_dirty_folio
      0.16 ± 12%      -0.0        0.12 ± 11%  perf-profile.self.cycles-pp.error_entry
      0.10 ± 15%      -0.0        0.07 ± 11%  perf-profile.self.cycles-pp.down_read
      0.11 ± 10%      -0.0        0.09 ± 15%  perf-profile.self.cycles-pp.generic_perform_write
      0.06 ± 47%      +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.x86_pmu_disable
      0.08 ± 19%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.folio_mark_accessed
      0.18 ±  7%      +0.0        0.21 ±  8%  perf-profile.self.cycles-pp.read_tsc
      0.08 ± 47%      +0.1        0.14 ± 18%  perf-profile.self.cycles-pp.ptep_clear_flush
      0.08 ± 12%      +0.1        0.14 ± 25%  perf-profile.self.cycles-pp._find_next_bit
      0.18 ±  7%      +0.1        0.26 ± 17%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +0.1        0.09 ± 40%  perf-profile.self.cycles-pp.free_swap_cache
      0.06 ± 11%      +0.1        0.16 ± 38%  perf-profile.self.cycles-pp._compound_head
      0.02 ± 99%      +0.1        0.13 ± 32%  perf-profile.self.cycles-pp.release_pages
      0.06 ± 46%      +0.1        0.17 ± 46%  perf-profile.self.cycles-pp.zap_pte_range
      0.91 ±  5%      +0.2        1.09 ±  4%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
      0.12 ± 21%      +0.3        0.39 ± 42%  perf-profile.self.cycles-pp.page_remove_rmap
      0.16 ± 33%      +0.4        0.52 ± 35%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.08 ± 19%      +0.4        0.46 ± 26%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.47 ±  8%      +0.4        0.90 ± 28%  perf-profile.self.cycles-pp.memcpy_toio
      0.14 ± 10%     +14.7       14.83 ±  5%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

