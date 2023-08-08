Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2D9773F6D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjHHQrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjHHQqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:46:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBF7170CD;
        Tue,  8 Aug 2023 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510192; x=1723046192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IR7ltUcEiTJlXEgm2655PfVyQmTRxlsP1lyrR9fIHW4=;
  b=JxBUcI1QGcuPOjdZkm91Rhh/Hv3vESUDkVVy/J6IZoNjLjSA1vRuSA8n
   xKBlO+RVh2ls7YGpWMyLUbNr6Ak6OBYleQa33cP/nSAf6WQgzfJ87OIey
   qDIRhHP5cSUu6LQJe1VuQ1Oh9n/cM5HiXRDWIIegBQKYMvyx1KX8buuM/
   bkHMosBb7jkGNtGkMszx6XSCWUpvoWziSVU2iVgTz9obzk4hP18wHcbf3
   nE764h1PL0ISo1NY5q8S4p4CHennmNwq6ztuwNVoLaiFqUC5UVwoyuHAB
   Fecl4hMuRC9j7FOHLZZclL+mMgdpRurtrRfF2XtpN2suoeCw8lKSr/xFF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437181037"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="437181037"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 08:06:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="731442323"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="731442323"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 08 Aug 2023 08:06:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 08:06:51 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 08:06:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 08:06:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 08:06:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvIaWMLK9ywStvJRhvej7tgdOFuHCgYZ9zgpD9+COIm/vZT/unLlDOh9POJ8qb4N+fjcGuT5U+lo3dTvdnyFHhni80+35ypPUtDP9rvnSolG0aHa2V3np6NWmo7qUUMYB8tIh7S0vC06mI6iDMOALPKQrI++RZrPvH9TMRZSoGie/e4DndvlSu8WDJaihAXn5RCuL47x65M5mCdzckw8WuXLGkKsFumh0BWZXxpqrM5S62AgGqi5CisbvDrBWRTkYm5jsN2ykc1tnVOs9nHHw/cjqc4od9Ar/PQUZcpsn7btVeMHTP6xPveMaZW3Wj6NoU8n4UmgmFZCZYBqwqQJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHkalPvfyZHN168PKWdMymG1e4+PrYs5McOAiJO1c+A=;
 b=McAuXSiIZ4zpIUfb7WI0d0/+IeOkl/4vb4V+wudF1A4AybuE0ZOavc5c3M2c2wOJVzzX/1HPjv9CyvaMV4YvHz2OR+3rZYaWOcfaUkXPzmPR0Sw+dl5I1yaFjVuiG+fDCJ8Yn9Ssgx9WjrgakSsFjv6Twznbfn7Stevgqh33BSdYo/IBlKqGCsxBDGeboGc/b5v7pul+18UlStfWyRfgb9sWX1ajR/yRBrA0jUqZ30DMMCI47z+R6ARjFmIfWXxNR42K39eXzGIYtI74jWNQPJgG4k9FYn+jPTiIHnLX6QmZU9TMvWNCJCiwEdclM2FO5UO8gxqTQXG6Mw4jFgcAhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM3PR11MB8734.namprd11.prod.outlook.com (2603:10b6:8:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 15:06:46 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:06:46 +0000
Message-ID: <8ee66e8f-cada-b492-d23f-e4e15cfef868@intel.com>
Date:   Tue, 8 Aug 2023 17:06:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v4 5/6] page_pool: add a lockdep check for
 recycling in hardirq
