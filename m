Return-Path: <linux-kernel+bounces-8138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6256D81B284
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10218283747
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03698219FC;
	Thu, 21 Dec 2023 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KEcnAPzc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7D9208DE;
	Thu, 21 Dec 2023 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePi09wAFvw8gZuCyaRUOd/7iRnb3HhABtjjqWI3J9ZGmlvSns2cASSXxhybAdaQEkv/ojiOfPRkajlKNTs1eSMYcr9IjfsslbtSXD0W8cWUdSehxWKlBmLhxrLD1SmXxeODBBnbUH+VHYQk2TT5G27SCEJymr23GjmHNyU5IEEB3qvXvNlAq02+Vg/+ini/cLNL+213rV2Ojhrb4gbiIafYRbMI4vbAJIGNMjq44OsV/MJBda3cI5/dkZWw3HtCOd/rCTxeUkENPGzYPriL/BHmKWGeTqJuxiYPkV6Fm11uYclElo3mLPFpWWIbXhUqgOpbMmegK5rcJGHeL/Uio3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWkadBbnlmHP6LcXAovQ4CiGKvMG0YDUbC7zyCRvPsk=;
 b=Nu1Mr/qKipVUOY0tqeHzilKTjzOPtLitnVthFVW7QN8wnL7n/YpC8GPT1l4SmDIE7iNrrFlS+BsUs1naJi9IezDVlHLNTUO0pPLxBdglG+WW2lFAGjxWTLOirAcqW3bcIcQzfIouFPxu6deMxzBSpZfx6c5NLAwkPdBsEioo8nXfB1DfcPdUraAp69O0xi0daHLHydk9RIlAfwNUjYspeNZS/gVC9FCxlkLQ5TJ4i8khJt9B59xaAsS80twx9M/u5crY4CYRpMNV31dIoZi1QosXVc6tHXzCOwK+KCTm4tQWUgXcDvvtsN7m1IKBi3LgFh1hcVqvuV3EDZfFSl6pHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWkadBbnlmHP6LcXAovQ4CiGKvMG0YDUbC7zyCRvPsk=;
 b=KEcnAPzcOU7gW/YSl38IS+I+17RMbDYZNkWuHs9La3PpZ5hkvojEF7xiwN37N6MLgXYwsQQRbwg+p12F/QZ+GttpPOp3lOqiTClg2u6FRWlJDzv4p9tO1n4TAl2yqEAksoT0KRKxXgwvGBExTxLfdpMdCbkHsGiAqXqhjBUfwgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 09:31:59 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7113.016; Thu, 21 Dec 2023
 09:31:59 +0000
Message-ID: <257c694f-5aa2-c29b-891d-3a1f480dd4a1@amd.com>
Date: Thu, 21 Dec 2023 15:01:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Content-Language: en-US
From: Sanath S <sanaths2@amd.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231218104234.GB1074920@black.fi.intel.com>
 <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
 <20231218113151.GC1074920@black.fi.intel.com>
 <20231218122312.GE1074920@black.fi.intel.com>
 <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>
 <20231218131840.GH1074920@black.fi.intel.com>
 <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
 <20231219122634.GJ1074920@black.fi.intel.com>
 <0816caa4-81b5-d0f9-2305-80c7fec6abb9@amd.com>
 <20231219180424.GL1074920@black.fi.intel.com>
 <20231220125857.GA2543524@black.fi.intel.com>
 <5bfaa405-b15e-36ef-a4e0-04b93dd983b1@amd.com>
