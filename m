Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247CD770291
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjHDOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjHDOIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:08:55 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D420139
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:08:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbyE5UhnPMNvxTSg+XiW++el62mCdTVdmZWhm5YOQIEB2mTZodRnTT4HEvzzk7UmSM4UeVvDjJt/iuTmUol1K0DmsxDzUkdoRTeF5A73JsjP9VKeSYvE9bdqWOh97mfCKtEPDs50ih8vLpbF2kYMk+1WLm+uukCUows943Aj5nv14pIG1mGLjvFbyMY6AtH3ETwhRI8qsYBqc6gFtwugALyyr79rEYfOh4GrPUlNENeS6Uv6G0c8PZ4EkHT2zS3bK96rdEon+/gM/2fxx5YiaFLtVbIhDYZBjZynA8QuJRqc5G/HIdBBEimZXjPwWCsT2/IBoKlgI8dmDscYXYcXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yj8TNtfOfcl/chGvarKALxeCcNncU97w11wCfKS7g0=;
 b=IJBiI5RPdYyaX1ssnTcKU3ETHL0tMsbVkyOi78OCJlCfsYoZAUqR6lTofUUjr1u99yGkd4Y2kQPGgbNGxHyAMESsSHCgdKPscSTuBEFHSj2HGXchu7zO/x+qJtfBMuHznxRyFpTAfDndH+RNxlVlzec9+zwMgce063xeuK00RWI4hrvxXYsG8VtGZS5f9wxsUbbGfmlz2bJHfVtKnxKF2hzu3ROcloE2uOgUmJSCZIF3/EvOT2hsz3pAabtQQlwx9vuZRBvtS+ErQA1C3mzzXPXsw5+jkOTm3NYCOIGMyvj91sxU4dQTQoKqy+WkFIjxDv6ipVCupjpgilnrjrNO5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yj8TNtfOfcl/chGvarKALxeCcNncU97w11wCfKS7g0=;
 b=R/mePJspPwPUYz0PSnEqMW4IhOB4z0QALBE2KDS50x0ebN2Jr0LxHcOZa4TAbUoYPz7DkY4dFGOuFA9DfBiBHGmWtx0y92tt9bgsv5cFpoR3jHtNAVsYVmO+eeoL3dUwSRrimsfXUm40rpmx4pDr240AKTIXDl0WBp3X34urDhc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by CH3PR12MB7737.namprd12.prod.outlook.com (2603:10b6:610:14d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 14:08:50 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::45a9:7ba6:5c38:d3a]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::45a9:7ba6:5c38:d3a%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:08:50 +0000
Message-ID: <fcb8f03e-bad1-966c-d454-b7ef7cb62454@amd.com>
Date:   Fri, 4 Aug 2023 19:38:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops support
 for acp pci driver"
