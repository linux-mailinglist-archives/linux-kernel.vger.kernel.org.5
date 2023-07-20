Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22C075AA42
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjGTI7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjGTIjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:39:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9418426AB;
        Thu, 20 Jul 2023 01:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689842345; x=1721378345;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=InI0bRcbP+2FZ30NS8M3jmC0iudQlo3Pc1WvA/bnQRw=;
  b=fXW48NwaUyQJvMSPAq3h542jpEKv+0Z9sQtTXYxMoOCjOPHi9IwtNPRN
   peyaGIsZOarrFV4+k8dVHoWtasxEE5lCUn3KaaVCW/Ng8TqJBlc3RoxLm
   DsZXNC9ZUXpJHsUk0zSnVAfyKnbEXMF93aEfdcjbaCrU1afb+pLkE28RZ
   0yMdCMxBuPRJlhC19/IBbhk99SDOsor47RXUmzx5paNqWsgWu+Tv5mNRa
   JwiB07l9ooxqRrZ6I1B5D6bn9KLxk6Ji2lkaKv6PYd3or7rkYbtDv6oqX
   mG4IfsG5IxO3XLdlKMwDliFQvUakudyDQVhJNJJBbv1K/JtvoC4OppBGq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="453048969"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="453048969"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 01:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="753992897"
X-IronPort-AV: E=Sophos;i="6.01,218,1684825200"; 
   d="scan'208";a="753992897"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 20 Jul 2023 01:39:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 20 Jul 2023 01:39:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 20 Jul 2023 01:39:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 20 Jul 2023 01:39:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnbujprh1MjOy9xc2AVg6VWg55nJgNVLJv0cNdm2SUuGZX4taHzdTYK6QKb3nU91RcP7xCtmeiVA9EYD4b2xYZK+RDVMMk3CaxbNBHpWIRfwF7mULap1TXIAKlpU0/BE+CKposMSh3BiNqKp+W5w0Ksq9L/mY87Hi12NTz2GoQYjPGdEAwcOWiTAuB1Hlk17CkLkRXn27HC6iWODAmAtkthSqZA4vOLS0DnH1tqBTBKlLQR3QGChKaZEV16KSYEbJYU+K817Hap+gdOpNs5CZT470wmuqeR8My5gMKuxtLZRpPF+E4rsQU2dwQzi2B3f+8E3sr77jO4Ym0kJ/j1PIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZp2Ild2k7D713B7XOmF4+ubV8LF76zh72U10PitG3c=;
 b=Rn2NmfNjoRwZf5uZtiT210fOIJ2oW/vO77ztlHXnhLCvAXdV8UMcJjrNtLEWQl6RFMvVqksYemUFVWG/8t3oIyUSVuKegEPJJdGbCzJY92AcNypiWh8sUIP3nLNMfXmFd+BMJnAtlk2jDUa+LFF5PR53+G13RYJJl15qobqQgrkjeTMMGW508HVY3+RkDM7N+E/ViqYGTRS+I6pvbxT+h82KngxDCKoXrJ42rl9USaYS4CmcP79FVWljYYcdesL4SrYK7Sa+kJ6Yn38nvasaA9A82C36huVA6lbBMcNux32wEb2Np2daIzTfrPxlvD37BxAkUUQwx77PmjDhg11+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by MW4PR11MB6666.namprd11.prod.outlook.com (2603:10b6:303:1eb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 08:39:02 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::5f7a:95cd:9d79:aafd]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::5f7a:95cd:9d79:aafd%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 08:39:02 +0000
Message-ID: <496d7fd1-8d15-7566-f3e0-07a88e477fe2@intel.com>
Date:   Thu, 20 Jul 2023 10:38:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] ACPI: processor: Refine messages in
 acpi_early_processor_control_setup()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <2703565.mvXUDI8C0e@kreacher>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <2703565.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::17) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|MW4PR11MB6666:EE_
