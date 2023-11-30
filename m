Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3F07FF4B3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbjK3QV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjK3QVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:21:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F901FF7;
        Thu, 30 Nov 2023 08:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701361212; x=1732897212;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sAe4K0Guid47zXrDUSAuZGMQ4siBE/vILl1rJlTx0To=;
  b=cEGCk17gKeUyw92EWK08aFIEhX/wWpU8tgKE1wkwKJf0OKIIkmY6Lj8O
   aEaKEuddJbHtUaEY6MRI7k9yS4IRXCUbfFOl3d3nJklMROGJfVCG7DLQZ
   r3uj8Cc66kUCJtDv9b+K4YL2gRf+41NO4nDFW6d6HcS6yB/dSprdOFndu
   cepmw0Gdn0WYFt7ztsIbl3HdZz7MhaUW2dtlYSREFrp6wmPHQCaBxabBK
   R35cV3l8HCdJWJYfjJgWVPBOZ8/5Wp4sMma6Jvv//yfQ/0SmTF8YEyP+S
   GVONvQXyy8lr8EZ8HbuAeW0jrsyEvmxNaDKhfZr/tCqcoMwPzsxbiXonf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="6624311"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="6624311"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 08:20:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="773103202"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="773103202"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Nov 2023 08:20:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 08:20:10 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 30 Nov 2023 08:20:10 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 08:20:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 30 Nov 2023 08:20:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3lO4ISFnJeMJYB8E5xrlESD1GjVLVBQ4RhPbqOgB4gXcLqHkO5JZYn8OzvWQGeGSXGdt8jqo6hxaF6Wne2QSdK6laDcrPPjE/ZnB1FywdQY5VybOAd6W+1sdrYlN+pWa6Q53EJMhTwSevuXSBAMlMCh5UF3T16xOo2OXZzAoqYkeouzzMoMc+LxXalwqwxl4SLlNEDRP+VMpgDk/Se3E5uNZI75i9Xx6zMUjNKQhVDipIjnbndMSnGunIxEvAVN5U7ZX+aCp/DJ1FGCzRbVV3uNR1TytRQAT+etAXi4hF2w9l9Jq1/gbtdw515HGycXZKhgxvJwQCIuD0cXISiTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6CE5yJ2HhmduXaM7QaZJbQFGxqWG9LWEuCpzl1n9IY=;
 b=Zr7Z8X3UMDQ1D5EbVUL10JTu2tvNGM+AkBr8vGoTz9eDWSxSTrkLbizg2oyiHcgsF8aZbwnIjUQRG7Dm79FINMjH8vvdBdGJ5oh3sYYVyWAxqcdOzhW+1GeGdWRdTe4pfpiKsgSuWjSB5qwz1U+m4B9FXvRPMtY0DdGdRGp227pfxSARaZRbimWL05RXr7vfwEBrOBI46NudWZ6Axa7MZUjzKZ+58hbK8xad5O7G4e4bqa7Yd9cpjQNCXtT3Qq884+kHFCByfANJfdSds4ZCoq0PBu/ichoS+BOMebqOt3E9faitudKflADOeYcovK9u7llLiqjMycu87v204/69KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 16:20:07 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 16:20:07 +0000
