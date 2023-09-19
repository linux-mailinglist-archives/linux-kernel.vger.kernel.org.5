Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC03F7A6492
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjISNPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjISNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:15:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D063F0;
        Tue, 19 Sep 2023 06:15:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuMBZkASgwzwtU5yBbjp/EIwCM3DA/vka6YP1MR91Wb79KM24Zc9CSf9gAezJj/+uIyVM/Mle8cqnkG0srunBuUYG3cSMuCrFZw5oVapJa6h2ldbKzLIEOc9JxKKknO3S1ZpURBmGbkYJ5m3uwRzczodbxzLIucBgXNAC/3HIjCEcWapsW9sVYK3KGHgWy8divvsMiyJIFmvnKkXFpphzL8lP354rO52LEaX6wNKZMLdzIEg7r824O0oI2Jc+Wj75EVRv0epY9qs2wZKrMX0tVVLHoNgRzesJ62I7Kh1AMjWVMjlQ5XSxHJvEy9hIJQk0XTRj/MBX9oNyx0qUpFdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWLrnVEwU0ICfifuZvhrH/2j0lkYCeRZI8XHAmhLSGM=;
 b=JfRzx6zxSK6NU7UltZWe9TWYQp0m4+KY6cuYhJ//1MvXgEBFul6OIVXMPuM/RCh09AauguwlFFQwfYUII+/TvhDIYMsXpGs4o9U0SLI1aLNvLMI4XnSrqIZJxJv8CkANrS0WRNdDNWhaE0uCbi50Xs6hY3KdqpT/hdpav/ZMhfy0bbUACpDVf3hxRRSlSKonrklbMZc9Cag52nE34Vn4AeCSAEXgEggLOyKdFYGAV5C0lJUIKu1pJb3Pc5TGbz5kluYvoiJn+bGDmlgKkD5a52YFCPb3uqelhwV4Xvm9Gnr92+x2Xa6E6Cf0Wgs1zUkbdOkUWlu8CligvnCNdvLrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWLrnVEwU0ICfifuZvhrH/2j0lkYCeRZI8XHAmhLSGM=;
 b=UbNHEH3+6ui3RU4BvjZpuFD+isiBNf432wovvr64cTn7CCSI2kL6bB8xo4ljqUrD6ceMjae+OPGhFP7HIj65G5UJh4kVum97cx12D0D/9rVp+VrCj+W5T/nMKKVvEbKDb+QG0rJXKZz2jXFpul900e1G10igZU0zVu9eOfX8THo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 13:15:08 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::6754:7b9d:a877:39b6]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::6754:7b9d:a877:39b6%3]) with mapi id 15.20.6792.021; Tue, 19 Sep 2023
 13:15:08 +0000
Message-ID: <1096ed01-61cc-9922-2e33-14d9209b40df@amd.com>
Date:   Tue, 19 Sep 2023 18:44:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: linux-next: next-20230918: x86 build fails
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230918135002.6d9610da@canb.auug.org.au>
 <d2b5b60a-7540-5a00-5fca-9690c1db85c4@amd.com>
 <CAP01T74oyzNvNqMq62UvfbkER906skY=wdg9PVMbRQhMOw+1UQ@mail.gmail.com>