Content-Language: en-US
To:     Marian Postevca <posteuca@mutex.one>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org
References: <87a5v8szhc.fsf@mutex.one>
From:   syed saba kareem <ssabakar@amd.com>
In-Reply-To: <87a5v8szhc.fsf@mutex.one>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0145.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::23) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:EE_|CH3PR12MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a3e681-f220-4aed-f13a-08db94f453be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: umFBSorim5YolwQqSxq26Dn7iGOMpAAaTfSr5E4EbR4N5mMCvcmgXspEANI3yCwNG4VbOgQjqMS+iidOWyp1Pv+4beDLJAt4c5WeqSxogPNUI6mklZKyRnHSlHk3I8rlsYACULp2vlzZbh9UhTo3PkDKRc3I0s4q5y9gUXwwp1QVCYKDMe93ZMu54BGKTUnenT+hZjIo5I9oHXXnJIoRPlTb/Zg+YWQFpdjlS845xtenCkIGlOblZjS1ZG/DioA9wUsFYj8hOcbWe0d+FekiLQO4WjiqjZOh675ilf0g0wRQXKh+PHnYKtYssO3FCVRAcwzLggUPgsg/OFzT2UEIfVKr1u+BusJNlB8Vd1daH9nVL9jb046S5Uw0yXkwSX75EMgtvh21zWlYRfjvWCOk0bw4K2vrNlmZqiyXYQ5EorcIq0lV+AYQRzLKbJSYU45su/qeOT70tJhlCRqy9SCsSO4WTl3WePpTDsxmeHl+EFQ1E9NTZjufZTXzq4qgfvS7oTea3V09g63+/R4CsYtjnfaoCHJe4FqxN6UOQpWWiQ9jUjZxWf1xTwP6CLt2lA+xdUzAL5wXm6n71XWEzPa5XCuopBjojVIQgZcizcP/p9+57Qu4PSAJSkKHf03fSmDK+I0611EDF5iK3LzVVkXg+zIm0DQq+Vda8+s0+NeHvFj9RlG3amAdCe1/QQtxrCbd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(1800799003)(186006)(451199021)(2616005)(53546011)(8676002)(26005)(6506007)(83380400001)(4326008)(2906002)(66476007)(316002)(66946007)(5660300002)(6916009)(66556008)(8936002)(41300700001)(966005)(6666004)(6486002)(6512007)(478600001)(54906003)(38100700002)(31696002)(36756003)(66899021)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJGV0wwRENoQS8xMWhZY0hhYXZIcGtYODloTHA0aUcvSlNrVUtydE43V2M2?=
 =?utf-8?B?RzhQbGswbHdtcFhtZkhodXFBQkNldnU0clYrRjhSMWh2bGZJRDBDa2tPd3Bs?=
 =?utf-8?B?WW9LVnEyaFhDREtRbFd4Y1M5NkRYdmUzNEJUUTEvb1VvaHRKUGoxT1k2ek45?=
 =?utf-8?B?cG9KYmZad1ZmdVNYamJ2RGVYbWRJMXZERDRFc3ZmMkh0Q09rd0xUNkJlNFZN?=
 =?utf-8?B?cUlOZ2c1SFR0RGx6ckxLZldFU3dEOXBpRkRZeUVHZ1RUMDdReGUzbFpWRFVp?=
 =?utf-8?B?Wkh4T01pcWpQRy9UMlJ1L0ZKU09VL0w2WWxaL2lHZkZzQmhTN095clRqdjRP?=
 =?utf-8?B?UlN6ZlpSVDJxb0xwZEVFTEFldHFnamsrL2pzcWRwbG1YcXBDZVZJYUpXVlpv?=
 =?utf-8?B?ZUdaSk9ieDZMcDdLamhMdDJvcVNiaHVWUjNsOTF6dVdMbmFNU3ZIdVpHbUhG?=
 =?utf-8?B?MmJUMTVsUysyMXlNVDR0RWNIY01OTGNiK3ZKWS9ReXREY1k5SWVXQlFmNHBI?=
 =?utf-8?B?L3BxMUxyY1ZMU2R2Q3ZUZG1OQnhqTldaeGdqMEExMkRzcEtKaXpEbUhudjRk?=
 =?utf-8?B?bThyd0JJSnQydVdkM1pGZ2ZNN0xFM1M3VHM3cDQ1NFdRSnB0Z0dxRVpmTGlr?=
 =?utf-8?B?TURsSzZFSUhtOGk0MTF4YnZXY1NCWWNoZWxtYjh3ak9OZDNGWC93YlQzVUsw?=
 =?utf-8?B?SlJzQzFpekZLc0l5UmtuUUNoUmwrYWpEczhtRFRVK2lnbkJtVGt1d1NSSmNB?=
 =?utf-8?B?cUx6N3JWOTlzVGhMSEsrRkt5bXhSekp3TnZQekJBQXpqZ0tqYTB5RHAzZ21N?=
 =?utf-8?B?ZmZjWVljL3lqQTZ1OEVCZXg5LzJiU3YrRU5YQTlNU0gwQ3FsdjR2RExRL1o1?=
 =?utf-8?B?Z0kyaWxLUXhCVldXM0RIcnZpQml6c3RCdVZieFdOZmloaStkbUVWQmtVRkpm?=
 =?utf-8?B?QmdVVWo2Vmt0QlU4WEEveFNFKzkrS3BYSEg0Y3dXakNTWnNiNFJ4V2FKM3ZL?=
 =?utf-8?B?Zlp2KzJtWG9reFFZMitiQUZPNm5mSG5CbmhlZGhCNndQeHk4Wnd1V2Iwc0lj?=
 =?utf-8?B?RVRTSmoyVUZCcXlJRmhmdDBqUzZ5SFlaZ01pcTNRd0U0QUhmYkFXOWFvWFU1?=
 =?utf-8?B?ZVJCL3Z0c3R3eU1MVFhaaXEvU2hJNnNuUUZ5TytORURoZys0dFVhQjNTcllv?=
 =?utf-8?B?eE00MjZZNHlqaTZ6NXpsdkNoT0pjckJBY3VCZ0loSTZCbk8vWGNRb25teTVo?=
 =?utf-8?B?OWFqTFdpbmJvTWhoQy9lbVEyR0pJcEhYVkFybGpEN2hFdC9HNkpuMTk5aGpt?=
 =?utf-8?B?Z3JidFR5Nm5uUVE5bTVieHVISXZrQ085NThxUVYrbUdhTXFjcVg5NkQvd2lG?=
 =?utf-8?B?ZUMyVG5qeUhZcGcrR2lUa2UwR0NKbUtERkVuSFcyZ1VDaWlyY25uSnFxVHM0?=
 =?utf-8?B?dWltVy9mKzg1bzl2a25veFkrQ3ZKc3BpeGVtVmxLcXQyQkNsNXl1b0RWNVlN?=
 =?utf-8?B?Sm9xazM2cyt2R0Q1cUROWEZXR01WWExQU3U2VFZiVUErcjdSNVExa1crSElj?=
 =?utf-8?B?WS9oOXYzZ3BDSURlZE1mUnR4K0NvcWcxYXRyRXB6TW1tYzNNNTdYbkZEd05t?=
 =?utf-8?B?SVdNcThFc1JHTUk3dklVNVBEZ3g4UjlHUUlQNndJQU1Hdk5sUUFtUjdHV2tP?=
 =?utf-8?B?bHdTU2pyY2FIcjN2ZUhPMWhvaTFvNGJCM2pGN3RKRFRjakEzTVhPWGxOTG1B?=
 =?utf-8?B?OFBJMGdJeEF6THdjd2t2dTF6NVNwNkIwQzdCQnQ3Um1Gem5LZVVDQ0tML3Jl?=
 =?utf-8?B?eGZFZ2R6T2JmT3BJWGFFUE53QklKZG1pQjdIVmtGM01mS2F3OUxSOU5FSm5W?=
 =?utf-8?B?Sm5DdzIyWndUcXhSVU83Mk0wM2xWeFhxWXdYTzRTVmlXS01QZGNUZk5ZY1JG?=
 =?utf-8?B?MVpCalc3VFdlbUpZR3d0eEhFSHJrQ0kxM0lkTU1teHNxUmtkMEJPaFY3YmxT?=
 =?utf-8?B?ZzZKaTJKWHVlaUtLOGlOMnpLWWE2cEIycXNCT2pwdWVhN0tZaGJDNzFNUm4w?=
 =?utf-8?B?aUtkUHZYWUIzNUMvU1NhTDFBQnFoYVJJdmxGN3YrK2pNY1M3bDB6RlBWK1pF?=
 =?utf-8?Q?Vt773FjGO4+mwZTcSFG0Xz1po?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a3e681-f220-4aed-f13a-08db94f453be
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:08:50.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjzXeur0YnAI77EIpfDaM/HNSRrcaoWUCBvPNZfoaMw7FNOi3vXyoHOX9GNdrFSUkxsvcJkZ5dSpAbAine266Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7737
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/4/23 00:52, Marian Postevca wrote:
> I'm trying to develop a sound machine driver based on the acp legacy driver.
> The first version of the driver was sent for review on the alsa mailing list this
> spring: https://lore.kernel.org/all/20230320203519.20137-1-posteuca@mutex.one
>
> I'm trying to fix some of the issues that were brought up during the review back then,
> but when I ported the patches to the latest commit on the for-next
> branch, I noticed a regression where I couldn't hear any sound at all.
>
> So I started a bisect session and found that the first bad commit is:
> ASoC: amd: acp: add pm ops support for acp pci driver
> commit 088a40980efbc2c449b72f0f2c7ebd82f71d08e2
> https://lore.kernel.org/lkml/20230622152406.3709231-11-Syed.SabaKareem@amd.com
>
> If I revert this commit sound works as expected. So I started tinkering a little bit
> with it and I believe that what happens is that the acp pci driver
> enters the autosuspend state and never leaves this state at all.
> I noticed this because if I increase the autosuspend delay to a much
> larger value, then the sound works until that delay passes.
> I added traces and I can see that when the delay expires the suspend callback snd_acp_suspend()
> gets called, but the resume callback snd_acp_resume() never gets called.
>
> I'm no expert in runtime power management (though I did read a bit on it), so I don't understand
> all the things that happen underneath, but one thing that is not clear to me is who's supposed
> to mark activity on this device and keep it from entering autosuspend if the user wants to play
> some sound? Shouldn't there be some counterpart that calls pm_runtime_mark_last_busy() ?
> I looked through the code and can't find who's calling pm_runtime_mark_last_busy().
>
> Some help here would be welcome. Is there something missing in my machine driver code, or
> is the runtime pm handling in acp pci driver wrong?

We haven't up streamed pm ops for Renoir platform.

That is the cause for the issue.

Will upstream them in a week.


