Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E477B6E9E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbjJCQeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbjJCQeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:34:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5239E;
        Tue,  3 Oct 2023 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696350860; x=1727886860;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pQENifl+tTDgaWKKBZSgnsoSJlFPZBHsg5dIDcyJpg4=;
  b=ZmUB7ylxHCmLg1TJ0DvJD20DOG54pHFKFEeG1bFjY6i5A356FVGFy96E
   paP7o6UUMNDzxvwTVuTINRhgAkedCuT8J3Wm/+VKEKMFtAjqA9Hm75Tr4
   nycfGaSI6WNsOn5odZYDn9GIZYZ3Su9bZqGd8fKnGoHclSQ4k7tR7PoDT
   ycF5J/UZoP/Ji3yh3GpkVSTVFW1Cn26QLutEx+ERP+E2KJe6T6aLlEBT5
   nDoVZcAG2/6GuhznU5C1daUz7qJJItDYUfdCTng1OJjIla4Xz5tnfWyv+
   ZccbHQPfMmIOr5pU11I7W/Ot5jMGYMAU9up/1sDndgMP16rWa2oL9hWev
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="386789894"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="386789894"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 09:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="727674948"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="727674948"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 09:34:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 09:34:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 09:34:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 09:34:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IW74pFDAtLPrNIVZlwkCMdtzim8/7AX6lTZvU9k2zLhURhONrmwSBk1WuDST9lQhJxrriMyX81brsCDFmdLJc68qMLbOFDJARJepYUt740OHOE7lLmqI0onKca3pbYkXiWqXe9Hc6zN27C644pPhMFeFDDNPJJggEHiSRsu/mv0bh3mERDZOJGkW4LqkgWd/DrSNa/CaZ3SV/B3Rn2oOc9eXFAr5r8UGGFeb4jD9uHdpz3OwMfq69kSM4zK0pWs7aS01jV06XzjB/Ix9xp7ut/XxDaKFw8XAK6AYLb0pkIpg91otAl7QpeagUcgmO7p/VVkqt6sMg2MJkgULYatHIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQENifl+tTDgaWKKBZSgnsoSJlFPZBHsg5dIDcyJpg4=;
 b=iNDljQgn37ETo1Ons/Gi2EDBmX2f2SBDno/xbzN0hDr91qPRryyv42Ou2kM1oyUfEZSh0IDYZOu86tOqbR6EtndjCGXd34uBk/3SdtExi05gIESOvbny61mveg20LaNCnbiHiWQbWwaIGhU+gikinPTzxXcqqIZDomvy6yAseBsO+Ia96w45+XVO6kgxhRxioBZ44eDWAM4jUjP+lGqy1g3zqoz+uga7Gh9m2ZQ2/D1jsdSdgK6mYoKzfe/DCRjnlchKxc6q9p7ciHNSUNa7A3DVO0Zl65fbH9cjNQoJ61Zoy0q1aYPac9a3OGNMga4w9TwzFZxvMhkxZ7xpEFgGmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7655.namprd11.prod.outlook.com (2603:10b6:806:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Tue, 3 Oct
 2023 16:34:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 16:34:16 +0000
Message-ID: <a22ae684-faf7-c4e1-226b-7eab4e9caf65@intel.com>
Date:   Tue, 3 Oct 2023 09:34:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v7 0/8] Add support for Sub-NUMA cluster (SNC) systems
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20230928191350.205703-1-tony.luck@intel.com>
 <20231003160800.8601-1-tony.luck@intel.com>
 <SJ1PR11MB6083136387418886E2399B28FCC4A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083136387418886E2399B28FCC4A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0014.namprd16.prod.outlook.com (2603:10b6:907::27)
 To SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b841e32-84cf-4a60-e18a-08dbc42e95a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L8iU3n73GOAa3V4OwTcdSvpIgs2Di1dVFmBgeLq+ZLjSrc596MYHc7z9kJ7ysEMG+ZghzOienCA85rru/9usbXOLiL7qlrsKMPoquROwU9DUgvPTuiwWob1iJgT8yPTKrLcznODuKYipzJkNzp7sLPd1rpt5Bd7owzexQ1DSRwBOAh8MwA1rFUfLEyIy5+R7PY18EDRG3F9oRO34UIlGnEtMOLjlRvrueOYfJD/kH8mGUDY2Ohkn1QSUPf0+PPdOxrD0sCQ+fVpK2Chszl7fhsysMFqy1Iis5A8/WVo4hzByeid1IeqVeLQvbhnhPOILWo8jrIGzGWXWa9JVgQvtcRzPfBOCmN45AP9tNSEr4qd1e37spwwQr/8Dq/2gJOjT0kFo3wwdzB9mAgexIZzR8I566Aq15gakfTnL6ZGxUpgiQHeHyHSPhQ9Uq9gK3HOLU9d2JB6+ZdZehIBgYzfoD9r3oDea0CawKxwSzPO4Tdw3jtzPix7+JeHop23QaitFa7d/RpX0MkXDJvb80QSrBp9f7QULQsK5UW4bpcGyVq5xuaJ+nOLdzqtqApCzyAzag+HnHYG10mXCFGncWY1u7eiX0VMK117TlPO0wjIQ2C+/Uu1B4Hgy5nNnm/OH4/p7tLxTS37s+iUPycQpjz6EKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7416002)(4744005)(2906002)(44832011)(5660300002)(31686004)(8936002)(4326008)(8676002)(2616005)(36756003)(41300700001)(66946007)(66556008)(66476007)(316002)(26005)(54906003)(110136005)(6512007)(86362001)(83380400001)(82960400001)(6666004)(31696002)(478600001)(6486002)(6506007)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFNMcmtVdnFNQ1FqQmZ6Z01YcGZlaXZMMjJzdlU4YTNCaU4vVEhsQ2hnYURK?=
 =?utf-8?B?U3B4NllQWlc4NUNacFdUN2FJaDBLRVpoZGpDd2ZlOTR4d0pLNEZ2V3dZc05T?=
 =?utf-8?B?SVZIanl2aTB0WUJSVDNMSnpFb0w2UDRNaWZaa2pmbDkrRXVIN1BpR2dqRGFs?=
 =?utf-8?B?Nk1IV2hyZVlBbXZYaVFBYityaWRoTWtxcjk5bHhOQkh0Z3o1SUVlL3dGNVd5?=
 =?utf-8?B?OWxzU2hJZUVPK25Va3pYQms0L01qUm1EOTh3OTQrZ0JLUUlCZE02YmYzSE9k?=
 =?utf-8?B?ZTh4d1hib3huL0xMa2dIaE5EUFd6YVQzeWp1OGhEWndWWUZHOUcweU9ncUxj?=
 =?utf-8?B?dCt1T2lFcTB2d0t6L3JwWWRJeGZSRUdQeGtxUjNoeFlGV1FoWFJZbzJiWE5k?=
 =?utf-8?B?Mml3T0tidmhZZmRTSzVBdWZwMVM1ZG5STUdWRDhKU1ZJcUsxMzN2ZkoydE9z?=
 =?utf-8?B?T3VYV3Z6R3hwVk5YZ2RFNE91Wmp6cmgrUmpKNlUreVBLc2V1Z3paaTA3TDJh?=
 =?utf-8?B?L1hRK3JaT3dnNVpsV3RMTmFBRWRsMTRPcW0wWGUwbTZaMG51VlZhd2MwRFZD?=
 =?utf-8?B?VzE4M0FDRk5xdHJoR1dGR3k0dU5iK3VFc2UyaE9GcExQNG9OUDByOGIxRmd5?=
 =?utf-8?B?RmFUeHRHSFFkcEJuZ0s4ekRqSXJKeHBTNGVhckRVZ0tqTmR0SlJNQ0tSQlNp?=
 =?utf-8?B?eE1tb2VyK0d6RFFjYW5NYUdvYVR2OVlTcFdOZjR0aHpxZFJZMmVER2tzOUlB?=
 =?utf-8?B?MXVvcjJ0cXNFbFU4b2pKaTZ3OU5DRG9HSEpUK1NaK0M1ejlza0dJV3hQdXdi?=
 =?utf-8?B?Q3Vvd0loN0dCSGZZNHBYelZBZjhRZU1JTVVGWWg2bWpkRGJsbkpZTTNualZh?=
 =?utf-8?B?aDZJT3A1UjlBWCtVM0U0Wk1HelRkZlJkQ2U4L0tWLzJkRXBaa2ZkcUI3N2tI?=
 =?utf-8?B?UFBrMlJUNk9RTFlOSC9hMmRVOGVieWdMSUkvRDVRaGUrNEVBREFlQU8zZkpK?=
 =?utf-8?B?MzF0QkRwSTdLeEVjMEVFQmpXN0lRZkNnSWZ0dkxZMDdvQ3pBZ0tTemdjdW1p?=
 =?utf-8?B?dDFsUlBBVDVYOVdmSEpudlVkSEFZVUJXdXFWMjRQajFQSHJPMGxHK25Bc0Fo?=
 =?utf-8?B?dGJwT1Jubm1EKzJLTjByd1dmVVJSSXdleVVLZTNFOXQ3R09STG9Vb2pFaGYw?=
 =?utf-8?B?OUszZ3JBVTFnaUIzZENKQkttNlJTeU5OZTRnQUlYZ1NGejlrUndHMEtNUWh6?=
 =?utf-8?B?cmducUNMWmg1SjBmdVdaTnJtNDNQVFBHRHJrcmVzSUVYUFNBZThER01Bam9L?=
 =?utf-8?B?SXRQb3lzT2VET3BpNnBhejl5VlYva3dCb3BmTjRCcFBNMDRqck1xdzVzVjRX?=
 =?utf-8?B?czlYRmVzakF4NjZTQ1NvblhUWWZqVmZPOWZteEo2QUV2eUxHQS93NkdGMDlk?=
 =?utf-8?B?U1RWSy8vcFB2ZnAyS3FkcE9uUHRBT2xjdnljTnBjNk1PL1NGVmRrS2ZyYUtx?=
 =?utf-8?B?QnF4dERjUCtnZ3FHcS96dnF3UzhjWmRLVVhmQm5TWUh1aDZVdXVsM3gwekky?=
 =?utf-8?B?SnY5NFdpWmdLVnVtaUtUaDdUTEdlTWRtOHZ6NU9LakFGbkZtbW5Yak1WUkUv?=
 =?utf-8?B?bHkyVmRsNS95K0E1SWRadWFkQnFZZ21pRkdMbGVkVDl6eVVHR2dIY1FQTGpl?=
 =?utf-8?B?a1lyWjE0T2Z6RjJEeDFRU0dxalZiQUdjQVNwSHIxY2Z1blBBY2lsNHBGQ2x6?=
 =?utf-8?B?TDBPMk9naDRRbDA3R1pqTllQaW1FU3BkY1Q2NDNMVjZHOXNrNVhnTy90dzZy?=
 =?utf-8?B?ck05ZnBxU09lWGtkUnhEUmRsYWJPbzJWa3JuN1pyWWgwR2VIWkR6L29kUm9n?=
 =?utf-8?B?SnArSm5TWXNFR0h5amZML3ZTNUI5ZzFYSDhSVEp1dzFjeS8yQ3Z2ZEtsQ3hl?=
 =?utf-8?B?Vk15WVdyNXkxb1F6UHFHazVPWDc2TXlTYWx3U3EyZmREMkJwTkVtcUNURElT?=
 =?utf-8?B?SFFua2RkQ2hzSC9JRFJ0UDRpcHkzbnM4UTl0K0VTTFVDM0NGck1rWnNhWkN4?=
 =?utf-8?B?UEZDWmdYTi9LOXQyR09RTGkrdmFGOGZiWTVVOGJ0cUFtNEZEOHNXb2kvTWtD?=
 =?utf-8?B?RmlMaTMxREFrRDhoNWorUFBYbkpFaWxJc0QvYmVvbFp2VGpYUE9XbEFTZlJC?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b841e32-84cf-4a60-e18a-08dbc42e95a9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 16:34:16.2842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVEkjOmcW+KIMMbigQK9q3qlj/LLSnVndKU2tRPyy91llEetQE9tjb4V0Maqz/afOpaSnIeDYaLlKlqttXuub1EYdpE9iMRr5I7R9sUB2FI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7655
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/3/2023 9:16 AM, Luck, Tony wrote:
>> The Sub-NUMA cluster feature on some Intel processors partitions
>> the CPUs that share an L3 cache into two or more sets. This plays
>> havoc with the Resource Director Technology (RDT) monitoring features.
>> Prior to this patch Intel has advised that SNC and RDT are incompatible.
>>
>> Some of these CPU support an MSR that can partition the RMID
>> counters in the same way. This allows for monitoring features
>> to be used (with the caveat that memory accesses between different
>> SNC NUMA nodes may still not be counted accuratlely.

The typo that I pointed out in V4 as well as V5 remains.
Not fixing something this fundamental reflects poorly on the rest
of this work.

Reinette

