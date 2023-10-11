Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9738B7C589C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjJKPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjJKPxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:53:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847D8F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697039621; x=1728575621;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=y5PkXtK1LbkktUu4kCFCh+gR5vI2cbZVexpyVAQOHP8=;
  b=Ik3PZ0zfISi7h0cijXGQe3ejD+arXd7Jlj7+xsHTsQMmvT5UdBwjL1TF
   X0mTthJ30mQBgIUGjFlkADrfvbtyTlYVRD95OaA3r9bDwOWTBlbO/lYVe
   Vs/do6564L7dHcQ3/SRsAnYIeXS0p9ppZSSj/pwYRnFu9N44T2jaXOOTU
   sdasQmXTScOpSTT3dc4nNwcDigR986tu+mMsSTaSYfQelllCj3lhuJe/b
   JfcTRUzCKnPsm/Pe/3iRP0XiPJ7AAnk6CXD3V1vRCfBSS4x/5jlUpBHrZ
   JAVVmGk3yJuJNBN11qXMVFHlDGk0NTTG6VlhshrkEn+ewU05XbVvekpQm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="384545838"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="384545838"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 08:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="870202831"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="870202831"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 08:53:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 08:53:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 08:53:40 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 08:53:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6P5TVzN88GfWO/+7aL6hV1w1WtL9uVhtZZyNvoFQTXBOWv9n3oI5hggkcXszmwt/cSIVPXEik4pf6iGTFOjpnPOa3kuq7GUM0zg1tzIhLPIZJDr+3NG5Yfzwh1mfiFeBun1XYG5d01nx6hvGKnhl7fB8sCv5RFH8m98/fz0mqRBc2p2fmaFjovY5B9CVn47QHwSj8IzyzVdyBeLKPf4IvGgw58qkQTeIZ0+0Zn1mvVinyYA5iJwQxGDnstAIGPgVZYuuSLjC4+W/cdX6tIX2eoEfhS6WbijAOziPYHnU0ao9mRyDkjheRXnHfsEB4RR0w2SXvbRAODqXJQFqvm2Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhnaDE7dH5SeDNmSRmk3CzfJCubY4zPUqMujZtPUV44=;
 b=jPELTf/c7NFjYtUJMymT68ms3bLFovGF2wRX/a4dEfIgS+ksof//0XvtY4WYcAR62yO14+Ia1IHSSKzOwchBwpqR+jrr+03qc7kl88ko53sM79zfCoMp1WqeomiTSL1znoejkBkxGKurUCTcjDhe1/7SmTA12uTue1ygXsdQEwpb02IVfYDhEINmZPfqHCCiwel3i++6joidAQHyFxZZqSKdM31Q4MynDbwXgE1SX4D99s5ncT8w6gqsnwWL4mPQPEliKtMiyHcnkdPQLBS5sZgsBsVJb/0mgGYRFjnLe3Mt5E2lKnJb+6MCosRS03cbJ8WU1pglRMPtqhVFEHzJow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6371.namprd11.prod.outlook.com (2603:10b6:208:3ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Wed, 11 Oct
 2023 15:53:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 15:53:37 +0000
