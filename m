Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109D775A420
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGTBxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjGTBxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:53:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF52C1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689817991; x=1721353991;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aErGrPApw85ggJd+g6FrYsFHBMlQ8O3FY9RuMTZs0HA=;
  b=aaAENaAijIag14AmwxC5suuaVfUG975fwaYtpEocHFP0BvCyYDt6qeOH
   Fx3TKVy6DUWFXM7NSEXC1BaW10B4/4p4MWriBlzxkk0Xyl3JNU0TGyowB
   hAOJdfmxST3pQe2e86UKqzHcVmnWKEUyWih2Ox5A8giT/KZjQlr4GOovF
   uIJaT0SNjMgpJNzorU9fmukA9K99XMAOPsWbE70Ajrp9mwooOfAhdahM/
   /cftF0iBY4mf+8hasEzJxuNXVTN3YMPtcqrvgjCYkHFJGdTzOoMnjYb0+
   YDYcU/wY2yLPiwZaLOqk/ABR+tqOqs7YaviuFI5Z9BT1rcgErOAOfVIPU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="356576286"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="356576286"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 18:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="789610553"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="789610553"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jul 2023 18:53:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 18:53:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 18:53:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 18:53:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiHmIBp6tBDPAXWBG9o/7i3/vhbBewho+zDKx6yaW3lEzi1W2+2YVp2j9+3pXXwnJooC0+7PgNFLnhur70fpMjzGYiQR3AT+pKWGChVN9Xp2VgOBhl97SzpIo1H46uPKBSa+m3Nb6NnasPHG17vTDah6mc923f5v/WPGxV0OKnVGPGqGHf2woJqrLGddEkXRCqoWQh7OVbxRVjWVQRP1wo+TmSimgS5dqHJON/8Mxt64Nb4RAfepX5aYixRjn6HvwT1G3l2XJo1zxZmMJK1vvnhjTl+Atsqj//NBhurlvLk2xlZh75NkRDdojaMTewt7iGF9pUak18mqB7A98xoPZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTQXmE8oPuaAQPelO6PDwO+cJSxAk7R75qaXW9RaLwI=;
 b=EP3HlSPvmrLmudc1VV5CxwLp8XWnzdmryDx6z79kSYd3IUH1B7zg8peTveXRXtB/Fz0RzJWLQQGnDhnQL2uahSN26xKGPqFsKnNy3kLw5TI0M09hRlLGoYWGyW9WC0arK1CCJFjEuiCr65ofnzZae69M5Vxo00XCzYQMrehfRhevpF2lpGaMyi9FfZLCdz6GtdtZ3dv7MzppmNUgUP7z0kF6QGbBjvIqOCFXVd1hFcjo5KSmDHTQfzN9kEjfnZXcHUCGaGKTouJZ2MTWgutCeEC2voBoQr/TYiJqd0B8zf4eZ+7MFz+rVld4SwbIrH8c5VCblnHIEuL3igh5QGOMZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW4PR11MB6690.namprd11.prod.outlook.com (2603:10b6:303:1e8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Thu, 20 Jul
 2023 01:53:08 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 01:53:08 +0000
Message-ID: <65523232-58d4-a8c7-50ff-8f44f7ac23fc@intel.com>
Date:   Thu, 20 Jul 2023 09:52:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 3/3] mm: mlock: update mlock_pte_range to handle
 large folio
