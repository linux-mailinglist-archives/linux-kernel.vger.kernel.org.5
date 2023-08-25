Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A10788BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343869AbjHYOv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244442AbjHYOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:50:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD222119;
        Fri, 25 Aug 2023 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692975054; x=1724511054;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mDQgWTesQ9Cla/vmQK275rnkQ0Dns79hs36JHDKOPfk=;
  b=oJRak2vanAAVmBbec/Jc4wyxmQnxLUyeeo+UNVfLGLMWa52X9j4f+qaF
   2Uuu0ti37JTOj0bhuD7J0mqlLpCa5H76mqtr9DAHjk/f/aVrDiX+9CM4C
   Gto7fX9q5F0gOXxRTK1Nr+es91UTcjt6Znf5I9zmCcIt0LsAwMA+l/8OJ
   CtrLW1BKgM8c6r/3zl3pJ3x9lfcOt88Eb2cIJoaLJOP8b1Si/LwAY4h64
   HadplizeqoFFgGoLhM+tgpWuFKScK+CyjAjtLy80r4xSE/bKfCNBGNjv0
   5TL6Ox+ByA27/Y3y0X1vhw2mzn70YA9UnqSs22fg/EL1ewey/1LZWnK1i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="461089707"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="461089707"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 07:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="827625239"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827625239"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Aug 2023 07:50:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 07:50:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 07:50:52 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 07:50:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 07:50:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDxcDlrqcqHZ876lRWTlA8rg1Rg8LiO+sEom0D2ph8uutOb87MfODAKk9PLGBN58ixEgGz5Atx0TnfAUdlls3DQPs6KqiC4hklzmgF62/MQOpI7WTXrwxXXejmhNRwG28pDq1hVcvYN+Jqi240VkBXezrFKeQU5fl7khc5XlViS4hQ3XMODxKR5pu/oIUqmjxLr3sAtLgqTCYE4/6OdVJhPiSEN3Tl4TJGAXFqqoKdovVv/IOd78ARhmQ3vgZuTNzM51mR8eBqzTs5zq5nUZ08vCpwb0cazBQc1fmSbTpKdxPOeznot4naIi8AFkA5dxeKDd86CBy6o+r+EMlAdx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDGfrN+hjIQdpQJhq3/1GDm/o+IX0RMC4TeC0/Z96ZA=;
 b=NkC6SQRbQQtMD85jVRo2jGjMqVLbDYQcSZeSYlzaqjI2rHkLSoH6X5X22mYlx6DCKFR3Igjp75m4vGavv/aH3ORCHm/5upa/rIy1Z1uJyMba6fz7gPl/9Z5JFdDT8OHg7Wp4FfUSUAFuCMR4bmkV1qTAadw6ANJwvM/1ATsvELPHPdUB2sCCnCZLTbqXlxeFgIZTU9xDAJ190JHuUbfuEf4vc26YMBSL0mFUtHUBceT7fpRsRw84rp+qpdEmtN5Mb/ij+sntFCkVxdHbE/aJHXeCG5t8j6sf4nv+/2bq3Oe3hxnrEro1TMdgCWajsFBfNJN4AZZSLVdxhaf3Lx9zdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB6466.namprd11.prod.outlook.com (2603:10b6:208:3a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 14:50:50 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6678.031; Fri, 25 Aug 2023
 14:50:50 +0000
Message-ID: <a5574786-0a49-454d-67e3-571983e6a6e8@intel.com>
Date:   Fri, 25 Aug 2023 16:49:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] bitops: Share BYTES_TO_BITS() for everyone
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Yury Norov <yury.norov@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>
References: <20230824123728.2761663-1-andriy.shevchenko@linux.intel.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230824123728.2761663-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0288.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::12) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: d93232b6-a130-43c1-e501-08dba57aac76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uA+rwK2XuYvLSd4YyIQ1JhUIfH8lp6AE7MX56gPiWW97GaoQ+ScR3WJmVUHIOFUE1WEzxso1TrH9Fs3v6re+csxOwtVTqtlyvJs8C1oVoGxLdET2dOULatJBlGCZTLK9RwzC5bvtRLOddtW94yjJwhP9g4jKR1FOAehYDg5GUCRhL58q0e3r5d6kljB+n8OFbuLsGlMJZNF+KzXzLmC3hWkforxmqaS/xU6UeMeb5aNy3j5GiOsn6L8YSX54fV7h0d6tafHKnDuEOX1bzhwao8UAj/i0tL53/5oV/9IA6ziE+pHsB3I32APKIEiczDJkUchqAEDaC36lF7y1h/zYWv6jLcEpC9lMpV79WwXlZDIzQ+e9Bc+uQAgYqw7lmChfGvcLNwnxHFZmJ4SpWiGz5qwm9B6rWr6cFsI6vqb81VH3coi5yWUTv/VUZh185NlD7B91wZA01L3ZzCqXltshNv3IxUkGOyQj4o/9G0sLBiE9D1z5C/zl2sKNtHrta5p/I58YqFRKMmQGw01xMRWwLjvI9zvyxQJnw+ppXwQoPLFL5re1CyuoHezwFFIvnMNmMcUIuPnf+Q/gGWo9h5ChKABKMRhmBRnAKvIu6XxxuHiB9Fz3auEbAbiS2w4ktg4sidXKezJcNz0yEerN1WzV9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199024)(1800799009)(186009)(31686004)(31696002)(86362001)(82960400001)(38100700002)(36756003)(6506007)(6486002)(478600001)(966005)(5660300002)(6916009)(54906003)(4326008)(8676002)(8936002)(316002)(6666004)(6512007)(83380400001)(26005)(66946007)(41300700001)(2906002)(66476007)(66556008)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWEvUDBuaU1jcFo3VmNnWDc2dEFzYzRtZFRaNnRmTnFVZzgvY3Qxb0F4Q3Vo?=
 =?utf-8?B?Y3JON1Z1ckR6NlZIT1NiTkZYNXMwL2t3ZUJTQXhnczB1V1FxaVVrQnlhNjdu?=
 =?utf-8?B?R0VIZFpyNVQwMFhkQnhzM1NWWTVpdU1BMlVWWXFXR1Z6NGJISEcvdVcxT05K?=
 =?utf-8?B?eFRhUmRsT3F0aXVkK2trOVhxQmVFWjhxMXowQnorRWQ5cUdOMTRMM3liZGZo?=
 =?utf-8?B?SzI0Y1JpQkhzdWJsUHZ6S3FCNzBVTUdlZDBPL2ZFUE01Y3AwU3RhS2owV0o2?=
 =?utf-8?B?WkM0a0tta240RldwQVBtZEI5dVN3Sy84QytPbmRRM0FjdUVFU3hVZmNHbmFy?=
 =?utf-8?B?b1NTbk02S0lKTnc3Rk1TcjhFM1E3RVRWdTBXZnRWbkZWU2NBTlNWbmEvYlVj?=
 =?utf-8?B?V0tWQ1VGS1RkbVZiV2VkRXFrVlhvbk1TNnhQaCtBclNpZ0FFUXNkWjNVdDNF?=
 =?utf-8?B?SDdJVEZMUjUvR3B1aGVuWE1CdkhmSUIwK2xkMjZ2V3k2TUk2Rm1KOFRBeUg5?=
 =?utf-8?B?NWg4dVpINmtkZVZISE52dUlBSjJkRjlualFhUVBQK2R4a2ZkY0JRL1NzR3d0?=
 =?utf-8?B?T1RpaG5ncm1Oc3lQOURTTzV2cjYzRXZ2b2liWURGL2ttT0c1ZHFXNU1Ybjh2?=
 =?utf-8?B?dDloT2NYYndwNzRMalg4TE5WcDF5Qk1QS2lGSDUrcmNocjhQWWpTMEhEWkI2?=
 =?utf-8?B?QmtLblJOeVRFS2l5YU1FcUxTTHJYNHlZU0pFSWswS2RyQ3g5ZkZIb2oyTkJr?=
 =?utf-8?B?RHJraEI5bU5YQXBkenZuQmg5ak04a0JzeVJPcmdJejhsMWo3NjZVdnp5SDYv?=
 =?utf-8?B?SDljZ29CV3hzTUNmR2pGRHhCbGw1YytjUmtqVEV4QUZmRFN5QzV4ZWw5S2lp?=
 =?utf-8?B?V2d4SERGZzFSbTF3bU93N0t0S0NsSDZCaHVmZURRQmMycXk4a2h2RWdyQy96?=
 =?utf-8?B?Kzl1NTk5OWpvK0x6VmNSdGx4K0F2RXUvWk9DTmwyZ0R2R3N5QWljbnF2YTI3?=
 =?utf-8?B?K1VmeXVmVStEVENobHR0L3ZKYVdXYTJHclNFKysvUzlnUlFhYisyYjd5bjcz?=
 =?utf-8?B?dk1rWEdmUFVCS2pnU2MwanVyeHFxVXFBTUN1aDFvNlhaRUZlSTZ6aHdPSGRG?=
 =?utf-8?B?VVhjRlg1WUFpRFJETEgwcTBiKy9lZmlYWFBtNFJvWWZnWkNBTW9Iekt3QjM3?=
 =?utf-8?B?dzFWNnVXMkxOOEtaclhBeE5uR1R2NUhnUW1xTGlBVGhGSytsaXFQbjM3Z1No?=
 =?utf-8?B?TXdZekhBQWJGUHNxazlBNGJOVTczS1RIOHVoZFFCSlBFTTkwcEgyOUJKMisw?=
 =?utf-8?B?RitkSHZPclRYSGc3MWpSS2pzYVdzelVCc1BxTGZybzVHZ2NLSElwbDdRYW1D?=
 =?utf-8?B?Rlc5R01IdC9WbHlOTUFsclJWNDB5Szh1VWNXOElLdSt5VmZFeUNUL05RMUtW?=
 =?utf-8?B?aTNkM1BsaUJ4Y1JPMkcwanB1dmhJbFYvbkFQZDhFblA4dXFPRWZNMXp5dSti?=
 =?utf-8?B?cXFYeTBkWFFIT2JhWURiVCswb05DNGFPZU1xRGhCTEVnbEJ0TmRWQ1JnREQz?=
 =?utf-8?B?alh1L0FJNWErVndRQlg3THNRTWQ5SnBtQ29YUjhHUjJPRUx6NG9vZk5oVHQy?=
 =?utf-8?B?ZVlHWXNVUU0rVVRodk1qOVRmaStrNWdXL2hsWkx1YnZiUzU1VDJVYkp5OUlE?=
 =?utf-8?B?TU5sbnkxb0NBNGptZXpsKyt6b0JJZFlQbFVUTGVxeEJjUVZkbzF3MkI0MzJB?=
 =?utf-8?B?dWZ6WU5vWU9tNTFySUt4M1JCaS9EV2hWU1cvZlFjQWFzN2VVQXVaalF3QUY2?=
 =?utf-8?B?SG5mTWljNEI3clBObXFpUHVlMFlZMklWU2dWQWtQd242YUUrR3ZmNUJIWlVu?=
 =?utf-8?B?MElya2E1SjhXazNXcWUzQ21hOFVXVUYrWWExb2dYVXlhVUxPVkZaMVczMEZv?=
 =?utf-8?B?N2FCSmJ5d0J6ZlZzWmppb3Q4WjFESkZ6bnZTK2dmRE9FdzM5dVNjcUczYk5r?=
 =?utf-8?B?NmlhZ0pGWnJIQnlFZTZxMXJsZ0s3OUlkRkQzNk1sOTlRNytQV0d4VDM0ZWJP?=
 =?utf-8?B?NEV0ZGhwQjE4WU1GQXo3WGdGbk16cHhNa1NtWWFWMFBOU0U1K3UxZ2luRHVB?=
 =?utf-8?B?U2cxamJBZXJZcHVMek0zT2crUHc2NnN4OHRaa29QcWpuMUYrQitpeGhKK2NY?=
 =?utf-8?Q?tA0jZQdvSenB7ryg7ZcNjLU=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d93232b6-a130-43c1-e501-08dba57aac76
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 14:50:50.3453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMfjUbR0tagsBwvLIzATopDuOFXU0VeFZMDyWy/FXgnKZB8h1QohIPS6ZXyShTEKe1w4BYqLzfwx4kzGdNUnyakp+JzPUsveKQYrrqW7bIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6466
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 24 Aug 2023 15:37:28 +0300

