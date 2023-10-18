Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD37CD61F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjJRIM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjJRIMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:12:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02CCC6;
        Wed, 18 Oct 2023 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697616742; x=1729152742;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rRVRfb2udaKuxAD9TCiFj//SScZHdA5HYLq8Nk3/q1o=;
  b=Koi61mDaGmMP/5AZD6LZcTmNhx4uFomsCsSTFJ129nxwArEfK0arijVx
   k7UeT/ALx7C8b09kt+Ds24GNr1VcgbxzAlrTY7oYkqfBtmlflsjJbxj75
   XZm56v5SQoPgsuz+knaFf24Pt+rxeJtCVgvOABjPdYp284HBRiZWLJzuQ
   8VKytBjp1SKuH7UErpZKhAIZAnBMeG7lkJStNBK3KwCR1pVj3BvxSmKsa
   xZtWc6LngExC/KVqrL1kl73UDirqgTkCU1qfAkyReF5EvP/EdtpIXgYij
   nzVemgEpkKgDBFIIfWDROKLt7jG0XotXGRtYFxOgdLr91W9ffPooOlK1P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365316392"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="365316392"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 01:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="4251199"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2023 01:11:15 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 18 Oct 2023 01:12:21 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 18 Oct 2023 01:12:21 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 18 Oct 2023 01:12:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5JLAmWqSp3rVWVTquAkHWBWgSVcfMpNNiFoiizJ7b4DAWTLYuJmaN3leB8mocNVZhokNA6MNj2UWPsPBWP0eHxnseJqUMvUcPLuVIZJgkm3nFleexv242iEEiABRdbJkeT2/wbg9PLp+YGW8NCjOzJBti1MJXY3vI+yf46I1kx+G9Pb820Ud1LBqXsDDQ1Wdxaf1r/7ISfiBSrglGETmgl+sLDOBoGkYONDdAYkmDo69owId7FhFGxX4zRcWepupd+OPwW3oqqsWdHed8SgICO0UXq1n+5zbK0/EGaaDPshgrA9AIr/C4hJzFtn9eu/mCAJFkRHPVJ0IWuqgRdHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+RQVyuP/W2YGVXoSoE76KFLI2BqsssZZvmBlhxqkcQ=;
 b=Dtnc6HU+szByknseBgaQUIoX5fe5HwgQbpaWekfFJKFRzVkw7OGVwPBRrkIFQWKvjZDVN3yt7xKd0YVGMx+TKNMk0MesGzqgwipwnk/7Zo1367KZdesM4gbST/5r/pkW32o3WigOD2R1JRVNXklylraw6eC6zvUVhIFlq7+JYoB13mvBcxMzYCtOYcQgI9JbwbKoiMeODqIdQ5VNj1BtMrEqjZXznOsIqMRGXVho7EUYkqqv2MQQwjUIR/m061HK8pZ+9HmO3YoAhGieW7ryYlgc7vdwjlV+VW+134beiUWbkEjv0Ww+Z3Hj/4hpfQnPhvyQ5InaBgTntmw6BBSBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 08:12:14 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d%5]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 08:12:14 +0000
Message-ID: <870b9b74-75bc-2a0d-7138-ae8df237f980@intel.com>
Date:   Wed, 18 Oct 2023 10:12:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] Staging: sm750fb: Rename
 display_control_adjust_sm750LE
Content-Language: en-US
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
CC:     <outreachy@lists.linux.dev>, <julia.lawall@inria.fr>,
        <dan.carpenter@linaro.org>, <andi.shyti@linux.intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-fbdev@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20231018080416.25931-2-anonolitunya@gmail.com>
