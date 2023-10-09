Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F67F7BE867
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376760AbjJIRkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjJIRkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:40:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C016494;
        Mon,  9 Oct 2023 10:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696873239; x=1728409239;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OfiQcEMB+kL2MpwLD+4G4i+U4WLf5QoPDH49jPnpSuI=;
  b=YstqUnDR1gQd6+gzK8j2BYfrQi+T35XkIo5f4LehTZE7gJlUV9Q2TQ2R
   uZmHMVSTjz7fXNZbEnDv21j837na/FGzTJKic2BJm5HtM/G2zSJYUqCtP
   xNWzyRKIsxK2MN1IFDVQPeUETA7EDj8Ia1oMcuJSeqxUcZBCBS+9mjzf6
   JHA6mcxFYWSg+RKGdWkGlqSfUWL2Oyz3xdoror5F+kVzdxUNYOOkHOJVw
   euSse3f018wDmV/t5lU9tLfYpARI6+JAZwXd0h4CdyCmlhEHNaxfKfR7a
   InUQgUtrShvp+/2yBRBKkn7pb2xRmy/FBpEgTn5kIbJnyFywNAoTgtuat
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="388074019"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="388074019"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 10:40:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="702998746"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="702998746"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 10:40:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 10:40:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 10:40:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 10:40:37 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 10:40:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WI5cq1e0v3csMTN5YSklvnYL5P7zggMYAFIdLFOUbuyufsI1VQr24nnm3AgbPZY1FLCivri93NsUUnSbLYGcoW4jROC1MRxzVzJm/y6IIOWwC3px4/vFfIes4b6SyfkSfI+YTL+POv25vehqdSHyJvj1ZCe+BHSwBiwlx6VcLvh3EYOpmhaNJr8D5Kvha2+tWBE1JpAVZBP7aMYXlex1GwjC3koMuOI/ZnYp8nD2VUNlLB8X9NFKxy/sB5fUDYvS9vhI6SRKQ7fYHFTwPxmbyQrxkIve1O8Hl1hFcvcq3WgQh4OjIpDOVzTt7701HHcG4+/Gj7vQ4t/Nuq12AlgKog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgTCtmG1FOgedLtEwLMbUQg0f4CflgDIbpV0ybv3vtw=;
 b=lXSLV4JI1lUKOD2Un25cJ716zmxpfOyQ+OAaXgksjyfW9asaG8Bc04TKXne45Wiy6RWB0RyneInVPJGj4tx74PBskpFrA6bGl67o0HumFy5IoydrfAhaeJMwl0g6R3LjLsruYczXWmh8Uw3axCgLzg5K+xRD0a3dp8x+8EVuBD1TShJ4GxegFT3T7/ojDN7k6AjhPfuLJVIPwtERFfmImIv2OPx55+OH0xVTL3tHXTHdV/pj7+EcWofPzsA4VLkvK7kS3UzL7qogA4iMNSoPbDUWG6f+aUUTlt1P5ItEIxpGwiH9NKLCOpk7QX/04M0RdRz6LSpQFI6lPXi4j8f/hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 17:40:33 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::5fbf:2030:88a6:14fa]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::5fbf:2030:88a6:14fa%5]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 17:40:33 +0000
