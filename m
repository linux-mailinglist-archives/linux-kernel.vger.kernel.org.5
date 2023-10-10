Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78F37C0188
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjJJQYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbjJJQYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:24:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D327C94;
        Tue, 10 Oct 2023 09:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696955039; x=1728491039;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iTR1oR9Jb5RD0hm+96tiizLCA8yLON8AyCg4jc1fEuE=;
  b=ELD2FkSFvj67MhKjNDV9k99Sju3woq7UWc4ckM/zJ5btnQ+XxTo8Ms3M
   KqBRIIMSMaJ6ko9ukUzASsNIPw3GMxlRDmaXySfWD4fPkr4CzrqFAOJjm
   +BgDewQd8EkFKhu0cXhLiJt/fFY0tC0R3UOobG11/Ov1SkwZs0W+GP1qI
   eADrCQb6EATcEUt4/VvSNNR9ExfMuajFCeX7/FIWnF56uVMkbArkk5t3o
   SuRVDkS8ZKzTUAKr/bU42+K9W+GyXhvKGKnlHwsUlPHMfDw0SsS5XBbvn
   oymQJbYK+NKkk3rkfKENY1qiv+rpv9Pa6459CpJIQfcmlsnc54WoZppp+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="387277623"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="387277623"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 09:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="927214997"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="927214997"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Oct 2023 09:17:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 10 Oct 2023 09:17:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 10 Oct 2023 09:17:02 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 10 Oct 2023 09:17:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lW3esvc5H952EcEBxrZiRvzuyjqYtC+d22DILxwMQZZInBQesKnAzmiEYbsvwOa3RPtqemHvvcnAV7v6f3RXUpVNITiZbCE8pJOx73WcjJF1karktSGHoo2cW7s3gsDf0PAoMs4j9NPXg1RNuG8mnOkjS3tDFlCdYEn/JQuB2iz3mlVtAgj0tA0DBgHDTMYNyf0PAU7rU0XrZvBvm5eE2GVuxJGjlhb2PaaWHecbitohZy4lFfd08T6pE7Em+HOr0QjoSrL7xvLKvIQZ95XVWqsKXZlNjJ7QpDNh5zIQRCL3/GKnMYBV9zTNUf+0AXJYMc1cozGD+2z6lHjte7JLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3q2rtb42w8KTT5wRCyE2Gtv8zYZPgIU9XSubIi9ahg=;
 b=O6m5j8uG18DppL8ZsCWjQFBvWUs4imPe2X9KKQ0aTsc+yVJmi+LGTKmZCCxS0lJNvw6y2wVpAWzvAJMeNSQcznFG2Km7gnPXeRxME1Vp3FxikVA5/jFS5yzO9wK4KroZ7O8oTVHYZa0G9m5V+TzH06RsYOQc9GU2Wo+08V/Dzw/93cUqou6iU+vBhERQv3aXktjqSDK7om0N6UIT4PJbIiX61qKE5IsZ2I9xe1yc59wcV+E+oRoxgkU52T/aK6OhW/DYv2jY76YcHqD/9ql49MIzvqeFSCnt+K3ruqj8Lxerhv3BWEtKlStvCO69qYmStNV6PsRlhBbG/C4Iof64xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5560.namprd11.prod.outlook.com (2603:10b6:408:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 16:16:59 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:16:57 +0000
Message-ID: <0eb67a16-971f-4e5c-9c9c-9ae7902866b7@intel.com>
Date:   Tue, 10 Oct 2023 09:16:54 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] x86/resctrl: Non-contiguous bitmasks in Intel CAT
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <corbet@lwn.net>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>
References: <cover.1696934091.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1696934091.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0209.namprd03.prod.outlook.com
 (2603:10b6:303:b8::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: baf5dcc3-eb61-4997-2d3a-08dbc9ac5328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oo/lCsvcFbP52WAxKEcM1hKxt+1nT0HOSHEHongP6YAWtuL9YUSK2aFoL1izfh6qgyqdJF5jPNeIxrutL5NM8NkiJvRf1tFgemxe7fwrnnAUAMUwJ+ofE3Z3SKTM/j/uzJAvR+7Uq3Ry3XDscpDBZC8obSeM8EiGdajqZAySMqHxYqu5dRzZ1gkwyCHIneO9dh4BBaXqwj7FDVlz6WTXD/2DQ0AKLHekRz6k9iemHmPqn0zyv9iptE+Z7n+Lg1yv/2A/fQ+OnAiWzKAYE4xlDux38C36r4rMlvnO5dEHovV9QgcWGiUq8OSCDkHJbeRb0HDZFgPbj8FwH4R2JVt9jOtMG3Mako1uAHJ3tIOd3Bgq0XsQly/M0rAEUsjQ4KGc0rQ7keXHxX8eB/EieDHADFrkmHT3C4HsjwmTE1JmJGS2plY4LrHdMoIMf91Cyc+JpsfGguv4SpGgcNV/V/A59oNdUmTXdx4GQo3YhwDkpMVZ/pIMOS0+7ME397sILyblaP7QIDEm8SdNGCNzNbHaStlZ2rgLXdbo3ZYfTYuWdclVBDA7i23c3BMdP4/g3jn31Zya5dZqvIVlWxrpGngCn1Gxr7w5z31vFCdiBE7EHiXHwj/IiyLMtdSEQTOfI2ok2SBcj7ROry2st/Z9Oht1BsLmvLNbTiQ6P6efRV2ao08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(53546011)(6506007)(2616005)(478600001)(966005)(6486002)(6666004)(44832011)(26005)(83380400001)(7416002)(2906002)(5660300002)(66946007)(66556008)(66476007)(316002)(8936002)(4326008)(8676002)(41300700001)(82960400001)(36756003)(31696002)(38100700002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDRydUdRdTZKb0NDUHlxa1U3cytLL0JSY0lDOUJlRGQvQjVlc1hyenZWK1Fl?=
 =?utf-8?B?andkKy9DKzJTb3VNQmd2OHM2VzAyeVhXeUtYSVE5dWlpYkxPcHBwb3FYYzZ3?=
 =?utf-8?B?QlNDSUZMMTdiUVMvTWpkdlI2ZFE4ZE5lTEFpZTNkdTBYbzArQjVZblhVWlho?=
 =?utf-8?B?bDlGTEg1RFFjZWlpQ29XeDl5TG9GYlpVRkZMRGxoWFp6SWlycWxzcS80Qkkv?=
 =?utf-8?B?YTNmRXBwMWU3S0RJR3plUDhwclAxSmZXV0ErellZWThyUStzckNLTzUvMlJK?=
 =?utf-8?B?czdyMEVqTW9DWFRZd21TVEl4L1NBUkFRKzZQTm5CRnVVMkNDVWFJUW5IVDNL?=
 =?utf-8?B?Z2U1ai9ydmZtZTREYmlpSUNZaEdpT0lUN2hEb2FOTUxmOW1aWU5rYS9TSFNM?=
 =?utf-8?B?THhNY2lSODVIOTNvM0xINUI5cW40MFd4ZU1maVViaFNLblpZNkduMi94MWhX?=
 =?utf-8?B?NnFBSW9DUzdQNnJhYjlvaVA2dEd5VmhUWmFPUk82TDN6d1JCWHRGWmQrTjVz?=
 =?utf-8?B?RVRDKzlWVTlkKzdiVi9lYVhIVXBXTHZGcUVsR3M4RlJEWFFkL1VlMm95cmt2?=
 =?utf-8?B?K2p1Y09nMHJINlA1dTNaQUVnWWFlOW9XTDNMejNuQjNqbTJ6ZXExQ0FrTFFv?=
 =?utf-8?B?blFNOHFSVVRmRnJjRzNrWG54WkVOL0ZpY2lsTlJxTkVEa2FhSVI0NkVyQlRs?=
 =?utf-8?B?bm5iQytxMnJOV2NzYXB0bzZUU2tDM0JuYXQ1WExLM2o0bVpwNzllVzJHbXBT?=
 =?utf-8?B?YXpqdUF3OE56L1hwZVYrUWQ4Q2pwZjFDZTJzeEFoY24xZG55akFicDd3VS9V?=
 =?utf-8?B?UHhWcSt6WlhhbkJYeDgyQVRiQU5LRHBTVXFmMUtMb3h6bmdaMGJGcVQwbVBv?=
 =?utf-8?B?TFBTWDNuR1RmVzVRRllkcGMycUlSL3Z4RHFmM3gwbmQ1Z1h3SFMydnVNVUV0?=
 =?utf-8?B?ejltT1dPUFRjQ0lpUDZMbmZ1SndhaERqZlkybkJ1NGZNSzJmT1FTZUJGb3VK?=
 =?utf-8?B?cjRSN1E0SG9ZOS96MjZZV05RdmpJWjVSaUJvQWhCMjQ1cnRMc2pkWGd5eFJF?=
 =?utf-8?B?SkxCU2hZN1J3TUk3d3FJZjcvQUMvbEZSaUd4NlJlYnBCZFgrdjdyZlBWWXda?=
 =?utf-8?B?SU1hdEhnR3ZSNWJjM3dsc2dSeGlCQ3lNeTJ4ZFUyTUFxSk1TdE55MEJUbG83?=
 =?utf-8?B?YlVFS1R1ZkNSSEZFOGJkMFFseWJPM1pzZFJIcnAzZWs1bXNnU1dGRDB5RVpQ?=
 =?utf-8?B?V2l5UmQ1aWVaV2VEUlFaZVprRmFQZXRjRmh1SVZjRURNbHJnVGhsdnp1ZXRr?=
 =?utf-8?B?WDdCTDY1R24vaVJXVEZ3K0Z2Y1BjZDhoNG54RzRoSVJQZ0I3S2dWM01XSzhv?=
 =?utf-8?B?c3oyRkREMGNxeXY5TlRTb0J6bDVpdTd1cDRyMU93Zm13NXhzTW4wamNYT1Q1?=
 =?utf-8?B?a0YyUjl6MkdoVFJVLzhITDdheVQyelNtaTBtaTJFcGVSdDJSNEkvME95VVBq?=
 =?utf-8?B?d0JXQUZ6T0lsWTJ1NWxPeFBRa0U4bFBTdVYrL0cra2xsVkg1V3ZZNm5SeGZN?=
 =?utf-8?B?MzBJemk2N0NxNWdjc1BReWVjeVlIOERDbnJyVk1kTmkyeVl1enNZREZYeS9S?=
 =?utf-8?B?U280c253Ym5DeTdDUThaMVFiSVJqUzl3RU14bFc4NU8yWS9XOTB5ZHZkck14?=
 =?utf-8?B?LzhGbzQxWUs3bXBaNEhjRW8rank2WVo0Tyt2anQwOC85MFZ0WFhOcjJKSko5?=
 =?utf-8?B?Mk9CZURENlpkOWpsY0JZWTcxRnlTaFNLMy92WjZyWHlsUHVLYVNWcVpBT1Ay?=
 =?utf-8?B?K0xPNlRzMGI2ckV4TkV6UDQva0hMaFl0RVRSSHNoaWNJeXg5TXJ4eWU2V1Q0?=
 =?utf-8?B?KzhEMC9BUzdpK2tHS0dUb0xtbFNNRmZBVWExYnoyNm9YZXptVG5WMHlzYUdy?=
 =?utf-8?B?ekp4eExJMkpnbytiN3hRSHlRTUNqeDMrTEFFOGtodEtUK2NGU0JDWGlvazBt?=
 =?utf-8?B?NGd2eGlzZFRYc3ZWbHZSNjZOU1ZOdy9xVGt3bEloTkJFMnI1WmFFeTVnbGl6?=
 =?utf-8?B?UE9raXgxZkdQT0NSaVMyL1cvNDVSZG53WWcyNEt1MVRqUnNNb3RIRHUzTnhh?=
 =?utf-8?B?WjlTQkhYQjhYSE9UQ1daRHNYdjIrT2RiTGMwMlh2ZUNTdkRuZDlLSEJmTGU5?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: baf5dcc3-eb61-4997-2d3a-08dbc9ac5328
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:16:57.3565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDkPcEyjNmWZafzfeCNVkQN3qksmi9X1RBKXgvYVf4+Cj27jBcN2KmG/VY8hrdN/5fbt5ER9WgO1xU+x7Kb/CpsdBMwCrFCnHyRRPVp8DVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5560
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi x86 maintainers,

Could you please consider this series for inclusion?

This is the second resctrl series that is now ready for your
consideration. The other series is Babu's work [1] that has already
been reviewed by Boris and we await a new version.

There is a merge conflict between the two series. I assume from
conversation with Boris [2] that you will decide which series to merge
first and then the other can be rebased on top. Please let us know how
you prefer to manage this.

Thank you very much.

Reinette

[1] https://lore.kernel.org/lkml/20231003235430.1231238-1-babu.moger@amd.com/
[2] https://lore.kernel.org/lkml/20231009165403.GCZSQwKwjGifBIQTpq@fat_crate.local/

On 10/10/2023 3:42 AM, Maciej Wieczor-Retman wrote:
> Until recently Intel CPUs didn't support using non-contiguous 1s
> in Cache Allocation Technology (CAT). Writing a bitmask with
> non-contiguous 1s to the resctrl schemata file would fail.
> 
> Intel CPUs that support non-contiguous 1s can be identified through a
> CPUID leaf mentioned in the "Intel® 64 and IA-32 Architectures
> Software Developer’s Manual" document available at:
> https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html
> 
> Add kernel support for detecting if non-contiguous 1s in Cache
> Allocation Technology (CAT) are supported by the hardware. Also add a
> new resctrl FS file to output this information to the userspace.
> Keep the hardcoded value for Haswell CPUs only since they do not have
> CPUID enumeration support for Cache allocation.
> 
> Unify variable names to match the "bitmask" convention rather than the
> "bitmap" one to ensure consistency.
> 
> Since the selftests/resctrl files are going through many rewrites and
> cleanups the appropriate selftest is still a work in progress. For
> basic selftesting capabilities use the bash script attached below this
> paragraph. It checks whether various bitmasks written into resctrl FS
> generate output consistent with reported feature support.
> 
> #!/bin/bash
> # must be run as root, depends on a recent cpuid tool (20230406 or later)
> # variables
> RESCTRL_INFO="/sys/fs/resctrl/info"
> L3_NON_CONT_VAL="${RESCTRL_INFO}/L3/sparse_masks"
> L2_NON_CONT_VAL="${RESCTRL_INFO}/L2/sparse_masks"
> L3_NON_CONT_CBM="${RESCTRL_INFO}/L3/cbm_mask"
> L2_NON_CONT_CBM="${RESCTRL_INFO}/L2/cbm_mask"
> L3_CPUID_CMD="cpuid -1 -l 0x10 -s 0x01"
> L2_CPUID_CMD="cpuid -1 -l 0x10 -s 0x02"
> PASSED_TESTS=0
> L3_SUPPORT=0
> L2_SUPPORT=0
> TESTS=0
> 
> run_test() {
>         # L2 or L3
>         CACHE_LEVEL=$1
>         CACHE_LEVEL_SUPPORT="${CACHE_LEVEL}_SUPPORT"
>         echo "Checking ${RESCTRL_INFO}/${CACHE_LEVEL}..."
>         if [[ -d "${RESCTRL_INFO}/${CACHE_LEVEL}" ]]; then
>                 eval "${CACHE_LEVEL_SUPPORT}=1"
>                 echo "${CACHE_LEVEL} CAT Feature is supported"
>         else
>                 echo "${CACHE_LEVEL} CAT Feature is not supported"
>         fi
> 
>         if [[ ${!CACHE_LEVEL_SUPPORT} -eq 1 ]]; then
>                 echo " --- Running tests for ${CACHE_LEVEL} CAT ---"
> 
>                 # read sysfs entries
>                 # are non-contiguous cbm supported? (driver sysfs)
>                 eval "NON_CONT_VAL=${CACHE_LEVEL}_NON_CONT_VAL"
>                 eval "NON_CONT_FEAT=$( cat ${!NON_CONT_VAL} )"
> 
>                 # are non-contiguous cbm supported? (cpuid)
>                 CACHE_CPUID_CMD="${CACHE_LEVEL}_CPUID_CMD"
>                 NONCONT_CPUID=$(${!CACHE_CPUID_CMD} | grep non-contiguous | grep true)
>                 NONCONT_CPUID_RET=$(( !$? ))
> 
>                 # what is the mask size?
>                 eval "NON_CONT_CBM=${CACHE_LEVEL}_NON_CONT_CBM"
>                 MAX_MASK=$(( 16#$( cat ${!NON_CONT_CBM} ) ))
> 
>                 # prepare contiguous and non-contiguous masks for tests
>                 BC_STRING="l(${MAX_MASK})/l(2)"
>                 MAX_MASK_BIT_COUNT=$(echo ${BC_STRING} | bc -l)
>                 MAX_MASK_BIT_COUNT=$(printf "%.0f" "$MAX_MASK_BIT_COUNT")
>                 BITSHIFT=$(( $MAX_MASK_BIT_COUNT/2 - ($MAX_MASK_BIT_COUNT/2 % 4) ))
>                 CONT_MASK=$(( $MAX_MASK >> $BITSHIFT ))
>                 NONCONT_MASK=$(( ~( $MAX_MASK & ( 15<<$BITSHIFT) ) ))
>                 NONCONT_MASK=$(( $NONCONT_MASK & $MAX_MASK ))
> 
>                 # test if cpuid reported support matches the sysfs one
>                 echo " * Testing if CPUID matches ${CACHE_LEVEL}/sparse_masks..."
>                 TESTS=$((TESTS + 1))
>                 if [[ $NONCONT_CPUID_RET -eq $NON_CONT_FEAT ]]; then
>                         PASSED_TESTS=$((PASSED_TESTS + 1))
>                         echo "There is a match!"
>                 else
>                         echo "Error - no match!"
>                 fi
> 
>                 # test by writing CBMs to the schemata
>                 printf " * Writing 0x%x mask to the schemata...\n" ${CONT_MASK}
>                 TESTS=$((TESTS + 1))
>                 SCHEMATA=$(printf "${CACHE_LEVEL}:0=%x" $CONT_MASK)
>                 echo "$SCHEMATA" > /sys/fs/resctrl/schemata
>                 if [[ $? -eq 0 ]]; then
>                         PASSED_TESTS=$((PASSED_TESTS + 1))
>                         echo "Contiguous ${CACHE_LEVEL} write correct!"
>                 else
>                         echo "Contiguous ${CACHE_LEVEL} write ERROR!"
>                 fi
> 
>                 printf " * Writing 0x%x mask to the schemata...\n" ${NONCONT_MASK}
>                 TESTS=$((TESTS + 1))
>                 SCHEMATA=$(printf "${CACHE_LEVEL}:0=%x" $NONCONT_MASK)
>                 echo "$SCHEMATA" > /sys/fs/resctrl/schemata
>                 if [[ (($? -eq 0) && ($NON_CONT_FEAT -eq 1)) || \
>                         (($? -ne 0) && ($NON_CONT_FEAT -eq 0)) ]]; then
>                         PASSED_TESTS=$((PASSED_TESTS + 1))
>                         echo "Non-contiguous ${CACHE_LEVEL} write correct!"
>                 else
>                         echo "Non-contiguous ${CACHE_LEVEL} write ERROR!"
>                 fi
>         fi
> }
> 
> # mount resctrl
> mount -t resctrl resctrl /sys/fs/resctrl
> 
> run_test L3
> run_test L2
> 
> echo "TESTS PASSED / ALL TESTS : ${PASSED_TESTS} / ${TESTS}"
> 
> # unmount resctrl
> umount /sys/fs/resctrl
> 
> The series is based on tip/master branch.
> 
> Changelog v5:
> - Rephrase patch messages (patches 1/4 and 2/4) according to Borislav's
>   comments on Babu's [1] series.
> - Remove redundant message paragraph from patch 4/4.
> - Rebase onto tip/master.
> - Add Babu's reviewed-by tags.
> 
> Changelog v4:
> - Add Ilpo's reviewed-by tags.
> - Add Reinette's reviewed-by tags.
> - Reorder tags in alignment with maintainer-tip.rst.
> 
> Changelog v3:
> - Add Peter's tested-by and reviewed-by tags.
> - Change patch order to make 4th one the 1st.
> - Add error checking to schema_len variable.
> - Update cover letter since now the feature has moved from the SDM.
> 
> Changelog v2:
> - Change git signature from Wieczor-Retman Maciej to Maciej
>   Wieczor-Retman.
> - Change bitmap naming convention to bit mask.
> - Add patch to change arch_has_sparce_bitmaps name to match bitmask
>   naming convention.
> 
> [1] https://lore.kernel.org/all/20231003235430.1231238-1-babu.moger@amd.com/
> 
> Fenghua Yu (2):
>   x86/resctrl: Add sparse_masks file in info
>   Documentation/x86: Document resctrl's new sparse_masks
> 
> Maciej Wieczor-Retman (2):
>   x86/resctrl: Rename arch_has_sparse_bitmaps
>   x86/resctrl: Enable non-contiguous CBMs in Intel CAT
> 
>  Documentation/arch/x86/resctrl.rst        | 16 ++++++++++++----
>  arch/x86/kernel/cpu/resctrl/core.c        | 11 +++++++----
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 14 ++++++++------
>  arch/x86/kernel/cpu/resctrl/internal.h    |  9 +++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 18 ++++++++++++++++++
>  include/linux/resctrl.h                   |  4 ++--
>  6 files changed, 56 insertions(+), 16 deletions(-)
> 
> 
> base-commit: ef19bc9dddc3727dec1efa08683f658b1f4b7b78
