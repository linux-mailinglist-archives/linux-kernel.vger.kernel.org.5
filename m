Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3877F16BC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjKTPIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 10:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjKTPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:08:23 -0500
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2068.outbound.protection.outlook.com [40.107.247.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A1C5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 07:08:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWL04hqZSSjYw3SqjFaumCfcIDjZ0oFnGG9pQww2SbK0wCiIriHuXvryUZ7g/Gk0GrHTvLcBAWHYph86367TSn4NA85HGDXq0tv5w8Aas3SQKd+xC2+Ras/I9eMGd5vwEsNbWyvEDJLQETeXGl/vBNI6bYJHiQrk08usqn9PLvaMB50x4jF/Uimj35ByBkkvwz0csc+KtyzqrGxt7huU4zrijig/eKgl7kAyIPszg7ewhecV+rrg6rkUbi/FESGb6ILkfnDi/d5C5UJBDFI7vC9h14qA7mW4fUm2zbrGWEt+nm6PUwWiacYgXwd7NYuQXQYOE8qsn1UnGXFHGdV0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQtzUQXjzUo5Wrxum5yXGOU8kfF+BYrtpZuKBdKI68Y=;
 b=djbdb9GjCMa/Soi4FTZnzE9GA3eRXDgTj18IjYuNoXSj35aNRn28HGDhWTnFcloXsrmDNId07E35yOlOqOtkPEaNbdxqVEk8iVb1aPExGZMBWlwBicBWxXFHD2J7b+LnCs5e1BDlI13lu1dR8sqgOclwJnLXbDTXig+CbXFJhL1gPix8cSnmjvqkaOSw5DIuz+QN7rlqCmhx1gVFlrXbGUQvSmMMSZJTNa7r/FUgnwXsxJuzt3oiej26SXM9QGlFw2EJWXvvazi9o8a1nrSGhxk/tvtjwubZX6vBDGNco8T7NPmKOn3y2LLylYoi+Hb1LemX29IBmneR9479YZCsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQtzUQXjzUo5Wrxum5yXGOU8kfF+BYrtpZuKBdKI68Y=;
 b=eDty5ne9QIkxxLAbxFg572xl8REukJzcqRi2R3fjxVWg693yRFyuGE4v6A4WSV/lTjgSa97ANPDmA8lzxIJ+f4pxYxNjZcp+oN/VQ1JyjyRc1U1K25qrnRVmTHxnYPoeNxYmNC2yS2arwjnwWkQ5ZoUerpH5juTTOOMPG9eEB7W6McOVlFXuVwBbRJ8nTFU8OG/V/vTYGWEt+qrJkcKrRWDToQcx2LLTDLx8vRX64aY1Hp2IUNgZ2KJchQvYRSV61/mB9bzSLjGARk8AkP8zIxcCTJWZBl5E0J8Bs+cLYTf6+qKa4ts9nEKsq0dCRed5OhnQ4dkezcQOIFORZNH98w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM9PR04MB8338.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 15:08:14 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17%3]) with mapi id 15.20.7025.015; Mon, 20 Nov 2023
 15:08:14 +0000
