Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1559E7FDE2E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjK2RVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjK2RVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:21:04 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4584AC4;
        Wed, 29 Nov 2023 09:21:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1POwF0BmodePW341j6k7DSUgibtaYFstzs5UVVLzyhs1mWb076TUQYNqhnauyMxGaZuXM07pd7GhS6gkjZaXFK75J+ClPog07GL3Xgde3MBNczY039e4SFmv6t5zE0CXxIz3Plle0LEb8w9PiZtpuNUk9VZFl4uiOgvzXRFXOLAonx59x3l0Vqq4M/Ola8+N2C9exRcGcKgPftcQrFSs2SgFRWV5vbCW9HdJCOy+gcqHqGMAXchv/UCD6GR3rOImjcZsWirV22vmo/uqrVEC4NFgP5elF8lWCXIDnw0pYPM9P+FRG+5rMtVMK7qmP96IyA9RQ66yUg7p7Njcrxz2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlL4DlLdnvPj3wixuxxlRXBiDv/1ysqnzDExzQF0yQ0=;
 b=HbIngDA7/TA9KTmrzNBDWFwuyXunFrL6+TuUfzg8hYZGhdLrjv0+KMiyypE6dkeXiLREsuMZDVIdTzbVGT8YNBeIDnfSLif7pQ5UnvlEULzeTsKDjpfzBsx6jni4KJVCDnen9QmHYqY6UqcnGz/vyQkM5KhgwGT0JLw+pHWqjnXKM1vFw/Vz74wklBz3d9RvuW0jSFRL0+u7HS0QHHzyCmLeMJISbJdH9DW0hlHyay749JovLnhZdraMyiXeTJ3uQ02JRI6uJU73xEAA1/iCzYOhyT+XSIVDloSr9jwfTv3QeiujvpMyBI1Nf6cFh2+VnqjLHh17ByuRuT83mMmvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlL4DlLdnvPj3wixuxxlRXBiDv/1ysqnzDExzQF0yQ0=;
 b=OscieeucXZUYDy6jRZEBt06yj0dU7ctR4AbhliomfjAsl/E5G9Yh4SFcseFq94Z88LaVPAroMgEXGSFnWlO8/hLRDDn9kMDsDC5NWAn07FNQgqD9wTWs92kcpnFk0tMNAne2AkSGRwtve3zsdnKLSQfCS9NWjo2LEuLL9/FUP3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7487.namprd12.prod.outlook.com (2603:10b6:510:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 17:21:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 17:21:07 +0000
Message-ID: <ad106721-343b-4449-b57c-1556c32779e7@amd.com>
Date:   Wed, 29 Nov 2023 11:21:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/9] Documentation/driver-api: Add document about WBRF
 mechanism
Content-Language: en-US
To:     Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
        lenb@kernel.org, hdegoede@redhat.com, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     majun@amd.com
References: <20231129091348.3972539-1-Jun.Ma2@amd.com>
 <20231129091348.3972539-2-Jun.Ma2@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231129091348.3972539-2-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0120.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7487:EE_
