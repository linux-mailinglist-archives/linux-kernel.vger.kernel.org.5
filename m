Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47477A7286
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjITGGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjITGGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:06:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EA19F;
        Tue, 19 Sep 2023 23:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695189986; x=1726725986;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=SofDqkz3jPHE72n+tEv9F32ecmsmmUmluQB5Iymv34k=;
  b=KZhdTlg2GmskiRyT5pJbxZEW5jhOHFOUo1SyrROzUQbmyZxnqAjzlEu/
   JphADfFkSHfYn95USK8kkVjsWZT35jFKD4s+pyBsqbxN8OlKgeM3JJtrk
   94vjlfBD/GKfYy0Q/pJnNZxe6bS3cBHnYkHl783lS7c9J8mh2InfuNj62
   CU9AKz7S4/+urBTwCg5vJDNLE9cv8doDQw9GsYQFPtL5OtmXwtvmSrzWI
   U07M+VsKjuIjFpNKkE9fDAydGZzHxcY2fZ1D5O5KA3qQoW46KrcKrHLzo
   s3xKLsNm4KpCkkbaYcdXhwkI89umxogDtcV7xD9TsP5fJGizviQ6tVDCo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="466450224"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="466450224"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="920149932"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="920149932"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Sep 2023 23:06:25 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 23:06:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 19 Sep 2023 23:06:24 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 19 Sep 2023 23:06:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 19 Sep 2023 23:06:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhXSsr1VffyvlU511omKB8AZb05P/+aktao7Kd86kXvMRbouHBkRsgOrTaA/qOG0XAe+pSHy0FZ9gK+LHyRnDNMNopxSnSazRSBLzmrYGetTV7wn/tMMq8sE0UcVX/MZNRGObjUAzT1SuRYj9FoacKkL7MOY7AWJbLcB9k5W84Ak0gEEeVUGYveZ3gVlMSJTK3ImK4CQF5xT7DjGqoUKkttsNCab63guqkayMmnnIsFFz0Dy/TgD5artUyAb1sOcV8L1+j8RJGp6WOJK5vh1Zz+3pDTgHCGSCg1j0d+qrqnh9qcBTtG8+NDpaW3mHBQUIpDZw3FIIoHCYvDfAoBlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxdzWfVVLHkEfmmZHnM+lsr+EQxwbZure7jzPk8D8iE=;
 b=ONwtOv9LnXVi1VKLXiq4aWzQaqYNi+d8NRK91oL1bBcyKa/puDZtXG/yfV7c4M6o8+lga+KM6HG92saoMNB9lSsUQsr7VBc2RguUIUSCEq8wp4GfNmPGToIEk5lo57KPMPf6UkHPgMz+proXyTmhEZJAsgt0KfrnX5WCt+dR96T3aybuT1mZM+fIEo7d3ewdHkL5BbeGiaBjkRGLtuo6zZ77ecT5vGfaK/ic/UcWSAFTHRPpYcfFKRDGjM2YA3eQEccwI3tnFgLDph8bKOxCXERPOisFbA+dqRf+phkaycygqeh//5vQiWd6eK7Mp0BOd0NFu+MIySWnB7I3Gs+gCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA2PR11MB4876.namprd11.prod.outlook.com (2603:10b6:806:119::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 06:06:16 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::6ecb:9e9a:87e5:f342%4]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 06:06:16 +0000
Date:   Wed, 20 Sep 2023 08:06:09 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        "Babu Moger" <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v5 8/8] selftests/resctrl: Adjust effective L3 cache size
 when SNC enabled
Message-ID: <nchqtx6dp3e2pcp64j7fdeyauarl4funonwkjx3nn5zztgpfw2@2xpb44k52ke6>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-9-tony.luck@intel.com>
 <TYAPR01MB633033C489AAC0E514CBC6688BEEA@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <SJ1PR11MB60839EB5CC3D172D864DF7A7FCEEA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <7gbxb6kxwa6anvcc4dquyuu7yronww6ztelazn2xllplorhbp5@i7o4fum5tjuf>
 <SJ1PR11MB608362BE12F47FFA54381FB9FCFAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SJ1PR11MB608362BE12F47FFA54381FB9FCFAA@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::18) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SA2PR11MB4876:EE_
