Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F4754517
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGNWpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjGNWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:45:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B523A8E;
        Fri, 14 Jul 2023 15:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpdMa2y9L9cHhQ0vGr8YIWO+j4WwF3X2qVzMddRdge1bM2BdnOipK0NG/qWHwse+MB0QQKINskZ9iNT4jNVQCPfctC138mN7Oyrjpeulkw5AP+ug8L3QlzCCYsk6artkLiK57BTUclUhE9iJKzhR95K/A0vdzHVz88/cljl9UugdaM/ktWI39bPEupTjS2NQv6RplZRGW8y5AE76+0x2+a+LDkP7Vqc7J/oK+PmBwTNBmQSPHGO3oMpn7ChFN/nFoy9UdcwH/NulZjOlZLYRzmYcIObOh0I5eo7mJeod8ycc7JcbId1NEeLtXjZCyCnJ5uwPsMDaHA68NomgGWrhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvgTWB8ij1cailG+LNFSwbQQGG9zz1+TVijvhnN9Gik=;
 b=JyIBBmlx4ug0YufBQ6eBXV8TRaZDsa+t4GD8kvnbN2YQVpyjqBgXlKY37PwnAthPMoR2evxStSN+ijYfjABaeIYItNmWrRnUMG3bM8yqt2KebkA9xf77ObGavBKVF7Iv/0uVhq+47VqEMUFXh0BUa4tHbetbtpbiYx6SXarUxgdN0qQNT4bXTMACHOhwyxlIz9Pe5J9SF19o3CpCWosOO6wyb7s23BBujg8Nm311qLUN82CubBlTGcEImA2Jr0xe+w+IeHswtgIbGag/HdTpf+suXoibJNvyQr1HKvwRImtpcoAQYi1iwwvSF7a1CwjoOlXv3Kg+lGqbiEttOpUdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvgTWB8ij1cailG+LNFSwbQQGG9zz1+TVijvhnN9Gik=;
 b=Qgch391zn4QNSz9N4FzV7CJg7a9opIdSH0drg7hd2MBypiiPLQuFv6MUufP5MKhRkf+zjVC56UQYuYr9mtBtcQw3NzWIF21d+/ZIdvtKZ2vTQmPiiQO2wvt9HIkWdZ7W9tqStAg0hORSR0vEWW9+w0vBBvjj+pCq5gYJgEDeqx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Fri, 14 Jul
 2023 22:45:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741%2]) with mapi id 15.20.6588.028; Fri, 14 Jul 2023
 22:45:37 +0000
