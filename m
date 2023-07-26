Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E07631C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjGZJXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjGZJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:23:08 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770811AA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB+j0JfOfY4xFO6lqdWNvtrFNbDvLbuY6Zdr7sxxYg+/IzNQeMxZ+pRhSTsb9zn3A10Y3JAc45SrtWEL2nJOCTswZvDgFIYLJ72XAuCUquQLQNyvERNf+cI1To0j0ovcsr3vXdv3znLDpyDF0i12i/tSqFMj6dCJgGy4IfTWlpEb+2aPKjTUs/hEJKn1rzt0gP7UCCWBxlTbKH5hZt68R7e3ioTIcyw4YRf4ZzGL4REj+u3GWmvgZ2JvZicpAVigf0m362Mzm4/AqZfAnF37urnuLPtSMGud7LW2sZySH5ldtgm4CCLeGABNMzn1pH27OJjFwBGDh9R5Eao3Q6CrgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMY/Raz5feB6c8PEU4g1o2JjTBVP82O+H1DPyVXUg+I=;
 b=V1TGDmI5neOQgIKmxa9Kdv0sP2iLGQEG/zNgCyrLTvLsuadqQPuRGVYh2TV3geAhO5wfiVYpoOUnK55zQN8ThvqgM78QRxLY/SPnaSbmhEVrhTm9Bx6U0Z5HQm465d7QdfI/Jd34w2lDidaAnj6blhjplvK8hVUwr0QAcIFonZwRtouobHsAqkh38Gdiwl6s9aJ5smvp2mLISXJclSDESkRgNvsEHY/uglN0iTA5t2JaA1++ZcbQKXXLUUsaOGO6Z+/pBCSK3gzHJqUrK0B+JDJyD8rUEeWDh9UrbTES2FLkVq5o1R3hRSPq4cQ7wTKZfPyv2WxMLo5n1KKeLZrDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMY/Raz5feB6c8PEU4g1o2JjTBVP82O+H1DPyVXUg+I=;
 b=NAFzDnVp3njaXxhS5vcmODdLLWsAExm+WzYsdZa7IbCmAm5CZeqA8sP827TmU8Rq4VRyhgHkObwfM8gyOVtUbfGjI4pCYPLQqHmdISBt6MOCIKDmzy5vlRshNgGgWZ9zMbgFXpR2zyqiZmO3mcc//ZHlwyFJCWk7jwXsTNjjqz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 26 Jul
 2023 09:20:29 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 09:20:29 +0000
Message-ID: <f4b7e173-6e77-b658-be42-eea64e7f2ed9@amd.com>
Date:   Wed, 26 Jul 2023 14:50:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nikunj@amd.com
Subject: Re: [PATCH -next] x86/sev: Mark boot_ghcb_page and boot_ghcb static
Content-Language: en-US
To:     Li Zetao <lizetao1@huawei.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, hpa@zytor.com, thomas.lendacky@amd.com,
        rppt@kernel.org, kirill.shutemov@linux.intel.com,
        michael.roth@amd.com, linux-kernel@vger.kernel.org
