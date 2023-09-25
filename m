Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB977AE0A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 23:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjIYVWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 17:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjIYVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 17:21:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DDF11D;
        Mon, 25 Sep 2023 14:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695676912; x=1727212912;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QWQZL9HX0p/+ZGmqPd3J6dLE3IC58+Vq07vaZso5mak=;
  b=QwHdbELg3rDqj+WFbqNrloPF1Zj+jHYpM8X0t4uNaWIfCAjsHgXWEXn3
   GM34pQHef98yNvbyr3IpWwbBW87gx4T007LTkuS+peLamJe0U8e3IkUY0
   fdoyBlR54isFq1c1AMWuV9jlVIllvomjCOm+VkOsUbDaQgOyNXrqjcS9M
   cpIa2FI4y9VhLtRrzv2fp/RRre9nG94ZZwxkelHQmoP741EEMMgDtz8Et
   t1BXjCNh2J91dq5sygzFtE8ShZhsrF1p8tvN3lW2MwzClm+LxQM21S4or
   6V6C66Vya0WC7D+8RH//lUfXlsza9uDJk/FhGwRLGOMrmuzYN0X8+1dXQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384169623"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="384169623"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 14:21:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748536276"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="748536276"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 14:21:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 14:21:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 14:21:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 14:21:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwZ2p4D9Ye7opoS4i+hP/VxnQI2YWkleHKHaqw7iRjW7Ga6Cwrc0IUtzV2SR6yxjk5iS6y4qvonGdusMyZG+I4FteicZqPDrbLHV4OQ+MBPxArAUq2uVpEysuTaarDpfXNTQevKrlgvamNessWn1DsAsONO6rtExPe8o6djoX30XQvfR9aY0sG89bzy8YlwUSTR14lpATEsu8s0uHp6HSiJFhqVUUttuhC4r9+YLOvnjO5D3ew3Lxm6Sb5dEQZaMCZytJelP+90Q+6CXFbfZypw4BSUcju5v2U0PPROy3zy6oVUOUv3dht1bmRBxhnGCUgvu5Tz3w8S13tIjC4ES3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VagZeEB1O6gc3lV4lFDQfw3fLUSJh7k5lNMQcQ43xrQ=;
 b=Guy5qI2EbAuE0CSFVOY2zV/g4SvxIRunCoIDvEnZ5X+r3GvG/pBSSuXTidATXCfNizSxOi2nA+/yukzlgMCzcaLBauEIZkPDRujD0MfRHowX8QwRM75ABUSp17+nikHV1Zq/BbDX8EiGHdZeWWQrOXUGsJFLbHTfFpI1wKzT0AdtvRNfi1ivlgepoO/CSB4Il5F/CAQ20FlqyLnqnUHyuqr2QU7jvVUFAyp5QUZb7nj25nQighsI5dVdFIA5u7GpW6euI6GYgQpMO0XGQCKB88B3Vc/QqjTHTojhDm8WUYbrNabaA59BunU/2ZxhKgY5HaW79qcLllg3eIb+h5irog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by SJ0PR11MB5008.namprd11.prod.outlook.com (2603:10b6:a03:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Mon, 25 Sep
 2023 21:21:05 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::cdca:c91f:da79:a1db%3]) with mapi id 15.20.6792.024; Mon, 25 Sep 2023
 21:21:05 +0000
