Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73EA1782F14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjHURGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbjHURGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:06:37 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B665EE;
        Mon, 21 Aug 2023 10:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwNavOBwKWzzj95IzpPouGJV/yKSrMrmRC1gySfTnPUOjgh699joyaK0IaVrzvGJ/vlFYjoHrbO6CHJ0K+ikEBagm5/RkEDq+mYHGXszw3lRy1gbtIJvE95yQzm6RX0BdLR+4ojT338bvZxuWBCNnMiLzNqR+QPfiJzNRTRyc75Asb2kqq/VqCb8wLXNmjszUJcCHZYRSbvAQ4mtZtdvFtfMzPmQH8rp6SwgldOxR1YLofJ3lmiAqTS4mMPESDHzXpflL6CA4jH3FrBbM3uZFcYIW1pJFcHyom9Acq+gVQfjka4ObNhJbuwauOYqoLm1rtmR6bU3m8Ujv1NuFhdEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHq9xorypYP/Q+VakUNnOga3buRX+V5CvbzUVzJra1Q=;
 b=JC9FmQC1CQ88lDVEN7tUx5gVt85kHaIoDuq4dSMSbtO/qnZH/EtH4U5YfUWcJJ8q+BBx/kAn4TfP7y8pfRCvvOcsLJkky4MZ+4Zpz7MY1N7YfnYWqCuG+xyZWef3kT7WAT+y3DhP8chbrs0QpqnqFToUh7oxKvvLmh/jOEtKSas+WY+ttUVrzKmER9FX5oHtYHfFYgMqZBkdLgjKrERN2DzWSQKW6T97/61szunUajSPGP0hcQVJv0mRHcJ4ybMZNf+fdRI+aX7HoTwVMzwYq0yCiTKNdPGDb7MJRUzlfkesvOmBBYxfuGjCfo/bUtgeUViGZPf7++JybmiyTmRBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHq9xorypYP/Q+VakUNnOga3buRX+V5CvbzUVzJra1Q=;
 b=M9mRk7zeRrFLXBIGy2FgUTkaSXhe3pfl0TCqDsQNzTgNGnaXpsEa0Qa7MeKpLXVcfQq6n7YHdsjjh5zXJu/Q9mQXGZcsfc85Hi8ZbBo+ZhO1KOyJ8DTKr/qyo5pGXRp53Ue2gymCpYISIYmYNWENlplAZ/u/6S1pBUH81cHc38o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 17:06:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 17:06:32 +0000
