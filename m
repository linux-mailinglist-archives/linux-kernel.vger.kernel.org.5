Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF20F7D806C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjJZKPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjJZKPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:15:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD1D57;
        Thu, 26 Oct 2023 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698315281; x=1729851281;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iIYQ4Ec1h/8BR/TVdP7hj1V9uJCEMjssTKbSsex5iC4=;
  b=VVeqiEi3lT1JUuvujQZGZCdZkPU38p1kFPpImzYEEnjQDDT5NI1Ix8wo
   XZiTwKOIeNPpySPMSu5eKmF38gVew0OqBtx7/gF42KUqAw9oF1NxU8u8C
   qr8A8lxw9K8TujRfC3Zb2glcgndfS3AvbBWj2kHuMrz9MytSUXRT3O8SL
   0ojv9S/S1Oa2dz5nem8OlGxv9K62JlhWguhME3S48KFRfh8KC4ahqkxHD
   Xl+OZFIRlYoc6Bp3ODhL4FmFUyF7xFn8oFKXyO9N1DjqerXGBTScAEHCB
   yxmFnTCSJZudb1Rz6dg0ETVxdkPf83JK6CdHgxTA3BYXNhC2DtP3Zl22m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="418628805"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="418628805"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 03:14:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="875880896"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="875880896"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 03:14:39 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 03:14:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 03:14:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 03:14:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 03:14:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0x8PPn++bGasO4qPOgEcQDMRh3h2ffwZVaFlhGnU+TOM0CkxdC6WMqldmbGScTNnWXDT0/hioNGfGxxJH7lUBQTF5hXy1cxai9pcGxInNOYSbJourFEtnShsMkSeK9Rapi6X/MKWY0VhWidKQv1a8CCZpFdgwl8MhkTvd0ZdRlzH2RcutA16GUyQ83LSq14TBpjpFssJm6SvHN1XE677RxLlobrdx+L9iyPUsuUEjS+EtwaOUNOExretfkhe1VzLs92GxwSFsUKUeQqjZ6GzmS6GwBoSnzSj4SgwgkDyjZlF31wSHkkZi4Ppi0MU99xMXYCsMlV8p6Ajt6jIRfwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac2pf5kdSVSaASCMkGHh4cBJcZ4Auvl+6Ffi40tO5ao=;
 b=if1HRMomulGtqGPG/GCT84OP8RttkaQlq0tSYvtmLa12LqIFWWdrrFO0D+AWfhfl3sNcEQv4iY6tZIsLvNeVuVpQ1nBnHl0j+YS5Pu8NAEQdmV4S8HNRXYUHTL55yMIAvtkeamDFRspI6bdaCNDQu4AoFOe8vtXF8S3J+BJfohWIz7VHM6QoSxejxXYCMNsMydtBuIfXj4zkhp1M2M1L35r10qDC1ktKe0GxDl2AkBQ69Vf+YpzpMfqJeX+3BDqHjbHkfYKVA06IIuBN4xedTtJjzRGtRmT6wNMUG1cTepkSwk9WxPCgvx7V3E58RVTOCoY9Bfhu1j7gKcAj9EV7Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 10:14:36 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 10:14:35 +0000
