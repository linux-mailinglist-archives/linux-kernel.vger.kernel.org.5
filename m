Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837597745BC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjHHSpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjHHSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:44:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952783CD26;
        Tue,  8 Aug 2023 09:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512908; x=1723048908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S271nEXJQXcS9s6Jph3anZpEwytGfZ3c9tHqgRZXPpw=;
  b=TZk6plQqGkhvs1w1ZAi9SGsbr2EtQZ6v45pqPD7giR/uZjAG4pIuZNRq
   TCdkg8OMVBtK+GbeOP6bpoIxo3K0/dgMgQnOU7adMSPQ7L/Rw4aLYVmOY
   tkkEdgIp13JPLFoGRHcCR5h033KYiwrNu6VhByRTLp2nQMb9v0T/44Krc
   vvlROqm/jlBfexJs9HXKVvL3XhOQxCZKXoRBglBk2u4BGt/pv2Kn6C8N4
   IezfPj0nKRT2nuaB838j4G1GARU3//ZlcaYdWxWTOylC1LFAJdV4mmrI+
   ivl56jzRRG3FlVpmxinCV4X8WND5S8h8czUsDNYcpBcQYYl+VHN+sqxQl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="374495695"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="374495695"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:29:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="681244217"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="681244217"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 08 Aug 2023 06:29:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 06:29:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 06:29:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 06:29:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 06:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiqQhwib1TV71Bp84ezyCd3ZOABkGjMd5XeFdk/ru4Kk8GYLBHqQCWn/Tkb2V/lnT/zuo+vrbH9fGQ1GBT7wrwulULNEHksm+LpEdd7Hk+2x/UxKW0YeWiU9chrzSu7YjpnP80xoElyFgovEpbBB3J8aC29muKy2y1ewPfgk+dL7hoP2Ogr/TFUH4yxPIoXcJvMa8iRInIeaayoZegwrpnxEUC/Kxgs/g6gp9jU7+2CVuduqGb5SyH1VK7WXKWcmAAPJDTm1ZCRwYny8VS0dlx6zz8RCd1Yf/ZpNRWdpONeq6pG47rEnSWM1e9/hYA+j8dHB3P0YfP4+raOPyM2Iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qH77iGD1HH9M1u4K6H7f80+vJU62PGlj6/jlH7MJY6c=;
 b=cj6n7d6uIsE/L1fJq8IeXjMVFBBbe9d/MuUIaQYdR3EiY8HybhRUk0kGdgqp6RaDoKOinFKExxOzZJuZn1KDiy8Zup6/7sEFsmmlbcQqrH6cjQmzW2lA/ujJG0T2aZKlWyCgbhHgRkLgAeVATsNvomTXNOadhmRCO4BhKYE2Cv+at1owuSHBfg9ChAhVDrYyOQF6EQdylo+W+heclBbfMreQrbTfP6yD1T9U2q7ddRQiJqlhnxAw4aPZBYNJbf9BryhUvQoaz8wG/tS8cyZI4VH5zBpORx9IvPxk49TYmOp6eU5uYdBU9WTmdGLIsZFqUeK9Wicqxuo9a9erYHmb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH0PR11MB5596.namprd11.prod.outlook.com (2603:10b6:510:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 13:29:41 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 13:29:41 +0000
Message-ID: <7c3aa2c5-ecf3-e2cf-8955-04155f37d609@intel.com>
Date:   Tue, 8 Aug 2023 15:29:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] page_pool: Clamp ring size to 32K
Content-Language: en-US
To:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Alexander H Duyck <alexander.duyck@gmail.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Yunsheng Lin <linyunsheng@huawei.com>
References: <20230807034932.4000598-1-rkannoth@marvell.com>
 <b8eb926e-cfc9-b082-5bb9-719be3937c5d@kernel.org>
 <0aa395ee0386b4b470c152b95cc8a0517ee2d2cd.camel@gmail.com>
 <20230807102045.365e4c6c@kernel.org>
 <15d32b22-22b0-64e3-a49e-88d780c24616@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <15d32b22-22b0-64e3-a49e-88d780c24616@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH0PR11MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: a3bd70a4-c151-4072-3ed4-08db98138561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQAgKne5GDp7A1BfVyxUJxSAFbkrcLvBGGbX725ZOLKnOlCHgwC9JRnsN+GPSrhvCTcfE5ccUezcIpgQK7F8lB3f/ba/FXG6Ui7bMXHoocIj36HME0/GInBmBOUjmX+cOxgdbmFOpjeyTdgWLA3jpkdjzEdJGo4AZVek/q/glD27wOirgCPeU6jzgPqyjPE7hq5h0FOaugkM9lPcrplu43P3qjEXCjcubV7veqQ0pr/sIxRQsLrm+0nE7O/VRjyFS/coUC+XQGfakPB6MdVmAs0g7vAzirecp7sd+a2GKbNq2A91hyAUKNaqdGIzZoJz3cErw5bfHYLh+uvaX5J/4dRK+iz0JL9RZt3lGJCUYNRhIsyAgxT0DWmx1Mo2mRfmgadPfuC65Dp7gF6TET+UsWjrYfuGYSl4vGqCsZvAjKMgOOGMYRqmynCsrg5XaeVdDUf1DF96iR0B74eaNsQwzOWLFZcWeGH4qBqT3bfrfSByqJg0yGLbEmdoy6/wC1mLgB8yI2C9cf+uE68yMe5lf6VLW3T/0+ZIS4ZOacKje5tXFge8o7lnRLp7ZyJhBDO6zflUkqc1AGnD18loffNwCSwIemappxUuYMIoSXNt/l7SpD/UZSjXSwLSJh3Omob3KQ71WsTEcEQbcE94dnkyTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(186006)(1800799003)(66574015)(7416002)(8676002)(8936002)(5660300002)(4326008)(41300700001)(316002)(83380400001)(86362001)(31696002)(2906002)(6486002)(6512007)(6666004)(2616005)(6506007)(26005)(36756003)(66476007)(66556008)(66946007)(82960400001)(478600001)(31686004)(54906003)(110136005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGZoL3FyY1N5VGlac2d5ZUdvdUZraTR4YnRMKy9HcnRrNjlRZHFCbEN5dmpO?=
 =?utf-8?B?dTNjNy9rZ2xNdGdLSVpiTFJWWTh1djNOVll6NkN2azJybkN0VDhKVDBYZ243?=
 =?utf-8?B?Nm5BYjcrT3dWcDJ4QnhuVkZwZFpFZnR2Rm1BeEdZdElBRms5V2g2a0dmaXN4?=
 =?utf-8?B?N0pHczA3SVBGWi82M0JrYjIxZURPaVR3WW5ZTEZzeFkwWWVXb3hvVWRnWklO?=
 =?utf-8?B?Q2VxVy9RR2JVRWJTdTJNVTBjRjlSZWt6RTZIaml1SjF1ckNSNUhPT2M4cFBi?=
 =?utf-8?B?UWxER0dwMitBSGNPajQ1eFBaMnh5czl3M2N2anJrMzFnK2xTVkRWekZBWFZS?=
 =?utf-8?B?aUdkUHRyWDNxalNORU1JT1JGYVVhYzRuZHNVQmhPWWg0UUNEMmdqck1NaVky?=
 =?utf-8?B?THplQTd3d3V2ajVyNDcwSFJHVzRNUDc2SVhnaG5OSnpUeDM0bThBZFUxZ2x4?=
 =?utf-8?B?T0krN3ZmUnBmd1pWNlRaUG1tenpvWllySTYyR2Mzc1ZyODJYQm1pSFIvdjFL?=
 =?utf-8?B?KzhQeEhwWHFhN0tEb2JmcldyOXdkN2xZci91b29FUldXdks1SW9wWEZ3Zk04?=
 =?utf-8?B?Z2FmRjNWWVc5WE8xbUY4dVc0aDlGdThST3VlUEZ2di9ja0gyVmR4V2dJdWVz?=
 =?utf-8?B?MEdzMzFyOVhXZUFpeWtKdW84Uk9pWFZmaXZBeEhyTUdrSnFJaGpYMk9OWFlS?=
 =?utf-8?B?N2dTc1hqVmlJbll3bXMrclVhSmI5d1Q0NjFlT05yVEVubktCclppY0h5eXpa?=
 =?utf-8?B?N2ZQcG5SZVdYMnNUL1kwQlk1L0liamdpMjNDMlZ3dlNYL0trb2cybDJJNFNE?=
 =?utf-8?B?NVNBM29NVEhtUmdpTG5LMUtMTjdCa2d0Mlo0ZStoSEptQ3Nac2M0ZnEwM01S?=
 =?utf-8?B?L3pkT1NJV2QxczBXOE16TlVIUno5aTNMNFN1eWtLR05lQUJnK1ArM3FreHRE?=
 =?utf-8?B?NE5xZFY1R3NlVHp3MHpvcU5MaGl4WUNqRElLcVpNOFY1YmtXQjNYdGFPcjlj?=
 =?utf-8?B?NnZndmF1M0Jwa3NOWDRZZlpCTGlxNkFaTTdxZzErZnhwcTdVKzBKakpPS0NU?=
 =?utf-8?B?SmZPODNCZk9JWTZKaC90aEQvMWg2c0Uxa0wybW1JREdxazZNTDBQRktoL0tR?=
 =?utf-8?B?VGI3elNLNVNuVTE0SFdMQVlhRjdzQVQwcHArSmNwRFo2YmJNUVdLVlV5b1lO?=
 =?utf-8?B?anN1M1d3UUlaZ0xYUnFrOTNWNStiWHV2eG1lMlZLaFpTYW5GdEdFTEg2K0Fa?=
 =?utf-8?B?RVZ6YlNKY3lySmQ3VjVOOGlRa3NDNzJrcEVSbm45M3lKQ29WSXZxV1I4TkxU?=
 =?utf-8?B?enBwY1hXcW9DbEVHcG1EQ2NLZTh5MnFtdDdNNVJWdkdIS205clpYdDJlcDRN?=
 =?utf-8?B?VGRiek45bDNmdkVtbG9xakRuQTN3bkQ3dXhIazhYZmEvNFlUaUxkd1JDeTFa?=
 =?utf-8?B?YW5xMTFFVUNJbHNsVGtPZEFXcFF2RXNFVWZ3cVd2QzJ0NFlvZXZXbFNIUTVM?=
 =?utf-8?B?Q1hmZzByVm9UZHU0KzdaaUlIc0NBSWFSTVNCVG5PUDlsaGo5LzBJazFFekVM?=
 =?utf-8?B?TWlxWXZzU3JqS0VOSE9xV0ZEVXluMUp4WitSVEo4L2xXS1hRNmxqelg2aHpQ?=
 =?utf-8?B?clpJd1dkVC95eEZSZ3puTDMxQmQvV0REK050N3VlMCtORVM4cTd0dmM5Z1ZN?=
 =?utf-8?B?cnZCRG5MamI1aXQ0OTNJT3NnUkdxYzEvaGRKbmpXbmNXVGdpbUx3MEhYai9p?=
 =?utf-8?B?WDhPL09PSzJhbVNBWkFPUDNzZmFMRnBqODIrbEQ0c2ZnK1NrUlN5VWFzOTJk?=
 =?utf-8?B?TElNdHFPdWxXOHRCb0ZBTEpaODBPSlRnQUVQMkZtSm1pUVVkazBzQ2ZDTmk5?=
 =?utf-8?B?WFJPem5FQnR5R0dWbVBQdHhkOVhjN2xQMWpmK1psMU9VTzZoQmErRzNtbVg0?=
 =?utf-8?B?S0JKREl6MUV6UXRZYlZEQTA0dXFIRHFQb0poUnk4K04wQ3Zzc1Q3WTBrV0JG?=
 =?utf-8?B?RWJFTUdhdmxnOU90Q3VpUWh2bXdWaThHNDVZZlFadDd4UVM0S2VrRlFudmJQ?=
 =?utf-8?B?ZE9tSDl5eEhPWFdENE5GdDhCTE4zNUhBVHVGcVE4TmhHOUhlQWg3VjBsNUlz?=
 =?utf-8?B?YUNTK2dFY0NHZ0lDVldLbmR5dklVZHd0Q0hjcTFmK3VCL1V3SFAxaUgyeElV?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bd70a4-c151-4072-3ed4-08db98138561
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 13:29:41.4484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3nSXAq+SnTzGqu7hfLqSNFTEq51srHsdY9sae4KiVnbYkWwbYgYsqf7Z1x8vy0S29UrO3BxdMjIXfjvr+Rt0lUZIVNf1/APClfvVbyhSX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5596
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Mon, 7 Aug 2023 22:11:35 +0200

> 
> 
> On 07/08/2023 19.20, Jakub Kicinski wrote:
>> On Mon, 07 Aug 2023 07:18:21 -0700 Alexander H Duyck wrote:
>>>> Page pool (PP) is just a cache of pages.  The driver octeontx2 (in
>>>> link)
>>>> is creating an excessive large cache of pages.  The drivers RX
>>>> descriptor ring size should be independent of the PP ptr_ring size, as
>>>> it is just a cache that grows as a functions of the in-flight packet
>>>> workload, it functions as a "shock absorber".
>>>>
>>>> 32768 pages (4KiB) is approx 128 MiB, and this will be per RX-queue.
>>>>
>>>> The RX-desc ring (obviously) pins down these pages (immediately),
>>>> but PP
>>>> ring starts empty.  As the workload varies the "shock absorber" effect
>>>> will let more pages into the system, that will travel the PP ptr_ring.
>>>> As all pages originating from the same PP instance will get recycled,
>>>> the in-flight pages in the "system" (PP ptr_ring) will grow over time.
>>>>
>>>> The PP design have the problem that it never releases or reduces pages
>>>> in this shock absorber "closed" system. (Cc. PP people/devel) we should
>>>> consider implementing a MM shrinker callback
>>>> (include/linux/shrinker.h).
>>>>
>>>> Are the systems using driver octeontx2 ready to handle 128MiB memory
>>>> per
>>>> RX-queue getting pinned down overtime? (this could lead to some strange
>>>> do debug situation if the memory is not sufficient)
>>>
>>> I'm with Jesper on this. It doesn't make sense to be tying the
>>> page_pool size strictly to the ring size. The amount of recycling you
>>> get will depend on how long the packets are on the stack, not in the
>>> driver.
>>>
> 
> Thanks for agreeing with me, and I agree with you :-)
> 
>>> For example, in the case of something like a software router or bridge
>>> that is just taking the Rx packets and routing them to Tx you could
>>> theoretically get away with a multiple of NAPI_POLL_WEIGHT since you
>>> would likely never need much more than that as the Tx would likely be
>>> cleaned about as fast as the Rx can consume the pages.
>>>
> 
> I agree.
> 
>>> Rather than overriding the size here wouldn't it make more sense to do
>>> it in the octeontx2 driver? With that at least you would know that you
>>> were the one that limited the size instead of having the value modified
>>> out from underneath you.
>>>
> 
> I'm not fully agreeing here.  I don't think we can expect driver
> developer to be experts on page_pool cache dynamics.  I'm more on
> Jakub's side here, as perhaps we/net-core can come up with some control
> system, even if this means we change this underneath drivers.
> 
> 
>>> That said, one change that might help to enable this kind of change
>>> would be look at adding a #define so that this value wouldn't be so
>>> much a magic number and would be visible to the drivers should it ever
>>> be changed in the future.
>>
>> All the points y'all making are valid, sizing the cache is a hard
>> problem. But the proposed solution goes in the wrong direction, IMO.
>> The driver doesn't know. I started hacking together page pool control
>> over netlink. I think that the pool size selection logic should be in
>> the core, with inputs taken from user space / workload (via netlink).
>>
>> If it wasn't for the fact that I'm working on that API I'd probably
>> side with you. And 64k descriptors is impractically large.
>>
>> Copy / pasting from the discussion on previous version:
>>
>>    Tuning this in the driver relies on the assumption that the HW /
>>    driver is the thing that matters. I'd think that the workload,
>>    platform (CPU) and config (e.g. is IOMMU enabled?) will matter at
>>    least as much. While driver developers will end up tuning to whatever
>>    servers they have, random single config and most likely.. iperf.
>>
>>    IMO it's much better to re-purpose "pool_size" and treat it as the
>> ring
>>    size, because that's what most drivers end up putting there.
> 
> I disagree here, as driver developers should not treat "pool_size" as
> the ring size.  It seems to be a copy-paste-programming scheme without
> understanding PP dynamics.

