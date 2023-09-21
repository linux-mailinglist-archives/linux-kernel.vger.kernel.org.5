Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB997AA21D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjIUVM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIUVMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:12:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DA5A0C2B;
        Thu, 21 Sep 2023 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695319056; x=1726855056;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+pwHUZ/2swYVy2VSDvF9eI7bZY/Pr2mIwCivK34bjD0=;
  b=e+RMHdL/iTwtXU+VahcqhLks/o3X7BCNdrchx46BCJkt6K5iQVHrXXPu
   Eyeq38yzDuOK/fNq3WeYM1FhzKjtQgVu8jqdWv9Qwf+33669UCXlCNuAo
   ZmmmHc+035WdKYjyA8XfPFL/AvmSg/rG+RWicMcQXrUhW69eZhdcY381E
   HBKy4NIzm2dUeJsIvjX5vEhsWaxBLU/nuAeo4x9nUeCaxpPZmYc2eF3GH
   MywA03M4VgxL2XI8/y1yBapeomsONCRnNPU/Gb1vHkidPTVbPz0Cphha/
   0zGi7lFnZn7H01lcQXnBlZoBH5DwSg9xmnbk6rupLxlXLHanVeaVYMtQH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="383284305"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="383284305"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 07:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="1077903851"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="1077903851"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 07:15:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 07:15:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 07:15:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 07:15:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaFMBb6ge/DQ3To+BZrKCDRwSD25sg9CuWej7x7OfvVDQm7g8976FlyZlmoPR9w/I7xtgTTxC2AdEV/+jBuCeTeM4TEug0KYbrQTqspCN7t8Ysqj6xjlmEjmApeSVqx1YTvvzLqgCUynooDsRDgacH05cICsxs8rtNsRjP94HykbELg9Synv3l3t5UbByZurNGnrqwpiQJTJjDUMw5HQBCnawdKwAEIjAdZs7HAB9aODnl6niXjar+LXa2JGhQb5H7gV2xArwLTiD9+Kq+k/nAsUyxo8RVZrTUCRGu1AtgT5xCfqNMkYxmCdYZxngYx66gujQcBsPjhvE0IF4tGm4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUEQRtq692kemEgPUm+d+dXMnJHtjEjJZpe0o9CyDkk=;
 b=JWKePhJa0uI0++UEI+C9808BLS0yjTBjZdSx2uMdemRQ0kFD2I6+TZYNBsC1PUx5k7SGdi7uQjvXvUAVkj3dZaNEjHy3fgW+Hcj7LmKTuFNnzPshbTwW62h0wPx0gzrVMvaVGN+4S3OGU1cZnHIwTm3vMl6XowafzCbEjCvENARW3OfhTfr/2dWmDGqV/IVGBTmlXNxKXMEFp8SuPf+UiFvrPlBimfC0agg0ep5UyQ31DIbzqvkLZOjVTRoe8QW2cS84jRv5Ddx2ciIt1u1O1E1HdTcqdczPBmGLJhjLDy7ookvHR1Qs/G0W3vxJxIIho143DGdswRknCEPc25op/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BN9PR11MB5274.namprd11.prod.outlook.com (2603:10b6:408:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 14:15:25 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 21 Sep 2023
 14:15:25 +0000
Message-ID: <d7462ae5-c971-452f-49d7-855f60c850d3@intel.com>
Date:   Thu, 21 Sep 2023 16:14:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] sky2: Make sure there is at least one frag_addr available
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
CC:     Mirko Lindner <mlindner@marvell.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20230920202509.never.299-kees@kernel.org>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230920202509.never.299-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BN9PR11MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: 1715514c-4f8e-4db0-1ceb-08dbbaad3291
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4U0eBLt4Iy8TsDLrNGZ72EDB127ST1QRi3ZDaL7j0UFlwuIqFXU1Y31+thRujaWcfoHmSAYavCBLXGCemduusaQX5lXVnvY78DmQxLooFbeSgCMEXTvDJ85GO/XL/1b74Eue2hIK/ksMVYtUQVlUW5kQpvykVdyYpvWsfdec3MKMe/448Wqb8C6pS7JwtqCqqRMCIr2xDi7II7ChVFgmtCaDG9vNgjedDqV+Y4ig+m5wZtGB7zKFydsgxH+7XwPSjajIuIYLmLIWc75Tt6GUCYOgN2oHZcGsfBj5ODjV0HJHZlqV1IUzttQI45RkYHaHXU2PP/GgXafPHzM7RfVXs75bIdM8WJh+npJta9wcmpn6B5Utz894Fdo+jkP16S0Ee1OtJeqsYq3yMPM/8gRleQ8PUoD6gFv7+Dcdg6N404emaR0ZDL38A5hvoXVqOppHjSrIgU6GgwKF0tfWO3diZEeUDuHFb/a5g3N7q1Ago6+kWmQOMICgyWM0VOhF6oMNIzOMSBYGfQtiAzttf2RZzjTMlpSmQKpDg/0n89AYhUw9LTEFdkdOKtXkE7ptBd3OQzHdIgqD/klAlfuW6qMCI9eVAW5jQNVEi4CUYxvo+BMmmWjv68pm3SyJCjxKINa/52yaHv+h1j+t7+6YU/DYWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(31686004)(6666004)(6512007)(6506007)(6486002)(38100700002)(82960400001)(36756003)(86362001)(31696002)(7416002)(2906002)(6916009)(966005)(83380400001)(26005)(478600001)(2616005)(5660300002)(41300700001)(8936002)(316002)(66476007)(4326008)(66556008)(54906003)(66946007)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3JEalBtbGF5dVpzektPMEJDdkxjdEkveVBtb0xqLzNvc1NuK3BzZUFzd2tW?=
 =?utf-8?B?VkgyZWgxemxMQ1JuYWVrNENJWkowRHE5eDZWdG5KaXM1UXJLdXJxMzBDTUtq?=
 =?utf-8?B?Sk8rQzNRbjZvUnFxeVNKUGc4R0hCNlRXaW9VUDNNcWtvOHh2RUlQZ0RHR1Fa?=
 =?utf-8?B?RG5nYmJYcmovL3cyMjg5ZXRVcnQzN0UrS1BqV2pIOGVTUmV5QmtHa0Vyb1hM?=
 =?utf-8?B?MTMyT2JWc1MxbU9hcHRENWdRc3dETG9yQTF5cUI1aWErZEt1Vis5SzVlcytN?=
 =?utf-8?B?dlVzYlV4dlplYStrYS9TZFBsaFRveHNqNmtYeGtBeDhObUlPT1I3ZTRmQzA2?=
 =?utf-8?B?bUNKQUxYYlpZRXp6TGg5OC9MdlZaaUJYbHp2cUtTQmtBeWIweFEzV2hldElm?=
 =?utf-8?B?UllvOERKWUY5MjdFUVh3TWRUNmxHUGFmaHdKaE8yK2dkb1NMZnpYU3VucUJJ?=
 =?utf-8?B?cTVkYVU0Z0FhMHMyZS9xWWZFMHgycEt1VDlhOGljVm5vOTNUVkJ0NlB1cmI0?=
 =?utf-8?B?cDhhd0k0eHEwcFRyV1BqUXptVkdYc2dkZ1VTMlBaSjdsWHVCakdMYzNTNkFw?=
 =?utf-8?B?dWdDcUR6cTIxV3hOSWxOeFBoekZvRzg1QnpIa2t1dXpiYXJFZTN3cGE0Z3dF?=
 =?utf-8?B?bnFxR2VNaXV1ZklWL0cxS05LUDV2SkpqNXBVbWlkOTI0ekc5aGJyUll5dWFT?=
 =?utf-8?B?ZDVlUUFjNThCN2l0b3hyMlViRUQxLzZNT29rMGoxWmRCclQvUUpSbENhcnpm?=
 =?utf-8?B?djNMRVMrbFhNTmpNeFNqeVhla3RiVzBlZmV3WWc4aVpUMVIyNXd6emNzTHJY?=
 =?utf-8?B?dUUyRmVqVklwMXliWEx4a0NxalB2WFBwUExlTkxWRHFEeTBVeDNqb2FPOGJC?=
 =?utf-8?B?QzdwVlQwTGRLamVZTEdxb2R2OTZNWEN4OXRTYWQvSEJydlNHK2JiQnVUWDhk?=
 =?utf-8?B?STJXNU1pZHFkdzRZWnAyZnBGMlVTRmIrdGhWREtjSnFLZzQ2RW5SbDV0MHNT?=
 =?utf-8?B?WE1PV3k0NklnVjFQcTMraTI4L2hjRy9WZXNIVHFPZFYwSnE1ME8vLy9vc20r?=
 =?utf-8?B?THlKUndtcFhDODQ4Zlo0VXM5RDJUbmxCUzJPdHJucW1YZkErTW81ZnNueUtx?=
 =?utf-8?B?QzNsajZyb1hHRUV6dlgvQXdpVFI3ZHI1K3NWV2QvZSt0TTE2cFNIVkZmNGpz?=
 =?utf-8?B?aENpMmVjeU1aZTFRNmdIcERQclZjNUxacXhDTmdIYnFQbXpPQ0lYWS96d3RE?=
 =?utf-8?B?SDRjdXllaTFSNVcxYUVKSTcvd1hjcnRBSFZ5NmlmVEp6M2dQUXJNZ2Zvc2p3?=
 =?utf-8?B?UmRWRit2QlBWb3BwQjdBdU5RNVJBODc3WXFnSDd3YU5MbmxmckxNejcySis3?=
 =?utf-8?B?NWxsc1N3VEVLdDFmQWpFRVpxRFk5SjVPc2h1WGxKc1A4cXNTczJEdmJ4am1Y?=
 =?utf-8?B?WXQyaUlTM1A5SURkYUpGZENobzVaZThmb3FQVEZYdVNEcnlXWkJBTUFVZW9U?=
 =?utf-8?B?dFJrb1NWMVZRZURFSThqd0lnd1RLcnllZERpc2RQVE85cnlXVnM1dUVjYTRR?=
 =?utf-8?B?cDY2bnBBUmlLTHFoQ3hScGR2anF3YklpckdEOGVGcDgwU1drUnlYWEZiQmFU?=
 =?utf-8?B?OXROVVVvd095UWZTWnFodXJoV1dhb0x4M1U0aERVbCsyU1dZVUNVSnZOckpl?=
 =?utf-8?B?MG03OTFUVFgvYzdLNDJIRzN1UVEvRG9IK0NGNWJueUh1bmFrWEh4am8rTnhV?=
 =?utf-8?B?Y0dwOFJaNG5UMk1icmVTb3l6UUl6N3MwUnBSdU1HOSs5R0NnQVMwRWxPamV2?=
 =?utf-8?B?ZE5vYXNoN0pJMTdHWHNhSG8rKy92Um9qZVpzSmQ0OENBc21vQXd3bFJ4bHJI?=
 =?utf-8?B?dkkwOTI3MHVvdVU3VDhEN3VXRlRFSEY2UHZmVGRXN2oyZk5adzlYZ0lpMFl2?=
 =?utf-8?B?ZmNNSGtrSnJianZiTE1tcHk1UU8xMlEySWxUcTZ4VWwveDF1ZFlVcDRjamVW?=
 =?utf-8?B?RDAzS0NRV0JWVCt3UVovTi9EOXFNS215bWpDZHBQMHFPbDBKTDdhSHl3TXBF?=
 =?utf-8?B?MXFSWFY5V2ZGTXdBeEJoWmhvY016QUFCZUM0NTQ0ZjJ2SzN4Y1FtNDR4OE1Y?=
 =?utf-8?B?TzJ2eVQwY1d6M2gyUEszaDJtRFUvcEk3YkNZM0ROQWxZVDRRUDg5UHpLSWVI?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1715514c-4f8e-4db0-1ceb-08dbbaad3291
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 14:15:25.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4ZvzvLK7uSBZZJWeKZ3elPZmq30i8OZ7V3gcfLMDujqSpN5TmaA6smsOwAfoB6FjyVozAfAYPgLGglUrycJODQfECNW+LF/GSl2ImL+fas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5274
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Wed, 20 Sep 2023 13:25:13 -0700

