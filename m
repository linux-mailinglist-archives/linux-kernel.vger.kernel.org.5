Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD18A778244
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 22:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjHJUlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjHJUlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 16:41:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389151AA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 13:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691700113; x=1723236113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=yUvuPusQYSwrZhybQUi2wxaLGfzKhCc7fH2MnQGenzk=;
  b=Vs4EZ9Cw5qi7IwG3GXCiYGdBPcF1NNxttLbcU71Zegt03uOCJ/LKEDKK
   QJWyqhBjY+RbwMnBoeOSuYc6BdyLOJeEYaa54sCyEQ24zlw7+Sg8odzJA
   +SA1qpXtZmRRxDn/54ANj0rVuFuBiUsaRMvn2YXYap0k+dYFJnByRBk8w
   B39eCQMK31vkVDSx4ZL5NN1pPCoiQ6tiTSAOkVAuyQXBcm0rI1kE+EotM
   gOD3M/bpdG1kQ60pFR2CEbc4F7fOY/tZ3vcnY8eE8XAaDQLfu9fKsKKGw
   9slqlq6csmjZB00HTjWUS2wsIWETQIeSYokwZ9dWTU5bHbR0QeyLTUv9y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="368992879"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="368992879"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 13:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="761930197"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="761930197"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2023 13:41:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 13:41:51 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 13:41:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 13:41:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjpDWYoRS8gzz6JDoeNBx4ZgOTEH7cKFb05TwS6QIVltj7b8IBdUTsJUy2btBXbei6655QeZkA10jigvCM58BBj6xoFhFgZ+yGkLqyX4KnublqZthnPd1pffSB5g3/6YfHlS0vdNhSyJ4Zt0OqsLw+GIJy8M0EhmdxDEBXjF1PBteRaEkkC+FdLTrYltHIpbqMDaEeZflCAupfHPfEgxD2MJdjbatQysR3xLMFnTaEhSxmZz0RIw/kitpGcQA3w2eNlmnY6Du/sOwTsf6fD+8bZ+5txG6qMDmsYgP/+Fwo8O2nFhOWvdhzvOflsscb6E8r/TmwtcjYrFewcbyOsoXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+BcyG1GG6rS/Z5lNtj/qsqoFzzjgmTnfdhO3Ty87zA=;
 b=QsCU2tsCkdQqPzqo2AGHXpfl/bMwtPSGeB1sixxYsGwzoA5DH7etfSYv+XczdyfVNvf8QjiOxO9PlkWP/WqWyoAF8m0QY5Wp+xWTjVRQaZn18vVv4BmoCr3llOtk0Alyr8iN2yhw0d4Du4yaqs7ZaGNzksQiMTUEnBzvcxlTFz5Wj1q2frfft2L4JXZxYrpNR0ag9b9qW2TtCg/A+TgySp1OJ3Xe37NmZoz1oVzuxS0j5po4ns4Livj3E5Nl+JcCoG1MCoQ06Ov+fPfUd2xGGaQU3TeGWZ8KymuSyLdIfNNRMa7flZ55cbXtVdlIXoQZT2UDfZDU1IYy08nB0knrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 20:41:49 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::1583:5154:e7bd:58f]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::1583:5154:e7bd:58f%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 20:41:49 +0000
Date:   Thu, 10 Aug 2023 13:41:43 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 02/30] x86/microcode: Hide the config knob
Message-ID: <ZNVLh38eq8TWHFra@araj-mobl.amr.corp.intel.com>
References: <20230810153317.850017756@linutronix.de>
 <20230810160805.081212701@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230810160805.081212701@linutronix.de>
