Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80E579AF09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350875AbjIKVl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242422AbjIKPdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:33:12 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D50E5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:33:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzzVQS/HMYxbCjYV2Tiz/DAjTfJcD63i3sM6i6qvsoUSnYsDatYbf0S+LtGUt3yZknRIFVfBu2p43g3sliS0GpCiTcrmXbml1jQK+HClSKhli33TmVxIFmJeZO0MmNrTu+5/dmmoaTATpZyno/pANqX6sBeP8Qsj2yyvauEaE4OP3kyMynwHp1m2gMCMrawcfFu8TyT73lDY9XhuOWkxSIiQg0DyO1JFqb9Fk9DexgiTVudOMLaTBkVs4M475M/Ix5Hl97tJx8944eqYSPnRAnOgAG4bDeWZQVM213mgE6jodeLipf4VSO4pj0qcuxtWCOQ3sV4eZrDU8m/0hoRwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJuZ5qhpgnjTKwQ+h9peoPZ7HzpZSnILcyi4rkOxvRo=;
 b=hV2niZxuvwbkjr+9u0+Ib4hSLtb7a6JJYGDpDDlyK9JtETUG45HWsLYsD3S7/7mdLmpWWNWqd/JsgeGcqCzRw6+RUWhVZ2AgrOqQDXdfOgq485/aB5F5K9fCGPe67Tj0Hi7DEISyiOxH36Oo0EAxROQnUdFy69hfRqIiOxUrwCjH4xnOcEMcGdD/e0EcZmycJOx+zv7eaC6IZtEF9QXhmBJ4pwYql08gymkWnrBGS4h1n0uFJMqA74ShY46rX3ArFVLT/Rou76BA3ndludvLCViEUkdiIjojKQatNotNlp1aGiRsEFCuWGCnlix+OHQA8MW7vYm4fBqTXrJUgA/jmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJuZ5qhpgnjTKwQ+h9peoPZ7HzpZSnILcyi4rkOxvRo=;
 b=FE7wN+NPOKpLTu2roRoX+KCQx5Fpp9k5IntinaBCB06lW2sgjbST4gkditV/b5uLROhrnlzCAYxpeIqGju3707SrBzilTS+H4bYnHpop9o1orNAmzKB0zbmaTcklgxG3dUleskO7fFzfyuLYi5FL9bb/8aFQCWezsCjMltbWkaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.27; Mon, 11 Sep 2023 15:33:04 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 15:33:04 +0000