From:   "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <CAP01T74oyzNvNqMq62UvfbkER906skY=wdg9PVMbRQhMOw+1UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::34) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 46640b3d-6f32-469b-b6d1-08dbb91271fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mwbCF8vt1VJCwJori8PStGsS99IV6jgfxm8/qOC5owXALR3JcuqFYpY6n70bt9VWmsQSmsKUTNBxNgFxLc9oQy/QPACXgrPPj7M6+/LwFT4gpg8PwhdrZKz7tZemal7zhWiNmC3eWHKEOWxbFbdO/qM0mfCxHu6LoOAmlq8hAI2/xxwpTsC9niRJ16sN9xoHE/BE0XKFe5ME6gxIIeA5HttMKuyBZVRdS88kz/JFPnV6WVbugFR0c4xLzs5MeftLPqrEUYEgZpuQxQe2zBzH0m+F4n6PiR5Yb5B7wKZvs/wLqKzTA7U/+2nm7R8iLZRn9nfEPVlkM6aFHkqrMcuQSa8BFUGkuXYNhqsMyvJX8ph68WFkFEhZDfSpyBhzHr1zLk9mi/u47qm6p/UyHkZKMnX11Oy1zeHubirKA1YIjzBNvtNVepLubEd9K+upsVVstHXnAQEe/KLbya5YbrDdtQQ5UEqa8E1dYpIVT8yy/emQqBiY6dJ8UagZlG+j9dWn+h/Q8DKWKEQMpvKXrgGIMP8DnxhgbWOLWEVPPoswdPiJzEY74AVEsVuW0EGYdlqGrCdk+W92/G7Y1hxlJoZGCXEpNH/YopqGuKqjFFMAZntXNk0G1SQZgKmSx/PpH/CGAEaGZZJvOoagVqD1w/DuPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199024)(186009)(1800799009)(38100700002)(36756003)(31696002)(478600001)(966005)(66946007)(54906003)(66556008)(66476007)(6916009)(6666004)(6512007)(2906002)(53546011)(6506007)(6486002)(8676002)(8936002)(5660300002)(4326008)(41300700001)(31686004)(316002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2lvOXBnVzNOSld4MlJhUUV0cFhtUEdxUkxPVDhNSGkvUzlzaHRvOUJHWkhr?=
 =?utf-8?B?alhpdXdUSTlPREs2eUhYUTZ0TEwvanZhSERKTHo0YlZKOG1remE1YVpheG1h?=
 =?utf-8?B?VXZrdVpqMGZyOWljeXRhRjd3cXBPUjVmdVI2TzR5Wlh1Y1hoUWZrVEJ0K1N0?=
 =?utf-8?B?RENUR2xrcktGL0lzeTl1ZkFOMkdyUjRJS1R3VDZ1TWN6ZzFKUDVVY3RGd2x6?=
 =?utf-8?B?ai9tc0N6d3ZlR2RYTEUzZUR2Tk0xYWk1L0FaNEtlakUzcUt3MTNqdEtzVFRk?=
 =?utf-8?B?cmFwaGxIS3J6TXhLZ1kwTkJuK0Zod1ZKQ2JLUzFnL2pabWhHaVdYUzhtVm5m?=
 =?utf-8?B?eVRrc3ZtUTMyMlJMOEw4M0lmZHpEQ2dNbUVqaVk2VUZkdWdBUlluNmlXanU0?=
 =?utf-8?B?a1k0eCt1cjZGeDd0d2xmZzNuRVVXSlhTVDkvNytLWW5aYUNuR3VGQnRIRXF3?=
 =?utf-8?B?T3lFWXhTQXFybDU1dFFvZTZJcEhMbTVyKzhVQ3QxdTdEbnlvQzJFaE9BRUp4?=
 =?utf-8?B?WDBjQlV2eWY5NFVXMHloZlFxamZaOE1RVG1tOWE0SExUMUY2OTNEalU4L21F?=
 =?utf-8?B?N3VsVGFvRjc3NjdKQWZhbk9HZkkyeTBFQmMyWFUwUHpERTI4UFFPV3RUSEFQ?=
 =?utf-8?B?YlcxZXJsSXRjWVNBWkk2ZzNRdytvMS9HS2dITVpyVmNabHNaUnJYQS9ZdVRQ?=
 =?utf-8?B?OXduS2swKzFqOEx2ZGg5TG90RHMvNk9XMFFMWFBoUFhTblFGaUlLdURkT3Ns?=
 =?utf-8?B?ZFAvQ2tLR2pxV3lZcUNrU1J0RGs3YW00N2dBeDgzcnJMU1E2NFhxSFdWYjZy?=
 =?utf-8?B?OU9FNnRqVXJ2dzRVc2I5ellhTGtBMkZKVTBCTVRXWXU5b0ZjaHpabmVKRHhS?=
 =?utf-8?B?bkpIc21kTWdEM1MzTFV4dFRZKzJxdDBINjRvS1Vic0FDYVhiRVRrRGlPblI2?=
 =?utf-8?B?azErbkFYODZUZXdad1h6ZUNkQTlQV1JFSGxENm02VUZqZDFrZXFGUENPSGpa?=
 =?utf-8?B?UUF2dVpSTm90ZksvbnMrZXBvUWgzaTV2c2ZscEFmbXc3ZHNzYWhicEFtTUNY?=
 =?utf-8?B?SmtHcFAva0ZBNlg3UVByQm9Bd2Vrcis4bDBvaXZ2bU9qT1BMMEhKbWFvYm5l?=
 =?utf-8?B?RC9iRzRUdDVVYmFJYVBWUndHSFpGTmU3ZHUvcE9JdUw2WU9xY2hDSk50YzN1?=
 =?utf-8?B?cVFqN3dKYUhYc2daVnRVZ0p5UUQ3dlAxYzRIUUt0aEsvNVFUVlZpdHJxMG0r?=
 =?utf-8?B?UmdDTXY1UU9lZk1mM3EydEVsUkFvc2M5bE1TQjZZOWRkM04vWjdOUTkyY1VY?=
 =?utf-8?B?Q2lFbmRIS1djRjY5aU1PbWN2emRaNXUyTm91WkhsZUk5V0xUWEdSYU1WY2pw?=
 =?utf-8?B?TEJHK2dMK2xwQjlnZU9hdXMzc1FqS1lSeXJyeFlKUWIwL1NqWmoweWcxWlZE?=
 =?utf-8?B?ZXEycnE5dStNdHVVaTl1cDNwM0IwcG1pTDVteTBZOWd2TVQ3WTlOME5sSXRM?=
 =?utf-8?B?R0RESDlwR2xpZTlGQ3lmRmhlK3VIakM3bUE0TmljYXZaR1QxYS8rTmZHWW9N?=
 =?utf-8?B?UGoxSGdTb0JDOVluaVgyTkpkQi9vSmpKQlZObDkrM0d3Nll1MzVsVGNKeGZX?=
 =?utf-8?B?bnlZdHpDTFZLUVY2dEpkcUlNSmxIczIyYndNOWM1cVErdjQxS3JyaFhBUTVQ?=
 =?utf-8?B?MnZ0QnJlNFpjWFFROVgzNmZucHo5eDN5RUpQVm8xZDF2R2ZCNk9VWGJ2Ti9J?=
 =?utf-8?B?TVRGbHZpYSs0SUNMS1ZBT0UzaE5aUFJiR0dXbU5UQlpYVnZvMHExTkczWmho?=
 =?utf-8?B?TU0rNE50VW9LVmNqdmhaQStlamt2UGI0NFFQNE1kRjg3dzk3d3JFREQ1aDVo?=
 =?utf-8?B?eFNLdjBJWXJJWUdvVTNlQ2o4Mkp6WERxdlU1S0kra244eTI3b0F3K2lSVHly?=
 =?utf-8?B?N1NZc3Nvb3FtZkxiOGwydWZjV202NWVNYnR5aVBkUzNtM01MQ3FneWVQWjVw?=
 =?utf-8?B?SjFlemsyVS9rMzZQYVdPRGdBK0Zrb3ZaT1FEbVBUejFPMW1NNlNZU3kxdjN5?=
 =?utf-8?B?T3UwM2MxNHVqVURrVm5TSDVzbHhEczV6dFFtK2dCdExtWVZMem9PdDcycDVk?=
 =?utf-8?Q?WeElaXNa8N6Wpad8c6jpsFLFI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46640b3d-6f32-469b-b6d1-08dbb91271fd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 13:15:08.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUnSz7M0pnY0VQva4joUUpU50y+AsCR0LPxG+ECrp5Bl65ptS5uv38K6NNfYVzRsdQqBInSBHsbEHPk+GammcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2023 2:17 PM, Kumar Kartikeya Dwivedi wrote:
