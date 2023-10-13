Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9A7C8B62
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjJMQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjJMQSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:18:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED76676BB;
        Fri, 13 Oct 2023 09:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697213827; x=1728749827;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eDg7PjKFI6fYDzrW8fqpXVxhXzF/EZxDyNrQ8RX9D0s=;
  b=BMGbcZvvVeu4hLRFy2tYXg45m7plgEHXJB896e++AgUWK1nzh5hOqWkc
   yUQTErHzs0vuKAqnPXTlwHQY8ze3T5LCWaQCGMLOl3mDGcJar5LfTvWNS
   akKSQfus4+anBSnWpjWfxL91RiP45toxRk6QALKUtp68XzTSNjC909sPE
   gtHVn+64V3TvYDI7TcmixdS/PkYc3xIWUR+pByso6GWgC6uTcI64reAWs
   076rnq6jLAZJcBpeTtHtVKltZoxDh9/pi0qHevvau6Dm2c2V5jg3GgD99
   KQGq3JxRa9Q/DX6Fznt6Dr4c9jBKtLWy935wynldSAlSDtRO++l46muI+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="6774578"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="6774578"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 09:14:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="898614032"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="898614032"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 09:12:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:14:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:14:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 09:14:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 09:14:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PW/G21K3yVgpHL7XEWC0CS1n16U8mrmk7kVIOi7ZlRwmiAOHyxn3BvdAA33Kz7Adaj0PxgmFUB92DvpynaQHzWwN8+cmzqDXtGXl7R1Eh/l+E7CT+UCbg3yk7nRY+K11n7KoUIlxZmlbts/7KAPw0Irg7sk+9EmFfxgAM2GRupkTTWvWmETTmzxfJ0h+gmxNR0CKdRuxbZaowapqPePQ3GjqIKjLJqYV9mKCFP9Yk+x4Dx5x6C+E72d4CPx7COI1Q7/e1AzRPWT+rD/xp8wURO0bY5lWp880/mSNn6QOKwL2RscwNRUaMfrNCThMB9LCgWneYNJbwdUmvergJgzI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKGOPoYc+Vmy8Wkj5yd8LNwmF9fv8cA2cWQwjipk08w=;
 b=TEaZj87rNTeFotkgKzTXBhLP0SHJAERodph4IY+JclhUFnSptxp5IEamHVTvZxiLGCtxdhQl7RtJ+s7pIYGrLMRVsrTVZTAwdACLrRAqsFY/5NwmPqx2KIP44Ok1EIC2U1uDcdPx1AlVWNXBbzgTRuFT/Hs+mkLBWmTbbBTHg9pEZQvjr6Xw980p2qFRQ14Z/CUzXBRXh4OVr2FtvODr1HRMQig93Ebh7RcDp5FeXeYt1olC/l9AAOGdC3rFiyW2r9XZuPPqP0rAt32Kx9LJYbU64wFJUo/2cI2Id03dCLx9WN3X/vNntgdi7eRX7IZMhO56H6cST9n5O8cATCP4OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by IA1PR11MB7872.namprd11.prod.outlook.com (2603:10b6:208:3fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 16:14:01 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 16:14:01 +0000
Message-ID: <9cda7031-286f-42e6-a23f-80c284931696@intel.com>
Date:   Fri, 13 Oct 2023 18:13:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] acpi/processor: sanitize _OSC/_PDC capabilities for
 Xen dom0
