Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673727CD5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 09:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344584AbjJRHrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 03:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJRHrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 03:47:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D22B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 00:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697615236; x=1729151236;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T5kWEBcn2uRkUxIiUByYY2HSvBlqBkLCISg4uD9JfCw=;
  b=YqGRfzovylviYbvC0QuTRhSCLeHkdI4e8vhQ35K3EBIMNSNYAYouJQdw
   Sx+fhghNk8HjM3BTGiKFMnF0f//rLLKljVGWynDezgETWQvo5TJ6nL6eY
   5Oct5zYpLEg1OKe7mVEP7vk5+S+BxlgnbQqTA5i4IvDI9vnz3d5lyCUxn
   nehuZiP3OratZG4AckGRA6jwfaPE4cb8HyqJI0Wes+auG+pMEK5oHb7uc
   9aASV6Xzvr48oODetai3DpKe2hj6+YnoMgqVXYovpohASQO7Ymqy39rnU
   CK4kGRqfL7rHawdTpUcMdy6lngTLfajn1v6uxIwrZ8EIjzgpEXiHCRmQc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="376332618"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="376332618"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 00:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1087822424"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="1087822424"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 00:47:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 00:47:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 00:47:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 00:47:13 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 00:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibuGPc03pGxCdfgrdi8nbeV9OjItl4wrc5zx+QMXdDD7pqlqG9pUiUqr89wu5wdbVVqaOzquSp2jnG13LXylODa63RspEHqqRTAlj2cGizhQ5vWB71HzIsLyVwg9m7phGwopEgmD9iP3gX3lvQLEsi0L4NhmGnSRkUE92jqFu2ioUN3v5gpM1MSGOxSHToAhilL3ZlE4KIa71bYhwY+PKVuEiNVFND5iFYFzGKwVjhKm2gZiDz2DFdgsEGZdOpZyodrsPJ+b93s3viRt2PmoaxXmg0NbQbhBH2iGezE2mPSooV3sYV4qyA+k3OZY8a3yA24L/kfuzwrNoOnOXJ/gag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgbGgG6wd8zRQ3iaBdSmzXZwuhjFk4myhzauYGGsXzw=;
 b=atuKjO0Ooxz/6d1kidYSTJAm4qttEVF8Gl3kXO/ENvVsZD7TK4AjhUIGnd5kWgJJ4tTv4aCi0GWKfHFFUrUkyYAmOYvggOS7OSdX0nCUNMH6Jdvx68kyx034thDR68QAYnb2NwABDv1d7WIN9A/qOuJ6ZTwdjoji0h6SUgDZZbxIYv8mmLM4OtpUAdhA7do//JctyjKTpTdQCVh7B4A8OKkv2TtGm+E/e4V2+cCLbIl/kWv5KhGogcRUmi8ntJn5KlJgXW336noggmwCgNr1jA9kckJxIoB4ULnfPTcGR5VKHtTlqLBjAoccr6k835t3UMaw5sPpMbOa4vyEP54SxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 07:47:11 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 07:47:11 +0000