> On Tue, 19 Sept 2023 at 05:55, Aithal, Srikanth <sraithal@amd.com> wrote:
>>
>> Hi all,
>>
>> linux-next: next-20230918: x86 build fails with below error:
>>
>> arch/x86/net/bpf_jit_comp.c: In function ‘arch_bpf_stack_walk’:
>> arch/x86/net/bpf_jit_comp.c:3022:72: error: ‘struct unwind_state’ has no
>> member named ‘sp’; did you mean ‘bp’?
>> 3022 |                 if (!addr || !consume_fn(cookie, (u64)addr,
>> (u64)state.sp, (u64)state.bp))
>> |                                                                        ^~
>> |                                                                        bp
>> make[4]: *** [scripts/Makefile.build:243: arch/x86/net/bpf_jit_comp.o]
>> Error 1
>> make[3]: *** [scripts/Makefile.build:480: arch/x86/net] Error 2
>>
> 
> Hi,
> Thanks for the report. This has been fixed in bpf-next and the fix
> should find its way into linux-next soon.
> You can locally apply the fix for now to be unstuck.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=43c6e890472edf3f667579b0a671f4b3d9b2fa3d
> 
This fixes the issue. Thank you.
Tested-by: Srikanth Aithal <sraithal@amd.com>
>>
>>
>> Thanks,
>> Srikanth Aithal

