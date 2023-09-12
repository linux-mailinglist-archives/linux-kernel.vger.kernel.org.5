Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EECD79D6D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbjILQxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbjILQxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:53:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37164110;
        Tue, 12 Sep 2023 09:53:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3VGx9/fCB4R/vx31hy5ijFhD9U1JUZi8Xj9aiFuf5k1z7RON9J+zrj1B4SK4t0ICZH0vo4s3lt6Ko8PEuCPP8cjftmWKanQLn882tAktrI2aZEApr8lJtpc+FfjiFXQFa/kQ01w2EWtvnmvX3QMjhXwFjtes1msYuJ1L+GyslugOO0UMRE4hnfe8AaqhrEJmDcKi73e8OjZELJiUAwbYCo4df6Ws6wWeyTOrtuuj6jaDl6bXxMRyaOcgrWR19UnNfPEQ9MhinXQ4EughSzIhO+M8yqlkH46fCKFER4/51naKOL8SUag90KkcysnezUp9k2XUJq8wIp31OeiJ8m8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBg84lw+Q+svgk9ZpFpZ2jgnxvb94T73VXWuGrw6g2U=;
 b=Lsq0Hv8rlfDhuDvPHf6QxIMuf4eCpyhXVyt6grCP9r61fPr9BWctMHYZHbgIjSjVwKONY8Pna91LKV96+foYQwkjfRWahdKvISaFqZdNk4NnhDTqtBTMkC/SP/qxFKqNkJAmQbkFXRVUTpksY3BF2EEQKevk9AhZ7/x1XJX3kO3UoPgyjWqG06KUP/Owg32hNhAulXBekXuwM2SIPlr20HBergydcAzW2dAjnzu2xmRkhVE9+ZpuQ0iuSIcSLGberDNHw7QfkW/tT45yPMkiKsImefdlU8C46Cva/NvbiJxTJTj7HphfB6nP3g4rGOaOmbRHX4f3uIrY9eSJ9rYe+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBg84lw+Q+svgk9ZpFpZ2jgnxvb94T73VXWuGrw6g2U=;
 b=mDZsaw4fAQEDiD1fHbU3EY8IeO0S+EsItTxWyqekp2YZwrg8wU9JUtcy2eSJ6PBdLusQE/9AmIKWMRM5fsWBvNzhEVLkDM9VRHmGg1Cte3KRxgV4muJf4Tt+P7i69gcHhWA5J/6zCfonHxlgXxwWi5Q/IlOKbOrrSNW48aaf6No=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 16:53:09 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 16:53:09 +0000
