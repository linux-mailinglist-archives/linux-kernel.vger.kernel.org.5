Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85F37FA3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjK0PAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjK0PAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:00:15 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2083.outbound.protection.outlook.com [40.107.104.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62262D6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 07:00:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFOT0IVIqdWAGgZq2Ev0yAB/MGv2jseL8dLKPEwRiMKmk6yKLcTroRE27nd+d9O5VVFpa/To5ReVpadhL/MJKWmWquJJtApDQ138ldZ8LvT8/uTXQ/HekSMDFVxIOLKaFVLL3WWUGxaX3v5AS3aqtREybw6hUp0fG75G1DOYM6J6pK0vJYZki62yXTbN5qtGpE1f3r9yqFVjErcXR8K3WcJZ+EZ8OFtJAz9XT98Yvb0fEC7AP1TiqpXEl1uEYCPBrxJHYluS4Rcj/x6GiHDTKfvWtGezoQd713oqlN4YueQzlYcku2XjIKFrI907h6GpwTVCTeyiGF+Fa6DnpnfsOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct7P1ZefeVRNmwR3+WVJwm8Vyg0MFXdJNKq8bsClr84=;
 b=e0YzO76KKeW3Wr7ONHBY7vBPm+utWGnFUdH9nPtCfKTOjCfHK2EIuMGVAW6GHQON39G4tCa7aFVb43ZOhUylfrwtQqoQdBR0Wucl2XiQbqKOSqRULt4MdGiWPY6Nd6q93fEZtxXGdfdaaRYHdy73XLmq89+NZTbnL2EbgVZioMd90CLkS1e7hW5cXHpIYMMYavV18rRYfYJfJs8uPePtSeb1SPOxgo6cq30sNfJy5JJmXWNf8w5ak2ga2PVikPjBGCapRY+S7Hbfx/mnMKoO/4YX3G7nad1oAsOIgBFgNI2TBITbWabM35JhshlJcn+5nu9d4elh2qHElUqw7G+2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct7P1ZefeVRNmwR3+WVJwm8Vyg0MFXdJNKq8bsClr84=;
 b=p1MjDzkSRvwFTahH2H96k5N/fpsFi4RTRf70Jsc9k3f9XWSj3lOo8GYR51x3cZ/87qJWoHYxBwNI+3ivrMbZ/xZjYTTheKg+ywbscnU7TiQ5+KUFy057hPvNGthDrcHkb7JpLbf/FDQ6mmSJLscYt1+kPfFLN+J+MohsKrGGCrnIlvCbPu4kx7NZHL7bFulHdFRlaT/UskkvR/uA9Hma5DPn4HnpAVyZeyfvcmuwTqkHx0YkW3VTnpsvu7YyXByHKHL4GUB0HAFw4kt5d7ObII4HkvJDu0Mg5BycMfIsFktMsL3MeEHnet+XFOGPy64Ju1zAvVYtDkDxPu1txPH/lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com (2603:10a6:10:2e1::23)
 by DBBPR04MB7849.eurprd04.prod.outlook.com (2603:10a6:10:1eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Mon, 27 Nov
 2023 15:00:18 +0000
Received: from DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::eb8e:fa24:44c1:5d44]) by DU2PR04MB8790.eurprd04.prod.outlook.com
 ([fe80::eb8e:fa24:44c1:5d44%3]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 15:00:18 +0000
Message-ID: <1b2da249-254d-4879-aa16-9ea7f39d1259@suse.com>
Date:   Mon, 27 Nov 2023 16:00:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/xen: fix percpu vcpu_info allocation
Content-Language: en-US
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
References: <20231124074852.25161-1-jgross@suse.com>
 <69ba2a99-90f7-4d39-afc6-971b0867a1c8@oracle.com>
From:   Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <69ba2a99-90f7-4d39-afc6-971b0867a1c8@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0114.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::6) To DU2PR04MB8790.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8790:EE_|DBBPR04MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e24329-d377-46a3-d098-08dbef5991c9
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idaUIww6wBycVJ7b/XAEO/FT6++U0Qd5Ir0tijwDk2TKa5oRyMuD9Y8NBEFFTNplxvK1zTcgoVhmqYY7ynuZBuSA417l7SrgDk/VyWrC4WABkAl5gHR3j1wLLBwtw50jiMP0fkjoZH9gvIc6Fy4HztPXV6ObmSCaEV81Y9R74dI+sRmI+4eD8gVVV90KTo4umhtEuTruk6Cte0USRwOBcOrSOXeT4U3kqLsezMvDJUc+p9eFyMCsTLya2NUFLstomnmthKl2sjTxttUOPHJgiBYCIXqYTJ+J5WTLYAiLUcioVn0WM4GhvgJOHk55wA4rLlSyOMCz24wu3TEwnQWjB0Oozzd6FELuyA1XEq7jb/EKcorE8mMzNBcOxDtBhm1554jK8N3bqkMQWAy0nPjjE7QXlweWG4I8IZoaSxe7F3S6+8um+6LvR78rfZDXL2td+p70jcedgdXtvTUHbUNyIldcFxmDnA2mzapxOkLP6pIa4jSMsiubmAktWUr6nPeHQ2ME0rq2U8wrxIYLiEnDG58JtFPAkxuA8sxU9pGR04Zrqqa/44Z9t7A4K/o6zetfEq26JtSBh+94vzVyFWN55XR2fiyfXZgPyDMAXchC0kVe9wEMCmoLSdXKyK1aXxGhQVopinU9gTasL5LVIRCJmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(31686004)(4326008)(8936002)(53546011)(6512007)(6506007)(8676002)(66556008)(66476007)(66946007)(54906003)(316002)(31696002)(5660300002)(6486002)(86362001)(478600001)(41300700001)(2906002)(36756003)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clRmdXlwOTM0R05UVjZpMDhCaXpQbWNBSnBmVzhramE3emlNM2VNR0VFTTFx?=
 =?utf-8?B?bUZyK2lxTHcwN0w2T1hsWHZXRS95VU03ODAvQWU4WUNLSjlDYnFOTTBzTnRk?=
 =?utf-8?B?aGtEU3JnU3hDQ1RGc01tYi9XZEJSYWVJRGdwZDZ6Sk50OFhvWXpHVVFER0dQ?=
 =?utf-8?B?VnJ4NjVIU1M0S1ZSdU5DSGN2WWE3N0x4bWROcEZXK0lqQWJEb0RLaHQwMW96?=
 =?utf-8?B?a3pQY0JuVlhuYmlkcDZ6ZjZudHFOVVZZa1FGNXVXc3NtWnJ4cjA0RWhsanVE?=
 =?utf-8?B?Q25kV25WUHpnOUY4Unh1QUlrdENEMkh1RHV3TjV0SUFJQUpyMXRvaDNGS3Ey?=
 =?utf-8?B?THV1MXAwL3ZsN3dNUi93N0RSRHRzTzdVbDZOMzJBbzhBeko3b1RpVG5VRHls?=
 =?utf-8?B?N1A0WWtldnQ1dDc5b2ZUUFMxVldYODZtY09pK0pLVC9aay9wdEJxT0FzNWRD?=
 =?utf-8?B?UnBFT04wNVRlcjFlQXlDOVc0Q3RIeGZFSEl4a2dLYkh3eFRpUzlMRURZdlVX?=
 =?utf-8?B?RGtEbjFuakxwM0Y0V1ZES3RoblBLRnZ2L0xKY3Z2dy84K2VRY0RaTHZMeS84?=
 =?utf-8?B?VWdMYks0VkhWeHhDSkE0Q1hTKytzOHpvT0NnT09adGd1cnQ0QjBpOEgvT0h4?=
 =?utf-8?B?VnVTOGhNTzM2NGgzcXRKT0VzUm5QSmppRy9qZCtESENPRjZzUFRHS2gyOXky?=
 =?utf-8?B?MWRDQ0VGR2NlbjZRVGI3WGZZdndXcXRmSFFQVUhhOUVMNGxkN2M2RHV6K3NR?=
 =?utf-8?B?SnNNeTJlRmJVNUQzcit5cTgweDZUdUJqNitKYU1kR3l6ckUxbDVKZk9NTWcw?=
 =?utf-8?B?d0RpNTFmODV3dHRBRWRwaENXYTc5d29KRVFKeXlueUhyWng1dnNHYm1ReFRF?=
 =?utf-8?B?QWtLSEZqUjgzaXE5UGtPY3ZJRXFtVzVNeDJtMnhzNlJoOFZocTRjT240cnh6?=
 =?utf-8?B?SWNKM2lDMFpoNmRtWFZWS3Q3QlNIaElseXFQZHVvWFAxOStJU0JPNWRjSmRG?=
 =?utf-8?B?Zm5saE9wMFg3LzNheHQvbGphNEw1clN0dXlKaXorc281cHFXczlXQWVxaTVX?=
 =?utf-8?B?ZzRRZTZKeHpoZW9NRktiRUJEYmIzQXNMeEtFOUxoV0RITEJwRFpwSkFXWFIy?=
 =?utf-8?B?STdyMVlmd3JIamxsMmxyVm4yN1dGVEUwaWtobDZjbGRBc1IvSmZ2MGIxTlYw?=
 =?utf-8?B?UUk2RnFxckZKdkJMM0ZMa3ZYc09udmZKMThnV1pSZGtpWFBlVVNoL25ZUmVO?=
 =?utf-8?B?M1pwdURIT0FtOHZLYTROSkxnRWVSMVF0OENOeTBhVFR3QzljY1RGQUtKeG1x?=
 =?utf-8?B?RUdQOHpIUm16M0UvaDlUWUt1cFpNTFlNbk5iZ1lDVmU5Q3JRckN2VlR3SGRJ?=
 =?utf-8?B?U0dlVEJJOStNWVczSCtsWDhkQTRTVWxQbkZmUWxRY051eVArb0lYWnA3YURX?=
 =?utf-8?B?dWtVQ1dnUHlYemtqK0xodzJnNEtsbnRrdTFlSEYvanJXOU01V29jMlJOQnRy?=
 =?utf-8?B?b2wrYWtPZzE5NG1odjRsY3hZeFBJUThjeFYzTHI2MWtZNGh3c0kzRTBSTzM2?=
 =?utf-8?B?V0hFQ29DdHNHNlk5S1ZMR3gvbVd1SUgrcGtQeThwaGh6dElKcHg3OHRYZm1i?=
 =?utf-8?B?REJyY3ZRLzExWjVFQ1Z0U1ZJNTF1dERtQ1AwQ2U4a3dVY2NVZEgybktUU3Az?=
 =?utf-8?B?OFMyazIxWGcvVC9KNHBZT3B2U0NxNXlDVU9idERvYTFFT2lvYXFHaERSbDFV?=
 =?utf-8?B?TmsyNzBUWk9zeEViNWpaWCtDeUpVMTJjREdrNGdSaXFVaUM2MG5yNFdVNTQ5?=
 =?utf-8?B?ZFZ1QTkvNjBURDMxV1YwZUVBdzZhVElwNXNqZWI4QzlJc3AwWmdOOVNLNVV0?=
 =?utf-8?B?OTk0WURua05GeUczZVdKcm5jOUtVZjQrNGxteStVeXdUbTdiRTBvSDhTMmth?=
 =?utf-8?B?cUFxcThHQnd2cHRGR1dDbjF5SEpoZ3ovM3ZBL2szRngrZjk1U2IrRUYvYStR?=
 =?utf-8?B?SVR2eVNPTnNKaUdsdXVLVHE3TEhvQm53bVc3d2E2VlYxZTdvR3g4M0M2SU9N?=
 =?utf-8?B?TTluQUUwMmdsaWFLc01KbFRrTW13dUZLSE1tckVkNTBUVUdWMjZPOFZQbnh0?=
 =?utf-8?Q?6rccZaksS6k/RVbvThCm65GtO?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e24329-d377-46a3-d098-08dbef5991c9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 15:00:18.1426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LV4K3R1ixdv/lpZ77Jk6jlmwEfmQ0y/XJ8GzLKS0rZ53AmImhK438r8nhEFWEB3baDFreYLvJsDaiYKAvrXYVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.11.2023 15:57, Boris Ostrovsky wrote:
