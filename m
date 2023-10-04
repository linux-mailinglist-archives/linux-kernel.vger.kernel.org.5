Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1897B77C7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbjJDG0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbjJDG0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:26:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0379CA6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9jqWu5lKZYUnxypNdB/BJINEkZGUjjWWHweVqnVUovQqEuYdlX/vVm/wE4iYUfOoT2TD9bzJIRVNPTvOpqIcdQgcO7xFa8okw/bgCzEnKaRtiFmTYg/vRF9KBsFki0YVEewsRgIhNOyNPyuJS0MJq1BdysgSUiHSsX7TpJl9ueimbvjfqSKstD/hduP3UzEmpWYxGwrh3vRb589k64zx8J7PR71TSMEyjk7VsLsBOrCuDwMQrnSi7dJUr7l84DY2cq17aTLZRxO6Ts1e6Qp4nV2AAzmxDyEGSaVgPFWcKZFB2Xr1JlzlF0lX4iuIg5/TJgpi0lQ9y+oxlwDFtj85g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyNcEQFk9s11nRzIFaJp0XhsAi8cCRh08F+qa/fUztk=;
 b=DFScXOjd/83iMQJhggu6LITMq8ILlaGT1XA4Fur7z/7p2ZUAtp0knYTN78OVhg+9rqWCy1TI+5Q69LoxMf+YCWoO61oO4Z6u0wciFSAWDVc2rO/rKgO6AXAP1I2lhqvg4HkmKv0blxl892prmJlc20lROkbwcNiKf5dXvOEdZFK1yRT9GLq74fUrBNr2NMmY2LcWQyQZYN3IFwOJZrXSjCoSbPy07Kp1ujGacnJGXuZ9RxMRnfZ66jbVgxq/QK1b1L+QG8cHOWg8+HGlAo/WX6R97CGKcT+/xGgdTlbJoHGyrNS/agTvVIPodQnktIkAWfjDuU6JdeaXLo/7BB73dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyNcEQFk9s11nRzIFaJp0XhsAi8cCRh08F+qa/fUztk=;
 b=D5VPpcaRn6EgUpcUhgQ7+ohiDMFfPYXOd3WWXkuvuTmJrjK+DEiWxVmAp9hgiMnB6Zikc7Z4uWOdh4snb91/XcuLEWn7CnOa7j3I5ox6HLO2sHU6le7s4SXkVklNNeTLF6qH5XNNtKxrxxP93TsXXFlh9SmhoKgrMJjatcx2+UU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 4 Oct
 2023 06:26:30 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6838.027; Wed, 4 Oct 2023
 06:26:30 +0000