From:   Karolina Stolarek <karolina.stolarek@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20231018080416.25931-2-anonolitunya@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::12) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|IA0PR11MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c13550-d433-4fb0-a862-08dbcfb1efcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9i9oVAxhbKbtgnz9ZzDWa50JikTlul085aCYrPvpM4Gh3v/stgZXhDNuSmY/AFCDR9Orbu0E1haObt4Zxi/pRSu36919E1LpKJMSTNyNhgHSHtRz8WwDi+BPJxfAGRYTHcfiLOeLHOMuC2gH9TLqaoT5EvJ+Px5W4GMPHucJWCl4DttIX9wkOFTdsmd2l7/bdVKj9irgkWprecxKIja+YUMkA9/U1rxkl2QRgkiW9oq4UklkGWNMBGcdf/hsgi1guE40y47iudQbv4bro4TWfxQ1C71ofupgXEtSWu4n2Gpgabz5nFsohapAiVJCrV3HsFIbuYdIlCb3LagvN8zxTavjXDUrvslgZpDXJgetPY/6zqaDCAUtMdTkRSiWZWwqYFVqfs7VIff8YYzAuTUbFXdRVzw7u+0KdrFb5CeC0U56SBuddpKlJM+cXuOViUEa/T61dvfwEi9kVr/WRayHciDYVrdUeXm8c6tHB0uJJdxDI6OTyjXEVpLPYZAyFMKI8/ackHtH084pfrLqvHiyMU62bUCoRkJJJU0QQWLxR7ujaMLrz8t0G8ysUz5wTmJnX/OKyhWlt4FMY/2+k2qYwhXiuGUP/Pdhf27gEvlnLu6rD8/Qmb/naMpBdwLEnZ+Z+lQruwVa4arjhCYW+1w6Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6916009)(66476007)(66946007)(54906003)(66556008)(316002)(478600001)(6486002)(31696002)(7416002)(2906002)(86362001)(5660300002)(36756003)(8936002)(4326008)(8676002)(41300700001)(44832011)(26005)(2616005)(83380400001)(38100700002)(82960400001)(6512007)(53546011)(36916002)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzI4MmYxdm93bWhJcitFaUhmUi9iMmdlSll1VzVZUlhlQ3ZnYXVjTGhJN3Z0?=
 =?utf-8?B?NHI4WmNMTnd1UHdZZDNOZVoxZWpzTk90Qlo4SXI5dkZMdU1jRlhuVkYzUGk4?=
 =?utf-8?B?dXl4Z3lHUkN5UUZFdFFvVlBvSFVnTE5ZNityMVN3Z3prTHU5cjVQbHNhMXRj?=
 =?utf-8?B?Y05OMnJEem9pbmd3aU1pQ2g2a29HbG1lVnpKbmJSVDN5QkVjUXdZVmZDK2lx?=
 =?utf-8?B?QnRzbndRcisyTXdSMnRZMy9tS2dvcndMQUdkZ0Z6NGl5V3dnL2JYSENyM29M?=
 =?utf-8?B?djdLaGtPRUFIN2FiT3UvbVNET24xdnhkRVdIMU9RQzZnQ1VLYTFRaGdGUkF5?=
 =?utf-8?B?UlZ3YitlZ1o4V1RKWldjYXNGUXJOUDM1dGtlK1hMRE93Q0w1QkE2MzhwL2xi?=
 =?utf-8?B?ZWE4UHQvZ01ubFVlVEJtSkVkS0Q2OGFkMk1TMEI0emhmNUNFeVRkT0paNEZO?=
 =?utf-8?B?SkZyMUNSQkloVHZiM2p4ZmUydCszZkEyZUtIMTUxWmNrRk1iRmphSnZqbXZy?=
 =?utf-8?B?UUdxOTJuR3hPdnFmdGVQWlRpZURLUGswMUlCVlFZcVV6dWtxSWZDYmMwMzBy?=
 =?utf-8?B?Z1RtK1BBbmJkTzRwdEloMU55Y1BBWlQ5UUJzVUs2OTI5MlpORmdLU2VHRk5D?=
 =?utf-8?B?UW1rT3d4dE4rV2w3emdVY2tvS3l6cGw1RnVCQkZHMEZEWFZQWDN6S3B3WkhH?=
 =?utf-8?B?cFcydFBsZCtNTXY3MWFKd1FuS3dCb3JlMWFFajFGeGNpUmRRN1Nic2tGZktL?=
 =?utf-8?B?NFV6QWR1T2wxcnRGY01LekwvVSsyYWxrVWR2SDI2TUIvNmRQTEJlNWhDOE1a?=
 =?utf-8?B?cUs0ZXlsb2dTdE5wem5QMmdKZmM3RUF2aGZHMHpDd3NqT0oybkxmdnhMZFR3?=
 =?utf-8?B?SEplL0g0VjllVUE2WmFwdEUvazMyU1Z0RDM1eGhldlc1U0hJY21JSnZNYS9t?=
 =?utf-8?B?Sm9NVExTYWFqTjA1QzhLcjBnem9aOXZsazZVaC94bkZ0ZkQzaEJuaEQ5MWpr?=
 =?utf-8?B?NWVjYXErSlpmbGhQYk10OXlvTS9JVTN3TnBuaUVwMjJkaWJOME1zeG5YcjJz?=
 =?utf-8?B?cTd5Vnh2Y0JJNGRkaWZWTWp2SVlrVU5tbzAwRzVCVWY5N05wMnRlMWk4QU5v?=
 =?utf-8?B?aEQ5WW5kT2FheWtpcnBuTzJzZG5zWUZvdjV6L0d3TkQ2MkoxK2NjNmt3dmF0?=
 =?utf-8?B?Qi9TV2tmQ29oU3prT09zZFBWSnk5TVFKUXNaSVl4eHpLbDEvM2hPaE5ocUE4?=
 =?utf-8?B?dkE1cnRqa0FnQk13b3p1NlR3K1dZOUw2dW13c1dhQzRjQm5DbEFIU0lHaHI5?=
 =?utf-8?B?dWk0QkRyaXdTUFVnQkZqM0RLS0VnYmcwNnkyZFhSdGlxUS9ZZ2dhVWhFQ1Ni?=
 =?utf-8?B?VTVNNm5aM3RqN3pQY3YzWExhUEVIZllZQWt5emxUenpaV0lNUmRMTTNsZnR1?=
 =?utf-8?B?dklHWUd1Y1BFQW4vU1RUT3dyS0N5eHhKcWJBeEM1UWFVQUJyRU1oWUlHREhz?=
 =?utf-8?B?aW96SG1TcnpJZm5KVEFzSjFtWFpiQTJzZjhhcE43b1dCWlhCRjlNckkveE01?=
 =?utf-8?B?WndHaXM3OXYwZ0trRjVkSktQSXBhRFdac3BzUjRTMlVCaUhFc1YxYm1UdzhM?=
 =?utf-8?B?WFhlVmlsOXM4QWVjTzhnS3RZOVJjdnJCeE5yeDh1T1ppNDNnTWtHaHpMd3N2?=
 =?utf-8?B?MkVnVnA0c0lja0p3dDdwM3JUTEdCeWg3OFZjV1dDTEh1a2NkdS9FcW5aVjlQ?=
 =?utf-8?B?L01iZmsxNFlUeFBhc3hhT2YxTVVteEtxREplRzBHV0R0Ukh3QUlSc25aV1Aw?=
 =?utf-8?B?NldqbXlONXdyOEdJcmlkbW4vWHVXbkVyNi9mdVMzekRoY2s3N3dqR1I5NVNk?=
 =?utf-8?B?NDNYeFgzaWt4MnJCTmNMTE4yOWxOem1LWmpkbWREN00yb1BTRjRwTlp1TFVw?=
 =?utf-8?B?aFdvZzlrNlhFVm9Zci8zaGROVFJhZVNnYkg2dzdQaVZWUGNPSXhUSDVvQWR5?=
 =?utf-8?B?M1pOUks3eFN1d3JBcWlUdFR3bUpyMkVkWEROYm9OdHJDSnN2Nm1WbG9BSTh2?=
 =?utf-8?B?U09zbGZEWFFjcWU2dE4xMUtidElzSkIwTURjZWtCVnFabXczeTg5N2UyOXN6?=
 =?utf-8?B?VldWc25kYUp0Y2l5R3FaUTVjSkRBeWVPYnd4VStRUUhqQmtjcXhBWjNSNWtM?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c13550-d433-4fb0-a862-08dbcfb1efcc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 08:12:14.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: luyU7jF6dl14tydI2TMAoJm3Mu8mrAKyRbPoK8H9eptD4gpfHkIz26glZbxSznDyyRzaZlVKc2QtRzoEEv9d4IhgQS47GtsqrOSwcOjJ+ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.10.2023 10:04, Dorcas AnonoLitunya wrote:
