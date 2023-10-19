Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8D87CF594
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbjJSKpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjJSKpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:45:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11B6126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697712344; x=1729248344;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5KBXe0BSoQbG8O7ZoO2D3UK2YDLOJD2xblAKeg353WI=;
  b=cCUdyIdzS9g9e8bIASMGp0w3v0nkZsSE20iSMgjaj50N/CQUbGKVDaSr
   d4fF/UC3H4lfDnO131MJJZKu+klbO3EStSb2dKvMBnamIBDtaIS4+FNue
   hp3uXtCSSqn4vPGeJ1Pz+NsbHG9GKl1FSM5NaObAdk8Jw/sBt0J6Ktw2p
   XS46EFCJApo2ichMmFkg35EqSuaca5DdqCWn4wn2B5MBP15ms6gjdQWgY
   8QxMZvjkJuPof3KS/lHB/XFuJM9sPiBelwbm2vVIueGN5wdkS/TYthcKT
   dKW9qmYHmwfR/VgGYv9A6qndq2ue6F8SeN62+DxVcK/VQXYa5DK2hu6J4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="7775546"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="7775546"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="733523539"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="733523539"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 03:45:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 03:45:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 03:45:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 03:45:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 03:45:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dw+1iIJcryoxxoFj6PZtly02dN8J9n6UJOGFB0BCc/TkGuT4z1bmtCS7WBy9fyp9LzwjYSsHDtRg9iCz8lQPKbHYRAG5lzkNUczRXZJnyiWWywm+0ftxGDNHdgLioQrEd0QCwGM58AA4FlZtDM3D0tFEOcEC8XnCNI8EDHMIou+IeQxP61HwTj+rIKGc3O/TmT9UO3zi+WUNyT92MGQ+fZrDDJohESA1UzwjB+NfCcxCarkFjCdisKOF2CfW/T8eCRbaQ36q6BRE+cnRKB+scJ6fXUHMtyYk3ES33ClhQB/5m9E+RlXng0lqKwiQCWe4G18o8JBuj+GCKe8VSq4qMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qod94FHMAAzWdHhR/VdHyp/LV31ISvlDU1xp9jArULQ=;
 b=W4uU8B97Befv57wMmShE8rVEOrVszYpCc1OHAbxCgVguVc1Filp10y/TLj2aMM4mDykd16gt8v1e8xGdluT4rqChd/CcFpzMGlNQzj5K+1TCHqQVjfzkUPILVCXQcyqfNn9KYW+XdbMayBV7ghoYEDUaF8hVZeZablKhlPX6vcHjjPPWux9AZ5Jlv9jPTs+iI+JQUm52zeaPte43h4N0PNPg79azxjtB4bMG7EA+80xqrPtwHthDTJ07zNPz30BoNnsE1SZswd1d7A9GYYWbQUPDKiaXS3840bG77G7a19kRvvvHQpu2jPmtAoM6qEzcrIQGUvw39TnRtWq7xDGfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 10:45:38 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d%5]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 10:45:37 +0000
Message-ID: <cbe2092b-e36b-899a-cccd-1e166534b5e0@intel.com>
Date:   Thu, 19 Oct 2023 12:45:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] staging: vme_user: Replace printk() with
 pr_*(),dev_*()
Content-Language: en-US
To:     Soumya Negi <soumya.negi97@gmail.com>
CC:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        <outreachy@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-staging@lists.linux.dev>
References: <cover.1697696951.git.soumya.negi97@gmail.com>
 <cad6da28b5f772957ced5b561b21b5d8c8204bc9.1697696951.git.soumya.negi97@gmail.com>
