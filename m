Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685177CB28A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjJPScQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPScO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:32:14 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AEF95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rzp1+IzhGD0jA51zq6OHxZYOSKqcqoz08nFLUAXZPBM1Ad8KOwWTQIcKco5MoGN3Xc4KDaU8bvvCNpc8KdlaM4o1b8j65g5BJG6CC6L6zxL8tX9MhN402MPOcOwYA7014hfIMJ4+86Wfh8radXOY0JwDA8yF9mo8PmRRfd9G4kOJjwkZUu3wHM/RU1Xf+Uzwfcb/8TSViRJ8QEYwpLh5FaY1n18jseoH/XVVJrtWXm4RXfBhIDpzkWMjb0BgddG5cypipU19eMV+sYytIP5pQm2ZPvNRGEZB/lOf0FzRF+Rc/s2jj2ykZQLeA5w9SxpV8hrRBf6tnvU8b5gBPCKxxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SATH6hRX/DQyfbg+6aizGobtQTGlzziMBTTeVQiUFSE=;
 b=D1Ae0JIVzZqFhNnM5RC469lljZLGO8pvrn8vn49yJaeE31PUxzwJJGWIf5ibgcGFjS0WG71yK/hEojbnKJaNHxizDI0DvD06UwrdNAjOV+74iHHAgdYSLIWFFczZONAQtKUddJvxqq1uTuo1IodTyGLcp9BMdGSDQI/LE2Svzs7APUMOIw91oZF56TwQAyIPVmayCPD6Lny4h8E/sIgVUpCc1iKEs5JvHGAI5aG4J+D8kdGrg0t/qymqpsr2KqLQLatRPSwC5QAPhu/5xYgDOJXj5baAp55vlvMH+81FmgT2OfKpzv9y910S3VkMI81VwXRcyA0He5rVoz3Ydaf/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SATH6hRX/DQyfbg+6aizGobtQTGlzziMBTTeVQiUFSE=;
 b=Zxa8YFXiH6o/wu4yjcw/JudxHlJEFzTJD0LPcQJuX7mlyw3CnNG5xUT1u27LCEXW6jvLsMyXbhpTL0DuH6Z3/ugdp7YZbfcf+euwT5L/FD9jFliIdjxMkOkaXqjLwbA9wlBD+EZhjPdZGxDdHd+bTD37cpwQoWyKz28psIEj7Pg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 18:32:05 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::6ac8:eb30:6faf:32b2]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::6ac8:eb30:6faf:32b2%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 18:32:05 +0000
Message-ID: <f7aa58e0-7fcd-35a9-d04c-1369a8cb0701@amd.com>
Date:   Mon, 16 Oct 2023 13:32:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] x86/mm: fix pg_level_to_pfn for 5-level paging mode.
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org
References: <20231013191703.422085-1-Ashish.Kalra@amd.com>
 <ZSpVtZhks7Wm5Upc@gmail.com>
