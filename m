Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D32808A6C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443368AbjLGOXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443271AbjLGOX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:23:29 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1FE26A2;
        Thu,  7 Dec 2023 06:21:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Owegfm9G7RNm8SYETb2NJRKpOdHh2P60vNM1+Qml6DYs78/wRPvz6S7BWupq4oIrFxQpinJ8M8h1fPeacaM8nU8iV8GZu0JKfOGp6HoE7IgBr7fwRthHDPZsfaQKnPLQxUYbDKDbq+zEqASwSdQ40sa0FG6DhM4Z3hwWe3w+kjS0f3wBLvMKS891fg/gxZtugv9+oczUOhxvVi7u+uZtz99AMELKHRwhMDTr7EM0FeyU4WLF3WgRyGkvkmvEdDRs41sq703IiXWLWmEL1WiSSYIHLcCo/1JoamYN9PKa6/9m3Ann19bHPx4RjR2jIl/A9z/2AXYQ4szq3GzghiVXsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3jVE5aniqmQYRZf9bOsgHZr1wyu3wH4STP082+kz5s=;
 b=LgP5TJU+2IQnNi69NuANENh+TKXFz8/0KFyUxOyRJlJfDa6xLpxTBTuVjYRzjW5TbazS96jh/g38lZ3P8geXKjeKnySZ1Rln9y+lSVKlxibIgtxkfvVLgGB+j/0aZg5aTWCUjmytmnfdSgzWHpgVkxjoj1CURmL1zWDzb9/fXFD8hCbfh/yfK0GLA6lln0wNRCdJ+pGv5LO8huEDpzzsorXa52iWfHKkJIlVVU/mpskXiKT4f1QlZFhBN3FcTUQgZTpw1f1JEHmsQj+QXqR3ofMxmm3/AMqDvhrWJJT1ENv1prB5EYN/uD/Lt8fWQCOZMwav4KIh5oEUu2EAaz4E6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3jVE5aniqmQYRZf9bOsgHZr1wyu3wH4STP082+kz5s=;
 b=l5VCW/TwprtBBd+uFF4LFaTb973pu01KIkR7hKZ2mvd47/JCtLqwOvcwlHl9NJmRsfEp/fuxo5htIJaMIjv2kEvqX2lNQTRzmMw5GYJG5+8YQomRqRQp0OyHql6whNsDRw8VXa6hIXloUGbtK4mSUMD807VyYFZsnUFUbHN9fqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 14:21:54 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::cd68:8823:38b3:65bc%3]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 14:21:54 +0000
