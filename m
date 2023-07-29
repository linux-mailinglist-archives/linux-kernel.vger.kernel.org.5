Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24C4767946
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjG2ACj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG2ACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:02:37 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1276FE60;
        Fri, 28 Jul 2023 17:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690588957; x=1722124957;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yJ+Ku1Uptnkna/qf6C5iSo/XumWlQUPktLxCyzqI3mg=;
  b=d3xK1EebB8JsO3IFKyAqMjW59gDt5umxZthX8cOMbCQKCSoMBD4/pQtE
   h0lWvUoJ02+8ppFVZlpHKBTNZ/YRvXV1PcUIoLDn08h+KJiWOFveQmIzr
   +E1/NmTwKwqvGVL8W5/vIkPy4gG3U4Y6zUkmOQ4pjWC99boTUgpSzVrBE
   oey2RregoOF6AVca7r1HJ5R5G8CP5Prfarg4HpIjFnZ2ajkgfic09fhJQ
   tqcAHNPU+2UveWm/A7R8qtowqHhvr+Se5iUgctCDiGX7yL9jIb5Hy4LEn
   D5SYILOGbKWT++uRHgLZ6xlrcX6/U/R4CcmVh2IZPtJTq4A+fLadEU24e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="366175205"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="366175205"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:02:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="762745785"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="762745785"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 28 Jul 2023 17:02:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 17:02:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 17:02:36 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 17:02:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPmalDxFzQNHrOMvei4/NE6MoP23TPyNrL1U95oQ5UENYjHd/vhB0cKF6jAQefmCiHtDT7FjzUdPbKJkcdNBoLCad6OnmZ0difKs23UMYwK3ryNu0InfVMGFA95fSnvRvDSlgAHwk9sIFHIXTvMRa1arvpoppm7zBuIihlrG37rADq8VU3v2WoD7E8j2zgb3pw9weHNNQFuz5qsibTSI2cvU1+dMuoZR3mK8lFvUX1EfKFgTa9aZ1qYE+NanAEdLlQ3EXLEWZmJO2Bthq2Px1Ft+TFd6crA6AS556UVhpzhjOwBJVCpkD/rfgtGy0VNP7/fK2e/TA7dc+Ul/JSLnnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCrz4t14eeTTrFZ7TiJqPbUeF87lA072n1C1uKBKP64=;
 b=K3xoL+aHyC0Rk5QivJkFh/58LiNbMI1jq98aeRJijDpFcHLHB5POJKGrVCEB69spNTyvp4UrIle4qKV4Ksb2frVbuaA5kwAhtxaX3nc4naJjsKGCtY3B5hoUDrsWAQqRsNiwkpjsI7IIdDjQrn0Dw1KCROUpP1WSC306WkxVfUmysh+Fxbj02LXxsL3KejgtxH6WSqW2C/EpvHHAm4jgX0xFKUo6l7Gx6u0tDMWVzHvL4drI8/VOjWxCR4iCGiSxCF230cdusBVJPEMzeAujmpIY4abU1vTPZfUXgLmq+OMbda3uUXOhe/FEkCqv+riTfVV1jNtZ86wLASZlMVIxUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by CO1PR11MB5010.namprd11.prod.outlook.com (2603:10b6:303:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 00:02:33 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Sat, 29 Jul 2023
 00:02:32 +0000
Message-ID: <633489d5-f521-91a6-0448-208eb25ff63f@intel.com>
Date:   Fri, 28 Jul 2023 17:02:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch v2 21/38] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "Russ Anderson" <russ.anderson@hpe.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.839913695@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230728120930.839913695@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0135.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::20) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|CO1PR11MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: bc744841-66c9-42ee-e52f-08db8fc71b86
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aBO2VB8U8ze/ZGjrXw+PR1cOpSQ/7ALbwu3ll80rx6D/CcCuj7whw54g7e6X/5J1SHPb4JEJaA2eJvZv40RSGnvGyt9iM+P/DKW5fTCQYZv7lar94agDnqG4wwzHiIjUDGN3gG4mtq9YpSagSCoOhu25Iqx0gs7idBpOxZzKrOd7EhChGvpwpVK32Vlp+Ba1P4Tk/JLlXhmbeQ/fsTojA6+VVWFKzOihxYluvdjIp6AA4I04klGd0HdAtk0hNZxdpnTdVoqhX6aV//jJ67Kd/9xFGxRNxZfhkJgUMbefWNCc/hJgH0eogJ4vdABAt45nL/SVybB4vHZ6PmxgersX7nO9qojWnMF4vc1nOb1mqHeuTwner6Ted2qPq/RIeLqkWJdlYelSEXuEC5yJScktB5nJtY9kMYl1NxWLVMZ6hHL+pTzOoy8Jx1NrWkCE3UAN+k/wMStFbRR0EtyxYP/vMgd4aMyubv58Dl3PVWNBH+gb00guxt+4xhK+V6pmcViSWIax+XC8/cQfx3fTixR5NndbTYHF1986E9+dZqYiFKLQ0D3ayEqWgAE6VZB42X/35nVGVon141m3697v8wq6w9okgjnvjwcO9Hk25jk0+c2zsD9m5WfGsryuP2jH/WYr4OmefmXkj3QlgZ77POV7bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(6486002)(6512007)(478600001)(86362001)(8676002)(2616005)(31696002)(110136005)(44832011)(8936002)(6506007)(54906003)(5660300002)(53546011)(26005)(2906002)(4744005)(7416002)(41300700001)(36756003)(82960400001)(38100700002)(186003)(66946007)(316002)(4326008)(66556008)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTVCRkRFV1RhWDIvU2NxNkxCaGxKeS9GY2xlOE5RMzdSQnhUbG9KZ3NLV0dT?=
 =?utf-8?B?OGwwS1drOHk2elF4cThtdG50ZkFBaFUwUUczdzVYdHo2ZDRCQzZBczd4U2lD?=
 =?utf-8?B?U0JsT003RmxYRk1vQVBNcndCL0dJMDRzek05S2FtVEhCc3c4dDRGNEdiclFh?=
 =?utf-8?B?bFJRS0g3cmZWb1FHWjc3WHJhODVnK3A2ek4rZ0xyTkYrc3orazNFMEd5eXhV?=
 =?utf-8?B?ekJoQlcyVlkvL1hOWTZZemQxdDRPWEZaZmNuVlpYNHJuaXd4T1BuYXk1czc5?=
 =?utf-8?B?c2dGZzFlUUhWaEpSUWo1eS8vNzRwRFZkTmV5eWJ4RWpRcmh2SlQzVi9OL0ph?=
 =?utf-8?B?MkpmUFBnazR4LzVsMThva01PbS9wdmVwb0xvUC84MUEyTUkwRkpFK1JyT2dX?=
 =?utf-8?B?V2J5TDdFSFRzenI0UUxaa3BoUTVlUUZ1RTVQSU0wNHJQMEVVSlZ4SDBwaEdq?=
 =?utf-8?B?dzBRdWNlbVpYSnFWT3ptNUdLaFdUUk9OSzMzWTNuZmZveFF2SGhhRWErZ0V6?=
 =?utf-8?B?UjBiTkZ4R1R2QjUrcERPeGhrUHNRcGNxWUpieFJEaVh0dlg1Y2JrbUd1MG84?=
 =?utf-8?B?NG9oS05RdEQ0UngvQS90YTE4SEZyR2lNR01WV01ZV2Q3U1lRTGxOMFNKeVRp?=
 =?utf-8?B?UUNHalBJMU1zbWx2cUNpZVNINXM3R2pHblFtK3hYdjA2NmlvRzZ3cmVTUjlT?=
 =?utf-8?B?SVA5bjducVVlUG1ReGdhaklxOERYR0swUGVBbVpWTy84VUVjL29ENjJ6T08y?=
 =?utf-8?B?MGVNdVBnTEllMVJ1ZkIwSmQ1TFpoa1NkcjhpeVhQSWFLVTRTNlhNVS9mZ0h6?=
 =?utf-8?B?bVJrenNkWFVIY3RPaTRBOFozSVBaTlkvMk5YWTdJK0lHWUdad24zRm01aWQw?=
 =?utf-8?B?cW1kclEwM09mWjBqaXlEYVh5T04yTnhjOUUzSDRJM0VKSmF5dW5KYnJ5b2ti?=
 =?utf-8?B?MUx1UjF4d1p0N1U1ODBMZGtsZDM1dE9na3phYVh3c2JFMTJwMU1iMTY1bDRo?=
 =?utf-8?B?cHAxWDc1bVYxWW40d05kclpMUkVscTQ1Vkdsa1VsakhsOC9sNjlNTjdtMHk1?=
 =?utf-8?B?TVRrM0hJNW5nd1VzQ2lGOE45M1V1QVV5M05IN1MxSHNJYmExeE4rZDE3T1VO?=
 =?utf-8?B?REN5dFpGajcwNG5lY21aMExOQTlGR3czYkdBSUdyaG9LaVgzNHpyVEVndzJ4?=
 =?utf-8?B?MnJKSGdUSjBVaXNTc21pa01majNPUURJN2tmMEE2MGhGUHZTK1N1VDR1dVE1?=
 =?utf-8?B?NUE1WElTSE9heFVFWDBMTitGWjByY3Z6WW9WYjMyZkt6K2I1UlphRXMyUWtD?=
 =?utf-8?B?bWIrN0lRSTNCZ1FURFphM1pwOXp1cG1YVG4zTHZpR2FjRW02QmpsZlgreElP?=
 =?utf-8?B?U2pmYjhnWnd6WkJPbm1icG9QbEo4SCtBMU10a01Gc2NxM1BsYkhhc3U4V29z?=
 =?utf-8?B?b0dxQXhGYnVJcGJ3MzNJV0dsRzRrMkhid2oxME9kdWl5U0s4NzZ1cnQ3Zmpj?=
 =?utf-8?B?Q0ZsOWsvQ2I1SWI4YTBMbkpsUWJERStEN29vODJZNGxOUWRVMHZxbW52L05N?=
 =?utf-8?B?VjN3a0t6Yk80RHhPeUlOcDNtWlBDd2EvWWo0eEt6WURnZ3VWNEJLM1JScE0v?=
 =?utf-8?B?VWJpTVlxR21hSXdFNjhHdzRqcVMvUk9SRFhJNGxYN0J0c3BvUCswMU82ZDZy?=
 =?utf-8?B?UVlZVnVOSFo5QVNwUXloTWViYTQvZlI0dXYvRFc3ZEhEUzVEY2RPdVVVeHJt?=
 =?utf-8?B?bWRZM0pTVlVtbUNwWVc3SmpxeWZ6R3phMXdJdnJsYjU2WEw1eHNaQW13VVJp?=
 =?utf-8?B?UmpiZVNjd281SzJVeXJtc0FkaEVCYU1zV2hyNnF2UERjTDJDOTYyc3FITVVY?=
 =?utf-8?B?ekJCQzFLazdpZk1oVWx6ZFNSRm5CT1JRd3pXSEIvK2hySVFDQkl1YXkraENj?=
 =?utf-8?B?b0kxTEFWUVo0WWtVNDhSYmpwN3JQNXRQWXNQVnlFR055dFBsbmtUeVJjTjlN?=
 =?utf-8?B?LzJDKy9BR01MMXU4bUllTUJxT3pBREc5QTM4VVd4U3htUVVhVnJYR0d1cFQy?=
 =?utf-8?B?YjRSWlVWZlpWRTJVVEVsY0F4cVZrZzRnUHVqa3hqSjR1Mms4TE93Y1NweS9o?=
 =?utf-8?Q?J3ZN9XSRc32Vni25sXfPXZ5Ft?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc744841-66c9-42ee-e52f-08db8fc71b86
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 00:02:32.7660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kvQygSF/5XL5ugN3q9abmyp788i1owj3Pmx7ygRRAlKIyZENtiRIChVIjdSELwjvVQHZm2tFYkyUHtAN++pvFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5010
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/2023 5:13 AM, Thomas Gleixner wrote:
> Topology evaluation is a complete disaster and impenetrable mess. It's
> scattered all over the place with some vendor implementatins doing early

s/implementatins/implementations

> +static void parse_topology(struct topo_scan *tscan, bool early)
> +{
> +	const struct cpuinfo_topology topo_defaults = {
> +		.cu_id			= 0xff,
> +		.llc_id			= BAD_APICID,
> +		.l2c_id			= BAD_APICID,
> +	};
> +	struct cpuinfo_x86 *c = tscan->c;
> +	struct {
> +		u32	unused0		: 16,
> +			nproc		:  8,
> +			apicid		:  8;
> +	} ebx;
> +
> +	c->topo = topo_defaults;
> +
> +	if (fake_topology(tscan))
> +	    return;
> +

Spaces used for indenting "return" instead of a tab.


