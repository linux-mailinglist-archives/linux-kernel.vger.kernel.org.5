Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2D775D7A5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjGUWpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjGUWpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:45:06 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD1E3A87;
        Fri, 21 Jul 2023 15:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3YG4P+ie5s+MA5obd301VeX2R5UrhW65VejXh3iAypsJ/n8VuWAj2OcMXCvr4/EtlWL1Rk1mfB9B1fT8Oso6uLLKGCi71ws6OgVW31hywWNBVsOZI/80Hfx2VKjJYilzIfuL0LYcRb1RjgoMc+snjQPcHVdV6CaQDyLNWGTf1+7gT3SDiZolrrQOfR4S5TzfD27HpvPjWwft95rARZkKE1eH6765zLAnQGX5EYL/vnvMl30EhT+D30fzEinLYXP6IDQxo39OQ0EDXyIuA2vBgTuJAnFbCjGU1F4GA0hH4tA+HCKpg8IiTZ9oQhVWpq3jVKCk8w/YtpJreaUC+iFEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8dqrqydUEGlT2w7zxYJgh6QbIcxdk7QY4zCo2W7MKQ=;
 b=UYJHIUXQi/EmkARcZ7otxbIWRZ+pQYNUNQdG2i1g59S4sWyVYdYnnSJoXarCNHnH99p2VvX0eYEdJQKrGekIsraapW0NXHOuQ4fHWwU3biFgGJ+Mr2jOR9uFrMEUJhAINohOrQmzd1ISG5lAiJ0Wohvma5Lny/6FtQjfXi8SmbVMzzxnAN83w2X90/ZIhf5FrQeGItvqPneAfGyuTUpXHv6uiWlX2jMEOslYP20N+RKDwYJyMIIjQkdZ29dlh/m8hKnu1dP2ieCaeDXY54QVF4xS4PTK0AltSEdWYB7KmC9mmhFsxqxRaSF1ogMqRG03vHSOrTsYrkT3RI/MjG+X0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8dqrqydUEGlT2w7zxYJgh6QbIcxdk7QY4zCo2W7MKQ=;
 b=3TCexgYzTiA0QbOqKHypob9EE2NFoLNqPQeQsTje5BZFeKxhpxezgBfSnIDK4XeGOfjgtjvP5Ck01AIKc2ZbTcqz4DtN2w9/hCDtduu+KQvWzSsR4tK4Qb3FczdcbhnLo9sXAsLfxthLXFLaRjYXMTXJNcl5C9PRaw/tJwMKiXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS0PR12MB7534.namprd12.prod.outlook.com (2603:10b6:8:139::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 22:45:03 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::1352:c7fd:4b4b:cc18%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 22:45:03 +0000
Message-ID: <d64f5a02-68cf-2978-c523-094c458aa866@amd.com>
Date:   Fri, 21 Jul 2023 17:29:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] tg3: fix array subscript out of bounds compilation error
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kuniyuki Iwashima <kuniyu@amazon.com>, davem@davemloft.net,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        mchan@broadcom.com, netdev@vger.kernel.org, pabeni@redhat.com,
        prashant@broadcom.com, siva.kallam@broadcom.com
References: <20230717143443.163732-1-carlos.bilbao@amd.com>
 <20230717192403.96187-1-kuniyu@amazon.com>
 <c196f8f9-3d2c-27c6-6807-75a6e6e4d5a5@amd.com>
 <20230718195414.4c6f359f@kernel.org>
