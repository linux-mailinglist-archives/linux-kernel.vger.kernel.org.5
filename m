Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E827AA55F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjIUW4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjIUW4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:56:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB067E5C;
        Thu, 21 Sep 2023 15:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695336979; x=1726872979;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SNHwqSzdNGxc8JEtzhSBlBOaD9TJgXBlRmEjJWX2INY=;
  b=fAdWREqrsmLT2ImG/3MIrCjbESgfQRQzSzsTHa3p7+a8O8D1TllcddKi
   53JfbV6Z6FR78RiptFdBcaG7T43ZQjvy09AZs2i+NQXKzDSlNTK1BFB3k
   9YG3djMQD60jFuF+iH6XwQ1kHpHux7a30xvpV8EPy6N/zkkci/7AlOWrx
   jRuXG8fZCU+XRPIgrGepfI6m/fVNqJM16Tj9D/BZvAX5gELu0Ho0+x3Js
   m/QlgvOblYeQi5AtcE0tYBHRHcV22V5vMHBPE0oj59yFcznVoaMbVWWU1
   n0ooOg/JWCSiZGoL7fjnBODJ22TQC4+abSZ4sxxqm41pohU6yhKET0cij
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="384526680"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="384526680"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 15:56:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="890575286"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="890575286"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 15:55:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:56:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 15:56:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 15:56:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnVg9hvcB4yTzP1Vn76gKecUdEdaHrT3YVe4tTnLdMxPhVtjNWtWdH3PVZZy0zmLraqCHJ4v4RDwnpEh2T+oWjBFiqGcTHVaazEgT29Ba27QZqBIYl9aJC4PIH4bsuoBxLLe6KaiShCwjGoHnlsWrHUPKLB8Z8Xbk0SvOJC3w4ECsJDvPywbjvdNahcu8Oj52zR1O+lAyGIuCuZgK7BY2hXNJVPvOCeAkhDrAqukrr3kRmfTjp6UiLGTmYr3NWbU4FiNbUg0mf8UlpB2o4i+ktAt8tdkjLdAS8+MinlxsSKWXN9xADpCuSuqRuoeA06g/p25ySZ4BqmopEZITqjUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX1L0sfadKqOzBIS3zevjOy4pFdWCStKqXRzpv5d4N8=;
 b=TGYxa7l+fd7B1ewd4lFyz0dq6yJ0nLxODScp8DzHS4lhWj7Ki9fwOdEKecf0uUjR3/gbe12TEaGt5DkaiF7K/Dr3T7S02MrcfiEKlqqUlbtWmi1ng7X5L0ZfxzfJII3p58GdorxjxIFB46oyRY0S4HANyTROiUuIOdhv6NMn2ngNKCpTl41UzVSOdB5BrIuFo0SanUIOiG9CyZz9SYtET+z8SnMxMEpU/N/AawvbGB36FJWIAmM7z4borJ1BpCgZBeASoFsBQ8pLgXIl5VucDI1MvSjomd1nAO4vFBrtRxev5G0QWLCEixnq3SmioHATmuvajqCFaxHF2pZB1XoLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 22:56:15 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 22:56:15 +0000
