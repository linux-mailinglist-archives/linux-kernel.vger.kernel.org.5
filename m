Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B17752776
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjGMPkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjGMPkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:40:31 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C5D26AE;
        Thu, 13 Jul 2023 08:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsT4Y5u+H9qGuCuwMhVKKBPJbbAPnAn2ly/pt9km4yKdOO6KVz9j6k4oR3R0fLRDbndUZTvntT5U0CT0IeiRWV7Ox5o1+OeOKa+x2BzawBVkEJMHjeCxzyDoMsae8x7g+qFAeWlcAQtJUjTs0LCSRSP6JuXymmocplrkXJv6ckDP5VooaT9qGfI/QsghOhSAlwZPL7x7+k5fPBDXhU9U8tb66j7jglmARYTMNP6vbdmdZBpRtrTxybKi1BLPLAQCpXlD7FinCkQV+giKm5qkPQKISUi61Kr1TEXPn/UFpRi6pGfQf5+wm26Z/Z0LT2caiYS3y/DzMUYfPJAbFBJU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Vhs2zlGK0baWFWAZMffZaa5Xs3kGUgCVxXMU5cXaEU=;
 b=Ir6lavY4Piqmfz1gKjPBQmKt1VVbeqwDYKNQBN+FYjKGCnGpZ27f0oT87+ZTtuhYfoCq6nMlEDDJy3ZXK+EX1Y/aRcamDRFVQzlgm51yq7yFHMb/zKNdkcdQQEKN8z2lNH7R4kFQVOHraj1HupZYMfRiy1Kz/Arcrt3tMMjK6+ocv1Qp4vO/QZTOqkwaUac3d5wgFM2hqcLJElJ7y+Dv3pkpN0Q16rJ0wD2DlPIKgVZ5RXR+54J6I5kdRXGQuMOJLrVAiXxpepsnocgLFcxBVMsFRqmAd06mx9cc7ybH4ESSoArE0L4SYypBp4t/vwBWOFUA1iz7JMJixI4hS4sddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Vhs2zlGK0baWFWAZMffZaa5Xs3kGUgCVxXMU5cXaEU=;
 b=J9Y8EJDrVyrnL3ErWb1UTK+V19molpgSYe7FX5+uktdQhf0zSMZ8uWi1nViMn9xlXMGAsggY7AmJpJTjvNnzhm46E5kDdWkHwHBxPnxlMqvU2ydzyY8w6///cQaPSMjsC7rKjFJbFwpFXXhH8bRt139OXoEyAmrmADv5DlY+KWE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Thu, 13 Jul 2023 15:40:27 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::bce4:716a:8303:efcf%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 15:40:27 +0000
