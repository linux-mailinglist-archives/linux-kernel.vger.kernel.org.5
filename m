Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AFE7E03C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 14:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376452AbjKCNbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 09:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 09:31:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFA2182
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 06:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPMH2KhvnZ+I0KXlqZrDfzaXpKEKoieCAg1ty81rwvQT2vezXKUr7eswCPOGmvVPzNEKnMfmRyW0qCfEM4OFJe0Pemmdn/HGI/AwNzUVxuB/upieWjBOmey1Ppnu/lfUD6HQUbvBy3Rji6DvMTFXIZSqd6jPKy5G4c3v+e6n0MeVuP7Eiv6+L1SRG7Qsl+TusDKOmweziqUp7ox7zFFIbk6JGN9LhucADS0onM52hhbopgrPC47nDmQvLkOg1XcH7sgM9cjrW0fjpngquUJzO/9aprCz3bvDXfFmWW3Ytpe4bSrdoC9VU0ybqcLXFo0T6H/PHngcy8K571C3ZWjtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3guKPN+wluGfCLaFvOYjM2WDwIFi4bDcqFZuId2kyWI=;
 b=nPbG78I7Wlg0qvYGEhDg0wF25bb331UphNQB2tgme4M6T+1AxpmlSnEUGFfKKR7I6MznJ4I0AqdPQHCv3pnG8rR1DNqxmqXd+rDrjjHmLZ6EzXeC3wsN+cZeC7UOjYSH4MTA+eDwvGRwaOPMdEOdhmkheD3Hg8Jesc8vQ0oAhYXPmmLZ9uZSt26Z/4i3eUN+CTp67WdF7hw59oLgOoYbyi0bhThmv9+0qCzmeRBMW4n+J2rUiubCe77xNzQZAr24bfzqc8/HbUPWMS4aBPofIoA48RwFV64K0RHY3jz0zDYqPzsDSyMo60ZLVRQKDJvZ8hmqo6nemA9fxBuBjPi7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3guKPN+wluGfCLaFvOYjM2WDwIFi4bDcqFZuId2kyWI=;
 b=x+Sa4YVGXX279JfWAiJwyaFddSTaAgxfzQHqfOKK2Fm4Rr47GExZ41HnaAsbfzxSm659/jdN9o7yG0xztrAtxRB3rM6fjIdRVLEuS1616VDd1XEd7+xJDRJNuHEgN7zblVFHMT2ioCOu+N3KejoOpj8tpjZSAOqiCxhIMHW3JE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:31:05 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::7354:d327:ee4:dd79]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::7354:d327:ee4:dd79%4]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 13:31:05 +0000
