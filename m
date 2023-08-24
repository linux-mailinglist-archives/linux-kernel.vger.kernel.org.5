Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009D3786435
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 02:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbjHXAFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 20:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjHXAEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 20:04:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2530BA8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692835484; x=1724371484;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SvhZdU/qUsysMywB5Ivo/eOczMJF0cO0SgmrZEB3prg=;
  b=oKBtP1xJZkijE0JhouC9plcEqPYN4CZl+pClI4ZaknxHFur1o5WqT2jr
   WMOhnNzbFdmRtmH6qLq0L3MirCfDcvEgh1FPTq/f16nBvd/JX3pwUf4Co
   D96FICY+ZbmrPA3nSyGDDnyTsXGzuV15VRrHKxYa8Eb/p1ZiA26YtS3WT
   kF71VtSljD9+DIW4sx7w1e1quXLiGx7JEqSi/aXrVWOhFZ3XzUhfaQRz+
   iUzqmsBfsJC6viQuuIFc+BQcIrHJ/cheHvHADi/jJPF1IKCpzWAxj1+Q7
   mWqcFv+uVKxXM6vkRO8Jbxp6q4GeZ57VyZYe1zDqMcYW3X9xkiiHYGuEJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="378057244"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="378057244"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 17:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="739973669"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="739973669"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2023 17:04:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 17:04:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 17:04:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 17:04:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEIXpTaI2ktKCz69vTP0Cn0thnFCLPgi1XxOR+jp9iLtGLXyX/pfJPhnH+YGBgdXsYeLDyzyzfHfsu3YK2nln56SWHZbaXsfxVcuLAcXCMvCaFNPfSldQfKD1p35J8WNDdlKH9AzpCbA5XtaCDUmWHfwZSCu3wRAR3P+NPmMpiGjlEpB7ovsByjX+o78SZgvw+6ltdmPtMz74MCTJJtVsSyr/TmC/Ia7w81wbwNX+WBuGFrEzbmjzN3doTM7X7LOGUABd3IT9kbFv7AgaXf/1ohEb+ZcH+XEe25N4E70kxEuiKe1mhD+C2SBa9QB9o3UT6/4u4OGkCAY+R3nGzW2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKf29dBLDibkKk8Qv7a5Tiz5joemmAyT8bFkPwnOnc4=;
 b=GREbGvgAZkm2UuOKivOarC7fXtNq15YHk5kwKE3FMHEtdoTTWeIQ5ZW+/hbXRi/n93cCunBiQeZoFq/eDcZTpcmhelVBXd+NGjMvGpMI78epWdtiZMZlXQuo4mEKI3Aydu1YMH68iCsmXW8nYcVScJo/aXW24QwevqCeRSG3SXZs+fBBD7RE4ATQ+WnReb1YWDM0iSLGMnjUq1iFxeOQAd66O5xIfSmjsL88G/jrUEWLtvUixB66aUB7bHg8EjJ78qll+KmkDfPdEIJbF3Ys9kCitSII671dww/OyEFG/c+XXggqarOrB+q6jKQ1MDARH0bafvthhAOy4AVQnZ7wBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by PH7PR11MB6793.namprd11.prod.outlook.com (2603:10b6:510:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 00:04:34 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::d5b8:c389:3c2c:3fee]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::d5b8:c389:3c2c:3fee%4]) with mapi id 15.20.6631.046; Thu, 24 Aug 2023
 00:04:34 +0000
Message-ID: <ebae9a75-c465-9385-b502-39e5a7eee436@intel.com>
Date:   Wed, 23 Aug 2023 19:04:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] x86: Use __fpu_invalidate_fpregs_state() in exec
Content-Language: en-US
From:   Lijun Pan <lijun.pan@intel.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
 <9e9c629f-eab0-6643-4e47-0a4b39e2a3f8@intel.com>