+1. That's why I wrote in the previous thread that pool_size must be the
minimum value which gives optimal performance. I don't believe Otx2 HW
needs 32k entries in PP's ptr_ring to have optimal performance.
That's why I wrote that developers must check whether there's any
benefit in using bigger pool_size values. Values bigger than 2k don't
seem reasonable to me, especially now that we use direct recycling way
more aggressively -- often times ptr_ring is left unused at all.
Jakub thought that my "pls test whether bigger sizes make sense" meant
"please tune Page Pool to your servers", not exactly what I wanted to
say =\ I said only "please keep pool_size reasonable, it's your right to
have 2^32 descriptors on the ring, but don't do that with Page Pool".

> 
>>    Defer tuning of the effective ring size to the core and user input
>>    (via the "it will be added any minute now" netlink API for configuring
>>    page pools)...
>>
> 
> I agree here, that tuning ring size is a hard problem, and this is
> better handled in the core.  Happy to hear, that/if Jakub is working on
> this.
> 
>>    So capping the recycle ring to 32k instead of returning the error
>> seems
>>    like an okay solution for now.
> 
> As a temporary solution, I'm actually fine with capping at 32k.
> Driver developer loose some feedback control, but perhaps that is okay,
> if we can agree that the net-core should control tuning this anyhow.
> 
> --Jesper

Thanks,
Olek