Message-ID: <c881f759-617b-4349-b207-934b4c72a1ac@intel.com>
Date:   Thu, 30 Nov 2023 09:20:04 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2 2/2] cxl/cdat: Fix header sum value in CDAT checksum
To:     Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Fan Ni <nifan.cxl@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Huai-Cheng Kuo" <hchkuo@avery-design.com.tw>
References: <20231117-fix-cdat-cs-v2-0-715399976d4d@intel.com>
 <20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231117-fix-cdat-cs-v2-2-715399976d4d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0064.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::9) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f81e2ea-e5bd-40ee-7088-08dbf1c03782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fcf5qa+/lwq/qEGzboQml9vlT/CJWY3XhwelmNdfxVYgNlsCyZ5yGm4HdgxMNXSd3B/WzT7YhKfxAIIWBFTbP21fbN5o3HD29w8Fh36eWeJXBF9RQAvRecLR5O+4mcS2yH1T91DTGZf0FoDtSi69wLKAyCbqFwmI90D/K8/Dw/sZ/aBh7E3EiMw5QqQ+gfFpgtVe3FHOd5noYkhy96eT+9rqFqWtsNxdQlguGWAnxXNoaSf6v3RiOogstP5uuQV3UydTRMyN6aB3+2XJuDuM7FI76VPTiDbGQb46BfeFn1fErugcMyZIiNRRM9PsbTCErEeW8UP7ycgYLCVOMTARR3rIgYdFah0wZcdXOpXazEldiLhcACFBrpDG7jXgTxMyBJKlVM1idgo8MH55VT8JWuFYschNOqf2g2G7TWSEV37SNrf+Ch3nCEnFcTDbWbmeZE8OPkW5UDl57c6TJ5cEyjjgPsMCSknl1e5exwm9IfoD8uQvjz66Z+LIdmp1hnDAw91aquadgbuRoXa/Ez7AgrXGP9e/fOvlnSzNpvUyKKyOV1GUP/4VvTVN7q88YiFOBITUmzvsPBPhoHMUJb6FzrRpktzuXN3555exUZpDhio=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6666004)(6486002)(6506007)(6512007)(53546011)(31696002)(44832011)(8676002)(36756003)(5660300002)(82960400001)(966005)(8936002)(41300700001)(478600001)(31686004)(2616005)(66946007)(66556008)(316002)(66476007)(110136005)(4326008)(38100700002)(86362001)(26005)(2906002)(83380400001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjVNTERadGhjR1BuYUhoVEFWRU1jNjJ3MjdxdFI2SFVSQ3pJZGpQV0ZwYjdL?=
 =?utf-8?B?YXkyclkweTVrME4wSHZHV1ZQSWxBV0c4UXVXWlM0S1kzallHeHVaaXhaMGFR?=
 =?utf-8?B?dENuTWNxV3RFNnVYbVNRckZJbys3VVJBZzhTV2kzU0duZFdWVDZYNzgrMGly?=
 =?utf-8?B?dzAySmV5N2x4L1RPR1E0b1FmYm1mcTJpTWkzYWcxUllodU5CZE42aXpiRjJT?=
 =?utf-8?B?YlBwMmg4MGljbTluS2JCaHRHQUx6dVI1dUw2bmdIMit4UjFEK2U5STFpMzdm?=
 =?utf-8?B?eXlsSzZKb1RDTTFvajVLTUxIUGVObitNZ0pPWGdmTG8yY2E0Z0JKT3lOR29X?=
 =?utf-8?B?TXVUNlA5SC9YTnlYd21oUHkwTTU1VkRqT1hxWW9ISWNVRjNpNDJyR3lwbFNB?=
 =?utf-8?B?eCtsL1lrZTJ4eTNVbHVac1c0YllNTlZxNUtyU0dEWWdGem9CTGFwMFVNTE1M?=
 =?utf-8?B?N2hhTXQ0bzRPZEwwKzhjRzQ3WlpzQ0FvR3pvZXdLeW5jRUNDcksrWG03RzVW?=
 =?utf-8?B?N3VqOVkvZHN0NGxtNTRyb3UvRFRTVnExU1ZsTklUM0RPUnVSTm93ZWZEYkZC?=
 =?utf-8?B?V283SXUvSjFvTFBxSklsTTFJdWV6UHhDMExiTkt4RGlNT0lneUozdkRLS01P?=
 =?utf-8?B?WUNmbHVta2JwR3N2eldyaGp4cUV2WlpKYUg3V1FUeDJTZ2JRRC9tZlhKK1ZL?=
 =?utf-8?B?MXZlUWRGc3lNeSsraFVwU0NnRlp6WGpzMTlHK3RxM0lMdjVsZlNRNTlRa3Ew?=
 =?utf-8?B?VzU0NENPS0U4T2ZudWFaWDFvMU9xVWFvelRMcDkzNFh1T0xFV2tpOVJ3bWlE?=
 =?utf-8?B?S21kRlZvREROTlFITkpxS0FWcmVsSURObnY3SUhpU3lEcldwNDZXZytzSWVz?=
 =?utf-8?B?bGZYeFc0QzdEQ0swWVFuQkV2c2pqZGVrelo2TTdhVk9MYk91L1N6Sm1BSXJG?=
 =?utf-8?B?YjdQVndISkpMN0lMWG5acGxYeVlJeFkzSWErczNNeG5vcWFtdWgwL2RsZm9I?=
 =?utf-8?B?MHBEYzZtWERNM0kwWS9WSXpYNW5oSk5aNkp4cU5OTUttNytzckdQQkFaRnRo?=
 =?utf-8?B?YlJYT2hWK2tBaFNSSGN0U0dQTHU1ZzJuSEx2bnBzRzg1WkV3ME1aYytHYXBy?=
 =?utf-8?B?T2d6UHNMSkVVTUltdFVWZUtJSU5MQWp3TmN0dFRsK1pBc0pyYkNRK0FZV2h1?=
 =?utf-8?B?WEZMWWk3VEhaMm1jSE1nVEVyR084MzJQeXVwYTdFODRHMjBHU3V3cjRiVU5q?=
 =?utf-8?B?U2UzVDdYeE05Y3lidGp4UDJWVDBkd3Q4bVA3WFVSNW5kK0ZlNTNLQStobHlh?=
 =?utf-8?B?c1JvTVF6T1p5SHBsL3VWRE5nNkkrZ2haRWpRdEVDbElZdGZxSmF1c1pXL0Vl?=
 =?utf-8?B?cHZIUGNrY29EQ0kvZVY0YjBUYU0zSWlVa0xDL0V2bzFVQmE3a0VIcmFSall3?=
 =?utf-8?B?NUJiRyt1c09TME0yUWthVzdrQngxSXlMUDhTVnFGaHQ2TWE2YXRyNThwcEtV?=
 =?utf-8?B?OXJ4SUNCWWpVZW5LYXB5N2t5Tm1TR0ZYS2pjODliSElvK1VOaEFBRFRoUEVw?=
 =?utf-8?B?L2l0cWs4WWZ6Qmp4U1dJaTJWei9iaDhJYTZQTDJ5MnRMOHV0L1A2VDh3M3Bk?=
 =?utf-8?B?Q1FpelNJMnBZMlhrdS95amZqa2VVSFdrKzMwVG51cGhTbTRDV0pXYTVVaHRv?=
 =?utf-8?B?RWNEZ2xNOVZpS3pxaGxwQm4xb3A2R3VWOFNLQXdkK1VwVkE1TVJURzFQVGFi?=
 =?utf-8?B?OWpoWVQxZzZtdTBZYW1QVy9Ua1M5d1B5d3NWUWVEVDFqVjRGbHU2ZUlFYlpH?=
 =?utf-8?B?dHJkc1dVYk9aOVRZbk9CdDhBMjJpZFFDbndvalhCbThYdElCVkg5OVJVQWM4?=
 =?utf-8?B?M2Z2UTM0N1lzODFaeitwbzNtKzU4VnZ2NTJPdVViS3lQcUZHMDBIODlVek5B?=
 =?utf-8?B?R1orbkkzcXJ1OGQwcVJMY283d3dXMjBRZ3AzRjRoSkZpQU5vMFBYZkVUVzhO?=
 =?utf-8?B?TGltcU1EY1VkUExYbWk2bzFGK0Y0alMwVTZMeWYvc1YwdGcvRFE1WE51SmZ0?=
 =?utf-8?B?czRSSWVpWVlzb0JaZCtFSVpsOERFRU94d0pWVzZwUllVZHRDaURWRnJhUUE5?=
 =?utf-8?Q?p71ftnxm+OMvrt+9fNkcVcOQ+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f81e2ea-e5bd-40ee-7088-08dbf1c03782
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 16:20:07.2478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x76P26HU/A06na9SbIGrcMc7C+QPK/7OinS7RKSOuM90ACxg5RV7Mvx2IDs30h99PsnrI4q+lzDmfr3MUvdUMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/23 18:33, Ira Weiny wrote:
> The addition of the DCD support for CXL type-3 devices extended the CDAT
> table large enough that the checksum being returned was incorrect.[1]
> 
> This was because the checksum value was using the header length field
> rather than each of the 4 bytes of the length field.  This was
> previously not seen because the length of the CDAT data was less than
> 256 thus resulting in an equivalent checksum value.
> 
> Properly calculate the checksum for the CDAT header.
> 
> [1] https://lore.kernel.org/all/20231116-fix-cdat-devm-free-v1-1-b148b40707d7@intel.com/
> 
> Fixes: aba578bdace5 ("hw/cxl/cdat: CXL CDAT Data Object Exchange implementation")
> Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Def more future proof if they introduce new fields in later versions of the table.

> 
> ---
> Changes from V1:
> [djiang: Remove do {} while (0);]
> ---
>  hw/cxl/cxl-cdat.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index 24829cf2428d..67e44a4f992a 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -49,6 +49,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>      g_autofree CDATTableHeader *cdat_header = NULL;
>      g_autofree CDATEntry *cdat_st = NULL;
>      uint8_t sum = 0;
> +    uint8_t *buf;
>      int ent, i;
>  
>      /* Use default table if fopen == NULL */
> @@ -95,8 +96,12 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>      /* For now, no runtime updates */
>      cdat_header->sequence = 0;
>      cdat_header->length += sizeof(CDATTableHeader);
> -    sum += cdat_header->revision + cdat_header->sequence +
> -        cdat_header->length;
> +
> +    buf = (uint8_t *)cdat_header;
> +    for (i = 0; i < sizeof(*cdat_header); i++) {
> +        sum += buf[i];
> +    }
> +
>      /* Sum of all bytes including checksum must be 0 */
>      cdat_header->checksum = ~sum + 1;
>  
> 