Message-ID: <1700871a-882a-b7c4-a33d-7466d92f728b@amd.com>
Date:   Tue, 12 Sep 2023 11:53:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 0/9] x86/resctrl: Miscellaneous resctrl features
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
References: <20230907235128.19120-1-babu.moger@amd.com>
 <080318bb-4237-b320-b775-3abcc09cb2ae@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <080318bb-4237-b320-b775-3abcc09cb2ae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0080.namprd04.prod.outlook.com
 (2603:10b6:806:121::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5163ea-a265-4b09-5370-08dbb3b0be86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHLLMzp5CT3LFXnGIhOjme0hSn7bQQtaDR5lDyhvumSwY6efo1klsp7oFhlMeO8tXj9kcVXiEWph8nlEvT5i1raDCyaxPgQGdOTXgNgOzKZzMH9aYhF93nFPtReIcVDQV5Co4+JbRhTcVIy5y/BYDRI5UMo1Cwp76J5XosnkmkC8JQ8Hq4EW5YLMBbHO6Pmp3OCaqFXS5j6TjmQfj5qU05TQcG7ZKvFf7hL8OxAzp11W75Fg5GeaSmWGYJmIX9bYjOlbacRQ9rfGGBmlwKK8gkTyShwdMn37Tl/dOPxrbMFgowAJ1L04xpYC38SKhIN4jUmYfDdkG4WHzmazQ/rOQMIzljpDZ/rD6P1/4gOKbiUczgoBZPc9rohNJaQ6/DajbEoZWrUeGSYjCLQm5Cu971ZDuTgaPHLRaR4g/R0vEfHa3ifyJSyd1bmAHpu5EMgaWZhMgDTpv4tCE2Osv5oRT4IEgTe0iW0JUXMcNjhkc9xI+yuwYA+qenq5J1R8UBz6uOuIbAF0w0vSzVeiOpdKDv3z5rIj7osrX3vbkd6aZou2L4Me63wZf8Qp6M6L0JpdoWVpMu1GPWN8xEmW5hWWCtv61xHk8UokBmAeLCPt5XJahQfOJUcd5r1H8xPeOtiMG9uniVQ49RrCWtZpQ+HOLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(396003)(136003)(451199024)(1800799009)(186009)(83380400001)(31686004)(26005)(66556008)(66476007)(41300700001)(66946007)(2616005)(6666004)(53546011)(6506007)(8676002)(6486002)(478600001)(4326008)(38100700002)(8936002)(5660300002)(316002)(7416002)(31696002)(7406005)(2906002)(3450700001)(86362001)(36756003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODdwbWZrMDVvVS8vWGpyVGcvRW5uR084djNFcVE2cS9rcy9yNkEvWTdLVGxj?=
 =?utf-8?B?MmcxV1hHRXFRYk9WNEtQa3NDTVVFbklLTjJSUi9BQjh1U2NJdFkrSE1iM3U0?=
 =?utf-8?B?OTU5WS90QUhpdmlmUVlGd05LNjdGajRHQllkWUdTTUdPNzZVT3FRblY5dyt4?=
 =?utf-8?B?SHlOWUhCWkVKNnBKOXRPL0dPZ3FHU2dVcmp2UmE4L1EyZDdRV240WlA1V0Zp?=
 =?utf-8?B?REJ2cENsait4TWMyZ3o5MmdHM2RsZkVPMzMvbjdDYjN3U0FpcGpqb3Myc3Fy?=
 =?utf-8?B?UWR2dWNvRU1CMitITE0wMGJ1UmxxS2hNN2p0dlJIT3BjMVY1QThjbDdIUWFm?=
 =?utf-8?B?b2ZWbVdaZjVxeFphTDMrdUozdE5YckVKVS9VdGE4THZseFNkRkQ3U0NvMFRE?=
 =?utf-8?B?RXNLdGNLdEphanljODBNcnJva1FFSnI0WEd0eVZzNXFPUm1KZXErR1FoQ3Zj?=
 =?utf-8?B?bzJIUEVDM09iWmoxd0VzSThqdEFEMXhTUjNVejVVbzhYZFRUY1lNSURTd0lp?=
 =?utf-8?B?SjZyMEtvZEYrRlpNTkRnUUFoVzZjeklBZU9rU2VzOSswOHJTamxJS2JKWGdD?=
 =?utf-8?B?bHRBQ0N2L0R6T2Zjd1gxYmtFV0JLdit2cDJ2azA1SXdkNFY2b1UzQUtnUjNx?=
 =?utf-8?B?Q2QvT1lzTDNJK0pwSTczYUwyT0NKTXN2TWQ4emZsZlBjUHpMWEl1dnUvZHJ3?=
 =?utf-8?B?N1h4eVZWZ2I0SnlaS25yZUxpcXVhNTdsbkxlVUQ4TXYydW9QRHlvNktOOVdw?=
 =?utf-8?B?c0k1MzZlYnRyTVBGckpEbGd1ZVlKRjVVSXNNcHJTK3VhOUdrRHBlNlV1clR5?=
 =?utf-8?B?ZE1PNCsrRTJ5dGNWZjRRalZPVFlrd01PTDVwUGZtd3E4N0JkdnFtRngzM3ZZ?=
 =?utf-8?B?dW5xSDd3K0ZHNHg5TFhoM1VQd1RwK0NqNXlSdGNHSzZPS2Nqejk2R3MvdkJT?=
 =?utf-8?B?WTR2NlZDWUY1UjJMSXFmdDU2aDhOZk8xOGlES3BuTmhiT20yYmx6a2x3aGgw?=
 =?utf-8?B?cHlYQ3YzZ3NQZkdlY2x0TjNqbC9Rb3NmeFZXS09vcHpSSjdDZ0huc09KVWM3?=
 =?utf-8?B?UG5PeElmbWROZXdQRUh3WGpaY01UY3ZnSW1VSHNaMTN3cENlUEVhWFNJVkpV?=
 =?utf-8?B?WlNUcWpGc1lNT1BUbEFMemRPb3BETitOeHZZSnQrSG9sNDVFZnlURmp6alpK?=
 =?utf-8?B?SEZlNitqaU5sU3hjMjdXMnVJWUk5V3FLcWJCZ2NIelBSR00rL3M2RVVSYi95?=
 =?utf-8?B?SmJteUxrSmQwbzNrQndPZklyTHZnUGZLWVJPZXFma3hkRDFGRnMzK291c0Yx?=
 =?utf-8?B?emdqZHB2V0VsMGY4ektNejRJV1doQkRla3lKejhlTVA1S29rUi9LWDBXWXdR?=
 =?utf-8?B?NTY0K1IxeElsVHoxMVM0RDM3WER6TjljM0h1c0pNTmRxb01IQjY5cHdHdHVt?=
 =?utf-8?B?Z1VCMVhtb1BzRlVrMlFVZHlKMFV0K0hWRWREc1lkd2w1UnhCVlBReHlsT3Nr?=
 =?utf-8?B?ck9lMXBGSHBBVFplYnlXa0d0VTNVS2xXR3ZoTkFpbWVoS3BrTzhhYUgxSHJy?=
 =?utf-8?B?ZFZZSkZ5TEtNaHZUU3BDK2xrTE1oa3lQb0dRRnliK1VrYzQzRHdOcHFOeU5m?=
 =?utf-8?B?elNFQ1NPWTJmZ1dnSk1GOFZpWlBiTVdIOS9XbER3cVEzKzAyRVp2NnIwQzhQ?=
 =?utf-8?B?dXJLT0NHUVpIeUlHQmwrMVZUYXNydklSVWVBSEJaeXRaK0FGb3BKOHRIOTlB?=
 =?utf-8?B?RmUraGRZbkhuL3I4RHpkZE4yZVcvSnVDSHlnL2t5cWV3dVhvdWVjengzMVR5?=
 =?utf-8?B?Y0lJQzBMYlh0dWlzR2hpWnpDSTZwMVFhcVJKSkdsSVNXUjRVcTFqT3QwSHdu?=
 =?utf-8?B?cmlZUVl1V1BQZERHOWJTdWhmZGI0b1ZOL1JhOU40b2tURlpJY09VSVFoZnYv?=
 =?utf-8?B?S1lxL09JYW8zcXYvOWNKKzY0QTBjQWZJN1FaY1hUdHNvY04wU3FUL1R2UUo4?=
 =?utf-8?B?ZDhGck9JcTRvc3BEU0FHUEVySDRyNWZjQ2NXYS95SVM1N3FhYUlMZ1RlUFhi?=
 =?utf-8?B?Z0dHSUUvaFRTU0dOcmx6QzRnbWhNRE9TKzFkTTFBSGl0Y2Y3UmJoMzFoYlBp?=
 =?utf-8?Q?Ado4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5163ea-a265-4b09-5370-08dbb3b0be86
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 16:53:09.7784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7w43eRch2Nzdoy/dvzuHmLrczixD3AzHQ0GYjWa89cdjp0zAchtZlZKzz9ckLKe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 9/11/23 18:08, Reinette Chatre wrote:
> Hi Babu,
> 
> On 9/7/2023 4:51 PM, Babu Moger wrote:
>> These series adds support few minor features.
>> 1. Support assigning multiple tasks to control/mon groups in one command.
>> 2. Add debug mount option for resctrl interface.
>> 3. Add RMID and CLOSID in resctrl interface when mounted with debug option.
>> 4. Moves the default control group creation during the mount instead of during init.
>> 5. While doing these above changes, found that rftype flags needed some cleanup.
>>    They were named inconsistently. Re-arranged them much more cleanly now and added
>>    few comments. Hope it can help future additions.
>> ---
>> v9:
>>    Changes since v8:
>>    Split the RMID display in a separate patch. RMID is a special case here as it
>>    should be printed only if monitoring is enabled.
>>    Made rdtgroup_setup_root and rdtgroup_destroy_root as static functions.
>>    Added code to print pid_str in case of task parse error.
> 
> fyi ... I found this version difficult to review. The cover letter contained this
> high level list of changes while some patches were changed without getting a mention
> here nor in patch-specific list of changes. I ended up needing to do a diff with the
> previous version to get an idea of what actually changed.

Yes. My bad. Should have listed the changes on each patch. Sure. Will do
next time.
thanks
Babu
