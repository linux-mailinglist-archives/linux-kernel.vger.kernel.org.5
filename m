Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2D7BBE18
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjJFR4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjJFR4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:56:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B86CB6;
        Fri,  6 Oct 2023 10:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696614990; x=1728150990;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WeBifTGuIF5WyY+YPSahX7iwjaMddbDi4hOULjmkIC0=;
  b=mwWO6U5Ugz6Zi5tYHqNNZrlXWkkgEO7YY5XeT4R4kjtXiYQS1LjXPxZ9
   LSf7oJvEmQUxnWu+eRt+6K51roKNmQXCJFkA3dJmSm6s0esiTow6/Hstc
   MjhMSmDcSSyyxu8YFBpUbgwwKD2UYSTfABvBeKT7ecYJ9vfOfpkeu1r0r
   fKYI2duB4weZb25tOaQcah3P/Dg+nTOP8q8KPw+JGAx+NjMvKuHOpG/SO
   faHCg3YCMib2NZr3oKvBKYkgrzG4BZrM+QtK3fvwRXrM5raX0Nlb/jHEe
   7dwNC1M993vBsWOmBmrx82r6UuZwod+GKn9sR4c0KK97dQ5MagnPlD6gD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="450291887"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="450291887"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="745944882"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="745944882"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Oct 2023 10:53:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 10:53:55 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 6 Oct 2023 10:53:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 6 Oct 2023 10:53:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 6 Oct 2023 10:53:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTP/Y9UmjxLMTZkNm5AzRqClAhI/p+GydU0DY6qSNw2W47c+ZoxN+xUPnsQrRPVxgjYitFCLik7yBSOUr4H2WbJ4DfQCGwsw4E6emCP6+RBQtSjLhaq3UsNQ/9j/ukmcjH4vDIwClxsTheWd+Ru3XyqaK9pB7WcZyL289u6yXOmIIBygOCTcFvmTMbjMH3tlAaWSUebuQfX9zaEvPFmYfQX4SIWGnkYlpUH7JIq1cbQraUX3aaEg8tz1PsHP8eUshVEYC3X5RX/jfPr8EcUeHH6iIKw5/BaBlgoIDYt4lXwqmYJ/qvsWgVCfmXvV3QthAAtQ70DmTN4FOQRN6nOejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4Tp+IDedg6v9Ii6tyGECN7WK9Ot106L8N1J4M/pJBc=;
 b=mbhTyLa9CVbjUtr5pn/469h+/vc2gNqnTvn3/yx0cWHNX3vh/e2DZI9L2GsDfVdQxs7i0vZG+H2oyMvV8OIg7sJWjFXuX+ZlZXujQ3gvhy48K2cpkPp0f1rlB2bYAM1+pN2AYWEF09hHPdNsPNroKps0Qi3HS1oC4VHGGe/R9hLEycRkeiLfKxWZB9JYmFrvV+uA7psPvj/4etA9wEOKiJFNvg30i1m8QJQpUG5C4/agjkVOVLf3BCYNohHpqAUmSHV/hICOtDc0b+SnBjh++woL7vTpS2WomyjrrwTi5Si+j6Z+2ruxnb1QSVy04duq1f0eCqyBZ/o10Q5n8k+pEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB8116.namprd11.prod.outlook.com (2603:10b6:8:12b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 17:53:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 17:53:53 +0000
Message-ID: <533ccc1b-7566-444e-8549-184fd272f666@intel.com>
Date:   Fri, 6 Oct 2023 10:53:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] x86/resctrl: Non-contiguous bitmasks in Intel CAT
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        <fenghua.yu@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>, <dave.hansen@linux.intel.com>, <corbet@lwn.net>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <ilpo.jarvinen@linux.intel.com>
References: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <cover.1696493034.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:303:dc::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e6a47c3-1f5e-4a04-daf1-08dbc6953434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9OoyUKfj+WD34IM/dSDrvftCEazrx19OrpT0NN9TtzRZ/VhMf/f28VPiMPDTrR1lyjl8pqyNMc2BShq/JVxQeu8Fg1O8jNFo7AgCh4cf2rcLFWkmyptpOr/mcyNYAAzhFBQDM3pbtOMJUeQ3MSOlo3gAGoOftFVMRHODkQCqqzY/wzOeHmZxN3havCDFAbjRjGCn8VtaUsq1ePjnIRn+U8okndJMdVutqnn9AK4hqeHShv924HTvsitSHTqCcFjOmqvZbpuLxrEyaZqkZ+eZoRyZuba48IGgQDtcAN4N45i1i1+hrAT5NZOLkxfmZABsOhBpu2Ru9T8NpOzik1zsuLkQrIwRdx9K0b9pPDtjEBjXq9mwJroBJj9+4llYZk4cgttZPSld3L4aNkyKw9OT5LCxotNJnZt+7Bqt5XSz+65cxCU3Iw2Ak0iFkAWXK+cv0gKMANkB7UQrfdyUBrnvHYjqeRB1sdtp2sBfjvw5XBAAkHzWnWRBWsWb9Y8J4yJl9SthjfXw+nXdi7MvEPvjmc5O99l/pgrgGTMD+y88DsG1p+yVTDwOGYvk+W51ULA03dUtYX1d+vZEeAKThjaU7mo6f8QjeUeYoHUDllr8oHZzfts1SlW5+c5eLyN2KMuBPr2fX7YLXd2+iSynJhx+aOKeDiEzhWUt5c/4ifBTkq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(7416002)(44832011)(5660300002)(8676002)(2906002)(4326008)(8936002)(41300700001)(2616005)(66556008)(316002)(66476007)(66946007)(26005)(36756003)(6506007)(53546011)(6512007)(82960400001)(83380400001)(6486002)(966005)(86362001)(38100700002)(478600001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vmlyb1ltK2pxcHRkVFRYdERrVmp2U0hER1Fob0x0S21XSnM5RllQWDA2V0lr?=
 =?utf-8?B?TDhrcUUzenFlT1p5cW5ad1kwVGlQd2ZtYW1DbitaL0ZhZkNDTVFWSjByT3Bx?=
 =?utf-8?B?QWZWN2pOcTNXVkl6RlNIVGZPWlRERG41a2J1TnA2RGswbG1XVjl2K0RmM3VF?=
 =?utf-8?B?S3I3MGpEZUI3UXozd0hHOTlETFI2UDZUOWVxRXBBUHc4MGpVZWJVb29nWis0?=
 =?utf-8?B?b05FRzgxdG5ScVV0NjJXOWJKV0svellCNVM3REJCdFJTeUVBRG9VaHhGbHJX?=
 =?utf-8?B?TGxqcjE1R25ZN2xpVFNOc3pKZklXQ2E3WHBsTUE4aFl5NXM5c253clhlNU5r?=
 =?utf-8?B?ZDJVUHFCNS9FUEJTT0VMTkdVQ2hYZ1VvTXN1SXZjeks3TlE1dG1MTEJoeTJC?=
 =?utf-8?B?OTFZTXljMkIrV3JwT0RQM3dsN2hmMk1MRzlRWi95SEJyT1RkREJ2TkY4dEJj?=
 =?utf-8?B?K3Z5ejhtdHY3ZjVybHYzc2owUG9uTHhTZHNVb0QvQlA2a2xBY3o3MUorL2xj?=
 =?utf-8?B?ZEIrN2tBSU9IZGhoK1FNcy9tWXEyb1EzUGNNTDhQdFVFQWI1amxzTmRieTJo?=
 =?utf-8?B?UlRWdURFOHRoQnMvY1lhY0NyTmNMb3AzYlJMNnNaZDN2b0tLSVhtclM2cFBu?=
 =?utf-8?B?M3A5L3d5dTIzdDFIN081RWhtbWsyV2orS0lXWGRMWWIwVHhZbzBOT2NHWm1T?=
 =?utf-8?B?bDlJVFNocVJ0UFlxMTV3VU1jL0pVOGNyOHljN1JPdlJkU0xzTzJqZGt5djY3?=
 =?utf-8?B?aW5DbG4xc1lBTlJoblIyRlQwektVNDJPSEFMcjZWb3ZiRkV6anJHaldOZTZJ?=
 =?utf-8?B?RlVLZXhnYU4xekI5UVUyRWlpSG5WMDVuSm51VHd0YncraVBXQ0NUc3lqR3dS?=
 =?utf-8?B?aTd2a0xmbGd2VW1FQmM0eVZHMzJ5ZnhOZGE3cW40ZFF1UWQ0YkRwOFAvVUxa?=
 =?utf-8?B?T2gvSW1hZEJXcWdMZ2hmK2hGSTdMMWc4WTVyRnBJSXhPM0ljZHducWh6elFU?=
 =?utf-8?B?eW1DT0RnNlZtRE10bGZ2Q1l1NXhWdGdmWXM5aHZkMWR3L0ZqN0lKTzJoWGNB?=
 =?utf-8?B?bzhpc1ZBQ3V0VjRCeXBiNURmMGUvNXR6dmdVNGtuSUhEcHlkRS9HazFMVUt1?=
 =?utf-8?B?cHVWaWRTbU9wKzFvWjV0UVF6L0VSbndxVWcrTWl0Wnl2MWtZaEZHM1JrZGl2?=
 =?utf-8?B?TzJtVGQvSWhLdE9UejM0MmVwdHBpRnVYei8vVThnVDc1V2hwL2ZLaG1jbE9h?=
 =?utf-8?B?NGhKVzJLeUVSSEdjdjZ0eFFyZU4xSVRNTUkya2RSbysvR3pPMzh6ZVAvaysw?=
 =?utf-8?B?RlhWZytoaUFRMFNIUm50MlJDTDg0U2h4Z1dqenQ3Y2RpZndTUXl0Z3RnY3ls?=
 =?utf-8?B?ZFk2VlRLb05kMmd1NVkwYjVScjZNaWxSVEdUK0JLMmNLeDJQL2k1YmRmSHU5?=
 =?utf-8?B?STZ1UTNCUW9GWlQwTS83ekhtZ0F6dE5uZTBsYXN4VWJOV1QyMkhUR20wZXUv?=
 =?utf-8?B?TkZhKzFXY1RaR2xSelhMTitUQXFRL0lpeHlOTEtUWWtaNW0rUk02V3JOeGVK?=
 =?utf-8?B?OEIrd2wvdWZyTjgxWDRrRE5FdWZkNHRaSlk1SW80endIZVVDTzFYcjBBOFpO?=
 =?utf-8?B?ZUNPcHpRdlA2UXJVcnc4dVM2R1FpdGc5NmpJb0JCa1VRQUVTT2lSZjE4aHlm?=
 =?utf-8?B?V2ZzVGJ2cHUySFpDMGhEZmRUdDhwbnNJMG82bE1PNmNJbFB0Q211b3U2bGtB?=
 =?utf-8?B?RW5DM1hEUWtuVVpCRGIwZ25GL1pTdjIvUDEvYnZCL1NiQXB3bVcxSW1TZDVt?=
 =?utf-8?B?dS9uREdCa2thd0t3YTNKell0MWdibUlnOHFTUmhjNzhteHN0cjdYOVFvSm0r?=
 =?utf-8?B?QlRXdEpEVVE3bHlyZjZCS0xSUFE4b0pGQlN5V3lUaWVuTUttSno1aFZoOVdG?=
 =?utf-8?B?UW9OcGZYR0t2bnUvdkZ2LzcwMk1iMHRBK3VVNWlxWXQrVWNFbHp4L2V2c3hi?=
 =?utf-8?B?S0MxMzFtOEhWY2Zkd1o3aFFieUI2d0k5VUhoQkovTW5VQ2ROUEJFckJWL0RE?=
 =?utf-8?B?Rm81K1gwRDEvSmlhWGFzY0s2cFYzWnZQTWpSblljZHNzQ0xaTFRIdC9LRWJ0?=
 =?utf-8?B?TlZSaGFzaWJWdWZwK0tEMTNuS0NhRDFGTXhkYm5MTnd3ZmNqeXgvcDg0Tmo3?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6a47c3-1f5e-4a04-daf1-08dbc6953434
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 17:53:53.2837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gOnZ1ldYxePGO88P7UUMI27GU1waUkaSJq5iu4UtC0rzYhacR3VPk99+6WJt89FgyX8J3WB/noCewR/ZH6Xqf1J+IFDlA/dzu9vItyJ4Hqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8116
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On 10/5/2023 1:14 AM, Maciej Wieczor-Retman wrote:
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
> Since the selftests/resctrl files are going through many rewrites and
> cleanups the appropriate selftest is still a work in progress. For
> basic selftesting capabilities use the bash script attached below this
> paragraph. It checks whether various bitmasks written into resctrl FS
> generate output consistent with reported feature support.

This work conflicts with Babu's series [1] that is also ready for inclusion.
We could wait for outcome of next level review to determine who will need
to rebase. It may help to provide a snippet of the conflict resolution
in anticipation of Babu's series being merged first (I will propose exactly
the same to Babu for the scenario of this work merged first).

Reinette

[1] https://lore.kernel.org/lkml/20231003235430.1231238-1-babu.moger@amd.com/
