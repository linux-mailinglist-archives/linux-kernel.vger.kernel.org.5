Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019B5787F08
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjHYEiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjHYEhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:37:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE721FD2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEzpjb6AilLj7ho37vkUI0j2Xb9DcU3zT95+CpxNXW42AjF3J+5Bd/3jux0OiY9rQzhldqapYB2Xl6kiyU6oqnYIuGERU4DsDofd5CB1sQwEBmQZ6tLo3nEkGZCIdw7D+MfLyW2wdoBafSevpQ9ll4Vr32ZBe6UZHkYzsRCEXBf/sy1lOpW+xLmLyjHZ3ReiOgfa2oxnRibPqO7+aPHlYNSmGmM5CnCAKHyVrTVh6/Mm0qEBGE4/Sax1hMUKi/CIW1CeNYB/9QICJvHVseR+c1kX+YM+KJ2qTYpWKGvjr8oI01/v3Xef+i5sxl6rPBZvJxxBMjG+inZ/spCLUUQIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+p0XVJuZ297/HnQAvDvmEbkRsh54SIuo3/bdnUdwva4=;
 b=lY+NGa/r01bV0KAjfdWQQABYLYfMrX+5DdU+e8oO8LHnPi+vf4x1XbO0ofKfX685tFJMz8zwKajMTVhpcCKZRBhGQC8AeTSOOmyeSDKsZV2ryV6rB+OI5/VX402UHeIaRyPK+ThHkUHrBj5vt1pvG2dIqvLl0sgLmx2LKYLYUsFL6VCApRGal3nQjL56i1dJwue7q7xXtQ/C5uSIRGoW43u4cInVKl2JUYljlDXWkA2R4wIoP+BmjCqmaY85bpywWSgmGevfS25THaFqSPY9r3OpucA9CLD9iIsi3AX1gpIhVROlz9cC1GAWefF29Ub7bCoDf9LjJku7yc5HA9i79w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p0XVJuZ297/HnQAvDvmEbkRsh54SIuo3/bdnUdwva4=;
 b=0oYed5Kg+zbgAbtEldp/BoSH/+31K0LpshKnUn6b/OjMSS/l2AkrM6WsnIM9zw4xS7Cb3cQNruV9nEcSp36oTvxo+FjefIZB6E/Fhc3l1P3ydFWC7kJlKaqL9h0AtRinHm5ZffknoCTZECq8EFYelKl8aRHFmPRsJTsgTbiFLEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 04:37:42 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::bc63:b5a8:902:ee0e]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::bc63:b5a8:902:ee0e%2]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 04:37:41 +0000
Message-ID: <73949f6d-bc2d-f2eb-7609-ae66a9f0ddfb@amd.com>
Date:   Fri, 25 Aug 2023 10:07:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/5] kselftest: vm: Fix mdwe's mmap_FIXED test case
Content-Language: en-US
To:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com,
        raghavendra.kt@amd.com
References: <20230704153630.1591122-1-revest@chromium.org>
 <20230704153630.1591122-3-revest@chromium.org>
