Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42357B58DA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjJBR1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJBR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:27:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3108FAC;
        Mon,  2 Oct 2023 10:27:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCaClL7rHF7pO+cg58dhFigzYS5xqWZkon43NLcL254JZIjrnLOlJpk0fLpadH7Dco0AlIoiFMUn9IRXSuTYgO1N9Upt/pmrOrr9620k0HPGoAmolsQl0oTCuIIWk9FHIamiyN8vhZAe4DvezF1Xq4b7rsG0E+vonGGB5k6JSJkAElLKGsDOScvBZ9QCUvaibqx44vPALQtVhoKATeTcG4wq1I1QfhMcSa9STrdPmw53GVpcbpif9cvkO+vqrGqgZqE/qxNa2rrZ/3ezZOqAaZ4VQyYEaL1FUvwvnpdTLanfvOqYUq+P3SGx45QkMa/ot88Wd9Stryls0rjOGy9IQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40vqjOWdOGXklme6Ni7DffIoUTDiu+RAFIR6L2Tsgnk=;
 b=THEy9+HlvDqprLb6GXXlF8VrbtlNupuLKnepx/wxui2f9C17vJhz527wLGa7JcW8sP29t3t6BuaBa0Zd0IwF8lZoqhO4kYoOuTc4f//fzkiukLC0Nilmob9dxZ+/ENEG1h5+kowfQ/5MFeztg0gCpQlCP0iw0IHaBf/rAnrWC9qZ7ST47s9jD/6z6LjcdjMjPesXDV9MsIGAyFL+rbODklVMDAqQaUm0ToWdPLOJ8nleEI4gxj4kJBM0HDU9Dcd2+2bb7i94d344UrLeSAcVczw+v+EoIVVs1vIIAcn12PpKiUjXH3wADo2nFwkDMGR8DS+Cp2sHO18tuep6j+Ni6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40vqjOWdOGXklme6Ni7DffIoUTDiu+RAFIR6L2Tsgnk=;
 b=kD71GDqp8XJoPhcpvo7gO3GmDinFcSvgJ8vl8R1LNLRB9yDRGE5ek7F+zO+VU71E5hWVQknhrZSJTIEI41mDGTykzi2dw+yjPwTUjsqpKcMZYl2GJMj2G2Ca3CjGYeEVc7u99ITdu5MG/Ljds3ZRRj6uNBZ64d1AnIDH8lq3fv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 17:27:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.030; Mon, 2 Oct 2023
 17:27:01 +0000
