Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03AB76ED61
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbjHCO6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbjHCO6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:58:38 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C2173F;
        Thu,  3 Aug 2023 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691074717; x=1722610717;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jS/mXCBZSkDTBFcBPg5ljbbgQMH3kqXPoPdI2ODjKZw=;
  b=ZOnvYsSZd5944574Hjlj7eY91ir1C6f238Mf/gs9npf1QoHt8JqSmarn
   o69VecSHPLGP6jAXtYuSBHn302kmnETRwMacD9cyRNHMULL9CK/xyNKVN
   zbdcu/zD8Ll9X+lsAB4n4t33pxdfLqtDiHgIiGalPj0qoxU7SXED0p4pl
   mqIlJNbX6hSpK9YiB1ELtrx9m0rHi5Q8zkCC3SAgfl+8Oc1O2TROYDCHz
   yTZqymdKAfdlJdYFEZBUYNmYW5u0NEUfcRmDKGvTGDQTm0glAsNy2y+O7
   sSt3OPusoJCF1abBBsjTn93W1redeVtd4efKuv661fdINKId8jwftBOWK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="368796876"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="368796876"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 07:58:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="706573784"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="706573784"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 03 Aug 2023 07:58:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 07:58:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 07:58:34 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 07:58:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/odtR0F8eJubSupwxesetTayUafwFvuXydCwb+ZSRRUiWBWWBGDhPVZgKh0ATm7BLODh0nU7/7wEuyncWF2dkNZIPBZX+Jku47wAPZIUjOF2Xf0tCmbEwGrNebJIUTEIMLVXFeqXsGf0lLf07tp4TLgmB1//yUOkVbAqOnwE9CR6tKPuyPdAb56B6OOTNBjgnNPJ9gotLxSGiTLZ7a1yy9YmU4fHwogUplH8GB2ecuMVKKjfHZ6mFXS7uEeST6aJ+8qkhdF0DB66wPQKMBlBapD7hEppEnMkrVCs4+l1DXggsl7vjA4PmPka7bP78xbObtRHqF/upzdCGOAFFcwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LlVYQi/yALqi73M4wAGIzmlWYbWCqJVT5S070aSqxI=;
 b=MADAKvhZwqPr1szkQo/0NNje+3NptdvKFeQy3vCXLxAu+aTljcuyjq33SfamGc8vAlMaTKrcsyKOY6G3SIYdFQaITB6lnqlzf7AsK63Oktr/ZHcGXppGPTg1vB17WEQwzjCl/3mo3A+pJlkssoOoLtb8UwytVGI0mK9PyyquOXSsMUyfOTRqzVzB/x0VFLeJe4tDY3YC7zb327NYQ8Wlm96Woji/itsQydPO5LCH1QvSo+o7OMNLil3LcbuGq1xWglNmspBXi8wx5pxRDrMVBDzEoZv32fPm6dZh4gQwurJmyJGtEZlNySwTz3KxbB5Nj7vP4S1uhytEOV8iloq2Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH8PR11MB7022.namprd11.prod.outlook.com (2603:10b6:510:222::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 14:58:27 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 14:58:27 +0000
Message-ID: <7b77dd3a-fd03-884a-8b8a-f76ab6de5691@intel.com>
Date:   Thu, 3 Aug 2023 16:56:22 +0200
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
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230802142920.4a777079@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0446.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::22) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH8PR11MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: f68297f2-c3c0-4aac-e2a4-08db943217b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIp1i6a8dpSA1dSgIPCcr1QrRPN/fvmwvAMV1CtuCcm6P/YFUp2nvhin5X1E02SxKqXMtfCtMUMy/e1OoCCiW6r86cKoEWHXtrJYq1NtNU3amU2HJuyCgTx5fmUT1SA059oyQ/oKvelfm2mvVSVHiyZrXfjdy7KRLZpiu3uGX0fv/tLpG6TCG8WAG5KT0ydX5yCHVyvKlC0cEfsiFXnqdqEFtJZssto6EVskgJN2ChjYSOnAkkusjDKKLUC6PxJUE9mCifvpK2m5az6aev4ki2zfoioGAyXeIEi7DnutFf79q0xXZeRKfJRYWBfghFv/PtGxPpmHH8aIPa7QG0vTm79wGH5VJyfipCmH3Mq2lBLXufM8Qt7mPA0m/c7lFgsSpBjUWXKczsFxNAip9Zmp7eLFeFAx78wDGTQrHEY8ea5iOVa4uAWHkBg9eznsF/xv5wos0Y9lypzVvqqoMjf3HocqlJb2+mm1yPeDGmVhKW4NZC0msbEC8+rc7cDVIlVtaeGclsAKq83HK9Wi6+B9F40c3VZwbA5pMbHv1ieEkrcn92aIi32O4uvD8boLGBlWNHUAv+VfR4d3yC2DoFC1AL4uKchrSy6VhGMjj1Y7n5r/mdvuWRUCvTA+1Zu4Juu2Tx5ICkkW4IX8FWpF40baiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(2616005)(6506007)(186003)(26005)(8676002)(66476007)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(6916009)(7416002)(8936002)(41300700001)(6486002)(6666004)(6512007)(54906003)(478600001)(38100700002)(82960400001)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnQ0VmRacHhyTktFV0FPZkkzRmhtdmFvZEtOdmlOajY5QTRBV292Uk9hQ2lB?=
 =?utf-8?B?bTBtakV0K3ppSUNmZ2pNNVVIZDF0ZGJNUzJOcktZVWNxcnJNcEpBSm42ZkFq?=
 =?utf-8?B?WCtIQUV4cVBFUFBvbXZVWHRHS0F3enE1a0ZvMVl6bU1ZTVZNSm04b2k5aDRC?=
 =?utf-8?B?Y05NNnIvUlZxeURQNitFcU1JYVdPMUh3eXp0V2VkWXpoWWVuT01Ed2x4SDEy?=
 =?utf-8?B?dFhybTgvUWx4YzZHMnIwWm13S29HQ1VXNXBJL2E5ek9rRmJZQXlpUDZFbEpr?=
 =?utf-8?B?MUk3WHR5bHdoa1NXakl2alBWYXBWRDMxV3g3Ti95cmVxaHNzVTRzZW9BSG1q?=
 =?utf-8?B?alU3KzBJZjlIWjVjc1dqOERmMVhFaUdITlNjOFJTN1Y4NEUyRWVYK1BUbXlk?=
 =?utf-8?B?V3VBV1VVYjhHRWFyS1NUWkZJVWVCTk45SGx5MVJJcU81NGFqRWJsYmVvbTQy?=
 =?utf-8?B?MnJoSmxJb2J2S1Zuak5UWTRGbzFSU296dm9xN1pFbHZDQTEza2d3OVdKZU9D?=
 =?utf-8?B?YXlVRUNDZVNqWHY3UmcwVGgrSHVpUDJXTUI5eS8rTXRiTlBTZG8yV1o2Slhn?=
 =?utf-8?B?b21Vdkl3cGhZQW9DQ0ZlV0JwS1NUbUpoVnBHTllKYTYyRXVkVGlwYlQ5a3E4?=
 =?utf-8?B?K2ZiRnV6ZjdCeXhZOFU3SHd4bXR0Q2VvdXhnT2IvQlIveHRvUXpseFZMeFk0?=
 =?utf-8?B?ZXFPWU5KMGU4cDVUdGFtQUVsdDRRTlFOTVBISm9WSG0zUE5taUpERm9kaFM3?=
 =?utf-8?B?aVkxeVFaNFNJd0xFZmx5QXRidUdQaFhmbldBaWVnNVJxcUxrd0hrMzd3SVVF?=
 =?utf-8?B?cVFJNEFrbE9kTXJQaDhhWmhZa3BpZHgvV2I4NUlXcXFpRjFXR0lsdGlDS3dj?=
 =?utf-8?B?Y3B6emdzWHNiNlE3UDJ4VHkzWmU2UWJpbFVYanNVS1kyQ0NZMk9zNGQ0MU4z?=
 =?utf-8?B?WlcvZWFUcEh1NERaVDEydUlZa20rR1hxZVRjbEQ2L2VSOFlvRmVvSW9lbWFL?=
 =?utf-8?B?VDIxd0NJOEZiNjJadjdTQkpKYmZzdnlGUnV4OTljN0RXai96TUJUaUpPVExr?=
 =?utf-8?B?Y0Q3dHpFbDZLZUpVaGdlUnZub3M5bGJwWXRWRHNWeE5mV0dqYTdkK2RmaHA3?=
 =?utf-8?B?R01aTk1wWUhOMU5EVm5vUHZJbFhVVEs2TjE5aGkwMlBYQ2V2SHpzMzVuWWJw?=
 =?utf-8?B?SHh0TUhXSmZVaEFNRVBrc2Z0Znl5L01aelczTWRTL2VNbWRPOW9lUkJWQlZ1?=
 =?utf-8?B?OVNsbW9XRHk3ZERVblhYalY5blAwUE9Bd0tLVmJjZzNxNDliZDJlVjhmRU9l?=
 =?utf-8?B?RGdORmp2Z1o4MnJ5YStndWVQWFAxWUgyQVlCTkg0QXFSdXlTTzhvWEpJMlEz?=
 =?utf-8?B?QVNQam50K1Z0VG85NnhFeWIydnRCK0lDSkZmZ05IbEt3UkJnVzRFdDBZK3M0?=
 =?utf-8?B?TC9SNHlFWS9ma3Bjc2FZQkZiR2dGTDVhUFQ0TjQ1UVRWaS91bVFuRHRKS0JS?=
 =?utf-8?B?T2xIWXFEV0VFZ3dyVnJFVndFNHNOT3JRY3ZOZkNOaXM0NkNGZTZya3M0bURs?=
 =?utf-8?B?akFkNE13VWFHRmFDbDBGVmV0SVU5dlg5MTZMcEkwVkNXNExoZTJRY1lVZjR1?=
 =?utf-8?B?Mmc2bGdwNzI4ZHdBOXBUeU5MemY0aUFCSm85OUZKUEJZaGh3N29RNmVYUnFN?=
 =?utf-8?B?MzczT0VDazYyTWtMUVZ6a3dLZ01YVFhEcmZvV1YxRklYS1I4K2lqOFQyMmRM?=
 =?utf-8?B?b2tTYWJDTUtGeUZKRC83bkYzYkJZaGlMZHNieWpyWlZrL1REWmYwZjVieEIy?=
 =?utf-8?B?K0ZMNGozUGV0RjhRMGFSVmxsTmZYeVR0NUR2UnRyU0V3MmpqSVkyVEpuc2Jz?=
 =?utf-8?B?U0NmL1BZMkp5VFBUWEl6TzViK01CZTZmYTBBR0JwSHRFR0t0V05IMzkrWHJI?=
 =?utf-8?B?UW5WNTBvaGpmYzFNMDdZdUdpRXBienJLeTJkZTkxNGp0QmozK1pXeHFLVjBz?=
 =?utf-8?B?RWh6ZDZRRmhJQ3pQcVQ3M0ZVSThGQTRoUklSUjNqVzE2QkI3eE56Z2pZUGFl?=
 =?utf-8?B?bERFWjBJT2tqTWRkRlZ2a1E0ck9WelRFT1ZmelFkc0plQkg4UnhsRGw2TnNC?=
 =?utf-8?B?cTJJcEhpa0ROY2RGYVk0T2tnYTZUVHBtMlVlV09KUnovc3RhQ3daZnozbFcw?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f68297f2-c3c0-4aac-e2a4-08db943217b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 14:58:27.2565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsfMuBSNG/ALXtNmblIXtwtk8uuKxjAt4kbIGzjJqHe3TFkZH3Kq6TBM1ZxH8HbjGRNpAO99rvQY+dHiX0EMIVeVHl8L5km5K3iUxzbyP9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7022
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
Date: Wed, 2 Aug 2023 14:29:20 -0700

