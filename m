Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C466C77E534
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344180AbjHPPdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244131AbjHPPdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:33:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849EE1FE2;
        Wed, 16 Aug 2023 08:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692199988; x=1723735988;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UjZtQfDi0/gnsQgFVtgwbGEjNu2jin+bLsnte7sJ8Y0=;
  b=Fom7NsjCpE+LTc83yfMqt5RYA9IW7B3ThqRos+RR3DbYPGpjF7Oz00IY
   QTIZnc1/5W1KyPOI5KaTQ+F7ECwhHfmzwlnkyF18bcGenMwRlkWaiDOAA
   Rd0L4HQ4yeGx7Gu2dxhUGkR6PtfR7n01+3csyP+TnNzgAiL7QmRCABvvz
   5e0Cj97F65H06xzxKLdh2LYMhPd8zFevbkVVJiaPLKNRUREPLJYnPeJPq
   IiHjUR9hGx7UjWvooHpv5thWFYIdYIPGz3vH+0b7fUMzOwW7xHgT1637O
   dKNI3er4pgXOjQ2cqATyMChI69EcVfviZKTIzX0MjZFPczSwV3BocDdfU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436465470"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="436465470"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 08:33:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="684110458"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="684110458"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 16 Aug 2023 08:33:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 16 Aug 2023 08:33:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 16 Aug 2023 08:33:05 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 16 Aug 2023 08:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7DNIjJ1Xzp7kiu+xkMNQD64yHWkD0CG/r4C1We5qF8V+86wvX6dTJ7LaU4+YZUyQlKp0rhgb1fRAGQpGRXcv7OabvJuOx+ywWUHEHox9S+kJQQHtcBR8XO09Q4TSlmsluGI/V5CkIUxPx2ElXpypWjs27T9FdtKD4+3Uyz0FyOh20ELpLzMhZ4BdbuItNnrZBprm4SAC+c2B+n+H+FDA4PJeTT/WJgLhMH9sAWxnYq1/ZPuqPeoK4bRyyrQv2ZOWnPhVEnVaEwa70AhkIMDWZ/vnZLfyO7euWC5ujUyzLO4voTzA7zwInIgArS7/N+rtNSn+i1uAnfq9FdO71th0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rR07dB6LumzqtDqyaTzbej6H7s5HkONURkTkVBXKdcU=;
 b=jXh32X9nudaDtrECjDBgmZGWzkvsAFPW0xislU5CjaQ5oHuv8ldH6ZlbKJbofZ46l00CIyEEY7buQJuopofH/TVvhG7YZE4I42YdZEfSC9eVT/vu0qNkZ671pQ36SZfHdQ0YgyQ+IvTEYtqmKzQBCUPz/6vHlhnqEGM1gfbnnZ6vXuKG3MMoxK93UAWcA42fwQJx+nd6FBhZ7HU9U/cLmHtr6CnJZI99dumcow8MZYXoP48+7HW+2dpj+9ogTrPq3fe9EiPYzhrJK5NJPLcGltufkE3eTcAk+ubUXj1o+Jhl9BP9Ja3lsvRjSz6ycpjtjwvR3gvG+zGxM1ALAavKew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB7563.namprd11.prod.outlook.com (2603:10b6:510:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 15:32:57 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 15:32:57 +0000
Message-ID: <80519d5f-e328-4ea4-a488-00209432d5d9@intel.com>
Date:   Wed, 16 Aug 2023 23:32:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [io_uring] caec5ebe77:
 stress-ng.io-uring.ops_per_sec -33.1% regression
To:     kernel test robot <oliver.sang@intel.com>,
        Jens Axboe <axboe@kernel.dk>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <io-uring@vger.kernel.org>,
        <ying.huang@intel.com>, <feng.tang@intel.com>
References: <202307060958.3594f22f-oliver.sang@intel.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <202307060958.3594f22f-oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: c056e68b-837c-45e5-a6df-08db9e6e1090
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MA03LhajMEbP7CD+yY8ticGwKuQkunSdWmwB2cI7a5gNAtiTl9cV7zdz9j+KJbhwtNHXaMEFT7ktV/G2L1XHegy2fcRPq3SWVxsC0CcEy3l132KmgkwN74+u2JovndSFCAgy7NLZr6oC4rTjP/NEXfRvLg9+0Y+7k4H9W/TtyOe0YGXIU9QpdTuZTG60kx7fmLovCFZ+FoxuKDf5plo9EnrquJS8vfu+6M8IGVM3Esp6ZpHof5O0ifhSBnwUkZaKhfluD2rEewxoSr/vDZLPnx4rGbyfIK+xIJvAjnLh9qDdjnCjcWJEsZrawKGwTOrH2rOg3HGFIg3PLbod+HR2fAzMDbXQW9wXu3/bbpJM0UxzLmqV59y7e+mE+e9QJ3bNhoqwY+90BJSR19a4xjpN7rZ37A+3XTgBn3DQQEz/PodKF4xqwivwhaVK/stGHO7rm2Qg9a/6foXrqdPoRZjEh4G1yHECIK254bFdeZuNPh9iQZeNJrc6cZz/+ZFga1KfV+XAUDgM615Q4fGY9D8ZSDj6YHDIjmQ0d8/Dk8QsCUBAG3wtuCTDx425JI+yFujc/QH18UiR7DFFPj3KQBpkKa3K8HxR5ugisEKAnzPyrSERSQip6ETejnJ70JtDpzuYeBLvw30VPmYmg+Om+KlekZgOx65oOMsj9E/hEsN7qb2RxAG74fJoDTkFjhcOQk/T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(66946007)(110136005)(66476007)(66556008)(966005)(41300700001)(5660300002)(38100700002)(31686004)(8676002)(4326008)(8936002)(82960400001)(30864003)(2906002)(19627235002)(83380400001)(26005)(478600001)(86362001)(31696002)(6512007)(53546011)(107886003)(6506007)(36756003)(6666004)(2616005)(6486002)(45980500001)(43740500002)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHR6djJVZFhaRXJKYUFQRGlIT3IyYmVzVEt2ay9RckJNMHZ1ektwZnh3bzNJ?=
 =?utf-8?B?MzBmb1lsM29TbHBlOWVxeGJ2dmUwR2krdzRiNFpnSVZKaE5HQzJyQ3BncTR5?=
 =?utf-8?B?amxYQ1pEK3RDU1VhaFNtN05qN1k3L3dzWXo3NzJSNWdKaWVEd0NFSkptNVlP?=
 =?utf-8?B?eFBIOXhwVHphRjZodk5YNmw0VFFHY3NsbThwWXE5b05McFpzRFg3L1h2Yjdt?=
 =?utf-8?B?RkMzclVQc2RlRnUxSjVZUFNjYWpDbVMzN3V5aHdKUnl2alJnU215dUYvQVpF?=
 =?utf-8?B?dTJjVVZSRUMwUmtiWFlVVXdTeXk5U0VJelNCYWRTMDRENlVKai9lSU9DWFRv?=
 =?utf-8?B?d2svQlIwdGVTOUhUOGhUK3Z0dVhlV2FiYjQ0SkpHb096b0tUMGFnTGlSV2w4?=
 =?utf-8?B?R0tPRmtLWWVnVUI2N1BCcS9pWENZSFM3bllqcFlDNXlNdDhqZmlMb0lIaUMx?=
 =?utf-8?B?RUpjOUlFVyt4aGFFSnhNQzkxK3NkeTFlUkRzd00zaVdvNlNvVk1VeDRFM2hK?=
 =?utf-8?B?NERyQkdnaHB2K3pzNW5TRmdjU0FiTUdLdnNQWi9HRXJabjdhbjJmUk9xRWNu?=
 =?utf-8?B?a2t4Rkg0VEJKaFZ1eVpVU01NS0E4bFA5VHBiakFZd3hkUEg0NnpGaHVzK1E2?=
 =?utf-8?B?bU5PVWQvbXBBS1RDOFd0OXFuSDRPQ3YrR29PakpQbWd5enBlT3dEcEhnMTJU?=
 =?utf-8?B?QlBNUEU1ZjNUQ3lFc1NMME8zWWVaa01UakN6KzVPMXdTVVRFY0lPbmg3SCtz?=
 =?utf-8?B?cElIalN0M2VaMndieVg1Myt1YjRkTHMxVjlseVpheTFmTUJtMWFCdjZvbXBi?=
 =?utf-8?B?c0ZOM1o1S2hTYXRjQ2lZcW1PSXJCc2dyM2MvWlBHMEFPSE52b2hkdDBKVFAy?=
 =?utf-8?B?OTJVUXNZZnA5cTJVckxoRHF6Y2dNOHgzSjdFY3ZwQlovVlk1Y3A4WjZXcTIw?=
 =?utf-8?B?c0s0a0xIN0NPdG9nVGhieDRUWVBiQ1ZDUWYwaUZKdWxFSnRva1VCVEY1UGVi?=
 =?utf-8?B?MTRhSHVNOWRSNmNyeG96aVFzY25Hcm0zZ3dLSEFobzFuZjQyN0JIY0Q0V05w?=
 =?utf-8?B?bno2ZVVlTFJZYWwwaVJzY1pkMHk1N3NLNHRxL1RtRVZPd3ZmZnMvTjVwTEZO?=
 =?utf-8?B?OHFjQmxTTFFtQXlzd1lDMEc4RHAvdW9nNmJZNUlCU0NRVDJIM050eTM2aHlm?=
 =?utf-8?B?OU03b29LYU1PZU1qajFJSFgvbXFtZC9td1ZtdDBFZFZjdnpNbzJnc0s5TDMz?=
 =?utf-8?B?N0NVZkRHU0ZNQnEySGlrM3p6NituMWdzcmhrcmpDczg2QVpMcndwZnJqb2xH?=
 =?utf-8?B?dTk1eTdYSE9tNWRBSTZSMCtYcUZKc1lDTUxBOGNLUHNOaVM0TmdmYVBud0lr?=
 =?utf-8?B?dkNFYUtVOHhmWEh1Y3h6WFdDUGRKTlhrYlFOVmVMNFFJa1U5TEMzQ3NsK0gr?=
 =?utf-8?B?ZnNMUXQwSjRLK0dLd0hrdTNDSEE3QmQ1NFBuRnBiTUxtUmdldWhRZXZ5aGh3?=
 =?utf-8?B?NDZ3ckh0ZzRwaXFKQ3Ryb3dDRjVVMGtLb3hUb0ZqMFdDbGMvdVZoTWc1ZHcr?=
 =?utf-8?B?cGdrNkRpUmgrSnRqNHdFV3pzWnhVTS82bG1DTW5FV3dOTVNYSGxwUVNWR3Zs?=
 =?utf-8?B?M1pmbjAreldWNWxyd0d0a2U2SXgzSjhlUGczZXEvSEFYL1BNUy9OeSszWU5q?=
 =?utf-8?B?aEdRcmowYUtjeTNla3Y2S0NtNGo1VldLeWRYcm9Bd0ZGcGFBK1JFQms3dmNT?=
 =?utf-8?B?WnAzN3FHaHc5VThLR0J0UHFsS1lTMkVlZzEzRUtMaXdHNUtidUhiaDB3cmg3?=
 =?utf-8?B?QWRaTmNRMytYNGFwQ2RlWk1HRmJVZ2pjQ0lMVnJCNnZ0MEVKciswL1hUWWp6?=
 =?utf-8?B?UkRWWldZSENqY0tVYUFSVVhQeVo2SEo3bmZ4V3VPMDdQZGY0VmlENDBwZytl?=
 =?utf-8?B?aksyZmRLOWFOTm1UeTNHRUQ0VmY3c2Z1d3lsSHFDc2VacTVRRCt0NVoyNjhy?=
 =?utf-8?B?eXpOTEEyWS9zM3BkT0k3b1orL2g2b0hiREl1NmpzclVObTNwSlpwaWdFM0dN?=
 =?utf-8?B?ZGNlcEJxNHVBMmhsZzBjSmhkdzBjdGhWTE96VFBmcFFkZ2ErTlhKU3M0VUs4?=
 =?utf-8?B?NE1TdENVU3B3M1hkYkRTUWpOVjkzcmhVSVU3RVlZUDdXQjhFdGIzUjBjT1dS?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c056e68b-837c-45e5-a6df-08db9e6e1090
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 15:32:57.1966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UWPI+661E494tRAGZ7dhiojiIA8NI7xyWok1Xr2/Amryoq7eVtTiJL55t9Ptz5LAL966Din7bGnUPBGyH+5zyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7563
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On 7/6/2023 3:29 PM, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -33.1% regression of stress-ng.io-uring.ops_per_sec on:
> 
> 
> commit: caec5ebe77f97d948dcf46f07d622bda7f1f6dfd ("io_uring: rely solely on FMODE_NOWAIT")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> NOTE:
> one thing we want to mention is we reported
> "[linux-next:master] [io_uring]  caec5ebe77: stress-ng.io-uring.ops_per_sec 32.5% improvement"
> on
> https://lore.kernel.org/all/202306061247.510feb23-oliver.sang@intel.com/
> however, by further checking, we realized the test machine ran in abnormal
> status at that time due to BIOS issue, which we finally fixed recently.
> please just ignore that report upon linus-next/master.
> 
> 
> testcase: stress-ng
> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	nr_threads: 100%
> 	testtime: 60s
> 	class: pts
> 	test: io-uring
> 	cpufreq_governor: performance
> 
> 
> In addition to that, the commit also has significant impact on the following tests:
> 
> +------------------+-------------------------------------------------------------------------------------------------+
> | testcase: change | stress-ng: stress-ng.io-uring.ops_per_sec -1.3% regression                                      |
> | test machine     | 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory |
> | test parameters  | class=pts                                                                                       |
> |                  | cpufreq_governor=performance                                                                    |
> |                  | nr_threads=100%                                                                                 |
> |                  | test=io-uring                                                                                   |
> |                  | testtime=60s                                                                                    |
> +------------------+-------------------------------------------------------------------------------------------------+
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202307060958.3594f22f-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> To reproduce:
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
>         sudo bin/lkp run generated-yaml-file
> 
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
> 
> =========================================================================================
> class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   pts/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-icl-2sp7/io-uring/stress-ng/60s
> 
> commit: 
>   e9833d8701 ("block: mark bdev files as FMODE_NOWAIT if underlying device supports it")
>   caec5ebe77 ("io_uring: rely solely on FMODE_NOWAIT")
About this regression, some findings in my side:
- LKP use initrd to do stress-ng testing. That means the stress-ng is using the
  file in initrd as test file.
- The commit caec5ebe77 makes io_uring rely on FMODE_NOWAIT. But the tmpfs and
  the file on initrd doesn't has that bit set. I suppose this is why we can see
  this regression with LKP which is using initrd.

  I tried to let stress-ng.io_uring use the file on tmpfs and also can see
  signifcient performance change with this commit.

- If apply following change based on commit caec5ebe77:
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 7c426584e35a..e755697c773f 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1765,6 +1765,17 @@ static void io_iopoll_req_issued(struct io_kiocb *req, unsigned int issue_flags)
  */
 static bool __io_file_supports_nowait(struct file *file, umode_t mode)
 {
+       if (S_ISREG(mode)) {
+               struct block_device *bdev = file->f_inode->i_sb->s_bdev;
+
+               if (IS_ENABLED(CONFIG_BLOCK) &&
+                               (!bdev || bdev_nowait(bdev)) &&
+                               !io_is_uring_fops(file))
+                       return true;
+
+               return false;
+       }
+
        /* any ->read/write should understand O_NONBLOCK */
        if (file->f_flags & O_NONBLOCK)
                return true;

The regression is gone with LKP.

- If apply following change based on commit caec5ebe77:
diff --git a/mm/shmem.c b/mm/shmem.c
index e40a08c5c6d7..e9df664f0063 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3962,9 +3962,16 @@ const struct address_space_operations shmem_aops = {
 };
 EXPORT_SYMBOL(shmem_aops);

+static int shmem_file_open(struct inode *inode, struct file *filp)
+{
+       filp->f_mode |= FMODE_NOWAIT;
+
+       return generic_file_open(inode, filp);
+}
+
 static const struct file_operations shmem_file_operations = {
        .mmap           = shmem_mmap,
-       .open           = generic_file_open,
+       .open           = shmem_file_open,
        .get_unmapped_area = shmem_get_unmapped_area,
 #ifdef CONFIG_TMPFS
        .llseek         = shmem_file_llseek,

The performance change when running stress-ng.io_uring with testing file
in tmpfs is gone.

This is just the information FYI. I may miss something obviously here. Thanks.


Regards
Yin, Fengwei

> 
> e9833d8701028b5d caec5ebe77f97d948dcf46f07d6 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>  2.594e+08 ±  7%    +108.5%  5.408e+08 ±  5%  cpuidle..time
>     265280 ±  6%   +5210.7%   14088284 ±  4%  cpuidle..usage
>       5.66 ±  8%      +7.2       12.84 ±  5%  mpstat.cpu.all.idle%
>       0.04 ±  7%      +0.1        0.15 ±  2%  mpstat.cpu.all.soft%
>       2.04 ±  3%      -0.2        1.84 ±  3%  mpstat.cpu.all.usr%
>       7.67 ±  6%     +93.5%      14.83 ±  6%  vmstat.cpu.id
>      61.83           +29.1%      79.83 ±  2%  vmstat.procs.r
>     622749           +44.5%     899809        vmstat.system.cs
>     108826           +59.8%     173876 ±  2%  vmstat.system.in
>       9355 ±  6%     +84.7%      17276 ±  2%  numa-meminfo.node0.KernelStack
>    1579458 ± 27%     -67.5%     513874 ± 17%  numa-meminfo.node1.Inactive
>    1579339 ± 27%     -67.5%     513754 ± 17%  numa-meminfo.node1.Inactive(anon)
>       9295 ±  6%     +67.5%      15572 ±  3%  numa-meminfo.node1.KernelStack
>     824102 ± 15%     -46.4%     441722 ± 25%  numa-meminfo.node1.Mapped
>      69099 ±  4%     -71.9%      19445 ± 13%  perf-c2c.DRAM.local
>       5392 ± 32%    +570.9%      36177 ±  9%  perf-c2c.DRAM.remote
>      98.17 ± 13%  +11039.9%      10935 ±  2%  perf-c2c.HITM.local
>      61.33 ± 42%   +1277.2%     844.67 ± 19%  perf-c2c.HITM.remote
>     159.50 ± 14%   +7285.8%      11780 ±  3%  perf-c2c.HITM.total
>    3690643 ±  5%     -26.7%    2705345 ± 12%  numa-numastat.node0.local_node
>    3745826 ±  4%     -27.3%    2723971 ± 12%  numa-numastat.node0.numa_hit
>      55147 ± 13%     -66.2%      18626 ± 71%  numa-numastat.node0.other_node
>    4234422 ±  3%     -28.1%    3043703 ±  8%  numa-numastat.node1.local_node
>    4245483 ±  3%     -27.2%    3091278 ±  9%  numa-numastat.node1.numa_hit
>      11061 ± 67%    +330.1%      47574 ± 27%  numa-numastat.node1.other_node
>   37095722           -33.1%   24820858        stress-ng.io-uring.ops
>     617812           -33.1%     413235        stress-ng.io-uring.ops_per_sec
>     228755 ±  5%   +3421.6%    8055857        stress-ng.time.involuntary_context_switches
>       5935            -9.0%       5403        stress-ng.time.percent_of_cpu_this_job_got
>       3679            -9.1%       3342        stress-ng.time.system_time
>      10.99 ±  4%     +55.0%      17.04 ±  7%  stress-ng.time.user_time
>   40467435           -10.9%   36037982        stress-ng.time.voluntary_context_switches
>     460384 ± 42%    +308.0%    1878137        meminfo.Active
>     460256 ± 42%    +308.0%    1878009        meminfo.Active(anon)
>     416447 ±  2%     -12.8%     363303        meminfo.AnonPages
>    2233362 ±  8%     -60.2%     888272        meminfo.Inactive
>    2233179 ±  8%     -60.2%     888092        meminfo.Inactive(anon)
>      18675           +75.7%      32806        meminfo.KernelStack
>    1109597 ± 13%     -32.7%     747212 ±  7%  meminfo.Mapped
>      11174 ±  3%     -11.4%       9898 ±  2%  meminfo.PageTables
>       2310 ± 18%  +98373.0%    2275219 ±  9%  turbostat.C1
>      20795 ±  6%  +55407.8%   11543024 ±  4%  turbostat.C1E
>       0.12 ±  5%      +5.6        5.69 ±  2%  turbostat.C1E%
>       5.87 ±  6%    +102.3%      11.87 ±  5%  turbostat.CPU%c1
>       0.05           -20.0%       0.04        turbostat.IPC
>    7116993           +60.9%   11448631 ±  2%  turbostat.IRQ
>      85.17 ± 58%  +19991.6%      17111 ±  8%  turbostat.POLL
>     245.45            -2.8%     238.59        turbostat.PkgWatt
>     118.03            -8.3%     108.24        turbostat.RAMWatt
>       9358 ±  6%     +84.6%      17273 ±  2%  numa-vmstat.node0.nr_kernel_stack
>    3746119 ±  4%     -27.3%    2723944 ± 12%  numa-vmstat.node0.numa_hit
>    3690936 ±  5%     -26.7%    2705318 ± 12%  numa-vmstat.node0.numa_local
>      55147 ± 13%     -66.2%      18626 ± 71%  numa-vmstat.node0.numa_other
>     395951 ± 27%     -67.6%     128400 ± 17%  numa-vmstat.node1.nr_inactive_anon
>       9297 ±  6%     +67.5%      15570 ±  3%  numa-vmstat.node1.nr_kernel_stack
>     207192 ± 15%     -46.8%     110289 ± 24%  numa-vmstat.node1.nr_mapped
>     395950 ± 27%     -67.6%     128399 ± 17%  numa-vmstat.node1.nr_zone_inactive_anon
>    4245753 ±  3%     -27.2%    3091083 ±  9%  numa-vmstat.node1.numa_hit
>    4234692 ±  3%     -28.1%    3043508 ±  8%  numa-vmstat.node1.numa_local
>      11061 ± 67%    +330.1%      47574 ± 27%  numa-vmstat.node1.numa_other
>     115285 ± 42%    +307.6%     469935        proc-vmstat.nr_active_anon
>     104064 ±  2%     -12.7%      90796        proc-vmstat.nr_anon_pages
>    1264863            +2.5%    1296456        proc-vmstat.nr_file_pages
>     558025 ±  8%     -60.3%     221737        proc-vmstat.nr_inactive_anon
>      18670           +75.7%      32807        proc-vmstat.nr_kernel_stack
>     277364 ± 13%     -32.8%     186281 ±  7%  proc-vmstat.nr_mapped
>       2789 ±  3%     -11.3%       2473 ±  2%  proc-vmstat.nr_page_table_pages
>     569317            +5.5%     600873        proc-vmstat.nr_shmem
>      61861            +5.3%      65163        proc-vmstat.nr_slab_unreclaimable
>     115285 ± 42%    +307.6%     469935        proc-vmstat.nr_zone_active_anon
>     558025 ±  8%     -60.3%     221737        proc-vmstat.nr_zone_inactive_anon
>    7995646           -27.2%    5817349        proc-vmstat.numa_hit
>    7929402           -27.5%    5751148        proc-vmstat.numa_local
>       3517 ±101%    +224.0%      11397 ± 41%  proc-vmstat.numa_pages_migrated
>   28296925           -31.3%   19428277        proc-vmstat.pgalloc_normal
>   27448011           -32.1%   18626826        proc-vmstat.pgfree
>       3517 ±101%    +224.0%      11397 ± 41%  proc-vmstat.pgmigrate_success
>      14631 ± 24%     +44.3%      21116 ± 22%  proc-vmstat.pgreuse
>    1177088 ±  2%      +5.3%    1238912        proc-vmstat.unevictable_pgs_scanned
>       0.64 ±  2%     +29.0%       0.82 ±  6%  sched_debug.cfs_rq:/.h_nr_running.avg
>       1.50           +66.7%       2.50 ± 20%  sched_debug.cfs_rq:/.h_nr_running.max
>       0.50          -100.0%       0.00        sched_debug.cfs_rq:/.h_nr_running.min
>       0.31 ±  8%     +98.8%       0.62 ±  6%  sched_debug.cfs_rq:/.h_nr_running.stddev
>       7171 ± 13%    -100.0%       0.00        sched_debug.cfs_rq:/.load.min
>       7981 ± 16%    +288.4%      30998 ± 92%  sched_debug.cfs_rq:/.load.stddev
>       6.67 ± 14%     -53.8%       3.08 ± 27%  sched_debug.cfs_rq:/.load_avg.min
>    1885498           -16.5%    1575192        sched_debug.cfs_rq:/.min_vruntime.avg
>    1954909           -10.1%    1757298        sched_debug.cfs_rq:/.min_vruntime.max
>    1727273           -21.1%    1363179 ±  3%  sched_debug.cfs_rq:/.min_vruntime.min
>      41645 ±  8%     +91.7%      79846 ± 17%  sched_debug.cfs_rq:/.min_vruntime.stddev
>       0.50          -100.0%       0.00        sched_debug.cfs_rq:/.nr_running.min
>       0.21 ±  4%     +67.2%       0.35 ±  6%  sched_debug.cfs_rq:/.nr_running.stddev
>     751.58 ±  3%     +18.6%     891.11 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
>       1665 ±  9%     +42.5%       2373 ± 15%  sched_debug.cfs_rq:/.runnable_avg.max
>     513.17           -68.7%     160.75 ± 20%  sched_debug.cfs_rq:/.runnable_avg.min
>     248.44 ± 12%     +96.2%     487.49 ± 11%  sched_debug.cfs_rq:/.runnable_avg.stddev
>      41543 ±  8%     +92.3%      79899 ± 17%  sched_debug.cfs_rq:/.spread0.stddev
>       1298 ± 10%     +45.8%       1892 ± 14%  sched_debug.cfs_rq:/.util_avg.max
>     453.00 ± 15%     -70.4%     134.00 ± 16%  sched_debug.cfs_rq:/.util_avg.min
>     182.62 ± 12%    +118.3%     398.65 ± 11%  sched_debug.cfs_rq:/.util_avg.stddev
>     280.79 ±  2%     -46.8%     149.49 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.avg
>     165.17 ± 30%    -100.0%       0.00        sched_debug.cfs_rq:/.util_est_enqueued.min
>     105.37 ± 16%     +51.5%     159.68 ±  6%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
>     530405 ±  8%     -26.0%     392728 ±  5%  sched_debug.cpu.avg_idle.avg
>      19942 ± 41%     -66.1%       6758 ±  5%  sched_debug.cpu.avg_idle.min
>     272109 ± 11%     -44.4%     151324 ± 17%  sched_debug.cpu.avg_idle.stddev
>       8.57 ± 13%     -38.8%       5.24 ±  6%  sched_debug.cpu.clock.stddev
>       2936 ±  3%    +116.4%       6353 ±  2%  sched_debug.cpu.curr->pid.avg
>       5578           +57.2%       8768        sched_debug.cpu.curr->pid.max
>       1578 ± 30%    -100.0%       0.00        sched_debug.cpu.curr->pid.min
>       1176 ±  6%    +125.1%       2649 ±  6%  sched_debug.cpu.curr->pid.stddev
>       0.64 ±  2%     +26.6%       0.81 ±  5%  sched_debug.cpu.nr_running.avg
>       1.50           +66.7%       2.50 ± 11%  sched_debug.cpu.nr_running.max
>       0.50          -100.0%       0.00        sched_debug.cpu.nr_running.min
>       0.32 ±  8%     +94.7%       0.62 ±  8%  sched_debug.cpu.nr_running.stddev
>     309449           +44.0%     445760        sched_debug.cpu.nr_switches.avg
>     502157 ±  2%     +27.3%     639259        sched_debug.cpu.nr_switches.max
>     210908 ± 12%     +89.5%     399733 ±  3%  sched_debug.cpu.nr_switches.min
>      42371 ±  8%     -28.7%      30230 ±  2%  sched_debug.cpu.nr_switches.stddev
>      54.82            -1.3%      54.13        perf-stat.i.MPKI
>  5.309e+09           -16.8%  4.418e+09        perf-stat.i.branch-instructions
>       0.39 ±  2%      +0.3        0.70 ±  2%  perf-stat.i.branch-miss-rate%
>   18374324 ±  2%     +58.4%   29111083 ±  2%  perf-stat.i.branch-misses
>      57.60           -10.6       47.02        perf-stat.i.cache-miss-rate%
>  8.211e+08           -34.1%  5.408e+08        perf-stat.i.cache-misses
>  1.401e+09           -18.8%  1.138e+09        perf-stat.i.cache-references
>     654272           +45.0%     948647        perf-stat.i.context-switches
>       7.35           +14.9%       8.45        perf-stat.i.cpi
>  1.879e+11            -5.5%  1.775e+11        perf-stat.i.cpu-cycles
>     229.56 ±  3%  +66076.8%     151915        perf-stat.i.cpu-migrations
>     282.44           +31.7%     371.93 ±  2%  perf-stat.i.cycles-between-cache-misses
>       1.08 ±  4%      +0.2        1.28 ±  2%  perf-stat.i.dTLB-load-miss-rate%
>  5.363e+09           -11.7%  4.736e+09        perf-stat.i.dTLB-loads
>       0.14 ±  5%      +0.0        0.17        perf-stat.i.dTLB-store-miss-rate%
>  2.903e+09           -12.1%  2.551e+09        perf-stat.i.dTLB-stores
>  2.573e+10           -16.4%  2.152e+10        perf-stat.i.instructions
>       0.17            -8.9%       0.15        perf-stat.i.ipc
>       2.93            -5.5%       2.77        perf-stat.i.metric.GHz
>     764.19 ± 20%     -82.7%     132.26 ± 12%  perf-stat.i.metric.K/sec
>     245.84           -15.1%     208.78        perf-stat.i.metric.M/sec
>       7.28 ± 18%     +50.4       57.70 ±  6%  perf-stat.i.node-load-miss-rate%
>   22932644 ± 21%    +577.3%  1.553e+08 ±  5%  perf-stat.i.node-load-misses
>  3.872e+08 ±  2%     -70.8%  1.131e+08 ± 10%  perf-stat.i.node-loads
>       6.12 ± 23%     +49.4       55.48 ±  6%  perf-stat.i.node-store-miss-rate%
>   20676280 ± 24%    +600.9%  1.449e+08 ±  5%  perf-stat.i.node-store-misses
>  3.782e+08 ±  2%     -69.6%   1.15e+08 ± 10%  perf-stat.i.node-stores
>      54.67            -2.7%      53.17        perf-stat.overall.MPKI
>       0.34 ±  2%      +0.3        0.65 ±  2%  perf-stat.overall.branch-miss-rate%
>      58.57           -11.1       47.50        perf-stat.overall.cache-miss-rate%
>       7.33           +13.2%       8.29        perf-stat.overall.cpi
>     228.79           +43.6%     328.44        perf-stat.overall.cycles-between-cache-misses
>       1.08 ±  4%      +0.2        1.26 ±  2%  perf-stat.overall.dTLB-load-miss-rate%
>       0.14 ±  5%      +0.0        0.17        perf-stat.overall.dTLB-store-miss-rate%
>       0.14           -11.7%       0.12        perf-stat.overall.ipc
>       5.60 ± 22%     +52.4       58.04 ±  6%  perf-stat.overall.node-load-miss-rate%
>       5.20 ± 25%     +50.8       55.97 ±  6%  perf-stat.overall.node-store-miss-rate%
>  5.212e+09           -16.9%  4.331e+09        perf-stat.ps.branch-instructions
>   17804128 ±  2%     +59.3%   28355867 ±  2%  perf-stat.ps.branch-misses
>  8.089e+08           -34.1%  5.328e+08        perf-stat.ps.cache-misses
>  1.381e+09           -18.8%  1.122e+09        perf-stat.ps.cache-references
>     644681           +45.1%     935594        perf-stat.ps.context-switches
>  1.851e+11            -5.5%  1.749e+11        perf-stat.ps.cpu-cycles
>     223.81 ±  3%  +66855.8%     149855        perf-stat.ps.cpu-migrations
>  5.265e+09           -11.8%  4.642e+09        perf-stat.ps.dTLB-loads
>  2.852e+09           -12.3%  2.502e+09        perf-stat.ps.dTLB-stores
>  2.526e+10           -16.5%   2.11e+10        perf-stat.ps.instructions
>   22590325 ± 21%    +579.0%  1.534e+08 ±  5%  perf-stat.ps.node-load-misses
>  3.815e+08 ±  2%     -70.9%  1.111e+08 ± 10%  perf-stat.ps.node-loads
>   20384897 ± 24%    +602.4%  1.432e+08 ±  5%  perf-stat.ps.node-store-misses
>  3.726e+08 ±  2%     -69.7%  1.129e+08 ± 10%  perf-stat.ps.node-stores
>  1.593e+12           -16.2%  1.335e+12        perf-stat.total.instructions
>       0.02 ±188%    +490.1%       0.14 ± 28%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.__kmalloc_large_node.__kmalloc.iovec_from_user
>       0.00 ± 71%    +368.2%       0.02 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
>       0.00 ±103%   +5050.0%       0.07 ±  5%  perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.io_alloc_async_data.io_setup_async_rw
>       0.00 ±223%   +1833.3%       0.03 ± 85%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>       0.00 ±223%  +22500.0%       0.04 ± 71%  perf-sched.sch_delay.avg.ms.__cond_resched.change_pmd_range.change_p4d_range.change_protection_range.change_prot_numa
>       0.00 ±223%   +7000.0%       0.06 ± 78%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.generic_file_write_iter.io_write.io_issue_sqe
>       0.00 ± 72%    +240.7%       0.02 ±  3%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write
>       0.00 ±223%  +12316.7%       0.12 ± 32%  perf-sched.sch_delay.avg.ms.__cond_resched.io_write.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
>       0.03 ± 71%    +248.4%       0.09 ±  6%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00 ±141%   +1782.4%       0.05 ± 55%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
>       0.01 ± 76%    +354.7%       0.04 ± 32%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.io_run_task_work.io_cqring_wait.__do_sys_io_uring_enter
>       0.00 ± 83%    +459.3%       0.03 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.io_run_task_work.io_wq_worker.ret_from_fork
>       0.00 ±166%    +422.2%       0.01 ± 73%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>       0.00 ±180%   +2452.9%       0.07 ± 44%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
>       0.00 ±157%   +2845.0%       0.10 ± 22%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
>       0.01 ± 71%    +137.3%       0.02 ±  2%  perf-sched.sch_delay.avg.ms.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.01 ± 72%    +660.6%       0.04 ±  2%  perf-sched.sch_delay.avg.ms.schedule_timeout.io_wq_worker.ret_from_fork.[unknown]
>       0.01 ± 71%    +108.3%       0.02 ± 15%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>       0.15 ±207%   +1495.9%       2.33 ± 29%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.__kmalloc_large_node.__kmalloc.iovec_from_user
>       0.10 ±128%  +10698.5%      10.74 ± 41%  perf-sched.sch_delay.max.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
>       0.12 ±184%   +3432.9%       4.20 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.io_alloc_async_data.io_setup_async_rw
>       0.00 ±223%  +21533.3%       0.32 ±123%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>       0.01 ±103%   +4800.0%       0.32 ± 85%  perf-sched.sch_delay.max.ms.__cond_resched.change_pmd_range.change_p4d_range.change_protection_range.change_prot_numa
>       0.00 ±223%    +1e+05%       0.84 ± 85%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.generic_file_write_iter.io_write.io_issue_sqe
>       0.29 ±108%   +1816.6%       5.62 ± 39%  perf-sched.sch_delay.max.ms.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write
>       1.17 ±168%    +519.0%       7.27 ± 69%  perf-sched.sch_delay.max.ms.__cond_resched.io_assign_current_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>       0.00 ±223%  +2.4e+05%       2.39 ± 42%  perf-sched.sch_delay.max.ms.__cond_resched.io_write.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
>       0.98 ± 90%    +443.2%       5.32 ± 34%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00 ±141%  +23558.8%       0.67 ± 56%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
>       0.21 ±129%    +292.1%       0.83 ± 36%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.io_run_task_work.io_cqring_wait.__do_sys_io_uring_enter
>       0.01 ± 80%  +37525.8%       1.94 ± 45%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.io_run_task_work.io_wq_worker.ret_from_fork
>       0.11 ±191%   +1132.7%       1.33 ± 32%  perf-sched.sch_delay.max.ms.__cond_resched.tctx_task_work.task_work_run.io_run_task_work.io_cqring_wait
>       0.09 ±196%    +596.7%       0.63 ± 94%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>       0.01 ±189%  +37034.5%       3.59 ± 77%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
>       0.37 ± 97%    +971.5%       3.99 ± 10%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
>       0.01 ±164%   +3227.9%       0.24 ±106%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_madvise
>       0.04 ± 71%    +142.1%       0.10 ± 10%  perf-sched.sch_delay.max.ms.schedule_timeout.kcompactd.kthread.ret_from_fork
>       0.01 ± 71%    +329.8%       0.03 ±  2%  perf-sched.total_sch_delay.average.ms
>       0.24 ± 70%    +300.7%       0.97        perf-sched.total_wait_and_delay.average.ms
>       2487 ± 71%     +72.6%       4293 ±  5%  perf-sched.total_wait_and_delay.max.ms
>       0.23 ± 70%    +300.0%       0.94        perf-sched.total_wait_time.average.ms
>       2487 ± 71%     +72.6%       4293 ±  5%  perf-sched.total_wait_time.max.ms
>       0.08 ± 70%    +196.5%       0.24        perf-sched.wait_and_delay.avg.ms.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      53.10 ± 73%    +146.8%     131.03 ± 25%  perf-sched.wait_and_delay.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.09 ± 70%   +1232.8%       1.15        perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_wq_worker.ret_from_fork.[unknown]
>       4.87 ± 70%     +88.7%       9.20 ±  2%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>     405.33 ±104%   +6124.0%      25227 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
>     673.83 ± 73%   +4455.5%      30696 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write
>       1.67 ±157%    +1e+05%       1673 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.io_assign_current_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>      64.67 ± 70%     +68.6%     109.00        perf-sched.wait_and_delay.count.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
>      89.00 ± 87%    +655.8%     672.67 ±  6%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.io_wq_worker.ret_from_fork
>      45.33 ± 70%     +69.9%      77.00        perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.wait_for_completion_state.kernel_clone
>    1015874 ± 70%     +75.8%    1786051        perf-sched.wait_and_delay.count.schedule_timeout.io_wq_worker.ret_from_fork.[unknown]
>     366.17 ± 71%     +77.1%     648.50 ±  2%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork
>       0.84 ±100%   +4269.4%      36.90 ± 15%  perf-sched.wait_and_delay.max.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
>       1.17 ±168%   +3446.2%      41.54 ± 22%  perf-sched.wait_and_delay.max.ms.__cond_resched.io_assign_current_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>      55.54 ± 72%    +141.0%     133.87 ± 19%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       2367 ± 71%     +78.3%       4221 ±  5%  perf-sched.wait_and_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>       0.06 ± 94%    +894.2%       0.63 ± 10%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__kmalloc_large_node.__kmalloc.iovec_from_user
>       0.03 ± 74%   +1090.6%       0.38        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.io_alloc_async_data.io_setup_async_rw
>       0.00 ±223%   +3964.3%       0.09 ±166%  perf-sched.wait_time.avg.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
>       0.00 ±141%   +5678.3%       0.22 ± 27%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>       0.00 ±223%   +1318.8%       0.04 ±128%  perf-sched.wait_time.avg.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
>       0.00 ±223%   +1160.9%       0.05 ± 96%  perf-sched.wait_time.avg.ms.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.[unknown]
>       0.00 ±223%  +20680.0%       0.17 ±183%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
>       0.00 ±223%  +29607.1%       0.69 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.generic_file_write_iter.io_write.io_issue_sqe
>       0.00 ±223%   +1200.0%       0.04 ±130%  perf-sched.wait_time.avg.ms.__cond_resched.dput.step_into.link_path_walk.part
>       0.09 ±114%   +1394.8%       1.40 ±  8%  perf-sched.wait_time.avg.ms.__cond_resched.io_assign_current_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>       0.00 ±223%  +19322.2%       0.87 ± 35%  perf-sched.wait_time.avg.ms.__cond_resched.io_write.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
>       0.03 ±182%   +5037.2%       1.77 ±114%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
>       0.00 ±223%    +512.5%       0.02 ± 73%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init.mm_init
>       0.00 ±141%   +5309.5%       0.19 ± 58%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
>       0.00 ±223%   +9055.6%       0.14 ± 77%  perf-sched.wait_time.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>       0.07 ± 75%    +228.6%       0.22 ± 22%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.io_run_task_work.io_cqring_wait.__do_sys_io_uring_enter
>       0.07 ±113%    +311.7%       0.28 ± 14%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_call_function_single
>       0.10 ± 73%    +368.8%       0.47 ± 12%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
>       0.07 ± 70%    +204.5%       0.21        perf-sched.wait_time.avg.ms.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      52.84 ± 73%    +148.0%     131.02 ± 25%  perf-sched.wait_time.avg.ms.pipe_read.vfs_read.ksys_read.do_syscall_64
>       0.01 ±153%   +9910.9%       0.92 ±183%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_madvise
>       0.08 ± 70%   +1268.9%       1.11        perf-sched.wait_time.avg.ms.schedule_timeout.io_wq_worker.ret_from_fork.[unknown]
>       4.84 ± 70%     +89.1%       9.16 ±  2%  perf-sched.wait_time.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.01 ±144%   +5547.8%       0.43 ±138%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.do_anonymous_page
>       0.34 ±101%    +855.3%       3.24 ± 19%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__kmalloc_large_node.__kmalloc.iovec_from_user
>       1.06 ± 71%   +3383.1%      36.89 ± 15%  perf-sched.wait_time.max.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
>       0.56 ± 77%    +987.5%       6.06 ± 30%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.io_alloc_async_data.io_setup_async_rw
>       0.00 ±223%   +5500.0%       0.17 ±186%  perf-sched.wait_time.max.ms.__cond_resched.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node.dup_task_struct
>       0.00 ±141%  +45243.5%       1.74 ± 47%  perf-sched.wait_time.max.ms.__cond_resched.__wait_for_common.stop_two_cpus.migrate_swap.task_numa_migrate
>       0.00 ±223%   +5621.1%       0.18 ±177%  perf-sched.wait_time.max.ms.__cond_resched.copy_strings.isra.0.do_execveat_common
>       0.00 ±223%   +4717.4%       0.18 ±121%  perf-sched.wait_time.max.ms.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.[unknown]
>       0.00 ±223%  +25600.0%       0.21 ±146%  perf-sched.wait_time.max.ms.__cond_resched.down_write.free_pgtables.exit_mmap.__mmput
>       0.00 ±223%  +2.3e+05%       5.41 ± 40%  perf-sched.wait_time.max.ms.__cond_resched.down_write.generic_file_write_iter.io_write.io_issue_sqe
>       0.00 ±223%   +3295.0%       0.11 ±168%  perf-sched.wait_time.max.ms.__cond_resched.dput.step_into.link_path_walk.part
>       0.32 ±102%  +13069.0%      41.50 ± 22%  perf-sched.wait_time.max.ms.__cond_resched.io_assign_current_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>       0.00 ±223%  +2.8e+05%      12.76 ± 80%  perf-sched.wait_time.max.ms.__cond_resched.io_write.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
>       0.06 ±198%   +7022.2%       4.23 ± 93%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.perf_event_ctx_lock_nested.constprop.0
>       0.00 ±223%   +2779.2%       0.12 ±117%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock_killable.pcpu_alloc.__percpu_counter_init.mm_init
>       0.00 ±141%  +34166.7%       1.20 ± 53%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.migrate_task_to.task_numa_migrate.isra
>       0.10 ±214%   +1111.3%       1.23 ± 68%  perf-sched.wait_time.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>       0.62 ± 74%    +146.4%       1.54 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.io_run_task_work.io_cqring_wait.__do_sys_io_uring_enter
>       0.11 ±204%   +8137.5%       8.81 ± 52%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.io_run_task_work.io_wq_worker.ret_from_fork
>       0.75 ±101%    +347.2%       3.36 ± 17%  perf-sched.wait_time.max.ms.__cond_resched.tctx_task_work.task_work_run.io_run_task_work.io_cqring_wait
>       0.01 ±153%  +1.2e+05%      11.01 ±178%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write_killable.do_madvise
>      55.51 ± 72%    +141.1%     133.84 ± 19%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       2367 ± 71%     +78.3%       4221 ±  5%  perf-sched.wait_time.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>      47.63           -47.6        0.00        perf-profile.calltrace.cycles-pp.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      47.25           -47.3        0.00        perf-profile.calltrace.cycles-pp.io_read.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64
>      46.60           -46.6        0.00        perf-profile.calltrace.cycles-pp.filemap_read.io_read.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter
>      48.31           -46.6        1.74        perf-profile.calltrace.cycles-pp.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>      49.01           -45.6        3.42        perf-profile.calltrace.cycles-pp.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>      49.08           -45.5        3.55        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>      49.12           -45.5        3.61        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
>      50.96           -44.5        6.42        perf-profile.calltrace.cycles-pp.syscall
>      42.90           -42.9        0.00        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.io_read.io_issue_sqe.io_submit_sqes
>      34.63            -4.3       30.37        perf-profile.calltrace.cycles-pp.copyout._copy_to_iter.copy_page_to_iter.filemap_read.io_read
>      40.60            -4.2       36.42        perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.filemap_read.io_read.io_issue_sqe
>      25.86            -3.3       22.60        perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write
>      45.60            -3.1       42.47        perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.io_write.io_issue_sqe.io_wq_submit_work
>      45.63            -3.1       42.50        perf-profile.calltrace.cycles-pp.generic_file_write_iter.io_write.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
>      45.53            -3.1       42.41        perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write.io_issue_sqe
>      45.69            -3.1       42.58        perf-profile.calltrace.cycles-pp.io_write.io_issue_sqe.io_wq_submit_work.io_worker_handle_work.io_wq_worker
>      25.02            -3.0       21.98        perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
>      16.79            -0.9       15.93        perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
>       1.10            -0.1        1.03        perf-profile.calltrace.cycles-pp.simple_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write
>       1.06            -0.1        1.00        perf-profile.calltrace.cycles-pp.pagecache_get_page.simple_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
>       1.01            -0.0        0.96        perf-profile.calltrace.cycles-pp.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write.__generic_file_write_iter
>       0.72            +0.1        0.85        perf-profile.calltrace.cycles-pp.copy_iovec_from_user.syscall
>       0.64            +0.2        0.81 ±  2%  perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.io_read.io_issue_sqe
>       0.74 ±  2%      +0.2        0.95 ±  2%  perf-profile.calltrace.cycles-pp.folio_unlock.simple_write_end.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
>       0.94 ±  2%      +0.3        1.19 ±  2%  perf-profile.calltrace.cycles-pp.simple_write_end.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write
>       0.00            +0.5        0.52 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.io_wq_activate_free_worker.io_wq_enqueue.io_queue_iowq.io_queue_async
>       0.00            +0.5        0.53 ±  2%  perf-profile.calltrace.cycles-pp.io_queue_iowq.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.6        0.55 ±  2%  perf-profile.calltrace.cycles-pp.io_wq_activate_free_worker.io_wq_enqueue.io_queue_iowq.io_queue_async.io_submit_sqes
>       0.00            +0.6        0.58 ±  2%  perf-profile.calltrace.cycles-pp.io_wq_enqueue.io_queue_iowq.io_queue_async.io_submit_sqes.__do_sys_io_uring_enter
>       0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.io_queue_iowq.io_queue_async.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64
>       0.00            +0.7        0.65 ±  2%  perf-profile.calltrace.cycles-pp.io_queue_async.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.7        0.66 ±  4%  perf-profile.calltrace.cycles-pp.flush_smp_call_function_queue.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00            +0.8        0.76 ± 10%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.io_wq_worker
>       1.00 ±  2%      +0.8        1.77        perf-profile.calltrace.cycles-pp.__entry_text_start.syscall
>       0.00            +0.8        0.83 ±  2%  perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.io_read.io_issue_sqe.io_wq_submit_work
>       0.00            +0.9        0.92 ±  2%  perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.io_issue_sqe
>       0.58            +0.9        1.51 ±  2%  perf-profile.calltrace.cycles-pp.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>       0.00            +0.9        0.94        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.io_issue_sqe.io_wq_submit_work
>       0.00            +0.9        0.94 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64
>       0.00            +1.0        0.96 ±  5%  perf-profile.calltrace.cycles-pp.schedule.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +1.0        0.99        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
>       0.00            +1.0        1.02        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.io_issue_sqe.io_wq_submit_work.io_worker_handle_work.io_wq_worker
>       0.60            +1.5        2.06 ±  4%  perf-profile.calltrace.cycles-pp.schedule_timeout.io_wq_worker.ret_from_fork
>       0.00            +1.5        1.51 ±  4%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       0.00            +1.7        1.66 ±  5%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.io_wq_worker.ret_from_fork
>       0.00            +1.7        1.71 ±  5%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.io_wq_worker.ret_from_fork
>       0.00            +2.0        1.96 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>       0.00            +2.0        1.98 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>       0.00            +2.2        2.21 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00            +3.4        3.43 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00            +3.4        3.44 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       0.00            +3.4        3.44 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>       0.00            +3.5        3.50 ±  4%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>       0.00           +38.3       38.32        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.io_read.io_issue_sqe.io_wq_submit_work
>      46.29           +39.8       86.07        perf-profile.calltrace.cycles-pp.io_issue_sqe.io_wq_submit_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>      46.30           +39.8       86.11        perf-profile.calltrace.cycles-pp.io_wq_submit_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>      46.44           +39.9       86.38        perf-profile.calltrace.cycles-pp.io_worker_handle_work.io_wq_worker.ret_from_fork
>      47.13           +41.5       88.61        perf-profile.calltrace.cycles-pp.io_wq_worker.ret_from_fork
>      47.17           +41.5       88.66        perf-profile.calltrace.cycles-pp.ret_from_fork
>       0.00           +41.8       41.76        perf-profile.calltrace.cycles-pp.filemap_read.io_read.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
>       0.00           +42.2       42.15        perf-profile.calltrace.cycles-pp.io_read.io_issue_sqe.io_wq_submit_work.io_worker_handle_work.io_wq_worker
>      48.31           -46.6        1.74        perf-profile.children.cycles-pp.io_submit_sqes
>      49.02           -45.6        3.42        perf-profile.children.cycles-pp.__do_sys_io_uring_enter
>      49.21           -45.5        3.73        perf-profile.children.cycles-pp.do_syscall_64
>      49.25           -45.5        3.79        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      51.00           -44.5        6.47        perf-profile.children.cycles-pp.syscall
>      93.92            -7.4       86.49        perf-profile.children.cycles-pp.io_issue_sqe
>      47.26            -4.9       42.35        perf-profile.children.cycles-pp.io_read
>      46.95            -4.9       42.07        perf-profile.children.cycles-pp.filemap_read
>      43.23            -4.6       38.60        perf-profile.children.cycles-pp.copy_page_to_iter
>      34.88            -4.3       30.61        perf-profile.children.cycles-pp.copyout
>      40.64            -4.2       36.46        perf-profile.children.cycles-pp._copy_to_iter
>      25.91            -3.3       22.64        perf-profile.children.cycles-pp.copy_page_from_iter_atomic
>      46.01            -3.2       42.76        perf-profile.children.cycles-pp.io_write
>      45.59            -3.1       42.45        perf-profile.children.cycles-pp.generic_perform_write
>      45.66            -3.1       42.52        perf-profile.children.cycles-pp.generic_file_write_iter
>      45.63            -3.1       42.49        perf-profile.children.cycles-pp.__generic_file_write_iter
>      25.33            -3.1       22.21        perf-profile.children.cycles-pp.copyin
>      16.98            -0.9       16.06        perf-profile.children.cycles-pp.fault_in_readable
>       0.88 ± 23%      -0.8        0.10 ± 18%  perf-profile.children.cycles-pp.ordered_events__queue
>       0.88 ± 23%      -0.8        0.10 ± 18%  perf-profile.children.cycles-pp.queue_event
>       0.94 ± 21%      -0.8        0.18 ± 35%  perf-profile.children.cycles-pp.process_simple
>       0.50            -0.2        0.33 ±  3%  perf-profile.children.cycles-pp.__io_import_iovec
>       0.48            -0.2        0.32 ±  2%  perf-profile.children.cycles-pp.__import_iovec
>       1.12            -0.1        1.04        perf-profile.children.cycles-pp.simple_write_begin
>       1.07            -0.1        1.01        perf-profile.children.cycles-pp.pagecache_get_page
>       1.03            -0.1        0.98        perf-profile.children.cycles-pp.__filemap_get_folio
>       0.25 ±  2%      -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.xas_load
>       0.14 ±  2%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.iovec_from_user
>       0.16 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.xas_descend
>       0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.io_madvise
>       0.08 ± 11%      +0.0        0.10 ±  3%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
>       0.08 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.__mod_timer
>       0.04 ± 44%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__timer_delete_sync
>       0.05            +0.0        0.09 ±  8%  perf-profile.children.cycles-pp.io_wq_free_work
>       0.02 ± 99%      +0.0        0.06 ±  6%  perf-profile.children.cycles-pp.update_rq_clock
>       0.05            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.lock_timer_base
>       0.06            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.set_next_entity
>       0.02 ±141%      +0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__try_to_del_timer_sync
>       0.00            +0.1        0.05        perf-profile.children.cycles-pp.update_min_vruntime
>       0.07 ±  5%      +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.io_clean_op
>       0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.call_function_single_prep_ipi
>       0.01 ±223%      +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.__io_commit_cqring_flush
>       0.00            +0.1        0.06 ±  8%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
>       0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.unmap_vmas
>       0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp._raw_spin_trylock
>       0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.x86_64_start_kernel
>       0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.x86_64_start_reservations
>       0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.start_kernel
>       0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.arch_call_rest_init
>       0.00            +0.1        0.06 ± 11%  perf-profile.children.cycles-pp.rest_init
>       0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.fput
>       0.00            +0.1        0.06        perf-profile.children.cycles-pp.io_cq_unlock_post
>       0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.native_sched_clock
>       0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.sched_clock_cpu
>       0.01 ±223%      +0.1        0.07        perf-profile.children.cycles-pp.io_prep_async_link
>       0.07            +0.1        0.13 ±  5%  perf-profile.children.cycles-pp.__update_load_avg_se
>       0.09 ±  4%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__cond_resched
>       0.00            +0.1        0.07 ± 13%  perf-profile.children.cycles-pp.do_exit
>       0.00            +0.1        0.07        perf-profile.children.cycles-pp.switch_fpu_return
>       0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.migrate_task_rq_fair
>       0.00            +0.1        0.07 ±  5%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
>       0.15 ±  8%      +0.1        0.23 ±  8%  perf-profile.children.cycles-pp.stress_io_uring
>       0.00            +0.1        0.08 ±  9%  perf-profile.children.cycles-pp.__io_req_task_work_add
>       0.00            +0.1        0.08 ±  8%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
>       0.00            +0.1        0.08 ±  4%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.llist_reverse_order
>       0.06 ±  7%      +0.1        0.15 ±  3%  perf-profile.children.cycles-pp.__switch_to
>       0.00            +0.1        0.08 ±  5%  perf-profile.children.cycles-pp.rebalance_domains
>       0.19 ±  3%      +0.1        0.28 ±  2%  perf-profile.children.cycles-pp.update_curr
>       0.00            +0.1        0.09 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       0.00            +0.1        0.09 ±  5%  perf-profile.children.cycles-pp.set_task_cpu
>       0.11 ±  6%      +0.1        0.20 ±  4%  perf-profile.children.cycles-pp.io_free_req_tw
>       0.00            +0.1        0.10 ±  9%  perf-profile.children.cycles-pp.select_idle_core
>       0.00            +0.1        0.10 ±  4%  perf-profile.children.cycles-pp.update_blocked_averages
>       0.00            +0.1        0.10 ±  3%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
>       0.00            +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.__sysvec_call_function_single
>       0.06 ±  7%      +0.1        0.17 ±  4%  perf-profile.children.cycles-pp.__switch_to_asm
>       0.80            +0.1        0.90        perf-profile.children.cycles-pp.copy_iovec_from_user
>       0.00            +0.1        0.11 ± 11%  perf-profile.children.cycles-pp.detach_tasks
>       0.00            +0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
>       0.00            +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.__io_req_complete_post
>       0.00            +0.1        0.12 ± 11%  perf-profile.children.cycles-pp.sysvec_call_function_single
>       0.05            +0.1        0.17 ±  6%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
>       0.00            +0.1        0.12 ±  4%  perf-profile.children.cycles-pp.task_h_load
>       0.10 ±  5%      +0.1        0.22 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.04 ± 45%      +0.1        0.18 ±  2%  perf-profile.children.cycles-pp.__irq_exit_rcu
>       0.00            +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
>       0.00            +0.1        0.14 ±  4%  perf-profile.children.cycles-pp.llist_add_batch
>       0.00            +0.1        0.14 ±  2%  perf-profile.children.cycles-pp.io_wq_worker_running
>       0.00            +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
>       0.00            +0.2        0.16 ±  4%  perf-profile.children.cycles-pp.__smp_call_single_queue
>       0.00            +0.2        0.16 ±  3%  perf-profile.children.cycles-pp.__do_softirq
>       0.17 ±  2%      +0.2        0.33 ±  3%  perf-profile.children.cycles-pp.tctx_task_work
>       0.65 ±  2%      +0.2        0.82 ±  2%  perf-profile.children.cycles-pp.filemap_get_read_batch
>       0.66            +0.2        0.83 ±  2%  perf-profile.children.cycles-pp.filemap_get_pages
>       0.00            +0.2        0.17 ±  3%  perf-profile.children.cycles-pp.switch_mm_irqs_off
>       0.47 ± 12%      +0.2        0.64 ±  3%  perf-profile.children.cycles-pp.scheduler_tick
>       0.04 ± 44%      +0.2        0.22 ±  6%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.00            +0.2        0.18 ±  4%  perf-profile.children.cycles-pp.menu_select
>       0.08 ±  6%      +0.2        0.26 ±  2%  perf-profile.children.cycles-pp.prepare_task_switch
>       0.04 ± 45%      +0.2        0.23 ±  8%  perf-profile.children.cycles-pp.task_tick_fair
>       0.22 ±  2%      +0.2        0.42 ±  4%  perf-profile.children.cycles-pp.task_work_run
>       0.52 ± 11%      +0.2        0.72 ±  3%  perf-profile.children.cycles-pp.update_process_times
>       0.00            +0.2        0.20 ±  4%  perf-profile.children.cycles-pp.select_idle_cpu
>       0.52 ± 11%      +0.2        0.73 ±  3%  perf-profile.children.cycles-pp.tick_sched_handle
>       0.00            +0.2        0.21 ±  4%  perf-profile.children.cycles-pp.wake_affine
>       0.74 ±  2%      +0.2        0.95 ±  2%  perf-profile.children.cycles-pp.folio_unlock
>       0.54 ± 11%      +0.2        0.75 ±  3%  perf-profile.children.cycles-pp.tick_sched_timer
>       0.00            +0.2        0.22 ±  5%  perf-profile.children.cycles-pp.finish_task_switch
>       0.60 ± 10%      +0.2        0.82 ±  2%  perf-profile.children.cycles-pp.__hrtimer_run_queues
>       0.00            +0.2        0.22 ±  3%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
>       0.66 ± 10%      +0.2        0.89 ±  2%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
>       0.66 ± 10%      +0.2        0.89 ±  2%  perf-profile.children.cycles-pp.hrtimer_interrupt
>       0.24            +0.2        0.48 ±  4%  perf-profile.children.cycles-pp.io_run_task_work
>       0.00            +0.3        0.26 ±  4%  perf-profile.children.cycles-pp.available_idle_cpu
>       0.95            +0.3        1.23 ±  2%  perf-profile.children.cycles-pp.simple_write_end
>       0.05 ± 13%      +0.3        0.35 ±  3%  perf-profile.children.cycles-pp.select_idle_sibling
>       0.20 ±  3%      +0.3        0.52 ±  4%  perf-profile.children.cycles-pp.enqueue_entity
>       0.00            +0.3        0.32 ±  7%  perf-profile.children.cycles-pp.intel_idle_irq
>       0.11 ±  3%      +0.3        0.46 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
>       0.73 ± 10%      +0.4        1.09 ±  2%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
>       0.28 ±  3%      +0.4        0.65 ±  2%  perf-profile.children.cycles-pp.io_queue_async
>       0.01 ±223%      +0.4        0.39 ±  4%  perf-profile.children.cycles-pp.update_cfs_group
>       0.00            +0.4        0.39 ± 19%  perf-profile.children.cycles-pp.update_sg_lb_stats
>       0.81 ±  9%      +0.4        1.22 ±  2%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.00            +0.4        0.44 ± 18%  perf-profile.children.cycles-pp.update_sd_lb_stats
>       0.00            +0.4        0.45 ± 18%  perf-profile.children.cycles-pp.find_busiest_group
>       0.22 ±  2%      +0.5        0.68 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
>       0.15 ±  3%      +0.5        0.61 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock
>       0.00            +0.5        0.48 ±  3%  perf-profile.children.cycles-pp.schedule_idle
>       0.10 ± 11%      +0.5        0.61 ±  3%  perf-profile.children.cycles-pp.select_task_rq
>       0.09 ± 12%      +0.5        0.61 ±  2%  perf-profile.children.cycles-pp.select_task_rq_fair
>       0.36            +0.5        0.88 ±  3%  perf-profile.children.cycles-pp.enqueue_task_fair
>       0.18 ±  3%      +0.5        0.71 ±  4%  perf-profile.children.cycles-pp.update_load_avg
>       0.39 ±  2%      +0.5        0.94        perf-profile.children.cycles-pp.autoremove_wake_function
>       0.44            +0.6        1.02 ±  3%  perf-profile.children.cycles-pp.ttwu_do_activate
>       0.00            +0.6        0.58 ±  4%  perf-profile.children.cycles-pp.sched_ttwu_pending
>       0.40 ±  2%      +0.6        0.99        perf-profile.children.cycles-pp.__wake_up_common
>       0.42 ±  2%      +0.6        1.02        perf-profile.children.cycles-pp.__wake_up_common_lock
>       0.42 ±  2%      +0.6        1.03        perf-profile.children.cycles-pp.io_wq_activate_free_worker
>       0.37            +0.6        1.00 ±  3%  perf-profile.children.cycles-pp.activate_task
>       0.45            +0.6        1.09        perf-profile.children.cycles-pp.io_wq_enqueue
>       0.50 ±  2%      +0.7        1.16        perf-profile.children.cycles-pp.io_queue_iowq
>       0.00            +0.7        0.67 ±  4%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
>       0.00            +0.7        0.73 ± 15%  perf-profile.children.cycles-pp.load_balance
>       1.01 ±  2%      +0.8        1.78        perf-profile.children.cycles-pp.__entry_text_start
>       0.00            +0.9        0.88 ± 12%  perf-profile.children.cycles-pp.newidle_balance
>       0.59            +0.9        1.52 ±  2%  perf-profile.children.cycles-pp.io_cqring_wait
>       0.17 ±  2%      +1.0        1.18 ±  9%  perf-profile.children.cycles-pp.pick_next_task_fair
>       0.79 ±  2%      +1.1        1.90        perf-profile.children.cycles-pp.try_to_wake_up
>       0.61 ±  2%      +1.5        2.06 ±  4%  perf-profile.children.cycles-pp.schedule_timeout
>       0.00            +1.5        1.54 ±  4%  perf-profile.children.cycles-pp.intel_idle
>       0.74            +1.9        2.67 ±  5%  perf-profile.children.cycles-pp.schedule
>       0.00            +2.0        2.00 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       0.00            +2.0        2.01 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
>       0.00            +2.2        2.25 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
>       0.71            +2.5        3.17 ±  4%  perf-profile.children.cycles-pp.__schedule
>       0.00            +3.4        3.44 ±  4%  perf-profile.children.cycles-pp.start_secondary
>       0.00            +3.5        3.50 ±  4%  perf-profile.children.cycles-pp.do_idle
>       0.00            +3.5        3.50 ±  4%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>       0.00            +3.5        3.50 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
>      46.30           +39.8       86.11        perf-profile.children.cycles-pp.io_wq_submit_work
>      46.45           +39.9       86.38        perf-profile.children.cycles-pp.io_worker_handle_work
>      47.14           +41.5       88.61        perf-profile.children.cycles-pp.io_wq_worker
>      47.17           +41.5       88.66        perf-profile.children.cycles-pp.ret_from_fork
>      34.58            -4.3       30.26        perf-profile.self.cycles-pp.copyout
>      25.11            -3.2       21.95        perf-profile.self.cycles-pp.copyin
>      16.80            -1.0       15.84        perf-profile.self.cycles-pp.fault_in_readable
>       0.86 ± 23%      -0.8        0.10 ± 20%  perf-profile.self.cycles-pp.queue_event
>       3.31            -0.5        2.82        perf-profile.self.cycles-pp.filemap_read
>       2.55            -0.5        2.08        perf-profile.self.cycles-pp.copy_page_to_iter
>       0.60            -0.2        0.44 ±  2%  perf-profile.self.cycles-pp.copy_page_from_iter_atomic
>       0.34            -0.1        0.21 ±  2%  perf-profile.self.cycles-pp.__import_iovec
>       0.32 ± 13%      -0.1        0.26 ±  4%  perf-profile.self.cycles-pp.perf_adjust_freq_unthr_context
>       0.20            -0.1        0.14 ±  3%  perf-profile.self.cycles-pp.__filemap_get_folio
>       0.18 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.generic_perform_write
>       0.06            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.xas_load
>       0.08 ± 11%      +0.0        0.10 ±  3%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
>       0.58            +0.0        0.60        perf-profile.self.cycles-pp.filemap_get_entry
>       0.05            +0.0        0.08 ±  8%  perf-profile.self.cycles-pp.pick_next_task_fair
>       0.09 ±  4%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.update_curr
>       0.14 ±  8%      +0.0        0.18 ±  9%  perf-profile.self.cycles-pp.stress_io_uring
>       0.06 ±  9%      +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.io_cqring_wait
>       0.02 ±141%      +0.0        0.06        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
>       0.02 ± 99%      +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.enqueue_entity
>       0.00            +0.1        0.05        perf-profile.self.cycles-pp.io_wq_activate_free_worker
>       0.00            +0.1        0.05        perf-profile.self.cycles-pp.__wake_up_common
>       0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.select_idle_sibling
>       0.00            +0.1        0.05 ±  7%  perf-profile.self.cycles-pp.__fget_light
>       0.01 ±223%      +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.__io_commit_cqring_flush
>       0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.call_function_single_prep_ipi
>       0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.fput
>       0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp._raw_spin_trylock
>       0.00            +0.1        0.06 ±  6%  perf-profile.self.cycles-pp.native_sched_clock
>       0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.flush_smp_call_function_queue
>       0.00            +0.1        0.06 ±  9%  perf-profile.self.cycles-pp.dequeue_entity
>       0.00            +0.1        0.06        perf-profile.self.cycles-pp.ttwu_queue_wakelist
>       0.07 ±  7%      +0.1        0.13 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
>       0.02 ±141%      +0.1        0.08 ±  4%  perf-profile.self.cycles-pp.dequeue_task_fair
>       0.00            +0.1        0.07 ±  5%  perf-profile.self.cycles-pp.__io_req_complete_post
>       0.00            +0.1        0.07        perf-profile.self.cycles-pp.finish_task_switch
>       0.00            +0.1        0.07        perf-profile.self.cycles-pp.menu_select
>       0.14 ±  3%      +0.1        0.22 ±  5%  perf-profile.self.cycles-pp.simple_write_end
>       0.00            +0.1        0.08 ±  6%  perf-profile.self.cycles-pp.io_wq_worker
>       0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.newidle_balance
>       0.00            +0.1        0.08 ±  5%  perf-profile.self.cycles-pp.llist_reverse_order
>       0.00            +0.1        0.08 ±  8%  perf-profile.self.cycles-pp.prepare_task_switch
>       0.06 ±  6%      +0.1        0.15 ±  4%  perf-profile.self.cycles-pp.__switch_to
>       0.05            +0.1        0.14 ±  2%  perf-profile.self.cycles-pp.try_to_wake_up
>       0.00            +0.1        0.09 ±  6%  perf-profile.self.cycles-pp.tctx_task_work
>       0.00            +0.1        0.10 ± 14%  perf-profile.self.cycles-pp.syscall
>       0.00            +0.1        0.10 ±  3%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
>       5.43            +0.1        5.53        perf-profile.self.cycles-pp._copy_to_iter
>       0.06 ±  7%      +0.1        0.17 ±  4%  perf-profile.self.cycles-pp.__switch_to_asm
>       0.79            +0.1        0.89        perf-profile.self.cycles-pp.copy_iovec_from_user
>       0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.update_rq_clock_task
>       0.00            +0.1        0.12 ±  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       0.00            +0.1        0.12 ±  4%  perf-profile.self.cycles-pp.task_h_load
>       0.03 ± 70%      +0.1        0.16 ±  5%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
>       0.08 ±  5%      +0.1        0.22 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.00            +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.llist_add_batch
>       0.00            +0.1        0.14        perf-profile.self.cycles-pp.io_wq_worker_running
>       0.06            +0.2        0.21 ±  4%  perf-profile.self.cycles-pp.enqueue_task_fair
>       0.60            +0.2        0.76 ±  2%  perf-profile.self.cycles-pp.filemap_get_read_batch
>       0.00            +0.2        0.17 ±  4%  perf-profile.self.cycles-pp.switch_mm_irqs_off
>       0.01 ±223%      +0.2        0.20 ±  7%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.73 ±  2%      +0.2        0.94 ±  2%  perf-profile.self.cycles-pp.folio_unlock
>       0.11 ±  4%      +0.2        0.34        perf-profile.self.cycles-pp.__schedule
>       0.00            +0.3        0.26 ±  4%  perf-profile.self.cycles-pp.available_idle_cpu
>       0.00            +0.3        0.28 ±  7%  perf-profile.self.cycles-pp.intel_idle_irq
>       0.06 ±  6%      +0.3        0.39 ±  4%  perf-profile.self.cycles-pp.update_load_avg
>       0.00            +0.3        0.34 ± 19%  perf-profile.self.cycles-pp.update_sg_lb_stats
>       0.14 ±  2%      +0.4        0.49 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
>       0.00            +0.4        0.38 ±  4%  perf-profile.self.cycles-pp.update_cfs_group
>       0.99            +0.8        1.77        perf-profile.self.cycles-pp.__entry_text_start
>       0.43 ±  2%      +0.9        1.29 ±  3%  perf-profile.self.cycles-pp.fault_in_iov_iter_readable
>       0.00            +1.5        1.54 ±  4%  perf-profile.self.cycles-pp.intel_idle
> 
> 
> ***************************************************************************************************
> lkp-csl-d02: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory
> =========================================================================================
> class/compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
>   pts/gcc-12/performance/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/lkp-csl-d02/io-uring/stress-ng/60s
> 
> commit: 
>   e9833d8701 ("block: mark bdev files as FMODE_NOWAIT if underlying device supports it")
>   caec5ebe77 ("io_uring: rely solely on FMODE_NOWAIT")
> 
> e9833d8701028b5d caec5ebe77f97d948dcf46f07d6 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>    5308533 ±  5%     +47.1%    7808651        cpuidle..usage
>       0.07 ±  2%      +0.0        0.08 ±  4%  mpstat.cpu.all.soft%
>       2.32            +0.4        2.67 ±  2%  mpstat.cpu.all.usr%
>       2803 ±  8%     +20.5%       3378 ±  9%  perf-c2c.DRAM.local
>     296.00 ± 13%     +37.4%     406.67 ± 12%  perf-c2c.HITM.local
>      36.33           +30.3%      47.33        vmstat.procs.r
>     330079           +39.5%     460335        vmstat.system.cs
>     109577            -5.4%     103641        vmstat.system.in
>   10701593            -1.3%   10560464        stress-ng.io-uring.ops
>     178275            -1.3%     175926        stress-ng.io-uring.ops_per_sec
>    1960002          +151.4%    4926804        stress-ng.time.involuntary_context_switches
>       3091            +1.3%       3130        stress-ng.time.percent_of_cpu_this_job_got
>   11661888           +31.4%   15325792        stress-ng.time.voluntary_context_switches
>    4077643 ±  5%     +68.5%    6871201        turbostat.C1
>     605983 ±  2%     -65.1%     211732        turbostat.C1E
>       1.06            -0.7        0.35        turbostat.C1E%
>       9.73 ±  5%     -11.7%       8.59        turbostat.CPU%c1
>     491190 ±  7%     +23.2%     604908 ±  4%  turbostat.POLL
>    1914052           +10.3%    2111343        meminfo.Committed_AS
>     930287           +23.8%    1151328 ±  2%  meminfo.Inactive
>     930123           +23.8%    1151164 ±  2%  meminfo.Inactive(anon)
>      17477           +20.4%      21036        meminfo.KernelStack
>     489503 ±  2%     +27.9%     626186        meminfo.Mapped
>    1070375           +17.6%    1258628        meminfo.Shmem
>      28375           +12.5%      31930        meminfo.VmallocUsed
>      81701            +2.8%      83976        proc-vmstat.nr_anon_pages
>     958569            +4.9%    1005343        proc-vmstat.nr_file_pages
>     231219           +24.5%     287829 ±  2%  proc-vmstat.nr_inactive_anon
>      17489           +20.3%      21036        proc-vmstat.nr_kernel_stack
>     120756           +29.7%     156655        proc-vmstat.nr_mapped
>     267914           +17.5%     314689        proc-vmstat.nr_shmem
>      37175            +2.2%      37996        proc-vmstat.nr_slab_unreclaimable
>     231219           +24.5%     287829 ±  2%  proc-vmstat.nr_zone_inactive_anon
>    2580741            +1.9%    2629260        proc-vmstat.numa_hit
>    2578639            +2.0%    2629404        proc-vmstat.numa_local
>     324060 ±  5%     +20.7%     391137        proc-vmstat.pgactivate
>     305237            +1.8%     310644        proc-vmstat.pgfault
>    8075240            -0.8%    8009939        proc-vmstat.pgfree
>       0.76 ±  7%     +30.5%       0.99 ±  8%  sched_debug.cfs_rq:/.h_nr_running.avg
>       0.51 ± 17%     +41.8%       0.72 ± 12%  sched_debug.cfs_rq:/.h_nr_running.stddev
>     112.29 ±  5%     -19.2%      90.79        sched_debug.cfs_rq:/.load_avg.avg
>       6.83 ± 15%     -26.8%       5.00 ±  8%  sched_debug.cfs_rq:/.load_avg.min
>     190.88 ±  4%     -11.8%     168.40        sched_debug.cfs_rq:/.load_avg.stddev
>      94373 ±  2%     -27.5%      68398 ±  3%  sched_debug.cfs_rq:/.min_vruntime.stddev
>      52.03 ± 12%     -45.9%      28.16        sched_debug.cfs_rq:/.removed.load_avg.avg
>     154.10 ±  5%     -24.7%     116.10        sched_debug.cfs_rq:/.removed.load_avg.stddev
>      16.01 ± 19%     -62.0%       6.09 ± 63%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
>     232.67 ± 15%     -37.1%     146.33 ± 62%  sched_debug.cfs_rq:/.removed.runnable_avg.max
>      53.79 ± 17%     -50.6%      26.59 ± 62%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
>      16.01 ± 19%     -62.0%       6.09 ± 63%  sched_debug.cfs_rq:/.removed.util_avg.avg
>     232.67 ± 15%     -37.2%     146.17 ± 62%  sched_debug.cfs_rq:/.removed.util_avg.max
>      53.78 ± 17%     -50.6%      26.57 ± 62%  sched_debug.cfs_rq:/.removed.util_avg.stddev
>    -139143           -66.4%     -46818        sched_debug.cfs_rq:/.spread0.avg
>      15031 ± 61%    +589.4%     103628 ± 21%  sched_debug.cfs_rq:/.spread0.max
>    -276846           -19.9%    -221798        sched_debug.cfs_rq:/.spread0.min
>      94452 ±  2%     -27.5%      68458 ±  3%  sched_debug.cfs_rq:/.spread0.stddev
>     172.17 ± 23%     -30.0%     120.50 ±  7%  sched_debug.cfs_rq:/.util_avg.min
>     544.17 ±  7%     +31.2%     714.00 ± 15%  sched_debug.cfs_rq:/.util_est_enqueued.max
>     237021 ±  4%     -10.9%     211258        sched_debug.cpu.avg_idle.avg
>       2.78 ±  5%     +29.6%       3.61 ± 10%  sched_debug.cpu.clock.stddev
>       4017 ±  3%     +29.7%       5209 ±  2%  sched_debug.cpu.curr->pid.avg
>       6035           +13.2%       6830        sched_debug.cpu.curr->pid.max
>       0.77 ±  5%     +32.9%       1.03 ± 11%  sched_debug.cpu.nr_running.avg
>       0.53 ±  9%     +37.2%       0.73 ±  8%  sched_debug.cpu.nr_running.stddev
>     288481           +38.4%     399165        sched_debug.cpu.nr_switches.avg
>     506142 ±  3%     +10.8%     560658        sched_debug.cpu.nr_switches.max
>     145805 ±  7%     +73.9%     253621        sched_debug.cpu.nr_switches.min
>      95935 ±  4%     +10.7%     106211 ±  2%  sched_debug.cpu.nr_switches.stddev
>      56.54            -3.0%      54.84        perf-stat.i.MPKI
>  2.414e+09            +5.0%  2.534e+09        perf-stat.i.branch-instructions
>       1.04            +0.1        1.10        perf-stat.i.branch-miss-rate%
>   26162111           +10.3%   28862610        perf-stat.i.branch-misses
>     344022           +38.8%     477562        perf-stat.i.context-switches
>      60948 ±  3%     +46.8%      89481        perf-stat.i.cpu-migrations
>       0.48            -0.0        0.45 ±  3%  perf-stat.i.dTLB-load-miss-rate%
>   20160713            -3.8%   19400778 ±  3%  perf-stat.i.dTLB-load-misses
>  4.188e+09            +2.3%  4.284e+09        perf-stat.i.dTLB-loads
>       0.51            -0.0        0.49        perf-stat.i.dTLB-store-miss-rate%
>   3.15e+09            +2.1%  3.215e+09        perf-stat.i.dTLB-stores
>      64.08           -10.0       54.11        perf-stat.i.iTLB-load-miss-rate%
>    2679077            +9.0%    2919839        perf-stat.i.iTLB-load-misses
>    1395424 ±  3%     +55.8%    2174067        perf-stat.i.iTLB-loads
>  1.535e+10            +3.2%  1.583e+10        perf-stat.i.instructions
>       6665            -3.4%       6438        perf-stat.i.instructions-per-iTLB-miss
>       0.16            +2.5%       0.17        perf-stat.i.ipc
>     539.48            +3.0%     555.91        perf-stat.i.metric.K/sec
>     299.70            +2.5%     307.28        perf-stat.i.metric.M/sec
>       2813            +4.2%       2931        perf-stat.i.minor-faults
>       2813            +4.2%       2932        perf-stat.i.page-faults
>      55.86            -3.2%      54.07        perf-stat.overall.MPKI
>       1.09            +0.0        1.13        perf-stat.overall.branch-miss-rate%
>       8.09            -1.7%       7.95        perf-stat.overall.cpi
>     237.89            +1.1%     240.44        perf-stat.overall.cycles-between-cache-misses
>       0.48            -0.0        0.45 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
>       0.52            -0.0        0.50        perf-stat.overall.dTLB-store-miss-rate%
>      65.75            -8.5       57.25        perf-stat.overall.iTLB-load-miss-rate%
>       5739            -5.3%       5437        perf-stat.overall.instructions-per-iTLB-miss
>       0.12            +1.7%       0.13        perf-stat.overall.ipc
>  2.377e+09            +4.6%  2.486e+09        perf-stat.ps.branch-instructions
>   25873412            +8.4%   28037995        perf-stat.ps.branch-misses
>     338522           +38.8%     470012        perf-stat.ps.context-switches
>  1.223e+11            +1.1%  1.236e+11        perf-stat.ps.cpu-cycles
>      59954 ±  3%     +46.8%      87990        perf-stat.ps.cpu-migrations
>   19842577            -3.6%   19121495 ±  3%  perf-stat.ps.dTLB-load-misses
>  4.123e+09            +2.1%  4.209e+09        perf-stat.ps.dTLB-loads
>  3.101e+09            +2.0%  3.163e+09        perf-stat.ps.dTLB-stores
>    2634058 ±  2%      +8.5%    2858568        perf-stat.ps.iTLB-load-misses
>    1372598 ±  3%     +55.5%    2134390        perf-stat.ps.iTLB-loads
>  1.511e+10            +2.8%  1.554e+10        perf-stat.ps.instructions
>       2758            +3.5%       2855        perf-stat.ps.minor-faults
>       2758            +3.5%       2856        perf-stat.ps.page-faults
>  9.489e+11            +2.3%  9.704e+11        perf-stat.total.instructions
>       0.02 ± 34%     -36.7%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages.__kmalloc_large_node.__kmalloc.iovec_from_user
>       0.00 ±141%   +1200.0%       0.01 ± 66%  perf-sched.sch_delay.avg.ms.__cond_resched.__alloc_pages_bulk.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
>       0.02 ±  3%     -47.8%       0.01        perf-sched.sch_delay.avg.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
>       0.00 ± 10%     +50.0%       0.01        perf-sched.sch_delay.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.security_task_alloc.copy_process
>       0.00 ± 40%     -75.0%       0.00 ±141%  perf-sched.sch_delay.avg.ms.__cond_resched.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
>       0.00 ± 12%     +45.5%       0.01 ±  8%  perf-sched.sch_delay.avg.ms.__cond_resched.cgroup_css_set_fork.cgroup_can_fork.copy_process.create_io_thread
>       0.08 ±  7%    +111.1%       0.18 ± 17%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write.generic_file_write_iter.io_write.io_issue_sqe
>       0.02 ± 87%    +710.0%       0.16 ± 53%  perf-sched.sch_delay.avg.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>       0.01 ± 93%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
>       0.01 ±  7%    -100.0%       0.00        perf-sched.sch_delay.avg.ms.__cond_resched.filemap_read.io_read.io_issue_sqe.io_submit_sqes
>       0.02 ±  2%     -53.7%       0.01 ±  4%  perf-sched.sch_delay.avg.ms.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write
>       0.02 ± 15%    +910.6%       0.16 ±  9%  perf-sched.sch_delay.avg.ms.__cond_resched.io_assign_current_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>       0.08 ± 13%    +197.3%       0.22 ± 15%  perf-sched.sch_delay.avg.ms.__cond_resched.io_write.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
>       0.03 ±  4%     -47.3%       0.02 ± 25%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.01 ±130%    +861.5%       0.12 ±100%  perf-sched.sch_delay.avg.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>       0.04 ± 32%     -69.2%       0.01 ± 32%  perf-sched.sch_delay.avg.ms.__cond_resched.task_work_run.io_run_task_work.io_cqring_wait.__do_sys_io_uring_enter
>       0.02 ± 29%     -63.1%       0.01 ± 71%  perf-sched.sch_delay.avg.ms.__cond_resched.tctx_task_work.task_work_run.get_signal.arch_do_signal_or_restart
>       0.03 ±  8%     -47.1%       0.02 ± 22%  perf-sched.sch_delay.avg.ms.__cond_resched.tctx_task_work.task_work_run.io_run_task_work.io_cqring_wait
>       0.26 ± 51%     -71.4%       0.08 ±112%  perf-sched.sch_delay.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       0.02          +138.6%       0.05 ±  2%  perf-sched.sch_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       0.03 ± 27%     +66.2%       0.04 ±  9%  perf-sched.sch_delay.avg.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       0.02 ±  7%     -46.3%       0.01 ± 12%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       0.47 ± 87%     -95.7%       0.02 ±141%  perf-sched.sch_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork
>       0.02           -25.9%       0.01 ±  3%  perf-sched.sch_delay.avg.ms.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.02 ±  2%    +145.8%       0.05        perf-sched.sch_delay.avg.ms.schedule_timeout.io_wq_worker.ret_from_fork.[unknown]
>       0.02 ±  2%      +8.2%       0.02 ±  2%  perf-sched.sch_delay.avg.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       0.02           +13.3%       0.02        perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>       0.18 ± 75%     -82.7%       0.03 ± 27%  perf-sched.sch_delay.avg.ms.syslog_print.do_syslog.kmsg_read.vfs_read
>       0.61 ± 53%     -91.4%       0.05 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages.__kmalloc_large_node.__kmalloc.iovec_from_user
>       0.00 ±141%    +600.0%       0.01 ± 61%  perf-sched.sch_delay.max.ms.__cond_resched.__alloc_pages_bulk.__vmalloc_area_node.__vmalloc_node_range.alloc_thread_stack_node
>       2.52           +42.4%       3.59 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
>       0.01 ± 22%     -82.4%       0.00 ±141%  perf-sched.sch_delay.max.ms.__cond_resched.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
>       1.09 ±  9%     +57.3%       1.71 ± 16%  perf-sched.sch_delay.max.ms.__cond_resched.down_write.generic_file_write_iter.io_write.io_issue_sqe
>       0.03 ± 38%   +1632.3%       0.57 ±115%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.do_madvise.io_madvise.io_issue_sqe
>       0.12 ±109%    +914.7%       1.17 ± 77%  perf-sched.sch_delay.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>       0.02 ± 99%    -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.dput.step_into.open_last_lookups.path_openat
>       1.59          -100.0%       0.00        perf-sched.sch_delay.max.ms.__cond_resched.filemap_read.io_read.io_issue_sqe.io_submit_sqes
>       2.17 ± 47%    +101.3%       4.36 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.io_assign_current_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>       1.60 ± 20%     +33.6%       2.14 ± 13%  perf-sched.sch_delay.max.ms.__cond_resched.io_write.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
>       0.01 ±121%   +5431.7%       0.76 ±122%  perf-sched.sch_delay.max.ms.__cond_resched.stop_one_cpu.sched_exec.bprm_execve.part
>       1.08 ± 23%     -84.6%       0.17 ± 98%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.io_run_task_work.io_cqring_wait.__do_sys_io_uring_enter
>       0.59 ± 65%    +224.4%       1.91        perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.io_run_task_work.io_wq_worker.ret_from_fork
>       0.47 ± 53%     -71.3%       0.14 ±117%  perf-sched.sch_delay.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
>       0.34 ± 66%    +164.2%       0.89 ± 45%  perf-sched.sch_delay.max.ms.do_wait.kernel_wait4.__do_sys_wait4.do_syscall_64
>       3.51 ± 39%     -38.6%       2.16 ±  8%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
>       2.25 ± 23%     -49.3%       1.14 ± 32%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       0.72 ± 70%     -97.2%       0.02 ±141%  perf-sched.sch_delay.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.ret_from_fork
>       4.80 ± 10%    +267.2%      17.64 ± 47%  perf-sched.sch_delay.max.ms.smpboot_thread_fn.kthread.ret_from_fork
>       0.33 ± 81%     -86.6%       0.04 ± 22%  perf-sched.sch_delay.max.ms.syslog_print.do_syslog.kmsg_read.vfs_read
>       0.02 ±  2%     +76.4%       0.03        perf-sched.total_sch_delay.average.ms
>    1308716           +33.8%    1750883        perf-sched.total_wait_and_delay.count.ms
>       4.99 ± 27%     -67.9%       1.60 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
>       0.39 ±  5%     -62.2%       0.15 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
>       0.05 ±  4%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.filemap_read.io_read.io_issue_sqe.io_submit_sqes
>       0.37           -64.3%       0.13 ±  3%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write
>       3.55 ± 14%     -60.6%       1.40 ± 14%  perf-sched.wait_and_delay.avg.ms.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
>       0.13 ± 16%     +67.2%       0.22 ±  5%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       0.78 ± 71%    +243.6%       2.69 ± 42%  perf-sched.wait_and_delay.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       1.01           +13.5%       1.14        perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_wq_worker.ret_from_fork.[unknown]
>       1.89 ±  2%     +81.3%       3.43 ±  5%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>      91.67 ±  7%    +124.4%     205.67 ±  5%  perf-sched.wait_and_delay.count.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
>      34911           +15.9%      40453 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
>      32972          -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.filemap_read.io_read.io_issue_sqe.io_submit_sqes
>      41032            +9.7%      45024 ±  3%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write
>     283.67 ±  7%    +158.3%     732.67 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
>     181.00 ± 10%     +37.8%     249.33 ±  2%  perf-sched.wait_and_delay.count.__cond_resched.mutex_lock.perf_poll.do_poll.constprop
>      57633           -24.2%      43664        perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>     463.33           +17.0%     542.00 ±  3%  perf-sched.wait_and_delay.count.do_task_dead.do_exit.io_wq_worker.ret_from_fork
>       3110 ±  9%     -74.2%     803.00 ± 70%  perf-sched.wait_and_delay.count.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_reschedule_ipi
>     476298           +30.4%     621321        perf-sched.wait_and_delay.count.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>     543784           +64.9%     896929        perf-sched.wait_and_delay.count.schedule_timeout.io_wq_worker.ret_from_fork.[unknown]
>     107418           -42.9%      61300 ±  4%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork
>       4.37 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.filemap_read.io_read.io_issue_sqe.io_submit_sqes
>      13.48 ± 16%     +44.0%      19.41 ± 23%  perf-sched.wait_and_delay.max.ms.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>     248.34 ± 18%     +22.5%     304.33 ±  7%  perf-sched.wait_and_delay.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>       4.99 ± 27%     -67.9%       1.60 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio
>       0.00 ±141%  +13030.0%       0.44 ±134%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__get_free_pages.__pollwait.perf_poll
>       0.05 ± 16%    +748.4%       0.43 ±  7%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.__kmalloc_large_node.__kmalloc.iovec_from_user
>       0.01 ± 36%     -83.3%       0.00 ±141%  perf-sched.wait_time.avg.ms.__cond_resched.__alloc_pages.allocate_slab.___slab_alloc.constprop
>       0.37 ±  6%     -63.2%       0.14 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
>       0.04 ±  9%    +518.0%       0.25        perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.__kmalloc.io_alloc_async_data.io_setup_async_rw
>       0.01 ± 35%     +63.9%       0.02 ± 34%  perf-sched.wait_time.avg.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.perf_event_mmap_event.perf_event_mmap
>       0.01 ± 14%     -60.0%       0.00 ± 86%  perf-sched.wait_time.avg.ms.__cond_resched.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
>       0.00 ± 70%   +9200.0%       0.31 ±136%  perf-sched.wait_time.avg.ms.__cond_resched.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.rep_movs_alternative
>       0.50 ±  8%     +42.8%       0.72 ± 25%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.generic_file_write_iter.io_write.io_issue_sqe
>       0.01 ± 36%   +2067.9%       0.20 ± 77%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.mmap_region.do_mmap.vm_mmap_pgoff
>       0.07 ±107%    +667.1%       0.57 ± 60%  perf-sched.wait_time.avg.ms.__cond_resched.down_write_killable.do_madvise.io_madvise.io_issue_sqe
>       0.05 ±  4%    -100.0%       0.00        perf-sched.wait_time.avg.ms.__cond_resched.filemap_read.io_read.io_issue_sqe.io_submit_sqes
>       0.35           -64.9%       0.12 ±  3%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write
>       3.55 ± 14%     -60.6%       1.40 ± 14%  perf-sched.wait_time.avg.ms.__cond_resched.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
>       0.71 ± 13%     +85.8%       1.32 ±  4%  perf-sched.wait_time.avg.ms.__cond_resched.io_assign_current_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>       0.61 ±  6%     -59.2%       0.25 ± 17%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.io_run_task_work.io_cqring_wait.__do_sys_io_uring_enter
>       0.32 ± 20%     -51.1%       0.15 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.task_work_run.io_run_task_work.io_wq_worker.ret_from_fork
>       0.80 ±  2%     -35.3%       0.52 ±  5%  perf-sched.wait_time.avg.ms.__cond_resched.tctx_task_work.task_work_run.io_run_task_work.io_cqring_wait
>       0.02 ± 50%     -55.6%       0.01 ± 20%  perf-sched.wait_time.avg.ms.__cond_resched.unmap_vmas.unmap_region.do_vmi_align_munmap.do_vmi_munmap
>       0.12 ± 18%     +54.6%       0.18 ±  6%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
>       1.60 ± 90%     -69.3%       0.49 ±  4%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>       1.06 ± 16%    +153.8%       2.68 ± 42%  perf-sched.wait_time.avg.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
>       0.99           +11.0%       1.10        perf-sched.wait_time.avg.ms.schedule_timeout.io_wq_worker.ret_from_fork.[unknown]
>       1.88 ±  2%     +81.8%       3.41 ±  5%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork
>       0.00 ±141%  +25270.0%       0.85 ±137%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.__get_free_pages.__pollwait.perf_poll
>       0.01 ± 46%     -85.7%       0.00 ±141%  perf-sched.wait_time.max.ms.__cond_resched.__alloc_pages.allocate_slab.___slab_alloc.constprop
>       1.75 ± 14%     -47.4%       0.92 ± 70%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.create_io_worker.create_worker_cb
>       0.02 ± 29%     -70.6%       0.01 ±141%  perf-sched.wait_time.max.ms.__cond_resched.__kmem_cache_alloc_node.kmalloc_trace.single_open.do_dentry_open
>       0.01 ± 37%     -72.2%       0.00 ± 86%  perf-sched.wait_time.max.ms.__cond_resched.alloc_vmap_area.__get_vm_area_node.__vmalloc_node_range.alloc_thread_stack_node
>       1.70 ±  4%    +154.4%       4.34 ± 20%  perf-sched.wait_time.max.ms.__cond_resched.down_write.generic_file_write_iter.io_write.io_issue_sqe
>       1.62 ±131%    +378.9%       7.78 ± 55%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.do_madvise.io_madvise.io_issue_sqe
>       0.01 ± 35%    +240.0%       0.03 ± 40%  perf-sched.wait_time.max.ms.__cond_resched.down_write_killable.exec_mmap.begin_new_exec.load_elf_binary
>       3.65 ±  4%    -100.0%       0.00        perf-sched.wait_time.max.ms.__cond_resched.filemap_read.io_read.io_issue_sqe.io_submit_sqes
>       3.11           +16.4%       3.62 ± 10%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       2.93 ± 20%     -29.1%       2.08 ± 24%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.io_run_task_work.io_cqring_wait.__do_sys_io_uring_enter
>       1.70 ± 45%    +262.6%       6.16 ± 42%  perf-sched.wait_time.max.ms.__cond_resched.task_work_run.io_run_task_work.io_wq_worker.ret_from_fork
>     336.28 ±139%     -99.5%       1.66 ±  6%  perf-sched.wait_time.max.ms.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
>       9.76 ± 14%     +42.5%      13.91 ±  9%  perf-sched.wait_time.max.ms.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>     248.32 ± 18%     +22.6%     304.32 ±  7%  perf-sched.wait_time.max.ms.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
>      22.65           -22.6        0.00        perf-profile.calltrace.cycles-pp.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>      22.38           -22.4        0.00        perf-profile.calltrace.cycles-pp.io_read.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64
>      22.10           -22.1        0.00        perf-profile.calltrace.cycles-pp.filemap_read.io_read.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter
>      23.44           -21.9        1.49        perf-profile.calltrace.cycles-pp.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>      24.49           -21.9        2.55        perf-profile.calltrace.cycles-pp.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>      24.59           -21.9        2.66        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.syscall
>      24.57           -21.9        2.64        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.syscall
>      25.54           -21.9        3.67        perf-profile.calltrace.cycles-pp.syscall
>      21.27           -21.3        0.00        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.io_read.io_issue_sqe.io_submit_sqes
>       5.56            -0.8        4.74 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
>       5.56            -0.8        4.74 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
>       5.73            -0.8        4.93 ±  2%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       1.47 ±  2%      -0.8        0.71 ± 34%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
>       6.21            -0.7        5.53 ±  2%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       6.21            -0.7        5.54 ±  2%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
>       6.21            -0.7        5.54 ±  2%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
>       6.23            -0.6        5.59 ±  2%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
>       0.64            -0.1        0.58 ±  4%  perf-profile.calltrace.cycles-pp.filemap_get_entry.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write
>       0.80 ±  2%      -0.1        0.75 ±  3%  perf-profile.calltrace.cycles-pp.simple_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.io_write
>       0.76 ±  2%      -0.0        0.72 ±  4%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.pagecache_get_page.simple_write_begin.generic_perform_write.__generic_file_write_iter
>       0.78            -0.0        0.73 ±  3%  perf-profile.calltrace.cycles-pp.pagecache_get_page.simple_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
>       0.58 ±  5%      -0.0        0.54 ±  5%  perf-profile.calltrace.cycles-pp.filemap_get_read_batch.filemap_get_pages.filemap_read.io_read.io_issue_sqe
>       3.68            +0.2        3.84 ±  2%  perf-profile.calltrace.cycles-pp.intel_idle_irq.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
>       0.75 ±  4%      +0.3        1.06        perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.io_wq_worker.ret_from_fork
>       0.78 ±  3%      +0.3        1.10        perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.io_wq_worker.ret_from_fork
>       0.97 ±  4%      +0.4        1.41        perf-profile.calltrace.cycles-pp.schedule_timeout.io_wq_worker.ret_from_fork
>       0.00            +0.5        0.52        perf-profile.calltrace.cycles-pp.io_queue_iowq.io_queue_async.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64
>       0.00            +0.5        0.53        perf-profile.calltrace.cycles-pp.io_queue_async.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
>       0.00            +0.6        0.56 ±  5%  perf-profile.calltrace.cycles-pp.filemap_get_pages.filemap_read.io_read.io_issue_sqe.io_wq_submit_work
>       0.00            +0.7        0.69        perf-profile.calltrace.cycles-pp.try_to_wake_up.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.io_issue_sqe
>       0.00            +0.7        0.70        perf-profile.calltrace.cycles-pp.autoremove_wake_function.__wake_up_common.__wake_up_common_lock.io_issue_sqe.io_wq_submit_work
>       0.00            +0.7        0.73        perf-profile.calltrace.cycles-pp.__wake_up_common.__wake_up_common_lock.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
>       0.00            +0.7        0.74        perf-profile.calltrace.cycles-pp.__wake_up_common_lock.io_issue_sqe.io_wq_submit_work.io_worker_handle_work.io_wq_worker
>       0.00           +21.2       21.19        perf-profile.calltrace.cycles-pp.copy_page_to_iter.filemap_read.io_read.io_issue_sqe.io_wq_submit_work
>       0.00           +22.0       21.98        perf-profile.calltrace.cycles-pp.filemap_read.io_read.io_issue_sqe.io_wq_submit_work.io_worker_handle_work
>      63.41           +22.0       85.44        perf-profile.calltrace.cycles-pp.io_issue_sqe.io_wq_submit_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>      63.43           +22.0       85.46        perf-profile.calltrace.cycles-pp.io_wq_submit_work.io_worker_handle_work.io_wq_worker.ret_from_fork
>       0.00           +22.1       22.06        perf-profile.calltrace.cycles-pp.io_read.io_issue_sqe.io_wq_submit_work.io_worker_handle_work.io_wq_worker
>      63.60           +22.1       85.71        perf-profile.calltrace.cycles-pp.io_worker_handle_work.io_wq_worker.ret_from_fork
>      64.83           +22.5       87.33        perf-profile.calltrace.cycles-pp.ret_from_fork
>      64.64           +22.6       87.22        perf-profile.calltrace.cycles-pp.io_wq_worker.ret_from_fork
>      24.80           -22.0        2.84        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
>      24.78           -22.0        2.82        perf-profile.children.cycles-pp.do_syscall_64
>      23.44           -21.9        1.49        perf-profile.children.cycles-pp.io_submit_sqes
>      24.49           -21.9        2.55        perf-profile.children.cycles-pp.__do_sys_io_uring_enter
>      25.59           -21.9        3.70        perf-profile.children.cycles-pp.syscall
>       5.57            -0.8        4.78 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter
>       5.57            -0.8        4.78 ±  2%  perf-profile.children.cycles-pp.cpuidle_enter_state
>       5.74            -0.8        4.97 ±  2%  perf-profile.children.cycles-pp.cpuidle_idle_call
>       0.88 ±  5%      -0.7        0.15        perf-profile.children.cycles-pp.intel_idle
>       6.21            -0.7        5.54 ±  2%  perf-profile.children.cycles-pp.start_secondary
>       6.22            -0.6        5.58 ±  2%  perf-profile.children.cycles-pp.do_idle
>       6.23            -0.6        5.59 ±  2%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
>       6.23            -0.6        5.59 ±  2%  perf-profile.children.cycles-pp.cpu_startup_entry
>      48.82            -0.4       48.39        perf-profile.children.cycles-pp.rep_movs_alternative
>       0.74 ±  2%      -0.3        0.49        perf-profile.children.cycles-pp.newidle_balance
>       1.65 ±  2%      -0.2        1.40        perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
>       0.66 ±  2%      -0.2        0.43        perf-profile.children.cycles-pp.load_balance
>       0.46 ±  4%      -0.2        0.23 ±  2%  perf-profile.children.cycles-pp.find_busiest_group
>       0.44 ±  3%      -0.2        0.23        perf-profile.children.cycles-pp.update_sd_lb_stats
>       0.37 ±  4%      -0.2        0.19        perf-profile.children.cycles-pp.update_sg_lb_stats
>       0.83            -0.1        0.69 ±  2%  perf-profile.children.cycles-pp.pick_next_task_fair
>       0.18 ±  5%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.kthread
>       0.17 ±  2%      -0.1        0.10 ±  4%  perf-profile.children.cycles-pp.smpboot_thread_fn
>       0.64            -0.1        0.59 ±  4%  perf-profile.children.cycles-pp.filemap_get_entry
>       0.80 ±  2%      -0.1        0.75 ±  3%  perf-profile.children.cycles-pp.simple_write_begin
>       0.59 ±  4%      -0.0        0.54 ±  5%  perf-profile.children.cycles-pp.filemap_get_read_batch
>       0.78            -0.0        0.73 ±  3%  perf-profile.children.cycles-pp.pagecache_get_page
>       0.77            -0.0        0.72 ±  3%  perf-profile.children.cycles-pp.__filemap_get_folio
>       0.60 ±  4%      -0.0        0.56 ±  5%  perf-profile.children.cycles-pp.filemap_get_pages
>       0.06 ±  7%      -0.0        0.03 ± 70%  perf-profile.children.cycles-pp.cpu_stop_queue_work
>       0.11            -0.0        0.08        perf-profile.children.cycles-pp.clock_nanosleep
>       0.08            -0.0        0.05        perf-profile.children.cycles-pp.do_nanosleep
>       0.09 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.__x64_sys_clock_nanosleep
>       0.08 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.hrtimer_nanosleep
>       0.14 ±  6%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__kmalloc
>       0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.common_nsleep
>       0.07            -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.update_blocked_averages
>       0.07 ±  6%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.io_prep_async_link
>       0.05            +0.0        0.07 ± 14%  perf-profile.children.cycles-pp.switch_fpu_return
>       0.13            +0.0        0.15 ±  3%  perf-profile.children.cycles-pp.menu_select
>       0.07            +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
>       0.06 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp.check_preempt_curr
>       0.05            +0.0        0.07        perf-profile.children.cycles-pp.__smp_call_single_queue
>       0.07 ±  7%      +0.0        0.09 ± 10%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
>       0.05 ±  8%      +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.update_cfs_group
>       0.12 ±  8%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__cond_resched
>       0.05 ±  8%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__update_load_avg_se
>       0.06 ±  8%      +0.0        0.08        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
>       0.05            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.__timer_delete_sync
>       0.05            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.detach_tasks
>       0.03 ± 70%      +0.0        0.06        perf-profile.children.cycles-pp.update_rq_clock_task
>       0.07 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.__switch_to
>       0.07 ±  7%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.lock_timer_base
>       0.07            +0.0        0.10        perf-profile.children.cycles-pp.ttwu_queue_wakelist
>       0.13 ±  3%      +0.0        0.16 ±  5%  perf-profile.children.cycles-pp.___perf_sw_event
>       0.03 ± 70%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.llist_add_batch
>       0.03 ± 70%      +0.0        0.07        perf-profile.children.cycles-pp.__try_to_del_timer_sync
>       0.03 ± 70%      +0.0        0.07        perf-profile.children.cycles-pp.set_next_entity
>       0.10 ±  4%      +0.0        0.14        perf-profile.children.cycles-pp.select_idle_cpu
>       0.10            +0.0        0.14        perf-profile.children.cycles-pp.switch_mm_irqs_off
>       0.02 ±141%      +0.0        0.06 ±  8%  perf-profile.children.cycles-pp.io_wq_free_work
>       0.04 ± 71%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.sched_mm_cid_migrate_to
>       0.02 ±141%      +0.0        0.06        perf-profile.children.cycles-pp.reweight_entity
>       0.10 ±  4%      +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__mod_timer
>       0.05            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.task_h_load
>       0.08 ± 10%      +0.0        0.13 ±  3%  perf-profile.children.cycles-pp.available_idle_cpu
>       0.02 ±141%      +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.enqueue_timer
>       0.00            +0.1        0.05        perf-profile.children.cycles-pp.put_prev_entity
>       0.09 ±  5%      +0.1        0.14 ±  3%  perf-profile.children.cycles-pp.prepare_task_switch
>       0.18 ±  4%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.dequeue_entity
>       0.10 ±  9%      +0.1        0.15 ±  5%  perf-profile.children.cycles-pp.__switch_to_asm
>       0.08 ±  6%      +0.1        0.13 ±  3%  perf-profile.children.cycles-pp.wake_affine
>       0.14 ±  6%      +0.1        0.20 ±  2%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
>       0.16 ±  2%      +0.1        0.23 ±  2%  perf-profile.children.cycles-pp.select_idle_sibling
>       0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.io_wq_worker_running
>       0.14 ±  5%      +0.1        0.21        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
>       0.18 ±  2%      +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.update_curr
>       0.19            +0.1        0.26 ±  6%  perf-profile.children.cycles-pp.sched_ttwu_pending
>       0.10 ±  4%      +0.1        0.17 ±  2%  perf-profile.children.cycles-pp.io_clean_op
>       0.14 ±  3%      +0.1        0.22 ±  2%  perf-profile.children.cycles-pp.io_free_req_tw
>       0.26            +0.1        0.35 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock
>       0.25            +0.1        0.33 ±  2%  perf-profile.children.cycles-pp.update_load_avg
>       0.26            +0.1        0.35 ±  2%  perf-profile.children.cycles-pp.dequeue_task_fair
>       0.20            +0.1        0.29        perf-profile.children.cycles-pp.enqueue_entity
>       1.56 ±  2%      +0.1        1.65        perf-profile.children.cycles-pp.schedule
>       0.20 ±  2%      +0.1        0.30 ±  5%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
>       1.83            +0.1        1.93        perf-profile.children.cycles-pp.__schedule
>       0.21 ±  2%      +0.1        0.32 ±  2%  perf-profile.children.cycles-pp.tctx_task_work
>       0.28            +0.1        0.40        perf-profile.children.cycles-pp.io_run_task_work
>       0.26            +0.1        0.38        perf-profile.children.cycles-pp.task_work_run
>       0.31            +0.1        0.44 ±  2%  perf-profile.children.cycles-pp.enqueue_task_fair
>       0.28 ±  2%      +0.2        0.43        perf-profile.children.cycles-pp.select_task_rq_fair
>       0.37            +0.2        0.53 ±  3%  perf-profile.children.cycles-pp.activate_task
>       0.32 ±  3%      +0.2        0.48        perf-profile.children.cycles-pp.select_task_rq
>       0.40            +0.2        0.58 ±  2%  perf-profile.children.cycles-pp.ttwu_do_activate
>       0.34 ±  3%      +0.2        0.53        perf-profile.children.cycles-pp.io_queue_async
>       0.44 ±  3%      +0.3        0.70        perf-profile.children.cycles-pp.autoremove_wake_function
>       0.46 ±  3%      +0.3        0.73        perf-profile.children.cycles-pp.__wake_up_common
>       0.48            +0.3        0.74        perf-profile.children.cycles-pp.__wake_up_common_lock
>       0.55 ±  3%      +0.3        0.85        perf-profile.children.cycles-pp.io_wq_enqueue
>       0.50 ±  3%      +0.3        0.82        perf-profile.children.cycles-pp.io_wq_activate_free_worker
>       0.62 ±  3%      +0.3        0.94        perf-profile.children.cycles-pp.io_queue_iowq
>       0.98 ±  4%      +0.4        1.42        perf-profile.children.cycles-pp.schedule_timeout
>       1.00 ±  2%      +0.5        1.53        perf-profile.children.cycles-pp.try_to_wake_up
>      63.43           +22.0       85.46        perf-profile.children.cycles-pp.io_wq_submit_work
>      63.60           +22.1       85.71        perf-profile.children.cycles-pp.io_worker_handle_work
>      64.83           +22.5       87.33        perf-profile.children.cycles-pp.ret_from_fork
>      64.64           +22.6       87.22        perf-profile.children.cycles-pp.io_wq_worker
>       0.88 ±  5%      -0.7        0.15        perf-profile.self.cycles-pp.intel_idle
>      48.22            -0.4       47.81        perf-profile.self.cycles-pp.rep_movs_alternative
>       0.31 ±  6%      -0.2        0.15 ±  3%  perf-profile.self.cycles-pp.update_sg_lb_stats
>       0.46 ±  3%      -0.1        0.40 ±  7%  perf-profile.self.cycles-pp.filemap_get_entry
>       0.52 ±  5%      -0.0        0.48 ±  6%  perf-profile.self.cycles-pp.filemap_get_read_batch
>       0.51            -0.0        0.49        perf-profile.self.cycles-pp.copyout
>       0.25 ±  3%      -0.0        0.23 ±  3%  perf-profile.self.cycles-pp.__ordered_events__flush
>       0.07 ±  7%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.ordered_events__queue
>       0.06            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.io_prep_async_link
>       0.05 ±  8%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.enqueue_task_fair
>       0.10 ±  4%      +0.0        0.12 ±  4%  perf-profile.self.cycles-pp.update_curr
>       0.05            +0.0        0.07        perf-profile.self.cycles-pp.update_cfs_group
>       0.07 ±  7%      +0.0        0.09 ±  5%  perf-profile.self.cycles-pp.__switch_to
>       0.06 ±  8%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.tctx_task_work
>       0.06 ±  8%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
>       0.05            +0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_se
>       0.03 ± 70%      +0.0        0.06        perf-profile.self.cycles-pp.finish_task_switch
>       0.11 ±  4%      +0.0        0.14 ±  6%  perf-profile.self.cycles-pp.___perf_sw_event
>       0.03 ± 70%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.llist_add_batch
>       0.03 ± 70%      +0.0        0.07 ±  7%  perf-profile.self.cycles-pp.select_task_rq_fair
>       0.10            +0.0        0.14        perf-profile.self.cycles-pp.switch_mm_irqs_off
>       0.04 ± 71%      +0.0        0.08 ±  6%  perf-profile.self.cycles-pp.sched_mm_cid_migrate_to
>       0.07 ± 14%      +0.0        0.11        perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
>       0.13            +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.update_load_avg
>       0.08 ±  6%      +0.0        0.12 ±  3%  perf-profile.self.cycles-pp.available_idle_cpu
>       0.05            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.task_h_load
>       0.02 ±141%      +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.enqueue_timer
>       0.00            +0.1        0.05        perf-profile.self.cycles-pp.pick_next_task_fair
>       0.10 ±  9%      +0.1        0.15 ±  5%  perf-profile.self.cycles-pp.__switch_to_asm
>       0.21 ±  2%      +0.1        0.26 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
>       0.00            +0.1        0.06 ±  8%  perf-profile.self.cycles-pp.prepare_task_switch
>       0.08 ± 10%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.try_to_wake_up
>       0.14 ±  3%      +0.1        0.21 ±  6%  perf-profile.self.cycles-pp.__schedule
>       0.00            +0.1        0.07 ±  7%  perf-profile.self.cycles-pp.io_wq_worker_running
>       0.14 ±  5%      +0.1        0.21        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
>       0.00            +0.1        0.07 ±  6%  perf-profile.self.cycles-pp.enqueue_entity
> 
> 
> 
> Disclaimer:
> Results have been estimated based on internal Intel analysis and are provided
> for informational purposes only. Any difference in system hardware or software
> design or configuration may affect actual performance.
> 
> 
