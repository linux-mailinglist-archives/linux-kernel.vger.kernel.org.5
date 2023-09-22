Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDF27ABA23
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjIVTgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjIVSAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:00:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DB9CA;
        Fri, 22 Sep 2023 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695405568; x=1726941568;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qq/hyd87Xw38sxr+gK2BnIYfAaiRxRuZ2lVhenT/l0o=;
  b=lba0vEzWEGmmbLYoYuocgM7JcX6hrSB9qLEfd7fsbyth2ED9A5pR1k1G
   DNRFf1cKD5c68RauYhN2AS42nE68RooHsGoEstKpUPu/3F0Hh0+1Q3Y7c
   c/y7yUtdTN8LpACPnaRyUeD+dwwqVHazBNx04xzb8Ea+PkKMnZM1pJWOO
   LM1q+QtG+qPqjou/iKvrRqh+Iq5YQRbyplwnIFg4fqT7bKUNtd9WiWYq6
   w3t7h1XSKDwqBj+iS8r3LOS7ZvI3fdZeCigeqK1tYOYxFYBoSOb9Pqf+J
   ujXXENfAVbS8/KkZjvcXTgIXKsWBXqA0g0/XVtVmvY1yxfw7oADcQdIt4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="411833992"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="411833992"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 10:59:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="747613850"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="747613850"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 10:59:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 10:59:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 10:59:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 10:59:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKUOeyv6+mgfmbDj68ZRihjM6jBIrA7rk0fC6WCmQWjrOKTsNcio51YVzIOhguwx0sT623p7483hvDabMekME2sNupNFsqahpD8+HFSNyr94mDCZFoC2v/AG0uQYblWBi940OWAujddJZP/n4xWdlq3B4rL81LPQ0E33Bl7OV9NLmtOG+YS+l4cycugHPpVYUB+KE02rYPy+eE58rlzo7JZOCe+sQI9RlfdFt0U3YrfV7psuZphEu60SlMLSt/03IFWamaXW6LpGsa3BwePMKewNbZDU137Y1s/ABJS1zs0MBPK0FVqa9Tc7pG5G7f/QUZ8A6HNhCsBOONCFypnFjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJd4b4p1CQkKhIYjPJiAuDivnVFsE2XanDI9hq/Mj5o=;
 b=Gh+r9dSEQ5qRL5u2ci4oypcWx5B427Dfv4XvOUp3iKbTAY4J0V24q1g3H5JrvAsxmcGvAKRG0yC7QIqNmGSp7nPdB6EJxpFqJ5qXfayzRznpdqUfFloNOMgrVj77fvrhz2um66vepLotq9Gu/iPZW7ujwTUzI2HB1kIThYAdkbg6JqJ3wyWX31o9Yb6+/8+wTK2SIT20sI3UAaYPtDR06TLzO9um1v/4R+gfDca3ngzY5A2KH/+90xjrbkZsylRSfT8AJOW3lCMHuqpWHlsKfSLl+HeafO/kN85lAnY/KlJxDENT1kq72xL4uTMNB+vyInPpDnXUKrWx8+etiJLSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB7448.namprd11.prod.outlook.com (2603:10b6:510:26c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Fri, 22 Sep
 2023 17:59:20 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db%3]) with mapi id 15.20.6792.024; Fri, 22 Sep 2023
 17:59:20 +0000