Content-Language: en-US
To:     Alexander Duyck <alexander.duyck@gmail.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        "Jesper Dangaard Brouer" <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
 <20230804180529.2483231-6-aleksander.lobakin@intel.com>
 <692d71dc8068b3d27aba39d7141c811755965786.camel@gmail.com>
 <601c0203-ee5f-03a3-e9dd-fdb241f3bcdc@intel.com>
 <CAKgT0Uc0pLzaOfqFbvd9jFErAbTbsUMNNw5e_XY5NfCnO0=g0g@mail.gmail.com>
 <ca096c35-6ce4-6c1d-7e26-a017348f6ece@intel.com>
 <CAKgT0UcZspvhYcfiKs90snAfwwb+CMn-vhA62XcSTRiV0BfOqw@mail.gmail.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAKgT0UcZspvhYcfiKs90snAfwwb+CMn-vhA62XcSTRiV0BfOqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM3PR11MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ee2506d-edc9-445b-223e-08db98211532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBnJNSg/XfgUcNkkuaWHjPCqY3GkXKgpGV10ZO4+2SuwFQrTX4gJnG6U+dRa0bn99+QqbCHfzX0dzXp9Ezk6lq5yZst6ZPy+g9D4USJVGs2p49/WWtvLg2hry+HyDkcG8dxuccd+8WgaKJGmvbx3iYUlsnT97bzb+BMo+7CUhg9KGbwZ+6mzaIA6uEmVRSPH3DBZgQRIUOkoGIQTcUYlxgxAEXkbcnmya6wCqeCtxIapaq463tp645OWpl6NAB+peSmrlLRwx2dNrAyF/FknIppkfAsJuSa5h8ApkypZn05oJLvSmdYxD2a0TA99Kt+WQfUhh9YGJhQLhY1b//SsfFPXZhoInBf/NVslG6XK0PFTTZB0dNAHmz+DqKbx0G4QRNkCippvjdZQaEGGBKdOXdP1QTcG6nLiCjaJPGRzz4DwQqbuXVpc2KrR+fpinxcEEsvOm1OHKNS/ObMBC2joW2QJeByuZTKAGHKYSeXQhr/qf5Mae+0XWxnwPiz6AbZc6Eo1OI74dWuiGzs8RtJFOu9u/rgFMivV1++SvJmbhk8+OYnaoA5ErnSpi/X0tcGQodZUeK03Sad7AJPbQ+l0ZdSYf+OTQoIPfKceKmnobBTwDJPFPyWPc8wNQ3LFoceHco6T6qB+jv1jENJmIIbqOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(186006)(1800799003)(2616005)(6506007)(53546011)(478600001)(38100700002)(31686004)(6486002)(6666004)(26005)(82960400001)(54906003)(66946007)(66556008)(66476007)(4326008)(6916009)(6512007)(83380400001)(5660300002)(8676002)(8936002)(41300700001)(2906002)(316002)(7416002)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T096REI5OG9BaXhjbnBIeWFmTlJjZ042bUNCQ0p0QVF3WjJNQnV0TnkyeVFC?=
 =?utf-8?B?eDB2blNUcENabXpzMHVtdVFaOGd2L01pL1BqcVVvWWFXYWZnZE1zZjdQTVNB?=
 =?utf-8?B?eVhVZVRYSUFkWC9PMzdZRXJwTDdBUzBxRWFoVkQ2QVhWVUNycUhlUTg5NXNN?=
 =?utf-8?B?aG9OSzlvZlJuc1dPODVHK2xpYkpQcFVSNE5xTHoxTkR5aFM2T1NjYkcwRjhD?=
 =?utf-8?B?Vnp4cDRTUG1VS1BLSjBLM0dCdkR3VU5DNE04OC90Y3pWb2lETHhsT296bGtG?=
 =?utf-8?B?MlpGbmp1Tmxyc1lRejE1VU1NREV4YTdGZ3R1NVJ4MkkxdkNIN2E1NnpQMHRX?=
 =?utf-8?B?TEtUUVBuRm56aEN0SHdmM0o0bk5Ia3AyRzJBVHF6WkJiRndqcEt0dXJ3d0dH?=
 =?utf-8?B?NVA2YlF1Nzd2aFoyU1YwZWxpdUI5L3B6cTl5Mlo1eG9rMEtIV3I1VVBlYVVV?=
 =?utf-8?B?ZTZESEI2MEZVOWt6Y1VnVTBPTGxyb200TXZ3ZVlheHZ2aDdVODY3YlptR1BF?=
 =?utf-8?B?azNRTFY3MGNZZThFbi9rc1c3U2RXWWtMYll3LzlJTStjNVhJVGZ1K3VBZWhK?=
 =?utf-8?B?cHIvZWp0NGtyU0dKekFzZm1yVzlhcXVVeWJlM08vKzFWV2Q4dEc4SmRzL3dN?=
 =?utf-8?B?ZlB1eDBHQkhMMEJRWHE1S2xmdW53TVBsaG1GSEp3dWRnbmxTdjdOOTBiaTFW?=
 =?utf-8?B?YTRlY3NFTnVTQXZSMW9IcU40S3NRcUhzSXY0UlkwU2VnWmUrbG1BRnpmNzM5?=
 =?utf-8?B?U0dOWGdqQXFXSVZlblVibXNMZ2k2dFZ4dGlycU95UGw4TElSa29PMlZQK2hh?=
 =?utf-8?B?aFJhQlFDdTRKQ0E0REVRM2RXdGR4d09RWDFveTlpZTdWYVpLNHA4WmJQWXgw?=
 =?utf-8?B?VmJXUzlvVTUwU202OWNaMklIejRxTG5UTmdDOWMrREgvYm9mdVRLdDF1Qm1u?=
 =?utf-8?B?bUZkQXF5VlJhd2I1aUdYRnJyMW01R0JwWkRnWnl6djFxWmgxQ3VVWDVLMVV6?=
 =?utf-8?B?ZEh2WExqSDliNGJCOS8zSmdRNDdaTXlkZGt0OUZnWnJQMkE2clN5RGp3V2dk?=
 =?utf-8?B?S2xJZlYvWndLelE2Vko4VmtONGlzL09YYlNxRWpNOWtwMDlXZzlVZnNaRWVh?=
 =?utf-8?B?d011L1UwZkgzZjRMdzREdFdNdG04WC9iUmwxQ3B3WnVGMFZxNUNzdlQ2d3B6?=
 =?utf-8?B?ejNQaW1USzN0dDFCVHVUQ1pxcStSa0ovWko3bElqV3VKTzRvOU5GaXdOUzBo?=
 =?utf-8?B?ak1NNnkwSHN1eXk5Snd6OUhPQ1U0WXlQOXV0YmxCUVNLbE9qWkljTS9vUnhq?=
 =?utf-8?B?cWhrOEdEbnpINmROM0FUeDBnckIrSTFseFFSRDQrRE0wdjNKbitaZWllcUlJ?=
 =?utf-8?B?NGNiRVYyZDRxUG5kVzJWQzUrM3hpZ3phalhCeHhBOTExeXFuaUNJblAvS2Jn?=
 =?utf-8?B?SW15cCtDRnNFQ0I5aVZDem50dEI5SHVBbHYvMG9ZZVZ6UXdzN09hVkpac1NN?=
 =?utf-8?B?UGh1R3RLcXREbG11cnlrOGl6NDZYSmJ1Q0NoOFJIamE3a1d4WkFYNmQ5NENK?=
 =?utf-8?B?azIyeWUyWUpaVVkyeFBCQ3h5U1d0TkFPSCtTSmRSSHB2bHIreXRWOHVSMlZY?=
 =?utf-8?B?VEZlWFhHby92RUdoNjRNYld2ODFYMWI4WTFpWU5sU09TYmtNcHduWkUwMUo1?=
 =?utf-8?B?ZkJ6aW5KckVBMldnTzZOdXcxRlU1Y0JTUHhKb3JZSnFjMWc0UzBzVTJWNlIz?=
 =?utf-8?B?TWdpUU1ybTFPL0FMaUpOZGFaZWhNV0xFV2pUM2t1WTQ1RHRHSEpjMmpVNnBl?=
 =?utf-8?B?ek9uVWhkK2hKczA1aXVSK1AyQnZicVNiVDU5Z1lUbzZhSHRPN0ZuVjlRSGhv?=
 =?utf-8?B?bHlNR3JITXYxRjF4K3N4VkR5dlphRGZydjlnWlJ3dGl4UzAvL0pwbkwrRktO?=
 =?utf-8?B?disraHNwNk1LK1N3V1VVMUJ0Ti9nRndzb3R6RWJCNTVyUGZkNHd3UUNnVndx?=
 =?utf-8?B?TllhNDRzZTE5Z1hMREk5d1JQenRTTGk0ekE4UGdTaEJrY2orQ1BHamlNUERL?=
 =?utf-8?B?MmZXTFNTLzBhSFhPS0pkTGd6SDNyZnpwZTIxb0JLclYrRDY3R0tSc2VuVzha?=
 =?utf-8?B?WGppQVFaS3BvQjNGdVRsRG9paGNGZGRJY0Z4WkV0ZFdORmh0U0dhTHR0anBO?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee2506d-edc9-445b-223e-08db98211532
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:06:46.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JurDFnRgYKfNHDUbmeDENGiKyJyYxlJCX+/mllOAAI4J2XUd6NrhFcwOLkoonzS3IpXFHQWHUyOlwgY75HgL0Dre5MYuNuKhG5KjhJ8DErc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8734
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 8 Aug 2023 07:52:32 -0700