From:   "Jain, Ayush" <ayush.jain3@amd.com>
In-Reply-To: <20230704153630.1591122-3-revest@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::32) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 52439646-4622-4b99-d764-08dba5250485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFoAj1+P4xtZq/f0KNQ3E25wuGvgj9mFEtGuL/+azaVRI7x6+DONtVPmCdCYU0hjqB6K36p781O5LwMQK4lbr7ZHnzalwlT4pQa7IhIX2i7qFWHc52/QCPr7YO5eUTyfJgsyRmk3QPfTXL/pKf0wB8DSdk9Huh76BaeCYXNtFjwYF5QvMYKMUKxOkpE9jYmq+lSDGIbQGa3NondYml3ykbUQaqcQYP70tZchaRemshUhHXtnokuGaeP31F2rQyJYEQ4qlpPgMnxl08cFxJJ/fyUbZMnggwm1rTf4yCJ8iPT7J3hp1sbL6C8nrB7f7QlpA3admQZbBrYmnHGK3v8lcQ1K1gQBIbLaiF2u5XGmfR5E7kMLFIYbgzcvQC67nD0BCW7ChQHZ4B3naYxu65Cf+eXw32p7qmcUC14pEkDqrW5qTa4S1hNnadShGqd9AClRLelRbNZErFBGwQU69nLMI+v+357bpokDPny+KJFvqIggfeROPGtQNEMHnqd+G7i7udunQm/IZmCdRZoB9AGGM1mFIMAfXMwTvJy/1nrFT7rIOMdZqbB+mFTvxgXhlv9cTQTBBiPbsSRRk3cvvL0ra2PQPzLhSiFwk5Z9I8Ix6c7FN2iPX4iOIJRoB4C8K4XrlcAXPHPt7a+3gvoCquNBNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199024)(1800799009)(186009)(38100700002)(8676002)(4326008)(8936002)(31696002)(41300700001)(53546011)(6486002)(6506007)(316002)(6666004)(36756003)(66476007)(66556008)(66946007)(86362001)(6512007)(26005)(478600001)(83380400001)(7416002)(31686004)(2906002)(2616005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzdMSDJQOVpwcHB6ZXUwcWtTNGVzR0NDcHg3NHNpZ2hvaFBjeGxYTHBUSWly?=
 =?utf-8?B?Z0p3SjJncVFwYnRJVjA0M0o3d2VrNk1BbmV1ekdtbGUyMXYrSlNFTDg5ME5m?=
 =?utf-8?B?d1hJaHVtaGQ1by9jaDJzekp4czUxMTdPZitOd0M5MzBvWXhneDNubVZGQm1h?=
 =?utf-8?B?RzEwQ0NSK3VGekVHTSs0VGRWNndqZGloUVhrbTRDWjk3YkN6d1dWQkM2Kzd0?=
 =?utf-8?B?ZDZwaEdIZlYzMFhLT2gzZUFTYUVEeWJZMS8rRmNoK2RtYVZCdlB3aFFwblBP?=
 =?utf-8?B?cnBpaXZnK3liL2xxVENNYnBJN2duTm9iU1R5U0wwYVBRZnJjMk9hUzJIQ0dy?=
 =?utf-8?B?M1ZlNys1dGtldXVaWDVUUzFrZWJkblFxTzJhaWJsN1haM0NiVGRtLzBLUnV2?=
 =?utf-8?B?K2RYanNBODFOM0QxTjhpSEVobnVubkh3QUN4aTBJVEExWmdTWnU4T1VJd2JR?=
 =?utf-8?B?V3RBM3RSZmFDRUNrL29pWTVmUTh6VTYrbDBTdC9aMU5RSHFja1F2eEo1Ulpo?=
 =?utf-8?B?V011N1BNWktVdm5VK2NySzF6Ri9YTGJtRnpxdVBZSTl0cVN6cEpxU0pwQWxH?=
 =?utf-8?B?TG0rcW5QdkpvSnF4OVl1bnA3K0hwUWpSRloxZ2ZrOWlWQTcxK0xneThXeEVO?=
 =?utf-8?B?UmpPaVZHbDh2VVBUd3E1eFFqeDVyMG5pZEk5QXN5NHd0ZTVBTzNWVUF2MDY5?=
 =?utf-8?B?QXJjK1A2ZWtDeEEwdFhWYjFZMTg1UGY3WXg2MExRRVhwOS9STVduZXZ0eFZs?=
 =?utf-8?B?bUM0UVk5THB6c0lOVk9RR1NmYTN3VnNnUkFkRHp6dXJ0UFR3UG1pV2o5dVkz?=
 =?utf-8?B?a29oSUo3RUtmK0d4MUY3aW1ReWdIOGFDaTVEVU1UNXg3bys3bytvcCtJdHhM?=
 =?utf-8?B?dTczbVdXaEszNWZDNVkxeUFxWmY2eklZTVcvVlZ2Q3d6VTFwQU01RG9sbDJr?=
 =?utf-8?B?d0hCaFZ0Q3hxblZoT296OElUZW1XZnNPVjZmTnpJdVlLN0hGWTBZNXhWc1FK?=
 =?utf-8?B?eTh0aWR0aVVuWlRrWmVYZVZ5d0hGUlBLMkNJK0VoOGFYakdmOEZLTEQ3aGhi?=
 =?utf-8?B?aG5FNVVvdGtDMkQ5NHpYRThCQjk3VnFKNis4Qkx1ckxMVGdvMUFkNm5pSGNw?=
 =?utf-8?B?ZnU0bml0cytsNHpZL2NKZVJMcjdxWWV0aUF2Y0VFdWI3Z1Bna2I3ZWhWeUJ5?=
 =?utf-8?B?b0plK3NtNExPUDNjSzNWUDFvbmd5cXlJUDdrcGJ2eWxkbGkvRm1ZaXdMaEFP?=
 =?utf-8?B?Nmh5Y01SKytCZVJCa3MrK1BEU0c4cnVaUGRxUFdQVUZHK1l2WUZFb2w0SWlk?=
 =?utf-8?B?cW80S0NtNkI4TFdhUjBaNDdZbUVyQ0RVbDYyZmZFQ2NQWFdmd0lNWmJtQ3FY?=
 =?utf-8?B?VUlTalBCMG96QStwc2N0YWxjNGVIL0hLZ0ExcnEyMktCakFzMzVMbU44bzZy?=
 =?utf-8?B?bVB5WWRQOExTaXFEKzZMZ2VmbFBNa3JQQlViRHlmK0lDajJoMjdGc25EeUpy?=
 =?utf-8?B?V1hiUXpjSnNnM2x4WDYva2RSMXV3RnlYMHpxNndWdGtoTzMvTTFiRHBZeGxJ?=
 =?utf-8?B?cXdobGZUNkcrY3phWWtKaEc2QkkvUi9ZeGF3OFV1NmJobmJqZUxwNzZEM3RT?=
 =?utf-8?B?aGlONG0xaDgwWnJ1RzkwRWFqenl1clh0d2FrQ0xydjJ6RFNzL2JpclF6M2tk?=
 =?utf-8?B?OC9tUHR5WjJxb0RBT240dndBTUhsd3hDS2UvQnpTdUJrSDYyS2J0MHJZcWpz?=
 =?utf-8?B?SENqd1I3YjY2S0psdGdqMnU3dHo5d0YwdkRTbFhYNEVtYm5CampCOGIyYzR0?=
 =?utf-8?B?MXdMc0RWSXIxOGN6SDRNSXR4MlBjcjVGUUxvZHVsckUrRUFhaHpCRk9ydXc5?=
 =?utf-8?B?ekNvM1YwcHZZZHpJM0t0OVdWNmhBcDl6WVd5V0JvQVVsQ3RFT2JIRm56YWtL?=
 =?utf-8?B?S0NLR2JabzU0Z0NKQ0F2R3I0cW8zOFZPUzQvV3AwalNzMUpXcWJGcmY1UlJp?=
 =?utf-8?B?MEdTN2ppS3NKUXhrTW9rbzl0VFZ6d1VxajNqdnhrbE5BNWVYdVVqMmNGVU83?=
 =?utf-8?B?b2NQeTRycFhsbmRhRnFIdlQzbkN1MXlDMXVONUhpeCtnN0RnUzRHZGtvVzNB?=
 =?utf-8?Q?bcOwgW7bT46ltD+wlumhvPQ/n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52439646-4622-4b99-d764-08dba5250485
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 04:37:41.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3re7enoqvyhCap+y6sHUmRQ0Uz/eamBi9Kn3pgP28q0GzCYxhbmC5ge9G5A00uGrVCtKXu/FsUCRKnzG1Inuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/2023 9:06 PM, Florent Revest wrote:
> I checked with the original author, the mmap_FIXED test case wasn't
> properly tested and fails. Currently, it maps two consecutive (non
> overlapping) pages and expects the second mapping to be denied by MDWE
> but these two pages have nothing to do with each other so MDWE is
> actually out of the picture here.
> 
> What the test actually intended to do was to remap a virtual address
> using MAP_FIXED. However, this operation unmaps the existing mapping and
> creates a new one so the va is backed by a new page and MDWE is again
> out of the picture, all remappings should succeed.
> 
> This patch keeps the test case to make it clear that this situation is
> expected to work.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-execute")
> ---
>   tools/testing/selftests/mm/mdwe_test.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> index d0954c657feb..91aa9c3099e7 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -168,13 +168,10 @@ TEST_F(mdwe, mmap_FIXED)
>   	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
>   	ASSERT_NE(self->p, MAP_FAILED);
>   
> -	p = mmap(self->p + self->size, self->size, PROT_READ | PROT_EXEC,
> +	/* MAP_FIXED unmaps the existing page before mapping which is allowed */
> +	p = mmap(self->p, self->size, PROT_READ | PROT_EXEC,
>   		 self->flags | MAP_FIXED, 0, 0);
> -	if (variant->enabled) {
> -		EXPECT_EQ(p, MAP_FAILED);
> -	} else {
> -		EXPECT_EQ(p, self->p);
> -	}
> +	EXPECT_EQ(p, self->p);

Tested this patch on EPYC x86 platform and fixes the testcase.
Thanks for this patch!!

Tested-by: Ayush Jain <ayush.jain3@amd.com>

>   }
>   
>   TEST_F(mdwe, arm64_BTI)

