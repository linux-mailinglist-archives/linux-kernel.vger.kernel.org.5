Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B1A7F97E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjK0DSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0DSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:18:34 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2115.outbound.protection.outlook.com [40.107.93.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8C48F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:18:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dluHFEe55y72Or6nzF2XKXZ0fXXGbMKkmwvPGDXo9e/AlKpmd4vGwCyBhhwV5cO+wENN1dvPh9RVCj5K7q7JQpW9rH6m5RmTGT9CEid6tmlWffjaM4Kn5jjRAlJz08Biv2coKuNSVHOR/fqWJ3lTbbn5ew5N/VqQwU0lTWnCVu5ETrfFsU5qzXr97v3jZdgmtgnqUhwI3sPq0wktsuyYPN1w6xUR6rmY+kaLmC1VVjO+mCFqseQBEIXsx4lmgdKcJRVh1S16dacOpia7ILGTo+2bWGTr+CrkMITCnmHYKsQ+cDj6JhRTfDjdQOdS3WLSaigxdclibU3MdL2TRqicYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7oVf8Xoi1MeZkZ5tEksIAnZJ80pxGxaBu7w1/Y4JoYQ=;
 b=KBKCRR5bmlwi5GD00ribxNO5sTfOnHY3Q0fv5REJVHF4kLVMNcHdYRJRWrs+YMf0AcgdLvoxPNWtBBuQ2x5QMuMoJe9WTaMDPqVQF6sQ3z/uDnhQyNZtRuY6bChUaDtetu3EN/w5nCWVc2Mfa3uLnp0K+XOaGKrLFkLfjAAhbLBAVlOzb5bnlcCzCZEUjyUaAyCgwqdLTurlzd+ssPj+TDCxzhfVK3JsYXe2fRQOVV6idagV79SjTb97evpbrm0qcRUdTp4L5NbjgCJjHmRCB4v1jjNudQ+A1z2U2QjzNTc3KrOh61vtk2cB+UAeOuicZpPx0kxE5qDjji7/w7kPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oVf8Xoi1MeZkZ5tEksIAnZJ80pxGxaBu7w1/Y4JoYQ=;
 b=lF1GkQMLJMSVBySuEAVvvBw9uHA6+NSZ8S8Dz6D35aPKhJM295nZPokei57KY6aasK4MX916N20jyt4RarizX32jDRyG1FsQ5Ip3G9v8zL0CFNPuAKKRM6t4xeUOxb5Z8C/mJ9UbEh3VUUwiWyZtPrOzJb04p+znYwwvUuoCZ1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 SJ2PR01MB8370.prod.exchangelabs.com (2603:10b6:a03:540::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.27; Mon, 27 Nov 2023 03:18:35 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::3f45:6905:e017:3b77%7]) with mapi id 15.20.7025.020; Mon, 27 Nov 2023
 03:18:35 +0000
Message-ID: <33021b87-4c6a-45fc-a6ae-265765cfcd78@amperemail.onmicrosoft.com>
Date:   Mon, 27 Nov 2023 11:18:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash_core: export vmemmap when CONFIG_SPARSEMEM_VMEMMAP
 is enabled
To:     Baoquan He <bhe@redhat.com>,
        Huang Shijie <shijie@os.amperecomputing.com>
Cc:     k-hagio-ab@nec.com, lijiang@redhat.com, akpm@linux-foundation.org,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, patches@amperecomputing.com
References: <20231127020727.25296-1-shijie@os.amperecomputing.com>
 <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