Message-ID: <bddf9acc-5ffa-4430-9f5a-6322f31a4dd3@suse.com>
Date:   Mon, 20 Nov 2023 17:08:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] x86/CPU/AMD: Rework Zen family detection and other
 fun
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231120104152.13740-1-bp@alien8.de>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231120104152.13740-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0128.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::12) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM9PR04MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: d386416f-35f2-410b-7dc1-08dbe9da84df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULt9N9KZFafmVF8GmVC5Td+NoFOzFetNdEFZdcg/vZq4JtmjRap8Vnq/zBQ2k6RwQBSuxI/qzo9y6dqvRBn9ibkFQVdgNNLCe9FevDd/l/JbUW8ytPY/Lz4EbZ3XAsZugrcr6sMqmP1oBsb02AIxyNsTjsUUDGqTj7Acul5HkoYCTH7SUsacdpuDsiQ37f44cmr6WwnhpCkucxUQHU5ZJk/Pa2Z3UJ9iS/QnvBVLxYykyTdGoBUg30kk0fuWnYTPfCMGZiZx044Arts4EAiAy6fcyl2qsBFze8OaYmw0/u3oRO5+khC9XvcW60Naysteav9ZAM/ZKuWb1euUudHINME4LmdHQGEom/A5uVW+Tpfe8I0yWokSHF/TBFtt1RZyifq7lwdUnkkwEEstPcU6/eXGKnRHIzgPWOXErwgcuh3+d79w5RaRUsq4tttdwmFMtZM6TaIsm8UMdP+lEu3+e4dQQpovFgSPGkh9X76z2DhZB88Jbil8RoW/ZJ6+W5U6vTBvtz1PvOPEo+w6oJQ30UG7zXyHNG69Dj1HeRn89tr393SeBo8NNtOvhi7yZnFaK++/5NbHLqLprOL9RJbDh5Bn+4RbZDstKsq1OdU5cq2DQBvBq21nvFatLla5veVuSyOqWEj5Bxp18Fe8pvISEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6506007)(66574015)(6512007)(8936002)(8676002)(38100700002)(4326008)(66946007)(316002)(110136005)(66556008)(66476007)(6486002)(478600001)(2616005)(83380400001)(6666004)(31686004)(31696002)(86362001)(41300700001)(5660300002)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDZ6bUY0K1N1NFdyMnBPdjhCWjMzUGtkTEpBaUhnbVBFbnd1cElsYVA2WkN3?=
 =?utf-8?B?ZnF5NEZtY0tvRU0xREpQNU9ycTVlYThxdXRzYStYb3RpMkh5Njh4MUg4aHIz?=
 =?utf-8?B?bG9yRU1xbUdEcVpFZ2hIZE9PdVNuTFZsTnhGYkgyMzM3MExCck1mSzFUWXAx?=
 =?utf-8?B?d29UYktBZnFYdFEwMVQvWDVreUYxS2V6VVdYZFdUcFYydERqdnV1ZkU0ZjBk?=
 =?utf-8?B?aEVOMThyUzh2VXROY3ZlRWZzNFRIM1htYWpYN3JuUTYwTDBPSWFsbHhPS0VB?=
 =?utf-8?B?bVUxcnAzZjhBa2d4OE5Cc1hRYjZSd1YzYys4N2MzM2xOZnNHREJFWWtxYy91?=
 =?utf-8?B?Q0pSOG0veTZYR1FxTzZxbVliNldSTWhVVFd0YTVkbFJnTTUwVjdWc1c1eEtK?=
 =?utf-8?B?TTV0V2VYSTltNGF2Vk5RKzdSKy9TRGdTbkt2Z0tWRmpOcVFkK3Vvam5vUHFr?=
 =?utf-8?B?VVJid2ZGOEs4bzhZTXVqYzdPQVJYWDVDSWdmd01uUURCbytLRkg2VkFnTXZG?=
 =?utf-8?B?R2MxTFBsK25oUWZQenhUNXlwVUZFaEMycG9mWFVoTXdMZVh1cmdpdHczYXkw?=
 =?utf-8?B?UzdTQ2U4SUtOazhWTVdPQktGNlJZaVhlczRLY3RFQmNFU1d5WEZPTWtuR2tJ?=
 =?utf-8?B?ZnMvbU5LVldGYlQySkx2M1R2VDlGZ0tqU2E0eWI0TnhGcDR5Znp4dmlEWVBW?=
 =?utf-8?B?eTBybWNJdTdnYTEzejdMTVNFTi95NlRWWkxwL3ZDMU5kTVA4dnFBRmxlVEVw?=
 =?utf-8?B?ZnFmSnFuZWtRanByd0Foemx2RGxiRzM0NnlzRG95QVBpeFc4UHJYOUJRQ1U2?=
 =?utf-8?B?cVFwQTRGQWxNOWtKbERuREZSV29BYnlxbURWZHhJclpzbTE0TU01ZWYvRVdG?=
 =?utf-8?B?NHp6R1liS1BmZGQ1UFNnK21sTHlOdkV4ZVRHa0IxZXFNR2FHcGtWMmxiQ3Vi?=
 =?utf-8?B?RXc4cEoxOHlMNGdVczdtSVhWMnFBcUpNQVd3bkdQNDdleitaUEErM3VJdEI0?=
 =?utf-8?B?cERwQTBBdjYrVDRXZ2tZTk1KbGloTSs2WlJOcnl1bU9aeXhLekFIV1FFOTRu?=
 =?utf-8?B?dW5rR2Zrb0JuUE9uZTd3dGlKaXIxSFNtcDYvN0U2elhxbkVEem5FcTRXSjNw?=
 =?utf-8?B?YkZPdVFydERjSFRLQ21Hakt1eEZvZElsTnFreWJDcmt0Rk9TWWtNZ3F4Q2x1?=
 =?utf-8?B?NTRpcm85TGhLTTRJczBHVFQ4UkZXbHJYdnVxNmt3Q0NRdEhmUWREcFk4VnVG?=
 =?utf-8?B?VHJHQ29vb0dZYUF6bHVTN095UXJHSUJxMnBZOHU0NEV4OHh6bkxPbjRiNGZV?=
 =?utf-8?B?WXBwTE5QYUs2ZXpGcG0vNXRSY3BBVmJLYi9LQXAxdjFGNUVweWc5eEJDb3hY?=
 =?utf-8?B?WFQyVk9QZ1BId1RnbmQzdGJnT0FUOUVzb3ZnYk5STldISzAxamMwclZNUVA1?=
 =?utf-8?B?QXh5TTdneVdTaDJTMjhtSWpHN2JUYVdNUWlXclFLalMzcjhUdFR3M3RQWTJu?=
 =?utf-8?B?SkFYVmRnV0wwVjh2d3duUlZOR1p3c1FFUGNCZEYzbzRodHZLSlFVZXlsK3hR?=
 =?utf-8?B?YjYvZ3JMZnY2Qi93Y3RZUzNoWGVYSjBNZlYvWTl5Yy90ZTJkU09FdTVxeUZL?=
 =?utf-8?B?UHdiL0VubUJZQXhldTQyWkFzcnQ2ZDBZTFZVNngvdWgvN3NUbng5dFkwOWND?=
 =?utf-8?B?cmVveWlXdjhIYy9odndpa1BjREZjQXFLVHFFVkxsWlJqU29lNUY5b0xoUUZ3?=
 =?utf-8?B?WnpubGt4TWowUmFHWEJkQUVoRTY3T0Z6ZitGZE9oeXdDZ0JiaEdrN3FYbFRI?=
 =?utf-8?B?M3JQUndaR2NQdzJXSnhaT1VkZnNRVEo1VGJNcGtEZGphcFBsZXhreklNblYx?=
 =?utf-8?B?aGl6eExMM21TbENuSUhSL3BmMnRDNk01S05Bd3Y4eGFlZ1oxMWlZUy9aRzlV?=
 =?utf-8?B?YldpZTltRjlDWjE4Z3VLUmNoKy8yVzIvM0RHZ0srUTdGMzg0M2wvaURYTGFv?=
 =?utf-8?B?VkxLV0VnNk9sOEhXUjMzYllnRlc5QXhsWnZOT3lTdkhCS3IzWklaNG5NZERK?=
 =?utf-8?B?OW9CdU1BZ0FreE9oWjJHM1owS25UMDJYZ2dOTlRUa0ZEbk9CNFJKZFpNVUl1?=
 =?utf-8?B?d093eUFYNUxxeXZnZEZYeGIwNEcwMGUwUUVlOHpkZ3VpaS90RmpBZTFTZ2dK?=
 =?utf-8?Q?w44VUyQAl9eyFzCqnhjaF270AY1wuqeoDzTzJ+tgjttk?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d386416f-35f2-410b-7dc1-08dbe9da84df
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 15:08:14.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQ041t0ftmU6SsSYdxwhdcxhsV/5nrOqa7YFk1SEQVglisoNeccxTOT5I9e+3jCZQK4tJ3WSkLdVt+0BG+hj1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.11.23 г. 12:41 ч., Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Add Zen generation flags which will be used to check on what type of Zen
> the kernel runs. Distribute the per-generation init work into the
> respective functions and cleanup amd.c properly.
> 
> As a result, drop the errata checking gunk which is not needed anymore.
> 
> There should be no functionality change resulting from these changes.
> 
> Borislav Petkov (AMD) (13):
>    x86/CPU/AMD: Add ZenX generations flags
>    x86/CPU/AMD: Carve out the erratum 1386 fix
>    x86/CPU/AMD: Move the Zen3 BTC_NO detection to the Zen3 init function
>    x86/CPU/AMD: Move erratum 1076 fix into the Zen1 init function
>    x86/CPU/AMD: Call the spectral chicken in the Zen2 init function
>    x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()
>    x86/CPU/AMD: Move Zenbleed check to the Zen2 init function
>    x86/CPU/AMD: Move the DIV0 bug detection to the Zen1 init function
>    x86/CPU/AMD: Get rid of amd_erratum_1054[]
>    x86/CPU/AMD: Get rid of amd_erratum_383[]
>    x86/CPU/AMD: Get rid of amd_erratum_400[]
>    x86/CPU/AMD: Get rid of amd_erratum_1485[]
>    x86/CPU/AMD: Drop now unused CPU erratum checking function
> 
>   arch/x86/include/asm/cpufeatures.h |   6 +-
>   arch/x86/kernel/cpu/amd.c          | 266 ++++++++++++++---------------
>   2 files changed, 135 insertions(+), 137 deletions(-)
> 

The whole series LGTM:

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com >