Content-Language: en-US
To:     Jason Andryuk <jandryuk@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
CC:     Roger Pau Monne <roger.pau@citrix.com>, <stable@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
References: <20231010173924.44167-1-jandryuk@gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <20231010173924.44167-1-jandryuk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::23) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|IA1PR11MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a531bb1-2e38-474d-ca29-08dbcc076977
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7cuAIBos4LcIYeG+2LjhWFo/t7JlNimMm5dfPZlkBgpumiZexwriVyiTyv63IBC+HvuM3d9Cf9Ky8QrUeDsvOkBEf9KVNMf/6vm6gfmYdztd/XkkvbEUrKZ7kXyFjuYnHLd98omXSosTuCb9sdZw7Lm2wsQWC1AAppVcKqzbF6QFaZr7e3xKGNXmbF6fcm02AgW43nffFnC7WwxDr9woTwyv8T7lNBtmwpp4YgJCSm9KM0iMPvFgV7MBMI5/6Vx/LPYonn7NFqWjMpiCSTxYoapY1bvRO8DOCpUzFLJQQcJ+c1czoE9+Er3SU/CMC4tBbJ6SJSjPmUcmxdjFbJ/AGxhvUX58QhLaQGr6yUyjx9UX4cv+HIi04BI822u3XR8uwQaOlwx2hEGJqrBt+HE1E3Mhl4PVcVEic/ofMKV/Ynrs0wE6jFWISuqZe9LEcPJUA2v2qBO/7stt7EyChmxpR4UiVd40zl0tnyNcsF5J7hfh9nQUESOjnc8UahW8ZgEp1L7neb6NeJX+RWlKQfHkfQqPGzsZ3uiQSAr5egLZd4PVcqa9r636ReuWhCBEX/2hdi2t+eUlsECELEbJFwR3b0EwLLA9szpk3IWr35pdZAuQftBKZKev7YYIEOsc34jNlDRgxi14UeM17SCtTsvojw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6512007)(38100700002)(26005)(2616005)(82960400001)(8936002)(478600001)(6486002)(5660300002)(4326008)(31696002)(7416002)(2906002)(8676002)(54906003)(316002)(110136005)(66476007)(66556008)(41300700001)(86362001)(66946007)(36756003)(6666004)(53546011)(6506007)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUpHREJDUGdtblgwMWFHVVQzOGY5TmJVcUlQYUNsSHRFamJ4eVdyQXNxN3Yv?=
 =?utf-8?B?WlNBanZNWkUwdHVXZ3E0anBYUlNXbU52Y2orSWhpc29YSWgyb2s4aXc4b3Av?=
 =?utf-8?B?OG5QbmZhMWNEU21SU2pkMm91QmVlYnFVc24zVGtQdHpZZElTOEhkR3pKcEtM?=
 =?utf-8?B?Vkp0WUtRMXd0VmRYOTBSaGRnVGJ4RE9qZFEvNFpXeVdiSmJEZGRrdUJ4bmh5?=
 =?utf-8?B?VmVmcW9EZnp6Sm9uZEF6MVRTcGtyQmgyaUNXbkZyWDUxK1p2MWNzMWlldEsw?=
 =?utf-8?B?Uk9KVmpEaE9HM1ZXVm93UCtXeHVTc1UvdjhJMEx5RWZCMU55N1NyeWdOdlUy?=
 =?utf-8?B?Zytlck9ZbGdnU2VRV0N1UUpZSjFEZWg1OXhzZUN3YkV0MHo0cTFGRFU5SUlH?=
 =?utf-8?B?YlNBVXlTVFdpQ0JrZEZHNlYyakdvUy9lcjBtR3lXUWg2RkZhRU10bTlDTkN1?=
 =?utf-8?B?TDF0ekpLdkhTY29nMlNUWGNPbmEyTjNEV25RNTg2enMvdVRqNmZOVGpwMEd2?=
 =?utf-8?B?THlVSWZDKzhRenR3YVg3RjI2NUN3UDFIcTdZQmFzVDBNZkhjYkgzSkljNUQ2?=
 =?utf-8?B?SFdOd052V3ZoNUNCeiswbklsQU1BaDhpSkxPYkZSZ3h4ZTV6c2paeHArODJ3?=
 =?utf-8?B?Ri9PSGxvMWxFZnRETHVYS1JrZ0xGWEpINExtM0F2TVVuSmtIVUlweUJLSFA5?=
 =?utf-8?B?cmRxczlndTZzVkdSeVpvMHpOSWZNSjZ6VnNNZWxHeHMvN2hDUUVrV0cyRTVK?=
 =?utf-8?B?dmZmdFU0Z1JaNndaMnQwK3FBU1JUS2daeU5kTjVHVWxFeElhUENWT2xLRTVR?=
 =?utf-8?B?UlorZW9qWDJKVms5M1BMQVdXRVl3Q0x4U0ozcUJSSzR3M3lzUzgrTHMyOTZx?=
 =?utf-8?B?Yis4L05nZGR2SC8xdWtMTlhHNUM1NzZjaHFTeFVuM1hsN1ZnZDNvVE5Rald0?=
 =?utf-8?B?TEYyQXpLMXpPMFBaVTA5RnU5Zk8ydUd6bU4rVENMdHdqTkRpMVFoWFVZNG5R?=
 =?utf-8?B?cG4xWHNrcFJLejdmWEtJQWpjRXdTQ1NocFpxZlJ5K0RnWDVDcUw1T0VpZkFq?=
 =?utf-8?B?a0VnNlNMQitjOEllMTh1MjQ0SjRNV29KUkdPZ21KNWJDYURHSE1NUXo1R1Rp?=
 =?utf-8?B?MnY0VDhldkZldGRwLyt6SmR3OWhaNFdiQ01PVFdrQWdXQXgwQk5MRzQxMjlt?=
 =?utf-8?B?Q3U2N0pXRC9ndVVrR1hDdFdwSWpYZ2ljaDFhOVVCWVdQaFFqckZhK2JuSmZz?=
 =?utf-8?B?LzNtczJodGdpeDZxNEthblRYbWtkUGlaWHB5S2twUDM3OWhiYk5UYVgyeWgz?=
 =?utf-8?B?RHVIT2dUbEpvM045eVFkYndSb3kzVlkyVENSSjNNRVJEajdlYWtURXJvdkM1?=
 =?utf-8?B?ZitXdFRjMDY1Wmh3ZTR2ejFYSE5VRGNNMExCamN4Z1FvdFM2Z2xHc3hKZWNS?=
 =?utf-8?B?QkFudFpHaVpCZEsrR1BGeFhrL2MwVGxzTnhld2ZFVXg3aytHcnBSMzBOUzR6?=
 =?utf-8?B?bmlRZk4vNTVrMlRLQm52YWw0ejRKVnhKbEhKYnZhN2hDWnUvYk9pNDZyV0Fr?=
 =?utf-8?B?ak16U2l0QW5kWi9rWHFpa1NEcDRlS0hVd1RHcXpWUlhndk1DUVN1OFp4aVFV?=
 =?utf-8?B?amMwZlpFKzhmMFFYQTE4Vm1wM24xTTd2WlM1a3hlcjNua21BU25ZT1Q1UGg1?=
 =?utf-8?B?NXlqaU0zdm1QdG9PYjl0bldYZ2NvSkNoS3FoWmthMEZvQVdDWnIxL2FQaGJ1?=
 =?utf-8?B?RGRFNy9hS2JYK0wrNHVuN1ZBemlaUEo3bEFDUTNud0JwYnBXZjZnNEVhOU91?=
 =?utf-8?B?MnU2cU5tTHBGdjlSTms2MFo4TDBraFBnVmEyZDBwWTlTbzg2RFNVWG1VNUFN?=
 =?utf-8?B?RXJ3TDdYRUlsWVVPVC9laWJpMkMzVHJPTjdWd3c1N2hIM2dOQkdOSkhVRXln?=
 =?utf-8?B?b1drOU03MncyaC92VDN1Q3ZZdlVBWHlXTWdKYjZjYzhxRzJQdktBY3IrUXdy?=
 =?utf-8?B?T1V1TCtJMkxSVjJBQmJvKzBnTDBjNUxPSnJSdWJvRW03aWUrb0I2UHVOYnQr?=
 =?utf-8?B?OWtjUGlPYTNYR2ExSzVNdXFQb3I4eDZsRytvK2I1KzI1dGYxYjNKZEE3THUy?=
 =?utf-8?B?N2YwcGd3TDZ1TUxtL3FsRTJpVXU4c2E0Wi9rcE9rMVoxV0ZNNTFCekZrZkNL?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a531bb1-2e38-474d-ca29-08dbcc076977
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 16:14:01.2261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKmDVwlUXTn1vSLinVxWWT6EnVlWXsy5SdHtpuPu1fdF1ktYHE3l8Nf0GDCPBLBFDjoQVcKzmcE1qXTFhc81DyXntG3hBdm9DMD+kvkV0cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/10/2023 7:39 PM, Jason Andryuk wrote:
> From: Roger Pau Monne <roger.pau@citrix.com>
>
> The Processor capability bits notify ACPI of the OS capabilities, and
> so ACPI can adjust the return of other Processor methods taking the OS
> capabilities into account.
>
> When Linux is running as a Xen dom0, the hypervisor is the entity
> in charge of processor power management, and hence Xen needs to make
> sure the capabilities reported by _OSC/_PDC match the capabilities of
> the driver in Xen.
>
> Introduce a small helper to sanitize the buffer when running as Xen
> dom0.
>
> When Xen supports HWP, this serves as the equivalent of commit
> a21211672c9a ("ACPI / processor: Request native thermal interrupt
> handling via _OSC") to avoid SMM crashes.  Xen will set bit
> ACPI_PROC_CAP_COLLAB_PROC_PERF (bit 12) in the capability bits and the
> _OSC/_PDC call will apply it.
>
> [ jandryuk: Mention Xen HWP's need.  Support _OSC & _PDC ]
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> ---
> v3:
> Move xen_sanitize_pdc() call to arch_acpi_set_proc_cap_bits() to cover
> _OSC and _PDC.
> drivers/xen/pcpu.c is CONFIG_DOM0 && CONFIG_X86
>
> v2:
> Move local variables in acpi_processor_eval_pdc() to reuse in both conditions.
> ---
>  arch/x86/include/asm/acpi.h           | 13 +++++++++++++
>  arch/x86/include/asm/xen/hypervisor.h |  9 +++++++++
>  drivers/xen/pcpu.c                    | 21 +++++++++++++++++++++
>  3 files changed, 43 insertions(+)
>
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index c8a7fc23f63c..cc8d1669d6e8 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -16,6 +16,9 @@
>  #include <asm/x86_init.h>
>  #include <asm/cpufeature.h>
>  #include <asm/irq_vectors.h>
> +#include <asm/xen/hypervisor.h>
> +
> +#include <xen/xen.h>
>  
>  #ifdef CONFIG_ACPI_APEI
>  # include <asm/pgtable_types.h>
> @@ -127,6 +130,16 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
>  	if (!cpu_has(c, X86_FEATURE_MWAIT) ||
>  	    boot_option_idle_override == IDLE_NOMWAIT)
>  		*cap &= ~(ACPI_PROC_CAP_C_C1_FFH | ACPI_PROC_CAP_C_C2C3_FFH);
> +
> +	if (xen_initial_domain()) {
> +		/*
> +		 * When Linux is running as Xen dom0, the hypervisor is the
> +		 * entity in charge of the processor power management, and so
> +		 * Xen needs to check the OS capabilities reported in the _PDC

I would argue the phrasing here is unfortunate - it's not really _PDC buffer anymore,
it's more processor capabilities buffer [1]. Your phrasing would indicate that this
buffer is somehow _PDC specific.

BTW this file is x86 specific code - are you sure it's appropriate to involve Xen
hypervisor here ? I understand this case if x86 specific, but still.

> +		 * buffer matches what the hypervisor driver supports.
> +		 */
> +		xen_sanitize_pdc(cap);

Same here as in [1], I would call this function xen_sanitize_proc_cap_buffer(),
or something along those lines for better readability and correctness.

> +	}
>  }
>  
>  static inline bool acpi_has_cpu_in_madt(void)
> diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> index 7048dfacc04b..c6c2f174fa30 100644
> --- a/arch/x86/include/asm/xen/hypervisor.h
> +++ b/arch/x86/include/asm/xen/hypervisor.h
> @@ -100,4 +100,13 @@ static inline void leave_lazy(enum xen_lazy_mode mode)
>  
>  enum xen_lazy_mode xen_get_lazy_mode(void);
>  
> +#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
> +void xen_sanitize_pdc(uint32_t *buf);
> +#else
> +static inline void xen_sanitize_pdc(uint32_t *buf)
> +{
> +	BUG();
> +}
> +#endif
> +
>  #endif /* _ASM_X86_XEN_HYPERVISOR_H */
> diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
> index b3e3d1bb37f3..859bb6027105 100644
> --- a/drivers/xen/pcpu.c
> +++ b/drivers/xen/pcpu.c
> @@ -47,6 +47,9 @@
>  #include <asm/xen/hypervisor.h>
>  #include <asm/xen/hypercall.h>
>  
> +#ifdef CONFIG_ACPI
> +#include <acpi/processor.h>
> +#endif
>  
>  /*
>   * @cpu_id: Xen physical cpu logic number
> @@ -400,4 +403,22 @@ bool __init xen_processor_present(uint32_t acpi_id)
>  
>  	return online;
>  }
> +
> +void xen_sanitize_pdc(uint32_t *cap)
> +{
> +	struct xen_platform_op op = {
> +		.cmd			= XENPF_set_processor_pminfo,
> +		.u.set_pminfo.id	= -1,
> +		.u.set_pminfo.type	= XEN_PM_PDC,

It would probably be best to rename this constant as well so it's
not misleading.

> +	};
> +	u32 buf[3] = { ACPI_PDC_REVISION_ID, 1, *cap };
> +	int ret;
> +
> +	set_xen_guest_handle(op.u.set_pminfo.pdc, buf);
> +	ret = HYPERVISOR_platform_op(&op);
> +	if (ret)
> +		pr_info("sanitize of _PDC buffer bits from Xen failed: %d\n",
> +			ret);

Shouldn't an error be pr_err ?

> +	*cap = buf[2];
> +}
>  #endif


Regards,
Michał

