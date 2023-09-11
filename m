Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AB679B665
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377834AbjIKW2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243469AbjIKRNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:13:20 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C8B121
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4Hmf2NUhhKC7OS4MVH34tFRyiELJkvPW3eiB8r6riECaXpfLRsUihuoGVl53w6wTvXYz4hOxXmQdsdhza7zZO2MsUJz+GrUANuzWzPgH6vl4NB6kPHNizpvKvYgOASaQYeoE7nSd0TiNq083xy6IHQzrQqjpDhBFQY8gaJ7f1r69Z8RkCPgACYcGXqDzpDoFie1f7IBvBcpimCnJNGWTvuO0MUZ4lbO1bvXDLwEmBxP301cbegRivEBbXS7pMb0nR/T3NGYGrYbudkV4zNmj5KfnNFoUWAkcboSsyVMc517uRplbDEFsMXL9G+a8ECdX1d2cRG5pb5qaNJSsQKKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzqMw2ZbAKmi/cm/jdOcIMvbAm2FESeomqlS54L0ZDM=;
 b=J2JsVXpk4KVnwQfwaKM9HJdCJ4mqKd/GqqTFqweeSXYJWcu3voK/gobgL3gP7TdJpiu+QQtodPJLz0QzSdWAhqwsX93yh1FhA+VgJ1koUALKZqMAphsXTDCQWNQJmfbko4ufOjSlhC4S8MQXTwweVpkN6NRaIsgiWlygGSGYvv2Ei0+MKLSLcvclUD31fPHpAkg1A2rToAxrf3EC9/bDOSB2T2M9UjIbSi8PfEZvP9UXaggxhWUyLqQBc0Ggm9y2Q/rpnj5KaS9TNTGRwt5Fw2j4P6/zdc0ezOX68biNXdvAoBR9t2pdehJ0nHmgE3U8IiX6c/Q6a1FKBj8OnEOcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzqMw2ZbAKmi/cm/jdOcIMvbAm2FESeomqlS54L0ZDM=;
 b=uUYIxGezKqMM4iAL46TAvAMXFWIxD910hquS+qRQTxIwPPdlVp5MsBa4EWmCM/Fgadf4FMW/Z4V/zhAiZEmlEI6UAIKJpWP1Da85P0YuNflk7heHJV7RlTfTMuGKaUOt8zZuBVQfn8aPFUH48vogwRChVBhZsiNBJ8zcGz2zqPA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 17:13:11 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::d267:7b8b:844f:8bcd%7]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 17:13:11 +0000
