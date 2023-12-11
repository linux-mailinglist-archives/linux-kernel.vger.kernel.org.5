Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC3C80C5E8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbjLKKJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234883AbjLKKJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:09:08 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511D71734;
        Mon, 11 Dec 2023 02:08:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKrGxcYuNZbJOQOox4CzLNDjolXfBqoywrw173uL3lmLImBIvmDVNn5oTLLmRlOT4spGsDM6nFYEeGXaK3njsyR3InRCgZ0r0EY9UskrOUjSl+1Vb9PVlbi8hlDiZIF7O9StOl+Na9axdCmoNjM3cXtjgVggO33w3azYl8gvHEmPQuPs6MUpL18VnRLAEOSAUTkelPNNmdyeKzxloDWLzZ2uL7IDkhP+gfAaVaDRVKqQX8esYZ3RNerGU2jyObw4hFJudF/y3gb0l/URYOTbzSc30rF3Zf+MyjL25Yhg58B9v1FuoSuya9gmuie4mz5tHRYOMIOpEYyKjl14Q/1nPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71+oWSnSfk3fDz/1QxzY2uu/SYxydALkIMaNWb06PhI=;
 b=W7U0AO9ZVEp7p00IY899cy2/qK72U9pmcJm3IFslJhF54+pVJmFU8uWTdhOW/wGoChiqkqHp2fqRiA6e1+viv1UUvlnIYIIzRg0eZ2ab5HKEQQI9XHNVgI2Fy0aJRjPSJPcQrCRbHbPHVFncDkoQ5PcFd0PSAXYal1LcUzu1p8luBaMLNoptYEjHerCsPlYly3oDkC4CDSgzkcz8Mv3OIDLZtKsfE70ztWjAGwrsDij4cCsoNy1Bh3MDxwBf6jfJq9fhsmMPkN5/S4AbutuPdGl12Jl/cdsWOZCYsoq1goIMQ6axJFA+LicZxgmtg8hrS3eXi2py9VCvXi4RK6IG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71+oWSnSfk3fDz/1QxzY2uu/SYxydALkIMaNWb06PhI=;
 b=ZvLO0zEPSZA3YEcQM21nvX4qp4uVxBZsIu4r3gmjePc9A0tg12vOR94eAzzeFh14XKiJ0woyIp8I1YGRH2U9TDAlMeIjzz+s0ccg4WKOgYzaKE+kvIgWIeiz2k9iEknp5whI9oNYx8CaIDjTQW7BmotY5vWgTPTDlv9bSQpXZqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:08:30 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 10:08:30 +0000
Message-ID: <08f25cb0-793c-441c-b033-0de8104629c9@amd.com>
Date:   Mon, 11 Dec 2023 18:08:24 +0800
User-Agent: Mozilla Thunderbird
Cc:     majun@amd.com
Subject: Re: [PATCH v16 0/9] Enable Wifi RFI interference mitigation feature
 support
To:     Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
        lenb@kernel.org, hdegoede@redhat.com, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231211100630.2170152-1-Jun.Ma2@amd.com>
