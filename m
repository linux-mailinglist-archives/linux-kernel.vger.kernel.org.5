Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2238B773098
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHGUoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHGUoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:44:14 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB60E5F;
        Mon,  7 Aug 2023 13:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEHf+hvk8F6UTKlGyleXOmTbGl1os1mbyH4QkaZry0L74/z0JaKg+wMVuoSgiDStEvl4mhmO0UbeibsT9kZ/UaTWFr8XbGvQRD/ngtYqa7GKirKR656iiFaiwBuQWjF8RiOJEKd3rY+jO0piFKaihXhYrfebzAqyQkhtGUMX8SXlnwxBuVtPO07DgtXSYrURn2HdGDxaRjv6tutVHLvXbVK3mX/TIF3sG96cGSkt4soATXYQ2k84eMLn7Vt6AKicJF5+GHRuYC++QMG4KhoPZ0kTDc7x4ac08MJxKtpbbQBb3LYj1w4+OMY9tfgcpcUgQKNk3yNwP3+FQkANQ5Nzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHDx1/LXjDF7Me8gs0BZjrWmyu2q+EeYI47DdaFuhLU=;
 b=ZGAxLTwAes+L6HHg4gCnR/jcF9ub9aYxNXnm1MS559CSWlIrRrNB6nL2GuP/Ywbj2J2KDtqjbuHryKFFhAxOXP5OtJBjdtWfUBXs2hmYHCAYrP6158LAuWOyPHhslW5VOqhrgoQPdGnusfpbdIMnYnCLnj2qWmwxgYszGEMoRDx46+NA7XLy/1UVfMlWvSlFA9oJZL3bOETLTLxY4MjjvWAnWe8Hie5etAmPf6GlnaMxn9v97Xy3Yu0NEhegNOXZlOR0vEI9hI/f/wVAuP5wKzC/EGvHyKHRfTSEaPBb3udt2WmdhDwz0+RVahIEcgb9j2zQhk/QJTCoRN7uo9Pjtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHDx1/LXjDF7Me8gs0BZjrWmyu2q+EeYI47DdaFuhLU=;
 b=sWRVakO7wAL9AzJllP1EMOGnwMdlwyDbB3oN9QJMcDP9WXB9EeWtdLMY3/jax9rgieRq9Gs9nMFwgkggm+J7MZiw+k41KIwGMe786prDUaspFiu/evuRe5qszSJbfWQ9V6fiUvTbijxPVUDPCUhMecTJfEB/daukJIhgji11+3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Mon, 7 Aug
 2023 20:44:11 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::377c:b288:3718:408b%7]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 20:44:08 +0000
Message-ID: <58934edf-4fad-48e0-bc5d-62712b11e607@amd.com>
Date:   Mon, 7 Aug 2023 16:44:08 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com, mario.limonciello@amd.com
Subject: Re: [PATCH 1/2] platform/x86/amd: Introduce AMD Address Translation
 Library