Message-ID: <e790c7e0-324f-a36f-b23e-013db0489441@amd.com>
Date:   Fri, 14 Jul 2023 17:45:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 6/8] x86/resctrl: Display CLOSID and RMID for the
 resctrl groups
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
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564611100.527584.7981937236207103115.stgit@bmoger-ubuntu>
 <94694f76-62e0-3751-3791-936db8b7e3ce@intel.com>
 <f443880e-fad7-b61e-e832-3cd180ad3a33@amd.com>
 <e051f7f9-3d51-e45c-f8d4-e3700d68aa92@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <e051f7f9-3d51-e45c-f8d4-e3700d68aa92@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0047.namprd05.prod.outlook.com
 (2603:10b6:803:41::24) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 0105673f-98e3-43e4-bb88-08db84bc0ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vzcKJQWD+KY7cSDiszJm2jClU72gbnmXNLf7FuuFZ6BGkfD3jtHYJSXv5aQN03wxvgei+88o3WHpWFUUP1Fo9XUiYeVrMC6oUlLwwez6SZMc/UC6+WIPcrwXUnVRrDZxLepNlA/aYeiCiES9jeaNo5k+apF8wi/pl55k/DgIIvhuEw4kiitVlL9CQ8mSZMmrLH0QbXEGX4838Fxut6dG3ovqUHZhHJz2SnhBjwJGPwvtTOoEAbjPPcVGgFG/dhcuF5ldnymCGjxZf0ceKJESkzFT3W3XztjYLWVnAzB3rZ80Jl3L9hDc2p7cz5gvfVjTC7rt8Ty7+ZhOd8CjBSl1Zo6wTZUnA1xXKv0OD3o0mW0ONLfYnOlm34inGv/47wPBe8J7PIjAS+LxT3Prcy5asJC/5GDLxDeMv6bLdrBcUBfhzbO6bW32RSaWHSPJXGAUEcA+htEiWVTVzpBYZ7BW/J2B13E3lbWrYMZ5ZiScw1sfEWt2HP5G6hzzJGELihXWF8vMrnypPHBl2mH5oSBnC3/5tScTZH0MibPTW1aCXBZZ2QIcRPudA36FLuKG8Jf2lMY1PPUnKOMdhVwcbdPftDYHwEcNjr7pNTgVPkunF7Aaji1juwzXgRS/oyHStr1+Pwcm++gldrWxa605h9dUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199021)(5660300002)(31686004)(8936002)(8676002)(478600001)(186003)(7406005)(31696002)(6506007)(7416002)(86362001)(26005)(41300700001)(53546011)(2616005)(6666004)(6486002)(316002)(6512007)(66556008)(36756003)(66946007)(2906002)(4744005)(66476007)(3450700001)(4326008)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjZ3QXRUUlJkNlZzUkh3NkkwRzN4eEpGUlB2ZUVBRUFXWWJZRE4wV28rdVpk?=
 =?utf-8?B?QmpzYXJ0RFRzb2l3cllseFR1VzdrQ2ZucXVOQk5jVEJwREJHaEQza2FZZWdt?=
 =?utf-8?B?MDRQM2UzZkVGMERlZGZxNFNOa3YvdFV2OFd3WVBtYTl6MCtrNGFrMmxDWWpm?=
 =?utf-8?B?eHhzR0VMa2ZvVUNjeDA2MGlhTU1NSXVnT2VMMkJjMTN4QmhIQkwwdkJISXBW?=
 =?utf-8?B?R1JkM0lweXRQaGs1MlJsTDBaaG10QndDQzd3VVNNaW82QkhrbUx4UTl4RW1O?=
 =?utf-8?B?M0Qwcm5mTmN0dWY0MG1qdjI1Zm1HY2h5Q0dwbmtGRStZaDd0aEhFd0hDUzV4?=
 =?utf-8?B?bU1GTXNDMWNKQWZmUTdUWGdNd3M4M2R6Y01XeFkvVmJVMUcySHdPVWUyOUQr?=
 =?utf-8?B?cnZrV1pjTURIL21sRzA0R0xYM1NSVmJWbEN4T1NiZEpLN000RVBVd2dyTE5u?=
 =?utf-8?B?MEpIaHBzck9BUHBmUDlncTVjbnNEVUdTOFpoT2lreXVMemdlVVZCNnlUWW9Q?=
 =?utf-8?B?NG5GY0wyMENPb1VxOWxaTGhuVzdQWHEvL0ZuVStNR2JMeVFWVDc1K2EwTVFG?=
 =?utf-8?B?Y1ZkTGttL0s1RCthRnBSL1kzVHZyQ2dVbVIvODZIdnV4bytqUExTYzNLeDBw?=
 =?utf-8?B?NmRKbFVzS2lLa09kemtKRWhWN3dyVDkvTm9CWkhSRHAzZGdKMkpVV1BOSzJM?=
 =?utf-8?B?SjAzNmZKdWZjeWV0M0NyczJ6UXdJLzBVR01vVGpEYkJ3S0dTVGlHL3Jxcm1P?=
 =?utf-8?B?NTBFb0E3dGhzdW9acXd1Y0ZXcXljRDdpSDRnRU15d2N0aWpGNUNPVkR1SmU2?=
 =?utf-8?B?aHdDRkVzS09qUFpyallkckUxd2gzVlVocjVsbFloWXdBelVpdWk2MnpwdmFI?=
 =?utf-8?B?UkV4WTRnMExZa1BPQXpCM1lNV2dyRmhjV2VsYkxpMmxHa3pPVUg4WXhYeXlw?=
 =?utf-8?B?QWZLbGIvZTM5d0Vyd2VJQVl6T1JHZk4xalc3WmRYTE9RaytObEpGNzR6ODV3?=
 =?utf-8?B?L0lNVit5VFdXelhjWGUrWnFSZ2hSRjFIMUF6K21lQ01hRjNkczIwMEtuL3Iy?=
 =?utf-8?B?Y1FvclJCcG5EaFNsWmRLV3REcTVNQXEzckZtaXBpbXFPbENkRTZ5M1JDZW5D?=
 =?utf-8?B?V2JWZkwyb3NSYUsvU2dna2lCRnYrUjRQZ2FjQzVaVlc3N1JrUGV6THgxb0xj?=
 =?utf-8?B?YjEybmgwb2ZmNjB2ZktBRFR1bUFpcXprMTZIUjFNeTZzMzh3TTI2ZVRWdk1G?=
 =?utf-8?B?T252THVTL2diN25pNVRjbVVZaUNlSDdBVEhIaG0xK2VsUW5kKy9DZTJsS2Rv?=
 =?utf-8?B?b3JEb1RhTXI2aEluMzRFZHpTem1WTG44TDhPeVRJTE9OWTNkL3VPcE1od3Bl?=
 =?utf-8?B?UkpvTDdvcm5TdzNXTzQrMG9jWnBxMW13WStBNVdNV3hDcmJZMzIvc200SVRq?=
 =?utf-8?B?Q3VNWmxEdFYwemRMcy9YclVKeDJVd3lkK1hJMk9ib1pac09kc1dwOFhUZ0hK?=
 =?utf-8?B?SWk2QnFzZFlMbFdqZTNzTnRoNUZBWkJ3ZzU2enROcGJkMXg2TFJhSkFROWxq?=
 =?utf-8?B?Z1l5QUVCNEhjVWttYWsvaFJhZDRRVVU5Z2lqZEQ5cXRTMmRnRktXWndtNE5y?=
 =?utf-8?B?ZFVraWROOCtRanlSajFPdm1XMGZjWXM4OTUyR3ZrdklReHJxWTdmSi81d0xV?=
 =?utf-8?B?NkY5Y3dNYkFwTFlMWUxZY3FmbVowYzA0UndXMnNWQUhsWUlDeDloUkt4cysy?=
 =?utf-8?B?MDQrNWV1T09OWUE1T0ZDNktFRnJQcmk1RDlEM2hnYmlsdzZwb09TR1BjTnpS?=
 =?utf-8?B?b1RSMjUwSmlURkRMZ3BOZktRYTZHQjdIOGxaY1JJQ3F6ZVVnK3NkOFNBa0Jz?=
 =?utf-8?B?Wm1hYkUraUdkUDdMdUEyMFl5cDB6L1hMWXF4cDFNcUJ1MUJ5RVI1NXB6ZERF?=
 =?utf-8?B?WDJEb290andiZDNUWmhQdFZSeFZWQXVycnVwdTU3R0kvZHZhT2lYM093ZUFw?=
 =?utf-8?B?cTBjVFV3VUVRd3JCOVdRbWl4MnFjOUJMZzBiMkMyL3B6d1JzSGVnemVxUE1C?=
 =?utf-8?B?Ky9BdFZKcm1RTUFjRzNiSTlxMEY3UlpnWGd0OXJaTVlHbnRtdmJLdzJBVjQ5?=
 =?utf-8?Q?PyUA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0105673f-98e3-43e4-bb88-08db84bc0ae1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 22:45:37.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUUQf6JNm+eUT2nZuyPgYGO/G/cvlP2Qe2pyAxPxvSkEQvxpvJcqjfKIez4SNmFQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/23 16:53, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/12/2023 12:36 PM, Moger, Babu wrote:
>> On 7/7/23 16:45, Reinette Chatre wrote:
>>> On 6/1/2023 12:01 PM, Babu Moger wrote:
> 
>>>
>>> Could you please add a snippet to explain the file naming choice? Just a
>>> mention that this is done in support of other architectures that do not use
>>> "CLOSID" and "RMID". 
>> Adding this.
>>
>> Other architectures do not use "CLOSID" and "RMID". Kept the names
>> ctrl_hw_id and mon_hw_id to refer "CLOSID" and "RMID" respectively in an
>> effort to keep the naming generic.
>>
> 
> Looks good. I would just replace "Kept" with "Use" since this
> change introduces these terms.

Sure. Will do that.

-- 
Thanks
Babu Moger
