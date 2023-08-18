Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D1F781363
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 21:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379633AbjHRTgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 15:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355677AbjHRTfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 15:35:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F72421D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692387352; x=1723923352;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uKEGlShBMzXlHg1BIlH0PWUTGS67uwQD/LcddVGEXNA=;
  b=OGt213lWwhlNa4Ugi1DcyYeGgqSNnVt0B0q6CNiGDMCer1KIBjS8SeSf
   vw37aH/IFBy+JAr4VSyVWWQeUotYgH53KBRZTcnK9k6rVBda9QmOo1r6X
   ykrM8JxQ2OJrT4h9CV7udZ6P7pyhJZdoV7wuHdZnoZYfJksCiat3/BIXh
   XHcI+hLEa6IQ431cuB1CLhF1fomNmO/LNY1RnsEbk7eZV3ZwWOmU68ASm
   magin2XwSlZA0YoLNfvkpGZ6H2p+CPToMOEVrs+klgYS7jZP3wRjMLcfu
   cO2gy7rEObdGh8EKNx2EChz43JkrbYyW2hVJLqECHDLxMppVtF3xweRFP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="373158722"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="373158722"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 12:35:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="1065854624"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="1065854624"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2023 12:35:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 12:35:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 12:35:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 12:35:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QvF8163Qzvk/OH2Cm7Diks1Id798Cyloz8rnTwkSXkFdTUfeLRpvMEyfIT+DKiSX4Yar/MAPP0HiaynEV2vjniLyryEbYiPkFSuKxmsqCOyh8ly7SPy4m2yLFEtg6FD5utxbkiCKqZnw5B9yUpN1DJfcWvwi3Rg/SSUvo8uyZD1fTZ6/ZLvebNBfrS/Mr0BhZUyje6cLim/XusVEmanb7zmaD5vRZ2XwABjpOStGyOoaIJWNCikQ3/LHjeHicwBthw9wqCwaX/gynnjdqLi7fJHrQwxWovcn5kJFZrqFSZEtSQgO5+ERIUIwJljgaOsEQBpdCmmye6pniYOy/EzpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQizF7TeQd54Rsg4ReWqbwZA3nveubyrLYLD7CGU3ws=;
 b=Xh7yIaPBgBxuQ79q+R43tWxkeQmxBu/Cu0oyOqLIwt89h+jWxvrwNG7hkltE8Skovb2gBIcvaMFujgypPXcx98vlVbAh+qSjYEsPAJ4NYeEX9PC9PQTTVHAHm4kkEvBQsE46nzqn2pDGBEJaGmidT078wyEyaCx6weEXsEVrRJu56JO75Dzqk8vbnkUJhWa244Hr92dVMrq3355S3FdGLx5QwOETNG5pZ4Qz6PKL8wWflpNm2HY4TIX/eugYbKCGScFDL6sMRLm5LrwgkemALDUPmgE6DUXvcROQEqcn2StzkN+NrA0i05u0ROjx3Px58CcZXKHxrM8UXJJqJbySJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB7141.namprd11.prod.outlook.com (2603:10b6:510:22f::14)
 by CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 19:35:43 +0000
Received: from PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::d5b8:c389:3c2c:3fee]) by PH8PR11MB7141.namprd11.prod.outlook.com
 ([fe80::d5b8:c389:3c2c:3fee%4]) with mapi id 15.20.6631.046; Fri, 18 Aug 2023
 19:35:43 +0000
