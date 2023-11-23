Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C209F7F5F57
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 13:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbjKWMro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 07:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345346AbjKWMrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 07:47:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C826D8;
        Thu, 23 Nov 2023 04:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700743670; x=1732279670;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U1D9tS6goFJ8cZ3Kb2elaFOfYwrCs9vELzkqZWXSIjw=;
  b=VymN0JkgTwEpWsDJyYrS9hT51QTgxajR1XyPmAIy1yFhDNS0I1V04fyr
   tuwgE3b/Lr/LPF4Fqv3Bj/tM8yzpIZwnpfCOgC+h6hXtc9jag/WdwZYPU
   g4mRdv/3b3usojfXtGeuBe9eVwuMjvf8CQQEMhBYjJ+fYkWW8m74wvJeA
   aCqd1cIAXd2f1bRpcVdRSO+Pmgl47EgMHYEtsEsfYc0LiuYkceCQeL3ls
   eRPQBLaAfLjjGA+2jsFmYaL7nJKvB/hv/5c9JSfLIlN9A8PYg+lQSrMEa
   yT3spfH1uDlCOROWwvKcVh8Gy7OVKdxOwZfvt3reQHYVoyXZVLUoYRAQ3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="5406802"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="5406802"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 04:47:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8837225"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 04:47:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 04:47:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 04:47:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 04:47:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bftS8SAqlRnU6/+TTS5oGLxboohfqFfvXPhan0708AhMQJA8+7koyzE9FkQGqUETonJrXU4MocIHdb4S+jMBjvtoIBWXENLpu79hKUF/H+sI0XNRBGS3mC+a+kWQcK2j3nNeZ7pKVSdvwo+o/GC1o4Z3EonZO4VaAw2b+rw5gKmzDBppPdjc540zmL7NvCS4VSirvd0ec2Mp+vRbk2aTCbEkPmvEW7Uok5mbmJ2UbO0wW9ICOFFkLGtvG+fhRLETX8CBDSiSTYciOszbJ5TZxT6MfR+8oMADZXBkB+o/6AMEYbh45gw8mICrZPIO69y/eaT5Vwlc58IbUvgGMUbBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FADC/RWGf8VjlbRzCx+0rFDI6bjsAUIK4tztdlOHjfc=;
 b=dFafkIphMsbstyHqawCQHAO2JZA9CQHix9mSEdyGESa9/2uK0bZ2qXu9TwnHYZaAPzT2BXG3q4KybwGaHCm75IojdzXOmW++tib2JTlv69XVdjZCY+pWGMp+pgOEuR8b6wJdBo+eyBLHVXHrT9Ot3l1Mr8ERfaRxMvNspP/culmVUubVL+0GO+8WoLkK8JF/PXroVPLNa2dZhzW9VDExKhfuJBcAGJ7zCDcvat8L29j7+B9OZOKrVf+CxIroPpZCCe2X2OlnEvfu8jN6sr7vsa5CD4toMJeDAwHjHlChId1JHrfGqFj6Yshn2sfLL1gkSNRrgAXdQqNgq09/ML+TCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by CY8PR11MB7315.namprd11.prod.outlook.com (2603:10b6:930:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 12:47:38 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 12:47:38 +0000
Message-ID: <84f9f3b7-54ef-42f6-a9d6-af4d763ed3bc@intel.com>
Date:   Thu, 23 Nov 2023 13:47:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [net PATCH 1/5] octeontx2-af: Adjust Tx credits when
 MCS external bypass is disabled
Content-Language: en-US
To:     Geethasowjanya Akula <gakula@marvell.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
References: <20231123055941.19430-1-gakula@marvell.com>
 <20231123055941.19430-2-gakula@marvell.com>
 <24e4edf1-14e3-460a-bc33-0b2177a49ee6@intel.com>
 <DM6PR18MB26021B0EDA9DCDAEC80A4A6CCDB9A@DM6PR18MB2602.namprd18.prod.outlook.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <DM6PR18MB26021B0EDA9DCDAEC80A4A6CCDB9A@DM6PR18MB2602.namprd18.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::17) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|CY8PR11MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 27aacc7d-f020-45b2-e7b9-08dbec225f92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9Bxk8/6ke2JByntzG97Htbvw6l+eCemoXxVRPUifqG6Wpc+bpxV0SperI1JGQb5cj63A/VMTZZIqNhRM87xGo1AsoD1ywdLUNRk7Bv2AxEjCthQEbsHbf3cMtJrv5YAOYRsWSUspKKeXahhfxEXin6fvPhtLqo4orZUAt7lG6R+uYFqvtuhe1QS2qStSU7AdcFV15JjDMtoja5dMJnf8dFJQ+Nz6DoeJpT9EsAiRjlYwzI2s1cX7OhXwis7cTgtjqFUcrncSLO0cIfNWzb+CuHNsEFFpFfkSk61lDTGxyjfNuvHOq3iALtmQNOz4mly//WEoeIoW+2h0T15TuWTdh0rR7qBvGROLETKwrTzVSRSsvjL80hMjufsr8TXQ9EuIq7/C/yI96/WkCwaVvXDjmKov1Qf7X7Vac31/G9XyLKdLIflW2fDLWnU9L64fy4LlTzwJgWrHh3/L0GVMUfV/+427THFIaB8TZz+ChgmvVJ4FYaq57I52l3eFrMdn7jAiL8KRu4EWdBjRAqSjm1gFK14UMNbK6JC2pyBLwbDV97pyxdB6D2/VE+BXkdxzSYYLqgSzAfRnl+1RlvI9OB4VtyJkPXOh3rtk2qZfSAyAH9B10dN2v7fQjk54k/3/jNJXDyW/Jphl5hZ+Z8vYernVUaN1fGX6JsxLAzzjrPzER+wuc6RfQcQWa/q0NihDLTa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31686004)(7416002)(2906002)(44832011)(41300700001)(8676002)(8936002)(4326008)(5660300002)(316002)(66476007)(66556008)(54906003)(110136005)(86362001)(6486002)(83380400001)(2616005)(478600001)(6506007)(36756003)(66946007)(6512007)(53546011)(26005)(6666004)(82960400001)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTV0TmkrTm0xV1JFVTlIc1V6Z3E4Tk83K0hCa25naWNKT2oyMTV1d2tkcm9t?=
 =?utf-8?B?MUZyWW9aZjRNbmJFNDVZcEFQaGtCdGxIV2RHOTBhY24vN1dnOXlHejBKNmY3?=
 =?utf-8?B?alBZVk1ianVGaDBWK2NFQzRsVUdmU0ppQmxlWENqUURFa295U1I1U01td2xk?=
 =?utf-8?B?SGgrWGwvelpUYmh1STlxaUtZOW80c3B4aXYrM3ZGWE1zRFg5M2FReTJZby84?=
 =?utf-8?B?VEY1ZzhyNm9ZdWlaNVZlSkgzeWZDVEk1MlR2WVRZU3R2NDFFL1dQM2xNbFpZ?=
 =?utf-8?B?TTk2NTRqc0pZZ3I5bnYvVjdJWVpzTlEzaFBoMmZNTUFYZmVJdmdFRVo0WkVh?=
 =?utf-8?B?MHlFV0YySi84YXFDYWdKOEdadTVZNnVmQ2xSZEJyZ0g1cXlMTkNWang5TzVw?=
 =?utf-8?B?TGlhVDQ3MGJXdGtMUk5vRlZHaXArWTZJZ0xrdUhHS1RMUHlnVERWVStOWUx3?=
 =?utf-8?B?cG1xUG9RNDgwZmNyQktUamU3dWZuSlR5TDBBMkJkK2VSNG0yaWtXSkdDSkF6?=
 =?utf-8?B?cnNLZ2pZTmIwVUpaZGhvWFlJUzhYWi8vTVpWbGlLZ0NPaWRYL0lSOUl5N0Ns?=
 =?utf-8?B?MklTcGdBU3dpanlGQ2RPQ1B1cVRkM3lmMGJySVdSdGZCcEFZVVBuRWhzUWRF?=
 =?utf-8?B?eXJPUGo5Vy9LYUQ0aFVHYlBmdVF0T21OWXZiUHprbE1PQi9SQldyVjZDNG54?=
 =?utf-8?B?TWVMM1NCd2FuMUxzZUF5NjAyRWlzSlVDZ0tTQlVNTElSd2dwQ0JqcWdNYmJn?=
 =?utf-8?B?dWswdVBDYVBKY1BPUU5pM3BPbHpyN3dvQ2FaUnF0aGF2ck9mbGZCZFMvQytJ?=
 =?utf-8?B?TzlYb0liaS9WZjFORDdmbHhqa00xQ3J5aXJFWHIzOVFTQkF1dkVRTWc4TE9q?=
 =?utf-8?B?TzdueDg3bFo1azE3SEFzYkZZS2J5aFZvRVc2Qmd5WHFIdEEvVnMzTmV6aXpy?=
 =?utf-8?B?NUM0bXdkUU1paDNzVzV0ek1pVnFMQjJyOVlidkNsLzExRENEYVc3Zy9Qcmwz?=
 =?utf-8?B?OXBmN1NCUnEvYmRaRnBvdE1QNUltNHhJMTBkMTVKT0o1WjI4NXdhKzJRYWVF?=
 =?utf-8?B?YkhaaWg2S2NXblVITzBkOXJjbjJyRkpUeTZ1bWlMbXJVUElzS2dxakVQaWF3?=
 =?utf-8?B?SG5MOEdNTmF2TjdlR1NDN3ZPRmZsbUQrNG8rNTJyUlNOOTVyYUhWOW5hOVFi?=
 =?utf-8?B?cE9TZzBDamxOY2h1aXk4My9TWmVDejlmazd6QTlnZkY2Q1hJY2lFNzdoSDJM?=
 =?utf-8?B?d2N0czNraWJhVS9JOTRwWVdmWmg2bEpCc2VBMlRQYTVFZm1ZUHVjV2tzUVZt?=
 =?utf-8?B?cDc5dklmbityYjVxcUp5MmdESFgrY1ZObG1EcSt6dHh0ZCtkbWtpb092THlr?=
 =?utf-8?B?cVc2aG9ib0lqTkNnR3dxUFpVNFZRbGswd2dSV3R6ZkVNbnErMEZLeVZ6L2FI?=
 =?utf-8?B?STUrOVJHajA2WW9ISWVSTzVTL2tiZW1TRm5HMmhPR012alJBZjJFd21kZDMw?=
 =?utf-8?B?SFZORVpFR2JtYUxwb3lVS2xzSkthMHZ0bTBpOGVKSUZqRGNzOGRCcnRLWHdo?=
 =?utf-8?B?TW03dk9iUDFDNVladkJtU1BmYTl3NlZYSkhxREhmN2NNQy9NMEs4TjFNWG9u?=
 =?utf-8?B?a3VEOFlHYURKWnYrNWxhck5FcXZublZERHFkbjFuTi9uY2NSVVBGZmVJdnhX?=
 =?utf-8?B?SHJkejQ0ejd4QkoyUHU2RE11V0cxT3c2aUZ2Yng3WVAwaWl1ZElaZGxKdVlG?=
 =?utf-8?B?b0F3Y1FSZUlLc2NBNnhkaEdKYnNCRmZWNXcyWittVDdzYUFPbkRSM2tGR1pw?=
 =?utf-8?B?aEpFdXAwT1RiKzdjdS9VUlZLb2NPbUZRYStHMzVFVng0MEhINmNwYktkWE1N?=
 =?utf-8?B?ZG16VStkUFlVa2RhUURnYzdjK1FYdjFHZk9Hd2FDRDE3cEIxbjdwNXkzUzQx?=
 =?utf-8?B?LzN3Q3F4Mkhtek9pS2VVL1AySzRXeVhKc0ZsZmF3anJmZVprcG1PV1phdFRL?=
 =?utf-8?B?elR0VFpHUkk4anAvSzdReWRTVlNVTmU2TmxTTXZ1eVNuUG9QZnY3M1gxaWZh?=
 =?utf-8?B?aUxCdS9CbDNXbGY1S01Rc1p6M2djOVV5U0pES0dPRWo5amJCdzVtNytrMk9R?=
 =?utf-8?B?bXk3K09mMStISk5rTHdKOTFUTnRwNlZ2SVM3TmV4SVF2VStMdGxJOW02ZlhN?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27aacc7d-f020-45b2-e7b9-08dbec225f92
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 12:47:38.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Vp+JrgkCp5jOLVmunYyHM7PNVokx90VRjv6g1oQcSEAUjTNckdowsTnEyQFZGlf1dXO1rGrKAnTrfdG7rvQDd0AtFcQLEblvKEBtph+YNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7315
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.11.2023 13:34, Geethasowjanya Akula wrote:
> 
> 
>> -----Original Message-----
>> From: Wojciech Drewek <wojciech.drewek@intel.com>
>> Sent: Thursday, November 23, 2023 4:15 PM
>> To: Geethasowjanya Akula <gakula@marvell.com>; netdev@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Cc: kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
>> edumazet@google.com; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
>> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
>> <hkelam@marvell.com>
>> Subject: [EXT] Re: [net PATCH 1/5] octeontx2-af: Adjust Tx credits when MCS
>> external bypass is disabled
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>>
>>
>> On 23.11.2023 06:59, Geetha sowjanya wrote:
>>> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
>>>
>>> When MCS external bypass is disabled, MCS returns additional
>>> 2 credits(32B) for every packet Tx'ed on LMAC. To account for these
>>> extra credits, NIX_AF_TX_LINKX_NORM_CREDIT.CC_MCS_CNT
>>> needs to be configured as otherwise NIX Tx credits would overflow and
>>> will never be returned to idle state credit count causing issues with
>>> credit control and MTU change.
>>>
>>> This patch fixes the same by configuring CC_MCS_CNT at probe time for
>>> MCS enabled SoC's
>>>
>>> Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM
>>> for normal traffic")
>>> Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
>>> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>>> Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
>>> ---
>>>  drivers/net/ethernet/marvell/octeontx2/af/mcs.c     | 12 ++++++++++++
>>>  drivers/net/ethernet/marvell/octeontx2/af/mcs.h     |  2 ++
>>>  drivers/net/ethernet/marvell/octeontx2/af/rvu.h     |  1 +
>>>  drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c |  8 ++++++++
>>>  4 files changed, 23 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
>>> b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
>>> index c43f19dfbd74..d6effbe46208 100644
>>> --- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
>>> +++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
>>> @@ -1219,6 +1219,17 @@ struct mcs *mcs_get_pdata(int mcs_id)
>>>  	return NULL;
>>>  }
>>>
>>> +bool is_mcs_bypass(int mcs_id)
>>> +{
>>> +	struct mcs *mcs_dev;
>>> +
>>> +	list_for_each_entry(mcs_dev, &mcs_list, mcs_list) {
>>> +		if (mcs_dev->mcs_id == mcs_id)
>>> +			return mcs_dev->bypass;
>>> +	}
>>> +	return true;
>>
>> If there is no mcs dev with the given id it means it is bypassed?
> Yes.

Makes sense
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>>
>>> +}
>>> +
>>>  void mcs_set_port_cfg(struct mcs *mcs, struct mcs_port_cfg_set_req
>>> *req)  {
>>>  	u64 val = 0;
>>> @@ -1447,6 +1458,7 @@ static void mcs_set_external_bypass(struct mcs
>> *mcs, u8 bypass)
>>>  	else
>>>  		val &= ~BIT_ULL(6);
>>>  	mcs_reg_write(mcs, MCSX_MIL_GLOBAL, val);
>>> +	mcs->bypass = bypass;
>>>  }
>>>
>>>  static void mcs_global_cfg(struct mcs *mcs)
>>
>>
>> <...>
