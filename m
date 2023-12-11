Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE7880C5EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjLKKJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjLKKJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:09:21 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D6D1BE8;
        Mon, 11 Dec 2023 02:09:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTSNmlwHT6kWOuVBkvcWhHzTDTguyU2v+exb1mFl6pAsYTDmPC1TZIJrhSk7AbAAf0BkIsaweumbXXzfKdm28q30WFK5ELT5ZlfzRV48hbwb/f8wqJWayssxuutdmH8TmnyFT5o6Nha1VEzI4jSsCPWh58j4pY0fYFrfaWoj7Y163vGmGS+51lxpW/6P2rs/7vkxjHiiXuIC8ulNE832FsXW2pTYMolriYle40TUlh3D+oONGY03D+8uaIc51Fb1Acl+M6++m+fFpOJKhIB7hx0aI9Tz4OExCR/5Ya7M/TYHrEsflJRAY+uEYAxgptea9wsmdXTerh5xzydC63hp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71+oWSnSfk3fDz/1QxzY2uu/SYxydALkIMaNWb06PhI=;
 b=YF3U4WxHTiT2SdmuN0tKB82a8Rqd6voaOy51g2XDLpPpD8L/nM8equ7VWYDfOGjH/Mjxthdl75+gWrhpHzs3zjpeTRRvNI8dY+I1z+an+Cjeo0drrDvqfWMXVq6rgPqKQwYl5N2jtFQ5NBDxK4NSfrJZxMgo2uMeWS4Lu2xkBYn22tMKSIYK31QwAZt4VMGkuGP0Rlg77f3fwpwC+vq79rcLFVMu1MEt+FdO97FeDJBTxamf0cKLev6Tgunhgpy9fGUHS6doMcmjzCE5ZI0IZd8wiKKvGdMRv0kjmuOM9yeyAaiFu0+82KiwA1wRUvYg2CKuL5ly1ai0caWmBpMO6Q==
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
 2023 10:08:37 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::8650:7935:179:f18c%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 10:08:37 +0000
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
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: b2a16355-c56c-4d37-7bc9-08dbfa312468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AlkhNmQfOmhoIQGSHRzJjE6nj34u5FxnVVF+adgIYc6maU89fn4/gt4FZOSTYKOymF42Zg8ychSJxNB0bdo0ABTyX1yiEBKG46AOOtO9dMzmDPxHrE8iNNI6FrBQPb0V2Y3IzAKe9BuTnsmWfApLGRhxDn57QdyFtCzsaLeTFgUux6O4zxqLgqG+W2xF4udhrDDR8nT31NXFBmEQVP/VKeD4R+jI8UEJvptDDrsf14TVXgG4+GN2kMOr9gSvRNs0d6EjR6oPRVdNj6HjAczdVq8nAWLwwS+/y3MMEcF+vKA+9nPpirCR+dJkqo9EKAYojOwvGB9/KP4n2QqsNtgukL5OKNpRjscKKbOWHN3rQo5N1krklX5HNRKeh2Ed4Vhq3w4+rB+2Jz5ck2HbWCISgVpnWR0G/b/s1PcW62BUjPoPnJ8LSSDgcq6Eu/15KU+IzOh1l6vckTdTQnpYVHPj0dTayCPwSGeo/0EsEeqF+3R+/102nsCiDCOSBKvmjCs1bEQODUvLF2vLHJUC1OB2rqB1GrWUEXVWMC/mkb1QgxOdjPg9bW82CvUB7UF4JNkP4sI7C6jOCxMYAedjx0Ua9h0Q3KVATzm4aRreYhQLX3260uml+hCjNceCGo/kVV15Hkq+CX4G2WuMzLqXrpo27NQOF3FXMlW6epgMsIaiKaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(2616005)(26005)(83380400001)(36756003)(31696002)(921008)(38100700002)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(7416002)(6666004)(6512007)(6506007)(53546011)(66946007)(66556008)(66476007)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVMyb0w3Zlh4bStiVHRYeFNiWStRTVlmRkQxRFJVNHdPbVFkN3Z1cU5lckEz?=
 =?utf-8?B?MGM1bmxLT2FUdHdLbjZ1Z0dTa3NiYmx0dWdBckd6Q0tEVjU2OUJLY3I4YVdJ?=
 =?utf-8?B?Tys2aHNwcnVFRlFvSm5wRkdCTUdCcXZXSk1QR1hQS0ZnS3d6SGo0dy9DTzJa?=
 =?utf-8?B?M09MUDdoU3g0Zk9NQUc4UmExdGJCcGhLMnZObnZDK2JKRXpNNWVoRXh6cXM5?=
 =?utf-8?B?cElKQ01rbDBJTzVJWTZudFdvczJFRlZGTzVWa01NU2ZUc1JPVkhxV2tVZjM1?=
 =?utf-8?B?RHpZS0RLTW84cHlYOUhZMTBPNEVrU0xKY0tPTDhtTWRFWTQveDJ5S2IzbXJW?=
 =?utf-8?B?dHlzOG9wMi96NnROWWFtNDUydW1samE4T0lDYVI3Y0p6MnZiNmNGQkNnZG5a?=
 =?utf-8?B?WWEvaGpGdW4zZ0V0bklSRVVhVGNXenJnRk90QURzMHA5QXY4VjNDa3Exdnlw?=
 =?utf-8?B?eHBhU2RVZWxJTWI5U1ozKzlWNnRUM0pwN0h5MkhTS3RYT2lmSzA5Mll2TVF0?=
 =?utf-8?B?UXQyMEtJTTZVSTNrOUhGLzhFZzNBMjVqRVFRSGVxcWMyMzlESUEyUkdoZ0FP?=
 =?utf-8?B?UnBPeTZ5dDY5OXFnZ0Y4d09lVy9XRU1jalVhOUF0QWFiSDgrNWxMRVpoaGx3?=
 =?utf-8?B?VFpMdHRPRCtGbW9BNUxKYmNKQmd3bmZTNzNQWTVBR1NRdTkvMnQyZlU4UFhB?=
 =?utf-8?B?bHNMVWROa1RNZlh4VVBaTUhuZExyYnV5elQ1VzVOL0sySnp1L1dRTTNkTjhB?=
 =?utf-8?B?aGg3Vy8rb3E5UUxtcldSRzVIRTE0cVdCekNrelVVV1kwdDRWQURncm1iaEkz?=
 =?utf-8?B?dzI0WjNWdzF4WTJ3eVdaTHFBODVtSEhDNDl0TmlFNWQxRkxnTCtnemtzMzM4?=
 =?utf-8?B?eEZVK2ErWUljalptWENRQW9jWENoZVdMN1lvRlJWUVUyRm5kVjJCd1Axd0Y0?=
 =?utf-8?B?UnNwTHZsdDJzU2g4eVVFSnBmSVp5TUgrR1B2Snk3azRmazBrRExVcjNiNHlo?=
 =?utf-8?B?VHBSMEpESkpOMkUxSkR4UWZyZ0hhQkZNbmhSeWtSRlMzSk9FZ3ZCV0lOblJC?=
 =?utf-8?B?S2EzT1JIc1B3ZnRscThCb1dHU2paTUFLcjB3ZlFCN3NGUkxzcmpkblZOdVZJ?=
 =?utf-8?B?TUUxbW50bzE5azg1Q1NuTi9pV01CNmlIY20reWlrU2psN3IzeFBMM01oQlY2?=
 =?utf-8?B?L1I5b0ZBMjJWaEVqaTJ5OFhmMDhhYWhlbkJiclRta0V5TmNZK2xDQTZIdWpq?=
 =?utf-8?B?QUZJSGFTRC8zc0U3UzRZa3lsaU04M0xMRHBTbkNoRml2cFBpeVQram5CY0J6?=
 =?utf-8?B?KzVlTTFkTUFZbE5HazJTLzNRVlNDU3pLSmIxVjd4VnA4bE9rVlNocDNualdN?=
 =?utf-8?B?OHJXcFVDSXVBZUp0UWo4U1ZoaFlPWUEvcHc0SGlZWkI2TFFRLzRwYmVCTktr?=
 =?utf-8?B?NTd3NTZRbVcwY2VxSnZ3RlhLNDgweEhYa1V3c0F1bWZMZDkzU2RlN3NIRXFo?=
 =?utf-8?B?UXBuVWVvMzFpSWN0RWQ3aHdUUkprTXdxVEJpbjY0QWV3QS9RUExVTFJyQ1Ro?=
 =?utf-8?B?RzF0d2FLcG1rWHh0NzNMMDk0bjh1aGpWZFJLUWlxNTNaNXBNeXJtTnZPMytV?=
 =?utf-8?B?V0NsT3hoVUwxc0hDaDY2M09kaURMbUdTb0QwZUQ4ZzlEU25nbmRjZ0tYdHpF?=
 =?utf-8?B?NWJ0VXA2YStGUmRFbGhzd3drY2MvLzVYOEt0Z2hGaWluNmpVOW4xU3lmNDk4?=
 =?utf-8?B?bkpPdTM4ZUFBK3hWejBsSzlTN0tDY2hEdlpVUlFnaHdsaDVMYmhZd3AxQXVK?=
 =?utf-8?B?UERtS1Zwd0tYeWFVcmdVMDhMNDR3U3hNcVNJRFkwUnZrL1NYSEEvOVR3VG80?=
 =?utf-8?B?SXh2dkdFdHdUUDlqdkd2OFl0RC9QWTRXWjlTMXgreE1Ob2RpRWJHeEJDUzZ1?=
 =?utf-8?B?V2pjRkl3MGlMWXZlbWNRRnk5eTFCbDVDWDdvblA4UEgwbUx1cFRCSVczcjAy?=
 =?utf-8?B?RDFUOG5ZUFlqcVdZbE9tTEx4a1JJOW1tT2YrVkcrVkxLWnJ1TytSdEkwZlow?=
 =?utf-8?B?R1QvTVpRSmd0T3B6cnhwUlE2VUZldC9NM0NnSUZJcGk5Q2pEZ2lqTUFGdzFB?=
 =?utf-8?Q?o6hjhIAvnpOqZ+xxE9ZXIUZ4U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2a16355-c56c-4d37-7bc9-08dbfa312468
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 10:08:37.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0p2avOCc64/ruWL3S+cQRhJ112VyG7Z2i6Amomk+yrliV2/dAHaeRLPQKQ+wmzvu
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
