Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D709C7E81A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346148AbjKJSaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345663AbjKJS1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:27:14 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7626595;
        Thu,  9 Nov 2023 22:20:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYdRE+TvYp9sS/jmG8WyPrt7nnwPKV0NLPZ/bIwVcCzHO7/dx3HlQX6m0jYUGB3c0r5S7u8mXJ9sSc2Wlw6fwDfOYgrZAtCzD7NmJZtBlj6ZY5UAFo5H5IfF9t5xUGGxTaKd9I5FjTgusJcOxZV+XPKYCQMIBsl/f/5a8ap7xxsf5nNn9+v7JrvGVCs+YDqGegsVGwMPsDmSNTQPoOmMxdxEYBvdAWwxyMqpNzWg2+55K5w4EVcSezXKaP9JX9d36zNGEqItC3l4bdkN3vpr8FptqPW9RVz7wf1XNzcUxMC8qTo1Jb6GN+ugMb286p/a6xqB5S6igaa0+yjGeNxJkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2IjFB2Py0Qm69uOKPb9IPDrnGI6L9Ns2AaebZ3f+NM=;
 b=dEtik4TqvHLT5w+cfxt6WDG2tmzs0Gmf3O1SHx7s3W8hNog+K8n6XAGBSFCyvytteOywzSwVoSoqiHPWdkvMdU9FAa+LWcy8Kom2a66AwU4yBjF2rBirDn6BDsIbTvUYvjtkbnAtgrX/unlRSJnLVDgcTh34vaasScj7ANxrq+ds/RyzvhG8l0Fy6wwu0dOvbqgVTFr5G2rLjlUGKlOKEs7Ay9SgZwTeICfbYF0n0uzhv6xlQHRiodC7cJC+Bl46P11Kch1MJF7trXvLegX4eBCiHWijLxyXPRkLNYC+LiNr8YzICKJcypeOlCG1JSbnH968VKyOj4PBVahMgb7/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2IjFB2Py0Qm69uOKPb9IPDrnGI6L9Ns2AaebZ3f+NM=;
 b=fxmA4oPMx5TU6y0ZPxYmPqRYm5Ik5KSygCpz8SBWEb4vc7fwdO/VO/lULbz5JSDKExUG2jO9I3K45QY9iQMnEr3A4eu9DIcuS0vtum4QUW41kXL8S/nOqXcgu3Rr07VtRLd4j4oERm6EUDuxs+PgxUXbWbk0n5/hSCCg3v+Ixu0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.19; Fri, 10 Nov 2023 05:31:23 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::5287:5f3:34f:4402%7]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 05:31:23 +0000
Message-ID: <665cb7da-3d7e-4323-9a07-d4f59102c5f1@amd.com>
Date:   Fri, 10 Nov 2023 13:31:09 +0800
User-Agent: Mozilla Thunderbird
Cc:     majun@amd.com
Subject: Re: [Patch v13 0/9] Enable Wifi RFI interference mitigation feature
 support
Content-Language: en-US
To:     Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
        lenb@kernel.org, johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231030071832.2217118-1-Jun.Ma2@amd.com>
