Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79E97B7DA2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjJDLAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjJDLAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:00:09 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC75A1;
        Wed,  4 Oct 2023 04:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKw+c04QgXMzDWuOOUuQK3ux2z0cbGFsI+5ClJl4jQjwP/Bv5CWKIm/ZKM3YhxypbTlRhy014PJGFBBoAv+IBaLETno18JjeCEXnlf/PK2yztu8qsX0TXjKCUPxhtRP5pOPzFATlbX1emBpYvFupS/2m9bHJwJWMfGvgJCJtf5GWUTNFvjbVNj5p0j340BP0eVXsZAKUYTCUCcjN66KIgjf/474hZaPdvwyf40gOmm80ha65zGX7qAq9NJByOJR3JXt2qkYI9Jt+jGxYuEHHKMhDFJ1a9DN/Ng9+0Oc3gvrK/ZiMv9zRcNXD/mlTRf76PdMgwMi4bg1IBmNiIG++wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxBKnL0c6SykYylO1KpdCKzNA5lEjjGexgJ5j8gnrBc=;
 b=WWwBpBoPKnnJ6DY+i6YyRZ8ED1/g6DQxTeXmXrWSlhpM8pKQ0ELEfelBpzHkcNCk4amVTxK+/SkL1YDcNDFqMFTQqhXYf+KjskXvUsig1dNJVz2PW7V30mCxo2nQf/7ipg4Rdo7RDfdmp1mi0ETbLpW7QuGVtlIs+7KrSTwKnO2MpUTZBoKYRVHlJws0Bb8VNuGyk2OyuPmpMAE7xKHRhccXSR0WMpDyDN1yIqgu0bqJGTgYLXG1zIHt2uqQOl1AIn3IRGcpwhwwvaLFdleE8ejiJ5ruVqvqODNqB9ofjyIKMpFgsq10LXDFVBl8Kn2wYCrxOQS7JghnGKyuYyPmhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxBKnL0c6SykYylO1KpdCKzNA5lEjjGexgJ5j8gnrBc=;
 b=kybHn4J0QzouoKBA+Q52jAwmp+M5FKrzvTgm+1MFBvL/HSaF7dHDq/YsP7WJXevTrYGfPwU8HIKHVlZMtom87WH4og4xVieIyJ2+Cxs50XOxbZRH0zY7QZbdbCWU6JWL4aKwQ/5KqwNjGd55dJcjz5daHvr2Jv2bUmhDEKpSYtY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by PH7PR12MB9253.namprd12.prod.outlook.com (2603:10b6:510:30d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 11:00:01 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::b009:6291:f87a:33b6]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::b009:6291:f87a:33b6%4]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 11:00:00 +0000
Message-ID: <0ad21a06-7a64-7d71-16f6-0bded64b6921@amd.com>
Date:   Wed, 4 Oct 2023 16:29:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] tee: amdtee: use page_alloc_exact() for memory
 allocations