Message-ID: <bb209d21-3bf7-1549-688c-f0ab7811da86@amd.com>
Date:   Mon, 11 Sep 2023 12:13:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: kexec reboot failed due to commit 75d090fd167ac
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Young <dyoung@redhat.com>, Ard Biesheuvel <ardb@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aaron Lu <aaron.lu@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        kexec@lists.infradead.org
References: <20230829140451.GA509854@ziqianlu-dell>
 <20230907131409.masxz42ik6u456qp@box.shutemov.name>
 <20230908060230.GA283801@ziqianlu-dell>
 <20230908123233.dpbpohgrbyyxekzk@box.shutemov.name>
 <202309080856.F066F92C98@keescook>
 <CAGnOC3aG9BuoVEGs4LQhhczdhAF0gFBmXR7GXKAf4Z8FPTb1PQ@mail.gmail.com>
 <20230909113209.actnan6hczrclz2d@box.shutemov.name>
 <CALu+AoSKpgbbKmsL8iuWpQB2ANqnhhfXR5pN5m0EsKZeFUBPkw@mail.gmail.com>
 <20230911145707.hslq47ngknshrlyk@box.shutemov.name>
 <b41a26ae-52f5-f9d9-edc7-32ee665f2482@amd.com>
 <20230911155340.mzfngcnjpazwsn76@box.shutemov.name>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230911155340.mzfngcnjpazwsn76@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::27) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b4dd7f-7f11-46e2-17e5-08dbb2ea60a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HQFhKcuDPZpDmlP5OpasvYTlK0hdDfLDlESm3KccNOJ60/kkm7gd1J+4ASPp1YOxbnnjYjm7hhXHRzYR2buOCdU5ZpIj542huPtrgRudWRxfEbzYl+k4eUyiEX583YpsfcgoIQ3dbvBZ1q/QRqkpVQk0yTHmbCDJHoXQb+T0yGOyxPEvby2i7A+/CZq8eQZKFca/vgb7pph1vJBXxdg8Pt/SnNJjn8f1oY+rgPSzdY6jmHPmej1itEVut0g+Rdh6B6XTnibj9wi2yEnGwyicf5hbnoQ8DasFlOPdAFw6E/AXCL60pJYr9GvGTwc06e1WtQplmHYByzJPIGKXx5WSDYEtAOwpeuQWNqWEDbwv2dBq2yYZeDeBZRBXA++Ua6Re88iAUNFyMSrjQY/SF+eDlwoJucaHaCiAhMQe0xUIloq7Ex5d8X88AgcDyeHanpEQnKItiK0OTzGpUMoQaq5okPf9uBRbZxLMwsdvl9JqCVC8WQNLNFFtBaskiqIC/zYqHBK5ShBT62ydCD2JgLpqZevZFuUIyAih2iQ0gdgijp520h7LykGKq4W3zUnf2xFVNgBEaWyfHZlR1fPkUPb2wWcE9NPF3rbAPojCTU9fIgZ6Lv8Pimtsja1D8ljAhe5lyI28mpt9ibWdnbOZN2vJDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199024)(186009)(1800799009)(6486002)(6506007)(53546011)(6512007)(966005)(83380400001)(478600001)(2906002)(26005)(2616005)(7416002)(54906003)(66556008)(66476007)(6916009)(66946007)(41300700001)(5660300002)(8936002)(4326008)(8676002)(36756003)(31696002)(86362001)(38100700002)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2pibmpiSXpXMDFwQjJjd2tKQTdEMjBBZm9lRU9STU9vNFBjL1BqdHpzbktT?=
 =?utf-8?B?TFhuamd5c256Qm90aTY1NklKOUlBVmdDY1lVZWNwVDZsSWlIai9sZzgxK0Ny?=
 =?utf-8?B?Tmt0aXMrb2ZoTUNWbm8wMW5jeGxSbkNQQmc2QmpIck1jZkN6M1FHaEN6Wk8x?=
 =?utf-8?B?bXNZSFdkNEsrSjJ5bisvdTh3VGtaM0dLWklQVkMvbFFJNE1kdG5MVmhTNDNa?=
 =?utf-8?B?SHdNOGppSithUlR4ZDVkcW1KRy9RY095ZHpDV3hPdFlxek85RDA1MzlOTWpk?=
 =?utf-8?B?YmJEOHV5UmtwMWNzQkI0THd2WGl0a0Npd2gvQUFOTXJjWnM5MndYRzczOVIz?=
 =?utf-8?B?T0E0T2NtMlpWM2t4M3RmUlFCNFdpcWplSWVtZG1OZVpVRC9ReFhmNFlBcndk?=
 =?utf-8?B?N0d6dlgrRS9ncVRYYjYzNkl3UitLWERBUFNkUU1RejFoWmVLdzVyaVpDYVl5?=
 =?utf-8?B?Z2hWTm5EOWNYK3hMeTVIUDc1MXV5ZzdNaU1xbVNXZER2bXBzelhjVE9qbDBy?=
 =?utf-8?B?Z1dtUkZTazgwbDIyN3RGTHBxaXNMYlAxYmNTSlNSQllFbFpaTFpyK0RSWkVY?=
 =?utf-8?B?WGxaRE1FeTBKS1V1UzN4dFc5YzVxUmtsblNQTURyZzJ2Mk5WdmhhREFFd1pP?=
 =?utf-8?B?MkRab2ZQUTJXRFhpMitwdWJKVDdSMlB1QzVjeVk4UFR0OEREV056a1RZb0FB?=
 =?utf-8?B?N1I0UHA4ZmloYmY2R1pjRXQ4OERQQWdGTTFWcjJ1VkR0WEplUmpLbTZSd3pI?=
 =?utf-8?B?clJycnlSREcwcDM2RllXT0lFSUNrTVFvMTdibkkxRDdMT0FaajdYaGJaMmZL?=
 =?utf-8?B?S0duTU5pYUZHNzZXcVVnVlA2dFkrSFRzOFhnZ1JQdGJtdEdNeTB5YVZIaU85?=
 =?utf-8?B?NkZMWHF0TzVyK0g3VTBIa05ZSXRrS0lGLzJZZCtNam5LcGV2TGRHSlUzUjha?=
 =?utf-8?B?YmJ5K09NT0lobURjMHlWSEp6UXcxRngrK0ZvcHUxT0ZydEE4bVdRMVZTNWFT?=
 =?utf-8?B?c1pSSlBTTDFpQzVadmpsWCsvdjVxMnpxVThTNkxSaHV3SFlzNXd3aEh2R3Vz?=
 =?utf-8?B?dHBJdDZOcUVFVEZMZ0R1VnpjQ25Cc05Sa3VSRTFuVDhXNm5kWmxUb3crZFpC?=
 =?utf-8?B?Q0I5dkNpYmZnR1pCZ3BlOTM0ZGJvbGpHelRUdjJHaFdpZDlrWXhjbmJxYUxh?=
 =?utf-8?B?alFnaldOQnd3MS9YVTBSVGpMRDMvY2YvMUt6R21JS1dzTXM1QmhWMUpoUURZ?=
 =?utf-8?B?KzFrZUhycUNJRjFoY1lHL240eGZUeWswdTZiaWtLNjFpM0NkY0tCRFptdWhT?=
 =?utf-8?B?THAwTHBoUklzZUh5djNaZFVvd3g5NXRxUXhaYlA0cWVQNWRXc2kwMXZkMGlv?=
 =?utf-8?B?alFtWDZqWmxpeThEaWx3aGZ3UkxMSGdyQ2djT1gyajduM1JseXJQWG9DdEdN?=
 =?utf-8?B?VkRJN1YzZkNhRkpsMnRPZkYxUlNZMS82VC9rUDFmeGUxd2JUazRKOWxGN3l4?=
 =?utf-8?B?TS9IMlFVa0JUeVpJdXVnN0FXRjVGRTJvVUZpb2ovaFBzRENiM1Q2cUxnMWhB?=
 =?utf-8?B?M3RhQndtYzlEN2NtVmRCY3NENDBYanNqVHd1NmovYXlCSmluZ2FNajcvcita?=
 =?utf-8?B?SDkwNEE5QldmMDFXaGZ3bXo4NUhSRHNQNVJuaWVNcUZPNjhxY3V1ZUtZTjF6?=
 =?utf-8?B?TjVZWjRoWWYvQVZzcWt2UEx0UGtyNjBMS3RPdFJib09BVW9ha0FtZXQrZnIx?=
 =?utf-8?B?c2xuSUtMNVlQTmhiQ21oRW5VTzNaenNnQ1BlWVA5RGtMczNYOGdEZFNWc05B?=
 =?utf-8?B?NzBJNktBQ0U0VjU5QmpkNUUxMXo5TG9RejJGRzY4U2RHTHBheFRoei9EbWox?=
 =?utf-8?B?STNWSGFMN1BCanZVaUtSeW8yZWxjUjJMY3k0eHNNQmN6Z1ZQNnc1bW8xanBx?=
 =?utf-8?B?TUJOS1JzaGxPY3hlYXEzMjBhQ3VMeVNQb0orQ21GbVAwSGNuOXBhYzhNVGtU?=
 =?utf-8?B?QmdlQnBHKzl1b2JnV2ZKcWcxRklxelh0V1dGZ1IyMHM5VFZLWndKZjhjbURH?=
 =?utf-8?B?RU9lV0JKeURVVmJYUTM3dE55cDNKRVBGaS9xejIyWGQzRWpxS093MjFLbHRK?=
 =?utf-8?Q?DZqnJsa8882Gmb6HHGL54aGyN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b4dd7f-7f11-46e2-17e5-08dbb2ea60a0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 17:13:11.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db+9yRmPALtqz97m4zQ7q/JziL/s/Pto9yqfeJuyoq7zj2JVoToS5wlpJBeaO16m0xS+yQ1prHZb3HwArL7HpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 10:53, Kirill A. Shutemov wrote:
