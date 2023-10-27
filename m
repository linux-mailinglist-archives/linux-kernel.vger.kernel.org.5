Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C606C7D8DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 07:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345104AbjJ0FFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 01:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjJ0FFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 01:05:48 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092831B3;
        Thu, 26 Oct 2023 22:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dmy2a8nknQvP8nv+DdpkhdQgXQFO6yqY62DjBY+TZ9m7P336pG6c7t/nTNjCf2Q0ZNtZ8kLmdQ3/6xu5M8qF18+hhrwG3QL20xnoZCpj4VuhzcRkXK7tjp2bksp4x4i1iVpf/m/pA+SLAb8GP/onGBwOXP4H+IOEJQKoCfMJ/8xNZN8E7biuygFq/2lZz37iPjGtzoAcywPslNq2i3TwCugJXAOLYbaMJTn1GWCNxDeGSp7AYqcr+8a3x9mO/EOaXRzwivwMwojaGito1MSmg5z4VYC0092haJvYROiJqhCbg0NuiMEGzoViT05Lfx4+09HvAWhwxAy1nx/c+ftzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2K6gj88dBi8ehtgGrg7VZ4FwTXBqyhc65RMvhTbS08=;
 b=b7Suzhl6LgfSd4l/jb80RAOiI0T3U+2XLPnMuo6+Exc9qj7d4s4OqvlPC308JVvWNUJIpUWi34L1KyQXksuihDt3MX7wP+zYTRdHnu2GwSkIPcLjZYPZQwcZUV+ky6wV/t4JNDduALDwAiy1t78GxTTI7Ha/uLrJVSiLi2foVQ7xBKRA40HBTARkM8CEw/wq2J2xMQEQwFuEDB/HIJ6ebnKTRTCxJreCHNbMCaSaFp26kWLZ7+TtwpH9pHpJOUjlx6VKZ6VNjFyQSGTUS3P/y8N1cXX9BJEU51lRY5q38mIAXpSTkA6RV2tuhBS+R+qeHU4GclRZyXbd+sBzk5d95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2K6gj88dBi8ehtgGrg7VZ4FwTXBqyhc65RMvhTbS08=;
 b=ENfzeKQkxI1Hva39P1xlK2o7CUMsXS43Z0hF0MO6aCYqcY+H8T9endlDfeD5tTeu/b3952uJICoLfgfbW47nN18a5CsqODvHbliA/UVcFfge67xEcVffqq2B4jX3wA9ymgKrATa/16qZHceZhj1DqVkCYXIEuKlgyzNME/zWHqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:b5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 05:05:43 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48%6]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 05:05:43 +0000
Message-ID: <ba6eea97-116a-4678-7800-d24692c65cd6@amd.com>
Date:   Fri, 27 Oct 2023 10:35:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>,
        Avadhut Naik <Avadhut.Naik@amd.com>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-2-muralimk@amd.com>
 <20231025190818.GDZTlnomnaT8zxnbxX@fat_crate.local>
 <b3b21eaa-226f-e78f-14e3-09e2e02e38d6@amd.com>
 <20231026111448.GAZTpKKLI6LG1/COFE@fat_crate.local>
 <850a3e78-f663-c696-2141-7aefb043b6da@amd.com>
 <20231026123754.GBZTpdojw+pNuZMyJy@fat_crate.local>
 <dd13363e-fd7e-4e88-8c23-91cfffe11dc3@amd.com>
 <20231026134016.GDZTpsQDYU4Ll6sAA3@fat_crate.local>