Content-Language: en-US
From:   "Ma, Jun" <majun@amd.com>
In-Reply-To: <20231211100630.2170152-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0017.apcprd06.prod.outlook.com
 (2603:1096:4:186::15) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad196ab-cc87-4bbd-bcc8-08dbfa31203e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5u1Z3TxJ/bs6E06Cc9BR18o3vwPCmhFsuomzqk+NuUB3St0z3TX14rr4u/GgI7ZR67cZQel4yqW6ldlqp4dPjOzdiWhQZoFjblhNYbOKiflX6e2tTfNS8vtQKcoAPN+ohSYez4FtSsIQX0xRb8e5PgmX5tO+JakJNBPBm6Q8cKRQ/t4xNIWt1BLpH3T+S4ivncBzNRD0y9USg9cJptuAF37hN4dDKJ78A7bNBz+rUo3OzJnlYDbXNkKKX0lQTxjkWNKi4hwuy5OdBGKgbYViUA8aBOENdLtTnxooJQB12ZngaJkzxEiG2z+/yS5teQmDZM7jTgaPAD00JaSVGGo+S22Kf7ln68E6WRGeTFohlfarlBDoKPTsK+jfd6KqJlWkRkvUdr7yZnoof0svKQDsJIitA3oUCt1i6IZnZZELuhRktdrghwDrUpxKlUstfPoeFdOwh9ogqFYuofBoqYnwnWDyMPqRXH6s6pFapp3Vns2ifCn9Dp5xU6/WfdHFGivR1U4pcRrxMJlgBLD1Wa/KgygTZHk5zTHc4GbF0cH+aP9umUusNgpQTgc8Y4sABLL6lgDmm3S8/zXwaykmnzhbiBXyfB4tIRiEPdtd4RKF5lXVdta8qMde54/m8moTaIxuMy7Qt9rs9cwCt3fit6aCTMYaccDfP0MTeqAxKPVPqA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(2616005)(26005)(83380400001)(36756003)(31696002)(921008)(38100700002)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(7416002)(6666004)(6512007)(6506007)(53546011)(66946007)(66556008)(66476007)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3ZmTVRCc21JYlhvaG1HMWJvaVdpWUFrczEyVlc5VWVBQ0dqblpQNENjNzFR?=
 =?utf-8?B?WnArUzhkMU1Zd0JMNklMZi8rbW5YdS9HRmxZa08zSHdaWERyZ1BBZjNKUFFh?=
 =?utf-8?B?ZWVjaWRPQjJuTDIwRFFWWEF4MkNTRGJaYVJkWnJNYzVpRngwWXFuV240amtH?=
 =?utf-8?B?aVA1NUdYQ1JPRkQwL3ZyeEttWFc2VFpQaEhqRmIxWjRzdTMyTEN4RlNRTUlB?=
 =?utf-8?B?VTNONU8rVnZwdXVHYkZ5dWxxZlpLeTZWQ2FLVGo1N2VabFpaUE1HZFJsWXRa?=
 =?utf-8?B?MTU1WkZxV003ZS8rVkRUSWxBT1FvR3JlMjQ1K2lTVWx6VnpYK1RhcUw2aHFx?=
 =?utf-8?B?UDh4dlBVd2hMUisyVDZNRmdYejkvZm9BQTl4akQrNDk5anVmWjI1dG9rNjZF?=
 =?utf-8?B?eGJRaWxmNmxBUUZ2TXpSdTV5VXdneEZjMGd0VC9scFl1aXRuWE4zY2tUb2Y1?=
 =?utf-8?B?Mjl0OFRvNEZ1RVZ0YkRpVW9wb2NRYmR3UTFZK21WR2hFQk9GYnN3UmZxWTZ1?=
 =?utf-8?B?ek1jcXVpQlI0M1lNZzZSeHZwbUVCWEU1RDZpdnNoVjY5alJ0Rm85RDY2TzJv?=
 =?utf-8?B?ZXcvdnIvandMSHFzclJqMnhUMDE4MmFWalp6N2x2bGdzdmd2RU9VSXZXUmhW?=
 =?utf-8?B?MXh0N0RVV0FMd3hNVzdldmdmNWlNNjFleVQ0cWZPS1NFUmtweCtkdllNK0JP?=
 =?utf-8?B?M2FmNW9KSG5xUC9MMHN2c0ljcEl1bHN3Ymg5Nk56N3lvYUZvUFZIaHpBV1d6?=
 =?utf-8?B?emQrQVNTU2hIeDlIWXBPcjMreTFTOWhycXhwUEYrMjlEREIva1kxL3BtWnZZ?=
 =?utf-8?B?RDBHME9oTkFaQ09HQmRxUVFwMmdZeHM5S1pGQmNnaFBkVnVFck9VY0QrbFAw?=
 =?utf-8?B?ampKL0F4K25tcXE5VTZPa1FLNGVXWnRFK1I0TDRYbHFFdEo3QkxuOElzQ1hI?=
 =?utf-8?B?MS8ya00ydW1Id2xOYzVLUENoVnZkL1U2eTFGS0FQK1FKY2QxTmVnU0hQVGdr?=
 =?utf-8?B?VlRoOFJsQ1FjVEYwL0ZtS0lNcUxUSVZOMkVVdkNDNEdLYkJLWXVmeDNWOXUx?=
 =?utf-8?B?M2hsemMyUTR3dFFZOFRPM0l1QldmNTZoOVNBbWdndWE1dzFoRG5UVEttWUha?=
 =?utf-8?B?NHFVd1owYnM1MjBHWFdkZFJVS0tBa0dHenVNNUdtbW1oeXN6VG5nbStLZmR0?=
 =?utf-8?B?NEZqcGpkRm9SaE1qT2lKTDRIK3lDYVpHRnUzZnduZEF4R0xxL1FSSUdlUmhj?=
 =?utf-8?B?Zjh3TlJxNHNFeC9Ya25FdG5VRHB2eUdIWFRyOW82RFJsZkU4dnlGZThBZWxQ?=
 =?utf-8?B?UWRWSzk1V1ZQbHVpRXAwZ01Wc0JRdFE5dncySEhFUlBFQ0NoblgrbEp4NTJt?=
 =?utf-8?B?R2JwOFVZcVZwZmpLanFZa1NHWW9TVkRTano3OHRSUlE0MC93NHg1aVdzK2NR?=
 =?utf-8?B?ZEI0UWtlcWI1NTcySzRSdTJLVW82QnY2ZW1reVNNS0RRVTQvK3BxYnQ4dWdJ?=
 =?utf-8?B?QWw5MUQ3cml4L2VEWEZJYnJ0S2xDRjRFWkFjQTdqcUZ6bGpkb0FzR1diNGJL?=
 =?utf-8?B?amNXckUxMERYRU1IN08zUExyM1FQZGdvZk5jRUhybmNtaEFHUWw3ekFhc0R2?=
 =?utf-8?B?NG5kTE5QY0ZMNitWRTFpbGw1dUFBQXhlRmtLVFNWQUhlRnd0MVNxc2d0by80?=
 =?utf-8?B?VFhuZy9mUnVvN3d0VDlpK1I3ZCtxUURLRStQVTl6TUNXN1ZHVCtqVERIdWg0?=
 =?utf-8?B?MWd2OHNJOGZvWUZtWm5yV2NGMEpzSjN2cDBSUXlxZ2JRZzhmc21HM2VRSWN1?=
 =?utf-8?B?ekRib2hEa2lCZ3BINkZPMDNIR0hqN3lRUUdmSkdRdjMxVUJ3WkZHd0g5bkhp?=
 =?utf-8?B?OTBhRGl2RUZZV2RrMW1uYVVDVjVuOWJGVmFtVzJtY0dhN01DUWoxSk9jQXNh?=
 =?utf-8?B?ejFOL1ZNV0xHVWMreUFMWTFkRFU5K3VpUnhmbXpGZ1l1NVhiZzlNZG9aa09y?=
 =?utf-8?B?a2RXYmFDY2hKaUtEaWxtWFNkWVNIVVFGRWVHeU0rdFVtN0ZSaVlRVGdIVTJ5?=
 =?utf-8?B?ek0wUDBzd01LUXNIbHZ1dUt3NTM5M2JabGF4cjg5aFdyeXBndjZ0RVJsUTJx?=
 =?utf-8?Q?/wVwOqvgObo/JbtjYeG9xppPK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad196ab-cc87-4bbd-bcc8-08dbfa31203e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:08:30.7484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUpQudEKQm4SZLYAR50uJDq9fr5vWYLH4r71gm7SiJgYouj6bQpViYtFHW0f2nPt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Compared with the previous version(v15), only patch 1 was modified to fix compilation errors,