X-MS-Office365-Filtering-Correlation-Id: 0791686f-7ac6-444a-1b77-08dbf0ff92ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WR3c0l3VsXESZSiw5fR2Kcj05ggtmg7OMMrkpla2e1xlOLMzE/8o9O9eA231Z8rZoJEn1Qxncj/oMdwclkZ3XKWMtfejWglyPsxiwygtEepnfHfN0AW9MySNIybNtql3DwhxDQWW9rnvtiHCT/Gwigekbt4DgqX+k+iWrRPNP1A8YXf+Ijbo4BopEQN3q0WZ+J3y4k3r+J+G9qVpW/8zOek0vkfiM/obqj67jQUE2DTBQPqOd/6NE3j7S7jcLZi7oWeScd6flepjTzFHcuYjLoCSDQhBjEQUqxLi5TLn+0ZrDxMU6KuulhQ4sTzkAfDBYAHCW8e/BOnGMsEHyFIxc/QCs/Cybnb4C0/9uKfq2p27Y6aMLAqRjBCAZJl6tvn3VMd1olOL2UZtT1XA2OuoewKGU8oEvz1m1Epr3P+oT0U/Gtoew3uaaKKeOIiuNbKIsXBAGTeEEuvRZz6U6vYdtTCF2oB9hRRQgGu6KYKX/p91y91XD0PpukJPjPsLj0ssfnyaUmgOhtX3NrvcaEp9ctUGXtHkHxeOuhGQzYnmfP9W7hbIgxG3lO4eSCJLPZZSwZnGWRye6TIw9+Kq99ftiNbthEa57w4wgd710fqcfLrwo35OoAvYFUXqGPHWeIBeYUC+djnsGso67VCF21lI1yZJuDNeciYmAmJlPK4a+CQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(316002)(2616005)(6512007)(6666004)(53546011)(86362001)(31696002)(6506007)(26005)(478600001)(6486002)(83380400001)(38100700002)(36756003)(921008)(66946007)(66476007)(66556008)(7416002)(5660300002)(44832011)(2906002)(41300700001)(4326008)(31686004)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THV1OGZCSmNWSTFhNkwyVUJwMENJQ29MQlNRWXVERk4yQVVsQkJqTW5YRVZz?=
 =?utf-8?B?bWdvRWdYRldzem5iMWRQNStwbDMwd243WUhVcnZ1UElHQlpTblJDaUZac1VY?=
 =?utf-8?B?OTZjbzhCZEJGZzFmTFQ1K1FjSytoVzhQTlZTbHFuSnl6M0dudDlobDVpVmFC?=
 =?utf-8?B?dDFKSklLSjZqazR4bGJ0Sy9hanBMMnVMWS9YT2lKSS9NL2IwSGZIUUp2OFg1?=
 =?utf-8?B?ZDlNYmd6aTJZTjh5MDZnOWdFWUdLWWVCakxhU2ZKekNGbmduMHdxbUpMMnZ0?=
 =?utf-8?B?Q3RsTEkvS29JUFRUTENWQzZ4MTdLZWxDZDV6d1A4SjRLSlJhVFZhdE1kRDZp?=
 =?utf-8?B?MThINVhWaGxPOVI5Y1lSSWNnTjgxSVdZQk4xS2Q4VGQ2SDEwZE92alVYaDJm?=
 =?utf-8?B?R09haHVwTjhINjU5Wi9QK2I3a1FYVjdiSXJiUmNRQzQ4SHNxTFVFWVlQaldZ?=
 =?utf-8?B?N0Z3ckRXamRibmU2MlZtZTdldXI3OCtsVVd0OXdlOVZTTFQ0UEFmQU5RZkJD?=
 =?utf-8?B?NWF4bTQyNkRLTkNWNDVhYSszTUtQaDF5dEYwcDVtc09HR0xtZHMvd0IyaG9Y?=
 =?utf-8?B?TnlnVUVzM2UrM0VaQkF3UVZPcVZ1cHBWMVlBWWpnZ1NNVVZ5Q0VSeDAvRzdT?=
 =?utf-8?B?NkttSTcwOVZ4MWtUWkM1NkFaQ0RhRVRNMDVvTm5YbVNzYW1qVE51SlBLYkhj?=
 =?utf-8?B?QnhxWTEzbUlDSUJ3YWgxSG4raFZ4c3ZlRE1zeG1haVk4ZXZVbFpZaFpvZCtq?=
 =?utf-8?B?NjczempxMzFJaDB3Y3VLaXRhVWNZWGREZ0FoRkxDTmRMejdybFNDTU5PM0F0?=
 =?utf-8?B?SmZxYzZlQ01VQmRDNUo2b0p1d2tHcjVPSnpUek10aC93dkJSL1BydzlxM3Ur?=
 =?utf-8?B?ZVFqZlFqaG1IcDlFeGhkK08yVmRPN2cyLy93Z1JESS9FdGxFNnJsa1RtUlVs?=
 =?utf-8?B?UjlCbmhMTjlvNXk3OHJBcDdIS0I4ZWUxZ3g1MDlKQmI3VGlCZnBITkd2SlBt?=
 =?utf-8?B?VDV4V3FmSGVNb05CK3U5Zy9CTm9ZT3Q2NUw5dWVCNWhxdlJ2S0VDOW1GUmJl?=
 =?utf-8?B?NFhUN1F1bnlNQmxvV2Z6R2lqMnljRFBpdUtKS0JhbEUzT3JtaFA1YXhZWmQy?=
 =?utf-8?B?ZWdDYXYyVGxLMFFnbEVpZUVYRnFxdjFSNU92TlpWQzZwbjBhQ0Q3VTRFTzB4?=
 =?utf-8?B?TDlNTWFDWnV0STFrY2hCQXM2UFFMMS93N1hqcGRqZEYwZU45WEUxWXRINFd4?=
 =?utf-8?B?NURlOUdwRGprUXlmMDFwYWEwVTltMFIrcktTdnpzT3BVc1ZOSEtLZ2E4ZHJ4?=
 =?utf-8?B?UzNDQWkrSWRHWmlqeTFqY3cyaHU5Nm1mZzdacCs3dGZ5cFlUTlphQUJheEM2?=
 =?utf-8?B?M28wK2VuRE8vOGJ4QnZtOGlqRnZIOVlwYWZhR0VoaUZDOUIxV0ZZVmtBQisx?=
 =?utf-8?B?QWQ5TVplQnpsT2xnUzRSeUdHR2tYSXRnZEpmc2lwenVKTkxtb0RITVVSQlRr?=
 =?utf-8?B?OHovWnpPdmRzNWdXdTk3dExXTDYvSDRzeWdRLzZTU1VsWnNCTHgzRENPK3JP?=
 =?utf-8?B?YmlMV3doQkx5NWVFOEtCcmFuaXZGaVU3alg0TXl4SUVHeHp0Z0RJOXBRaGdB?=
 =?utf-8?B?TnJLKy95VHptM29wNXQzUUFGWm9yTnZnSEJrME9HaStYa01tcTAxY2Z6cU5L?=
 =?utf-8?B?OEdHdUQ1ZzJqZ3E3QkFMYS9FaUl2STBKM1JiWFFKWkwrUm5wUkl5ejFnZjVK?=
 =?utf-8?B?UnJCdHdjWEJZN3VBdkJadStIZWlRd3BpTWdnQk5mdDNFRm82WVZTNXdyL0FD?=
 =?utf-8?B?UzZsNEdubjdwQzBsd2crMlZySnViSmp6NnpJOUhtdW5sb0JaaGYxUjAxb2tF?=
 =?utf-8?B?dXhheHAwVkxmUXFEMmYzdXRSN3dqKzRKSFVyWmRKc2xVWUJLQW5lVng2dzc0?=
 =?utf-8?B?bldIK3VIaW9yMzRjcmxrcnp1bVRpdi9UMW9rQXpQamwzTEtEM01jWm1nRUNR?=
 =?utf-8?B?RURmZXU2cUowSEl1ejF3MVJXRjhjUUtqaVFuYTB1R293MmQrdlJIWUx3MzBU?=
 =?utf-8?B?TXRDamZiRi9GdFN6dmRsNUxydEhyRUpBSHgxQnd5bzYvNXpuRkREQW5rYmxl?=
 =?utf-8?Q?WPG9q14w6/VQSdwwIxhzkK8AW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0791686f-7ac6-444a-1b77-08dbf0ff92ff
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 17:21:07.7706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B698ZknZjcBPawcUhDn7E5bTeyZpLefCeGiTSf7+JVn9Vs3WQGVWxTwDqWttcDc8rnbbUam0rvcF2SJRmPiptg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7487
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/2023 03:13, Ma Jun wrote:
> Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
> explaining the theory and how it is used.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> --
> v14:
> - Fix the format issue (IIpo Jarvinen)
> ---
>   Documentation/driver-api/wbrf.rst | 78 +++++++++++++++++++++++++++++++
>   1 file changed, 78 insertions(+)
>   create mode 100644 Documentation/driver-api/wbrf.rst
> 
> diff --git a/Documentation/driver-api/wbrf.rst b/Documentation/driver-api/wbrf.rst
> new file mode 100644
> index 000000000000..12793bb1abce
> --- /dev/null
> +++ b/Documentation/driver-api/wbrf.rst
> @@ -0,0 +1,78 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=================================
> +WBRF - Wifi Band RFI Mitigations
> +=================================
> +
> +Due to electrical and mechanical constraints in certain platform designs
> +there may be likely interference of relatively high-powered harmonics of
> +the GPU memory clocks with local radio module frequency bands used by
> +certain Wifi bands.
> +
> +To mitigate possible RFI interference producers can advertise the
> +frequencies in use and consumers can use this information to avoid using
> +these frequencies for sensitive features.
> +
> +When a platform is known to have this issue with any contained devices,
> +the platform designer will advertise the availability of this feature via
> +ACPI devices with a device specific method (_DSM).
> +* Producers with this _DSM will be able to advertise the frequencies in use.
> +* Consumers with this _DSM will be able to register for notifications of
> +frequencies in use.
> +
> +Some general terms
> +==================
> +
> +Producer: such component who can produce high-powered radio frequency
> +Consumer: such component who can adjust its in-use frequency in
> +           response to the radio frequencies of other components to
> +           mitigate the possible RFI.
> +
> +To make the mechanism function, those producers should notify active use
> +of their particular frequencies so that other consumers can make relative
> +internal adjustments as necessary to avoid this resonance.
> +
> +ACPI interface
> +==============
> +
> +Although initially used by for wifi + dGPU use cases, the ACPI interface
> +can be scaled to any type of device that a platform designer discovers
> +can cause interference.
> +
> +The GUID used for the _DSM is 7B7656CF-DC3D-4C1C-83E9-66E721DE3070.
> +
> +3 functions are available in this _DSM:
> +
> +* 0: discover # of functions available
> +* 1: record RF bands in use
> +* 2: retrieve RF bands in use
> +
> +Driver programming interface
> +============================
> +
> +.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
> +
> +Sample Usage
> +=============
> +
> +The expected flow for the producers:
> +1. During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
> +   can be enabled for the device.
> +2. On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
> +   param to get other consumers properly notified.
> +3. Or on stopping using some frequency band, call
> +   `acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
> +
> +The expected flow for the consumers:
> +1. During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
> +   can be enabled for the device.
> +2. Call `amd_wbrf_register_notifier` to register for notification
> +   of frequency band change(add or remove) from other producers.
> +3. Call the `amd_wbrf_retrieve_freq_band` initally to retrieve
> +   current active frequency bands considering some producers may broadcast
> +   such information before the consumer is up.
> +4. On receiving a notification for frequency band change, run
> +   `amd_wbrf_retrieve_freq_band` again to retrieve the latest
> +   active frequency bands.
> +5. During driver cleanup, call `amd_wbrf_unregister_notifier` to
> +   unregister the notifier.