> In the likely pathological case of building sky2 with 16k PAGE_SIZE,
> make sure there is at least 1 frag_addr in struct rx_ring_info:
> 
>    In file included from include/linux/skbuff.h:28,
>                     from include/net/net_namespace.h:43,
>                     from include/linux/netdevice.h:38,
>                     from drivers/net/ethernet/marvell/sky2.c:18:
>    drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_unmap_skb':
>    include/linux/dma-mapping.h:416:36: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
>      416 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
>          |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/ethernet/marvell/sky2.c:1257:17: note: in expansion of macro 'dma_unmap_page'
>     1257 |                 dma_unmap_page(&pdev->dev, re->frag_addr[i],
>          |                 ^~~~~~~~~~~~~~
>    In file included from drivers/net/ethernet/marvell/sky2.c:41:
>    drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
>     2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
>          |                         ^~~~~~~~~
> 
> With CONFIG_PAGE_SIZE_16KB=y, PAGE_SHIFT == 14, so:
> 
>   #define ETH_JUMBO_MTU   9000
> 
> causes "ETH_JUMBO_MTU >> PAGE_SHIFT" to be 0. Use "?: 1" to solve this build warning.
> 
> Cc: Mirko Lindner <mlindner@marvell.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309191958.UBw1cjXk-lkp@intel.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

That "nobody uses this HW on non-x86 systems, why bother" is fun each time.

> ---
>  drivers/net/ethernet/marvell/sky2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/sky2.h b/drivers/net/ethernet/marvell/sky2.h
> index ddec1627f1a7..8d0bacf4e49c 100644
> --- a/drivers/net/ethernet/marvell/sky2.h
> +++ b/drivers/net/ethernet/marvell/sky2.h
> @@ -2195,7 +2195,7 @@ struct rx_ring_info {
>  	struct sk_buff	*skb;
>  	dma_addr_t	data_addr;
>  	DEFINE_DMA_UNMAP_LEN(data_size);
> -	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
> +	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT ?: 1];
>  };
>  
>  enum flow_control {

Thanks,
Olek
