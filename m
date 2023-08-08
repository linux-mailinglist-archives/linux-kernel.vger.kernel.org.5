Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D38D773F04
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjHHQk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjHHQju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:39:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E788A15B88;
        Tue,  8 Aug 2023 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510072; x=1723046072;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=skUOHDXeOlvMiLatQPrgoMDG6IJaFBnHBUC2Eu4yBRg=;
  b=SjqGGMvDODVbGBi3q/Tz0UN2WdjUXJZZqtVpzrpWOFMGi5VVizfKsBRl
   WpaiTehV68QxtPJX+BRvB7V+1AkO5+dFGEBg0xz3eTo/wwlVoc+Mjrzjc
   5f7/hf+9G1sRxy9sg9x6Uo2lLNvgAetBOJbfQGXiuhcuh/GxYuYkS5TLc
   XH/IYtrMzsGEdW1zzKuV3JYtaDB3snlkWvC7lNhsdmQJO2tLN5FtlTDVj
   34fdp7/iaPUSI04BzmvGEH553iBhwgaJvnYYhAwQJPoh7mh7hAnhHwF4v
   Mk4MTfi7rs5eFpGJ5RKDfECU9JqCYa+Ns8FWbUXUWJuECE8tIfDlnwNlB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369608841"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="369608841"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2023 21:11:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821202368"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="821202368"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2023 21:11:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 21:11:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 7 Aug 2023 21:11:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 7 Aug 2023 21:11:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXedRBMaKCjiOqu97Nb5jCHoLE7cDW9CjGoVVfhTmYG7CuTaIDI++f4dRxWPkZLl5ooziGaV4QhIPZwQKT77/HNaiUd5YI1LhrntQ94Kkzu0OZJVJU8Az8HF+E9qYS3XCmdl/O3tXzjABu53M+a/3QVvCnwSx9UD9uitmqGM9e+MBKy3Khc1fenhd1NjDJWHOEMhIwZXBXY9CHXBRL+cuAs+OyNQEgosgqcHhdS/RptzpuB5maXZn0XX2vHOaMRD1Ix9/VX0q8uF4bGzFOXspPGHHyT74GjxurEKLMdywgue9sIju1d5AhIKyW8Y1+4gxwFREiiz+IHjH3fvzORa8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39Jle6tY02c9lk/gradx6wDFnhdgjeFi7ht0sSRd+Jo=;
 b=W3otYA6rw5tOulHdOCu52iaAgz6hmX2p60LOraP6vkUz4JmldMFFYe6wCPVZSZZq4gw6t87FRnOI3lbAAaAkq58A37yqo/gV3+i02RI1jQPgtokdvhhGtEvHtJ4KDCdSI864eHEyNaT31aSiMpC3EVqY8OMNNbEngChtUWmbicEfpWX0b2VLFTXDnAFK7aJTzSigRXg6ySRUFMvfrsiZoSE7IIOvowMlDX/ouVBR2sll9oOwtEcmFPZCIkK4G3yuL2EgjfoNnE1IO7OYfRNyNGxKQWE2ingpMM3Yo0LA4j4pYQIJQS1LGcflcW+lDKHOyJv2MxccAOPc/Bj9Zy04HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 04:11:05 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::221b:d422:710b:c9e6%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 04:11:05 +0000
Message-ID: <ebcaa6d3-a984-4916-a010-364e11e868ff@intel.com>
Date:   Tue, 8 Aug 2023 12:10:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] don't use mapcount() to check large folio sharing
To:     Yu Zhao <yuzhao@google.com>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <willy@infradead.org>,
        <vishal.moola@gmail.com>, <wangkefeng.wang@huawei.com>,
        <minchan@kernel.org>, <david@redhat.com>, <ryan.roberts@arm.com>,
        <shy828301@gmail.com>
