Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8476A803
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjHAErv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHAErq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:47:46 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0B510C8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:47:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxJpAhRyE45c6Djsh7+SycM3rZs2Nhk8Lu/bNlc8QSDvbCx35JJzKplIrJEg12L3cz5KOlrRmxyKEyYQIyIcxrwuk8/X3nVAbE9bgrUAxGIGRyaQC8au2xqcuhNMKTgH8WksoYbVtVU9BfuYAgwYamE6WHSEP/MpalZQlRmNDcL95E0KBVNZk1SgT07oRm9VGfXwLR4Sm1RnwOxWZYS3mkjnUA6iaKQZ05i+FxieVfJ5AqJoTiB7KTVXeX0OGYavbF4R1EhLkG2C62y04XnFxsnD2K8I9C3wdHHOC/wru0RtBEJa0oQ4xlsPE59PNq73TojwK16lI5gPquxpLNyTRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49ycr+U9ovwh7ADpgbyyJdmHZN0G05ckm5VE7t8WCfY=;
 b=dut8VfO4SL5dqyYCw+HUHTuFwrLHzkDNlVcEIJF9x/3jbwzDgJsoNRaUSK4SIL1DM3Prh+G9/j88mVbZLr1zhcQaGAdjbgHXjxiHNvafNrVGdNLnW/mq3x7x6BMP5nIVc+swVfvS53qbBBw3rn7Ip+1rM11sz/fsL3HpkS/mq+BUJmYmnI6aBPntCR4GmAi2QF9LvKuY/3j+rDta3Ii3Ac1PlRH7x7VcKdQSW+x1D24zncE9gf+jlgUofFZc/bbBFv8WRGogEVqAsMZ1kyncLjTs/8wNZn5xVtD6uiCgDkU4vRXvyjuMlPoARDCi4R1G58YMHLvoRR0lqZEhjkJ+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49ycr+U9ovwh7ADpgbyyJdmHZN0G05ckm5VE7t8WCfY=;
 b=KXAOp54KojBZX2kKGOXYiqL9SRQJgSVLB6bQYrpY13pmYfZnT/BFrZFP8Ixr7Qj1ZkHFZLCaMJPDiKUM+wiOOO4YmqQ8TiImJcqYv8svfG1BgEN+m5CgSLKrol9YGpozLebo1+XdLN5J+LZTWd+B5eKxnSdZBHKS5K4MYRflGtc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43; Tue, 1 Aug 2023 04:47:40 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54%3]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 04:47:40 +0000
Message-ID: <107e416f-ad6f-a30c-3d9b-341ce13c2a1b@amd.com>
Date:   Tue, 1 Aug 2023 10:17:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/14] Add Secure TSC support for SNP guests
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, thomas.lendacky@amd.com, dionnaglaze@google.com,
        pgonda@google.com, seanjc@google.com, pbonzini@redhat.com
