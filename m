Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4FE787FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbjHYG1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241757AbjHYG07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:26:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1537A1FCB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 23:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692944817; x=1724480817;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=K1n96/I0/os3B7JwMZ7hSTBB7Jl/vUFtQViClLA94Jw=;
  b=GAASlFgHWP2cVg62dzIdSeMmaSDBsMZ2S0uhKvHsXf3NZ+XPqCwsK0dk
   MqcIBjOllaGabteycxb7XNZSe5aH2Aowls3nV0QkVW65rG//ykz6r+uH6
   g9x5kIJHLoSmRkHqt8oMqjpQiLBCUUUFxgZGxLIjJSeE/SBTSSr51lEL1
   34igTM9EnDtN0dJEyfoNRlpiRNlxVr5ysX8vQQ0hRGfRWQtq//2XRQKrY
   0PR4pFedtXOwokOQGyzhcJZ2zhvSvcT8+m8nrFAtgUY2haUYadc2hwAXG
   YcyG40D/kKgSrye4vpXlq7Kycx8/AnDAnI3P0YhGhU/WGUMgXn1yVbgXt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="364837344"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="364837344"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 23:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881062783"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2023 23:26:55 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 23:26:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 23:26:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 23:26:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERc/HV3a3iMus0Po6V7FSnKBbS82t0J+U2bVyon8SA1xFePxPPxuKDr7KpfK3zgueXVcd3Y2zsrAfH+SQW1HuTsZ304mFdTbzEFFKkpASHLKCV8ZMG7rLb+ahkgf5gJZOTuxvsb4qP0n0YDah9QqlaqMQ5VlPGh6kz3A9PRJfQRbCcfTDekkMPbgy7pePQjEDF/VJOqeFwiPhfukStzU41XT0HDxkosranchCfsjmzoxuIvVJfNgC2pbq74ioWsr8WnXsXYRxiB4u7/CdvaEqPK5G6DISECbDfPiT4dk4inRrcemZpgCEL6qOi1aNXiN6nrUlpEHip+DA7UvZ1jRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FHDztVITERDpUuF0WF8c8Bg24qj1VpSVAZVAwHZfug=;
 b=YEtjzXYLnMT0I1V47SuoGEift8SLU0TlX5v6kTVEVysdFo6FiKIMeLZhYkuU5FkvLgIjSJvGTEt7nAqb426q4hxcMwyFw4zf96jmTIQQ3Xs1VKfLqx0gnyWRZcrQaTlCq+yquCGokArXUIti1uofGGFS3QCtHvAdluNdIBaPVxEK18XoG0MWXNin/zyWSOkhPdLbEahhLwYvq2MQSCU9ETwCWRup/og+pPQ/pBOF/rMUYYUfNMxggiks4cAcHQpetTOg8iqnFLQy+j1jk5D9hWY+T++LsAD6Ryp3Lz/W2KwjSb5/Mb7Ei8M9XhyuAQmdwdpJ1Bch5Ti9exsD+RtRdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 06:26:41 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 06:26:41 +0000
Date:   Fri, 25 Aug 2023 08:26:35 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        <fenghua.yu@intel.com>
Subject: Re: [PATCH 2/3] selftests/resctrl: Move run_benchmark() to a more
 fitting file
Message-ID: <jaqand55qwxm3euuqfu5wldkpvjtan4mbve3jsyixa6kstjtwp@rbj5stuvduj4>
References: <cover.1692880423.git.maciej.wieczor-retman@intel.com>
 <69a1ed7c06c3c34a2e39b50ffcceb9774967203a.1692880423.git.maciej.wieczor-retman@intel.com>
 <3978b8f7-1d80-d7-926a-72b2cfd923bd@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3978b8f7-1d80-d7-926a-72b2cfd923bd@linux.intel.com>