and other patches remained the same as the previous version.

Regards,
Ma Jun

On 12/11/2023 6:06 PM, Ma Jun wrote:
> Due to electrical and mechanical constraints in certain platform designs there
> may be likely interference of relatively high-powered harmonics of the (G-)DDR
> memory clocks with local radio module frequency bands used by Wifi 6/6e/7. To
> mitigate possible RFI interference we introuduced WBRF(Wifi Band RFI mitigation Feature).
> Producers can advertise the frequencies in use and consumers can use this information
> to avoid using these frequencies for sensitive features.
> 
> The whole patch set is based on Linux 6.7.0-rc4 With some brief introductions
> as below:
> Patch1:      Document about WBRF
> Patch2:      Core functionality setup for WBRF feature support
> Patch3 - 4:  Bring WBRF support to wifi subsystem.
> Patch5 - 9:  Bring WBRF support to AMD graphics driver.
> 
> Evan Quan (6):
>   cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
>   wifi: mac80211: Add support for WBRF features
>   drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
>   drm/amd/pm: setup the framework to support Wifi RFI mitigation feature
>   drm/amd/pm: add flood detection for wbrf events
>   drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7
> 
> Ma Jun (3):
>   Documentation/driver-api: Add document about WBRF mechanism
>   platform/x86/amd: Add support for AMD ACPI based Wifi band RFI
>     mitigation feature
>   drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0
> 
>  Documentation/driver-api/index.rst            |   1 +
>  Documentation/driver-api/wbrf.rst             |  78 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 208 ++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  42 +++
>  .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |   3 +-
>  .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     |   3 +-
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |   5 +-
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |   3 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   4 +
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  48 +++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  22 ++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  13 +
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
>  drivers/platform/x86/amd/Kconfig              |  14 +
>  drivers/platform/x86/amd/Makefile             |   1 +
>  drivers/platform/x86/amd/wbrf.c               | 317 ++++++++++++++++++
>  include/linux/acpi_amd_wbrf.h                 |  91 +++++
>  include/net/cfg80211.h                        |   9 +
>  net/mac80211/Makefile                         |   2 +
>  net/mac80211/chan.c                           |   9 +
>  net/mac80211/ieee80211_i.h                    |   7 +
>  net/mac80211/main.c                           |   2 +
>  net/mac80211/wbrf.c                           |  95 ++++++
>  net/wireless/chan.c                           |   3 +-
>  27 files changed, 997 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/driver-api/wbrf.rst
>  create mode 100644 drivers/platform/x86/amd/wbrf.c
>  create mode 100644 include/linux/acpi_amd_wbrf.h
>  create mode 100644 net/mac80211/wbrf.c
> 