From:   "M K, Muralidhara" <muralimk@amd.com>
Subject: Re: [PATCH v2 1/4] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
In-Reply-To: <20231026134016.GDZTpsQDYU4Ll6sAA3@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0037.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::12) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e5af5b-37b5-4f2d-cb50-08dbd6aa5eba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6kuOlfboQRiQTtxWbjQC4ZxPVG2Ynr3TJXvk6YhHUvNjspaPQDmkIqkAp9fR+HZr0YXLl1i/Dgt2YM1/RTHuC+l4KA6hGfqx8FjxsSq9SxKvxDdu6pD2OX8Rnm+X0DS9ENIZssKk5mCcKgZyinOUYgma8j1kpvtZGNAipTsVztEJc8UszzB1iYm/dL3PlvQ9rM6SAqKfAm+gsGz3QVhfpnlcQNqJ6yzpmeHD8t8NHn+Y5AdEAdnAfjpWUAXA0ttvhzTviRxPesXmJfSRwofAblrJX/XnHTZ/coCQ2Xh6GV78iesA5rAbS7U/cSdiuKIsvVKWJL3fH3LrMGWrsooFbSTr5Edm7Kuv4DmbI8f0H0ujIHJDuW+GB86ziPLOb3GMjdobBWWKDfK2ojajUnrNlifbWgOlJDZNyZHMXvEb0uVPw9aVud4m7fu6NGPO95EERhYCPoOui6B0QECmcon46xPqpbDYvPil9Qqq0tq7ge2JihqBXKOaB0kZXpLBi2tpN5ChrKS1FWCcacz06UJXAW52ed9Sd/5NQBNOJn0d9obOFggGypueg7Gzu/iuAYGFdPB8UFcQrcs9rovEp6YGFnaht3h9y61YhiU2dlS6QqVhcrSBTpiPU1ovux3GunmtbZf3imEZj4N0JY1ShaDPAK0ip21ymk4GEPsJ6xFOFzqfZ/v3i+9o1OzMTjNiWPi7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(346002)(366004)(230173577357003)(230922051799003)(230273577357003)(1800799009)(186009)(64100799003)(451199024)(31686004)(41300700001)(31696002)(38100700002)(53546011)(83380400001)(4326008)(36756003)(8676002)(8936002)(4001150100001)(2906002)(5660300002)(54906003)(66556008)(66476007)(66946007)(6636002)(316002)(26005)(2616005)(110136005)(6512007)(478600001)(6666004)(6486002)(966005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVVtZnRLZWhDZkxWL0tvYnUzclg1MThjbkpKSXVad2cxS3REenhkNmNuenRk?=
 =?utf-8?B?MzQxZW5jcmhmVEZwbC85UklUcW5iVSt0aHZKS3B4R1dtdkdzUGhDZlMwMVpD?=
 =?utf-8?B?azY1SjRtV1Q5and6SksrczZnNEFqNkFNZDM0MEw2RWRYeG1mNGFVUUdpL2hV?=
 =?utf-8?B?eG1NTkJaSWFSekpDaXdGa3ZZWlNob291cWpZZUVZOEZSUXVncHQyRzZMMnVj?=
 =?utf-8?B?bitUeEdXQ1ZEU050Z21uMTVTcU85blY5L2E3UGRhNXBVOWJYV09MZzBkaTlh?=
 =?utf-8?B?RU9tc09yOXFWVzBFc0hHK2dtblZ3VzJ0MFliUXY4TFk5VWJsY1I4dG5Mc2VN?=
 =?utf-8?B?QlBwZlJhVVU1N0NaZnhhdE92bXJML2VaaUJ2VHZTYmhJQ08vc1ZDRjlpL0Nq?=
 =?utf-8?B?d01JYnNMWjFUVHJsZEQ3SGw1TzhScW00ZERmcWtpUElBTzNJUTA1VXQ5ZHpZ?=
 =?utf-8?B?VzFBNzdqdzdadFNIb0Q4bHQ5MjJRR3B6Vmk4REhYVDNldk1Rb0hTbmMxQ0Jn?=
 =?utf-8?B?NlgrcHlWaDhxYXpWbWwyWUltZTBTTUh6NkUvUERCQU1ZbGdXRTFlTlBLa2N5?=
 =?utf-8?B?cUdENXFTL0V0OVhtbjcyUjhkQzFoYUR1dkdWSGQxNGpuL3lSZ3BUV0dENFBa?=
 =?utf-8?B?TGdQL3dWUnBMalpYclgyeHlCQXVab29UakNNbVo0VkpoY0FiTEpkTmRzYmpB?=
 =?utf-8?B?VUw4WWVPL3FWeWE1VTd3R1FqOVNHRXBKNmNvZ3IxcHBxd0xXcDhUTnh1Rnoz?=
 =?utf-8?B?c1VvMU9lOStNZTV3SWtmMEk5NDdSQmpYdHgrczEzaUNrd2FTMUNmeWdLR0Nv?=
 =?utf-8?B?Vlozd0Q5WndmQ0tyMHJLRVBZamdGeTFVdGV5aVh5cStycTF0MnU4eURHTTNQ?=
 =?utf-8?B?V1NjTjZWNkFvdUlQd0tUL2JLczNwZmRYSkVQWVQzV1pDeFBnYlA4VmhQanRx?=
 =?utf-8?B?Rk1pMkZ2ZWdhd1lEQmVjQ3JLR2hFNzlIc2sxQ0JUYktCQitPM3EzSXI3NFdP?=
 =?utf-8?B?d1RTdTdSb0tDL1h1ZVo0b1dLZlpEc0lxeW1PUGdZT2VtQnAxR2ZjTFBzOXo0?=
 =?utf-8?B?eEZRaTRlelQwZHg4QzRKMCtxR3BVWnU5VG40eWM3K2VCUFF4dFZUNlYyZGZk?=
 =?utf-8?B?clUwY0RTOEtodUpXdTlHRmU5aFE3dnNtbGJoRktFMXowSURzVHhuVHRvcS9v?=
 =?utf-8?B?WTJwRDQvbFN4OVJtRnRxUUtaMDdvSG9meSs2Rkt5UnNRbks3SGR6c0JsNHAw?=
 =?utf-8?B?YjA1R1BscTJOVHQrT2tyRlJDQ1NrY2VBSlE0a25zMUtHUHVKbENoUXdDUktH?=
 =?utf-8?B?cVpaTkNNd3U5eXkvd0tqNGhtb2RvTXRtVUFWL2w0eUtxVlJocnkrVWJjeStm?=
 =?utf-8?B?WFI2aXQ4U2hZai9ackdWVmdNSTFJVGcvZEdJMXYxbmRtZVJNU2hQNEJNL0Y5?=
 =?utf-8?B?cCtISU1GYUl3UmV4dHZNbXFzQjF0TWZTUmhneTBXZUpXcmltVmxzVUlORTc0?=
 =?utf-8?B?TDFzUlRCL0lTTWVidXBoYWNxbjN0QkpXTWViWmtqRi8wb0ZCWkQ0TUJlVXpz?=
 =?utf-8?B?b0hLTHBNb29GT0xHaFNMb2ZIRFl0N3VhUW9USno4WklodGlaRnFrQVZpRzRS?=
 =?utf-8?B?bFIwUGZ2YUhrWDEzRnIvaHk1MjdleXo1ZEREZVBrdVhzcWNmTDZUZ1Zrcnow?=
 =?utf-8?B?OFYzUUNUUDRETjhRL0VZT0R4ZDQzOWoxTTNTbjhlOW95Y3hUK1FtN29rVitv?=
 =?utf-8?B?SjY0ZjdhZ0xnMnZ0NjRRYXM0a0FnVlhNd3pzWjAzeHhpa245dUJUbnY2Q3Zt?=
 =?utf-8?B?Nm5vbDlhOVhJb3ZTZ2lIcEJlWlFWd3BQUjFVY3M5M1h2NlE1Umt6aEtwWHJi?=
 =?utf-8?B?bHU5aHNrMzJZMjFmOU9HSGFlZGNIeEppcWFXMVNkbHBJekUwWTZ4Z1RTdWNh?=
 =?utf-8?B?NkFEY2pDZEtPRkUxYlJIZ1Mza2xpS1BBZWhOTzExMmFpekZwQ3ZwSUJyVFEv?=
 =?utf-8?B?WlRwT1p5d05PUTlMMEUwWEwwVmltN1Nlb3lhOU5FdnZTMWdSWHZabW5yTGVq?=
 =?utf-8?B?citXeWFNaTEwL1RiRDRYUG8rS0JOcDc0OUw0SWExNDZrS21XUW5HamRNQXU5?=
 =?utf-8?Q?N91+irnSLiXW19UlgAa8HTNIP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e5af5b-37b5-4f2d-cb50-08dbd6aa5eba
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 05:05:42.8920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zgPL3EBmE35ps3ND5/ih5Eb+pZcTvZLMY0pBLlZ/smTWrLgAK0PNHIdoRyPiE0E4UlbCpHQSXpzD7olG6coZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2023 7:10 PM, Borislav Petkov wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, Oct 26, 2023 at 09:05:51AM -0400, Yazen Ghannam wrote:
>> Post-processing is one of the features that Avadhut implemented.
>>
>> https://github.com/mchehab/rasdaemon/commit/932118b04a04104dfac6b8536419803f236e6118
> 

Hi Yazen, Thanks for pointing to this commit. Yes I do remember.


> Yes, now try to decode the error with rasdaemon this way, by supplying
> the fields.
> 
> Then explain step-by-step what you've done in the commit message and in
> a documentation file in Documentation/ras/ so that people can find it
> and can actually do the decoding themselves.
> 
> It needs to be absolutely easy to decode those errors. Not tell people:
> "go look for the error description in the PPR".
> 
Yes, we have offline decoding option in rasdaemon

For example:
$ rasdaemon -p --status 0xdc2040000000011b --ipid 0x0000609600092f00 --smca
2023-10-26 23:51:34 -0500, Unified Memory Controller (bank=0), mca: DRAM 
ECC error. Ext Err Code: 0 Memory Error 'mem-tx: generic read, tx: 
generic, level: L3/generic', mci: Error_overflow CECC, Locn: 
memory_channel=0,csrow=0, Error Msg: Corrected error, no action required.

Observed the error string "mca: DRAM ECC error. Ext Err Code: 0"


Also, we can pass particular family/model to decode, Ex:for MI300A

$ rasdaemon -p --status 0xdc2040000000011b --ipid 0x0000609600092f00 
--smca --family 0x19 --model 0x90 --bank 19
2023-10-26 23:52:09 -0500, Unified Memory Controller (bank=19), mca: 
DRAM On Die ECC error. Ext Err Code: 0 Memory Error 'mem-tx: generic 
read, tx: generic, level: L3/generic', mci: Error_overflow CECC, Locn: 
memory_die_id=1, Error Msg: Corrected error, no action required.

Observed the error string as "mca: DRAM On Die ECC error. Ext Err Code: 0"

Thanks for the inputs. I will add the steps in commit message and in 
Documentation as well.


> Thx.
> 
> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