In-Reply-To: <5bfaa405-b15e-36ef-a4e0-04b93dd983b1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::14) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b0c508-3860-4bbe-3fb7-08dc0207adac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YLJhwkW3TmWHwPI/U1xGenQUdhlKAlQ/zhuiP0d/sMDCogAtejGeIw41yc7KxRAQ23Oa6Lj02zlEnkBFgvqjQPAi35QNyfxuVcabCt/TSUXIXDjMTwquSw/vGGrFbW3Jbq/7U6UrvA4KlQPHalj+l6SwVDP9KxE9cEFExQwKwBNPzO6XNsR6iXkx1dlQESCGUAMJRU9m5ZZaxjSYNdIWqZjBQM8oXYv5DiBi+oOGdGc+pv1CDrq+viP1JHiy8l7jZisu8HqqdONvXMkAb8H1WJfziyr7p9AZMr32CAysNa6Vn3IIdZMG0XKCtBgIuHVY0kdAEB10QKkgwyDvQyr95LnN0VGRZz91GwB2p/7IT6zAmvKz4Yw7/SW/shCPlQ2rBhtV6uRTY09HrBl3smxv5OUHQLoPpukAeOTxm9g65sZYE61+Jt5N1R2wY3OpCG0vI9NGYdAIxeLRL6zK3GF9iifWDmVt1hEKm8dTYM6T5v6brvp1kyJKITt+zz6hleykEzNKT0DlxTnpf0OnISXYeCmOCSlPCCS0rGjjL4iT3fV/sEfn2pSVNJB/tLLOi7bFjwMQOifT14GpBKTo3ubkoDQxSH6LaTIXbZU3ElCTuzMwWVZGHeJ/tMdKeU6ISBeDMZVhSINz3ph4Z3YKdXTfMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(6666004)(6506007)(31696002)(36756003)(53546011)(6512007)(478600001)(83380400001)(26005)(38100700002)(2616005)(41300700001)(5660300002)(6486002)(66556008)(66476007)(66946007)(31686004)(316002)(6916009)(4326008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFlQYStDbkd2ZzEyNnB5K21xdVhwNmp1Y3lCSnFiMFlVd240Qml0RkJjMFlt?=
 =?utf-8?B?SjZrbDhkV1UvUUU1NWFiRllzN1ZSMU54YzhOVUpCaS9UTnlMbUMrTUlJZWcx?=
 =?utf-8?B?WmRMd3BWakQ1dzNlRUJ6b25yWVczdmI4THhBNnZ3SXBsejdWRm1wK0RuRVdT?=
 =?utf-8?B?cVlkejViQlB2YWZRTDZ1NUZMRUlFRUsvZnU2cUthdy9pbFdzYlVyc2VZZUQy?=
 =?utf-8?B?ZEpJRG9Lbk5PRnJHWE02QkJkM1Q2M3llZUtFSEZLT25PYWVFeE1mTmQ2N285?=
 =?utf-8?B?alhpSmcxRld3eDZXaGtHYmwxUVJKckRIeUZlazdNcVJ0b01wa2FYaWVrUm5L?=
 =?utf-8?B?OTFaY3lxb3hDVEg1eEs2Z2ptS01uanorNDl6cHJDbWdPUU5xVjVYSnREWnZv?=
 =?utf-8?B?RjJpMFBlZE1MbXhUV3pCRGJvNWs0T2lDdWZlWFJnVU1pTWx2Ujg0ZnZrbzJ5?=
 =?utf-8?B?TUJFbUJWMm1OWFp4TUJVcmp6V0pzRjZidEloTmlXL01EbjRhcXQ2aU9Kcnd2?=
 =?utf-8?B?ZVRiVjZ4U0ZIZWwzcmlQbVhxM3hYa0tkL1QzdnoyWTFjN1dTcFN4aXVMeUVH?=
 =?utf-8?B?SXlkenRSVy91aGJtQ1VFVkl2YXhuYlNQZDBTZzU4andkd2NQdTVOamEzamZV?=
 =?utf-8?B?MTZ4TGM4S015cnZiL3pST2V1M2tCMjlCMVpJTlRWWUZ5aytmeWVuOUdsNWRv?=
 =?utf-8?B?amxtZDBMb0NnZEh0V1dsM1M4a2NPTUVSZ1kzYU8yKzF6RUtzekZrQm9PRHNM?=
 =?utf-8?B?VzFISXpHcWZCREFKNVpxU0NCRUpQdGY4Q2tUbDd6TVBQZmgyZWpjT0ZhaFVE?=
 =?utf-8?B?eFJKZWQ2eXNGRUlENEZhTTc0NmRnUmxnanZsalkyR1hmWDJmVUJWOEliVVpa?=
 =?utf-8?B?YjdPN3p1MjNwS0RWa3JMckNXSWpBSTc5Y1o2TUtveW1DaUNFalVudjI5UXNF?=
 =?utf-8?B?NmNOWHV5dEdiWTN2Z0FucVNMUjZHMVNMb1BqdWhEdUFWUlZoeTFkT1JNT3Yx?=
 =?utf-8?B?MHlOOUx2YUVPSTJKZEN4dVFEOEpvRjlCUWpMYmVQNlF4YzBjN0xCTWFaVWhn?=
 =?utf-8?B?VEFiWm15Vzg3RDVlWi9OS244M1pWMjNNeWd2d2ZrUldaU29SVVo0R2lCOUgy?=
 =?utf-8?B?d1k2VUYvNjVGVVhGSEtPenRlMWJ2c0FITFgrQitMalk3dnVObGQ3b2FvL2Yv?=
 =?utf-8?B?OGJkMWtFaDFzZ3JQREloUWlXZFhDYU5lQllFQlVKbUY5c3pCNEpCaE9qWEVP?=
 =?utf-8?B?NGtMeWprbitzaE43MjBnbjQycUI1eitQQldRdFdTbE9QbXd1RE0zRU1qTWJO?=
 =?utf-8?B?cFVIOXk0LzE0NTQ4NDRPeTZxMHh1QzlNdDlVSVpqUmFjMStPeEdId0F2N0xF?=
 =?utf-8?B?eGNYQnpkbFV3RC9PQWQ0MS9nUktOSXVLeThtcjA0NEJGWDdsWmkyeG9rT1du?=
 =?utf-8?B?OFBYMXBpaEJuSWhSTEZUQndLbUxWK254NzNqVUd4YkNQRHB5ckNpd0dQTW9q?=
 =?utf-8?B?R0VpNzJxa0lOUXBoWFJwTjVBZzhaUXgzZW1ldEtTSVBVVzYzQ3BUNDdDbVNn?=
 =?utf-8?B?dlFyOGhwS1kzU0g2aFAyanl6Zlh4YVZrQk9xZlZ2bUFCcGNSV2RwdjE0NkUv?=
 =?utf-8?B?S1hhcEVNY2d5TTdxd0ZTSUFlVlJEVVlOK3phNjNldWZYN2NQUkxJVmRiTDRJ?=
 =?utf-8?B?VklZY2ZBS2IwN1lsRVFCN3h5a2J6Y2EralpwRVpQUE9pYzhONmZjaFNpN29a?=
 =?utf-8?B?eFNuVXFUa3B3cWFuTXNwbHgxRUxrMzMxL1lIeEtRUlQwYkhhejE3QWJhaFVt?=
 =?utf-8?B?YXVWNUVUUUpxRzNCR2RWb1BEV0hYZW5XVm9wRFdTN0ppZDRqemRFYkVKRGcy?=
 =?utf-8?B?UzR3N1EvZzM3ajBoQzRJSkExc1NSdmJZZGtkQ0hHb0NNQjd5LzVKVGt3STB4?=
 =?utf-8?B?cS81SE81V2ZoNnp4Tm44T0JJMlUva3JDMXkycDc4bVhjQ2wxVHZwZXdManA5?=
 =?utf-8?B?c3pUKzcrMFVObVBuVkNlaUdyRllBb3NXSnhVYnd6ZkpiQThBaFZSTUlMQVFZ?=
 =?utf-8?B?NTV2TDM4MmdkUWpBaGNPTWFqZE1TVFZxMWo2emJnWnpoT29DSE91aFd3UW9Z?=
 =?utf-8?Q?zPK/1VHL3r4RUtQ0cwdMHu+h6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b0c508-3860-4bbe-3fb7-08dc0207adac
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 09:31:58.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NCdIkWDG3PxhS4UeVrEj7GqojTsDgLJDQHyLfi4Uvg3IvyZ3NVdzSrgGAbrznQYrbjFgsu8x/oKoZjm2xk2/nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242


On 12/20/2023 10:31 PM, Sanath S wrote:
>
> On 12/20/2023 6:28 PM, Mika Westerberg wrote:
>> On Tue, Dec 19, 2023 at 08:04:24PM +0200, Mika Westerberg wrote:
>>>>> One additional question though, say we have PCIe tunnel 
>>>>> established by
>>>>> the BIOS CM and we do the "reset", that means there will be 
>>>>> hot-remove
>>>>> on the PCIe side and then hotplug again, does this slow down the boot
>>>>> considerably? We have some delays there in the PCIe code that 
>>>>> might hit
>>>>> us here although I agree that we definitely prefer working system 
>>>>> rather
>>>>> than fast-booting non-working system but perhaps the delays are not
>>>>> noticeable by the end-user?
>>>> I've not observed any delay which is noticeable. As soon as I get 
>>>> the login
>>>> screen
>>>> and check dmesg, it would already be enumerated.
>>> Okay, I need to try it on my side too.
>> One additional thing that came to mind. Please check with some device
>> with a real PCIe endpoint. For instance there is the integrated xHCI
>> controller on Intel Titan Ridge and Goshen Ridge based docks. With TR it
>> is easy because it does not support USB4 so xHCI is brought up
>> immediately once there is PCIe tunnel. For GR (the OWC dock you have) it
>> is disabled when the link is USB4 (because USB 3.x is tunneled as well)
>> but you can get it enabled too if you connect it with an active TBT3
>> cable.
> Sure. I'll check with these combinations.
Can you name any docks that meets these requirements ? I'll try to get hold
of it here and check.

