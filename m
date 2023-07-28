Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79A4767652
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjG1T3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjG1T3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:29:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728CC2701;
        Fri, 28 Jul 2023 12:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXehqbn4JN44j8FfShpCoNV+gEmvD3IMkcGYfSQ3zGOqS5QZiLSy0CGOUWCwLYWbhGYNGuNIhig5NaGS8vFKk729QtiPTyjCnxlxgfTE+vs4xlz510NtciSDSATQ/qlD1xy6t/2HtURtJ73WvfN9tm60Y9GMyCRgY7PLLq0PHHoAn9wqoiL6FGaMxZnor1cYVNf2P6y4C6yi8+NP9nh3H2Tvg4bOisbb3Dn/y3ja6viqNT2hVN814pQIKeJBLizS+2WFkMQg70bEVCwgwlWBaYv7Ps6U2zea1rybzrHRfo2kMkQ5Z3/U+RDCqfdgC8/z1TotY4QXiZpBjPty04c+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siWjYDCHGICDUwZFpVQM4AS6O3ehK4RrTbvl6LBMFoY=;
 b=N2nOMaGAxeCAlZKvE7pDw8H6hEmxvsZbgtKyYtyVNTiF9Qedx5z+MLLM3Dqt6124/RENguKle38aFauMIgA0giXPoNkgM0sEsRQQGrEzP7n3Mb4qE54gEyiWFjoi4bBCV5ODgOiUw8HZgr72YHGgvf6eXGaSS0DMOXVQdgtQKEWY7YspBKGSa00gWWQAKGJQF0InMT/UwcN70PjjxCj0k6b+IFffTSEjqZRKeisK+6UUaUtljsihgQV+S19mBg+0UwBTGu2WYft1ujY//3bj9HPTH70Vy5bBcOKJqmDtxWespok5pnhWjN1D5Wl8D4845g3Tf2VMTGSgbmnt98cOkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siWjYDCHGICDUwZFpVQM4AS6O3ehK4RrTbvl6LBMFoY=;
 b=r8Z+HF70UfJAFnEEk6qY8RSBKrt2SHETMeePsxPueEU6CRrIdKmCWC8L/c14MwvFDOYoaMC9xaqbGqGQ92PtEIKq26RuOP20XdQa+Y5EjbZqYiOSeeEsYXO7y1rHuBbOoyx6mYsw/DsyzWmziLB7nkQg+A/C7CLL/gC/HSNagPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7272.namprd12.prod.outlook.com (2603:10b6:806:2b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 19:29:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 19:29:09 +0000
Message-ID: <79ee5522-3f3e-3480-dfb2-0c7640a97587@amd.com>
Date:   Fri, 28 Jul 2023 14:29:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: resource: Add a quirk for Lenovo Yoga 7 14ARB7
To:     August Wikerfors <git@augustwikerfors.se>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, regressions@lists.linux.dev
References: <20230728183921.17230-1-mario.limonciello@amd.com>
 <1af52057-84e4-be2a-5fac-24847361812d@augustwikerfors.se>
Content-Language: en-US
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <1af52057-84e4-be2a-5fac-24847361812d@augustwikerfors.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b5991d-14b9-4ee9-f43e-08db8fa0ea45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNdyXgX9Qt7+lD9lMCEd52CcmE61flAxt0fpe8GAwtR5TIwkIUEdLZJcnRPOtMAqSPVUmVFAd2tdlOl5+t3UWW2JrrTqx1c/Sg9ykSXHSJGYgNsW5/0hkwkqURoVlAqG1LziqftGj7icpxTRM+7D+X6ElLBQszZJXZiFbNlFYzg9kgABvugbDGSQ0HGwQwzrJfbEXvzrhStggYaDpOuGmPGjeWoWcsLVuWCARNpWtt2mDjw/4piAvVBmQV0NrqVsFKvk7/zkv6in+jdvwSPJvcaVVOz8KX7lEeO43M4RuJIMWjI9jU+lUzBa8Vxr27gUIjiocNqcVq9tbFPTTFEuf5NCZcCBJGByYYp02EFEfE50L/WEJkB0WsJ6/hjWOC2gVEqZvzoyaS4N7kNYLOBYpLzk4hCVPHSe1Vyt3RD0biIoA9TFL6z6mWpMyz7NHxiZnncDz2D53K95gSFBiS9EsEaGYE6R4YgzR9V+/CPUf2pApK8rZCOZp3Mw8Cnr8qq+uOiXgztoTo2wzD/5T9Vs3NGfsNloo3nYYPYF9G6vxmiR9h0qx4EeuoExivxYDsU1yC6b/SgcT1aoiFVzergQyUtZbhJ314aXS12ircGZvAErUX6AMIbuWbCQo21S0W1Q5UZNbpal3yChmLugY1sDp5O9+OuCqe5/3MwlOfyhSJLZ26inzySyWvFVEH7ODVAH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199021)(38100700002)(478600001)(31696002)(66556008)(86362001)(6916009)(4326008)(66946007)(316002)(66476007)(6486002)(186003)(6512007)(53546011)(8676002)(26005)(966005)(6666004)(6506007)(2906002)(8936002)(41300700001)(5660300002)(2616005)(36756003)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWNDYlI3WDNuS0dJUzhnMW9oSkR1NHJyZkUzVzlReGF2Vk1Lb04rSzlHUkQx?=
 =?utf-8?B?Y3ZNcG9BRG9lNGNZSGRCRkcvNnc0aE5sWkNkaldTU1VIUmVTUWhOUjZPQmQ5?=
 =?utf-8?B?anFDaHpuaE9pL2NzNzBoMlc5YnBLTjQ4N2xCMmUvMkpEcnNUaWhFbWNISkRF?=
 =?utf-8?B?a21qMDJHbm1GSi9KUEdEQ25aS0FWTUpFSU5kdk1sdkd2TGc1R0dqME84ZXFU?=
 =?utf-8?B?a3Fiam5RN0V0VnZrUjY2RzdYNURjcWpIMUZ6K0N2bGhnUlJ0VGhxTGhqNEpn?=
 =?utf-8?B?Q1BKTUV6a2I5eGlzcXd5MVBYc3g2R1Y1dE1TQXZYQnMzRW1NUGdpdTZIdEx6?=
 =?utf-8?B?VmJGNTQ0NXdXVW9pVVNPWE1SYXlLQ0tCNTFaMVA0UE9vNUhZTTFHRlVwM3NT?=
 =?utf-8?B?U0JFWjR6c1V4dkwzRWhXZG1UTmExZHROUUVnTGlQZHk2TzUvKzRsc2NVZ3BS?=
 =?utf-8?B?d3h6YzkyeTdlZTlSKzBodDBJSEsyNUlPektyd3lQSHhmNWVLanRvZ1BuK2Z0?=
 =?utf-8?B?ajFDbmE4QlJZQ2J1d1BtR0owR3daTVkwblFIV1pXVi9jMjhQcGIyODBUejcw?=
 =?utf-8?B?cFFpbVF4ckdxWlJabXlmU3VvV2xiQ3pSVEFSaXBjSGlmUDNSaE1nNVlsKzYv?=
 =?utf-8?B?N0VUVkZZaTJnNWViQU8weGg3ZXBPMzRzSDRwQ203TTAvVkV1dWhTc1lZT3Vj?=
 =?utf-8?B?WFlLejVlUmE2N3FFbG43QnJhODFsYlMyKy9pUlBCc1ExZXRrc1QveXdYQWEr?=
 =?utf-8?B?N1JLejR5NzJrdUxvcEhobDNCQnZTTGxyNHhxRFQ0YWp4MFVLeXA3SlhQTURs?=
 =?utf-8?B?QU5Hb3FKUWRJbmNuWUdEQzlJYTEvMFM4U3BqQ1dEbVBXa05JNWx6Uk4vRTJK?=
 =?utf-8?B?MmhTdnBCcjluMU0yZG5jcHRSZTE0RWVOYXdTY1RqYXJGR1ptK01TWEd2NG9H?=
 =?utf-8?B?ckxySjdlSXRTOSs2Z3dFSElWaUtlOGMrc2tUNUdBVzBXakFjQXRDbTZYRzFG?=
 =?utf-8?B?dmtBa2dVSkJNMThTSmJBNWM2bHNpbXJCdnRhd3pxcWFpMktzaDJLRG5NdHpn?=
 =?utf-8?B?aEdZZFlZcGFEUnV5czhPTitPQnhEb2wwNUFmUlVJVVlnZ1ZqOG9waURyV2Zu?=
 =?utf-8?B?V1JUeUJpLzM0ZUhNM2NIdnN1eU4zNStGMkpZZHVKN3YyQmF2NnIzeURxQ2tV?=
 =?utf-8?B?TnRsRWNnNmJxSWdLLzgrNElqTlRadW02NWpaSExmZkF4Qi9BUHZOYmt4S09h?=
 =?utf-8?B?S0xhWitnVEp0cGZnRS9GWDFjVnc5QnF2SjhTZW5Ndnl6eFdFZFdrK2tDdmZN?=
 =?utf-8?B?TWdHdlMweHdkcFlzZllsSHhNUkJXU1NxWGxYYVZRay8vbWN1SThZYmg2ZlRj?=
 =?utf-8?B?cFR4TFgvU1VpQjRXdUR2VFZ5WkhWNVJHRWZkNk44UUNBTks1THBNYjJTVHYz?=
 =?utf-8?B?SE11RXU0cXY1NGZrK1N4RnVOakFsZmQ1b2lZeDlnYjhkaDZoeTJLVkdFOHFp?=
 =?utf-8?B?ZG5XYmIrenlMdVNwUDBxVEQyNGZ0bEZadk50QWk3ZElQVWNQN21HM2taNFFu?=
 =?utf-8?B?eE9lWlAvK3YyRHhLbDAraE90ckFBc1VuYVpoeW9vdzVBRlIray9wTlBNZVEy?=
 =?utf-8?B?bWIrRmJSMU5LSnRkaTlkNVFnTEVDR3J3RUJReGJtYk1Bb2I3REttcG1mTHll?=
 =?utf-8?B?Q0xqMUtid3RuazkzQmQzWlEyRmJkR2NDSTdYcWdQM001Nll3aG94bzZUR2wv?=
 =?utf-8?B?L3dTZlRCZHNGN3lhM2tiYmY3S0wvaThoZzNZaVpwTzFHWTlNNmdYSmd6SXFo?=
 =?utf-8?B?STRmaUV3TmxBZ0FoajNjQjRJRzRjZkRsTyt2QXYwZzFxa0xqelo1NnkxcGN3?=
 =?utf-8?B?V3ZxV2o1ZlpIaWNwdGcreVdzQlE2bVluUi9mcFVMeG5vZjFNSWRYM1B2TWta?=
 =?utf-8?B?VFdXY1NKVVF4SVlnejROTmwvZTZlcitGdVhIaCtmVXBDN2drL3FuN1p0S2p4?=
 =?utf-8?B?MlNoWWcxUGF3dm1XMG4zTzQzQ042cGVKY2hyZk4vQ2hPUzRtWFRkTkhldC8z?=
 =?utf-8?B?dVpKRXB4L2d3L0tERkt0RHc4Z0UvbkkzYlp4ZTdMYlRvOWpycFB1UTg3YnNG?=
 =?utf-8?Q?dlwymrgvW/+aiU0y+FWr2VVdl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b5991d-14b9-4ee9-f43e-08db8fa0ea45
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 19:29:09.2265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TEJcEBxDfP70PJx/SlAuAiYBZaQrrT3mbPE082FEg92esSzSFTBib61Q3ASjc7isnC4K0k/dTPsTlOCXlbiMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7272
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 2:25 PM, August Wikerfors wrote:
> On 2023-07-28 20:39, Mario Limonciello wrote:
>> Lenovo Yoga 7 needs to have keyboard interrupt signaling polarity
>> is incorrect in the MADT and the value from the DSDT should be used.
>>
>> Reported-by: August Wikerfors <git@augustwikerfors.se>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217718
>> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and 
>> quirks")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/resource.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 1dd8d5aebf678..1a826419d5837 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -481,6 +481,17 @@ static const struct dmi_system_id lg_laptop[] = {
>>       { }
>>   };
>> +static const struct dmi_system_id lenovo_laptop[] = {
>> +    {
>> +        .ident = "Lenovo Yoga 7 14ARB7",
>> +        .matches = {
>> +            DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +            DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
>> +        },
>> +    },
>> +    { }
>> +};
>> +
>>   struct irq_override_cmp {
>>       const struct dmi_system_id *system;
>>       unsigned char irq;
>> @@ -494,6 +505,7 @@ static const struct irq_override_cmp 
>> override_table[] = {
>>       { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, 
>> false },
>>       { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, 
>> false },
>>       { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>> +    { lenovo_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 1, false}
> This should have ACPI_EDGE_SENSITIVE, not ACPI_LEVEL_SENSITIVE, see 
> https://bugzilla.kernel.org/show_bug.cgi?id=217718#c11

Thanks, sorry about that mistake.  I'll resend it.