References: <20230808020917.2230692-1-fengwei.yin@intel.com>
 <CAOUHufa99BbKi3pq2xxrNEzygULE-brUELK=DLU89REW-GT-Vw@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufa99BbKi3pq2xxrNEzygULE-brUELK=DLU89REW-GT-Vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::12) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 914c7818-aa5a-42db-3888-08db97c57c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1B9zl75Q24IF8Vu3Zz2a/Fgs2Ry7Il+pvijiBG8X5bCTbGe90vVswDBYp6ulzy9xz2joEPnZQ1Z1IazUzCusEK3ZbL0a3l0Pag5eVuRqwJ+A6UCVc/Uv82/Xgbi+UifwBxrSpHmkFaCtSbEK8lVczZ+QJ9iF/nEHGi7NnSvP0SaHEw9rpHqM0LANkSGiDbUcaClTTWGorcwXzmuBjaI6U+6Aa6gTeN5qRgBAXjvCGudSlRiZvMX1zuCOpmykajltjO841up6t0fNJLO73aLxKM7hVtOgjn0UAnaETge9EIREO++W3cfg4Xwtwh3FGY4GfXCkzDqcuavkrn8DhjWFdDZ1BT80JhLb0axJIjJAs+RGCgmui+fZpn9JrJkgwuuTM+ykfiQaJJlLhTaI01p0mIJEzeGFrtSrXT2sBHFPznQlnFF7PjAOhM4+zniSU0wry7bUu5PE/8LB8EmBPkyaT65Tf5ZjfxNdvJ6FOodgv6Q+LZ34pSidKFQ3srLQ8S52zihoAvXzgs7ZFoMgziMf/cO0gGocSdxkc2G8pTAriMszUA3i4dD0q20cAGJrTha6Ttm+6DB1i94Nq5VqWdlGPH+1DdzfVIEwhMRs3NRNLJGRfzhN7oIC6PRsiVtP9wuGNvy+I3JMjp5H8shq3/LSm1AMX7TLybkhmeI3dXb6Hniw0uKhek0p8rNe5NLhtHAe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(39860400002)(136003)(186006)(451199021)(90021799007)(1800799003)(90011799007)(8676002)(7416002)(8936002)(478600001)(5660300002)(41300700001)(31686004)(4326008)(316002)(38100700002)(66476007)(66556008)(66946007)(86362001)(26005)(6506007)(53546011)(2906002)(31696002)(82960400001)(966005)(6512007)(6666004)(6486002)(36756003)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFaTHM2ZHd6cjZkMExORGMwNHhvS2I5UU1sRzdoaVRPeVpXaWlGOVhMU1Zh?=
 =?utf-8?B?S3F3REVSdzlrbzd4c1lRSC8xNWhHT1FjeUpyVDZSWkhTKzltblJQMmJlNlRN?=
 =?utf-8?B?SzJMemcrWEMzNnJjNWRkcS9Ub210VHYvRDV0REE3Q3ZLM1BNUmZKQjdnMEcr?=
 =?utf-8?B?elV5SzgyTUNIbkVJRFZUMWZSRnhIckt3RGlLZWErMHYvT0t6bnFMMWJqeHpv?=
 =?utf-8?B?KzVnRnkxR0lXamxlSVFxNHNuOWNsRUQ0UE82b2oxaDFja2UwQkN1TW9YUWww?=
 =?utf-8?B?UjUrMXFzcDQ3am84QUJLMXdObHQzcWxlbWt4eGVyQlk5SHB3WmtDcENQSGpP?=
 =?utf-8?B?clpUQWlrZC9ONXFOL29lN2cxeTVIZmM2Skl6UjUvUzF4ZlhLNWdZZFpUZFNr?=
 =?utf-8?B?eEFzU3dqZDB1WjdRbjNnSm9MVHdTdTBSWklTcFl4bUJqZ2VmaGpuaWZraWRU?=
 =?utf-8?B?SDN5U1plZTgvN0VZaFJDM2tvMWR0UmpWRWxUZUpHL2VjTWw5eDU5UWlNSFpX?=
 =?utf-8?B?clVBcWdlWDIwZHh0OFBEaW8zdlhVU0VEc2VhbFo0S3RzblB2Ny8zQnZoVDFl?=
 =?utf-8?B?Y1NJK3ZscXFyNDRZVFozaTdqb2hkLzloNDJRdDZUUncwSVpSV29SVDFhTUVK?=
 =?utf-8?B?UndyM2g0R0JsZEdNa3owckJtZGtiY25MOU1qb1JmbW52TXFBUER2QXNZMnBY?=
 =?utf-8?B?Y3lzNGhyUlBWTndxR2VBbC92ZXdzSStsdXFHRlBNZUJqaEwvRTdISmdrd3hr?=
 =?utf-8?B?aGRhQU4xeDZ3SUVrQmZueGlUR0VrWHVYWjZFWFpPOGVnakx4dGxvTGlkK3Yw?=
 =?utf-8?B?WDR3Z2h2dGxCbFF4N0x1d2JOMUtVeXY2VWt1WUlWalFreHBNWUF5UnJTaHQ5?=
 =?utf-8?B?WnRmV1Q5ZHIvU0VySzd4OTVpdzk3bk5BWE5wUit6cUQrRUR0V1VBWVpyb09Z?=
 =?utf-8?B?RWJpZ05RRVVxV2ZtRlFjS0RKSjBMUU1KZ3F0ZVduLzFqeS95Vmo3aEYxa0dM?=
 =?utf-8?B?ekUrWUk4R1Y5R2ZEYTE4cTB4MmFKZ2JxOFB1N0ZMZDJqVEJTN0NRN2xteWor?=
 =?utf-8?B?UmFoT2xqR3pnQUdtNENlTUhxWUxIY2l6RzFLaFU0a25iR2NETXV1NC9qZHF2?=
 =?utf-8?B?a05GK0o0RklsVHA4SUdEa3ZxRkFJMGpES003TzFacnVzQW5BR0M1SDRBUUNI?=
 =?utf-8?B?NGY1QU9lZzVKd0xTV3pkaHNhR1kza240ZXlKKzVLMDM4bzZpaloxT21aMXVi?=
 =?utf-8?B?MTBtdzFzMkRPS2pkMlFvenFETHg5VkdjY1JTaVVybXFCWTZ2YjJiZVB3RWpW?=
 =?utf-8?B?SU9pQ21GcGRxVGJsbXQ4UURYWGVLcS80Y1gyRjZZVy9FeHJURmV1c2J0YVNi?=
 =?utf-8?B?cmY4QzQreVVrRjJBNStGOW1DMjQxSHhMU3kreExpWHpJMWdNRnhSZmJNRTFK?=
 =?utf-8?B?M1dqc2NYM2VQZ29TMkpxRDFqaFUyRkJITGFTcXkxMWVGcmFJV1NpZEgxckJl?=
 =?utf-8?B?VElmdVlsU3RrYTJUektyYUhGOExlQnNSOHZMUzdzbkxZZVhobWtTeStFRFEy?=
 =?utf-8?B?VE8vNFdTbGhMQ0pxeWx4S25TdnJnYkdYeFJ1SlJxRmZydFJldjUyODBJcnNq?=
 =?utf-8?B?U0ZnazlZZEJGSWxick9XbUZvNGZUU01yYmNxWjZpcEdWSWRja09vUi9IcTg0?=
 =?utf-8?B?bDBtVVJURGk2RVRLbkJrcDU5SWN5cDUrQzB6dGhZNktFdWZ3aklsOU82RnFo?=
 =?utf-8?B?Qkg3QjMrRjZCWlR2cEwzeEFXYkl4eHBaWDIveHJOYmZaaDlsTW00bHJYVDlV?=
 =?utf-8?B?ZHhuVlBmM1RBYU1CNXI2N0NiRTlOQ21CS3drd0Y3WVYxb2V6ZzZsTzIyRk9O?=
 =?utf-8?B?UGdKVWlXVldUdmdpSTFBZ3FORFJuaDFhbTJpVDM3S2Exd2lmenp5MysrMDZM?=
 =?utf-8?B?OUFtTzRJK2MvV0VHb1kzeGk0ZzZCaWp3cWp4alFsMFlLVlN4T3VZWEpQRmgr?=
 =?utf-8?B?L3Y5QlBweWpqMWR2aXd4YllSYmdjNnhNWHBna1BteFJVdGQwYnZyb3pXRVZ5?=
 =?utf-8?B?UWtpSnRFeHRycUM1UjZsTHJ1S3NoTlQ4VVU4WW9BczlCYmRuajB5K2pzT1Jm?=
 =?utf-8?B?WVJhZVhlMU9MZmRUM3FXOHJuQlRWc1RyeC9PVjBzR1JFcExUa3RCeTcyU2FN?=
 =?utf-8?B?dEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 914c7818-aa5a-42db-3888-08db97c57c13
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 04:11:05.2392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wKxqgFIovlw4d+XScEOkrBeGQPUoGEiGVENdRB2dEQVnvXDPy9sY3BOMSMJi8EDl9aSKU87S5ABXXSJwi3Owbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
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



