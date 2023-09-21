Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF527AA564
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjIUW6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjIUW6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:58:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2211A;
        Thu, 21 Sep 2023 15:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695337122; x=1726873122;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5bV8EnqnjNxHb7ZMRHFNXM5Cc2pFaOvl4SsCli/4ErQ=;
  b=VyLWdb/XLnRXNqRaAeQBruaw4Z2CkW7bS+sVRkb1U6Q7QQWZIaFZPetj
   Cs6VaTYzlvvU7d1hKBGQipmiWD3wG9nsOFMCu5iKvLo7PWaTcgS98EIN9
   YFSSx5NGyqbv32j33/9bQY+f7gix+aZWvqJceeuj7chTFRYF4Gc0UJn/S
   pcVKUVG+UPqNghEM1+z6mIzgeMG8kH0XDPzhtA/FlMslwgpIHUjeTVLel
   eSGxsQtop/6IAaGV1cXQ9RW3O+44pBslphs/P3yqvXMdcOr6qil0d11+Y
   W5S9Xu2s/NxsBybv3ubZaflJ5MUmUZcZerT/zRM0S2TbfoADgR0QD+bxC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="444795117"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="444795117"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 15:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="1078119565"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="1078119565"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 15:58:35 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:58:33 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 15:58:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 15:58:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 15:58:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f7cLvHY+UDEtx9YsQAyGJN14cBZYmU1itIB7ePnvFJi377rElw8HQ9Fy30aZNSaKtNVUlX+6HvHx8Rp0vbRUYqZsxvs03+ekmb8g2kWElUoO+p92jxK8sIM+e8XmadvmU93mLyAuqfxhaO6oLBw/X8duH3MoLFG1VbDNA6/uAoAhzqbBxaNSLHnIh5IOYTU95jXNOCqpHwG18QNxum072WQXFPtMT0AxKLdmm7tT4bVf6TC8NSuOJ07+h/E+8XOFqtNWWMCnfKB0sWtS8tOCjWszOO3k1q6pV87eoF0vDOsSzUN8Ph2ibEMrW1WlQFOo/jo8igWqbRWOAgUsLwkdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMVf+U3PXhrmvVXaVB3qJ+M4J8GAwMYsQpPstMSZqUc=;
 b=K2iJRvGcfRy6vCFrOuzDj+avnL3pdT5yZZH59X+CFlCKhKOAc6gvF1py8j9QCz3+r++km4nQaPw+mPMt+OzZuKQwjqeRAgv39lM4+bcVABYSNU5xid/YVlct67ht5CrYKwmle/Q6qExMUOucEh34kVZshngOv7Xml9PCogWqXLIQDaXQUZYdxfn0tcceph6HMMFvwNwo/yGP6ytolQmlBD92n8+WAn1XVlPVG9UPJ4grEoSVKWa1o/WSJ1T8v56hv/gmfpmQ2NcpAWyD5CtM6EUeUGF/XU27mt7HVTdgBncr6gH2wP/HpTh5zB3rTmaIOHJEHwG8U+nnCNAmjkkPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CY8PR11MB6988.namprd11.prod.outlook.com (2603:10b6:930:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 22:58:30 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 22:58:30 +0000
Message-ID: <de20c603-6521-1ab7-3bab-67e6a278bd1e@intel.com>
Date:   Thu, 21 Sep 2023 15:58:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 7/7] cxl/trace: Enclose a multiple statements macro in a
 do while loop
