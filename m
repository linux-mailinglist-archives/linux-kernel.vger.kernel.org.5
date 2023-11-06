Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBEB7E1FD0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjKFLUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjKFLU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:20:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A1B6;
        Mon,  6 Nov 2023 03:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699269624; x=1730805624;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9lzS5P1+/dM39wrKO2NyDMat/dLOZVCvWQLYZeq4zzs=;
  b=jGuP16jkDj1IhTpi2xsYdBb0QCdgHdQL6xOUW5oNyDl+wPE2F5klHASN
   52R5jAgaXAf5GMHyveOvw8O00CLkYWCIme62TXGEgZE9biyYXhtw9fybf
   DKVTcDNeTd/B0Pajn0v34rtoAQv67ORfGTvrYYVNIKtWMm4uSv6zMqPHz
   ZqPAU3hviLMWXVhSWXgCc1uVJwKIcpY68oZnsIeNULfu0XRQ259Y0oQU8
   T+51mycA0sCibL5XlRPeMmSfjWM8WYqWJhWD4IDdgqoOznvRPRNKgrkG2
   RCK8QNmdALDtz0v32egsR98ZlGax/AXuydkt6igJdUny2eFJkkUZQGoqf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2245110"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="2245110"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 03:20:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="832690836"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="832690836"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 03:20:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 03:20:21 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 03:20:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 03:20:21 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 03:20:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxbdXGP3oM9sPQI2GpDpxS1KXVI04+wo+I28i6FKpTOstiAn153yW0AMNc9zab0tJjDvoctY2pUN64P/XrMds18aWFfDxcjJEoi6iEcImZ83dXKnDoVHDrhQimytIfsP3O8UdiTwUGWqNiBETy4khw7O9RK5midw5vPXZLg9uy2Crh9vuxhdZIbwYx+m+KDFGG+an1KLNDKkzw+RxQRfFffqxs+jG4bgW2Nj8WaNUESjP5NytL3NDEPGVkuTJb0vZgObBtdQwoVoUE4QWq50ZFmtKnw47OmfB8gtgxDLTG6QSbZqAuV2lADiwtrIAG5nm0gNDR7fzsQnXUipIGGMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRo8YDu+c69Vjmk2VtVXja4RkSa+3n05nf0OqAs9lh8=;
 b=NY96ZZTlwV34/yu9XjX4Er0ezUnAAbOXBjMkRyS2jwgOUCuE8g+8yz4Yv5pEgxEPDzvjdQis4WRB1ZXUhGCVDtNA18h6epwNSeqi7cZH7dQraROjbdPmDN3dokZKax6Dgi3T4hXCfCje9U5qcLohFWm8fr3qQYaAklywOhUbvR7F25K2eVY3FT3RFROBGFuu1EquKPmEARiZjFrFjhun7WcpBZjGhPFyjPt0azbd0p62/FV5WjPxD55kdxvigdAGOtAe871lmAHo54yJGe6s3GCSMl6N46xXphj9u0+hLZa+jo4zsd5woXMxnLP5s3NAqhYoEqHV4GrBO4QHZbzS1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH3PR11MB8749.namprd11.prod.outlook.com (2603:10b6:610:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 11:20:19 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::36be:aaee:c5fe:2b80%7]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 11:20:19 +0000
Message-ID: <bf2b6899-fad0-4ac7-a906-e8d361e5a46d@intel.com>
Date:   Mon, 6 Nov 2023 12:18:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [alobakin:pfcp 5/20] drivers/iio/imu/adis16475.c:363
 adis16475_set_freq() warn: set_bit() takes a bit number
