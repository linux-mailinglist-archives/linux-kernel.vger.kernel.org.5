Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F038380C628
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbjLKKNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbjLKKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:13:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A54CFC;
        Mon, 11 Dec 2023 02:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702289591; x=1733825591;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PAzQ2POEDQ4yXdZ1yPECepn6T6BLWb6YQiAAJ3pszMo=;
  b=L2YKvBxpsfvrhTqgkHWCL72THq7Ps9CKF8oe/hR08sYrOv4uVN29hBrT
   BLtztVFLQDlcE8HXe/qRoY4zVYmIzRId9Zf/UPMQyU0FWRbbF9mlm5IGU
   TzwxmlQJ1eYEEnAon8kPpX3Usz7OEN8ehyRetHDqIiW7btRSF4q9SI1cj
   H2yZWTkfgcmVJEDklu9jejfdoH0F5ogS3d8k8/aBR7b4JuMx1S8n8O25Z
   q9IaiGD0CpLU883D1SZQa5NUbPEEPP9OdUlOInNJO9tsdrsuLv45bRedm
   bcYDO+BDt0wpYGpBGLXYDnJf6Kyk5PrTYRqAuoUjaU+lUHgyY13/YeS35
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1750579"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1750579"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:13:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="776610685"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="776610685"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 02:13:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 02:13:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 02:13:07 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 02:13:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSfoxCL81oPw/DYb3JS79eX3hMQzunN4NsmVavBuV9nid1/czeFAh0U4K6gBSGf4cprAcD2wHqbL8ylfPN6LU0/S0y7MrTgx2uxtYbHOSfgyhKSMLHb0ytN4mTAuU4fQ5qNKAzNe4yJ8WOeIvRFrujDI9AZBpUu/r1HvXRtw30stnDhhIdwa3nS7SFDTl3ebDfetl7XotVxYpPkCOlsLPXILW43+FFkRSF8gwbU6TzPe61JH7namDwbqAI4ZScXCn5T5qQEB7+g1myWOkjiT4yvLEuqLemI4ZtF2aaTSWQggwYEyLMnQoWFCaJwiwDYjZId7wfpc7wqglwuhZ++roA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ur85iY9xDixXPT9eu8dMwXTuO3CWtjWCvGCO/DL6P4=;
 b=hXmUoxEv+7LZ5TdqA5uhtv7yfyH6c6ZGw3b8sj8F4CnKfNgF0y46OyuwoDpBrPuu8frDcP3wrD5/9ytA0Nu2/+rwX+g6YwZnC3ggcuUMnUkg6XqopxWQhuwryGLH3iOpaHU4ZxspAzzWU6wbE42WUtq/r9/xBQx/Vw+2RJ8T9nJbWszX4x4W1qWWb+rEQO8TY7bJR9bFXGEuBQ7bI74n8eq6pirRXkvfSUAaZiOFf2i7dZ0xVak2MRkpzG4Po/rzuKweMrCrD/A7EBNLoZjY2ngvoCKGcpw3jAlPjEAVF0/Vy37AeRVnTy+lQWObpmEGqOwwzhBbhZUcFEDLdTQCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SA1PR11MB7038.namprd11.prod.outlook.com (2603:10b6:806:2b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:12:52 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 10:12:52 +0000
Message-ID: <b9c33092-6268-ef89-4401-0cf438ee8a4a@intel.com>
Date:   Mon, 11 Dec 2023 11:12:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ice: Fix some null pointer dereference issues in
 ice_ptp.c
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>, <jesse.brandeburg@intel.com>,
        <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>, <jacob.e.keller@intel.com>,
        <karol.kolacinski@intel.com>
CC:     <michal.michalik@intel.com>, <intel-wired-lan@lists.osuosl.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kunwu Chan <kunwu.chan@hotmail.com>
References: <20231211062649.247148-1-chentao@kylinos.cn>
 <447d130a-e1ac-02f6-e168-b04bfa9c6004@intel.com>
 <3231a5d7-29bc-4464-a26c-803b95774f86@kylinos.cn>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <3231a5d7-29bc-4464-a26c-803b95774f86@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::23) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SA1PR11MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c201c8e-2f1d-41f3-35b1-08dbfa31bbd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: daiQuxaka78KBGPD0wh8yrG6ZNYqLPMvNPI2T/2RU04jiqSxUxADuuk9Fnv+21beqmcxLFrbTwbFngGYZ68Lg//5/B8hiv20XzMycoBAJPhlbuxcmzdIOjhGIJheo3Kmt2Z2J/sMVucFeOU4gYsLYl7NNmZPRdhXq3aFRanKesg3+/Nl4GBZA5B3RrAcaSI1w5h/qfd2I1Oxxk+2WTbcOtfCNRwCDVzTjX0WNXCyhAdjvxMdNWj3TILuXG8pyLPoYuNpMftJ9LGlWKHvpQyzGPCaCHAdjEUhCwrQCJcaGJ1Xx6CUWFMtbifvJbXae7SyNIqj1gG7PsZeuyLa83FiiMVPjvC4HeWDVwUs798k1XIlCcYz3ApH36v0HCBYtN8KxCKvnCTbAVJ5GuZUIulO+dd4N4UwxacAnT0WZsfaOiLI61evSYRi4gICa+HVNYvD1vFQj/0nXnBKaeg07aEfTMB4Twoo+R1OZhcaldTjVE93bPkejcQsTk9NE/UcbR79knsSkw0IkTQfzACqoaerT+SfwDs7dvCTYGw0GVr/iYO9+/Fkj0mmU5o63MSJ5lJFrH0qJJDLK4w25nln1ea/+jRSgd3gwQ3Q6lsVLf/tA9IRWAwKk0qwuKvG/uGK6rh5mCSsAZT6WlF+V5YMczgp/Um/QzeLU+1fxQJSfTeClY+SWmD/R/mrIRwe7B3tR56raO77CnedoghALcWUxvteLeBOgIvpMvSuyV97Th4sErE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(45080400002)(26005)(2616005)(6512007)(478600001)(53546011)(6666004)(6506007)(921008)(82960400001)(38100700002)(31696002)(86362001)(36756003)(41300700001)(66476007)(66556008)(66946007)(5660300002)(2906002)(7416002)(6486002)(83380400001)(4326008)(6636002)(316002)(966005)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzB2WmxPQ3hiSGVZZjI0YitsTXN3SnhRRFhUNVZ3UTMvQzB1L0UvRFFpUUZY?=
 =?utf-8?B?dVdObXROMHcvU29TdURRVU1rV0tJaTdQMnNoN0dhWjdYdzI0MmdpMjRqNjNJ?=
 =?utf-8?B?VE9UNUVUWkJxRlgzS2xjZGZjbkR3QmNIdVlnSHZTTSt5LytqQVlRRDRhMytL?=
 =?utf-8?B?bHZ6RS9yY3JJUEYvWGlrdTM3UEd5cWc4M1Z2VHdNeE5MY1NsNWU3Y1ZRcWNE?=
 =?utf-8?B?OXNzNjc4OHhBSnQ3bnNHNDRJZzhxMlRYeCtTYnRzMmJsQ3Myd0NsQmZ3b3hU?=
 =?utf-8?B?U1ZmdllBemtJVXZTUHpKT1Rkd3Z3OHNXTmNVd0Q1RC9Iei8xQ0I3SmZpNEJn?=
 =?utf-8?B?Q3Y3RUlCVXF5cHplRmNTbWlqdjR3VGNUb1EvMlk5Z0VtMDA0UGd0UHc4N3Zk?=
 =?utf-8?B?aEZUWTZ4dk1BbWxFRWJnZWVRbGI1Z0VuaGRKSUYzR1hCdkJmbDh4OEozTGQw?=
 =?utf-8?B?TmR6aXdzSHZGUjljUjBmTXk2Q2doSGx4Z2Y4VzdYVkhER0tIWHBUWHNoMnlU?=
 =?utf-8?B?M3RqTmUvR3VmN2ZrRkVSWWwvWS9sa2dXVEgvaDh3RWJnNE1oTlljUzJPbFh6?=
 =?utf-8?B?d1BTb29BbS9LVHlmYis2YVNOc0tkZzE5Qll6Y2JFK0dyZnhkNzVDdlFZUFpM?=
 =?utf-8?B?TW1FVVo4YnZaNzJpWmJCSHNJZ3F5aWo0Mnc0RUlsZlZRa1l5ZnU4UHVvY3Zt?=
 =?utf-8?B?bFVGRHZOY2lJUmMvV0N1V25ldjRLaUNONlc0T2cvOWlKZjM1c0prNWRHUFhv?=
 =?utf-8?B?Sk9mQjhGQlNPZW9YMDBPMTNUYVgzWjBDclNmQTRZeitpSUNLZC9lb1c0b1cx?=
 =?utf-8?B?ZG9IMk01MkRDSzVXM29ZaVZ2TzR0NVhtcEpRQXdpbGc4TS9VcWd4Uk14K2RQ?=
 =?utf-8?B?cmdEcHFVM2FuWngyYUNtOUFEaXJiUXZhWDdjUUVrdXVoU3FCbzd0K1VvZ0lT?=
 =?utf-8?B?SDNrTHhhb1Rjb1ZKdkZEZGt5cVdkZnA1dFhXNzV6Qy8zMEdhZWs5alBHQ0Fo?=
 =?utf-8?B?aEZaZDBCZzFSN05LTlF1aENaVlRCNjNoY2VBZGptYnViT1duTmkzK3ZSOTVq?=
 =?utf-8?B?V1hjWEVxc1g4V0dWNGZHR0k1NG03ZjhIc0JNbXpnZGNzcVR6aWZQclVYekgz?=
 =?utf-8?B?aG1nOWU2OGtybWRHVXVGbVRDQnNMMXJMazBjRE9lY0F6MTdNRDVCRmszbHU1?=
 =?utf-8?B?YXRFNm5JRFNCb0VNaFdSdm4wRXZ2WVEzY0N3Z0dCNmN6L0VIMDFrUHBIR0Zy?=
 =?utf-8?B?V0tadW1VRjZsRnZsTDhCR2VsNFkwS2U3SVI0WDJTS0t4REVHTno0VW15dmVG?=
 =?utf-8?B?TjlFKzJBVTJYbmRaS0V2eUFlMUZDOStVOTZuVURCUWQ4Wk1wd012M2pSUGdS?=
 =?utf-8?B?UXhsOEJKZnl6eGJjS1J6NHZYRk1wRzdyZnlicG43MWEvSDBMVGt1cE9ZSEZ6?=
 =?utf-8?B?ZUpmalYyR0s5N0l1QmVjMVh0Qmh1RFNxRGRhbkNHMkdtZlA0Z2Vaa2ZoMTBO?=
 =?utf-8?B?YkQwRlhESDZKUjhCc3gyT20wT2xqdlh3VFp2d3hBanp5b1EzbFhPRmZZVEJQ?=
 =?utf-8?B?OUJ1TFlnanM3VS9qZ3A2anNqUVZHZE9pT3lFanNRZUNlNUcrWFlZQnlWS01l?=
 =?utf-8?B?SGpzb04vRi8xdjFyaGdMZ2F3MFFrbDhQQVlad0luV1h4dTFUd0hYRU5FQmRP?=
 =?utf-8?B?UTlvS1JSWTRpUHdVb1VkZGszMVYvWDVCWGdvdWtyNTFzRCt6NWNiNFlOb2Zi?=
 =?utf-8?B?Zk8zeGdaSnc4Tyt5L1JSSStlZSsyS2lxYnJPRWpPWC9OUGlDM0M4K01sMzJP?=
 =?utf-8?B?U0VCZ0dGR0g3K3ZYc2VsbUFwQXFUVndxNmpkcVJ5R1E2emxZczhmUTdSME9l?=
 =?utf-8?B?eWhZT0pyd2Z1blBLN0FmUlFiZDFuK1BoQ3ZCSGwzM1BEa3Z5SnZlck0xdjdq?=
 =?utf-8?B?Y2hVc2JsV09jcWI1bkNtQjB0dnJsWjlNWEtsQytLQUZLeGRsUklBcVVLYkZC?=
 =?utf-8?B?VG5XQkMxNjdNM1ZjYU14UkFOMnhFQVJXSmdRMzhDVHI5Szgvb3pDVkVJUU14?=
 =?utf-8?B?RjlONEpHU2lMQkJheVZqdmhneGJYYzNCSERXTzg0cGk3RzZUR21zSHRkREtr?=
 =?utf-8?B?S1JHTlRuTWxCWi9vMEFMSGgxOXVjNXlUTFcyRlNYcmRiUC9IQkU2ejhsSTRp?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c201c8e-2f1d-41f3-35b1-08dbfa31bbd1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:12:51.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZpinkLvnrnugchrQGSNn7XuE56St4HxHh1e28H+daaMcPWQ06AgvaHOsdXvhhyQ91SD295EsXuwcCMecUOZZ0lHI/435Wv+ccJLtks2Y1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7038
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 10:32, Kunwu Chan wrote:
> Thanks for your suggestion.
> 
> I made the patch based on linux-next.git(tag:next-20231211).
> 
> Our code is just self-similar, i didn't override the old name.
> I keep the logic as it was before.
> The newest code is:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/net/ethernet/intel/ice/ice_ptp.c#n2747
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/net/ethernet/intel/ice/ice_ptp.c#n2993
> 