To:     Jeongtae Park <jtp.park@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "Wonjae Lee" <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
References: <20230921025110.3717583-1-jtp.park@samsung.com>
 <CGME20230921024832epcas2p35c4d3c20f7a70b023db64cd0db823eb8@epcas2p3.samsung.com>
 <20230921025110.3717583-8-jtp.park@samsung.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230921025110.3717583-8-jtp.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0085.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::26) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CY8PR11MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 2712ceec-df37-4c85-8c69-08dbbaf64629
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0gVEu8UWfNsh55WlF2FreyzsKv81KbWb+4fuxLv7MBwdfrTBmf1zEF/ZRBVaY1TEg/K7yrSCAlvcyTNTo7V1yueCYEjp6ZTh/9qJFa9koJV9zhpH8hCZzDTHymhU/jmATMOu1CVExDbxxn20ytVes762AYgLErakuU6zfJ8RTo6HvrRaNPpeA2rUFNun/14/0XXtPGHy8KRF8nwMbYhY3/gtAUYnZmMKj682m+X0SaYBS/kzKkJRS31r4QbLAw1E9dr6kv19IgyGXwanq6FnGB/f8/RgzX1f4RrlakHJPCERkTTlFPyjq3D9GB1F+Dsl+9XmYWpuC5Eg5e4y7XhNyyKc5OHPBqfyTM2T+icmBbYKyhL0J50xCfppD3gf600iCIdPB4QTQ6ghFEwnr3YPryAmmP0wGpvMf82rMWo17XjahrfaOWIsHAiuohnJcgWGOR7T5cSWV0xWUNKMnGd8e8el8xBN3th6QMPfZN8JMIFSQoPXcI/IVb23tEzZkFId53VlCShpJ53NfTj7uz5/rJMMD5BXEPZPlPXSJTVOF309YJKlisSNId+OlyW4NFLo3HmzgTd928L3kEI+QVNmIEsZh915ECWd3btqNHs04KLvE9t4+HhNe0DZ+JGLDRQW+0trQRsU8h6QXRDNRhjeKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(186009)(451199024)(26005)(8936002)(2616005)(82960400001)(8676002)(4326008)(7416002)(83380400001)(2906002)(31696002)(36756003)(44832011)(86362001)(53546011)(6506007)(6486002)(6666004)(478600001)(5660300002)(316002)(54906003)(6512007)(41300700001)(66946007)(31686004)(110136005)(38100700002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUZJSkl4K2tXMVVsMmZpaWl6bXNVRFZRK1hqbHdjNVNuZHBlVlpaaXNvTHdX?=
 =?utf-8?B?a0JyYzQ0TU90dkg3UWpJNXNQSHdXaDJ5NjJad1E3ckgyL055azRmTDlvcWpB?=
 =?utf-8?B?NkRDR3NXWHNxSXRCZFIyYXQvWGNQMitrd0RvVWFwM2JWRzVQZEpLUy91d3Va?=
 =?utf-8?B?bnZIVld2WWltS3pRUVgvN0M1MmJFZkJWa0pOeUJDRk4xM1dKMjVSRG9NTzQy?=
 =?utf-8?B?QlBmWkEvd2NMcEdJUldXdEJpYzNjOTJMdmFoYVk2cWF6MVVNbitDQlNzTlJW?=
 =?utf-8?B?ZXJxT1JKYUF0S0Qvbks5VTM4VndydUVuMVB5dnh3TVNzSDNGN3dJeFRSZDNm?=
 =?utf-8?B?YVFadEFNbzgrT25iNktMbkhiVnRZMmRqbWxkbXlseXhiWFBWU05KUDJ3eXIv?=
 =?utf-8?B?NzM4K3FHOWRQUmZJQjNnVXdOVmNpN29qU0JqMEkxR3pablRaNGRHZ3pCV1oy?=
 =?utf-8?B?SFFETU5SbFh2UVVXaXc1RTl4SlloSktlUSs5RG9OdS91aDE5ZUhpbW1hbXJ4?=
 =?utf-8?B?TFJZMWswUTZYcUVZbVRCMlp4MGdKU3EzY1c4WG10Wkpxa2VyQ0dPS0EzVlBO?=
 =?utf-8?B?ek83MWVnQ0hvZ0pMeVVsam95SzNrQXJjc2NpazQ5STdWa0gzWjVMdi9tM0p4?=
 =?utf-8?B?SjZua2VNUE00dW9XYjc3MlRXRllFa20vNmttMnFOS21mdHcraCtaVExkVWZ2?=
 =?utf-8?B?TjNDd2thMENjdTFibVJDcWxpeHUzWDR1VTVOQXREY3NpQm1sdnp6Q1dlcXVu?=
 =?utf-8?B?OGphS2dHUHlCMVZZRzV5RVlrZyswZU1iSDhOUTFVVTloUEFzY1Vpb1hYMFZW?=
 =?utf-8?B?Tko1Sm5xZ1BSeG1reGQ3SUFCc0hCUkdpc0JwQjNUTEp0dmdRVXBqbERhcHZ6?=
 =?utf-8?B?NWVqakhvOHFnSEZnVlJQVjExWDR1aDdjNTJxcFdsTkR0UlVSSXlHNm9ndXBE?=
 =?utf-8?B?bkEzOHhrLzgrd3JVQXJhVEJLbWowRlM1N3lxZXZWMjhnckRiTnVVd0h6bjYz?=
 =?utf-8?B?Z3FNMWEydUdtVHhiaGZGZGtWeUhlTUlJalVEOGw3ek4yVUhmcytJNXJpeG14?=
 =?utf-8?B?OFJhbVBLYy8wRTVUaUpWaHdqbkhINkh2bW8zTWE0Y1huSmN0T01mOFN1UkJo?=
 =?utf-8?B?R3huTGFDWVYycUlrRU92azFiS3lvU3FGNk02MHFqU2hBR053aVgyaWNlVU9L?=
 =?utf-8?B?WGNYTlBHY1hrY1doU1ZGU3lvaUl6QTNpcFFnMmo2ekJQclh1R0I2ZVRzZGlU?=
 =?utf-8?B?U2hRb1lmcmxEUytoM21FNUtEMWNFbVRsajJMYmJrMmJocVlBRjQ4VFlVUlFN?=
 =?utf-8?B?bXRmSDYrUDBuTDRvN3dkREF5V09GdnFzMi81RWN6dE54elh0RS9yemc3dHN4?=
 =?utf-8?B?RFhFR3JvU1ZTRVU2OVdaWlAralk5NlpVL2dsYVZ1ZUtKS04yTHpYeE42dTV3?=
 =?utf-8?B?TTZpNS9xM1A0N1d5bEdtQzkrZnJIb2ZXeUM1SzgzRkh2bGdFQm4ybElBRUN0?=
 =?utf-8?B?c1lSRlFUL21sQ2tWOEc3eXE4RVRoY2lkS3hYdFFLM0xURFJOYmNCbStRZjlE?=
 =?utf-8?B?KzhZS3Z5aFNOV0d0dFdIcFduUzZGNnJyZmh2a25XRlZxYWhWU2VXSzFwMEhE?=
 =?utf-8?B?OGtrb1MwSUtEUmJ3OXFRV0h4UFZOcU5GL2dRdDBJb3hwS2pEK1JuMDVXdzJj?=
 =?utf-8?B?UmV6akZuWC9qWDdHVGoySEdxemNBclVibkhhVnRWbGR5UlFCVkVsNDJ5aUhO?=
 =?utf-8?B?SVV2Uk00SWZFa0FtT0RWLzVhNEt3Y0pVWU1lMWVFNC9ZYkZzcjBSeDBuNUpS?=
 =?utf-8?B?UWJVRE9TcURuOXQwVzNyOHFvbG5zVjdaZzRXOXlpWGlRaGhkdHE3RmFXS2tU?=
 =?utf-8?B?WDVldU9vd0tSdis0M0hCODk4ekgzTTBjVzN0bGNEUEJjK0NHd3JtOTFVeXkr?=
 =?utf-8?B?TS96QjVCQUhORkNrUDNucUZERTlhRXp1alpzRTdxUCtZRFFZTS83aS9Hb3Vl?=
 =?utf-8?B?eUN2LzR5RFVIaEEzeVlSTTBKYVdxZ3B0cm1INlVpMGZMUUNDUUpEYXVRQW5O?=
 =?utf-8?B?Wk5YaVdBcFFDRmk1V0U4Y01TMTdrdFAxNWh1YlJkY0Z1ekJVbGFSanVhYktG?=
 =?utf-8?Q?X8LnJ4B9PHHI3HpxMbVaCXlJN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2712ceec-df37-4c85-8c69-08dbbaf64629
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 22:58:30.6918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUWsagyIVwkcfJwZF7t3+twh200qdkKFAigUaxVIoAW531sPVZcNdXELzwOOIQkzXxLoPAZrIg/V3eDSl1KmuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6988
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/23 19:51, Jeongtae Park wrote:
> ERROR: Macros with complex values should be enclosed in parentheses
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>

I think that goes against typical traceevent macros layout. I would ignore checkpatch warnings on traceevent stuff. 


> ---
>  drivers/cxl/core/trace.h | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 7aee7fb008a5..e2338773dcd6 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -199,17 +199,19 @@ TRACE_EVENT(cxl_overflow,
>  	__field(u8, hdr_maint_op_class)
>  
>  #define CXL_EVT_TP_fast_assign(cxlmd, l, hdr)					\
> -	__assign_str(memdev, dev_name(&(cxlmd)->dev));				\
> -	__assign_str(host, dev_name((cxlmd)->dev.parent));			\
> -	__entry->log = (l);							\
> -	__entry->serial = (cxlmd)->cxlds->serial;				\
> -	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
> -	__entry->hdr_length = (hdr).length;					\
> -	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> -	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> -	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> -	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> -	__entry->hdr_maint_op_class = (hdr).maint_op_class
> +	do {									\
> +	    __assign_str(memdev, dev_name(&(cxlmd)->dev));			\
> +	    __assign_str(host, dev_name((cxlmd)->dev.parent));			\
> +	    __entry->log = (l);							\
> +	    __entry->serial = (cxlmd)->cxlds->serial;				\
> +	    memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));		\
> +	    __entry->hdr_length = (hdr).length;					\
> +	    __entry->hdr_flags = get_unaligned_le24((hdr).flags);		\
> +	    __entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> +	    __entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> +	    __entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);		\
> +	    __entry->hdr_maint_op_class = (hdr).maint_op_class;			\
> +	} while (0)
>  
>  #define CXL_EVT_TP_printk(fmt, ...) \
>  	TP_printk("memdev=%s host=%s serial=%lld log=%s : time=%llu uuid=%pUb "	\