References: <20230722111909.15166-1-nikunj@amd.com>
Content-Language: en-US
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20230722111909.15166-1-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::14) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: f713c7fd-aa7e-49dd-5279-08db924a6f88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UMMcxDiDiuKeByi0A3kUadXS21juaCQvsEK6VbIOjNU3gqmITm1XRuBkLHJ98t+cu3pkmoVjE/sNzaYgdiOZLGYaXnS8EY4rbBEwubG6ZcPg6fMRRUCA7zc/clnCrXpcsLtQjAXTeM7a6/kkRevTntsyu/Xra09DW6p6b2RIqim36SpfZiWo+mAZ2mLkMacZkd1jLvUz8V4kZ3fQ9g7UnQqvpXxoP/trBf6gQIUHlyJp1M9Hqjbn81KIURjENCyeXUOVzOQnSw3HxA093ZDVY7vDNLBDFARgFwdx0xGvFQsXoYwr+dMp/32ey34qbhApDtMlj3BdeuuxhXcD68cYet9VHwtFpTT79ciAZnJ/nDsp8SAsVkohe23PVohjpp4NJb193tfumQnx/2+hjyLBGt1ltiH+Wkm0LWWvIWId7e5dN7sJmp8tJVMKSy6dk8w3W4f2U4ohJ4Zyc7HrTCvaDS9UBN9hBYWcNm9+7Igj71Ifj8ySqJYQgJXa1ez2dElU7aHuShNT+3N5GtBY8obtZpIyjaA1Lj4x4OTTsTmeArlOmBrj28O1/pKtXfO4rnzbA99G6MPdKPX92MmsZeevFXMVAuZpLoZdyiFwGgc6A0bFuTsHbURFMlTChegm9JrlgOqAJkHIoYS+FsidElKcfadKFyyZqYZLZniy9AEGO+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(6512007)(966005)(6486002)(36756003)(53546011)(2616005)(26005)(6506007)(83380400001)(186003)(66946007)(66556008)(41300700001)(38100700002)(31696002)(66476007)(316002)(4326008)(5660300002)(8936002)(8676002)(31686004)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amZKU1FQWGt1NC9WS2lXcG9hbG1mWDE2NnoveURZcUJnTWRtSE5VTTJHSURk?=
 =?utf-8?B?WTRKYlFpL1VqWnBJdC9GUUNBODNuaSsyaUVUcGdMMjZ1dmx6amc3cEFhS0ZL?=
 =?utf-8?B?MkhFZTZiWGtDdWtiSW5YK0FOOGFQaHFZb0NSVzJ5K0srMDRheFRveXV1WW1G?=
 =?utf-8?B?NDRGbXBTVnp4Qmc2clVrL1A4cjNkYy91RXZ3bllNbllVZ2J1SVNvL0k1YU1J?=
 =?utf-8?B?dGRyLytjaTc5am45VVcxbzEraXV0SndGaU9uNW9sdFF1Mk9PczNRbytEVDRE?=
 =?utf-8?B?bmJueDJEQWYwS1N6cDc4MWt2SUIzVGxoeHFnS1VvSEVpSFJ2TmhhZ2hTcTR5?=
 =?utf-8?B?OUlsc0dGamlUdWhsTVFLQzJYcnI1ZXA4V1VPUXRMakVHSjRNejljZXQrdjN4?=
 =?utf-8?B?d3BISWNvNFordDVpVk83WW1iaGRmcXlFb0p6MGhhdzJIWmxVbERiTUdsM2lk?=
 =?utf-8?B?UG9nai9lOUE2em81UUZ0bnBKbzB6dWJsT2JFV2tPRVdML2JmNTRVQzN6S3I3?=
 =?utf-8?B?Z2tYVUwwc0s1MHgwS1E5Wnd5TmVuTlZ4eURYKzVLM3ZYaSt5S1RTZzlpa0xy?=
 =?utf-8?B?dW5pQ0lrSDFQYWhpMEx1NnhMYjVUdG1YRUp4Q1ZXMlI4SXQ1bGJFU2VNTGpq?=
 =?utf-8?B?WTBMSWI5Q0QvaDJWUkY1WjJCUFZTc0JDS0ZSeE9nWWtwcVRQcGR2UGw1TnJk?=
 =?utf-8?B?dXA1YUJkSXNTZlpFUndzY3h4ZXkxK1hyY0ZkWXVMV0VVTWR0YVE4TTVTdCsz?=
 =?utf-8?B?ZVhaSnRJTGk2Q2NSVGxHaVExNEliMVh0a2ZNcUkvZFh4a1BmTnhlRHJjbnJy?=
 =?utf-8?B?S0ZSUzJ1SVpEVmtXaU5FcURwd21JUmxJYVN2cURFOWhVZE4xbGI0RTBpUFBj?=
 =?utf-8?B?QjRjcHdzeFE0MzQ5cHFXWUQ0SWpKZXJqVlpuRlM0SWFPQWlaZGVHOThnRk5P?=
 =?utf-8?B?UnRKRkVTSC9WTmFUdFNwV0wxTVM4LytUSnp5ak4rVHhoWkM1ZjhKSFo1dlFm?=
 =?utf-8?B?V2VIc2hxWUY3ZERKbGFaamF6R2s3eFlPcTF6MWswcGs3RjB2UnpUT3lVSmtI?=
 =?utf-8?B?dm1pS3NlNU9WVXZJbkFOTkRvWHkvQmF4ekxadENJVjZNaFczV255MVFYMC9J?=
 =?utf-8?B?eXpvUHY0cTZDZFdoaFQxR3JrU1h1VmpkWEVUU29FNTkrZHNvNUxNVjFwcTA0?=
 =?utf-8?B?SC9TQzhMWkpTQ3ZBNFk1RWwwTjNOMkZsWDNVUnF1anYwWlR3Mjl0SHRRM1c3?=
 =?utf-8?B?TmFEN3pycDFWN2tIam5IaGw2RG9JOEVhZEZ5aEtCb0ZwRnAzeXVLVFVCR3Zj?=
 =?utf-8?B?Z2tvR2RjYlpISzZaWkRoa3VVMi9hUUU5ZkRFOXZlWDl1OHdwNHZyNGx3ZTVS?=
 =?utf-8?B?ZnlkUXdnMWlaaStNdkRBWUx6Ymw3UHpwZzlYVVlXbGpJckh5d0RVeXlldUxK?=
 =?utf-8?B?ai83VFVUcTVYcUh5Q2VydktoVnZSblY0VGF5OUgvN0pXcFRkLzlOc3NXSkM5?=
 =?utf-8?B?NHRFWWxkZ0FNajAwNXBQYlI2d05WZWs2Uk1qOG5BUlZKTGRRcmJEN2FiaVhr?=
 =?utf-8?B?R2F0cVF4M3VOcVM4WlFaK3dUWnJKMDlaQXg0UWpvVnhFZTVrNFA0ZDEyOWNS?=
 =?utf-8?B?dFJSMXg1Y1o5d1E1bklYTCt4cDRsamRiYVE4SzRBd1NETlpTMVVKSEJBMzdi?=
 =?utf-8?B?SDRrYmtoQnJTNEhyWVRoYlBGcm9uSm8zMTd6Q2kxYVRtR0VybjZET0VydEhX?=
 =?utf-8?B?NXh5NWd5US9FWmhRekdWUHZqVkxvYXN6SGZkbnRhRXpERUJYRG5makhhMS9U?=
 =?utf-8?B?UWFPZWxCN3BBc1J6UisvaUtlMGkwSkRpTmE5c3kxK0VFVTA1aWN4cE40Mi9o?=
 =?utf-8?B?RHdwVW9NV0V5UlJGeldqVVIwZWRVK3A4dndxaG1FcHQ1TVY5NGtQN0lkbXYw?=
 =?utf-8?B?QUxOVkJRbGpiNjVMMzJmc3FVZ2NsZzJ0SVNwcGhKejU2b0NrWStibzJxREYv?=
 =?utf-8?B?Ri9zaXhPQzhRaEtRcW54WDFGOGY0WDB4Rm1iL3o2aEYyWXJ0cUVyMVM3d0Rk?=
 =?utf-8?B?b2k4Ylp6MHZ6RDdvRW9KSlRudzMyaFo2VlY3ODNoS2gvelRFQmhGT296ckNQ?=
 =?utf-8?Q?9spjIRYbJNkUHSJGvvqsZBTTK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f713c7fd-aa7e-49dd-5279-08db924a6f88
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 04:47:40.3759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lul1aMLsvMzgl2TiMkqhyy6TdNurKzhESJ0oyvBdu9ycWlwMvG46xaFCSKxBUAnFskyxjbxl/J6ikBRR5Xjs9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/2023 4:48 PM, Nikunj A Dadhania wrote:
> Secure TSC allows guests to securely use RDTSC/RDTSCP instructions as the
> parameters being used cannot be changed by hypervisor once the guest is
> launched. More details in the AMD64 APM Vol 2, Section "Secure TSC".
> 
> During the boot-up of the secondary cpus, SecureTSC enabled guests need to query
> TSC info from AMD Security Processor. This communication channel is encrypted
> between the AMD Security Processor and the guest, the hypervisor is just the
> conduit to deliver the guest messages to the AMD Security Processor. Each
> message is protected with an AEAD (AES-256 GCM). See "SEV Secure Nested Paging
> Firmware ABI Specification" document (currently at
> https://www.amd.com/system/files/TechDocs/56860.pdf) section "TSC Info"
> 
> Use a minimal GCM library to encrypt/decrypt SNP Guest messages to communicate
> with the AMD Security Processor which is available at early boot.
> 
> SEV-guest driver has the implementation for guest and AMD Security Processor
> communication. As the TSC_INFO needs to be initialized during early boot before
> smp cpus are started, move most of the sev-guest driver code to kernel/sev.c and
> provide well defined APIs to the sev-guest driver to use the interface to avoid
> code-duplication.
> 
> Patches:
> 01-07: Preparation and movement of sev-guest driver code
> 08-14: SecureTSC enablement patches.