> On Mon, Sep 11, 2023 at 10:33:01AM -0500, Tom Lendacky wrote:
>> On 9/11/23 09:57, Kirill A. Shutemov wrote:
>>> On Mon, Sep 11, 2023 at 10:56:36PM +0800, Dave Young wrote:
>>>>> early console in extract_kernel
>>>>> input_data: 0x000000807eb433a8
>>>>> input_len: 0x0000000000d26271
>>>>> output: 0x000000807b000000
>>>>> output_len: 0x0000000004800c10
>>>>> kernel_total_size: 0x0000000003e28000
>>>>> needed_size: 0x0000000004a00000
>>>>> trampoline_32bit: 0x000000000009d000
>>>>>
>>>>> Decompressing Linux... out of pgt_buf in arch/x86/boot/compressed/ident_map_64.c!?
>>>>> pages->pgt_buf_offset: 0x0000000000006000
>>>>> pages->pgt_buf_size: 0x0000000000006000
>>>>>
>>>>>
>>>>> Error: kernel_ident_mapping_init() failed
>>>>>
>>>>> It crashes on #PF due to stbl->nr_tables dereference in
>>>>> efi_get_conf_table() called from init_unaccepted_memory().
>>>>>
>>>>> I don't see anything special about stbl location: 0x775d6018.
>>>>>
>>>>> One other bit of information: disabling 5-level paging also helps the
>>>>> issue.
>>>>>
>>>>> I will debug further.
>>>
>>> The problem is not limited to unaccepted memory, it also triggers if we
>>> reach efi_get_rsdp_addr() in the same setup.
>>>
>>> I think we have several problems here.
>>>
>>> - 6 pages for !RANDOMIZE_BASE is only enough for kernel, cmdline,
>>>     boot_data and setup_data if we assume that they are in different 1G
>>>     regions and do not cross the 1G boundaries. 4-level paging: 1 for PGD, 1
>>>     for PUD, 4 for PMD tables.
>>>
>>>     Looks like we never map EFI/ACPI memory explicitly.
>>>
>>>     It might work if kernel/cmdline/... are in single 1G and we have
>>>     spare pages to handle page faults.
>>>
>>> - No spare memory to handle mapping for cc_info and cc_info->cpuid_phys;
>>>
>>> - I didn't increase BOOT_INIT_PGT_SIZE when added 5-level paging support.
>>>     And if start pagetables from scratch ('else' case of 'if (p4d_offset...))
>>>     we run out of memory.
>>>
>>> I believe similar logic would apply for BOOT_PGT_SIZE for RANDOMIZE_BASE=y
>>> case.
>>>
>>> I don't know what the right fix here. We can increase the constants to be
>>> enough to cover existing cases, but it is very fragile. I am not sure I
>>> saw all users. Some of them could silently handled with pagefault handler
>>> in some setups. And it is hard to catch new users during code review.
>>>
>>> Also I'm not sure why do we need pagefault handler there. Looks like it
>>> just masking problems. I think everything has to be mapped explicitly.
>>>
>>> Any comments?
>>
>> There was a similar related issue around the cc_info blob that is captured
>> here: https://lore.kernel.org/lkml/20230601072043.24439-1-ltao@redhat.com/
>>
>> Personally, I'm a fan of mapping the EFI tables that will be passed to the
>> kexec/kdump kernel. To me, that seems to more closely match the valid
>> mappings for the tables when control is transferred to the OS from UEFI on
>> the initial boot.
> 
> I don't see how it would help if initialize_identity_maps() resets
> pagetables. See 'else' case of 'if (p4d_offset...).

Ok, I see what you mean now.

Thanks,
Tom

> 
