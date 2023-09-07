Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E66797377
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240495AbjIGPYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbjIGPXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828C31B2;
        Thu,  7 Sep 2023 08:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPwiRdIOiWmV3ZTAQm7HtDQuGLouoKkdLwnRvedoQ5hloLlztQc+S10hgo9j7X7z8dtCTiSGW31IeucBveiUaVLLQvnfYmsD0ZgtiZipW6/TyHld/CDUWKgcImJWz9bXE8s4WIyQPZmO54t/i3r9Wpxt+G996lBxs5JsRFbgmIDUzcTg7CacUtuFwxAUFQ5+X39orXcwmdjqwE1740YWJLlJAQ/hzhT+fdGI6pLxGNP2wnmEv3lT87X6+u/eXkZ8gOUi9xBwra1xbP5iGvmG80oUxsTRXzduWiwDm4eeG1EH/vFksAOm/sfdqqlxf9r11J4YThapHB82uVivm0Y+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3y5ih7Gd1C8zh11BAqAXdO9/z0EiGVuG1vMJuNp/sA=;
 b=eQ6iqiONPWbwCTppyhAjcGZLCJMozcQvgCtsaKARNGe5hWWObgASq+qqE4INYuP/hW+vDG9rWjcLbfxU42QPIkVx5xM/5O97+xNd1Rjg1hj76VYSKqW/cP2LfM9Po9KSpjAjxWe/ObAyKJ145s2c1T48CHKKulgFxZ5+R5dRXxg6XfOuUDJsUvVef1z37ifLPT9mKkjU4ZM6caW3qOYTFrvJy6H9zkauQdzZaJuj8htmqs9gw1x4FtoT0/5SNlAYzr3JTvpOsczWbYJalPMhoXieLpoun5zQmM7b/WtBRcVguKfaV2NQi4Wz4EQLWqrltMxzuA3FnsaNww3IufgbSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3y5ih7Gd1C8zh11BAqAXdO9/z0EiGVuG1vMJuNp/sA=;
 b=MHoIA3Z+iCYO3n4Q0wxHGGYsd80X1hI2VrANuWfoMwlOg5iQS2PCFVFcVzDVIFoHSJzJn8aBRe/CmUruzYy6sM872TZyty86nSEogEDezCEYhgePnzgj18xL+3gTIGqjvHjtlnkv+0XoKVLk9abN30yGsgSO5LhqahHrfEPSIY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 14:44:46 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6768.029; Thu, 7 Sep 2023
 14:44:46 +0000