X-MS-Office365-Filtering-Correlation-Id: ca728e6c-b798-4def-be9a-08db88fcc4c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpkULamV1WfFsrq4BntKrxpLuHSPdDIWvVJIaHpCLiJnoj2+013YU9YOlT+mNx0Q8i0CDvSWRKx8poxZqA648ipTgiRe4XVSf9lXRZOkiDKHppyGCUb7/xhiUtEy3KELv59Ie6cgWmZlavTtRQXA+YEaOL0iLakVZmDKIRoJx7uOfRrnwOSRGjGNgJfSLLq4cwSuuk/mddH9My2fwig7jAJFnsLnqLUZjbdBwZ29uRhkD3en1IFggDaP1oVGIwcbZjt0t42/ZrQPV0sAmbGHaH2gHsGzlYnFwc78bRdMF9H+StMT4/i04Dd8qFgLe9yo1U9qnY68C8MAmnV2NYDhCoVpF2vR9fMbp4FDoyvMOQSNgBntJpIw8Ugiu3Ts5RuHe1lp7IuY4rPOe0OjQragXf5TQkra3VfrmyTMgOfwvKelVKYGEnzH41RPg9FEiShAn0ZVKjCiycfE7eiU0aMY9/YnVIA+K/WwwT98MpE8v1xPeMzqiOd7OfB3aXLOw9TCAEfCyI/0VkAKV785THsiFmCQUuOKVndy4fQ9y4vfJ4iPDUMLV3BsAmiXkd+P9fu+Zsm2CXJFYHpD9CJFh8J38io3gWM6MU1EJdZRL95fxCNwqgrFxrPd6IcERFj06Yai
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(2616005)(26005)(6512007)(6506007)(186003)(53546011)(4326008)(83380400001)(5660300002)(8676002)(66946007)(8936002)(316002)(66476007)(66556008)(54906003)(41300700001)(6486002)(110136005)(2906002)(478600001)(15650500001)(6666004)(36756003)(84970400001)(82960400001)(31696002)(86362001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnAyNWl2NUNmZGRSSDZjRkM0QWZFZldJaER1SElTRGVmZ1E1dVN0ZVhLbkRl?=
 =?utf-8?B?YnpIQ0ZJUzV0TlE5T1ZPQ0lzcXZLMGo1N05FUU5yRnNSU3lYOHk3OUZsczVP?=
 =?utf-8?B?bUd3QkZMRm9BM3VCSkc0VnlCUkJDa0JLQVZoRk4zcGMxNlZxb1lOeU9PQmZQ?=
 =?utf-8?B?UVhNTHhnT2wyaE96NUwzMU5TWGlXTzBudjJFeFJCbjFDUm9FajYyMTNRaFRN?=
 =?utf-8?B?UStPNTE0N2s5ZUZMUi9QS1B0amtnZ2loUE1pNm5wempKcVFhZklRaHlRZUhM?=
 =?utf-8?B?Y3JwZVNOVUpRclZHK1ZTbmhvREpPdWV3NjhCV1JtY3AxRWI0Q250dTJ0NFFT?=
 =?utf-8?B?TGJPK1BEWHNpTFRYRDNtb2ExVGlLNmkrRU1mQ0dIY1Bzai9CekVoLzZPdDUz?=
 =?utf-8?B?MXFGanRLRFF0bEQ3RmpyS3ZHL0FOTjdDb2NML1VaOFFhWFZJcTBiQ20wSk0v?=
 =?utf-8?B?b09STG9CR2hVWmg4azRTMzdwenVGcVlsV2VGLzkvNElLTGdSRmR5YThCMC9q?=
 =?utf-8?B?K2dYYzdUcmExRFZwekdUVVJTZFA1UWVpazBFcjYyRzVkVnRmbmRtWW1KWUUv?=
 =?utf-8?B?bVB6SXJ3SE51TGZBcTE2OHFEdnRUcnBITXpxbE9veDFpMGdzRXZ1RHZCUFZa?=
 =?utf-8?B?dUxSQ3hXaVQ3RkZUN1pVNkd5TURwQVRCZ2pUVWZKT2dLNE5mVWRLdVZPZ1Jr?=
 =?utf-8?B?Wi9Ic2QwUzFwRDViM2lDMTM2TjA4dW9lUWMrQ05nb2FBR1BUc2hFZ01OWTlM?=
 =?utf-8?B?SFRFRVRQR0dsTjA2TlNDZHZ3bHJiU2s2TkRJTmFrSkt0bEZ6NjZWbUZidjQw?=
 =?utf-8?B?VTl3U1I2c3k5aWdPMExoaGxlcXdINjgyb0RHQ1daN1JKYzRYc0tNZWtqMmpF?=
 =?utf-8?B?UnpkVGt5U3BxczFlcjJIZjJjbzJqMjYySGs0ME5nUXh3S1o1a2hNT2tNbzNX?=
 =?utf-8?B?TUthZjhLRjFHM1VObGJPYzB3ZXd4aC9aUG1HSWcyUldHRDdBQmRpKzVxVGZF?=
 =?utf-8?B?NkxFTW5zSDlncFcxQ2F4LzBkL095ZHRrU0VXZDFyOEwwWUExU3VCRUErYWFM?=
 =?utf-8?B?QmRJUFh0VE0zS3Erd0gzcXJSSnJNaCt0eERtVDRlemdTZnE4cnZ2cUdaMUdD?=
 =?utf-8?B?RUFhUDhFdjRFZjNBZnE3ZHpyYU9xN3lDRFE4RFlETXRmeDg1VC92UDhyK2Vz?=
 =?utf-8?B?Q2pVZ21CVkNqbU55aDhqOXUrcVBhMGZNb2Q2VEtOandjSjlTSTk2WklRT1R4?=
 =?utf-8?B?djhsaDdYdVRUZ0VnMXAvd0ZtSG1CbzNna3BoWWxQMHd6TVBhM0loNTFBUXdq?=
 =?utf-8?B?cWtnb0dPcVN3VlhvRmdONnFuRStiSUgxQ2pPK1pwdjdHQTVUTzZ4WGc3RVlU?=
 =?utf-8?B?OHRyRDlPaWRoM0tObkM2S0pyQyt1V3MvY1NBV2IyZ05xLytuRjNzU2dpbnhP?=
 =?utf-8?B?WGFoc3R3MWFrTDRUbDlZWjNpT0VQbUo0dEhvVmgvZ1BMMUVlajNtbDlIRHUw?=
 =?utf-8?B?alR5eU5uZTVuMk51ME5ZZFVtRUVVd1UrVVBlUlhqUGs1RXhRMGV5Um9UV1l5?=
 =?utf-8?B?VERoUENOK1laU0F1RVdSL090V084MUl1dFgrNDExNmhoL3pqakhhZmtFQ0xQ?=
 =?utf-8?B?WjhaSzZZaldNYmpmSFhFanY0T1J3eC85LzZwdFF3N0JQQmtzUjd3SHZQdUdw?=
 =?utf-8?B?VzY2eTRqSnpzN1FyNmFDdkxsWjlZQVlDQU9HNUtrdUNXWVVURnBKYUx4OTI0?=
 =?utf-8?B?bU5PQnhLWFB0d0ZyNXFKTU9kay9BRHlpUDJKWnArMXNKMm16dTRhMGFVZFFu?=
 =?utf-8?B?Tk1uOTZ3RXBCSDQ1eVlHbVBVb0lFbjJwK1g1Ny84MW12ZlFOLzVWV0QxY0Z6?=
 =?utf-8?B?dE4zOTlxYkVCeDlMdjFEYTUwaXBUcW1WUjRLQjgzZ0tVNldSZkxWNWQwYlNU?=
 =?utf-8?B?OG5PS0NSeGdVTVcxclpsV2R0L05QdUIxYnVOMFRxRGN2emhOa0t3MHp0bEZC?=
 =?utf-8?B?VFovbGM0K09pa0cyeUE2NjBvdTJuakxZNnprSnV0Yks5WDdDMDh1dWZUTUFU?=
 =?utf-8?B?YWtjMjR2cXJzTkdNUTdSTHBJa0g5d0FkUWxhcVQ2NzFvRkpHSzlMRmRJeVRn?=
 =?utf-8?B?SnJXaVEveld5UXV4aEtvR0t5V3ZZcDNoOEg4ODh4QVdTN0FVSlhZcHp3Zm1h?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca728e6c-b798-4def-be9a-08db88fcc4c8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 08:39:02.0561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqyHkAUdp5nDHo+m6aioj+EOd/9G3RqKHoBShHatQcSJW5tqMEtW7PYsDACYCBgzp58aZwLgU4C6oxHAHdldchbHYclkdAVumjbPqafl1vs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6666
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/2023 6:02 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The source and meaning of the messages printed by
> acpi_early_processor_control_setup() is unclear, so add a pr_fmt()
> definition to acpi_processor.c and expand the messages to make it
> clear that they are about CPUs.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Based on linux-next.
>
> ---
>  drivers/acpi/acpi_processor.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> Index: linux-pm/drivers/acpi/acpi_processor.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_processor.c
> +++ linux-pm/drivers/acpi/acpi_processor.c
> @@ -9,6 +9,7 @@
>   * Copyright (C) 2013, Intel Corporation
>   *                     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>   */
> +#define pr_fmt(fmt) "ACPI: " fmt
>  
>  #include <linux/acpi.h>
>  #include <linux/device.h>
> @@ -611,9 +612,9 @@ static bool __init acpi_early_processor_
>  void __init acpi_early_processor_control_setup(void)
>  {
>  	if (acpi_early_processor_osc()) {
> -		pr_info("_OSC evaluated successfully\n");
> +		pr_info("_OSC evaluated successfully for all CPUs\n");
>  	} else {
> -		pr_info("_OSC evaluation failed, trying _PDC\n");
> +		pr_info("_OSC evaluation for CPUs failed, trying _PDC\n");
>  		acpi_early_processor_set_pdc();
>  	}
>  }

Looks good to me,
Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
>
>
>

