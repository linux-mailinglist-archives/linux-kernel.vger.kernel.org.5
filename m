Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A8E8113D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441828AbjLMN5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441837AbjLMN5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:57:24 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864644C09;
        Wed, 13 Dec 2023 05:55:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCdMF6JR9kwxymOEkk3ZlnliI64ogq0+h9IjRer+tXbmkOLtjZX2BQF3Et3aU3haohRknn4BHCcg5zl43XJHeolq0uijwotsCu5P6MNSZ7h0U0+YjCsWgJngg9hhAeRRAukhLrbh4Yuz9jHZ050FpLxvPJRyjOOOBxu7hmeIGcZ5n6VWCXsfIpyZ3oG9zL4i1KxmsFoPUD02HK3VZOjo3SIAoA1QxHuHBMIK1sPbghYCXlrFu97duFuGw/pJwJoyXUitYMx1AwJdTX216I9AFeA2YgUGUVQkajsXjBIXzhVka67eRfjNGab6v6kIuL48yX8QYeE8audkVkoA/krztg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJHpwwR40ZY70k0My34aW/kvW/CIynZiRAVWW8KmiBU=;
 b=Rvxuc3Kx7G0xLGZOY08oPIBvsSSXSzP3ocbA+TEBRcwsukUe6DmRXk+wpz/wnlv7fUYSw9rmzVSbjE1QCdAxbh6/1FpxhwMxnQpO1dhjJzxrqlsrZEAuHlyS4TkIhjtkX29Z66qaDGTF5LABuK7qRpRcuLS2f6Mx/2aqRcpsJtUagL7psEJ3Ihh3a9wDbvtMPWduc41BIITGS8zMMi26TT+4TUabrUtsep6B7PtvoiT/9ZcsABS66CU7fiUCLdctIHAKfiLStejHggQz9Se1GigZXQGBpjSnG0Gs8U8DhEEmOBnmP3BK6i2Qj1IB53/fv3uSpJT8HmnlUv5b2CSqiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJHpwwR40ZY70k0My34aW/kvW/CIynZiRAVWW8KmiBU=;
 b=kUGQae5M1swwLHfOpV7CF3T0QSyTzlSz8cgYm+YCaLoQPnUY2HEOJrAzjrTQYQNOKGWQzdClryclwHwQDARoCVdcvQEB/UPhlT/jSFGFB9KuDj414/8VxuWMymfFWCLHJXDUyxFiKarUsgN5byKkAneSmr0nYR0mdpjBhdEKRAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 13:55:23 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:55:23 +0000
Message-ID: <1c2965b5-28f7-e80e-250e-200d189d5eec@amd.com>
Date:   Wed, 13 Dec 2023 19:25:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 4/5] perf mem: Clean up perf_mem_event__supported()
To:     Leo Yan <leo.yan@linaro.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-5-kan.liang@linux.intel.com>
 <20231209061723.GC2116834@leoy-yangtze.lan>
 <2865c1b4-a003-44df-a734-1e1c90bfa14d@linux.intel.com>
 <20231213134911.GB3895246@leoy-yangtze.lan>