Message-ID: <1c579c96-5010-4e5b-aa27-afb4f4f6746a@amd.com>
Date:   Mon, 21 Aug 2023 12:06:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: PHAT: Add Platform Health Assessment Table support
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Avadhut Naik <avadnaik@amd.com>
Cc:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        Avadhut Naik <avadhut.naik@amd.com>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org
References: <20230810234856.2580143-1-avadhut.naik@amd.com>
 <a0ab4d07-fb73-418b-b88d-c3ad6aa4cf49@intel.com>
 <655c916e-356c-03e3-6c67-aa40886dd5e2@amd.com>
 <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0j0R1GK=0z+LJd_PSh4zDv9Ydw2YA7HWm1R5wjCUsbbYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f599b27-7ce9-46bd-0c9e-08dba268f77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYuDFRDRzBl35se6LXltt7rLOtlk5nBLDo+BF28QYjjN4uPXwZn5pAGaK7e5UOFgBg11Q9FnEbsBghWkku0x9hfgIdjqsKcPzXJQZuXt/GuqYYsUJOPhxvBP42cljTipe4AUmC8AXnP8xJelmXbTCjKJ/73dqNgPYcl0MPkKDmzuJPk/mjfN0vr30TVnaO0w30eOGOOSDnxPLC3PQHn6hY92NRwAadgsxWL5WwdBCigTA8ZrLc0PLkVEYpnI/mU48rmt15/0Aiq/n0IxxmpNp1AMgrhd5A+3Sm+B0esUHziSPfWfRSXlibEEvzcD50kMkl5y0e4sdprEjoJFd/wR+AE5/F/lafBnxKzZE1+hsRacrYPuoutU+WreMztyYQJ12OuHaD77dkh0XOfef/o2hOAceXbEPIWc/jSDd2XKzIRyXHZCD0/p6UHHL1JJe39RdMoZXnaVqAQkQ1VvG4xxTsiLwfZztPOtUpj7z5GKWKLAfYGoOuJQGRPDFoNvkrk58njsllJOcko83kFzEfwZ9ZT5mBQYkg/hR6AQTa/nYr0wcmTM06Jh53T7K9/jD1E3JrnLhms/qKfbXURANP2B0YWN+hhze7x+Iud6x5tg+X5lYCZKPqQcdN87i5YuYkmBDEioh7Z+L1V4gav/pNO2oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(186009)(1800799009)(451199024)(86362001)(31696002)(36756003)(31686004)(6636002)(316002)(66556008)(66476007)(54906003)(110136005)(41300700001)(38100700002)(478600001)(66946007)(6486002)(6666004)(6506007)(6512007)(53546011)(26005)(83380400001)(8676002)(4326008)(30864003)(2906002)(2616005)(8936002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJNaUUyMThvbXJFbllNMGwxNGFBWHc1NSszYmF6bWhqWGgyUzBkekl4WmJD?=
 =?utf-8?B?NndkQlo5SE93Z3N2S05qRWNNcjVVZ0MyL1J2T21hcFI1MDRCU1A0NlRXOHVV?=
 =?utf-8?B?ODEyekVRMS9XSVd0Ni9UcVZyQk4rVXVyVWY1MEUrbERKMmxQcG85T3NBQXI3?=
 =?utf-8?B?b3J0OUN4eUdMNGU4NlR6dHZUeENJOVBtdlY2RS9mVjNGb3VtMEpmYTRjSGMv?=
 =?utf-8?B?VnVoMHVHMVBpeXc3UlF0WW9tZ3BNV0JQSGlBQWpaS1VUeVBtZVJyVVhTWk9y?=
 =?utf-8?B?M01TNWFrU3hPeVpTSzFGZzRtdWpZTTNjd0dmbTE4R2JoaU5OZU5ZVDJnTUoz?=
 =?utf-8?B?dXRualFuTmpFbjgxbVpEd0h6aWp0c3prZy9pRUJlVlNIYUo0a2tXQmc3ZGhM?=
 =?utf-8?B?R1pENDNxNXk1V3kxSzJxWk1wQ0FWOHhVdjdFWGo5WHV3dXhBVnRldXo3STBN?=
 =?utf-8?B?MjA1MTlmS2lNMGRGU0FPQ2hEUmJKbXdGQmtSS0NuWjRvN0VsWDYxL3ZiNWZZ?=
 =?utf-8?B?V1NzWnJ3alp3dUttUGMyWCsyQ1d0NjdEU1ZrdVNNMVNBbHZwWnhELzlPcldT?=
 =?utf-8?B?ZHBicWJOS3F5alhlcWVEVFozSG1FOGFCWFNINnRGUjVodGV6N2gzMUd5b2VD?=
 =?utf-8?B?S1d1RTBxMjFraGJoMk9VRDNybHFMeXViYzdHNnpIdERmYXkvT2ZGLzI1ZW5y?=
 =?utf-8?B?TExZcTdiMFZ6dmsvMWkrV2NjT0o4RFJzWVU3L0k3MXlNa0pOaGxrenJ3UDJh?=
 =?utf-8?B?dVA2bVZHSkJPc0hBRGd5RW9selk2dlVsbmpkRXhmNnFWcU5Xakl4TXlGQW95?=
 =?utf-8?B?cllWWjhtenZCdWRpcDN1WFhEZHBubFR3NnlaSlg1ZVBQZnRKYTNsZmhDMnhv?=
 =?utf-8?B?K3UwOHJid3VVT3p6V2ZEYkUrVWRKNUtDRmRjMUlFQTJRWTIvQ3g2OGQzVjZG?=
 =?utf-8?B?MnBEZ2hiTFhMREJJdEhIb1NkSWJQTkhlR3FtZ1ByNUEwSTlwK3ZCZlA1dGJi?=
 =?utf-8?B?eVErNkxKOHBrZjNSNUlHek5aS0R1UDc4dHlld0szM0x0U3BZekJ6N2lmV24r?=
 =?utf-8?B?MEJaaTh1ZTgzcTlOc24yLzZxc2JBLzlCbUVyODBBa0tWZHhOeXFtb3JsOTln?=
 =?utf-8?B?aThoNVduR0FPZTJHYk5XVGNIdUR3Qk5vMmN0OCtyYkZEcVRvekZiN1FzMDhJ?=
 =?utf-8?B?WVdncllvUDZQMjJpMVV6SUNmbjNkWmh2WWhhYTcwYzVYdG9xdWxDWlM3UnNI?=
 =?utf-8?B?QUdnaWR3STROTnFhZDZsTHE0VWpZMWI4bTQvUVJxZThCcjU3UmN3L3pkOFYv?=
 =?utf-8?B?WXlyY2pxYUtjTmo0L2FiaGgwdnJNekJsK2hoNDhWS29sSDliMnhRSllMRFQ4?=
 =?utf-8?B?ZFByM0I2Yy85aHlaaU13aG45V0JNVHdBRlJNVUliQ1Bvcm1JVThnS2xqTVJH?=
 =?utf-8?B?WkN5TlBaYnNRc09lYlJKUVJJd0VQSnRQNTVUNGJtUXpxLy9TSEpHT3hyVkFj?=
 =?utf-8?B?Wkt3bTlRQVNXMG1Mbmh0OUxEdzBEb0R1ZytFeE4zczVBbnZyNUpvNzYwaHlP?=
 =?utf-8?B?bDhjZXV4b25IKzd6cjQ2OEtKTnR3R0xNeGprRXlEaGl4ZWRHK3dla1VTY2ht?=
 =?utf-8?B?M0RIaG9vNm0vN0ZRVElMNWlVQTYxa2RYc1ROV1VhTTVhV1l0UDJubHVyU2ZE?=
 =?utf-8?B?Mktnc0g4RE1laVRUSlpJN2p6U1JYTHRyWjBTVEZuMW5rSHdXVjBPdnFvTGxM?=
 =?utf-8?B?VVI4NGhwZXZ0SVJ5VVVaWXRNQTZSeGJwOTlXSU5ZbXNPMzRWRktnd3V6emd3?=
 =?utf-8?B?eDh5Wmw4bU50Z1RGUHRiR1pOK3BnYTZ6YmdKU1lid29qUXE5MXlpMFhQLzRy?=
 =?utf-8?B?bGVBbDFXM1Jvc2hWQVFGR0RSU1hhVEIrUUVXcEdxdkpyeG1wdDFnWWVYWkNo?=
 =?utf-8?B?VzdlM0pwVjZmcWRyK2pjNzBkTk5nb0hyc0RxL2VFZUcwVjl4R0Y4K2tIdXdQ?=
 =?utf-8?B?QTZic3ljcjNuODNvdXc5eTRWZURaSDFkeVAvaEhUcG9rdDFvaEdJOEorcHZJ?=
 =?utf-8?B?VGtEWVQwNVJMeUoxVHhubThURGFLWUFTUFE1ejNtMzQ0UUc2NlZLb3YybmNS?=
 =?utf-8?Q?+u461nThjhkycXd2mjtjrTyH8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f599b27-7ce9-46bd-0c9e-08dba268f77d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 17:06:32.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoapM1bQuc89WIF4I9BljyWZxJm1FUzEkFfQ+cxjHeZjncqVqAI8n91H646n10qFEj8h9tZSKd7dpqA5T8xzRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2023 2:49 AM, Rafael J. Wysocki wrote:
> On Thu, Aug 17, 2023 at 10:43 PM Avadhut Naik <avadnaik@amd.com> wrote:
>>
>> Hi,
>>
>> On 8/16/2023 06:35, Wilczynski, Michal wrote:
>>> Hi,
>>>
>>> On 8/11/2023 1:48 AM, Avadhut Naik wrote:
>>>> ACPI Platform Health Assessment Table (PHAT) enables a platform to expose
>>>> an extensible set of platform health related telemetry. The telemetry is
>>>> exposed through Firmware Version and Firmware Health Data Records which
>>>> provide version data and health-related information of their associated
>>>> components respectively.
>>>>
>>>> Additionally, the platform also provides Reset Reason Health Record in
>>>> the PHAT table highlighting the cause of last system reset or boot in case
>>>> of both expected and unexpected events. Vendor-specific data capturing the
>>>> underlying state of the system during reset can also be optionally provided
>>>> through the record.[1]
>>>>
>>>> Add support to parse the PHAT table during system bootup and have its
>>>> information logged into the dmesg buffer.
>>>>
>>>> [1] ACPI specification 6.5, section 5.2.31.5
>>>>
>>>> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
>>>> ---
>>>>   .../admin-guide/kernel-parameters.txt         |   4 +
>>>>   drivers/acpi/Kconfig                          |   9 +
>>>>   drivers/acpi/Makefile                         |   1 +
>>>>   drivers/acpi/phat.c                           | 270 ++++++++++++++++++
>>>>   include/acpi/actbl2.h                         |  18 ++
>>>>   5 files changed, 302 insertions(+)
>>>>   create mode 100644 drivers/acpi/phat.c
>>>>
>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>>> index 722b6eca2e93..33b932302ece 100644
>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>> @@ -4490,6 +4490,10 @@
>>>>                       allocator.  This parameter is primarily for debugging
>>>>                       and performance comparison.
>>>>
>>>> +    phat_disable=   [ACPI]
>>>> +                    Disable PHAT table parsing and logging of Firmware
>>>> +                    Version and Health Data records.
>>>> +
>>>>       pirq=           [SMP,APIC] Manual mp-table setup
>>>>                       See Documentation/arch/x86/i386/IO-APIC.rst.
>>>>
>>>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>>>> index 00dd309b6682..06a7dd6e5a40 100644
>>>> --- a/drivers/acpi/Kconfig
>>>> +++ b/drivers/acpi/Kconfig
>>>> @@ -96,6 +96,15 @@ config ACPI_FPDT
>>>>         This table provides information on the timing of the system
>>>>         boot, S3 suspend and S3 resume firmware code paths.
>>>>
>>>> +config ACPI_PHAT
>>>> +    bool "ACPI Platform Health Assessment Table (PHAT) support"
>>>> +    depends on X86_64 || ARM64
>>>> +    help
>>>> +      Enable support for Platform Health Assessment Table (PHAT).
>>>> +      This table exposes an extensible set of platform health
>>>> +      related telemetry through Firmware Version and Firmware Health
>>>> +      Data Records.
>>>> +
>>>>   config ACPI_LPIT
>>>>       bool
>>>>       depends on X86_64
>>>> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
>>>> index 3fc5a0d54f6e..93a4ec57ba6d 100644
>>>> --- a/drivers/acpi/Makefile
>>>> +++ b/drivers/acpi/Makefile
>>>> @@ -69,6 +69,7 @@ acpi-$(CONFIG_ACPI_WATCHDOG)       += acpi_watchdog.o
>>>>   acpi-$(CONFIG_ACPI_PRMT)    += prmt.o
>>>>   acpi-$(CONFIG_ACPI_PCC)             += acpi_pcc.o
>>>>   acpi-$(CONFIG_ACPI_FFH)             += acpi_ffh.o
>>>> +acpi-$(CONFIG_ACPI_PHAT)    += phat.o
>>>>
>>>>   # Address translation
>>>>   acpi-$(CONFIG_ACPI_ADXL)    += acpi_adxl.o
>>>> diff --git a/drivers/acpi/phat.c b/drivers/acpi/phat.c
>>>> new file mode 100644
>>>> index 000000000000..6006dd7615fa
>>>> --- /dev/null
>>>> +++ b/drivers/acpi/phat.c
>>>> @@ -0,0 +1,270 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Platform Health Assessment Table (PHAT) support
>>>> + *
>>>> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
>>>> + *
>>>> + * Author: Avadhut Naik <avadhut.naik@amd.com>
>>>> + *
>>>> + * This file implements parsing of the Platform Health Assessment Table
>>>> + * through which a platform can expose an extensible set of platform
>>>> + * health related telemetry. The telemetry is exposed through Firmware
>>>> + * Version Data Records and Firmware Health Data Records. Additionally,
>>>> + * a platform, through system firmware, also exposes Reset Reason Health
>>>> + * Record to inform the operating system of the cause of last system
>>>> + * reset or boot.
>>>> + *
>>>> + * For more information on PHAT, please refer to ACPI specification
>>>> + * version 6.5, section 5.2.31
>>>> + */
>>>> +
>>>> +#include <linux/acpi.h>
>>>> +
>>>> +static int phat_disable __initdata;
>>>> +static const char *prefix = "ACPI PHAT: ";
>>>
>>> Wouldn't it be better if you used pr_fmt macro instead ?
>>>
>>          Have explained below.
>>>> +
>>>> +/* Reset Reason Health Record GUID */
>>>> +static const guid_t reset_guid =
>>>> +    GUID_INIT(0x7a014ce2, 0xf263, 0x4b77,
>>>> +              0xb8, 0x8a, 0xe6, 0x33, 0x6b, 0x78, 0x2c, 0x14);
>>>> +
>>>> +static struct { u8 mask; const char *str; } const reset_sources[] = {
>>>> +    {BIT(0), "Unknown source"},
>>>> +    {BIT(1), "Hardware Source"},
>>>> +    {BIT(2), "Firmware Source"},
>>>> +    {BIT(3), "Software initiated reset"},
>>>> +    {BIT(4), "Supervisor initiated reset"},
>>>> +};
>>>> +
>>>> +static struct { u8 val; const char *str; } const reset_reasons[] = {
>>>> +    {0, "UNKNOWN"},
>>>> +    {1, "COLD BOOT"},
>>>> +    {2, "COLD RESET"},
>>>> +    {3, "WARM RESET"},
>>>> +    {4, "UPDATE"},
>>>> +    {32, "UNEXPECTED RESET"},
>>>> +    {33, "FAULT"},
>>>> +    {34, "TIMEOUT"},
>>>> +    {35, "THERMAL"},
>>>> +    {36, "POWER LOSS"},
>>>> +    {37, "POWER BUTTON"},
>>>> +};
>>>> +
>>>> +/*
>>>> + * Print the last PHAT Version Element associated with a Firmware
>>>> + * Version Data Record.
>>>> + * Firmware Version Data Record consists of an array of PHAT Version
>>>> + * Elements with each entry in the array representing a modification
>>>> + * undertaken on a given platform component.
>>>> + * In the event the array has multiple entries, minimize logs on the
>>>> + * console and print only the last version element since it denotes
>>>> + * the currently running instance of the component.
>>>> + */
>>>> +static int phat_version_data_parse(const char *pfx,
>>>> +                               struct acpi_phat_version_data *version)
>>>> +{
>>>> +    char newpfx[64];
>>>> +    u32 num_elems = version->element_count - 1;
>>>> +    struct acpi_phat_version_element *element;
>>>> +    int offset = sizeof(struct acpi_phat_version_data);
>>>> +
>>>> +    if (!version->element_count) {
>>>> +            pr_info("%sNo PHAT Version Elements found.\n", prefix);
>>>> +            return 0;
>>>> +    }
>>>> +
>>>> +    offset += num_elems * sizeof(struct acpi_phat_version_element);
>>>> +    element = (void *)version + offset;
>>>> +
>>>> +    pr_info("%sPHAT Version Element:\n", pfx);
>>>> +    snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
>>>> +    pr_info("%sComponent ID: %pUl\n", newpfx, element->guid);
>>>> +    pr_info("%sVersion: 0x%llx\n", newpfx, element->version_value);
>>>> +    snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
>>>> +    print_hex_dump(newpfx, "Producer ID: ", DUMP_PREFIX_NONE, 16, 4,
>>>> +                   &element->producer_id, sizeof(element->producer_id), true);
>>>
>>> I do have to admit that all this dancing with pfx and newpfx confuses me. Couldn't you
>>> just use pr_fmt for everything printed using pr_* family of functions ? print_hex_dump()
>>> is not impacted by pr_fmt, as it just uses printk to do it's printing.
>>>
>> I had considered using pr_fmt initially but since the ACPI spec says that PHAT health records,
>> especially reset reason health record is intended to complement existing fault reporting
>> mechanisms like BERT Tables, CPER, decided to have their outputs in identical formats, like has
>> been implemented in cper_estatus_print().
>>
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Print the Reset Reason Health Record
>>>> + */
>>>> +static int phat_reset_reason_parse(const char *pfx,
>>>> +                               struct acpi_phat_health_data *record)
>>>> +{
>>>> +    int idx;
>>>> +    void *data;
>>>> +    u32 data_len;
>>>> +    char newpfx[64];
>>>> +    struct acpi_phat_reset_reason *rr;
>>>> +    struct acpi_phat_vendor_reset_data *vdata;
>>>> +
>>>> +    rr = (void *)record + record->device_specific_offset;
>>>> +
>>>> +    for (idx = 0; idx < ARRAY_SIZE(reset_sources); idx++) {
>>>> +            if (!rr->reset_source) {
>>>> +                    pr_info("%sUnknown Reset Source.\n", pfx);
>>>> +                    break;
>>>> +            }
>>>> +            if (rr->reset_source & reset_sources[idx].mask) {
>>>> +                    pr_info("%sReset Source: 0x%x\t%s\n", pfx, reset_sources[idx].mask,
>>>> +                            reset_sources[idx].str);
>>>> +                    /* According to ACPI v6.5 Table 5.168, Sub-Source is
>>>> +                     * defined only for Software initiated reset.
>>>> +                     */
>>>> +                    if (idx == 0x3 && rr->reset_sub_source)
>>>> +                            pr_info("%sReset Sub-Source: %s\n", pfx,
>>>> +                                    rr->reset_sub_source == 0x1 ?
>>>> +                                    "Operating System" : "Hypervisor");
>>>> +                    break;
>>>> +            }
>>>> +    }
>>>> +
>>>> +    for (idx = 0; idx < ARRAY_SIZE(reset_reasons); idx++) {
>>>> +            if (rr->reset_reason == reset_reasons[idx].val) {
>>>> +                    pr_info("%sReset Reason: 0x%x\t%s\n", pfx, reset_reasons[idx].val,
>>>> +                            reset_reasons[idx].str);
>>>> +                    break;
>>>> +            }
>>>> +    }
>>>> +
>>>> +    if (!rr->vendor_count)
>>>> +            return 0;
>>>> +
>>>> +    pr_info("%sReset Reason Vendor Data:\n", pfx);
>>>> +    vdata = (void *)rr + sizeof(*rr);
>>>> +
>>>> +    for (idx = 0; idx < rr->vendor_count; idx++) {
>>>> +            snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
>>>> +            data_len = vdata->length - sizeof(*vdata);
>>>> +            data = (void *)vdata + sizeof(*vdata);
>>>> +            pr_info("%sVendor Data ID: %pUl\n", newpfx, vdata->vendor_id);
>>>> +            pr_info("%sRevision: 0x%x\n", newpfx, vdata->revision);
>>>> +            snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
>>>> +            print_hex_dump(newpfx, "Data: ", DUMP_PREFIX_NONE, 16, 4,
>>>> +                           data, data_len, false);
>>>> +            vdata = (void *)vdata + vdata->length;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/*
>>>> + * Print the Firmware Health Data Record.
>>>> + */
>>>> +static int phat_health_data_parse(const char *pfx,
>>>> +                              struct acpi_phat_health_data *record)
>>>> +{
>>>> +    void *data;
>>>> +    u32 data_len;
>>>> +    char newpfx[64];
>>>> +
>>>> +    pr_info("%sHealth Records.\n", pfx);
>>>> +    snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
>>>> +    pr_info("%sDevice Signature: %pUl\n", newpfx, record->device_guid);
>>>> +
>>>> +    switch (record->health) {
>>>> +    case ACPI_PHAT_ERRORS_FOUND:
>>>> +            pr_info("%sAmHealthy: Errors found\n", newpfx);
>>>> +            break;
>>>> +    case ACPI_PHAT_NO_ERRORS:
>>>> +            pr_info("%sAmHealthy: No errors found.\n", newpfx);
>>>> +            break;
>>>> +    case ACPI_PHAT_UNKNOWN_ERRORS:
>>>> +            pr_info("%sAmHealthy: Unknown.\n", newpfx);
>>>> +            break;
>>>> +    case ACPI_PHAT_ADVISORY:
>>>> +            pr_info("%sAmHealthy: Advisory – additional device-specific data exposed.\n",
>>>> +                    newpfx);
>>>> +            break;
>>>> +    default:
>>>> +            break;
>>>> +    }
>>>> +
>>>> +    if (!record->device_specific_offset)
>>>> +            return 0;
>>>> +
>>>> +    /* Reset Reason Health Record has a unique GUID and is created as
>>>> +     * a Health Record in the PHAT table. Check if this Health Record
>>>> +     * is a Reset Reason Health Record.
>>>> +     */
>>>> +    if (guid_equal((guid_t *)record->device_guid, &reset_guid)) {
>>>> +            phat_reset_reason_parse(newpfx, record);
>>>> +            return 0;
>>>> +    }
>>>> +
>>>> +    data = (void *)record + record->device_specific_offset;
>>>> +    data_len = record->header.length - record->device_specific_offset;
>>>> +    snprintf(newpfx, sizeof(newpfx), KERN_INFO "%s ", pfx);
>>>> +    print_hex_dump(newpfx, "Device Data: ", DUMP_PREFIX_NONE, 16, 4,
>>>> +                   data, data_len, false);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int parse_phat_table(const char *pfx, struct acpi_table_phat *phat_tab)
>>>> +{
>>>> +    char newpfx[64];
>>>> +    u32 offset = sizeof(*phat_tab);
>>>> +    struct acpi_phat_header *phat_header;
>>>> +
>>>> +    snprintf(newpfx, sizeof(newpfx), "%s ", pfx);
>>>> +
>>>> +    while (offset < phat_tab->header.length) {
>>>> +            phat_header = (void *)phat_tab + offset;
>>>> +            switch (phat_header->type) {
>>>> +            case ACPI_PHAT_TYPE_FW_VERSION_DATA:
>>>> +                    phat_version_data_parse(newpfx, (struct acpi_phat_version_data *)
>>>> +                        phat_header);
>>>> +                    break;
>>>> +            case ACPI_PHAT_TYPE_FW_HEALTH_DATA:
>>>> +                    phat_health_data_parse(newpfx, (struct acpi_phat_health_data *)
>>>> +                        phat_header);
>>>> +                    break;
>>>> +            default:
>>>> +                    break;
>>>> +            }
>>>> +            offset += phat_header->length;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int __init setup_phat_disable(char *str)
>>>> +{
>>>> +    phat_disable = 1;
>>>> +    return 1;
>>>> +}
>>>> +__setup("phat_disable", setup_phat_disable);
>>>> +
>>>> +static int __init acpi_phat_init(void)
>>>> +{
>>>> +    acpi_status status;
>>>> +    struct acpi_table_phat *phat_tab;
>>>> +
>>>> +    if (acpi_disabled)
>>>> +            return 0;
>>>> +
>>>> +    if (phat_disable) {
>>>> +            pr_err("%sPHAT support has been disabled.\n", prefix);
>>>> +            return 0;
>>>> +    }
>>>> +
>>>> +    status = acpi_get_table(ACPI_SIG_PHAT, 0,
>>>> +                            (struct acpi_table_header **)&phat_tab);
>>>> +
>>>> +    if (status == AE_NOT_FOUND) {
>>>> +            pr_info("%sPHAT Table not found.\n", prefix);
>>>> +            return 0;
>>>> +    } else if (ACPI_FAILURE(status)) {
>>>> +            pr_err("%sFailed to get PHAT Table: %s.\n", prefix,
>>>> +                   acpi_format_exception(status));
>>>> +            return -EINVAL;
>>>> +    }
>>>> +
>>>> +    pr_info("%sPlatform Telemetry Records.\n", prefix);
>>>> +    parse_phat_table(prefix, phat_tab);
>>>
>>> So for now you're only dumping tables to the dmesg output ?
>>> Are you planning to create some sysfs interfaces similar to let's
>>> say EINJ ?
>>>
>> Yes, for now, the output is being posted to dmesg only.
> 
> So it is not particularly useful for anything practical.
> 
>> If there is a consensus, we can have the information exported through
>> sysfs too.
> 
> That depends on how you want to use it which should be explained in
> the patch changelog.
> 
> Now it's basically "it's there, so dump it" which leads to the obvious
> question: "Who's going to need it?"
> 

I was just talking to some colleagues about PHAT recently as well.

The use case that jumps out is "system randomly rebooted while I was 
doing XYZ".  You don't know what happened, but you keep using your 
system.  Then it happens again.

If the reason for the random reboot is captured to dmesg you can cross 
reference your journal from the next boot after any random reboot and 
get the reason for it.  If a user reports this to a Gitlab issue tracker 
or Bugzilla it can be helpful in establishing a pattern.

>> The below location may be appropriate in that case:
>> /sys/firmware/acpi/
> 
> Yes, it may. >
>> We already have FPDT and BGRT being exported from there.
> 
> In fact, all of the ACPI tables can be retrieved verbatim from
> /sys/firmware/acpi/tables/ already, so why exactly do you want the
> kernel to parse PHAT in particular?
> 

It's not to say that /sys/firmware/acpi/PHAT isn't useful, but having 
something internal to the kernel "automatically" parsing it and saving
information to a place like the kernel log that is already captured by 
existing userspace tools I think is "more" useful.