> It may be new callers for the same macro, share it.
> 
> Note, it's unknown why it's represented in the current form instead of
> simple multiplication and commit 1ff511e35ed8 ("tracing/kprobes: Add
> bitfield type") doesn't explain that neither. Let leave it as is and
> we may improve it in the future.

Maybe symmetrical change in tools/ like I did[0] an aeon ago?

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/bitops.h     | 2 ++
>  kernel/trace/trace_probe.c | 3 +--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 2ba557e067fe..66dc091e0c28 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -21,6 +21,8 @@
>  #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
>  #define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
>  
> +#define BYTES_TO_BITS(nb)	((BITS_PER_LONG * (nb)) / sizeof(long))
> +
>  extern unsigned int __sw_hweight8(unsigned int w);
>  extern unsigned int __sw_hweight16(unsigned int w);
>  extern unsigned int __sw_hweight32(unsigned int w);
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index c68a72707852..da6297d24d61 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -11,6 +11,7 @@
>   */
>  #define pr_fmt(fmt)	"trace_probe: " fmt
>  
> +#include <linux/bitops.h>
>  #include <linux/bpf.h>
>  
>  #include "trace_probe.h"
> @@ -830,8 +831,6 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  	return ret;
>  }
>  
> -#define BYTES_TO_BITS(nb)	((BITS_PER_LONG * (nb)) / sizeof(long))
> -
>  /* Bitfield type needs to be parsed into a fetch function */
>  static int __parse_bitfield_probe_arg(const char *bf,
>  				      const struct fetch_type *t,

[0]
https://github.com/alobakin/linux/commit/fd308001fe6d38837fe820427209a6a99e4850a8

Thanks,
Olek