> On Tue, Aug 8, 2023 at 6:59 AM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Alexander Duyck <alexander.duyck@gmail.com>
>> Date: Tue, 8 Aug 2023 06:45:26 -0700

[...]

>>>>> Secondly rather than returning an error is there any reason why we
>>>>> couldn't just look at not returning page and instead just drop into the
>>>>> release path which wouldn't take the locks in the first place? Either
>>>>
>>>> That is exception path to quickly catch broken drivers and fix them, why
>>>> bother? It's not something we have to live with.
>>>
>>> My concern is that the current "fix" consists of stalling a Tx ring.
>>> We need to have a way to allow forward progress when somebody mixes
>>> xdp_frame and skb traffic as I suspect we will end up with a number of
>>> devices doing this since they cannot handle recycling the pages in
>>> hardirq context.
>>
>> You could've seen that several vendors already disabled recycling XDP
>> buffers when in hardirq (= netpoll) in their drivers. hardirq is in
>> general not for networking-related operations.
> 
> The whole idea behind the netpoll cleanup is to get the Tx buffers out
> of the way so that we can transmit even after the system has crashed.
> The idea isn't to transmit XDP buffers, but to get the buffers out of
> the way in the cases where somebody is combining both xdp_frame and
> sk_buff on the same queue due to a limited number of rings being
> present on the device.

