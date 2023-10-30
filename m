Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8187DB280
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 05:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjJ3EX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 00:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjJ3EXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 00:23:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F09B4;
        Sun, 29 Oct 2023 21:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyPigNb4VvTSNZiDkAQ8ZBdxBxVr3F/loTcKSFqH8HYPJBEEFmOq2zpYsaTlc/eLS9iaZYLvvZ4vP/KKGR07VEvQLddnwtGE6iI43xbX/JwNMk8Gmb7gp/FP57OiCJZNMd+uuVzI5+dl8ECnbSHpdkwXZDMdOlwVeT5r24sBorsTG2uWC5XBVuOWX0L29WgVGDCyfH4AZ3xfXtScJLZrG1lNU/3B53Bjzi2/hBQDQriP4F7R+PT4Nb576MS8JDHTVRHO3VSnKTmCNBHiMWg86KDKRDBd7RlV0W9GyMMLAITg9aif74OdijiZIave4I3wuE54WM0HmUYda/f9A+EDvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ReNXBF7XniDVT3/axQpTptRSn5o0q4fKxc7i/lFuzs=;
 b=QADpTA0ov3hcWq6Uzm7s28OHnX67VtAjqf5XJAdc+KZfokXq1YWhgTdu4uVTYcB8GNT7apFAN5OkFwg1cXe2RBmFxQv0dS6jFJdLjg07fzhAfjQuaVrT2+92xDOY2HGlfJepvqEdp8XIApCQ9x8Ehc+Ri/lL0X1muP2xqbCT09EZSICbG3oH3Qr+IjfZynDMrL3NFWNrZUGgoO3bHt0IJkIKeoV2ZcRC9HYqc9i/xR0gkIPmWoXchNDEMoV3o50e5fmRnSNR9/hqWXq0S6tGM3wjFv2sPGNGfFKBIypb/ApbNXriyhpDwQUXNEc6/J1BPQgYK3O8tWzsLRLTHNYS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ReNXBF7XniDVT3/axQpTptRSn5o0q4fKxc7i/lFuzs=;
 b=4HgvEkilzGbpjCNL4i76USQRUMGEiiof2iIf1Vx0XPjDRqIROy0tjoe8fOaNbuPUJZ3BPCDFXfr3A9wE/GHKkKG6awoiHRE33/GrzUC+Pdg2Xy0POfFm5f21z/PqW0YuhRSSVSq1WiSLtNGsj7zZQCaA6virPgEqR9U0yeDXSZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by DM8PR12MB5479.namprd12.prod.outlook.com (2603:10b6:8:38::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Mon, 30 Oct
 2023 04:23:18 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48%7]) with mapi id 15.20.6933.025; Mon, 30 Oct 2023
 04:23:18 +0000
Message-ID: <45616b21-ed70-96a3-b17d-0ee765383bc7@amd.com>
Date:   Mon, 30 Oct 2023 09:53:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 4/4] EDAC/amd64: Add Family 19h Models 90h ~ 9fh
 enumeration support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-5-muralimk@amd.com>
 <20231027144552.GGZTvNIE7g1S3jBM72@fat_crate.local>