Message-ID: <610d562f-0bbc-485c-ad63-9534fa4ba937@amd.com>
Date:   Fri, 3 Nov 2023 19:00:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops support
 for acp pci driver"
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Marian Postevca <posteuca@mutex.one>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>
References: <87a5v8szhc.fsf@mutex.one> <ZUQssoD2rUHSYQ2v@debian.me>
From:   syed saba kareem <ssabakar@amd.com>
In-Reply-To: <ZUQssoD2rUHSYQ2v@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 514e1a3a-01b2-4491-87d8-08dbdc712110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uhqEuphOKxAEAjFjBBryCbkro4lHmcYseFGvpZv/rwYTTBTXH9CH52h1rpKaOIB3T7qmpBLVl/7ZXtIFEbawtI88ugdo5egTxn5yx8E3e4CwwS/dsAkpGuKxCQ9jheDo6zWT3uXgmOQExn2m5HrzZcCheOI44859yvOdfiwYiJjm7EnIrJPF+edL54qaV/LN2/6i0nj2PSX6RTk8HoXV6ejdWPXJ4W3AKjYkp+7dsIHxPCV0mvRxhYaMGHz5NMuzjTzoHy2cU33/cPm2eAV7YiEPnixg+dkvvaz8IsqRPIRqo+rHDqnfzL+jJKX/+jFEaFeAbsvMEuMRPAgv4BASaGQ+J7Qhsq7FGw40SCVxLlIPgfiqd4MFRZPTfJBKIljTCkSGY3oIcuVF4jsbuphjkkXDg9jMMslAF2hlFq3yi7kZafJ4jYe+Rp7SAP3ploEXCKbPXATUu9IbGQpi0u4sM5A9D1AmJfgcIwKDj8Fko/naLtn8ABK2l3IzA9tvQ3Md1Zp3Mz9TIlEpjKnnTbLnbWw9N7PaSoRSnabFDmEE6/mBJJKbR1YD4jiISSXiVNwH94FaZEoaxOqygwlFU/dAyCXxk4iivEVs5BYz3vk0gmzm2a4zyDiufee/BAyCgtUOs70KSig3HBHsMmH3QoUIrP3BGqDyXdZS/ZlihFduJlrKA9lwpKpxp1sZBM1oMXyE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(6512007)(2616005)(53546011)(6506007)(478600001)(6666004)(7416002)(5660300002)(2906002)(83380400001)(6486002)(110136005)(41300700001)(966005)(66556008)(8676002)(4326008)(8936002)(66476007)(66946007)(6636002)(316002)(54906003)(38100700002)(31696002)(36756003)(31686004)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjF4ZGFDK2hYNC9rUjdDQTA3dWJGR3Y1VnUrdVpTVmRYZDBJTFh4V1oxZWRO?=
 =?utf-8?B?RHdmOG1nUExZeVlwcVpRSzYvMkRkelZqUER3K0tqYzZsaWpJSmpnb2hYZlhV?=
 =?utf-8?B?cktXWEkveWVPcTJ0YUV1REV3enJISmtjUEFOUE9JczlFem1QdmMvRWhGS1Rs?=
 =?utf-8?B?ekY5UU9wMEVzMnMvaWpVaFRDMmFucjZqVnE2TzlqWmVjeWFhQzNCZUpERzJK?=
 =?utf-8?B?Sy91MTRuYVhmV3FzTmVtYnZaLzBvZ3Q0ZXZNb1EycnBsWlpEK3V1TFRRVWQv?=
 =?utf-8?B?U2JpQVBtVWRuWUhNSjFUc0g2clZ1ZVIvWEFjWkZYc01ZeU9maVNCaEU4eVUw?=
 =?utf-8?B?K1F3QlRnbkNhYXBhcTZrbWg1ckZSS3pXT0RnY2lRVzZ6VzlDK0JtTi9JcklY?=
 =?utf-8?B?S3pxZ25YK2RLQUJ4RTVDS2J3blpSSUMxZmZLTjhVVVc2S1lFNmJvUCt4bEpC?=
 =?utf-8?B?cG5oN0JvVEZ2NG8xYTUvNjFCZkpVMGsrZmR2OExXeHNwbEpqZUM0MWJmNllx?=
 =?utf-8?B?c1BqQmIrMXpSY3R2Uk5KOFRnWW01cEtNeURxMlp3WnY1Um9KMXZZcnduVlo1?=
 =?utf-8?B?QkdwbVhWRXhLMWN0LzhCaEQ0SjIrMUJLd2xtajJMaUhGRnhKVitxNzBFanZY?=
 =?utf-8?B?TEZsUDFGa3FHc0tPT2ZjOE1vSUFJRGtWVUkrN1N1aks0anBYZ0lrVTUyMXUy?=
 =?utf-8?B?ek9kbEdINFIrZ2tnVVJtSERxVDZWKzExaE9LMzJJbXVnYVF0eklkYzFwaHc0?=
 =?utf-8?B?ekVCTUJZdVQxajRKbVFEbjgyWWQvQ0ZPNmFXM1hjMWZyVDQ1dWpDYzE5SjBZ?=
 =?utf-8?B?bDVUbkJqRjhjeGFXWEw5bFA3YkNXSTZVZHVBVWF5Y0ptWlBtRVRxUXRibUxz?=
 =?utf-8?B?TEk1alJYR09udmRwcitjK3E5UHVtdjdTZWQ5NU9KU3BCRTV1UGpHc09SNCtk?=
 =?utf-8?B?TkE4VFV0Ti9RSjFFMFNPQWlhZll4dm1CRFhmRkR4b0w3TE5kNzVCN1ZENEgx?=
 =?utf-8?B?R0dFc0dOWFNJYlplblQ1VWc3SjVEK1RpQTNyVnNSNDJiRThuMVllSUt4YjFO?=
 =?utf-8?B?eWpaVTM5Vmw2V0tkNjdkUVJBM09uU2ZveUZTWjhKT2EvM3Nwc2pqN1VoQUw3?=
 =?utf-8?B?ZHpKVVFzOTVFRzdZRG1sWmlGb2xCU05OTkw2dkJmL0tQS28wUFliK3N6YytR?=
 =?utf-8?B?S3ZjKyszcHkrYlQ5NklGSklCdUhzYjZaK1AzclFrckNhU0dxaUVvOEIvNDg3?=
 =?utf-8?B?VDFjbjNLZWtrUlVKcEF6Nk9aTyt3S2JmS3h2ZngzQmtXMFl5amR1dkhQOWFj?=
 =?utf-8?B?dnF5dkYyV0wrUkhpeHU2SUZzZVdMbTBzSFU0S1R2OXdEREUwSEFQbW45cWUr?=
 =?utf-8?B?WjBtZHdUazlQdDdBNG53dnBpeGRyR3ZnYWVibmVmWEhqenJ5c0xxUVpiZ3RQ?=
 =?utf-8?B?TCtFalhOKzdzSWNOWndvbU82enVvQTQ0V2k2NU9QRXFBWVBEeWdtYldzRWli?=
 =?utf-8?B?RStjMFY2dnlwdnZVbnBUWXQwTkxNdVlhK2RzUStCeFJjVGlEdm1Qc1BlUG9t?=
 =?utf-8?B?czhNQWU0Z3oyVnlHNzNDNlpuQU0wTlRrRGpsVkQwMDJyL0dwUU9QV2dUS2RB?=
 =?utf-8?B?RkcrWTAwZ1crbHNtSThjSmlIY2JQeDkwZjk2K3FHc1AwUTQ0c1NMc2djRzdI?=
 =?utf-8?B?d09hSDJtUXc0Y0s3YVhCZTErNGhxWUZTRkcwZTlKTlgyZnJqV1pSZEZDU21O?=
 =?utf-8?B?blI1Tno2enpGMnIydExtY2lhN2ZDbmZrTS9vT3g4SExxa085TjU4TE5PdUpw?=
 =?utf-8?B?RStHUXl4Ly9pVEFISytYd1BhNEEyZDZWVWpFQVlOQ1M5STd4SjZNVzlYYjU5?=
 =?utf-8?B?UExWYjRtMWR2Q0ZpNjB2Z0xNdlRJZ29PK0pSU0YyLzRSdEY1eVJtTm4rWmZF?=
 =?utf-8?B?alM2SFY4N2ZWaWtoSlhDQjdmdTRmSnVad3B1K1l0OC9RdGVyVzRKcTdCZ0ls?=
 =?utf-8?B?VXZzcTR4ZUZCM2F3bWp1T0puOXRxM2NjN283RnQ1bjNDcFdSTXFPM0M0QWhV?=
 =?utf-8?B?c0U5RTJjaXFxUU9QZzlHekgrM29jNHFMRU1pamJVNEpUMWlFRzkzeDdlWFFX?=
 =?utf-8?Q?ZZu+fejzKowYO9vZSz+QgS1lc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514e1a3a-01b2-4491-87d8-08dbdc712110
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:31:05.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a198ya78CR8yz/Rdqf9jkSQ0KD+PWRv9km2a3m2+NLZ1PtSX2/sU9Nc+/aJ6niXU4PvrWgbdQ8eUTUhSIp7qiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/23 04:41, Bagas Sanjaya wrote:
> On Thu, Aug 03, 2023 at 10:22:07PM +0300, Marian Postevca wrote:
>> I'm trying to develop a sound machine driver based on the acp legacy driver.
>> The first version of the driver was sent for review on the alsa mailing list this
>> spring: https://lore.kernel.org/all/20230320203519.20137-1-posteuca@mutex.one
>>
>> I'm trying to fix some of the issues that were brought up during the review back then,
>> but when I ported the patches to the latest commit on the for-next
>> branch, I noticed a regression where I couldn't hear any sound at all.
>>
>> So I started a bisect session and found that the first bad commit is:
>> ASoC: amd: acp: add pm ops support for acp pci driver
>> commit 088a40980efbc2c449b72f0f2c7ebd82f71d08e2
>> https://lore.kernel.org/lkml/20230622152406.3709231-11-Syed.SabaKareem@amd.com
>>
>> If I revert this commit sound works as expected. So I started tinkering a little bit
>> with it and I believe that what happens is that the acp pci driver
>> enters the autosuspend state and never leaves this state at all.
>> I noticed this because if I increase the autosuspend delay to a much
>> larger value, then the sound works until that delay passes.
>> I added traces and I can see that when the delay expires the suspend callback snd_acp_suspend()
>> gets called, but the resume callback snd_acp_resume() never gets called.
>>
>> I'm no expert in runtime power management (though I did read a bit on it), so I don't understand
>> all the things that happen underneath, but one thing that is not clear to me is who's supposed
>> to mark activity on this device and keep it from entering autosuspend if the user wants to play
>> some sound? Shouldn't there be some counterpart that calls pm_runtime_mark_last_busy() ?
>> I looked through the code and can't find who's calling pm_runtime_mark_last_busy().
>>
>> Some help here would be welcome. Is there something missing in my machine driver code, or
>> is the runtime pm handling in acp pci driver wrong?
> Thanks for the regression report. I'm adding it to regzbot:
>
> #regzbot ^introduced: 088a40980efbc2
>
We were working on some other priority tasks, will upstream the changes

by next week.

