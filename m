Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81453753D19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjGNOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbjGNOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:20:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD5E35AD;
        Fri, 14 Jul 2023 07:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689344416; x=1720880416;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cdH4AZO9pwkwCsGdDCVew+ZLVkxPPOoCv5VeR+wTRJk=;
  b=CTEEtQifoqSrPp+/XH5Eho/+MOTLa7h8BfLTFJViDVusSMAOlXq+2vDj
   Wd7gk8UCMBWRxc7SYBPj+ZOuRHFMMA74XhgoNJ9gUL3MEulsM5xhfh0ar
   QgVDWiq93wp5e/wE6rMXansZJL3Fq9LYfunYPbRhaB5z2c2Oh0gFgKp3P
   ljgthEtG+JSLLdC0fBtfF8/qYUo2qbI5rmr83Uq+QF2frVd2gVnlHy2or
   DBtdSWaW0Y7iVmfZFTlhIR/CawvBQXXvbKarJJtQWuOHBFFNaSXPV62ik
   J/dUZRXORAHEHu+YPzzG56ez17cAHiKCZBqirD4EO1S6X5sgCI4Pn9ATA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="368123379"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="368123379"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 07:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="752051441"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="752051441"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2023 07:18:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 07:18:12 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 07:18:12 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 07:18:12 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 07:18:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4jwberLljhQg3+HEMBp3QoqpC8+7KeAsR6RQy2dbWA4bMaxtuqAwnDr/u6oCXnale+fK8SzMWGqTt5vTEpIi1OyOl23F0b0O9EFWbh3A8II+S+jvmDDNKGppFCbZwSKCS7/Yurq2g0JAxuojPa35gbfDLaRFA4PNwdOVHnzmf7BR2+OqC3L6A65PeXspRnhXPkPcuOK+zZ2qIWqaiI9hpi2Q8Lz9Vp51zHoQzQoPL4mucPp023aJ98a+1+bNW4gJY6b2uahIFcggoNK1I4Mv/RbgdORw++Qi7OAYhGk10ubvSjON7tqLi7s9sp/00TtjXsY93uezikhiX/wuWudcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPZQjLL+i1Ss1kZGmwn4szSjzqDewaGJvTm4x40gnG8=;
 b=NWv09rqvx6Vb1MZW0fuuNDGb2X/0rAX7WAWuAzOWPfMvau6gdXiAFri5GhUXuYX3grEdXT4NUAJoDur1nSJnVBST7ZhR3NR/GGd+x0LE9fe6y9rU7qYyRm6Yi8jMvbVaPybA3E5c1M870RzEHWkFpm3+VU3NPdm1kkOu7HBU2VpRlmyTDOq1BPxDOKyGPJu4jqc/YFzGqeMejCMVMTRu+VdM8+Ct9PqUHK1Log66Ed4uramJwfsxcZD/tOhWiyY5xrDyZIsnD4tTAZTO9eL/PKY/CykZxI9AnWhbnJQ4Fo9qAYBzO82O17prEHJI7c6eqszQI9kT2mdIH9DYrXF9OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DS0PR11MB8082.namprd11.prod.outlook.com (2603:10b6:8:157::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 14:18:10 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::6cba:7ffb:4681:a38b]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::6cba:7ffb:4681:a38b%2]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 14:18:10 +0000
