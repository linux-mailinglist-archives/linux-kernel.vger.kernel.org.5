Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B01E7D94D1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjJ0KKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234978AbjJ0KKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:10:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B393D7;
        Fri, 27 Oct 2023 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698401414; x=1729937414;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xbaTke3U+2WYdyMJqGvedQSd8rGz0Y36RP0wvvf8OsQ=;
  b=d4pxYlp3m6atrgDCgrHmYL7teF0NPx6sAT+QLHGjgYj1zyV07VBHus7s
   31+erlSP5W58lKTqlah7OjT4aFKAxgr9BG/16+yIcesxcRmywDc+wu52f
   0wwRNe1ttMgmse6ruoP9AHyakn7dqDazUA3AZ6J5OZ4zN6+ZImtqMkwDL
   3u8hMV8IpDv5nf7V8LToB6+Pj98T51ruhTDSLReEmmDf5BzdT60VI//pe
   zJLarqgFaue506Bp1N857R9HrRDLjcmvPUidKv1KctqfbQ/KZsUk2S2lG
   xJrE1a+qy2CGIJixUK5hpJ1GetHRgeRivFaVAFuHdD3/mfzZir9N/de9S
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="451986659"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="451986659"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 03:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="763169927"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="763169927"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 03:10:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 03:10:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 03:10:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 03:10:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wfo7lKY26P9v5wd9X9kSI3yfIUBf4Knn+pIpFyK9caiqhaw/H9Ok6A1rzfIyy/yiySispRrz3fAsKFaDJc8NLt9tMVvF+ZLqubEuP5jNSrTWPLoLCA9pieEaDFjj74f7lGERihq4xXuFzW0lPjmoYBek22/GVkTn7WkM5eJt084TlV7LwgSGAqZXZajw3V37VQ389AcmF/Zse0Ppw1JFQdcmKN1MHXcxS8XNOdQ2BD+vi91LR8GDFxbGSoGRAkFaSVZ2Ul1cMdH/2i4TbznVVvR+tSbYxHKuINkBR27Q22NaYMW7m01xL9clW5IHR77uHsm13ype7pQ15Ab6HZ2O8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FW4XBm+PIjietQaslpCPlqPBBsRNz6vpxvirgWaSrDk=;
 b=QxE6Zpu0eIIE/uibv9VfE1BWiQhgGuIAy8WFo1lskapOywUopl5FdjJ4vvV4CnJzU4b1KrH8DCenB1khwxcgrUhf0vWkEb9Aw6Mqbeyy5y1+SODauGsJmx3oNKxKjJkubCey6HEQeyasjKdAu/o3pATaTgGIKQBpEVAMMo385aZT5LcdkWMI2+HQh89Z4lPWSg6epJjZXzUFKko1P985Er3Dxw/hd3B+S+Dr6THYpJ0g2kqOgKIP/ne2DkEdsfIi5L2KL5ROBNr9RK5kbD9aXuLtp85gOBvc5vi98Jx0h2VldqhBiLs5pHo4Ey9jjxXNEw8xGQ/y0WN2iGRX8JJXTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW4PR11MB6667.namprd11.prod.outlook.com (2603:10b6:303:1ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 10:10:07 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 10:10:07 +0000
Message-ID: <0cc19076-7c9b-4f6e-80e2-1a403fc0e501@intel.com>
Date:   Fri, 27 Oct 2023 12:10:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] octeontx2-pf: Fix error codes
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20231027021953.1819959-1-rkannoth@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231027021953.1819959-1-rkannoth@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::9) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW4PR11MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b4cdd55-0172-4a7b-6395-08dbd6d4e58a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7X+aNJbEZWw5oHhkG1b+3hO5qw54JnYNgCgNRgkwkH41CyHttDVHU5rVdkINmfjctKeKZ0zDlvdC1BH5iIDxoEI/zSmwQW9E9wzHiYF2oTJdVYObOOx91Cp9MifXYF28SgMWOr88+wkAHWZWsdBjbE0Cuc8Jke3iNKVMfxpNfXLEeRb7/RzgnWnsTzhJ2M/8RNywcSlAnhQmIrdEEI9z9R4Ya/OsXgUF30Keuak8VFqU3oNZvxXDQ1pYUlU7oNaZitM0cZca2Rn0FrNOug+FvZymbnsHdZKEcA19gItdT4ZTsioSnnIkcArr3fXQzm7/U73oBpPv3F6hfVtczT1fz78xgPn+XJOnwzV+uBmQ8A+/A+NNm3F9kKK4D02DHXQMLVPtOcr66DhQnvGaN5Voi2BsFP/UIcKdJHUPi1xMhlc3Xj8sulFKS37H6cQoW3nQOMIfuazJ92Uiezm2f4IfF05vMOKZZER8IWBCgFo6Ef7aaWBCAAjX+mcOdjDrToaRNo+u5rvYX98S4phUP7Ws0mVrIhGBEhxIrWVpePny1ZlJKasfjUpamYmTOJ4iTdJK81LBMcAQPvbWQgzgCXkivp9M7AlT8KMn8DF1lYLoIEu0sQiAAJShTulEHSfoMhguXnR0WFHQ8/Mv878mfLAng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(36756003)(86362001)(31696002)(31686004)(6486002)(2906002)(478600001)(6512007)(8676002)(8936002)(41300700001)(6666004)(4326008)(6506007)(53546011)(44832011)(83380400001)(2616005)(26005)(66556008)(7416002)(5660300002)(316002)(66946007)(66476007)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nnk0ZE03ek5abVdCQjNnK2FoTEhiM0l6UVhMVDMrVDVxSU5SdkdnUStXNWNm?=
 =?utf-8?B?dit1OHgxWW9LQTJlKy9KaitGZkZ2VVVPZlZMWldYOFRCTGJHSnhyMnJnMldq?=
 =?utf-8?B?enpwMEpLZGtxVHlwcWx5UVFKZ1pYY2NGdngwU2hUbkRwUTRPdjJMQ3NwRTg5?=
 =?utf-8?B?cFZKQWNKMXVKTmRzdE1DWXdqUU9HSmRtZ3p4dlpvMmpRTlJsdmpKWkZjWTJk?=
 =?utf-8?B?MDE0YVd0dGxJa0o0UUFhLzg5TklILzA5L3N3Nk4wMWFRazFzOHB3dXd0b3JL?=
 =?utf-8?B?ckRINVhKSFd5ZGJ6VWs1OFE5OGc0V2hXVi9sRUhocHppNy9sTVdqSUtPOVBi?=
 =?utf-8?B?Q0dBRTI2VG53cmk2OFVqNUxvNzcvbzFEeTNVdmM0b3BObTlVVVFjRjFXR0NH?=
 =?utf-8?B?L0dVclNabyt4WU0xbzBsMmZnS214clpCR2U2WGxLTExmdE9KRFJLdEpyeTEy?=
 =?utf-8?B?bEl2ZEVVaXVxY0V5cTFTS01Kdkt5NnFzMkNLQzRUcFVhK3RGNWNVbkJYcERm?=
 =?utf-8?B?bVFwNEZPb24wYmlEU2hRUzcyb093SzVrQVg0WTJiT1dTaGhKcUtPZXJPSXpY?=
 =?utf-8?B?ZlhiV2FCclU1cEdXckFNcU9nNm5oaHNLUGpkeEI4MUhPdllBekR3NVBnVE43?=
 =?utf-8?B?RjQ0USswYnNpaTE5Nmpub0JIQVpDOE14N0E2VGtTVVRtRTdPZ1hqZE1HUlVu?=
 =?utf-8?B?OVZlL2Y1YnQ2MldnSnJNWEdQZjNhREZRREtzU2tyYi81ZGVYQmtNcS9Wakd2?=
 =?utf-8?B?cGlhaUtRV1Zjd3MxTDN6cGZVeUxQQ3pnZGRDV29YZkNwN25lN1ZteXVLUFBW?=
 =?utf-8?B?R2YwbUtmK2dPZ3M4bDMrWE9XUVVqemRZdE9JaytQKzhaeE1GMm5RSStWeWlO?=
 =?utf-8?B?UXpnMWo1Y3VqR0hiOWI2UVZMSEFad0ltNEs0TVNySHF0dXYvQ3NYbHNPYmRL?=
 =?utf-8?B?M3RLYkRrWHllMFA0NWNiQ1dydzJvZ1hrT1pONDhGYnRWN0ZmUjZyZERKQUE0?=
 =?utf-8?B?SnpvamtPejNyRlUyRUtvWXhqRkhmTUg1aHEyTDBwYTVsd1dIREtLMVlNbXFE?=
 =?utf-8?B?WVBkZXlJQ1FDRVMzZlM0bjA5RWRJdVExSGFOV2UwZm1Wc0NJdnpib2EwMnBa?=
 =?utf-8?B?WEVLS0dac1AxZ2FpcjZIek5CeTdxbzJwb0wzQm84U1FPcWNGYVkxZU5vZzBP?=
 =?utf-8?B?a0JqTHpxODNWd0FVRGJ5cVVWNXgvUHlRMEhvTkpTZXZpdGR2VXQrK2tOSmxy?=
 =?utf-8?B?SWlXdjVYZDgxYVRjVjRxbnlIak5kVmpOR3E2U3hKRDZLWlJRRS9pNHkzdzJ3?=
 =?utf-8?B?VHVhN1FmS2dDM0tZWDZ4S3Rkcml3NDFoZlRBVGw2Q3ZyMnk1K1BiZFZlY3Jp?=
 =?utf-8?B?TlVrL25YSE8wdFYyM21aZU50YU9JOU1oTmlIeU01TW1sMWo0MDRaSGtYcktt?=
 =?utf-8?B?ZE00UEgxZmpZNXZ6WWtCQmk1ZE0zWkV2QlFQZ25PUFZNbzZCYm5yUTVrT1pJ?=
 =?utf-8?B?clJZcFlwWCtnb3cyTld6T0owbEpzTzRkN1Ezc08yZGpSOHd6bUFGTWtVc0o0?=
 =?utf-8?B?cjZsZ0VuMWpGQkk4WW5laXk0ZGp3R2c0d2R2OHcvVHoyUFNkWnE2c2UwUmVN?=
 =?utf-8?B?emZZYXEvNFUwZHQ2S2c2MjU3d0lTSTVzcXBDVmFNWjdabGtGZDlLeXV1UnJC?=
 =?utf-8?B?MUE4STNhQXZKZjlHMXpQOWJZL21qdnFteFlTeHdXNDFKV08xOU95dE95ejN0?=
 =?utf-8?B?MkdlN2RpQTZUVEE5TGJ6MEJXVlNlV0pxUk54MlRIQVhRWjhleUZQYUhvUG8z?=
 =?utf-8?B?Y2h0SE0xVVE1Tnk4ZHhiUTQ3RWRaWVI4c1FCM0plKzgwQ3R0cE92SVdsaXla?=
 =?utf-8?B?SkdxYWlTYmpuQlppY3FiRFA2SmVMWklkbnNxM0crcHhVb051Sk9yTFJCVDgv?=
 =?utf-8?B?aGlvd2hOb0EwbWtPai83UHhMakhkOUs2OUdwWWZURDJNZFBuZU1ZeXJONWNr?=
 =?utf-8?B?ZmVEMGg5enc5cnp2cE55T01CZVhaTWNRb1FOd0F3ckNVenZKSUhxU25FK0lp?=
 =?utf-8?B?TGc4TTlTd1d6cmFUT21sVG1iVFZrd042RVpnYys2cVZRM2VaUDgyRkxFWmEw?=
 =?utf-8?B?Y2pER2ZJdnZKODZsdkVUZUJ1NlRLamhVRUdDcHpKNnpRclJENmIzUDFNeGNX?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b4cdd55-0172-4a7b-6395-08dbd6d4e58a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 10:10:07.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwHg4pZlvAGXoyr9F59grKsUz0c4suIGpna1TbiW/mHWt/994VxM6EbNaPYdZfBFWXvLzjJz0XPcAMqIaPrUFsdVgSU2H3FwgrFYi/Tp8BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6667
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.10.2023 04:19, Ratheesh Kannoth wrote:
> Some of error codes were wrong. Fix the same.
> 
> Fixes: 51afe9026d0c ("octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> ---
> 
> ChangeLog
> v0 -> v1: Splitted patch into two
> ---
>  .../marvell/octeontx2/nic/otx2_struct.h       | 34 +++++++++----------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
> index fa37b9f312ca..4e5899d8fa2e 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
> @@ -318,23 +318,23 @@ enum nix_snd_status_e {
>  	NIX_SND_STATUS_EXT_ERR = 0x6,
>  	NIX_SND_STATUS_JUMP_FAULT = 0x7,
>  	NIX_SND_STATUS_JUMP_POISON = 0x8,
> -	NIX_SND_STATUS_CRC_ERR = 0x9,
> -	NIX_SND_STATUS_IMM_ERR = 0x10,
> -	NIX_SND_STATUS_SG_ERR = 0x11,
> -	NIX_SND_STATUS_MEM_ERR = 0x12,
> -	NIX_SND_STATUS_INVALID_SUBDC = 0x13,
> -	NIX_SND_STATUS_SUBDC_ORDER_ERR = 0x14,
> -	NIX_SND_STATUS_DATA_FAULT = 0x15,
> -	NIX_SND_STATUS_DATA_POISON = 0x16,
> -	NIX_SND_STATUS_NPC_DROP_ACTION = 0x17,
> -	NIX_SND_STATUS_LOCK_VIOL = 0x18,
> -	NIX_SND_STATUS_NPC_UCAST_CHAN_ERR = 0x19,
> -	NIX_SND_STATUS_NPC_MCAST_CHAN_ERR = 0x20,
> -	NIX_SND_STATUS_NPC_MCAST_ABORT = 0x21,
> -	NIX_SND_STATUS_NPC_VTAG_PTR_ERR = 0x22,
> -	NIX_SND_STATUS_NPC_VTAG_SIZE_ERR = 0x23,
> -	NIX_SND_STATUS_SEND_MEM_FAULT = 0x24,
> -	NIX_SND_STATUS_SEND_STATS_ERR = 0x25,
> +	NIX_SND_STATUS_CRC_ERR = 0x10,
> +	NIX_SND_STATUS_IMM_ERR = 0x11,
> +	NIX_SND_STATUS_SG_ERR = 0x12,
> +	NIX_SND_STATUS_MEM_ERR = 0x13,
> +	NIX_SND_STATUS_INVALID_SUBDC = 0x14,
> +	NIX_SND_STATUS_SUBDC_ORDER_ERR = 0x15,
> +	NIX_SND_STATUS_DATA_FAULT = 0x16,
> +	NIX_SND_STATUS_DATA_POISON = 0x17,
> +	NIX_SND_STATUS_NPC_DROP_ACTION = 0x20,
> +	NIX_SND_STATUS_LOCK_VIOL = 0x21,
> +	NIX_SND_STATUS_NPC_UCAST_CHAN_ERR = 0x22,
> +	NIX_SND_STATUS_NPC_MCAST_CHAN_ERR = 0x23,
> +	NIX_SND_STATUS_NPC_MCAST_ABORT = 0x24,
> +	NIX_SND_STATUS_NPC_VTAG_PTR_ERR = 0x25,
> +	NIX_SND_STATUS_NPC_VTAG_SIZE_ERR = 0x26,
> +	NIX_SND_STATUS_SEND_MEM_FAULT = 0x27,
> +	NIX_SND_STATUS_SEND_STATS_ERR = 0x28,
>  	NIX_SND_STATUS_MAX,
>  };
>  