X-ClientProxiedBy: MW4PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:303:8f::6) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|PH0PR11MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a89113-0230-4243-8aef-08db99e23891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8rlRzJZ+bQx9SgtRbxCmG2WF6+QySWXCDfObEZFN53XDA2k3iMlWnUZbagcI5EOp0+TujL03QJnFlnpuDd1FMcnd5HE3/iT1uqV7ecrlmpYTPdB7Xp9pljgok1uwliFzA7UnclbVgAusdFsg2zuH/J7WgXDgKhwdgYcmOT9+T780KAH/0ZCbirLEW+/Yj35ma09sEpg1kqu7cbaSnuTmUUvy2rYs9lUXhqMX9BvDG4FOQH8o2yObVWYqW1dUAcGxuJybaZG6iQsUvifA9Kna653zMDkJl/mWghq0v/hnn9sEodXUr7gfH8ZSOjxIKkZ3uMvzsdAogW/Lk1QbPqSKNKdSS41tRk8kf6LAQTg+eNCVHJRv8CnTgjyZX9jGhLYYKnpWM5o6tjr4/hAPaZrVxK9zDOBpuNnA1k2rwkjSxqbz2gZgR3OtpPRX+O2mrmvHv9XhJqHfKvFItk9gbd/o5f0CsKm7fZRK96nl9RhenJaMDvvOLGrrqJ/ho5wsar2YKDMBRGAiVTpZUT1ma3pK5OYRcx1Oeuom3s2x+TiS0mtCKGevYxK0PBNgRsiKZFt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(39860400002)(346002)(1800799006)(186006)(451199021)(66946007)(66476007)(66556008)(6506007)(4326008)(44832011)(6916009)(26005)(6512007)(6486002)(6666004)(86362001)(83380400001)(478600001)(2906002)(5660300002)(316002)(82960400001)(54906003)(38100700002)(41300700001)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zYhrFPBu1or9hl2CWeRwxsctbUjt8tCGIl2OOi0xMddgL63QxDGT8/V7/aBv?=
 =?us-ascii?Q?c5tmkHJjRTFGg8kpC+LHT+hSX9stf1vg1mjYqYWF/jF/8nt3SP704PdXfcsE?=
 =?us-ascii?Q?ZTAcAjf35TJRmUI+h+AWOfFkJkLDsTQR1DqWnFMgX82uOfxP/7SXDcgJl+gX?=
 =?us-ascii?Q?kJiBdzIDReQ8mmGOMUixQ+oAEpdsrbp+K/3xULAETSIHABKm45AUQGxRnO8m?=
 =?us-ascii?Q?fwGUeaZobTYgfE5gRZPFoCWyA+pKoj0oFGh1d+v0GwoJ6PXIJvK4v1n3gBEG?=
 =?us-ascii?Q?Q3EP3DaboeRmMDrz3rL1ue98in1Q/AjYsepi37n1hT948JDdCf70nUle1QV+?=
 =?us-ascii?Q?9cQjBsVe7IiYd30n31QHlOSshB3KXs4ic+1bM/cKd6zju7jSwnuyRsbE9pQe?=
 =?us-ascii?Q?aQR9atNJylQmKl96j5Tn4OHVYN9YoaCzdTh0NMlCAV1CvfBjeq9RUBIOE8BH?=
 =?us-ascii?Q?muJEDTCE2qfVAms9qg1Z4zXrhVvocb+Z85GXnNCUkHXcFkKqFz9Z8y/qMIbK?=
 =?us-ascii?Q?F+9IH2NGcpIl7veJJc9xk73C4XJduBhzJr56dGxJMZyV4gmLjZJAVp7kpaEt?=
 =?us-ascii?Q?rnLBbpzEDrO4zkLPdNbvaMMkUnApNL+sRyap3XmX/DRN1G185hYcIhwsONNt?=
 =?us-ascii?Q?trqgIlirCZcoJq09HNJMaosW09ebM8R5SPgfMj9+hMXVQWcnqmoB9nrASY/R?=
 =?us-ascii?Q?Mpz6KRlZ/ncEMRaguzwzIv4rXyaZdfmjZTq24j85JAIj6pANS5tVGaimN0Um?=
 =?us-ascii?Q?Cs9gDgBu0hqnH95lRfheIPDNkbn/Vg4X3GhCiG3O7uUcQWhVrC15MGb0gVwX?=
 =?us-ascii?Q?jv6SL9sV6/Ihp+fyL1MATKU6DuEp6e5bQ4zzdO3chyhtoLIJqSvPkzqeOu08?=
 =?us-ascii?Q?IT+FF0Zuqog0V8p5ReWXiP0B7RhtwFmCvV4jexij8yj9ml8BvLatGn6BkjQh?=
 =?us-ascii?Q?bnlawhsaKhSltT19AL0/DhSCdT4f4cousDip53ZBDqXvSC1p/eF/zc0dgTon?=
 =?us-ascii?Q?rib3EpvzyGpHtWXgNRxJ2UumwaFVa/Uf3SmHLGpmYPEgS0yJHgJRdpnRenQu?=
 =?us-ascii?Q?N5SmLPsaQxjaHHq20ZXhB10tZ0VPNajMaxdCevzzGFjy8Trl4iO6eHbE2FtU?=
 =?us-ascii?Q?HgrCDsljW6LtMxuZ5yJR8Szb7J4de43OQlq6RDhj5XimY9Ae/IKs2hksyVG3?=
 =?us-ascii?Q?vppT75Z6vFLjjp3z5b4xHT7RfbrxWBUrobYfpZ6glCgmUtqyPxwVJ6jdUAJh?=
 =?us-ascii?Q?TcJnrNjBTxFY1A1d5dNSaVWXeD/XAo/nP4jQCPoH4nWGUQo7/SyX6Id9U8tt?=
 =?us-ascii?Q?UrLgo8z3pMhKOldBG3MgSOylfeQRGr1PfqQf1K/hnlTE8refhc+o9W5AN1gC?=
 =?us-ascii?Q?U5OKhYEYEYylCY0hJEMmNmxFrDOyg13VFqCFhU7qs2S7uliUJPoqARYaOM/H?=
 =?us-ascii?Q?hQryI4QWJYjCFxLz116E1wvX+ZZ1Rgpq7RYnfuezzy9gb/jDjtBU5b05Wz49?=
 =?us-ascii?Q?WQ3Cc/TwhnKMr6HTputFHiJnAcq7/DbDY2FqqN651NJ8G3clO0zTptNqVjn4?=
 =?us-ascii?Q?jioNuxeV5EGtNUU62XMLR7GIms2lH4iD9Ll9gVcp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a89113-0230-4243-8aef-08db99e23891
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 20:41:49.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3FZmZKn94+opSCHM8FNAJQwJgVTNI/2Mz4QN9sROeocxSvB7mYaI82DD3iqKj8UiEwu4T9MdxAOvmiuj9Puww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7562
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 08:37:29PM +0200, Thomas Gleixner wrote:
> In reality CONFIG_MICROCODE is enabled in any reasonable configuration when
> Intel or AMD support is enabled. Accomodate to reality.
> 
> Requested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/Kconfig                       |   38 ---------------------------------
>  arch/x86/include/asm/microcode.h       |    6 ++---
>  arch/x86/include/asm/microcode_amd.h   |    2 -
>  arch/x86/include/asm/microcode_intel.h |    2 -
>  arch/x86/kernel/cpu/microcode/Makefile |    4 +--
>  5 files changed, 8 insertions(+), 44 deletions(-)
> 
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1308,44 +1308,8 @@ config X86_REBOOTFIXUPS
>  	  Say N otherwise.
>  
>  config MICROCODE
> -	bool "CPU microcode loading support"
> -	default y
> +	def_bool y
>  	depends on CPU_SUP_AMD || CPU_SUP_INTEL

Seems like there is a dracut dependency that checks for either of these to
be present.

dracut: Generating /boot/initrd.img-6.5.0-rc3-ucode-minrev+
dracut: Disabling early microcode, because kernel does not support it. CONFIG_MICROCODE_[AMD|INTEL]!=y

Just a tool fix. 