Message-ID: <9e9c629f-eab0-6643-4e47-0a4b39e2a3f8@intel.com>
Date:   Fri, 18 Aug 2023 14:35:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH] x86: Use __fpu_invalidate_fpregs_state() in exec
Content-Language: en-US
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
From:   Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <20230818170305.502891-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:303:6a::20) To PH8PR11MB7141.namprd11.prod.outlook.com
 (2603:10b6:510:22f::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB7141:EE_|CH0PR11MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: db410864-ef0e-4f28-31f4-08dba0224ff3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvgZZlzKWGsw+JvKJInzcwg7HCiWuZ5lzE32q7panoDGtTdNLup80EjGAik+tMXNwplGemT9N4/T5c981v/bTBCLodBzbulo45Qkci9/gnkYgxjCv6XW3YXZw/TJXQTuQep18uPoAsy9A26JP5/7M3KFyY16NuY1DIgr63qWbTfwQ4OtYD7PxDkWM+R0EzDWsdJDNweV4nj860ji024wehRF03AQtq0KvtkVF/kyDcIULzAHKu+2izCNtk68rWdGv7IiPhNseHmaAo3XYxMjJye8nYETsOVFa6A2rzBG+o358TSotU3wzEmWOHpsPzmdVRfJQ8WcdhM1UOfNC/Sa1ATS7sog53buunpCWmUxGaxdNhLeihGOqlNmMghhsfq+li1/lOzQ6W0Tc0IvchW8ImreRlRcPeZVhJYq/LDMbNoj9fzPqTIe/jpmyuGS3PL50rx/r5xNy/RKzfcj07t7uNFgdxhoxJtkmfTIfTfDpNQ6FRU9tPkHGyxgjAWlyCK/0eI3pfPXYu33M3PMHQeZSTLN3FG16ll+SyKFcbF5Nn14SooTTXhf1dAgl7EGgi9dEW9o7sQWt8qD+WGNh2sl+efJfvYC2I/kdjdNAw+rtITGsBf6w0XB7Uac4dJCff0XVfORWY4KJDmGp8NLa76oBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(1800799009)(186009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(53546011)(82960400001)(31696002)(26005)(83380400001)(36756003)(2616005)(66556008)(316002)(2906002)(66476007)(66946007)(41300700001)(86362001)(5660300002)(44832011)(8676002)(4326008)(8936002)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0p2eGowL1k5QXp1NmM5TUtuUk11cUlXTUdtS1ZGSDRWZzBUMTBNZlZMNGxI?=
 =?utf-8?B?ZlZ0WndyRWpxelB4MWtGaEQzRW5LYVZUSUMzci96VVVFMGVRSUs5THZDbGRE?=
 =?utf-8?B?Um9FSEFwZnM0UHdFbTdjV0pIVGxSTmdNSHJ5STIyY0hIYW1HREMweUZ0RkRl?=
 =?utf-8?B?d0d3TkFxVVhDUitiWVZleUhOUHFyeVplSUE2dW45YURMVXIxaEdLbnlGcGZy?=
 =?utf-8?B?ZmxVanpVTThVYmFhdWlLUHljRGZDenVhM1Jxay82S1YzMzg5RTRhY3FtbnAw?=
 =?utf-8?B?Qk5vUWhjTjVnRzZSTkQ3MkUvK2pTTnRicDhaQUtxNmFKeDd0L202UjJKOTNI?=
 =?utf-8?B?dndqbjJVWFovOTJxb3ROVUhUN21Rdm1CVk53OTMrTFVQaTAvdXRqNUVmcWhC?=
 =?utf-8?B?MmoyQ3pxSFltMW5ORjQ3V3BzS0ZBVEE3cmttUGtOdTBER3RITnlNNlp3ZWNW?=
 =?utf-8?B?akFvc2FiR01oQTRoeGtKaGg0ZitVNzM5YnlyRXp3dXE1Q2hXcGtWOFJjdk9w?=
 =?utf-8?B?emw4MVpoL2NmK1VrSzNqbEpKelRjajhDUk5IWVRLNlJGWmxxbE10Nk1UcGhX?=
 =?utf-8?B?QzU1Qm1GUHN1eDNUSmo0QTBRd1RoYmNZb2w2Uld5cFg3NWdLK3k1am03aFNo?=
 =?utf-8?B?dEY0V1o1L0ErMW5LOUtTS05LQnNZemp3b0xRSnlWbjZEU0pkQzFoblYwZUxP?=
 =?utf-8?B?ODJwWDgwUE5NenRESXMzWjRkaW1xWjFrZ1VCcE1BM2tucTBmNmZZd2Uxa0w0?=
 =?utf-8?B?dUFObEhaRWEzSkVGN0pJTFpiMk5BMzNpSFc5TFRzazZzYlR2Unl2cXBXWkVN?=
 =?utf-8?B?SHZwN0tFa1J2NUxJYU54Y3dpTWVFdTNjak1NMDd0WlBvM0ptMTVvNi81THhi?=
 =?utf-8?B?SjM4RHkrdWZwNU51eGdtaHErU3lwZ1RJQlhVQmQ3STZ3blVoMUFTd0VXWnI0?=
 =?utf-8?B?cVNkbUZnaHUzaHhhaUNVL1cvZ0ZDOVB6cHpycjcyNUJSdm5KNVllMVpOMWxJ?=
 =?utf-8?B?dFJWZGtIS3krNlYxY200eWxVOXZpUUNMVVlEd1phbEVrOUM2Ym9kblVXSTFP?=
 =?utf-8?B?S2QxQ0dOVy9ZbEh6M1QxQVZRa3F1bXZ4U2w4N3dpUGg3cTY3OHFSdkcwdjdx?=
 =?utf-8?B?L2R0Tjlwd09NVFhzcWpOK25pNXFkdkZsT2ZGVWpudWNZbGhIejczRE44UlAv?=
 =?utf-8?B?b2tBN21uSVQvTEJheDVuZGRWRHJ3VU4wT1A1Qi9Mc2w0Mi8rUnlBZ0hTM1Fa?=
 =?utf-8?B?S0dKSVFWYXJMMG9WVGlMY1RoQ09FbjdaQ2RZY2JOK3RyTG0xOXhSOG1nZTlL?=
 =?utf-8?B?cWduY1gxd0ZERGRWU0pJSm1waExpVmF2WDRyYURpNDhINmpkRjcvOFJUR0Fq?=
 =?utf-8?B?S1FRcmhteTV6S2M1b2dSbnBLRHdNb0Jwak1IYlhDTEo0VWRORFBRdWxBcktE?=
 =?utf-8?B?QitUZi9MM0ptRWs1aUlBYTVGK1ZGVjlGSm9pbWVKNHY0VUV1T3RXQndVdCto?=
 =?utf-8?B?MkJuaGFMYjV2b2dweE1NK21ZVXI0THVBeDI5YjYvZHNZZFRZT2wxbk9MYmNK?=
 =?utf-8?B?YzN2UmJMYVc4TkNJQmtIZ2FhVWxsRjFycmp0bzRyOUlOYTRiNE83aXk3SnMy?=
 =?utf-8?B?bjhjZm9NYVBsdUFnNTJ5T0RZLzIweEtBVVhab3Vra1lHYk9pVHJtSC9sMFNw?=
 =?utf-8?B?VkdlTVpsdk1lN1B4UDlZMmNSeEt5R2pOTWlJUDFkU0VJVzJwdUVMUUFRRVZz?=
 =?utf-8?B?NFloS1lVR3grVnpvOWZtaU5lMmdualdWRHNiN3VNbndsVUw2ZmJBaitKbTRL?=
 =?utf-8?B?ZE16bEZYeWg1dy8zYTAxZHg3UzVtMjhpYmtvMEkrRzh2K0UybUV4b1RrbUNw?=
 =?utf-8?B?WTNuQlhmRFpyTy85QTVxNXE4UGtwNjVseWR5L29wbzVnSDJFQVZrL3dWUjQ2?=
 =?utf-8?B?Q1diSncrQ3Y2dW1jVzlJamd3dGRETE5TYkU2ZG9qN1RaOGM5ZFFjM1RqcUcr?=
 =?utf-8?B?SDRQTDYrbXpWT2pZK2VMdmlkdXVXZUpDa0VhRDB4cWhSV0xHSEp5QmhxeHpS?=
 =?utf-8?B?SmtMampGVWpwY3Nia0drVjlTZmwxbUNPS3BWSWxzS1RNdkd0dTlPdG03Qm5O?=
 =?utf-8?Q?IzUwhndFaiKTZbV9K0QMoiLNb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db410864-ef0e-4f28-31f4-08dba0224ff3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:35:43.5302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cvKHNWHb8jNrJ3Sxg1bKO77H2R2jd6UJ1MG3WqNZMxWVnpCNlz6whq/jkkOwuTTqoZMRHOzoNmQgBnANyXq1qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rick,

On 8/18/2023 12:03 PM, Rick Edgecombe wrote:
> The thread flag TIF_NEED_FPU_LOAD indicates that the FPU saved state is
> valid and should be reloaded when returning to userspace. However, the
> kernel will skip doing this if the FPU registers are already valid as
> determined by fpregs_state_valid(). The logic embedded there considers
> the state valid if two cases are both true:
>    1: fpu_fpregs_owner_ctx points to the current tasks FPU state
>    2: the last CPU the registers were live in was the current CPU.
> 
> This is usually correct logic. A CPU’s fpu_fpregs_owner_ctx is set to
> the current FPU during the fpregs_restore_userregs() operation, so it
> indicates that the registers have been restored on this CPU. But this
> alone doesn’t preclude that the task hasn’t been rescheduled to a
> different CPU, where the registers were modified, and then back to the
> current CPU. To verify that this was not the case the logic relies on the
> second condition. So the assumption is that if the registers have been
> restored, AND they haven’t had the chance to be modified (by being
> loaded on another CPU), then they MUST be valid on the current CPU.
> 
> Besides the lazy FPU optimizations, the other cases where the FPU
> registers might not be valid are when the kernel modifies the FPU register
> state or the FPU saved buffer. In this case the operation modifying the
> FPU state needs to let the kernel know the correspondence has been
> broken. The comment in “arch/x86/kernel/fpu/context.h” has:
> /*
> ...
>   * If the FPU register state is valid, the kernel can skip restoring the
>   * FPU state from memory.
>   *
>   * Any code that clobbers the FPU registers or updates the in-memory
>   * FPU state for a task MUST let the rest of the kernel know that the
>   * FPU registers are no longer valid for this task.
>   *
>   * Either one of these invalidation functions is enough. Invalidate
>   * a resource you control: CPU if using the CPU for something else
>   * (with preemption disabled), FPU for the current task, or a task that
>   * is prevented from running by the current task.
>   */
> 
> However, this is not completely true. When the kernel modifies the
> registers or saved FPU state, it can only rely on
> __fpu_invalidate_fpregs_state(), which wipes the FPU’s last_cpu
> tracking. The exec path instead relies on fpregs_deactivate(), which sets
> the CPU’s FPU context to NULL. This was observed to fail to restore the
> reset FPU state to the registers when returning to userspace in the
> following scenario:
> 
> 1. A task is executing in userspace on CPU0
> 	- CPU0’s FPU context points to tasks
> 	- fpu->last_cpu=CPU0
> 2. The task exec()’s
> 3. While in the kernel the task reschedules to CPU1
> 	- CPU0 gets a thread executing in the kernel (such that no other
> 		FPU context is activated)
> 	- Scheduler sets task’s fpu->last_cpu=CPU0
> 4. Continuing the exec, the task gets to
>     fpu_flush_thread()->fpu_reset_fpregs()
> 	- Sets CPU1’s fpu context to NULL
> 	- Copies the init state to the task’s FPU buffer
> 	- Sets TIF_NEED_FPU_LOAD on the task
> 5. The task reschedules back to CPU0 before completing the exec and
> 	returning to userspace
> 	- During the reschedule, scheduler finds TIF_NEED_FPU_LOAD is set
> 	- Skips saving the registers and updating task’s fpu→last_cpu,
> 		because TIF_NEED_FPU_LOAD is the canonical source.
> 6. Now CPU0’s FPU context is still pointing to the task’s, and
>     fpu->last_cpu is still CPU0. So fpregs_state_valid() returns true even
>     though the reset FPU state has not been restored.
> 
> So the root cause is that exec() is doing the wrong kind of invalidate. It
> should reset fpu->last_cpu via __fpu_invalidate_fpregs_state(). Further,
> fpu__drop() doesn't really seem appropriate as the task (and FPU) are not
> going away, they are just getting reset as part of an exec. So switch to
> __fpu_invalidate_fpregs_state().
> 
> Also, delete the misleading comment that says that either kind of
> invalidate will be enough, because it’s not always the case.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> 
> ---
> Hi,
> 
> This was spotted on a specific pre-production setup running an
> out-of-tree glibc and the x86/shstk tip branch. The symptom observed
> was a shadow stack segfault in ld-linux. The test case was a kernel
> build with a high number of threads and it was able to generate the
> segfault relatively reliably.
> 
> I was surprised to find that the root cause was not related to supervisor
> xsave and instead seems to be a general FPU bug where the FPU state will
> not be reset during exec if rescheduling happens twice in certain points
> during the operation. It seems to be so old that I had a hard time
> figuring which commit to blame.
> 
> A guess at how this was able to lurk so long is the combination of two
> factors. One is that this specific test environment and workload seemed
> to like to generate this specific pattern of scheduling for some reason.
> So the fact it was reliably reproduced there could be not be indicative of
> the typical case. The other factor is that CET features will rather loudly
> alert to any corrupted FPU state due to the enforcement nature of that
> state. So maybe this FPU reset miss during exec happened less commonly in
> the wild, but most existing apps can survive it silently.
> 
> But since it's still a bit surprising, I would appreciate some extra
> scrutiny on the reasoning. I verified the FPU state was not getting reset
> during exec’s that experienced rescheduling to another CPU and back at
> times as described in the commit log. Then following the logic in the
> code, failing to restore the FPU would be expected. And fixing that logic
> fixed the observed issue. But still surprised this wasn't seen before now.
> 
> Thanks,
> Rick
> ---
>   arch/x86/kernel/fpu/context.h | 3 +--
>   arch/x86/kernel/fpu/core.c    | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
> index af5cbdd9bd29..f6d856bd50bc 100644
> --- a/arch/x86/kernel/fpu/context.h
> +++ b/arch/x86/kernel/fpu/context.h
> @@ -19,8 +19,7 @@
>    * FPU state for a task MUST let the rest of the kernel know that the
>    * FPU registers are no longer valid for this task.
>    *
> - * Either one of these invalidation functions is enough. Invalidate
> - * a resource you control: CPU if using the CPU for something else
> + * Invalidate a resource you control: CPU if using the CPU for something else
>    * (with preemption disabled), FPU for the current task, or a task that
>    * is prevented from running by the current task.
>    */
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index e03b6b107b20..a86d37052a64 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -713,7 +713,7 @@ static void fpu_reset_fpregs(void)
>   	struct fpu *fpu = &current->thread.fpu;
>   
>   	fpregs_lock();
> -	fpu__drop(fpu);
> +	__fpu_invalidate_fpregs_state(fpu);
>   	/*
>   	 * This does not change the actual hardware registers. It just
>   	 * resets the memory image and sets TIF_NEED_FPU_LOAD so a


Thanks for the patch. Let me get back to my server (offline now) next 
Monday and will add a "Test-by: Lijun Pan <lijun.pan@intel.com>" if it 
passes.

In our bug case, probably just switching to
__fpu_invalidate_fpregs_state(fpu) from fpu__drop(fpu) is enough.

Maybe there are some other cases that need
__this_cpu_write(fpu_fpregs_owner_ctx, NULL) through fpu__drop() call, 
which I don't know.

Here is the excerpt of the call sequence:
fpu__drop() -> fpregs_deactivate() -> 
__this_cpu_write(fpu_fpregs_owner_ctx, NULL);
arch/x86/kernel/fpu/context.h has
static inline void __cpu_invalidate_fpregs_state(void)
{
     __this_cpu_write(fpu_fpregs_owner_ctx, NULL);
}
static inline void __fpu_invalidate_fpregs_state(struct fpu *fpu)
{
     fpu->last_cpu = -1;
}
static inline int fpregs_state_valid(struct fpu *fpu, unsigned int cpu)
{
    return fpu == this_cpu_read(fpu_fpregs_owner_ctx) && cpu == 
fpu->last_cpu;
}

So, I am thinking if it is more rigorous to have both 
(__cpu_invalidate_fpregs_state, __fpu_invalidate_fpregs_state) 
invalidated, similarly as fpregs_state_valid checks both conditions.

code changes like below:
diff --git a/arch/x86/kernel/fpu/context.h b/arch/x86/kernel/fpu/context.h
index 958accf2ccf0..fd3304bed0a2 100644
--- a/arch/x86/kernel/fpu/context.h
+++ b/arch/x86/kernel/fpu/context.h
@@ -19,8 +19,8 @@
   * FPU state for a task MUST let the rest of the kernel know that the
   * FPU registers are no longer valid for this task.
   *
- * Either one of these invalidation functions is enough. Invalidate
- * a resource you control: CPU if using the CPU for something else
+ * To be more rigorous and to prevent from future corner case, Invalidate
+ * both resources you control: CPU if using the CPU for something else
   * (with preemption disabled), FPU for the current task, or a task that
   * is prevented from running by the current task.
   */
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 97a899bf98b9..08b9cef0e076 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -725,6 +725,7 @@ static void fpu_reset_fpregs(void)

         fpregs_lock();
         fpu__drop(fpu);
+       __fpu_invalidate_fpregs_state(fpu);
         /*
          * This does not change the actual hardware registers. It just
          * resets the memory image and sets TIF_NEED_FPU_LOAD so a

Thanks,
Lijun