From:   "M K, Muralidhara" <muralimk@amd.com>
In-Reply-To: <20231027144552.GGZTvNIE7g1S3jBM72@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|DM8PR12MB5479:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8ac36c-922a-4701-1eb7-08dbd8fff137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMlSG3hVM272/lWhumYxERntZ5cFr6EAlHEaPaShfizBKQlZ0DPrA4cHlS4bJz43eEHYPMC75E7Zie9vLN5FdOOI1/PTKRgQ65xUMbBWdxk68fSmws7lRJm3G6XI8fnlY0VphJCFz7qxUhqSeQ41exgUnYYJfy5hPY7lnFFmsk5jsREb4e2s8U4D8eKTB6G2W9ar/oL5NOoQ3h06zH7/ssmPaV1VCRKTVSasOu55M/EkUGSZwewpf8JhZy8cwSj/+X1CxKqgbwxf+GWGdJNlcTUidB+tmi+8i6EMEnEdBikyInHRRftVYcQFJuxO2a9gkAPm/031cjiIyofOsWlUsPyJOd8i0JNS9HpUKfygXOzt81qDD1aET4U89YltvYB2NVIeqkBk4COI/2J2hhKla6Fa8JXaZHZfDal+u9EaqdxhysUrqDxrAzPOQsmV+iDbtDjjOoce59dm3izjOeg45aaUmgFz1mR1tnUZPdXAORHWXXi+K8hD3eCWtl7VQc6huLg1/rnid4DSX13eTazhjY6vyBro2yZwqM6xIth+bJMxGWnD2FoiczgDG0k+Iw/R0YxBqitXtjgLcrFyreDSHUI7hza3xW0elbb/9bhCvQwNChFucesNMh8jhYpAHFVGVbpLWMyz/u7z/QlJYIDYasG5f7w5O7wkPFCG4v2k2d8Frpk1rYOoj2+FFB+cVx5P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(1800799009)(451199024)(6506007)(53546011)(6666004)(6512007)(966005)(6486002)(478600001)(83380400001)(26005)(2616005)(2906002)(5660300002)(66946007)(41300700001)(66476007)(66556008)(6916009)(316002)(8936002)(4326008)(8676002)(36756003)(31696002)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2owVk43b1Vudkh2bVJZcEszazNXbHRpaTVlcGZQZEoyR0hCNkxYcDh6Q2tp?=
 =?utf-8?B?STJsbGZnRzdqWHBLZjl6T1ljM3JqTVNUbm5UQm9idmF3TXBvWm5rUjg4TVRv?=
 =?utf-8?B?NjNIckZtSG13TC8zbVVTcUdZQWQ4Qis4N0c5MndWR2FBWlZWN2ZVREVPaHRX?=
 =?utf-8?B?M1pLWDVTRHFWemN4SDZhbzhCZHVPRU9zcDFzR3FmRTVkbTFVYUd3YVZTVkta?=
 =?utf-8?B?U3VkVmp5eGFmbEd6ckFMR1pRWlBhd3ZRVXExaW9HRDZGZWdlSGFPWFNPRm9w?=
 =?utf-8?B?V2VmeGJXRzFMV3BwOXJZSXlBVWxKdFh3S05qak1HaEJyVVZvRFZ2dFVpSXJL?=
 =?utf-8?B?cUN1anFZalBwTDBzZzYxRHpiRWpQa0F1Tzk3aGVleTVia1drYjFyZWVuNFds?=
 =?utf-8?B?SXJrMXh5dzZxMWN3UFNVRGx0QndraU1IRUFXRDBFL0pOUGhoTFFRbnFJbkZ3?=
 =?utf-8?B?aXdSMDBRNEhpNjNxTndDZllSYnh1cWtCRmVERElzUTk1aTdabjBhQzRnczhX?=
 =?utf-8?B?bUV5U1JPamdKTERkK1JPcEQ0MmFZT2xNc2JwelNGdlNIdU9EUjRUTnplYlYr?=
 =?utf-8?B?OHNPclpLNVFlbUg3cVZYbkdYblBzdytGc3dQK0tWY0h6TzZpTlFLQWViUFNW?=
 =?utf-8?B?bjJKRUxoMm1vV0NzdUt4ajkxRTVXM0N3azhmUDlYTTIreWFBTmNXOGVONlUy?=
 =?utf-8?B?bUkzMDNVeCs1VmJiL1FsL1dLR2RQbDFaelU0bGNyQnhPdGJmeFovb1FkbDJa?=
 =?utf-8?B?QnJMK0lXcW5pZTBzU2MzOVNlWHVZZ01GeEttRjVQYlVoSnZnSEt0K3REaWlk?=
 =?utf-8?B?ZitKVnFzM3FVQ2Z4UElYNzlpREl1ZHdlZUFrMUZQeStSMmpYVkhvZjYvSVRv?=
 =?utf-8?B?alcwMHJGbU9tbkFzaW5pU0U5Vk4zT0JxYmdhRHM4Wlg3WnhzQ2orZCtmMSto?=
 =?utf-8?B?WTB4cEo5NUxCOXFBd0VQdWhJZTFXbEZtN3g3MjBYeWFTdnhzVTdjUFVEeXBw?=
 =?utf-8?B?UFE4MkxpSFFtUkNERXIzRVB2ekNSTVlRNW5oNVZKUzEwZlRjbjEzQXNBRlF5?=
 =?utf-8?B?RHlURTIzWEVud1lidXNqRHU3czNpcW1zOSs5dXNZMDRMcElicWJaK1VxRVNL?=
 =?utf-8?B?UFRZV0EzZ09kczJ4eU52UU1DaU43MVc1Mm0wMXY2eE9DYWdqQkNpOEdPNFQr?=
 =?utf-8?B?U2JXNEtKa3pWZCtKSUoyVnVUTGFTQVg2cGxVbjdRc09uNGptWVJCcHlENUpm?=
 =?utf-8?B?TnRtK3picjhzbVFPOVJPeFczczdBUmJCcmxnNlBxWlhnT3FMUllmK1lXSC9h?=
 =?utf-8?B?Y29yaE5SeDFuclU4dWVRMm95ekVhNURvTUNjbGl0UXMvT2hNNjRKUTl2TEJp?=
 =?utf-8?B?Q3l0dG15L2Zwb2ZyRWF5UERveERxYVd2c1cvZWUzSkluMjVvVkFkL2pobTE5?=
 =?utf-8?B?WnFHY0FSbkI5d0dkUDRKWVh1YndvZlRzbnN5SWpmcm85d2xYWFhPdHVBZito?=
 =?utf-8?B?c3VDdFhBdlRBek1NelFTQmtKTDFqZWlQWjUvYUVqTHp0dmpNRHpQbk5UWGZw?=
 =?utf-8?B?K2xRckMxWnJNUVVaTjMyUUlHM3RtMFVvcFQwdUNjN0gwMVk5Nk90bm0yeEw1?=
 =?utf-8?B?N1dDaUcra3pDRm1LSTNXZ2hFRy91d01vWFNmaldYLzcySzJ3RG1oejdNZ3dG?=
 =?utf-8?B?STdCaTRBWUloNnFvdEJ3UDVSd1Ezd1VSNDQ5Y1ZPWFNab0IxdlFtMFRSaExa?=
 =?utf-8?B?M2x0SGZBRlNsMUljc3pTU0d2dE43d0loU1FyZElzRTRHYVY4TUE3NmlmV3hl?=
 =?utf-8?B?WTB4azhBR09mZVhkMG16cUg0ZUNtRWR5dmhId29VS3dMb0lsS09CbXRyWnNl?=
 =?utf-8?B?b3M4RnFITS96dkZvczVCSmkyVHRudk85a0QxVkJjUTFqZFB5K1ArY3dHL2dB?=
 =?utf-8?B?LzkvYjBvOVpyS3YxaFVYNHZ4bHZBYlc2TFoycGk5bWNESjVSWDdSSVhqK0Z3?=
 =?utf-8?B?aVJ4anBNaWpZcSsyWGwzY3NIRVo1YkozNmFLd3UrY1o3cmFZZVFMaG9LZnVF?=
 =?utf-8?B?YXQxVTFBSSt3b21aUUQ2M1d3RG5pUzZoUUJJMXFzOUhPRlRwa2w4WTdNeUlj?=
 =?utf-8?Q?nIRKlKXrey0f/sq3kH0F+WJjf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8ac36c-922a-4701-1eb7-08dbd8fff137
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 04:23:18.1734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/3FZmnh/3ClOEh9FMO6hpfc1Y59FITRm/xaGKRQMtgWUepMKSDL0m+bLtoQCrfmL18iM2o4qGadI+W8zkIHBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/27/2023 8:15 PM, Borislav Petkov wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, Oct 25, 2023 at 05:14:55AM +0000, Muralidhara M K wrote:
>> Subject: Re: [PATCH v2 4/4] EDAC/amd64: Add Family 19h Models 90h ~ 9fh enumeration support
> 
> "Add support for family 0x19, models 0x90-9f devices"
> 
>> From: Muralidhara M K <muralidhara.mk@amd.com>
>>
>> AMD Models 90h-9fh are APUs, They have built-in HBM3 memory.
> 
> s/,/./
> 
>> ECC support is enabled by default.
>>
>> APU models have a single Data Fabric (DF) per Package. Each DF is
>> visible to the OS in the same way as chiplet-based systems like
>> Rome and later. However, the Unified Memory Controllers (UMCs) are
> 
> s/Rome/Zen2 CPUs/
> 
>> arranged in the same way as GPU-based MI200 devices rather than
>> CPU-based systems.
>>
>> So, use the gpu_ops for enumeration and adds a few fixups to
>> support enumeration of nodes and memory topology.
> 
> Do not talk about *what* the patch is doing in the commit message - that
> should be obvious from the diff itself. Rather, concentrate on the *why*
> it needs to be done.
> 
>> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
>> ---
>>   drivers/edac/amd64_edac.c | 69 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 57 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 9b6642d00871..82302393894c 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -996,12 +996,19 @@ static struct local_node_map {
>>   #define LNTM_NODE_COUNT                              GENMASK(27, 16)
>>   #define LNTM_BASE_NODE_ID                    GENMASK(11, 0)
>>
>> -static int gpu_get_node_map(void)
>> +static int gpu_get_node_map(struct amd64_pvt *pvt)
>>   {
>>        struct pci_dev *pdev;
>>        int ret;
>>        u32 tmp;
>>
>> +     /* Mapping of nodes from hardware-provided AMD Node ID to a Linux logical
> 
> verify_comment_style: WARNING: Multi-line comment needs to start text on the second line:
>   [+     /* Mapping of nodes from hardware-provided AMD Node ID to a Linux logical]
> 
>> +      * one is applicable for MI200 models.
>> +      * Therefore return early for other heterogeneous systems.
>> +      */
>> +     if (pvt->F3->device != PCI_DEVICE_ID_AMD_MI200_DF_F3)
>> +             return 0;
>> +
>>        /*
>>         * Node ID 0 is reserved for CPUs.
>>         * Therefore, a non-zero Node ID means we've already cached the values.
>> @@ -3851,7 +3858,7 @@ static void gpu_init_csrows(struct mem_ctl_info *mci)
>>
>>                        dimm->nr_pages = gpu_get_csrow_nr_pages(pvt, umc, cs);
>>                        dimm->edac_mode = EDAC_SECDED;
>> -                     dimm->mtype = MEM_HBM2;
>> +                     dimm->mtype = pvt->dram_type;
>>                        dimm->dtype = DEV_X16;
>>                        dimm->grain = 64;
>>                }
>> @@ -3880,6 +3887,9 @@ static bool gpu_ecc_enabled(struct amd64_pvt *pvt)
>>        return true;
>>   }
>>
>> +/* Base address used for channels selection on MI200 GPUs */
>> +static u32 gpu_umc_base = 0x50000;
> 
> That gpu_umc_base assignment can happen in per_family_init() too.
> 
Sure. will modify

>> +
>>   static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
>>   {
>>        /*
>> @@ -3893,13 +3903,33 @@ static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
>>         * On GPU nodes channels are selected in 3rd nibble
>>         * HBM chX[3:0]= [Y  ]5X[3:0]000;
>>         * HBM chX[7:4]= [Y+1]5X[3:0]000
>> +      *
>> +      * On MI300 APU nodes, same as GPU nodes but channels are selected
>> +      * in the base address of 0x90000
>>         */
>>        umc *= 2;
>>
>>        if (channel >= 4)
>>                umc++;
>>
>> -     return 0x50000 + (umc << 20) + ((channel % 4) << 12);
>> +     return gpu_umc_base + (umc << 20) + ((channel % 4) << 12);
>> +}
>> +
>> +static void gpu_determine_memory_type(struct amd64_pvt *pvt)
>> +{
>> +     if (pvt->fam == 0x19) {
>> +             switch (pvt->model) {
>> +             case 0x30 ... 0x3F:
>> +                     pvt->dram_type = MEM_HBM2;
>> +                     break;
>> +             case 0x90 ... 0x9F:
>> +                     pvt->dram_type = MEM_HBM3;
>> +                     break;
>> +             default:
>> +                     break;
>> +             }
>> +     }
>> +     edac_dbg(1, "  MEM type: %s\n", edac_mem_types[pvt->dram_type]);
> 
> That whole assignment can happen in per_family_init() - no need for that
> function here.
> 
Thanks. got it


>>   static void gpu_read_mc_regs(struct amd64_pvt *pvt)
>> @@ -3960,7 +3990,7 @@ static int gpu_hw_info_get(struct amd64_pvt *pvt)
>>   {
>>        int ret;
>>
>> -     ret = gpu_get_node_map();
>> +     ret = gpu_get_node_map(pvt);
>>        if (ret)
>>                return ret;
>>
>> @@ -3971,6 +4001,7 @@ static int gpu_hw_info_get(struct amd64_pvt *pvt)
>>        gpu_prep_chip_selects(pvt);
>>        gpu_read_base_mask(pvt);
>>        gpu_read_mc_regs(pvt);
>> +     gpu_determine_memory_type(pvt);
>>
>>        return 0;
>>   }
>> @@ -4142,6 +4173,12 @@ static int per_family_init(struct amd64_pvt *pvt)
>>                        pvt->ctl_name                   = "F19h_M70h";
>>                        pvt->flags.zn_regs_v2           = 1;
>>                        break;
>> +             case 0x90 ... 0x9f:
>> +                     pvt->ctl_name                   = "F19h_M90h";
>> +                     pvt->max_mcs                    = 4;
>> +                     gpu_umc_base                    = 0x90000;
>> +                     pvt->ops                        = &gpu_ops;
>> +                     break;
>>                case 0xa0 ... 0xaf:
>>                        pvt->ctl_name                   = "F19h_MA0h";
>>                        pvt->max_mcs                    = 12;
>> @@ -4180,23 +4217,31 @@ static const struct attribute_group *amd64_edac_attr_groups[] = {
>>        NULL
>>   };
>>
>> +/*
>> + * For Heterogeneous and APU models EDAC CHIP_SELECT and CHANNEL layers
> 
> s/Heterogeneous/heterogeneous/
> 
>> + * should be swapped to fit into the layers.
>> + */
>> +static unsigned int get_layer_size(struct amd64_pvt *pvt, u8 layer)
>> +{
>> +     bool is_gpu = (pvt->ops == &gpu_ops);
>> +
>> +     if (!layer)
>> +             return is_gpu ? pvt->max_mcs : pvt->csels[0].b_cnt;
>> +
>> +     return is_gpu ? pvt->csels[0].b_cnt : pvt->max_mcs;
> 
> Balance that for better readability:
> 
>          if (!layer)
>                  return is_gpu ? pvt->max_mcs
>                                : pvt->csels[0].b_cnt;
>          else
>                  return is_gpu ? pvt->csels[0].b_cnt
>                                : pvt->max_mcs;
> 
> 
Sure understood. will modify


> Thx.
> 
> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
