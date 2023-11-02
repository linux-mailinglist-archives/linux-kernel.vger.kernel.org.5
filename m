Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597C57DEE2C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 09:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345313AbjKBI3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 04:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKBI3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 04:29:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E65C112;
        Thu,  2 Nov 2023 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698913769; x=1730449769;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RKRiC1SDEw+qFE4F0mUht9c7G2+g+v6331lkQDabKl8=;
  b=XStE+yh9wMLwJGH8HvNWuRY87wPTFVHwQSrH2CB3iOJqQQczHwniChvo
   5DU5KAaNn0qUqIjgXkQin4PkRyU5b4XIMzVjAk6/t6pzLG4vNhOH5n/EZ
   ZPhVqZJew6gTrT6XPawdgL2oIF51PG+ayhKyUhJMr06fMk2MOpSyo0coj
   rPYHvMZ0RNzU2yAYOVL0tQWRTpqAeOctjenUoBRy8oXmsKmWAiO0BUpRN
   SoU2mLrXGVDhC9DfzgvD2DVEsy8ghxhIYRhEp63a3upg7skPH1RvONAJ/
   7Qqud1xZYoW3GqJtIi7zbfEENoY1Yp8bSeZBuocnV6TTLkykSLrlvhR4N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="385838065"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="385838065"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 01:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; 
   d="scan'208";a="2363692"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 01:29:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 01:29:27 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 01:29:27 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 01:29:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CL91qwDzL7NhkWn0cbwcs5kbEr1XiNKlZuVtOmCv0IogzdZnGLo2gOSjERomLEwDFBKjdZkEYpPQW95SjBF/GxNOYBuChwP1s7221bLt79HxzEHmvVFZT3YcLQW4nEpsAjsVAbuY0DP8FU/hjVdNhaWdW9ZDg/MFY3dlOsgwBEbOV5SFwMneRzM/bpEawmc4hKouuLqw3m4C1a+uq2vyZNduu4q/oMDzCAsI/zADicKwk5LAtGU2Inu3gHv+RKx2Kw40yW+RXHdGAykMyogwkolsb9WZJBumCFUXk5Mj5tUm5MhbX0U/46xIHuW1T6rTzrV8hjCpoWrIJZ96i7HdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHz1QXBxa687LD+2FRrfdMRcg1twlRXobrUtJt0z2C4=;
 b=N5AGTnUez11WBGyK6BRGR/4IsGNG79o1c2K/KPT0712eIvyjySE6ErDlKMBJwH60+zmrEaCkUIuKSbdy/wMzfZ8opl+Jzj/8h0xdVrov7u8gNyzjZnDvw/GAJ6gk5Qfau2HykiCIoawMeEGLfxkQl15TFCL4eIQKZS3rBJzyeBzN1twUc/ArMGG/ZVpNs3s8swbOMk+7IAcHXp6KUzz/G2XpiIQYonuCjNSifcWPQ4tcNOb3xYk/F0WHij6DmZfdDWeRTBKTbIPUAise5ya5go2Q8e1XmdohX4C0Mo5RYHzoJAmNJP+FvZoWRRxrKhY98DjZABLDZbElxmsMzhcvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by MW3PR11MB4747.namprd11.prod.outlook.com (2603:10b6:303:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 08:29:23 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::e1c3:7b76:eaa7:c1d9]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::e1c3:7b76:eaa7:c1d9%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 08:29:22 +0000
Message-ID: <9b4f03fe-758a-43b0-92c7-7c72541013c2@intel.com>
Date:   Thu, 2 Nov 2023 09:29:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] acpi/processor: sanitize _OSC/_PDC capabilities for
 Xen dom0
