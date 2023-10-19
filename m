Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A587CEFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 08:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjJSGRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 02:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjJSGRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 02:17:32 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A0BE;
        Wed, 18 Oct 2023 23:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIiZTC8SUCZUuqu0tpLuReSNlmWb1y4B7u+5RAvtv1D2eVptQUEF0MWj3Z/g3kGy0/jttu5EsyTdayERkwgkH1yO/q5GcR91kUxrNPmJ8zSLOXhA3PXzETHfpEbJruMLMpUI0dY+z1e6jqM7mfwrZHpeLXO+/atoacbuTcTUxPrcEn9NLYwejfhqaai9hby6aY/S3E8dosoVoRKJ7nRm/Da8UXV1j4g1cBznzuFRJuPMaYgeuVPJihLDILmTUxVLLaqF3rq6qTwrMMBlCRoRTM+qq8y5E1E4mYYdmyruIcfWDBghLIFqRqb3E6nuecxzrCK42+8cnT5BmYXbjrPWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBqT9M2T6hc5bLw1aqb0YQoiwrwBpKLwAnvUhAfWy8g=;
 b=W2KhIdmjCAn6cwbW3CFSzJkUeaOfsc+1LXp/MzLhNt+YI1zPpLY+HrvzeB8lwqHUPUlQBbdr/fotk3SEaGO7WG7c5kuDrHqxOZFFx5dpqhIBRCkHbws0jM6SMILyScleqLDR6HwZ+ussooq/OzXTS7tj7Pyix6PNfvKFiaeJYKuhNX+YwddVQdFP/kmopuYTYldCyFdVHkzKCBco3OPtdjzrUs2O1Gx21L6ZGmZDDzmmHzgpYX9B8xYpwVllOP/jmmq0RjpWLiUsbSTN+FbTjNef1JEL0YxAPCU1wjCQCwoB0+stj9Rwvewf0PPSEr80WyUYQR0Nq/vvSYEoM/qiRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBqT9M2T6hc5bLw1aqb0YQoiwrwBpKLwAnvUhAfWy8g=;
 b=35iKzvkzgI9992OSfHS2FRca8buagfQy9pSWUtc8PUpG+Eru+fxSt/JWfNNWxOI7IAqo5DRYdmk5TuByaJ5OIuMgIwKgArTQJdebnSgq6XTU+Vk7aCje9XAJsREpc2mvz05Ea8f7UGRQjuMs1PYKO7N/wD9eLW14h5z1O57fHWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.21; Thu, 19 Oct 2023 06:17:27 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::4ead:d69:799a:281e%5]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 06:17:27 +0000
Message-ID: <5f85eb72-3f34-4006-85ca-2a2181113008@amd.com>
Date:   Thu, 19 Oct 2023 14:17:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     majun@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v12 0/9] Enable Wifi RFI interference mitigation feature
 support
To:     Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
        lenb@kernel.org, johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
