Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D307AB3F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjIVOl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjIVOlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:41:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5BC1A2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695393693; x=1726929693;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ce76caRIrDisZgP/t8rdzNf2gf8jRagUJdML0ExLhlk=;
  b=MrWdjaB+/1GECchjFpawYWd7WkQ4ZQBzqwPibuyf+2BI0wX7c7GGuj68
   A6jC6g9wWXidOM8P9Zeod+m9ImP4Ehmqbv0lJuXZhGzm15nPfvAfLXqDK
   4YKKC830FGL2gD36APXrXe6lz0y1LCV+gLFnMw+riTDo/gWCBka1dxyxL
   bs3SlHycpbsAEzedMSUUZA59ufxb/d26/OoecFItkEKmFAbPZm9rXkkbg
   ZpGHL2RmalomINWxhTE5J95a2IXYeCdSbP3VHR+fBsuzmGoMWj+TFOTe/
   bEnkJZ4/nOG1iveRLYFrSMKCu4TamAPdHX9EZE4Ctqw0lf8mOkCvbwmEJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="360223146"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="360223146"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 07:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="750867148"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="750867148"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 07:41:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 07:41:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 07:41:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 07:41:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 07:41:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmRRE49k1Y5crFYvGW6whUalOTrvmRN6RfH82o8m2fINxSA/cHdrm5CGZUtGX7w/Zo+9W2W/k4LTyLb5OjRCMwYm/atpYNZSQ3uNldm5zUOp9SIfNua7NIz7ubjLTdPdm6NyyZYBId88bfrKHJUBhuRkSMuQYsbvSq67AxiJJgYxTwxhRknfSolA8zBweuFo04Ctl5Sub2Qk7593Wu5Fbx9bto1VghijJ8Fbva8VoRZEeLGltzdYxVkOKQHF4UbjJR/kOuKZu+N+rO/HPjqJu/JVzu8f7Zmf0bs0NAk2D3M2Y/SmLOT8ePRLttxDhDMki1j0UnnxXVFTBoQpeAF+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qegBJRKYGKVmfXdpGaxVHwiMccPsOBcCpFLUdzAzpR8=;
 b=j/0RO4fmCToKHtY1tQ3M48Xo44DmK4bDAo/ogetOOdym4IaLQkkl4WCaLKlSNj16mn6hWrElK6wWStSMkUt9+AHpmtH1c1HyMr11OqmdmO6g6TrEDwLPLYO/q1Q353VZztGn5vlN3k0c8HUifGaOR01Th3yCGeZG/tGqRiu64C54fHz400Z9b/AFtLBIctL9PwbnHshEwVMHtRtoQtKazBbsc6E3pFDGMRUbqzqPqoWLRHMdRvH1gOt4vY048ZCtZL83wcJhV6axgDwyBI0EyOdszBgDUx+TPBlFbVl9jTWqx5Ycsr++adyMfkiwtK482ni4hxKReKv1JLseJJcc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 14:41:29 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Fri, 22 Sep 2023
 14:41:29 +0000
Message-ID: <8a4a6e1f-accb-92c2-ae14-9f6945e97f7a@intel.com>
Date:   Fri, 22 Sep 2023 16:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 0/5] Implement MTE tag compression for swapped pages
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Potapenko <glider@google.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <pcc@google.com>,
        <andreyknvl@gmail.com>, <linux@rasmusvillemoes.dk>,
        <yury.norov@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <eugenis@google.com>,
        <syednwaris@gmail.com>, <william.gray@linaro.org>
