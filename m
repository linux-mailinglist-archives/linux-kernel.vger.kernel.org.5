Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354F276EFD1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbjHCQnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbjHCQmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:42:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C23C2F;
        Thu,  3 Aug 2023 09:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691080947; x=1722616947;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yeT3FVZgzgPga454dNZInwHumKv/C4uLhe0qP9ePJfY=;
  b=TiqxVpjJduSoudaB78KX2AU4TGkRLIhqjkYp9HuzrCueuMg4LUM9b9uO
   2VollN+a0EPzdUuaM/efGz36k9ZA7fHC0UEK9owz0zMTdCpWXSHeP/iZ2
   Pn2LwQVjld8kWdUrGpOcC285N3DKKdnU6OqUEJXBIeAgYRckGZ0WDT3pT
   Ar0rMCIQRSbzhJlkyifGwkGIx2FMdR7G0gsY+UNLHfZN84MdJpZbz6Wfh
   rXyWOw/uedpMYDnauWxlVqyMtQJn3E55iDztvJb9eKSKJQo8S/18QlxwD
   SE6Awg5fcF5ThUWNZwPNq+QQMsa2V/ENI92EnT7NCQvNS1AzC/zJf0IOM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="368833046"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="368833046"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 09:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="759201544"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="759201544"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Aug 2023 09:42:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 09:42:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 09:42:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 09:42:21 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 09:42:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM/ZQ4Iz5Akf9Ztb7RL+0ZDPhcMZvGoL69iVB/jDvpEfbg1cL8NSeTQIoC+kjxQpsKzRgFqRttMriP4p4iT8cMFL0hdrr/uly12/e0zb34CgXPrjp7lgxwWqLHiZA8z5DU+unC3G9Zr1OyZ7MW+C0A6gTP4r8qWJjW530aFBU3bwSGFtZbh0K+A0dKR5ksjTRoSNrKWoAUguxE/gbqTzFNQC1bn48bGWedndb0F/29jshiWqx5p+75WjFdQc5oJUhfsz/vPi03nTlpwzHTtpl7FPZ3WNZt0pzXDE3sPj/Gsjo9O7sMykKTgDCmfUQVqwHS7edbTQAGpgWjk6/oy53w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeC99JrjCXV2cPmYxeHJNh1TWSwDYNup7hbe3ExB4ek=;
 b=HUGbiDK5wOjCV/ys7EDDqKp6Q9PybrQK89XNr5+G/mqiRVIgW0qArxOp94x3W/DQZ0MfuNxSbOj8xtRkQ+89rE8G/2gM+pJpo03gqphmgK5syNukaF+QFXy+mSgf97EuezJ2ZrojZ6IHIHLHMg65HO5TeXjRql6tM/73OjB6hRcu+ZrvR8L4XLyY2Rk4oMS4XZm5v8aQQS5iknBDf09gOGAFroM7gDw6JTZqUWnLpGT2wKZhEcQXuGc6v+ZE6xvLnErHN/xeLpgo4LAX6CbelPJN9wXS1OufCY+FOuYvvMJFPSpdGNX3A/nWnZFYu3DPxDh7gb43DR9jUdAYQe6sCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Thu, 3 Aug
 2023 16:42:19 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 16:42:19 +0000