From:   "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <ZSpVtZhks7Wm5Upc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0106.namprd12.prod.outlook.com
 (2603:10b6:802:21::41) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 223a17b4-9278-46d1-5f2f-08dbce7632a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /o8gzFdS+M9RIGbcjmP81VpHA23oc5Uvm69tugjYNen/xF6rFPK5BdPAPyXBVnh7OjGCIDlR5XLF+YnIz1kfRa/ZtAWomXDofFHCzb4b7dqEaG4pFKrS5MMSX4qbD/NdDrPtvVwVniqwpU4B1k64X8GY1P54mPDk+Dsg2HsR3Z9dRQJPbVerHCI4+VC4Zg9eLCbg/m+4hFKDxBT4z/JCixyXxcbrScNvfLAjd9Y3zyH6XG+W/0nKRRQg+vddJy5gCrzcjjhyb0a1nPfdMWPT3ZphowqC0Sgvm7Kt1sN2g7Uz4gH5521QglXiRfe2WuRdoS3Yvi4gzfl8c8uzMcz1/aNhYCGSmoIEJ+d6oe0Zv0YhVLIMAus293S/cqS2hMJxyiYPZi+6scd+fxlJlca/zjYrYNSNptNZm/brA/VMYxe6ZNd5ZZNdLKVLuPACThK1nstUfmDbHI9ogrStSPAAG78QFhYUOejVh9Cc2e2ohNccPDewRxPViKkNSR5O6ZcXN4xA5KQxcP0HwdZ0iCIuL5Kv98fwn6yQ01qSiRyyn/k0K7uLF8MnTWC8RIvD3asRc6QB9CL1Ta23blxsuw3eHuEgY92WGxHpr0niJlYTx+negveWBCxVwWX20EZ5342c3RjTqAcXDcAfoGqOdoHnEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6916009)(66946007)(6486002)(478600001)(66476007)(66556008)(26005)(6506007)(53546011)(316002)(6512007)(41300700001)(2616005)(8936002)(8676002)(4326008)(7416002)(2906002)(5660300002)(36756003)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnZsZ21nZ3VDVlJrRFEyUDVuVm83OVFBSHVpNE1tblVXQjdWZzQ2aElFaGEz?=
 =?utf-8?B?ZTlSWWcwZmp6Y0ZVVzVsaUd4cmFxd3Q4YkFwRW5ucFFxQmR5SDRNblhja09k?=
 =?utf-8?B?ZFVWQjV3UkNlL1k2VUc4cEl0VFhFZlNnUEJwb1owRGIxcUdURmR1V1VtNzRa?=
 =?utf-8?B?eGwzMlVQYkl4ZGVTaVFtVHBkcXFwd0xTOTRFQnhVTjMxWDRPWCsySEh3YTlE?=
 =?utf-8?B?c0hka1g5UnN2SmsxbFVZb3lEQzQ1NUptNXZmVVBMb3NORDFPcTdzZ0NibXgv?=
 =?utf-8?B?MmRtU3VLZ0kxbytJWTRlQTVCUmdSSnc4WUwxcjJSQXNZTmU5cjQwVzlVMTlu?=
 =?utf-8?B?L2xiVG90bStoang0bEJuVkdOTFd2UkpoL0VCdW8zeEJOUENDMzBDTzhmVGxk?=
 =?utf-8?B?Mk1rUUVqZjVlMUdxT3RKTGRzbyt2QVJaL0s3cDNqY0xOcVdZbFUzdTNvMEpP?=
 =?utf-8?B?a3U5d0xQcmpUUzRIakgycXdiQzRnUTFsTk52NWJUWmhJQUY4QnZRTjVqeFZL?=
 =?utf-8?B?QStadk9mWFdpWitKaVhxYXh0TXRVZm5VTzZsUWJwOThPYVBBQTcrR0xtY1h1?=
 =?utf-8?B?akM2cnVjazh6VnVYVGpnMzhLd3R0dksraURsSnBpbERtYjJiTThOOUM2SVVK?=
 =?utf-8?B?UlVVdW5URGFiYUFaMmlsSC9MMUxscHRpYWVOQnBiMmJvVUR4YmJVeHMvLytp?=
 =?utf-8?B?NThDeW9lcUVmUCtqdldpc0puZlQ5M01ETk5rd2VDTkhoSkNmMmRqMGNLRXEy?=
 =?utf-8?B?WU40U2x3WEFVaWUzMGtseDZOREJIc053NWpCUjU2dFoycmp5bDZuczgwTlpi?=
 =?utf-8?B?VXpsRG5sMXI1SHh1UkZvaWJicFRIZHQ5L0VxamFBMGxDb2VBMHNndUhUdWRW?=
 =?utf-8?B?TWhoVXRDN3ZoVVZRdlNRV0tEd2dLekpOZWJWNVFXSGFsZWwzaUpCb2ppTWtw?=
 =?utf-8?B?bW1VN1lhbTVZRWowRzJ6a0F3WG9hSTlPdys0NzBWRjd3Y1RGUHZSYitGK3VX?=
 =?utf-8?B?MmtoUkhkVU0yb1NQNzdKRjdJdnkxOEx5YVM2SS9nUWNNUXlCSXhRWXEwNzU2?=
 =?utf-8?B?WG1JY3pDVjIzUTcwM0NyNng0Qm9FVTArRmtvZFROOW9NYjY1SWR4OHkxQnZJ?=
 =?utf-8?B?STVwS0hWalN1U2UxaTlsM0R0U1NlanJOYXJ0MHZ4Mzg1YlVpTis5eUF1TXBI?=
 =?utf-8?B?N3VaelpIemVFVk14SkpPT0o1SS92dTc0STlTZTAwclhLU0E1eUQ1NkJZb1hW?=
 =?utf-8?B?ZUVZR1RhVTc2emNDa0FjekY5cnQ1UVIxb0VtaEZwRW82dWNpQUV6aW1GS2FW?=
 =?utf-8?B?ZnJtdzB5RmdoYmdSTDkxZExUSHlkQWpYeWNkL3N6THRqYko4OXpVYzVaNDQw?=
 =?utf-8?B?OThKMW00ZnEvaG5UYi9XeGtka0txNTdHL1NHRTRRMzdpazgyc2U5UVhTZEgr?=
 =?utf-8?B?cy9Gbm02N0RFQ0FQUm1KS3lqVEx2emUyZHdaUVlSMEZWWTJJMVg5bWhEZ2FH?=
 =?utf-8?B?RzdaVXFQVFJQQTBuUFVXMlZYZDUyQkpwT01vdlhXZDJyUEtOVXk5YXQwaUoy?=
 =?utf-8?B?eDBIa21SMGJTTVhHV3RndXhNWXNnbGRneFFBWVRMSW03SmVSVnZCV1VxOEpj?=
 =?utf-8?B?UlRUZi92NWxoNVgxVitqTFFyMVYrQmg5WGxDZnFDbSt5RVJRUHhNOThhZDhM?=
 =?utf-8?B?a25tSHM4ZGp1NWJoU1pydnI1MFB0TWUzRXBHWmsxcU10K0luMTg3WjdidXVi?=
 =?utf-8?B?OFlFVXo0My9MaDVWaHgzanpMOWtvK0taWm5NQU9DWUVOd25DRnM2d0dZZUwx?=
 =?utf-8?B?K3J1cDU1SzZ6RVNqMGFYWk9LOVh4U0VhLzJnNVpqMjlPaUFvUlA2TmlSMm0v?=
 =?utf-8?B?SlBvZU9HcDhmM2M3YUdKY0ZLb1kycGt4c05mRWxlNFFmYW9ZSzEvTEVGY2Ez?=
 =?utf-8?B?ekZhVkFZRUlHanlMekdGWnpYNGRJMGI0WjN2enp2aEJUUjNEdzBWbFcvNHlP?=
 =?utf-8?B?a2p1Mkg2ZDBjVzRhUnFRMC8yZXdBN3NFQXJhSG9rT0tYdHV4K2RUb0I4M1p6?=
 =?utf-8?B?K05PRmFtcUdUYkJiYWtDQWJXNk1mWVR1c2xHcXp3VnNNQ2orV0k2UEVHUGVP?=
 =?utf-8?Q?rrEiCRxrk7D00wWOPRGhrljNF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223a17b4-9278-46d1-5f2f-08dbce7632a8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 18:32:05.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZlL1i2Ujv9fTq9PawQX5lvF8xmxc1pb1k5IvWIn9U5lOpQRcQ2bWT8pLv3PzmeBI+HRaS9CLcRKKMjmb7bakg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/14/2023 3:47 AM, Ingo Molnar wrote:
