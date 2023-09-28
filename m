Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77ED97B2635
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjI1UBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjI1UBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:01:30 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A0E180;
        Thu, 28 Sep 2023 13:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GX4Hh6pYeXaENZBRduHnZ+twWBAxgsarJQAzaLrdRc8X9UCzibo9OBheY3x/oQC3FNSRbqXvxtOy0QKWRtPuBFnhlK8KY7/eMHOmk02nWBrZ03iLmSSih4xYLMlEQ6/Fte2DiaBpVMWkulAPHrJgKKMjbwHjpvZNoUYY8hkdf4ZA270cB/XcCd2Q7nUgqtMC0PfoAqmdlC5zQzgQq61BDdAXZOXlEvNkxQXKV2E1YS3EtGrwvdkebtzsOBU2owfj8MqVOsOz7sPIT2WFcWgRRjzFzjOU4SySxZFrO1Jk+PGE+f+hQJhxsMGqG9lGcTUJfdS7rbstGod//ZLOfVPjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0zKZOFNa9DDlVYoFzJBaoQ65W1IEx880uL0m2ztPsg=;
 b=EnDBdqH52DWzp+HkmBje3IZkt9wPKKktgghsUWs5w08POwOiLjw+oNyPdgZBx07dWRvXMfKtjvxkrseD5F8TfSYayzDDc+02eyOad+BcBwCTXPaa+PzpncB3xrYXm4Orjp3gBa5W/T9dqiemhJaZ2XXt48HmZKdio4voUKsM517YEVJ++AkB4YGMCt0j+ZtxKZ7WkQaIeKHtju7AMQCBixZEsGJFpUOOhWGLAv9o4gif2De53dvxFIOU+s5Gj+Nd49U+4zR8jtQHZ9pRrqHXGWOqWHaBampaD06GrNH8vOCHq/fnufWvo9n/PwsdDDwf6OcCjd8hjeK/liJQh41vDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0zKZOFNa9DDlVYoFzJBaoQ65W1IEx880uL0m2ztPsg=;
 b=c0ECV3WHpYnYKMItXf+QSIcdF30OB8ac3RLmEfQLISskgn//biwZk6wJ+iwyPduxkrlslSFB4QmsA7Z0waShTaEfSmifS+AEO6DUEscOgBMgdpZ5nw+rQ89LCNazlPM+lsI4NIFCoo/oD0fHjL/FHk6khunxwXe6/3WlCEQDRMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8133.namprd12.prod.outlook.com (2603:10b6:a03:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.33; Thu, 28 Sep
 2023 20:01:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::3e65:d396:58fb:27d4%3]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 20:01:20 +0000