From:   Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <ZWQEP4SczFh+GUHq@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::14) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|SJ2PR01MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 463c7504-3622-479d-189d-08dbeef78a4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29eWMchkudghPEU8ugv+D99KbzRPACwgjePN0oJFz5uXNgI1OmuXkygIdIFqKor0PXhGwNesAQ1RI2QbB90lImnt8Uu6BkTaO92+VnTj2MyDslpHzosD6iB1unaq6nbNmUyIXnOQOHUrbjHVpq9rvLPa4azX03BMYRRK+oFxmGSyOEmqdj1d6nLASpFscTT/1JtPlgLk+V9KMb12HpRosfUxUiEBH2sQ1A33Z+R2Q45vPqUcJ+QMbSF84ZkaQtLl4PrtwtowmtQds5hHsXHHvPfwjzRvym3NKQewj2b0TD8C8w83QtgMex1Hq10aV4L/krtmk//TeyJujsDanJHUmSIbS3eYOeiCm9cttWAA0GG+eVTy5qQdzkpRM3RdBij/KZkQJtlfMOz8rhXxoFwNi8xete4bq41rRPHvTXh48mzkmmcEg3dxPHAZFKXX3y2ZCZmc0rI3v+ZWRgm8/pzWh63Hn5uOeQmaW7xXOrwC16lMPp0C7QHd6+nSn2R3C1L5DzOfTUtRxknqdloufCuFEAICbhbBn+LPJ+93V23zxwe7e71g0muMx33i3QVo/1TM0VLiiXy7HH4UcDkd5/pgUIgumW7kVYxaEMpMWkmUtqxXjHauqOBuVFeLrxE78uzS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(31686004)(26005)(6486002)(2616005)(6506007)(107886003)(6666004)(478600001)(6512007)(83170400001)(38100700002)(31696002)(5660300002)(41300700001)(2906002)(66946007)(42882007)(110136005)(66556008)(316002)(66476007)(4326008)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk9YNkFBSktGUzRRWmdkSis1eW9VQTlZRVhxRlpnZkY2cUlKM3M4REk2eUdr?=
 =?utf-8?B?RXFkV2o1dTRPNGpDcXE3Q1M3ZDdCamdYVWphdkpaUjl3bGV3WWdIbllnY1ZX?=
 =?utf-8?B?cWdRazU2bmE1TWJhNmhqb3h1R0VzbHlXTk41WHRhaDhxV3BhemtxZUErdTdk?=
 =?utf-8?B?SGMrU3lKeEJBMlhqRzFDaWV4ampYell0Q0hJMytaWlVxdUUzc1hkc1pmQzFP?=
 =?utf-8?B?VUFoR3lEVmNReFkwaE4vOW15MlhSa0xORUd0clZUUTkyNjBjbVB5QzBDOW9H?=
 =?utf-8?B?bk1lRDJnUWtLVE5mTFVxckdqQmh6MDFPb1YrTnA1Y0tqZjJJdHRVS1grUjlL?=
 =?utf-8?B?NWNXYkRybHhjWFUxbHZEdGpFZHVCSmVQWlFYVTgzeHVyQXMrcFB5Nk9IcUEy?=
 =?utf-8?B?VzlpWGJ0MkY2YVdvWWxiQkJ2Qys0NHJVRHFtS3o0Q00zZisrVThMT25Ia2N3?=
 =?utf-8?B?dVBaaFlaOWJUdGdIMTEweFFrVzExQzhMZXZ3eFRGS3ZZQjlRRG1KclpvVTZC?=
 =?utf-8?B?RUhUbUJpa0xMWU5uRlpvTklyZXVzS3MwV3U3UVNIQ3RicXRqZUFiSDR3a1pK?=
 =?utf-8?B?aEgwMlVzQ2VSbHFCQjY5UGpLYW90SE9rQ2ljSDAzUEN5MDBMT3NDbEE0OHlN?=
 =?utf-8?B?K29ENUlaaG5FRGw2b2lGeTBPcnRqOFJnMlhObnAyZ1RnajE0cEpsZTN4RVl5?=
 =?utf-8?B?UVZIQ3R0NFhHSG9uSUhEOEJ5c1BDdi9yY2RMcVNVcUlycFk1d0xmOG5aWk9R?=
 =?utf-8?B?RDVVSzVZcVI2R0NiNDVxQ2wzbVR4emE3MEUwdUtoT0ZNbnpETmYwQ1BQRUp0?=
 =?utf-8?B?Y2NaZklwdXBYT21lS25yb1cxQ0t3QmxrOVlLT2xEYjMyaDBwSnA1aXRzM09X?=
 =?utf-8?B?R3RNSDR4WkttajVoQ0ZXSWFvSmUxRkRGemk2bjV4UzFSR01vYVJ3NEZLOS9x?=
 =?utf-8?B?LzZDVVYralNnUVNMcTVObml5bk9vMm4wM25pQ2QzODA0TjJhTGY5M1c2WjZH?=
 =?utf-8?B?MVhiUTdRdXNBOVFURWo5b1pjbzBVd0ZkNy9zUk1reUlkY3hFU3g3SzNybDZu?=
 =?utf-8?B?TlgzVjVKNW9XOXVxcWpZVlJqa0pIWDdEcE1kQ0hwNUhrSVlHUlJkZlFKMzMz?=
 =?utf-8?B?QWtDR1A4bzAwWVZURFZIZHBlbWYwaTBESzJYVGZBaWphdWRGdUFNdklDQXZB?=
 =?utf-8?B?RTFrQjZGRzYvWS8xRUdlZjFYcmFXbXducXJzL0w4K0hic3Z4SmhtR1ZCVTFE?=
 =?utf-8?B?R3VoRjRValNsTW5aSTIra3I3RUNFdjZabWJpR0owMzlJUWYyUFpUcHl4aEw2?=
 =?utf-8?B?UnhhN0tkd2lSbm0xVE4wTHFIMjV4K3pETCtVRlpHbWVad1BXTmxpOFhyZ3pn?=
 =?utf-8?B?WWZpSlNrSEk4S3gvV0lzT2RIaWRwTkR0UWhyMHcwdmxrVFJ2SDByU0NsV0NZ?=
 =?utf-8?B?SGt3QlZmYjRISHBVekZxM0dzbWQ3b0ZFaTRsUmhvYmdCdlZIQStXb3ZLWjhh?=
 =?utf-8?B?bTlXVnU4UTFFUVpHU09LTnJhaFp3Vjh2TjQ3a2VFN1A2VEc3Uk9RRjZjVW5S?=
 =?utf-8?B?WU9OWGdvRUEzOStDMFJ4WGlWUnoyS1VFY1Q1L2JMU0FVTEg4ZjJ2WlV3NFpn?=
 =?utf-8?B?Y1dmb203VFZZcGhVbXBnTlpab01QeTBRSlhocCs3M2swS0NTbFdSUVlUcTZq?=
 =?utf-8?B?MEpuR1R2RTdKSGo2cXZjNU1hNE5DMUVTbTR4NXJjQnBPdHNIVEZ5SytRYzNH?=
 =?utf-8?B?Y3oxc1ByLzdxTStRU3pqdUhsRFVzLzJBeldwVWZhWi9qR2dtUTVJbW9ERkFB?=
 =?utf-8?B?bDdISUx2WnIzWTgrenluN25lbUw1SWhDdktCUzNZdkx2WklONWJVTUt1dXV1?=
 =?utf-8?B?dmVTamtHVFh1eno5K1ZpYnYxNHI0dWNXUC91SkI2REZ1RXhoUWorOGJ4ck8r?=
 =?utf-8?B?Q3VoaWJhcnJFYzh0N1N3QmQwemNzcGNvUENQY3Arb3Zld1ZFWnZxM05jZFRr?=
 =?utf-8?B?QW5ob3Q4bERZR3A1VTV2Tlh2S1RDSDhHRGdtZFhDbW5kNlErU3ZiL2xJY2lx?=
 =?utf-8?B?NGJybTVRQU10N0ZqMk1kYTU3VkFtMXZTKzU3TnRYckJXUVRaVzVVTkliVjRI?=
 =?utf-8?B?b2U0UndBalU5SjBNVVlQRGxSeC9uRVIzOHJwbTZ2L3ROVTZkUWVDaGRpZ0Iv?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463c7504-3622-479d-189d-08dbeef78a4a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 03:18:35.0999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7QEc3/P18E/akTgACmpIpSm+HIRagQYjUnVRRbuW4rmoDOAe0fFZzMGfc7I7hDra0ky3zR6l5w8NWTkNVloSkvdNXp76tbEYUf2U5pPZ+QbP9oMRcIQjRvhrcxMN6Tc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8370
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/11/27 10:51, Baoquan He 写道:
> Hi,
>
> On 11/27/23 at 10:07am, Huang Shijie wrote:
>> In memory_model.h, if CONFIG_SPARSEMEM_VMEMMAP is configed,
>> kernel will use vmemmap to do the __pfn_to_page/page_to_pfn,
>> and kernel will not use the "classic sparse" to do the
>> __pfn_to_page/page_to_pfn.
>>
>> So export the vmemmap when CONFIG_SPARSEMEM_VMEMMAP is configed.
>> This makes the user applications (crash, etc) get faster
>> pfn_to_page/page_to_pfn operations too.
> Are there Crash or makedupfile patches posted yet to make use of this?

I have patches for Crash to use the 'vmemmap', but after this patch is 
merged, I will send it out.

(I think Kazu will not merge a crash patch which depends on a kernel 
patch which is not merged.)


Thanks

Huang Shijie


>> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
>> ---
>>   kernel/crash_core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index efe87d501c8c..9653c4177191 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -765,6 +765,9 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   	VMCOREINFO_SYMBOL(mem_map);
>>   	VMCOREINFO_SYMBOL(contig_page_data);
>>   #endif
>> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>> +	VMCOREINFO_SYMBOL_ARRAY(vmemmap);
>> +#endif
>>   #ifdef CONFIG_SPARSEMEM
>>   	VMCOREINFO_SYMBOL_ARRAY(mem_section);
>>   	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
>> -- 
>> 2.40.1
>>