> On Tue, 1 Aug 2023 15:36:33 +0200 Alexander Lobakin wrote:
>>>> You would need a separate patch to convert all the page_pool_create()
>>>> users then either way.
>>>> And it doesn't look really natural to me to pass both driver-set params
>>>> and driver-set flags as separate function arguments. Someone may then
>>>> think "why aren't flags just put in the params itself". The fact that
>>>> Page Pool copies the whole params in the page_pool struct after
>>>> allocating it is internals, page_pool_create() prototype however isn't.
>>>> Thoughts?  
>>>
>>> It just seems odd to me that dma_map and page_frag is duplicated as we
>>> seems to have the same info in the page_pool->p.flags.  
>>
>> It's just because we copy the whole &page_pool_params passed by the
>> driver. It doesn't look good to me to define a new structure and copy
>> the values field-by-field just to avoid duplicating 3 bits :s
> 
> FWIW I'm tempted to do something like the patch below (an obvious move,
> I suspect). I want to add another pointer (netdev) to the params and 

Just take napi->dev as I do in libie :)

> I don't want it to eat up bytes in the first cache line.
> The patch is incomplete, we need to stash a one-bit indication in 
> the first cache line to know init_callback is not present without
> having to look at @slow. I'll defer doing that cleanly until your
> patches land.

I would propose to include it in the series, but it has grown a bunch
already and it's better to do that later separately :s

> With this in place we can move flags outside of @fast, and interpret

Oh, really nice. We could avoid copying them at all.

> it manually while copying all the other members in one go.

[...]

Thanks,
Olek
