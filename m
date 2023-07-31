Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FC576A04C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjGaSYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGaSX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:23:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC80719B0;
        Mon, 31 Jul 2023 11:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm7i23516Tv7MpYmUzIVaUZPumzz7OXp5yU/vriRNpJmFTa/7RzKAhFwKZIGcvZsNtuZNKq9QUulCjqbzyXQCMEca30/+FpZRD5URM8vUmzs9G7uVTbb0MnAduJHO8WXVB0Qjc7bftKcKflxXeBPjR2TiBnjf4wGBO6GLy81Q5bnpJnyLf/5Lzn/50r2t9cmyYZvqYM2rn/x4aOtoGsNrqN9ktM+QByggNr1Y1iOMzlbHXrVEqWkb+gAg+4DPZgOUnnzV69bxQ2VfkFeepj6XdbTo6lAemXnEVTXqGyvHV7a2St6ojPpC+UlmMuQ4BGREBUfp03KlE4YMBDqZxUgbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWHcWiDhdEztOc9nkLoFd1pEpxlbnCIEfFgF2rdItP4=;
 b=dqtPZyZ62BkH5Rdhah06Ko+m7BMjaNRaQIG5MVwMWG6BA0OWRaAnkYgfqjlr1yd0QrRPJeQUd4DVV8VxHIIKbV2jyWJnvnP2oEFbpfizmquqdnbTvT+L8WxySm5e2Fcd+7tQf99ngDuUDoOVQXdRuKmwHvsz74oVG1HFLSreHo9NkkT1Ls8HL7L4raLiZJceLp8tYcdSe7gJSayZtLVPASbAqbDqvQnQubw5KMRx/fVZnV4Ka6CO/XdQNnJf4lqa/lFFiLrmGL3Ams1g37q+I09l3qVqOs0fvqaI1ogA7I44Bvvl+gpZvGMQw4I1u+zL2Uy+XZqWBSz8ITa5rdgodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWHcWiDhdEztOc9nkLoFd1pEpxlbnCIEfFgF2rdItP4=;
 b=erbgfLHp2porVoqwX5xlHmSuTQ6MKKs2JRscmmjjM1uVispWDPuXqRe1SnetIdwzfH318T+JdoxlanF70W0Y72YKESaSN1rHt+hrDkB1xY1EFiYZN84rw89vZHtX4xGXrlLbCIuFyuvf1JRlytfPDaqrYtV37TXqbfdVmlblVAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7936.namprd12.prod.outlook.com (2603:10b6:806:347::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 18:23:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 18:23:50 +0000
Message-ID: <673bc252-2b34-6ef9-1765-9c7cac1e8658@amd.com>
Date:   Mon, 31 Jul 2023 13:23:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Error 'netif_napi_add_weight() called with weight 256'
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, hayeswang@realtek.com
Cc:     edumazet@google.com, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, davem@davemloft.net,
        linux-usb@vger.kernel.org, pabeni@redhat.com,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <0bfd445a-81f7-f702-08b0-bd5a72095e49@amd.com>
 <20230731111330.5211e637@kernel.org>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20230731111330.5211e637@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0035.namprd04.prod.outlook.com
 (2603:10b6:806:120::10) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: efd69008-f867-410e-ac75-08db91f3498f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MlAjD6gI9+uUC1k32NY0fZNUNP8KnwPxC10BV3ndW43Jqm7atosJyIfCHyesDGHYs9jsfe4coWlLx6Tlb7iebny2A7ySOKH/wy3ljIOf/6otI67nmYpnAzTaCqr5InADmjKd99wWCsNMklsUyAorJ0UWB0RM/DOFQX30k/SpiV5JFXw4eesCUEaF24L9ulcfjAl6jVr/gEUeAwpX0DhDUaJh+6+XldoW28fum7u+y/nHDKhJmw7EnrkeboWuMeQoAznpGSvvC46a0k/v1A5xTc1ocUBb8EHSOA74pEWkn6DuEZ1QXCyzD1boszF2V373QtopgPzfxViyeiqGqADJV71AuX37BcqjjbowsZ1J1qMH9CV/3DMr/GetezRJ5JoA6VlgtqRMoOcohWitHh2x1GE8DomGzTmwX33Sjkmvm9CNZ86OWDY74gfevDwzTPMqqsamP6eUEmRXCsaani8Mtorc8ix87yUvx5aeMlp5zP/aKpEYWbFRMjYDe26OJi4Daocsrz+Byl91lB+LhgPkjzncV3hI8HfJvOfUIiUDYQFvxaMl1eiSo3FS1BU8J1h9B02f/NTVYQQC19TFgkg0DCDL6I7GNNjh/CEC823HQHZAtaMVGKrkF3PepB1XwU7o20qpuZK4KVpc2AcGvF8D0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(26005)(6506007)(83380400001)(186003)(66946007)(66556008)(41300700001)(38100700002)(54906003)(31696002)(86362001)(66476007)(316002)(4326008)(5660300002)(8936002)(8676002)(31686004)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akk0TGlzeVdyTE5LL0lsNWdJMjdxSUdFS2NUNUJNVytpNzYwSGJYVHRJRGVQ?=
 =?utf-8?B?RVFuQitkcmRIN3VQdE95VTVZRkxDRWlkcDZySkoyVXVFbDBQZHgxTmlvRG1x?=
 =?utf-8?B?RHpLeTcxSVFQZFlJYWM0SjNGT3ZIQUxidldudmtyWVRCbkpSTml3bi9GeUpT?=
 =?utf-8?B?bFlQamxFdzVaRStnWXRJSGJhVkYrQTlVUWpNSENVdzlvcUp1NFRScGd6b2Qr?=
 =?utf-8?B?YjZod0xmM25YT0dtanpDTE85MEg0UytxM05vaTU5Uzh5YmFNR2JGUk5lRnpp?=
 =?utf-8?B?Vyt5Y08xc2lMdGJGckc4ZUErTzlXeU9RWk1mWlZFSGwrOU93N0h1cE1XZ1pV?=
 =?utf-8?B?NHlLa3pmQXJYNzc0bHFLZC9YTU5pOUt1NDRhOEFXSVV4ckpVVVJLTVlaN05j?=
 =?utf-8?B?MGJpL0xOL3JaenZRTjJpYjFPYkxtVitSWnpCV2dPTVpSbmVtR1lpZDJQY284?=
 =?utf-8?B?elBnRG1Mc2VTWHNvQjRzMkVKMjNUemQ0RzRhMCtWRkhlVXN4T0owcTBLekMv?=
 =?utf-8?B?b2NLNmdXREw3dzNqdWlHVE9wbENtQUNKajB6bFFnQXIwemRDUnA1TlVkaFdZ?=
 =?utf-8?B?T1RzYjU5UTNDZy9MMWVJT2dPaGZTbkkvcGd3L1RQdy95Mmw1R29VeVJXMVE3?=
 =?utf-8?B?a2JUK01oUkVlZXgzUzhVZDd2RU1hSHZ3WUVnTWxJNjIwdURzeG1mZC96bDFI?=
 =?utf-8?B?bkRad1V2a0FDWlRYaGRyazhTZDA2STRNay9zaHA5SndKTjFUSHFvdmVrQU5J?=
 =?utf-8?B?MTZvbEVrcTVPTHZ5TDFpNzBVbmJvMmsySFdxQWxmbE5rNnZFZWxUUVZxck5w?=
 =?utf-8?B?dFBrMVN1TEpNY2Ntb2xQZmlxUTNzeUdMU2NJclI1WisyMTdpVmJEQ0tPMlBI?=
 =?utf-8?B?SEI2aVNtb0t4SC8rSXoyQkRhdGFpbnFDejJHT3JGRzlnTDNZRnU1SG0wbGtx?=
 =?utf-8?B?bGZuSUNtUXJGRDIva3ppNlZrTjdzWFA4eU1JSFhvWkNCTmpweStaZGs4Zkx6?=
 =?utf-8?B?eEZYWEtJZzcyT00yaWVMYWFqVmI5aGRFRmI3WEhyMXBhRkM2QVFrQXdqZmRy?=
 =?utf-8?B?NkRVdHd5S1hIa1BkN0RjdlZwRjFZSWxMWXhoZkJKZzVCOVZIRWlRMi94RDdp?=
 =?utf-8?B?SnFyNjlIZy9YOWpLbk41TDRYZGp4bURvTGFuMjdqSW5HZjE1ZmZpRjdQYWc3?=
 =?utf-8?B?SmYvMUl5L0tWSUhJWWtnbnFNODd5SXZLYVp2c3RGM1ZraHJIWGF2NFZUdjZi?=
 =?utf-8?B?YW1yalNJUlNxbEtyYURHUXVZZEYvckt5Q3ZuRmlhc0pPUUQ1cmIyeG9adEFy?=
 =?utf-8?B?MzdMZHRnKzNZNFQ4ZStXejNnSWlhdzJrTGpLZGJNUnJseHJrMDhjb0VwaFQ5?=
 =?utf-8?B?TjVOejNvRWJjMkFLREtZZ1d4Z1krUG1pZmJ3eitVNXErZGVXSXc1eEhkYThN?=
 =?utf-8?B?Q3ZHYjh2SHNKSGphRDdzRFVmeG9yVEZVNy9lUVB1OFl3My9jR3kyYjBwQUlX?=
 =?utf-8?B?QUdQQVM1eERaQTRrQVVBRHlrMjRhdVRzeGptMFFRTGFPcE81bllicjRlbjJy?=
 =?utf-8?B?cGxyS1ZLZ1lPTWlmblFTRi9XM2tXZVVkVUpINFR0UnE1cXo3UGNxcUlaanFY?=
 =?utf-8?B?Y0FyYm5RRlVUeXpER08yTk5jUTRxS2w0NWF4VmhXS0VHRVZET3ZZa1FDRkZI?=
 =?utf-8?B?RGpuTFNaOXVHK2cvMmkxazZXakd3UnhzRlpSWkhkSE54K2NGZ2lyd3VoeGM2?=
 =?utf-8?B?dmhxMVRjRndsU0hIUzQ0eUs5dUhqTUVIMXRqeDVFRzdxMFZyN2RsbEJuTFlK?=
 =?utf-8?B?Z0VCajhJS3htMmltTXRKbmZTSVhwOFpLYURCckdkc3R3cXNyNUxBbkFlamFK?=
 =?utf-8?B?VUlqMmtiLysraXdCVmJ3RWpEeVhzQlhHbmJmUjFPNFlMUkhiNm81K1dIRVln?=
 =?utf-8?B?U2t4N3hBdnBnVDZiK0RtajgySkdub0Y3ZmJJazY2VFIzc1J6Ry91RjN0dGlk?=
 =?utf-8?B?R2R4YjlmTFJLMjRZeVhPaUk2b29nMS9CQysyQWRLU3MzZU5pUS80RmRRUXYx?=
 =?utf-8?B?Rkp0cWF6MnlLaG12OGNGWkhtaks5WVVTdnM4M3kvTjVtRmd5TE9BNzlyU0Rh?=
 =?utf-8?Q?IVy6JzBLLMA+e4BJhFvBZUhij?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd69008-f867-410e-ac75-08db91f3498f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 18:23:50.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzgzOg1l67PdX/HpNY5ovA6vqz/sP1YDJZ6RG6perJcN9lHRP+5qchoGDfbfJ341vAqVSK+HUgXpOj3I2YIiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7936
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/2023 1:13 PM, Jakub Kicinski wrote:
> On Mon, 31 Jul 2023 11:02:40 -0500 Limonciello, Mario wrote:
>> Hi,
>>
>> I noticed today with 6.5-rc4 and also on 6.1.42 that I'm getting an
>> error from an r8152 based dongle (Framework ethernet expansion card).
>>
>> netif_napi_add_weight() called with weight 256
>>
>> It seems that this message is likely introduced by
>> 8ded532cd1cbe ("r8152: switch to netif_napi_add_weight()")
>>
>> which if the card has support_2500full set will program the value to 256:
>>
>> 	netif_napi_add_weight(netdev, &tp->napi, r8152_poll,
>> 			      tp->support_2500full ? 256 : 64);
>>
>> It's err level from
>> 82dc3c63c692b ("net: introduce NAPI_POLL_WEIGHT")
>>
>> Why is this considered an error but the driver uses the bigger value?
>> Should it be downgraded to a warning?
> 
> Could you double check that the warning wasn't there before? The code
> added by commit 195aae321c82 ("r8152: support new chips") in 5.13 looks
> very much equivalent.

Yeah; looking through the history I agree it was probably was there from 
the beginning of being introduced.

6.1 is the earliest kernel that is usable with this laptop (for other 
reasons).

> The custom weight is probably due to a misunderstanding. We have 200G
> adapters using the standard weight of 64, IDK why 2.5G adapter would
> need anything special.

Perhaps Hayes Wang can comment on this (as the author of 195aae321c82).