In-Reply-To: <9e9c629f-eab0-6643-4e47-0a4b39e2a3f8@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0041.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::18) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|PH7PR11MB6793:EE_
X-MS-Office365-Filtering-Correlation-Id: f2b0d63c-4947-486b-9c8d-08dba435b1ff
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tg6iP2HCYxAjTtnvgJ+u/eDKcb9fLoIR/LpozIrRNf6MC0YoweSIcD4SUtObTanOGCBQrz0dyyNHI4zkzUCEk8yFq3pubVM0RmUWnCJjSqZkNJekGHtAHwrBtaV4MoCjOKXoMf4VzB1ee6S31qQSq5+yTEdR16g82y3W9l/VAypXmsQcOp+84hh5llmxT/ZJQYKaOijWqCBJYBktF3HUzzKCf1vuE47anuKBfg2yg1iecHgiMFS6YQWQm0khiWxcFJnURFRbAuM/k8jpFtTgMNGS8O9PrrRmG1ivtGUY5urfU3+eQDvSSuyA3BcJs0jd/KZ8sxLhiPeSyN2wR+wTPuTGBkUJXfkJ7xeQ65VCUSH3WLQXPsUkL3J50RajxNUvJ+EkNfNItliCSgobOADMcKJs4O4R2AWRuZu+klZMbHNCac6QeeOqlRoG4yUMiziFE5lfV6t2SKhot94oJY+0HJkLHkb2ynCKnJMLcyH3cj2k0zfZEAijt1sFZYZIGAKul5+xkkKuDKdcKwAoa7hH26GDEz1+E1YYD3YT7U/dcICjymhjfO0kFcEE4ugBBUcYj8S5qZA2UV8r1E73vyT8Rdn86+YaH5vd32ji0gif2yhncKTMHPNO0Sna8hfRFs9l6z4dHQSV5erYOad/CsqU7iwkiAnHy3AitOUnPUIGqT+8JN3wDeDIkUEd0gbKaXz3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(66476007)(66946007)(6512007)(316002)(66556008)(82960400001)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6506007)(53546011)(6486002)(83380400001)(30864003)(2906002)(31686004)(31696002)(86362001)(44832011)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEdxV0N6eUtib3FncFM1eFZEMGRqV094WWZZWWJDdVpDcWNmRXUyam1jS3N6?=
 =?utf-8?B?VDBTVjRxa2V1TDhXbkgxWnVkYmdFMU9GWERPdHI5RGZ3OU51MmhzTGRhZHdN?=
 =?utf-8?B?cC9pU3MrM3hvMlUxQTdJSDlaVXhOSWU0SlpORmJUUmdFZndtQ1Zvek15UTMr?=
 =?utf-8?B?QWhWdGlDSDNuL2ZjcTNnSFJrallDVm9iQ3ZJdEZIYWcrWENaNnBGRXBLbzhL?=
 =?utf-8?B?MGEvR3JObzFyMmU0RFVxZDNaTVlFMS9ab2JBUFRpRlBZeUNjZHQwd01VVWNa?=
 =?utf-8?B?OEZTWWR4SUxiWTYxQWdpUkpDL24wY3BybVMrK1Vvc3daalcyclduc2dMc2Vo?=
 =?utf-8?B?OGo5c3NxTU1nQ3VQdU9TQ1ZnZ1A5eS9FZ3o2K01hTW5UaEFFRHA1dTFXenRS?=
 =?utf-8?B?RSt0MFBla0JOVk8wUGFVNDd2REZZQU1TQ1MxaWF4Nnh2aW5KeU55a1JENXN5?=
 =?utf-8?B?UEJ1YTNYTm51RjFTN0RnaE1MR0xSQ3RpRHBBRzk0NlhneTU0a1RvNHNYZ0tB?=
 =?utf-8?B?bHJlK2Fpd2xQSUhGanJZRlYxL2JjN3Q2OGlLUnNkWmRzdmJlSmNmL1dKRzd4?=
 =?utf-8?B?SW8vaFN0eHJ5OGhzNTVVb0xpT09zNllwOVc2WVVCVFU3KzJ4QU5kZzJuUDZu?=
 =?utf-8?B?T09QTG1ZUENTQ2hPdnhqSW1ZVXRhRDFlZUZiWmNyVlJ4Tzc4bUxZbjNDOWNJ?=
 =?utf-8?B?dndoeHFXRjhtM3Fubm5LZnR2QXhDYkxnOE41akZBRFE5Slp3R0plS1pRNEZx?=
 =?utf-8?B?TjBwbDJYdE5vcnNIMmozU0VTNjdoclVEa2hvcHYxVXptZ1JaQUVzNE1WcTFP?=
 =?utf-8?B?RUsrSU9uclgzLzVuR1RlNHc0SWxkRzZ6dEpwa0xjRW5TWjBaVDUwd3N6SWYv?=
 =?utf-8?B?S2kxTWk0Z3JNRkhjNDdrRGFmaUFscU1DWUx6THVFS2JUbkUxSUNGU3UzMnlY?=
 =?utf-8?B?aVlTNS9KbUR1YzRHMjZsT09UVXZHQm1sRlR5MmNmRGhRVGVBbG9aVlZTVGVT?=
 =?utf-8?B?WmYyZEpmeHBwL0RFZ0dnRDZOdVlVSU9XeGZRVFBpeEdyYmpkRmxpSWp6Qy9a?=
 =?utf-8?B?TTZSWnZMZHhaeVNidkRoUnQydW9zdjFIVlFrWkp2TXc3VVBDYnZCVFh1Nnp5?=
 =?utf-8?B?QXFuQ0Jod0ZxUnhCSjZ6OGw2M3FNUlNDbUFpRmRTeXpPWjFaMlJGcEMveUJZ?=
 =?utf-8?B?NEl4Z1c1U1ZWOWpGSXllZHUrVnhZR3lxTW9HQzlUdWUyWU1ob3RkbEczM0h1?=
 =?utf-8?B?NlZIMXlxRjVxZHN5Rk5sTDV0OWMyOEM5WHcvMWNUek9vL2ExdkJxRDdWSU9n?=
 =?utf-8?B?ekRrc1FBd1VDVVV0QUg3MHBWTCtaQ3BIcGNJcFZhRTZiSFlMSnFFQTVEREpP?=
 =?utf-8?B?TU5UcXoza1BRMGFyZTRMRWFLcnBpUVc5dUZwSFVCQlllekx1N0Q2SnVibXZ2?=
 =?utf-8?B?aG9Kc2c5M3ArSThEWFBUaGVJUExrQVN0S2xzWnBPRHdLYXFPMi9XN3dWK21s?=
 =?utf-8?B?ZjYwRFBBRHcwYlFYU2lFVi9WdjNMOG9QSlZWdVAzSUtTZER6YlY3ZDhFT3BH?=
 =?utf-8?B?SUxVdkgwbVhEd1hOUERzWlZhV2NibWViQ1RZYis5dVA1NVNDemlCaWZ6V3Zv?=
 =?utf-8?B?OWZweTgrRjlPc3JpNXZBM2lhS2w4UDMvVVV2NTN5eTRMekp2MHFyRHFldkl1?=
 =?utf-8?B?blJyeDBCUDdFMnpCT1A4b3Q1NkFSM2xxdUdMOSt1S2VybnFBSDJPeEtRdW1m?=
 =?utf-8?B?ci96aVgzWVk4aDkwZTQ4elJsZmZ5aUpuNUprK09acmRDVnd6VmpCRG53ZGdY?=
 =?utf-8?B?N1VKSFMvZ2NQODYwN0crVmpyblNEZ3gwTTVIaXcrdVV0QmhQR0ZUNFg1TTV5?=
 =?utf-8?B?cEFkR2lNMWhmMDdVV3QzclFTemgxeHUyeXAwcHZGZHhuN2lxaTVXMmc1a2xM?=
 =?utf-8?B?dWZMby9mc0M3S1hnKzcxWUpUVDlUNkJSeGxUR1RNUkFzOXMzUDV5bmRlb1ZL?=
 =?utf-8?B?YkgxQ0Y4MHJYaU1oN3dNbThjOVcxUHJrWUx4Qkc3SXJYSlc4ZkdVNDdNNlNN?=
 =?utf-8?B?UGlCWCtuMldJeTJNeWk3aHBkNE9HNENIZ1VQNCtyejczaHZLZXh4dWRsb2d4?=
 =?utf-8?Q?YJj29NsZnvoU89zK+DpCO1AGD?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2b0d63c-4947-486b-9c8d-08dba435b1ff
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 00:04:34.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQ5k9bwzdTRKdgZZEN75ZByTTiP78heEPf3hON3gDaOf1jorv1lU8K+/gdE1xq62Hcof1QwL3ssGUJZvDS+KxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6793
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2023 2:35 PM, Lijun Pan wrote:
> Hi Rick,
> 
> On 8/18/2023 12:03 PM, Rick Edgecombe wrote:
>> The thread flag TIF_NEED_FPU_LOAD indicates that the FPU saved state is
>> valid and should be reloaded when returning to userspace. However, the
>> kernel will skip doing this if the FPU registers are already valid as
>> determined by fpregs_state_valid(). The logic embedded there considers
>> the state valid if two cases are both true:
>>    1: fpu_fpregs_owner_ctx points to the current tasks FPU state
>>    2: the last CPU the registers were live in was the current CPU.
>>
>> This is usually correct logic. A CPU’s fpu_fpregs_owner_ctx is set to
>> the current FPU during the fpregs_restore_userregs() operation, so it
>> indicates that the registers have been restored on this CPU. But this
>> alone doesn’t preclude that the task hasn’t been rescheduled to a
>> different CPU, where the registers were modified, and then back to the
>> current CPU. To verify that this was not the case the logic relies on the
>> second condition. So the assumption is that if the registers have been
>> restored, AND they haven’t had the chance to be modified (by being
>> loaded on another CPU), then they MUST be valid on the current CPU.
>>
>> Besides the lazy FPU optimizations, the other cases where the FPU
>> registers might not be valid are when the kernel modifies the FPU 
>> register
>> state or the FPU saved buffer. In this case the operation modifying the
>> FPU state needs to let the kernel know the correspondence has been
>> broken. The comment in “arch/x86/kernel/fpu/context.h” has:
>> /*
>> ...
>>   * If the FPU register state is valid, the kernel can skip restoring the
>>   * FPU state from memory.
>>   *
>>   * Any code that clobbers the FPU registers or updates the in-memory
>>   * FPU state for a task MUST let the rest of the kernel know that the
>>   * FPU registers are no longer valid for this task.
>>   *
>>   * Either one of these invalidation functions is enough. Invalidate
>>   * a resource you control: CPU if using the CPU for something else
>>   * (with preemption disabled), FPU for the current task, or a task that
>>   * is prevented from running by the current task.
>>   */
>>
>> However, this is not completely true. When the kernel modifies the
>> registers or saved FPU state, it can only rely on
>> __fpu_invalidate_fpregs_state(), which wipes the FPU’s last_cpu
>> tracking. The exec path instead relies on fpregs_deactivate(), which sets
>> the CPU’s FPU context to NULL. This was observed to fail to restore the
>> reset FPU state to the registers when returning to userspace in the
>> following scenario:
>>
>> 1. A task is executing in userspace on CPU0
>>     - CPU0’s FPU context points to tasks
>>     - fpu->last_cpu=CPU0
>> 2. The task exec()’s
>> 3. While in the kernel the task reschedules to CPU1
>>     - CPU0 gets a thread executing in the kernel (such that no other
>>         FPU context is activated)
>>     - Scheduler sets task’s fpu->last_cpu=CPU0
>> 4. Continuing the exec, the task gets to
>>     fpu_flush_thread()->fpu_reset_fpregs()
>>     - Sets CPU1’s fpu context to NULL
>>     - Copies the init state to the task’s FPU buffer
>>     - Sets TIF_NEED_FPU_LOAD on the task
>> 5. The task reschedules back to CPU0 before completing the exec and
>>     returning to userspace
>>     - During the reschedule, scheduler finds TIF_NEED_FPU_LOAD is set
>>     - Skips saving the registers and updating task’s fpu→last_cpu,
>>         because TIF_NEED_FPU_LOAD is the canonical source.
>> 6. Now CPU0’s FPU context is still pointing to the task’s, and
>>     fpu->last_cpu is still CPU0. So fpregs_state_valid() returns true 
>> even
>>     though the reset FPU state has not been restored.
>>
>> So the root cause is that exec() is doing the wrong kind of 
>> invalidate. It
>> should reset fpu->last_cpu via __fpu_invalidate_fpregs_state(). Further,
>> fpu__drop() doesn't really seem appropriate as the task (and FPU) are not
>> going away, they are just getting reset as part of an exec. So switch to
>> __fpu_invalidate_fpregs_state().
>>
>> Also, delete the misleading comment that says that either kind of
>> invalidate will be enough, because it’s not always the case.
>>
>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>>
>> ---
>> Hi,
>>
>> This was spotted on a specific pre-production setup running an
>> out-of-tree glibc and the x86/shstk tip branch. The symptom observed
>> was a shadow stack segfault in ld-linux. The test case was a kernel
>> build with a high number of threads and it was able to generate the
>> segfault relatively reliably.
>>
>> I was surprised to find that the root cause was not related to supervisor
>> xsave and instead seems to be a general FPU bug where the FPU state will
>> not be reset during exec if rescheduling happens twice in certain points
>> during the operation. It seems to be so old that I had a hard time
>> figuring which commit to blame.
>>
>> A guess at how this was able to lurk so long is the combination of two
>> factors. One is that this specific test environment and workload seemed
>> to like to generate this specific pattern of scheduling for some reason.
>> So the fact it was reliably reproduced there could be not be 
>> indicative of
>> the typical case. The other factor is that CET features will rather 
>> loudly
>> alert to any corrupted FPU state due to the enforcement nature of that
>> state. So maybe this FPU reset miss during exec happened less commonly in
>> the wild, but most existing apps can survive it silently.
>>
>> But since it's still a bit surprising, I would appreciate some extra
>> scrutiny on the reasoning. I verified the FPU state was not getting reset
>> during exec’s that experienced rescheduling to another CPU and back at
>> times as described in the commit log. Then following the logic in the
>> code, failing to restore the FPU would be expected. And fixing that logic
>> fixed the observed issue. But still surprised this wasn't seen before 
>> now.
>>
>> Thanks,
>> Rick
>> ---
>>   arch/x86/kernel/fpu/context.h | 3 +--
>>   arch/x86/kernel/fpu/core.c    | 2 +-
>>   2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/x86/kernel/fpu/context.h 
>> b/arch/x86/kernel/fpu/context.h
>> index af5cbdd9bd29..f6d856bd50bc 100644
>> --- a/arch/x86/kernel/fpu/context.h
>> +++ b/arch/x86/kernel/fpu/context.h
>> @@ -19,8 +19,7 @@
>>    * FPU state for a task MUST let the rest of the kernel know that the
>>    * FPU registers are no longer valid for this task.
>>    *
>> - * Either one of these invalidation functions is enough. Invalidate
>> - * a resource you control: CPU if using the CPU for something else
>> + * Invalidate a resource you control: CPU if using the CPU for 
>> something else
>>    * (with preemption disabled), FPU for the current task, or a task that
>>    * is prevented from running by the current task.
>>    */
>> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
>> index e03b6b107b20..a86d37052a64 100644
>> --- a/arch/x86/kernel/fpu/core.c
>> +++ b/arch/x86/kernel/fpu/core.c
>> @@ -713,7 +713,7 @@ static void fpu_reset_fpregs(void)
>>       struct fpu *fpu = &current->thread.fpu;
>>       fpregs_lock();
>> -    fpu__drop(fpu);
>> +    __fpu_invalidate_fpregs_state(fpu);
>>       /*
>>        * This does not change the actual hardware registers. It just
>>        * resets the memory image and sets TIF_NEED_FPU_LOAD so a
> 
> 
> Thanks for the patch. Let me get back to my server (offline now) next 
> Monday and will add a "Test-by: Lijun Pan <lijun.pan@intel.com>" if it 
> passes.

I have run some relevant tests (compiling kernel with high thread amount 
repeatedly, make -j 256),
glibc tests (https://gitlab.com/x86-glibc/glibc/-/blob/master/INSTALL),
fpu & cet (ibt, shadow stack) test (https://github.com/intel/lkvs),
and not yet found regressions.

Tested-by: Lijun Pan <lijun.pan@intel.com>
Acked-by: Lijun Pan <lijun.pan@intel.com>

Since this problem was first reported by Lei Wang, I suggest adding:
Reported-by: Lei Wang <lei4.wang@intel.com>

Thanks,
Lijun

> 
> In our bug case, probably just switching to
> __fpu_invalidate_fpregs_state(fpu) from fpu__drop(fpu) is enough.
> 
> Maybe there are some other cases that need
> __this_cpu_write(fpu_fpregs_owner_ctx, NULL) through fpu__drop() call, 
> which I don't know.
> 
> Here is the excerpt of the call sequence:
> fpu__drop() -> fpregs_deactivate() -> 
> __this_cpu_write(fpu_fpregs_owner_ctx, NULL);
> arch/x86/kernel/fpu/context.h has
> static inline void __cpu_invalidate_fpregs_state(void)
> {
>      __this_cpu_write(fpu_fpregs_owner_ctx, NULL);
> }
> static inline void __fpu_invalidate_fpregs_state(struct fpu *fpu)
> {
>      fpu->last_cpu = -1;
> }
> static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
> {
>     return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == 
> fpu->last_cpu;
> }
> 
> So, I am thinking if it is more rigorous to have both 
> (__cpu_invalidate_fpregs_state, __fpu_invalidate_fpregs_state) 
> invalidated, similarly as fpregs_state_valid checks both conditions.
> 
> code changes like below:
> diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
> index 958accf2ccf0..fd3304bed0a2 100644
> --- a/arch/x86/kernel/fpu/context.h
> +++ b/arch/x86/kernel/fpu/context.h
> @@ -19,8 +19,8 @@
>    * FPU state for a task MUST let the rest of the kernel know that the
>    * FPU registers are no longer valid for this task.
>    *
> - * Either one of these invalidation functions is enough. Invalidate
> - * a resource you control: CPU if using the CPU for something else
> + * To be more rigorous and to prevent from future corner case, Invalidate
> + * both resources you control: CPU if using the CPU for something else
>    * (with preemption disabled), FPU for the current task, or a task that
>    * is prevented from running by the current task.
>    */
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 97a899bf98b9..08b9cef0e076 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -725,6 +725,7 @@ static void fpu_reset_fpregs(void)
> 
>          fpregs_lock();
>          fpu__drop(fpu);
> +       __fpu_invalidate_fpregs_state(fpu);
>          /*
>           * This does not change the actual hardware registers. It just
>           * resets the memory image and sets TIF_NEED_FPU_LOAD so a
> 
> Thanks,
> Lijun
> 
