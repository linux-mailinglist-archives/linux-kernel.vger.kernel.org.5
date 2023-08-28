Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED9C78A4D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 05:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjH1DsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 23:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjH1Dr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 23:47:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A5CC6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 20:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpsIbJ8iKvkEu9Q6QdqdjoGIsmJetXX2h0ja+glT3jS/oVIgQChPQTv/IyOjP1sZg8vdN/y0fReOmkNvU22I1/DgH0M4TunMpDww9Q5mTEx8XdYZNJfX0x/0pHa+WNaq9cQI8E8lt0idq54JW4NVEuzQ+z6iuK2J6hNn6+L+SWNWgd3ZSvHAEp2l9Oe0ORdOue8dH9RlGkJ/tawq4bvPuMtsH0u5T/w5WsNwvgPK81HC2hXrhxeJzLZWbd/xwrUFnE0TdzpS1St3LEuCh7KtAp5Netp2g1N+AiQZMCG6/+gu6BDkBVywKQ44x9jVEA1gpLPqLQJZ6BkwBAZ+OZMcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqRNcrg3Ew/WEXZMNMLGMVfYGq2/E3WIRLA2dHCS8YU=;
 b=XiPKe2yzymzIDuFb8OLQGHsnEl1ObjL6/O5ZjPJxtCP/YHHjBhRWbeEIgIZFp+EhmtZOZm6sVxCZm0WOh7JDPwAzziUoFckVpl3LgPwv5x2mUoWDxQxF24xL8qa+gQ99pDnYnjiTXR7y/jKjAEhKw+s7DDSu27Zc6kR/WUbzeMFzkIek2+UMc7Dzurjl/1Pytcuw3QbJPv+1SrHcQTkuopJRfhNeRCRIa1rdR351/pYN0IpnzvjL+jK7Dg9YgbgJ0VG80QJ78G1QP9T4yD1pm2R8c/1fb6TGHkXfXCyncIWDVchvftg1/LT0SA2utoEYrjfcuAlsrNS9Ji75ggZGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqRNcrg3Ew/WEXZMNMLGMVfYGq2/E3WIRLA2dHCS8YU=;
 b=sdCqhBkAlNTHdrPrueQ7K1ZjhLt3etm8ZmlS3KdydBgULClnjyiwysR03D8DTs/A+TmQWz+zslSOCF2/t00T3k4vt0Cn+yugnWg665RQVl0x8aMueckQLWotQkj54VqZTxConC7gccGpo9MIgGhFmUbyfzFcfOFDziTk05gQk4Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Mon, 28 Aug
 2023 03:47:48 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 03:47:48 +0000
Message-ID: <f200403b-c460-5ebb-fec5-c5caf0cdb006@amd.com>
Date:   Mon, 28 Aug 2023 09:17:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 00/14] Add Secure TSC support for SNP guests
To:     thomas.lendacky@amd.com, x86@kernel.org
Cc:     dionnaglaze@google.com, pgonda@google.com, seanjc@google.com,
        pbonzini@redhat.com, bp@alien8.de, linux-kernel@vger.kernel.org