From:   Carlos Bilbao <carlos.bilbao@amd.com>
In-Reply-To: <20230718195414.4c6f359f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::20) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS0PR12MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 64fed5fd-ad48-45ca-2225-08db8a3c1f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/wQyxjo5xiPGkvjRZJCog0dujIL18vB2rSUG60sA4NQEIUVaRZHBvnh44gPS3Uq7BCergbsgAfiKvTjrPxK3kFnZpI9mxsm1+3RxmamnTamsXZk9pEj9Y5ohEzvBqRL3e4SnOnwTj59yAat22RrNTlqz9PCxLOY2eITHVVJC9BJQTk0LCRJNqzuRbMckEC1vexJRjEsCPDEvc1N/KTukV75a/Myz+DFNDznPV6Y4tjtwSl9hqNWkXqV9XMBuR2UYTa8VNLIeTUnr6T41y1YjfCNjZhxtAxi2PqtptfzfTui7tca/AK7L52W50X8cc5SHqxB1aBkSmVXmh8SPJrmARO8qfL5E8Y8K/N68keEGcb+PHiBnIcSe3C+sd2TIa6im8Gnf89z4QfC2H2Fd9vW4On2vIF+5FK6xlphkdQEtF8Wo2JUyDfC8ZzR4f4vLDlzbVSQrw2SBqvA08bATuovLBFlWjE7Ir0HcACR1sGdyPQzZ6+uZvoM7Mtt+YOlvclCyJ1bfUn1lySqw/yDLpvOIcsFRynFFearQz/dFzCw9f6JyXt9RUprP1MciefTmdfYUOf+TqCBMb7Fr6ZUu4n0xnUXxhTNhmZietOns8o5Zt1KPNpvoWHbnRYeFiqTWIpiJCqEyvBs8nnI/ysvdbcnIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(4744005)(41300700001)(316002)(7416002)(44832011)(5660300002)(8936002)(8676002)(2906002)(36756003)(31696002)(86362001)(478600001)(186003)(6666004)(2616005)(31686004)(53546011)(6506007)(6486002)(6512007)(38100700002)(66476007)(66946007)(4326008)(83380400001)(6916009)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk4zWmg2QkRZNFNHV09MTzA1b3JLcDBjSVFSU1hXN3IwektYbjdUNjdNeFBa?=
 =?utf-8?B?bCtDUWNlbllWTWVWT2JkVklUc1VZVGlqQXlWRGNxNFhuR0txTmN5U0JlcGNq?=
 =?utf-8?B?Q1FveVZmSG5Tc01sZVRPWlZOeTNlb1R2bm45TjJOKzhuUEY0MlUvMXlaZHZj?=
 =?utf-8?B?K0x1ZnRIWTU4RDZmRHA4S21VUjFIMHMwckVLMVlPODZZQWZsQ2lDODI2V1dr?=
 =?utf-8?B?QmtOT1A3TjA2OERNUHJtZFU4SnVNejgrajRlaG5Vek5KN2RlT0s4R1FyNSto?=
 =?utf-8?B?c1lUWXNxSTZBRnl2Q3N3TG5sWXo5ZWhkKzlldTRwc1BtYmZvUWo1YkcwVXFL?=
 =?utf-8?B?bkxGU3BrTFJwZ0dCdHR0VEZFTXQ2NEJ3M09wU0VLbUNJbk9Fd1VDZ0ExeDcw?=
 =?utf-8?B?Q1ZFaFdhTE1IUlptTlR5NmtHMTNqclVkV2NVMWs2eWk4ejcxc2o5RkpudmNK?=
 =?utf-8?B?N0R5YkNJMmFwT3F6WG92R1JoM2RiQnVXSGV1TTdlYis0SS9uaFp6cWJKSmFH?=
 =?utf-8?B?K3g5V0J4bmgwMkVzUDRVQXEvZk9nLzNDSW9KOGYvNkVZYkdRVGM0amxUK0xL?=
 =?utf-8?B?amt1TUs5S0IrTmFVUXBvRGw1eHFxMmFudkRLaHFQUzBvOGpOTUdvRVhFS2lq?=
 =?utf-8?B?UkRtK1FOcUNYdjNBaDhTREdDeGJZMkw0SVBYNDBVenlDTXJadGNndjZBNXFS?=
 =?utf-8?B?VGJDNE9xOFhVWUpBU2JLTDZRZ29aQ2hOQ1RGVmhkNTFOb2piZ0pqWWdxMXNY?=
 =?utf-8?B?TUU2RldGUFJTbkppT25NTXh6c3h4TGNWVUR6Und5SWt1Z0twY3UzbEVVT3hE?=
 =?utf-8?B?Q3Y2TUJzY3RSdVBMZk1vYkFtWldWTDNoY0hOMVc3dnN2anFEM3A4d3lIZjZ4?=
 =?utf-8?B?Vy91Nm04RlNNTGxhaGJvek55SmpRRDR3MHQwaE5ibUgyWEFXMHlOL1Zva1lQ?=
 =?utf-8?B?RGhEQjhKUm9pbWU5UVFzSjlNeGh6T1g0QjQ0MFdNaGc0bWM1a0J4YUVyRURw?=
 =?utf-8?B?STR2OVVzUnI5cVdFVEpaWTJZZUx4VXFwWTdFMGx5ckNEekhadVo0dE1ycS9H?=
 =?utf-8?B?bTF1WXJ4YWx1bHQzZHdrc3QwckpDOXpSdGtqeUQybTdkS1RnNUptWjVkcnBJ?=
 =?utf-8?B?RURPUHVtVE9pU3hQakl6a01tc25DMG1mS3VFckxkOFQrdHJzL2xzMG9sSjdM?=
 =?utf-8?B?Wjlka04rSWZXSmRyR3JhOTdRUEMway9mWkNLcXoyUHU4dUR4S29Nb0JWSGo0?=
 =?utf-8?B?OFYyVndkWUpYUnpsc3p2K2hHdTVZR2w5R2J2eGxBbGhJM2dIbjRmdVo3WUNT?=
 =?utf-8?B?SG53bVdjcUpNaXozck1lbzVPc1lNVXRGMHg5RCs5KzkxNnA2Zk5uZ1o2N04z?=
 =?utf-8?B?Z296bDRUSjJVWGd0MGJnTTkzTG9NOHdOQ1lBSUUyUVRNNnJrUnRjWldOWlVa?=
 =?utf-8?B?VDQ5enFuZVM0aWdieG9sUHB3Qm00RDAwNlArZEdhalNYOElubjY5cisrR1Ix?=
 =?utf-8?B?eUFkZm9qdDB5SW5BcEJCaGo4SjJSSUJid2IwUldtUG0wZWpwN3FRV1E0RTJu?=
 =?utf-8?B?UlZ4cjNaeExoYWtsWlhMZHQyUkFKaWhucVo0d3U4M1NEc3phR1hSbHQ4cnY0?=
 =?utf-8?B?aVN6Q2tiVjJhZTlLK1RQUFlnQ2I0MlNpZ2lKOURwTjJrVkhVSGlFK2pMR2sz?=
 =?utf-8?B?RTNoK244ZExSOGw0T0N4c1JFRkwxY0JHOU9BS0ZzK2NyWTFLbWZ3MGxKVlZC?=
 =?utf-8?B?bTBVRW05RlpiRkRLeVNnb3h6SGpnT1htbWNxaHRFYjRjRXlva2NFMVJBTHpB?=
 =?utf-8?B?QVRzb2V6UlpGOGtJOU44MzdLMGFqbnBGTVhmVlM3TE5EOGRFTldncDc4OGlD?=
 =?utf-8?B?emR2bU45WHhPV1RBcDVpd3lWczhWakFadVhXYkd5Zy9CZjF2MEFDcERkR0k0?=
 =?utf-8?B?bGRPUGovRWNLVWdhOTJIeGpPYkdmVDN1Nm05dHhkNk1OVElKNUp6TTZKbWI0?=
 =?utf-8?B?RFEweDdjNUJlQi9INWJXdy9jeFE4d09sOS93YS9hN0o2bDNhMndYK0c3aFAx?=
 =?utf-8?B?TDkzUmI2NFhObVF2b0hpRU1HY1NNL29iTlVKc3pnTnl6bnYxYzNhWG1XZXh0?=
 =?utf-8?B?ZHR6b25ONEtZZ0EvcHJsb3ZMdHprYjZMS1cxaXloUlhRKzVXd0RhT05UV3J6?=
 =?utf-8?Q?ioIaW4SkvsaNGnarLe1PTjIq94qmHvwDqGFQbxe0e6Jk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64fed5fd-ad48-45ca-2225-08db8a3c1f42
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 22:45:03.1580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONKPlswKSheHFF3k9C2qKW1iKvoeSLkbPpo72sC3uDJBFGmLyWpOSCSHoKDV8cw3kuLV9uiIjlbc1A8DDCNddA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 9:54 PM, Jakub Kicinski wrote:
> On Tue, 18 Jul 2023 10:52:39 -0500 Carlos Bilbao wrote:
>>>> Fix encountered compilation error in tg3.c where an array subscript was  
>>>
>>> What is the error ?  
>>
>> drivers/net/ethernet/broadcom/tg3.c: In function ‘tg3_init_one’:
> 
> What compiler are you using? Any extra flags?

GCC version 13.1.1. No special flags.

> 
> I remember seeing this warning too, but I can't repro it now (gcc 13.1;
> clang 16).
> 
>>>> above the array bounds of 'struct tg3_napi[5]'. Add an additional check in
>>>> the for loop to ensure that it does not exceed the bounds of
>>>> 'struct tg3_napi' (defined by TG3_IRQ_MAX_VECS).
>>>>
>>>> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
> 
> We need a sign-off tag

Apologies, Signed-off-By: Carlos Bilbao <carlos.bilbao@amd.com>

Thanks,
Carlos