From:   Karolina Stolarek <karolina.stolarek@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <cad6da28b5f772957ced5b561b21b5d8c8204bc9.1697696951.git.soumya.negi97@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|BL1PR11MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fad3ec-c3ab-4a9e-9450-08dbd09087a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/Ha/4ecB+C15HXo+VjKtNvbByEKT2PoS8Y7F8vlw9X78AiMZ3aC+7mBIUmlaQKMQ9NBMG2zZIfCJG7Wi5KjmQ1Y6sFlO68jbWbX7iuiMmK703Bx1/SoWR6C+CrXAMQ7OXXXXtkrB2z/IqvFV2mlth0aKZzUT6XTIMmntX9rkoG5G/ssVMBjoHaWj+RTFR3TOyhwTobX7fNZXc0PYNb4ivhr48fe2p5cumjOPrm0YX7JBUfg9PzhH8T8eTNIAXBEJ2RINSvreaS3nTSIbh/qphoXiOgnk+lFrE4VCDP5q8Nrz6iwoFyqZHn+ow86wtqTwUcPJMU9SVJj/pGLlFAlk+N40pzrLCWDfespNyP1y5PLogPNdiS0/4ubv8r/DNdavlvLCILv+je87PlvL6VAiovth0p/FF8KE8FSf/8kTjyXfImhGa0jdY2AUULvJHBhqIyAMCr8lsWoys9XAJNu3bpChcR/JPht5tlHmqfUSfrYg+R0Fft4o25AzNfi/7MMJvPuY8hvKtxcADRj1bnIwFiOatM/gbawXz34sXPdPf7dqoIV48pCnOwVGlJ7G6haN44jqza9g+1rzAuPzPT48aTGk/eQ3ntRehbSiJ70thKl0frN34o3b7S89QOFFYQ0Iyy9+nvvpBxNuP9Xe2TnUIY4Zdr6LKB2009+nrfPxug=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(38100700002)(8676002)(478600001)(83380400001)(66556008)(6486002)(66946007)(5660300002)(6506007)(6916009)(4326008)(66476007)(86362001)(6666004)(30864003)(41300700001)(44832011)(31696002)(53546011)(54906003)(316002)(36916002)(2906002)(6512007)(8936002)(2616005)(82960400001)(36756003)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUFFREFYd0xJclAxenFQN3lzM0tUUUxIVFJwSjdvM0pXQXZldXlrcHhWUDFM?=
 =?utf-8?B?V0RxakFTTjBHN2xjeTRmcGEyYnZCd2JISy9hNmw4bndUUlJLUXhDMmkwY2x3?=
 =?utf-8?B?TmZSUEEzT29IdVl1bnlXNGlzY3I3aFRMYmtlVHNWTFczUVpOMkwxZXV0eHpB?=
 =?utf-8?B?UGpCcUdrUXVWTFBpUGpoUnptdVdWSlhlMmFFMVNNUWFPVkVrVnVJWndwWHI5?=
 =?utf-8?B?QnpieEUyVjZTUDV2dnEraktpMkxpVVRCWGdrSTFCZGZIVkdHV0toZDhFaThj?=
 =?utf-8?B?MWNJOHY4bDFlVnhqS0t1N1gybThJSzR3ZlkzQjdYZU9EUyt2d2Y1empGNVdP?=
 =?utf-8?B?SENQODBwaGpLeTg2VVhKYVNFTTBJKzdwbnlkY3BYTE5laFJESkk0ZXo2TStu?=
 =?utf-8?B?M2ZCZHI1dGowdGdmZ2pxZVBQZTNVNUYwVnBpTjRtUzVuVXpNRnhxWUlIZlI4?=
 =?utf-8?B?S2JTL0ZNWVJsTXoxVnNMR1R5QzBjUGpwUTNUbGs0MjdnK0dwaTNub0xUOVBK?=
 =?utf-8?B?SHZVYVV4bXZiN2c3RnlaK0NjeURwQkhYcEg1bXlrVXpyYmoxWDU4TWtQbS9z?=
 =?utf-8?B?SVd6cHJ0Qzl2UWtwQlE0OS9BMnFQS0hSK3BmZGNNdWlyWVlQc3BaYWdHYTdM?=
 =?utf-8?B?eXNYS3Q3SStwN1c1ZXJ1eGRCSTRtdUtpV3pPS3FwbXhDNk9nSzQxVHIwd1cx?=
 =?utf-8?B?bzd0WVJsWjJpZ0VuSkdSNGxiTDVrWFY4eUNsKzZqS3JvcnRiY2tNajVaKzNz?=
 =?utf-8?B?aE9MMGUvK2FZeDRGUXVEOFF0MWxOb0s0R2QwSVNOajBoMHRzK05DUTRzR1d2?=
 =?utf-8?B?Y1dQWkIzaTRYTmpRMEFBaEM5LzY1UmtUS2tPS2d2K2hiSjdvQ0dsZDNCNitZ?=
 =?utf-8?B?T04xYUhVMDdBbGp6QldBM1NBc2hvMm01STROVnFSdzFWeEYyOHNHRFFua1cw?=
 =?utf-8?B?TmNveXprR3JOVnVjeUhxREhFYjVpanlWaEFRVkpFd2t1SzlNdG1RaDVYS2JH?=
 =?utf-8?B?ZFdzNkxLVjQ4dkpPL2I0UzNMOUZMMzFmSnNsNjl0c0FtZGs2T3NScDV5NWRJ?=
 =?utf-8?B?UWl2RVNJMW53d1FKbll0TlFUZjYzQXVYQ25JMkgxM0FjL015eW4xcWh3VU1G?=
 =?utf-8?B?SDNhUW1yVGJ2Qmo0L1JQOWpiSE94R0hrcGpVeG9SK2Z4VzFTWFpLRnZWTmNQ?=
 =?utf-8?B?bXBIRldQUUcycjZ5NEZ2VzdNL3JJb3oxbjBDZ1ZCMFVXYmZGSGh3Z0lvUjI4?=
 =?utf-8?B?Mk5xQjBoc0N2K1lPSnBRK1Jaa0lHQ2k4SmZrOFlDOVIwQWJ3YkxmL2QvWGtI?=
 =?utf-8?B?YVNRMjhub3BnOUMxbCtaVWdZWWM5QmdIdEZYakVDcU40QVlEOXZvQjB5WUoy?=
 =?utf-8?B?ZHlTU1ZERWxEVHZETzZjckpjY1JpRnY3M3h0VnNxZzVyMU9ROFY2dEFYakd1?=
 =?utf-8?B?TUZqakJLclNJVkJCZGc0SWV0RmpMUE81a3pRUE1nNHBVUVR3dzJiZnZIbzBk?=
 =?utf-8?B?K0toSnRUcXk3SkduczJFV1o0ZFVRWDVSOUZndndoUzJRanFlVWIxcXQ4M05x?=
 =?utf-8?B?b20wQStTZktISG84RWZFa1c0djBlL0pUZzhkbU5VQnFqNFdpbnR4UEo4aW1x?=
 =?utf-8?B?M01CMVQwaitFc0NjSmNmZU5sTEdqOTlDUWp4N0EvU0gyUnRwbXRQRE92ZWhW?=
 =?utf-8?B?N0FYVkxrZXpzcU9JZWhDY1lWVTZqRFIwZlNzRHN1Z0JwTWlGUFJsZTNRQWtE?=
 =?utf-8?B?WVVDZ0Ntb3FGREJKT2syZ3Z1MGpQZXJxcU9DL2ZMNmhpU2QzSzhJR2hianJy?=
 =?utf-8?B?L2dESGR1VjNrdUh0ckRjMmdyYzQ2SVBPN09lVEpFZGhMb2xqb1J2V2UxZDVu?=
 =?utf-8?B?YWpCVFZ1bS85Nzk3M0V2Q29MNlB5MmdnZFpjOHJTYmIyL0Jkc0dnVXo0c2w0?=
 =?utf-8?B?cVJPMWpCNXNMalFnbHFNeEJ6aDlyL0NoSko3ZFl1bU9UM2JSUUg2OFRjcE1H?=
 =?utf-8?B?ejZYYWZibW4rckFjMTQwZFRCRGZyR3FGM3BEWXZIUCtSMTZYR1pMbFE1VGpK?=
 =?utf-8?B?ekdEalhqYzJkVjgvTXZJTzNnZnNZOEozN1NCTitNSmZlR2JqOWxqN3d4T0J4?=
 =?utf-8?B?aXRqV0dXTVBxM2EwMWlGZHAzRmtxTzAzT1cvK2k0VlZtanZCUmZlZ3JBV0F4?=
 =?utf-8?B?OEdSTDFuUVJDczcxNUxxZXArQXMvbXBvRGFmMXA5amw4OExpK2VzVUVmRzJJ?=
 =?utf-8?B?enZ5Tkovck5IZERYQUE2Z3ZSYVJnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fad3ec-c3ab-4a9e-9450-08dbd09087a6
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:45:37.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wkmDmD1PXH4aw4OpXoxJ9qAoggroXzziHMcJ/kvJ7+HQ0RW9dDlS+C0UQ3u/FZgH1kNDanHzyXDNTAL9D3Y398pQBi4KR6W57KmfJeotWvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.10.2023 09:20, Soumya Negi wrote:
> vme.c uses printk() to log messages. To improve and standardize message
> formatting, use logging mechanisms pr_err()/pr_warn() and
> dev_err()/dev_warn() instead. Retain the printk log levels of the
> messages during replacement.
> 
> Issue found by checkpatch.pl
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
> Changes in v2:
> * Change the pr_*() calls used to replace printk's in v1 to dev_*()
>    wherever possible, as it adds more context to the message.
>    (as per feedback from julia.lawall@inria.fr &
>    gregkh@linuxfoundation.org)

