Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E127AB8CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbjIVSEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjIVSEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:04:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A823599;
        Fri, 22 Sep 2023 11:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695405853; x=1726941853;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lkwRXPfFEOXA2PeZL6j94X+s5ukYfAuyGyGIdFeb9b0=;
  b=ADVfzXQP+P7ClLuWkLohVzQ0B2UlwI7Mk+c2QHkI5n9HJShn/vbJCwPd
   g/PfIgkEveJ4bObWK7/4Nn6N5W8nG3KgxIFF3gH3+Jv+sRBoP1Sf77ABg
   QBjOMZ3NzifFZlCrvlPKOslKxJVa+pP0qlvAwb2w/zptsPx2Ihr2PjlEi
   3yp4Rdcf5qjhn+siGHWmnnViVIAZSe9SRgD6KxuRcQto2hXHO+TYAiRv6
   c5DWOJvhscQLRcJXIx6dd/2GWullXBK9xAZrQDBgXbBYt0BlYeWjBUtSs
   snSfsdoxYiI4TDpKzNkC2cVO4H5ol/CeCv7arQC/cNDkDnhxr0l53glWp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="371222047"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="371222047"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 11:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="921262987"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="921262987"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 11:04:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 11:04:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 11:04:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 11:04:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoQCuwL0f+xxYpO9ZT+pMoi9LvMr+zPBG9CLfBTycx01N+2sNZNbMnCJtyBukAmvzZlQPErpEqi8Sps5HhhnghHjQvimjqkZ1D++ub0hCkyN2S23WmfhVjnhQ3qACshtmLP2slXyEwlV74UquNkOhdy2itEtAa0XcrG1ySwL6ntU0Z4imO+ZcdV9u9YMzVcltFjHSA/R+hpiDahp+xRw1efb7N52ysXjTeEF57SA9IRUSY6oeh04m2gNVOEH4CzoI/Xs8IA5N/NuQZ2wuuWq4koh9xJ5iSDmC28XksjSD8Y3/E1hzcY6zU+U/fU4GqesiEjUhnD3vZykVX4K4oZDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVxeWFbjembTnnTm4nzVAjsws5Jd8SYCFWBdkWwGdEY=;
 b=ShFbz4xfP7ocRXfgMGVUdMfoHon/OZ1m3hTLlmPN4QCAXOuPIh2Y+ivpZaTgjSQc10vWrWQieiIGwLevx8bEhPKaoGhNa4+HV4QvHO3mMEmzNSGUYsDVzRaOXZ9nAtdq1VktGIH0mzgy4GtJAtN+ruEo+pOvsPMsy1DqibDfHOrTvZw42/Cxc7fQa/nuEZRhI7Rxp1HthvjEJaRlF3epxWNtC5NxfPji6S1DYrYmeysevWdP5EqcX8f2wg6kQHEWc64eMOBZnD+0AXt0sHP8qq/6WpPiPUuzGSwwEHNhVYIhhPUahA4/+WehWLrLgAcR/QG59sx6NK6q7yaGfQE/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA0PR11MB4544.namprd11.prod.outlook.com (2603:10b6:806:92::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 18:04:09 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 18:04:09 +0000
Message-ID: <e5f86461-fc67-d109-229c-b9d3fefd263a@intel.com>
Date:   Fri, 22 Sep 2023 11:04:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] libnvdimm: Annotate struct nd_region with __counted_by
To:     Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>, <linux-hardening@vger.kernel.org>
References: <20230922175238.work.116-kees@kernel.org>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230922175238.work.116-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:a03:338::12) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA0PR11MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 617dee4f-195d-456f-ab17-08dbbb965196
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3LhqfBGClSiqwOwh33md/KKTjSwtcPni1GWcd0P/ccgCsQmroRRVObQU5xXyLOCnx/ihqyqF35vBgnzgKYMQaOIMFQGAZNVMbnDda/PfYOSVTaN8AkBsPQNzzTesv++j22cvqc7mGy+Pv5m0KXhG/m9thsz3hDF+bLFYZWCxZ1LB/ydLh4YV71z8Xjf4kl2b6aF0mlB0C1Z+GgX2AFnISWRT9MreltWcG1lrMUkeACauyiGJhAqNj6uV6uvKdQBKmu8gdLZj4imnD9Xb4N6aMVktc3GO6kdW7y1Rpgwfv1jYWw+ee0rV9dno5KrnJf+IEttBEYMmWD03UJ2zr3Ni7Evb/VRO7PupX2pHaRnUicUeic8sWX5Rd5qsTm7UrHbm3KeRAi34ym38+yKARl48qVJg1xmhbSWP0XD+UFyC+1KF91LU2Xm44RV4AdP5s5+KBWf48eLsq8MxF0yRpxsZGousRuWI3o/LuUK+iAg3hfGhqA3YM978Bdf2uuKQx29N1N6LBXkyotexZfP2cWDbCl3gufCvPjI2VOZ7zGcK55gLqHNhfAVoqkQ4yI3152d4QDcqFYQXgshckB9LkDYM1MNsmiOUjO//uoFp+hKmRsJtqlm8F6hNIq5xROmjkDKS4Cykxy06QEdJDRNi0kemTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199024)(186009)(1800799009)(82960400001)(31686004)(53546011)(6512007)(6666004)(6506007)(6486002)(31696002)(86362001)(36756003)(38100700002)(83380400001)(2616005)(44832011)(2906002)(26005)(966005)(478600001)(66476007)(8676002)(5660300002)(4326008)(66556008)(41300700001)(110136005)(66946007)(8936002)(6636002)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnVRTVBFdEhCa21pcUtEQVJsQWI3SUN1M1pyblltNDYrZURYcmwraHZ3YlFQ?=
 =?utf-8?B?THlvemxzcms5cWNwalF3ZWxHQWE2QjZ1VGl0TXlQMVJJelpQL1FHTnlaellq?=
 =?utf-8?B?VDBvL0tiMTBFSW1qOGhXd1d3UWk3S21mKzl3bnNGWmVHb2Ric002S3pGYkts?=
 =?utf-8?B?YVdrd1h3cS8wa0psTnhhdmJIaDZkeFVidXBDOURKUWZJNDRJU3ltWlcrOFFH?=
 =?utf-8?B?S3FmamNxbWNwbnhvYWROZ1FhOEZLcmNKbHQ5OFZsSHVrSTRHbXgyVVFwWmhS?=
 =?utf-8?B?WXE0Ky95Y2VpdUU2a0JnaU1wSTl3Mk9oVFpUSyt3ai9USzVZU3MrUG1uaHNw?=
 =?utf-8?B?OE5KZWg3eG9ndHplK3htVEdTZ0hDYjNabnd0SVRqR2RNdjhDUEhKNDNhNmF5?=
 =?utf-8?B?THlPakNKTHJ4ZFMvWlhva0VQeU52bzVDNWUyTm1CZTNjbllpWHM2bDNyazdy?=
 =?utf-8?B?eHBmYzB6VUo5RFBuSGk3Z0llQ2JCWlZ1M011em1oc2RMcDRVOUtpYXBvTk9W?=
 =?utf-8?B?dGZodGdpOGFiM2pFRjZLRjZjZmhTWTNla00zSUUra2VGZ0tPTEphVjNvQzVt?=
 =?utf-8?B?WjFyOXRobDRTbkZrUU5qczFkOE50WUpvalJxdjlHVnJsaGp6NlNCTWcvTW5l?=
 =?utf-8?B?VVQ1SnBRQndxcjVhK0NVM1JOL3gwSlEvdlBUeEdTU0tXaDArTnBPSlVKYnNG?=
 =?utf-8?B?VWFCbVBsZm00Z3dPbFBvRzkzaWNwMGpvNjlQVmRXOHFYUGNYRTFwSkpPRG5R?=
 =?utf-8?B?WHFoWVUwdnladUdQMUpuWGQzbFRkMjRVWGNja0Fva2I3V1ZtWXdoK3Q3REY3?=
 =?utf-8?B?cEthTy9jQlNSMkMwbHVxQWFYbyt3dDdoOE9YNmEvR2hJalo1S1FSVmdDQnMr?=
 =?utf-8?B?aGpZQnJqbC96MEtDWllmQ2thYW1lOS92VHMyMktncjdXdTJiaFhjVmdsam5v?=
 =?utf-8?B?SmdWRUpEZm83RG50UWxpZTlhb1Y1KzFsOWd4elFnYVJJUi9jN0JWOXpETjZo?=
 =?utf-8?B?Zk1VY2pjY3I1OEVkVW9XOGFqajhHK1duRzVBbWpSQndINUFGeHhtcVhIN2Fh?=
 =?utf-8?B?SUxhc3FwNDFMQXdrenVzdzFTTkZlL3o0dHo2cS9ZcVBtQmZYRENncUNnOHNo?=
 =?utf-8?B?b29EenBZQUdKeGdyaEMxZnlKb3FEZGxFb1JHKzBzbzlEayt4ZlAwVU9PSCsv?=
 =?utf-8?B?QTBPbTBYRFFNSzZoVXh4aVJWWTRXa1JHZUUwWU5oWVJTMVRacldTbU1TRzNh?=
 =?utf-8?B?NXl1bWVBSmp6U1BIVWliOG9QNnkwWWJKVktYTFprRW0wTW44Qko5NzgyYnBa?=
 =?utf-8?B?eHpEUXlUalNNZkk4eGlRRUZadzN4Q0ZTZjhVMFRTSUw3ckxvN2VVZ3IrU01D?=
 =?utf-8?B?ZkpuZlFRclpDWDlkdjdJYlRTU3RJQkdQOGdlVTBDWms2QnZzbXdxMXBOenlH?=
 =?utf-8?B?eGxrOCt2QktLRWxLTE1VeDFQM0krNXFVWXdoOS9sWGpIeTR3NWlNZTdKc0FM?=
 =?utf-8?B?cVNwT3QwbGxoMFhRKytGTjNZVDJpK1VtMlhhNmlPTHJxTmZuOE5mLzR6Wjc0?=
 =?utf-8?B?MVpjZzk5Wlc0dE13RngvbVgzckUweDFEMmJRTFZtV1RKbUNXMUlhZzBrNHI4?=
 =?utf-8?B?alJ3OTNBbGZqb0I0RlZlQkIvQzFwd3NPSUJDU2YxUzMrUGpqczVoK01rMUtr?=
 =?utf-8?B?ZWIydlJoU2ZTQXFXdkhSU0ZjbWN4b2dSbTdPaHI0T2JXOThJU2ttNzE0OW9I?=
 =?utf-8?B?Vjg1Vk9FZWZKOU1CZTJjbjlLYTRsYTVrMThLRUNwYUtnZ0hvNVJaTWpDZU9n?=
 =?utf-8?B?WVRaNTdpckgyUkViNEFNV1Y4ZU8wODF1STJrNHhLM0dWOEtDMWhuL0ZubmhK?=
 =?utf-8?B?b1REeThiS0VKaWZvWkNLZDExQVEzbm9GL3V6WEliczhYamtVM0xPR2pIamVE?=
 =?utf-8?B?OThGVm1pdE50eXh3MXNqOXZHd3c1bjIvWGRmR3M3aFI1TUtacDFIU29RUDVZ?=
 =?utf-8?B?b2o5Qzd3a2VRaUV0VkFDdS9SOUdEcHdTTlB0VUtWb25Sc3FhZHlXM1NOZzlK?=
 =?utf-8?B?RkJ3aGk0bUE3bzhjTlZ6Mit1UENyZGtjMWdxMFBwakVlbTBES2lLNnN5clRr?=
 =?utf-8?Q?dC3/FTZPXdWJqlOIWLKlllGrv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 617dee4f-195d-456f-ab17-08dbbb965196
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 18:04:09.5075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ohOn2Axh0hShH0FLctfSvNUA+fcFEyv5MWKw67o8SeC1mfY/fQdTvAnCcq+FhkVGdWIm/dAGmuRAgMgnE2sDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4544
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 10:52, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct nd_region.
> Additionally, since the element count member must be set before accessing
> the annotated flexible array member, move its initialization earlier.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: nvdimm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/nvdimm/nd.h          | 2 +-
>  drivers/nvdimm/region_devs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index e8b9d27dbb3c..ae2078eb6a62 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -422,7 +422,7 @@ struct nd_region {
>  	struct nd_interleave_set *nd_set;
>  	struct nd_percpu_lane __percpu *lane;
>  	int (*flush)(struct nd_region *nd_region, struct bio *bio);
> -	struct nd_mapping mapping[];
> +	struct nd_mapping mapping[] __counted_by(ndr_mappings);
>  };
>  
>  static inline bool nsl_validate_nlabel(struct nd_region *nd_region,
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 0a81f87f6f6c..5be65fce85cf 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1028,6 +1028,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
>  
>  	if (!nd_region)
>  		return NULL;
> +	nd_region->ndr_mappings = ndr_desc->num_mappings;
>  	/* CXL pre-assigns memregion ids before creating nvdimm regions */
>  	if (test_bit(ND_REGION_CXL, &ndr_desc->flags)) {
>  		nd_region->id = ndr_desc->memregion;
> @@ -1062,7 +1063,6 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
>  
>  		get_device(&nvdimm->dev);
>  	}
> -	nd_region->ndr_mappings = ndr_desc->num_mappings;
>  	nd_region->provider_data = ndr_desc->provider_data;
>  	nd_region->nd_set = ndr_desc->nd_set;
>  	nd_region->num_lanes = ndr_desc->num_lanes;
