Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE8E7AB229
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjIVMcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjIVMb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:31:58 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE1E92;
        Fri, 22 Sep 2023 05:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWXWTIVBEUSIqtR6eN+YHRxFnZ15Z+SsAtPueZa0ta1/8nxbsfDy4djpkEm24MfrlD4bg71AUzNFTAJTS5wsm2NV3JIEB5MgwjVL8ivi1Vw7gITUZtQvbWxaV2gmjiQ58RG9Kti3jiiUcJo72TDiT8LmkUpWHDN409jx8LY+8jhfehGA/r9LKk3b3BnFUnWzKEpLkEGEk8hf+QCy5rYG5zjk+/xVdJXsh4Pg2GwzHkDXwot8SegFbZp9yAxrpTqrA3a/SAy+WCRD5tONkRzcmFqHJe1V83HaNSuN+Ygf24Onh9BFxJ+1FlC763oULPXIUVRQCLUx0yiRfUkTZO89/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EewptkuzE8i+nJHnYaLBJyk9YSTnStbo7+aWdW0kO0k=;
 b=n2VPuCeGlNCfrpyyYQHYC2xpZCrnlOCF8zRFU28tCrA8jyh5dn8DZpwW3tiZmq69IgFFQBpz8XkNDmmGaQh9CtZpXKoHWxn7mJci5eE9QTPYRZW5ufkOn2SJiedBKDCJkpdlTO8zs3gBgX4uiFT7Nh7z2Im98VMXAEjs0d8pLW/WDrsmT4g4eJuDUYVKtdJ7EceWKX5K/xP8mJu5NUeOJhQX+/aFGEUmZR8NaqshLZOTEUqQ8mIC/dX8mtL7qzattU6wQEdSIxMi7J4kQGiXJiON040gHtKOz3ZccB0PgOFKDsokssDiabgCw3wlw3d+nbeVkz4vuL0qHXzwR+AzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EewptkuzE8i+nJHnYaLBJyk9YSTnStbo7+aWdW0kO0k=;
 b=AZOCFiE0XebRtNZyR6z0MIZiUUp2w3+Ls/B1L//u0Rt1X4kslxqeuLolktq/RWeJQlqnYsKYMs6gxk6t//mg/LsHQlG8WsWu3WnL5RmpiQPuzAKXnvWMFRAxsHOvE5rFbfz8V2DU8XRNkm7ZlwYzahvFoROSW1SAJpupp4kU64w4T3QpTj987sLyq4nqW2ETdOzKPv8xNcGVM1ZNnpj0Oo2uc95voD0ZCSRQeHV3cEKnfm2Qc9TRs5j7WFc6h6xOVL6X7gaBT/mJG3xuSze0kwH2t6ZyU9YEYqaLp5rIPfARIooQGpKESa0n/3k++jNbIljgOCf3dPrQzwVraROnzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.19; Fri, 22 Sep 2023 12:31:50 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 12:31:50 +0000
Message-ID: <7e0355bd-64cd-f6c2-b720-e4643579078c@nvidia.com>
Date:   Fri, 22 Sep 2023 13:31:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230920112835.549467415@linuxfoundation.org>
 <79a96d41-1b79-51b4-fda0-743b853213b9@nvidia.com>
