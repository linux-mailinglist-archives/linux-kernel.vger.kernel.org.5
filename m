Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024EB7BEFD3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379233AbjJJAh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379226AbjJJAhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:37:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D046A4;
        Mon,  9 Oct 2023 17:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696898273; x=1728434273;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oYfXIMM80pjaoGqImyGrJnEG4n7/NoO3rq4rNdRDwp8=;
  b=KOPy7q+T1EvLSAxo/Yws8oVrLibJsCgGVzOCzhEr2QbKppr3wFqa0A0G
   nFB+Y9nJXrR3vhwUyatc3gx4gkkjBgz3KOsU1hilh70KrgqTkVsv28mRv
   w2N8U5m9lw7KIVyqwL5o59PEYGijtBYP7XpWCWADl1oIXuVfP0d3o6BaA
   CpW+XhMl/fRzzvDilehlL7bH1dV1dUxU4AjP4rBUuhQ3Kbqq2SEWI6Iqf
   rg3UWTNLprwZcnUxLmeKVD7Kw0AneZd9ZH3gGCHe1LpY7GYuAODqQUMCL
   oy4977q8KZgK2WdcRa4SRMPoW7jIh3qlGrgflDc12b+SxH1jq81b0Fm92
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="384139425"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="384139425"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 17:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1000444933"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="1000444933"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 17:37:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 17:37:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 17:37:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 17:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/Zxoh/mlXNKrpG0x31dt4J4tnqDjsUWXEn9kvWf8y1MbGFGvE9lfsOKCbE/2M18DwkQZAI22F4tuPHnR81ujpp5U19HpneLzCaSkMu9nLLZH7/ehwMzXYoENx3PMHBdu5+SjZtNWZjQ7D7j6JkRsXbF3naiYuFHrcbksNRsWnWOJ1O1i5eoxf9ALSkeiKtvB/lMIooF/fVFHBklDLw/ULW+dzJcJ7UZB43/fZs9w6xEi2hcemDHkdwcmZFFWIYVKmgp7xWnFf7XcQS7C6D/j+2iuvq5vFz+rsHyZv0PeCQX/B2f/41iI59FI78OnT8T2DvC10Dz6vuiczqLzBYaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2KBk9ip9ASB4wUFqqj6HlsXPH0qBEq/x1MglGuLUH0=;
 b=Y9X32hw6PUJOwO7b1eXeRJiGzGWMGQjb17Xq4cDa776gqX9Zft0SF8TvGcOlcPXI7VoOY7gakHT0EJQUce+1STmDetvMIBRtZ4YO4cwZGYSXCNWf3AArO4kmbHWtPriO3at2X1ctmLmdy+xZiDgMs1T/b1ML9hwl56MiX6VBigFtbD61D7Ax0c8U2F/RKQkUflsGb5+rkph3+mN6j1rNaQ+L53dUbgOGsfBsvYg5ugyU9zksym6uEqia1RmUiFCSgcwlbVa1xe0+VGIcrHKLl6zZIQVpkRVOKL0O06zMOo+5mph4A6ub+sim1UYgAPt05gSfEvwGdIvD4fPGubnNHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3728.namprd11.prod.outlook.com (2603:10b6:208:f4::21)
 by PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 00:37:43 +0000