A gentle reminder.

Thanks
Nikunj

> 
> Testing SecureTSC
> -----------------
> 
> SecureTSC hypervisor patches based on top of SEV-SNP UPM series:
> https://github.com/nikunjad/linux/tree/snp-host-latest-securetsc
> 
> QEMU changes:
> https://github.com/nikunjad/qemu/tree/snp_securetsc
> 
> QEMU commandline SEV-SNP-UPM with SecureTSC:
> 
>   qemu-system-x86_64 -cpu EPYC-Milan-v2,+secure-tsc \
>     -object memory-backend-memfd-private,id=ram1,size=1G,share=true \
>     -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,secure-tsc=on \
>     -machine q35,confidential-guest-support=sev0,memory-backend=ram1,kvm-type=protected \
>     ...
> 
> Changelog:
> ----------
> v3:
> * Updated commit messages
> * Made snp_setup_psp_messaging() generic that is accessed by both the
>   kernel and the driver
> * Moved most of the context information to sev.c, sev-guest driver
>   does not need to know the secrets page layout anymore
> * Add CC_ATTR_GUEST_SECURE_TSC early in the series therefore it can be 
>   used in later patches.
> * Removed data_gpa and data_npages from struct snp_req_data, as certs_data 
>   and its size is passed to handle_guest_request_ext()
> * Make vmpck_id as unsigned int
> * Dropped unnecessary usage of memzero_explicit()
> * Cache secrets_pa instead of remapping the cc_blob always
> * Rebase on top of v6.4 kernel
> 
> v2:
> * Rebased on top of v6.3-rc3 that has Boris's sev-guest cleanup series
>   https://lore.kernel.org/r/20230307192449.24732-1-bp@alien8.de/
> 
> v1: https://lore.kernel.org/r/20230130120327.977460-1-nikunj@amd.com/
> 
> Nikunj A Dadhania (14):
>   virt: sev-guest: Use AES GCM crypto library
>   virt: sev-guest: Move mutex to SNP guest device structure
>   virt: sev-guest: Replace pr_debug with dev_dbg
>   virt: sev-guest: Add SNP guest request structure
>   virt: sev-guest: Add vmpck_id to snp_guest_dev struct
>   x86/sev: Cache the secrets page address
>   x86/sev: Move and reorganize sev guest request api
>   x86/mm: Add generic guest initialization hook
>   x86/sev: Add Secure TSC support for SNP guests
>   x86/sev: Change TSC MSR behavior for Secure TSC enabled guests
>   x86/sev: Prevent RDTSC/RDTSCP interception for Secure TSC enabled
>     guests
>   x86/kvmclock: Skip kvmclock when Secure TSC is available
>   x86/tsc: Mark Secure TSC as reliable clocksource
>   x86/sev: Enable Secure TSC for SNP guests
> 
>  arch/x86/Kconfig                        |   1 +
>  arch/x86/boot/compressed/sev.c          |   2 +-
>  arch/x86/coco/core.c                    |   3 +
>  arch/x86/include/asm/sev-guest.h        | 175 +++++++
>  arch/x86/include/asm/sev.h              |  19 +-
>  arch/x86/include/asm/svm.h              |   6 +-
>  arch/x86/include/asm/x86_init.h         |   2 +
>  arch/x86/kernel/kvmclock.c              |   2 +-
>  arch/x86/kernel/sev-shared.c            |   7 +
>  arch/x86/kernel/sev.c                   | 631 +++++++++++++++++++++--
>  arch/x86/kernel/tsc.c                   |   2 +-
>  arch/x86/kernel/x86_init.c              |   2 +
>  arch/x86/mm/mem_encrypt.c               |  13 +-
>  arch/x86/mm/mem_encrypt_amd.c           |   6 +
>  drivers/virt/coco/sev-guest/Kconfig     |   2 -
>  drivers/virt/coco/sev-guest/sev-guest.c | 638 +++---------------------
>  drivers/virt/coco/sev-guest/sev-guest.h |  63 ---
>  include/linux/cc_platform.h             |   8 +
>  18 files changed, 882 insertions(+), 700 deletions(-)
>  create mode 100644 arch/x86/include/asm/sev-guest.h
>  delete mode 100644 drivers/virt/coco/sev-guest/sev-guest.h
> 
> 
> base-commit: 6995e2de6891c724bfeb2db33d7b87775f913ad1