Message-ID: <f9bd5402-0377-6d75-5782-8bef29759c90@intel.com>
Date:   Mon, 9 Oct 2023 10:40:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v11 05/10] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Babu Moger <babu.moger@amd.com>
CC:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <paulmck@kernel.org>, <akpm@linux-foundation.org>,
        <quic_neeraju@quicinc.com>, <rdunlap@infradead.org>,
        <damien.lemoal@opensource.wdc.com>, <songmuchun@bytedance.com>,
        <peterz@infradead.org>, <jpoimboe@kernel.org>,
        <pbonzini@redhat.com>, <chang.seok.bae@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jmattson@google.com>,
        <daniel.sneddon@linux.intel.com>, <sandipan.das@amd.com>,
        <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bagasdotme@gmail.com>, <eranian@google.com>,
        <christophe.leroy@csgroup.eu>, <jarkko@kernel.org>,
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>,
        <peternewman@google.com>
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-6-babu.moger@amd.com>
 <20231009172517.GRZSQ3fT05LGgpcW35@fat_crate.local>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20231009172517.GRZSQ3fT05LGgpcW35@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::39) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CY8PR11MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 1852f688-e7ae-4c47-d202-08dbc8eed63a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UL4AR50jKwuH5tirKYsjihciN0bd8XswL5IIgvRIBKf0f5N4d3f1nj/SblmdncaP3zPG850Q2Is4d2p7Eg4R2l8HwAvR/AKo2zZu/21DhxAKeAOyL/vkg1FwXN9Eukwd8fpHh9d+/MCStgm9H1q8S2z1Lztdxdj71BAWAUM+yGXZBhOss+RJYf161ozwLA5h+0Bg6qf5rh0q9bSJiMoyzcPEPBvl3pLCMR2bfrfEZ6kJABrnt5V1MnHaZT/UdfMNC2ZNlDCxUa+J1hC93pPUbKzt0x1A693tj8CqjA6J4eOM882yf8U8xvtnuLPt8OiNrrH/LRk9je/+O7rLktsaSlgwib5fuJ9UmbqZ2Z9Nm6nUB4ApUeolMyF7JVmA2i5xctRh8FyTCStHYuTQKrHg/aYVKD1ScPLJ/Plv9M2voF3Bn2aPmfURHGdm9CAcVb6oWQjInPqoW5RViDVqLRS3UqV7xOg2BwqxAZMSmhTIxKZQwfFFzGJ+8YE8mdHi5/BI3A3QtDv1yVLQnJgdMPbCflS88dGhZuK3bRLj9eoARQfKTFkZ8KPCcDIn8ukGN9tPutPUm+z2EtCWfFYnnrCDi9n+KnsUbEHGYQ2meOVoQHgUGWfWN8xnsQZf8C13WDuJILhSL2vz3i5RX2S1ekQcIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66946007)(83380400001)(2616005)(26005)(66556008)(66476007)(316002)(110136005)(7416002)(7406005)(6486002)(6506007)(4326008)(41300700001)(44832011)(53546011)(5660300002)(478600001)(6512007)(2906002)(8676002)(8936002)(36756003)(38100700002)(82960400001)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1pjT2NLVm5acDk2dGFjbW4zWUJrWlA5MEhLeldodkc3Y0VWS2ZibG5FUndD?=
 =?utf-8?B?UUhVV2x4NEd4TG9ETFhGb2pudWJzckhpMTBzZDczYUtNNnRXemxQYmRHNUlk?=
 =?utf-8?B?cE4xN2swZU8xZ0VaZG1MSmc1OFV5UkdBTVJOdGhBdWR1Yi9PclUwOXhjM3g4?=
 =?utf-8?B?SFVjZUthQUlFSUs3ZSt1UkZkVUhxSDNUS3RtT0I2OFhybGRHRlowTjVlTnZm?=
 =?utf-8?B?YXgzLzVkemRSbFI1bVNHV2tWVlVLR05qT1JyM0EwbnRBMVNPUXE0QUxXcmVE?=
 =?utf-8?B?QkZoZmNNYlVVZEU2czhZOGx4RlF0UGprUFduRC9xVXBFR2lNVnpCbVdJM2Vq?=
 =?utf-8?B?VHNqYkR6N3QyKzhML1JtVVlSZksvbVlkaVRkeVgwWW95Y3pYZi9zQURMTEEz?=
 =?utf-8?B?bmFmVXZ2RWJpcERFbTFZSU9tUDhFRlhzY09DOSswN3llVGJxR1J1dXpURXRD?=
 =?utf-8?B?bWh3endnVHdqTno0b3Z0Mno2K1E4T0pHNjhzbXBQM2tLbWc2STEyOG5BTkVu?=
 =?utf-8?B?MnNkVDFTMWdrZFNobHE0M1ZNaUZxVmx4TEt1eGdaTmxxa2tvYnRsSkVGR0VV?=
 =?utf-8?B?U1RYcUNQNVp3elVvUGZEL1hjTW1nUWZCMFhObTdkZytrY1FsaWlRUVo3V0JZ?=
 =?utf-8?B?YUJ6dGtjZjBOYkNjZXZ6SHlEQ1JsdDg5QS9mdWZlaEZaTi9UZ0xYZC9IM0gw?=
 =?utf-8?B?d3pLRGp5VG1UZW15UmNvY3FwSGF0RHh5SjhNSmlJZW82WVFQa3ppbm5idXM3?=
 =?utf-8?B?RU42SFZyeWZWRThzbXZVY0tvbk9YZkwvbmIyRG9maGV1NUI3YlVLOENTcGtK?=
 =?utf-8?B?Q3huREdvdEtsL3hNckl5RDlhaU1ObENZUkplb245Z2kva0MzNWVGZThqVUxp?=
 =?utf-8?B?WmR3ZzZGTmdmU2xqdUFFbGVVekJSVEw1WVdmZ3NubERZWFd6QXhpVFF6Mm9h?=
 =?utf-8?B?VlZnQlNmK0dCNUNVQUJjbWhJRXN1U2Ztck14NmtiWEticHhYdGJFdFdMRXg4?=
 =?utf-8?B?VHltNU13aEVuVzRoaFlHWWk0TFZNbmhlTkNuWFE3NlRxQ1ArNlNFeFY0aUdQ?=
 =?utf-8?B?bUlKQ0ZPdGVMVzI4aU4rZnNlVFdvSHQxdm9VM0pseHo0eDJGekxBSDFhTnYy?=
 =?utf-8?B?OS9PMnF4N1FleDV1T0FaZHZUcVRTeU15dGpPalYrMnVEUmN4elIwWXRleFFE?=
 =?utf-8?B?MlZwN1d3RWo1M0FvUWdNVjhiSzFDcHkxem16SzRGbnpPdHBhV3EwMlVOR1Fo?=
 =?utf-8?B?aXFiYldPcTJmZ0hYcm1GQ1hLbENiSytjc0YzT01QZ3BQVnA3SWxkUnQydFBy?=
 =?utf-8?B?U29mV2xiR1MrZ2F4elNvdDkvQTlhMFJmYW5NUFV6eTFpTUVIbUVwM1VTU0dR?=
 =?utf-8?B?Q1kxbTRtd3JiQ1RHdi9NV3FRZHBhUERZRzZTeXExeWtYd2lBODZTaHFEdDZi?=
 =?utf-8?B?eTZFWEppYVFtWC81U2duQ0M4NU1ORUUzRVAwcDBzbEJMcklsZzY1dUcvTkR2?=
 =?utf-8?B?eUl4cDRlWDZwSVRySE8xbndHNHIzUjZqL0xaMmJjUHdUOGJNSGxzZmM2dnRX?=
 =?utf-8?B?UlRZMm1DbDl4NG1jTml1Y0RoYmdXMm5ScWJ0OVk5NFQ1bkJwT0FMZ04zcXIw?=
 =?utf-8?B?SGJvbXQ1Q1c5MHdsczhiVHNMWlJpVHBHU1RPYUZ4V1NwdGpwVDh5UEJ6MlRk?=
 =?utf-8?B?ZkxSVElQQnFyNmREWksweTE0TzZTZ1lBeVJPNFhEcXN6WjRxUnNqY0U5bmJS?=
 =?utf-8?B?dW1YMnZuRUUwUXgybUJWejZYTmZ5UmNKc3ZodVd5cE5kUy9zSm0yNVRJTzZD?=
 =?utf-8?B?REQzdkl5aGQ4QmtPVFlIamRURkdPR3hhaWxuYmgzRldoVmlYRVZITUQwWFYw?=
 =?utf-8?B?UldRai9JNXVNbEtGNk9LMHdtNGVmemlIcUFCVmRkYTJ2QnRabzBHWmJrejUv?=
 =?utf-8?B?TmxmRHJWNERkemF3SXFQTkpETXROZUpmbFJtK0RQb0tUUmo1bzZPUjF4RWF5?=
 =?utf-8?B?bVM5d0YzSlV0M09UYjBUUFhkTVBlNmFRT3YrNTVnYXB0U0RpamxacitkU3M3?=
 =?utf-8?B?c1pHRnh0MUZueGpmOUhZVE82YXhDeUNEVWdTQ0kvdGdrUlFHa012SU5WM3Zy?=
 =?utf-8?Q?v2fkidA1Yf+sL/FWXi6sGJQ1n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1852f688-e7ae-4c47-d202-08dbc8eed63a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 17:40:32.7000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VhSCbuiKSvP77ap/7yzDekHFfktw2zoql2ZEInXBys8abyWZuiW6mBWmDU5Jn5Aa3h55lk/fcdO0tkveyyOdMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Babu,

On 10/9/23 10:25, Borislav Petkov wrote:
> On Tue, Oct 03, 2023 at 06:54:25PM -0500, Babu Moger wrote:
>> rdt_enable_ctx() enables the features provided during resctrl mount.
>>
>> Additions to rdt_enable_ctx() are required to also modify error paths
>> of rdt_enable_ctx() callers to ensure correct unwinding if errors
>> are encountered after calling rdt_enable_ctx(). This is error prone.
>>
>> Introduce rdt_disable_ctx() to refactor the error unwinding of
>> rdt_enable_ctx() to simplify future additions. This also simplifies
>> cleanup in rdt_kill_sb().
>>
>> Remove cdp_disable_all() as it is not used anymore after the refactor.
> 
> Do not talk about *what* the patch is doing in the commit message - that
> should be obvious from the diff itself. Rather, concentrate on the *why*
> it needs to be done.
> 
> Check your whole series.

When you send the next patch set, please add the change log in each 
patch after the "---" instead of in the cover patch only. So Boris and 
others clearly know what are changed in each patch.

Thanks.

-Fenghua