On 8/8/2023 10:43 AM, Yu Zhao wrote:
> On Mon, Aug 7, 2023 at 8:10 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> In madvise_cold_or_pageout_pte_range() and madvise_free_pte_range(),
>> folio_mapcount() is used to check whether the folio is shared. But it's
>> not correct as folio_mapcount() returns total mapcount of large folio.
>>
>> Use folio_estimated_sharers() here as the estimated number is enough.
>>
>>
>> This patchset will fix the cases:
>> User space application call madvise() with MADV_FREE, MADV_COLD and
>> MADV_PAGEOUT for specific address range. There are THP mapped to the
>> range. Without the patchset, the THP is skipped. With the patch, the
>> THP will be split and handled accordingly.
>>
>> David reported the cow self test skip some cases because of
>> MADV_PAGEOUT skip THP:
>> https://lore.kernel.org/linux-mm/9e92e42d-488f-47db-ac9d-75b24cd0d037@intel.com/T/#mbf0f2ec7fbe45da47526de1d7036183981691e81
>> and I confirmed this patchset make it work again.
>>
>>
>> Changelog from v1:
>>   - Avoid two Fixes tags make backport harder. Thank Andrew for pointing
>>     this out.
>>
>>   - Add note section to mention this is a temporary fix which is fine
>>     to reduce user-visble effects. For long term fix, we should wait for
>>     David's solution. Thank Ryan and David for pointing this out.
>>
>>   - Spell user-visible effects out. Then people could decide whether
>>     these patches are necessary for stable branch. Thank Andrew for
>>     pointing this out.
> 
> LGTM, thank you.
Thanks a lot for looking at this patchset.


Regards
Yin, Fengwei