Message-ID: <f7ee378e-6fd4-620f-abf9-2a8aa3643f94@amd.com>
Date:   Wed, 4 Oct 2023 08:26:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Kelly Devilliv <kelly.devilliv@outlook.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <TY2PR0101MB3136A7480B842E009BCBDA8384C3A@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
 <13d73200-2d53-7f95-fb93-5b5f422251cd@arm.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <13d73200-2d53-7f95-fb93-5b5f422251cd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::10) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: ecc8777c-778b-4292-fef1-08dbc4a2d87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IfEwoz3Y5M8qB/aoWisH9/OdaenO1USrj10bsyEESBzpnB+uUHmF8b8bXT1P9lwwoRgP1tkPdbTYkRoA2gY7fhKQoGxxAGJTKYoYV7fT1x6crZNk0LwknZvO7ZigoeqQ1noX0xUBB42qDwugqL7kwwh0BE9365ufaazoFWXOOAcQ4zBZvtyrrusWd8UF2Tg2M/nLbcGnfIVC3MFqXMXIxowKPPFYDXVqZ0Lnh2Gz7OlVbgvqDqxcbdg8MpKGXIBd85jTFXW7eXlSem0O7SC1ZGI0df1kIDvV45deHLXzm5x6SGmQ5mckDOs+DriPSvVHKRT7BYOWXTphXbvYg3uDwbeHJsUFDGulKaFcUM09yBZAgq2tACuQ64mfIUHOgsf48HK0r37ukCd7ea5CrolRaIEaLC8I1sfk5hENR+dspZCmB+wROJAc84Va+L7l+SRdT+JVfAPmA852Fv9TJO83nBKrYu6BMLUWFc12n1+qZOm2LdGf6RrMaX8K0JY155vAASWosIh6jOHFK+yxoU2JS6L5OgEHNWDOU3I9ZmkCq/ySZEjHevMbOohOxFEazzTB8WQgMqNtzcHJQir9ccou5rdZYuz3lNJiJlKXsSmjLB3v4aPaTpQnsWpdG2X4EogdX06UBkfDyGaAEv7GVvvBDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(36756003)(26005)(2616005)(5660300002)(83380400001)(6506007)(41300700001)(8676002)(38100700002)(4326008)(8936002)(6486002)(6666004)(53546011)(478600001)(31686004)(66946007)(110136005)(66556008)(54906003)(316002)(66476007)(86362001)(31696002)(6512007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmcxUkQ1Y0pNNmtsWnM5V2pNck03SmtlUlYvbUVHY0RQeGRxODBNd1pEU2xq?=
 =?utf-8?B?Y24rRmZkenc5dmZGUGYzTDU2SHdRNjZEc2J3NXY3ODAzM1JDSWRINHZzcUxz?=
 =?utf-8?B?WS83Sll2UGxvbXpVV2I3eWYrWU9yTGV6NWdZR3VNdjRhdlJ0b2dQUXpHa0JY?=
 =?utf-8?B?ODU0YTFCaTZzTG1EUTh0ekRzSUs5V1BvWFgzT2ZyajIzcTdkOUdxUUttaURu?=
 =?utf-8?B?eFZHMUlLTHFkWVBEN0tHQWg0R0dERysxb3doWENTMmRzaWVLNXhkNWdLcVdK?=
 =?utf-8?B?bmpjeXRkZFJMUURGNWdjY3ZHb3drSWlPbndPOWl5RXVZTGI2UHpLdHpnV1Zw?=
 =?utf-8?B?cWhodGRNeEd5MEVuVndFMHVtK1c5QXlFYnBGckE1REFza2JEZnBwYU1jcUF2?=
 =?utf-8?B?RTBZU24zOFNlUUl6bHE3R0Nwcm9sQ3BoNzJINlY4OUZncUNRaUgzZmlSYnNx?=
 =?utf-8?B?RWVScVlhSXNpUWtzL1hJc1hISzh0RmkwUWpVYWpCQTgzYXFxZG1YOElYQ1hP?=
 =?utf-8?B?SlpKbVBDSm9TeUs3SGoydG1QYVFTWmFXeTBxb2xXL2hUcndKdWlLN1BYVS9U?=
 =?utf-8?B?cWp0dU9mSlR4a25yTHlCRnkwQ2VhdEI4R0s1bytnQjRlMU1XTGVIYkVHMHhR?=
 =?utf-8?B?NUsrK3gwTGxleGRKRis5ZnBzWGpValFSNHdaeURTNERxRkZVcXBVZkthaVNt?=
 =?utf-8?B?RE43U3RYZ2locXY0OUY3OWRTblN1WmQxYXJRT3dHR3V5Wndpc1BCU0VXUWJk?=
 =?utf-8?B?Nml2L0dSMUxEbm5ZT2JwcWhUcE5lWFNFOGgzZy9DanExQTJrWFNlYnl2aVIw?=
 =?utf-8?B?UlQyckxrUVFlS0VsWDM1bUIwK3BhMFJWOHdqZ1ZnUUJxWW0yS2VxaW40V0hQ?=
 =?utf-8?B?dlB5U0ozZFFjZkNHZUM2MnZlVUNqR3c1bXNzQkx0bTZkOW8vZWp6Qk5iVjlx?=
 =?utf-8?B?dXRvVWNna0hSK1ptUVNhd1pKYTQ1THAxZ1lHZzhVNWZrNWozNTBDbVJ4bVB2?=
 =?utf-8?B?QkVtd1ZONENUS1NMOHFRNDV6NlIxM1FMOWhaU0hFWVJtY3JTa2N6TVlLc0tB?=
 =?utf-8?B?OUxYdGtPRHNCckpWV3dWRHc3ay9PZHp1ZG1yVThSczBDcTRhSHowZXQ2TzVy?=
 =?utf-8?B?TGtOZXEvWnhpb3FVclZROTRtRnFEeHZvL2RHMW1IQkFYdnBBKzBQSXFlcjBS?=
 =?utf-8?B?ZzhWYnZBZENwTkp3TjF6aGZwUWQwL0w4cmIrV1MrT09uOTlzWWVMMjNNc0l5?=
 =?utf-8?B?a205TXlZMk1GNHJjWGhHcU9hVDFRZHArdWFBbDk3QXh2bjVXY2hZS0NlWEVi?=
 =?utf-8?B?WjZoYkU5SVhjRHliR2JRN1hoa2YydE5URis4Z2tCRnlCdHc0Z2lHTVI3bnl1?=
 =?utf-8?B?bEtKRDdYdlR1RVJRMHE5emMxMUJiN1BHYnA2aE95bHltMEhSb0hvcktuemhF?=
 =?utf-8?B?eHhDQUR6VVNpTCt2UUYyZmNwS3lNYjEvTkhHaG9OSUxoczY3OWJWa0h6K284?=
 =?utf-8?B?UkNaNU5oNEU4SThJYk1QOWZkc1UzbWVFMWgyU0xpclRtSXJheFU5SUdRZGlL?=
 =?utf-8?B?SkZkRHNBblh3OUhhVklYVWpBc1YxOFlsbG9MVWZKTThtUURYY1N1Y0FrUWl2?=
 =?utf-8?B?NlM1b0NTZ0tHK2hjdi95NWVhcFhGeHp5VThyMXpUZDk1SUxxYk5JVk5CU3hQ?=
 =?utf-8?B?UTd0MHN2dno0SVB3QXhQWkRYei9wbFJwaXArQmtjZGFWOEtWT3RtQUw1amdM?=
 =?utf-8?B?M2IzTHpTY0NHZ3hTdDhDNnBBUzU4d29TMEFhYlRXdjBLOXhadkpRbmFEQTVE?=
 =?utf-8?B?TlI5eVRuS1JDTE5uRWdlMDRwVkpPWWFxRllDdjRpMFVoRlVXbFM3b1ZKY2sx?=
 =?utf-8?B?QTBDRm53dlFFM1AvMkNZTzEzcTRNb0N3NG5ndlZkYnAvZW1WaHYwZEJvT2d1?=
 =?utf-8?B?NTBPc2hiUWJlc1BpWldrTGJGbFZrOVJxcWlmLzFEQXVJM2lRbnZ2ZU1BS3Rh?=
 =?utf-8?B?bWExQjNnelZxajd1ZnBWYklPK1E5cElERlJGZ1BMeW9paTRpT0V1MzV3T1ZB?=
 =?utf-8?B?aGR2YVhmaGlGV1BEcm42aU80ZkVFSlU3WGg1UzdKNERSNGFtM0c1ZHFzNTZI?=
 =?utf-8?Q?gO1c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc8777c-778b-4292-fef1-08dbc4a2d87a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 06:26:30.0922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VD673md6vsCpXpRcgwT24ZTGp7RU8hE7cQPzHb/dbgOSdak+fNa7Kb/CYBhmd/9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.10.23 um 22:08 schrieb Robin Murphy:
> On 2023-09-26 16:30, Kelly Devilliv wrote:
>> [SNIP]
>> Hi Robin,
>>
>> Is there any chance to extend the dma_map_resource() API as discussed 
>> above?
>
> As Christoph says, no. There are things one could do to make a 
> minimal-effort bodge in a downstream kernel, but upstream we already 
> have a dedicated PCI peer-to-peer API, so we have no reason and no 
> desire to also attempt to crowbar P2P support into a different API 
> which isn't designed for it. Sure there exist some drivers that went 
> ahead of the game and did their own thing before we realised that 
> dma_map_resource() just fundamentally wouldn't be a good fit for P2P 
> as initially suggested, but all that means is that if they're still 
> doing that today, they're now lagging behind and it's on them to 
> update to the newer solution if they want to benefit from all its 
> goodness. Note that this isn't just maintainer semantics or relatively 
> straightforward things like memory attributes; I believe the proper 
> API can also handle stuff like direct P2P when you do have an IOMMU 
> but don't have ACS upstream redirect, which dma_map_resource() could 
> never do.

The problem is that the new API requires to have struct pages for PCIe 
resources which the graphics drivers absolutely don't want to do.

Allocating struct pages for memory mapped I/O simply doesn't make to 
much sense when the underlying resource is not even memory.

Regards,
Christian.

>
> Thanks,
> Robin.