Content-Language: en-US
To:     =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>
CC:     Dan Carpenter <dan.carpenter@linaro.org>,
        <oe-kbuild@lists.linux.dev>, <lkp@intel.com>,
        <oe-kbuild-all@lists.linux.dev>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <ff4ef031-774e-4e4d-a009-31f242bf6aee@kadam.mountain>
 <5b0f8705-71cb-4c4c-a70c-d9d3a15886cb@intel.com>
 <f040255ef1b3be87050b8255c947b4b375e75a02.camel@gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <f040255ef1b3be87050b8255c947b4b375e75a02.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH3PR11MB8749:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6fafb1-8e70-4921-fea4-08dbdeba5bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/SWKyrQmteWPji41f4Mlcf1zkH2fCxm1ddgkD4z1ntI0GnWz+CxsgI0siOGsQB/toss37fw6Ij/dcfG5fw2+HMxzNJxoGK6G5ljXHpQJvDkEyDhinJN3R2/SwCH23zhnGfjH379qVayAh57P2UgE6VpgtHIVERvgdQ/8NThXC1rukNVqtkApWWXNK/bYi/fYb2tPwjzT8w+wchCbcBVS+5AOQTXncUnkK47LNKD2kL+OzYTVjUdNXwB4kJZTWflaTrYGRI2hulXhIVnGwS9Cg70cNOfWjSHd/J04t0gFgPYMzCt1EREL1W8cDuF+xTa1JqUmDCDNCkXGcPd8K0tXUTB+A5nPZA7bZRL7oDWv+g3b2Xi416gNF3Je84HFlvzZ1yXqLtPiIk9TWL7NFpjNrr4X4drqb14Ns2F0WlqEycA0clCIAVQ3wI7Ywl90NIYuJ93J5ezBsAoR2Xi071n5aP2Q4UksmUi0qte0sGWxkKIWrxvAmKWpr46lYK+O7RXA9nYzI6ybT/2qVUIiW5uxyUYkexk83j4kzj5ydxaeAAry5scnFQKk7jwd2ZxwU017EuSXTS9bTTy89FEp5woBl+21i3/vP4iTsnR5IbuudRHEkUob3evPSzO5SOsXBs3e3neQbk/vygTEwSJKPeYV7fqwHxB1W0WGeS5ZnloSwK7GZWTTBTQhPs6TLjj9v1yfUvUv/WY56mtNj+e0tcHDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2616005)(6512007)(31696002)(82960400001)(6486002)(966005)(26005)(478600001)(36756003)(66476007)(66556008)(66946007)(54906003)(316002)(110136005)(6666004)(6506007)(8936002)(8676002)(4326008)(2906002)(38100700002)(31686004)(5660300002)(83380400001)(41300700001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmY0SjhPVUxYNDhKZnhxb1MvTitDRmVreERsY0VvejhYWFBMSy9KOExhL2Fy?=
 =?utf-8?B?K0I5c3BXc3BsSUZBeFRwTGpoU0k5ZFVPb0crckFkclo5dkZSWGlBWjNIT3dL?=
 =?utf-8?B?dVJ5TlFMaXloT0JuWC9RRjhlcnFkb2FWbHA3ZTVCRUVkc1FvQ1JmTUFOTmFm?=
 =?utf-8?B?ZEJBZVFiWVBzTC9GR1VRWTNvSCtEOU1Wd2NYeTU5eGsvSFpzbE92bkdDblNU?=
 =?utf-8?B?UTVJTW1kTDRiRlhUcW53L2lZaTJBMGZXcStKWHhGcW9ZV1gxWG9OZU1rL2NU?=
 =?utf-8?B?bDRYT0x0YldqdWUzalFIRlNSaWxJUnNNQ25neG82ZDNzZGFyZWdkdmU0ZDhK?=
 =?utf-8?B?cUhWeDZBc1FlQ1VXWmR1TnE0SlhLU0lkeE9yYm84MlNiRGorQ2VQQURXNjZu?=
 =?utf-8?B?VzV0RHNlZXZNNjFlVnU0Tm5mTlJPYU10OC91cENxd0pUWWJkUkloWkZ3ZVpE?=
 =?utf-8?B?Q04vaTNORytuUFpoTzh4alhCVm55OENYenJQNW1CYW51c1AwOUkyYTFkcFV3?=
 =?utf-8?B?dmltRWNvZWRMVTI2TUZiY0tIYmFaSStTMHl5Q1luaXorS3oyZzBTWDlwa2Nw?=
 =?utf-8?B?MEY5enRoWG44endlTFpSdXRkcWxURWxNcW45eEdJTFVEWE9QWGVyQVhYbmJN?=
 =?utf-8?B?UGFnMlN0d2p6MnEwQmFESlkxT3BFeUxpbU1pQnpibWpURjB0ZFgveThXQjFw?=
 =?utf-8?B?MHNLWW5WWXMvaDBiZmkvZHJ6cmNvck1YNXBxMmxyZjBnN2ZRS0d2Y2FneHJ1?=
 =?utf-8?B?TzdWN3lWamM4VCtYU3BUL1NEeDhyTkh6dUpxdytNOTlQR29iUFQySHRXV2lV?=
 =?utf-8?B?dmhnRWxLN3VOTCtmUFNMdVVLdjRFdWFEbUkxZ1Z2UXh1QWJMQlVMY3k1RkJG?=
 =?utf-8?B?a2FNL1hxekphS2tVVG1vS0dlKzFYYk52NnFJc3pwR3NsY2FCajVjcU96cmZs?=
 =?utf-8?B?R3Bna0ZKM1h4UTNoS0VsSlFvZkxsaGNEZFV4UWVSQkRpSEJlVVVkaFViR1dJ?=
 =?utf-8?B?bnBIdG5neWtHcXJEMHVjSVNQLzZ4VnNIdkVyR01LZUJzNDV2dkN6Yzh5ZlJI?=
 =?utf-8?B?eGNFOWdEYkZJbEVlSXNqVEg1QVcyNUNseGVja1IvcE44MXptb0dGQzFldGxq?=
 =?utf-8?B?TEJYcldCSjFwVEtrN2xRckRYakJ0bjB4VWRBZ1JYSzd0WFZ4czBIUFMwQ3NT?=
 =?utf-8?B?MVg0VVRRUEFJMnJQT1RuMzRnZTBNT0QzZ3praUE3NmdJenJGdU12QkNmVlZv?=
 =?utf-8?B?YkhZcGxlNk05MHB5REVneE5xWEFsbjJ4enFuZXZRU1ByWG1rcnRHSkdZWEVi?=
 =?utf-8?B?K3pQVE8xT0hVUDhoWjlvU3FNREpSRURWQk50dFNSb0JVNVorZjg3TW1OZXkw?=
 =?utf-8?B?UzczZksrdXEvcWlQcXcvaWZ5M2lUaC8rUjFrTTQrZlE1U0tQa2dJcDcxRlcr?=
 =?utf-8?B?bzdZTzVDWEMzQVl1MVIrakZ3MlBwVVJpeVZSeVVmbHdjZS9oYnZDNVNDaUxU?=
 =?utf-8?B?SWdiQTNmUFdVcG1qSDd0c3pqR0dKVXBwMStjSnp2RVhCVFIyWmhtQUFDdG02?=
 =?utf-8?B?UCsyUFcyVTN6bVZHYlN4SFJ2SmlIK0kvaFUzeW9oa1FYdUZJc01IalRSRXk0?=
 =?utf-8?B?dU5hRVRieExmMjN3OWVBM2hOZ2lpR1NyeFZHN0Nwa2VRaVJ3TkpOMWJ5ams0?=
 =?utf-8?B?UjBxMEhjdEdTWHhIK0d2TlZ1Vjk0TkNmeFE1bGRZMCtnYlpoWnhWRFpXeWg2?=
 =?utf-8?B?dHIzMnByU3A0NU8rVmdxMmdCRWhPdkpSanloSHFnTlpLZldZYUc0QVFuazRy?=
 =?utf-8?B?bldHQjE5WFNOdzFNQlc4bGFJYVdveGFSNWVNdGg5YU5GWEFSKzN4Y0IwOXdH?=
 =?utf-8?B?VlRiS0I4ZitIUmVxMDJ2S1lOWElleElHWEt3TkxFSzMyVXhnNTJCQXhPUjdX?=
 =?utf-8?B?T0UzdDFIWGVTTy9lT3YzbjYxdUlmWTBma3AveHdTK3E3dGU3UnN6Q09WUkcy?=
 =?utf-8?B?a2N5bmVrUW1nRnBwY3ZaSWRRQnVKbGhnYkF6NHU2Y1Fxai9FMzBaeHUyWlhS?=
 =?utf-8?B?N21uL1JqVURJR2l5emRoSXFYQlp3SUlxQkEyNjhuK1VTdzB6OUoreEk5Z2xY?=
 =?utf-8?B?U3ZiSDhEZytDK25oVitnMXVmVE1uN213bUx5RkFXYllNdTUyalhlZEMzQUs0?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6fafb1-8e70-4921-fea4-08dbdeba5bc3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:20:19.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7OJU+4lz+iif2y5/+NCaIGNoL3gXyVa7KMRwq5jlqXSpoKZW3PuiBgojnGUxBQgrg6NqCNvEa8AvuCcNtU+XvXJucoeWQVvRMY5rxGrAOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8749
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nuno Sá <noname.nuno@gmail.com>
Date: Mon, 06 Nov 2023 11:07:16 +0100

> Hi Olek,
> 
> On Mon, 2023-11-06 at 10:31 +0100, Alexander Lobakin wrote:
>> From: Dan Carpenter <dan.carpenter@linaro.org>
>> Date: Mon, 6 Nov 2023 11:50:03 +0300
>>
>> Hi,
>>
>>> tree:   https://github.com/alobakin/linux pfcp
>>> head:   89565e300e3d4033b8bb568774804fdc09d4f3cc
>>> commit: 945a0d6e86d97bf60f2fae88ee557ed3eae18b94 [5/20] bitops: let the compiler
>>> optimize {__,}assign_bit()
>>> config: i386-randconfig-141-20231105
>>> (https://download.01.org/0day-ci/archive/20231106/202311060647.i9XyO4ej-lkp@intel
>>> .com/config)
>>> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
>>> reproduce:
>>> (https://download.01.org/0day-ci/archive/20231106/202311060647.i9XyO4ej-lkp@intel
>>> .com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>>> Closes: https://lore.kernel.org/r/202311060647.i9XyO4ej-lkp@intel.com/
>>>
>>> smatch warnings:
>>> drivers/iio/imu/adis16475.c:363 adis16475_set_freq() warn: set_bit() takes a bit
>>> number
>>> drivers/iio/imu/adis16475.c:363 adis16475_set_freq() warn: clear_bit() takes a
>>> bit number
>>> drivers/iio/imu/adis16475.c:416 adis16475_set_filter() warn: set_bit() takes a
>>> bit number
>>> drivers/iio/imu/adis16475.c:416 adis16475_set_filter() warn: clear_bit() takes a
>>> bit number
>>>
>>> vim +363 drivers/iio/imu/adis16475.c
>>>
>>> fff7352bf7a3ce Nuno Sá 2020-04-13  357  
>>> 9da1b86865ab43 Nuno Sá 2021-09-20  358          adis_dev_unlock(&st->adis);
>>> fff7352bf7a3ce Nuno Sá 2020-04-13  359          /*
>>> fff7352bf7a3ce Nuno Sá 2020-04-13  360           * If decimation is used, then
>>> gyro and accel data will have meaningful
>>> fff7352bf7a3ce Nuno Sá 2020-04-13  361           * bits on the LSB registers.
>>> This info is used on the trigger handler.
>>> fff7352bf7a3ce Nuno Sá 2020-04-13  362           */
>>> fff7352bf7a3ce Nuno Sá 2020-04-13
>>> @363          assign_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag, dec);
>>>
>>> assign_bit() takes a bit number like 0.  But this is passing BIT(0) so
>>> it's like BIT(BIT(0)).  Which is fine until you get to 5.
>>
>> Is this intended? There are 2 places where you pass
>> %ADIS16475_LSB_DEC_MASK and %ADIS16475_LSB_FIR_MASK, which is `BIT(0)`
>> and `BIT(1)` respectively, to assign_bit(), which takes 0, 1 etc.
>>
> 
> Sorry, I'm missing the point in here... This should be a simple mask as 
> GENMASK(1, 0) setting/clearing the bits when appropriate. Obviously,

assign_bit() does not take a bitmask as a first argument, but a bit number.

I.e. if you want to switch BIT(0), you call it like assign_bit(0, ...),
not assign_bit(BIT(0), ...). Same for the bit nr 1.

I can make and send a quick fix if you prefer.


> ADIS16475_LSB_DEC_MASK and ADIS16475_LSB_FIR_MASK are not properly defined
> :sweat_smile:
> 
> - Nuno Sá
>>
>>>
> 

Thanks,
Olek