sure, I just checked those, no huge benefit of dedup

> I'll update v2 patch with:
> 1. update suject prefix to "[PATCH v2 iwl-next]"
> 2. remove 'dev_err'
> 
> 
> Thanks again,
> Kunwu

Thank you too

> 
> On 2023/12/11 15:15, Przemek Kitszel wrote:
>> On 12/11/23 07:26, Kunwu Chan wrote:
>>> devm_kasprintf() returns a pointer to dynamically allocated memory
>>> which can be NULL upon failure.
>>>
>>> Fixes: d938a8cca88a ("ice: Auxbus devices & driver for E822 TS")
>>> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>
>> I would suggest adding "iwl-net" as a target here
>>
>>> ---
>>>   drivers/net/ethernet/intel/ice/ice_ptp.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c 
>>> b/drivers/net/ethernet/intel/ice/ice_ptp.c
>>> index 1eddcbe89b0c..59794ce4f243 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>>> @@ -2668,6 +2668,8 @@ static int 
>>> ice_ptp_register_auxbus_driver(struct ice_pf *pf)
>>>       name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
>>>                     pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
>>>                     ice_get_ptp_src_clock_index(&pf->hw));
>>> +    if (!name)
>>> +        return -ENOMEM;
>>>       aux_driver->name = name;
>>>       aux_driver->shutdown = ice_ptp_auxbus_shutdown;
>>> @@ -2929,6 +2931,10 @@ static int ice_ptp_create_auxbus_device(struct 
>>> ice_pf *pf)
>>>       name = devm_kasprintf(dev, GFP_KERNEL, "ptp_aux_dev_%u_%u_clk%u",
>>>                     pf->pdev->bus->number, PCI_SLOT(pf->pdev->devfn),
>>>                     ice_get_ptp_src_clock_index(&pf->hw));
>>> +    if (!name) {
>>> +        dev_err(dev, "Failed to allocate memory\n");
>>
>> Kuba @ [1]:
>> no warnings on allocation failures, there will be a splat for GFP_KERNEL
>> (checkpatch should catch this)
>>
>> [1] https://lore.kernel.org/netdev/20231206195304.6226771d@kernel.org/T/
>>
>> so just "return -ENOMEM" would be sufficient
>>
>>> +        return -ENOMEM;
>>> +    }
>>>       aux_dev->name = name;
>>>       aux_dev->id = id;
>>
>> I didn't checked but having same code in two places raises questions.
>> Are you overwriting old name here, or our code is just self similar?
> 

