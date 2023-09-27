Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8A67B0ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjI0WUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjI0WUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:20:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322D9FC;
        Wed, 27 Sep 2023 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695853228; x=1727389228;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AipRmiDWBFjOtnos1jsXeCEGZTOFc2t6cmuKMrvvXgo=;
  b=IBHQOrC1kgYRWmfLbwjnZfzzUk7CyFDkmObmcD/88NPl/cRX0Ek+7Rm2
   TAPc1CeVJo8333ec6yqrC1mp1N17p2K7VsuQgySNu1J8HAMvPUOhTnKxS
   yogphUjZPMrGMStd4S6B49PQL6CULGxxRd6+LjjfNS8nhQMqlkG7mW/BW
   IRtEhCGHcaLSOBxFfP7wIKdCN54ZM/Wa2yPeqdSwcuEcfOl3IxJQg9C8h
   is8SQYBbLyuQGfNnoW6/qC8cel/xqVa6QiHxVtfNNYGdx9211COul8mKS
   PX1/2p5AWuHN7S/eSHO4tPYYH00EeIHZyOKxWy7Roe/rM0iS8c4k6tcgy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="468224678"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="468224678"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 15:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="752753317"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; 
   d="scan'208";a="752753317"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 15:20:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 15:20:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 15:20:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 15:20:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxKzhPUwVX39qX2Xelwx/HQrySya2yhZlSB40zCD3oiv6DdQi/wW2KLWRv5go22voc6tq2uj7Mj7Dmm5nZVVCrIvnmsbWecIc4Yw7r+3TZ9cJ69OP0Nt7HxmNzQ1mB2AYg1EmwxTAtn9vYOMYH6rijCpZYDKukhSH4h/J+iP6Q2XyXzhZfAUqpErukZUv0qahCUNiCAwF7LVg3XvXOv0vKqoXJfAsXfFxGnogUB1kOYv9tjzXBHJRoXWQ3o4RZ5YJu+pIuT6suxoCBp2ugM1bwtmSPzQ6CTXNBeMQeZ0jvPwBs1WaNZGK/AwBlWEByiPbAru2bRoi2iQCGwgPR/23w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsIwOMNXlo4tCTWjlFnNWNMOf/EYuo1Ww1jmQPdIM+k=;
 b=n/n/MoSqpepoNsEOxXyos3wefVZR8fVL2Gf1J2NYqhm+qkLflLbQ/dm+Nf9HgsGxPQSoWF2Gatg/Sx6yNomq3pMAu7ZZZYUwE/izJGwjevowK8hN4z3jyHndI9Ksmc8s2JTPYXNUMskxDOZvSMUJvX3E5qf001Wxna3wizbm9CQVLo9bNByOiJ5YhKhJUmW/Y24jRW0eUieu5NToOC+2erPwH7gkSwivtFP7VRIVf8J4F22RZLg9IFKDs+iY1ETtOCl9pag0H/7W9dJRqgMQlIYzuYW2z9NpymJUQwBzsR2zt2SxeziQhNRoMl7tg9P8MxFL6MLnsP8atEbywEDRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DM4PR11MB8225.namprd11.prod.outlook.com (2603:10b6:8:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 22:20:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 22:20:19 +0000
Message-ID: <635364f6-fb75-b9b3-d230-78eb62d77b9c@intel.com>
Date:   Wed, 27 Sep 2023 15:20:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v10 01/10] x86/resctrl: Add multiple tasks to the resctrl
 group at once
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
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-2-babu.moger@amd.com>
 <dc1281bd-68ce-18f8-e4fe-d2d07535f047@intel.com>
 <c58a017d-81ff-a797-5b3c-af5a016319bb@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <c58a017d-81ff-a797-5b3c-af5a016319bb@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:303:b5::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DM4PR11MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: 211a7295-bfcb-4fea-0233-08dbbfa7eed7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UDOoCusOwWju8R5kDCLJqVNzwWzzYT2VYqkkB5wvwLpJhs2H5/s7krF7svJUbz+er7j26+h6iUFU59uakvlSdt/rzoUEWOPxiIZXkZPyMYq5Mi1mv9wYplAXCA9MV4EUdXO3uCRD/Sgbnr0mpI02hX3ljlZNUMl4b3XxJuCmC3O8bTC6JaHuuEb1vdWOPA9LF31gwiom8PTTpuIjQyk79HWxFogXirfSqHbprVK6zPLQCTRt01ChBOy8fpph04qEigRjh6Mnm9pY1USfK2/gXqN2tGxYenSP+AM9ElE9Rtf8FqzxuRBTRtBMs8BID8dbaNUvDpuLaWx8WgwE7xDsKwR3MAlQbrqgPAcoZ0cei1BnLmm5QmU57Qa7fWQ7JJZlqhsp0Q0/eXgSVqtup6cmWmeKkTNKd60HjeOAzveD2XUaT63W6jovfC8GhkHZK/ROBYFf0dBKOJGZDm8pyrDWjkuJ+eQ6vnW09RhImEa7J/xDPhBOyLPuaEQWFtyU7r+GGxyKMuDu4OJQOyPGVGXCjgNnu1p1qGSNTMFUb0v6Afe9zPjOHdOZ+fFvJWZZi4lF0N6ASePxfR4itsd7WtIjO6AovlFYe6kQk6krVh6s2fqrpP8Ez1vH91fQ9S5LUKxEsjTFfOeDeq5wK18IP6DLYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(66476007)(83380400001)(41300700001)(316002)(8936002)(8676002)(4326008)(478600001)(6506007)(6666004)(26005)(53546011)(6512007)(66556008)(2616005)(66946007)(6486002)(7416002)(7406005)(44832011)(38100700002)(2906002)(36756003)(82960400001)(5660300002)(31696002)(86362001)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUx1TUdNcUhyalRFUll0R2dhQUoxTWgvRCs2UHhyVzY3WDU1UENZb1ljNXI3?=
 =?utf-8?B?WlV4N0EzYmRZemQyY3NJa0VXU1FFTzZ1V0wwRFR5RmVMNk1jT1gyRDBpMlB5?=
 =?utf-8?B?Vjg2OWNQMUo5d09LY09Ka3V3dUU2dlpXR0cxckhFVDV5TUh6WGtueG1aTDRh?=
 =?utf-8?B?QWxKSWRZZS9IK1F4YUlOcTFkVjBGZ2FCakIwWmdGOUNLM3dyY1BraU5vY2VB?=
 =?utf-8?B?WDhMUWFLK0RjdFoxVVBXSDltU054V3NZT3FlSk5UZGVzT3F5cVNSZTlQbHpL?=
 =?utf-8?B?VFpMa3dIMlRRTzZUek9RTWtRdks0ZXRQMnBUTVRGaTdOcUtWUkY0d2FMZEE5?=
 =?utf-8?B?UjMzU2QwMUJUaWJJS2dJWDdOL1JaeFpsOTZxZVFFdmp3SHdCODkycDYwQlFH?=
 =?utf-8?B?bGNmVGx0MnVjSm1pNjFKMUZldHdza3cyKy9IRlNJS0U4dkdBd3lyVVp1Y2ly?=
 =?utf-8?B?MHJaL3BEaGJmS3l1WHRRWVlvRjdGcTV3Zll6VTVVcmM0eno4UW1LcUxCb0pJ?=
 =?utf-8?B?MDdtNG5XREdTSEMxdXJvbXdtdFowckJscWFYcjhzMGZIVEowSmFmRllMbkNU?=
 =?utf-8?B?MUpueGloZkFTRzJNaDFtVXFVNUxqeGZHVGhYY1FUSDBtZ3VJY2J2UzRzY0Vl?=
 =?utf-8?B?cEVRQUZvYVVZVmI1dzhXOXZYYjRONU5pdHJWdUszVTFYWW9NVXFyY1JtRDkx?=
 =?utf-8?B?V3NCQiswVjJIU0ZpR0h5MXNOdURESTF2eDk4RDlJL0dqZmwvbzhROUtjOS9E?=
 =?utf-8?B?bEFObE5lYnRzK1R4WTc1aEE3VVZLY0l1Z0kzeHUzekNVU1NxUjNzbmJiNWt2?=
 =?utf-8?B?bWFxaU1RaEw4UWhqRVlIS3A3VVdVYUF1WmZTR1kwekwxcDU2b1VlaDhxZUhI?=
 =?utf-8?B?QUNVZlV3MUdTYVlsSllQQW0wTUdYTnVpMXVFd2Jsa2JsaGN3NVp5cjVrRXdw?=
 =?utf-8?B?cXJKa1hjQSs5Q0o2TUVPbEJQQnF5TlplaS94ZWozRjVMUmdsUkk5eEFtTDNB?=
 =?utf-8?B?VXZib1BRdjJSbTFjd0xQWmFZRG5mNzI5ZXIzTDU0M1ZBK1Q2Z3c1N1VES1E2?=
 =?utf-8?B?c1RRQUs1S1R6c3VrUjduYzM5U2dUeGo2UkdMVGlqalJEQ2dBZjdjWE8xMEE2?=
 =?utf-8?B?MTZBNlZaYkJpMnMxRVBJQ1R2ZWlHRXp4Tk5wSHJQa1dPSUJzOWVoaDh5M2x1?=
 =?utf-8?B?Sml1RGlJL2ExUEdpLzlzYkdCdnVlTlF1RGU3UVlqOXk4MWNjam5QZE1RdzNq?=
 =?utf-8?B?N2RHbGlDZktwQjJYWmtKTkh4QUdGNkh4NThYTE9pK1RyOFN6R0FFY2ttUU84?=
 =?utf-8?B?TW5ocDVEOXV4NCtCVVlNKzF5U0xQTnp5UlVKb2hHY0trQ0FzOENwQmdXTkEx?=
 =?utf-8?B?WTcyNllhZHU1U2Y5c2ZicG9GMzhVU3lmU29SNlZBRDhTUnJkZm5wd0pXQjYy?=
 =?utf-8?B?L3U1ZGlXbTdQWDFXQ1VLenlYVGo0SEx6SlZJby9FTk9GYzJwd0s0bllZQTFj?=
 =?utf-8?B?WFNGV0VJalRSSExhSDBtVldKaFJUaFlyOHJZaThIWXdlUXpvRXh3ZE1XaElt?=
 =?utf-8?B?RUFpWXNjZzgyYzM0V2pweGQxbDlVUGQrdlp3ZEhEQWxXbUhWWXVTbnVRVDdK?=
 =?utf-8?B?NW16VGJwNURGQXFwbWhEaUtlZklJME5nYWI2RlNqZTFSVUl3LzBhYWg2eStO?=
 =?utf-8?B?ZzRYa1ZKS1RuNVFkL2VtR1gwVjNqUFB5aEN0ajR2Q3F0ZnFSZ003WlZPaEc0?=
 =?utf-8?B?N2M3RkJPZ1h2NG8vZEZOQlRtaFp0S0lJMkJONStuSnBZWXBRL0puZHE0enE0?=
 =?utf-8?B?NUNIczlkeEdvU3ZwcUFPSU5sRDJRbTJ6VCtSVnd1UkI3b1gxY3M5RlRGQjZ3?=
 =?utf-8?B?QWt3YmpwZU1CZzhQcitndXlCcHYvSFBuamFTSFBlMzhVZFhOUktNZW9wMVA5?=
 =?utf-8?B?M3pYUm5XMGxycnk4WERsWnlFemVmcS9VZEhVV2g2V3h0R1hTRmlOelNBb0lQ?=
 =?utf-8?B?U2hWMnpLNFdmdWhPSUphOUFBNWhlWnRnbFZZR1pkZG82SDRRa3JqeVh0bnpk?=
 =?utf-8?B?eDhVeDhOVmRXWHlRaFY0c1BsVnRBMlV1STBrVHY2dUk0eXhqVlk2aDl6RXpB?=
 =?utf-8?B?Yk9xV1B1bGJaaG5aSXArcXViMkpzeTBLdTN0cHdyRWFnazJ6RllURXk1dWxC?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 211a7295-bfcb-4fea-0233-08dbbfa7eed7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 22:20:19.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjL4HWCSeqqlZr9t1G6WA4pMQuv8gCm1uBLBjeRfdd85KiXGmKy4KhnNe3JVs+cnv0pbtw00BjSYe0JioeSOV8Kbr68D6pW8DQ6vSO9qAMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8225
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 9/27/2023 2:44 PM, Moger, Babu wrote:
> On 9/27/2023 1:30 PM, Reinette Chatre wrote:
>> On 9/15/2023 3:42 PM, Babu Moger wrote:
>>> The resctrl task assignment for monitor or control group needs to be
>>> done one at a time. For example:
>>>
>>>    $mount -t resctrl resctrl /sys/fs/resctrl/
>>>    $mkdir /sys/fs/resctrl/ctrl_grp1
>>>    $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
>>>    $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
>>>    $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks
>>>
>>> This is not user-friendly when dealing with hundreds of tasks.
>>>
>>> Support multiple task assignment in one command with tasks ids separated
>>> by commas. For example:
>>>    $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks
>>>
>>> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>>> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>>> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> x86 area aims to have a uniform view of commit tags.
>> Please review the "Ordering of commit tags" section within
>> Documentation/process/maintainer-tip.rst and apply that
>> custom to this whole series.
> 
> After reading it, it appears this should be the order. starting with Author SOB. Hope this is what you meant.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 

This matches my interpretation.

Reinette