Message-ID: <dbf9fa57-2ed1-3e50-32be-aa5512dafc6f@intel.com>
Date:   Fri, 14 Jul 2023 16:17:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH RFC net-next v4 2/9] iavf: kill
 "legacy-rx" for good
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        <netdev@vger.kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        "David Christensen" <drc@linux.vnet.ibm.com>
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-3-aleksander.lobakin@intel.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230705155551.1317583-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DS0PR11MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5cea9b-294b-4811-faf9-08db8475269d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4H+Ocd4/PRW9361ICClaZPqbdL5ia87MKFnBL2RDIekkqzHpTx/BNzBvwfNXk9SOP2GtdgjKmMdVPLw2XZh/xmFr+j3YDaXTdWKppnFI7FLZrrQ/A72Yqn/rGs+Z5I3QejQly+FhegHH6VbNAEselvL0wIJtvuifrsa32gRLZoAUiPjwDicL1D8y/NKqFq79jnvuO6TP1gb7LjK7AvRQtB+1HRejbln4YjdUK2JYs6mAe7uTU5jeDNGYLFXWB+PHrCJKDKz0tizwI9BZRsDTNlUM4r40dvhqjDBiLGgkA/IgwhHKpRhQ2PSCR768u/MXFxJer5hxMmeCuswvyIGpXn6xAn2B1wfAGlLyRTBT5+Dvp1//pIv4WAb2x2uQIxguMkzzPjDbTL3i+bH41ajp4GczA5DRv9tPZlQ1vTG94q67U3QscFUFrcrINzvIR+8CVhCR0oi027qPgzgKVq12Fx0gJ66mUWkwON5Uqg32KXJCHn9XNYB2z8Lr9vwIqUYYVG0EDG+hVV9TRF6TKJssDnT5hz6LS5x9Gac2OAPyw+cnN4T08kMsNeLnujqcuPpvEUojqOc4+ECo9JziyhYFjADGX7equ/KZZkguFzG8663ASanDiMzZnl2a8TT/kXNXPRcdF+TL22/YwqFoHdmAzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(316002)(41300700001)(5660300002)(82960400001)(38100700002)(8676002)(8936002)(7416002)(86362001)(31696002)(36756003)(2906002)(6486002)(6666004)(6512007)(478600001)(2616005)(83380400001)(186003)(26005)(6506007)(53546011)(31686004)(4326008)(66556008)(66476007)(66946007)(110136005)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWNDUS91anVObWt6SFA0bWx5K1BQZ1FpNWhNYzBxSXhhMDhnQkV5cG1hbnpI?=
 =?utf-8?B?NTMzYldld1p0MXBveWZRZGxkU01ZSURLSXRRdVZ0ZVFrKzJDdjhKTE5IUVdO?=
 =?utf-8?B?T0xCZXhZL0VOSGJzcVhsV3lPSWY1RG5OMTM0S3pKV1pCNSs3U2ZPU2RxSi9L?=
 =?utf-8?B?eGROZ0lZaU9xTFhPemxCbHNrMTRpZlN0bFV0ZnBDcFFPWWt4R1YyOUU1MytH?=
 =?utf-8?B?WlB5V2J5aWh5ZFl2UlVRNzRiYTNuR0o1bnZCQ0J0U0Uzc3VFOC9OSEtqVzRC?=
 =?utf-8?B?UDZzYlFIeHRvcUhNcVFoZS92STl3V01ydVg1c0dkSmMvd0oxQjAwS2IzV3Bp?=
 =?utf-8?B?SDVKVW9DbEk1UEQvQy9MWVo2cDU1SWtXeU9WTTArc25JMFF4Qm9oSmVPK1BH?=
 =?utf-8?B?a0FRQ0l3NHMzb0FEaGNKcHFsNzNUak12VmxCaHkzUktZSWlKV1gwSjVET2J2?=
 =?utf-8?B?b2pUdHZ6VVRTTmJWYURQYmFnVkROei8vYzdlaEo3NC9idWIybEs1d1NabVJm?=
 =?utf-8?B?VmlmeUdGZG52bk8vYm84QTFRTk5iRStPQjl2Tm5BdVh2KzNCZGpHTzZ3OHFV?=
 =?utf-8?B?Q1JZU0ozWGM3bjNDaHkySFM4WDBiYzlSYys4S1ZoQWUwWXUvazlsbmFYaVov?=
 =?utf-8?B?Z3ZrZWxJdTZhdTJ1S2pyLzROUkdJVDcyaGZqdXc0dzZiRHNqVjRidTVHVi9J?=
 =?utf-8?B?b0xPUUJRS2s0TkMzV29PL3RQOHl3bVViS2VHTWxMWlBUajFwRUJXMll3SEN6?=
 =?utf-8?B?NTdHazltTkMyUnJMd3JhSE1LMm1PTHhld092MEpPYTZhT3VIT0RKQXFXbUpm?=
 =?utf-8?B?MXZXcy95QTVTbkN3VHBGRzRMTVIybHpSbmVFdk44MmRWQXJ0c2xWMHNXb1VY?=
 =?utf-8?B?Z0Vtb29tOFBjQXh3T1Rxa3d4U2QwVG4wdEYvTkhGM3QyYkNKRzZnclp3SEls?=
 =?utf-8?B?ZVhEY0pUYWJkN3BUL0NQUU85eFZvOHNMVUFScnpNU2Z4OW5PQnFlTDRpbzBl?=
 =?utf-8?B?TStzVHd3Y1lieGZsWnQrNnpwREVlMWVwUkFubDIrSzMwQmRvZC9hZVd6MnRR?=
 =?utf-8?B?a0ZSejk5TGY2SmYwLzlZRmVCUVZka0JJeGFDRWw2b0NTWjAySi9uQUJvcmxW?=
 =?utf-8?B?NGV2TEdHd1Y3L0p4KzZGam54WEVlTDlYdi9BbTlYYTF0Q2thdTlXVmxSTDda?=
 =?utf-8?B?aWRwQStLMjlKcWd2Vlhlemk3Z2I1d2ZUTVlDaTFpcHFWTDliUjBWZ1FZK0pP?=
 =?utf-8?B?M1h1NGwzY3A3UVNJVXJRVmEzeGFHUFNzOUdNeHRxRFZGWHlDdVZ0SWl1VnFU?=
 =?utf-8?B?M0hUQnJNbG5Xdmd0RVRtd0RYR0FBeWwwT3QwZEJad0lpRTVKOEk2eEErRTR5?=
 =?utf-8?B?UmM4dUxNNGtlRHJMcGR5a05IcHZxdmxWeldnSzdVSFFhUHRqTk5rNTlGZHFS?=
 =?utf-8?B?T3hGbUlyREg4QkxRa2Z6SnBUS0tqMXhtRmhPWDVxMS94QWtscHJ2aFlVQ2ph?=
 =?utf-8?B?S2lPZnpJeXJORmlZV1ZaQ2NLeDU3WEZWRGJLZXJZRmNjRGVNdTd6U3N3K2gx?=
 =?utf-8?B?cTlsZXdjUjFzaFZZcjR0Q25tRTAzUG4vSWt5VXB5MGFyRDhhNmxmaTlPODFW?=
 =?utf-8?B?RzdDQWorUWRYNzJpR01mVnF2enVhbE9mRVcxbDVIWkpCa1VwT3BFWll1QXI0?=
 =?utf-8?B?dGdKTTRvYnZOQlFnY2VGa0V1L29Ja1BIdUtrWVc2NUhkbk9xMmN4Z1pWK3Jv?=
 =?utf-8?B?eGYrZk1lUm11ZHNmc0lNZXNETjlEbVJhSExSN2xxWFgvZy9QZ212cnNYK0N3?=
 =?utf-8?B?RWIzbDE2YWJQQkE5dEFUSkxWSTc2UGl1dDBMVSt3MC9GTXlwbGltOHJ1anF0?=
 =?utf-8?B?QUo3MUtHa0ZkY3JYTy9qL2JlaENtbVNnSjBYeUJsRVlxT2UxODlDTnIwZHho?=
 =?utf-8?B?M25BNm1BdHE5dFh0ZUdVOUI5MXVja2l6dXFnWi9tTXBzbXdKRC8vR1J4eUlu?=
 =?utf-8?B?QzdHUG1TdU0wL3A1U1R3cEYxQ0J6WGpWYUJqbEhpenFLQnFJTWIwMVNYbCtl?=
 =?utf-8?B?RGQ4ZktxVDROZmxaT0UwWkVPaUVQblhxeEg5U05USG1lZEVieGJUYnIrc2V6?=
 =?utf-8?B?aUFSNEF3Q3lXVUFiMFQzMHpvWGhSQVEzYk1NUXAzdDdaay9IaXYvMGhiVzdj?=
 =?utf-8?Q?rRVhZ73502jgVm6sXkZbgOc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5cea9b-294b-4811-faf9-08db8475269d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 14:18:09.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvGeoEb/yMS+gPq1UHfu5sx26OM8kX7jsqECieQvywLf79ZIGNfFzMb/5N7W14ZNltTS3zI69mKcZ0yMV1vJeVdRC28rt6z3N6atUc6jw2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8082
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 17:55, Alexander Lobakin wrote:
> Ever since build_skb() became stable, the old way with allocating an skb
> for storing the headers separately, which will be then copied manually,
> was slower, less flexible and thus obsolete.
> 
> * it had higher pressure on MM since it actually allocates new pages,
>    which then get split and refcount-biased (NAPI page cache);
> * it implies memcpy() of packet headers (40+ bytes per each frame);
> * the actual header length was calculated via eth_get_headlen(), which
>    invokes Flow Dissector and thus wastes a bunch of CPU cycles;
> * XDP makes it even more weird since it requires headroom for long and
>    also tailroom for some time (since mbuf landed). Take a look at the
>    ice driver, which is built around work-arounds to make XDP work with
>    it.
> 
> Even on some quite low-end hardware (not a common case for 100G NICs) it
> was performing worse.
> The only advantage "legacy-rx" had is that it didn't require any
> reserved headroom and tailroom. But iavf didn't use this, as it always
> splits pages into two halves of 2k, while that save would only be useful
> when striding. And again, XDP effectively removes that sole pro.
> 
> There's a train of features to land in IAVF soon: Page Pool, XDP, XSk,
> multi-buffer etc. Each new would require adding more and more Danse
> Macabre for absolutely no reason, besides making hotpath less and less
> effective.
> Remove the "feature" with all the related code. This includes at least
> one very hot branch (typically hit on each new frame), which was either
> always-true or always-false at least for a complete NAPI bulk of 64
> frames, the whole private flags cruft, and so on. Some stats:
> 
> Function: add/remove: 0/4 grow/shrink: 0/7 up/down: 0/-757 (-757)
> RO Data: add/remove: 0/1 grow/shrink: 0/0 up/down: 0/-40 (-40)
> 
> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf.h        |   2 +-
>   .../net/ethernet/intel/iavf/iavf_ethtool.c    | 140 ------------------
>   drivers/net/ethernet/intel/iavf/iavf_main.c   |  10 +-
>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   |  84 +----------
>   drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  27 +---
>   .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   3 +-
>   6 files changed, 8 insertions(+), 258 deletions(-)

Good one, there were some random questions in my mind during the read,
but all are resolved by subsequent patches.
(It's a pity I have not found yet time to fully read them though)

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