Message-ID: <ea350439-f4ec-4e1e-e152-07f2513d8177@intel.com>
Date:   Mon, 25 Sep 2023 14:21:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v10 10/10] x86/resctrl: Display RMID of resource group
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-11-babu.moger@amd.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230915224227.1336967-11-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::36) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|SJ0PR11MB5008:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c4145f-20b5-4a7f-d271-08dbbe0d5398
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vQjBmUGq9HZ0b13LJ7MdbLLp6NfGNiI8NRTStmmaJjk/hdAyitbNL3LJ09ajW05Hw11u9sGnw/LNRP1DmVnUkUmcZnNlHjZtubmxniBy2kS93ZW7qFWzfv4znrkA4qmbVbNFAvggD9e7PsNI84KQT2wEIcBNtgbQsMSiSNzTJuNjK+CKwetI6X6LwvSkBio1DwUuDNwWreEQ/ENk4W6qhYfrmwEpzGd+hvI5+lqz7of34oo15aH4DylqO4DbrCeOYW4Zwajx2OiYye72JNar7Z9JA8MHDqv9cnZCE9THIfQ131gWo4iMncwM/Ic4L3Y/xZg2Dj4vDkMO0DB6hV0u+5lVDPAwn4qLOU0VCnrYjlMJAMIPAsUHV3BERzdF5g3xOeoGbQvWiovHaHk3D9wrj7YcZ7MYVI7QsqUhzsI45m+wJxLfdOjVzY3qY6GhicNJyekxPpSBvrr6r9XiEL/IkfQWVEJwDChl7tU8zOf6NI4uLGm/RB0iYPVfWChb2VB5b5Jv3PPbaIOnCIN2I8f+fxWgo73kK3FltKG/FUFIJ2h8f3zqOuMEpOeXNn9bEJw3jap5mD37g7eNbE2JFrM3Hjazr/LyKogUPhDQy/m6EoiCg6NUW+3eoTEXe0jp7peiM9tKKgLAdjoqw6VNoOpxZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(38100700002)(86362001)(478600001)(44832011)(31686004)(8676002)(36756003)(4326008)(8936002)(31696002)(7416002)(4744005)(2616005)(6486002)(5660300002)(6506007)(6512007)(66556008)(53546011)(66476007)(41300700001)(66946007)(316002)(2906002)(82960400001)(7406005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2M0MFpsNzJCUFpYdVkxdkxaRS9vY3gzVVZGTGRKNlFzN0FCdzQya1JpLzlx?=
 =?utf-8?B?U2tPN2FFdWc2SnM4R2RUcXdySm9aQWxIU0NGUXJIbk1sajNzZkJ0d2ZzaUs2?=
 =?utf-8?B?M0J0enBuNUFBSkE1ODNiMURPVUJBU2RTWEF4ZXBYalQ0Rm5ZSFBaY294Y0Z6?=
 =?utf-8?B?SWY2SVRBVUg0WXlrWGxlYUNPYjZOTUliNXFmKzNURzEzSk05Q2pvbGhmdTdI?=
 =?utf-8?B?M3dVbXlFNlVRVUF3YWF0ako1NW45Q3RHYjVIL29jTWtvbXpTMjkzaGFzUTBQ?=
 =?utf-8?B?cmhQS21WSm1vU1JKV2R5dzVqL2NvTHdubXlVbWtOclREdGk2Yk1BR25LR0Rn?=
 =?utf-8?B?dVYxR2ZWRG1Pdzdac0JRc3orWlUxR1ZkTkdsUzhaR2RlTGI4aVdXUms5bEtv?=
 =?utf-8?B?UEQ1K0QxazJHb2FGblc1Q0lndlFrMlBnRVZtNHdwQlZmYUMwT01uU29KbVVR?=
 =?utf-8?B?ZmpWKy9ocWtvNG1uelRFY29JYW9pQUNFWEdJL2R5aTZUTEpFOEo3QWxya05y?=
 =?utf-8?B?a25MdStiUnlPWkRRT2lDblhTcVdGV0RlNGg0SEhxR3NwZUUwNExEaUJud3Ba?=
 =?utf-8?B?am95VU0rSkU5QWw0SnJKUUpUQ0JxZnVwUy9TbmVNalJINklyWlltMnEvOWJ5?=
 =?utf-8?B?S3RFeHBObUhDQlI3VGNkSDY2NUJrUXhvLzZOcTFWYmlDeEI0K1pTNTRaaHRH?=
 =?utf-8?B?VHFBN2x6Qk15aFdTcHpzZzNXMkJTNHZVbi81cGNJTHJPWW5nUDBCVkptRkRV?=
 =?utf-8?B?bnNSZDFScTJjWW95QlE0VmxLbFBMaldiZXQyTWxKc2pEdkNQWDBVQjRFSXNN?=
 =?utf-8?B?MlVWOGhCd2YwbEVMRUdsZDBOTmhibWl6aXZhUUR3L2FCTm9scnFYM1NHOERR?=
 =?utf-8?B?SFJFckx5Zy9yMk9BWEU0U3BGYUR0UmZUcGtUdkR2ejVYbGpFcEZ1bmtDNXp5?=
 =?utf-8?B?TUZheFUrVkR4eEVxc0MreG5makhCRzE3UnI4bXNRejZJUXRaQVJNTUNPbDdG?=
 =?utf-8?B?TXBTdmQwaDBuS2cyQlRwMWQ4VGwzSEtZVVEvaGlEeFFGenR4WTdNSWJQMkhp?=
 =?utf-8?B?amtuWnp4ZVR0MVN1NFNXMVF0aHNiU0ZhZk1zMG13NHh1Uzg5QTB6d2hlekwv?=
 =?utf-8?B?ajE1blFiZnVkSzZ0ZllVTTUxbWNSQ0tsVlBHb0l4bEc4bnBNVmROMGNIWm1X?=
 =?utf-8?B?U0t5QmdmdlRIbFFkS3lIMzRMck1XTlZIVjVYSHo1NVBUeWhYMGM0em9vRTFN?=
 =?utf-8?B?YjhpeTFQc1FDZ3JKb0EzQnoxd3puV3R1NjAyUkVLQWdvZjVJZm5oS2VQSURV?=
 =?utf-8?B?S2NTekRBZ2NieXZCWi9oTlltZWszdHJlbHllaVZPNWJnMmlPb3d3OUY0V1I1?=
 =?utf-8?B?d1BDRG9ndkRFWitvUjZlUmxDVjFyR1ViOWMxZ1ZwOWpMSkplblBGSWI0cEJI?=
 =?utf-8?B?U0NaWWMzQkovQWc2UHF0NmkwOGpnUXZxcUVJU1hnZVlmQnBvZUozemlZd25O?=
 =?utf-8?B?RkNlbjFJbnkxc1FvTGdGb2ozZVVGOS9hS2NvQk9ZbU5jTTkyL2JPVnZOZ1Jn?=
 =?utf-8?B?b2s0YTIwYXd4OWtYT3dsd1Qxd0tHZG1Vcm9FWmFYR0MvSmVkWDE5ZWkzY3E5?=
 =?utf-8?B?VGpXcENYUlpDaXp4M3BlbmIwSE5GcjNGaVErOWg5OVZzR3ltd2lTcjY0Y0Rz?=
 =?utf-8?B?VFlwNnFwWThjZFFPU1dER0RyTzZLRHd0Yjl4UENROFdQVjZya25XSGVBWVNy?=
 =?utf-8?B?bUk1VnN1VVhORnREdTg3OHd6UDNTQU9BdDRtQy9vNjZVZkZTeUNIWUxvMHZu?=
 =?utf-8?B?SGxzY09XN3ZkOHo5TVEzT25zVEdlUXpna2xVaUlEdnRFV3hheUJhNlJRbnEv?=
 =?utf-8?B?L2lLakRuZHFweFh4c2Q4azRDUnovU2d1am4yKzByT0hxRm1yY3BzVFlTdUlX?=
 =?utf-8?B?bmRmZkFtQm1oMUl4bGZ3QXhtcm0wMVNIMy9CR0tUYjRHZGlyeGRsSG4yWFVU?=
 =?utf-8?B?YmdhKzRkc25YSFFuQUdNMnRDcWg0NVRiYUdBMzR3YXBRdktwbUEzcEVJQnRF?=
 =?utf-8?B?cWVtYUJBYlhHblYxMzZPUFFoUU52WVFsUVNFTVpqSVRPOWZHUlQ3RFJKdDNM?=
 =?utf-8?Q?ceAmIsJnCPSr2daOv3aMJHQkU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c4145f-20b5-4a7f-d271-08dbbe0d5398
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 21:21:05.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WdgvMY/iBs3oqB7jbSr89iTB6kQB8YUV776wC8pKBktB7stqMGA59yfvsrbMI+Z0whoLqAlREUIkefQJYDslqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5008
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/23 15:42, Babu Moger wrote:
> In x86, hardware uses RMID to identify a monitoring group. When a user
> creates a monitor group these details are not visible. These details
> can help resctrl debugging.
> 
> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
> Users can see these details when resctrl is mounted with "-o debug" option.
> 
> Other architectures do not use "RMID". Use the name mon_hw_id to refer
> to "RMID" in an effort to keep the naming generic.
> 
> For example:
>   $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
>   3
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