Message-ID: <13272300-1d7e-92e8-020e-54d9cfd12ca7@amd.com>
Date:   Thu, 7 Dec 2023 19:51:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Ravi Bangoria <ravi.bangoria@amd.com>
Subject: Re: [PATCH 1/6] perf mem: Add mem_events into the supported perf_pmu
To:     kan.liang@linux.intel.com, acme@kernel.org, irogers@google.com,
        peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com, john.g.garry@oracle.com,
        will@kernel.org, james.clark@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, yuhaixin.yhx@linux.alibaba.com,
        renyu.zj@linux.alibaba.com, tmricht@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ravi Bangoria <ravi.bangoria@amd.com>
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
 <20231206201324.184059-2-kan.liang@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20231206201324.184059-2-kan.liang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::20) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: b5720a52-c6c5-4df6-4dc2-08dbf72fdcc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jC39ctvXyBcMRPyo7QaTl2DBJnFV7siNQvmCmLYn59wc8PL0HcweSmALLvfBEq8xFAWIE5xy14DfFR8RTjesSyZVuwi+hM20v8dhmTAEztG/S+B90eB1X4fd5tzETHoWDkTxRq3Yl+ZjplozcMdCJlSqIRD2wsl0L1J917mZoTAERqIlcEjK7vAJtD/PFCM5dt9XLLemWyXoX46ihWXkDNJhZGfOMcHtuL8D76vehJa/4+H1XL0j5qmHXXPz4N4bmBqGMB8hOJH3AwmDNem7eLlDXQQgXH9HWO3fq9gRn752NspJ5imda+wMroM5Rgsvw1xNzexW/Gaq564sDI+BElwb5xsON2VSAthCSAxx/Xu4oyRMkNaX/Em59GrUKfmWlBlnAs2VtAaaHDyAsRgLntjKi9PkGaetW78QVVrQj48Jeu6JALTHj7+C5q5orcnA3G2cOe0PB4gkr9bNgPLOvK5c9g5qqePy6LyNex94++9aQDaZ6ZeVMcL4Dnd6X205aYOkH74QmEm6ZtAWqyMZmgSntGgZZOD5DIuRQLazQfxoreHdgbdPv2lFcNJe4W45QGmcIeu3pNXDek87EhCrDMhuqQ3n+LhCcOOW7hhGHQqQ4iSgkLI3N92Z+kQrKGz1xhadISK/g8LaAsOyxR8jRDV/CahrgjvsUzNEdrWn2K8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6862004)(2906002)(8676002)(558084003)(6200100001)(31696002)(8936002)(44832011)(86362001)(7416002)(5660300002)(921008)(36756003)(41300700001)(6512007)(6506007)(6666004)(2616005)(26005)(38100700002)(31686004)(66556008)(66476007)(37006003)(316002)(66946007)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T09jR0lrMW1yVWd0ZmtabTBvVUphMHpXLzc5bldETHc5ajkzcXVJM2FSZlRu?=
 =?utf-8?B?UTdqSUUzdjlQRFRpVXRHTDBqVVh4Q3ljdWhEeDkzdkhoc1hvZlg5STlBQTR0?=
 =?utf-8?B?NzlvNE1kRENCbUQxTGk4NmFhWXFpbzRoREtzY0RmRGVZMHpIdnlyVDFEanNS?=
 =?utf-8?B?cVBiY3cyTFlmNmVSTDRvcW5oZHNxY1AwelZaNDhkTEVNZGZnNkhOb1RDQktm?=
 =?utf-8?B?WnVYMDU5SWJmSnhKZUkycUZaSStSa2lDNDdGVno4cm5rZ3I1R0x6N3poZjVs?=
 =?utf-8?B?UjV0Y0hjOXJpQnRvWE0rMDBQWGJqOVp6RnBsbmU2TGdFa04vT0ZFRmNDWmRm?=
 =?utf-8?B?NzN3cnJmZjV3cmswam40YUU5TUJGQlRrMUFERlNsQnltVFBiRlpHc3RxRUha?=
 =?utf-8?B?RWJHd0xaakM2OWsyU0NrYXJqczZHTGV1a2dSOE9KQ09tNmdWZlg3U3BiUVB2?=
 =?utf-8?B?ZUtnemJjTEg1Z1J1MW40WTU2VVEwRklHR3VYZUd3RHNZMVJBTEZoTTV4Rnky?=
 =?utf-8?B?UHduODNHc0JCeSt5T3RrU3pCclJvWUNudDB1UlVjellLYXEwaTVaa3ErN1Bv?=
 =?utf-8?B?Q0xPS2N1SzBsMUxmbk5aMWgveFRXQkt1eHNYQzROTGxTbXJIdTZaR29kWFpQ?=
 =?utf-8?B?OUFWVEt1bDBHOFFYUVVncExuempwVGFxU1dUTFlGbFhzVFVqYzU3L1NsMGJy?=
 =?utf-8?B?aXVITVl3OFdEUUhyUG1sTG5JaVJGdUR6RUxrcHo1RDltellRTUgrSTB4STNu?=
 =?utf-8?B?eWdtMGh5Y2llSWpxMEtqczNpRzhMNFpLeVJWYXhXbHFEakZWdWhDOTdPNzlM?=
 =?utf-8?B?bDlpOVhoYitlYUl0QTdFdUs4M3I1ZWxrSlBxWnRxTG1Xcmo5c21GZ3JWaWNZ?=
 =?utf-8?B?bE4zV3dCcSt5K0E1TUpLdW54eXhCWHZQUzFlMUwyS1kyd0hOMjVnaGhobThR?=
 =?utf-8?B?cmUvRG5nb0hJY1NNbTgrL1RnMGhBUGM1M3hqbmsvZDVidFFBczFreHpleGVp?=
 =?utf-8?B?TGpzZHV5RU1oejRhamt6dkVsSDZaVDdOWkJpdVVnMkNwbGlsNHFHQUNnK1Fq?=
 =?utf-8?B?eTl6VWcvVmkwOHhHZDlPQ1pMbnYyM3lyM3V1ckM2cm80VGplTUV2ay8yTmNh?=
 =?utf-8?B?YXlFdjAwSy9LZVUxWUJUY2h4U2cxZmdFOXhwMkRCaTJkUzlSaVNnQWVncnVw?=
 =?utf-8?B?MnJkaUZ1U0RWenhmdVBzcUdJaEpUUlN3c1ZMSkJMYThmZjhuSXV6WlN6Q0FH?=
 =?utf-8?B?VFB1VUZDMDR2WWN2QUYvZisvUjM2c1FtdkNkWVFlMkxGMGhtNEtwTnZaVys4?=
 =?utf-8?B?cVN1Yi9OdENtZkttTkl2WitQODlTLzljL2I5MmIwUWl3dTNXWWFtbVc2KzQ3?=
 =?utf-8?B?ZU4vdDFTODdlbTJ3eXpzY0JuenkwdVFJTE91R0xGY3V6MTRLUGFsUTJPNWEz?=
 =?utf-8?B?QUhTeVF3Zmt6WGltUFluUlpueVNuaGFuTkdwY0EySm9vMWFzRE4wcnRTbGZ4?=
 =?utf-8?B?Z0FEdnNKaE1mTlBmRUJTMzd3cHl2MmpBR2x6MmduSWp3a0x5VGYvQ1dKdE8v?=
 =?utf-8?B?eGM0ZVFBL2RSczM1YnZKeVNVTk53WGxlMWRKSEtINmhqNXdXNnFoeUszMWp1?=
 =?utf-8?B?QUdXV1F0blgyTHZkTXhMNTRza2JXQUFJcWtJMXU3dkt6WUVzN21BekVnUmYy?=
 =?utf-8?B?UjlzVkkvOTBMMmVUMzdCRjhpWkJMa0VCSlBlZ1Vobm1wYVZFZnNnZGRsdSts?=
 =?utf-8?B?cHAzSzZKbXJsZFRkSm54ZHZZSnJlSkJON05lelF2amx5ZHc5M0dzZFAvMkhs?=
 =?utf-8?B?MDdHemkvU0UzSjA5dWREOS9tMi85a25Hd2o2cytBSjNCU1JXVUNjbGI1YWto?=
 =?utf-8?B?b3hxaWhzR1I4aHNOM1ZpTURFVE5jUzZpNXdiZHFDODB2MHk5QU1WZGhQLzRQ?=
 =?utf-8?B?clFjTFlnRmRtVElUQ1k1d3RxQUhvUlNSdkZxWWVkQXpWZndGSFpLT1NHZE53?=
 =?utf-8?B?VktnQTdVMTBFTTcrdG8yR0xKcHdkWlYxQk1jT0FjZ1lWamZhelJZZ3pRWXFu?=
 =?utf-8?B?KzludGU0YXhTcEpCdkt0b29tbzNGdU9IN1M5SE5HaGxzVmhOVm9nY0xuUHY1?=
 =?utf-8?Q?JnJIdD/NPz+xDQBvIaASJI+C+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5720a52-c6c5-4df6-4dc2-08dbf72fdcc3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 14:21:54.6294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B35MCcMzcU7PXo5eZt/hT8rtbxw9RYUI47ZAMJinb559cC98Ci2n4sSYZthVaslKCzmJqBxX8tMXbckngbsW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

> +void perf_pmu__arch_init(struct perf_pmu *pmu)
> +{
> +	if (strcmp(pmu->name, "arm_spe_0"))

if (!strcmp(...))

> +	if (x86__is_amd_cpu()) {
> +		if (strcmp(pmu->name, "ibs_op"))

Ditto.

Thanks,
Ravi
