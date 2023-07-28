Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4A767932
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 01:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbjG1X6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 19:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbjG1X6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 19:58:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799303585;
        Fri, 28 Jul 2023 16:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690588681; x=1722124681;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Bc+6EwPc98WamVlhT69GIjduIJvFMLu/pLzl8N3jSFo=;
  b=CgINddZ2kB7BYIppXm3iB/M+VnYCEYlqxGefxhbyJp75IuLCiZKLlGID
   c4rzt1Xn1jwe5EVF0ucT6QVHkyUOyXBeABxTbu98s+8lIaGmJqcVdoxeW
   vpZ2nlln8qRq0QUgCt6OsZk+yCJnknTsNXHFZIzY5s1RWMZh+MWLiAyXN
   p9KUN+fjK3DYEBPJA4LPTkFl9TBxx0InFPaiw5qGAckkH0AIhk5oOhRgW
   tJkuPoLLqK7q61OTpFd6O898YpQwiCsCG2q/LtnXIkPyGdbzJRFkHkYRB
   VQP3ar/44ZYfXz3qVQPSCn0q0uXvt2QLa1oXOPAAC1fZeRDHiBnPxWQnD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="367591055"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="367591055"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 16:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="793080536"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="793080536"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2023 16:58:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:58:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:58:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 16:58:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 16:57:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntD0TIZ7S7BiujqoWw0D//68VtuRdUeTVbUhNh+D23lMK0xy1nkZYUHZcB2FM7sYOzycLduW4/BLDWp7OrxlbGDDlwHT4iaWdxnVHMvq/UjbaSdNcmdAmqX/ct4iPUxGc0I3BSpr34XqoMKp2pqZ4/kAy9I4yS24Xi2ocRiwM42B5jLFteVNdxHglOnrakEqdaO4pyXnMezd6HwwhYmOLtikHCeS0N8zk2JriRqhqcptapWkb1N3Yp2i66zzvIi/UBk7X+Ip1FDdWA/KI7nv7Wtn2zXrTPF5Ylu8/GTHM16FliatMo5VzCNGrPnXht1qkNmPSGYS+nQD3awMvLWZpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzJoaQFgW7TYJ2CwyAiq4aYpG8ZXrVQu68lQmmGhawg=;
 b=HV/IpbucQMUc2KwM3KvZZcr0ExwKQUScIFFcKYvvOCM1mUsEX3gCOaejhT9xdsXY6LJuWqoN6e3VGnRIm5nLgd/ps8kfmFOQSLVfAX8H/5sT+CeQoFZq68nXopy8qZIJNB2VMdguqKo1gbFThJsZQGhcfKX72Dv2fBSfDaJr76DBkjr1vlj35MLPQZb5v1hd9tMy2timdf33Jeyf3dRjh/ACAwMdEgsmBUska8T+eVJH+Y/kVhw1ybQY1BmFIlyWZOrK02wyLPdzbfnNt2O8gHPwu3teUEYMhtxIq2uj5BUxA1qm98DgwGwKeLRTRhmIIv7B40nb/z7Fvy3EzLoJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 23:57:57 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::d790:194b:937b:68e2%2]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 23:57:57 +0000