References: <20230814055222.1056404-1-nikunj@amd.com>
Content-Language: en-US
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20230814055222.1056404-1-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::18) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: c87fdcfe-5c2b-4e10-1998-08dba7798bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PSbfHn2Hr8cu+IgQc1veu/O2M/eOl8IUn6YbKCKrR0wYIf3xlNwl1iR9c6UcMkg2q9aqWWHLOTTTy9pNRWjktidSuKrx0dbkFBA5+dRsj7AJJ+764zmzsXhY3UCGQ0g0Qcs9/0hqdHpAWDcvXYblKVTct1YDneUq0kESv9JnZMDqwiSD/3JFdBi8u8xgZahnLvOrFxgqElreijS/5HsVDxJB0j4/DatXNfcrVLSNU3IdgCXuTGgICQLcsGvHpDsMPlGtBhpXbBa//ufVeHRfdJOQB1rCcxnFPfmHgaHtKkJD6Yrktk7uPAG8ANFU/U3+sh29bYFx83eAGZiOAKJ8+8rxHGp53IhsYQEwUuR612LXxMI8XT9SCSEKv8dOCv3Sw9Iq0w/8QGPblDAr/W0TdnNfIQqcXFfA3j1SvSooFcber8b9J/Sr1SSa/PGQblwAjPV1FxeHZhxHRegwpnWfD+CyWiypWrcw4VxyHplz1Wbf9MhFvvy3Iey0poyqu9sOickMNcbBYfrhQ/QFVwMlblzHkaBOLM3yKMUjM9YksTDB75IMLzfDfhJhD4dnHU7uc0/2KXDhtIXe4/Q/3X0pIZjWKqLv8ArAMuApiSxRlKFAhBB6ozZbGjE7KHNDF3RxwCu4EUCBKOxNU3oxkebevGwPy7ecUwKSI3wM35cZ1BA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(186009)(451199024)(1800799009)(41300700001)(2616005)(6512007)(83380400001)(53546011)(6506007)(26005)(66946007)(66556008)(66476007)(8936002)(4326008)(8676002)(2906002)(966005)(6666004)(5660300002)(478600001)(6486002)(316002)(38100700002)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzhtbGxvZk1iWkZvRENTVkd3eWtsT3ZVUHlLeE5GVHFrRndSQ3JVMDlHL290?=
 =?utf-8?B?UVR6c3I2VS9kLy96WmI5NkdMRWZjLytFQkZCLzc4N21kcGhlclg3SlFiUUw5?=
 =?utf-8?B?Wkp1OEw2aEtzb0hHdGZkaEg1TENscGI2cy9BbG8zSmlYSU1TdEk1L0xvazJx?=
 =?utf-8?B?MEhiZ0o4dlZ1WkFkQVJhTE9IdFNNcXF3dnZzSC94U2NWMXM4MzBKYW1ZOGdU?=
 =?utf-8?B?cWREcy85UmtoUFVXOHlObjAyQ1pUL2FzbzN2ZldsWGFaclhHRmc0NGhVcEpU?=
 =?utf-8?B?YWZ1bnFnc2pGZzRZay9udTNXRkxVN1N6WjI5N3YzbkcrbjByODVmSWNMVGRn?=
 =?utf-8?B?eGlsajBzUnl2MGpDS0U3RjBkZ0EzTWUwUll3VnJzM1k4elF0aTkyTXhwTStJ?=
 =?utf-8?B?eXdrcXBqL2U2eGQ4Z21YMlhLY04wQ3ZudUJaNnRYckNBZDI1OU9KeUh1cS9N?=
 =?utf-8?B?S0cvUXczSkdJWGZaSEdGbkZZVFBCQXo2dk5OSzV6aG5qMWxEL1c0bmZheUc4?=
 =?utf-8?B?emRkcGhJS29CUU44STdCYTA2dkpVU1BDOWZxUDlsbUkzQ1BENEFHdUM4ZmJY?=
 =?utf-8?B?cTE1anZhNU0wekp4TXh1a2lCakF3cmJPakxEaDU1N09sWlVtUWc5ZjNjcFg5?=
 =?utf-8?B?dGdqV1Fpc0g4dkZ1c205bVBHVWFCaGorb0dabmUwVXV0VUNDWkd6TWUwc3pW?=
 =?utf-8?B?WmRYRHBPMzRMaE1WbXFkVTJlZUowUWpLVnEwVXQ3bHVlVkxpd2VRRnRSQjJy?=
 =?utf-8?B?ZE1FM1NZdnllYnd6cG9mVTJIbDJwYkMzLzdWUzdnb0RkQndXUHFDR3M0UFdE?=
 =?utf-8?B?WXkycEUzMmgyTTRROHJCYXFaSU93cFZVSzcxU3hkTHJ5UkZlRGs2aXRydDQr?=
 =?utf-8?B?dTBUQzVPRXhiV1J6WUdBTmZiMGpNOG9vWUxYRjFVYmJKbUIwaXBLejRUUW5L?=
 =?utf-8?B?VjNwNHFSY3cvVEhFaWhIWENiRlByaTVwMGpmL1JhUUxDMzdvWlVpbzAvQ2Ri?=
 =?utf-8?B?ZU8rQjRtSjBuV1FNMldBQkt4aWQ5MWVyL2taTG1nQ1l6VCtadnFXdTJYTjVl?=
 =?utf-8?B?d3dLMFZ0alFXUjRCYWV0OWZyMmFWWTVzbjlJdytTVkxMckJGOXp6M0VSTUZY?=
 =?utf-8?B?VVlZbmZka3RIakJraWRvVmtUM293Z3hhUmVPRnNrdTg2RlJhMkFQOEx2cUk0?=
 =?utf-8?B?Q2d4T0pGUDFMUldvc3pWQzZxZzgyMi9rdUQzbWNvakhPRXdVek9kZEc1anRU?=
 =?utf-8?B?ZSsrenhiNHNqN3pKVXBQc1ZpM3NGOG1wVWJicDdyYXVqZk9PaVZJajFWbFN5?=
 =?utf-8?B?WmlVL2NUdHNHUXYxTG9TcUdONmlKV1c3cDQxWUVMbFR2WjRuU0VNV1BHMXZq?=
 =?utf-8?B?ZWQzVndiOVRrVENGNFZhVTBXVVlCL0NZb0dpQks2VHcxeVM0Ri9UVm5yRFI5?=
 =?utf-8?B?Yk1vaFJYTURzNGVMMTZacWdodWhaL1RwT1dRUVJxRW44ZlRtTFNHeHBWQTZh?=
 =?utf-8?B?dUxCWFpBYUVCcHNJbnJNN3FCMWMvVDRqSzUrbVN6RHRIMFhLZ0R6UWZ3UFBF?=
 =?utf-8?B?Y3ZuMjdEYVA1YXg3clNrUDBiVWoxTFUxYksxVU1CcWRPWE9Scm9vUW5ZOE54?=
 =?utf-8?B?RG9JNXM0Z2JQNnZFNTZOYzZhdE8wYTU3cWhNTXdVYi96SWJlS012RHRWdTFZ?=
 =?utf-8?B?alFEQ2ppb3ZhUVMzc0k0dG9XaUpYaUJpbjIrYWlBdG1lbGRxWVJhanB2Q0ds?=
 =?utf-8?B?SGZyWnFzRTZ4M1U0TTFzZnBZVHhuRVE2SGd5TVJkdlhScENzQzRBOEpvcmhG?=
 =?utf-8?B?VzQ0SEM0Zm91Z1htcE9oZE5xYlBWRzJFdzNXeG9EWmhMTjZpMUpITFpYRUpO?=
 =?utf-8?B?dFcrNWxleFU4alcxMno2bk1zT3RVVjJlN3E1Q203OW9rL3dYR0ZRSTJRb0NM?=
 =?utf-8?B?cHd0RkQ1UEsyLzJuZ2J0aEdNVjNLc0FSWWJkTXJ0QU40dW5POFJ1SkYrV0cy?=
 =?utf-8?B?cjNxTCt5eGlLdHd3T3NVSHBqNzRjeVNIdHZ2eHowK1owaDZJa1paL1JEMFhv?=
 =?utf-8?B?dyttS2NzT0NmeUtoMUpOc1NoV2dGeTFaWWxRR205VEJ2Rm1mYmxEaElUc25J?=
 =?utf-8?Q?85THOvTPKx0iW9YJKzlT9Lr+Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c87fdcfe-5c2b-4e10-1998-08dba7798bb8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 03:47:48.5338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ySUAZYb21WgpDvqYt4VFOKIn+cVlLuKQ/7+lwOB9TnQ8Zm8eNzok6sCK9ZZNg7PIJt7CG5YSN6mJ0HBwWOvkLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/2023 11:22 AM, Nikunj A Dadhania wrote:
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
> v4:
> * Drop handle_guest_request() and handle_guest_request_ext()
> * Drop NULL check for key
> * Corrected commit subject
> * Added Reviewed-by from Tom

A gentle reminder.

Regards
Nikunj