References: <20230726170659.2474934-1-lizetao1@huawei.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <20230726170659.2474934-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::8) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b6c84e-5c1d-40f6-de01-08db8db98dd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9GSknflN0zAKHOQQiO400NS3LOzpplmI+9LbP3fS1yeC01+uKVz0CQtYLlyhMQ5Bg+oyQd/AWTFBEd3VkWa10UXsUFQqcWk+6MjTeD45n+BYGKUWA4hDqNne7p/cJ5+HKAH5hM9h6mfxQejPaq9Myj3nqu5NK5Fz6yUmcpA7v+G3ndCYf7pOUSGS5cgwIrhCi4l01bgnrcMjFOyuv1GU0Fe6z/hlyJ+72O9gx57uD/5QNZ/INC8wLDArsyWz5HZ59CYpxXMO9SSotpO8CA+/ofSoparrs3KYp92SHLJDBRvD9+2rdy7xr33YfKhbs1EzMvqvM8IYu0jXFQTm8XRQz29P7wmHGUyWmacBFxLmnrWMMUZjUd/rv50MoOw9ip4LoZHCX2qrlDorVBliowRDveGwV6VIxJOFrP+mNsymlesSErOmMXfsVmE2YRIwBP/8lQ3V8ZAdfH5/wl0K/+J6QOcflzq03nK4Gwd5cTlCPO7uhQneUTdydsW2cCa2TYdj8lBZPC3z1PLerX5pZO0VJEsUvUD+4mL/HDF1NZgKCZpiK8RNIBm0dwKsVQ3g3xeONZQBV25BvmDPCspOd1ChTDnHTQWIfjjW1oDc/hYNcuIY19tyLl8ZAc6FbICS17rdCARQt2i9nVLj4fgEaP97uQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(31686004)(6512007)(6486002)(478600001)(6666004)(2616005)(31696002)(83380400001)(38100700002)(3450700001)(2906002)(186003)(6506007)(53546011)(26005)(36756003)(316002)(66476007)(5660300002)(8676002)(8936002)(66556008)(41300700001)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enc4NXNyZXNuZUhFakVYMERBQzZsejAwUVlqMTUvdVR3eU5UQko5Vk01bGkv?=
 =?utf-8?B?RWJVSzJTc0ZNUjQ4cGp6STBMVVpWS2FDMXUrREtZb3ZpNEZtMG1GRjNFS3Jq?=
 =?utf-8?B?eitFYnM4M3NUSWgwcDJtVHRkeWJZQmZVcXJBN3VOeVd2M3UzUzZYNkNCSUxI?=
 =?utf-8?B?WTlEWjdGemdzc1FyV2pab2dWYWVVODcyZEFCdVo5eTdrZVdxdVRacFpkNnhU?=
 =?utf-8?B?bkd1eloydVpyalk1TVlQYlJpRkpDTkRsSHRPZk94N2VIa0pwWGVyZlJocVA5?=
 =?utf-8?B?UXJaTm5abkx1S1lXVERZbzZhNzM5NnRiMWx3cWlJSzNMTjVRL0pUQkNRVmdM?=
 =?utf-8?B?Um12c0RaQkNiQnIvR1V6UmxnOUZtczl6ZllEVENOTjVMQmoxUkhrb25oZmZs?=
 =?utf-8?B?RTFUNlVCanlCQUMyc1oyL0E2bUNzUkJDZE43MXhyV25LaFEyOG5ZT1EyUWdq?=
 =?utf-8?B?RUVkeHl4dm1zRXpZTHZ6bGFxK0pCNzFTZ3VMNW51MkcveFJHcHpmaEhiRmVT?=
 =?utf-8?B?R1hFbHlmcUMxSGdIQjM3NUR0YzZmeUxEWTVlSzhFL3pSOXo2VUhIRG0vazlW?=
 =?utf-8?B?ZmNHREl3YUd4K2VxRENuUUpqMEhNTEl1UFRzT1VFUXhoS1BNeTBhUk4yN3Jr?=
 =?utf-8?B?Ryt5cXAzWEJWRWtuaDc4MmJLOTlSaTU2dUt2Tzc4VG1CQXRwc1hSaU55ZFQz?=
 =?utf-8?B?bHdqeTd1RUE4bEhHUVgvTWdhanB2Ull4R3EzTE5MNkxOQlpvNlYxZWpVa0FZ?=
 =?utf-8?B?STlZdGxCZm13eGs0RnRodmQ1d01VMWJKUVNha3JFRG8wMzQxSCtPQUhtd3dK?=
 =?utf-8?B?eEJsWkJUQXhDc1V4RlpRd1BjYnhsSTB6WER1aktyTUpsakdJNy8vU1plUU82?=
 =?utf-8?B?dHZBWFRITmxsRUt1bTgyOXUvakx3cHZyZWdKcVJ2bXN0dnJtK3M1TjNJbFJH?=
 =?utf-8?B?TTcxM1M1WWRBUmhpN0NMTDFaV05CSHBwbm1LcXFKNFJJRkJHbGcrK2tyNkps?=
 =?utf-8?B?YTFhVStJR3JxYTlxY1hsUFhzemFpWGdwZk1kSkRjYjlIWHQzREc0Y0Y0VDFO?=
 =?utf-8?B?OWNPQkJ0TDNvSWMyMGZiSnZPVDlvTDhuRVF0WHhiZkRLOHVDa3hWZ0E0VWdS?=
 =?utf-8?B?V2VBa3NtU3c2SFhIOHp2RVNCRlFjcTFFWnlNOEZMNXoyd0cwOHI2bUliTC9h?=
 =?utf-8?B?djRPNis5ZG9xai8ybEg3VGlRd0FEUUhkd2NDS0V6czF6dmRLZlNBNHNYL0dB?=
 =?utf-8?B?dzBCV1hRZGFrUkluSFFjU1JyLytuOUpkTjVLU0IwY3F0eXc0WUVMcXJ0ZjEr?=
 =?utf-8?B?VzJ5VFVOSWZ2YXFOeW5DRHBSeGNtNkFJV3FlODkxaW5jOVZSUlJmSGFGOGV4?=
 =?utf-8?B?bHJFQmpEWlBWWEMxZFNJY1lQM1Myck93YUpDV0NlUEZ0N09Rb0lPYys4SEdH?=
 =?utf-8?B?d2NPV1hyQmZCODE2TjcrVnpXcWtnRWQrdytTL04xNVJZM3gzaGEvSnFRV1NC?=
 =?utf-8?B?b3ZvR0xFbXA5anhxTnA3V2FBMXZ6T0VJU2gwUHdkMkpHV3dyRitWeVBvN3Z3?=
 =?utf-8?B?YmVnZS9mckRiWnRTanFKSXZNWjV2NkVTUUJTWUpwNjBXbS9pdmpSYTcrOUZk?=
 =?utf-8?B?VWx6cEVCeXVleWJQOHJMOVhaamNVWHZRVTRYVkhNSmwyaHpSSDBETWRsd1k0?=
 =?utf-8?B?Zzc0Vzd5M2tzTUpoZTl2M0lsa2VVUUFKSDROaUMwWnJyN0VmbEVia2ZLb1NZ?=
 =?utf-8?B?Q2RBZDFITUkyQVpVbVdBNWl4ZmdFdkI4cTlEOUZjY2R0VlhEUlQ3bTBpZStQ?=
 =?utf-8?B?MGlqUXZBaWczL3dSakhsRVBpSU9VRUdFNXY2YnhZNHpBUDZ2WDBTQkJ1d21K?=
 =?utf-8?B?Z055aERnZWgvaitSVC9YbXNONUNvT0ZBUzVoMTRJWkxGdHA1R05oZVIreUZL?=
 =?utf-8?B?WXAvYmVpRVRVUnBmaTdqalFQaFlvZHlmQ21YRG12dC9WM2NqWlh3OFM1d1Nj?=
 =?utf-8?B?ZDYxMnRVYzN6c3lZTlpIV2lvWUtENHVocW5DaFFYdGgvdXoyaXB3czJqOUFk?=
 =?utf-8?B?M0ZZRU5nQkZ3ZEhub0RzcU5TTDZSQTNqTEt5TXlQN1p2QUpPb3dkeGdvdk9C?=
 =?utf-8?Q?JuNsPN3ogvQgv9QZ4spW7GLmi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b6c84e-5c1d-40f6-de01-08db8db98dd5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 09:20:29.5114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kODCLwk8XZE3TKUF/aWsESIMsJ054EdbzwVMWYjBZzD+Wg1uew75ZV5h6lCX5axBENvD33fqFM15p6PnEEcumQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2023 10:36 PM, Li Zetao wrote:
> This patch fixes the following sprse warning:

s/sprse/sparse

> 
> arch/x86/boot/compressed/sev.c:28:13: warning:
> 	symbol boot_ghcb_page was not declared. Should it be static?
> arch/x86/boot/compressed/sev.c:29:13: warning:
> 	symbol boot_ghcb was not declared. Should it be static?
> 
> No functional change intended.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>

With the above nit fixed

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

> ---
>  arch/x86/boot/compressed/sev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index 09dc8c187b3c..323f6298a6b2 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -25,8 +25,8 @@
>  #include "error.h"
>  #include "../msr.h"
>  
> -struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
> -struct ghcb *boot_ghcb;
> +static struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
> +static struct ghcb *boot_ghcb;
>  
>  /*
>   * Copy a version of this function here - insn-eval.c can't be used in

Regards,
Nikunj