> 
> 
> On 11/24/23 2:48 AM, Juergen Gross wrote:
>> Today the percpu struct vcpu_info is allocated via DEFINE_PER_CPU(),
>> meaning that it could cross a page boundary. In this case registering
>> it with the hypervisor will fail, resulting in a panic().
>>
>> This can easily be fixed by using DEFINE_PER_CPU_ALIGNED() instead,
>> as struct vcpu_info is guaranteed to have a size of 64 bytes, matching
>> the cache line size of x86 64-bit processors (Xen doesn't support
>> 32-bit processors).
>>
>> Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
>> Signed-off-by: Juergen Gross <jgross@suse.com>
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.con>
> 
> although I am not sure in usefulness of BUILD_BUG_ON --- 64 bytes is part of ABI and hypervisor already has its own BUILD_BUG_ON for this.

I understood the check to guard against SMP_CACHE_BYTES < 64.

Jan

>> @@ -160,6 +163,7 @@ void xen_vcpu_setup(int cpu)
>>   	int err;
>>   	struct vcpu_info *vcpup;
>>   
>> +	BUILD_BUG_ON(sizeof(*vcpup) > SMP_CACHE_BYTES);
>>   	BUG_ON(HYPERVISOR_shared_info == &xen_dummy_shared_info);
> 