Received: from MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::e4db:e815:f217:9b6]) by MN2PR11MB3728.namprd11.prod.outlook.com
 ([fe80::e4db:e815:f217:9b6%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 00:37:42 +0000
Message-ID: <5b6bdf6a-760c-4ba3-95ec-2d4482ad9bac@intel.com>
Date:   Tue, 10 Oct 2023 08:56:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
To:     Ingo Molnar <mingo@kernel.org>
CC:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        <bp@alien8.de>, <tony.luck@intel.com>, <naoya.horiguchi@nec.com>
References: <20230914030539.1622477-1-zhiquan1.li@intel.com>
 <ZRsUpM/XtPAE50Rm@gmail.com>
Content-Language: en-US
From:   Zhiquan Li <zhiquan1.li@intel.com>
In-Reply-To: <ZRsUpM/XtPAE50Rm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0001.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::7)
 To MN2PR11MB3728.namprd11.prod.outlook.com (2603:10b6:208:f4::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3728:EE_|PH7PR11MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a97251-18f3-4450-85fe-08dbc9291ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CBY4hmf8WRFrPIaKvVmi1/pintlSoTnvbNK/rr199jbt2E5RroYY2HztrQYzuB3E6iv/XZTmKcHrVB9MU/C7EUeycPeg0IB2wnAIDreCqmY2H+F+dGmforA5fi9qSSXzUeJvuBSfDNIzfmuIiNdVPKTJFXNhExHnjuLEUlLzMkUWJ8c/HwshuEJAR7MjVKioe8WpRMnubJxxlhIHBQFpWeHP+S8VKMQR3M5/bNgzAh6oRyIBWtprYZUam4PXvJMHCl1NRuPN1pX4w6QctjhWymcEHW5iFYbV9mBBZPVQya+2qUOixYjzhtDLIhichY+UO+FZoYjyWTylo0yT0Jx+85FDhBiqc6D7FGjUGVb7cG3E0x/9gPsUR0jPgAvFQzb7CfUuwIaODWRiIvvyPaQCgrOb+wxl0j3lMtfldwLDQjzdHpDP59innR3F5QBgt9lQyhLtmoyrfW62GQCcGJfm7pF1EPfYg+U0IDeWAlM+A+4dvuRHRaBULtTkkJhLGmFmOEM10GhWuavHLoaX4e0d10nYm/THSWENIjg+KK6zWIObu1u5LS8qwQUXES81d/SAhqhq8ZyLhYWlfTQ+PO/RTuv9Blx24vbdmk68L9kf3pqaGvf0wOolbIeuC3nh82JsIoYxmUjLscGNbjA9UMF/4Zok8nD1MUFSHIklb339a5LFQLK5LpAjt1iCRvD42ov3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3728.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66899024)(26005)(83380400001)(38100700002)(82960400001)(8676002)(4326008)(8936002)(66556008)(66946007)(66476007)(6916009)(6512007)(5660300002)(478600001)(41300700001)(2906002)(53546011)(6506007)(6666004)(316002)(6486002)(2616005)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUhTRjBaWlR0S050MWVodHN0NW4zNHFTSmZma3F1MVlPNGh2MnMweVVKTnRz?=
 =?utf-8?B?S3lhTnlZeWF5SnBuSEp4SjNranByeWZ6RlNIbnhHVTVqdDdlcFQyUEFCc21T?=
 =?utf-8?B?OElDemtyOGtwNTd1T3IyMXhwYTd6YVdvTHM1M3hQemJuRzBzaFhhc2t5cUg1?=
 =?utf-8?B?dURIRFZLb01XVUdnVnhPWllVd3EwL2RKMjdxMnV1YUxTQ2doMVMrQ0dCd0lT?=
 =?utf-8?B?VUZxczNVOE5JRUR0VTYyTEovS0JJc1h6cUdGOGhrVjBQdHJWZ3F5YUpjb0tG?=
 =?utf-8?B?TXZFQmVWWk5IMkJ2em0yb0tVeHM0LysvMkRQMXVTR0hVT3cvQlo0cmJQUFQr?=
 =?utf-8?B?dUczUnVkc1o1Z3Mwb2FWQkNCVllmQ2gwbTVla1BQSXJqMUZHR0o1SjE0WGxl?=
 =?utf-8?B?ZmlrY1FCaGxsNWN6VDRVM0ZoSlZkTVdNb1pVSnp6MXdHMVNheFA1MURxc2FZ?=
 =?utf-8?B?ZzY0Zk54KytlZHBkUnZmdGlhdXFwMkNySmI1OXNLZEVsOHE2ZUNnODVwTjhs?=
 =?utf-8?B?eldQNmx1NERROUwyTW1KNGN5MG5QVmlvVkNxVTI1cTV6ZzdSM2pjUG5XcG5O?=
 =?utf-8?B?cGwxL2dGMW4vdHlucURZTjQ5Z2paL2ZJMldFSHFITFEvV3FiMmNKeEFxL1pX?=
 =?utf-8?B?YWw4c3VQdzRjY1Q3S3VxVmhRd1lyM2pldlJ6SFkyenFvemN4M1UvOUU5OFAv?=
 =?utf-8?B?Nzc5eXQxKzBQS1ErMmh3eFpLRzlzcVNGSUJoNHMwT0ZrSGUzYjNSTUZzcnNV?=
 =?utf-8?B?OEFscDBrdGVVK1J4NURiRU1pdllzY2p3WmhsUGQ2QzNScTQvZGo3cjhQbUVx?=
 =?utf-8?B?dUdzeXcwMmM2NDMxRWZiNHd0OVhQdzgyc0c5RVlJZzVMYU93bVhBd3duUFR2?=
 =?utf-8?B?UkNpYldTOUJpTDdHclEvaXZOa0FkYWhwTUdHamRySFRzbW9lKzBTS1hFK2wz?=
 =?utf-8?B?RW5DOVV3bzkzMCtCWmMrNGZMU2VJM2NEYzVUSXQzOVpJemw4SU16Rllwdnds?=
 =?utf-8?B?YXowTyt4VDF6NFdsYVVJZHRodjdiejk5czZzc0ZnMkV1NWo1cHJFSkRGSWpI?=
 =?utf-8?B?QnFWOUhhVHZ0YWZxL0ZDT0Y0eXFpZFRySTRQSFFaTVA2QTNma0RNTDFZaHV2?=
 =?utf-8?B?eERFL3F6RTZnT0wyWVhQdXQzVlpqM1NZeEt3V3kzNDlJdmVwUjkvYnVpdTdr?=
 =?utf-8?B?bGhWMjlsSHpteDRXUzBhbS9SVHRaeG5McTFqZjZjUzFGMGUyZDQwQ2hOOUpC?=
 =?utf-8?B?c3BhcWpzcWE2TElKWnZhcWY0alh3TXNyNnFtZ0piNEZUczZxa0RDVDhhVytN?=
 =?utf-8?B?RVBDcHFTaUVQS1AvNFBUcnd0Ulk4V3RQL3Fia2dERGVDaWRrZE5NdTZDQU4y?=
 =?utf-8?B?T2YrTXB1WGxYa2Y2NFR2OXAyTzFCcUhjQW9EU2tXc2IzOC8za2haemkxaWUv?=
 =?utf-8?B?V3pmVDdMMGIreHkvL3gvTFlNS3VVZGxnQUhnTTRoYWRGSUJoL2NnV3p1ZFdG?=
 =?utf-8?B?cmZ6K2t3MlhRRkQvZEVkcTFySFFXNWVVSHczazlXNGtpeEtGdTVSNkJwVHZE?=
 =?utf-8?B?QUxVRUFGQTQ4MTFXWjdPb0pUbmxoRWtQL001TmltdjFxd2FIRFo4T1V2SEpq?=
 =?utf-8?B?ckRKMm1lK0lzREJOdE5YUkgzeGxwdHppdXBOcDdpYUpuS2FjMGlESHBBLy92?=
 =?utf-8?B?MHZTa1pGQVV6NHQrWnZlam1yT3BMVzlQRC90K3BaZS9UN2NNS0VLVFZERmNZ?=
 =?utf-8?B?RVhPYXBpUWlrMGpGZHMyaXlQMjRIN0lLaUJCVVg4TGxTenFNVCt5dHVPaVN3?=
 =?utf-8?B?OG9DajBlOUFQR2w5SUo1ZzNmdHdSNEtGT1IraktTUkM1TXhGV2VaZm5xM1Z4?=
 =?utf-8?B?UkJlR3BzcmE2aFlNZENYWDFnejVPOEJDR2tKZ05ucGI1UlBaNWtMeVhJa2ZK?=
 =?utf-8?B?Yk5Cb1BoeFFVRzJiYlVoN2xjRi90bXYrcTMzT1E5S3RwMTQ1cmZPcGlJRFUy?=
 =?utf-8?B?YlhPU2lTanc2bFNnVnJISHRROWVjMUk3RHUrMGQyb1NNeVg4eWlSZkx3MTB3?=
 =?utf-8?B?L2dOOEF2bURjeXlwbE4zZHhJbCtqMnV2ZGlYOUpLMjcxa21IKzkwOWNXQjZM?=
 =?utf-8?Q?M/JwbaDRFbBK8zFltyp/trlfW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a97251-18f3-4450-85fe-08dbc9291ce0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3728.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 00:37:42.0953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +19IfD8vwPEnekX7++tmtKr9jcU3dZfI1277OKBlNbkup3q1+2WT1IaYmkd1HMMiianmhV1kDCZqj+X/IhIONA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/3 03:06, Ingo Molnar wrote:
> The English in this commit is *atrocious*, both in the changelog and in
> the comments - how on Earth did 'Posion' typo and half a dozen other
> typos and bad grammar survive ~3 iterations and a Reviewed-by tag?? The
> version below fixes up the worst, but I suspect that's not the only
> problem with this patch...

Many thanks for your attention and fixes up, Ingo.

I’d like to introduce more background of this patch.

Memory errors don’t happen very often, especially the severity is fatal.
 However, in large-scale scenarios, such as data centers, it might still
happen.  For some MCE fatal error cases, the kernel might call
mce_panic() to terminate the production kernel directly, but not try to
make the kernel survive via memory_failure() handling.  Unfortunately,
the capture kernel will panic for the same reason if it touches the
error memory again.  The consequence is that only an incomplete vmcore
is left for sustaining engineers, it’s a big headache for them to make
clear what happened in the past.


We had considered 3 solutions and finally chose the last one.

1. When the capture kernel boots up, re-scans the MCE banks to check if
   there are fatal errors, set the PG_hwpoison flag for each error
   pages.
   We can foresee this solution is heavy.  It needs to find the struct
   page of error pages from old memory and set the flag.  Looks like we
   need to remake the wheel, so we gave up it.

2. Replace the function copy_to_iter() at __copy_oldmem_page() with the
   function _copy_mc_to_iter(), which is a #MC safe version.
   This solution is lightweight but has following drawbacks:

   1) Such issues are quite rare events; we don’t want to use a #MC safe
      copy to accommodate it. Especially, if the problem can be deal
      with by MCE handling rather than touching the Kdump stuff.

   2) The #MC safe copy is conditionally, whether it can fix the #MC
      error depends on MCE handling can reach the fixup_exception()
      function at do_machine_check().  However, in fatal error case, it
      might invoke mce_panic() to crash the capture kernel earlier than
      fixing up the error.

3. The solution in this patch overcomes all above drawbacks.  It set the
   flag just before the production kernel calls panic(), which would not
   introduce additional overhead in capture kernel or conflict with
   other hwpoision-related code in production kernel.  Furthermore, it
   leverages the already existing mechanisms to fix the issue as much as
   possible, the code changes are also lightweight.


To verify the fix is not difficult.  The issue can be simulated by
ras-tools
(https://git.kernel.org/pub/scm/linux/kernel/git/aegl/ras-tools.git),
"copyout" test case.  It can inject a fatal memory error in kernel space
via APEI ENIJ interface (need hardware platform support), and then it
touches the error page to produce the issue.  The patch has been
validated by this tool.

Any idea is welcome!

Best Regards,
Zhiquan