Message-ID: <dd8d6beb-a24d-afe8-929f-acdfef544a39@amd.com>
Date:   Thu, 7 Sep 2023 09:44:41 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 1/8] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>, babu.moger@amd.com,
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
 <fda1fea1-5e39-8a54-ab97-78d182c54801@amd.com>
 <80cad07b-27e8-ab80-24f2-c6befa5db710@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <80cad07b-27e8-ab80-24f2-c6befa5db710@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:8:2a::25) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7e1ef3-85f8-4676-9edd-08dbafb0fb0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29ZJz+p9BhorRUqjrPZn4yhuoQz7T8mhtwxPGqQnixRGuOQleoIQ/x35F59/S7SC3o7UigidPlt8Z+0rLh5wIsPSB4gw/oWOOZ4Zj+YTS1tuuu9GqEjt+e5kDe26qPT2aHk+KGT3s9wPz/w2C0ZoVHtIZh9+SaiuUsqFzuKDdpsLem4tDQIZElI1OmGX2bYjzBMEPJLY5WGJxYBGhXuznfcWY9VHbyV0HScjb/yIeb//JPLkPTVx0BK8NPg52hC/2OEG0ZkMxJhR2S48IDpvLpPS7sqecnWWPraViKOksw3/GkrhagZqSubjhVbQ2gN8UCXWiEBisjaUQrREZ+CIhtNPB6dBGxVvIBtTJQ8OpmVMDP+fZ3suatmQq7R6yNn7IZ1wwuwbomXYEeP5+KFPncR6skrwACNRTi0LMIerrB31WSm4CC5r4A9QzN9k7zFoUdnORvSFEOcNmPl6VjIFt5zbyUQ0kh4xHY4K/iI0SSI4fWqLq6M57mInGTaseb0hpfvq8Uz+yKxHAlbhvXSk6DlmOVTTB64Ltb6o9cHleFEVQF2wZlvP21IGwxkswy7d9vgVNwZCDdJZlZBDZlEVbKwjjgcBrcqcyi/0Nm+BMgOwnUejFD8iQUF0ssFSyGWtr6f3Jt7MeCvl817pitWQqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(1800799009)(186009)(451199024)(31686004)(53546011)(6666004)(6506007)(6486002)(36756003)(31696002)(38100700002)(2616005)(26005)(2906002)(478600001)(966005)(6512007)(83380400001)(8676002)(5660300002)(41300700001)(8936002)(4326008)(66476007)(66556008)(7416002)(7406005)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGVHMUx2MjlIV25MUXdNRklZN3pzWVdRMXRYTDE5VEdrK0N5eWtiWHFhTzll?=
 =?utf-8?B?R3pOQkVYa2hNOVU2N1QrVUJreFFkMHpyZnlzbk1vR1l1SDQ2SFNJM0diQWFF?=
 =?utf-8?B?ejBBYk1lS1NUN2pPRExkcHNiaVp4S01XZjJ1WE1iWUEvODl3dEVMV0hPeisy?=
 =?utf-8?B?RlVMZXpDUUQySWJ1a0I4Z0dZcVVpTnR6WnczS3c5RnN3U245elFENC9GQnJy?=
 =?utf-8?B?c0piZXgwUG1uVWUzNmhzZkZMN1UrakxyNlJRUDQ1MUNyeHR1Z1M3ektVZTFx?=
 =?utf-8?B?OWZZN0tRbWU4ZnlvV1pTOVozSUM2OTBuNzdZdnQxOWNuQnFRcCtpR0VTR2RN?=
 =?utf-8?B?b215cWRSbjlMVkNiWjJ4T3FVMjZ4MGFTQVhRWkxFakhZbWRyRGxnOHJjMWs3?=
 =?utf-8?B?MXNqYWtOZU95RW96VjFjL0dPSS9EOGR6d0ZIdGRKSFRDeTBoU2JNZThxQjQr?=
 =?utf-8?B?M2psdTNWU0ExNU1MMmNEUlIrVm9lM0xEREJqWWFzVitGRm4weEFjTGZuS21I?=
 =?utf-8?B?S3F1ZlRaQnJJZSszOXN3b1ZyV0IwQUJWUXNVa1FoblZmcUZlUHZ0WTZoNm5P?=
 =?utf-8?B?c3BLbW1zTzZQclZNWGhobXV3UlBSQXd5SXdPS0ZjNEFYR0dmd01xQWQvTlpD?=
 =?utf-8?B?eGVjMTZ0K3Rvcmhva09ibjJ6aUZzdlA1RTdmRFFrRkpUeHQ2TGNUQnJvR1hl?=
 =?utf-8?B?WHZwN0syOXdreDJvWnlxOXpPcWpDdGhaRzl3QTJyTGVJWVNaVGRrejJNdTdV?=
 =?utf-8?B?UWlzQnpHQXB2MHlaK0xKeXQvckl6M1dXUkluQnJjREprNDlpcmZOOHpkTUZW?=
 =?utf-8?B?RmZDSWJBc3hYcjI2L1p3b1VEaEJwZy9mTDZEbXorUm03Yk03TWVyY0xQQlhm?=
 =?utf-8?B?WFJmRjdlcUw2T2NMQnVIMWRNUm5iWkR1N25FNkZTTWl6S3l4NnBic3Z4UFl4?=
 =?utf-8?B?QjNaMlR1NElvdnA3d1RUYkQzTGlPdEdVT3dzM0RXbWx2cUlSNFl1YjE4L1VM?=
 =?utf-8?B?WmJqUTFHeWhKc0pKbHZDN2dSSFMrV0lQZ3MwOFJrMmJSK25ndE9JRnJhWmpZ?=
 =?utf-8?B?eS81aTREeXZqSGpRREkzdWwyd1RKQ0dSZGs1dmkwK0tpd2RHY2cxc3F4cVA1?=
 =?utf-8?B?SnNTY0xkaEdIVDJiTUFrMXRlREVCL1FndTdnb3E0QmVCSTNmU2daS0QvcXpm?=
 =?utf-8?B?SlVPYlFDakltOW9sN2U0RndVMGJ3ajVtYlZseVFOZmZzeUpCSVZtajRJR3JT?=
 =?utf-8?B?NU5kUmU3OHlzYXYxZ3Q4QWpsTGVTV1dzT2EweVNNVDhNWnFHd1BhSFRmdkZz?=
 =?utf-8?B?VTFxSnNGQXp2N1JKUGVzcy95U3A5VVpza2ZTZGNFK0VqUlZWYXFEdFVMQytu?=
 =?utf-8?B?S0xUZUU1bjBVUTFmM3RGeXZMR3JnNkd3QmpBelhjNE1EN1BJdW5xa1MxV0hQ?=
 =?utf-8?B?ZDlVNnhnY1BNNThVVEkrZXRYMHlEYzVCTmlsZ2NRSVVGQkJSOGJNOFpDaThJ?=
 =?utf-8?B?TlRWd21ZYmE5dmg4NFR2MUY2UnFNckt0bE0zdXlnT1lsTkNmTmhJTnlOQW5r?=
 =?utf-8?B?djJGaWtHTzZGZnBXZ1UxaklnUENlaFRTeVBuMnZpYmt4TklUajM3RUJRUXFC?=
 =?utf-8?B?K2ZJd2NWdWlLdU5lVGhJczJtRzlUem1IN25xSi80NkQ3MWs2bjZjQ2VXanVk?=
 =?utf-8?B?Y3NMOHpEbllVaWlRMnhZV3c3UHZkUjhRMFFNUkNLRitsZkFxa1BBRkpvZEUx?=
 =?utf-8?B?ZmEwOWYvR0VhMHZlTGQ3R1R1R05zcEp3ekMyVEFtTHJTOEphYzRsOFZ5OXMz?=
 =?utf-8?B?V3FtQWd0Y1NlaWpnZ1lhckRWcFppalVOaFNERFoyY3pYNXE2YjE1VnpsR00z?=
 =?utf-8?B?TUxpUVZENzU1OTJtZXBvYlhjT250eHFaanJ2RFZsWVhWeE9jVk5tdlRJdUZO?=
 =?utf-8?B?RUgveEpWZW96UVFuNHBLZllzaFltNk0zTWJNTmtYVUttOXk2T2orWVJLeFhQ?=
 =?utf-8?B?T1YyRFdHZ0tyTllydUtTaHJSay95UDhhTDMyQUpWY2lrbTZHNVZmUzBSZ2VP?=
 =?utf-8?B?Q0t3T0FpVDZkTzd1Q3JBMCt4aXhMaVo4U2h6SjJvV0xnWFBZd3dLN2M4cUZh?=
 =?utf-8?Q?VcQU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7e1ef3-85f8-4676-9edd-08dbafb0fb0c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 14:44:46.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NVDk7DlZQmwzfvTRzfoX5EsQuEguvdX8MBivvbVi/JiYkOGGcbriBfPERvOJQwS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052
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