Message-ID: <37b999a7-d1a1-6158-f97f-ce8cc3276cc1@amd.com>
Date:   Mon, 2 Oct 2023 12:26:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 09/10] x86/resctrl: Add support for the files for MON
 groups only
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20230915224227.1336967-1-babu.moger@amd.com>
 <20230915224227.1336967-10-babu.moger@amd.com>
 <031ef099-a7d2-37ce-eb97-c4f7d76a12c4@intel.com>
 <7c6dcc06-0b6c-a346-c7ff-60da3fe59fbc@amd.com>
 <8e6fec2d-2262-1f62-8c4e-cedfa8459434@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <8e6fec2d-2262-1f62-8c4e-cedfa8459434@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:806:120::29) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8a7630-968f-4b25-5b83-08dbc36cc98d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpglBPUndOeZjXeDqUXFaTJvfVqdELuvWv5VNmJ2NrtbPA7JeW1ldVlQZHJnZS2luV0IQVlPbEDDZq1KW+1DwArRWYVL9yb5C7888TIbhwsxLUCUPY7r/KD0GQ4QbtsuhX9XukjXSRZsYgTUdJpNvZTzx+ZYFluFJlhDGL0AbU6yg3qouXL/mnEH5NPTYZ9lQKUhB0TldvMCZJkOaHY35vzdJvh0deMvqFG7HNLqNvBpxdBUI0zhNkFKHSMB0l/z7tdTK5R8fSR65yVkEIUMGslomcF5LtgJdGggYBV2B/B/cjmSOQffLeBQWm3O1JoKSbQJNbQxKwbz0X4MpSHi96VKQqf3cRaq6vfoFUVeP/6AAAIT8LhWhZhYiVviSD038aGfvQuDG6DyRvGnkslWLGCi5gs2YdqeV6n3gNO/Sb1n9LTnemyyjm72LVYrGaDCXP+v9lIK6RXl96j6OVn32ior7q7J1V7kSZpzvtTTPHFc6+kD0ujtf8oG8W9GFswwgWedmqnoyIVubf/jHIlCAW0oNcekjeUD3eDFCh96cYc1QUtsAXTMqfUWf4OSmiIyoKNp3trEK9bJbLAWoF7n3lNupUEBMDvgI+w7V+r8nIX2LaazyvIqi+6/ToGQx6NHeq6ZTObF91eIQTVIMK3xHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31696002)(86362001)(36756003)(31686004)(26005)(2616005)(53546011)(6506007)(6512007)(7416002)(3450700001)(2906002)(6666004)(7406005)(6486002)(83380400001)(478600001)(4326008)(8936002)(8676002)(41300700001)(66476007)(66946007)(38100700002)(66556008)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlI1NGd4MDFoeUd0aFlZWmhOWXVPTzZRSmdVQ3VaY1VSakRWbkprTzFTbmFo?=
 =?utf-8?B?TU1GQzZmVEUxdTMrdkwrREFLSFZBNU5pRG9FdDczWnRFYmVIQ2NZQnR6UXdq?=
 =?utf-8?B?Y1VRdGQ2YVBkWDhBQmw1bzcwZERoTXk1ZnRRdDVKUFFQREFPU2FOSWZMdHo1?=
 =?utf-8?B?cHdudmtSNEF5ZFFFRnpzTnpGRG9UeEdGdjRmV0Zsc3Rna0JsUWp6MUZYeEEz?=
 =?utf-8?B?Y2srdFdRc2poWlRLcmxKcEZzUkh4VlcwemhqcGovWERUeWVoYjhIS0lkMmU5?=
 =?utf-8?B?cnlNei9TWDRUODBvRFZSd1Bmdm13d1VRQ0l1eXVMYXBNU3pFSXZoZUovb3o4?=
 =?utf-8?B?VmttTmpsTytWQy9aQnFHVkJ5dStSdGxEbURtK29OTUdVamRGK3RyK1RpUDVB?=
 =?utf-8?B?b3FHR09sUnRiTHZNNit2d3hWSEFXKzZFbDI4UGtaaS9NZHpCMEtWZi8vUmhT?=
 =?utf-8?B?ZkJScFIvbGlBR0lWUjc4NWYyWGlzaExPcUZpaHlMeG1QY044VERSUUg5UW9P?=
 =?utf-8?B?NW1GSGx3WmN0TEFEbGNjMngvb1NxZE1rTEFRL2NpYjlBbDZmMnhkelNSZnNk?=
 =?utf-8?B?YkdTNWJwOXJuWU5LUFZBdndadlc3K21MWHI4Y1hxNmdJL3d3NEllL2NiWjc1?=
 =?utf-8?B?RWR0WVZKQzR3bnBMWnVyaHdtcHBoRklRV0tvcXdCVlFoSzZYbnJndXFiVC9l?=
 =?utf-8?B?M05HSEdpVXllYWRjTThZKzhUWkhVcWV3MDdtdmc4TkR2c1libFdUQTJ4c0E3?=
 =?utf-8?B?elFVdXdmS3l0bFBVOGlTSEptalNiQzVza1liK2hqdkttWWdBc0Fsc3dWNjhW?=
 =?utf-8?B?R1o1cjlZVjRXVlhITHJvSWRFS09zMGxwTXdWTERDcVAwbHZGSEFibEp1WmV0?=
 =?utf-8?B?VG5pcmdnWC9oYms4amdXRG42ekplUlFSQ3hBMDRRT2VudWFBZTJmS0t0aUVa?=
 =?utf-8?B?YXZGbGV5bWZGRGdzNXFwVDNBR25NT1BSTWVyeFBOTVEyT2JESHhWeHIwN29m?=
 =?utf-8?B?a09sZWpEcE9sbzlGeGs3MHhQZ3BSbnJPWmtOME5uRjN5L1NSdm9CaXBaeFcw?=
 =?utf-8?B?M3J6YmlGSWlNN3RuNmM5MEU5RG40VG5pS0JqYmhQbDRPV2RXaUhuanFldWlY?=
 =?utf-8?B?SmVIbUt1UERUWUtjZUVTMkRkOHdNRDBtYXo1KytPM3FGWURMNkU1bWwyTlFT?=
 =?utf-8?B?Z2IwOXVLYzRNU0s0WU9lQWNMZmFDZFp6N0ZSWm1EU2dUZ2FjSTZ0MEN1Rko3?=
 =?utf-8?B?ZkVrTy9veGFXYzJkYnpvVGRTQXhNMHVEK2dLY0lSU0FHOU1FM3Z3Tkw4RTN3?=
 =?utf-8?B?MWVwMDgwK2RrcUE0S3FVdFJMeVFUbzVtaG1UdmplNVFqTWNERDk2Ly8rYU51?=
 =?utf-8?B?YjBaUXc5d1NncmVob0RpR0h1M1ZzeXJ0aE03bTh6TzNncTk2a0JMV243M2t1?=
 =?utf-8?B?L1hNSkFSRTVpRFdid3FnQWlCTGt2eFRVK0ZaaExDS1ZidmF0N05hVGJwbG9N?=
 =?utf-8?B?SDlnT1hEb3pPcHYzRTZQZTlHeTgrWWlEeGZFREZIVEk5QjZWVEIzNXVmR2Mv?=
 =?utf-8?B?YklyQldsNkZQa1RWZ1BqdHJWcHNkUXdKZFM1YlRmTWtXY1haNENzZ3pwKzBD?=
 =?utf-8?B?MTNxSWJTZVgwUFZ1T1ladEJzc05qeFpkdWY3aTFONU5UYm41SEp1dVRoK05X?=
 =?utf-8?B?VXNGUFhnNTYwbFN0OGh3NUt4RFduYWxSdHFuQ01hNGkwZTh4Rm83UWRKbWFC?=
 =?utf-8?B?TU0vZE9SZlpjWk9uWUQ2QWo2SEc0cTJDdTBlTzBnRWpXaUZmdWhLNVZFZHZa?=
 =?utf-8?B?UWtkMWc2MmNYYS9WQ2dhTVJYWThOT202OFUraVp6VUxzaEZsNWdKVWh5OU1m?=
 =?utf-8?B?eVBsaHZNeS9ZblRLY1h2aGV5cVV5OTl1eFE2amVvdHRGekhhUEtIRjVpbWhS?=
 =?utf-8?B?L2NmQU5Eb1pJT3F4RWRBWkdYcGhjRjU5V0krSThhTE9tTTFncmt6OXRMZlhE?=
 =?utf-8?B?bjgzZVExUkk4VDA5d3FXWmt2QzI4WmhnV3ZhV2pabCtlVUtZdlZSZHZzL3Jy?=
 =?utf-8?B?T3pIQXFrSmFLc0Vla3NHLzFaVTg1U0g0WEhYUkkrRkp5MkQrRjJDd090d2hR?=
 =?utf-8?Q?VO7Y=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8a7630-968f-4b25-5b83-08dbc36cc98d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:27:01.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3koHf/8z8K4MerZf/7nWDDcuY8QDyyX4wSot5RSaz11127FwLhprkGcW6XF+vLIw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,