Content-Language: en-US
To:     bp@alien8.de, linux-edac@vger.kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>
References: <20230802185504.606855-1-yazen.ghannam@amd.com>
 <20230802185504.606855-2-yazen.ghannam@amd.com>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230802185504.606855-2-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:408:60::39) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 67308424-cda2-45df-ffc6-08db97870bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: giVXCcp1q25fNlLfZrBC8Z7JCnqUu1nEV2sS4ffUkgJJFnVbAIAmBlzYTM2DRDJsFNWF/rm+ebzp3dygJETkpNSl18oI336ceH6CHjO4s0aH7sxGcw6RmD6VswDiLwXozZuwGJAxs1sg4No7ZkRheHpCx6LL9BkYQM0Rv2I7Qnjy/TZ8IFtNwnpiF8doNOA4I9dguV14i803ior77i8vRYuTL+LVGP1GPWDvUNFW/riZQrfhGY3R73oJLbhWt3jqZeEQOYnEBYLW2w34SEGnp9KUWvcxzM62G5ib+EqtioaBrbtScABJD/4nzDQMIIFAFEM4SV37OGei8b4zqSpEnZwtizBIFsB1jzxT1EESY5KCIELDIYUdxnjxS49VzBXC+fv3VPhSE+vfDJEAbjB9RFxxY2MkFZbtQTRgQkw3xK735lV5Mwdf5+/aNpGSExyL4xP9bq96N6d+sZXevnhLmQVkCvMT4wtZ0DTVr9fjahgvjCiSIN/DyLLiDmVM64jQw6gg8zkRz4xmJ9Sy0HuP5DG+GjcfKnXqtMyahiziSFdba/OgZXTRfWrYKjJnvZSMx7uPV1MiTw6Jr7/pOLUbXM2Uan9oPjfBUzbrDxf7SyjsWF3r+P9A3r5NeM2WrYnFcZnfEOktHCvBGgterJUbNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(186006)(1800799003)(2616005)(6486002)(6512007)(478600001)(86362001)(31696002)(26005)(6506007)(36756003)(53546011)(41300700001)(316002)(5660300002)(8936002)(44832011)(8676002)(4326008)(2906002)(6916009)(38100700002)(66946007)(66556008)(66476007)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0NlN282T2ZPeUxOOGlJYnZnSE5nSWF4RGg5SDZGM052SS9aS0VXcS9PMnBm?=
 =?utf-8?B?VlZiS3FRU3VsZ3cxWExqeVBVNFFWakNGT2ZZNFdHdi9Hc2ErZlEvYUV6dVRZ?=
 =?utf-8?B?RVdhSlBuM1NpSjlIU3BnclVOTk0vYmpmNllTRWFRSGdrci9abWY1b3dKcXM1?=
 =?utf-8?B?bEM4R1lFUThhczlNWDRLTG1SUDZwU29abGFFemlVRkpwQVpqSW1XekdwR011?=
 =?utf-8?B?anplOC9nWlpVOFJvWDVnZCtsaGdISTJtemE2NlBhWVBpME4vQ29tY3crdlM1?=
 =?utf-8?B?UnJkdjhqeVlQRlBwSHpkdXBUWkZZYkhTbXEzREdkajRjVEs2Y3JTRmVXS0w2?=
 =?utf-8?B?bjhZR01sRHQzK09BNVNISTJobEhoTnl3UmRidDZ2WHUzYzVVb1A1dDBGVFcy?=
 =?utf-8?B?Y01CRVFPVHJHM0xKS1BKb2cydUhGc3B2ZUVMRzQ2aEVNTEoxY0NlSHYzNFQw?=
 =?utf-8?B?MmE4c0JkbVJsSjY1UWl3SHZFOXZCTk93czNKRGJSN3Y4QkZkd0xnd1FackJG?=
 =?utf-8?B?dXlhN1BuNHlsK1lrdnAveFlPcml4ZklIMjc3U293N2ZlaCt3S2hHNUpieEVv?=
 =?utf-8?B?U01iNGhwR1V5YnY0REdkcVZlYXFUTHRHaXpRMytrRWRRMDVkZFJlNXFHMjBD?=
 =?utf-8?B?QndMV2E3cXRGOXN0VnN2VU50bFJ1cWsrNnhQOVJBQ1c3WHIyazlMbmNrNFdX?=
 =?utf-8?B?RE1sa04rS3RYMWZJU2NEMWRUd1RwSUQ0UWhvVHpqT05uUEtGU3BoUHZWUGE5?=
 =?utf-8?B?aUF2NkxVbmkrU0RpOVFaL0tMazZBaVdmVmJJTUlPbEZ4WmdBY1ZLRkdYRHBD?=
 =?utf-8?B?aVErRWVBQ3JVajNmWGFva2dneEh1TEJ0QUdYV2xHV2dldlp2cndSVHFCU3lF?=
 =?utf-8?B?bWRlbnFJTUg1dHRPS3hGd0RDeXFqdnBzOFZYYWZ1T0dacHIxUDRPTWZYK0Qr?=
 =?utf-8?B?NmJOTStEZk05Zys1eTlmU3J0Z2dTODZuMERiREtPOWdYdmZJRHhvM0xvZFov?=
 =?utf-8?B?WEVHVVNMU1JRK1JrNWpzRjVYOEdkQTdpQlNzckFNY0tXYjhReDBuclZ5eWVB?=
 =?utf-8?B?eUZPR0FmSlJCaWFaVDNiRVZjQ0VYUTJkRjVGTUk0ckdMUnJaYkpWMjJQOTRG?=
 =?utf-8?B?U0FkZUU0TlFuMUxuMHRKT0pPV0lKMHZIWU9hRUFhMjVrWlVLR25EZWJ0QjBO?=
 =?utf-8?B?N2QwK3FYS1o3ckRPdG1KTmFvVllJMlFYSElmTGxxa09oeGsraG5MNFNtUjRS?=
 =?utf-8?B?K0hEejR1cE1iWDZEcjZPNXhVK3QwQ05LUEs5Ylp4OVlkbWFDTUlUOW42QmRX?=
 =?utf-8?B?OW5qNnlYdTNUMWJENUV5S2VJSlk1SFFiWW5PQXJ4ZEFzZlZ0dnBTcFJXVGI2?=
 =?utf-8?B?V1oyYnBCSUVZMmlERGFJQTkzTjRuZXZweVhweEdZUFE4WCtTV2Frck1lU0ZQ?=
 =?utf-8?B?cllHUy9QOVA3VzRVR3lVbngyOVdXd3Evd2dGNHBrbFZESytiRFhuZEVCSlM2?=
 =?utf-8?B?WEJWZzlYM0ptWitpWDVKUFBxbFFSSmZtV0gyMUdDOGdWVVhSOVY5aTBMclp0?=
 =?utf-8?B?eXl1T2UxUGhGa2ROOXc2UGlnSC9lNm91dXNWdWszUTJZQ2R6eEswaHVEQ1Zv?=
 =?utf-8?B?WUFvWklodm9iWFBjaG80Q2F5TlFCTTM5eDdSV3BZbGp5cnVORFg4ZkNhTVVU?=
 =?utf-8?B?UVVvR0FlWlV4Y0dZMkJxUHNHeTRMQXdNeHE2Zk5GK29WSkczVlJRaWYwRnVJ?=
 =?utf-8?B?QUtXb3hoZ1J4TEZieVRla0svQVZuaDZKODQ5OGlBSU82Tmc4T21qR1lhRVJn?=
 =?utf-8?B?MHhSUEdsU3dBekZHUThPUTA2c2o0dUR6Uy9aVUhRNG84RHUxckJaWTRLNGlN?=
 =?utf-8?B?Z0FQM2tSSnl1cm1raVBXZXA4K1h0YSsxSlRGZThUYXNJTzJQSm40Q00rWDQx?=
 =?utf-8?B?aUdDUFJyVVltdXlmQmQrcm5DUDd5YWtyYUsydVVaeVZVdXcvNkdEa0h2YjBi?=
 =?utf-8?B?MnRFYXN4S0d0VVB6dUFzSll2M1hOMDdxMHFyOXpKTGdWQkRhajRHenpuQ1ZN?=
 =?utf-8?B?dEJhUmhzRy92Z0ZQWGI5aWVxeDh0aU9SSHgzbnFXUUFaMjVtR2RxZGpNSGdH?=
 =?utf-8?Q?sfjVMAK2p/7yYQ0wSbMF+NiPt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67308424-cda2-45df-ffc6-08db97870bb9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 20:44:07.9444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xngpZ50XyJrzdTXjhyXgf3bnnAuekzTy2Wh7tQr+mRJqHNXS8PhZdLAX4GsEFHAsFwDIp+e/4pliTnAHVWP8hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/2023 2:55 PM, Yazen Ghannam wrote:
> AMD Zen-based systems report memory errors through Machine Check banks
> representing Unified Memory Controllers (UMCs). The address value
> reported for DRAM ECC errors is a "normalized address" that is relative
> to the UMC. This normalized address must be converted to a system
> physical address to be usable by the OS.
> 
> Support for this address translation was introduced to the MCA subsystem
> with Zen1 systems. The code was later moved to the AMD64 EDAC module,
> since this was the only user of the code at the time.
> 
> However, there are uses for this translation outside of EDAC. The system
> physical address can be used in MCA for preemptive page offlining as done
> in some MCA notifier functions. Also, this translation is needed as the
> basis of similar functionality needed for some CXL configurations on AMD
> systems.
> 
> Introduce a common address translation library that can be used for
> multiple subsystems including MCA, EDAC, and CXL.
> 
> Include support for UMC normalized to system physical address
> translation for current CPU systems.
> 
> Future development to include:
> - DF4.5 Non-power-of-2 interleaving modes.
> - Heterogeneous CPU+GPU system support.
> - CXL translation support.
> - Caching of common intermediate values and results.
> - Leverage UEFI PRM methods as alternate backends to existing native
>    code.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>   MAINTAINERS                                |   7 +
>   drivers/platform/x86/amd/Kconfig           |   1 +
>   drivers/platform/x86/amd/Makefile          |   1 +
>   drivers/platform/x86/amd/atl/Kconfig       |  20 +
>   drivers/platform/x86/amd/atl/Makefile      |  18 +
>   drivers/platform/x86/amd/atl/access.c      | 107 ++++
>   drivers/platform/x86/amd/atl/core.c        | 212 +++++++
>   drivers/platform/x86/amd/atl/dehash.c      | 459 ++++++++++++++
>   drivers/platform/x86/amd/atl/denormalize.c | 644 ++++++++++++++++++++
>   drivers/platform/x86/amd/atl/internal.h    | 307 ++++++++++
>   drivers/platform/x86/amd/atl/map.c         | 659 +++++++++++++++++++++
>   drivers/platform/x86/amd/atl/reg_fields.h  | 603 +++++++++++++++++++
>   drivers/platform/x86/amd/atl/system.c      | 282 +++++++++
>   drivers/platform/x86/amd/atl/umc.c         |  53 ++
>   include/linux/amd-atl.h                    |  18 +
>

Hi all,

I'd like to get feedback on the most appropriate place for this code.

I want to move this out of EDAC, since it's not really an EDAC feature. 
And it needs to be used by subsystems other than EDAC.

I thought x86 Platform Drivers, because the code is very 
platform-specific. And there are already some AMD platform drivers. But 
there isn't any platform control or management for this translation. 
It's just reading registers and calculating values. So it's not really a 
"platform driver" in the sense that it manages platform-specific behavior.

Another option is for this code to be in arch/x86/ras/. But I would like 
the option for this code to be built as a module, at least for debug and 
development. And I don't know that modules, nor platform-specific code, 
should be in arch/.

Currently, I think this could go in drivers/ras/. This address 
translation is needed for RAS use cases, so making it a part of "RAS 
Infrastructure" may make the most sense.

Boris, Tony, (and others) what do you think?

Thanks,
Yazen

