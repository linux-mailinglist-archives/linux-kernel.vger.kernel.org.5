Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E691D7D3715
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjJWMpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjJWMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:45:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C6A4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 05:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLrtumko+Drwv1Zd206O+nKM7X2+s7n4WlIQ1xcpnlX6y5UFLRhlkvgH2Wz5y/pmud/DHvwnwcaftOrESRzaoajv8xJByBFFdu/wGGGDfrhiIHU+7Clz7747BrKtV7na+cPrGClDDfXqt0AeKXiPltxgn5qFMdIiXxwlbTU6AVByXPs4yaDxU/N2t7MQyO572HJeSw5RNMwtuvBjvAAeMIRY3uJbk0cfc0kvxPrQzuPP7sYT/HXskN8t+OCqo35bXEQeAjoenx+iw/Yf4lB9bFVqrrXvPragFbRF2VRalsiN5TWyMLoVHAIoxUyE4W2D11tZI0Ua8zQO1jFStVtqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqpQL3n6f7cyu7yRtWh1f/WeW9QBiCoyMR9UN+X3CiM=;
 b=cSOBb/2YBU8KffyDLw7rDQStRbO/7sAADKOthHuuRCCuLJXurVjOCV3dlaO9C9DFlScUMTpkFonSpk8snHaor/Zyx9CoJTyN7fIT8vvJkP5BWhc016P0NGaMkTn8PDPg7GF7oJvZVq3qBbDZZjYyZIuMB78XInXfnieogUJMlCmvgCisjpr9uvniIY7k6UHYuEHQ9geWTfwMkiHyxcyBdeO8403fPZwSb0IbSd1B/Cvi4rcLGhIPNuI6D5Mn3auXfujFzJQQI+WNhIJTZqXYyirvW75FX94LudaaY+sEOlSYVux6xVB21mM2NBUyfbCMJr3uhn4rOhkmx0CRZudYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqpQL3n6f7cyu7yRtWh1f/WeW9QBiCoyMR9UN+X3CiM=;
 b=aN/UF2GhcvbSP1dBibfFz2h2foA6leC4kZ+4nV8ilphfUh/Fm302tkhfgUyI27JV90Aq9wQPkWdjQrgp6nBlgK+JrNtVNfv3EJMGE3mPJZpF7VOd2Zc4DxG/gNZTSiidz5t1iJNPTUS96epNZoFCUQrIdCuR9IF5IU7v2RIvaRg0VxNjwpfjGPJY0N28VOOkRgOdUkxm06Gs/PdtuLxH/3EBJinBIFTst5xt796rHl5ljgAhC8QD0XkhzEoNydFu8NSCLsblanxSuyEoVsFQQNivIBvtvIUzygl1kdgtzdyxtyxdrIqA77wIc3QUzV36NJirWGB9lgdyJczTHhiZPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6133.apcprd06.prod.outlook.com (2603:1096:820:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 12:44:57 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::b44b:d090:c97a:eb20]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::b44b:d090:c97a:eb20%6]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 12:44:57 +0000