Forgot to respond to this.

On 9/27/23 17:02, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/27/2023 2:34 PM, Moger, Babu wrote:
>> Hi Reinette,
>>
>> On 9/27/2023 1:34 PM, Reinette Chatre wrote:
>>> Hi Babu,
>>>
>>> On 9/15/2023 3:42 PM, Babu Moger wrote:
>>>> There are 3 types resctrl root files.
>>> Considering patch #4, should this be "base"?
>> Sure.
>>>
>>>> 1. RFTYPE_BASE : Files common for both MON and CTRL groups
>>>> 2. RFTYPE_BASE | RFTYPE_CTRL : Files only for CTRL groups
>>> If (1) is accurate then I cannot see how (2) can be accurate.
>>
>> How about ?
>>
>> 2. RFTYPE_BASE | RFTYPE_CTRL : Files for the CTRL groups
> 
> Yes, this is accurate. Even so, this snippet does not seem
> necessary considering the changelog rewrite below.

Sure. Removed this whole snippet.

> 
>>
>>>
>>>> 3. RFTYPE_BASE | RFTYPE_MON : Files only for MON groups
>>> Same here.
>>
>> How bout?
>>
>> 3. RFTYPE_BASE | RFTYPE_MON : Files for the MON groups
> 
> Same comment.
> 
>>
>>>
>>>> Files only for the MON groups are not supported now. Add the
>>>> support to create these files.
>>> This is not accurate. Files "only for the MON groups" are
>>> actually the only monitor files that *are* supported. The
>>> problem being fixed here is that monitor files are
>>> not supported for CTRL_MON groups.
>>>
>>> I made an attempt at rewriting this commit message but I am
>>> doing it quite quickly so please do improve it:
>>>
>>>     Files unique to monitoring groups have the
>>>     RFTYPE_MON flag. When a new monitoring group is created
>>>     the resctrl files with flags RFTYPE_BASE (files common
>>>     to all resource groups) and RFTYPE_MON (files unique
>>>     to monitoring groups) are created to support interacting with
>>>     the new monitoring group.
>>>
>>>     A resource group can support both monitoring and control,
>>>     also termed a CTRL_MON resource group. CTRL_MON groups should
>>>     get both monitoring and control resctrl files but that
>>>     is not the case. Only the RFTYPE_BASE and RFTYPE_CTRL files
>>>     are created for    CTRL_MON groups. This is not a problem
>>>     because there are no monitoring specific files with the
>>>     RFTYPE_MON flag associated with resource groups.
>>>
>>>     A later patch introduces the first RFTYPE_MON file for
>>>     resource groups so fix resctrl file creation for CTRL_MON
>>>     groups to ensure that monitoring files,    those with the
>>>     RFTYPE_MON flag, are also created.
>>
>> Looks good with slight change(only last para. Rest looks good). Just removed the "fix".
>>
>> A later patch introduces the first RFTYPE_MON file for
>> resource groups. Add the changes to create the files for CTRL_MON
>> groups to ensure that monitoring files,    those with the RFTYPE_MON flag,
>> are also created.
>>
> 
> "Add the changes to" is not necessary. With this and removing the "fix" it
> can be summarized to:
> 	A later patch introduces the first monitoring specific (RFTYPE_MON)
> 	file for resource groups. Ensure that files with the RFTYPE_MON
> 	flag are created for CTRL_MON groups.
> 
> What do you think?
> 
Yes. Looks good.
-- 
Thanks
Babu Moger
