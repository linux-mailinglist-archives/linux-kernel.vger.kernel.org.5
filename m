Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525EA7D454A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjJXCEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjJXCEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:04:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2131.outbound.protection.outlook.com [40.107.215.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACB2D7E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EpROu9vP8qHUFSqI7fFKwZBod22WhzO4yz2Rk8xzdIfMCJMLru5v3JOvErScakVuoHm5ks/UW4JDfdueLEp6RrlTJSKWN1065spMEbKXXr9EMbotzy0/RsZe7FWfQpJ+UOOnqQwhPrZv62gCAEOWK9fV5O0AwKb17GiOaHU55N5onXdgFXlPhG/Dx0Mpw0dbALH+QSXAnYioe0OYavNeNBA43na2dgSsXEyn8LyAJjzFHq04Q5/lgAJRJrgvtWdQoOH14N4RiUAYEalNYsIWYhDIkO2780pceIeufet0tKTSbi9eCTjXS1wW9C/bLZLAZwr/GL6lvH9vpBwNy8KJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jer51wN5nXfv+D/Ih54737OFEZoPEZKMgNmqo8+P3zQ=;
 b=MYVogRacseVjKcyJf2S8CtSZs0obOLdFb1WwRmu8QjNEC6zq7Z/JqBqIz3e18m/20Wf80vrP6ptvNN8Qun3DIplR0gaWornNRus1f2z5ebaDkJ4hAu+2+yP8RR+J/7uPuoSz0pfjDdtrTttoQTTbIpmOTUoTfCWu2I5l5CuGbRBWfyteBr+3qK1DWF6se2zp7FztK6yYbTBOOKYAtN8z6PzofPMhN3GRNXUcYhQ2txELubycN4+N2vyH0z5URfJVp2kuus93piDgiJmqDZ8CKHuMEeIY0+tWvHwq49wK6XVuipb+sAdXNrIrFoWGb0dCa/nMQOM7/BbyovGy/490/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jer51wN5nXfv+D/Ih54737OFEZoPEZKMgNmqo8+P3zQ=;
 b=GdhZrvngVDD2KOzEcv4b9a+qWrRIxF2QGxiFIs5gusFmKIul2Q/cDP6th60faDMDxYK8KgfAgO5gbycxAATZruOJY8/xb8bDrWfkQtXufZIbyK0kqj8/U1NEqLMS44WzKzQJsGkNtN5yKEjoHpeGv85FgI57RR4cXR5ycKMV0F3gZdsP0P/u5hj8l8QuOdFMv803PdYduJH37nMKATTWq0ryePvawEUOdq935QF7raLcX560Gjds4aSbWpvus+ddU6yXZZQ7G1J5slByPjeLvbiWokX3R/fWlpqFOgHqIziP8ZT0OIpl7o2axFWipQamqiQ6QW9YIn7FS+cxDTKs7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR0601MB5535.apcprd06.prod.outlook.com (2603:1096:820:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 02:04:31 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 02:04:31 +0000
Message-ID: <ec6b681b-132e-4323-93eb-5925b0ca7ace@vivo.com>
Date:   Tue, 24 Oct 2023 10:04:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm:vmscan: the dirty folio in folio_list skip
 unmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20231019131446.317-1-justinjiang@vivo.com>
 <20231019131446.317-2-justinjiang@vivo.com>
 <2d847d76-2e33-4296-992f-1a6d00c66ff5@redhat.com>
 <02e73251-33ff-4632-9d2c-bc268f397202@vivo.com>
 <ZTH+7ZJyPnyZOe7V@casper.infradead.org>
 <380bc753-5ee7-4bc7-a76e-a804d5179d87@vivo.com>
 <ZTZlR2qJivLIdgsB@casper.infradead.org>
 <4eacc9e4-65ba-4fd9-bd30-575b0f23b63e@vivo.com>
 <ZTZuui+0Ppe6cjgC@casper.infradead.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZTZuui+0Ppe6cjgC@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR0601MB5535:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e04d70-5ea0-4b34-b85c-08dbd4358f2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOfkz0qfVz39An0UsLeAOR9YDlS5Dii0YOzTY5vMpEaTw/I44Ogd6BWMnwf3Pxc6XOgAsEa1XWo2KJbG5A5PBKY+LkxSzoNfOOvFNp9XO6WasHoO/UqpTYbvKrNFQ+pRwkcWju6jsOHzmXWasf6ThQ9SONe1WumcIYcFNSyevqSHC+a2APmGTzgKTR5nsLJ46tX1kq8RHHYcUmgRA/I8ZA8r/9nLtpNeG2aWExa8j1y8pxj+HNxyoOOY+SmMU/HiUS6i0wll/QtvRRgo7flGSCD1aSEAO552pbdJcUZEcKCorrO/e0OpW410DLD5ZTPQmSqCFdXJxEH6aaO+Q+ZYRb7l/ojMcl3CT/TjtKa8kd0RkCVYTxnPtfTWHgwDD7E4qPGh/Hqu36qolhrPpYZK6qUbLXskgIAixMFFYBBLCEgccNq73y4kfcKMw9uIOd56KAXSSqxNLITYcMxrhN3r5qXExtvMhwJ6SXVh7hDprIJdMS1IRmXt/y6E7YXWAikWdmk6doKZlthq4zIojrju0JICSC6GqWo8DGb9w75N/MUOUpkvjP8LNu9vQtcsoJwaDmDlpuN6QdFpyBQ94qjcyH2xfmMntSlvA95bI04ZUNNL7ajy2Cwr2xHimaS1+JYBkqThz5A35puY/1ZtRzTVMHMcH2wmcj4/vJEWyh/tJi5kMr6Q5slXpYLjlVTJ+f3IeY0NB7ZVMwWx6YEOACPxf1798wSjHGfg/k8lQYoD5vw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(84040400005)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(38100700002)(41300700001)(66476007)(66556008)(54906003)(6916009)(316002)(2616005)(107886003)(66946007)(478600001)(6666004)(6506007)(52116002)(6512007)(6486002)(83380400001)(38350700005)(86362001)(31696002)(5660300002)(36756003)(4326008)(8936002)(8676002)(26005)(31686004)(43062005)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFE1MkZTSGhQSzdXYkNmTzRtcVhodjhIcEd5eHV3WndHUzl5d3dLZzhNWUo3?=
 =?utf-8?B?TWk5SlZCU3VsUC9TUmM2Z0RRVVBmZGRCWVQyNXhjMFRFZ01XUmdmcVpQOTZ5?=
 =?utf-8?B?SjUrdEtXN0ZWdGNKcGZZd2pzb21xakVkTEpCS2d0SzVEcEtoSFdVUUlmVWlo?=
 =?utf-8?B?dk1sbWJFU3ZwT0ZVaXdZRkxmbDdiUnh0cVhzM3drSEFBTkVaUDN6aVVQUE9Z?=
 =?utf-8?B?TWF5dHU3OEFDazhCYkM2V3dkSjBQbnBYVnhJOWJUTTdvU0xiV1NvUU5ZdTls?=
 =?utf-8?B?anQrQW4yWmpDVXpBNGYwSkpQayttVjRRaTN6aXpLSWZhbDArNWl4bU8rbG43?=
 =?utf-8?B?UnpqQ2Z1ZlNTR1RjM1JCZDJ6Z2NLOU9ZY011KzBtQ2w4YmFpZmJ2U3NYNEM3?=
 =?utf-8?B?VW5nRkRZYVROZjhLMXd2cXhyWFRsazV5bFhsZjQzenhUZzBxQ1BiYnFRVXpF?=
 =?utf-8?B?QmNZSVdqcWNqLzlUVVNGYzdTKzFUbWo1RmZ0Y2ExaFkxc1Q4NFRPbTBsMEU1?=
 =?utf-8?B?YXRheWFxRCtFYzI1MWo2MjVwVWRFWmlnemVhS2g0SzhBSWVFVE1LcVJQWUx4?=
 =?utf-8?B?NDdxbGlhRW5MSGEyVk9HN1VMZ29YRzRmVDVKZUt4Ym1xQktEVUhTNGJlb01n?=
 =?utf-8?B?SUpkTkd5K050QWl4R2tyMWFTWDRFNUVYVm9LdFhMZ095K0YrL3p3U3hsaEdp?=
 =?utf-8?B?Sm5lZmxJZEJYWm9oSFg0TVNVY1VtZGc0c2M4a0JCTHdlV3NLMnVDbndwRnhm?=
 =?utf-8?B?S0dQTFN6dzdOcExkVGMwZnJKQmZjMHlBV3dhd1hMZmQ2ekxKMjhhKzRsQTRu?=
 =?utf-8?B?Q01yWGRBNitnYWE3Y0dEZTB4Q2FTVXhYK1FZSE95dEFpZlJWbmQwazlzWjAw?=
 =?utf-8?B?TEdlR2xHeTl0QVA2K3NFc3RMYzZVSGlsWmtMcS9RNVI1L2Nsb2xLNVJwbWhN?=
 =?utf-8?B?cEhCVU1WaWdSU3RzNHptd09vQStRWGtrYUlOS2VHcktCSEN5WFRiTFFSMVg0?=
 =?utf-8?B?SFlRZGJueWdSeUs4anZ6K05iYUEyVEQvbUlRYjBUakFqMVE0LzB6QWc2bjZ1?=
 =?utf-8?B?WFkwbmZLbTRRT0xxOEMxdDArdnNtUnNYSzlTeWpQMTdjYnh5YmpNdFJmdTJ0?=
 =?utf-8?B?aXdaV2xzOFg4UlFzSTc5cGNHWTRLY2pwNWZWSEJLbjdETzJja1o1a3YzY2k1?=
 =?utf-8?B?RnBaQkZvb0d5aWo0NCt3aGRxQnUyc0hNT1BRTnVyNmZHWXZkT2VUV3NLczdn?=
 =?utf-8?B?ZCt2aTU2dXZJUCtpVDdDV0xmTzNLV2xaa3dYcEQ2L29ENTVCc1BXczJFNFZB?=
 =?utf-8?B?cVZJSUFFdmpjb2tZbUhHUkEzSUxnTmJITHUrc3NEdVBRY2pwWGl1S3RkeWRi?=
 =?utf-8?B?MjN5MEtwTHRybzg0cUNrOHE1Q0loOVUvNy9URVI1MFdEMWgrcVFVc0NiSC9j?=
 =?utf-8?B?TmRHMU1CbmFjaUY5OEFlL1dlYUhqaHEwcVhnTjJHQTNBSFdveEhoeTdtTW5I?=
 =?utf-8?B?QXVXaGI0TzdGdHJOYTZFR0RuZFpmSytNdS9uTnB1UGpaRkJrWk5kc2t1emN2?=
 =?utf-8?B?Q3RzM2hGOG5MV0RmbVlWbW1Ca3V0QWF0bDVybHIzWk9CcFBDWDl2OTJ6TDhi?=
 =?utf-8?B?Z0gwYU02TzBJNnF4eEZWUDlVZXN0V1NBQ0RDR2dIS3owdmFqTTI1ai9paHlp?=
 =?utf-8?B?eU9wMmwzSlFqOGRNV1VPWXFOeXgvZlh2OTdmQU1IK04yenQ4Qno1aDltdE5u?=
 =?utf-8?B?NzhaOTRlNkFndlNSNzZ5bGhCc2xFRm9DZnhzTFVUdkVSSmM5Sk84TklFbklF?=
 =?utf-8?B?NzcvZFBEUFJtc2tpUjk2M2RrUk1MS1JKY2NmVWpXcUVvVVVYMzd3SjczTnBv?=
 =?utf-8?B?WEp6dXJEZ0w3dEowMldKVklZcUFDbGIwKzRUT01qOEdTZVdzMERlWGt0ZWdq?=
 =?utf-8?B?Z1ZQdVF5THE0RVQ4REtxWXFhWTQwMG1pUklXV1VtcVpHemp4Q0MzRGwxejVm?=
 =?utf-8?B?cGFhSzVSZ2FJK0RDeTJMZUkvVko2c0ZYRG9nUTMwMVJZMG1YMGNTQlZGdysv?=
 =?utf-8?B?TmxXdWM4WFVGdTVQaE5ZNHVaaVdiZDEyNEIrc0piT2ZPVE5IR1RIeFZ4MVk5?=
 =?utf-8?Q?l6Sefjh7OTdHT/no4Un1a+LNb?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e04d70-5ea0-4b34-b85c-08dbd4358f2d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 02:04:30.5399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRk66XxHbw08fUrFIhwU+EAMPtsh9NhIH1x84l/gs8ZXOKr7ENMpE+E+WayN5RJJKNH96zntLPUCJuwzJz4AuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5535
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/23 21:01, Matthew Wilcox 写道:
> On Mon, Oct 23, 2023 at 08:44:55PM +0800, zhiguojiang wrote:
>> 在 2023/10/23 20:21, Matthew Wilcox 写道:
>>> On Mon, Oct 23, 2023 at 04:07:28PM +0800, zhiguojiang wrote:
>>>>> Are you seeing measurable changes for any workloads?  It certainly seems
>>>>> like you should, but it would help if you chose a test from mmtests and
>>>>> showed how performance changed on your system.
>>>> In one mmtest, the max times for a invalid recyling of a folio_list dirty
>>>> folio that does not support pageout and has been activated in
>>>> shrink_folio_list() are: cost=51us, exe=2365us.
>>>>
>>>> Calculate according to this formula: dirty_cost / total_cost * 100%, the
>>>> recyling efficiency of dirty folios can be improved 53.13%、82.95%.
>>>>
>>>> So this patch can optimize shrink efficiency and reduce the workload of
>>>> kswapd to a certain extent.
>>>>
>>>> kswapd0-96      (     96) [005] .....   387.218548:
>>>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32
>>>> nr_reclaimed 31 nr_dirty  1 nr_unqueued_dirty  1 nr_writeback 0
>>>> nr_activate[1]  1 nr_ref_keep  0 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>>> total_cost 96 total_exe 2365 dirty_cost 51 total_exe 2365
>>>>
>>>> kswapd0-96      (     96) [006] .....   412.822532:
>>>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32
>>>> nr_reclaimed  0 nr_dirty 32 nr_unqueued_dirty 32 nr_writeback 0
>>>> nr_activate[1] 19 nr_ref_keep 13 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>>>> total_cost 88 total_exe 605  dirty_cost 73 total_exe 605
>>> I appreciate that you can put probes in and determine the cost, but do
>>> you see improvements for a real workload?  Like doing a kernel compile
>>> -- does it speed up at all?
>> Can you help share a method for testing thread workload, like kswapd?
> Something dirt simple like 'time make -j8'.
Two compilations were conducted separately, and compared to the 
unmodified compilation,
the compilation time for adding modified patches had a certain 
reduction, as follows:

Compilation command:
make distclean -j8
make ARCH=x86_64 x86_64_defconfig
time make -j8

1.Unmodified Compilation time:
real    2m40.276s
user    16m2.956s
sys     2m14.738s

real    2m40.136s
user    16m2.617s
sys     2m14.722s

2.[Patch v2 1/2] Modified Compilation time:
real    2m40.067s
user    16m3.164s
sys     2m14.211s

real    2m40.123s
user    16m2.439s
sys     2m14.508s

3 [Patch v2 1/2] + [Patch v2 2/2] Modified Compilation time:
real    2m40.367s
user    16m3.738s
sys     2m13.662s

real    2m40.014s
user    16m3.108s
sys     2m14.096s

