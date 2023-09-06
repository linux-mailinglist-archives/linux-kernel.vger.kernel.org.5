Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845C3793FC2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbjIFO51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242225AbjIFO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:57:25 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE84198A;
        Wed,  6 Sep 2023 07:57:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArzbfMhMpAxvG3grxrHzFtjpPDt14W5VmXiBbndheCg+lHBCmUrrVeFgxcHsROFng7xM9pLV/kqC2kZacqH77vMzckfGtSP/0bys3m76mWzlGhUfp2LB+FMCOCX9hQIPAQ7akja4UHY/jivkkYA6uYMn29Kl6QoVu1VPbVTkmZ+IxmGQRTl0ShUYOfL4Sxk7Y31s6GiF8l202IvOrKfCvt6QHD9HrLsodts8fQjvPkaYIhGccqTbpuvvVs4aq0GFTCtXIJzzTb39suPwrrf3x7P51TiDRdPxQgMazWHMNYb6DPWpmJNTa6qJG4PIQW/cVIY7fyWZe27HcVvMqwXfeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtjkJFxMkadYVcjQWJFxC93jsQ1eVkQG3mWtREbMc9g=;
 b=Uq39qlpWjZn6sc/hfDrJD8OB1RSRzIV9FVW7bpQe6mz634HOO0jLzrZq5iPqQ5mGz/CSK5d+QK5kwPirAkRFLk3VK3VP0YDe2MuquqNH2e6imd28xOqcR75OaQhC/eNqjVHspmS/Jkl46rR19+sNHDfHXb8cL+ViIdSivjBfYH1X8L7fogbjeUue23kGgQ7KjRkUfiv0NzvegoIFtqpZAjIAj0L7naqK/yXk/3v4JP94QD6QvESQsIFwupB050JH18ikcdhODJ3wVQehKh1ULOKasS/2cJ52rWTo9aAZAuEcJW5ZSDueL6IU3Afb24XTIrNySdXSiosIeq2QXvwRpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtjkJFxMkadYVcjQWJFxC93jsQ1eVkQG3mWtREbMc9g=;
 b=glVqtzHr+yZQlJqSMn3CRjCqMdhShKwoPpCNDuTgF0a8w9Dkh70Wb7W4KeqUee65ln3oOQXAVWgDHSJMIh4eun9MujhyzecB3M0wOIIuHntiJzSeg0A3uVwU8bv6BLEz8vAR30JhdwOSoj7AMkDFCVS276VdsgJWzGeqDap1KDM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 14:57:01 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 14:57:01 +0000