Message-ID: <b41a26ae-52f5-f9d9-edc7-32ee665f2482@amd.com>
Date:   Mon, 11 Sep 2023 10:33:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Young <dyoung@redhat.com>
Cc:     Ard Biesheuvel <ardb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        kexec@lists.infradead.org
References: <20230829125134.GA509331@ziqianlu-dell>
 <20230829125939.bcg2r6hwqf45npko@box.shutemov.name>
 <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
 <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0044.namprd11.prod.outlook.com
 (2603:10b6:806:d0::19) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: d9520486-16c3-4929-7a59-08dbb2dc63bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CfUa7UZgu50HHYzqcenoqtFIHaq04CVpRB97PKLSSq/+uP4lX50dVSJ+AFI+4NvIGtxp/hFgvurs/QxZnK3l5KFEvRRf0ZLDPLwtVZITex4xHdmsfA3lF11eWpMDT8H5BlkRQcYBALsq9A76MWLbSC4qtuV6K3al+tdjgr1NT73ku1QvoWemFDyhHdbCpTevbiiHCWzooGVOuTqy3eDf1XBcky/yMg586Ezi5gSjZ39BjQI0ISopr5zyRqfW7mimasHNrCP5ZXVQLMXMZDoo7ZrZHzikYbaawyE7DzYCZtzj22clnnHS/wqSeidlYhgshbXv80X03fP/M653ol/BfNFkD3yu0DJ6PvYluwIOgCvC829ZLm2V+CGlw5DePYwi4Edp0WyyNGfVquOT7uyAMhX0BJ+l7+QwgHbuW/OJAW7ptfu/DvVuPwy42sEaURnoQIrXgFQj4EljKdQ//e1sRl+pp0zn6xhVUtzDKD0h3hw6xTt+0s61Sa/OoATwG9mRfzqmt2IMRuVVrrUPVOXtWzZoWxbCKhOxqPIHB9Jqyc6OpkGNqaLAlY0I85alrdhpKCFZS21wRVzbNFT1qkJFJSwESPDqHCrHOtVGn7BktFr9hK12EuE9QiwOFiTYc+K2Mg7LmjYuV/LEcjQw86lSDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199024)(1800799009)(186009)(66476007)(86362001)(2906002)(31696002)(8936002)(316002)(41300700001)(8676002)(7416002)(5660300002)(36756003)(4326008)(26005)(6666004)(966005)(31686004)(478600001)(83380400001)(6506007)(6486002)(6512007)(53546011)(38100700002)(2616005)(110136005)(66946007)(66556008)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHR2RGNrU1dXelhybm9DOVNNZVl4M2F6bk5RaEpHS3ltTVRqVUFZNWk2YlNt?=
 =?utf-8?B?UmhXdHliU1N3RnU3bDR2eS9zZVBEdktLUHMyb0Z0bUJUUHV0a2dtemZLb2VS?=
 =?utf-8?B?TVM5Z0tmbEdCdk9QcXJ4WXpTRzlJT25VUEQ4WFRCbmVYeDVJV0xXc2NiYXZG?=
 =?utf-8?B?M01saG5Bb09oRlVhTkFHdHpHYVJqbnlyZmc3M0ZzL1dIRWdZbnU0RDkzNkRZ?=
 =?utf-8?B?bW81cE5ObGhnR2RwT0dpVFhpc2FOU0pHdThWWXBNWVZwWXhmYjVLNi9aTUpS?=
 =?utf-8?B?QVBDNUtJc2Fna1dyYkVOYkt6cDFrc2NucDdFTldLNWF1TlVsbHNyMCtjTlhn?=
 =?utf-8?B?SlFXWXF5YlNOMkNyTmgwdlFGcTdBWExPKzZmVzZHVkltSEsyeklhRjM2cEd5?=
 =?utf-8?B?OTJqNEQzeTRYeHdpMDNMRjZXZG9IdDhGM09LVmEyUzZZTVU2U2FGb2NVRkZl?=
 =?utf-8?B?c3Z3QjR1K2hxSjJKMU5SbGVoNklwNE51TDU0RG10U1BuUEtScnVmUWxzYXlI?=
 =?utf-8?B?MVpLUEZHZEYzLzNuZ3FxZTFUT1ZCc2dncUt3cGtHMHVpcVQyb2dGM1RMK1A0?=
 =?utf-8?B?QmlHZExPeDZBUGpNRkNNeUxKNks2U3NZL2xRdG1KclIvMnBxT1Q2WGxFWjUy?=
 =?utf-8?B?SmdYZ3lXMlprcXBuSWtwSUF2SGhxV2RrNmtpS1dqZmF4RDZiTVBIcGt6V2ow?=
 =?utf-8?B?QWZEUjZ5RlRhS2RUVy9xL05HcGMzbDN4S2VPVWViMnBuMzhhRWJaNHpSMkRn?=
 =?utf-8?B?Y3Y5UUVGbWRSdExyL3RXYXRmdVhHRmVMUmQ0WGhEYjFLdnRNcDVZSHgxS28z?=
 =?utf-8?B?c2RoWXRZc2pvTUI3NG9NUGF1NjRLYmhiK3dBcHRuOTd1bmFEUlcvalMxeFNJ?=
 =?utf-8?B?TnE3OVRLSFpXR29Zd01qeVFsTW5lRFQ4YWMrdnZvY0Fma3FoQUpVaGV1ZVZY?=
 =?utf-8?B?ZHZZZzRybVJjVGVUbFJ3RjB3QzFYODVZQVZXRnBpYWtLdHZUN3dvODJnZU1k?=
 =?utf-8?B?ZThHQUpOSVkyRndvcEVWZTJPUXp3UGJsZHhaUnRKVGF2S29RTFVMYWNpdnhL?=
 =?utf-8?B?L3FyVkhENUlDUXd5emdFMEprbHBHOXZyaGozbnIrQlp6d1YzdXNxSTZsVjVL?=
 =?utf-8?B?Yjg4MVAvVlNTQkZFNU5wZkY0T202RUpORkRTQUZhTnFQWEEyUkxvYmVhbjBQ?=
 =?utf-8?B?RVBnWGdJMk05NmlRTFQ5ZkxiVkRHNUxrTk5TWXZobWtuSC82dkRlU0VVUjl6?=
 =?utf-8?B?dWVvRUc3aXFya0p1VGJEZDdhMjd6QVd0WEJ0ZkpFeDgxNzBvcEg5WFZxME9J?=
 =?utf-8?B?Rk8zZCszeVZPN3R3dHNtUTNxd1gzbnBoZ1NLMmN2bXQzQVl1NWJ0dDd5MFZD?=
 =?utf-8?B?VVFUVitMN0MzenNRNU9lMmJwWDFPdEJmeFNNL3dHeTVFbUEvUzR2MWI4NCtZ?=
 =?utf-8?B?YVkxWmdCQ0U2VGVWY1lRQmVxT0FoN3AweVk1VEU1aUpKODVRMkJGNnhQc0x2?=
 =?utf-8?B?YzByOHFJK1QrMU5QeE01SzE5c2sxVStraXV1RlJWNm5VbEpGdU9VbCtyTW1q?=
 =?utf-8?B?bmNhMnZOTnZsdjN1RW1Hc0dEY09PYUVpdzdIZklLTnNCdEZSS2FZWmthOHFm?=
 =?utf-8?B?ZC9wcy95a1FVK01LSUVySzdwU2NHNVIvVEt6TWl2L3I0MzVzRmRkR1FkM2dN?=
 =?utf-8?B?UzRReGhEZG5DR1BHL0RVUFBZRVhTbW1LTERxVkhHWWo1OUNJYmFPcGxMUXFu?=
 =?utf-8?B?V0dacU1BS29VQnkxTHBBK2hRbnBUcW5TREtnd0FBc0NyV0NqcjVaeXZDR2dZ?=
 =?utf-8?B?WDV4ZVdmVjNYWCtpeGhSQXRCUXRFL2cvcDFSbGpXV3p3Mm1oV2V0VGZpcVZQ?=
 =?utf-8?B?NExXUDM5TEx4eGFlL0RCdlZVeG9GNG8vMHR5aHBGdVNYWURsU2JTRmZyYURt?=
 =?utf-8?B?dUp4M3V1NFVxaGVXQ1c2NmJObXVjWGNkZmhKWm9RYlNUNXNhT1l5dGlLMmh3?=
 =?utf-8?B?T1F1UldxN3c5RVRrZ05NTWxTWlAwS2E0enA1TXZDQWRsa3J3TiszQnhVUU40?=
 =?utf-8?B?c1JuL0RKd1UwMnZySXdQWEJDTUhjTUh3QnN3Y0FZKzhNTWJpRHNkYjd6TmJo?=
 =?utf-8?Q?n5tIkbrw78bsucbcTbfp9B+LR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9520486-16c3-4929-7a59-08dbb2dc63bc
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 15:33:04.0539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJ7HLoAiu5a6zC48wOHhJMfjn/NJ25gpqjV/pC8oK3pOdWyQxGb9kMAHoMHUU4UCAHBBrNd0GAwsaUjdYlbkWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 09:57, Kirill A. Shutemov wrote:
> On Mon, Sep 11, 2023 at 10:56:36PM +0800, Dave Young wrote:
>>> early console in extract_kernel
>>> input_data: 0x000000807eb433a8
>>> input_len: 0x0000000000d26271
>>> output: 0x000000807b000000
>>> output_len: 0x0000000004800c10
>>> kernel_total_size: 0x0000000003e28000
>>> needed_size: 0x0000000004a00000
>>> trampoline_32bit: 0x000000000009d000
>>>
>>> Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/ident_map_64.c!?
>>> pages->pgt_buf_offset: 0x0000000000006000
>>> pages->pgt_buf_size: 0x0000000000006000
>>>
>>>
>>> Error: kernel_ident_mapping_init() failed
>>>
>>> It crashes on #PF due to stbl->nr_tables dereference in
>>> efi_get_conf_table() called from init_unaccepted_memory().
>>>
>>> I don't see anything special about stbl location: 0x775d6018.
>>>
>>> One other bit of information: disabling 5-level paging also helps the
>>> issue.
>>>
>>> I will debug further.
> 
> The problem is not limited to unaccepted memory, it also triggers if we
> reach efi_get_rsdp_addr() in the same setup.
> 
> I think we have several problems here.
> 
> - 6 pages for !RANDOMIZE_BASE is only enough for kernel, cmdline,
>    boot_data and setup_data if we assume that they are in different 1G
>    regions and do not cross the 1G boundaries. 4-level paging: 1 for PGD, 1
>    for PUD, 4 for PMD tables.
> 
>    Looks like we never map EFI/ACPI memory explicitly.
> 
>    It might work if kernel/cmdline/... are in single 1G and we have
>    spare pages to handle page faults.
> 
> - No spare memory to handle mapping for cc_info and cc_info->cpuid_phys;
> 
> - I didn't increase BOOT_INIT_PGT_SIZE when added 5-level paging support.
>    And if start pagetables from scratch ('else' case of 'if (p4d_offset...))
>    we run out of memory.
> 
> I believe similar logic would apply for BOOT_PGT_SIZE for RANDOMIZE_BASE=y
> case.
> 
> I don't know what the right fix here. We can increase the constants to be
> enough to cover existing cases, but it is very fragile. I am not sure I
> saw all users. Some of them could silently handled with pagefault handler
> in some setups. And it is hard to catch new users during code review.
> 
> Also I'm not sure why do we need pagefault handler there. Looks like it
> just masking problems. I think everything has to be mapped explicitly.
> 
> Any comments?

There was a similar related issue around the cc_info blob that is captured 
here: https://lore.kernel.org/lkml/20230601072043.24439-1-ltao@redhat.com/

Personally, I'm a fan of mapping the EFI tables that will be passed to the 
kexec/kdump kernel. To me, that seems to more closely match the valid 
mappings for the tables when control is transferred to the OS from UEFI on 
the initial boot.

Thanks,
Tom

> 