Content-Language: en-US
From:   Ravi Bangoria <ravi.bangoria@amd.com>
In-Reply-To: <20231213134911.GB3895246@leoy-yangtze.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::9) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 979e560b-2d9d-4017-db3d-08dbfbe3270b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RbUojtavatbIzvWrbA/EgCbvfSYY+FhWUy+gGoI2WeZrtkEC9lR63CKeg7mxLVrNe3BB/bN4nBYC2i9lheSKqEdYGLb6uisGhM7ZhxmWzj2keJ8gSr9yAF+zaiD81RulYom4O7kMle+9u5pmSp157oAZfPACzlLHS+8EtjW6RdfB79Q4qZU1VwCNHHqJB/oi1XSSWXnQzG3im/4EdcKLE/cj57qB9vwjHJ4M26IUSK+UUqpzLccV+TF6wBbpat2nW+58Sy2ilutEHnB7ugjStMVmiQ4a15FGxN0Q3srvm1eX3IyufglpM/6qACs/Mew3meDzUODbafA+MhlgRhFAhq3YVPcHYIOWMq2kvY/Mrl56+0s4hkFkWtTpX/UFUqs9lARuTtIqjxi7pOTAnDJR18yv7vU1FiXacHeSl1mwgMfgXaSG9buOE+G019F+20At6nLhfQ1OCv8tMkGYqUbsGdEzT5KkQsPvug6xC8x++UlkvQlHt4ELiCtfmicmV2PCu7fNJ5yfztJ4c3HlzchIShKYWw74tpxY0w9YHrj0gkLhNNHTiGmcUcIh99duilSmXd6CUv2aOuiuDsmqCLT51BdJyT66eF87jwQJoToOKiQI1OSUaFP9SI3wA+9/LRdqw6IMqNPPhhyJSET16xZ645rYgZVfclA4RMrht20S+3DA5h1uY/G2P9uU7oe+z9ei
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(44832011)(2906002)(7416002)(5660300002)(478600001)(38100700002)(86362001)(31696002)(2616005)(6486002)(36756003)(6512007)(83380400001)(26005)(6666004)(6506007)(316002)(41300700001)(4326008)(8936002)(8676002)(66556008)(66946007)(66476007)(110136005)(31686004)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1hZTjc0bEI5YVQzemZ3S2sybkUyc01rYUdFenRGVVRBOEdKWUR2bmMzYy9p?=
 =?utf-8?B?SGpvdXhvUG1aVGo2TkhUTHhqRTlKb1FUMjdjZ3NacllFTjh6SzE2dFNlS3JE?=
 =?utf-8?B?TnRkamJTemdKTUxoeXd4VXlOK3NWNkp2MkhmK3hkQXJVSFkweHZpQUVpbXhN?=
 =?utf-8?B?M1ZYbWNwWXF2WGkzRjFzclRqbFFQNzFsY1lheUViaWJFWFRkT1BZQmJOVktl?=
 =?utf-8?B?STE0dWhRajJIekE5b0tXbGtpYWJyVzhOb0dhaEUyRy9MUnRnTmh5eUFsRWhU?=
 =?utf-8?B?aENIT2N5cXJScGI0c1lDRHErTjhQUG5iL2FOTDJkb3lqNG5lSTBJaHNvMTMx?=
 =?utf-8?B?S1AxM0cvUG1hb3RvR2pEQ0gyN2RNTUlCYkltQy9IcVhrSGVvdlVoR2VPNmdL?=
 =?utf-8?B?bkZKWVZuS29UbE9ZVXhuLzl2bkJwRGhvSXFzbTRSNER4MzBOYjJrTDVoekRa?=
 =?utf-8?B?UnJ4bGtDM01pZUk3NThKK2w1RzViTWQwRG5oKzVSQVJxQzRETGJFazA4Nnd5?=
 =?utf-8?B?TGpTdzJEVGxIYWxFdVhvWFBvMjdKbWxZTlJYUThRc01SNE4yWWx4RmdTU01P?=
 =?utf-8?B?d3F2RjJjRVlwanVWU21DZkJRMWNRUFBjTWl6VTlPcHdBNlFZSStNdjNGQmNw?=
 =?utf-8?B?YlFDZk03M3BhM04vam9oS05hcG9MNkxzRUF1NDRaVW5EYUZmQUZiNXhLdU1Y?=
 =?utf-8?B?NllaZndhWW0relNTSlZMcVBpNTBZRmtLZXZ3T1Bwd2w0bnhQekdvaUNTcmwy?=
 =?utf-8?B?SXVOTStmWFQwbmF6akcwcG0rZU1GVzB6d3lOWHlXN0lMUEJCTmRPbURWeXln?=
 =?utf-8?B?YlZjUzUyQTg1d3hKYWlGaW5nY1QraHArZFNBTEgwbVBCeUh5eWxrSk9NR09Y?=
 =?utf-8?B?K3NncldFUFpSbW9TNzQrdCtiOXhaSkJBQ2pySE9Ua1Jaa2ZXK1JWSThpME1Y?=
 =?utf-8?B?eXlWaTZyaDhkQ3FXelAwUjZJWVJTTnJhTTlMSTdOdHpMR05pdlMwZDNERCtZ?=
 =?utf-8?B?SHhyUUlVZmliNGU5V2JSQ0tkK1paeU9VRWxCeEZlVjdMUytIK1ZlN3dtd0dV?=
 =?utf-8?B?T1JpelF0ejYrbytaNUpPczdNMW4xV05PaVlWRzFVQTE1WkRlam1jMERUbkli?=
 =?utf-8?B?WElyaW5nUnJQeW9FTU5oWGUxQ3dEQ1BHcDRUNW8yOVBHNGhieWhiMDd1UmVL?=
 =?utf-8?B?U1Q3OFVEUUcyRGhTWkphTUhDSUx6WXNBaDd3dmdDRW9VaWJFQnFNcmczTisw?=
 =?utf-8?B?ano2d0x0THhvaytvbGpRT0t2MVZZbU1tcUFFdExyTCtReVVFdm05bmYycDhw?=
 =?utf-8?B?eUtkZG9XZVdzRW9keFhGUStNVi9talRna0h0R1BrdTRhYVY1V2tvUXdlbkUy?=
 =?utf-8?B?bXVjSlFBMk9xV1VIVVAxMkZGWnh0SEs4b2QvM0x2aVpUQkNaSmhGRHZvSmVh?=
 =?utf-8?B?dVNHb0ZPOUh2S25xZ1YyeEM2a21nUEwxZFpaZlphR01PcnEyYU1zU25LTG9p?=
 =?utf-8?B?d3BYU0RnSWF4T0pvaExPQlQ0RFNKT3NSY1JnUEhSTVJhck9NUXgyMDJFaDBv?=
 =?utf-8?B?M1dNdHExRkR2bEFRcCs2K2Vuc1IwTGtmbGJreTZXZUV0b0tqUGFkZDRsR2dM?=
 =?utf-8?B?dzJsZFc0RnBxU0RPUVBRR29iclVSbWQ2SU9sN3hGVGF6MTg3S3Y5ZllCZWtz?=
 =?utf-8?B?VEZubStYY2h4Tkc4cU5FMjZTQ0xHbld1YUo4Y014aUdSQjBheXVHY3FZMHpP?=
 =?utf-8?B?UXdjcmQyV1Z2VkxFY2J5U3VxR0xSNTVEdFRtMzJUMDFFa2tWTGQ4Uy8yT2ho?=
 =?utf-8?B?MVpGVENOQjJIRjYwejB5TTFKdS9qMVpQbGZWNVRmUllNN3JML2ZNYWdzRjdC?=
 =?utf-8?B?MWhmOHlYZkYzSXI4ZDgrbUhsTy9WVTA4UVhic2tQTjVGc3NodVo0eWUvTmFE?=
 =?utf-8?B?dkltSmRBaVc5SE56K09nbHRyYlNkWmJycGw3WG1sc3VCV1M2ZHRyMHFvYTVw?=
 =?utf-8?B?UmpSZlhaMC9ZR3JoMWNjaTZhTzlUaGZXcUhza0dFT2hITWtlMUo5NklSK096?=
 =?utf-8?B?cjlrV0ZiVzN1N3ozZEpLQitENjYvTmxKbER2TTRDZmtLaGwxQjJXcjdKRk40?=
 =?utf-8?Q?IPOsJcwMueq8ue6gXRyVwz4RV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979e560b-2d9d-4017-db3d-08dbfbe3270b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:55:23.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mN1fxXcd0KU/w1xNXcJLJQ8tMGtREn5jmbSlAmxSeSLIlq6O+ctN+MiREksxRJ0YNBVEjhmzFt4ZqDjTyDQEIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> For some ARCHs, e.g., ARM and AMD, to get the availability of the
>>>> mem-events, perf checks the existence of a specific PMU. For the other
>>>> ARCHs, e.g., Intel and Power, perf has to check the existence of some
>>>> specific events.
>>>>
>>>> The current perf only iterates the mem-events-supported PMUs. It's not
>>>> required to check the existence of a specific PMU anymore.
>>>
>>> With this change, both Arm and AMD archs have no chance to detect if the
>>> hardware (or the device driver) is supported and the tool will always
>>> take the memory events are exited on the system, right?
>>
>> Currently, the Arm and AMD only check the specific PMU. If the PMU is
>> detected, the memory events are supported. The patch set doesn't change
>> it. It just moves the check to perf_pmu__arch_init(). When the specific
>> PMU is initialized, the mem_events is assigned. You don't need to do
>> runtime sysfs check. It should be an improvement for ARM and AMD.
> 
> Okay, I understand now.  For Arm SPE, it has a dedicated PMU so if the
> PMU is detected, then we can assume the memory events are supported.

Same for AMD. If ibs_op// pmu is present, the mem event is supported.

Thanks,
Ravi