Message-ID: <0a8351e9-a9f1-bec4-1542-2a456ca76d93@amd.com>
Date:   Thu, 13 Jul 2023 10:40:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: thermal: Drop nocrt parameter
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20230712172459.20275-1-mario.limonciello@amd.com>
 <CAJZ5v0jDpMNsWztgPDfLG3eGw3YOxK_ygWRLgHmbZUoMh97tbw@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jDpMNsWztgPDfLG3eGw3YOxK_ygWRLgHmbZUoMh97tbw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0017.namprd06.prod.outlook.com
 (2603:10b6:5:120::30) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9fe811-53cd-4ecd-e71c-08db83b77b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TFmMCmQX5C49zmjwN9QL+qL6xVWhd/gOf12gpxp3iQ5OOCAmSYaahxn6b8WdlOhaSVTxrpVKZSJAo95rpKh7kfJL/oE9/TGvWTiG5acN1zbzSDVnZuo7c34Cm20TJ9KVPePez2liSPvXFpdny+Z8TuQZgQ66p9FMTEJ0Bjr/sh3lEPZKwhmI29pZkAmCaB5IqUppefpuUG3vK6/SDyQyVSIKZo1Tnto4BJWjJHgczOUe5SdG2aWJKp7dICX9YE8gvxfySUcqsLFZCXAMF5vsVUvl2hKn6Kcp8niVxofRTf8g0CtBk+/PzXOnvhGPbUUcDnk9Y1D51me5siQtLLKWc/fAuXBE109eV06t+Bka9ykPAI86ShyWQYN/ecIuN1IA4c87WWLXl3jd9SFcl39AvZapOW5/6yhQinxwupTOCdny3LAwj7FiDJ4DM5IdDRyE1uOi3od/fZC5r+pS/I4caL0kRgC41OVdGKwgsCzHKQsIrtEHt8zB+fpay3t811KJiJZu8DyzQYydmyIRRXae8EQbs7p/Y8LS7FNeSMfEJr1ahKQ9yudypChiZLBf0L3xDswBwgqcgtziLxLXk+NWL9oG9lN5we4K1Qxv9jdzwOpxn4WWz703HC/qjC0f6nTrlQ3Gz4jlmpanPReHbFtdNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(38100700002)(86362001)(31696002)(36756003)(31686004)(26005)(5660300002)(6506007)(53546011)(8676002)(41300700001)(8936002)(186003)(2906002)(2616005)(83380400001)(316002)(6512007)(6916009)(66946007)(478600001)(4326008)(66556008)(6486002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3NwbFNnWm9IcmRUbWJCeGVXUVd1Uy9PdUpRckhsQitsZnZTcW1nM1BHSjN6?=
 =?utf-8?B?UUdGa3ZIOEQzYlI2dWhwSzVKcjM3M0tuRDh5VTRFTUV2N2hKRnFoT01ZZUZt?=
 =?utf-8?B?ZkhpS3k2ZUllQnFuek5mT08xaGZScEtQdnhhVWt5T2QxcHRJWXpNMlV2ZGdH?=
 =?utf-8?B?WWhVUXZMTHlYelk1ZkVxcDlIcjhNUncvbmxuWFhhSDA3UDQ0WWdLa0VxZzZk?=
 =?utf-8?B?UVRRUEtTcXI0TVBkdDUzVHVHNy9rZldGUVFyR0FXOGtEQlVJWXBwNlMyYXpO?=
 =?utf-8?B?SmtnMFV5c25iSkhJZUdwU0VoekFNenYvanFBc0lXVUJQeHRLRXlRVU9ueTN3?=
 =?utf-8?B?dHdjbWpBYUtGdnVhOEZ0bGpRZ3FTaERzb0g2REJsRHdoQ1pMa08vUldXalBk?=
 =?utf-8?B?V3I1QWdFSCs2Tm1DcTd2U1JmUjR4L1RjNFVTMkFWbkZWZG9XVEh3Z0pPaE1J?=
 =?utf-8?B?VEJVYzZ6bVNRQkhJWUVrM2dNM1BqWk9LNFZmM28zK2VQaDVSK0lEWG5KT3Yz?=
 =?utf-8?B?a1FySWVRSGl0c0swS3pOS21CRkRVa2lCNHhPU2xiVWd6UGNXY3NOQmt5OGw2?=
 =?utf-8?B?d2xhTS9oc3lSOW4wV3YrY0oybmtranhVa2dOdjFyL3hmUUZORHdHZ1lrUThJ?=
 =?utf-8?B?REpselMyTUI3Ui9IVlVoSnBLSjBUL0t0cWVUZVl2UGFhM2dzTnpSbEp5a2pL?=
 =?utf-8?B?VGRGY1lEdFJSdFNPd3VLWTVXNXp4bnRjbk10emtkN0VoYm5TUTNUYkR3dG1L?=
 =?utf-8?B?Sm9IT0FzdzNhT0QzcWE1T3RxUGdib3dYTHVvc0Q1RzRBSVh5a2JvVlBsM0N0?=
 =?utf-8?B?VnpheHk1VnFUSi95cThZd1hKbU80T0tXaWpqSXFkTnNZSDBkYkJVbGpNaERX?=
 =?utf-8?B?M2c0TVBvaWhFcnVFaGR3Rmd5aVJqUXlFTTg0N05FOGo0N0NOalBlK2M2UFVV?=
 =?utf-8?B?QnJQTG9tY2hoMWg4QnJHZGNwQ3ZVN2tKNHk2b1VyWDdEVVNlYUk4ZlFCdmY2?=
 =?utf-8?B?N1d5bzZDdkhwcE4rbkUwWVkzNncxZCsyV3hMRHpoQjJaQTk1c1QzcHA3c2FK?=
 =?utf-8?B?MDNSQzV6dDJzczk3T1NOYnc0STBvZldWaWZ2dXZZdGZ6d0dZbFNxRVBwRUpF?=
 =?utf-8?B?NG5yRmtwSVNyWkxoM3VVOWNvbG40WWttOTh3TjhZVkh3VHZxL09kUWlIbzNu?=
 =?utf-8?B?cmg2Z0lkWW9kY09Va20rV0R2azJzYWt5ODUrcFlVQ3lNa0M3YSsrNlduemlZ?=
 =?utf-8?B?eTdCcnhFY2I2T3ZHbVNNcnl3Q1lFTWo2VXEwSzVTOTd2YnduYjhadENIU0FU?=
 =?utf-8?B?UExMelFyaXY5Zit4U280VGhOcUluQmJSYlE3SkVuMTBMdnFQYTltMFMwQ25W?=
 =?utf-8?B?UXh0NDc2OWI5RG5vcXBUMzRkUTRyTGN5MEV4dHp5S1NwVEhuamJPYnlQYW4x?=
 =?utf-8?B?Rk5mUko0c2hRa0N3SFRQUm5XWG41aVZhd3J5WkxxVXBRVVJINXUrSWlVSE8w?=
 =?utf-8?B?cHNlekdacXFEVytMeFF2bXJFTW8yTENCUjR3ODcwYU4xSzFVaTg4d3lva3ZK?=
 =?utf-8?B?VldBczVJYndzRzFYZlhXRVM2Vkx6ejZid1hXSjNVWFNsNmZaTkpIV2tNWDJp?=
 =?utf-8?B?NlkxVitEaW5Vcmk3dFhVVnhzbDNKNWxpbGhWRUlPS3A0MksyMENuRTRsbDZP?=
 =?utf-8?B?Qzd1cGR5clpaTVZmVW44c2N6RTZRQlVvOHJUbEppalgyVld3VVRVejhPa2Jr?=
 =?utf-8?B?cFd0cEdlbzV0cWZJNVI2Q2FYVWJWMGM4WllMM3lPUVJva2grZ2FYQjlrckdy?=
 =?utf-8?B?dFNiTTlYTENwdjZzbnprZVFNT0g2NTQ2ODJHZjN2YXFJRU5UVm56R2lBVnpt?=
 =?utf-8?B?ZUVXN01lNTJEYTQvc1pNODF2K1lBTWVEdFlFSnRscnVza2VheitUVnZiQWY3?=
 =?utf-8?B?cHBrSzFMZWZiVzFXdSsxeERMSjVmSWpZZnh6cDdZQ3BLdkpZRitIZ3hoeFNw?=
 =?utf-8?B?ZG16dytYb2tnazJoN0gvQTBHcGFIUEYza2JTcGxOTEVCUUlJUmZ0YU9PTjV1?=
 =?utf-8?B?dzV2WGI1RU0vTGJSa3V2ZkJlMGRKa2JIRER4b1hsbHI4RE5DMERaS0FCK3pU?=
 =?utf-8?Q?FbKBIeNOlxfKAuOTAFXHx2DUn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9fe811-53cd-4ecd-e71c-08db83b77b73
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 15:40:27.8183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvFEUY4ytwvWdQESrfgogPU52xgDHYw4iVEzK80cn94MDPMtqeDPQ9+06hpC8gcM74o+gz4zDt9bh+lwP40wlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/13/2023 10:31 AM, Rafael J. Wysocki wrote:
> On Wed, Jul 12, 2023 at 7:25 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>> The `nocrt` module parameter has no code associated with it and does
>> nothing.  As `crt=-1` has same functionality as what nocrt should be
>> doing drop `nocrt` and associated documentation.
>>
>> This should fix a quirk for Gigabyte GA-7ZX that used `nocrt` and
>> thus didn't function properly.
>>
>> Fixes: 8c99fdce3078 ("ACPI: thermal: set "thermal.nocrt" via DMI on Gigabyte GA-7ZX")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Stable material I suppose?
Yeah I think so.
>> ---
>>   Documentation/admin-guide/kernel-parameters.txt | 4 ----
>>   drivers/acpi/thermal.c                          | 6 +-----
>>   2 files changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a1457995fd41c..2de235d52faca 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -6243,10 +6243,6 @@
>>                          -1: disable all critical trip points in all thermal zones
>>                          <degrees C>: override all critical trip points
>>
>> -       thermal.nocrt=  [HW,ACPI]
>> -                       Set to disable actions on ACPI thermal zone
>> -                       critical and hot trip points.
>> -
>>          thermal.off=    [HW,ACPI]
>>                          1: disable ACPI thermal control
>>
>> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
>> index f9f6ebb08fdb7..3163a40f02e30 100644
>> --- a/drivers/acpi/thermal.c
>> +++ b/drivers/acpi/thermal.c
>> @@ -82,10 +82,6 @@ static int tzp;
>>   module_param(tzp, int, 0444);
>>   MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
>>
>> -static int nocrt;
>> -module_param(nocrt, int, 0);
>> -MODULE_PARM_DESC(nocrt, "Set to take no action upon ACPI thermal zone critical trips points.");
>> -
>>   static int off;
>>   module_param(off, int, 0);
>>   MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.");
>> @@ -1094,7 +1090,7 @@ static int thermal_act(const struct dmi_system_id *d) {
>>   static int thermal_nocrt(const struct dmi_system_id *d) {
>>          pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
>>                    d->ident);
>> -       nocrt = 1;
>> +       crt = -1;
>>          return 0;
>>   }
>>   static int thermal_tzp(const struct dmi_system_id *d) {
>> --
