Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F10788FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 22:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjHYUUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 16:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjHYUUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 16:20:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907E7171A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692994831; x=1724530831;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l9KhruYqZra3TcUEmJUJl7uHXeAsrWLO3pEEAoyqquA=;
  b=K/irW2hh6J4OYum6X3OXo8Wnpamcu/mcgFsrG94FYS2RQAO5kVHz9WhP
   Hy4o82OhrwYp1pa9uTanKX7PfqDkNFrdLJC4uyKSeGcuFOrwPdQQCnC2j
   b2zj3awKeKejQ37wksnVKXU9F0Qlemh9gcf1/yRPGjKj4Tr2njdancjbM
   +5unedQhoHBHgqCFmG2iMHr3TacafrQXPdF/buu6b/0uOP93Ujfupv/ui
   FwcdYBNhVdhxgh7tgAZAzzYiHjSVI9pHUYKdYf9/Yq4CWZiifq+P43WoP
   bu+MNpFVzkxUtbDWH3kRhAg4k4CFHkZed3LdvZcetLkg+2pnjU2FBfnV3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="377534535"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="377534535"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 13:20:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="807646447"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="807646447"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 25 Aug 2023 13:20:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 13:20:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 13:20:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 13:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUl8BDcJ242NxjMKeZF0+OG1q35b5dAIJq322dTVtEXkIaxLJvhqy18X5eoXtdy+lvBQviViHDaSbe+pym/K5bZ4eSsnRUEBdBUGtFkvO6iJB1xiVp2NsRGvJINkDtnvvxFAg1Yawcta9b7fJ3Qkg0yzgitylT2Yoql2ibvtjxTDDz0BSgIKckrlF+s6OQ0ClUZu4qVEMfx9NJKE6LICyZJP22JFYwPhWp/4ilvx7XxQj19ahVGSQBsJo57OSRtl8X+pw3LwNDYg4/uPtil2/Qvohr9RMPglq1HVivCHFQFxjYFTRU5kPyZubSBYzd+w74DEhxEy2TLg2cnrVApqEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm9LUCoWVz9JNgxW1XrfhHNUvQtH317XXBwWRPftwUE=;
 b=RP0/U6MmiETav8h+7+a/VFZnnX6FGZE1tYGEsuIDpbYgvVKf+2jIVKcNFZF1ZirQDPzoK+79WYHv0oy6NVP4jScWggv03Ujhk9Js88boZrSSV/gbWGdZ7IdNFRv/C9aZICoRML5vX7XSAfhS6IxMYC1RADkhJpSbx3yYX1npebUxDrjHIN6jP4+Y7ixUkf2Btzty949RN9lVIQNkhbObAy34+ZmG5MVKgmgWUqUw+JvRjdvJRJx4n6ismQOLXwfOWRi9cnRWyWd3yHXU5F19eGgR9nGf+YoVVB3SA+3um5/SEGaYbOjX76ptKGaf+R0Uu2a7vic8ffmIiz8CVVNxwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM6PR11MB4658.namprd11.prod.outlook.com (2603:10b6:5:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 20:20:25 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 20:20:25 +0000
Message-ID: <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
Date:   Fri, 25 Aug 2023 13:20:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: resctrl2 - status
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
 <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
 <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083C0ED50E9B644F4AF8E4BFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:303:b5::17) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM6PR11MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: 724c282a-8ce6-4489-6102-08dba5a8b78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KcFP1tAqauYya3Os5fMK8pMizkin7C1jibzpIIsmNEPCIl8z2swhsCfUAZVDoBIDC91/d4fIuzDz+TkX55D9mAzZAm/qDxZEeZAxrFjOZ05DYN3jmZvWpYDiuGRZcluFncdtpstoGh0vGtyT2wma/nDZltmfklgCBL1f2G2dDmJ492IX9a/t4Rwww1vk4vJxflIgCaRZLvFlh8gwD4g0oKQ15ygKuXB48NiTu4/FNhEzXGaa+VYYBxBn6luFkq903f9xxAPzN7TJtkrCzgrAnIx013XVUC7kyw7vF8sDon9LZ/PLg2G0psrnSOtj/wqQRHjAnmMZBEM6A9B2Fpe0WJe8vXq/H98FUOTmt8o2F1sBJEQE2yyh8bPRLnpqdVtITuBnxyxSfaJE3KFvrdpoVKuG24UJrZSMrpXY9ur6v6CJx59EdkRHSOLTRaPdqS/HwpuayLbT7D4NJ79cGyv2l3ukXT3aJZOzxn40lNesr+YOxgcXORoZ80QOkG+EN/wdWS2Lv8nSDthbsJDZZuJe/Sg4/EI1O2qs+gt0+jiSUizzWb/5M1c+RrNhnGKGPvVpiPXdfqQgacGh3Bxky0bMXKbXBGQJD2E9glXLV++umhLs0mli5n1mvRfxAK2MdqQVrHTtp/R0yD71cAPc1BsMYQYGRHhm5HUvDxAtX3i/H9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(136003)(376002)(1800799009)(451199024)(186009)(44832011)(83380400001)(6512007)(478600001)(26005)(2616005)(5660300002)(31686004)(2906002)(8676002)(8936002)(4326008)(921005)(66899024)(82960400001)(38100700002)(66946007)(66556008)(66476007)(86362001)(110136005)(41300700001)(54906003)(31696002)(53546011)(6486002)(36756003)(316002)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aThuMjJzN2d5WTZxdDBFcHNFbWVFZDJEYkNsTUQzOVAzcmdYRERadWtwOGVs?=
 =?utf-8?B?UGhGT3BmNC9qRHBUZkFiTXZuRnVvM3lOeXlXZ1VGRnpNRWdGbmxNOGZQL0lm?=
 =?utf-8?B?MCtnSEZSekpUaEFObGdMSzRVaDVwcGRydlFEcHFwWlBLbE1Pc1VnNk5GVWp3?=
 =?utf-8?B?ZTlJQ3Z3ZVBieFg4aTlRNEhFZTV1VzZtOTRMeW5YTlJVcytKUkFyRlBhT0hF?=
 =?utf-8?B?M053NXhYdHZxZi8weWoyNnhsR24wNXUyTnoxWUxPTnVGek5yTFVJNTdqWTdx?=
 =?utf-8?B?a09aaHBvRzVRYUNoSWpyMUd1TmpnUitFUHgxb3lFVzZITFI2clpIR3VFUkdE?=
 =?utf-8?B?UVBOWjV6R2hsMHd6M2tuRzRMOSsvbmpEU2ovT2lQWnRBTFdFVzBoSGZzMG0y?=
 =?utf-8?B?cURucXhqcTFuTzEwSWRWcGk3SkJnVnkyRkxqTEFFR0laV1VmckYwTmpMTlJl?=
 =?utf-8?B?M1BPUmZVOUVqQTBMUERUeW9vMWhacHE1TEpldUgra3R1dEhRd0lQWlQ3VzBP?=
 =?utf-8?B?TDNQZ3crQkI4eklEZVdjWTZQKzdoR2dmSFo0azV6b0o4bS9vQzhjMTN6aWRY?=
 =?utf-8?B?bTJkZEVtM05pbzNPS3poZWo0eStPc2hnd05SQ3FpKzRKYmFaNUR2dTdEcTJp?=
 =?utf-8?B?dVZUTnhuRitBZG5YRUtieTh6S0VEVkhjeWx2MCtHeHFNWHUxRFBRNzJaNVN1?=
 =?utf-8?B?dnJrc0w5TDhGY1F5dFhMdW80TWc4NWxnTUFlSWpnbGFMNGFaN0MxaFM5RXBZ?=
 =?utf-8?B?K2xiUVE2L0JMeVRIbjMxazU4bWs3Z0lCSUF4NmorRThhMFBiSUo1U0wvdGxQ?=
 =?utf-8?B?TVpYMDBKbWZkMUltR2ZpSDZscC9jV3hIaVNra1dyenJIczV6MStWa0tvNytV?=
 =?utf-8?B?K2JQUWZvaGpNVmZJa3ZEQ0s1TzVQWWdKVzJZM1RlTEt0T01WeVJQb1dBaFlq?=
 =?utf-8?B?U2FjQS8ybzh5cHdHVThCYWJqMEZFbnZIUy94T2xXQzZYSXlsZVZoNXB5NkZN?=
 =?utf-8?B?bExmK2hscmlSYUtIRlNsSlpER3F5NklJWnBseW1PUVlVRitkdEYzYXZmcHF4?=
 =?utf-8?B?YzZDU3d1ZVdna3JKK0lWeXN2c3lZRzdiSVRFZEtlYXBCSzJjUXpQM2hsL1hS?=
 =?utf-8?B?L0MwSk13eDlrQThYZDlsckFiSkxpTWtMTWIwOVJNaGw1aGtzS3dZK2VZZ0R4?=
 =?utf-8?B?Z0JpR0xUcnV1bHNvT0NxVTY1RER2VGExR3pFU0RES2xZZzdzRURaSVhUcnJR?=
 =?utf-8?B?MGhYcEVjak1ISEFTcEdqeTNSaDYxMzJIVCtvOTN0ME0zczhxRStGZUtpV2sw?=
 =?utf-8?B?Y2ZVMXIwRGtEMmIwSmdaU0M0a1lLNms0VmJwMjAxQ2g3N0l0am5JZWc0VDhW?=
 =?utf-8?B?RWZQbFBrRDZyOWkzVDd6dkxBYlhRV25MRjJ3OTRsMllGOW9GV09USXNyeEtZ?=
 =?utf-8?B?cXFHdWNGN1NKVzM0SHVZRUplOSt1bjlFNGRwcDlwLy93M01NTkt2NFl6eWMx?=
 =?utf-8?B?TFIwTXNhbUU4eHpDZE1IbDNXUzlGNWNFT2VqQXc4amNidmRTNHE0QnRXdWlo?=
 =?utf-8?B?SWE2eGljeENCOUlCeUJLdW9HeTJJcVZCbHRKTUJ1YWpGNzZLNVFzaWJyNENh?=
 =?utf-8?B?V3VzLzVLT3dHcCtMY1Z6R05wSk9kalNBV2l2WE41SUl6NUgzWTA2RHh5SkRP?=
 =?utf-8?B?SjBnaHNOdHllL2ZNdnB0eS9nWXREcDkvRzFmTEN4bTAxWjNFNWhLTytsS3M1?=
 =?utf-8?B?VldkZk9hektFUlFOVjYxbG1rNDBJcFlNS213QVUrUE1ORnZPRVo2UEtzRjVz?=
 =?utf-8?B?TThDQ0dZV0dWL3BMd2dLTEF4aThjaXVtNlR4SFh0c0k4QmcyT1N1V1VpU1Ir?=
 =?utf-8?B?ZWM5c3owUGlYT04yL2U4OE5kWmViNkdITS9FSnZDeGdrbXJHY2NJc2lycG14?=
 =?utf-8?B?K3Mrb1Vnck5jQnVobFpjcUVqcTI2TFpjNFVnRGFLYVZEckh2WkN4c1pXZW9n?=
 =?utf-8?B?Q3ZEN2VKV015TldFZVlGaTFUdFhPUitUWnQvdVhrK1hqTWQ3WnpIbzFMT3dl?=
 =?utf-8?B?QUpZYkxSWUY0MjYwakxoU2htckdhSEloK210bDNwZzVLTFROUTNpY2c1N2NX?=
 =?utf-8?B?NWdpc0IxVkxCSHh5dWM1M09ETTdrc2lzc3FUV1ZvTmRJbmx4NDl0Wnl6bURB?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 724c282a-8ce6-4489-6102-08dba5a8b78c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 20:20:25.6873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlT2mFnhNPwNkNfiEW5TdGttYxKzmJUv7iN3ptrwFT+iGTwOULnrpXtIQ5AyjLEHJXlXVYPyLRojD0aFjsq5doKwy/Gu2xEwcSFSby+h/so=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4658
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/25/2023 12:44 PM, Luck, Tony wrote:
>>>> Alternatively, can user space just take a "load all resctrl modules
>>>> and see what sticks" (even modules of different architectures since
>>>> a user space may want to be generic) approach?
>>>
>>> This mostly works. Except for the cases where different modules access
>>> the same underlying hardware, so can't be loaded together.
>>>
>>> Examples:
>>>
>>> rdt_l3_cat vs. rdt_l3_cdp - user needs to decide whether they want CDP or not.
>>> But this is already true ... they have to decide whether to pass the "-o cdp" option
>>> to mount.
>>>
>>> rdt_l3_mba vs. rdt_l3_mba_MBps - does the user want to control memory bandwidth
>>> with percentages, or with MB/sec values. Again the user already has to make this
>>> decision when choosing mount options.
>>>
>>>
>>> Maybe the "What resctrl options does this machine support?" question would be
>>> best answered with a small utility?
>>
>> A user space utility or a kernel provided utility? If it is a user space utility
>> I think it would end up needing to duplicate what the kernel is required to do
>> to know if a particular feature is supported. It seems appropriate that this
>> could be a kernel utility that can share this existing information with user
>> space. resctrl already supports the interface for this via /sys/fs/resctrl/info.
> 
> I was imagining a user space utility. Even though /proc/cpuinfo doesn't show
> all features, a utility has access to all the CPUID leaves that contain the
> details of each feature enumeration.

