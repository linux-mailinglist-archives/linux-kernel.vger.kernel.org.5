Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449477B0E50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 23:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjI0Vor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0Voq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 17:44:46 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0542A11F;
        Wed, 27 Sep 2023 14:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhEtWlb2H05PjHhjqgFIFyLipfR8AB/Qo06dB40tIMR4JXA61zbzNe9TxhftHHTsM6b8zCEzZzvgU/TNdJ4BEXJheL3o/gTUtlNCStxXnwY2ZPpUfigUnqyAtlU2uBZdfKMIYTLezc811E8+4fRG1n2W62dzf82Gln12kM14UVubYUQdBRXUecDW/l18xL4CC6ooiXJqBtPxBDqIQ6Co7zqYMuaY2iSPmpvYsqmdcPsrqq7Db1cwedts9oTWClKwH8yN+DI8Eo7YkouQbN28rGRUjGvMo05fTDZwS7AW9J062p1YHP4/4wL2hcqK+4lUQbmOOjGrt2EJY2XMSvP9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89FZBXaUrrtRKlHegKWqpSVctPcNcwdseqT+5hHwhPk=;
 b=SlvYtAWc9VdX4/jq3kxrCOy7DVxudRHGCMwVdBMXgAZLJE8SQ5x2RVoBbuTEvC/w6H4FsKhp05qjaSBiiMOmNsLTMS4YXaKQYz2RgDATKiyKW7lnPHuOfk9kO7KjpK/PswboYkxM7UT0dLJpU4etaz1mC3l5Cvf0GMjhrDWmubv4C6PS20hj7s4Vq9+EAjczvFH3+q5Ha2RL80dnCylJc2epthVhUeE3MEpE/lFXisNxdhvBmeogp0KKAQsdwaT7tIGbBkFRguF7xira1+KDCpW/sE4o2Y0AzWjDs+elNFHxUxD1mU5IkhcfrF4ds/KmuPNSjXhnr/DT/QQcrvJ5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89FZBXaUrrtRKlHegKWqpSVctPcNcwdseqT+5hHwhPk=;
 b=vB4wG66u/QfXCTpyE2ZQt/iIz8MlfAO160aTz0HYDxX/Dtb5nTXvZ2qSdLo51vCQw/S34X2VoINXyGXrweJe7uYL/qxsc24JGe4qbKu0zVJpXb4oy7quKupAr3MT3exAHVseLz4VfysJOflG+YV7gHOZcUHjwQA3JPpZQLUJrlM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Wed, 27 Sep
 2023 21:44:41 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 21:44:41 +0000