Content-Language: en-US
From:   "Ma, Jun" <majun@amd.com>
In-Reply-To: <20231017025358.1773598-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CY5PR12MB6624:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b615315-c40e-4d10-ff8b-08dbd06b10f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ii/tGh10VP9UnPb2VjGTclKf5AICZQUkYGgCjJiiGpBQc6BjUibPyx9Zq5Mx3HTdEi4gYZSD42H/0nP3D6ihNto6rTULo+aY4YvxepRdwz9cf3QfJFzuuxvDiOj/g6BIFpDyne+N8706DmGT2r/50JaPn6oxEyi5+E7YCxZFJ1EyuOKuXOy7mQjOzCSWQf4dOiJwSaGUezzahoIey9hqEZZQRZQFYXXrR9g1Kk8UgHwrx5CrOeDWO2Cloxb/knUuBqRlAEP+xIvwIhkiJF5QZbYfYGXBoweLpTuASgvNW04SKOW98kwnCpuQWKbN+hbrSuUrsG+Q1uc7hWxMy2/c+aLwOVWH3FK+2Q92W/jnSfH+B5X7At8RCDDPXRHo2RoPK66Uig1lthSKVSrSSoSwO5vNyC6yDu5rWLsfpVmBXMQ2OWySKhf56fkh+i/gd5sZFPiQdaAL0NSCF+WssRcVKEO2bSRsyEEaXYsrcJYZ6r210FdIYNBah+WhQcqYCW4q5MRcd6s8wIpuzjUX2yMICzmFFLwKp/oXTo2hjQ42SE+WjTJnL9vmnt2PgzeaYrXQ/Gk+c7f2Vth0I+8H/UYRKSDuWFe0AA2DFgaeAtkaI5r4EEqwknHMsyyWiWJMzKhF7OWWvWkXI9R8IDCpX1uPCOoOFQx6mh8+Em9novH0THA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(36756003)(31686004)(66476007)(6636002)(66556008)(31696002)(38100700002)(921005)(53546011)(316002)(6666004)(26005)(2616005)(83380400001)(6512007)(6506007)(66946007)(4326008)(8936002)(478600001)(8676002)(2906002)(7416002)(5660300002)(6486002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzErOVMrdFJib1FUTFZRR0xDMGRpTW16Tk1lUnEyL1FOSng3TTRmeGd4WFpj?=
 =?utf-8?B?eG1aTE0yL283aXJJZWVQNGdDUG5QUEE5Y1Q5OFU3amIzN0YwN0FHdXkvenpZ?=
 =?utf-8?B?MGxVQ3c3RXU2YnJHd1UyQWU5VnZYYUEza1Rkc25VbkJYMHZMakhYdXhwUXRy?=
 =?utf-8?B?dmhPSnNYMkNIWmhBMFBOL1RmU1N6Qk9aS3F5b3k5Um1yYmtrQXB2eGxNcU5a?=
 =?utf-8?B?Ukt0clJFYTZnZXFxL2RFWG9CRmxDQnRIMjlIU0hXQzY0SEZNaUpjT2xYMDZ4?=
 =?utf-8?B?aURDZWtJSENrMXZLYVlGakYrTURzYmRQYzU2WmRjSEJ6Q3gzV2d0ZkhjdFQ1?=
 =?utf-8?B?TmVyYkNsZ29BQ25LRnVidm9pZldMSWlGY1pFd29VN2pMVDNSdlFSUTErRCt0?=
 =?utf-8?B?WXZxY0toclFOZFVtbXJWaFJJNldJLzBUNDNqOFpKZS8xTjdITVFIRHBydlFH?=
 =?utf-8?B?MklpSVhQUHoxVTNpSXNWNU4rbHBWUmhDdEgzNjViYzFERDVFSEV1a3RQOXJF?=
 =?utf-8?B?cTlJOFdXM2NPa1FSVGpZWitialVrTENlRGsrclJvMnU2NW5qZnBWZEJpR25R?=
 =?utf-8?B?QXlDSEQreXA2YW56OFkwYTJkU2RxT25YNjBIUVVCM2UzVHVrU2RldXYyRmxv?=
 =?utf-8?B?RDU0d0c4d1pVWGNiRm5POXJ4a2xHZy9xTVpMeVNTZy9OK1AyalAxZ3VxUHNZ?=
 =?utf-8?B?M013VlRaNmlDN3YvKzZFYkZCcFJFMnFTMnB4cVFGeWRodCtKWnFQMWUydmhW?=
 =?utf-8?B?eS95Qzd4MDBXL2IrVkVlb2VKNXlzUlRkQnB6M1hDcVNackh1RVhxWTVhRGQ5?=
 =?utf-8?B?S0V3UHV2VHkzcHdYVW9ZcjBBazVncWJ3VEU1ZE9OdEROd2wzUU8zY05lbmxB?=
 =?utf-8?B?R1JyR2pLcGk4d2g1YWROcVVMcGE0ZVdheVB1NzNQNWE5TEhQT1F1NzlXQ1Bp?=
 =?utf-8?B?U0F1OXNWMUw5bW9tSkpZalFMSU1JTkdnQWIrVEJkQ2pDaXFzbUJwQ2gxcklM?=
 =?utf-8?B?MldMOVlIczl5QS9HeElWZmFUeWFsNEhUM1hDQXUzZGJBZW8xTU4zTnh1ekhN?=
 =?utf-8?B?TWNWNlptam96bnZtNnJoT09FRFpHQ09neThNYzIreHdOZStmbUoydnJoQjBh?=
 =?utf-8?B?K2h2RUYvdUo0dlZqdW0vZjFac3gzSE5HcG0yMjlYQnpnOUN5ZjU4V00yRjJV?=
 =?utf-8?B?NVVyTnNwZUJzZTYyczRISlJqNUE1MGcyZWVaV0RVQXFhMkgwUnY3cU16VThp?=
 =?utf-8?B?aWtUSFVxSEtEaWdlbFNiV3pFcVJaaGtocE9TUmwrNnBSOS8wdjd3MXhKU09r?=
 =?utf-8?B?MzVGeXFMSjNONDBPdUVpdXFRUFo5N0lab1lTQUhManMvSGZXVnJMa00xMHhQ?=
 =?utf-8?B?V3pSRkdIZ0JLZVpidGNUaVFoNHB2bHpkL0NoMXlEY1NQWWdZUThqVmtIMGly?=
 =?utf-8?B?T0tPTkhodG5NQk9yNDhac05uWVBXTktTSTdjbTlGQnUrSnZoKzRUZ1Rrd25V?=
 =?utf-8?B?bmtQclZESGpkOE5OQkYwNThMR0l4OXlCT2dmTHRFR3FjcGdnRStsNFlNQ3lM?=
 =?utf-8?B?ZEhUTDZ1ODQxeE1uNjkwMDhKVDQyQzd4ZjZIaDdFUjdPYThadjlicFRFZXdH?=
 =?utf-8?B?emhsTUVQeVpUdUtFeVFEMDhSTzdvZ0JYaytoWUhFRC9vUHNDTWdjOVYxcTBu?=
 =?utf-8?B?dGRhMjBTSDBZZFVFdFdGODZSbkJ2T0JjR0gwdjArdlowNFRPSlNpM2hGckx3?=
 =?utf-8?B?YkxoQmlDTkxxNmFiZ1Z1ZTFnTXlUeWcxM2dBVGh1aHpiZDBLb3YxeG8zL2ZE?=
 =?utf-8?B?SU00ak1CbmRuODFqSVNQL2VoVElDZmZLSjUvK3FySFlZQ2pTdUVyTkdNWFEv?=
 =?utf-8?B?R1ZwRWk4dC9nbTViUXIrSUVVamNMSi9Xd0s0NmsxWVFlUXMzVU9kdGFPSnUr?=
 =?utf-8?B?dFRpZk4yTzZVNFpBSGI5TG5OSHBaSzRVYm9BMGlTNENiY3lLM29WU3lkWDh1?=
 =?utf-8?B?cG94NmFOL2h1TkxLSW9helc0Q1ZEbzNIajBldGlIbngwc2NjSlNBWjYycmtY?=
 =?utf-8?B?ejdFTG4yek9CODBJS0pmZzZuVGo5dzVac0t2dHg1NFdEaUNuMTEyalcvRHNy?=
 =?utf-8?Q?W+ZWdbQWlmK9a/0CM6ApDJuBd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b615315-c40e-4d10-ff8b-08dbd06b10f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 06:17:27.0476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4H7oxub/tPvGJovCWG0BtUXh6ypfXoyVox79Ye9oFsd9VBLguZySFA74kWpLkINC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...
Any other comments?

Regards,
Ma Jun

On 10/17/2023 10:53 AM, Ma Jun wrote:
> Due to electrical and mechanical constraints in certain platform designs there
> may be likely interference of relatively high-powered harmonics of the (G-)DDR
> memory clocks with local radio module frequency bands used by Wifi 6/6e/7. To
> mitigate possible RFI interference we introuduced WBRF(Wifi Band RFI mitigation Feature).
> Producers can advertise the frequencies in use and consumers can use this information
> to avoid using these frequencies for sensitive features.
> 
> The whole patch set is based on Linux 6.5.0. With some brief introductions
> as below:
> Patch1:      Document about WBRF
> Patch2:      Core functionality setup for WBRF feature support
> Patch3 - 4:  Bring WBRF support to wifi subsystem.
> Patch5 - 9:  Bring WBRF support to AMD graphics driver.
> 
> Evan Quan (7):
>   cfg80211: expose nl80211_chan_width_to_mhz for wide sharing
>   wifi: mac80211: Add support for WBRF features
>   drm/amd/pm: update driver_if and ppsmc headers for coming wbrf feature
>   drm/amd/pm: setup the framework to support Wifi RFI mitigation feature
>   drm/amd/pm: add flood detection for wbrf events
>   drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0
>   drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.7
> 
> Ma Jun (2):
>   Documentation/driver-api: Add document about WBRF mechanism
>   platform/x86/amd: Add support for AMD ACPI based Wifi band RFI
>     mitigation feature
> 
>  Documentation/driver-api/wbrf.rst             |  71 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 214 +++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  33 ++
>  .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |  14 +-
>  .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     |  14 +-
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |   3 +-
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |   3 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   3 +
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   9 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  60 +++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  59 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
>  drivers/platform/x86/amd/Kconfig              |  15 +
>  drivers/platform/x86/amd/Makefile             |   1 +
>  drivers/platform/x86/amd/wbrf.c               | 422 ++++++++++++++++++
>  include/linux/acpi_amd_wbrf.h                 | 101 +++++
>  include/linux/ieee80211.h                     |   1 +
>  include/net/cfg80211.h                        |   8 +
>  net/mac80211/Makefile                         |   2 +
>  net/mac80211/chan.c                           |   9 +
>  net/mac80211/ieee80211_i.h                    |   9 +
>  net/mac80211/main.c                           |   2 +
>  net/mac80211/wbrf.c                           | 105 +++++
>  net/wireless/chan.c                           |   3 +-
>  27 files changed, 1180 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/driver-api/wbrf.rst
>  create mode 100644 drivers/platform/x86/amd/wbrf.c
>  create mode 100644 include/linux/acpi_amd_wbrf.h
>  create mode 100644 net/mac80211/wbrf.c
> 