For x86 that may work (in some scenarios, see later) for now but as I understand
Arm would need a different solution where I believe the information is obtained
via ACPI. I think it is unnecessary to require user space to have parsers for
CPUID and ACPI if that same information needs to be parsed by the kernel and
there already exists an interface with which the information is communicated
from kernel to user space. Also, just because information CPUID shows a feature
is supported by the hardware does not mean that the kernel has support for that
feature. This could be because of a feature mismatch between user space and
kernel, or even some features disabled for use via the, for example "rdt=!l3cat",
kernel parameter.

>> fyi ... as with previous attempts to discuss this work I find it difficult
>> to discuss this work when you are selective about what you want to discuss/answer
>> and just wipe the rest. Through this I understand that I am not your target
>> audience.
> 
> Not my intent. I value your input highly. I'm maybe too avid a follower of the
> "trim your replies" school of e-mail etiquette. I thought I'd covered the gist
> of your message.
> 
> I'll try to be more thorough in responding in the future.

Two items from my previous email remain open:

First, why does making the code modular require everything to be loadable
modules?
I think that it is great that the code is modular. Ideally it will help to
support the other architectures. As you explain this modular design also
has the benefit that "modules" can be loaded and unloaded after resctrl mount.
Considering your example of MBA and MBA_MBps support ... if I understand
correctly with code being modular it enables changes from one to the other
after resctrl mount. User can start with MBA and then switch to MBA_MBps
without needing to unmount resctrl. What I do not understand is why does
the code being modular require everything to be modules? Why, for example,
could a user not interact with a resctrl file that enables the user to make
this switch from, for example, MBA to MBA_MBps? With this the existing
interfaces can remain to be respected, the existing mount parameters need
to remain anyway, while enabling future "more modular" usages.

Second, copied from my previous email, what is the plan to deal with current
users that just mount resctrl and expect to learn from it what features are
supported?

Reinette