Date:   Wed, 11 Oct 2023 08:53:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <nvdimm@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [PATCH] testing: nvdimm: make struct class structures constant
Message-ID: <6526c4fda01a7_1db8e6294bf@iweiny-mobl.notmuch>
References: <2023100611-platinum-galleria-ceb3@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023100611-platinum-galleria-ceb3@gregkh>
X-ClientProxiedBy: SJ0PR03CA0121.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6371:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8fed39-e429-47c0-c185-08dbca723b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TD+kzK+a/nQ2dq+bkAtL9KitvJPArSi1iZ7eOLDQucyLk+KvUC1wTuqvM0BDv/RIlAcmu5XPvngc/Evzr+wdunGean0voCdBg+thT4c7+e281d1hZjeHkYq0U7Tr2DZn7BDzRoQesKKeTyQJI2kgscoDRCdNJmU2yljzrgsjzCKsVmmYXtUFIyXnpKXbAEV5ZTmkaAf+9bINsQw5JBAp77kB056ZLQ8RMPPbIc0iUfE2F3HhMj+rnZrSsHnnIp6QldW6Zwt8T8wNkB6Y+6bohUy8dKOJ+4kIKuGw0Bkv8uOHYHOXd+0PRZAWvF9ETOb/sbGDB70eryRl/yanxGXhF/1f4T9kKkMdt1FKKsaY2eSw8PpGZJBgTomvVFXw7oOxhzmiC45BxAyz2owFbvlmcOtaKBPGRxy18h3iT/fOnyXcqF4JCBYeNUJW9sY+ZicNlt9olWNZSQmYgsVUo7anWKPpd5kBzoAZDofNyGlUplzlTHHn2w/JoGBtMsUbGiT4AZ/qEJz1wp8rJ9miNYiOnxVUGrL0HN69ePZQDBVQVr6nezzk/GP49N9dt7RRObCQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(39860400002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(86362001)(82960400001)(38100700002)(9686003)(6666004)(6506007)(5660300002)(6512007)(44832011)(4326008)(8936002)(83380400001)(4744005)(2906002)(107886003)(8676002)(26005)(41300700001)(66476007)(316002)(54906003)(66946007)(66556008)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QNXF3zcIml8QlZoP5P4i8i3W/VgKgH3kKbnVmmYD8P1uV9EDK8rmtTYIoptK?=
 =?us-ascii?Q?7zMh/owfE5m9a5TDoH2AJbntFacV6gBI+rurWtaWx7ZQcL+E0adJjQ/I672M?=
 =?us-ascii?Q?Gvkoh4CdwUyX6X9wbOzOlseNUuPhIg/SXyEJXIhLlPRuO2m/F0LsQjqKlEcq?=
 =?us-ascii?Q?0LyHHT0J7A9YXtcmEqrJe+WM58VClpwOk0AWdPX2rmAcFy5VYvpHEbRPvycr?=
 =?us-ascii?Q?6NBUBeG4JHHmA1qIVN9PwjTBS1NOAk/XFgEnWttnOLstT1ZThKmCVZy+bJcd?=
 =?us-ascii?Q?5OpPdPSzHg4Ru1sJ+s88QaGW6DdSOezntiDn0lWL4kXtlQpyouLGtJ+2FiH8?=
 =?us-ascii?Q?iCnh3W+z69q1as0aU/WdO8Y4Jl04BcVqMXHcAyeTSWt2aSvVuguFRkQSxqTD?=
 =?us-ascii?Q?tRSpsiTsuMN6ZazpHqJ9zn6Iq4JHS5GUwITjHk9t0NWyBCbh4seD5jGRpDtT?=
 =?us-ascii?Q?qX+O5/0GlgNyB/hmsLM9TD114MZQiyJxMiIbSN/NQXioz+HBrgeC+pX10Dq3?=
 =?us-ascii?Q?/gCMCYyj1rSyA+IP25sVG97QNwTXJa9SU0dsSxhr5BK/AJ/46e3CS/ZNkBK5?=
 =?us-ascii?Q?3geO61X/0S9cM7B8VUSuQZI2opPXtZVSxlVi5cZsYBIy4dd1x3K77S/vR4ek?=
 =?us-ascii?Q?V2ghOCiODhh2CYHpKZ0l5Grxs176CN0Yhw3HOLeNTfnqpqq3RpwvCMycEg2e?=
 =?us-ascii?Q?/lypXvoVnLFm6/CLd2MnsyCVrYzLzxDxNmPig8tSJOm0ThHJ2pZA+9ILHxej?=
 =?us-ascii?Q?2MtnaDryEhAe5LqkzYAaB7TEgFgr4veEARrGbk1gRZgXiR/ewSxedF6u8Vtr?=
 =?us-ascii?Q?NUNJQZKK8r9gKkYhQv1LjLgSHmRIgzOoFLn59EPOOtfAGk752ADYNxV5OF+w?=
 =?us-ascii?Q?l86QJlkCbWfnhvI5oneaPMzLeetRVm8xhyI68jUJg8uRVWZM6TQG7disIBeh?=
 =?us-ascii?Q?KKDmhnJjP2KlzD4/LQKm1pd5//wFZLHAnbJLEPHoF4VBBy7Bw4y3My8/9nVe?=
 =?us-ascii?Q?BCjP+BkPlFcAB0GN+va6dsggUy1dwrcdlsAZfe1pe5OUt99K4QOkjl7anubF?=
 =?us-ascii?Q?NZFYAbLg4jg20ZrMUCOO0af14IokliRDitnMLVVrLZ3RNlRfqOrmUkz2wtOs?=
 =?us-ascii?Q?cUIcdrs4o/L7VOYX9FUQc8lqqIFlgjS6btQnCCjWZgTXmkRD2H5YkyLXPNmj?=
 =?us-ascii?Q?4b2np9QoJ3rHdvYJDvg8EFfV+hHo3SoMpi8x0+bewfmkBr2J0leQFMXr7rzm?=
 =?us-ascii?Q?DrjS0Xk8EO3zmRBtX9Vhr/nrRM5yVBCxDVoXFrnv+U0H/UAkir7Iw+5Gf8st?=
 =?us-ascii?Q?3Yf14tQM1Mp9I0rLgwylindHwrtICMywK+3Kgh/c2cCFsPwd9+qYqsK56UgR?=
 =?us-ascii?Q?QzEyxGHwzYe15tAB3k3R7NgL0PvyihXaaGe+HqDG5kIcWtSrGXtFCVbkJzht?=
 =?us-ascii?Q?Owxwsbp3psz2uXZNYNX0ORo47akQOpipJWCGvGL3BIqgqqE449te3EFHwHSb?=
 =?us-ascii?Q?99QLqD4fQvpHMVV+ueNT+04QlKCDySoOVc81vFCW7GhaUsunAiVyzcLS95Ff?=
 =?us-ascii?Q?ZbMlO+HuEHH2rxvZ69ohQzlKvoew2gXinIytk1mI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8fed39-e429-47c0-c185-08dbca723b4c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 15:53:37.5634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pkbKHpZBPlGqEGKGuqIr8703dEt+J3n6GIWTrWjwUwuEMoawPs3U3WVhSEF3Y5WHUi8vsSZLVl8+9rsIA42PPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6371
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>

Tested-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  tools/testing/nvdimm/test/ndtest.c | 17 +++++++++--------
>  tools/testing/nvdimm/test/nfit.c   | 14 +++++++-------
>  2 files changed, 16 insertions(+), 15 deletions(-)
