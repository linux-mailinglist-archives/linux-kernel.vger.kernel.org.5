Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8F7AAF1C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjIVKGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjIVKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:06:43 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53685192;
        Fri, 22 Sep 2023 03:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kw9gC44yvAR+zZAVV5uvl+3rw8tV+KeUDBPa1j2rylrcjXsYwzZmosUkqaINdKpfY/ZcKJhLqCR4tAt2lICNagFIh2An3umLFus08iUB2Y/ZLPTAJUjSmpLE9Mw4Ms56sLX4vxx7hhBy5C275EGRzDpkurTLNakeAn+HhNUXLwWT4eBg9UjuXl3qVdbcLHBbJyBfp5LmgyC7h0OdLnblKyVzop6VjoYk8g1Ow0v8KJjMGTfDi6XJaV+pnDyCDwDD3YuWlKS+ZSgCtqgrH356mjCiHQSSlQhvJO3dCjx9L3A4dfasy28+j26hKA2A89UNc0VaouqD1mqtp8fvPJT22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xNUY/AqI0Ims47Rhxw9Ye1JsNtjqGuY/EJylZ5GSNI=;
 b=cuzXmzcIJ25gPSu5DChJ5aV6zt8Yt6i3SOWCSjjujqWl+auO3NIo9hMyO6n1GKxpkUJjPl7XDWhzbkLtHNy5zmAam731n66Svon+VBxL+av17xJO6ICmctT4OqW6OQ4JwoTA/BtW02pO0p1DPtKm6WvHYfzhtKd1E3nP9arg7oG2hMTU3rUgldulFiSwxl+lBk8fAUD/KImEE/5fN2S3zQChBsEaO5d5YUaFYxICz3yeCuCqVQ7+I4/egLoDtzP4vg8VbYYENdZUWXeBQFJQbefQzHpgQxGPZ7D5rl8IXJ96D8u1hteiStPoUJBGhvuosheOMueQu3PlKaWV0GV4tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xNUY/AqI0Ims47Rhxw9Ye1JsNtjqGuY/EJylZ5GSNI=;
 b=gsUg5aHSH0zn3DhFfhHCrxYlFpwi249jAcoAp/K0CyGfzjjbXQh8E04xFbC+d8yHge+hUKdwJgK3SXMO8UiYhHyzFmDSRx1vi4IxVFbTaRYSmXOSK/KT5ZAKg9fqMin486FaO+KJZkNSdB59IhDih6AJLh1a4vOAELaXlvOqo2gKOSnXFu2Qs6BXSe21cQxLM2YYJsjTCjI0J98vwlDHOXjavZ3gxvPLKTzeGpGWdm+Zq5KYE3loN6uIt4QyzFMVv9n4nAvzMUH5cFV/jTjRKgm3VlIhDJyX+JcIr3hxvVHQf4SRLTrswk1Qh1fyBWbO7PVJceCUEpOFNYfwrc5P1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH2PR12MB4953.namprd12.prod.outlook.com (2603:10b6:610:36::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Fri, 22 Sep 2023 10:06:34 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 10:06:34 +0000
Message-ID: <ab1a38ca-738d-4e1b-9786-b61854f069b2@nvidia.com>
Date:   Fri, 22 Sep 2023 11:06:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6.5 000/211] 6.5.5-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20230920112845.859868994@linuxfoundation.org>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0012.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::25) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH2PR12MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 9114a417-f015-4f39-2843-08dbbb5399f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxdceA8MwDoIyaX4m8T0FLB946QKHtSiDM2WCmjFFKx9aD94c7VtI0moVOF+s1JYOAvzVBIW18N/u+cMX31kpPaMY6dwhVvwe8vqZ4Ivs+48CqQ8RkXvfLv8oIZC2IyDkh9AROrmtObTNoHnVRYMjagyX9O6B05cp9VFS+DojSejZNQR3VmN2QBDoPDiAtIf8GPIu27GtwCgNxf5c/JZ7PL1H2GbNkUFodygmzQuX5CI5jb+MaLJhgchaWxywmUazWl5kIx1JNTXs0COIDbahTZadZnDh20k0EHMXWieJpopzBX+3yvsr1JMc+rJxxvk7pNNeWYGZG/YbOPfvk/q73vJWkrYirVZcjP7X8dMK+kSlVYnKMPgx7jSCY0qNDUzbq3qEBbhywhy/dul/bRow5eI2/OeiYQMYduu+ZPu0IdxDNuRmrzrHSlVpCv6Huzm1yBNHAN1VOG64ECf/CB9jnyydY6hp60L8RNGMdY8AzVgKOm9IMaPzhs4P1vSzvXvL5bqxXoJnOog1pOGYmakSfG1g2uiPhmwDPRhdzDWR7VrfCpoGq7RyhVk7wCvQPdmppCcyruTgtmTyJow3uURPg29IVsy1/GodGnRuJ4M+0H5uk4OtPTAxRT6eiyeAP0BFBoAzhegLRLcciN84N2PHCWDR3sRcewNWK0k7PzgJZKqkbkQgI2wAPf0r0BEq0Ue
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(186009)(1800799009)(451199024)(53546011)(6666004)(966005)(6506007)(6486002)(478600001)(6512007)(41300700001)(316002)(86362001)(2616005)(2906002)(83380400001)(66946007)(66556008)(66476007)(5660300002)(4326008)(8936002)(8676002)(36756003)(31696002)(38100700002)(7416002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NllEYTNWWmY5ZVRwdzNXb2NJMXJJZTk0K0hOUCtTcTRwQ0ZLbWRiRWxibXRP?=
 =?utf-8?B?V3NyODV0aTM3TEhLcU4zUXVvd2VLYitJTU83N3owMks3dkw1bGFpRGt1Zjds?=
 =?utf-8?B?bTZPTEVqd3lLOSs3bjJuYVY1M1ZZL0h6YXkvQXRnVkMxWmNEN0lBdTZYVFlT?=
 =?utf-8?B?M2ZaRzRDVENYcmZLdEE2QXA1VHBjUmpMajFzYjAvdWxUVUlmTW90VjhFZDdl?=
 =?utf-8?B?SHRjSFhEK3BtRC9DeGZpSDI0S0RpQmd3dGVVNGZIT3dTWDhjYnFvVHNHc3Vi?=
 =?utf-8?B?SWNKN2pUQUM2WlVlK1VjamUxV1puQVdwWEZQc1BMVFFZN0dCK25ZaEZFcHk2?=
 =?utf-8?B?b1NpQlQ0ZWpPdjBQU0tIK0UwS3BJeXhGcmRYdGVZZFdjRWpkWUFuMm51ZXA1?=
 =?utf-8?B?SjIya0FoZFhSSm01QTdYb2t6alEwQzlKbktiMnNBV1FCQzhNdWdnL0NHa25k?=
 =?utf-8?B?bDFnR1g4Zjh6WDR3eEVldW15U3pXdDRUWEN6amx2VGZwL0pCamoxNzJxV1N3?=
 =?utf-8?B?S0QyLzJIUHY3WVQ4blY0dzJOdCtONi9jSlpQVEFweUpyN3pIZElsS3VHMURX?=
 =?utf-8?B?RVhEM0ZVWnk1a3VhUm9YMWZYWVA3TG13ZmNTeUJOeEc2dXVkWFFZd2FCdy93?=
 =?utf-8?B?aDBOamcxZXp4N2R0YnAvekZOb2xwQmNvanlYaDNCbDlRUWVoWVc5K3hVLzhY?=
 =?utf-8?B?UzRVR1FUTjRpejl0K0U1WG5IdHhJK2N2VC8zTUpFSE5VMHpsWWJ2RGc1akd6?=
 =?utf-8?B?bm9QU085cUpVUHIzbFM3Mm5KY0VId2JpTFFDLytIRkFvZmJVbW9YRW5heUJy?=
 =?utf-8?B?VS9iQXNqU1BoUkxzME5oUUNSSTNrWUpOK2gzM3dpaGRNaDJhT1JpTVV4TUNH?=
 =?utf-8?B?Y1NzVW9aalluWTAwR25mUzlKamRRbDNrbXdwSE1yTERJRnhqWHJWUThYU0Z3?=
 =?utf-8?B?TDVVL2JnSjRjQ3Q0WG9MYXlXQWI1QkpCV0VzVWVBYlJpZXNaeXlWWitvZW4y?=
 =?utf-8?B?RVNtN2lIYkRGdERleHBXL2VQN3RrSnh6RWtwMmZjWDhJUXhJcGxUbHBQSkhj?=
 =?utf-8?B?TTVCYjEzVlZZOHVEL3Mxbm80MEIweWRXSnp0VnhUdnJtdmZBM1o2ZU5VTERp?=
 =?utf-8?B?NVNzK0FYTm1MY2Q2TWRSbFNVNHlrL01jWkVqSUR6OUZXakMzQnJHTmJuK0xO?=
 =?utf-8?B?MkNPRFZIa2t6SzBVejFIK2ZZNERFamJudEUwWWdWNDBEcWt5elZoTE5IUG45?=
 =?utf-8?B?U3JqZUNkVWd3cFdEalpRc2VMSkV5ZU5nRHJsK1RSM3N3SkpuQXFUTmJGTmJw?=
 =?utf-8?B?TUtUOFBYVXpuRmsvbUthTERveEFqaTBtNXB5bXJ0eHVuNGV5OHhPQ1M4NnBP?=
 =?utf-8?B?T1hib2kweDEzSHVadXNFbERHcGh6Z1JyZHUyOGxrNU16TEpHSzlvQUszVzJ2?=
 =?utf-8?B?T0RlcWZEc3ZObzlzcVV3aDRzR1RjYndOVDNkaHB6aFhCYWFqbU1RV3RXY1c4?=
 =?utf-8?B?YzFmY1MrTTJ1Vk5NeXVTK3B5eW5WTHRSaTh1VjNmbGdRU3lHU3BXczZ1M0No?=
 =?utf-8?B?MzQyaFlHQ1kvOGtON2o4MWV3UlVjUFpDNklXalNQTXRMMUoyM0JMcVFEbktF?=
 =?utf-8?B?K3gyTXN4VVZGNVJWek9mR0EzSFVCMmtVaFQwNlExVXNENjRKRG5UVzI3SEtv?=
 =?utf-8?B?TjJSNG11eFZoTTcySVVMT0dHZUNLOVl3Sk1FckNtZ3FqeW1yVVdkTnQxZU9N?=
 =?utf-8?B?UnU5MC95SDEyWVR5dTA0cGt0VS83Q01LSkxsY05vMzZ5bHVFVGxPeGphL1ZM?=
 =?utf-8?B?cWEzOFpRM3AxOW5ML1ovVmZvQ3MySUxiZTk0ekQ1eTdDZVpqT0ZJbk5LV0w5?=
 =?utf-8?B?UUdYVzJwdTluWlNoRkEzZUhZSDhvcXdxVmJsSjJJa3dnZjhaUjBDNkdwY1JI?=
 =?utf-8?B?MkdTUW1aMUREc2dyanVuSUtJVTl4RTh2N2Fsc01FL3U0cTd6bHM5aGZDc2N4?=
 =?utf-8?B?MVJoNVRBRmFySldKaWp4TWN3clhVajAxM3BMQjBRRnJ3MkRJLysreWwxN2Vk?=
 =?utf-8?B?ME5oNHRpOVhndVFuUTAyK0p2TlNqYXRwdUFYdXhVTkNwaVR1RmR3aDgwMFM5?=
 =?utf-8?B?SURUV0k5N2FtVittZmFRbXhvM1A2My81WmhvTEVUd2RZYk5xaFhpZnQ0b3Fq?=
 =?utf-8?Q?lU5fv7tdeGxg5C3+R1r/m5EBv6EAI6oiWmGLkish6XUd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9114a417-f015-4f39-2843-08dbbb5399f9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 10:06:34.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lp53QsttwhwZsyfBiQNN0WDJD5Cmthb7ngpU/0PGbilKNCPKxwwDGDrW7r/EUnivxp6vbIerkwsbqtKF3y3FVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4953
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 20/09/2023 12:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.5 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

I am also seeing suspend regressions on this update. I am guessing it is 
the same issue with linux-6.1.y.

Test results for stable-v6.5:
     11 builds:	11 pass, 0 fail
     28 boots:	28 pass, 0 fail
     116 tests:	110 pass, 6 fail

Linux version:	6.5.5-rc1-g9e47a110b1b5
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                 tegra194-p2972-0000, tegra194-p3509-0000+p3668-0000,
                 tegra20-ventana, tegra210-p2371-2180,
                 tegra210-p3450-0000, tegra30-cardhu-a04

Test failures:	tegra124-jetson-tk1: pm-system-suspend.sh
                 tegra186-p2771-0000: tegra-audio-dmic-capture.sh
                 tegra20-ventana: pm-system-suspend.sh
                 tegra30-cardhu-a04: pm-system-suspend.sh

I will see if I can figure out which change is causing this.

Jon

-- 
nvpublic