To:     Jason Andryuk <jandryuk@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
CC:     Roger Pau Monne <roger.pau@citrix.com>, <stable@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>
References: <20231101134154.18336-1-jandryuk@gmail.com>
Content-Language: en-US
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <20231101134154.18336-1-jandryuk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0009.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::21) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|MW3PR11MB4747:EE_
X-MS-Office365-Filtering-Correlation-Id: ca54a316-efe4-45f4-b44e-08dbdb7dd0e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HL1dGMntoBbjGJQrqRzuv6MWSFJ0JTjJu0766wvyeDikx6ZwAo1bUDNcIKPKznBY7iy5EKrlHex1b9Jt7WWg1hDerNsDEIIjgsGlsLjgoIHLnF3BPH8KDRV7aMkOEtMLq+0M6RqnBqyXaXlmp9apryl+7BXTFjq8skYJNarz2Nm1nSpx1pW/N1BxIfAVVzqv6u28pVra1Eige6h7l8IPad+GTistkAoEnbhsC0dalyjJY36CS0nxPJE75xiMxUUGm449BzrGclWod/OKwzs6Mkjsvu4NbxBSLBb6NMuxwlJwHwdTOm0gMdwp/g30PYD7mILP9CeN7F2HxV/MCuYR6ECEgHgP/BAqoLsBXns2+qjEdYr/ys2ILO2MM+7Kduxy7SPzNO5qqf9J28xq54gun5zR4ttyvXnRentPo5M6/KRQDH1Ro/MVHVq60HBdaiHdKBq7GRCV8Nw3Nh5FeyqmTsIRzeqYt8evUKIVAesDOOCtLUm3Fw698ZSBlesoSmFAHBKqczO4ecLca2CyLPYaFKQ5LcsveVEUmiobumgxFzkHkrzlXC0C5KSZLu3+EYO+48dEArjFopy/tMyo9IYhx9mbUYZeWgAeYu0Gf/oVVP+wInfvO1Cz1uwiB7gr5EF/U0aDTjaq2Z8azuEPozoLzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(6512007)(2616005)(26005)(38100700002)(31696002)(36756003)(86362001)(82960400001)(2906002)(7416002)(6506007)(53546011)(83380400001)(5660300002)(6666004)(8676002)(4326008)(8936002)(6486002)(66556008)(66476007)(66946007)(316002)(41300700001)(110136005)(478600001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFZrYkxnM00rb3BmdjRRYTYrZC9xN0pBMS9UNDZYUmc4b1lCZ3FCaUhDS242?=
 =?utf-8?B?V3lzMGNBWC9nTFVnQXNtRTNKSk94Y1IrbmpydFJBaUxQbmhjc2RJekdDSVNX?=
 =?utf-8?B?VTlWRzJMaDN6ZkNQMmtVR1plUVdBb3R6WUxRSnF6b2hQNW1USnB0WU1wMFR5?=
 =?utf-8?B?TS9yNXZSeHFZMWQ4Z2cyWGdLcUlDRTdobHJFcEMzZGxzcFNUNklRZHAwNUl4?=
 =?utf-8?B?UlR4WkZZMDlYRXJLVnhFeGUrdHY1dUVXb3NUdEl6SXMyeURzRE5EQkxXSVJO?=
 =?utf-8?B?ZTlSeGlCSmF1Mk02NFBtY2loTTB5Qm9wZTliQWFMMjlHSkFYdk4xaHNFckc5?=
 =?utf-8?B?WEN6UytOaUFvaGE4Q0xhZjJaTFVyNEhGR0NHUVZTTkRtMG8xYkl0SnUrMXlj?=
 =?utf-8?B?R2cvS3JGNmxYNzRLUFJjZVNJVjRNRURKUUNPK0dRNWhORGw5R0U5Mk4yWXpW?=
 =?utf-8?B?Y0tjVVVEdUhqQzNFUkhEd0RPUkV0bittdlJXNnduaGExdE1FNFl4NEJWRDVw?=
 =?utf-8?B?N1hiN3lQaUZMRC9PUzBGOFU5UDZRaGNvMXg2OVh4L0ZzU3RrbW1iK3dWeDhM?=
 =?utf-8?B?U1VJa2ZvVkZsY3hNOURPczZWSk80d08rb3ZoWWdmZDVlSlpLWFdiV2N0R2Yz?=
 =?utf-8?B?aDJETW4wL0NnMmhRUlFDVTZzeWphSE9Hd3FIeTViOW9YaDR2L1RkYkJHUE5Q?=
 =?utf-8?B?c2h3bXJIenhxaTBmd3A2TWR3U01NcXIwM0E0MWJUWThJZnNqZ1BjUStmUE5G?=
 =?utf-8?B?aFNzNWdLNzRsSEU3Z1padExIMkwwVm9SZzMxRlhLN0VCVG9yNWtodjh2T3Jv?=
 =?utf-8?B?SDdkSnZaZm1xMzNaZmJ5VnlFVDN0RVJjVVl5TTUyb0I5Y05rMjZ4RG5Id3px?=
 =?utf-8?B?cTRnTGNIbzFoenVrbVZ6MFZ0ZU5lYm1sMEJoaE45bmRvMW15YVVKVHllT2wx?=
 =?utf-8?B?RWQzeHJ6WjJ0MzFrYmpLZWpUZ09iclhZczZiWldFY0VSMWU3Rm5IMHR2MFVB?=
 =?utf-8?B?cFR4VFBHWXdBU1hsNW5BeGVQUG5wd2JtZ3J2ZFJmSzlvdm9WWkJDQ2IvM08z?=
 =?utf-8?B?RTJ1c1c1MkZTOXk2OHNFOFdjaTlPODVzWkplYjBKMWdDZ2R3dy9qKzBvWmps?=
 =?utf-8?B?MUVURlhwMDRBV2JsOHF0NktMT2xUeXhXMkVuaTdxRVY5QkhtSU9OMGVERENE?=
 =?utf-8?B?R090YkR5ZFQ4dlF6MmF3b2QvdmthOTlkRjhWNVl2N2cwTk5jd3daQ2RuV2gv?=
 =?utf-8?B?OWVqdHZKNnI1T0drNzF6d2Rvd29JZERJdTJxZFlJK3o2cUxNbzRxenhNeVhu?=
 =?utf-8?B?ZzdEWEtacnhMenRsdlhqV3F6endrTGJpRjF2V2RSTjNJdkJLV2duRWZseW1O?=
 =?utf-8?B?clBKa0NVTlNmemhlNHBWZzRmMm9RMFpOMWZ2NVQzQmhQcGpTMFlqTjRzbEFN?=
 =?utf-8?B?cGpNN2RrMjIzemRHVkxRZ1piYmFWOTNGTENaZnlUVXFQR3lyUWRQQjlhQ3lK?=
 =?utf-8?B?UytrRWNsYi9OYUpTbGZVWTZtODhWMHhPWlRtekpaeUZReWdWUnNJdGEzeVIw?=
 =?utf-8?B?T1JFN3ZTNERVWWxKRFBXS3dvL204VEh0Zm0vRXQvOU1hZ3FXditqUFVJMFkz?=
 =?utf-8?B?L3JaeXhTZy84aXJhYVZoQmdhWWVLdGNUN0FHaEFRNUowU0w3WWJKS3pQUGFQ?=
 =?utf-8?B?dTVaZzVIeTlqZ1Vidnl2NEx3MU5UeUVXc0t4Sit4cW95NFBhU2traFVaNHRV?=
 =?utf-8?B?QlFkdUs0SG9sWURJeE1GSlFkVVZFaEVqeDM0cDBvN3dBRWRFaXVmWmVpcytr?=
 =?utf-8?B?Q2JUM3FCMnZrWnZPRG5pRnJkU2JSMFBLemRhdkt2QU1mNjBNNUVPQ212N3hv?=
 =?utf-8?B?MnZWMlNsRTRPRkE0bHliaEJVcUJ6Wnc2ZFZRUlFHVHB3UkduOHoxbmJQSGN2?=
 =?utf-8?B?aENqNVBoaDBIZVZ6cFYxUTVoNDd4YVhDZFc1WDBDV1B3TWwvNC9DL0ZUU29C?=
 =?utf-8?B?R1hManVXMXQ2M0VTQkNFUHhJWnRxVDdTeTJjRWFiVUxSN1pMb2lIRC9Dd3Fs?=
 =?utf-8?B?QklQSnh0bFNaN2J3L3NMbVZoQ3kxejRLQVBQN0NvTTFYelF4MmhoT3ZjbExu?=
 =?utf-8?B?M00xSFZqTWNVMkg0ZXZNN1lDeDF5eks3Q1RYOWQ1M203b3JVaGNhK2tzZ0Mr?=
 =?utf-8?B?S0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca54a316-efe4-45f4-b44e-08dbdb7dd0e2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 08:29:22.9055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4PfvH+wUYmFT4M7aQriLqq1oPzVSu9qxIYGfxCzS3uwcGT7IpH3ZhkHPG35ST1uVFRrtgCO/32UM8TaweYb5NjQnR2DpmAAJlxVYbPX/N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4747
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2023 2:41 PM, Jason Andryuk wrote:
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
> v4:
> Use xen_santize_proc_cap_bits() name - Michal
> Rephrase comment - Michal
>
> v3:
> Move xen_sanitize_pdc() call to arch_acpi_set_proc_cap_bits() to cover
> _OSC and _PDC.
> drivers/xen/pcpu.c is CONFIG_DOM0 && CONFIG_X86
>
> v2:
> Move local variables in acpi_processor_eval_pdc() to reuse in both conditions.
> ---
>  arch/x86/include/asm/acpi.h           | 14 ++++++++++++++
>  arch/x86/include/asm/xen/hypervisor.h |  9 +++++++++
>  drivers/xen/pcpu.c                    | 21 +++++++++++++++++++++
>  3 files changed, 44 insertions(+)
>
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index c8a7fc23f63c..f896eed4516c 100644
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
> @@ -127,6 +130,17 @@ static inline void arch_acpi_set_proc_cap_bits(u32 *cap)
>  	if (!cpu_has(c, X86_FEATURE_MWAIT) ||
>  	    boot_option_idle_override == IDLE_NOMWAIT)
>  		*cap &= ~(ACPI_PROC_CAP_C_C1_FFH | ACPI_PROC_CAP_C_C2C3_FFH);
> +
> +	if (xen_initial_domain()) {
> +		/*
> +		 * When Linux is running as Xen dom0, the hypervisor is the
> +		 * entity in charge of the processor power management, and so
> +		 * Xen needs to check the OS capabilities reported in the
> +		 * processor capabilities buffer matches what the hypervisor
> +		 * driver supports.
> +		 */
> +		xen_sanitize_proc_cap_bits(cap);
> +	}
>  }
>  
>  static inline bool acpi_has_cpu_in_madt(void)
> diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> index 7048dfacc04b..a9088250770f 100644
> --- a/arch/x86/include/asm/xen/hypervisor.h
> +++ b/arch/x86/include/asm/xen/hypervisor.h
> @@ -100,4 +100,13 @@ static inline void leave_lazy(enum xen_lazy_mode mode)
>  
>  enum xen_lazy_mode xen_get_lazy_mode(void);
>  
> +#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
> +void xen_sanitize_proc_cap_bits(uint32_t *buf);
> +#else
> +static inline void xen_sanitize_proc_cap_bits(uint32_t *buf)
> +{
> +	BUG();
> +}
> +#endif
> +
>  #endif /* _ASM_X86_XEN_HYPERVISOR_H */
> diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
> index b3e3d1bb37f3..7000701dff8f 100644
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
> +void xen_sanitize_proc_cap_bits(uint32_t *cap)
> +{
> +	struct xen_platform_op op = {
> +		.cmd			= XENPF_set_processor_pminfo,
> +		.u.set_pminfo.id	= -1,
> +		.u.set_pminfo.type	= XEN_PM_PDC,
> +	};
> +	u32 buf[3] = { ACPI_PDC_REVISION_ID, 1, *cap };
> +	int ret;
> +
> +	set_xen_guest_handle(op.u.set_pminfo.pdc, buf);
> +	ret = HYPERVISOR_platform_op(&op);
> +	if (ret)
> +		pr_err("sanitize of _PDC buffer bits from Xen failed: %d\n",
> +		       ret);
> +	*cap = buf[2];
> +}
>  #endif

Looks good to me.
For what it's worth -
Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>