X-MS-Office365-Filtering-Correlation-Id: 8392d85a-fa44-4e6e-9f28-08dbb99fb333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pN/WVlvzGSJFgaLSK4gCCgT0pHpNhBET8Nuvb1QERXur+zmwSJI5nDZ1/f4gJ1TX60w+CuSv9lgtJI3G2/B+JM61+7nmaY6ItYcYgnCBenWnPHPS2XvybfphtLDgrnNanUuMr4ogInerxusgICHNOWo+GX6HMG4+92k3auqb2CgDOV79anNAd5zm+G/ZZ6qBGQl8+ShK/oLrIQEN/eh/Cy+YiZRNZ3n5MIGDt54ZZIYLotQFmURLUuGHh0ts8lZhxHF5EI1QrSmzmjvd7QOPTyUkSWJEWaX4HnKUGbDcHqKqTH398jpb++yg9FzN2J1k91MBky+JcMFH8VZw9jG0G+cqXdDSsVUX809xdEjpUJc4zvEQlJhmpb5nZaEREqilR4a5uNm/WA+J1kTDU/phByhI6aQIPPukQectzo9w4xTnhcAgLnjSL4qZ5UPhKBXsc3mY/gFNKcHk9cRbbw/8rN4NEQTy1+x2VTtL9gV//pFLmPYqf18Zu1lyDOp1cv6ehDuljg2pCC9t84n0SKh4esrL6+VXW47EztMJihZkaZ+4V1O2BWiH9jwpELMNT6so
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199024)(186009)(1800799009)(2906002)(33716001)(83380400001)(38100700002)(6486002)(86362001)(6512007)(53546011)(6506007)(6666004)(9686003)(478600001)(26005)(6862004)(4326008)(8936002)(8676002)(7416002)(66574015)(41300700001)(5660300002)(6636002)(54906003)(82960400001)(316002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?cUJz4oXDvgKE/kXCOpSxvK+kl0HpCukHTwenID4xdQWktkwv27YF+WpgcQ?=
 =?iso-8859-1?Q?kdW/c7SdTQO68paJIW+cp3iYnKFlegzq7oGEA6RitskVp45k64vKTIrPI4?=
 =?iso-8859-1?Q?yEd5MDUcDOnwhgA9iz9nk6nNlqZFFpk0/tnBVxxsFPlGhzqTg9ryOgGsaK?=
 =?iso-8859-1?Q?zZUc7GeREedKf7QPNOcWAc3OBAFUlIkQhFch4EtcgqsVmee3sl1DM/1BqV?=
 =?iso-8859-1?Q?PBTdTzHGUKT3pfe8q9o4Mms/WOzSDN8qtxkssVZYqneZNi5Ahvf5D8kG1x?=
 =?iso-8859-1?Q?8Dec/wwGfFlwFcVeiTu1CoqovYiCvfzfVTFU/e6BpgoTqYLi0QhrOhb9QX?=
 =?iso-8859-1?Q?ajMAIPUFrdffXe3rWIlxMQA8yzrObikB+JlUpJ9AhPtDcgWwNZPnaS+sWm?=
 =?iso-8859-1?Q?cOnVYb7/KlCynGGlK0EONaLOEVNgpRahabhdjSWLrLL6age+gksYTCtQ6M?=
 =?iso-8859-1?Q?UbcjHFywZ3L3K0pHS2Ph0MTr6ESFmLiw/A+pbMvSxiPqLpUgrxypXXbs4Z?=
 =?iso-8859-1?Q?1Z/cTw19UCFG0xe0+VMKiVQkz++Fev6scFomVSsJ6OJI7d4ImcBSKlnAfO?=
 =?iso-8859-1?Q?899TdVaB+ICSTxfkJc+mctwfBynRL3zYRqW47jfthPeyZ0moGv6/KxK+/n?=
 =?iso-8859-1?Q?2KPwvHHeNclvy5ay+MQF7Z3mgsjH2yuYTgGK0uxi1KafEaFNDgeYUFBsh5?=
 =?iso-8859-1?Q?YACSqQSU0wBEQ4mTU8EK3F7YC1hzx0P18jfSAEpBXegIkQa1sxS/4zR4dv?=
 =?iso-8859-1?Q?kyldBs2WGqqwNq/CJiEa5gr3qA7ovkFdJqfFa7cbcW7/ptFvdzIllY97rM?=
 =?iso-8859-1?Q?kM51u+GLDuTtTcSJOrsg91xh1tCP0Q2KSNKEszZH43s5kiO9GJYjd6CfJe?=
 =?iso-8859-1?Q?6iDpSFtvcVEmw5s0uT8gOBZS/pNM+0xStxFbIv70kM6PinGDGSuK2ZNYMQ?=
 =?iso-8859-1?Q?uzc+hCBd6pm3GNzYRrv0G0WkC5pxlR36NNo28Gve7+lCFh1tPq9/h1tYqv?=
 =?iso-8859-1?Q?z7HZVv/na5Frejke5EZxt9TKQVbuAbX1FGJtOv+8g/EGreIXeVDL8sp8lY?=
 =?iso-8859-1?Q?RRhoEwkWMGQsElWFpHCRiVn45/g5DbmXl7rO6ICAXEo33a9U9/+hp2zzqA?=
 =?iso-8859-1?Q?qSZNtH0uWtFB3mhX0XnpJETLb/awTt0Cpqho+cKwtIBlLfrKg+umaHDaG0?=
 =?iso-8859-1?Q?omNGWNXslrurUTLD02OkH2Kk38yXZx32ZVaj3Sdf84QUpXn2wJhvvzHYYP?=
 =?iso-8859-1?Q?/quf/fCUL4RHFTeFfGzPrK/AIvPOdk5NMgQrLCVUFOVPoMIwr0fg76F5KE?=
 =?iso-8859-1?Q?L5WaVs/aBqRQHvnM0eatspZbaXUpL3Wz89hgY3959ztCrjrV56M8/gNLSW?=
 =?iso-8859-1?Q?+Q5On/cMnEituGXXGwgEpRwsVCWE9iHiosct3PXsW7Di34vCE0tmD9CjJ8?=
 =?iso-8859-1?Q?RdmlsLV0t0B/msdGEVTj0YMVNFqwEZRCBFHdfTGWJEibKdZ57N9gSOa4D0?=
 =?iso-8859-1?Q?yTUy93C8uKhrkoZa8+be4HjiaDfLTxn6m/Jg6eikSK9DnaILV86xQPAgEg?=
 =?iso-8859-1?Q?6iELcfxoicYdbCudhmi2+U/pbgBpLuIUDWmEVhITuBABq79l1Ml/SwWS49?=
 =?iso-8859-1?Q?skRKPzK0EM0owcQuo/uZYyoXaAohnDu3phtM3szDHorDJejznvRoeJYl6V?=
 =?iso-8859-1?Q?F9Ue5ACbSLyzV8nADvw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8392d85a-fa44-4e6e-9f28-08dbb99fb333
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 06:06:16.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yeFzzYM+0kmI+e748oBDxqdNrZ55pTlyQvvZ99r2iWhCom/g6rdNQGf577z7ziAQ3B+W3Vhn06g13GzuFexb1MHeJmKOfDzlarfncEho+AA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4876
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks for the reply

On 2023-09-19 at 14:36:06 +0000, Luck, Tony wrote:
>> On a system that has SNC disabled the function reports both "node_cpus"
>> and "cache_cpus" equal to 56. In this case snc_ways() returns "2". It is
>> the same on a system with SNC enabled that reports the previously mentioned
>> variables to be different by a factor of two (36 and 72).
>
>> Is it possible for node_cpus and cache_cpus to not be multiples of each
>> other? (as in for example cache_cpus being 10 and node_cpus being 21?).
>> If not I'd suggest using "==" instead of ">=".
>
>Some CPUs may be offline when the test is run. E.g. with one CPU offline on SNC
>node 0, you'd see node_cpus = 35 and cache_cpus = 71. But with one CPU offline
>on node 1, you'd have node_cpus = 36, cache_cpus = 71.

Okay, thanks, good to know. On systems with disabled SNC that number
should be equal even if some CPUs were offline, right? I was mostly
concerned that the previous version was returning the same number
whether SNC was enabled with 2 nodes or disabled.

>> If yes then I guess something like this could work? :
>
>+     if (node_cpus >= cache_cpus)
>+             return 1;
>+     else if (2 * node_cpus >= cache_cpus)
>+             return 2;
>+     else if (4 * node_cpus >= cache_cpus)
>+             return 4;
>
>This returns "4" for the 36 71 case. But should still be "2".
>
>>> PS. I did my tests on two Intel Ice Lakes.
>
>Perhaps easier to play with the algorithm in user code?
>
>#include <stdio.h>
>#include <stdlib.h>
>
>static int snc(int node_cpus, int cache_cpus)
>{
>     if (node_cpus >= cache_cpus)
>             return 1;
>     else if (2 * node_cpus >= cache_cpus)
>             return 2;
>     else if (4 * node_cpus >= cache_cpus)
>             return 4;
>     return -1;
>}
>
>int main(int argc, char **argv)
>{
>        printf("%d\n", snc(atoi(argv[1]), atoi(argv[2])));
>
>        return 0;
>}

My previous understanding was that the presence of ">=" comparison
implied the number of node_cpus could somehow get larger. So I
assumed that keeping it that way would be sufficient but now I can see
that wouldn't be the case.

>
>N.B. it's probably not possible to handle the case where somebody took ALL the CPUs in SNC
>node 1 offline (or SNC nodes 1,2,3 for the SNC 4 case).
>
>I think it reasonable that the code handle some simple "small number of CPUs offline" cases.
>But don't worry too much about cases where the user has done something extreme.
>
>-Tony

What about outputing this value to userspace from resctrl? The ratio is
already saved inside snc_nodes_per_l3_cache variable. And that would
help avoid these difficult cases when some cpus are offline which could
cause snc_ways() to return a wrong value. Or are there some pitfalls
to that approach?

-- 
Kind regards
Maciej Wieczór-Retman
