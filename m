Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3F37CF5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjJSKze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjJSKz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:55:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766FCB6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697712927; x=1729248927;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YMbCnEtJov75WdABPe89KHqXWXCdKpDB6vz6W3xtJ7c=;
  b=JNFc3ZCmhZcgPYBbyTyh63QLFQxyPKtbtehjIC6y7aDbMlEokpdJHCx4
   dsWT9tYyUi8xf4jDGwUlwhs+rZlzgS8r3CPYDk4dL8+wZzoq3bikCvyOy
   rUdPht6dsFdazku7+hbewrUBknslcpzgxW0Q17uct2BU2g+a/JxU3aR7B
   dgDx+4P/EYNZ2OR3v5VXY0+j9rKijfoOxw5oJP2BQiP9CMUqDzkiXh3r7
   Hr5x6E7K15+KONPkNNZyjNu/IRx7GB6cNac0l6nQxpVGYP5lpHOmOG0Rl
   9PwBdGtczE/hp+XJVgRhNfKrcsKG5i2qvJH7D95/IDZaxy8CDR3eQPUTC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="365575022"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="365575022"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 03:55:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="750469100"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="750469100"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 03:55:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 03:55:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 03:55:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 03:55:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhskttPs8GlQobdiDBPiuG43GXdt9t9ibLPbni22Z3P7wTf9d1zajZsUdC+dpaec8CYL11WjM/QrXtMrpewemyrFJHH6UztsDH7+oSLZEQrgeptm052oMrA7DoTNSQcQ/US93LEwEoQV62u1QazMZVbtMMXAZgH44HXNsyz0Difk00vgzNRSpx8GDQmzmWjYj3FULq9FUlifxd33kYjPMBDKGd3Ma5SLarNTxTvLKXGfoCm17k8tRoan/B6A0F/GSJXScpXXOmRrEUlxfeZZYbQm7re07IOjwiZ55jNV/uki6TtH5PK9FoduPxoznnudKNSnxYk2G9l4hhjztExHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6YFt5sOcFC6WEC84jTxEIp4l8/4xIUcHU3aj8d/9lQ=;
 b=YFCZZvtbkfHZsw2ziFrlbrGDJEmTfPigY0DWv8/SaAuAPq1mL5AE5Crd6kciL4Jc0zYiHdLcdgzDdFJQTWjpyx1BkXfMOsPR6o72yPA2Vos9rKgQ69TNtGqi+nFhZ7VZsZYo1/rSk6VFpr7OHdbim5eBD00H+ulZr50g1OtV7D/TzxXAZKVN1noZk9pSSJmPo1yTRQiky5dFTgoqY1a7lxs5ZZ9XBZNqp4cCqZjcKnYcUKm7fnVePIkP72cJ4ofP46zUSgTjM/jy2Mxp4xfSYwTg5gaBVOxbRWFxo8l9bEkvoDaw9NTK3WdzkLWm0LRujJqBKfK2//XhtFbzKqFZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4243.namprd11.prod.outlook.com (2603:10b6:a03:1c8::16)
 by PH7PR11MB7606.namprd11.prod.outlook.com (2603:10b6:510:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.41; Thu, 19 Oct
 2023 10:55:20 +0000
Received: from BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d]) by BY5PR11MB4243.namprd11.prod.outlook.com
 ([fe80::59cb:e244:fe8b:184d%5]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 10:55:19 +0000
Message-ID: <93a6d8b0-140c-983e-1b78-6f5a4e03e62e@intel.com>
Date:   Thu, 19 Oct 2023 12:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] staging: vc04_services: remove empty functions
Content-Language: en-US
To:     Calvince Otieno <calvncce@gmail.com>
CC:     <outreachy@lists.linux.dev>, <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <ZTD677iqMkRPxT27@lab-ubuntu>
From:   Karolina Stolarek <karolina.stolarek@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <ZTD677iqMkRPxT27@lab-ubuntu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0402.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::14) To BY5PR11MB4243.namprd11.prod.outlook.com
 (2603:10b6:a03:1c8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4243:EE_|PH7PR11MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 304830a2-4aa3-444e-8219-08dbd091e2be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HHxcL1S0t0/0WNSmUi+fPHz3aVN2zetRZLKTN7UovgxLGqwfi6SSexPJLJq1jw9oHKfBjtvY9vnNdOs2URpL+vTXgRUPefwXU7SYcnS5S48sWoTWXcY035MR3pdJ9iK7Dp0dJeXsg4gHVFNgIPtT30io/i8gbNHVMjZYZlsST4EbPkrneRSLTlHhQhtOhnXY0AqvLw87WF6Ml8nN+QZMwO+/htZV/uoJD2G0Vmu9IuySDWD+0C3OkTJM0oioWhDEJvA7Yvyfq0dIh+Dv5kV9G9A53RiGYEslrSEHSTH+5xc1zwZuMVrroIbjmWYMFYG+yVQZX1VWAqn3RmJdV2/QOV8kz/q8damlnZw1OO33x4fzS7shxDQ8qoNMbkyN6cV0Z+FutMYUtr8FDnLprwvXsvqhnhNTzzmg6WZvN64mDYuUSixsI3GGQKcVQ1pb01/xiTD69aKZz01sPWJwuwywmeTOUCmh2mFDS0zR4/zTcqcg8lhp04WnQzU2JTLy6T4QWuha4k43Ysc2Hlqai9My3W35XfhqsKHfBSSD60Q6VcFqNg5lN5pOZ4hborfqNV9YGQ2/TeoMxb+mjA3O2aPfD0MfmloTZcHimgrBS02e6guDphniGUCU1eJtQ7ugC9m1+B4yLeD/YLWef+kG7q216A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4243.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(31686004)(86362001)(31696002)(38100700002)(6506007)(44832011)(41300700001)(36756003)(5660300002)(4326008)(2906002)(83380400001)(6512007)(82960400001)(36916002)(53546011)(2616005)(6666004)(8676002)(6486002)(478600001)(8936002)(66946007)(66476007)(316002)(6916009)(66556008)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUtkV2JkRTQydFVtUWtsUFVZMXdmMHQyTk5wTEVndmcrU3NVNDU5clFwQkYx?=
 =?utf-8?B?ZVpUeVhvbmFyckUyZkMxd0lPNWNoZDBoR0I4MnZEdjNPMitvQ0dGQ0hvVG5w?=
 =?utf-8?B?aU5OU2Rub05YY2I4ZERWTDhFeFRXcXo5WUpOcDFTYXJjRjQ2UksvQ2I3NzFr?=
 =?utf-8?B?YnpQVENWcTYraEVCWnRub01BUzBNQlY5YVpISjdDNExjaFFuc28rRWJGY0Va?=
 =?utf-8?B?VVdtaStCMGNteW44M2o4N0FQL241VUplYnJhV3Rjb0JPVDI3bWI5TXBoeUxl?=
 =?utf-8?B?MEpFQWxXeVpVQzFBZC9HVG9XRUhrQWcvR3cwc2ZNL1dFdFIxamQ2Z0V3OURS?=
 =?utf-8?B?UGpCNzZoZTQ2ZWRDZUdQdlpzL2s2bE9ZaE16R2RoQW1LZURLNFRHT0FGdTJU?=
 =?utf-8?B?dlQ1V0FvVFQ1a2xpUE05a280cGVKNTE0RmUrNHhkSjYzSVVGcXhOaHcrcDdv?=
 =?utf-8?B?Um9VNUdENWRORDR2QTNzcGFqUkxwK3o0VHBQR2orSm1DeXptTWNSNmJKUlRi?=
 =?utf-8?B?emdmTE1ERnBhRERZLzVIb2JQR0RtRUdFcmJ3Q3lmWHdieWg3QTZvL0NkVmsv?=
 =?utf-8?B?cVBTWS80RFc3NzVKc2REblQ3ZW1aYjZLTHJjZHJhUEgrN0VTbTZSSVRZb3lN?=
 =?utf-8?B?SXR5QWp3NDRreXpTSEI1QWFKYzZsakNTL2x6YkJLSTZ1TUhxNDhqek9zRUZk?=
 =?utf-8?B?UVRnRE5UMnJzR2JzbzF5bVQzendEQUY0MzJNaDFzL3ZvUVd3WGNwa1g3LzRX?=
 =?utf-8?B?Q1J6RG1UbGVRcE9ZMGNDYmdGQys0N3dLZit2RFo5ZGdhVXlqOW1aMnFVT1g2?=
 =?utf-8?B?TG92a2hhOTZIU0lydU4xS0VSemFzc2J5SjQrS1I3L2NDM3VsU0hBQjdaTDc5?=
 =?utf-8?B?QngzT01DR1lzd0JRaC9RbGNMSlZqVU4vdjQ1ZEFGbS9nYitrTnlYcHZWZ2pV?=
 =?utf-8?B?c2YrT1FRTnhlNDdSMGgzd0psOWZLVzdFdEZZTFhyN1R0TTRQc0thNDVCdHhu?=
 =?utf-8?B?QnJrTnNOL0ZCN1BLV3orekhCUnJpaDVkWWtHSW1mWXl6WnFsb3I4cXMxOGZG?=
 =?utf-8?B?OE0yRW5MK2JRUXdWcjhpb0pZYm9WRTBHQlFRTTR2clp1NU1FbEFzYjdnbGs1?=
 =?utf-8?B?SUhmL3drOVUzQWEvenFjdmJaUFZNaERZSzI0TXEwS1BrTWk3cE9TakZyQ0ZG?=
 =?utf-8?B?eHl2K0kyUGU0UnhXeS9UUUs3YkdKZlplcUdIWG45MGZzNlFjS3pjVXoyTk41?=
 =?utf-8?B?QzdlVVg2TlhpMnVhdlhWendTaDZUWmFvUUhzbzV3UnhKSkVWWTZSY3hYRjVw?=
 =?utf-8?B?YUgwK3ZtSXg2emRmV3JBeGVRbm9ZbG8wVHJDVng3ZzQ2dENoRGFDY29oaUR0?=
 =?utf-8?B?VGxZWC93bUdRMW5ZZW1XTGdMQ0NYbTVEQ1lUQ3poUWU1a3cvTzhGVzlVdUFM?=
 =?utf-8?B?SmtnYlo1dkZYcXhXN2Q2R21KYUhhSHJYTE1XKzdkdW5peXJ6YnVQUGtiUXgv?=
 =?utf-8?B?R3RXUStJekowSld0RmxZemVrZjVjdUdQWk1PU1lxbzZZY3dWNm9OYTNhbmdC?=
 =?utf-8?B?QVc2WG1IeHIxckJQeThFT0hyRmhwdzNDSkpRQnlWWmdFNWx6MWdjM3p2TEJG?=
 =?utf-8?B?RWJPREYyWnNZUWIzbmdtZXpPWkM5VEFOajRkSnVmT25aVkVLc1ZXOUVZMmhS?=
 =?utf-8?B?dnVZdnJWOXFuOGx3azZQNUY1WlBxcUxNSGdCWDFET25pNkY3VG9nQWtmZnhr?=
 =?utf-8?B?UjJOZ1RsckIyNFlPWjdzRS9JQjE0QzZDejg2SVE0cmRSVCtvcDNRVUJOZzRl?=
 =?utf-8?B?b1R6ZUcvNURGelFyNjlmRjhQbUVEVmpKVWhrL2NKVmlCR0NwdlM3eTUrOWtu?=
 =?utf-8?B?cmZQN2ZPVnJpMDlaZE1Qd1luYzZtUWl0ell2a0s5S1p3d3lzdm9BM3d2c3Nk?=
 =?utf-8?B?b2pKZlZtaXY4Qm91TTQvYTZrdnJJSVRhLzdyL2o0dGNLWkNacHdWcmxtNThl?=
 =?utf-8?B?emJJZTJZcmpyTjhxTU82T0owU1d4ME16bG9EbnE4bEpTWjlnVG13dnhxOHpH?=
 =?utf-8?B?WktWQjdZM0NKeTFKWWRRYlFzMHJIZkNSR3piWmE4QzQ4Z2VhVzl2bzdFRVRO?=
 =?utf-8?B?TnA5WjJ3dlM1UlVkR2d3eDdCYzRjZFRhRUFCa2JWSVNITjA1SzJDc04xOElJ?=
 =?utf-8?B?VmRQRGxZMUhmWVUzeEtyUnJBZkYwRFdPTGF1R3NjakxmTFVXeEJ3OWpmWU9s?=
 =?utf-8?B?MGJaUHYvTEZKUFdUMUx4eld4eklRPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 304830a2-4aa3-444e-8219-08dbd091e2be
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4243.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 10:55:19.8686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtRRntWpnM2MertZzE/pu2GJiYUXHkwNgYF8vrm1NLrv0DD+nbKKI2BurOXAWfHGuYhxyqF8j9teeEuHi1d6IEohvKmwc36wGHiWDSgyh0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7606
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

On 19.10.2023 11:46, Calvince Otieno wrote:
> The functions vchiq_debugfs_init(), vchiq_debugfs_deinit(),
> vchiq_debugfs_add_instance(), and vchiq_debugfs_remove_instance()
> are declared and defined but contains no code or statements.
> They do nothing.
> 
> Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> ---
>   .../interface/vchiq_arm/vchiq_arm.c              |  3 ---
>   .../interface/vchiq_arm/vchiq_debugfs.c          | 16 ----------------
>   .../interface/vchiq_arm/vchiq_debugfs.h          |  8 --------
>   .../interface/vchiq_arm/vchiq_dev.c              |  4 ----
>   4 files changed, 31 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index eef9c8c06e66..b802d1ecc8f6 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -1806,8 +1806,6 @@ static int vchiq_probe(struct platform_device *pdev)
>   	if (err)
>   		goto failed_platform_init;
>   
> -	vchiq_debugfs_init();
> -
>   	vchiq_log_info(vchiq_arm_log_level,
>   		       "vchiq: platform initialised - version %d (min %d)",
>   		       VCHIQ_VERSION, VCHIQ_VERSION_MIN);
> @@ -1838,7 +1836,6 @@ static void vchiq_remove(struct platform_device *pdev)
>   {
>   	vchiq_device_unregister(bcm2835_audio);
>   	vchiq_device_unregister(bcm2835_camera);
> -	vchiq_debugfs_deinit();
>   	vchiq_deregister_chrdev();
>   }
>   
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> index dc667afd1f8c..7e45076e5ebd 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
> @@ -228,20 +228,4 @@ void vchiq_debugfs_deinit(void)
>   
>   #else /* CONFIG_DEBUG_FS */
We need to have these definitions, so a kernel with no CONFIG_DEBUG_FS 
selected builds. Have you experimented with this config with your 
changes applied?

All the best,
Karolina

>   
> -void vchiq_debugfs_init(void)
> -{
> -}
> -
> -void vchiq_debugfs_deinit(void)
> -{
> -}
> -
> -void vchiq_debugfs_add_instance(struct vchiq_instance *instance)
> -{
> -}
> -
> -void vchiq_debugfs_remove_instance(struct vchiq_instance *instance)
> -{
> -}
> -
>   #endif /* CONFIG_DEBUG_FS */
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
> index e9bf055a4ca9..76424473c32b 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.h
> @@ -10,12 +10,4 @@ struct vchiq_debugfs_node {
>   	struct dentry *dentry;
>   };
>   
> -void vchiq_debugfs_init(void);
> -
> -void vchiq_debugfs_deinit(void);
> -
> -void vchiq_debugfs_add_instance(struct vchiq_instance *instance);
> -
> -void vchiq_debugfs_remove_instance(struct vchiq_instance *instance);
> -
>   #endif /* VCHIQ_DEBUGFS_H */
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> index 841e1a535642..953f39f537a8 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -1185,8 +1185,6 @@ static int vchiq_open(struct inode *inode, struct file *file)
>   	instance->state = state;
>   	instance->pid = current->tgid;
>   
> -	vchiq_debugfs_add_instance(instance);
> -
>   	init_completion(&instance->insert_event);
>   	init_completion(&instance->remove_event);
>   	mutex_init(&instance->completion_mutex);
> @@ -1297,8 +1295,6 @@ static int vchiq_release(struct inode *inode, struct file *file)
>   
>   	free_bulk_waiter(instance);
>   
> -	vchiq_debugfs_remove_instance(instance);
> -
>   	kfree(instance);
>   	file->private_data = NULL;
>   