> 
> * Ashish Kalra <Ashish.Kalra@amd.com> wrote:
> 
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> Add support for 5-level paging in pg_level_to_pfn().
>>
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/mm/mem_encrypt_amd.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
>> index 6faea41e99b6..45914568596a 100644
>> --- a/arch/x86/mm/mem_encrypt_amd.c
>> +++ b/arch/x86/mm/mem_encrypt_amd.c
>> @@ -267,6 +267,10 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
>>   		pfn = pud_pfn(*(pud_t *)kpte);
>>   		prot = pud_pgprot(*(pud_t *)kpte);
>>   		break;
>> +	case PG_LEVEL_512G:
>> +		pfn = p4d_pfn(*(p4d_t *)kpte);
>> +		prot = p4d_pgprot(*(p4d_t *)kpte);
>> +		break;
> 
> Mind explaining what happens if we don't have this fix, how you found it,
> which users are expected to be affected by it, whether that's the full
> known extent of 5-level paging support deficiencies in mem_encrypt_amd.c,foud 
> etc?
>

It was found during working on SNP guest kexec support, this helper 
function is used during early boot stage for setting of C-bit on the 
PTEs and additionally need this same helper for switching shared pages 
to private during guest kexec, so i believe this patch is needed.

Thanks,
Ashish

> In addition to such patches being much easier on the eyes, it also helps
> maintainers prioritize patches.
> 
> Thanks,
> 
> 	Ingo
> 
