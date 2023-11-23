Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCAF7F60E6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbjKWN6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345628AbjKWN6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:58:15 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DAA1A5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:58:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+J05tgt9SRBiIUHQqJ+s2C3uaz3Orr2/DPXnUVD+jazpaCBI7KDVD2sI4yVx/MMqZCnZkbgydVpIbg8hmuvaAB/2cN26SuSK4OBQTFEw9I2ziqXINdp82Njt346IL81QfYvQ16O+tGofxYNzStE1DsCpOD+W8adyHBJ2gs51aK0wBbpez8guhyskon4SZdPalpE/DG9/OOWVsuzhMeZO4h2T0DfQmtP1MH4SNmRh8fwK9yEIEDGUYsezg1txzpJ1EcBmfVYTMfoilxHLTkW6rKKk1E6AfIGLMS3Ne7m2AiYmy4PGSFlgXH2dC9eH3lDnSYfD4/asg1IGDCZX84bjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE+dDhi3KcrAhtsJyuq2xfWswqmmhHG2eLlsQz7xLHE=;
 b=Pe97bIQQ3gBDLxr9Q9kM01+cvBn9Esds/xyDVPpxX+GB1Lbl6x9U7Zg5AFV3vzalqRMXOc9THf5XtYz0AlVVleVrwkF6earsHQm0CIIRwpraVW6jmMvGr//+kPMymFOpMEfBdo+WZr10aPTJxfXYR1TW9Vv8yjbQ2NweouOj6WTHB9C1DGFSqLZS3Se+k55cya+4gcLS7DJRu42Dj/hHscqi5TSv0sXGkl7k+OTxaMvbeGSBwCfD11LSv9bRVIoWUbAZo5GrAO2LnvuGyNFZbC+hc9fwVWg44sW3WrReD5WEwh9OvpFM54w5u93E8LzUSPtyxIlI5fuDb0ZL06tpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE+dDhi3KcrAhtsJyuq2xfWswqmmhHG2eLlsQz7xLHE=;
 b=EX9/vTfhnT0RiWNyFhajDSx36F2WzHIG4T2iJ4rnsiy2oPvn66d///0RkpuAq4BFhTrjKj9+eiJ0e6eDsT2MQYnajiHYy2hoPnELfMxvRaNRjsc+LnDRKDAuWzlR3mjt17lZ4DtUGhmN1B82yG+6sf2O7lBlz3NbKWO6q33migk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 13:58:16 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6d62:cc7:cf1d:86eb]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6d62:cc7:cf1d:86eb%7]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 13:58:16 +0000
Message-ID: <ac9d4f7b-c7af-4d21-b0b8-d0f188b94b0f@amd.com>
Date:   Thu, 23 Nov 2023 19:28:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops support
 for acp pci driver"
Content-Language: en-US
To:     Marian Postevca <posteuca@mutex.one>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <87a5v8szhc.fsf@mutex.one> <ZUQssoD2rUHSYQ2v@debian.me>
 <610d562f-0bbc-485c-ad63-9534fa4ba937@amd.com>
 <d002ad6f-d908-4cf6-afcf-bf0989418e72@leemhuis.info>
 <6085d2e3-f28e-4d1d-9863-8275931430e6@amd.com> <87fs0x4fn7.fsf@mutex.one>