Message-ID: <fda1fea1-5e39-8a54-ab97-78d182c54801@amd.com>
Date:   Wed, 6 Sep 2023 09:56:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 1/8] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Cc:     dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-2-babu.moger@amd.com>
 <a59be218-350b-b88b-2b02-be9c1d2bf797@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <a59be218-350b-b88b-2b02-be9c1d2bf797@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0137.namprd11.prod.outlook.com
 (2603:10b6:806:131::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: e8bc7f82-2393-4dd8-1a7e-08dbaee9869b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cUPPRjd48LFrWeVCbRst3Ycgic8l8LTFBZ8jULYoaXFV9f0EqUhrmIbx95QV2rTYMu1k0VCtTJ2XkhLfNH2Ts0ZaIWkZ212LWCTXy3bAYo12A1NYFdPt1mP05MDgzF5ZXLqRoAbtuP+jZnny57EV14TmdQD5mCCaVHTXnThAbfRSjBs8m6OJE75ly5LEIPt9XyVfEE/M8m+D9go7PpPvGoiZYG1Mjgi+AnNd1XpZjY+JkUJ6wnkDkA+fPXWxuhswAeRna/phE1oTDzoIxgc5LPnjt5bVJdaNQ90v8uc38KjMD8IfL4ro2yo2RyQcMcLuljQ6hQ3BWDgNdaYGC9LDg+2iCsLuU5p0TQwqk+l15ml+8zc83gUJtEV5o68BMve2ZC+yv91zZAHAfDmtCyEJSH+vWiYZOUJYu3xkG8/HK1yagu+9ELBolwaGKrR9WJScTwXYE9poISfB7WWbkZwKU2SwrLODqOn5w4X3kDqJzve6uWFKTw/TOI5tY6eZptx7GjSKOhWnDJ1274k5wQtiInVJdbTfL+U6WbU25OmZdS9ZXvSLbUSum/RIN2HQiV/C0IxECLTfazsU8lbZsICgRB7CIfvnMrAqEhXDNcoTTla6sRsKKI0kfsvs4xFJx0NNi9V6JMmyWckC89IGn7jp1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(39860400002)(396003)(376002)(1800799009)(186009)(451199024)(8936002)(4326008)(8676002)(83380400001)(478600001)(66556008)(66476007)(110136005)(66946007)(6512007)(2616005)(26005)(6486002)(6506007)(6666004)(53546011)(41300700001)(2906002)(316002)(38100700002)(5660300002)(31696002)(7416002)(7406005)(36756003)(31686004)(66899024)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzdFZGdiU1liT2hmYncycHBNN2JGWTNPMThDRk5TY0Z5SjZLczRmQkV0c0dr?=
 =?utf-8?B?QnhMeWZydVJXWVdHblNzOEJzcnBEOEFwSTVYYU40dzV3MjN2T3EzVVY4d0w1?=
 =?utf-8?B?aERmZ25rSHJmajc5UFZIMkZuNDFhcGluSDNZbW1odGI5ajgzSzRRNXUybnVx?=
 =?utf-8?B?ZVpXckVwbGdvTlRWZ05YdmtkWFM1d2ZtaURzWGFTU0Q1VkFvcXR2MkM3c0VQ?=
 =?utf-8?B?MzJxcjUvSXFONG9tU3dQNGRhS1RCalBlb2tkRmlvQk4zTnVzYjNUQmx5NW40?=
 =?utf-8?B?ejBTUzBvZmY3ckQ4UjVBUWl1aXZ2WGhUREI4VTZNL1cxZGJSYWJyVW00VUZJ?=
 =?utf-8?B?VzhEZmdTdC9DYlhwdi9RL01RV3M5dkVSZHA3eFJJdnlNWXViV0hGRGlibm90?=
 =?utf-8?B?V08rK3hEMjhGZXhjeG1NaVV3NHptZGZxMGc3N2dmaW1HR3ZPeGovV0grbS9l?=
 =?utf-8?B?dzM0Nldod0ZDSk9iZTlDc3NLUnU4dDhncDdaQ1kyT0FNUHFvSVcyR0l6QTV2?=
 =?utf-8?B?a1BSRXZBS2VEYTVubkJXdXlVbTV6cmhIV1FnTDViWGNndnBIZzdFbDdBRzkw?=
 =?utf-8?B?R2RuQmFUM0w3MTh1am1YQ3d0c0I5em52SXEzWGl4Z3pWdTRodlU3akl5clI1?=
 =?utf-8?B?eDAwYVoxNWFWbnBZQUs3ZjE0QU8yMzliVzNwbjFTZUxDU0Y2dlVXTS92Z3FD?=
 =?utf-8?B?TTU0R2t2KzcwZE8zazVhclZvNkQ2K3cwSjBiTHhocUtFcFlQeE5UNkFRRHUy?=
 =?utf-8?B?MU9DYWI5Q1g0aWZ0c0c5L0dPekJrQmRNSks3a1FXR1JScGlrOGtSOEJXbXlU?=
 =?utf-8?B?M0NKWDZic2x1aE1SYkwwWnBLYjhtcXl5WGFreTRTVGYvZEE1MHk1Rmh5aTFI?=
 =?utf-8?B?aVdGMmhpNVhEdVBuaVFFVmlxdzkvOWo5K2E3WnZWRDBxNm9yWTFkMFRLMlVy?=
 =?utf-8?B?ZWsxeVFmK0tkRE9VdkY2Ync2OHhZSTA0REdxbXpHUEhZRjZuQ1pZZldvMWs1?=
 =?utf-8?B?cGxXRVZXQUpqQlpjRkt0VXdja1NzSmtxNHN2L2NCZmY1TlRaK2FyVWhndHNX?=
 =?utf-8?B?YlRKQVpHc1dYT1RCWW9acEJpOWxXbWNONXNmV1ArNlR1NXJBUTk1dnhsZktF?=
 =?utf-8?B?bTJTY0YxVUVOaHhGQWZ6TmlhZzFHWS9xZnVaSllsaXZrVUhPSVFnRUpiVWdN?=
 =?utf-8?B?eEN5VnRZOENwUG1Jb05lMGNJcm9LUUdrOFlCYWsvQVJQcnB2MGYxb3lCeEYx?=
 =?utf-8?B?VGRJakREOHRFa2REWUlNcVNWZktoaHk4RUhXazkrR0ZWbTRZZzdiK0tXSzgr?=
 =?utf-8?B?bHBEaUNLRk5nYitaTEphVGdqVE1MYkYvNElCRGNLTTNGU3pxWVhsalh4ZEQr?=
 =?utf-8?B?QzVFSHYwQVgzeXdVREZUU3MwbzlmRnh6QVVwYm1vTjRURTNjbFJQd0JIRFBX?=
 =?utf-8?B?bnBzOWVPU2hjTzZRQml2S3dYS3pkZXUyUURlOE5UVElFTndaZGVrSVA0dTc0?=
 =?utf-8?B?NkIzQVJ2SitTT3RESGtmcjVELzR6aVBoL1dZaXdCcnpiVEhvYXFXRGVaaFR3?=
 =?utf-8?B?cW1KYWZBK2xRVi9aL0hqS2NEdFhHUkdsUCtuOUdLWnFvNlJHZ2dkWmR6UytK?=
 =?utf-8?B?aStDY2VzZmFjS0YwVnZvMEphUExLQWxoK0NjYU1rd2hJd2pXc3lMd0JTS3lC?=
 =?utf-8?B?dk9YUWc0Vk5VejNuZlFpZm0zbUtMSXlqd1k4NjFmd0RhR0lOM2JXRG5DOEpj?=
 =?utf-8?B?aWh2MkxRN3B6OTRwWmFweEVlV0w3UGRrcmJ3N2RscVkzUTk5MjFrVm81VWoy?=
 =?utf-8?B?QWVPazNFNmZnMjVuRzhPSkw1Nnk5TjhSQnFJbTV1U0s5bnZKZm1Gb2JDeTJp?=
 =?utf-8?B?Q0VHOC9iZnNJVGVyRUlWbEpqQlM0UjhPd3dDZEl2U2VBMkh6dUJhdWxDbTRp?=
 =?utf-8?B?YlY2S0VHcWVzeFZlZTBrUnhnNGgxTHh4NUJPNGJrSjZMeWEyZHgrdUJubHlZ?=
 =?utf-8?B?b3NmMGt4TnNNQi9VOG1SdENjNnR1a2c3OWhoR0s5WXVaV0Y0b0RVSGkyOTIz?=
 =?utf-8?B?OHBXTjd3cHhDNXRHOFprcGJRU094WnJrQnRWbXZneU01QlA5VFV4cGVzMHRQ?=
 =?utf-8?Q?OXIY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bc7f82-2393-4dd8-1a7e-08dbaee9869b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:57:01.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2V+1ycYNyDnVi8QqNjJkomX26A39VX+MZLJDRdVENaNgXWZEcsCJTbKN9s/rVXRz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 9/1/2023 5:13 PM, Fenghua Yu wrote:
> Hi, Babu,
>
> On 8/21/23 16:30, Babu Moger wrote:
>> The resctrl task assignment for monitor or control group needs to be
>> done one at a time. For example:
>>
>>    $mount -t resctrl resctrl /sys/fs/resctrl/
>>    $mkdir /sys/fs/resctrl/ctrl_grp1
>>    $echo 123 > /sys/fs/resctrl/ctrl_grp1/tasks
>>    $echo 456 > /sys/fs/resctrl/ctrl_grp1/tasks
>>    $echo 789 > /sys/fs/resctrl/ctrl_grp1/tasks
>>
>> This is not user-friendly when dealing with hundreds of tasks.
>>
>> Support multiple task assignment in one command with tasks ids separated
>> by commas. For example:
>>    $echo 123,456,789 > /sys/fs/resctrl/ctrl_grp1/tasks
>>
>> Reviewed-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Tested-by: Tan Shaopeng <tan.shaopeng@jp.fujitsu.com>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
>>   Documentation/arch/x86/resctrl.rst     |  8 +++++++-
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 25 ++++++++++++++++++++++---
>>   2 files changed, 29 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst 
>> b/Documentation/arch/x86/resctrl.rst
>> index cb05d90111b4..af234681756e 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -299,7 +299,13 @@ All groups contain the following files:
>>   "tasks":
>>       Reading this file shows the list of all tasks that belong to
>>       this group. Writing a task id to the file will add a task to the
>> -    group. If the group is a CTRL_MON group the task is removed from
>> +    group. Multiple tasks can be added by separating the task ids
>> +    with commas. Tasks will be assigned sequentially. Multiple
>> +    failures are not supported. A single failure encountered while
>> +    attempting to assign a task will cause the operation to abort.
>
> What happens to the already moved tasks when "abort"?
>
> Could you please add add more details on "abort"?
>
> "A single failure encountered while attempting to assign a task will 
> cause the operation to abort and already added tasks before the 
> failure will remain in the group."
Sure.
>
>> +    Failures will be logged to /sys/fs/resctrl/info/last_cmd_status.
>> +
>> +    If the group is a CTRL_MON group the task is removed from
>>       whichever previous CTRL_MON group owned the task and also from
>>       any MON group that owned the task. If the group is a MON group,
>>       then the task must already belong to the CTRL_MON parent of this
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 725344048f85..8c91c333f9b3 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -696,11 +696,10 @@ static ssize_t rdtgroup_tasks_write(struct 
>> kernfs_open_file *of,
>>                       char *buf, size_t nbytes, loff_t off)
>>   {
>>       struct rdtgroup *rdtgrp;
>> +    char *pid_str;
>>       int ret = 0;
>>       pid_t pid;
>>   -    if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>> -        return -EINVAL;
>>       rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>       if (!rdtgrp) {
>>           rdtgroup_kn_unlock(of->kn);
>> @@ -715,7 +714,27 @@ static ssize_t rdtgroup_tasks_write(struct 
>> kernfs_open_file *of,
>>           goto unlock;
>>       }
>>   -    ret = rdtgroup_move_task(pid, rdtgrp, of);
>> +    while (buf && buf[0] != '\0' && buf[0] != '\n') {
>> +        pid_str = strim(strsep(&buf, ","));
>> +
>> +        if (kstrtoint(pid_str, 0, &pid)) {
>> +            rdt_last_cmd_puts("Task list parsing error\n");
>
> It would be better to show the failed pid string in the failure report:
> +            rdt_last_cmd_puts("Task list parsing error pid %s\n", 
> pid_str);
>
> So user will know which pid string causes the failure?

It was already discussed. Printing the characters during parsing error 
may not be much useful.

Thanks

Babu