On 9/6/2023 3:42 PM, Fenghua Yu wrote:
> Hi, Babu,
>
> On 9/6/23 07:56, Moger, Babu wrote:
>>>> @@ -715,7 +714,27 @@ static ssize_t rdtgroup_tasks_write(struct 
>>>> kernfs_open_file *of,
>>>>           goto unlock;
>>>>       }
>>>>   -    ret = rdtgroup_move_task(pid, rdtgrp, of);
>>>> +    while (buf && buf[0] != '\0' && buf[0] != '\n') {
>>>> +        pid_str = strim(strsep(&buf, ","));
>>>> +
>>>> +        if (kstrtoint(pid_str, 0, &pid)) {
>>>> +            rdt_last_cmd_puts("Task list parsing error\n");
>>>
>>> It would be better to show the failed pid string in the failure report:
>>> +            rdt_last_cmd_puts("Task list parsing error pid %s\n", 
>>> pid_str);
>>>
>>> So user will know which pid string causes the failure?
>>
>> It was already discussed. Printing the characters during parsing 
>> error may not be much useful.
>
> Could you please let me know where printing "pid_str" is discussed?

My bad.  Should have read your comments more carefully.


>
> My understanding is a similar thing is discussed in v3:
> https://lore.kernel.org/all/167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu/ 
>
>
> Then v4 has this code without printing pid_str. In v4, there is a 
> similar discussion of printing pid, but not pid_str.
>
> But I cannot find a discussion of why "pid_str" is not printed.
>
> If kstritoint(pid_str, 0, &pid) fails, without printing pid_str, how 
> can user know which pid string fails? e.g. user tries to move 100 pids 
> and the 51st pid parsing fails. It's hard for user to know the 51st 
> pid fails without showing pid_str in the error info and then it's hard 
> for the user to decide to re-do moving or aborting moving etc.

That is correct.  Will add following print statement o print the pid_str.

rdt_last_cmd_printf("Task list parsing error pid %s\n", pid_str);

Thanks

Babu