Message-ID: <5819e6c8-d887-40ca-9791-07c733126e64@intel.com>
Date:   Thu, 26 Oct 2023 12:14:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] octeontx2-pf: Fix holes in error code
Content-Language: en-US
To:     Ratheesh Kannoth <rkannoth@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
References: <20231026030154.1317011-1-rkannoth@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231026030154.1317011-1-rkannoth@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH0PR11MB5832:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a116aab-f637-4ea3-fffb-08dbd60c5ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgFcSCh1xyegJhKrXa6Y9NZu9qUIzvzR18Yx9yCzSNDkF//A9I3Hl/JSnVtgxy+fYzR1ubsgiO8BX5Yi57SImU1oQ/G8HhSK4NuAyuWFPzx/8tLtEKwtaTNEIOyLGHPgLx9ZLJBxZJEkb5eNbGjOFkGZutzHNZJiV/Ck2yxPJzbiNAuN2fR1oVB8ZDTayWS2rCuP08Y8Z+t881kTKcwaysDIfkZX8Vg4lfe4u7f+NMk0mtPOd9zBCbjoWcspuFbgVJ+su+3PJ1nAWGeWC1ihnHc+/uIQK8DTzrG9UJk3Ju2weokl65/9kOcQo9Bha1QWFnoeHdS463REdKsG2SrqP3TMwyY5S1hjZmEz3GvhY4Z+oWV4bQ6Q4SI3nJgRJXLUPeKevkc2oUbAAqi0IhYsYuqezmHvdPkBC84o34cB8pEzWnp2Wwa6OcauUosgOF98evOlPN6BFZwQvUfEwUi63dKn8vzXwkAbO9du4+plYDfkiRD7LrAP9Hm1obc68LsIQ/cHIqZws7DgesGlGC3mdPRpP563eIMvAmeTDZbbBhYlVkbma2TDwTCSsSQJXRCqqeQYBl+x/HA5CDNiKpi8VrK+YQ8qiNWBX2ZPoILXcltE93dFq5SZ7HqxnpAhpdCFJT3QolG5p9ooLzHJallJ0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(478600001)(86362001)(2906002)(31696002)(44832011)(66476007)(66556008)(38100700002)(66946007)(82960400001)(2616005)(6486002)(316002)(6506007)(6666004)(6512007)(53546011)(83380400001)(4326008)(8676002)(7416002)(5660300002)(36756003)(41300700001)(8936002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2RxMnJJTVNEeHNiaEl0QkdlV2d6ZXFLTmM2TzE5V1YxenpoZ09WWGhWS001?=
 =?utf-8?B?UUsxTCtaODBQcEcwTWR5TFFrL2lEb0JWbG5LRmJocnFSQ085dGM3akF6S1pF?=
 =?utf-8?B?S0RKNFZGdk9XV2hGS1lXVGRBNTA5SDVwV2ppUCtjUmZJcnR3SjRrdDhDbWRF?=
 =?utf-8?B?NjI2amdqckYrSDNTL2g2aU03bWNydFVxa3NtcVBYUUM2MU1SVTRlUjJyaTR2?=
 =?utf-8?B?Q0R6cVZ0UENjeDdvWitodktMVUFPZTFaSGw2Zk5YcXZWcWZqZXpRR3hJRm5n?=
 =?utf-8?B?Y1FxRnJ4bnVUZUZKZ0NSZFFOUkhvTUQyRDluNVZnU01iSXFCNzZFUDE4aFVu?=
 =?utf-8?B?Z1RFdmNCdU9za2dSN1Q4R1lrTkg5VHVVZWFlOHpLeFI5V0g2SDVTRE8wa1dW?=
 =?utf-8?B?dTE3Z21Demc1UUJWWlhJMG9WZEpFcFQxRnI4cXNzOU1Qd29YUVVGRFpxL1Vs?=
 =?utf-8?B?b3pYNk00Y3RyNDNPalhRdkg3R0lwQWFua1phc3p5VUZWdVlwNlRIRlpMb21O?=
 =?utf-8?B?N3hqRDMxdnVHN1BCVFdKc0drMEZ1TFc4K1NYQnMzYi9ieWtJa05YTnNpM0s4?=
 =?utf-8?B?TXI4WXdUWUx1TkdHS2h3ZExyVVVxZ0FBcXRsTUIvendBaG1hWjVxVms0NDFh?=
 =?utf-8?B?QVMrSDBUUWplWWNTbVUweVRFcW54aEdJeFVWdmMxcStlLzJGN0RiQ25BWnFz?=
 =?utf-8?B?SExkMDFIWkRZVzJ1QUIwblFaQndtTHFTU1gvRU51K2JqZnhBQnNtMmZqeEN1?=
 =?utf-8?B?d3FJY3Y3MlAzcHEydlRBVXVmazRVdmFZOG5CQmtrZjlJOVlic0txN3hVeXlV?=
 =?utf-8?B?VFFWZ0tnN3FoVk9XVGZDOTF5OFllbFRNTndzdm91VzRZUS82MXlkdUNBVVFl?=
 =?utf-8?B?ZmRKc3UxdzQ2TmFCakE4OVM0OUNPTkN0TktsL21WZW5Wdm1yOVNIZ0x1eDZz?=
 =?utf-8?B?aUMzbDZLcVVEcy9lUGJhTXRYejV3ZFZPY3Z2dXNkZFFLNkpWeEpzaWNJTko1?=
 =?utf-8?B?Zk9GY2hpa2s2RFN2Vktzd0V2OUl5V0xsSmRFYW1xREo2OFVzVFR0M3lxSTB0?=
 =?utf-8?B?MEE1cnhwZXRoYXkrTFRpUkZoTm1ocWxQYVhiUnVRTmhKcUJQU0pYUDJiR2lX?=
 =?utf-8?B?Y21obTViQ1VJd1ovUzNUQXlpUVJnS1BYUWxFc2hPcmJWYVA4YzVIK2l1b2c2?=
 =?utf-8?B?QVQ0UW1uZ28rSW9XNitodnpzMnRzY050TjVuODdqK1hTNTRiSC83c0xiVS92?=
 =?utf-8?B?ZHdDU3o2bDgrSUFNK0NQdFhtcDRyakg0WnpoOEowOW0xYnhxWkthQnJobEto?=
 =?utf-8?B?cFQ3ZDFSVFE4VjJRS2JTNnhVeG4wZVpMVkpaeWNNZDFiSDVzWDlvS2ltT2M0?=
 =?utf-8?B?S2NxS2lIeSsvMys1SnlFR0VKTTBCRVhNL0VDeWF4Lzk0OXJBZmpxSFhlUE1D?=
 =?utf-8?B?aFdGbVE1Q0xIS2ozQVBTcndnM2pCUmVRY0piQjZVUzZYU3dyNnJ3VjJhcUVS?=
 =?utf-8?B?WTBDWXVDT0JKcmt6bTdPN1lqeExwZndJTmxYZEhEekZqdFJqWFdUUDJoWnlB?=
 =?utf-8?B?NmMwRUhCOUYvNGYyUlVEa2ZodUVna0hCelJvd2xES1BDT0R2U2ZJZFBFOERS?=
 =?utf-8?B?VTFaY0hjUmZjLzMzY3MxamxybjZtVGVaWW9SWktPVURHbEpBSm1PcFZjbnFz?=
 =?utf-8?B?S0JqVzlQUS9HdWtCejBnYU8xKzVTTW9DVkZBLzdub1hmbWlSL000di9PUE1T?=
 =?utf-8?B?Q0VIeSt1WUE5d1RRNEdnaEZQVnRwWWoySWFaYzBvSzQzYzNzUWcvRlJXa2JM?=
 =?utf-8?B?amx0MGp2YzhwdFZaYjFhZ0F6V3kwa1lVN3ZjeWdDYW5jU25vRUgxRkxpUHF3?=
 =?utf-8?B?Tm85ZS9UelExSUR3TFpWNlpzWTRER3BRbU8zQ3lTb1FCcGUwRE5wSURDakNk?=
 =?utf-8?B?aHdTR1A5bjNBdXljVzR4WUc2V2NxcXRMcUhZaEZrWUtmQ0RCNmg1YVY3dldL?=
 =?utf-8?B?M3I2eWpVMk4rOWlEb09RNVd0Q2lPVmR1ZlhUVmtmbkVwSzRJRVlaaklVNWZD?=
 =?utf-8?B?VTBYMkM4cU9iaGk3ckcxdVdzVFFjMUJhOVEyaHJRU0xsWE5rQ29uVEpxaE5n?=
 =?utf-8?B?ZmVlek5ibDB6QUMxSldkZHN1SHV1bTRFdFJINGlPNHMyZ1JFVFBiQmV4Wnk0?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a116aab-f637-4ea3-fffb-08dbd60c5ab8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 10:14:35.5705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrmT9G/LFR4pemTZ3B2k3BoUMxkjyQd5kGvcAF6GJdc/wakeoyQBSstEcEGf0inkkPJP3Gr2DCMLdES3teT67lTvXruQMFn6Ne8WbxR5MEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.10.2023 05:01, Ratheesh Kannoth wrote:
