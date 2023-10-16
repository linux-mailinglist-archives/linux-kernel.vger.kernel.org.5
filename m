Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807947CB4DE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjJPUq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjJPUqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:46:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169BDA7;
        Mon, 16 Oct 2023 13:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697489212; x=1729025212;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jWNC44PjJekmYoP9qNTKNOtUAYXt6HTomi3f5rtSwoE=;
  b=a3y7bhyNZaklVhuGPhAe6LVJTBbDTRxIyLuq34gKjMKbMxiZDRmA16gU
   Jvz+61N3do/Fk6jJ2IA9v/CsPys4HR9sG97ZUEYz7IABfy9EvVPImWE4N
   ZLhnbDs5PNEbA06ziPZSrALzKXMR5aH7lBET3VRkYCf8Zo5/AGtpJnzxY
   tjbxLM6d+T86+o1iV7n5vFVQMw7FG09/tmX30ubXILgoU7W2rcZstHvoC
   6Ztjw4RQSm+PfbU/+sZLkhfsAvBKujON/+FtJTn/jsEarQpKUOtZBJv3/
   CkGypwXEgcnjgOyTgFbx6qP3k3VVh/v1vtpSr/pf9sAFLNWaBUQEy5JZQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="376002114"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="376002114"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 13:46:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="872256696"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="872256696"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 13:46:50 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 13:46:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 13:46:49 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 13:46:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nm3lkB/PGMreh64iGDIocFQa/pWPHGp1rvkQ7TgJzHWmf5la7yXgccYuqWxPkUy/vaBkGpP7wLVF8kp+lOAEaZ9eB1K5chi1sKLQZLjBoW/S4169Xl5TMSzc5bkpCwwAFk4C/Acikedtvv6gGYEhuDTSfdKyLqET6oqLqjI7olFdNhnqfUTTPsFu3V/gzTfRDpRBOhQ1YrzGfMhvkMmYaAiDx9/5PNiiFCHiijzqoTmgbBZZ9v/PpeDf9R6aF2LP1X7n4pv3JCLrxvls5xdaR2RVbp1IwM0gnzPfuMwIZHlwTT1LrqkGzkSR8UKvAlKiNIgbwb0Z62zIZ/PkKlDCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcGyQeMjLxS1vA8tCJHS4nfHcJ+DPPCvLN09h1KXtFU=;
 b=kX7jLZCVW3aZ80lqxqwHxJw1C9i0OE7TPMjw3h2109gXTRDuZkse2TWtM2HF9AsSPnueFIexlwAgCKF47Xs33pasnuLxmYEGzqRNecj9tNguamvrX4ESbCak9Vgjq0HiBt6vv85lPtOy0JvuWdIzhFfhxLnRzxxKDlCLUJZimoujbwjNEag5wmDJUe49rAS8ZX6fEISZ2hygQT/QhrTCE14JYvlem1qrvwXe2qxqmYRGX66dnF1okN4qBqYPHDOnY1Uz2TafeuHePSnakqPoZypZCbCKwM3v+Jr3t5chzST+IB1eJvyySUzBRZAtMVRsyEoTfBgUVS7erYtFjjcM+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA2PR11MB5036.namprd11.prod.outlook.com (2603:10b6:806:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Mon, 16 Oct
 2023 20:46:46 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 20:46:46 +0000
Message-ID: <2c86957f-9705-4f24-aa43-60d89f636c31@intel.com>
Date:   Mon, 16 Oct 2023 13:46:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
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
References: <20231013202602.2492645-1-babu.moger@amd.com>
 <20231013202602.2492645-5-babu.moger@amd.com>
 <d4a33013-0448-4c36-a168-b3a953024962@intel.com>
 <0acbb031-a84e-1cbc-0857-f087b07a9056@amd.com>
 <299778a6-5ea0-c70d-54d6-1ecdc1b417d6@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <299778a6-5ea0-c70d-54d6-1ecdc1b417d6@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:303:b6::28) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA2PR11MB5036:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a5d747-e9ec-43ea-a3de-08dbce8902e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DG8sI9MiAGFrESCHg0Rd/WHSvCxL5F/Lw3s9QLQkK1rNlPonuQb8bgB3rRpeMogwrwetKdQPz3U6Ha1EwzHpf4jeBTB3y3Kiv46mEb0VKqmVXu3a/s694b0dOUeUt/6h0f0yp2QCUpq/WVvC6AaWc170RK3d9Qt6uSHkrbZPIbcTCMHFEYPPpIi25ATCm/+RwSV6Xr2eVXDY6eltDUrUiSrQNaw2pWSwU+BYxzv6Z1cAAaw30V90bW68BCbNTq+fbL6NxAakEOxHEvAc7mxZdWpDkIcXUFaMLzLgAIIx2azDUUuBbMXlnKqrnQ8oMrJjsB+skCwLfqzbOBOuWkeerKYM8TXpkOZrNYuklBGnr2LRI67e+GbdPs37Ab39p71Q+f4jB4nJAPvanprO2ILQjb1vnaSu7Rl4R8xNXfTauviEIpRwdu5cudPQy/XSrUrVhNy/eHJ/+A/XE6Jd6sy5TnPGUzXREvbrHoFNaaRq1VhmyfZq1shK9cKPVl3bvmHnP7hI0TgHX8ccHygN6r2yK21AUsL5Y68EDw/1BZtiGs1WF1al4OhJNXxasRkj9FB6BxQtkofclVrigzYVWHy8pdQ5uitR5scfu0vjJDOYRw6xDzw8gN+QnqPIdKzHaJNJumpmh1BNpZy7uWP3I0eqVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31686004)(6486002)(6666004)(53546011)(6506007)(478600001)(6512007)(31696002)(36756003)(86362001)(38100700002)(7416002)(82960400001)(7406005)(2906002)(26005)(2616005)(316002)(41300700001)(66946007)(8676002)(66556008)(4326008)(8936002)(66476007)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU5SU2lYUVUwSHZhUmQ3T1VGejdzeCs0NTh6TzRlRVBpRGk5N1dPTTE1bm8r?=
 =?utf-8?B?SnprYkQvY1UweDd4b2RsS0h6V1ZuMk1EV0lSOFhaQzRDeCttcmNZc0VSOWFU?=
 =?utf-8?B?NDAzd2V6elBibEtXRFo1Q3JEU0dGS0NiRVYwcTQxRFp6UnM3WVVpbzVsTDNJ?=
 =?utf-8?B?WERJU1EyN2xhRmZUODhGbFJmbnJYSXpsZCtWM1Y4UVBvR1hhdnczK3RzcXVq?=
 =?utf-8?B?c2FMdGJnRVR6V2hKMEpOZWcwUnphbE9UaTlIM3RJOFhaNmZob2VDcGxzWHA0?=
 =?utf-8?B?TmJRc2crai9OSDh1TjN4dVdMNHBzT2NCSG0weW41RVRrQWFYdWtkbk5QS1U2?=
 =?utf-8?B?R3JKa2hlWWlxRlZ3bmZvRjROR3c4WmZTbG9Ic1VkK3V1NmRyMUQ2ZVA4YnVD?=
 =?utf-8?B?bjI1d2NEUGZZRUpmMjhJRjUra3lxN0p6SWxjVUQ1cWhqclJIdkpqNHJGdFAv?=
 =?utf-8?B?MTNMY2VYdGNTVjZ3YTNCN05NcktMTmFjdTlTc2ZVeXhKRTVzYllNNGI1VG16?=
 =?utf-8?B?Zkhnd2VoZE9DWXFCWWNMSVJWdi9qLzQxOWRjd2FYY3RUUVZFTHdKQzJPODNT?=
 =?utf-8?B?V2FhNndQWlNWd0hFU2thNnU4aUx0eUtwOEZwSThSaVdTSC9CU2dzaTJKTTB0?=
 =?utf-8?B?UGxZdHNncmV1bGg0cFRoeHBVdzl4NmhyNVhPNndzL2V1N20yQnNVM1pnZjVa?=
 =?utf-8?B?bkpvTzR0TlhXekNjZHc1NDI0QS8vWXZaWm1YNWdPeFN5Qjc1bmYxQkcya0h4?=
 =?utf-8?B?MTRXb1dXVXA5VnRkUmxmSnpkd1BNYlY0Sm5tLzE1aDA2VWhnWis5TzZNL09F?=
 =?utf-8?B?bEJGelpvMk53S2Q5U0N3WllQamR0ZXk5R1BZcUlHYTV3emtVU0hwUXMwZ1E2?=
 =?utf-8?B?dFQrUDEwdWtveWk2b1pvQ0JKODJjbU9zYUduNDladzV2RTBoMWRrUGFkQ2Ny?=
 =?utf-8?B?alRPU0NrS0p2OTk2M2g2QkRlVXZMMFFFNkJrZGt2QkFLdzAwbmltTGkxV0Jj?=
 =?utf-8?B?SUdjdEd4UE5MNzA0ZEl2dzBmWDRHbmQrL2M2MlBwenJOeDRIbzV3M2JnRVI0?=
 =?utf-8?B?TWlVMWJuSlkvcG5GVjdDOTFteWk2eHpLdi9tN3ZER1RuaVdnbUhzcERPblVJ?=
 =?utf-8?B?L3JzWXh3M0dQUDN2Vlp0RUw2TnZodjVqck5hV0ZkWmo4a1JYK1QwaXVOSlFM?=
 =?utf-8?B?U3pLMVdzQytLeU1mUmUyelpDWlllZ2FjNS9uWHpVeEgzUGw1TUlCcGczN3JC?=
 =?utf-8?B?QWhFa1hMajE5SjRHY2dJSzNZS3c3QnJoQ3RwUEQxeVU1THc2RXpMTElhT2to?=
 =?utf-8?B?TUtqcnRBU2NPQ1k2L0hsQkxOWGtLcWlPRFRIQXJucGFNc1BqcXRVVHk4Z3RM?=
 =?utf-8?B?eVdUUUFvbC9rbmpoZkVuYi9nSGZjeDE0OUoxM1ZCcEFmazBOTkZSc3FTL3Zu?=
 =?utf-8?B?dnB2bU11ZWlsR0F0ait4ZG5QSExKQVRhTDFKcWxqakFIL3lDQ1RJa2F3a2Vu?=
 =?utf-8?B?OVVwYTVCaFNzYUdVUVo1UlE5aWhRejFOWkU3ZVhxak9NODJmRVJ3S2FUVVVP?=
 =?utf-8?B?Y0JjNy9keG1XN0lWekhLN0h0Y2g4SUpIMnNEb0JoT2JGa3Ezby8vb0V4UDE4?=
 =?utf-8?B?S3dJQm12M1ZqTThiNFNURVQvUGNnU3BIbUIxZC94Q2lqLzNFVmtDdEpPWmJr?=
 =?utf-8?B?Z3RKTWg1SGxINFZ1UW90UWtnTW5lemFlbjIyUi9ScGFzV2hON0RkNEdGU1hi?=
 =?utf-8?B?NWVaTVdqNXcva252UlJYU0xUSUpaZUIrZkVCSDF5dVBhTEVsWFJZeDgwYVRN?=
 =?utf-8?B?VEJnRFY1WEJGTmdadkdmTS85QW9RS3hEbzRQWHJxdHVLVm5VRjl2c2xweFBE?=
 =?utf-8?B?SWZvQVM3N0IxL1FpekRCM3h0WEpYK1lDWXcycERrdVhtNmRaY3N6dFRLajZs?=
 =?utf-8?B?RDBYU3NPQm1GMUVEekMrTjVEbkY1dm45cnNNanZSSlV6Q3FoOWxYUjFZTmtQ?=
 =?utf-8?B?S1NjRmxWU3gvQ2o5M28xVWQxZGUydVF3ekMvQ0oxL1BnV2tHUVIvK2RLUldP?=
 =?utf-8?B?RXM0VXMxRkJtZFpMSE9YekdJNVdsRXlTR2Y2eThNQUJUSjVwU0JrUFg2UTRJ?=
 =?utf-8?B?cU9UMVFqZ2ZDeEZSZ3E2dHhaMk1LSVlXd25DVjg4TDlzbDc1K1BNVUtkMGNR?=
 =?utf-8?B?RHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a5d747-e9ec-43ea-a3de-08dbce8902e8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 20:46:46.2707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQnvMhm5/mfmWs0J24nAzaanZcKAn1zGI2/vDsAg/3npVuLYQa1hJwGrlr/ktxyN3Et2lT7/rr12z3Nycc3ZRlx/vB1ecNjfoOicempioIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5036
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/14/2023 4:06 PM, Moger, Babu wrote:
> On 10/13/2023 4:39 PM, Moger, Babu wrote:
>> On 10/13/2023 4:23 PM, Reinette Chatre wrote:
>>> On 10/13/2023 1:25 PM, Babu Moger wrote:
>>>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>>>
>>>> Definitions and directory structures are not documented. Add
>>>> comments to improve the readability and help future additions.
>>>>
>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>> ---
>>>> v13: Fixed the format issues in the documentation. Needed few minor format
>>>>       changes to address the syntax issues.(Reinette)
>>>>       Removed "Reviewed-by and Tested-by" flags as the patch has changed.
>>>>
>>>> v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
>>>>       to Documentation/arch/x86/resctrl.rst. (Boris)
>>>> ---
>>>>   Documentation/arch/x86/resctrl.rst | 64 ++++++++++++++++++++++++++++++
>>>>   1 file changed, 64 insertions(+)
>>>>
>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>> index 178ab1d8f747..1163da74f734 100644
>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>> @@ -369,6 +369,70 @@ When monitoring is enabled all MON groups will also contain:
>>>>       the sum for all tasks in the CTRL_MON group and all tasks in
>>>>       MON groups. Please see example section for more details on usage.
>>>>   +RESCTRL filesystem implementation notes
>>>> +=======================================
>>>> +RESCTRL filesystem has two main components
>>>> +    a. info
>>>> +    b. base
>>>> +
>>>> +    /sys/fs/resctrl/
>>>> +    |
>>>> +    -> info
>>>> +    |
>>>> +    |  (Top level directory named "info". Contains files that
>>>> +    |   provide details on control and monitoring resources")
>>>> +    |
>>>> +    -> base
>>>> +
>>> Could you please do a "make htmldocs" and then ensure that the output looks sane?
>>> The resulting output does not look right to me. For example, the above turns into
>>> a single line that looks like:
>>>
>>> /sys/fs/resctrl/ | -> info | | (Top level directory named "info". Contains files that | provide details on control and monitoring resources") | -> base
>>>
>>>
>>> The spacing also looks off when viewing this in html.
>>
> I have fixed the all the format issues. Please let me know if it
> looks ok. I will send the final version after that.
> 
> Attached the patch and also added the diff inline.

This still does not look as though you consider how the document 
looks after the changes.

Consider the organization. Before your changes (assume numbering starts
at 1):

1. User Interface for Resource Control feature
1.1 Info directory
1.2 Resource alloc and monitor groups
1.2.1 Resource allocation rules
1.2.2 Resource monitoring rules
1.3 Notes on cache occupancy monitoring and control
...

After your changes:

1. User Interface for Resource Control feature
1.1 Info directory
1.2 Resource alloc and monitor groups
1.2.1 Resource allocation rules
1.2.2 Resource monitoring rules
1.2.3 RESCTRL filesystem implementation notes
1.3 Notes on cache occupancy monitoring and control
...

Note how the "RESCTRL filesystem implementation notes" is inserted
as a subsection of resource and monitoring groups. Since the text
describes all files in resctrl (not just resource groups) I expect
that it would not be buried as a subsection of resource groups.

This addition also ignores existing customs. Nowhere in the
entire document will you find "RESCTRL" (well, except for the
config option).
 
> Thanks
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 178ab1d8f747..e990272e9a4f 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -396,6 +396,67 @@ Resource monitoring rules
>  3) Otherwise RDT events for the task will be reported in the root level
>     "mon_data" group.
> 
> +RESCTRL filesystem implementation notes
> +---------------------------------------
> +RESCTRL filesystem has two main components.

This documentation was extracted as-is from the header file where it
was next to the flags being documented. With this move all that context
is lost so it may be helpful to summarize what is documented here.

> +
> +a. info
> +b. base
> +
> +::

If I understand correctly, instead of adjusting to the target format you
hardcode all the text as pre-formatted? That may be ok. I cannot speak to
whether this matches expectations of the proposal to move the documentation
here.

> +
> +       /sys/fs/resctrl/
> +               |
> +               |--> info (Top level directory named "info". Contains files that
> +               |          provide details on control and monitoring resources")
> +               |
> +               |--> base (Root directory associated with default resource group as
> +                          well as directories created by user for MON and CTRL groups.
> +                          Contains files to interact with MON and CTRL groups)
> +
> +               Note: resctrl uses flags for files, not for directories. Directories
> +                     are created based on the resource type. Added the directories
> +                     below for better understanding. The RFTYPE flags are defined
> +                     in arch/x86/kernel/cpu/resctrl/internal.h.
> +
> +"info directory structure"::
> +

This unexpected. In your previous response you noted that you did not know
how to make it look like a header. I expected that you would read the manual
to answer your own question but instead you just placed the title in quotes? I do
not see how placing text in quotes create impression that it is a header.
There is syntax to indicate section headers.

Reinette