From:   syed saba kareem <ssabakar@amd.com>
In-Reply-To: <87fs0x4fn7.fsf@mutex.one>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0213.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::7) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3c6daa-405a-400d-d299-08dbec2c3dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pw90a6Uv9ny0TndwizQLTj87eWFSJXFHdRjkZWFEYsav7XXLfa97xIXNkUVIjc4ZmvmBKi2tALkDg5ZKSOgww1JCt+Wj1hn1F2uK/8MYAPw1Jv9QpIqxxGKiINsCEOf74KVL7sp3KaAOdxnNBcNUV5rnBVL2rFaCLzjdNw+TARf8aejSV43JuHFkpNYzZivMZJIq3pkF1Pegv+ntrFvCUHwWIg0H4tgLGe/iGoDOaTzo8+WTU62uXqq/hKJxIcWBxZflDPmPAUGGhGmUuz6N6vtE8DKpvTUNHr+WWGEZZ3bas0wkSq0Ocwv0MESrzO75CY9lNw9HA0mF9Rv1Hnzpt4iUGFR5ndosoCS5ekW5ZmnSa1ucnceFB3JYj7ZWiSI4r/0DdDjY495UU1pc8EIhZvxHpVFHi94F/FrAis8bykIKLUAvRd4kogphxIgFplK1aeKAeQeirHhXvBkvuwK3rh/1IuvzYKLaHDh0pYmAnT08vcuzjoOFUUTa3dCMQrAERU/ss5HbCamObU1g4Bo5g+bEGgW2dRQf8kjWwLr4bB3duWuHStO59Q8SqmFVHmimgbHGrsM7/m8u5Lus33NG72fvFO0daiWqYyQ+OuExWZPd5BfJDlx+Ym8P4deJdksUnc7lD9llbEB9M4g9434Iqsk5M+AKEqCXgHe85yxfSehkWxra56JWcFELZLDh3nEn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(5660300002)(7416002)(2906002)(4326008)(8936002)(8676002)(41300700001)(66556008)(316002)(66476007)(6636002)(54906003)(66946007)(110136005)(6666004)(478600001)(6506007)(6486002)(966005)(53546011)(31686004)(26005)(2616005)(6512007)(38100700002)(36756003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTFTQVhKc3ZIdTlSQVR2N2lFZktHWnh3ZmFVNVk5Rit2WXJYRXdFVWVhSnBU?=
 =?utf-8?B?ZTFBM0pkbElWODB2VVpVN2wvK1EvdUJsTk83T1FlL2FRRG1MYUtiQWVxeGxZ?=
 =?utf-8?B?UkdxQnhCd3NaTzRiNXBQRTV1VytvR1Q5K3pSNnJQdDQ4Z1BNN2NQV2Z5V1gz?=
 =?utf-8?B?ZGRRcVliRUN5NjZWdEpYd0pXT2xhRFVEdzdGSzZwei90WXBJbEwzc3JpdU1r?=
 =?utf-8?B?SUhTZW5jVTBabnJ2OGpJL1BiYWFRS1lmV0RycmlibU04NmNqaGNLRE9qOSs0?=
 =?utf-8?B?OThnY0R3R1NrOXJmUERraGdTOHlEd1dyUW40T2gxSHlwb3NwbGcyeDg4Z1hz?=
 =?utf-8?B?QkMwZDRTazR5S0EzSSt3K3pjcTNmNElsYUFSUytTdCt0YnFCUUZwZW5OOUJo?=
 =?utf-8?B?ZlZaWEF3WE1PSjZOZmRMUTZOV1RyUUVzUXpGeHJheHNsUnMycTl6dmpuMXRo?=
 =?utf-8?B?UFJVTmhMU2NaRTc1SGVVRHkxOHVFMzd1ckVpWWlLK3pucURtTXMwelg2YzRB?=
 =?utf-8?B?ajVOU0NGRDNXS3d4Rm1aTklSVU1DdzB3VmQ3Yzc4d1NuZEcxRE9jYjZqbjRB?=
 =?utf-8?B?c0JJaDZ3Ri9la0c0TmN5UmtTamhsWUhYNCtGWktlUGVFWEo3dVFWRWpaSzAw?=
 =?utf-8?B?TlNsN2d2ajNzS3pmNW5xaFYyVEhkTDVISmpPSWNTRWF3clJQZWdPdnMyNnJ2?=
 =?utf-8?B?TkZXWTd4bGxpa0VWL3EzcnZkYnQ2WW9EcjloelpZQlFwdGQ4UTFSTS9WMDFv?=
 =?utf-8?B?NlVDaEFiT1E3a1hxcHhmeDdQRnBUa1FzeEw5bkVram9DSzgwT1BiTE1aUnRu?=
 =?utf-8?B?SnVUNS95aXh2V2ZtWWhvRjcvcDlNTnIyWlE4OHdSUGhES0ozTG5jb09ZLzVI?=
 =?utf-8?B?K2RzMmoxaHNBR1hFeTBjT2l6SVlFZk9BbXBKZVpLRTBlLzFxeWxjS253K3RL?=
 =?utf-8?B?ejVTTUJORWxSc0V5WUUyV1FvbzgyMkY1T3hZaXd4R1VuNWRUN29yVWpNcTU1?=
 =?utf-8?B?U3FzcEJDaFN5bGRURGpaZlU0em0yWS9ISWVtQXpGYXozZEk4cHhvYW5WNGps?=
 =?utf-8?B?Q0JrbFEweXh1N2RtbktRMTZ6eFEvNXN5MDlpTzlQMFBYdkZNYy9EN1BkU21Y?=
 =?utf-8?B?dEVmYXg3eDloZ1I0eHRBRk9kNmpRcStWVGNrcEtlUGE5REM0bm8wMVJGbk0z?=
 =?utf-8?B?RG1DazlEOFl5UUE2dGJvT0ljUXRTZzB4YzJZQVRPZVg1d1lVUzRROWVJckVB?=
 =?utf-8?B?V09GaE9JNWNrRkJPKzVkcElEQWRvdmZWc1lzN2VDZDB1ekUvQlYyME1FL050?=
 =?utf-8?B?ZzZ6cFRhb1E2KzUzRERuREJXRVpFTkNFY2dyYWptNDM0NE9neGxIUWVEVXJW?=
 =?utf-8?B?UkpXU3Jmazc3ZUQ4YTMvVTMrczJzQ0owQWJZTXV2YnV5UTRmZ3FtZXozanBw?=
 =?utf-8?B?RmtPWkxjZXZhcVo5bFVvTHlvbEF0MXdPV1o4T09jc2N2eUxxL3lxc2dWNHBY?=
 =?utf-8?B?Ty90NGZVZzAzcDdSaHFPT0t1WkM2QXFzYXAzQ1VmT29xdDZ4ZThxZFhyK0Z5?=
 =?utf-8?B?ZG90ZGZOTmorb3FmNjdZaDcvcURUR2RzVkZHV0JiZWhDSm5qTmFWOVVPYUNZ?=
 =?utf-8?B?TmFYUU1yUkd2ZGZrRXVIMkNLZTJqZnhWcmxLUXE1OWQ0Vy9QV1J0c29JYTY4?=
 =?utf-8?B?K0lRd20xWi9tWHdkd3Vsck9DNDZIcElWeHVLVkQ2cCtDTGFtNFFTSHVWUVdL?=
 =?utf-8?B?b2YybDRCdGJ0d1dINkxTZ2kwUmkydi90UnFCM1BRb3NmV3Y0V2NCaWtXbW9o?=
 =?utf-8?B?Rks2TWwxWWVpRUNDTnNGYlp2WTZzVWtNTGhpeE1BNmpwTHhicHMzQU9vZ0FZ?=
 =?utf-8?B?Rit4Vm1BMHZlQ2xMaUlvTGhmR2VGbDBoMURGZko1OEttdjBURDFNbG5KQ2hD?=
 =?utf-8?B?cm80M0ZoVXJIUTNqVEdlVHYreGUrWWZvZXIrK09WcVhyZ3FpSmdwNEtEOWpP?=
 =?utf-8?B?N0NIQUZBV3FTT05FTnVZZUJYUW1lNmZraWx6ZDczTGVUYmpJZU5vNWdVSjhQ?=
 =?utf-8?B?L2t2MFpxMmppZkRwbzkvVElIczNoRnpXN25XZGdYVFFtUmV6dDZUOHZtY0Fi?=
 =?utf-8?Q?JRE60jJsJjjGQQgb8nedEb8Dt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3c6daa-405a-400d-d299-08dbec2c3dcd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 13:58:16.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEMeBAjEuiVd2FBS/LDsdGRCRKP1QYu8dXV3GlhzVHzDpwnD/tIlSMwzlNQnISxkJ/Anm9FExCLpnjPzhHUDkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/23/23 03:25, Marian Postevca wrote:
> syed saba kareem <ssabakar@amd.com> writes:
>
>> Hi , We have up streamed the patch it is in review.
>>
>> Please find the below link for the patch details.
>>
>> https://patchwork.kernel.org/project/alsa-devel/patch/20231113123345.2196504-2-Syed.SabaKareem@amd.com/
>>
> Sorry maybe I'm not understanding here something, when you are saying
> that the patch is in review, where is this review being done?
>
> As far as I can tell Mark Brown only pulled the first patch from your
> series:

We got comments for the second patch and we addressed them.

It seems it may be stuck at review stage as one patch got merged.

Will resend the patch again.

You can find the received review comments for the patch in the below link.

https://patchwork.kernel.org/project/alsa-devel/patch/20231113123345.2196504-2-Syed.SabaKareem@amd.com/

>> Applied to
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
>>
>> Thanks!
>>
>> [1/2] ASoC: amd: acp: add Kconfig options for acp7.0 based platform driver
>>        commit: d3534684ada99ef8c0899eb28c62b4462483ee19
>> [2/2] ASoC: amd: acp: add pm ops support for renoir platform
>>        (no commit info)
>>
> I don't see the second patch in for-next.