Message-ID: <c58a017d-81ff-a797-5b3c-af5a016319bb@amd.com>
Date:   Wed, 27 Sep 2023 16:44:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v10 01/10] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
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
 <20230915224227.1336967-2-babu.moger@amd.com>
 <dc1281bd-68ce-18f8-e4fe-d2d07535f047@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <dc1281bd-68ce-18f8-e4fe-d2d07535f047@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0094.namprd04.prod.outlook.com
 (2603:10b6:805:f2::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BY5PR12MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: c194663c-3365-4434-0331-08dbbfa2f45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BP2kTgspAb4Z/moTEmE+Guc1EcnaQP+Prcios0E+hK6XoBGDqzO100vj8lpQxs0e0Jyu2zQH9cIrSSdz2yST1bXWo+qrBOb+gdn/MBwoD8t39Huu9yCUtx/7HP7+8rzbHEDnq99NnCEjizGUTcZftAbSVjykYXYMKeXrHlrpmw+5eTFS2UCy/h5BBCPhxJcpenPkruTXcEHrfdcLVeWdwhX5oyEgBknhp50UCc7VN7kgfrmjKOkYG74G4XDqZGskSBw5Sm/RZLUd23eat2mHt7jUDierG9U0otyRV2bAr+CoxcBLcaWcQ22TohxrGwiwjbSl5pnEzrqSkLrn7tG25+lrgSKsBLKClAgBPFXt/0hKV0Vux4Kmpn2hzTqt53b2hdlRJtWkk6qmfhmCD7kCaTAPANZbJ+8rRzrAUTSDKSU5rctBMKz+1LAjRYDciqAJmew3JYeZ5+mpb00bmZWjqSv8AHBBckAd9gPL7ZJ3kmL0gBiACB1zq8Ij16tOVKapzhBrW1WlJJPpBoUpBsgnhzMKl/iFwZM3OsfWkBRSDUqj0/sUFeYulCfLtEIIcExQF8hN6ul4/y03D/+WeDIpHLz0lPPsgmjKYXuT4Idofne4APImGTi126b8zEUY2RxmY7gYtooNCdZ+3IbJOKQh+KYOOTBwhr5DOUC0m0TocaQhb24t9xt7cGzlAMgUctOT/UFRR9EVziO9v2+emqjOFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(83380400001)(2616005)(41300700001)(31686004)(6512007)(26005)(66899024)(36756003)(6666004)(53546011)(31696002)(6506007)(4326008)(8936002)(66476007)(8676002)(5660300002)(316002)(66946007)(7406005)(7416002)(66556008)(110136005)(38100700002)(2906002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akZSV0JpMlFYbjFnR05mdXhLNDZ2dXBJTzBWWExJUkZLMmliZ3R4SlJNQnBP?=
 =?utf-8?B?RUdLVUhOM25NRGc1clZJOFNqSFZ0SnJmaU1qSloxanozcFhoRnRFM3RqYWRy?=
 =?utf-8?B?QnhwMGdWTjdWSmRuOXVQYlBnZkpiNFMwdTk1ZisxZ2ZGUVA4VWhodExjODNO?=
 =?utf-8?B?eldmdUg2Y3B6ZjcrSlZZaUlnblBLa3RIYThEVkkwTUVtOWttSTJpQ0tIeitJ?=
 =?utf-8?B?QWtvb25PZnBXdHBjdE9tekp3N3A0QVRibzE2SmdyV0hTOElqMktDdGlZVTBV?=
 =?utf-8?B?dHRIWHRzTVhpN3VNc2ppL1Y0c0NQTWROcVEzSjJmNVdnbU0wci9KTVhQTWFK?=
 =?utf-8?B?c0p3VUl4LzZ3M0hKVGpsUjFkSTZZZFpxeitPMHNKbDdrbkFFd3JTVjJRTDFv?=
 =?utf-8?B?Q3Q3Y0VmazVGMHdzZy9IODBPTFRBUVlpeG9sK0QwMHhBQjNnR0paRE9Dc2s5?=
 =?utf-8?B?dEo4TktvSHJZaGJ1WkZtZ1NqRG9VS2NXcnVuRHVoSmwvZEV2Qm9RbFZOaHhJ?=
 =?utf-8?B?R0ZqYVpHSEoxTHcrUXZDb2VuR1JJeGJ5V1RrdDR1cmtwZklhZHlLUFJmSHR4?=
 =?utf-8?B?djhNcmt5UDYxNUxNUDliLzVpTytTTmw0MDAyUTEvL0xHWGl4RFoyT1BhTU1C?=
 =?utf-8?B?dXh3VE1GWFVaMUhibm40QkthazBsMnFia1IxTHMyNDdnMmxaNVg5RUdrYllx?=
 =?utf-8?B?dUtSS2xpbkVMd21DUU9LZXJOK3RwZEprNWF4d2hZaXpMSXpFZ2gxWXZ5K01X?=
 =?utf-8?B?Wlh2azd0Um11Zk5BMWVJSlFsYjc3L0dLcmRXTmxIQ2h2cWdOaGUwN21KTE1z?=
 =?utf-8?B?bjF4aTQ5Tzk5U2dsTlFRYnIyWlRWTUI5VFVrOS9FZ0t2aW51T0l5ZGdKTkVV?=
 =?utf-8?B?RUlYUTZwRmM1TStnZDZ4OVYwdVZQSGxQeUpENzlwTlkvOVBGR1Zwekt0TzVr?=
 =?utf-8?B?OEM3NG1uNzdPcndGcFQ5RTBLSTFKTFJNTm9kQ0RpWUVycjAyUFRWSFZnajF1?=
 =?utf-8?B?aUNkWmxKOEFMSTIydjBwVTVHMkU3WFYzR0RwTEc2MXpJcTgzV1RXVHNvNXR1?=
 =?utf-8?B?TDlXVXZBWnlta2M4WHVWVWc3d1NPT3p6OTkydDFSbXU0L0lQRHNsdWR6OTVG?=
 =?utf-8?B?cy8zK0FVL1ZkUnNySi9rM1d0QlJKOSthV0VLOXUzSkNOQVM3SDE4SVdtSmJ6?=
 =?utf-8?B?cGI0ZGYrZzg5SzMwaXp3VXF2ZE40MUFRcjZrZWhDZ0l1MUJpR0M4ZzVxQWNo?=
 =?utf-8?B?ZE1zdVAzaFF4YUJWUndrQkltRmNSSWZRYzJqRm91SG90cURzTmVCdnNJR0tn?=
 =?utf-8?B?Z1lGbUtQWE5jb2R4WEpRRmVuVjliNjZhSTBFQXJ2c0F6VUgxTE9kSjV0SHNp?=
 =?utf-8?B?VW5lSlNiN3BzZ044VUxZeUlpYm9kdkdaUlZvdUIyMjhTWmRXd2NTcEVWRlZ5?=
 =?utf-8?B?SlVSbHltdDRReno0TTE1SHhXSTR0eDJVdTZwcXpBaWc1Z093anMzeG5QRFJL?=
 =?utf-8?B?S1pybkU1L0ZFeWJ4dHB4UUZqYk85MzhSQUFPNnZERlpkMlg1SFdLb250QW9u?=
 =?utf-8?B?SktWcnNKbGlvVFdZSHptSm14eFFtTis0cDZJcXdTMTl4cGxwdEN5OGxrdUVG?=
 =?utf-8?B?aUZ4SmdDZmxvU29tZEpGTFZRQTVHMTkvTXB1UGJhc3g5aFhpNE1aSmpsVGoy?=
 =?utf-8?B?ZHQwRi9DNC9oY1Jtc0YvN2hFSXdBZUZsUklGK0xQWkRxMGZUVXFQRTMvaTRF?=
 =?utf-8?B?LzR3ZEdQN01EM2RuUFhwMVFEcis4UGk3UGNOcmpBcUYrMS9IVnZZc2lNOHZH?=
 =?utf-8?B?cjgycGROWDAwbXJiY0xYczJ1SlBta1RZdDczUDNMa1dmQnJnbFFCc2xycVdr?=
 =?utf-8?B?TGhrUE94SytmZU5VVUExaEhvVDRWRTlnUnFWbitPUXhISHdFQXBMK1cvMEZy?=
 =?utf-8?B?bFRYeHJzbEdCU0JyNU1leEx4a095bzZqRjhBMmttVUVUWE9ldDFuaTJOSm80?=
 =?utf-8?B?eSs3Tm5JRXZuaEhLTnNOOWtOSWw3b3pNQVgrYW1FR09jcktOblIzQ3pSemhn?=
 =?utf-8?B?UWNBQ1RXNHN3djVDUm5PSmxqS1RzRWxERkVxY0NaTTZUdmUvR2h2WVRTbEl3?=
 =?utf-8?Q?+e5Bzg5C+FLcfjCsI6A4XoXG/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c194663c-3365-4434-0331-08dbbfa2f45e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 21:44:41.0105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWHUEPmD86w+Gc6zpVAnezdHhn+bxXvK0PYrDgxEplrzr5G7o6uM3K+L6E+KqSap
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 9/27/2023 1:30 PM, Reinette Chatre wrote:
> Hi Babu,
>
> On 9/15/2023 3:42 PM, Babu Moger wrote:
>> The resctrl task assignment for monitor or control group needs to be
>> done one at a time. For example:
>>
>>    $mount -t resctrl resctrl /sys/fs/resctrl/
>>    $mkdir /sys/fs/resctrl/ctrl_grp1
>>    $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
>>    $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
>>    $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks
>>
>> This is not user-friendly when dealing with hundreds of tasks.
>>
>> Support multiple task assignment in one command with tasks ids separated
>> by commas. For example:
>>    $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks
>>
>> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
> x86 area aims to have a uniform view of commit tags.
> Please review the "Ordering of commit tags" section within
> Documentation/process/maintainer-tip.rst and apply that
> custom to this whole series.

After reading it, it appears this should be the order. starting with Author SOB. Hope this is what you meant.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks
Babu