Content-Language: en-US
To:     Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        SivaSangeetha SK <SivaSangeetha.SK@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>
References: <fe6fd7781d77ea32064e5b861f33150b28768278.1693340098.git.Devaraj.Rangasamy@amd.com>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
In-Reply-To: <fe6fd7781d77ea32064e5b861f33150b28768278.1693340098.git.Devaraj.Rangasamy@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::11) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|PH7PR12MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 786d2901-a809-49c7-fc5e-08dbc4c90dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kjbp1olyHPfospjvHSvRt7vPpXrs1qXCB0F84T/thF2Dfbo7Yzgi88tp2WUJq0zOomHGrMkelC4Wn0fmCFiVfvXiNWOKFK8Weh31/di94ACpLne8HNKRz7/eqWR9gbtv1siJaj3jjRoAzSSfHuPhGnnneIlDZPxK4NgVySlp5tXedXiAZxzpNKd5JSHQ6SvyTZXREp3q5zigBPgMj2tOJqXiDhwVxYfi2IWohLHxmf4K+PSX90QjBwcJUuhoGUSgQz21SKyFQgBYSilZO2oH3a/0OYlJQbVckjwvOuzECJ979TMbqT31XNQCOMhP4HXW6tdFPozo+byblorhsjlmboWNlEa83F/9/BT1nQ+EhjDmcbmOBMh0McQTnnSmBbKB3i0u4tS8BeWli4D0TJhRxAN+mPWfeyMrH7rScsxXDVBvWDrPI+IoIcEeCo+Xdx7ZIcs31N56Esb7CPumJfB1OzQKmLLh8h7esLM63DjVXrM0GphVKirm52cPwq02qMvS9sIZHwvqQEFtjQZxNQb/X3/zyuKvN1vSgXNCc51SGpA/G39rVHG8OccWa2oIOlh7/tnJg84xh7LTPnizB8N37pwd8lbFfaBuUuaxnxuSft0gnjxwOQOTc8jaj1xLhEtXAw6CjnhZUW+23R9TCNqZYZEKGo6dmzBmmIg1DlL2/vE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38100700002)(6486002)(8676002)(8936002)(4326008)(478600001)(86362001)(6506007)(6512007)(53546011)(6666004)(5660300002)(36756003)(41300700001)(316002)(31696002)(110136005)(54906003)(66556008)(66946007)(66476007)(2906002)(83380400001)(7416002)(31686004)(2616005)(921005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUhDRXBtUHpaZlkxVkNFbnRxckNPaGRrZ0trUzJxeDc3clJTOTExbThyUWhI?=
 =?utf-8?B?WEcybU44a0FmUTQrOHpCOVRMZDJMclR0RTZFQ1l3K3RUcXh6L2hnc2RjM01m?=
 =?utf-8?B?elNTZzlFY2Q5LzZOVVdHSVdWT3pVTFA5T3VzRyt6MUIvZ2g2UTBuZXpURElp?=
 =?utf-8?B?STRkTktaaGllcG1kNmd0R0hYYWpGVW5MNzJrd3FiSEhvY0JIV0RzU3JTRjdD?=
 =?utf-8?B?ZGhLTlJMbHE5OUFXMW9NNUxsZm1BSFg4aFdYN1dQTkZOQVhHNzdEMEF5WU13?=
 =?utf-8?B?ekZBVGRhWjcwcFBXajg3elUwbVk1OUdqWkd6amdIWjJSWjNQZzBOR0JRYmd5?=
 =?utf-8?B?b0NsaTdxK1pzSHE4Z082Z0c2QUF5QWVncjM1MUx6NWljaHdvc29hdkUreGpS?=
 =?utf-8?B?b3NodUxNb3dQM3NaY2JXdURaZ0ZJSWN3K29XRmZhWW9JRU5Sdzd4UEtLT0Ix?=
 =?utf-8?B?T0ZCWDF5WGs5dUluV2NBTG9adTVENGt0RmpXWWtVM0V1N084Sk1IcUtHcG5t?=
 =?utf-8?B?RTE4SjdhK2FPSi9yQjNUM3RDSlJQcVZBVXp2RlJFTzNVR2VleWQrNWZ3RWM0?=
 =?utf-8?B?NzJXalZpWHFia0JPTkxMdDc0WFJnUWZ0NU93dUlDVUh4ajVVYlB0MklEcUwy?=
 =?utf-8?B?aGxTeXFxazRmQ3lWRmdOOWhsVW1sNjdMeTlOL3ZGbHRZQTU5ZzR4MUxkU1g3?=
 =?utf-8?B?OGI4Q29VTzV0NkpDRHlZNGZ2QkdhQkxQSVMweFpDV1NTV0JZOHRpcUJlZmJj?=
 =?utf-8?B?TVBTdExMQUhuSUtWMEtrTXNSZGc0N3krN2lHM0tOUDdnZ3N2cE5saEdMcEpX?=
 =?utf-8?B?ano2b1B2aENrRVB6Um5aZWI3S1I2b2NibW9uM1R4c1M1TmpvWklaZCs0cVpj?=
 =?utf-8?B?K1cxSWRCMkpzKzd1bkN4N1ErclQyL3J4ejkzb3U5QUJ6MUxpOFBRZG9KZWE2?=
 =?utf-8?B?LzQ5T3JVTjlTQldtUWZUR1NJTlV5ZkplNWFTNlJoMkZlWTZmaitVVU5YK3BP?=
 =?utf-8?B?bkFKVlNnSTI4dDJVQW10b1pXeTV4VzdXS2RZNEJFTm5weWQ3MXRaRm0xZUFD?=
 =?utf-8?B?dUgzYjNBWUNtRVNFYmU5OE5vWDVoK2hXNjI3WkNSSC9lV3V5cVFqQUFUaGRn?=
 =?utf-8?B?Mnh0ZklJOWZKQ2dWNkJKdVdzM05qem9aZ01CZUJYNFBjenA3QklzN3pHMUt4?=
 =?utf-8?B?YjNPWHBRKzhjVFNIZE9uWGY2UkNHQWFzQk8vdUJubnduVFBrNkZZSW1LVFU4?=
 =?utf-8?B?R25ySnhEa2RxMUdULzdoMXFRcnc2YXEwcmxSN0lRWG9GQk45bmlDSFFSa21G?=
 =?utf-8?B?bnZPL3RmY2NsRjhCSFNFUi9xbmpiUmE2cFRQMmloRlo4ZXQvei9QSGtEMkJz?=
 =?utf-8?B?K1FwQVpoWjFMR2d3K29WYXUyVzZpWGh2K1UrcWxRNzN6RXpBejBUVTFWbzVU?=
 =?utf-8?B?T2QyWmtNWFdVTm5rQnVQTWtJWkx1V01DNkRBUEdzem1keU1odXFkRXlPWjNI?=
 =?utf-8?B?Yko3OXVxTDFPNjFWaEJraytkYWNBeFp3OEh3cVRBMEsxZExHQjdQcHBUV2Y3?=
 =?utf-8?B?SkhDNGRKcy8wREJVY09IK3pFbFcyRm5LalE2bktLOExxQ2RCb2lvV3hBeE01?=
 =?utf-8?B?NG9UTEZSZWFScWVuRVZSNjd4cXJOdXlqVTk4OEhXZ05xUUtNZSt4dlUvM0h4?=
 =?utf-8?B?allPQU1XbEwyV2I0M0tHK1VlQUt0eStodzFkUDRST09Pd0h4VFpUclM0ZVpn?=
 =?utf-8?B?c1ZxbzdYMVJwcnp4V2F6MDRTcTFpa3pyL2Yya1R4dW1OTGovSnlzR3EzMEpl?=
 =?utf-8?B?Y3I0eVMyS2VWQjM5V1lpOU51enA3ODgwQkdNUk1ST2VKeUZORHNkMlBHVDlK?=
 =?utf-8?B?S2ZnVzk1QURSMUZyTWRwN05jMDhNTHY0ejhHakdUUlVyK201M2xCZlRMUXpH?=
 =?utf-8?B?TzJqUmN1ZlozVWErdVhva2ZMUW5uK1ZLTmtoT0pSTTVjcjdjYmtkd09kdTFM?=
 =?utf-8?B?L1pxTTV4Nk83RHR6MHJIS25Cd1pFZXNZRjliSktTamwybUlMZGhpbkFDNk1n?=
 =?utf-8?B?SnFsdC9PQXNrb2duMGROejhyckdiU0VDRFFkZ3c3M0hiMjdEK3dZWExiR1Ry?=
 =?utf-8?Q?zT/mNGVuOs9ynj2NicJ5KobUV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786d2901-a809-49c7-fc5e-08dbc4c90dfb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 11:00:00.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cd4gwUFSqnEQeV2PtxFfiLY3BrdvnzBRW+iIwZeM15LQVA9GEyKKY51lnzbYV5dsAanpX0WbJG29Lo8QuyuDPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9253
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 1:49 AM, Devaraj Rangasamy wrote:
> Use page_alloc_exact() to get buffers, instead of
> get_free_pages(), so as to avoid wastage of memory.
> Currently get_free_pages() is allocating at next order,
> while page_alloc_exact() will free the unused pages.
> 
> Signed-off-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> ---
>  v2:
>  * Replaced __get_free_pages() with alloc_pages_exact().
> 

Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>

Thanks,
Rijo

>  drivers/tee/amdtee/shm_pool.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tee/amdtee/shm_pool.c b/drivers/tee/amdtee/shm_pool.c
> index f0303126f199..156e8a6f631f 100644
> --- a/drivers/tee/amdtee/shm_pool.c
> +++ b/drivers/tee/amdtee/shm_pool.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/slab.h>
> +#include <linux/mm.h>
>  #include <linux/tee_drv.h>
>  #include <linux/psp.h>
>  #include "amdtee_private.h"
> @@ -11,26 +12,23 @@
>  static int pool_op_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
>  			 size_t size, size_t align)
>  {
> -	unsigned int order = get_order(size);
> -	unsigned long va;
> +	void *va;
>  	int rc;
>  
> -	/*
> -	 * Ignore alignment since this is already going to be page aligned
> -	 * and there's no need for any larger alignment.
> -	 */
> -	va = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +	size = PAGE_ALIGN(size);
> +
> +	va = alloc_pages_exact(size, GFP_KERNEL | __GFP_ZERO);
>  	if (!va)
>  		return -ENOMEM;
>  
>  	shm->kaddr = (void *)va;
>  	shm->paddr = __psp_pa((void *)va);
> -	shm->size = PAGE_SIZE << order;
> +	shm->size = size;
>  
>  	/* Map the allocated memory in to TEE */
>  	rc = amdtee_map_shmem(shm);
>  	if (rc) {
> -		free_pages(va, order);
> +		free_pages_exact(va, size);
>  		shm->kaddr = NULL;
>  		return rc;
>  	}
> @@ -42,7 +40,7 @@ static void pool_op_free(struct tee_shm_pool *pool, struct tee_shm *shm)
>  {
>  	/* Unmap the shared memory from TEE */
>  	amdtee_unmap_shmem(shm);
> -	free_pages((unsigned long)shm->kaddr, get_order(shm->size));
> +	free_pages_exact(shm->kaddr, shm->size);
>  	shm->kaddr = NULL;
>  }
>  