Message-ID: <53c19bba-4513-0778-5e9a-2cffddad4465@intel.com>
Date:   Thu, 3 Aug 2023 18:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 5/9] page_pool: don't use driver-set flags field
 directly
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
CC:     Yunsheng Lin <linyunsheng@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-6-aleksander.lobakin@intel.com>
 <a0be882e-558a-9b1d-7514-0aad0080e08c@huawei.com>
 <6f8147ec-b8ad-3905-5279-16817ed6f5ae@intel.com>
 <a7782cf1-e04a-e274-6a87-4952008bcc0c@huawei.com>
 <0fe906a2-5ba1-f24a-efd8-7804ef0683b6@intel.com>
 <20230802142920.4a777079@kernel.org>
 <7b77dd3a-fd03-884a-8b8a-f76ab6de5691@intel.com>
 <20230803090029.16a6798d@kernel.org>
 <7c1c6ec2-90cb-84e0-1bc3-cf758f15e384@intel.com>
 <20230803094043.31d27cb5@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230803094043.31d27cb5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0371.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::22) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: b0048768-8993-494e-252d-08db94409a6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTSaJTZAJrPTjyuN3gHJcJ83eaFS6ZzO8+guhej+dd7zwuklpZIlL+5DxDYZQnrMeC1LtroC/XjnhItfq3zw/oN2Q4mAhoxxxvJaQGsC0MR2ei9eTtyJdH8CPXAPuN9M9iyhwTQFIMDo4TgeT17qXq2O2mvMx6Q2AeXpNBAznFX66JcFT4dwjtUtOmM2fWp962Pc4SzgFEJ66kuvpenW3g6xn9ShSq+cr5I+KK9m+XWqiow8ZlLq/H7DB6pvPbYQVyn+peBEKJDdNnAim3hjTYUPPH5YoKDrKwOWp3r7K23h1L7vW86IgX2ihN+Hwp1F7qsEHjBvo59GjtBi/Zcc4/2LNc1Z286wxSoAmeVH3e5JdYQ4ja4u0WtSVnzrBex/UWL9A4K/gjOsLnfdDargiF/GHi7lYPlTjy/svu9t5+3B8clBv1hH8ntAjWaFqVieLjbUIjZyQiOCgyNDrBTwdYOeUmAUK3/Wh+QwUxsdF6UHicjXTfYm1bGu9aK9wF8qgu8DGiVjksV55fdcn7rLj/KXitVxeW76ModAGpCK09NWLL4PvGYR8wZg1qQZRt14foe0+IouyWWLVhCuUWgNiH00JWUMOSB0gVq19x+N7M8KEw169zhC05QgESuWWHYcv4CaCmFKLK9INeXUUkwsCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(4744005)(478600001)(86362001)(31696002)(36756003)(6486002)(6512007)(6666004)(316002)(8936002)(8676002)(41300700001)(5660300002)(31686004)(6916009)(4326008)(66556008)(66476007)(7416002)(54906003)(2906002)(38100700002)(66946007)(26005)(2616005)(6506007)(82960400001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDFGZEhaWXVSanRoQnlGTVNiWVo2TGw0ME4xdkJZMjJxdzlpY0ZrUVBpK3RP?=
 =?utf-8?B?dG84UHRoN210MlBwSnJtU1Qwc1IyOGoreXhsckhtVDJVbnhxNjJxemlwWXhC?=
 =?utf-8?B?OG1XeUlsUFF0c25OZzRFT2lYNndvUHpieWNpcit4ZXhXUFlSTmdyNTcyS3lR?=
 =?utf-8?B?bHMzNG1OVlBEMlNTSTB5Z0hFSW5uc1Jjek45Rk52bHdGbFY5dERzdzA4N3BO?=
 =?utf-8?B?eEZZb1dnclJpMDJjM1FObGlweHh6QjFQUWdSZmdsb2NEQzBSaEJvdS9mSzJG?=
 =?utf-8?B?R1Byb0tncWZvQUpEczhsTVhPTlMvcUVVUGo1RkNEYWZZMHpkZ1Zac2YrRFl5?=
 =?utf-8?B?elpZMnRDRjFYMUwzQmRoNmc2MDhCY1Y4KzRYMnVSTXZTSGs5S2VzRU9vTC9B?=
 =?utf-8?B?aW90ekJDd0JDdXVMSUFZS3psZHJvd2syNnhISGNJMWVmenl3UXdUSmxBN1Jx?=
 =?utf-8?B?d1VTclRqTXRDemRqcnZBUDhoODVTNXlCemRWM0tsN2JVU0RLU0RGbFJVeC9m?=
 =?utf-8?B?NFcxc1A0VTBENmRQQTN2ZHNGV1hNQkp0b0YzMm9XQ2xRMko2RXBkVTRvQ1Jm?=
 =?utf-8?B?cEhVN042cU1LcTlHaEp4MWorY1NSVFdWUXNLSmhxK1BFL0NBWW9BMXNTTkIw?=
 =?utf-8?B?REJjeVZzYmFDbzc4SE1VU1Z1am1GYnZ3NEk4OGp0ZlNJaG44WkFYbklBNGlG?=
 =?utf-8?B?eFhBYVVoSTZlNzdhaXpGbXVyUUxEVDlMNE1WMGl4WDJFL05qTFhxMWF4Q0Rt?=
 =?utf-8?B?QlFLclpFbUlwZC8vL3ZadjRzUG5nS1ZpM1R0UVpuVzAyR1RUeFhTOUpUc2Yw?=
 =?utf-8?B?OXM1bWtVSkplTU5MYTF0dktzUWVyTGRxUUhsc0xBcS9IZTNPcTdVUGNYRUdD?=
 =?utf-8?B?RlVmdVQyWDAvclQ1cUE5b1BreTc1K3JFOWxGbGF1cUs2bzJkdmpiVGhUbmRG?=
 =?utf-8?B?ZFVid2ZDdmswNDRpdDV5cDhmVElxazBuZUtKbzJoeHg4ejhBQXFaYjUrNlhZ?=
 =?utf-8?B?RU9LdVErellFM0tsRDFGNHdrSmt4ZkVsYnlKQWhtVFNQdDdsTXoxcGRUREJ0?=
 =?utf-8?B?eHhKcUpIMTZhSEdudkg1VlZHT1Z4dXpRTE9uMVdsSFlGVXRPb2xvb2RrRENW?=
 =?utf-8?B?d3M2eW45NU52cCtFait1M1lBcisydURYb1d2M2NUdXpaMnAxYmhmR2xRcXBo?=
 =?utf-8?B?MStJNGpzVEduaU5nUmFBdzV4NVYrcUlvYlk0Nms4N0ZyTUVRNThmNHRQV1cx?=
 =?utf-8?B?d0hSSkkrTGxCUFBOVjVQYlhkTEJFNDdCMlJRWGlrZUpJM1I3UXBLdjZReDlo?=
 =?utf-8?B?ZWh6VlZMalJBWC9OMVBsSThrNDJIcVoyTDNsNUhBdTI5VkEvakl1SzBUd3Bq?=
 =?utf-8?B?dDZFbG5haDJmR2tPWGdYZWVCY1ZOOFBOMXpqT1kybkNGK0RVeHR0UU9EZUY2?=
 =?utf-8?B?eCtvTDYra1lGd1pBUUc4YmkxdXNmdG5kd25adklLL3NGeWJJY2VFL0tBZnVO?=
 =?utf-8?B?N3RsbHVSdkZ3RjNRQ0ExYkNNYVJiWVFKckQwTWVHUW02YzZvOWZhY0d3c0ww?=
 =?utf-8?B?NTZUTmpGVG9IYXNaaFNxVkU4NkJmZjZVZlpvU3I0KzlvRHlUSE9CYVhId0h2?=
 =?utf-8?B?ZGNQSzZ3dGVLc3EyRXdTbVpKd1UzZy9LQld3ckdxQU9meGZQZ3ZZMkl4cVJP?=
 =?utf-8?B?Tno5R1FCSndxNENLLzVTVUR4dFpLdkRBamphQXI3cVVYeHI4blZZWldicXRn?=
 =?utf-8?B?blVkT0JlK2hUaWZyY0tFOEpsTllvZzZHRmM4d1hIS2tqSzNsOE0zakdrcjVN?=
 =?utf-8?B?TWJpUjFCNGdZQ0NvSWIvWm5DL0hMSGRrS3lzYW1wb1pyYWNqMUFwWks1cllE?=
 =?utf-8?B?TVRwU3laMDRPcTgwTU5xaS9pS1BoNGdTcHp0QWV2QzhEbFlYbE0rdzJjcDZQ?=
 =?utf-8?B?TzBjd25GV0dPSVNWUmxsd2xYcTg2a3htOGptS0tLVktONjVFRS9FYmgvSnJX?=
 =?utf-8?B?ZjAwLzJ0MHdYc1hGSHFzVmRyZ2tOWnNRbU5pYlJsZ3FiRUxMcWkzcUNJRmpD?=
 =?utf-8?B?MlMzOG1YUElHNzVnc01KckcrUzBHNytuUVJJU3J2T0R5OGQyNG0rK3JNbU52?=
 =?utf-8?B?Uk93NzZYV0NBTUF1V1Z2MTh5a0pPbS9wMmNuKzVvRVR0UEE1WEZad0kza3F3?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0048768-8993-494e-252d-08db94409a6c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 16:42:19.4882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2Qc9dNGnp91j7g/TncZXmEc3dPGL5GaNvpU2VUKR0f6FUTIPEYoZtL4708/jbawXk/qd/4PwbAmpiNvRwGZczeNgAR46sYByUZIamzQrR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
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

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 3 Aug 2023 09:40:43 -0700

> On Thu, 3 Aug 2023 18:07:23 +0200 Alexander Lobakin wrote:
>>>> I would propose to include it in the series, but it has grown a bunch
>>>> already and it's better to do that later separately :s  
>>>
>>> Yeah.. I'd be trying to split your series up a little to make progress
>>> rather than add more things :( I was going to suggest that you post
>>> just the first 3 patches for instance. Should be an easy merge.  
>>
>> One minute before I was going to post v2 :>
>> Sounds good. AFACS only #4-6 are still under question (not for me tho
>> :D), let me move that piece out.
> 
> FWIW I'll apply my doc changes in the next 5min if nobody objects.
> Can you rebase on top of that?

Breh, sent already >_<

What do I do then? Rebase and send v3?

Thanks,
Olek