Message-ID: <6f59aab0-ac5d-7124-a079-0e131f944403@intel.com>
Date:   Wed, 18 Oct 2023 09:47:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: vme_user: fix coding style - remove CamelCasing
Content-Language: en-US
To:     Calvince Otieno <calvncce@gmail.com>
CC:     <gustavo@embeddedor.com>, <outreachy@lists.linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        "Martyn Welch" <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
References: <ZS+HyqwvyVyfzGXs@lab-ubuntu>
From:   Karolina Stolarek <karolina.stolarek@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <ZS+HyqwvyVyfzGXs@lab-ubuntu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::15) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|MW3PR11MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3bacbf-7c83-4900-237e-08dbcfae6fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUKgfGl87MKH00/1ERJFGYjj9tlJmGFU0NI/TNzdkjKair+6yE9n0rwxj8HJnLiLszCYEomRIWQimnpFDA+SzoCycl+2gpz7+3LohEKCy1kZGXMQsWlQYGzvMN6cUsa2mUQqd1eSFSyhqQWp75n2zLFoo4JqnxuIaeNQzquiyE7GASVRn4xFDf0ocm1YRQZN0DJ547AxvBz1W5s6d8qi47YdXL4x4P2DpB9OOE/CL9gUV9jpbBJoWbjH6UDS2Qo0Ul6AsrnomDV3B6uYrnLoPgIymOxszPOfnANm71FaJ7/lAQ1jJPSi9GTLfmGr4AECg+Cmw+himDoNv9BTg4hIbFNbJG+TIcXsORaatZPvGKNXrN88UrF5w3cStsrFoA8xXrWE14BWPK8Isw2DwSLwF5Rjzv6yVkUL+mPjodH3jr/ZKogw5wuINJ76xIWO5OuLalelTV5VtpgvTRXwRbXwsrRFm3CCiJPZDL9FryMbaWAUKXxLfL0La45oIq7OmGkxcZN9ovc5Q9iBsaweWS8Uy3fEngujVFD+CyFZGKDwus/4CktdcnOqDjpcDMWwPzUjW1KAgrIwQfxoVJV72aqmdi+OPTn1tkW8fNW6nqs+7fRp5N+KhU9isF2z26rZZvtXHkJUUjtQ6lFvVY6Kf4G/uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(316002)(66946007)(6916009)(53546011)(6512007)(66556008)(86362001)(83380400001)(36756003)(38100700002)(82960400001)(2616005)(31696002)(36916002)(478600001)(6486002)(6506007)(54906003)(66476007)(41300700001)(44832011)(5660300002)(26005)(30864003)(31686004)(2906002)(8676002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHl2SXFMb1BMV05pM09YSEQwSUxRd3dGK3JteWV6YW00TSszV2hWcjJWaUV4?=
 =?utf-8?B?bkFlRVl5VDhkL0dNVWpjMUN1NFdsdXc1OG92MGdCbXJMUTE5ZjBUY0IzUGY5?=
 =?utf-8?B?dnAvaUwvV1NyajBnVmxRUy95TzVoeThOZEdhWGt0a0pWTjVoN0pYK3FlNzdW?=
 =?utf-8?B?NkdSMFR2U1lxL2x3WlUwVG1zUmJaVVNHd2F0L0t2cFZlSE4wMFRjWnZsdGQ2?=
 =?utf-8?B?UGtzL1hvaUoxWnBUMXRNem84M3dRNW9aT2N3bHl2K2xsUFlndDU3SFVHWS9m?=
 =?utf-8?B?emIvVVhBakMzYUNzQTd4U21NazBHL0IxekhWR3lUTkpicy9KNk4zNkQrc2Zq?=
 =?utf-8?B?b1lWa2RENEV4L3h4ZjNvSUpLOGp6Z0hPNXoxU0lDSXRPQld6dHRqNkFYWjda?=
 =?utf-8?B?UlRCcW5Sb0FkVldieDNPd2JnUisvNlhmM05QcW5ySEI0YlFRcXBSVVZ2c0N6?=
 =?utf-8?B?TEx3REo5OEVXZHFOTGZKZ2E5dStmMHBrbjNVRW5QWE5QSW9wY1ZXTkMvSVVD?=
 =?utf-8?B?bmtzdUlYWlE2Z0JXS3Y5ZlBHSjZDa1ZmNkxKYlk5ZytXZHlxaXI0eHpsWWxm?=
 =?utf-8?B?MFQxWkpLMnlSQjgvTFFTN3pFUyt3OVZiNUovUDF2UjArdEhSNWNnV3JNd3Fy?=
 =?utf-8?B?bnJ1aTBMcVRucDBXY2ZzcGkyUitMSmFJcnIwNkpBd0g0eXJhc2xlK2tEU3lF?=
 =?utf-8?B?YitzOW5CREwyYXg3RTVXeTc2MUJlZStENjBKT0Vkblptcy93WURzMk9FaGRD?=
 =?utf-8?B?WnlSTEhhZ0MweUEweExNck1kTkRyLytTRnl0L1luQTVqa0RtVXJMdjBGQk1q?=
 =?utf-8?B?U3ZrclluTDVKUmVkZDlFK2Z6VHNydjN0TGF0QWU4ditYeGxHYzZaZmsyWDZJ?=
 =?utf-8?B?MERkclRFbEZmaVFmR1hCYk9UVmswOCtMd0ZiaHZ1Y3NEb0tLVkZqMkJ6VlNr?=
 =?utf-8?B?amE2N2prcU9TR0FIamxhZ05oaHUvdTFBTWpST0I0YnZYRUN3MkFvYVVlRG1B?=
 =?utf-8?B?R1ZYNjZ1TUczNitnNC8zRzRaMzNONHQ5NS9HVmp6Smo5ZnpCdytmaFBvcldO?=
 =?utf-8?B?K0g2aFZXMmFCYmhXKy9tT0tGTFlXOThXWEg4NzBlaU1BS1VWTnhVcHNxbEcx?=
 =?utf-8?B?VnlRSVNkSERuaE1tMGdINS9EK1E2ekw0Szk5RW9ZZEU5VUk2TTgvcjU4YStm?=
 =?utf-8?B?UTdQYzVVb0FlZjZydGdkbldNVjdzTlFpZ1ppd1BQWXptOFdaNUZxTG0xMDRl?=
 =?utf-8?B?MWZrcW53cWloUHZJRnkyelBER3FhNGVNWkorN2lXaDk1dC9oY2Y2TGJOVGM3?=
 =?utf-8?B?RU55Ynpab1F5NTN1Kyt3UjBSOEZiRWdPTVpDNjJwelM4NXF0UkxTak1xeXVx?=
 =?utf-8?B?K0l6YnByODBuNGJMc2d5RmJxaTVsSnNUdG1UQTVUMTVDQVZvdFl0THdsNkRY?=
 =?utf-8?B?TXZWOWNWUktiZG4vRGszVGJEMWhncFpycEYybWZ0bmk1bTJqUWg4QzE2NVBL?=
 =?utf-8?B?QWk4dEhSRGtsODFidXRWeEJZOUcyc2U1WUs3YnJ6MEdyVG9TRlJMNFNXckdZ?=
 =?utf-8?B?disvaTFXL2RYMWw4ZzRtV1FvNi9sL21vUi82MjZOY0NXeW5TenhPdVVEVm8x?=
 =?utf-8?B?TDdDa1FnWm55TXE4Uld6NFVpTHFRSzdNUTAvMnI1bnFBaVJhd2NOSk91T1JE?=
 =?utf-8?B?ejRTOENTYUpkWFBHS0FBQVFGOWM2K3VPUU9FdUtyT20yUHBOV2RTbVpIekFQ?=
 =?utf-8?B?OUtyc1FJYXBOY2wyeEg2TEt2ZEgzcURFYXRmaTgwR256SG1laXErK2FUaFp5?=
 =?utf-8?B?bGFiNEl5Si9WSHROWjlKTVVTMjlYOE9WeFBIYkE0OTNDUXhiSGtaYUtmQzhL?=
 =?utf-8?B?ejhoWUxRU0VlWWs0VStlcGJvYXJLSHNzN2xLbk9CV2hDK1VrVldSNmw3cmRL?=
 =?utf-8?B?bXQ5TnJDRVN6UCsxY2pqbk1IcnpNN28xS3Qxb3lWRXdoeGVjSzRuRmJ3Ymlw?=
 =?utf-8?B?S0FkWmNPS2daREV2OXh0STJBcmcveTRFeVZMOEZ1RzVyMlNGbmZaOWxYOTcw?=
 =?utf-8?B?aW5ZaUcvSFZxM3BQeHlvcWIrU1g2QlpyOTNBclRsbXgxOTB0Z1QxckRlbWQz?=
 =?utf-8?B?aTU0SUNpSWE4c2hCNzJONTlQRVgwLzNuclRZeis1dlU1UncwdjZ2YzZ6cCtB?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3bacbf-7c83-4900-237e-08dbcfae6fa6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 07:47:10.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hKbLw7dPHsGLvDCOMGgjdJVdtos/3DZFm5J4rKaSBm5jdXaRl+YXa4mhS/nPT3p1x7k1PNxfmg2kYSGYxCNJDCiHgkGiFby/3tWV04FGkvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.2023 09:22, Calvince Otieno wrote:
> This patch addresses coding style errors identified by checkpatch. The
> changes include converting camel case names in constant variables to
> UPPERCASE. These changes align with the coding style guidelines.
> 
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
About the subject line -- I'd drop "fix coding style" and wrote about 
the specific change you did in the patch (macro rename? Variable 
rename?). "CamelCasing" should be simply "CamelCase", I think.

And a small nit -- just one blank line between the commit message and 
SoB will suffice.

> ---
>   drivers/staging/vme_user/vme.h        | 12 ++--
>   drivers/staging/vme_user/vme_fake.c   |  8 +--
>   drivers/staging/vme_user/vme_tsi148.c | 88 +++++++++++++--------------
>   3 files changed, 54 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
> index fbcbd0204453..0b40859fee23 100644
> --- a/drivers/staging/vme_user/vme.h
> +++ b/drivers/staging/vme_user/vme.h
> @@ -33,13 +33,13 @@ enum vme_resource_type {
>   #define VME_SCT		0x1
>   #define VME_BLT		0x2
>   #define VME_MBLT	0x4
> -#define VME_2eVME	0x8
> -#define VME_2eSST	0x10
> -#define VME_2eSSTB	0x20
> +#define VME_2EVME	0x8
> +#define VME_2ESST	0x10
> +#define VME_2ESSTB	0x20
>   
> -#define VME_2eSST160	0x100
> -#define VME_2eSST267	0x200
> -#define VME_2eSST320	0x400
> +#define VME_2ESST160	0x100
> +#define VME_2ESST267	0x200
> +#define VME_2ESST320	0x400
>   
>   #define	VME_SUPER	0x1000
>   #define	VME_USER	0x2000
> diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
> index ae802d6dda7e..0e02c194298d 100644
> --- a/drivers/staging/vme_user/vme_fake.c
> +++ b/drivers/staging/vme_user/vme_fake.c
> @@ -1108,8 +1108,8 @@ static int __init fake_init(void)
>   		master_image->address_attr = VME_A16 | VME_A24 | VME_A32 |
>   			VME_A64;
>   		master_image->cycle_attr = VME_SCT | VME_BLT | VME_MBLT |
> -			VME_2eVME | VME_2eSST | VME_2eSSTB | VME_2eSST160 |
> -			VME_2eSST267 | VME_2eSST320 | VME_SUPER | VME_USER |
> +			VME_2EVME | VME_2ESST | VME_2ESSTB | VME_2ESST160 |
> +			VME_2ESST267 | VME_2ESST320 | VME_SUPER | VME_USER |
>   			VME_PROG | VME_DATA;

I just did a quick search, and it seems like "2eSST320", "2eSST233" and 
"2eSST160" refer to bus names, so I'd keep them as they are in the code.

For the future, if you're not certain the meaning of a definition in a 
driver, you can always look it up. If you're lucky, you might find 
documentation for the hardware, or some article about it.

All the best,
Karolina

>   		master_image->width_attr = VME_D16 | VME_D32;
>   		memset(&master_image->bus_resource, 0,
> @@ -1135,8 +1135,8 @@ static int __init fake_init(void)
>   			VME_A64 | VME_CRCSR | VME_USER1 | VME_USER2 |
>   			VME_USER3 | VME_USER4;
>   		slave_image->cycle_attr = VME_SCT | VME_BLT | VME_MBLT |
> -			VME_2eVME | VME_2eSST | VME_2eSSTB | VME_2eSST160 |
> -			VME_2eSST267 | VME_2eSST320 | VME_SUPER | VME_USER |
> +			VME_2EVME | VME_2ESST | VME_2ESSTB | VME_2ESST160 |
> +			VME_2ESST267 | VME_2ESST320 | VME_SUPER | VME_USER |
>   			VME_PROG | VME_DATA;
>   		list_add_tail(&slave_image->list,
>   			      &fake_bridge->slave_resources);
> diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
> index d549c22da534..859298aa1313 100644
> --- a/drivers/staging/vme_user/vme_tsi148.c
> +++ b/drivers/staging/vme_user/vme_tsi148.c
> @@ -551,14 +551,14 @@ static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
>   
>   	/* Setup 2eSST speeds */
>   	temp_ctl &= ~TSI148_LCSR_ITAT_2eSSTM_M;
> -	switch (cycle & (VME_2eSST160 | VME_2eSST267 | VME_2eSST320)) {
> -	case VME_2eSST160:
> +	switch (cycle & (VME_2ESST160 | VME_2ESST267 | VME_2ESST320)) {
> +	case VME_2ESST160:
>   		temp_ctl |= TSI148_LCSR_ITAT_2eSSTM_160;
>   		break;
> -	case VME_2eSST267:
> +	case VME_2ESST267:
>   		temp_ctl |= TSI148_LCSR_ITAT_2eSSTM_267;
>   		break;
> -	case VME_2eSST320:
> +	case VME_2ESST320:
>   		temp_ctl |= TSI148_LCSR_ITAT_2eSSTM_320;
>   		break;
>   	}
> @@ -569,11 +569,11 @@ static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
>   		temp_ctl |= TSI148_LCSR_ITAT_BLT;
>   	if (cycle & VME_MBLT)
>   		temp_ctl |= TSI148_LCSR_ITAT_MBLT;
> -	if (cycle & VME_2eVME)
> +	if (cycle & VME_2EVME)
>   		temp_ctl |= TSI148_LCSR_ITAT_2eVME;
> -	if (cycle & VME_2eSST)
> +	if (cycle & VME_2ESST)
>   		temp_ctl |= TSI148_LCSR_ITAT_2eSST;
> -	if (cycle & VME_2eSSTB)
> +	if (cycle & VME_2ESSTB)
>   		temp_ctl |= TSI148_LCSR_ITAT_2eSSTB;
>   
>   	/* Setup address space */
> @@ -673,22 +673,22 @@ static int tsi148_slave_get(struct vme_slave_resource *image, int *enabled,
>   	*size = (unsigned long long)((vme_bound - *vme_base) + granularity);
>   
>   	if ((ctl & TSI148_LCSR_ITAT_2eSSTM_M) == TSI148_LCSR_ITAT_2eSSTM_160)
> -		*cycle |= VME_2eSST160;
> +		*cycle |= VME_2ESST160;
>   	if ((ctl & TSI148_LCSR_ITAT_2eSSTM_M) == TSI148_LCSR_ITAT_2eSSTM_267)
> -		*cycle |= VME_2eSST267;
> +		*cycle |= VME_2ESST267;
>   	if ((ctl & TSI148_LCSR_ITAT_2eSSTM_M) == TSI148_LCSR_ITAT_2eSSTM_320)
> -		*cycle |= VME_2eSST320;
> +		*cycle |= VME_2ESST320;
>   
>   	if (ctl & TSI148_LCSR_ITAT_BLT)
>   		*cycle |= VME_BLT;
>   	if (ctl & TSI148_LCSR_ITAT_MBLT)
>   		*cycle |= VME_MBLT;
>   	if (ctl & TSI148_LCSR_ITAT_2eVME)
> -		*cycle |= VME_2eVME;
> +		*cycle |= VME_2EVME;
>   	if (ctl & TSI148_LCSR_ITAT_2eSST)
> -		*cycle |= VME_2eSST;
> +		*cycle |= VME_2ESST;
>   	if (ctl & TSI148_LCSR_ITAT_2eSSTB)
> -		*cycle |= VME_2eSSTB;
> +		*cycle |= VME_2ESSTB;
>   
>   	if (ctl & TSI148_LCSR_ITAT_SUPR)
>   		*cycle |= VME_SUPER;
> @@ -895,14 +895,14 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
>   
>   	/* Setup 2eSST speeds */
>   	temp_ctl &= ~TSI148_LCSR_OTAT_2eSSTM_M;
> -	switch (cycle & (VME_2eSST160 | VME_2eSST267 | VME_2eSST320)) {
> -	case VME_2eSST160:
> +	switch (cycle & (VME_2ESST160 | VME_2ESST267 | VME_2ESST320)) {
> +	case VME_2ESST160:
>   		temp_ctl |= TSI148_LCSR_OTAT_2eSSTM_160;
>   		break;
> -	case VME_2eSST267:
> +	case VME_2ESST267:
>   		temp_ctl |= TSI148_LCSR_OTAT_2eSSTM_267;
>   		break;
> -	case VME_2eSST320:
> +	case VME_2ESST320:
>   		temp_ctl |= TSI148_LCSR_OTAT_2eSSTM_320;
>   		break;
>   	}
> @@ -916,15 +916,15 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
>   		temp_ctl &= ~TSI148_LCSR_OTAT_TM_M;
>   		temp_ctl |= TSI148_LCSR_OTAT_TM_MBLT;
>   	}
> -	if (cycle & VME_2eVME) {
> +	if (cycle & VME_2EVME) {
>   		temp_ctl &= ~TSI148_LCSR_OTAT_TM_M;
>   		temp_ctl |= TSI148_LCSR_OTAT_TM_2eVME;
>   	}
> -	if (cycle & VME_2eSST) {
> +	if (cycle & VME_2ESST) {
>   		temp_ctl &= ~TSI148_LCSR_OTAT_TM_M;
>   		temp_ctl |= TSI148_LCSR_OTAT_TM_2eSST;
>   	}
> -	if (cycle & VME_2eSSTB) {
> +	if (cycle & VME_2ESSTB) {
>   		dev_warn(tsi148_bridge->parent, "Currently not setting Broadcast Select Registers\n");
>   		temp_ctl &= ~TSI148_LCSR_OTAT_TM_M;
>   		temp_ctl |= TSI148_LCSR_OTAT_TM_2eSSTB;
> @@ -1100,11 +1100,11 @@ static int __tsi148_master_get(struct vme_master_resource *image, int *enabled,
>   
>   	/* Setup 2eSST speeds */
>   	if ((ctl & TSI148_LCSR_OTAT_2eSSTM_M) == TSI148_LCSR_OTAT_2eSSTM_160)
> -		*cycle |= VME_2eSST160;
> +		*cycle |= VME_2ESST160;
>   	if ((ctl & TSI148_LCSR_OTAT_2eSSTM_M) == TSI148_LCSR_OTAT_2eSSTM_267)
> -		*cycle |= VME_2eSST267;
> +		*cycle |= VME_2ESST267;
>   	if ((ctl & TSI148_LCSR_OTAT_2eSSTM_M) == TSI148_LCSR_OTAT_2eSSTM_320)
> -		*cycle |= VME_2eSST320;
> +		*cycle |= VME_2ESST320;
>   
>   	/* Setup cycle types */
>   	if ((ctl & TSI148_LCSR_OTAT_TM_M) == TSI148_LCSR_OTAT_TM_SCT)
> @@ -1114,11 +1114,11 @@ static int __tsi148_master_get(struct vme_master_resource *image, int *enabled,
>   	if ((ctl & TSI148_LCSR_OTAT_TM_M) == TSI148_LCSR_OTAT_TM_MBLT)
>   		*cycle |= VME_MBLT;
>   	if ((ctl & TSI148_LCSR_OTAT_TM_M) == TSI148_LCSR_OTAT_TM_2eVME)
> -		*cycle |= VME_2eVME;
> +		*cycle |= VME_2EVME;
>   	if ((ctl & TSI148_LCSR_OTAT_TM_M) == TSI148_LCSR_OTAT_TM_2eSST)
> -		*cycle |= VME_2eSST;
> +		*cycle |= VME_2ESST;
>   	if ((ctl & TSI148_LCSR_OTAT_TM_M) == TSI148_LCSR_OTAT_TM_2eSSTB)
> -		*cycle |= VME_2eSSTB;
> +		*cycle |= VME_2ESSTB;
>   
>   	if (ctl & TSI148_LCSR_OTAT_SUP)
>   		*cycle |= VME_SUPER;
> @@ -1406,14 +1406,14 @@ static int tsi148_dma_set_vme_src_attributes(struct device *dev, __be32 *attr,
>   	val = be32_to_cpu(*attr);
>   
>   	/* Setup 2eSST speeds */
> -	switch (cycle & (VME_2eSST160 | VME_2eSST267 | VME_2eSST320)) {
> -	case VME_2eSST160:
> +	switch (cycle & (VME_2ESST160 | VME_2ESST267 | VME_2ESST320)) {
> +	case VME_2ESST160:
>   		val |= TSI148_LCSR_DSAT_2eSSTM_160;
>   		break;
> -	case VME_2eSST267:
> +	case VME_2ESST267:
>   		val |= TSI148_LCSR_DSAT_2eSSTM_267;
>   		break;
> -	case VME_2eSST320:
> +	case VME_2ESST320:
>   		val |= TSI148_LCSR_DSAT_2eSSTM_320;
>   		break;
>   	}
> @@ -1428,13 +1428,13 @@ static int tsi148_dma_set_vme_src_attributes(struct device *dev, __be32 *attr,
>   	if (cycle & VME_MBLT)
>   		val |= TSI148_LCSR_DSAT_TM_MBLT;
>   
> -	if (cycle & VME_2eVME)
> +	if (cycle & VME_2EVME)
>   		val |= TSI148_LCSR_DSAT_TM_2eVME;
>   
> -	if (cycle & VME_2eSST)
> +	if (cycle & VME_2ESST)
>   		val |= TSI148_LCSR_DSAT_TM_2eSST;
>   
> -	if (cycle & VME_2eSSTB) {
> +	if (cycle & VME_2ESSTB) {
>   		dev_err(dev, "Currently not setting Broadcast Select Registers\n");
>   		val |= TSI148_LCSR_DSAT_TM_2eSSTB;
>   	}
> @@ -1504,14 +1504,14 @@ static int tsi148_dma_set_vme_dest_attributes(struct device *dev, __be32 *attr,
>   	val = be32_to_cpu(*attr);
>   
>   	/* Setup 2eSST speeds */
> -	switch (cycle & (VME_2eSST160 | VME_2eSST267 | VME_2eSST320)) {
> -	case VME_2eSST160:
> +	switch (cycle & (VME_2ESST160 | VME_2ESST267 | VME_2ESST320)) {
> +	case VME_2ESST160:
>   		val |= TSI148_LCSR_DDAT_2eSSTM_160;
>   		break;
> -	case VME_2eSST267:
> +	case VME_2ESST267:
>   		val |= TSI148_LCSR_DDAT_2eSSTM_267;
>   		break;
> -	case VME_2eSST320:
> +	case VME_2ESST320:
>   		val |= TSI148_LCSR_DDAT_2eSSTM_320;
>   		break;
>   	}
> @@ -1526,13 +1526,13 @@ static int tsi148_dma_set_vme_dest_attributes(struct device *dev, __be32 *attr,
>   	if (cycle & VME_MBLT)
>   		val |= TSI148_LCSR_DDAT_TM_MBLT;
>   
> -	if (cycle & VME_2eVME)
> +	if (cycle & VME_2EVME)
>   		val |= TSI148_LCSR_DDAT_TM_2eVME;
>   
> -	if (cycle & VME_2eSST)
> +	if (cycle & VME_2ESST)
>   		val |= TSI148_LCSR_DDAT_TM_2eSST;
>   
> -	if (cycle & VME_2eSSTB) {
> +	if (cycle & VME_2ESSTB) {
>   		dev_err(dev, "Currently not setting Broadcast Select Registers\n");
>   		val |= TSI148_LCSR_DDAT_TM_2eSSTB;
>   	}
> @@ -2359,8 +2359,8 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   			VME_A64 | VME_CRCSR | VME_USER1 | VME_USER2 |
>   			VME_USER3 | VME_USER4;
>   		master_image->cycle_attr = VME_SCT | VME_BLT | VME_MBLT |
> -			VME_2eVME | VME_2eSST | VME_2eSSTB | VME_2eSST160 |
> -			VME_2eSST267 | VME_2eSST320 | VME_SUPER | VME_USER |
> +			VME_2EVME | VME_2ESST | VME_2ESSTB | VME_2ESST160 |
> +			VME_2ESST267 | VME_2ESST320 | VME_SUPER | VME_USER |
>   			VME_PROG | VME_DATA;
>   		master_image->width_attr = VME_D16 | VME_D32;
>   		memset(&master_image->bus_resource, 0,
> @@ -2384,8 +2384,8 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		slave_image->address_attr = VME_A16 | VME_A24 | VME_A32 |
>   			VME_A64;
>   		slave_image->cycle_attr = VME_SCT | VME_BLT | VME_MBLT |
> -			VME_2eVME | VME_2eSST | VME_2eSSTB | VME_2eSST160 |
> -			VME_2eSST267 | VME_2eSST320 | VME_SUPER | VME_USER |
> +			VME_2EVME | VME_2ESST | VME_2ESSTB | VME_2ESST160 |
> +			VME_2ESST267 | VME_2ESST320 | VME_SUPER | VME_USER |
>   			VME_PROG | VME_DATA;
>   		list_add_tail(&slave_image->list,
>   			&tsi148_bridge->slave_resources);