Message-ID: <51ff0094-5c7b-824b-8b3c-2439e5477725@intel.com>
Date:   Fri, 22 Sep 2023 10:59:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v10 10/10] x86/resctrl: Display RMID of resource group
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Babu Moger <babu.moger@amd.com>
CC:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
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
        <adrian.hunter@intel.com>, <quic_jiles@quicinc.com>
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-11-babu.moger@amd.com>
 <CALPaoCj46dDCFruHW3EcqRQ90SZpOsKK2UVPzb+88rzs5aTTJg@mail.gmail.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <CALPaoCj46dDCFruHW3EcqRQ90SZpOsKK2UVPzb+88rzs5aTTJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0079.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::24) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH0PR11MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: e4cedb51-1df6-4e20-2e5f-08dbbb95a56f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: frCqa+u62jk+ke1RuJI3jCseY2DznIeRNgf+3FT2GDyfp44l7ARLG/n0bijqsMrU0sAsAdMoYnp0RZiA3B409FICzhJtyHgr9YnnIFBvZKEwFgexQN8CdXAYJ0Oq2bdtzw6/HrjYlal9WGtr/Cu89xYmpeLIVbi1E6nZ02mX7/HVBoAK6ljAR+3MEhXMVo006ULhPTbq9TdIScSE+jyQKx1QaowLyMMBf9NelCThIgLV4frkjFfwH+JsDztWjAydnaln++CMAO2Zid1T05w7CG+jk1a5GaVQtEmE38YQ4Q0e48AxAOVYtQkbsBCaQCJ9JufOuGT4BLQ/SVGJdyBVFJMtw+eW4NWJGibAC6i7Yyqh5n7OD9/nrAmoZSB8AJ3vGSDZHgpShk8ZfHNTzbBcMbp76IGlHz+V0MJ/ullBzkTezKbXj0Mop0/1K9yn8xu4yATA0O/mSwGuVxmcTA0VmCym2/BmI0JR9AmOw9bOaR35k9G7x9qGprF1iqQr1xxRwDH8xhQ7iFph/iMVBTHp9pF4+CRvBMa324niVOg8wF9Mtw/CCUTXzZCs6PDk9VYEeFK+l7y12E5dlxRFL4Y+v7TVL/VmJJGoJqNirDqVOv8REJnQvb+FVplipOIb/ThIXIFuFSeOGWGbCn+GgrLtNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(1800799009)(451199024)(186009)(6486002)(2616005)(6512007)(6506007)(53546011)(26005)(38100700002)(36756003)(82960400001)(31696002)(86362001)(44832011)(41300700001)(31686004)(5660300002)(7416002)(7406005)(110136005)(478600001)(66556008)(8936002)(316002)(66946007)(8676002)(4326008)(83380400001)(66476007)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkorMlVpUTArSU1IZ2NMR2dnYjM3VXlaWG1xNWVsQjFQMGxYZi9jS3FLdFhW?=
 =?utf-8?B?MEd0ekZUMkdscXBDZE9HS0RqQjN1ei84NWE1eWt4elc2aVRyY1diWXBoRWZP?=
 =?utf-8?B?UEZ5U1dHM3BCcDl6dkltLzJzNXhTMTJMT1hDelVKbHlSc1ZBQmNkWGtReHdB?=
 =?utf-8?B?SXFSTFh3SHBIQ2NCc1B0eGdYZGpXK0hpbzd1MTIvUUtlZG5DZThRZ0JqTXpj?=
 =?utf-8?B?Qlg3aEtUQmwvRHgyaWkyK29tc21IbkdSdTcwQjJvUEZHS2E5a2VCMTlqdFdq?=
 =?utf-8?B?bExCUG5RQjlDNENJL3lIb2Z3YWl0K0lramUzNG1qUHdCUTIxZS9VbVhzb3FQ?=
 =?utf-8?B?MHlrYUlTQkFBWEtiY1gwSU9lcSttSnUvVitVNDUxcHZOWlQzUjYweFRLRTEv?=
 =?utf-8?B?Q1NVN0d4VHJYbWh4eVpCbk5PcTNXc29nbjZMTkVoVlk4ZFdBYmxtUWpWLzVk?=
 =?utf-8?B?d3h0SDVrTy9mRnJqeFFXWUtKQWs0MEZpa2JXNk9TbnJ5SThzMC9VRkoxWEUw?=
 =?utf-8?B?Qkx1UDU3SndhaitGR1d2Qy9jNzNwN1lHRUZOc0RpdVJuanhpQjVaOTRkc1ow?=
 =?utf-8?B?dkY3ZSthWHRaajl4WnRweFFIZ1VrTmdsL0NyREJQeHNtMks2R0ZJeGpibUoy?=
 =?utf-8?B?Y29vSjUzZVh1VUtoQlZ2SnNCLzVSRFZvbjJHTUFYT3A3YWVzM0hYSDMvb0ZJ?=
 =?utf-8?B?WkhlUldVTG12cTVSbkljK0poZ0RFczlZRHJET1pSRmhjZStqN2QxdDJSTjZZ?=
 =?utf-8?B?aTVndFdXa3l4U0gzczI1ZGlkL3Y4NHhGczJWUkVMZlNzMGpOOVN3emR6bVE3?=
 =?utf-8?B?RHdsL2FaaEVLMmJFTS81SDRMMWNRRHFuSTZLQTFhNG5lTmErWmk4KzVXakd3?=
 =?utf-8?B?ZElaTEs4NnpBd0g1cDRaVTdvM2VXQUQ2SEVTaUZvdjhmellTalFQSWlWcHZX?=
 =?utf-8?B?K1BNdjRwV2R2Q2xodVArWC9xMUV5RGMveWE0Zk9hNnMxK3ZQcTBsaUY4bERm?=
 =?utf-8?B?eDR4RHZtWm8vclIrNk13cy9pK1pIZGVwNmNhZW5GdkxQaVgwUWxBV29uc2xl?=
 =?utf-8?B?ZUtLMHMrVVVkWmNMR084YmFGMTZtSC83R0dNdVlOM0o3WkhzZVhYN3FlUEE4?=
 =?utf-8?B?b3ZIMHNIbzJncUZTaWluVnB6YlJUWU9udnZlVlF5TUNOSmdjMDJJenl2akNk?=
 =?utf-8?B?ckhvMmZLamw5bjUvYmJuUlBVTWQzNHFWd2kzR3BwUXhrV2hITG0rY2RwdlA2?=
 =?utf-8?B?UHE4SndoNFdFd3lpYTlMUXlwMVliL1RRU1VVSkM1SmRkVHNtMm5pcTBTWWlT?=
 =?utf-8?B?RHVQSVQvK3M0S1dmenFyQ1MvcjlWZ01zSDBmYi9sWGMzTXZiemhWeHg2ZzlR?=
 =?utf-8?B?VWcvYlM4alVMU0tSNGs5S3VNT2ZKRUxmdFJIN1AzbmxoUUFiRThoNzUzRDNV?=
 =?utf-8?B?aHlvRmNQRTNoNWNDTUNJcHNvUXFMcTkvN2VBY1BxSld3Rnl2am9RRWhPZlVv?=
 =?utf-8?B?djVaYWZBaTl0QVF4Vk0vMzlQQ1pvUFZrUkxxZVNtdi9XTmU0ZzlJWkxKdThM?=
 =?utf-8?B?Um5DUXJwbDRncDc3WndyRkRnN3NFaS9IMTRIMVNDUCtpeVExWHE0TkZQRlRL?=
 =?utf-8?B?SjhoVjllVHlRb0FMWmk0RDdIMEw2dU5vSDV2UldSTkdHTVFFL1RtVkhKU3Vl?=
 =?utf-8?B?K3gwMWVNYUduMTZwMHJYb1hNWjNxc3N3MlIrUEVDYlNMWk9tNlpHbk9wcTFM?=
 =?utf-8?B?VmZDQS96UDVLcGJKVDRBdjVYR3BReUE1cnoxTzBrVjRBRHNlU3JRU0crK05O?=
 =?utf-8?B?ZWdZR1pObFRmcWgrcVBScW5xbDA2c1BWUEUwYVVYcGRLNXk5Q3B6elpTZUJJ?=
 =?utf-8?B?TjBMNUNLVmJseUNvbTZJQ3BUd1pjelV1a2ZybUV2dVFNUDZVeTdwbnZMZkxD?=
 =?utf-8?B?K1Q1a3dzUFZueFFxa1JCWS9CQmNqWFpXanZIMUYzLzgvSFZad2dDa0ErbWVv?=
 =?utf-8?B?UmZ6VHJpTzhZbFVFRUdLaFRXQkRockg1a0RLZnpNQXEzSlZDT21hWDd2MVAx?=
 =?utf-8?B?REFlZ2JvRFAzc3YrbXkxeWRZTmIyRmI3Y3ByZWsvY1NnNUViVjBLRUw2cnA3?=
 =?utf-8?Q?w4GDKhl3s1POufJspK8JSPdPb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cedb51-1df6-4e20-2e5f-08dbbb95a56f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:59:20.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrUGwEAck37c1wzk6EkrxyqeydUZ5ILzGw45hSwwmGj/xzhkIBh83M2KEJ4dwKRyTL2EgbmQfYCkTsWt+VZh8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7448
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On 9/22/23 07:36, Peter Newman wrote:
> Hi Babu,
> 
> On Sat, Sep 16, 2023 at 12:42 AM Babu Moger <babu.moger@amd.com> wrote:
>>
>> In x86, hardware uses RMID to identify a monitoring group. When a user
>> creates a monitor group these details are not visible. These details
>> can help resctrl debugging.
>>
>> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
>> Users can see these details when resctrl is mounted with "-o debug" option.
> 
> When I reviewed this, I went through the whole series second-guessing
> the wording above and wondering whether "monitoring groups" applied to
> CTRL_MON groups.
> 
> I was able to confirm that mon_hw_id did appear and had a believable
> value in CTRL_MON groups which had allocated monitors. (and I added
> some comma-separated PID lists to the tasks node)
> 
> for the series:
> Tested-By: Peter Newman <peternewman@google.com>

Please use "Tested-by" instead of "Tested-By" (the "By" is wrong).

> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index a07fa4329b65..b4910892b0a6 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -296,6 +296,11 @@ struct rdtgroup {
>>    *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
>>    *         Files: cpus, cpus_list, tasks
>>    *
>> + *             --> RFTYPE_MON (Files only for MON group)
> 
> If monitoring is supported, all groups are MON groups. I think the
> "only" above caused me to second guess whether this takes into account
> CTRL_MON groups getting the RFTYPE_MON flag set dynamically.
> 
> However, I think the documentation above is still technically accurate.
> 
> for the series:
> Reviewed-By: Peter Newman <peternewman@google.com>

Please use "Reviewed-by" instead of "Reviewed-By" (the "By" is wrong).

Thanks.

-Fenghua
