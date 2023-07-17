Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2352975691A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGQQ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjGQQ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:29:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930E612E;
        Mon, 17 Jul 2023 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689611338; x=1721147338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OOO5T1w6aDFxDYetXs7QKLSXOOYpZQmyJwdtz3bPCGg=;
  b=TTv8NiRU4dP9v+MD8+++QaR2zt4XQJzuH8AhXETxZD7QOm7aq7dbVtE2
   VvCnXcIp42awYKOPGB30ZWg9yh+hJojRaVbH8mmCixYA1J2msbrqgfuWF
   7BYOGTl/Wm2cikS1F8uveNZdqrsv2tq/adcT+A2Mdx5hOHVGhLDEA1vVH
   ilCU7XI5P/tubCdPg9USEISqLhSnehFrfJsuJmzrxSJ2Y5nzZby3V7KJL
   D2SiECHlGgNm6kW/3dtGBxdunCaZHvJk1wK6ljPm+SXV7ft8z/35WXuLz
   xHJC7MUvowtZGRzex2J71itIiRSQD/MR5RD1YRBo3V9azH55f2g8NlDlz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="350837111"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="350837111"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 09:28:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="897262929"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="897262929"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2023 09:28:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 09:28:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 09:28:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 09:28:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 09:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nli8U9RG5XpvVpJrllsPmVjl8ibvzQkQxAOnmhi5/58VQ5eTDGDgBln7ZSrzffTPffiF3xjDXmsJr7ynngK44K6HA6H3rckyxpZisISlAskxvy1nkt6QhIXd3vhKAIn2Ualp2amzlJKq7p7W08CPoP5nUBDvyDrzEC3ZOiAuCtCpS3ZIIJykANtB4R04hT0sLbghXkczqq5ND+mxajppEiwhk1mZJhqsM8HDkrDmEqarWaSrGEwPEycTAkLGQQRjMHvcPxZUbZ98LYPUK8tBxm8/M7pHAo02wqP6EezeqR4U9DZKu1bPw+AFkg61bL67wgOz4+yzu0o6vL6zCPK9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfCbIiMhCnRsqGt4WalmAme6FfMElSfbv3fKHtKPCj0=;
 b=PG8XXCqxkp8Ugk8c0AQNl1uoBl/HgzGDRt+HwGGqmTkLjvu2wzssKk9dq7dx/LaKRGU256CzGZV57sLbXa3k/oCSyip5xq37rY1zTerZhCPhJ8qTDmJD2rDJGCijufGBQAshc5FTEkorUY/gE6rSTci0aXxDhJnT95cGXqAZzxvOnpSr8NlR7fw4xBNvX0bmoB+5h0TQCr2IuKpps83L5Za4qTwjq9ftDDHlJYXFCrOnYafFLpVGH7XQ8NwLWfp1Ed1CMXmlJycWK1pHLxiIhFvyzd8dmlTnREBAjgNuw4yjwh5Rn1qxJ6T2iG3RoLKKLpr3oDuhG8Qt+Nek0PQdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB7205.namprd11.prod.outlook.com (2603:10b6:8:113::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 16:28:51 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 16:28:51 +0000
Message-ID: <a607c370-030a-2b96-9aca-886a23248e83@intel.com>
Date:   Mon, 17 Jul 2023 09:28:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] cxl/acpi: Use printk specifier for resource
To:     Breno Leitao <leitao@debian.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <leit@meta.com>, kernel test robot <lkp@intel.com>,
        "open list:COMPUTE EXPRESS LINK (CXL)" <linux-cxl@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230717102625.4083462-1-leitao@debian.org>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230717102625.4083462-1-leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB7205:EE_