In-Reply-To: <79a96d41-1b79-51b4-fda0-743b853213b9@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::12) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: a390b455-73b2-4715-d02d-08dbbb67e4ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edBp7lychzmS071gWK+uU1VcLMSgDcQZpPRkVyLUgHQCIrm9tsC4H8PljCXtRnAer2Sj6EoQC3IV/IY8qpQwEuX8TdGT6CT+idIoKDiDbMKEsItkd/QJQjrzaawfA4bVj22gFrpjmpGimmWSdqWnQpR7CXNRgPRu+C5MdVn7cpUvX0ZHnPPNmpfVlu1HngfvTP4/Lo1NDY+lqRHSUNwg4nW8eAAi7YRjUrJWsQCLtRYmL1jOvIX7bpj0WypWzPqg0U+Uu7zwZnKzZfIfh9QhQcofEDbtcjpWXm2sCMxEvBoJ1fuurLneGoti45pEBeAmv35gr18XT3I9IS7LPK5CZu5k6/nxiooOlpvvN0YBoEgT38najFz9Cs7sBlV5HmuktgAWQSCwZpnDxWGxOynrQvQJZpt3R6LUOZ0ou1iYUiVU1kLrCBeTieitWRtKrwtvS685tlo3H24yrDAaXfftH+1zjehOyH3Arp7YCXyyLH9V28MnAVdIMX8P0bJiW0cFl3TUaoZLx2N/Fg3UBZrESnKudPyG2xZ2gDRT5iCYtZrgrD046g02MHpOzK+PzvsVr0s4lzP+d8E2GGIR+N0sIAVPfdaafP8XU2xaYUJAHR2tHfmpGK4tDJ/nK5U/bvnB6kQZTybktnjHhu4vagIuzV2G8QsXIU9L/BWqSkfrli7TuIHl3N7NbFKjCSkhnTxt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(1800799009)(186009)(451199024)(478600001)(6666004)(53546011)(6506007)(6486002)(6512007)(83380400001)(8676002)(8936002)(66946007)(66476007)(31686004)(66556008)(966005)(316002)(5660300002)(2616005)(36756003)(38100700002)(31696002)(4326008)(86362001)(7416002)(2906002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUp1N1gwZEFickpsa2VjcTdCMjFkWUNkR3N1c1RNbDJTTXRnQnpRb1dGb3ZM?=
 =?utf-8?B?SkNrNmcwcG9peFdWRXZabEZZMUppR3NMYzUyZ2tuTG9aYzRoSmJLaUFhT2Za?=
 =?utf-8?B?Q2dsUzJrSWRzc1VuVHkybzNacjVCS29NTkg2SXI2VGNEaExNek02L1ZRUnAw?=
 =?utf-8?B?MUx6aG1xeVg4dGsrUmNVbXRJemJjMDVEQk1BNUkzSWpvOUtDdnpoWGRmWFF6?=
 =?utf-8?B?Zk84NnkwVVFoRlpDd2x5Q3M5a281SjV4VWdzZERJV2wzdFZpcHhZK0V1Wmxn?=
 =?utf-8?B?UDVKa0o0VE5hZU5ONSt5ejRwZHFoU1diMC82cE1tbXptQTF2NEpqNnVVOWps?=
 =?utf-8?B?M3dPeWRMM0NCTzM4REVNelJzRmVuZmdRWmpyRjZRRDEzZzFKMndIcS9Zclp6?=
 =?utf-8?B?V1RwYlBIWmhnT0ljRkE2VVY1R1dYaUY2ZksyNjNTTjNMem9HenlnK0psSURG?=
 =?utf-8?B?OW1LVmVhQlB0YWRTQkJoVTlSWDRZL3BoQUdFVUg4b1dCa0hycU9NSVdoRTNO?=
 =?utf-8?B?T04wdmhxQ0NtYk5MUTZjSmRPQTU4aFNGV1JjRmRkOTFsc0hqd1ZMT0pGUXcr?=
 =?utf-8?B?SnlPaGFycXNad3A1NXV3UlNBc1k3L0Nwd1BWM1RMV0dhU1VHSCttQnovVEl1?=
 =?utf-8?B?WWMyRVMxVTU4dFNud3NMcHVVb25HWGRidmN4VDN1Q0RuTVlBM21JZ3ArWDZu?=
 =?utf-8?B?MmFkZXpNUXJvbWhkTmZzcmZuZXJaRUxrUmlwUUY3TmRJR3pjM1FvSnB6RFJz?=
 =?utf-8?B?dVRNNytvaTd5dEJSNW93OUE3RW1YQ05pMjd5SVljWFNXU21aTzBLa0txYUp3?=
 =?utf-8?B?ejVwY2lxWHllUUR5Y052Z051ODREMWl3Zy9OM3REbWhmbHhwMHVPZWlwS0g1?=
 =?utf-8?B?NVpkNFVwN3l4Y3A4c3d6cVp3bFhaazFYdFVDc25SMW9yMHVnWFNQZVFsVWwv?=
 =?utf-8?B?Z1RtbFlUaE9uTElhalFYLzAzVVdyZm0xSlZmeEo5b25WMlRpd0tpc1NJcWdv?=
 =?utf-8?B?M2xsK1pVYkxKTVFVQVpLcWZEZW81V2tsRXFGcXFLL2o4MFgzVkNaanVIUUhK?=
 =?utf-8?B?aEpqMm4vUFJJZWR6b0R1M0daMEVORmxMSzZLRXRaYkxTVmlEeHVwOWxjRE1o?=
 =?utf-8?B?dWJVNDlhYWF0UkYxQ2tXTjhWOWJaYzVnM2NkMVZyRGd6ZDhXVUY2N2FBcXdy?=
 =?utf-8?B?WUd0OE9QY0dQR3V5YisyWmhaVTlOVWUyV0srV2lsS1k0Y2FNSCtSSHZLdDZD?=
 =?utf-8?B?cWJTWGxHNFE5SXpiVGVTcHlSdVhKOXZyVFVqTjVORnFvUEVvYkRTdElyVTZU?=
 =?utf-8?B?VGN1bjhWR0QzNzVsM3dSUDErTlNkOWF4QVZ1UlhzWWw0NkMzSGw3b201R3ZH?=
 =?utf-8?B?QXN4UVpvdzk4V3VLdWp0cmxWUXM4Q1U3Vmh2MzBuRE1lcUxJbUlGMk5wZ3VM?=
 =?utf-8?B?SllLOFNDcGJrQWRTc2UvM0dMYmkyQmpBbGpBYVNCbGd6MUY0YklsQ21PaUZ2?=
 =?utf-8?B?YXZMNGdLelJIcXl1L2ZJOUtaU0E3bXc4d2pQNVNKaG5wRDZXUmlYL01ERHhl?=
 =?utf-8?B?Q2VYZVpONG5mTFJiWHBPQU9SY203TEdMRlVzaUZheXh5WFljd09SbkF4dVd1?=
 =?utf-8?B?Mi9YMzAwbmU1SlNBNVJnaVh3WlhhaVYvWFRsZDRWTXJ2UU9WRW1RdkYwZmhG?=
 =?utf-8?B?UTFXcXQ1L0dCeEVkTDZqNENwQW9GYWF6Wlh2bURQWnlyTVR1VERlc2dTTDh3?=
 =?utf-8?B?cDJZMDJIdDdoVEtyYTcxREhpenVnVkJLbHBJVTNqeEZUU1cxdzNmNkFRcjdM?=
 =?utf-8?B?Uk4rWnN2VWcrK2szUDI0MWcwQVhmMTBncGpPNEJlOWpRUDh6SFhYVFlZSitn?=
 =?utf-8?B?VW9udEgwU2lPUTc1REd0cTNtOWxGcWVKcjJXZDBBZnZaZ3ZvSG5hUk9VSlZD?=
 =?utf-8?B?WGhWUlVJNUlhT1NYNk1oZXFibXB4Q3d3K2p1dmZvUER4SlQyVGVUbE85RFlN?=
 =?utf-8?B?OXh4UUU1QW5CaTFKS0o2Wk5tdkFIbUdxaWYxVWd0bm9XcWlDclYrSHE0emNT?=
 =?utf-8?B?SU9QN0VIbkw5ZTJyYnJXZ3pxd0dHN3hPbXdJZUtsd2dZU2hqVUxnTHlmTUZN?=
 =?utf-8?B?VjBmQU5WZ3o2Lzg1T1psNm9kQk5IWVJUcTdvS3pscHd5NzMyQTQyYXl5Nno3?=
 =?utf-8?Q?xDrea+fTRsii2RaJouDlnwD9loqjoWxl55egDZ5LfRDB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a390b455-73b2-4715-d02d-08dbbb67e4ea
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 12:31:50.0755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV5Qaf4kVbIBhwtbX7mHUCOKYE505iv2APdTb5wZTme+C0y9w1vnJb5IdkGBIoNQN3Ldq3dl/BnBG5i2Ye6pLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/09/2023 10:45, Jon Hunter wrote:
> Hi Greg,
> 
> On 20/09/2023 12:28, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 6.1.55 release.
>> There are 139 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.55-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
> 
> I am seeing some suspend failures with this update ...
> 
> Test results for stable-v6.1:
>      11 builds:    11 pass, 0 fail
>      28 boots:    28 pass, 0 fail
>      130 tests:    124 pass, 6 fail
> 
> Linux version:    6.1.55-rc1-gd5ace918366e
> Boards tested:    tegra124-jetson-tk1, tegra186-p2771-0000,
>                  tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
>                  tegra20-ventana, tegra210-p2371-2180,
>                  tegra210-p3450-0000, tegra30-cardhu-a04
> 
> Test failures:    tegra124-jetson-tk1: pm-system-suspend.sh
>                  tegra186-p2771-0000: pm-system-suspend.sh
>                  tegra20-ventana: pm-system-suspend.sh
>                  tegra30-cardhu-a04: pm-system-suspend.sh
> 
> Bisect is underway.


Bisect for this issue is also pointing to ...

Rob Clark <robdclark@chromium.org>
      interconnect: Fix locking for runpm vs reclaim

Looks like all the Tegra issues are related to this.

Jon

-- 
nvpublic
