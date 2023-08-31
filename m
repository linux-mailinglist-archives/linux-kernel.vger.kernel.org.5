Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9210E78F613
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347868AbjHaXVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347861AbjHaXVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:21:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2057DE56;
        Thu, 31 Aug 2023 16:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693524057; x=1725060057;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nVwY3owFxZWFpmq91bjVxNX9Sy8kuWwgWNQsf4DpvWs=;
  b=QySyqY2S85P+fUNVLLcyknfOqMz/ylILLAbTEbhRoCSpaSkrk40BvyW+
   DNFKKQKRrdxTOk9phpAHY78ilom+oQW6y9yTOxWw6XNBgNSxRME55UgcJ
   MzFV7jS/wJp1N4t+3fze6T3w9gWVPF7K1zTnKqvfrERo6cMv4PnmKCwNg
   sxWzwnG2/1wqAQZmQNFl8yS1uirtWdPIbFRCiRaa92x0fD55X1AbSUw41
   U0OX6AhpIpjKcj1JPj0PnBOd+QEuPl8BmM1vfQ4aJllapP+BMBZp5dNe1
   lq6zlFGE6r++jFpjtcmcGqkF9BQ0ccCZ7O+YEgkzqfgHlr5t8DPeLQR/Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="373487726"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="373487726"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 16:20:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="733327328"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="733327328"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 16:20:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 16:20:55 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 16:20:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 16:20:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 16:20:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl99OgDR1lAXAW8jmFVhkEX6VlXnbW54fe0GOKfON9NSjHhPJS3vJhpbWA5t224pRE/tSGj3807Ug8KAEXIriZL1mqewzz2d2b9wt61I25jppxAoQvfHNJrvvngNW1IvRtBEjmaOfId40I3wu5jQwQsWa/Cpua3ZKCDKb29XwK1+C2Xxm/HTDMUzPe9qzjzh7VPsqJbW/MCIm0lughPlEtR4QaQ5q48UPmrIuzP8TuR6ZzTvbCuz5pHuB3cw36ETWElCn2cVTTouN5xPGIc/cOs/Jfg/37EiNbrrri0tsAv8JoukTGT1rfxFAIHwaZko3zqD/LwmXftaX49cicTMtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGqYpOA0k2sU0smTtZ6RlcRNoSpQFQumqpY3H3cCKUo=;
 b=OEuGRyGrBSsqOylslD1wu0IUY4JRpVUonxh/GhxdVvikGeHphC6sr8MbcNjxNW3UASOz7GYCUg6wwVKlWgRv+bm564XiDtkfpA8LRO9UtLnpubWhzRyP6JtqLvKD58INlxGEqlnho93Ino2l38AzQxQyKeIfDekzWTSkIT4oSMUT73XXUFOb+xtfgBBQRNjgUw7iNDq1DpiGOoPRMxDvyxJz56OKHy+LR2ZDfvxPoXw08AkhfMPAnKg3kd5EiJEpSAzUNaOJn7s8X0N4kAaKXNiv2zOxyxp8JksYZDUROqqBD7jBmjL1q4E2UdUUu1FL+mqfsN7qzUaG+amGsxx5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CYYPR11MB8407.namprd11.prod.outlook.com (2603:10b6:930:c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18; Thu, 31 Aug
 2023 23:20:52 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 23:20:52 +0000
Message-ID: <b5ae72a8-baf2-c92b-8174-394c51c33388@intel.com>
Date:   Thu, 31 Aug 2023 16:20:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH RFC v2 18/18] tools/testing/cxl: Add Dynamic Capacity
 events
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
 <20230604-dcd-type2-upstream-v2-18-f740c47e7916@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-18-f740c47e7916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:180::29) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CYYPR11MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: c43411bd-ffd7-405c-708e-08dbaa78eb2f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOfQQZBV1KN35VRvuWbnC1Miu34gJMQntZXI+HD0yFCNo5hspy8rbQdgDV4nsyeTsdyedFIkgU8WaIj0vBhdlg+tpgF8ZdPVVJaDVq6rKEHVqaVeukCVOrAw1reSOUuDjSBVOZjTV1dMnM2+u8jKAgLBzgfnScguQ6/0kAl5yaon5KtKnfGoNg2KMF+4Hv4Co31vLb/7Rn7iXKlxqndNNAUdJNwfTDjDE8/GN05H18CkmqoMCR8RZG8zMwn/YxFopQHSTgQxGqecZ+pvOQ1ki+XeOj60IBqu6rrpSkDWLCTgRVlXHdB93c/G70FoHb4Qb6GQfqnNMi/j23rxruuNKbeiSWk9ELiPTO0bvsyfBzgkLNUaeoSRBgB8gvSl7VEn0Zd+zfz/w5kd0AqNV7+2t09EbWIH+iBdfMT4ldEdgxgbbeW6E0X9tX7R/MYJhyxGTPvyVe4k5dxqglcO/CG493EHrj4YrQKKWuv1VUXCMWcAnyiQVvbXy9SVmBZhqmzx+FIFE6yifK7EAACIJai1bJzP1nOCcVoM706f78xKPyp/IJC02JiXwbXMhxUeWZ0I8929FIp+3MKMAq4eLouLFnd3eWwnJRCikB2RnanR5dVYYTE1XiPoOlf+RP+/o8ohc2dguuwGIVb7rzyeHMwh7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(186009)(1800799009)(451199024)(8936002)(6666004)(478600001)(110136005)(53546011)(31686004)(66946007)(66556008)(6506007)(6486002)(66476007)(54906003)(6636002)(316002)(38100700002)(41300700001)(82960400001)(6512007)(44832011)(26005)(83380400001)(5660300002)(36756003)(2616005)(2906002)(31696002)(86362001)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0NXY1Q0Sy9kc25mZndWYzdubWRaMVFFTzh5cFpwTVJsTU1CbW9tcTJzSzJz?=
 =?utf-8?B?enZHenVUd1hDVHhGcXV6S3JESktFNis5Qk80TjYrZStINWtpaXFmNVM4WEFB?=
 =?utf-8?B?MFlQYVRJZ3p6cTJRVlJTQmVsZmtRUmhqY3FRRXV6ZjNOMVZtWEVXUUFVajU2?=
 =?utf-8?B?VENUNGM3a2dtQXJTWHFWTlh3THB2OGZ4aHZlUnZrdU02QmxNNTBxZjdXT213?=
 =?utf-8?B?MW9JYXdsaEZTZk1PYnJHL082ZzVncWFYVlpzZWxwY0pBVHp6dkRKQ0RIblNL?=
 =?utf-8?B?em1EVUlsTWJrbnhFT1JvbWhXTi8vMWYxS1BBRFdUOUpMQk8yRldvWkd5QjBv?=
 =?utf-8?B?SEI5S211Q0VJYWZKN21BcitlMVVYOVVQUy9zUzVWbG1KT1loU3dwdGVvdGsx?=
 =?utf-8?B?ZVpWaXpnVWk2V2I5REp3SFZnTVk2bDNnNXFMZnNKM2FlMmRMVTMvcW5Mblg2?=
 =?utf-8?B?UWJNVkZQWi9wUTNiN1k0cjJxQmxhYXc4QzQrbEg5TDBna3I5WXlrZitzWHNI?=
 =?utf-8?B?bXhzZkdvWUxDU3dnSWh2bFM5SXNKQlF1SEhTSkFJcTVlMEx2ejBvUks4dEhC?=
 =?utf-8?B?UC9GaVQxV1cwQWwxNWN3ZVc2K0FMY2NFUjVZNDJaZnBzS3lSV3Rsd29yMW12?=
 =?utf-8?B?amgvODN1MWxOdm5tVUhMVllUVWNreUlVanhRZEJrSTZvVHRBdlFQTGdqNm0z?=
 =?utf-8?B?S3UwZE5mWGVBOERuM2dyY0pVUFQ3dERHeTJCL29heXhGWkNONTg3VEllZWtM?=
 =?utf-8?B?VnVmaDdxS1hpVCtWTytLanA5WlBkZ0FJR0dpY1k4RjQ4VW9ZTmtVZzNMbDNY?=
 =?utf-8?B?ZkFtdCtvZS9MSEJhMHlkejB2STdnTVZSdlVPblRCa2pBSU1OTk9icVNuMUxk?=
 =?utf-8?B?NmlqK3czcEo1a295V0FUQ0hzSEtna0lQZDVjYWs5c0I4cDJTWkNvTFlNb2ly?=
 =?utf-8?B?a1Q0MjA5T3pzVHVHTk1hM1VJWTRhNGE5Tmc4UjJGeGNMaUpIZzQxemtEOHZF?=
 =?utf-8?B?biswNitjU1Uxam8vQmVJTzJjWGU5UE5KTTRzSnB1cWVsaXdhbndoa2lrQ3F4?=
 =?utf-8?B?QmFZYnZCaW1CN0N2c1ppTW82eUdTdEF3dGJyL1ZIN3A4dENlT0lKNlhQdHZN?=
 =?utf-8?B?YjRMZkR5cmFmZi9uVkRoNmVpL3d3UDRGZTVDeisrVmNKd0prcUd2RU9IeGpq?=
 =?utf-8?B?SEgzRHV0dzA4OE02UkIrQkNMR2VYVlFKc3FTM2FOeUUwbnZsZENaQ1NFQTIx?=
 =?utf-8?B?MFNCYzVDZWhOZmJYMElNdmlNYjZscEhHNThlYklTbVpNTlljNWJCOWd1aThz?=
 =?utf-8?B?WitJTUpKOXJ1RUxwTkFDRWJRZWRSYm5ub0FkeVVycGpmclUxTmh1d3RremFq?=
 =?utf-8?B?ZmxBSm1Ga1I4TjRKeUN3SDhkYWcrckliYlFWWjZFaHowc294NHBZeDJKWDk5?=
 =?utf-8?B?emJzUm9Fd3lBdVoxN1pzOStOY3p6bS94dkFvclVtQ0xWVEFTeFV6NmplcVJW?=
 =?utf-8?B?SHdzWndOUmZaMXBUSlhkMHdIWTB0RnJ4YTQvTDJLMVRMSko2SllMeFBKMm5P?=
 =?utf-8?B?cEYyRW5mcUVxcFROMlhIZ3FmUzEyZXRDeFBVNlFDY1A2K2VRWWtLTmYrdWh5?=
 =?utf-8?B?OGxDVUNIMVZUckdLZVJwOTZ4UEFRZ0NjQ0NEa2p6UW5UN3lDaElLWFV1UGNR?=
 =?utf-8?B?bzNOT1hLa1FkZGdrWkczRGxMM3BLUnpybk9OWCtuaitiMnhvOER2R2NScW1o?=
 =?utf-8?B?b1dOR1lEWDNwbkhzRHVRQVBCeXdFRHR4cnkrYk4xMnZDTzNVdlNKbzhPM2d2?=
 =?utf-8?B?THdWZW91cWhoZ2lHWFp4WGVRdHcvU0ZmaW5teDJ3TXdVMFFHMFNDeVpHd2pO?=
 =?utf-8?B?UlBESW5YcmxqV3F3dG9HRXRtN0hHdTllRTR5WHRuSkhXL2FLZnRpVXM0SmtC?=
 =?utf-8?B?aVhVZ3BjTmltQ3dvMEVPQjlqSmxESE1jQmhHUTVWdUVRZkczcm1iSC9VQnVG?=
 =?utf-8?B?d1VEU3RDdnNMSEg1ZGJ0dGR6VjVMU21wbjZnT2lLb242RStJSVZnN0JQRkQ5?=
 =?utf-8?B?cVk2TnNReXV4dWdPN3hMbzdNeWloS0VQVDRQdGE1amZFYUxMZ3JidjRNaEdT?=
 =?utf-8?Q?khlQYClHr5npWc5dLY37ieMO5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c43411bd-ffd7-405c-708e-08dbaa78eb2f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 23:20:52.2706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvRpkMt/Spz/zv5WMGIxLnHkrUq7n95c4mWIc4awfSOIpXpFdcWpk/qec1aD7jHyrguXxUHFnldaVLJ/NBG23A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8407
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 22:21, Ira Weiny wrote:
> OS software needs to be alerted when new extents arrive on a Dynamic
> Capacity Device (DCD).  On test DCDs extents are added through sysfs.
> 
> Add events on DCD extent injection.  Directly call the event irq
> callback to simulate irqs to process the test extents.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/mem.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index d6041a2145c5..20364fee9df9 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -2008,6 +2008,41 @@ static bool new_extent_valid(struct device *dev, size_t new_start,
>   	return false;
>   }
>   
> +struct dcd_event_dyn_cap dcd_event_rec_template = {
> +	.hdr = {
> +		.id = UUID_INIT(0xca95afa7, 0xf183, 0x4018,
> +				0x8c, 0x2f, 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
> +		.length = sizeof(struct dcd_event_dyn_cap),
> +	},
> +};
> +
> +static int send_dc_event(struct mock_event_store *mes, enum dc_event type,
> +			 u64 start, u64 length, const char *tag_str)
> +{
> +	struct device *dev = mes->mds->cxlds.dev;
> +	struct dcd_event_dyn_cap *dcd_event_rec;
> +
> +	dcd_event_rec = devm_kzalloc(dev, sizeof(*dcd_event_rec), GFP_KERNEL);
> +	if (!dcd_event_rec)
> +		return -ENOMEM;
> +
> +	memcpy(dcd_event_rec, &dcd_event_rec_template, sizeof(*dcd_event_rec));
> +	dcd_event_rec->data.event_type = type;
> +	dcd_event_rec->data.extent.start_dpa = cpu_to_le64(start);
> +	dcd_event_rec->data.extent.length = cpu_to_le64(length);
> +	memcpy(dcd_event_rec->data.extent.tag, tag_str,
> +	       min(sizeof(dcd_event_rec->data.extent.tag),
> +		   strlen(tag_str)));
> +
> +	mes_add_event(mes, CXL_EVENT_TYPE_DCD,
> +		      (struct cxl_event_record_raw *)dcd_event_rec);
> +
> +	/* Fake the irq */
> +	cxl_mem_get_event_records(mes->mds, CXLDEV_EVENT_STATUS_DCD);
> +
> +	return 0;
> +}
> +
>   /*
>    * Format <start>:<length>:<tag>
>    *
> @@ -2021,6 +2056,7 @@ static ssize_t dc_inject_extent_store(struct device *dev,
>   				      const char *buf, size_t count)
>   {
>   	char *start_str __free(kfree) = kstrdup(buf, GFP_KERNEL);
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
>   	unsigned long long start, length;
>   	char *len_str, *tag_str;
>   	size_t buf_len = count;
> @@ -2063,6 +2099,13 @@ static ssize_t dc_inject_extent_store(struct device *dev,
>   	if (rc)
>   		return rc;
>   
> +	rc = send_dc_event(&mdata->mes, DCD_ADD_CAPACITY, start, length,
> +			   tag_str);
> +	if (rc) {
> +		dev_err(dev, "Failed to add event %d\n", rc);
> +		return rc;
> +	}
> +
>   	return count;
>   }
>   static DEVICE_ATTR_WO(dc_inject_extent);
> @@ -2071,6 +2114,7 @@ static ssize_t dc_del_extent_store(struct device *dev,
>   				   struct device_attribute *attr,
>   				   const char *buf, size_t count)
>   {
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
>   	unsigned long long start;
>   	int rc;
>   
> @@ -2083,6 +2127,12 @@ static ssize_t dc_del_extent_store(struct device *dev,
>   	if (rc)
>   		return rc;
>   
> +	rc = send_dc_event(&mdata->mes, DCD_RELEASE_CAPACITY, start, 0, "");
> +	if (rc) {
> +		dev_err(dev, "Failed to add event %d\n", rc);
> +		return rc;
> +	}
> +
>   	return count;
>   }
>   static DEVICE_ATTR_WO(dc_del_extent);
> @@ -2111,6 +2161,13 @@ static ssize_t dc_force_del_extent_store(struct device *dev,
>   	if (rc)
>   		return rc;
>   
> +	rc = send_dc_event(&mdata->mes, DCD_FORCED_CAPACITY_RELEASE,
> +			      start, 0, "");
> +	if (rc) {
> +		dev_err(dev, "Failed to add event %d\n", rc);
> +		return rc;
> +	}
> +
>   	return count;
>   }
>   static DEVICE_ATTR_WO(dc_force_del_extent);
> 
