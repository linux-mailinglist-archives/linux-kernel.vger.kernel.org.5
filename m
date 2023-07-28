Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AFD766F53
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjG1OVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjG1OVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:21:30 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C0421F;
        Fri, 28 Jul 2023 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690554067; x=1722090067;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y5/qjmmbkrD4EKSI3kgJBvGLZGoA4227SKm6EUnoi2M=;
  b=gU0po5QVTXSgtOslableaUXLSiw3Zjn4c6ZD+BrbjlTg/othh2Ykrm3V
   r1UqfeSxuwq52S6fTp8BJCKrch8HoD2LODEtKq+4n5Y5CZvMxXnLBN7uK
   RljW96vzcDBTcBaZgXA7vpQjFD0yN3iF3Qa43dmiDP9Go+YJuSQvDmJYA
   mfkkz2n6FRZq8n2QXNuW7IiiYW7JVbkU4HG9Miw5aGQVHy9wxbRdhYyAe
   hzx2qMSUB2jL34/1F5e5OtrW707OwbySGeXMEkvsz1HBCrdAN00UxyW2H
   K6OCpyNfMk5RHQtVtqu+rMIUq0n2CUrKXD5+panJKou4DwGgE+EVximJq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="371301861"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="371301861"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 07:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="901289699"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="901289699"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 28 Jul 2023 07:16:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 07:16:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 07:16:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 07:15:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGWRqu1vArmB7GbE4q98+C4gUdJ5+g33WtGqldDz41qsf+4ftbw0nHpSCbGUVohSydp2vvpI+RBXqWGEie96aHkeGY4d/SQOZBNHDCEuRSiwf0vU+n7mnaE0kdsmN1kwWDmgJsvX0XZVCuyQOqQRKsRTT7MmFNRJEJL/AX4/qcHYBMFyQIq2IHKy1OY/hVjkibSwQ4ukjonATZYBM9sx7BzxK1CzznD6wQMVc9zveA1WNVleFl7lO88S87ERGpveKCdAzfbueH+7g4yVQNR2blK8rbQPBlI81iBl7bCJwI7x0qQf8DActJNKgjOJwxSznpUhIESrpkN+sPeilKnMbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrPAJjvxepr1iD1U8Ez+8Rtf+GoC5+rY244lBmbyf5M=;
 b=oCULxIYGmQ2yUw8Z6yyAOxVpj0w519YpWaLSoZi8jzeZwYyvS2pjDF4eqn8oRcY5AljhhaN2BaLlSZiwWUsxpvnqiuOLr3ewFHF1Um4hSh05+EP8FvnRV570VhsvLi/vF6PfXepysH8kLjoyF6vU2xc0+nSenAvYidJaDxp9VKeAHLrLxykb9V8mkvZj5SOvdF4QCYHF9XLI646iIX7PeM1otmCBwUToJDlvycWvwpdY1EaZgo1mDA4G8I2pfwPHputTLoK+6f5l1BzNHcQ2qWtCsdiugW8gHEhAyCg+TinyDZ/iH+QEtjkO5LcoR2XqSaBCpvlRl2Slfqann+bq5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH8PR11MB8039.namprd11.prod.outlook.com (2603:10b6:510:25f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 14:15:55 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 14:15:55 +0000
Message-ID: <604d4f6c-a6e7-e921-2d9a-45fe46ab9e79@intel.com>
Date:   Fri, 28 Jul 2023 16:14:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next 6/9] page_pool: avoid calling no-op externals
 when possible
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230727144336.1646454-1-aleksander.lobakin@intel.com>
 <20230727144336.1646454-7-aleksander.lobakin@intel.com>
 <a79cc7ed-5355-ef7d-8865-0ba9673af5c6@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <a79cc7ed-5355-ef7d-8865-0ba9673af5c6@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0013.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::23)
 To DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH8PR11MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: 33394bef-d678-4c65-9ea3-08db8f7527f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSfRgh/xqQ/nm802jyLAAJbl+PNL7DmsMjPehrAVuu8cTjR9Fwj4GQIyC3KVGGhXHpJRCZ7LNf9Mkw9Pu2x8hMuG14m5SDF2p+N8sw9ETCXJZUk9+Y02zGEk4nVK5VBCpQa+cWmC8zfaAnVs5gtCXvw9xUxCb7I0mwOqWYGvhhyBRU80EG7bkGhA1StJHAt1gbKaxEMwDpjQoAetpeH/Lex2S2XMSGXNRNLy+lXvH422++zLEY1DeI2fHfsjPPefb5dSoJ0qwbuHEtbwQH5ASqLSJ6ZEncBH0a/OKXWm5RauP68hGXZBfeFvqG83GbJEXJpA/GgPuNnDhGLdTm+3jq9/Tqg5uMV3+rkRSFJwR48gK+zhmqVpO+E7ViilAcAmzigM3MxzBTDYay/2nx+A8Mu6s/PmRde6It0PVwNBQS9Mx60oyWD7fcv76HzVzrTGt5yX9a9X9lL4hLtZm0tcGGEesxqm2oX8s0DA0y7XY/X225uHRE93CLsneFEfaJMkzIe6FK/RaUJ8kulz9CUaGj4UET7lT+KYt+eLtnSu+HxtKJVDbD7YYnn+j7vnhDAX1ZRbGP0PaV85+aEAgmP1sOodthnizbhqgiFZHoxan8Egwj0shQocawtc5V7923SzIOEfDySjRvuRyTV7y8rIow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199021)(2906002)(316002)(8936002)(8676002)(7416002)(5660300002)(86362001)(41300700001)(36756003)(31696002)(53546011)(6512007)(6506007)(26005)(82960400001)(478600001)(6486002)(6666004)(186003)(31686004)(2616005)(4326008)(38100700002)(6916009)(66476007)(66946007)(66556008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlM2Tkh2d0MzN2k1N1B6alFNR2FSb0RBTStaemR0TzRUMmIxblhSSjNaa3lW?=
 =?utf-8?B?LzRBM3RRY0hJcGkyZ3FSZ2QyR0F0dFFSaURNVDlUd3FXYTJsdnM2OHErbkdF?=
 =?utf-8?B?Z3hvUlM3elFOMTNxZFJ0eVpRcldGU0pwYWZ3M2wrWE5TVG15c2YwdU5NaVFB?=
 =?utf-8?B?WTZ2UnZVM3FvelhlZENOSFZqT1h3cTdlMEJUR3ExTngySG16WUVuMHZEZ1BL?=
 =?utf-8?B?bVVabTYzQmNtVVJsR2Y0M2V5V01LSUZhSENTdFU3ZnVyL2pkMDVuZHNSem1w?=
 =?utf-8?B?Q1JmVmpiVDc3WFdnalF2a1ZVaUFTRXZkVEhBcmJDUEpNekZ2T1ZXVmpTYVFj?=
 =?utf-8?B?dytCaDJQSS9abnpWejQ0VFNBSVQwampoRjA5Sm01ZFFrb0MyblRRR2hBakpn?=
 =?utf-8?B?RXhobHg2U2xyRFN4aG1uamNTSWZWYzhiZEpQWEdKSllLS2hINDVHR3V5andj?=
 =?utf-8?B?OFJwWXkzdis3ai9qQmkvTXZXQnRTa3pRc1hkOTdyKzFOamEycVkxL1orUWll?=
 =?utf-8?B?SCszSTc4UmFUR3hwZjdrOXNvSmV3b01mcjBDbWVRZmZMS2ZvVHBxTzl2NlFS?=
 =?utf-8?B?d1FsTjVMZzlqTFI5QVp5VGovMGhNeU45OGxUTTB1by9LdnNieXJMOU5nRWF0?=
 =?utf-8?B?cFl3OE5LdTdRTFcvbFllNGN3T2JuYVljdEcyVnZOOTk1V1RDYmcrNkQ5TUN4?=
 =?utf-8?B?NFZuS2tLY3E3TWtDemtaS2RVN2RXVk83cm5vVGlLT25TM1ZpYnFRNHQ4cTVm?=
 =?utf-8?B?a3A5QW1IZUd4SVJxdEU0bGFCSWxYcXRGL3V6dXdKUkZFRERVTUpEL3piZUF3?=
 =?utf-8?B?VkhWYWJyZjU0L2V4eEoweFJUSmdvbStBQzh6RWZmY2ptMkRhZ3lETjdZS0ZR?=
 =?utf-8?B?dmNaWWVTWldKNVJXeU5wN2p2MVMzTmlOTG1WQXI1T0lDUjF0d0hOSWV4dVV6?=
 =?utf-8?B?U2RpWHpQR2xwUEhIc1pRQzl4dG9GK3p1VTZWSEFvTkZLUFVodms0SGIzd2JK?=
 =?utf-8?B?OTR1T09IZW9sM3dyZzJzM3pqaGdSMlNLSGtuQlkrZVllSDVQNDlodDdmNWFj?=
 =?utf-8?B?NGlNeFVCRXN1dFZCeDhsem01UU84VUVkcGtKeHpMZGRjWGhvTUVHSHdXVExM?=
 =?utf-8?B?NWF4Q0oxYkcrWVhRQWZtTUtFMHhzUjJWL0xEbmZWU0FrL2JRWWYrWmpORWNM?=
 =?utf-8?B?TWdzaU9TdFdYUysxRnJFSzU1L3E3VGhYOUJsYytGM2hVMDc5NG1Ud01saFBP?=
 =?utf-8?B?b3JSNFcrT1dYcVA2cTBJT3loNXRsMFRBOGdCZmg3Zk1pbXdYTkJPQUYyRGVK?=
 =?utf-8?B?U3JyRXBDckVld0NYSjZaTFVrUWIvYTlSczlVeGVGTk10UEd2WXZjVUZVemhC?=
 =?utf-8?B?UkdDaGk2YTVmaEtMZEF2VityOE5kdHVXZlVaZDMzamhpZDk5RFZ0YUlYRW84?=
 =?utf-8?B?UkI2YUVDelkxb2ZreW96anJtcStvZ0dmWXNDb2ZEZnBidTBFM1ZWcGdmQTNF?=
 =?utf-8?B?bFhlSElYNFBjSjlvVVU1bmgvUVZIWjBNWUpYTmpXSGZOdG9nYXN3RHJMVWRs?=
 =?utf-8?B?dVRRdXY1VGE1MlZNem5aU3FmQmRtUVVVMmNDajRLcXI1SWkxci9yY29JWVY0?=
 =?utf-8?B?SWxJekdXeUJGeUliUTNRbDcvc2RXcEJLeXdIblVzM2Uwek5KaVlIWDl3RVJu?=
 =?utf-8?B?ZytXcCtMUTdXR2pvQnFQeFBBV05zaVV2c1VkL2RONldXREk5ZG5sRzNZdHhF?=
 =?utf-8?B?a1M4eEtlRWVIejB1SUZYRWVhNVNyUTJPZ0o4TWh3UkY2dWVHZHhaZmoyVUZT?=
 =?utf-8?B?aWMyNkpKdk9KT0tzUG1qTWxiMzVySjUyNzg5Wk5nWHpEc242bWEyOEFZRHV4?=
 =?utf-8?B?ZmxZalkxaHJEVzgxamZPZGVSNjdKelFuLy82Z2dMZlBiVE1IUUoyZ1FObG5W?=
 =?utf-8?B?QWYzUGNCeG5NemdhTmJMeGJKT3RMUExTcE40Wlkra1BRMWVhV2x2Ky9xVVlu?=
 =?utf-8?B?R1gycWJiVXo4MmY5MUFFNExDdDVtMFc0ZGtLMkdDTXA1OU1tcmJiNzJFZnRO?=
 =?utf-8?B?b2Qyelg2bGZ0aEZ1YXpMWk1qRDNDdkk5S0tnRG9ZTG0xK3VNVHpnbitIdDRo?=
 =?utf-8?B?L0IzRmhVWjVSVE1seU81Nk1qRDZ3MDVMZS9UckRuMGdQQmpZdzA5dWZoeTJW?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33394bef-d678-4c65-9ea3-08db8f7527f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 14:15:55.0157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmLrGtjbOM1IH8bpRFvWdmtTeEk6MKrlRNNfU18BUtLq+YQZe19BA1NMUCh2O+isWgTyn4prevfGUPfPb/26VNy7atbYI+PyR3pxT5KoTJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8039
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

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Fri, 28 Jul 2023 20:39:24 +0800

> On 2023/7/27 22:43, Alexander Lobakin wrote:
>> Turned out page_pool_put{,_full}_page() can burn quite a bunch of cycles
>> even when on DMA-coherent platforms (like x86) with no active IOMMU or
>> swiotlb, just for the call ladder.
>> Indeed, it's
>>
>> page_pool_put_page()
>>   page_pool_put_defragged_page()                  <- external
>>     __page_pool_put_page()
>>       page_pool_dma_sync_for_device()             <- non-inline
>>         dma_sync_single_range_for_device()
>>           dma_sync_single_for_device()            <- external
>>             dma_direct_sync_single_for_device()
>>               dev_is_dma_coherent()               <- exit
>>
>> For the inline functions, no guarantees the compiler won't uninline them
>> (they're clearly not one-liners and sometimes compilers uninline even
>> 2 + 2). The first external call is necessary, but the rest 2+ are done
>> for nothing each time, plus a bunch of checks here and there.
>> Since Page Pool mappings are long-term and for one "device + addr" pair
>> dma_need_sync() will always return the same value (basically, whether it
>> belongs to an swiotlb pool), addresses can be tested once right after
>> they're obtained and the result can be reused until the page is unmapped.
>> Define the new PP DMA sync operation type, which will mean "do DMA syncs
>> for the device, but only when needed" and turn it on by default when the
>> driver asks to sync pages. When a page is mapped, check whether it needs
>> syncs and if so, replace that "sync when needed" back to "always do
>> syncs" globally for the whole pool (better safe than sorry). As long as
>> the pool has no pages requiring DMA syncs, this cuts off a good piece
>> of calls and checks. When at least one page required it, the pool
>> conservatively falls back to "always call sync functions", no per-page
>> verdicts. It's a fairly rare case anyway that only a few pages would
>> require syncing.
>> On my x86_64, this gives from 2% to 5% performance benefit with no
>> negative impact for cases when IOMMU is on and the shortcut can't be
>> used.
>>
> 
> It seems other subsystem may have the similar problem as page_pool,
> is it possible to implement this kind of trick in the dma subsystem
> instead of every subsystem inventing their own trick?

In the ladder I described above most of overhead comes from jumping
between Page Pool functions, not the generic DMA ones. Let's say I do
this shortcut in dma_sync_single_range_for_device(), that is too late
already to count on some good CPU saves.
Plus, DMA sync API operates with dma_addr_t, not struct page. IOW it's
not clear to me where to store this "we can shortcut" bit in that case.

From "other subsystem" I remember only XDP sockets. There, they also
avoid calling their own non-inline functions in the first place, not the
generic DMA ones. So I'd say both cases (PP and XSk) can't be solved via
some "generic" solution.

Thanks,
Olek
