Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494F078E0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbjH3Udk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjH3Udj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:33:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DAB4B23;
        Wed, 30 Aug 2023 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693427586; x=1724963586;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=V/ktCVoY24ZA1fxtPqnDfXW5T1BU4M93WcII81NJuew=;
  b=HUlAv7F42N0Ye2FCa20/BTNYVNJ6NUDUFXtul7Xlm7lz7FSvjrHqV9/p
   frzxe0RmSJD9ofU2S2/gmHsRuvPxEbMK6a/33RR8W5ApTfYKJwz2FFPKf
   ymxnB28fF12alhPJ4nmTZx5Y2GCKLXycX/PHc/ZAnHrsFVCvgWWzzKHqj
   EsRGXGYfXDtTcBCtFgylHmGVXJ63sNc50LJnZKMR0ZM1GKpKeWSU7KC2x
   0xSaVvy2Q71OrePgT7jaXq7d3Lkh8stvyA9e8k9Gsw7dxOU/GdwxxNdlC
   3aK03nKb7TQGAGvH1f/LQ97f8a3DDVwlmRd40nZZDKaXkrn9xLPuS+keG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="379495599"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="379495599"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 13:33:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="768533125"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="768533125"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2023 13:33:03 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 13:33:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 13:33:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 13:33:02 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 13:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5HHVUnfuaJVoUGMFicDu9YjNyIBM85FYI/K3w4JdbNL7jkqYcKTWJ+4oLeh+SrIciMSFQyxmc0eaaSm1UFao+6BJMda/mkZ93htr84T7pIzwWzKsGxV9hwk4Olw9IdwRobySl80F2MkvkNJbUKZbn+rBIDD75fLxV4Ln9xPUdvAeeHQyTP4uNuqGBF9GAbGzM4e7/BIn21/xDRrNP7o/w3wTaPceYUrBYJVrUQMNpC0adX0A7XxynzAhdoktyA9BHTM/0NKEyv7S/LXCDMa296IxClpe7ZvzmQUn7pSAH269eTUFuoPmoK7osgYvmT+nJvVtXgCbbXTNDOUqWahCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sP2YgWLcrTQLQbf2Dw1IxCm11sq7Yb5BU/zr2vLlz8=;
 b=LpmUzMv3DssXn9jkHTqhYcsi9jWbqMrgUvMg+dUDyDuRAKugjPqZlw58/TtbQnJVeCaFJPrgAAmY76msGbtTizqC3fBE6D4MKpeNlYugaBjxqCnpioTJOfylGsohiHdUaLu29v034mOWtCUS8nLKrPiE88makFxLcTUEtgWOg06DejEqytEtoRPFjlfK3WsBp880iXZZJw5Us4c5BKRYAWjTaRjWAbjOphBwbB94+D55lns56h069c/YOp8m+jJvDugNZT0k/szCo1i9dgLS8MK3TYGv9iPxwflud2x5ucSp29BA+KBtK/o+otBoVugzk16BLxz7l/AADPuddp11zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB8015.namprd11.prod.outlook.com (2603:10b6:510:23b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.30; Wed, 30 Aug
 2023 20:33:00 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 20:33:00 +0000
Message-ID: <4a7c4345-a35a-4b41-9d51-fe98e36a3bbc@intel.com>
Date:   Wed, 30 Aug 2023 13:32:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH RFC v2 01/18] cxl/hdm: Debug, use decoder name function
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-1-f740c47e7916@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-1-f740c47e7916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::17) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 54fb032b-fcb6-4db6-63b4-08dba9984d6c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzznsR7r+wOkwqTB4CFlEjWqHc7Ninsh4jgsFyAXPk/y96Ub8JVXZZAO4hAarLyxlrDECbXdI/LwTgaRFs24reRiQIjRaX76SEKh4pt4mKZ0foJdbtTjbFixVf19xNXKUKl0ECBlP/QSAViYTT25ad4gyoQdq4S2akVD2F6cUQXUKEJs2KoJ9pBDQxOZuup1dkhVNtkHaWHdxOKGcLvOmDIsX6LVvQanw/BhFsvlw/iftDmsgE0do3ZvK7VTsaiNSy9v8W8D8LeTPhLg7GxpvO29Qfgk9CzlBKcIGBiVRmcXphBVWl3A+MRsOacGX0lyuuSzaKAh/MrEj3nSgdk0mMHiQy8PS1fDKMTLSgN6V+5DGjoLu7MscKZUDaFd1eR1YYLEegzRdlbsnUEXIVGijq1ma+scBRZ2HLJoDVtrrmCo2aYW5Xasoh0IEkgJLZU5GBF0iWLE2NQEzYuAMv9wcifnc8mN3cxJWnF81UTdU421JZk8Sjfei1r+pIzAMeY9m0WsX89ZO4WwqW5M8t3hHLdCwYNMC8kK+WJeV9KCQojpqEXYB63P0D50gmYYZWcCrpf8JXAzrzQ7o8FyVOOXdviArAbbzQyW2Nf8knSkmhdKSNhrvCN6nG8A+cXausV73W+41FcLCoPIvVBD3ZCJ+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(186009)(1800799009)(451199024)(8936002)(6666004)(66946007)(31686004)(478600001)(110136005)(53546011)(66476007)(6506007)(54906003)(66556008)(6486002)(6636002)(38100700002)(316002)(82960400001)(41300700001)(6512007)(26005)(44832011)(5660300002)(36756003)(2616005)(8676002)(31696002)(2906002)(86362001)(83380400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVR3emhaRTlod1UydEFiUzRML3JhT2Y4eDZzYTBVbVZ1Q0FOOTYwTEVCaGI4?=
 =?utf-8?B?SklkdmVJK0Fld25HUUM3bEs5akVrNWFzYlh3ZWFoT2lrbk9FNDlnYnNxV0FE?=
 =?utf-8?B?cFhlaWZsTDZsL09zQmNtYnphSlp0bkU3UWIwOWtCTFA0SGtnbWkwaklaZFFq?=
 =?utf-8?B?TStQcFp0MjF5ZithQjlibW53T1JFNXlCejF5WGFlVFB3TnpGUk9VdnA2OEFQ?=
 =?utf-8?B?d2FrY2ZYczlZTnB5Ym1xY1RGU0pPQVdGaDFUU1JHVzFVWDhMYyszN0x0WENq?=
 =?utf-8?B?Skd6YWZrZmZpbzZSZDJsSXJ3Y0xZRTI1Q1ZSWlpKQkoyQ1J6amVYWThTZWlt?=
 =?utf-8?B?L2VkU201a2c0QWU4VS80Z1V2R2dxcWZTZGRXMldqdjdsNHRBaXl2V3RGNnAx?=
 =?utf-8?B?cWdNMVBHeVBtbjBJMGlWOHptSlAvS0VjMWhnL2t1WGxsSVErd0MwaGhDb3lm?=
 =?utf-8?B?OERaaUl0Zy93bUovZWRQeHRKMGpORnVFb3pVMmdON2Y2OUpkVG5CUTAwcVFt?=
 =?utf-8?B?M2duazBGNUJFQVpFNHB0S3E3YjJoaU9NYzJOd084eVpvYmpGQ01WYlMyd2Jy?=
 =?utf-8?B?OEJhM3BOOFY4ZW9BVkFES2pjZk9ha2o5Vno2cHdtM29VaDRSdFlDYkI3TXdx?=
 =?utf-8?B?bU9SRUNYcVJxRTdYSSthMFA0T2xLYm42eHgxL1dubFNHSnB6QWdmV1B5bjVM?=
 =?utf-8?B?M0hLVDBuUVE0bTlLSFRGdi84di9yZ1liaWhOeE1qdmlMajFjcjRwd09ZVitI?=
 =?utf-8?B?aVlGVENsaHdEb25CWm1jS1dHY2p5aU0wZC9iSFFNd0VlcHVNVDl0SFU2SlBw?=
 =?utf-8?B?QjExVWcxZ2pzMXkwRGJnK2U0RzdZYi9aRENEQVd2cWxCVUM2NHg5b3JabFJH?=
 =?utf-8?B?WmhuZSt6cnhpVUc5Mkk1MU1BN2VWZGg2a1pMa3Npc2pDeE5ycGlVaHNuWUZD?=
 =?utf-8?B?WXRqOVBEM3NRTk5xei9LOXAzTEFaTUtwWVVWVnFTOC9QcjVzYnAyMndBMHJp?=
 =?utf-8?B?QnZlSDU5dFVJWlJCajRvOWEra0M3TUQ4cGZkMmYySE9raTVrdXQ1ODFZb0FI?=
 =?utf-8?B?K0VaMUljcVJrcFg4YURFZFZYY1o4QVlIbnZNOU5NdEZibUxENXVHRHlibHV5?=
 =?utf-8?B?eHpyNUJsNnJOOW00VVU1UWlId1pGbDNqeFFrS0I2NjNTb3lDbjZZK0RtcVp5?=
 =?utf-8?B?L1BUMDI4YjJjeWFnSjdQaHo2b3d5TGpEYWEwQlJLOU9xcEVDeGgvTnRTaDJ2?=
 =?utf-8?B?VnBMYXZaVkpUejhhS0lwYjJsVXJyNXdXOXZRb3lKcDdXY0IwZ3hYTmoreE85?=
 =?utf-8?B?bXZqVTVxUUI2Q1BUS05xRllHVDA4MTR3UmZOcUZoYzVMMGRLTENCU0lHODFW?=
 =?utf-8?B?Kzd4TWd0ZVBoSi9WOVhrT1ZiaW5zS2NhcHBzeklpRDBjTThmeW9nUkhQSEhw?=
 =?utf-8?B?NUdUWi9zVWl0QjRvRzdEdTNwSlIrWmRBZFMwNlE1VlpxaW1tYmFLMDV6bGVu?=
 =?utf-8?B?Rm5iN3N2dTZBei9UaGFsTFZOYms4QStCQWQyQlVJVU1mWU1pd2RoSnYrVUh3?=
 =?utf-8?B?NFV3ZjJITzNpRTFpRUlVOUFOOVFHK3g0R1ZHLzBnRHV4QU04eFVEWDRlQlp2?=
 =?utf-8?B?NWhrQ3F5NnFZS1g3YW5zWmc2K2ZERElmeWd2RWE1V3A1QlByNDR0T0hpenlv?=
 =?utf-8?B?TnZweGZEZnJaWTIvNU1qOUJaMTluM2RJdzlRSit4NVpmV01YU2FYRDgzSGt1?=
 =?utf-8?B?Vm04cXBRNVhFQmxrKzFCQUR5ZzY2dHlHZEVTRDhiTURSS2JNdlJHL3RSbmVv?=
 =?utf-8?B?VTMydG5LdmRROFV3UjJSYmU5SXlvMWpnOHBXTXpxUGh0YWRsSU5yN1NzNTVT?=
 =?utf-8?B?RlBsRzdjbExQaXZBakRJa0xYbC9Jajc4Ymp0elBqNHp5VUtpL2M0Vk1zcHdj?=
 =?utf-8?B?U1JPdHl0QVBLV25uSi8zb2ZFQnRjVE1yZlhBYUpyTG8rMHd1QWpsNys5cGJJ?=
 =?utf-8?B?M2FLWERRanRtenhIQ3VLd0w5TmltQWYvYjExSzR5aWNnM25HejEyYWYyNXg0?=
 =?utf-8?B?LytyR3JGY3d2UzNVNnQxZWFpRThVdnhoR3VZS3EzeENEY0h4bGFMcFFnRHJj?=
 =?utf-8?B?Q3ozK0pCaXZSMjNVNWRmazM3a3ovQzhTUjQyNE5UbkNBMytwWjJ5TnBxS1ZG?=
 =?utf-8?B?N2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fb032b-fcb6-4db6-63b4-08dba9984d6c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 20:33:00.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ID7PbUj5nPILIgKPa8UWMyABAtpLXaICH/u13c1BRQWQkkZ/pHc+syrokBwaVnbljk6hhjAm6hp9Qxy5VSHzXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8015
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 22:20, Ira Weiny wrote:
> The decoder enum has a name conversion function defined now.
> 
> Use that instead of open coding.
> 
> Suggested-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

As others said, send this upstream outside of the series.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Changes for v2:
> [iweiny: new patch, split out]
> ---
>   drivers/cxl/core/hdm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index b01a77b67511..a254f79dd4e8 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -550,8 +550,7 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>   
>   	if (size > avail) {
>   		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> -			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> -			&avail);
> +			cxl_decoder_mode_name(cxled->mode), &avail);
>   		rc = -ENOSPC;
>   		goto out;
>   	}
> 
