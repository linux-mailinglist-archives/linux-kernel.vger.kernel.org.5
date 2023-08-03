Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D99876E355
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjHCIkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjHCIkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:40:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7532D69
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691051975; x=1722587975;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mOyeXUV0blgcbrDtyOItVlDiAOyW6a5YD1uTPB7bdNg=;
  b=j7xeKxZRWepRTV/JhduujEqcH9sPujh8yzmWCtAshm940PplpbJaaiNZ
   TbJUIpkILPDsjrVRqtWdCpot+Q+w9q1TaDc1Ir4p5ByAahcZvU4cfYJkT
   xw49mxnks1xijbN8Q9CKaL0hJkWDcHfmN4AvsYhOe41H7rbeSOmFDaAVr
   whmaq7BfxYYW33mvqyEZ54fto5hI+OJ+gCBTkFiBKcJHaPeVc+FqLwasj
   8baPFN79fSJE8nQCkxWHcc6POQgmZg9e7XejE1RledemWIVXxHuYhYmRu
   bYuqKP03owRmABKxsVsJIwiKoJr2Gv1lLvP1AIUNW52wRiDtZFskAA3fU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368713414"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="368713414"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 01:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872844459"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 03 Aug 2023 01:39:36 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 01:39:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 01:39:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 01:39:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1hasWidc+Ob9vCTyfeIw8vUwyFnWgYxKMlu6tZU1z4LkHH+UjeknUY1btgq/JwDAkM5emfgQX1Hk0cPZO2EKplMbhaY92epsKW4bTbcdcNuvFBN7ZhVwmsI02XS/lJjVo23k5VJDEdOlSSnNR1CaLidwo2GiO+0W6iTMgthFsd+s0TC3H8kZPLzLlONUYqwlURi5OwUWtqV5zy5qj6ZwX0W/el4nS9gmmEILvz84LqRwrXco70ZjOHDPhVSEYWt/DZpuPrBNYfnFLO2ext/LOs9Q2GUHP02cjPUciAuVt/8kEcGkl/QcovU5mG7XMXP+tDy0cePtnZm2hVI/Krzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rYPJrBuM4cbcJaXx7JUOQNGiBHAG+RUQ1kV0J08sms=;
 b=QH9XX0ggtQcgMpUFnBEKlJ1ZN0kpd7cFzsgJhze89aXDOxCWgVYQEa+boaL3/k/Vi4UdXj2DqhJcIPUVrJkVQ8l27rQvzXFwc2SbakIcEwQ4Zm9MFxZ+gfZTcNXed3dgTkakquMAuUH24KKmTelGe5IeDANPFsIY+8zfN5fmeOIZIoCFTTDHao9AOPNaPPISGjzpJQiXS+cGGOsZ/tXsm75cDr50j5rs7M8MYwYID5TyEB9VHu7nlG42fsJQFxd/kiiulpwSj7lCZrkqyn0q8D9GTjMx4yNmK+qem/UOD30+1aWqKQhn/RYInP2eA0GFf8lpPWlEumrgPaTH+80rWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB6172.namprd11.prod.outlook.com (2603:10b6:208:3e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 08:39:32 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 08:39:31 +0000
Message-ID: <2d947a72-c295-e4c5-4176-4c59cc250e39@intel.com>
Date:   Thu, 3 Aug 2023 16:37:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
 <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com>
 <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com>
 <4ae53b2a-e069-f579-428d-ac6f744cd19a@intel.com>
 <49142e18-fd4e-6487-113a-3112b1c17dbe@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <49142e18-fd4e-6487-113a-3112b1c17dbe@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: d8725058-296b-4b5e-0ec6-08db93fd2878
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c28u5H8PD2FZtFh7PriFsKo59WRA5m8YIO5sZsMdaslIyPm0InXTvUWU2hEmEZ5SH0EQagM1E573ldqDMuWxpZpFkPuWkxOBzzFF+APQS3SaQ4+mMBweppOJJ6KhOQ+fI7YiIXQfs2P4dlRVbTiN05H6sTidg9PoDdV+3A31yeGV4uhKH3xHGI7HUcZ553ujG5xeQ+ukXG/SnsChb4z62JG4foxRxf2exl9MAv4AcnGM9TMRphexSTDY/si58mKxQRaoZMJwbC5Zjhfr7GHCSzvwOxrklRrKCzrKr0NldKtfjTcrHB7+H803oM/n/myQoLnPG+fUTBn9k2aRGLFIoDi1yCFaIEbgT9wWyltlYrmbxzK9JrawnJvemEq5xQjZ0rNdDVwNNJheDnv6q0TsoZD6wsr1f7C3zExOkMdwqF6ULnrO6Ot2n96cU+nO6v4ick9Q4of4WRZ7Fl/UL5jRdVmdKwfMSxgpsu2dHsawAfQdoAGd7/YpV3PLgKNuJp097JJL2YOzo+474wF9TKKM/NjkRzVJadfcNDLtBvDQprKYo0VG6uTkX2Aa2khPyYsLxk2tqh8dC/iL5H7CZXNuABeVY6ZSxGD7AkX5IvMrr1fD9CwWBNMk5fWDv56AZQoGu09xUBmUWPguKEDZ4/SIrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(86362001)(36756003)(31696002)(31686004)(54906003)(478600001)(110136005)(38100700002)(82960400001)(2616005)(6506007)(186003)(26005)(83380400001)(53546011)(8676002)(8936002)(6666004)(41300700001)(6512007)(6486002)(316002)(66476007)(66556008)(5660300002)(4326008)(7416002)(66946007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTVyQzZ3dXFmTkE3NXc4RXBPa1hpQzBrbGg3TEJKT1VreERwRld3bVhHZ3BR?=
 =?utf-8?B?bWtaRlNzSFNjNkkyRVNnY0tudzRKU1VqbEVCZ2I2cjR2bzRqZEZkVTVQMzVG?=
 =?utf-8?B?UXdmc0ZmZnJKaks5c2pudnVlTU5yU2xWMXMzc3hhbUM1Uy9uNTVQWm1mb2I5?=
 =?utf-8?B?OW94RXVHTGlDV0hscTZUdXlWK04yL1JHbU0wKzM4eFBGVWFzZDh2a3RJemFH?=
 =?utf-8?B?QjNheVlyQlVJSU9DVEpUcjB4eWdhU093SDM1Q3B5Z05IdWcwcDA5dFI4ODZP?=
 =?utf-8?B?d1hCaFJaU28yK2Z6RTI2d0RVeVk0SDB3RVZrNjdMRHZUendxdHc2TjNXUkpn?=
 =?utf-8?B?NWZHallleEp6NjNTMlQ0RzB2SWdnRGhpTGFCNzZFMVZTVXR1dU53VTVKMDJG?=
 =?utf-8?B?Mys5N0lUbU95NFVXTVhzTWgrODBtbU4xR2RMck1nU1QrN0N1OWwvTitDdHpV?=
 =?utf-8?B?ZVBtNmQ5NTFaZUxzZVlvVXNkWXpnaHhTb1FIRmRyUkRrVnNvNVJGVHAvMng0?=
 =?utf-8?B?OGw4Q3FrbVlTZ2oxd1VqVzV2WlBkaVk5YTUrMzBDN21GZWZXaUlsUS96b205?=
 =?utf-8?B?OG9JTTFZS0FCbjhZRUM3Zjc2dXhyaHQxZE81Z3hjSjUzS3lhRkU4aktzd21F?=
 =?utf-8?B?bkpxMjloSkpYbUpFMHJYM2srYVlUVGZMYVBhc3ZWdnpuL1V1Mkw5OXZJZUNi?=
 =?utf-8?B?NDVJVjd0ZkwrQTlYNFJnTUorUkhIa3pNS0FTTktSU1ZRTklBNHQ5QVZWNlZ4?=
 =?utf-8?B?QkVaUExMZXczcnJjUXhhbXh5TVdZcFpyZkNFanAxVEx5K3hjMTFpY004c1ZE?=
 =?utf-8?B?eEtHUmxXRjB4dCsybjIrWjBiQTN6R3Fucld4VmVOTU9VWnlZTmduTXlQcDF1?=
 =?utf-8?B?V2Y5d3VFdkZGbXBoYVI1TWV4YmFpZUZTQlNOWk9UN2Y3ei9aZTJmQ2VScUEw?=
 =?utf-8?B?U3BhWHljdXZCRFFJSWpEYXl2a2JFNm5BVU1nbkpSRHU3VU9WM3BkbW5nK0dD?=
 =?utf-8?B?YXpoODNEdEVEbkk3dlNaY1FoUm53ZzliNE5VWkZqQW0wNVdOZDAvOUNKVEdp?=
 =?utf-8?B?VFcyWm5WNDhlMHg3cHRIRlpxT3hoY2RPUnhNdm9uVDZUQ0JiK201MnlqcXo4?=
 =?utf-8?B?ZW5wZmYxN1JPL2taRFNxYmlGdklTNkNqNGFDUFFGTVJvMzFzZXJPWFUxZlNV?=
 =?utf-8?B?TW10Z1ozNnJSK0ZUWnBaK0J2cUlxeG1KbnRGOHQ0TzdIVXBrNEF3aXQyMEli?=
 =?utf-8?B?dnlrOUJzWTZOZFRNbHpVeHBESHkzVWp2NDZuSEEzUmtmOFJyOU54RFlXNUpn?=
 =?utf-8?B?WVZZTnRXMzd2N0I5T2VDdVFnMnRWeWQ5MWtqNitvQ2ZqZmprMzZMSlVSaGtX?=
 =?utf-8?B?ajRvaGxCb04wNUcxTEVINWp3cUhlVS9WdEptS05kMTBBOGYzakRqSG5FTEht?=
 =?utf-8?B?Zy9rdmNNSk9VNEN4UEZnT2R2Wk13MGxNdXpEV2doVm1vYlFTWDMyWFB6bnZh?=
 =?utf-8?B?SC9WeXRWNldUbEtDYy9oemsrdXlyelVWNksra1JJRmJwMWRscmtnNzZtWkEx?=
 =?utf-8?B?N3VsaFZsTWpGY01TbVlaME9hSzRITTVmMU1iSE5UMUZLS0FqL3hYeTdRMUNh?=
 =?utf-8?B?S2c1aXR5czVNaFdNUW9DeithaHZKbjd4T21Gcm1lTmQ2ZVJ4dmVPenUrYitE?=
 =?utf-8?B?ZnlmQSsrTXl6Z3kyckJ5OW9NcXlHeFpvRnN2MWg3UG1sekxMZmV1TDVlTGR1?=
 =?utf-8?B?Z0R5cmMrRTRFdVgveGQ2b0FBVEFHVUVWMDNnMm0yd1RFRWxXS2hzUTdHanRu?=
 =?utf-8?B?UmxpTHVVU2dYRitJTVRlWWlGc2F5S3phR1lFM3VIbXNvZTVrS0dmK2F6SnNP?=
 =?utf-8?B?bDVUMHJIWUhlTlFoYlllRGZkY1d1d212VmlGS3UwMkNSQm1LdjhwTWMrSkVD?=
 =?utf-8?B?MFZmeDg4a0FPQ2hNT01CSHhyQkRQekVFa0ZmK3l5Q3V0dUhBQ25HdmYxU3lq?=
 =?utf-8?B?ZTNZNkFhREFsZEphNDZkd3ZnNUpFRmkrUVNoQTJHSlJIa2RicWxwUW1seTh6?=
 =?utf-8?B?L0l0cDdHTWNyN3h4c3JsU2hRQ3ZlbDNOb3g3Uml6aUhMRlk1NFk5bWp2YXZu?=
 =?utf-8?B?RWpOSWtvSEtBRFZ6T1VxcEtobTdWWVNjUjY3a21UVGdncFJabmRmRlVyTWVS?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8725058-296b-4b5e-0ec6-08db93fd2878
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 08:39:31.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BbbNSw3XmykUIVVAgNhZ10fdy5KFMIzyvVmMKhyhUWYF4osMultLtwbSD5AnuM+sAqBQjFtVKt4v5YK1mtFZRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6172
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 16:21, Ryan Roberts wrote:
> On 03/08/2023 09:05, Yin Fengwei wrote:
> 
> ...
> 
>>> I've captured run time and peak memory usage, and taken the mean. The stdev for
>>> the peak memory usage is big-ish, but I'm confident this still captures the
>>> central tendancy well:
>>>
>>> | MAX_ORDER_UNHINTED |   real-time |   kern-time |   user-time | peak memory |
>>> |:-------------------|------------:|------------:|------------:|:------------|
>>> | 4k                 |        0.0% |        0.0% |        0.0% |        0.0% |
>>> | 16k                |       -3.6% |      -26.5% |       -0.5% |       -0.1% |
>>> | 32k                |       -4.8% |      -37.4% |       -0.6% |       -0.1% |
>>> | 64k                |       -5.7% |      -42.0% |       -0.6% |       -1.1% |
>>> | 128k               |       -5.6% |      -42.1% |       -0.7% |        1.4% |
>>> | 256k               |       -4.9% |      -41.9% |       -0.4% |        1.9% |
>>
>> Here is my test result:
>>
>> 		real		user		sys
>> hink-4k:	 0%		0%		0%
>> hink-16K:	-3%		0.1%		-18.3%
>> hink-32K:	-4%		0.2%		-27.2%
>> hink-64K:	-4%		0.5%		-31.0%
>> hink-128K:	-4%		0.9%		-33.7%
>> hink-256K:	-5%		1%		-34.6%
>>
>>
>> I used command: 
>> /usr/bin/time -f "\t%E real,\t%U user,\t%S sys" make -skj96 allmodconfig all
>> to build kernel and collect the real time/user time/kernel time.
>> /sys/kernel/mm/transparent_hugepage/enabled is "madvise".
>> Let me know if you have any question about the test.
> 
> Thanks for doing this! I have a couple of questions:
> 
>  - how many times did you run each test?
     Three times for each ANON_FOLIO_MAX_ORDER_UNHINTED. The stddev is quite
     small like less than %1.
> 
>  - how did you configure the large page size? (I sent an email out yesterday
>    saying that I was doing it wrong from my tests, so the 128k and 256k results
>    for my test set are not valid.
     I changed the ANON_FOLIO_MAX_ORDER_UNHINTED definition manually every time.

> 
>  - what does "hink" mean??
     Sorry for the typo. It should be ANON_FOLIO_MAX_ORDER_UNHINTED.

> 
>>
>> I also find one strange behavior with this version. It's related with why
>> I need to set the /sys/kernel/mm/transparent_hugepage/enabled to "madvise".
>> If it's "never", the large folio is disabled either.
>> If it's "always", the THP will be active before large folio. So the system is
>> in the mixed mode. it's not suitable for this test.
> 
> We had a discussion around this in the THP meeting yesterday. I'm going to write
> this up propoerly so we can have proper systematic discussion. The tentative
> conclusion is that MADV_NOHUGEPAGE must continue to mean "do not fault in more
> than is absolutely necessary". I would assume we need to extend that thinking to
> the process-wide and system-wide knobs (as is done in the patch), but we didn't
> explicitly say so in the meeting.
There are cases that THP is not appreciated because of the latency or memory
consumption. For these cases, large folio may fill the gap as less latency and
memory consumption.


So if disabling THP means large folio can't be used, we loose the chance to
benefit those cases with large folio.


Regards
Yin, Fengwei

> 
> My intention is that if you have requested THP and your vma is big enough for
> PMD-size then you get that, else you fallback to large anon folios. And if you
> have neither opted in nor out, then you get large anon folios.
> 
> We talked about the idea of adding a new knob that let's you set the max order,
> but that needs a lot more thought.
> 
> Anyway, as I said, I'll write it up so we can all systematically discuss.
> 
>>
>> So if it's "never", large folio is disabled. But why "madvise" enables large
>> folio unconditionly? Suppose it's only enabled for the VMA range which user
>> madvise large folio (or THP)?
>>
>> Specific for the hink setting, my understand is that we can't choose it only
>> by this testing. Other workloads may have different behavior with differnt
>> hink setting.
>>
>>
>> Regards
>> Yin, Fengwei
>>
> 