> Rename function display_control_adjust_sm750LE to
> display_control_adjust_sm750le. This further enforces snakecase naming
> convention for consistent naming style throughout entire file.
> 
> This change was suggested by Andi Shyti <andi.shyti@linux.intel.com>

You can use Suggested-by tag here, if you wish (as per [1]) before 
Signed-off-by line.

In the first line of the commit, "Staging" should be lowercase.

All the best,
Karolina

-----
[1] - Documentation/process/submitting-patches.rst

> 
> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> ---
> 
> v2: Correctly spells Andi Shyti's name
> 
>   drivers/staging/sm750fb/ddk750_mode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index f3f354831617..bcdd291d25c9 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -14,7 +14,7 @@
>    * in bit 29:27 of Display Control register.
>    */
>   static unsigned long
> -display_control_adjust_SM750LE(struct mode_parameter *mode_param,
> +display_control_adjust_sm750le(struct mode_parameter *mode_param,
>   			       unsigned long disp_control)
>   {
>   	unsigned long x, y;
> @@ -125,7 +125,7 @@ static int program_mode_registers(struct mode_parameter *mode_param,
>   			tmp |= DISPLAY_CTRL_HSYNC_PHASE;
>   
>   		if (sm750_get_chip_type() == SM750LE) {
> -			display_control_adjust_SM750LE(mode_param, tmp);
> +			display_control_adjust_sm750le(mode_param, tmp);
>   		} else {
>   			reg = peek32(CRT_DISPLAY_CTRL) &
>   				~(DISPLAY_CTRL_VSYNC_PHASE |