I see now, thanks a lot!

> 
> My concern is that at some point in the near future somebody is going
> to have a system crash and instead of being able to get the crash log
> message out via their netconsole it is going to get cut off because
> the driver stopped cleaning the Tx ring because somebody was also
> using it as an XDP redirect destination.
> 
>>>
>>> The only reason why the skbs don't have the problem is that they are
>>> queued and then cleaned up in the net_tx_action. That is why I wonder
>>> if we shouldn't look at adding some sort of support for doing
>>> something like that with xdp_frame as well. Something like a
>>> dev_kfree_pp_page_any to go along with the dev_kfree_skb_any.
>>
>> I still don't get why we may need to clean XDP buffers in hardirq, maybe
>> someone could give me some links to read why we may need this and how
>> that happens? netpoll is a very specific thing for some debug
>> operations, isn't it? XDP shouldn't in general be enabled when this
>> happens, should it?
> 
> I think I kind of explained it above. It isn't so much about cleaning
> the XDP buffers as getting them off of the ring and out of the way. If
> we block a Tx queue because of an XDP buffer then we cannot use that
> Tx queue. I would be good with us just deferring the cleanup like we
> do with an sk_buff in dev_kfree_skb_irq, the only issue is we don't
> have the ability to put them on a queue since they don't have
> prev/next pointers.
> 
> I suppose an alternative to cleaning them might be to make a mandatory
> requirement that you cannot support netpoll and mix xdp_frame and
> sk_buff on the same queue. If we enforced that then my concern about
> them blocking a queue would be addressed.

I'm leaning more towards this one TBH. I don't feel sole netpoll as
a solid argument for introducing XDP frame deferred queues :s

> 
>> (unrelated: 6:58 AM West Coast, you use to wake up early or traveling?
>>  :D)
> 
> I am usually up pretty early, especially this time of year. Sunrise
> here is 6AM and I am usually up a little before that.. :)

Nice!

Thanks,
Olek