Message-ID: <8cae7afb-3e6d-42cd-925f-4ee3af920178@amd.com>
Date:   Thu, 28 Sep 2023 15:01:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix Navi3x boot and hotplug problems
To:     Alex Deucher <alexdeucher@gmail.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>, Jun.ma2@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230926225955.386553-1-mario.limonciello@amd.com>
 <CADnq5_NHQhUZ9DzNtOy67Hx1g2_ZeBfKPC6O22YY_bzSJsMiUw@mail.gmail.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_NHQhUZ9DzNtOy67Hx1g2_ZeBfKPC6O22YY_bzSJsMiUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR14CA0070.namprd14.prod.outlook.com
 (2603:10b6:5:18f::47) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddef2ed-3e5f-4a92-9c68-08dbc05dae9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /aj4RWTLaLJyAu/6sA8RJUQO3TW+2VDbMZwWlj/gyFwLFjPJx4ELiB1oH3EH9owdIjdOdNRFAQ7NxGmDzDpEcAcL5d/8H4e6Q04Sq4w9z0NFVp+rwvCcyDdeffeS1C6ryoJgKkeuVdoQ5cfDyjCgo+Ia6FVnnQJdT1CByKGUazFZ4iWVgtHHf2VEMm5WJb6lg182Nai1b07VZvDvGfUYzvmm+fpS8xbmkMM/2gQVd4BaJSlVHfZJ1AJApfQnPdZJVmQABrgXOmiOgw18ghlMS3xeXFF3ilPpnz1hNPGaiug/UnCGErhIJ0n7QmxIOvrJqdS0i9sJ3NCSj1dnwFbakHr/dZKm+H2RxMHNu9gcv0lIf+foUgtb+oNCN3Ww06/Gd84FQE0t+MwXzGShzlqYJsiJe481c730i7f0BdG8az+1J4pdaW0OF5Fwg9RidvjqUnhpEOrNgg6ITzUQ6iNjHsLBUT/WatPjMCfWa6KOjNCZ3781g7yDxRfUf9PFU4xBELk0ORlN6o8+ejD16COQG3bEYggV3saeTJsLrw0iuQyrFtmY47dTibHCqLh3/vZIE4+/mZGhXknIL//3uWvAxXwLjftfXg6hFm6RLBz/Qwn+NRR32LNd6VlA6/emUf3ZkpbrOcNzSp01z3Sg1JULgpzfJ4tpV7HJjwiT0n0yQZY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(53546011)(2616005)(26005)(5660300002)(38100700002)(36756003)(478600001)(86362001)(31696002)(6512007)(66556008)(83380400001)(6666004)(110136005)(6486002)(4326008)(6506007)(316002)(41300700001)(66476007)(8676002)(8936002)(44832011)(2906002)(66946007)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm1uTmpwTXBoaXpzV1NudW0wdlhhSjdKVWFDcXEvYXZQanoyVXkxWnRGSjI2?=
 =?utf-8?B?Y3JKQnFESENQVnh6RTI0SmR0SllDMUpReDFoVGVDN0VxWmkvQmhNVWt0dGhB?=
 =?utf-8?B?a1kyazgyQjMvL3QxUmRwK2lnYjZUNVpyeGlvckZnYzJobGpiVVl3M0xkeVRJ?=
 =?utf-8?B?bVU2Sjl1cjJ2cFMxaCtMQW1yai8yZllVcDhNUUp5eGpoOUNjN1dUbDRabTdT?=
 =?utf-8?B?SG9GdkprWHZQY3RONGgxYndsVFE2MVBsbFJ1Zk9QeUJSdVhpWXlveFlYeGhk?=
 =?utf-8?B?bVNnM1FLVjE3OUU2aFZ5K1NOdFFNaUNpMTBBcGJ0eDdZOW81N21EZlVpYTBC?=
 =?utf-8?B?MU00MStpSi9ocWx0NkFFRXIxNGJyVVJyWno1RkdDYi96Sk8vdC90Y0hRMjMr?=
 =?utf-8?B?SGp6MjJHZXk1eXRJUTFXeCtNRktrSUh2SytOQUFMQjFmcTFrZXNpYUtVbWdx?=
 =?utf-8?B?U0pIMk9qbk9aRWRhbVZYTGtINHF3SGJBVWhndE1mZlMxR1ZTNzgxdk1nU1Vk?=
 =?utf-8?B?ZlVUbnlmL1Z2S1ZBdThoYklkUFkzclIwYTEwNGNwdVZ0VjYvLzdscXJOYTdZ?=
 =?utf-8?B?eCtuUStRL3ZlbWlJQ2UvWE5lSjNWTzZsMGVkZldqUVpldUo3dExBNzI2aFUr?=
 =?utf-8?B?cFdQSENMVjVpYVg0NlZWVzJsV2FPRnBTREVyK20wVXRmcTRMb2Q3Z0RhSk1H?=
 =?utf-8?B?b1V5a2NKMFduQ3R2MzdzdktLZ3ZqbnVySHF2aUNNaDlSRjRGeXlpTzJLUGZW?=
 =?utf-8?B?cDZ5cGtwTTZ4bThmem5xL1JML1UyazR2OHVqRVhvNVNBYVBBL2dlU2JPZlU1?=
 =?utf-8?B?VWxMSVhHSTFQRnVCYytRa1VRRmhMRThVclVQTTFjQk9RMzNLRmJWa2pEN2pJ?=
 =?utf-8?B?Y0RKUmFLeTB4K29hVUYzUU5EcHpLcDIzK2dzSUh1QVVDeTRrQ0orQXhxL1Ft?=
 =?utf-8?B?VkgzWEZkcTZnQWloU3ZiZjZSWS8zM3JiS3V3d21SYTJVM25OdkEvaitMRERO?=
 =?utf-8?B?U1REMDVPNGJUWlhFclh5Q0g3NG9SN2k2Yk1ZRTM4K01jbk1CUkthL0NNZFpN?=
 =?utf-8?B?ZUZXMlg1Y0xaQ0d1dW5vU2hkMUNYcHFXbGZJRmtNbEZhSFlkcG14NmJIZE14?=
 =?utf-8?B?MmcrRmJrUCtGcExpT2FXTkVXUUxTVjZDTUtTMUI5ckYyS2dHdEN4SXhNc0V0?=
 =?utf-8?B?WDVUTWFYQkVlT3pQOGJhay9jc2hNaFZ5NjN2R2U1dUF2bXB0NzVsSE5od3do?=
 =?utf-8?B?WkRyeVJhUElsdUhSMlFGRnlMbnJpTVlrZ2doNWk3ZmIrTW12UGFtK3BvTHQz?=
 =?utf-8?B?K3ZJU2tqZ2s0WFpkazd3T0h2WVEzY1NKdEdmN1BrQUJ5UVVlWHZKeFVYSEcv?=
 =?utf-8?B?dHZGSnhPNVlydG82MjhOZ1FzNG5VVVh6RmdqS2tWeFBTWWxPR3ZMNGkxUGpp?=
 =?utf-8?B?Tk1NbVBUTFMvZjdTblhmNHpTU2FxeTNweXVqdnhNeVR4UWFmYnQzNEZ1Qk8r?=
 =?utf-8?B?Wm5LN0d0cy8zdUljRUxHSVNpRHJPVVNZOHZwVStjWFFRa2xrS2JsbEMrbFRy?=
 =?utf-8?B?blo5bGhtd2NmZGRKUUV4bU8yZG0vdHZvdjZVTGtFTmtGR05OdUliRWdiemFK?=
 =?utf-8?B?S1dTWlpEWW9NWU1vUUx6S2JrTlp3K1NtMDV0dTNOTldGMWdHaUMvb080YjVm?=
 =?utf-8?B?UmY2QWxqWis1VE5wUWlSMkxsdTV1Y3gxK0RlRXp6RXcrSHlxRzhIN1FQRURQ?=
 =?utf-8?B?bU1FNjQ4YTU3Sk5BajlsaUxsMkZSdFc2MnlkblJiN2ZQTmRZWjZLUW5iczEz?=
 =?utf-8?B?TE90ei9nbitTR1MyNTdPNkhzRXEza0JCeUU2eG5pazVldTQrSDJWc2UxeWNC?=
 =?utf-8?B?TXBPcFFWOTlPQWkvZ1RlQnlwaWVZVlZnUTduRGZ2TzNseUtjMG1jT3p1RGtn?=
 =?utf-8?B?R2R5RUFRdTJ3bks0RUhGdjMyNlhCQmpiNEl4eGhGcFBub3hTWkRMTGZEd2tm?=
 =?utf-8?B?b3BCK0U5L2VSNm1TQ08vRGtxMjRuS1F0RXE2bjA1VXM5WjFOL2dXSkNkSVZv?=
 =?utf-8?B?bXlkNThRYTF1VWhza3M3M3BQeHR3MllQVklCdjVpc1UycWRVTDIySkEyMVAz?=
 =?utf-8?Q?m0ivzvP3Si/muwl61xjwxQaCO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddef2ed-3e5f-4a92-9c68-08dbc05dae9f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 20:01:19.9416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4qIB8o6fLJxSg98DWVc+c5xYczSAgpefQOkj1y6kcspLA5OCPUR1TBEApHl3Z6NzQ7fCfm1X5UlBpR5k7Upuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8133
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/2023 13:00, Alex Deucher wrote:
> On Thu, Sep 28, 2023 at 12:41 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On some OEM systems multiple navi3x dGPUS are triggering RAS errors
>> and BACO errors.
>>
>> These errors come from elements of the OEM system that weren't part of
>> original test environment.  This series addresses those problems.
>>
>> NOTE: Although this series touches two subsystems, I would prefer to
>> take this all through DRM because there is a workaround in linux-next
>> that I would like to be reverted at the same time as picking up the first
>> two patches.
> 
> FWIW, the workaround is not in linux-next yet.  At the time I thought
> it was already fixed by the fixes in ucsi and power supply when we
> first encountered this.

I looked yesterday and I did see it there, but I think it was 
specifically because it had merged the amd-staging-drm-next tree.
It's not there today..

If Sebastian is OK, I'd still rather keep it all together so that people 
testing amd-staging-drm-next get the fixes.

> 
> Alex
> 
>>
>> Mario Limonciello (3):
>>    drm/amd: Fix detection of _PR3 on the PCIe root port
>>    power: supply: Don't count 'unknown' scope power supplies
>>    Revert "drm/amd/pm: workaround for the wrong ac power detection on smu
>>      13.0.0"
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c           | 2 +-
>>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 3 ++-
>>   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
>>   drivers/power/supply/power_supply_core.c             | 2 +-
>>   4 files changed, 5 insertions(+), 3 deletions(-)
>>
>> --
>> 2.34.1
>>