Message-ID: <7f575fc3-f4d7-4c79-a13e-1b125093d8f3@intel.com>
Date:   Thu, 21 Sep 2023 15:56:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 4/7] cxl: Fix a checkpatch error
To:     Jeongtae Park <jtp.park@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "Wonjae Lee" <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
References: <20230921025110.3717583-1-jtp.park@samsung.com>
 <CGME20230921024832epcas2p3677e522ed0175b83c1a56e36a730ce97@epcas2p3.samsung.com>
 <20230921025110.3717583-5-jtp.park@samsung.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230921025110.3717583-5-jtp.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 08185216-4569-4e6e-e0e7-08dbbaf5f5ae
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eMmxDpE+cDdy9/xJ6ErmWSW9t30bSNBKLNTK8SjSybr/avfgs1kpVLkcog6KgCq7o3bNZWDFtGH7BDYXmq34TDIvTTsmXIiLL/aHrAxX+Se7BrQz2a0yD7BkoT4+afyq4nUQ27m2HhYlsPOmSD4yf2Omw7bAl7UVKbgtdCq2r6xO4Z7jt8HxwqrF/HZSDp/sbaf2n0sYjlTkVErRlL54yusktLQlH1Vsdabst/WZEUe5fEkxT3mIZ+XzPWvqppac3iGyHNpTKdIsO9c1D4ilSTPl82TKIKmWSeSZegkfT/7pNYRRa9HZb0HvMcXw5FdR38T5g9D+0qJCQ/4uOw96AQK/hWpk6VpxV+K1LkAVzUlnqwiQiQa1zVK6tEM9k2L2K97TaEEeqC/HkMe/Ta+YCvKwKvIy4dhAkv6HeT+5QKkTyLon6w5YRzNAlUO86d7gtoLtv3UcvrHeZrLJ7mCIC3cFfWurIFViDkF80ZsH4Ud7lG3bX7omoQwl9cNrLatQ9yPOB1dhOz6cpuvErs/Vo2H92j2HVAWlBd3/7GKQOMjxkl50Ec3TSDcKXEmPEVDhSauRK44P12idrPb37S3OpxoWyzhLshLFf4CXjmcG6KE6qhHO28sepd/e+yta1zH04XG1pGb6M/711uboRJPuZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(186009)(451199024)(26005)(8936002)(2616005)(82960400001)(8676002)(4326008)(7416002)(83380400001)(2906002)(31696002)(36756003)(4744005)(44832011)(86362001)(53546011)(6506007)(6486002)(6666004)(478600001)(5660300002)(316002)(54906003)(6512007)(41300700001)(66946007)(31686004)(110136005)(38100700002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3M4VURZMVBJQnpXL1NXNnlLczhFRkMrOTcyTnRwR0xhQUJma2F4YmYyNXFt?=
 =?utf-8?B?NFNKWjBlM1pPWS9NazNURTVPZXVqVDRLVXdlNjdxM0Jvb2pORndhTVpneS9l?=
 =?utf-8?B?SFJVR3pZUGgwM2ZoVDdPcVFOMjlYK2FVWW5PK3BDbmNHNldFRm1mWWxhejNw?=
 =?utf-8?B?QzV0NmgxRTdUdFVoTEQzWS96TndTazRYVEQxc1RVM25RRHQ4Q3dCdy9KZ2Ns?=
 =?utf-8?B?YVY2Vm95WVRxb2xSaGV3TkpNWVFURDRoZHI0TEpvOFI5TjZEbUVtaVloNnpH?=
 =?utf-8?B?eTNPcFFNSWk1azV6WDg0dlNwcTluQkN5NkxUL1QyRkVnMXZlV2dkaGtmREx1?=
 =?utf-8?B?S1FEeUpEZ2lkVFgyUy96TG5ZbFYweTU5cktiK0pNVGJ4dVJOeXVWZkkzRzB2?=
 =?utf-8?B?YkNlY1ZNMEM2SFBYMDlYOW96SXFqVTdxZUVGdEJ5dmVYVmZKaHV0WEs1dWZx?=
 =?utf-8?B?UXJhbURXcFV2b1hoZjZORWFxeFR1MFE5MFpEUjNMd0F6U3g0aWlsblFZTmxC?=
 =?utf-8?B?RkU1eFYzcXVNUnRBRk51VU5wQWVFWmtodEZqYWpxUzQxUkZHS2loajdwcDVv?=
 =?utf-8?B?WHUreS9GNEhiUHhaYjBpSXExcVBzbjlRWkNLdC9rSTFIdmRteXRzYy9kYjhE?=
 =?utf-8?B?djZ1cXZZWTFTeU13c2hBOFExYjRKeVlZQ3BNWWRXOUJ0ZGJZaG9oem9nNldv?=
 =?utf-8?B?R3poeXlZVmJuaFVKVmoyM25FR3JBamtBTGhLd1Y3THFncWs1Uk1QN3IwczBo?=
 =?utf-8?B?RGFHTjEvWnpxeFYyTnhLS1h6Q3Z6NEtRU0RlbWdrVkdGTGRPaWZieFhBbVNB?=
 =?utf-8?B?QmFqV1BPRURhMUNoOEprK05DTUNqaGZDMk92ZVZmN1VaWGE3UWhWR28rV1kr?=
 =?utf-8?B?Rk1rUGQvWGxSZ21JbVlsN3FiY1h6VXc2OFR4OFUvclYwN2lFTzBqYmp1SElO?=
 =?utf-8?B?U3hhVFVHOGVIREt1TFY5OHBCZHUxbUhKbk5iZG1jd0xrY0ZINWYrUzAxQkpv?=
 =?utf-8?B?RTJzb202cm5sM01HdlM0YVdWUlA2RjA0YlZxWHh1QUcxcmpZQm04T29DZmhV?=
 =?utf-8?B?Yk5sdGRtRFhydGgwd0VrRG5qa1lYeTJwbDNCK0xtYUV3Ly9ReEY4a1c0cTZN?=
 =?utf-8?B?bkwxZXVqS05xdCt4OFFHSWJjWmd0eWFGcCtaNUhPdmZBMlU2TkRjK0RlWVdB?=
 =?utf-8?B?ZzNKVC83TUFrMHpNQ1dRYzRLRVNKOVBXc2g5ajhBUGwvOFhtaURkOWFrRm41?=
 =?utf-8?B?MUtza0FxZ2l2TThDVjlyeWlySzM3eU5mallHOUVFRi9GeGhJa1V4NzF3UVYr?=
 =?utf-8?B?R010bEROUzFPenIySXFzcVpQQW9NWUVPNFRrNk1EVGVJVmc5TEpLRUFQcDZC?=
 =?utf-8?B?dEVvSjlSNWZaYjdTWXFVT3ZGQU9MSnNkTXA4bHlRK3Zxb044YWsveFA5SEZN?=
 =?utf-8?B?aXJqM0ZSYjZSMUFpRVlKcTFjMlhKN0JaWXB2bmxoUGlnOUU5THoyMWNGNzRp?=
 =?utf-8?B?VEhJT3RJc3p0U1plRXlOQXVLRy9OeWhZT2RwdktkVzhreUNDV0RzVXZDZVIz?=
 =?utf-8?B?eFl1a1NFNkc5M3lyUHV6ZGdwRllCWjROdkgzT2NGbDYwUTNNN1NYcU9mODh3?=
 =?utf-8?B?cldQYUZSS1E4bVFiQUJkMUw4SFgvS0s2WGhzaXNtY056NFZkZ3RqWXBscFJD?=
 =?utf-8?B?M1hka1FtN3kyRXpoV2xGSUR3WXFZcEdJVzg2UUp2bFdQWDhjNUtWYmhiTW5q?=
 =?utf-8?B?MDlNeitpbjlqbVFuU2l0RndmUGdQUHRJNEFBUUc2bjZhVFB0b2ZJS0ljQjZv?=
 =?utf-8?B?MU5KRENOUDlrYzdQcW5SbFJVU3QvN0xvUjhaTjdVbERxcGpzZjk5dzFRUFBW?=
 =?utf-8?B?U0RVQ041UkxZZGl4K3d0bk00NWNLN25iT3FZSkxubHVHSmZIVDdIeis2c1VD?=
 =?utf-8?B?ODJ3STlyK29VRjhucktpdXZTOWtxTW1JQkYyQ3h3Ti9wV1hjVnVNaysxTkFI?=
 =?utf-8?B?WnIvYXl1S0ttb2hGWVpZTGE4OHloL1hJOUQvN1ptZm5CUm5JTE5ORk14TUx0?=
 =?utf-8?B?ejFxSWs0Q2pxbE5EaWZIVUoyd0VjSXFNVTJlVEVPcENOYnIwSVRZTHQvQ3hv?=
 =?utf-8?Q?O8tgqb7yGrJ0+RZhtiG+c1cSi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08185216-4569-4e6e-e0e7-08dbbaf5f5ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 22:56:15.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0hr6/l6oMzdSPrgk3RIWGarECgucLkjf07JjELU8aCFyf16JqGcUAu3ZP9cSG7JLsuWfsEltGzZ7mnElF3E0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 19:51, Jeongtae Park wrote:
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/cxl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 76d92561af29..545381355efb 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -142,7 +142,7 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXL_RAS_HEADER_LOG_OFFSET 0x18
>  #define CXL_RAS_CAPABILITY_LENGTH 0x58
>  #define CXL_HEADERLOG_SIZE SZ_512
> -#define CXL_HEADERLOG_SIZE_U32 SZ_512 / sizeof(u32)
> +#define CXL_HEADERLOG_SIZE_U32 (SZ_512 / sizeof(u32))
>  
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
