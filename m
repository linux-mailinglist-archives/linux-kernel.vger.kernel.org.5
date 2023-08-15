Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1177D66B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240472AbjHOWu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240479AbjHOWul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:50:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62374FB;
        Tue, 15 Aug 2023 15:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692139840; x=1723675840;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hhJyN6qVFeSS3zJJskotPpzuqGHL+Jn03fXlK/30VsE=;
  b=nTGGCWQz2eAic1vG4+thY7g7ffwVS70odgqU2EXmDn/TxtV+yekSpL1F
   yX1bHILCKZk2fz4v1+xiChaOj70/zV6H7JrhucUoZ45CjyE/bZB5dzPnv
   LAXSg2PsNt7A9ataZSzSH3JZBigmPVUIEbqsg26+JmVAGjveCeTOH2PZM
   3fdGVykNUGtmYXl/0HSgYTEGiTgAoU7dMTYsf2gu5rPUuKi4YpsLbdama
   mN/rHOiTiVyxnDLE/MkLlhtoijkk3miiu07BJzvrsYqUtyeGXb3NRJytE
   xeXhmj/pN7tTXaoZawuOuHRhPym0vMBWl80Zf34BLk6mtseyO6EZgTnkn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352722235"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="352722235"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 15:50:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="907791693"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="907791693"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2023 15:50:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 15:50:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 15:50:39 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 15:50:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE6yVtV5ErjpTeO8XKFV41ZqwOn8AkkyH0zmzgvfToX7OBlAJ+eN59tPwfelXZGRXgA6vWJCBhA3lU377leMQ+q+SS0jRFxgWBNVbEG3GM1UiJLmjzXRl7d90BRZtWoMXHRzm1qdUM6FI/vjNUbhh5iw0114OOL6XXwDSoSQ6Sr1Ac/Pf/Oo5i6A7rW8Dt9QlXxlxMyWJdQQMYN9RMrnuo3KVBjAyxjQaqicBi/TOlRNapYgSfL5NOpqWzZVHC+Luva4xZKNHnlVFBIFcqrtW1VKvR3zSYUn50RUkDonj1pSGdZXvnOd84gaO+amb2e+nWLUnp54rRP6Q7WpjB8KsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVT+jlKQpk9NsnsIqU426zqJszYCYBCVMo3XR/+j2TU=;
 b=O8gECXO00kJosQq92b8Np1VRY3mVsLRY+6o5nMmPNqiyez5X51nw/6VvTDrIQSnSqOVVmE2exEg3Gku1eeRevbWOc+iH2Ruq7Geksmb09sOHeaYJvWeQRN5YAur9A+xEZnWOupiUSyPeU9auIifknLU4I+GExi0SOaWf2LfJiX/AkJs6TIGgrXLcgkSIMmXZZUnzqKQpITAUEH8NWUQSdv+MmwRK1ouKER/oqOyvACO0KITXQ7FERBQz+5ypnGcioeh2DClLrLPvj16dV4NdLy3mTPXtO4P7uqGzk6i9Z1RgQlqB8vh367uWIpYJ7sEhOJL2km9W9AVTECgOW2iXNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6124.namprd11.prod.outlook.com (2603:10b6:208:3ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 22:50:35 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 22:50:35 +0000
Message-ID: <b84a9ec3-5b65-9334-becc-0d90bfbbccfa@intel.com>
Date:   Tue, 15 Aug 2023 15:50:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v7 6/8] x86/resctrl: Move default control group creation
 during mount
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <169178429591.1147205.4030367096506551808.stgit@bmoger-ubuntu>
 <169178463637.1147205.7411319721706077266.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <169178463637.1147205.7411319721706077266.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0204.namprd04.prod.outlook.com
 (2603:10b6:303:86::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: e833e5cc-5fef-4417-af43-08db9de2095f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhkbWXz0y0Uja+U3h3/4qWVar/PyR7h9cIPkhIbFlcxkxBQkzPBXgIOFpXaC1hFzzM34Oq2WUJrPLY1Sl2wFCEBPkVbrwO7Q+a91ku6hAzYw98cj5Nu6IdJWgluJuaXh7/SrL/q4qwTpCJOEOlWpQ9dSEDZxjuxUzDEDqUfGPl3DYXXioYj7rSTYLEPRgUzu16cKp88W2kZ31JhGQqAedDgaFCHnjKE/GQhohv1vng3FFHnkyDmNmRqqK2rrXHdEpQ5d8arHBtR0UOLuETICPZBKGB65BLn/GP/9n+1elReQRuH/lpijcV8GHaf9NeyhRtSbhNXAcm1o6+9zglkfM5m9NtvoLPgONbkkwmboDJxiyzWyDRWrtB8b1uY2isv2I69yuXWN4MD90Z/UIiyfcbrLKinIGpQCPy4nHGBtHsL9qrNkrX38uO5COAXfsOEPRgfzZqExTaQGVTeba3xraeGZYG/ptcXnb0YYoTM6fjtdYr+RxqA/M402E5KVBdjYswRGKEgkf2lVwTwfyry4zngtKHe/u7AHV/q7DfotKo4L97Ce25oHgAre3M2m8W2Dl/Boab5cTHAH3N6JU1S2S97GqVTGSJaXnRzQXm//iSp0ju0Gxt3GtruK/S4iLkRmgOY41XFRDYvN3PVPbxSnrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(26005)(6486002)(31686004)(6666004)(38100700002)(53546011)(7406005)(6506007)(31696002)(86362001)(36756003)(316002)(66946007)(5660300002)(44832011)(478600001)(82960400001)(8936002)(4326008)(8676002)(83380400001)(7416002)(41300700001)(66476007)(2906002)(66556008)(6512007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YURGN2tTSUZHZ0EwemVwOC8xM05VT0YxUXdjNEd4RDlYdVlvVHlJMDJrU3Nv?=
 =?utf-8?B?WjVvc3VhaEFxc2YzVTgrRzZkNDRZRVphVlFtL2llMGxObEF0YmVhNkpicXd4?=
 =?utf-8?B?WmV0YWpJYlBYMzIwV0hBTnpJQUNQTFlLdU1oRC9ETmdMcVdOczFTTjVEN2ZI?=
 =?utf-8?B?WWVUaXplUkFnWE5zbDMzOVhneHRLMnhWY0Qyb3lINWhCbStIMkZoYSt6VU11?=
 =?utf-8?B?dFF6R1NieER3WDYrL0ROOWhKSGZrakJKNG54VjJIRXdFSjBKWTlJc3BpYVh2?=
 =?utf-8?B?ZVB4dSt2RjhneW5wS1lWejkzalAwRmg5NXUrSXpwUmJVaHduMkZ5NGx4bzNT?=
 =?utf-8?B?eFY3RGcxQjB3OEdDOTFLYmVHRzV1TnV5b25IYzRTVlRYT1hVYWZWdTJTOUtN?=
 =?utf-8?B?Z2JlWWJBVTl6QkxScG4zSCtFZ1R2QW5RdjlueTFIcFR1ZWFuNU1NbUR6bW5x?=
 =?utf-8?B?MUphQ2h2b1IwSzdRMWlSWExqQ0ZPN1lJRzdGb2oxakNUc3RDZGp4YkVURk9R?=
 =?utf-8?B?QVFjeHZiVXpvREczTVBzVWRUUnZnSUJ2czY2N2V0K1VrbU1TcGN6YWJtNlJG?=
 =?utf-8?B?TzRnU3BaYk5RaEY0YVBwRzdxd0JGdmN5QjMxbURINHRRUWx5RE1BSlpvNjU3?=
 =?utf-8?B?TW43NENLZjF6V3FqYlpZNitSWHRicTV5Nk1zSlRzZm1BU25JNXVTeExWbzk0?=
 =?utf-8?B?cmtjK2k4ODhpZTdNekRVbHV3TUNWeHFLSmRES2V3ei9DN2VGeUlCaTgxM3ZF?=
 =?utf-8?B?VWppTFdHd3BER1hVdGFnY0UvbXdNb052ZVlaSFk2VFA5V0NDT0QwQnM5VnBt?=
 =?utf-8?B?cFZHWWpjQlFId3NFcHFSRXF5aTgzMFNlMHdFL3Q3RWdCVjJaYkNQR0FPSkVt?=
 =?utf-8?B?NE9ZSllZcXR3M0syK1hUd1h4cld4NjhPWTVCWnNKc0pTVGJZbW0yMzByQXl2?=
 =?utf-8?B?ZjNEZzl4aktvcyt0UGMyNzVrbys5UTEzOGU1NU1VdVFWN0lKdFZhcVpTMmpD?=
 =?utf-8?B?MldvRUFveWszQXFMdTI1N05FNm4vUFI0bzVZb0paSG5qTTlub3RhVjBmbXJX?=
 =?utf-8?B?WWladm0zNFVBRjZPOFV3QnM5a0dNY2NiNWRISnZaM1MycDI1NVJHRGFnWGhG?=
 =?utf-8?B?d0JhM0VnblRKVUdpUDk4UE00YXZnQlgxK1J1NWkwNCtqN2dsVlh4V2Rla2dZ?=
 =?utf-8?B?UjJNYnRTZHVIazg5OE9qOW9HVHBiRmJ5WXNkamJPWXJsSXBsQmpaVEVONjZP?=
 =?utf-8?B?TWdOaTYxUmY1TFI0NGVaZ3dTOU4zSTk0NG01TGRQVjFsS0FHOVZjd2ljUWht?=
 =?utf-8?B?T21QdXBHUUdUQmZQeUNFSzRIV2doWGpSeHlMdEZkZGYzaEptNGEzbk5mMHRZ?=
 =?utf-8?B?RENZWUVPeG80VVRONnh4K1lreDdtS1JJcEpkUXNqZTc2K2hROGdHWVBUOWU1?=
 =?utf-8?B?dDV1SkVTb1YzbXI2eDlwcEsyWUJqbjlZK1JyeEU4dDJ0RE1RY1d4ejYvNWpv?=
 =?utf-8?B?b01FWEk1RGxQRnBKcnBVMHFZZ1BNdkZsTHB5bi9RcXovcG80MUdEdGQ0WEJi?=
 =?utf-8?B?bER1QzBnVnI3VmF1UXg0T3k1RGQ1aFhlLzA0cWNsdnFpTXJNdm41cGFqaWRN?=
 =?utf-8?B?Rk9iUUFGWWZDb1FmNnZhVlNYVHdCZVkvQW83emlhYkRXVFBaVlFBL3VGczZE?=
 =?utf-8?B?eDhoNmkwc2hLVVRIWjlmbFVueUJjbHhMVStiTzNlS0JWbTJRMlFZc1BtUTlV?=
 =?utf-8?B?REgycXArK3l5cHlzL09GdXR5WmlWNzJzMDh5NkVqNnNtRCsvSGxCSVhQWDFB?=
 =?utf-8?B?WnlYR3d2dUVoVGFwUkRxNXFYbTcrWXlLRHIrYk9BcGVuVzJtR2Rub1F4RGc1?=
 =?utf-8?B?WC92Y1lHTFY0SWJFVy9xK0c0ZUtBSlpjckJzZFcrcW14Mm1lVmVpSzZrMGdH?=
 =?utf-8?B?VWMxVW1yVnprYk5TTlpMR1FubVV1OTBEODdNQUp3ZTdNY0p5NHVpUjR2b0dD?=
 =?utf-8?B?U3ZIVTd1UXRWWTl5RlZrTUdiWksrbjVrcG9VdXNnb29rRzRoTkM1UTFlcUk5?=
 =?utf-8?B?SXRpWmhxMkFZYU1qbHVXTkhuUUMzU2ExT0VGL045cEtmNUhSUitMSmZJZ0hp?=
 =?utf-8?B?TTBUNm5hcjliSlBVSjQwcFQrSEh3OFltRHhhVVRRaEpwemxEeksybWdxR3Ri?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e833e5cc-5fef-4417-af43-08db9de2095f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 22:50:35.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kw1RdhKXjtY1OmPExE7sDHyxPebHgSkNfTWalXD8fIK+0UbSYy4c5cMhe5nsEYKYXlrhqq+6C5Gs9M+5MDrQKWMRNadaOahzTfeaWkrb+po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6124
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

Please do note that the subject is no longer accurate.

On 8/11/2023 1:10 PM, Babu Moger wrote:
> The resctrl default control group is created during kernel init time.
> If the new files are to be added to the default group based on the mount
> option, then each file needs to be created separately and call
> kernfs_activate() again.
> 
> This can be avoided if all the files are created during the mount and
> destroyed during the umount. So, move the default group creation
> in rdt_get_tree() and removal in rdt_kill_sb().

How about a slight rewording (please feel free to change):

  The default resource group and its files are created during kernel
  init time. Upcoming changes will make some resctrl files optional
  based on a mount parameter. If optional files are to be added to the
  default group based on the mount option, then each new file needs to
  be created separately and call kernfs_activate() again.

  Create all files of the default resource group during resctrl
  mount, destroyed during unmount, to avoid scattering resctrl
  file addition across two separate code flows.


> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |    1 +
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   50 +++++++++++++++++---------------
>  2 files changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 37800724e002..2bd92c0c3b0c 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -602,5 +602,6 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>  void __init thread_throttle_mode_init(void);
>  void __init mbm_config_rftype_init(const char *config);
>  void rdt_staged_configs_clear(void);
> +int rdtgroup_setup_root(struct rdt_fs_context *ctx);
>  
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 0805fac04401..a7453c93bad4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2521,10 +2521,14 @@ static int rdt_get_tree(struct fs_context *fc)
>  		goto out;
>  	}
>  
> -	ret = rdt_enable_ctx(ctx);
> +	ret = rdtgroup_setup_root(ctx);
>  	if (ret)
>  		goto out;
>  
> +	ret = rdt_enable_ctx(ctx);
> +	if (ret)
> +		goto out_root;
> +
>  	ret = schemata_list_create();
>  	if (ret) {
>  		schemata_list_destroy();
> @@ -2533,6 +2537,12 @@ static int rdt_get_tree(struct fs_context *fc)
>  
>  	closid_init();
>  
> +	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
> +	if (ret)
> +		goto out_schemata_free;
> +
> +	kernfs_activate(rdtgroup_default.kn);
> +
>  	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
>  	if (ret < 0)
>  		goto out_schemata_free;
> @@ -2589,6 +2599,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  	schemata_list_destroy();
>  out_ctx:
>  	rdt_disable_ctx(ctx);
> +out_root:
> +	kernfs_destroy_root(rdt_root);

Please ensure that all rdtgroup_setup_root() cleanup is done
here. It seems to me that rdtgroup_default.kn can be left pointing
to freed memory. Since this cleanup is done multiple places (here
and rdt_kill_sb()) it may help to create a helper.

Apart from this the patch looks good to me.

Thank you.

Reinette