X-ClientProxiedBy: BE1P281CA0322.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::16) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 2219cf29-d0e2-4a7e-ef35-08dba5343e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fo+eykojEfkSn9JBIm1i4PzFJQP8dSVd5YUY5hqg51DIi9ZKbfrioSXIlcrBH7livZ9IbHRSMZ1aUhbQr9BVq7jifiV8DXcqP2++vN/TtLV6Aejb8JWASVmH9V7axaunbJ593OKbF9NpGBJvuymKUQmGZOLGRSZpGO1XXHOpGhVFr+QQdVXmGq5jGhHUmkPiSNKs7TLicPYf6UuzVt0v6OuiPn/lh8H8+CteUOpYpaAYUjZZBj8bP78uzI+9THaWjOd5mNScbwoA96FtkUub8ZbJ5jpN5aW/bHyQ98Ox2cpNBg9G5nC88eXnAyoPyU9Oxkt5FxIKjGkccdYc55Pk7a/T4d7ypOPUUCqz9Z1vrvpWfteowAwEeGTw+MbX2SjSag9i+Z1biPY31V3lwuKyuQO16tENaygtRO1Xvv/UzXtm+RhS2bUt+zITtduo+RR5D5KOtjRzXmmd1TomEEuuQ3T38m2MeBDV0lVZdZEbicrypHnxVDoUjlc6r6f51dbDwsrpFM2tOzpwiiYUXQLi6g2q8EQWUlk8X0W0Wu1bnMLou5hQGCIdFOINtVpyZJs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(346002)(366004)(39860400002)(376002)(186009)(451199024)(1800799009)(6506007)(6486002)(6666004)(53546011)(6512007)(83380400001)(2906002)(26005)(41300700001)(33716001)(54906003)(6916009)(316002)(478600001)(66476007)(4326008)(5660300002)(66946007)(66556008)(8676002)(8936002)(9686003)(66574015)(38100700002)(82960400001)(86362001)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?MKlltacl8EO+V9C5wbRVlz7HhGPaTa7nkE8GsuQl+bAi1vDHJZtkeh587X?=
 =?iso-8859-1?Q?bdiq/CiE8tNJ4aV9uBwsUUjMDL2opbvPW5TQlI5JxLpAsS/uGgCe1urNQx?=
 =?iso-8859-1?Q?tYsJHFqWQCUobRrz74I7gMZH9vtIUgUwSO+9J32AxeJ9tIa43cr/KgRpOo?=
 =?iso-8859-1?Q?rH/u/u6fSZJ7NDZ9m0TXJrKG+v8M5Q5cfG0Pg8oC8ZxVmgnWiMKy3fe7+q?=
 =?iso-8859-1?Q?THcYlZeqIF/vQ71XEeQ3H0+8vqmrN9zaLJvbvhLIc9v24Z54vPRsvyvEhd?=
 =?iso-8859-1?Q?6HK+cJTq5FZ30n9nR5KXS7r6KRR5xmPywtDorrjCTeOyGuGlSoEIHkfEyS?=
 =?iso-8859-1?Q?oi9YwqJu3evv7IGt73CFa2sURYEWKl0zQoGbpRYtKq15eqziQ56QgYKdQq?=
 =?iso-8859-1?Q?wf8Fz8jHsM+Sae7r5LJE2C+cySJmzMIIfAimhi0SSHe2Cujb4NPK9ov9fo?=
 =?iso-8859-1?Q?H/O0U4Kb8za8120KQ7e3ABIc+0fCwRtUIX26TKasAF8YuVL3z8mxjBiR9v?=
 =?iso-8859-1?Q?ShLI/VJommrVgCJfGIcxhh7Ko1/2vyBPByJ+UyNOUYHShlAiISw7LwVw9/?=
 =?iso-8859-1?Q?rRBjbc1hDu78X178IWp21YsxdEepQjkmse7r+5IYuY6B1EUB1vcDpf6hcT?=
 =?iso-8859-1?Q?LBCHsxuXGXqNA9oR283AHGMdFhpQ2U3yDCu8g4sBwyNSi4dM/qOdpbx6X2?=
 =?iso-8859-1?Q?wxtqzeGxtB/u5C0z4Sw4KyWD5XK+BFb15aznAu+zkHbvbx455ilvVFZVFl?=
 =?iso-8859-1?Q?UeaoRN1IY4gbQ19mmu6WpSANl3R7Hnwvc3boQzul7cHMmeigH0CeNoxoDc?=
 =?iso-8859-1?Q?MWoGd569uiVZAjz2vTRbk5QC30cSPU0kdOyHYU//diZGFlh+Hez4gdbGlZ?=
 =?iso-8859-1?Q?SVhIcTC5bT7INCohYSGdvcEbYI5Hi6x0MYFJ9cjn8+dMmHbw74A+Dn49oD?=
 =?iso-8859-1?Q?GyBEEPXpVUtZ1trO1PrketJ77LosrdzXJTiWtrZIkC+No82NthR5Rl9Exi?=
 =?iso-8859-1?Q?tdcTAet3XCWZWnA7MdcaEWDqEsRYxkUb6GgIBQ2/l2k6QCv2TyEqmxJH8u?=
 =?iso-8859-1?Q?59cLnhfGyu371XXCwsymvJyWiUmjLYrXx+7KaLefeJ2Qc8ai3ohWiNrD9U?=
 =?iso-8859-1?Q?eQGbK1dqIQif3Va2YLoZGptSUqyVWP8KecRCvcW2LQ68c6J5G5IDKhh5o7?=
 =?iso-8859-1?Q?dADkvH4x8KVYFTrsIMe2ay71LIIpUuqXFh6QzsQViiFQmTp5E9mavwbPqY?=
 =?iso-8859-1?Q?ZEc5395XlsXgh/Tv55w/588B9P1pxq17aON/Aqee7r8swhWe4zYd9zWwgz?=
 =?iso-8859-1?Q?GY3V0BfYuIlNEoLP86RcXeieToABxtohsWNP9tgaEIs263KP1s6xZPKwxH?=
 =?iso-8859-1?Q?8z+Fo+wzs797oXEQTyOGPhvkn/Tj4Vtj4US9UhYxqh5/8rHX3zpU2DgtUZ?=
 =?iso-8859-1?Q?/slGMeLjJIqDl7XIR5bhFZ0P5T8RBtp3GWTNje3rf7RlJXGmDO8FuE5OcW?=
 =?iso-8859-1?Q?k5Av4Rxl2ZxKRIFPF+nepTerggyiseTPYyhmZhrveqJJ80aEQY4QloIK7W?=
 =?iso-8859-1?Q?zaETZx1bSmkgSzGBwLKn6nFKJOugxISBCNnXT8orsofwPi7MJVbGYHswr7?=
 =?iso-8859-1?Q?zGrPBA96qxdZ0pRC2Axm6bgP94BAtjo55FC52cEAgE50LStx+w/F79Gayv?=
 =?iso-8859-1?Q?d3lqGRI0nGEFBNcrk5A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2219cf29-d0e2-4a7e-ef35-08dba5343e99
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 06:26:41.2464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nk8Jyw9o2Gs+ky3KnxL+lWGkF64XXi3NADIKyYiV6hsIzOg2+Mdmtqi9s6p4Nqn+1vjqt+N4MfvTsQblL9vfBaR1UU4ivz8UOb80ehNPrpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717
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