X-MS-Office365-Filtering-Correlation-Id: 69276b99-8c9a-48fd-2d53-08db86e2e78d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YBssLnUVw55isZ09eRajtevqSvyjT8k5lEKTCD9GLDqtfDYUwrh5PRZ/Iz+zp03dzN5m7kxCE9DPlWSphMbDSzNx9D2X7TQeDsUrKZs8lg1arcMyWgWh0x09Sc/IOb1q7W9QhrQzwfnT6dc2TUiHORPZCVevgOjNTI8Urp+cU1Bc1U1g95Wc1aIHV4bJG5tisfOvpxcqXYCRJVZCe5TZeygk339l1KS8T1wLN2D/p6Sm2F4OX+vFZE5rtj1rUp1DsW8hg23OzlU7+bAySHMBcxdBtow+ONkHwJse8cQbOzSwZa4CplTUhp0k7uBC5HwcIsFnZ9vNztOnCacz6xsldxiOpe56piM0d5AKrYQMLz0aqJuQpEbKLNiYQmmoCCwf/+WG6bnoww21j64nxUEM2JE1hNwCT7e9oVqejAxpSnjV40jicVw3WagpzGtUhB9wdwk3Jg/PezYG8E4CAK2mmUDjRHSZ/isfCyM//JGbXrqZxuRYlPtoGXIORDT7oWtRZpGlxy6yZ8MIFPasPlUVnQnsCKagv1KpbFCFM5hH1co5b+vrBCeSAUc1x+Ob2ji9W5NpbDCHsFTVcrsW0EPBvJ+tao7LpWGXyi0M0QzrxwpjknBKdRqZRgXsyeeUM7gen+wbPLmLokC+P4929vaNQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(31686004)(86362001)(31696002)(2906002)(36756003)(44832011)(6636002)(966005)(6512007)(2616005)(186003)(83380400001)(26005)(6506007)(53546011)(38100700002)(82960400001)(6486002)(54906003)(6666004)(110136005)(316002)(4326008)(66946007)(66476007)(66556008)(8936002)(478600001)(5660300002)(41300700001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU92SDkraU8vaHZ0NW9uQjBENkxQT2FPczNSbjRDUVc1VUcyUTVIWnhsMGx6?=
 =?utf-8?B?V0txWFlOQTV2eHhUUGlMQWFobndBMUw1Y0JvcGVYL1ZhQ1UrWmpnK0c2WGJH?=
 =?utf-8?B?ek9PbktsUTF0a3lkZktZMXNZa0xqempoUWhPeWhYcjhSNUVoVEkzQlNmaHZR?=
 =?utf-8?B?cHdZVTRoMHYrL0dQcVplc2FjNEt6cTNHWDdlV1VwZjNHU0MvM1QrVTFkajYv?=
 =?utf-8?B?Mjc0WWlwVjN1MDBhS05kQUV5VTlSZWhYaUZncC9aTTB4YmRyZi9LUUgwVzho?=
 =?utf-8?B?b09tM3ZpeXFKNFVBSnFORUJLVUp1YnB6cW1ZTmQrSW9sOFZZa1hGeWZMMHIx?=
 =?utf-8?B?OHZ6NnZkSyszSGhYV0EwNVRidzI4ZkZtSmIwZkNaZGpHK1A5THJ6cVVOT3I1?=
 =?utf-8?B?bUFhTzQxWk4zQ1RKekY0THpPd0s3TFQ5blllejQvT1pUV3RvaWI5cUtTYnY2?=
 =?utf-8?B?a1BqZytKZGxUTWV0UkZmL0MrUW1DZm1OckozTnZ1RkdwZWhmMWhIWERxOU1M?=
 =?utf-8?B?YS84Y2w3TThLOGE4dGxiQm84aHFMVTNoTWhFdXltVmZtSUpuUnE2TXJQNlVr?=
 =?utf-8?B?aTJmdnYrQW9heitIQXFTcmZCVk9VZUZTZXVwd3RwWkVac2xqajNQenZXdTNS?=
 =?utf-8?B?VlhUdVBUeVI2M3FOK0ZCeG1HUWMwN1NlSzBNMDhMS0x6VGdkU3VwWFM5Sm1F?=
 =?utf-8?B?cklraE15Z2NwaHE4NHZwSEd4KzNmR2VSS0YwZkU5dXZnNUJQL3d2ZWJocm9x?=
 =?utf-8?B?ZTQ1eVFpcXJQZW4wV1RwNGxmOFgzTlJyVmZiQnd5eU5YeWFGRUhnWlNkWXA2?=
 =?utf-8?B?WUlUeFpmMlJHeFVlTmlUTlhhK1VzeXRQRW1MZFVvdzdhMmZiZlQzMm9NeDVR?=
 =?utf-8?B?WXRrU0hiVTMwV1E2NFVKbUJmQ1BQOEI1YWJjaldsSUlPdE5WL3IwM0dCWk9n?=
 =?utf-8?B?REJrYXVuY2FyMjdrU2JraXpobGRaTkJ5QmlidGN5ZzV6aExQb0ZxOTA5YzZq?=
 =?utf-8?B?bnh6YnFKYzFtMXZ2VnlNWnF3bmlJMjh3VkpodWFWMnIyT3JidjlRWk1rZExL?=
 =?utf-8?B?U3VzVGhCd3V1NXEwT3JzUmtMc0NpWEF0dCtYUkdhWFhOZmJhSWxuRDBjczc3?=
 =?utf-8?B?UGF5cnpHZEhtTEhpZmZCcUVjMWpVOXhTWFdic2h4T1VyVUJxVDM0cFRTMmQ3?=
 =?utf-8?B?QTJ0dFBER3ZpZ1kyMzdMbXFwTTh5a0p5MUszWlJMRnR6UHg5RURSeHVhcWtW?=
 =?utf-8?B?dE9nSnNaWHdLNFRkbWYrL0Z6SFgxOTV4WTg0T08zbXI2dVRYNTFwWmtXREVU?=
 =?utf-8?B?SGFGY2F6SjJsT0pieG9SMnEveVQyY0dyMC9hZDZyZHY2SjlHSnpJMTBIdDdp?=
 =?utf-8?B?Q0xhNFRwSmtWY2dmNmZoblFjSDQ3ZTN6WUpEbzM5TGlSVUNXbEUzRFFjQ3cw?=
 =?utf-8?B?Q1VCWktKZ2FUMlpLVVlKOENQaGMrL0xKSEhTL2tlNGFyMm5tYmNtWjBmYWlY?=
 =?utf-8?B?ZXhlNUtPSkM1Skp4aHh4bjNpUU0rVTdTU0xaWWY4T3ZKZ05rQld1djNEK0k2?=
 =?utf-8?B?cy9GdWVXam10Zzc5VktNQXZOWHJPa2ZERXQzWksyMHh2WmJvYjk0a3F6cldD?=
 =?utf-8?B?QXovWDhwalMyM1FQRERLVE1kR0RDdkRnZ1JVSEpqQU53V0JzZWRNSmFHeTA3?=
 =?utf-8?B?WGRid3BDakNwVUdreGlGYmRNbU16cmdlUVhaTW94REJFeHJMYXNSUkRWdG1r?=
 =?utf-8?B?STRaa3lGN2tydzBYTUJHa1RxVW1CaVVLK3psTXNWdGRSMWpDU2hXREF4UStL?=
 =?utf-8?B?STlSaHFKMGdkQ2tPeUpPUXlLbXhpc0ZQNEVVV0JBOXk4c0Q4ZEZRR3hrNEdQ?=
 =?utf-8?B?cERTanFubm5XSmNrck1DRUFMbzRrdk9RNUpwSDBjb09OVGVJdUp5K3ZqSEd5?=
 =?utf-8?B?cHdiQ0pSN1llc2hVTHRsVlRma1RJRUlSaEtFTmV6c2FzMlV0U3FQQjdWTVJO?=
 =?utf-8?B?WDVqbG56VUhFNFZaeWk4OUV0Sy9wcnh2MW50L0t1Z2g0Q090NkFXSUJZbWY2?=
 =?utf-8?B?OXJHRjlRcHFpWkFpRzhwK3NkNFRSWE4vM2F4Y1cyZGREbVBmb1RqbDI2VU1r?=
 =?utf-8?Q?+gPq7LzhzNUUUtSrGACW2byd3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 69276b99-8c9a-48fd-2d53-08db86e2e78d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 16:28:51.0964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+R7RUzomMn9H0wHz66KLANgINh98Dim9F2kiBmicfjdYqMCQU33efU2kGtxvVgy6/rQVZGHv4CwySwNWcYtsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7205
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 03:26, Breno Leitao wrote:
> Commit 3840e10e8dca ("cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()")
> is using %llx to print resources pointers, but it is incorrect on 32-bits
> system, causing the following compilation warning on i386:
> 
> 	 drivers/cxl/acpi.c:300:4: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
> 
> Instead of using pointers to the resource, uses the proper printk
> specifier that knows how to handle the struct "resources".
> 
> This is the new format, being printed now:
> 
> 	Failed to add decode range: [mem 0x4080000000-0x2baffffffff flags 0x200]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202307151059.2vvBt55H-lkp@intel.com/
> Fixes: 3840e10e8dca ("cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/acpi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 815b43859c16..d1c559879dcc 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -296,8 +296,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>   	else
>   		rc = cxl_decoder_autoremove(dev, cxld);
>   	if (rc) {
> -		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
> -			res->start, res->end);
> +		dev_err(dev, "Failed to add decode range: %pr", res);
>   		return rc;
>   	}
>   	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