To:     Hugh Dickins <hughd@google.com>
CC:     Yosry Ahmed <yosryahmed@google.com>, Yu Zhao <yuzhao@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>
References: <20230712060144.3006358-1-fengwei.yin@intel.com>
 <CAOUHufYef--8MxFettL6fOGjVx2vyZHZQU6EEaTCoW0XBvuC8Q@mail.gmail.com>
 <CAOUHufZ6=9P_=CAOQyw0xw-3q707q-1FVV09dBNDC-hpcpj2Pg@mail.gmail.com>
 <40cbc39e-5179-c2f4-3cea-0a98395aaff1@intel.com>
 <CAOUHufZHyEvU-c2O6B6stM_QVMxc22zV4Szn52myYqjdZvptUA@mail.gmail.com>
 <16844254-7248-f557-b1eb-b8b102c877a2@intel.com>
 <CAJD7tkYAkVOE2caqEj_hTmm47Kex451prBQ1wKTRUiOwnDcwNA@mail.gmail.com>
 <b995e802-1500-6930-79d0-8cc4bfe89589@intel.com>
 <CAJD7tkZtHku-kaK02MAdgaxNzr9hQkPty=cw44R_9HdTS+Pd5w@mail.gmail.com>
 <CAJD7tkZWXdHwpW5AeKqmn6TVCXm1wmKr-2RN2baRJ7c4ciTJng@mail.gmail.com>
 <208aff10-8a32-6ab8-f03a-7f3c9d3ca0f7@intel.com>
 <CAJD7tkYT6EZMwit8C9MTftUxMmuWtn2YpZ+NSVhy0xVCYuafsg@mail.gmail.com>
 <438d6f6d-2571-69d9-844e-9af9e6b4f820@intel.com>
 <CAJD7tkYWH8umBFgmxPmeOkRF=pauVW=MvyyN+z17XMHN+q8JKg@mail.gmail.com>
 <e3044d46-3b38-dc2e-b8d2-8ec1033f85e7@intel.com>
 <79f6822-f2f8-aba4-b517-b661d07e2d@google.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <79f6822-f2f8-aba4-b517-b661d07e2d@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW4PR11MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0d7405-29b3-4c9e-fbf2-08db88c41057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjEDwbYRBE1KtvbgwA/qsNZe193/jLPNomSKDSWfjMjhQSAHDlwJjuidCSrFc6KD/XC6A0Tc6grWCiU3NJoZXWk7J6T1bRkC5cpkHzG0p0XnshdROceBwtLhmg79IDMVW8coLV5u42L+4opQmALoM4bf9hNPO4yJ3JC6QBWbHa7rcA6NFeS2RNyifRGZpEC9/3s5bXLdQR4dzbHU9GLcUtrwUOaXWQT5Ys5D+45vpsjYQi8dCy6SGdUPbxGXUA4MV/YT3aRB+fbiPOH1ou5T+AX+3OjVOIqii7kg+vD/TEMz2fI4abrkCfHG0/7UXTKpyVrNN2r+K7iZ0U6Ez+Wj8qOS2cB85TgadRLxbod8QoMA05Ygc+nN31y8zp4p1hCEJ1IhS2qyPd3MEyP3nqzmBmctk8IiDUD/fuaMlgiAqaOYdFEz9obCcnXkL3hi13HWqD6hzXWKD4PwGx/KRgd4VQe0L9dAelfUHpSQ++AEBCODg8oMx23O77EhLqlgaa5kj7D0mU4EU8LQROjRvMq+SUmpqpzwa9v2ZzVLHOjzMWj2hxeL3upWGhiI1iFKhgD/YMOZSs8xj94g/yJnKT37BBj4nfQEcv+X2QVGxmh5Hw+1hAO1yRSYeSYhHR5mvMAa17MP43mBZwxKWljIQj8s8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(53546011)(82960400001)(31696002)(6506007)(38100700002)(26005)(186003)(83380400001)(478600001)(54906003)(6486002)(66476007)(7416002)(6512007)(41300700001)(8676002)(8936002)(66556008)(2906002)(6916009)(66946007)(316002)(4326008)(6666004)(36756003)(5660300002)(2616005)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVpMSXNsMEJwMkp5RUZxV3VmZmV0M3JrYUh2ZXFoOHlMaXRiWithTXVNR3FL?=
 =?utf-8?B?Nk14cnhsYm9mQ3RleXM4ck5CZ3hCcitGWlFHcnF0cmtlVmpoTDd3MmxCSUUy?=
 =?utf-8?B?a01OdVFhZU1mMURZOXpvQjV2ZEZiV2prbnNoaE1TaU4xWGd6NWV2SFZzbFRv?=
 =?utf-8?B?dlMreTRSRjVyTGNFOWtndlFubzE5d01ZS2g5eWt5YnlCdXgrMnpmMWZKWGNn?=
 =?utf-8?B?alBjUkhFU0pzcHVxTWFoalZkdGxxMnc2WjJyd3J4Q2JSU0VuVVVIR1dNRjNs?=
 =?utf-8?B?M3FGZVl4Tm15TlhPNU9hTmlMbVo4N01FdHpxbGRya2dmOGlJY2U3RE5MbHh3?=
 =?utf-8?B?SFVnQUgzTFlrVXJoZ1ltamtrZFV6ZHcvUTIyTW5LUVhzTEhpOE0yYUJqRHIz?=
 =?utf-8?B?M1E0bWorUHNQMCtHRVhNVm1GVGZDREVWTlNTZUROVmY5RlQ5N1NFMHIwRkJw?=
 =?utf-8?B?a1E3aFN1WStkbVBZSHE1SzFOeXJnUGt2eXZrQ21iQjFDNk9zRUg2d3NUU09w?=
 =?utf-8?B?S3Z5MzZOdVpyWE56ZjFkTHVQaEFLeFZXZkREcHR4a1ZoOWlqUkZHckZ5b0NL?=
 =?utf-8?B?eEhLVy9INGVZSVZXMFVleGJvc3hmTGMxNzR2akRzL21sZlBmTi82ZnVxaGQ0?=
 =?utf-8?B?VlR4Mnp5UzRja1ZHQWhPWDlwVXRYWE9TbmErWFNUVUczMGNtK1BNWnZXQkdK?=
 =?utf-8?B?UGJxbTdZTlpyMERFMnVyaHB1blJ1QU0rWnIzRXlkbTNVd3lZaHh5U3R3Umx3?=
 =?utf-8?B?eGI4SWpZUE9URW9jaFN6clpOY3kyc2pPNXFXYWRabzUyeS81UDY1N3BCK3d2?=
 =?utf-8?B?dkV4ZWtVaGxGREV0cExNeFVLR1N1clFCOXg2UXdVZzMrbkJJRlBEMGVvWFdk?=
 =?utf-8?B?TDYwTkE2SWY0RTBnaEpicDdWRVhmN1h5MjBlTXRXbm5OTXZ1NGVjQTE3b3pu?=
 =?utf-8?B?bFY2OFliSXlkam9LOHpncG04SzlIemlYaVg4b0E2ZVVTenhVZ1VhdlFWR3pH?=
 =?utf-8?B?cHRENGFRMXUrVEdweFRtSGdKK3o2WVpxTGoxcWRVVjY2OTRWcTZoY1V1TzRI?=
 =?utf-8?B?ZkVZZXJEVjVmNzJHOTFqRXozNGhjR2MyTEJWOHMxVnN5WiswYlNTOHRCZ2JG?=
 =?utf-8?B?NlFqSExHcnc1c2xab1BiOXdTMGNuZjhjdllHTjlDYlBIYjlvRUtFb2doMXZt?=
 =?utf-8?B?MGE5aDhhQlA1d2VWZWxCTjZEbUdnVm9najRpcUdiWUJtTVN0eFpLM05qVEhk?=
 =?utf-8?B?NGlheVlBS2oyblpBWFlvK1piZHlKblg1ZEJ6K0lQK0VaZTV6WEYxcS9sMWM3?=
 =?utf-8?B?SmllR2hJRk01NWNrdUxnNkdFcjBiOXYvZ2FlaHE0ZXJUeUtpSmxra2lYYWlv?=
 =?utf-8?B?amFOc1RXZk1jTG1mWUJmRWpKK1VwbkxSOGg3NjU2d1dDVEF1Qm5BZTRXMzkv?=
 =?utf-8?B?dFEzRFpNV3ZOUnpEbVhNRXlnZ1cvczB6QkxMTjlPenFyV2tJMWk5WEVETVNn?=
 =?utf-8?B?RVgraFF6QW43Z1UrTzBtTHRVRWVycUdhRU1FbDVxZlV4UGtRZGtRaFRvaWNl?=
 =?utf-8?B?aE1UUENIVDh5TExiTDdSc2R5bGEzSWtxeCsxY3FaRWZmalBwaWRKMXowdFhk?=
 =?utf-8?B?WWJJbkJOK0xJYnF1cXN1MzZJMTExdzJKMHowV1lEU2FtM1pxcFhyMWcwaE1Z?=
 =?utf-8?B?dUxGUzFoZEtxdUh5UVZrTi9kS0M5QUIyNEgzVDNkZmQwMGF4d2ZYQ0Zkd2JS?=
 =?utf-8?B?REU0TkdPdGFmTXR1UnMySVRiQ0dyQnRnZmp6SWl1T2tiUURzY05XVmhHS0lk?=
 =?utf-8?B?K01pSHYvUklQTlhLRkt0K0l6WG95WEMxU243Q21pOHRuL0lqTU5Bb1o2cGpR?=
 =?utf-8?B?TmhyVENnbXUrbmkwRHA5dktFaWVnSXlqaXdPYXVKYVBDREg5Wmgrc3E3UWxV?=
 =?utf-8?B?dHFlOS9CZjMvSnFDVTI5dDhuSkFXNTZtVlU1dXhuWlNLV3NuQlZlbE52RThk?=
 =?utf-8?B?cGpneGJ0a1lnT0EzWEpKRVJPRCtLMzMzbFlPQ3kyN3dtM002WHVEVTlXOUVh?=
 =?utf-8?B?OERxc29oK0NXS2dvS21vcnVsa2FvaUZNc2xTN1dCaDUrQmsyV2FYZ0NKSkht?=
 =?utf-8?Q?JvtJyM1uiTs0JQE3HSMCfGtx8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0d7405-29b3-4c9e-fbf2-08db88c41057
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 01:53:07.5666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbsfOZWJ4T+QuAAdqWTcWc2Oc9g18j5Dw2S773+w+WZiBm7ET8UMW2F6A6AW3fPy1K5VMvx4oYIblute/MkIkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6690
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/2023 10:26 PM, Hugh Dickins wrote:
> On Wed, 19 Jul 2023, Yin Fengwei wrote:
>>>>>>>>>>> Could this also happen against normal 4K page? I mean when user try to munlock
>>>>>>>>>>> a normal 4K page and this 4K page is isolated. So it become unevictable page?
>>>>>>>>>> Looks like it can be possible. If cpu 1 is in __munlock_folio() and
>>>>>>>>>> cpu 2 is isolating the folio for any purpose:
>>>>>>>>>>
>>>>>>>>>> cpu1                        cpu2
>>>>>>>>>>                             isolate folio
>>>>>>>>>> folio_test_clear_lru() // 0
>>>>>>>>>>                             putback folio // add to unevictable list
>>>>>>>>>> folio_test_clear_mlocked()
>>>>>>>                                folio_set_lru()
>> Let's wait the response from Huge and Yu. :).
> 
> I haven't been able to give it enough thought, but I suspect you are right:
> that the current __munlock_folio() is deficient when folio_test_clear_lru()
> fails.
> 
> (Though it has not been reported as a problem in practice: perhaps because
> so few places try to isolate from the unevictable "list".)
> 
> I forget what my order of development was, but it's likely that I first
> wrote the version for our own internal kernel - which used our original
> lruvec locking, which did not depend on getting PG_lru first (having got
> lru_lock, it checked memcg, then tried again if that had changed).
> 
> I was uneasy with the PG_lru aspect of upstream lru_lock implementation,
> but it turned out to work okay - elsewhere; but it looks as if I missed
> its implication when adapting __munlock_page() for upstream.
> 
> If I were trying to fix this __munlock_folio() race myself (sorry, I'm
> not), I would first look at that aspect: instead of folio_test_clear_lru()
> behaving always like a trylock, could "folio_wait_clear_lru()" or whatever
> spin waiting for PG_lru here?
Considering following sequence:
    CPU1 (migration)                            CPU2 (mlock)

    isolation page (clear lru)                  mlock_pte_range
        try_to_migrate                              -> take_pte_lock
            try_to_migrate_one                      munlock_folio
                pvmw -> take pte lock                   __munlock_folio if batch full
                                                           folio_wait_clear_lru

deadlock may happen.


Regards
Yin, Fengwei

> 
> Hugh