Hello,

On 2023-08-24 at 15:56:25 +0300, Ilpo Järvinen wrote:
>On Thu, 24 Aug 2023, Wieczor-Retman, Maciej wrote:
>
>Thanks for this patch, the new location is much more appropriate and 
>logical (more than once I've tried to look for this from the wrong file).
>
>> Resctrlfs.c file contains mostly functions that interact in some way
>> with resctrl FS entries while functions inside resctrl_val.c deal with
>> measurements and benchmarking
>> 
>> Run_benchmark() function is located in resctrlfs.c file even though it's
>> purpose is not interacting with the resctrl FS but to execute cache
>> checking logic
>> 
>> Move run_benchmark() to resctrl_val.c just before resctrl_val() function
>> that makes use of run_benchmark()
>
>Please terminate your sentences in changelog with . like in normal 
>writing.

Sure, I'll change it for the next version

>> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
>> ---
>>  tools/testing/selftests/resctrl/resctrl_val.c | 52 +++++++++++++++++++
>>  tools/testing/selftests/resctrl/resctrlfs.c   | 52 -------------------
>>  2 files changed, 52 insertions(+), 52 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>> index f0f6c5f6e98b..667542c084eb 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -621,6 +621,58 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
>>  	return 0;
>>  }
>>  
>> +/*
>> + * run_benchmark - Run a specified benchmark or fill_buf (default benchmark)
>> + *		   in specified signal. Direct benchmark stdio to /dev/null.
>> + * @signum:	signal number
>> + * @info:	signal info
>> + * @ucontext:	user context in signal handling
>> + *
>> + * Return: void
>
>This Return: void feels waste of screen space as if it wouldn't be 
>obvious from the function signature.

I'll remove it

-- 
Kind regards
Maciej Wieczór-Retman