You don't have to include the change log here, as it's already in the 
cover letter. This space is usually used when a patch is not sent as a 
part of the series.

All the best,
Karolina

> 
>   drivers/staging/vme_user/vme.c | 193 +++++++++++++++++++--------------
>   1 file changed, 109 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 6519a7c994a0..640b2dda3ac6 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -9,6 +9,8 @@
>    * Copyright 2004 Motorola Inc.
>    */
>   
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>   #include <linux/init.h>
>   #include <linux/export.h>
>   #include <linux/mm.h>
> @@ -62,7 +64,7 @@ static struct vme_bridge *find_bridge(struct vme_resource *resource)
>   		return list_entry(resource->entry, struct vme_lm_resource,
>   			list)->parent;
>   	default:
> -		printk(KERN_ERR "Unknown resource type\n");
> +		pr_err("Unknown resource type\n");
>   		return NULL;
>   	}
>   }
> @@ -84,24 +86,25 @@ void *vme_alloc_consistent(struct vme_resource *resource, size_t size,
>   	struct vme_bridge *bridge;
>   
>   	if (!resource) {
> -		printk(KERN_ERR "No resource\n");
> +		pr_err("No resource\n");
>   		return NULL;
>   	}
>   
>   	bridge = find_bridge(resource);
>   	if (!bridge) {
> -		printk(KERN_ERR "Can't find bridge\n");
> +		pr_err("Can't find bridge\n");
>   		return NULL;
>   	}
>   
>   	if (!bridge->parent) {
> -		printk(KERN_ERR "Dev entry NULL for bridge %s\n", bridge->name);
> +		pr_err("Dev entry NULL for bridge %s\n", bridge->name);
>   		return NULL;
>   	}
>   
>   	if (!bridge->alloc_consistent) {
> -		printk(KERN_ERR "alloc_consistent not supported by bridge %s\n",
> -		       bridge->name);
> +		dev_err(bridge->parent,
> +			"alloc_consistent not supported by bridge %s\n",
> +			bridge->name);
>   		return NULL;
>   	}
>   
> @@ -124,24 +127,25 @@ void vme_free_consistent(struct vme_resource *resource, size_t size,
>   	struct vme_bridge *bridge;
>   
>   	if (!resource) {
> -		printk(KERN_ERR "No resource\n");
> +		pr_err("No resource\n");
>   		return;
>   	}
>   
>   	bridge = find_bridge(resource);
>   	if (!bridge) {
> -		printk(KERN_ERR "Can't find bridge\n");
> +		pr_err("Can't find bridge\n");
>   		return;
>   	}
>   
>   	if (!bridge->parent) {
> -		printk(KERN_ERR "Dev entry NULL for bridge %s\n", bridge->name);
> +		pr_err("Dev entry NULL for bridge %s\n", bridge->name);
>   		return;
>   	}
>   
>   	if (!bridge->free_consistent) {
> -		printk(KERN_ERR "free_consistent not supported by bridge %s\n",
> -		       bridge->name);
> +		dev_err(bridge->parent,
> +			"free_consistent not supported by bridge %s\n",
> +			bridge->name);
>   		return;
>   	}
>   
> @@ -161,6 +165,7 @@ EXPORT_SYMBOL(vme_free_consistent);
>    */
>   size_t vme_get_size(struct vme_resource *resource)
>   {
> +	struct vme_bridge *bridge = find_bridge(resource);
>   	int enabled, retval;
>   	unsigned long long base, size;
>   	dma_addr_t buf_base;
> @@ -184,7 +189,7 @@ size_t vme_get_size(struct vme_resource *resource)
>   	case VME_DMA:
>   		return 0;
>   	default:
> -		printk(KERN_ERR "Unknown resource type\n");
> +		dev_err(bridge->parent, "Unknown resource type\n");
>   		return 0;
>   	}
>   }
> @@ -225,7 +230,7 @@ int vme_check_window(u32 aspace, unsigned long long vme_base,
>   		/* User Defined */
>   		break;
>   	default:
> -		printk(KERN_ERR "Invalid address space\n");
> +		pr_err("Invalid address space\n");
>   		retval = -EINVAL;
>   		break;
>   	}
> @@ -288,14 +293,15 @@ struct vme_resource *vme_slave_request(struct vme_dev *vdev, u32 address,
>   
>   	bridge = vdev->bridge;
>   	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		dev_err(&vdev->dev, "Can't find VME bus\n");
>   		goto err_bus;
>   	}
>   
>   	/* Loop through slave resources */
>   	list_for_each_entry(slave_image, &bridge->slave_resources, list) {
>   		if (!slave_image) {
> -			printk(KERN_ERR "Registered NULL Slave resource\n");
> +			dev_err(bridge->parent,
> +				"Registered NULL Slave resource\n");
>   			continue;
>   		}
>   
> @@ -362,20 +368,20 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
>   	int retval;
>   
>   	if (resource->type != VME_SLAVE) {
> -		printk(KERN_ERR "Not a slave resource\n");
> +		dev_err(bridge->parent, "Not a slave resource\n");
>   		return -EINVAL;
>   	}
>   
>   	image = list_entry(resource->entry, struct vme_slave_resource, list);
>   
>   	if (!bridge->slave_set) {
> -		printk(KERN_ERR "Function not supported\n");
> +		dev_err(bridge->parent, "Function not supported\n");
>   		return -ENOSYS;
>   	}
>   
>   	if (!(((image->address_attr & aspace) == aspace) &&
>   	      ((image->cycle_attr & cycle) == cycle))) {
> -		printk(KERN_ERR "Invalid attributes\n");
> +		dev_err(bridge->parent, "Invalid attributes\n");
>   		return -EINVAL;
>   	}
>   
> @@ -411,14 +417,14 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
>   	struct vme_slave_resource *image;
>   
>   	if (resource->type != VME_SLAVE) {
> -		printk(KERN_ERR "Not a slave resource\n");
> +		dev_err(bridge->parent, "Not a slave resource\n");
>   		return -EINVAL;
>   	}
>   
>   	image = list_entry(resource->entry, struct vme_slave_resource, list);
>   
>   	if (!bridge->slave_get) {
> -		printk(KERN_ERR "vme_slave_get not supported\n");
> +		dev_err(bridge->parent, "vme_slave_get not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -435,24 +441,25 @@ EXPORT_SYMBOL(vme_slave_get);
>    */
>   void vme_slave_free(struct vme_resource *resource)
>   {
> +	struct vme_bridge *bridge = find_bridge(resource);
>   	struct vme_slave_resource *slave_image;
>   
>   	if (resource->type != VME_SLAVE) {
> -		printk(KERN_ERR "Not a slave resource\n");
> +		dev_err(bridge->parent, "Not a slave resource\n");
>   		return;
>   	}
>   
>   	slave_image = list_entry(resource->entry, struct vme_slave_resource,
>   				 list);
>   	if (!slave_image) {
> -		printk(KERN_ERR "Can't find slave resource\n");
> +		dev_err(bridge->parent, "Can't find slave resource\n");
>   		return;
>   	}
>   
>   	/* Unlock image */
>   	mutex_lock(&slave_image->mtx);
>   	if (slave_image->locked == 0)
> -		printk(KERN_ERR "Image is already free\n");
> +		dev_err(bridge->parent, "Image is already free\n");
>   
>   	slave_image->locked = 0;
>   	mutex_unlock(&slave_image->mtx);
> @@ -484,14 +491,15 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
>   
>   	bridge = vdev->bridge;
>   	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		dev_err(&vdev->dev, "Can't find VME bus\n");
>   		goto err_bus;
>   	}
>   
>   	/* Loop through master resources */
>   	list_for_each_entry(master_image, &bridge->master_resources, list) {
>   		if (!master_image) {
> -			printk(KERN_WARNING "Registered NULL master resource\n");
> +			dev_warn(bridge->parent,
> +				 "Registered NULL master resource\n");
>   			continue;
>   		}
>   
> @@ -511,7 +519,7 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
>   
>   	/* Check to see if we found a resource */
>   	if (!allocated_image) {
> -		printk(KERN_ERR "Can't find a suitable resource\n");
> +		dev_err(&vdev->dev, "Can't find a suitable resource\n");
>   		goto err_image;
>   	}
>   
> @@ -561,21 +569,21 @@ int vme_master_set(struct vme_resource *resource, int enabled,
>   	int retval;
>   
>   	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		dev_err(bridge->parent, "Not a master resource\n");
>   		return -EINVAL;
>   	}
>   
>   	image = list_entry(resource->entry, struct vme_master_resource, list);
>   
>   	if (!bridge->master_set) {
> -		printk(KERN_WARNING "vme_master_set not supported\n");
> +		dev_warn(bridge->parent, "vme_master_set not supported\n");
>   		return -EINVAL;
>   	}
>   
>   	if (!(((image->address_attr & aspace) == aspace) &&
>   	      ((image->cycle_attr & cycle) == cycle) &&
>   	      ((image->width_attr & dwidth) == dwidth))) {
> -		printk(KERN_WARNING "Invalid attributes\n");
> +		dev_warn(bridge->parent, "Invalid attributes\n");
>   		return -EINVAL;
>   	}
>   
> @@ -611,14 +619,14 @@ int vme_master_get(struct vme_resource *resource, int *enabled,
>   	struct vme_master_resource *image;
>   
>   	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		dev_err(bridge->parent, "Not a master resource\n");
>   		return -EINVAL;
>   	}
>   
>   	image = list_entry(resource->entry, struct vme_master_resource, list);
>   
>   	if (!bridge->master_get) {
> -		printk(KERN_WARNING "%s not supported\n", __func__);
> +		dev_warn(bridge->parent, "%s not supported\n", __func__);
>   		return -EINVAL;
>   	}
>   
> @@ -650,12 +658,13 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
>   	size_t length;
>   
>   	if (!bridge->master_read) {
> -		printk(KERN_WARNING "Reading from resource not supported\n");
> +		dev_warn(bridge->parent,
> +			 "Reading from resource not supported\n");
>   		return -EINVAL;
>   	}
>   
>   	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		dev_err(bridge->parent, "Not a master resource\n");
>   		return -EINVAL;
>   	}
>   
> @@ -664,7 +673,7 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
>   	length = vme_get_size(resource);
>   
>   	if (offset > length) {
> -		printk(KERN_WARNING "Invalid Offset\n");
> +		dev_warn(bridge->parent, "Invalid Offset\n");
>   		return -EFAULT;
>   	}
>   
> @@ -698,12 +707,12 @@ ssize_t vme_master_write(struct vme_resource *resource, void *buf,
>   	size_t length;
>   
>   	if (!bridge->master_write) {
> -		printk(KERN_WARNING "Writing to resource not supported\n");
> +		dev_warn(bridge->parent, "Writing to resource not supported\n");
>   		return -EINVAL;
>   	}
>   
>   	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		dev_err(bridge->parent, "Not a master resource\n");
>   		return -EINVAL;
>   	}
>   
> @@ -712,7 +721,7 @@ ssize_t vme_master_write(struct vme_resource *resource, void *buf,
>   	length = vme_get_size(resource);
>   
>   	if (offset > length) {
> -		printk(KERN_WARNING "Invalid Offset\n");
> +		dev_warn(bridge->parent, "Invalid Offset\n");
>   		return -EFAULT;
>   	}
>   
> @@ -749,12 +758,12 @@ unsigned int vme_master_rmw(struct vme_resource *resource, unsigned int mask,
>   	struct vme_master_resource *image;
>   
>   	if (!bridge->master_rmw) {
> -		printk(KERN_WARNING "Writing to resource not supported\n");
> +		dev_warn(bridge->parent, "Writing to resource not supported\n");
>   		return -EINVAL;
>   	}
>   
>   	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		dev_err(bridge->parent, "Not a master resource\n");
>   		return -EINVAL;
>   	}
>   
> @@ -777,12 +786,13 @@ EXPORT_SYMBOL(vme_master_rmw);
>    */
>   int vme_master_mmap(struct vme_resource *resource, struct vm_area_struct *vma)
>   {
> +	struct vme_bridge *bridge = find_bridge(resource);
>   	struct vme_master_resource *image;
>   	phys_addr_t phys_addr;
>   	unsigned long vma_size;
>   
>   	if (resource->type != VME_MASTER) {
> -		pr_err("Not a master resource\n");
> +		dev_err(bridge->parent, "Not a master resource\n");
>   		return -EINVAL;
>   	}
>   
> @@ -791,7 +801,7 @@ int vme_master_mmap(struct vme_resource *resource, struct vm_area_struct *vma)
>   	vma_size = vma->vm_end - vma->vm_start;
>   
>   	if (phys_addr + vma_size > image->bus_resource.end + 1) {
> -		pr_err("Map size cannot exceed the window size\n");
> +		dev_err(bridge->parent, "Map size cannot exceed the window size\n");
>   		return -EFAULT;
>   	}
>   
> @@ -809,24 +819,25 @@ EXPORT_SYMBOL(vme_master_mmap);
>    */
>   void vme_master_free(struct vme_resource *resource)
>   {
> +	struct vme_bridge *bridge = find_bridge(resource);
>   	struct vme_master_resource *master_image;
>   
>   	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		dev_err(bridge->parent, "Not a master resource\n");
>   		return;
>   	}
>   
>   	master_image = list_entry(resource->entry, struct vme_master_resource,
>   				  list);
>   	if (!master_image) {
> -		printk(KERN_ERR "Can't find master resource\n");
> +		dev_err(bridge->parent, "Can't find master resource\n");
>   		return;
>   	}
>   
>   	/* Unlock image */
>   	spin_lock(&master_image->lock);
>   	if (master_image->locked == 0)
> -		printk(KERN_ERR "Image is already free\n");
> +		dev_err(bridge->parent, "Image is already free\n");
>   
>   	master_image->locked = 0;
>   	spin_unlock(&master_image->lock);
> @@ -854,18 +865,19 @@ struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route)
>   	struct vme_resource *resource = NULL;
>   
>   	/* XXX Not checking resource attributes */
> -	printk(KERN_ERR "No VME resource Attribute tests done\n");
> +	dev_err(&vdev->dev, "No VME resource Attribute tests done\n");
>   
>   	bridge = vdev->bridge;
>   	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		dev_err(&vdev->dev, "Can't find VME bus\n");
>   		goto err_bus;
>   	}
>   
>   	/* Loop through DMA resources */
>   	list_for_each_entry(dma_ctrlr, &bridge->dma_resources, list) {
>   		if (!dma_ctrlr) {
> -			printk(KERN_ERR "Registered NULL DMA resource\n");
> +			dev_err(bridge->parent,
> +				"Registered NULL DMA resource\n");
>   			continue;
>   		}
>   
> @@ -917,10 +929,11 @@ EXPORT_SYMBOL(vme_dma_request);
>    */
>   struct vme_dma_list *vme_new_dma_list(struct vme_resource *resource)
>   {
> +	struct vme_bridge *bridge = find_bridge(resource);
>   	struct vme_dma_list *dma_list;
>   
>   	if (resource->type != VME_DMA) {
> -		printk(KERN_ERR "Not a DMA resource\n");
> +		dev_err(bridge->parent, "Not a DMA resource\n");
>   		return NULL;
>   	}
>   
> @@ -1098,12 +1111,13 @@ int vme_dma_list_add(struct vme_dma_list *list, struct vme_dma_attr *src,
>   	int retval;
>   
>   	if (!bridge->dma_list_add) {
> -		printk(KERN_WARNING "Link List DMA generation not supported\n");
> +		dev_warn(bridge->parent,
> +			 "Link List DMA generation not supported\n");
>   		return -EINVAL;
>   	}
>   
>   	if (!mutex_trylock(&list->mtx)) {
> -		printk(KERN_ERR "Link List already submitted\n");
> +		dev_err(bridge->parent, "Link List already submitted\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1131,7 +1145,8 @@ int vme_dma_list_exec(struct vme_dma_list *list)
>   	int retval;
>   
>   	if (!bridge->dma_list_exec) {
> -		printk(KERN_ERR "Link List DMA execution not supported\n");
> +		dev_err(bridge->parent,
> +			"Link List DMA execution not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1160,12 +1175,13 @@ int vme_dma_list_free(struct vme_dma_list *list)
>   	int retval;
>   
>   	if (!bridge->dma_list_empty) {
> -		printk(KERN_WARNING "Emptying of Link Lists not supported\n");
> +		dev_warn(bridge->parent,
> +			 "Emptying of Link Lists not supported\n");
>   		return -EINVAL;
>   	}
>   
>   	if (!mutex_trylock(&list->mtx)) {
> -		printk(KERN_ERR "Link List in use\n");
> +		dev_err(bridge->parent, "Link List in use\n");
>   		return -EBUSY;
>   	}
>   
> @@ -1175,7 +1191,7 @@ int vme_dma_list_free(struct vme_dma_list *list)
>   	 */
>   	retval = bridge->dma_list_empty(list);
>   	if (retval) {
> -		printk(KERN_ERR "Unable to empty link-list entries\n");
> +		dev_err(bridge->parent, "Unable to empty link-list entries\n");
>   		mutex_unlock(&list->mtx);
>   		return retval;
>   	}
> @@ -1197,22 +1213,24 @@ EXPORT_SYMBOL(vme_dma_list_free);
>    */
>   int vme_dma_free(struct vme_resource *resource)
>   {
> +	struct vme_bridge *bridge = find_bridge(resource);
>   	struct vme_dma_resource *ctrlr;
>   
>   	if (resource->type != VME_DMA) {
> -		printk(KERN_ERR "Not a DMA resource\n");
> +		dev_err(bridge->parent, "Not a DMA resource\n");
>   		return -EINVAL;
>   	}
>   
>   	ctrlr = list_entry(resource->entry, struct vme_dma_resource, list);
>   
>   	if (!mutex_trylock(&ctrlr->mtx)) {
> -		printk(KERN_ERR "Resource busy, can't free\n");
> +		dev_err(bridge->parent, "Resource busy, can't free\n");
>   		return -EBUSY;
>   	}
>   
>   	if (!(list_empty(&ctrlr->pending) && list_empty(&ctrlr->running))) {
> -		printk(KERN_WARNING "Resource still processing transfers\n");
> +		dev_warn(bridge->parent,
> +			 "Resource still processing transfers\n");
>   		mutex_unlock(&ctrlr->mtx);
>   		return -EBUSY;
>   	}
> @@ -1290,8 +1308,9 @@ void vme_irq_handler(struct vme_bridge *bridge, int level, int statid)
>   	if (call)
>   		call(level, statid, priv_data);
>   	else
> -		printk(KERN_WARNING "Spurious VME interrupt, level:%x, vector:%x\n",
> -		       level, statid);
> +		dev_warn(bridge->parent,
> +			 "Spurious VME interrupt, level:%x, vector:%x\n", level,
> +			 statid);
>   }
>   EXPORT_SYMBOL(vme_irq_handler);
>   
> @@ -1319,17 +1338,18 @@ int vme_irq_request(struct vme_dev *vdev, int level, int statid,
>   
>   	bridge = vdev->bridge;
>   	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		dev_err(&vdev->dev, "Can't find VME bus\n");
>   		return -EINVAL;
>   	}
>   
>   	if ((level < 1) || (level > 7)) {
> -		printk(KERN_ERR "Invalid interrupt level\n");
> +		dev_err(bridge->parent, "Invalid interrupt level\n");
>   		return -EINVAL;
>   	}
>   
>   	if (!bridge->irq_set) {
> -		printk(KERN_ERR "Configuring interrupts not supported\n");
> +		dev_err(bridge->parent,
> +			"Configuring interrupts not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1337,7 +1357,7 @@ int vme_irq_request(struct vme_dev *vdev, int level, int statid,
>   
>   	if (bridge->irq[level - 1].callback[statid].func) {
>   		mutex_unlock(&bridge->irq_mtx);
> -		printk(KERN_WARNING "VME Interrupt already taken\n");
> +		dev_warn(bridge->parent, "VME Interrupt already taken\n");
>   		return -EBUSY;
>   	}
>   
> @@ -1368,17 +1388,18 @@ void vme_irq_free(struct vme_dev *vdev, int level, int statid)
>   
>   	bridge = vdev->bridge;
>   	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		dev_err(&vdev->dev, "Can't find VME bus\n");
>   		return;
>   	}
>   
>   	if ((level < 1) || (level > 7)) {
> -		printk(KERN_ERR "Invalid interrupt level\n");
> +		dev_err(bridge->parent, "Invalid interrupt level\n");
>   		return;
>   	}
>   
>   	if (!bridge->irq_set) {
> -		printk(KERN_ERR "Configuring interrupts not supported\n");
> +		dev_err(bridge->parent,
> +			"Configuring interrupts not supported\n");
>   		return;
>   	}
>   
> @@ -1415,17 +1436,18 @@ int vme_irq_generate(struct vme_dev *vdev, int level, int statid)
>   
>   	bridge = vdev->bridge;
>   	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		dev_err(&vdev->dev, "Can't find VME bus\n");
>   		return -EINVAL;
>   	}
>   
>   	if ((level < 1) || (level > 7)) {
> -		printk(KERN_WARNING "Invalid interrupt level\n");
> +		dev_warn(bridge->parent, "Invalid interrupt level\n");
>   		return -EINVAL;
>   	}
>   
>   	if (!bridge->irq_generate) {
> -		printk(KERN_WARNING "Interrupt generation not supported\n");
> +		dev_warn(bridge->parent,
> +			 "Interrupt generation not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1452,14 +1474,15 @@ struct vme_resource *vme_lm_request(struct vme_dev *vdev)
>   
>   	bridge = vdev->bridge;
>   	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		dev_err(&vdev->dev, "Can't find VME bus\n");
>   		goto err_bus;
>   	}
>   
>   	/* Loop through LM resources */
>   	list_for_each_entry(lm, &bridge->lm_resources, list) {
>   		if (!lm) {
> -			printk(KERN_ERR "Registered NULL Location Monitor resource\n");
> +			dev_err(bridge->parent,
> +				"Registered NULL Location Monitor resource\n");
>   			continue;
>   		}
>   
> @@ -1511,10 +1534,11 @@ EXPORT_SYMBOL(vme_lm_request);
>    */
>   int vme_lm_count(struct vme_resource *resource)
>   {
> +	struct vme_bridge *bridge = find_bridge(resource);
>   	struct vme_lm_resource *lm;
>   
>   	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		dev_err(bridge->parent, "Not a Location Monitor resource\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1545,14 +1569,14 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
>   	struct vme_lm_resource *lm;
>   
>   	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		dev_err(bridge->parent, "Not a Location Monitor resource\n");
>   		return -EINVAL;
>   	}
>   
>   	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>   
>   	if (!bridge->lm_set) {
> -		printk(KERN_ERR "vme_lm_set not supported\n");
> +		dev_err(bridge->parent, "vme_lm_set not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1581,14 +1605,14 @@ int vme_lm_get(struct vme_resource *resource, unsigned long long *lm_base,
>   	struct vme_lm_resource *lm;
>   
>   	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		dev_err(bridge->parent, "Not a Location Monitor resource\n");
>   		return -EINVAL;
>   	}
>   
>   	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>   
>   	if (!bridge->lm_get) {
> -		printk(KERN_ERR "vme_lm_get not supported\n");
> +		dev_err(bridge->parent, "vme_lm_get not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1618,14 +1642,14 @@ int vme_lm_attach(struct vme_resource *resource, int monitor,
>   	struct vme_lm_resource *lm;
>   
>   	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		dev_err(bridge->parent, "Not a Location Monitor resource\n");
>   		return -EINVAL;
>   	}
>   
>   	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>   
>   	if (!bridge->lm_attach) {
> -		printk(KERN_ERR "vme_lm_attach not supported\n");
> +		dev_err(bridge->parent, "vme_lm_attach not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1651,14 +1675,14 @@ int vme_lm_detach(struct vme_resource *resource, int monitor)
>   	struct vme_lm_resource *lm;
>   
>   	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		dev_err(bridge->parent, "Not a Location Monitor resource\n");
>   		return -EINVAL;
>   	}
>   
>   	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>   
>   	if (!bridge->lm_detach) {
> -		printk(KERN_ERR "vme_lm_detach not supported\n");
> +		dev_err(bridge->parent, "vme_lm_detach not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1680,10 +1704,11 @@ EXPORT_SYMBOL(vme_lm_detach);
>    */
>   void vme_lm_free(struct vme_resource *resource)
>   {
> +	struct vme_bridge *bridge = find_bridge(resource);
>   	struct vme_lm_resource *lm;
>   
>   	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		dev_err(bridge->parent, "Not a Location Monitor resource\n");
>   		return;
>   	}
>   
> @@ -1720,12 +1745,12 @@ int vme_slot_num(struct vme_dev *vdev)
>   
>   	bridge = vdev->bridge;
>   	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		dev_err(&vdev->dev, "Can't find VME bus\n");
>   		return -EINVAL;
>   	}
>   
>   	if (!bridge->slot_get) {
> -		printk(KERN_WARNING "vme_slot_num not supported\n");
> +		dev_warn(bridge->parent, "vme_slot_num not supported\n");
>   		return -EINVAL;
>   	}
>   
> @@ -1748,7 +1773,7 @@ int vme_bus_num(struct vme_dev *vdev)
>   
>   	bridge = vdev->bridge;
>   	if (!bridge) {
> -		pr_err("Can't find VME bus\n");
> +		dev_err(&vdev->dev, "Can't find VME bus\n");
>   		return -EINVAL;
>   	}
>   
