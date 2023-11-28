Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E8B7FC180
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345332AbjK1ODF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344798AbjK1ODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:03:03 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1152B85
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 06:03:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYXGfin63U1e4OUoi/K3+wKnZM0MUT4pBVCcw7BPW/xEp3DC3uHgbMPb46IPnHE5XbYsrbBYcb40MNneneMTBXTbL1487lQHcNKG7T/mt+KkFvGr9zF2rZR9dnYIFNFgQbhOVwa57n8mRzUtjfPFCurYy9E0bOw/mQTSysF6SWEO4alYGjjXcQIm3B42/j34Unbs+hL5gXAFjr8ZnnmAI1HAHoBcZ9pPQke1Ha/SgS6/gyU3wpJCemzP9B7p0yd5T3T59DONkxDLKp/1x1bIklHVN1U0Rjxsw6Obo/jBY0JBO/3xGIqy5wnjn6OO+hiEnbtMhY5JP/tizNFleR9yCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zm4IkeO2pxHmfzGex2DZMXhGNXVroixGAClUkKJ78OA=;
 b=dGgPv4M8GBUlvzQTwc7q9U9TTmmupmmQV/Hgfsb/IgBs27OmanRlmKT8ms6OAwnA3/azg2J2mHwEDYS12U0nzrB6te7qoBjJaym/auIGmXQasdIWBMxtOE4kymnBvqqy79jWrXrdLs4PIaniayfgE9Nki3RBm+GofDPEo1Sj+83h6NtZ4tXagwYiHYQyJeiEz4dUCGzSUd4XMbqUZd94XexURr6VBpWDRF849/oWlWOjSMTgPwxgC+idNBD0ehNN0DK1XcljxgG/UT49EOwxEUPlUrP6kq0TQtqlcVvFzmvCZwu/YTWH6+/gzqldAEIyrrpn+ygthYpa9wAEaw5/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zm4IkeO2pxHmfzGex2DZMXhGNXVroixGAClUkKJ78OA=;
 b=hSMOq74Z6BJmvdi3jxc8nv9KOdlajk49O9+rp88qwDkbvgqkKRaUaN0qzfx88MonAkS6RVZiBK/qPJzNnQYCNp53tc82HnhrDO4Fst3Tg1FI8FvhDT/PHPPdno89TQTtpnMPRKXrKxO0UfVLQLfEWA+/HyRP03R6XRcc5BJp8uQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SJ0PR12MB6758.namprd12.prod.outlook.com (2603:10b6:a03:44a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 14:03:04 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 14:03:04 +0000
Message-ID: <29e235f7-add2-47ae-b06e-a717202c4faf@amd.com>
Date:   Tue, 28 Nov 2023 08:03:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: AMD Memory encryption vs. kexec
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Kai Huang <kai.huang@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
References: <82b2e0d5-edcc-44f3-b759-d6b8c8788ea6@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <82b2e0d5-edcc-44f3-b759-d6b8c8788ea6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:806:23::28) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SJ0PR12MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c371250-2a0d-4151-1b0d-08dbf01abd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cSr95h8QrKKF6fa/a1bHewtKPNFcudCSTBila7uy4fqJrsb3uyhAEfI2vF7m+iuD8W4cAClIZ2Wxu5rFZFo/NFyI4/7JKMZrHiLCt8fhiR7XNSPglUdFFGlwX1Y5RanKUGmYiBWRX8ZOM8T1FdKgVt1mV38pdWvsjf6cwVNBw/k0bsCoK4uSckZg0O+xOddWTKSZAwr/COA3IiFQorsPIrE3MU3iHfmb1N2Vn2fr7+ehvhXIc/DVb55DVOrK38djFo8hOoeldye1tb5u9O5F2gdD0u7F3xiy+e8H9O+nxXlEiBS74JYOxOoda5aoQ8If+67yM7Q4J5zkM9+tz6DsBebf+e9kaGoF3xIXiAXRT6ibAP1dd+zCeBTHVq86O/eHF7BgZMR+10zxeu+EzpQwXVWrIgXb9DRmTntWO5kFVI4gVQQVwDCheo3sMsY5004f19J6yV+3YAkWBO4yIXmCgY/dawea8EsFEMP4VIAdTOP23OYUIZsnVqOOnTzWnY9pNs1Sovd+hEHO1IMnI+ghd8aV6Z9MLIhR9LkpqcTS4+J+Ti3uWi/KnfYD6ayBVJsyO8gK9U3VAqDqZZg51lqfXx02/hgaepfyi88pU67YzO03raZl7yd5X/RykdLTLubqIhxCJEM9W7isD2sOy+vXvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(36756003)(31696002)(86362001)(66946007)(41300700001)(66476007)(54906003)(110136005)(8676002)(8936002)(4326008)(5660300002)(2906002)(316002)(6512007)(31686004)(53546011)(6506007)(2616005)(66556008)(478600001)(26005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWlycDZ1RE80TUZXWHd2L1ovK1hnMG1KV2tmSDRNeTJnd2hzSTJRQ0ZuZHRM?=
 =?utf-8?B?NHo5YWRwWGplNmd1MjhLV0FzTnJrclNadkErQWlXdEpCYzhXTUprNXBXbDFW?=
 =?utf-8?B?ZGtua2lZZDJVakVoV0tYTk56T2FCNmZyTzByUm1FVzBHZHkxajgrOWpvbG1T?=
 =?utf-8?B?MVdnR1h6M3VDdkxPRTJ3Ly9tcWNCMDFNYTIxNFp0WkYzUzlwWUxsR0c1eXY2?=
 =?utf-8?B?c2dzV1lkc1RnWmxFM0szU2pXWGZyMnRiWmVVSnNJRmxmWk9YaTE5REdFSU1T?=
 =?utf-8?B?Sm1Sc0NqYkcyYUVPakRiTzI4VE9uN1I2WVdFeXFsaUhIOFM3YTdxRUtDajAz?=
 =?utf-8?B?VGxkOVNVbXdsaFNSRWVLd3FwbGVxak94bFFnb1ZjdUYvWlFNRXRSMnBJMWJU?=
 =?utf-8?B?eFpoVCt1anQzL2J5TGlWQVJmM0w5QkgrQS8zVUZONEpmY1NZaVZ0RGwwMjNz?=
 =?utf-8?B?UDlyK2IvUkpiUytiTFcvWkNMUDVPR3BKVDlOa3QwSU1IVXVvMHpSNUdWMkp5?=
 =?utf-8?B?SDVxVEZyUGRaYUl0R0c4a1YwcnFidlFISVYrNHhSTC9uUzdFWThYT1J1SUNj?=
 =?utf-8?B?V3p1RHpjMHFqZUZXaEhONzJ0cUZ6WkVDV3FwYlo0a3h2Mm1Ta21ucEZVblIw?=
 =?utf-8?B?SUVGeU9lZDRJK2N0MWFhazZNcDNzaGxBWWdyVkhDbDJsb055QVluVkpJUlI4?=
 =?utf-8?B?bVprRDRVQXNkSkl1Z0xXTmlxa1NVNi8xSEdyT1pjRzk4a2lWcEQ2VncyVVFE?=
 =?utf-8?B?MGJZcFZPWE9ENzUrU1FrRUF1QzNZSXFJOTA0UEdVYlExamtTQnVZUEFBZEpI?=
 =?utf-8?B?bm94bmZUWmUya3p2UGl4TDBMZEpoaHp6WXdQd2pFUVFLcUZjbW9UUDRLd1Zy?=
 =?utf-8?B?aUlaWFh6QlhCcXUxVjJjNzNyY01OZGQ5b2EyOHR1MVd6RHRiS054SVZDQU8z?=
 =?utf-8?B?WDZOa0s1cXpPS3V5bHRLNkY1RDlHeGd5dXRVOTByekVpYTYreG1CR3BhZVcx?=
 =?utf-8?B?TkxuWUIvQkNMdFN0Z2lPMFRrNWRRSEhhL3BoWldEbXdzV2Z6SmtDUUFJSEZU?=
 =?utf-8?B?Q3ZhRU5IcHRvV3pzYjBtVm1SMXI2aWZ0NkROQVVkVlA4M1dHcDY1YlFJSS9l?=
 =?utf-8?B?TmlMeGo4a0xicnpuM2dJcXJOMWNKaXhJTVY0T0ZFS1F2Q0NERkNCSW93a3FS?=
 =?utf-8?B?dlRxbjdwWDBMWWYwZHRranpUeFY5V1R1ajExeGJ3bUR1TUxHb1UyZXlEdDN0?=
 =?utf-8?B?cVFxTEV1blhKVEJPYml4c01sRDh5TUdPaElUM2Q2Ulh0cGNQeHV0a25RdlBt?=
 =?utf-8?B?WXQ1c2tQL0ZrQTIvV3pUYzNRSG13dkZHS3FFZU9MUFBwbFRFUllzMlpnanhZ?=
 =?utf-8?B?Z1hhUGNwSGxsZm9pVW54aURqTVVTMEkwanVUdENhbitqZGNZOERYcDZJamxV?=
 =?utf-8?B?aEgzMldVVDQ1SEpmeDRmTTdpaVF1c1ZOb00xNDh5NDh0ZTFrSjBTSUFubDRQ?=
 =?utf-8?B?VnNFUkFQRWw4eEF3UkxieDZwRXlTSGtieFNRQ1pMbVJDNTgvU0NKbExHSlJJ?=
 =?utf-8?B?L2xQTUkvRUJNYlJHc1BLc1I5ei9VS096Ri9ZQkh6M09aK05rQWVHdnpXeXZW?=
 =?utf-8?B?V2wwVDdKdTVCb1lXeWc4NEZsYUFVcUQzeFBnNEQvQXd3TmhDL1I0WFQ4Y1RY?=
 =?utf-8?B?dFBTSnd4Q0NRb05JR2NxU3A0RU1NMkkyV0UvQUJPZWU0MGR5eVgweG5wZzNO?=
 =?utf-8?B?TC93WTYwNnJ0djBnMVRrN0RzVkZXaW1QQ3pKN2k1ZFRLZ3lLZkNJaHVQRHFs?=
 =?utf-8?B?WERzaUZ1OW5CTjBjZVFrSWZSRFYxTERpeFIrbXhyTTFwZXI5d3duKyt4dlRV?=
 =?utf-8?B?NkhOUVQ4WkZadnhKZXdSRG84VXZ4MC9ObVY3WStFYmk0QlFwSTdidnJUUFQy?=
 =?utf-8?B?MU1xMzNlK3BUYXo4RnF0Y2JYUUY5diszRDlrLzgyK215N3Y0b1dkeGEzZUlO?=
 =?utf-8?B?cHl3aWZKTElEZ1hZT2xWZTRibWtCdGFReEJvNnRXTlVHMVRYbFVxWGIweWdN?=
 =?utf-8?B?UnE5Mlh3MGl3MmEreUNpMktIeE9ncnlWQWJhMXBPYXBTZC9wTnl6ZFhVLzcr?=
 =?utf-8?Q?O1GJHhXeG3KToJamXe1vxNB7E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c371250-2a0d-4151-1b0d-08dbf01abd58
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:03:04.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUFr7E0GOw5GPYtDkUHz3m7yOgRmL2SuZbZXfU1DzU6k7t2ApH42drT90cPHllkd19rcRRznRN0OxqDq5vCFWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6758
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 18:00, Dave Hansen wrote:
> ... actually cc'd the mailing lists and x86@ exploder on this one.
> Please reply here.
> 
> ---
> 
> There are two kexec-related wbinvd's:
> 
> One for the kexec boot CPU in relocate_kernel() which is driven by
> CC_ATTR_HOST_MEM_ENCRYPT:
> 
>>          image->start = relocate_kernel((unsigned long)image->head,
>>                                         (unsigned long)page_list,
>>                                         image->start,
>>                                         image->preserve_context,
>>                                         cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
> 
> the other is for non-boot CPUs in stop_this_cpu():
> 
>>          if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
>>                  native_wbinvd();
> 
> By my reading, the CC_ATTR_HOST_MEM_ENCRYPT is basically a check for
> whether the current kernel has enabled SME but not SEV while the
> stop_this_cpu() site is driven purely by whether the hardware *supports*
> SME.
> 
> The whole supposed reason stop_this_cpu() checks CPUID directly is that
> the current kernel SME/SEV enabling might not match the _next_ kernel's
> enabling choices.

Correct.

> 
> So, why is a _current_ kernel check OK for relocate_kernel(), but not OK
> for stop_this_cpu()?

The relocate_kernel() check provides an indication of whether SME is 
actually active. The kexec kernel is placed in unencrypted memory to match 
how the system was booted - where the kernel is loaded into unencrypted 
memory and then encrypted in-place if SME is desired (mem_encrypt=on). 
Since the kexec kernel will be unencrypted, the cc_platform_has() call is 
used to indicate whether to perform a wbinvd to remove encrypted cache 
line entries. If SME is not active, then there is no need to flush caches 
prior to booting the kexec kernel.

With SEV, the kernel is loaded encrypted from the start and so the kexec 
kernel can remain in encrypted memory and no wbinvd is required.

Thanks,
Tom

> 
> It seems to me like both sites might need to use the
> stop_this_cpu()-style "raw" hardware support checks.
> 
> Why do I care?  TDX potentially needs wbinvd at the same two spots.  It
> would be nice to have a common cc_attr for both sites, but I need to
> reconcile the apparently disparate AMD uses first.