From:   "Ma, Jun" <majun@amd.com>
In-Reply-To: <20231030071832.2217118-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: b655a1cd-bf58-4fc3-f6fb-08dbe1ae4678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OVXqpOTGUjkR0w63DG9B+sgISTHyrwfsPwFqMlPP99QhJvP51w2oXXuox5QJSJAnANz8oxzglkpV3Iy4Fyv44hATu8J0+5n5IkjpdtQV2j8AiH6nmA8zHQLiphCSnTnZbLyB1S6UHFTyhzE4L8eiOOvccHQJ6gfr+9MhByf/bCmzO4Nz2boce7au4TTz2AKZqznZbx81ZyCoOgZ1orUI0PRzDYxn24kTTShsGf10e+AERtMgk1zPEQS3RTYzGQsDF13ga9si9NmNst8GUrJ+Z3ugu1Ri8y0xi3JUG3iu3JNh/17deXrkxkXzff48SPVrRinBad75qKhj+uQb1R3eSWq3o9RM3h5KPUpVXEBT+juU2LW+lidcirrGf+MCvonOCX0+sjjN9fECuwGZkyGa0WPeLfqFaE6Ojie0BLdXLiaLn0FkhbVbI2gLdLv5m3tsav58TzMDZWFOeuGPWSUZZxGeT4/bNwF8D/1OxjfqBgwDauFscQm/TwVyuLAJKalH+kiuewu5ssk0ZfhO1ELGP/fzNQr3GIhRQyf6/8EpLT3N2KOHhoVlIONXlDh1DqYUNEjOKWQeOoZ643x2dSvLUbcOW9eY98DpraBLnXf99V9JZ99FJLyEAd4UU/0MuYR/SVfMk95vJre87u99wcht0RYbeaC8n1sSbFK7A4TTAhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6351.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(26005)(2616005)(6512007)(83380400001)(31686004)(6666004)(36756003)(53546011)(478600001)(6506007)(6486002)(316002)(2906002)(66946007)(66556008)(66476007)(41300700001)(5660300002)(31696002)(7416002)(38100700002)(4326008)(8676002)(8936002)(921008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUhzMFlGOXkrSGhsZlJJUk4ybVB2NDNkemdQR29HT2NGVFI2U2k2Y2J3N25R?=
 =?utf-8?B?ZFgwTE5RRnYzdjNBbXZNeWh3TVFtRDhvRFkzYmc3N241d0U5S250TU1jUFNj?=
 =?utf-8?B?bDRlNUIzcUZtcHFndWNXQVFUd2l4Nkk4cFdNS1BiUWNkRngxakZZZGVDQjd2?=
 =?utf-8?B?cnJSVnpwV2swZkRYeXV1L21lZEptZWF3dWVvcldQNjVXNHFmeTRoMXJGQ0o5?=
 =?utf-8?B?ZU8xSXcrK1dXRXZZU3c3UkpjaEFPbEFZTkVJYzlmNTlRMlliSFFHUHA5TzZq?=
 =?utf-8?B?Sm1PeCtiNWtVWWZqWHJ2MDhWUEgxK2htMm50WG9ieFdnZGNBMzZLVXhYc3dk?=
 =?utf-8?B?ZzBJd25nZjMwenhLaGJycUI3SWxjM2VUcHBNVkhMc1BrWFJtam42QUNvdnNv?=
 =?utf-8?B?Y0dScDl1N21Bb2N6MFc3aTZFZVJZbkN6Y0o1WjhwaWhnVVZtU28veVdrdlFo?=
 =?utf-8?B?RE1sTENYL2drcElQZ0dMUUpRVUNtMGR4bFlXdzRDbzBTR2IzbW9LVitMV1dF?=
 =?utf-8?B?ZkhkeHIvNndUTEhINkhqSXYzUzdCTzFnZWRHcVkxdFVndVdTKzk3SjVlaldT?=
 =?utf-8?B?VUFjQ2kxTENuWTkxOGt0bXNYaXArbTlJSUY0bHc2dDc2Uk9BM1UxWjBKSVA0?=
 =?utf-8?B?NDVuU0wxMFRpbjBTWElVbWlrejQ1OFJOU1VuZ0p4eFVIY2J4Ny96SCtUQSt6?=
 =?utf-8?B?dDlia1ROUVhtMnpvNmJpSHphRnRZejV4OVJpazdxKzlvekkwcjFmY01waGNI?=
 =?utf-8?B?ZStKTENOZVMyZ1BIcXprbk40czk4NWFSeUxvSHlkMmRjZWVQUXZ2VUl1aDFQ?=
 =?utf-8?B?aGtmUnJKRWM4Ly9aUWNSUlVFMjN2RzJvSTdIcEhsR3ZqWGE1a0JQVWhTL01U?=
 =?utf-8?B?VkRSTkhHcnNPbzZoT2MyK1VLTEtqYVQ5Uy9PQzJvMXFuSmlkZUVES3JGYjZB?=
 =?utf-8?B?dmsxME5iRytDUWhGU3gvVFkwUENXUkFUdXJRQURLb1ZhZEVOd3k0eG9HUGQx?=
 =?utf-8?B?MFI4ek13OGVLZlFMbEpUbjJzMGRuQzFiR1lub0ttNE1rc3RsRmFucXZLNjZn?=
 =?utf-8?B?VUdaZVNENU9vbklQMDlFTDZDUUtJdVczZ2xoVkJvYkp0RmUrUWJVRHI1ZURC?=
 =?utf-8?B?UzcxNU9jeDFRakp2WTNlUVVlMXRkbFo0NUw0bTU4V0N5cnJML0s0OXI3bTZk?=
 =?utf-8?B?Q2xMZzNncjFHK05iQVNzaXEvYXN6VFllcndad3I2OWVVZ2szbm1BbEpvMzdz?=
 =?utf-8?B?V25yOE51OU9ZVXBCMlM5S2xQb1BGeVRYcGRqUGdHcE5iZk5YL293eVJ3N0xm?=
 =?utf-8?B?Qlh4TnBYSTJUSDd2ZWt6cjZVeHY0bE1qVVpXME5sY05oV2krKzFuQlV0b2Ft?=
 =?utf-8?B?TFV3MTlDWUN6WmNtTEpqWTVUNlV1SFJVQ2hjbm9IYVY5WHBkSFZzcjZpYlc0?=
 =?utf-8?B?V3lkQmF2ZExUUlJaQUFYb3NJMFNraHhlRDgxcnZTd3lnOFczTk5hdjVibU9o?=
 =?utf-8?B?Q0pqU3pGZTVVVXZHOFcxTXowc0EreWhXaFNLTHNPazc5VHJNdlRHaVdIWUVE?=
 =?utf-8?B?dlFNYWZTSEFxcU9jcjlBb2N0ay9SSzRUdC9NNmNNY0k5NUFXZnlJbDVZc1lv?=
 =?utf-8?B?dHJmOUZaZEYzZGVVcHdWL1RqK2k4Nis3N2IyQUxKMUVNVUo5NExRSEs5ZkZ3?=
 =?utf-8?B?MHhUeVZMYjl5YkhpZzJDZGxETHEzTDZhOExTWlFrcFZ2WEIxOFFtaGJJUlFF?=
 =?utf-8?B?bGxuU2dNcHVxeDlGU0xSTk1VWEg3TVJoWTVtN2R6dEs4VEtFMWs4TkQ5QVVF?=
 =?utf-8?B?VGlONFM0MEUzU0FCNlpxOUJ0Nm5rSEUrdWlmUUVGZzJLNUVud3lZUnJaeVFy?=
 =?utf-8?B?aVRLSUxvMGVabm83Y29TTFJyZkpVY2tmcDZqU09TMUpBdWR2eFdCb01iL00r?=
 =?utf-8?B?bWd5WlErYVJ0cWF1dXdxT2hSK2lVOWlYa1EwL3RQUVVUVVJoYnJNTGFORlo0?=
 =?utf-8?B?YkpnMStrcEM1VHc4cHpJek1wMEoyT0FrbkpCeW5GdXJ0SjZOUFFIMnBHM0hC?=
 =?utf-8?B?V0xlN25FSUZ5L2E4WUN3bUI2VlM0eXk0OHNsR3B3d2xXeklNMjIxYTNqWmNq?=
 =?utf-8?Q?IOgPjCa6jnEBgKgT7JHoJgihd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b655a1cd-bf58-4fc3-f6fb-08dbe1ae4678
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 05:31:22.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veYcbKh+rMsqz6ff5c7FGE6YSKLmyhVKxCOQxpY5xFAuK8khJtkhSt3vL2k58pgv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...
Any other comments?

Regards,
Ma Jun

On 10/30/2023 3:18 PM, Ma Jun wrote:
> Due to electrical and mechanical constraints in certain platform designs there
> may be likely interference of relatively high-powered harmonics of the (G-)DDR
> memory clocks with local radio module frequency bands used by Wifi 6/6e/7. To
> mitigate possible RFI interference we introuduced WBRF(Wifi Band RFI mitigation Feature).
> Producers can advertise the frequencies in use and consumers can use this information
> to avoid using these frequencies for sensitive features.
> 
> The whole patch set is based on Linux 6.6.0-rc6. With some brief introductions
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
>  Documentation/driver-api/wbrf.rst             |  76 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  17 +
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 208 +++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  42 ++
>  .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |   3 +-
>  .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     |   3 +-
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h  |   5 +-
>  .../pm/swsmu/inc/pmfw_if/smu_v13_0_7_ppsmc.h  |   3 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   3 +-
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   4 +
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  48 ++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  22 +
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  13 +
>  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |   3 +
>  drivers/platform/x86/amd/Kconfig              |  15 +
>  drivers/platform/x86/amd/Makefile             |   1 +
>  drivers/platform/x86/amd/wbrf.c               | 413 ++++++++++++++++++
>  include/linux/acpi_amd_wbrf.h                 |  94 ++++
>  include/net/cfg80211.h                        |   9 +
>  net/mac80211/Makefile                         |   2 +
>  net/mac80211/chan.c                           |   9 +
>  net/mac80211/ieee80211_i.h                    |   7 +
>  net/mac80211/main.c                           |   2 +
>  net/mac80211/wbrf.c                           |  95 ++++
>  net/wireless/chan.c                           |   3 +-
>  26 files changed, 1094 insertions(+), 8 deletions(-)
>  create mode 100644 Documentation/driver-api/wbrf.rst
>  create mode 100644 drivers/platform/x86/amd/wbrf.c
>  create mode 100644 include/linux/acpi_amd_wbrf.h
>  create mode 100644 net/mac80211/wbrf.c
> 
