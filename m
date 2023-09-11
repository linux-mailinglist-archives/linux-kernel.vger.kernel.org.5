Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3076A79C2BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbjILC2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbjILC1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:27:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67503B9F9;
        Mon, 11 Sep 2023 14:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694469314; x=1726005314;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FcvhO884mOkEItnUWytPsQCrRHgKyVUGb2DS+yiAoTE=;
  b=lzYRc48BmI+Flb+19ehV+WdSHgwlBhjRuLxP2r4Dh3b2RP4p2/u6B1/t
   a+k7NvsftGp9N0XIXZE31jw0Nb3/+HT3o0Tu6OOhxvg8ID51rjRK4GRSB
   h305yhqfDNPYa8LMLSCL5roKVe1sDiKyajglC38Wvhsk6uKjrryAPJey1
   bkziPqyN7I6BzzpylmE4BP/LB3J+ILlEi5J7DMybml3t/gMRNXPZkmZ2s
   NerhJEb0315K+SM+2MC5/few/tY6kH6VsUDaMYCkoKASPUwwxKdpXjoO/
   IrycefEdzQ9oEReghqBhvH2aF89kmzDvhiWFRREEcHrX/3udVGwSEGxs3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="363250880"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="363250880"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 14:53:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="736910423"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="736910423"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 14:53:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 14:53:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 14:53:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 14:53:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 14:53:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZt1zmH0xOsA7eyuFzJ97fqmpNBRTkhLfcABbL5nUd+sfUXJcnYmOkOeOZKUKLvKisXFPKNcZIgRNQm6IJf9Iwuf8eYEgld4/OPxMCeIrYT6f/ecmBRsGmWDB9uHVeD72LkRDxBJgwU2EYE1WCzr0uNVgJaxhhr59G88gvlda17dqoL6d3BEAiSi/htBhvWSYM4k0TdioFTAYXIUoagtEZZYASzNaHQlKDu/50vpx/lmTUX07YrH8OtHuA3mwjjJtRBaNYWbbCb7mzDdlDyDs0nx60izt5K5JvwQ9vSs0BGpi8HlZcZnypYJllm6GOxKTzsjgOmcknB75PtOShwFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4tjHnII43VFguMa3nMhvCUZiSOyp1ABuqlSxKf1vsAc=;
 b=Tt9AdDdS9pUMG5JCGFeb2UeFOJL1lbygd1eU2vTPw9IJKVODf+QE+XX0jsx0C2RaxKw83THXWvzEgAM7SB8+EKffMcNtdsA8uZKg0L1lCr/YQx8HP9gLDryMlEZd5vdr86xhzdKs5cNUb1KpeS+IjQJBA6uHbb6Iewhb7Jo+odCg/8XAN9QLpUTjLX69hb3Y9wNqo0bmukriPsHd9ZXB7SdB8Z6Y95s/qaUdEfV6Y39iH+nvWVfFqQAB6LA6PdOdlzfIf7K6xfWNooeJlXjkHS7Dq4uUEvqnnp300GVehl7P59x1Ye5hdyXWKNUN9L74QMGiG1JB6TktWMZbkCw1Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB7350.namprd11.prod.outlook.com (2603:10b6:8:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 21:53:37 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::afd6:ce92:6244:7203%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 21:53:37 +0000
Message-ID: <b768e6bf-04c8-ad90-bfb1-39d78073be2a@intel.com>
Date:   Mon, 11 Sep 2023 14:53:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.0
Subject: Re: [PATCH v9 8/9] x86/resctrl: Display CLOSID for resource group
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bp@alien8.de>
CC:     <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
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
References: <20230907235128.19120-1-babu.moger@amd.com>
 <20230907235128.19120-9-babu.moger@amd.com>
 <d0bd1c6f-f1df-5355-5fc8-4fbd3be7d1e2@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <d0bd1c6f-f1df-5355-5fc8-4fbd3be7d1e2@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:303:2a::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: a75e82f5-e2d9-47d2-1030-08dbb3118d82
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ayvC1TmaFqdVfIXqdRlLrt+N3Sjp+aOTDnyh8j8mGW9SIhXjssr+CbdBsYCL/cnwcekQSEzB+jbUcuuBS0TQoCLD5axgFR5yBHtc4TU89dX3G1jXlrWokToarcooH0XA+gk+StsMeBJhYP/docbuFoYAwX9E6QnzJKRV8a3utHZSNkuZJ4mTGIXdDkvg+R4AtW4YDQJ4ClgcX4o5cAlI/yYsiwlIVpV6sS0QvvylNu6xzzHp2JqhBadojTr2iK+0y85Hr7PVmPnnbhQls5y+LWg3H64x6P7p3JSDLiCOV8fDcLhm72u3dYp5LqsAKVzZ4eZ9tJPHKU0pHyM8mUPy4tHVlrvvOHzogxIQTuyGeiZ9q+stWp0KiSLLd6opD70yhb+Vv6M6V6GYRr0wZe6RJa+H7ngDbQzS7Q99DIzA95QYIrzTTdks/xRgBP4xAvmZC6Yueqchel5+dmExjA3FqQxDR+kgutXDjK75H/9CXh01Yt/g7XT+3gaYot62Ecl2RcnfTPEO8K1clK4Gqe88E3b5sAk5wqllrMgho834t9iUadpsLYR5IdQt362Yrv3z/kkLHeSQme5Vr7ghfP+NuCUYFhMNmswBLT+BORNvBFQH4vKIM9PK9D2T4ajs0yO9VRR2HCXdhDBu3iuYgQZBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199024)(186009)(1800799009)(66946007)(82960400001)(66556008)(316002)(110136005)(66476007)(38100700002)(2906002)(478600001)(7416002)(31696002)(4326008)(8936002)(86362001)(41300700001)(8676002)(5660300002)(6666004)(7406005)(6512007)(6506007)(53546011)(2616005)(44832011)(26005)(6486002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGVFSzhIUkNpbzI3ZWliQ2pJaElzbXhlemFNcjVlanVCQUUzQ1h4RHpmeUYv?=
 =?utf-8?B?Z2RMTld4VTVMMlA1MEZIMW1XOHNKUHEwNDB5aGd3TStoR2xVdi9kaVphd3lU?=
 =?utf-8?B?M3EwMGMreHMvUGs2N0VlZVozNlVrT1F5SU5qM0paRmFmSmhTTWFqTzltek41?=
 =?utf-8?B?bnU1UGtkelhyNEU5STdNYlJwUVZiNkJnZTlpa2cxbmZQZDFOcmQ0MWZndk0x?=
 =?utf-8?B?M1A2dGlOK1ZlNHlTSjZCNUdVdDNyWFFHbDFLbFRqRHFwZGYwS1diRDNpNFJp?=
 =?utf-8?B?MDZ6TFNDU0ozd2R0NDlXY3d4SURIakRZS3JFbVJFQVgyK0doOHIwSHQrUzln?=
 =?utf-8?B?MWJVVzkrZDA4YytIWlR4anZzcmhXM1NhWGZDbUJ5cFYxTFlxZUc2eTFrZ0Jm?=
 =?utf-8?B?QXBiaWJDUXJnS1dvV3JlWjF5YnZZcDRUWjZZR0dhYXlYL0dqTXFxdmpvZ1Ay?=
 =?utf-8?B?Q2RVZUVtREhnWW1STUkramZMVW5VN2YzSGhpUUNBUDRwWGJ5UVpSRTZjbGdO?=
 =?utf-8?B?bVFGa1M0RWNjd1VMVVNZblRucm9DYnU5WmFySzdaM0JTWkswVWVONlRCcEFI?=
 =?utf-8?B?YzB5SEZ2WEo0TGFQTXZJOW5YVzJHWEFIZENrTGJ2Z2phaWtxdWs2TVFGM1cr?=
 =?utf-8?B?L005UVRwcUtJSGFKbkNyNnduYmdXclRuQVRvVGlzbXY4RHQ3Q3dhbFRLVkJk?=
 =?utf-8?B?VGIza1RxR0VFWExvTC9WTkdCbHdQVm9CTDRocTFHa3V4OFc5VWN0M3dxWEpp?=
 =?utf-8?B?T2NITHNtak5HUm1ZcVRMZ2p6NGVkengycVVXV3ltS3laaC9ueDZNNFFwTkZU?=
 =?utf-8?B?UUppNVhRblM3c29qbDgxNGtPRHZsZTRyWlVmMkw5YmJjbE1mK2huZmQ4TThy?=
 =?utf-8?B?cGJnTXgyZjNzcVptM25wdU9DQWZKVzRMeGt6SjdHdnBzY3ZsMWV4d0h0bVVX?=
 =?utf-8?B?Si84dlRTejhLMVhROHhZa3k0ckJ0aE1hSWMvNUg5bERZSzBGamYzWWd5N2Ur?=
 =?utf-8?B?c0QzNVJQQUx5MGFlWEJodCsrcjU2cXA5Q1BaSC9XOHNKUHBnWDVkVzBUcjN6?=
 =?utf-8?B?M1RDckVDUVdUMW9DR0Z5VkNtdCtqN1Vxa0wvTXVMMDJJbXZFTnFmT2t3ZStR?=
 =?utf-8?B?QlRuQXVQYzFrbFdUS0xRQ0hMUllZWWt5Ym5ZQ3NtU25ITFZ0aUdYZnVXb1pz?=
 =?utf-8?B?Q2k3ZnFFeXhIMWt5b0ttTGNib0d3SHI4RzZ0Y0U4TWhqdHgrSFBhdVVVTGND?=
 =?utf-8?B?UVhmajMvZ0l0ZDF1YnA3amxsTE5UZk9XVVdhOUtIeE0xRjlXL3NXZllDd2tp?=
 =?utf-8?B?VUttdTBtUWF2QnR2RFpOSm5BNmJrV1UvL2F3MkNMbE92VGQ4SHhma3M2VXJq?=
 =?utf-8?B?UDlJUW1KZE5QTE5nWXZiSXY3ZzhQUXVydlgzci9SSUd1cnF5MktwaHg1RWlm?=
 =?utf-8?B?eUdkbzgxSC9iMHFGWS91aGt3bUJUblBLSW1tdTgvclVrdTFVc05YRFE5T0Rh?=
 =?utf-8?B?WmtaR2MyR1V1MEZBTDZBdnpxKzhQRWtFR2JDd0xPN0pHU3VlUDQxK1pITjFq?=
 =?utf-8?B?VVorV0UxZFAyV045YituVjVYVDJMb3c5Y0IzZkd3OVVTUkx1c1IzaHFDeXgv?=
 =?utf-8?B?dE5sZTY5OVFuOEU1bHd5VGhwZ0NNbGZKWkNaVS8yNnBjMGZwU3lacTFVU0dK?=
 =?utf-8?B?QWtPd1dxSFBzeEowaEFLTW41RnkyYysrUEJLdzE3MldDNFZoTmNjSGFsS2lp?=
 =?utf-8?B?a2g2Z3hlSk9Hdlo1UXdUSk1waEh0VFJoUHEzd2prMUZtZkxGdW03T0NKZlNy?=
 =?utf-8?B?eXkzSUtqQlFkRjBkTlN6WVdNODVLcHlMaDN0Nk5CNWZ3cjh1SHM0Z2NyZU9x?=
 =?utf-8?B?NTV5Ni9YOUY3eFVvR3ZvdzRYcXozNXBZZzJ4NnNqdTlUN1ZCZmwrL0RKUEky?=
 =?utf-8?B?WXhoWVBVazVKd1hzZ3IyQkdybnNXMHk4MHI2NDRjSzVlcTN6TFlOM3ZGYVRB?=
 =?utf-8?B?UzB3OXY4V1ZsYmcvV1JFeHVSSW1YN2xDZGdqRVlQRlZneUZCbm1vM3h0RlVp?=
 =?utf-8?B?c24vRFdZZ1BCTFFFUGpFVjRQMnVYNCtQbTZWZ1cwN0dqWW40VnFvMG05ZmlS?=
 =?utf-8?B?VmZ1cHM0N0lIOVVuSjl3eklVZW53L21QZlEybHAzNm1kV2JWMUdETm1YYndl?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a75e82f5-e2d9-47d2-1030-08dbb3118d82
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 21:53:37.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDn/ndJ9pNKVwBtwvCXRgkG2+EWuyZoQavpAXHehvSIMJod+lDNBgiNx0YWThtvJE1btVJEPXMPFFeUoeQjEuidhHD+dWvwwn9QEX3sjQBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7350
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 9/11/2023 11:08 AM, Fenghua Yu wrote:
> On 9/7/23 16:51, Babu Moger wrote:

...
>> @@ -1863,6 +1879,13 @@ static struct rftype res_common_files[] = {
>>           .seq_show    = rdtgroup_size_show,
>>           .fflags        = RFTYPE_CTRL_BASE,
>>       },
>> +    {
>> +        .name        = "ctrl_hw_id",
>> +        .mode        = 0444,
>> +        .kf_ops        = &rdtgroup_kf_single_ops,
>> +        .seq_show    = rdtgroup_closid_show,
> 
> Is it better to rename "rdtgroup_closid_show" as arch neutral name
> "rdtgroup_ctrl_hw_id_show"? So the name is arch neutral and reflects
> the ctrl_hw_id. So this can eventually go to generic fs code without
> renaming it. The getting closid implementation in the function will
> be arch specific.

This is not so obvious to me. We have to draw the line somewhere. This
series draws the line between the kernel and user interface. That is,
from user perspective it is "ctrl_hw_id" and from kernel perspective
it is "closid".

I think renaming rdtgroup_closid_show() to rdtgroup_ctrl_hw_id_show() may
be mixing up the two because the function called rdtgroup_ctrl_hw_id_show() 
would operate on rdtgroup->closid - so in a sense renaming the function
to rdtgroup_ctrl_hw_id_show() would move the name further from what the
function does. Would that mean that we need to refactor the whole kernel
the naming to match between kernel space and user space by changing
rdtgroup->closid to rdtgroup->ctrl_hw_id? That escalates quite far and
wide and I wonder if it is not just simpler to keep the naming
boundary between kernel space and user space.

Reinette