Message-ID: <ef3e63b2-d73b-b03f-2f5e-df456d756a63@intel.com>
Date:   Fri, 28 Jul 2023 16:57:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch v2 19/38] x86/cpu: Provide debug interface
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>, "Jean Delvare" <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "Russ Anderson" <russ.anderson@hpe.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120930.727298737@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230728120930.727298737@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::45) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e97b362-8e97-40fe-5121-08db8fc67711
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HjkT3X1u5hyyi8S6trxApGNRylhrU3Tcji5LbHkWgc0/IXyYZ+hF/c0/BgAOagUzwLFP9KxSq5CV8HQl2iYuOo4nm9aX33ZY5eLOx//xN1RLoujkrKyaqn2WkPTHOIzd+91ITgci+F1Bp2dFEvHaRh5rtvL9rXTNCY+PKim+1Aorj+ShWl0nAWgyC8q7jvU76xzON4yHGsmtdK/+ogL5fWEU83gK0d6J51RgQRoFFuBFCyiFnHib5Mj5/TW553/xgyHBraE+xsBhhZSOQ1GMjm1DMzCd5bvRepRqL9eVFxFq5I91zUUe5yq8m8xPf202evX2yTPTpCXb/rycazoxetF0/bpJd+gE5OxYB3NhfC9w6b/L2hUOVvNhRRXd/YbqSiUxG+ZnPmhLmSZAcieZeycrYjlsLMLBSwU8lxY/A3OlppWrgRvE3rGpS5uuZzJYoS/EMpmS6/moLaXiLuJwW4vVc5ZcVuxpWd/13NucMvsFukr9j29jkcIUXVMsrozd4cQm7CyiX2ODz8KqZ0IVaFkgkVWuJc1L7tc+Zd08f30EU9UP27J/e0q/JRQeAozb2Wi818qA6N5351uPhveX6Aib1Dd0j6aAHtt0FyHGfMGbzMXW2WKAkZi8OcfxnfX/QS/hZUBrakByu3FQ9LbXYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(2906002)(316002)(8936002)(8676002)(7416002)(5660300002)(44832011)(41300700001)(36756003)(31696002)(86362001)(6512007)(6486002)(6666004)(54906003)(26005)(478600001)(82960400001)(6506007)(186003)(110136005)(2616005)(83380400001)(66946007)(38100700002)(31686004)(66556008)(66476007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnE2aml3TG9jaUlPSERUNnB2UUgwRk9OZTUxWWcvaEUwV0Q3K0dib0Y0Rnk5?=
 =?utf-8?B?R3hnaEV3Um1VMWZISWlGblI0ckJxN1RrZkVxaHNTUGpyc1V5MGZ1VDMzbk5I?=
 =?utf-8?B?SlNsVW1paWNDM29TM2xHZFJXazF1aHdQMUw2b05DdTh1UzZwVkwvcE5DdGRi?=
 =?utf-8?B?NmJQdWtFa2thL3FnR0l1MlRvcFpLK1hpYTdRUWN5RkJrWGd0bXlCNy9tT1Na?=
 =?utf-8?B?QWw0Z1JNaDZPNTY0RTBiWlJ0ditkc0crTHRORm5qaFdUcS9kTGFNSUdqdS9S?=
 =?utf-8?B?aFpRdU1sSE9ZQW9lSjU1YnNOSm5hakszMWNsWDlNZEE1R2NtbERkSHJXK2hD?=
 =?utf-8?B?MGJ3cnNWUWVham5uY3JLdXVVYmNjcWk0Z1kzVEdyWXNKUC9USjJadUFVaEZN?=
 =?utf-8?B?dCtMYWtOMWw2SXBmRE92UGkvcVF0MnB1b3VmS0FFQ01xSHdXZmRvZGVmcEVq?=
 =?utf-8?B?VjlXZy9UK2NoU1FRMC9QdXVia0FodE1CNjNhdkkwb2hPOTJpTHlBUldHOThx?=
 =?utf-8?B?T1VzUnBXcEI0VzZHR1FUak1jM1pmKzRxK1hWbjRaekJvaHoyVWk2YUtTbnVO?=
 =?utf-8?B?N3l1bDkrTGlQc0FoRDVhSVFrSzBiL0RNS0puUEljbHUvUFNaZ3E3SFluNHR4?=
 =?utf-8?B?aW42Y09XRCtQY2VqbGgxRjFpd1pSYUtLZWlWV3ZlM2tFRXVzTlRFRTI2MHpV?=
 =?utf-8?B?ZXpkSjljSmQwMm42alQyMWc0R1pPOGpYSkVLSEpLVmxyeGFVRnY4WFduK1Rz?=
 =?utf-8?B?UmtHTHViVVRGaStKSUVqaWhHLzhhcGZGaDR4RSttMVFoc0hOZVQ0bmhFSy9C?=
 =?utf-8?B?d25VNmc0dmRhMUtNRzN1MmIzSHcyNjByRk56K3duN0ozcXVralk3ODJmOWZk?=
 =?utf-8?B?R21BcXhwR2tGTStPdFFTMTFyOVdaTmlaSFdPM243RG9zd1VMUHNhNStvU1ZK?=
 =?utf-8?B?VjNleUtrMVVjU0RpM0hVdGlEL2RFazRWbEVRWXVndWtFYURYZk9ldkt1U3pO?=
 =?utf-8?B?T3ZmUzhBcGltY1pYM0ZLQ1NkZHBMMXRoREdGTmVRcVgzWlhkbEczREZZcnpW?=
 =?utf-8?B?b0wrWnlZLzloQUIyT1AwUVZoUS9vOG9kbkpPQW5JZGNaZ2VsUVdndVU5NVlU?=
 =?utf-8?B?Q0hIUU54MStudFRBZnA4S2ZheVhNNUN6MC9VN0ZkQW5odlQ0MkMzczlwelNt?=
 =?utf-8?B?WVp4MktkczZDOG4yeXFCTy9aMExYdDNTU3R2WW0rZW4xK2NkSjZsVjI5WUFz?=
 =?utf-8?B?NUhuT3RqU1l3WlpEeTFaMnU1M2gyWHlTbm00eWxWM3VucThPZ3haODJqd21k?=
 =?utf-8?B?V0hwTmRtMnBTa1A1SndWckJSL2IzWnhDck1JMVdqQ2xvVkpHTzVVcDVGTzdi?=
 =?utf-8?B?dWxpS3pjMXd6MXFyd2hWSWNRK1ZaWklEYXVHQUQ2dVdsaGtGcFk2VXF5djRI?=
 =?utf-8?B?eTVJa00yNUdId24rZWVqU3o4RmZqcmJNQ2FMWEhEckZZU2t2dG5oMGZlL0th?=
 =?utf-8?B?N1hKTEdrc1NoUmgzOGhuMkZ6bXNISktsVEV5UHJpdjc2UWhQNTBjNkVxM0RQ?=
 =?utf-8?B?OVBuenhBQVlyNUN6MUNmRHlYankyQmtqMGQ0ZjBVOWdPM1NEUXlUMHMxMGVH?=
 =?utf-8?B?dzlNUmJQRnlwb0Z2MGhndlNkeTJoM0VWc0NLQmIyaDJFdGcrdENqQmFyc1Mz?=
 =?utf-8?B?YVdvdURpMFM5U1NuVVRtZEZzajB2alNhaG5pamdGNkZCa0ZXTS9vdjdSSE1Y?=
 =?utf-8?B?NzhZLzBUdVRyVURyMGVxR3F1a1pWZFo5aStuNkVjTHJVUEZ1V2lPbTJEUXAv?=
 =?utf-8?B?d0l2NkFpMDVJcDhta1JQM3R3a2puZWRXc2s4MFRMNnJvaFFrQ3gwQ1Z1WkQ1?=
 =?utf-8?B?azI4ZVNYL3FXdWp1bDlvNGI1U1RuS2FuNGp2bTcyR1N6akViK0RnQmt3ZmtO?=
 =?utf-8?B?dDc5akp0ZnJ5RW5wL2ZqUHdweFlWeGtKdmdsMDFtWituWEdMc21WYXUrZGdv?=
 =?utf-8?B?RE9RalFxeE5Wd2V2MWNsei9wTTZJZDFEa0phcUYrRlorLzgyVENOZVk4bEZS?=
 =?utf-8?B?dnVjYmEvRXBzRDgrbnhUVjRrVjIzcXFWaDBuNVd2ZkxQTVFnbDBBckFsd1dG?=
 =?utf-8?Q?C9XwHZJnoWbWClUZ8vgLLrMuj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e97b362-8e97-40fe-5121-08db8fc67711
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 23:57:56.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3amfXWI/JFfHbj/TW5vXM4kPJ+rCS3nAqshUsHRRUQZduU4FoDtg0bcb0ZSH5d6kvifO94QwbemPRQIbdeJ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +++ b/arch/x86/kernel/cpu/debugfs.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/debugfs.h>
> +
> +#include <asm/apic.h>
> +#include <asm/processor.h>
> +

I ran checkpatch through the patches and it lists a bunch of errors and
warnings. Most of them are due to issues in the existing code which is
probably not worth fixing.

However, I found a couple of recommendations which might be of interest.

1) Using linux headers instead of the asm ones. Namely,

> Consider using #include <linux/processor.h> instead of <asm/processor.h>
> Consider using #include <linux/topology.h> instead of <asm/topology.h>
> Consider using #include <linux/smp.h> instead of <asm/smp.h>

2) Macros with multiple statements should be enclosed in a do - while loop

From patch 20/38:
> +#define cpuid_subleaf(leaf, subleaf, regs)		\
> +	BUILD_BUG_ON(sizeof(*(regs)) != 16);		\
> +	__cpuid_read(leaf, subleaf, (u32 *)(regs))


I am wondering if either of them matter?


> +static __init int cpu_init_debugfs(void)
> +{
> +	struct dentry *dir, *base = debugfs_create_dir("topo", arch_debugfs_dir);
> +	unsigned long id;
> +	char name [10];
> +

Excess space after name and before the square bracket can be avoided.


Sohil