> Error code strings are not getting printed properly
> due to holes. Print error code as well.
> 
> Fixes: 51afe9026d0c ("octeontx2-pf: NIX TX overwrites SQ_CTX_HW_S[SQ_INT]")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 65 ++++++++++---------
>  .../marvell/octeontx2/nic/otx2_struct.h       | 34 +++++-----
>  2 files changed, 51 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> index 6daf4d58c25d..e82724f69406 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
> @@ -1193,31 +1193,32 @@ static char *nix_mnqerr_e_str[NIX_MNQERR_MAX] = {
>  };
>  
>  static char *nix_snd_status_e_str[NIX_SND_STATUS_MAX] =  {
> -	"NIX_SND_STATUS_GOOD",
> -	"NIX_SND_STATUS_SQ_CTX_FAULT",
> -	"NIX_SND_STATUS_SQ_CTX_POISON",
> -	"NIX_SND_STATUS_SQB_FAULT",
> -	"NIX_SND_STATUS_SQB_POISON",
> -	"NIX_SND_STATUS_HDR_ERR",
> -	"NIX_SND_STATUS_EXT_ERR",
> -	"NIX_SND_STATUS_JUMP_FAULT",
> -	"NIX_SND_STATUS_JUMP_POISON",
> -	"NIX_SND_STATUS_CRC_ERR",
> -	"NIX_SND_STATUS_IMM_ERR",
> -	"NIX_SND_STATUS_SG_ERR",
> -	"NIX_SND_STATUS_MEM_ERR",
> -	"NIX_SND_STATUS_INVALID_SUBDC",
> -	"NIX_SND_STATUS_SUBDC_ORDER_ERR",
> -	"NIX_SND_STATUS_DATA_FAULT",
> -	"NIX_SND_STATUS_DATA_POISON",
> -	"NIX_SND_STATUS_NPC_DROP_ACTION",
> -	"NIX_SND_STATUS_LOCK_VIOL",
> -	"NIX_SND_STATUS_NPC_UCAST_CHAN_ERR",
> -	"NIX_SND_STATUS_NPC_MCAST_CHAN_ERR",
> -	"NIX_SND_STATUS_NPC_MCAST_ABORT",
> -	"NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
> -	"NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
> -	"NIX_SND_STATUS_SEND_STATS_ERR",
> +	[NIX_SND_STATUS_GOOD] = "NIX_SND_STATUS_GOOD",
> +	[NIX_SND_STATUS_SQ_CTX_FAULT] = "NIX_SND_STATUS_SQ_CTX_FAULT",
> +	[NIX_SND_STATUS_SQ_CTX_POISON] = "NIX_SND_STATUS_SQ_CTX_POISON",
> +	[NIX_SND_STATUS_SQB_FAULT] = "NIX_SND_STATUS_SQB_FAULT",
> +	[NIX_SND_STATUS_SQB_POISON] = "NIX_SND_STATUS_SQB_POISON",
> +	[NIX_SND_STATUS_HDR_ERR] = "NIX_SND_STATUS_HDR_ERR",
> +	[NIX_SND_STATUS_EXT_ERR] = "NIX_SND_STATUS_EXT_ERR",
> +	[NIX_SND_STATUS_JUMP_FAULT] = "NIX_SND_STATUS_JUMP_FAULT",
> +	[NIX_SND_STATUS_JUMP_POISON] = "NIX_SND_STATUS_JUMP_POISON",
> +	[NIX_SND_STATUS_CRC_ERR] = "NIX_SND_STATUS_CRC_ERR",
> +	[NIX_SND_STATUS_IMM_ERR] = "NIX_SND_STATUS_IMM_ERR",
> +	[NIX_SND_STATUS_SG_ERR] = "NIX_SND_STATUS_SG_ERR",
> +	[NIX_SND_STATUS_MEM_ERR] = "NIX_SND_STATUS_MEM_ERR",
> +	[NIX_SND_STATUS_INVALID_SUBDC] = "NIX_SND_STATUS_INVALID_SUBDC",
> +	[NIX_SND_STATUS_SUBDC_ORDER_ERR] = "NIX_SND_STATUS_SUBDC_ORDER_ERR",
> +	[NIX_SND_STATUS_DATA_FAULT] = "NIX_SND_STATUS_DATA_FAULT",
> +	[NIX_SND_STATUS_DATA_POISON] = "NIX_SND_STATUS_DATA_POISON",
> +	[NIX_SND_STATUS_NPC_DROP_ACTION] = "NIX_SND_STATUS_NPC_DROP_ACTION",
> +	[NIX_SND_STATUS_LOCK_VIOL] = "NIX_SND_STATUS_LOCK_VIOL",
> +	[NIX_SND_STATUS_NPC_UCAST_CHAN_ERR] = "NIX_SND_STATUS_NPC_UCAST_CHAN_ERR",
> +	[NIX_SND_STATUS_NPC_MCAST_CHAN_ERR] = "NIX_SND_STATUS_NPC_MCAST_CHAN_ERR",
> +	[NIX_SND_STATUS_NPC_MCAST_ABORT] = "NIX_SND_STATUS_NPC_MCAST_ABORT",
> +	[NIX_SND_STATUS_NPC_VTAG_PTR_ERR] = "NIX_SND_STATUS_NPC_VTAG_PTR_ERR",
> +	[NIX_SND_STATUS_NPC_VTAG_SIZE_ERR] = "NIX_SND_STATUS_NPC_VTAG_SIZE_ERR",
> +	[NIX_SND_STATUS_SEND_MEM_FAULT] = "NIX_SND_STATUS_SEND_MEM_FAULT",
> +	[NIX_SND_STATUS_SEND_STATS_ERR] = "NIX_SND_STATUS_SEND_STATS_ERR",
>  };
>  
>  static irqreturn_t otx2_q_intr_handler(int irq, void *data)
> @@ -1282,8 +1283,8 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
>  			goto chk_mnq_err_dbg;
>  
>  		sq_op_err_code = FIELD_GET(GENMASK(7, 0), sq_op_err_dbg);
> -		netdev_err(pf->netdev, "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(%llx)  err=%s\n",
> -			   qidx, sq_op_err_dbg, nix_sqoperr_e_str[sq_op_err_code]);
> +		netdev_err(pf->netdev, "SQ%lld: NIX_LF_SQ_OP_ERR_DBG(0x%llx)  err=%s(%#x)\n",
> +			   qidx, sq_op_err_dbg, nix_sqoperr_e_str[sq_op_err_code], sq_op_err_code);
>  
>  		otx2_write64(pf, NIX_LF_SQ_OP_ERR_DBG, BIT_ULL(44));
>  
> @@ -1300,16 +1301,18 @@ static irqreturn_t otx2_q_intr_handler(int irq, void *data)
>  			goto chk_snd_err_dbg;
>  
>  		mnq_err_code = FIELD_GET(GENMASK(7, 0), mnq_err_dbg);
> -		netdev_err(pf->netdev, "SQ%lld: NIX_LF_MNQ_ERR_DBG(%llx)  err=%s\n",
> -			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code]);
> +		netdev_err(pf->netdev, "SQ%lld: NIX_LF_MNQ_ERR_DBG(0x%llx)  err=%s(%#x)\n",
> +			   qidx, mnq_err_dbg,  nix_mnqerr_e_str[mnq_err_code], mnq_err_code);
>  		otx2_write64(pf, NIX_LF_MNQ_ERR_DBG, BIT_ULL(44));
>  
>  chk_snd_err_dbg:
>  		snd_err_dbg = otx2_read64(pf, NIX_LF_SEND_ERR_DBG);
>  		if (snd_err_dbg & BIT(44)) {
>  			snd_err_code = FIELD_GET(GENMASK(7, 0), snd_err_dbg);
> -			netdev_err(pf->netdev, "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=%s\n",
> -				   qidx, snd_err_dbg, nix_snd_status_e_str[snd_err_code]);
> +			netdev_err(pf->netdev,
> +				   "SQ%lld: NIX_LF_SND_ERR_DBG:0x%llx err=%s(%#x)\n",
> +				   qidx, snd_err_dbg, nix_snd_status_e_str[snd_err_code],
> +				   snd_err_code);
>  			otx2_write64(pf, NIX_LF_SEND_ERR_DBG, BIT_ULL(44));
>  		}
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
> +	NIX_SND_STATUS_CRC_ERR = 0x10,> +	NIX_SND_STATUS_IMM_ERR = 0x11,
> +	NIX_SND_STATUS_SG_ERR = 0x12,
> +	NIX_SND_STATUS_MEM_ERR = 0x13,
> +	NIX_SND_STATUS_INVALID_SUBDC = 0x14,
> +	NIX_SND_STATUS_SUBDC_ORDER_ERR = 0x15,
> +	NIX_SND_STATUS_DATA_FAULT = 0x16,
> +	NIX_SND_STATUS_DATA_POISON = 0x17,

There is a gap here, is it intended?
And in general, why error codes were changed?
Starting from NIX_SND_STATUS_CRC_ERR which was 0x09 and now it's 0x10.

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