Message-ID: <4eacc9e4-65ba-4fd9-bd30-575b0f23b63e@vivo.com>
Date:   Mon, 23 Oct 2023 20:44:55 +0800
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
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZTZlR2qJivLIdgsB@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 806980f2-9a10-4cd3-5b5b-08dbd3c5dcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYsq+2YTgymF9CPtFtUdLBI1VNxEOjKkRZvbUWTtp8L32cNwdpbmm9GrkAG5YOHwGMoWBZOgepAytF5Y1ITiG06b4vNql5sb6oKd+2TOfFgQYxTS0LRhHgoXJgyhwwaQiI5otg5fuYd7Xp5if8aoOdaoojZkjji3cSslVV/S6TCKs2xQjQuNm/Y09IWR7WaLOev8YMEUBfJN80/PZ0k5H2pzJotjjdJkQdP75GK8TMyG79eXMJbjNTRaUfokx2LULzKTi+P9aQd6flZi8bO9lvapJXEMxGJqaXV8FljFKiRXDvOuvMXvezqeeZqFfoGuCoHn39Ka5J75HXw9B+y7hYhoyaWZvhdaqazv9PAAMCzBT7l3CRPYB/0L+AzVyiW8ZzaibSI7FtOqLnAEqhvaCw308fldnfNpKcybeavvLZMfSUPC1eAeYMQ3MyJkqnOBCzlmZiIsX60Vz5aK/ozucRLlJ/pvxZL2VHqAbsmP4QPSIpuNYNwZIiZ0WxiKWZ6RmpnnTW9GCNou4N89z85WjNBlA9pc6QOW6vqxNiDRxV1/vYFerknkymtX++ImtLXjnccz+Jrt7n61A3MEQ2m1M1d+BbDXSxj1e5W9I7ZZDiiWQ0alzEkIhfwhGs3EE17QKn9w0yT7v4Y/tJ8cVjSqySeYNmbYIMvujz6Is6Wg+bD2MeCfN7++w/fERgF66TGddgtTOFzelGzn2OQSpaTactzP+FnG6XBelcGE0aawlL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(39860400002)(346002)(84040400005)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(66946007)(66556008)(54906003)(6916009)(6486002)(478600001)(66476007)(8936002)(8676002)(316002)(5660300002)(31696002)(36756003)(41300700001)(4326008)(83380400001)(6506007)(38100700002)(2906002)(26005)(2616005)(107886003)(86362001)(52116002)(6512007)(38350700005)(31686004)(43062005)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkxFNE9Va2xRaUNwRjJIaVFhdlk0QitXZU05dUZuWGRaZldXNXFlcXR5NUhF?=
 =?utf-8?B?UC9RcUZNcUQzQkdhenYyQU1SQkhXSWp5ei96dXRZTVlMVjVpcW9ERXlDTUZ3?=
 =?utf-8?B?WmtRUkVyczZTdnJyYWJaVG4wcUZtVnltM2dydk8rTENYVm1UMlFCYTNEelFw?=
 =?utf-8?B?ZGdBUlUybmhpZmFjay9hcm5sMm1CV0k0QTJ3aEViN2ZVWjQrVHNRNnV6bnhK?=
 =?utf-8?B?bGhhVzNIUmc1djI4YUQ5UTRNRU5jS3pPdGs2VzZCb292clkzYmhJYjdhTmFB?=
 =?utf-8?B?eHR2T0s5ZGRNT1ZwekdlS3pTdWFQcmRmbGpaZzAwdXluM1EzUVpRTGN2UkJI?=
 =?utf-8?B?ZFQ3MWd3OXV1VFhYdjFxVTVtQmEyTHdCOUdxeCtiVHlYWlhqTWo5YmwwQUl3?=
 =?utf-8?B?M3p2UE5kQTQ5TnI1d3VKZ3pmTjllOFVLMkxpUUZiRUFPZjYvZDNSUFUrNjNp?=
 =?utf-8?B?WEJ1N25oQWt4em00QkwxYktNbE9TajhmSytFdCtmbmZzZjVUdDk1MDJkUmdC?=
 =?utf-8?B?eEVvbUg4L2ZKMmxnNmxqSE1RUENXQk1vemtBeG1SU2VvcU9FQU5XdmU2eEw1?=
 =?utf-8?B?VTNZdDliM2gxOUk3aHBnck9WUmhyOFJ4N1llRjU5UzFFNmJVUVloS1RQb3dz?=
 =?utf-8?B?L2gvRkx5d2kxa3BzNmtkWVU0QVFyaEFSL2VUTjk0anBRZEZoaGtkQWhIbU9V?=
 =?utf-8?B?TGQ2UnI0Z2Ryb2EyeXMrWkJ1RFk3UitsbzZRQVBxaGdDdEk3T0FIQ3hraExZ?=
 =?utf-8?B?c0lvbXMyYXNNTnpkMUNzQStjTFRxUlFuYXNxVk5HTHFGZks1cXR4bUZCcGp6?=
 =?utf-8?B?OGxVSXYzaTQ3Y2lZQXV2S0lZaFp5WDB1dFVwMlNMVXE4RjBvMkFsWVMyWGdF?=
 =?utf-8?B?TTY0SlpCaGJZc2cvN3A1WHlpVXRkQm13OGhMSXVTbkk0K284dzZLV1RiM2ZS?=
 =?utf-8?B?YkErcnliY2tZRGZtUlhoVHVXTVF0WGVkdjJjdTc4ckV6MzE0Z0x3cmJaSkgw?=
 =?utf-8?B?N0Z1SCtkS0F4S0pKdjVQUGQ5RmQvVWNoVlhsbm5tRE1QaEEvUW5hMXVENkV6?=
 =?utf-8?B?cEkxdWx3N2NLNlZjc21sRldTeUc4OW15YlFJa1hZL3JJK2s2Wi9kaEFrZ0k0?=
 =?utf-8?B?WjM5OUdjZnlYZUowOVQxaWx1cVQ1elFpd0dWNGhQcFFpTDcxUE8xdUI1blFV?=
 =?utf-8?B?ZnhJMFNScWVjZEhWUm1ZUXRMbHhvR1dKTlVFMDFDSGxZTHg1QXlFNlRaVUlx?=
 =?utf-8?B?ZlZwZjZVN28vN0JjQm1ackkzNWhVUWkxc3RaeTFUOXVNSnBXMER4cFhIcGQ1?=
 =?utf-8?B?a2dnQml0SkVmc0F2RUl4cENHZHdrODFZRFZUQ2lmblZ2ZVpaSzV6NVhkY1N4?=
 =?utf-8?B?aXN3ZC9vbXFoNXZCZjZ0RDZkcHRGbTlRQldxZ3Q5QU5oeTdQT3VxbUhpWjU3?=
 =?utf-8?B?N3BJMjRNVmtQQnBmbTFIZjZZaktlUDUwMjVNZ0UwZ1hTemFGTHJkOGZ3Q2NC?=
 =?utf-8?B?SlZxK0hwRlJkUno3KzRqR1k5cXc2bVVXUjNTYmdyemo4MW5Qd0I4YkhjQ1ZP?=
 =?utf-8?B?ZXVPMk1FUnpXZjl3L2tRRlVYdXdVOXhRNHBwdURFMkRJd2JHekFVVngwcngx?=
 =?utf-8?B?NHpSa0hyZFlQTTEwSEtmT0k2b05lOGUxMk0vZnloRUdCUUNuMXV0Zzk3RHJr?=
 =?utf-8?B?VFpKMDlUQ1JhN0N5bGs0VG9IZk1uZFVRRFRaVlB4NEJNUGE0M0JKSU1IclV1?=
 =?utf-8?B?OFJYemxOQmJqOFlxZnIyRDBUMHRXTUhvbWtoMGdjQnMzZk5TTUhOUnBJRTFY?=
 =?utf-8?B?VFljbm0xd2Y5STZucGRSL2thclBRYXNZZ0dTN01ydHVCc3ZreUlWSzUzY01L?=
 =?utf-8?B?OCt0UXBRQlFFeEdnNzJ5N3IwZ2RSaGxCbHJIM28zNkRGMXFpQmdrWStOclRM?=
 =?utf-8?B?eVNuMGo5SCtBSWdKQkVYUVVxVVBZZzNEU1hiMnh3UTVCZVEzNVJ5M21jUFhP?=
 =?utf-8?B?bVA1bUQrcWZDM0VRbWZQeDlMR1EzbStISm0vOElkOTk5T1RsMjFTMm5QSEFV?=
 =?utf-8?B?NVdzZFhWUUMxdC9TODZpVHk3ZEtGeUxzaHM4dnpJT3UwZndESVFPeFZ1Vzdi?=
 =?utf-8?Q?lC91z/cEuLgnU4fP0LFImQnoT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806980f2-9a10-4cd3-5b5b-08dbd3c5dcf3
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 12:44:57.3602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHGOgQWuBblScw8cbiVWN9uUIbLT+byKsLow96yjBJ+jgOVYnADfDU4kwPjBBXopkgmXPpsut6+ppYE5Dt+1yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6133
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/23 20:21, Matthew Wilcox 写道:
> On Mon, Oct 23, 2023 at 04:07:28PM +0800, zhiguojiang wrote:
>>> Are you seeing measurable changes for any workloads?  It certainly seems
>>> like you should, but it would help if you chose a test from mmtests and
>>> showed how performance changed on your system.
>> In one mmtest, the max times for a invalid recyling of a folio_list dirty
>> folio that does not support pageout and has been activated in
>> shrink_folio_list() are: cost=51us, exe=2365us.
>>
>> Calculate according to this formula: dirty_cost / total_cost * 100%, the
>> recyling efficiency of dirty folios can be improved 53.13%、82.95%.
>>
>> So this patch can optimize shrink efficiency and reduce the workload of
>> kswapd to a certain extent.
>>
>> kswapd0-96      (     96) [005] .....   387.218548:
>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32
>> nr_reclaimed 31 nr_dirty  1 nr_unqueued_dirty  1 nr_writeback 0
>> nr_activate[1]  1 nr_ref_keep  0 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>> total_cost 96 total_exe 2365 dirty_cost 51 total_exe 2365
>>
>> kswapd0-96      (     96) [006] .....   412.822532:
>> mm_vmscan_lru_shrink_inactive: [Justin] nid 0 nr_scanned 32 nr_taken 32
>> nr_reclaimed  0 nr_dirty 32 nr_unqueued_dirty 32 nr_writeback 0
>> nr_activate[1] 19 nr_ref_keep 13 f RECLAIM_WB_FILE|RECLAIM_WB_ASYNC
>> total_cost 88 total_exe 605  dirty_cost 73 total_exe 605
> I appreciate that you can put probes in and determine the cost, but do
> you see improvements for a real workload?  Like doing a kernel compile
> -- does it speed up at all?
Can you help share a method for testing thread workload, like kswapd?

Thanks.

