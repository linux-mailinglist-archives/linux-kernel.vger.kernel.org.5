Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2EF7D3BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjJWQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjJWQEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:04:38 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B8CE9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gm14cnExuGT9NLQLS9TeV08AFI5pE6aYnWCw9/WQfA7RXnsNV0e5YKerNnQT8FEuG5dS8lmbPgED/bWw/ncNswlM+wNlk8I6/JKLiYES5H71CcLR83tg7QEZ75qY7feadFsVbWGQbjyZFpzCzm2rzb+mh9ePp9WwTQ7zYKJfLfBqyIYF2W36oMmvqV6AYtY6jM8EYbtalEOnb1MFbFjvdufGqk64mB1SqIB32Em4MajMTx+k5n3/Br4oxt1uTdzB/O3g+OwrxFchbJOWMxlNSDqHv4Lkov8WtOJIFs5DCiOKgYgkbwrRQrwKgUuqX2Jx+A2tbuE9gFZ2lelta++3UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSFbEQeXZqNILCgUNRgd8D+EDBpuFMk9fWnK1lyHOO8=;
 b=ZYFT+dS1oM96wuUgOMxMBAu4tVPd1D/9SENO0kMVEmjK7dNmT1dqHcpVHFPx+aQIaHQrwnyv+EUkC1gq5nbfXnzwXnxJqI1wy0yJCVtFepjhVAcRxRCJDnAh9nat07WQiM+FoJOQjqkXraXuP0Gx5Gl8/gvwF0WGCPt4bNKaU1sDbzr6h3IGYAHe9+yyGdFFATGOofH67x9Qk6NkjTq4mGJxQm4rXLkLCfLec5F6T03+fnlSo0VFl/cx4mNJMC8+fy1SpRclBov1wSZKBuxPP31b4aXL6vaxpudjdhO/xZLRLFXMH3ltuFYPQm7/Z2z6Bm8s/6BAgWgYUhhJbKdtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SSFbEQeXZqNILCgUNRgd8D+EDBpuFMk9fWnK1lyHOO8=;
 b=IeFFQYyJwHfzHnztXEIyQpiRH7FN/aQrR1o9cU2crcLxO2rUCMuu8Pd5TkqDPhRm8XJmBAkhmH3Aae7Kz53mmwPy9b9Za+bFgOyuFgc5GCPCxvjU/IufAjWZD3E3tRCA7baKZjj059V5dXRWUNmbd+mp/Ef3/fhSEulwx4SjMqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB5418.namprd12.prod.outlook.com (2603:10b6:510:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Mon, 23 Oct
 2023 16:04:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 16:04:33 +0000
Message-ID: <450e06f8-5655-406e-b485-c19862bba6d8@amd.com>
Date:   Mon, 23 Oct 2023 11:04:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: X86 parallel bring up regression
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     x86@kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Michael Kelley <mikelley@microsoft.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Helge Deller <deller@gmx.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
References: <3d96c70e-da3b-49c2-a776-930a9f1b815d@amd.com>
In-Reply-To: <3d96c70e-da3b-49c2-a776-930a9f1b815d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB5418:EE_
X-MS-Office365-Filtering-Correlation-Id: f6723a6d-84c2-42dc-1cf4-08dbd3e1bf2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +p9gYNiIVmma+zPvqsOOYEmj4l5bTTtEF5o9Vjft3+Ok3R2CffXkf9CtpbMm8N0MdKh9stlNT7TYlqw7Y9HJ8VREPi9f5rPSyeLwpHO9rK8MvWfLlMiLoFgGbJum2TUPyohWMr/v+aWR8CiiyxUbsnADyRcfEvAZHELzEPVRJ053LZ8ooXs4w5RALPBnjntXyxdvqkKY6U4N7ZipFQI9hFrjwjnxbHB9xaaqOEfXVT8wZ2BUYLnrhfplXFZh7K4eRI0S6HI0SaXw3alumyAUoFYw9OtXfJlt+rY5G13wHRK8Gp7UNa82WX1y07nFk/TzbMHhT1X3zIRuv2/nLQpRli//z59RVYg24R7dM1FCyR8mOaTsfiX5lgtxqo1VRlAOEIim++SsABq0+L8VY9b3t2UhwByX436Rjt2xShVYhiUdMK2rHF6JZnCqtXtTDr3wfXOrC08u/jAUaTOJoXNCHhWrFDR4Mm5zn8cG3+IueohnhHohMOduC11eiRoN77tBRDKVNfWSx81AMrgsmwlLIO5we2WOpbfeg4D000aJe/Cn7wzwvqBvNEqI1bC9IxyFyHpic6h+TxQHxe7cyxLJ7kBNLxVI+3PT19v+xOr09WL4DF1CdxJzSkg4/TXfULTWBUnbyfJx4cN7ZiFdlSRPxmrtdDi2rLCvtf1wu2Dl/cU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2616005)(26005)(53546011)(38100700002)(66556008)(8676002)(83380400001)(6916009)(316002)(966005)(6486002)(66476007)(54906003)(4326008)(66946007)(36756003)(41300700001)(8936002)(478600001)(31686004)(31696002)(6512007)(6506007)(86362001)(5660300002)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHlLb1lteFIxVVhRSWNSYURxOENoczdUTGFHQ0Q3K3ZxaGRNUnpQWXVOeU5i?=
 =?utf-8?B?WjBYOGczVGk4VHdFaVBJZnRTUmltUklqQ2h1MXhCVFJZTGNWc2srR2tScDJS?=
 =?utf-8?B?K2Jvd0sxVmtSdlkraFVQQmp4NStmV1krSjN1cC95Z3FXb2VHWGZrRkI3WENt?=
 =?utf-8?B?SGd1TFZyTmVlUDZWY2xUSUNMbDE4QjROVlRWaDJmRUNIa2ZLSGZNbDMxVG9K?=
 =?utf-8?B?U1YxN0ZVdER6clB1Zm4wSERVdzBWNzZjNTZLeUJGN0lHM0N0THZ4OE5NNnQr?=
 =?utf-8?B?VVBWSU1wVEoyWmJLcUdTK0F4QzZoaWNpMHhsT2VpUHRIVEVWZFJpaTZwVW9w?=
 =?utf-8?B?dTBNRklTL3N0YkxiUG9ZSXltOTRuR3J2ZUNBNzZvOVJyamFVQlNBQlJic25F?=
 =?utf-8?B?eGpnSUU5aUNxMmY5TmpxZXo0WXlwemFNWnpTRlkxRnJyejhlSjNFSkVpOWZo?=
 =?utf-8?B?UGxwVXZNRW9WMjFwRFdLRm9Sc0l4QnAxRXRqdnp2eFZjRU5wcVg2WW9VbEYw?=
 =?utf-8?B?bUI5WCsvaDNIb3JxbVN2UTZnT0FWOUJVS0h6L3pGdWJtdWQ1bTllL0VST3Jh?=
 =?utf-8?B?VlpJdXJmdkkraGRlc3UzZ2FFODUrTXZFRXE1TlY5eHNYbk1WN2VDRlNiUmNy?=
 =?utf-8?B?bjVSTXBrTVVkWHRSNnhoa3diemhheURmVmYzTTNBN04vV0U1Uk5qRi9kTFEy?=
 =?utf-8?B?cVF5MTJaZXhNbUJaSk9DVnI5V3VPdWxBMEQ5YTJDVFpoYlM4bWJzSE00b2VH?=
 =?utf-8?B?dk9Nb0QxSThnL2tkSVpCeUJwZG01Z2NubDVYZG1WZkR6c01qaWRtRUpFVmZz?=
 =?utf-8?B?SkR2cVdGQWpuZnpXY1JtN0VoaWFDdmtZT0xRbHgyaXpBQ2ZzQTFvRFRSd3Z6?=
 =?utf-8?B?dFRNcmpCQlpiL2JDN2lOL1dLTENib0ZxQ3FwNGFuYjZXQWx4aWx4M3poc1FB?=
 =?utf-8?B?NkdET3NWaFhBemJYZWRCYWx1aUxSbVJHTWlDMWRHTWtZVkJzb0ZKSk04eUJ1?=
 =?utf-8?B?WkpqYTlmOEl6eHh1T0dIRDl2L21JK2JJdGVlRXFlY2Q2dmhXNTNCN2FnWmww?=
 =?utf-8?B?L25SaENsa0RrdlhJQzVWSXZ4a1VnbnhsTGcxaW14NG9NNlphMVdEejd2OUtJ?=
 =?utf-8?B?NXRmQndIQU5XZHJFSzdEbnhZSGhRdmVHbUJpT1BuRE80MG5PRXFBRWhGLzZT?=
 =?utf-8?B?TWJWY2s3RXNMVCtEc3pxa2xmWWo1MXpCZitnelpHeC9nVkFxMXo3eVhaODFR?=
 =?utf-8?B?dnBTb3RyT0t2dVI1WmhPak5lUUhLc21MTFlkZmN3U1lDbWdicEdOZXIvUUdr?=
 =?utf-8?B?aW9MMG1NOWRDMENxSzB6ZXNRU0gyYWJ6K29ScWh2cy91T0pZdWZMRko5NEd1?=
 =?utf-8?B?aktoaW5DL0x5TC9qZ0Z3bVpCd29DNDZTb0pURGxWdmJkYXBiNzZvTld4MmRS?=
 =?utf-8?B?SzZoZ2dVSTVONEJFeXZYNjBWWXd3aTM0Tk5qeVFZL1hZS0ZEb04zYkxEV0wr?=
 =?utf-8?B?VjZNZHBvWXp2NWQ3YTJxUllpSi9rQjAyVndUSVM3ODdqS0pLQ2pGTmlNSDhL?=
 =?utf-8?B?Sk5BWjRvalJDSGZvQkI1enZCdkh4TnBHTmFsVUd0WVREUEFadnVjN0wyR09u?=
 =?utf-8?B?SXJLb2NjYzRtSkxYUXM1NHYvUGtLSjQzSVZsL2NaWXRjbWNYVHVlc3pjTVdS?=
 =?utf-8?B?anFWMUdCd0hJb1RobzFuS3U3MlpFSlRaQVZTbk9iM1V2ei9OZlVSb0R3Q1p2?=
 =?utf-8?B?dGdjU251YkxqL3RuK2hPemZBWDhOVzdQRFhCblZBWElHNU03dHpDZDZ4blFN?=
 =?utf-8?B?STFJYWtrR043TDJxcklCUDB5TGlYWTBuS1NwNDBPNktXWW8yUHFxMGtreHdR?=
 =?utf-8?B?SXRGWnMyYTdLcTN2WmU5WjNVZmpxaHdPYTVTeFQxeFNTZ3IvSkZMYUZSbVl5?=
 =?utf-8?B?VjFyQnYvWWlDRzBGcCtreTNGUWQ1alNtby96VnZZVkhGVDR4eXJSNzEwUG5R?=
 =?utf-8?B?VlpSVkdobmJlSGlia0dEc0lRT0haQ2REa2U3TjZDeVJDS29MMk1jd3RZRGtY?=
 =?utf-8?B?M0Y5VUh3bjBseVVDMTdvKytkV0EwbHg3QVZ1VWQyMHJ0N05ocHlPNm94WTVI?=
 =?utf-8?Q?CKCRNOOuUsmpczQKxN0lfgqo1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6723a6d-84c2-42dc-1cf4-08dbd3e1bf2c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:04:33.9197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fv56ySMLP1VQGwF+xqRN0Ik/IX6n8h+viAANeNKQw+ey11cqNfgi0ucqSkKO3oPtq/M37kuTsgWSewj2M1KDtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5418
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2023 15:26, Mario Limonciello wrote:
> Hi,
> 
> We've recently found that there was a regression from 6.5 that broke 
> resume from suspend-to-ram on some AMD platforms.
> 
> We bisected it and confirmed it's introduced by 0c7ffa32dbd6 
> ("x86/smpboot/64: Implement arch_cpuhp_init_parallel_bringup() and 
> enable it").
> 
> Furthermore; we confirmed that on 6.6-rc6 adding cpuhp.parallel=0 to the 
> kernel command line avoids the issue.
> 
> Here are bootup kernel logs from an affected system at 7e75178 (doesn't 
> reproduce) and 0c7ffa32 (does reproduce).
> https://gist.github.com/superm1/c251c0849956b8389309f03871fba091
> 
> Is it possible that this is caused by the system entering S3 with x2apic 
> enabled but leaving with it disabled?
> 
> I notice in the resume path on a boot with cpuhp.parallel=0 that x2apic 
> "explicitly" gets turned on again.
> 
> <snip>
> smpboot: CPU 127 is now offline
> ACPI: PM: Low-level resume complete
> ACPI: PM: Restoring platform NVS memory
> x2apic enabled
> AMD-Vi: Virtual APIC enabled
> AMD-Vi: Virtual APIC enabled
> LVT offset 0 assigned for vector 0x400
> Enabling non-boot CPUs ...
> smpboot: Booting Node 0 Processor 1 APIC 0x2
> masked ExtINT on CPU#1
> ACPI: \_SB_.PLTF.C002: Found 2 idle states
> CPU1 is up
> smpboot: Booting Node 0 Processor 2 APIC 0x4
> </snip>
> 
> I hypothesize this could be caused by .Lread_apicid finding x2apic 
> disabled but then trying to read from apic_mmio_base which isn't 
> initialized because x2apic was used (AFAICT apic_set_fixmap() never gets 
> called in this case).
> 
> Thanks,

AFAICT the issue is indeed that x2apic isn't re-enabled during s3
resume.

I've posted a series that I confirmed resolves the issue here:

https://lore.kernel.org/all/20231023160018.164054-1-mario.limonciello@amd.com/T/#t