References: <20230922080848.1261487-1-glider@google.com>
 <ZQ2mJ9rK7xNoMykL@smile.fi.intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <ZQ2mJ9rK7xNoMykL@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM4PR11MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 086a736a-ec92-4f36-77bb-08dbbb7a01bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MawD0qk49HIsnNEMRPgbW3DdXgGGXRFlIBFlj0VruCuaT1pymxLxOs0deJ9YYjXJohFB6iVlLnRBqgdDMoPTwlwvLx0cNyhUSpbe+QmnDa0XT53fPigvdOdy6RF7vBphz/OeoOTMvwR5GGyIMTSQ752A6ntIZVv0fFWtqxynG//+gsip+98z1NsI9Xg2FiLYur0+GevjNhNCpyOQRcBbf8DXQ57AwRnNL3EQKnDTxVxgL8OABG1mUHXGfS0l6jv6M4Ees2np3/1ADT5xY1zAPSunAQyJCEm1Yh+IyMMHniA2S9rzW02+zg32RWotbDVaQ2B7DHe6Ayc06+qvD8pv8uAtdI7hJUHxE5Yl7DRFdVNsQ3yRjvELfgbT4rYWs+D4fVD0Xp+G4nWY3moCnFRX3D2ca8seglo3uBgAFFI1Z160HAnO8b7yGB3AxPdt3tjTM+COqTt633Gm85BHC4ELEANd4jNQB4s6Xla6lr+IY3TCSMN3ivY4YXU0td7ZcXW78DkSX7AKhMM7t3zFpI9RYgryYefWaT8UGuFpzzwIM2pqOfz1Ohn3YaPtn8N58gtWMeNoYNNME3eXEf3AS4qgXdfGXZtAkjU8TLPLVJSCQ9e5m8mR9FUqO46jjRIPVN3Ce2tUANOOC2NFIQBkOi/+Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(8936002)(8676002)(31696002)(31686004)(86362001)(38100700002)(5660300002)(4326008)(66476007)(66556008)(66946007)(110136005)(316002)(36756003)(41300700001)(7416002)(2906002)(83380400001)(478600001)(6512007)(66899024)(26005)(2616005)(6506007)(82960400001)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yi9LeFBVVkpFY3djUFJGa1MrUjY3eGtoeXhERUVscS95N3NIQW9ZY2ZaVDVZ?=
 =?utf-8?B?amtiOTY3WjNTcXZpQi9RME9XT29TeWJPU2JDNVRSelVHY2lrUG82WUpQUzVi?=
 =?utf-8?B?NWl0QkNzU1dXSktDSENsWUEwaExHTnF4a1ltRGZqaGhzSjdhUmZ1M3BIU3Yy?=
 =?utf-8?B?WFNVLythOWtZWTRJdzZpeVR6QXVIYmREcVVhdktFaTE3QTZZREpJK2JQVlRP?=
 =?utf-8?B?YjdtbjF2V1NqbUxDdXlGUUZuVEIwditWeTRqTG9IQUtCMDJKTWhpT0dELzhP?=
 =?utf-8?B?R2xpVEtvTTFieUpidVF1V1JVcGlQOWlqTEdWMTNhaGtubmdXR1d2cXdicTFo?=
 =?utf-8?B?emdxMGlncytFRWZXV0I3bG5VczFka1owM1BnQVRBQ0Ftajhsb0lsbDZEWnBG?=
 =?utf-8?B?bUJGc29WWm5xSFBDK1JJV2dBd21XUzJTTStyblI1Lzc2OGxuSE50Tmlia1ZF?=
 =?utf-8?B?d0xseGNzcEhQeE5LRHNXaHZpWGNRMFV4UDF2RndnS0VUV3JpK0puSXRWcStx?=
 =?utf-8?B?Z0N5OVJaVHpqTSs1UzJQZ3F5aDNxK1NSUjNrTkpRckl2ajRTc1NwTUphWXE4?=
 =?utf-8?B?R1Bid3VBSHB4dTFvNFFNV09ZRjMydFJibFBMelVudGhrSTRxdHZ6UE84ZkZp?=
 =?utf-8?B?U2YvcHdzb2NpWjg5eUdzNjhLUFVvQkxUOHlkU0dOSUp3VlVNREh6ZUUydmhu?=
 =?utf-8?B?VzRJcGZ0MkVDTW1ycHBNcVlSTXdqeEgzQ2NpbSs4eEFRV1NRQ1psaFprYnRY?=
 =?utf-8?B?eTZZRzc3YitLQ0twMkdIQVFnT293QWdRRWIzRkNLOTY2bTFWWHpIckVFZmZQ?=
 =?utf-8?B?RUNpZEgyL3VibFR1SGdyVWh0MjRtT3Y2bDdaTE02YmswUER3SUR0WmovRSti?=
 =?utf-8?B?R0xrN3AzZnk3OHNTZkdLNmwzWWRsczhsTlBaelczVU5iNS9YY08yVksxNEoy?=
 =?utf-8?B?YktrRG50VHorT09NajUxS1VkOTgwQ0Yxb1l0RXY0S1JDdi9ld3hUMVdiall0?=
 =?utf-8?B?ejFRbjJ6VVZERGRsRUg2T252dFIzMGZGSnhvQ2hZd0Z5Mmpwc1BFeWoxY25n?=
 =?utf-8?B?b0VoSDkrdjNtNHIwNFVDNW9kc1dtOWNQZ0dVR0Q4SFdsRmtaTGFoR1c5UTBG?=
 =?utf-8?B?UzFHcVNyZVd0ZmE3WCtYNVNtdExFTlV0TTB2NUNObHdRM1BuSFV5aUVPcjFN?=
 =?utf-8?B?a3h0R2M3RHJ1SjArSVJVQmtoQ3lIaFNOQUs3VW9laWljUS9hN0Q4aXBEVnlR?=
 =?utf-8?B?V3hZbGlob1FqNElHKzFCaFR3SndJdTVseFNYekt4eUtqbTA5NEgvMnErWkR3?=
 =?utf-8?B?dnNMbEc5RDVmNzZjYzR0ZVR6dzRvbTR1bE41ZmJna2ZUSTNuWDlOOWRlRWRT?=
 =?utf-8?B?SDRhSzlFeXAxdVR1NldnVGdJRUdseUM5SzdrckZyYzkydTJNd3VKdmRvUFpa?=
 =?utf-8?B?OFVIWWZyZ0FlU1ZiRVRmb2psLytuWUphell5aWExMmtZT0xPSEV3Yk9ZVDlt?=
 =?utf-8?B?eHNHVUVMaGtLck9CcjlnQVBXdGxhTnRLa2xETWRML29YSVpLK2NLKzhpRXZa?=
 =?utf-8?B?djlxQWVsWjRPOXlTUTF5SkdEQlJzSlZ0NUlvS05lTmprSUE2UWpmanNqZkU2?=
 =?utf-8?B?VW5BVnpXd25UcFN1QnloWkdzaWJycndDbkloaVdqRC9jclBXVFNPYVF3OTht?=
 =?utf-8?B?Y3BzbUNwUkZ5QVN6U0pPd1BQeFZzcC9WN1NmSW45YTBDWENkOExreWpMSG5E?=
 =?utf-8?B?K3ZqTHA5U2MvTEhzQXBSVUtRUGhoNWZFNitxNWh4OVRQaitLc0pqZU1aQ3hx?=
 =?utf-8?B?S0d5cUpUWldJa3BLdE5CcnlKbUphTUVNVWJaZ3dIN21Xb3ZNRm1XWTRDcDY0?=
 =?utf-8?B?TTRPTy9kN0ZiNU5UUkRwakt0NmxPOXJLNU8zK01mWUVlSHd6OHZUZ2dyY21P?=
 =?utf-8?B?ZDVlNzJEbm1aSjFkMC83aytmaEhsK3kzb3g2UU5WQmtBWmsvNHUveDMvOUMx?=
 =?utf-8?B?UzNORmsvMEQzUWVnZ3RpY0JneUk0MUpGdGxCMW1SQlkzU1FDVnl5RlNVeEVx?=
 =?utf-8?B?SVhqRFhQRU42ZEdvTVZlOS9WdnlNb1YrVllHZjh6TitHQ2hNRDhLL2tsZHBz?=
 =?utf-8?B?M0V3emxTV3ZtM0tlVi81NFNuWnRXVHpRN3JNNU1DZWtvUEw4akx5Mkx2MjR4?=
 =?utf-8?Q?+HO4aHIfUcG0go5QkpysX6g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 086a736a-ec92-4f36-77bb-08dbbb7a01bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 14:41:29.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bcwW7Zk3yB9gSj8cf31eX7XHBjam4tYHuMMre8fol2rwi/kWJcPP2Hl7o5lBvvbeuq2if0zq1u9Xl9nChsaoHqLM4dq+gmrqRRP0cPV7pPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 22 Sep 2023 17:35:19 +0300

> +Cc: Olek, who internally is being developed something similar to your first
> patch here.

Oh, thanks.
The patch you mentioned properly implements cross-boundary accesses,
mine does not :D
But I guess we want to keep them both to keep the latter as optimized as
the current bitmap_{get,set}_value8()?

> 
> On Fri, Sep 22, 2023 at 10:08:42AM +0200, Alexander Potapenko wrote:
>> Currently, when MTE pages are swapped out, the tags are kept in the
>> memory, occupying PAGE_SIZE/32 bytes per page. This is especially
>> problematic for devices that use zram-backed in-memory swap, because
>> tags stored uncompressed in the heap effectively reduce the available
>> amount of swap memory.
>>
>> The RLE-based algorithm suggested by Evgenii Stepanov and implemented in
>> this patch series is able to efficiently compress fixed-size tag buffers,
>> resulting in practical compression ratio between 2.5x and 4x. In most
>> cases it is possible to store the compressed data in 63-bit Xarray values,
>> resulting in no extra memory allocations.
>>
>> Our measurements show that the proposed algorithm provides better
>> compression than existing kernel compression algorithms (LZ4, LZO,
>> LZ4HC, ZSTD) can offer.

[...]

Thanks,
Olek
