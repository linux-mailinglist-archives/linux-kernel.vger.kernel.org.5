Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9F76C3E5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjHBEI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjHBEIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:08:24 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C851FD6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uu9Iq6V0Z/STt0G0oaTcZK33stmmSv5nl6KFnzCl6BAeEaPMiaYal/PBHNpPPmnlwvsYL9gmDt5D/M4TC+lV0GcDzBRuCaV/m8z9J7s3+GpTEU32etnNu73B8QNznRpQS+voPiRnG5pAPlNJXcGJbah5mCPWFpZLArzKVG6un3ye1BwJP7tCg6qtgBxeZg8y1Bdtw6ths1y/vr2FjNfk0NnPlnLLeK30qByfAqpSRUPvnDAYJwuClVe/qIgfDGMEzczvdouMWy3EyW/kcs24ZtLkbcr1WV+WQ4AG8W969wjVL//EuWVdlPX4xlpXz/TegcrDYtRoO/qAkHaXW5IecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nNoXb3DCZfnd0iCjCGh+12lwdroTwo3AXFerJMOvzw=;
 b=fbTFvxlV52G7xSlM0H2NfTml90gw8ae/LPsaRav5dvPqU6Ke3HxTaGB/j6Gp3or5gGyroN/Z5vYUaZ0abXaRJ06nuM9Z0YMY+nRE/x3WmOM8zajmPQ+3jM3KFNqaYhyvoCwEVhFpNw/FpygBZlmmN7JAkmZdWM2GlYpueBtDBn9Nlal9FrTn2eGOLrxqASP/8U0znzNKhrvh30qGE92cUnrv34O29Ex4ic1NPInuH4ZXFgRo9x3pLuVs5pmcI7NX2/kFW4uTF/DlV2COoWrMoeS9oTY8HB7Y/WGpGhHMXaE9oE1Un//EkEz/zKpFWKkFpg9yP2QenrB5lFFk1gklMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nNoXb3DCZfnd0iCjCGh+12lwdroTwo3AXFerJMOvzw=;
 b=HVtAD4VQwkZs1swzH8fOo2HwJS+E+CJdbbsAwstC21uLJ4kDks3/ijK3/zO786OIMywrWvlK9CtwXnSZABA2/24JQQocO+1vf3fWVdSyRn6wuuh8mQlg4azRRjoZBJRPTk3lCZiqkOiXdmo/UyFPou6/gRMGHCF03gQI8u5ncGc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 04:08:19 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54%3]) with mapi id 15.20.6631.042; Wed, 2 Aug 2023
 04:08:18 +0000
Message-ID: <24655ce1-d3c4-6a32-09c6-26420346b3ba@amd.com>
Date:   Wed, 2 Aug 2023 09:38:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v3 03/14] virt: sev-guest: Replace pr_debug with dev_dbg
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230722111909.15166-1-nikunj@amd.com>
 <20230722111909.15166-4-nikunj@amd.com>
 <e738e3f8-4984-a7cd-05b5-006d73cb0cf0@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <e738e3f8-4984-a7cd-05b5-006d73cb0cf0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::20) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b51742-89eb-4031-2691-08db930e1a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M0gdfS2xEGMv1Z+zb6XNDOJzX5Ks2k94dlw53Drkoy6v70yX6/zrur3f9XIDLJOebNr/Vc3Z57harkZ22mxabrH7Tnl/y7J5jWhxHZEOfscxWR6lz8A5P62uptKfqGuO9MkZSRuF1DTiwsL67bi689sxWVGi/ZCWZHGDwAknflChhqYXLEyTMbc1alI8lTlUG8B+qb4E32u8c45xu1q2h503TvDmiLzpWBbkogwVfx/cKzGni9WFK0nQ7pAUCXHtoQv5KdyAbSIdNTUXegn+mCNrog45dwGNQywr92Gh+FHWjeBnCjU8AIAPRSK2EOGBSkeNuNAWKDUnuNkjGAVKBfcc1Sk5EwuuMaPjThgi/uH5mMrqmZQQfG+bDN0MLRR3W06M+EN0jNUA6u6R+foyu0asBFFy+/NKt8EmHB1MhYxTvyG03izX9nKVvuT1ImUuAGLgH7TCTojLYFovr6eBfpcaQDGDJVKrGGf9/8GQRcd/nVTAEpucHS6Q/xMRUuDaSNC7RlMx9MK4AAvFGQLGXE0d0YVRn6uQICLXKj6LO1O61sbprpjS6tMMS65TaDC+IzdqglO56o8wmnxktv376TX3VEkue1H0ViMcHW9ffXKejXmJGlTEqGSYA6Kh0Q2AnHHSsNtjW0QsuqRM4d5FkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(2616005)(186003)(6512007)(316002)(478600001)(38100700002)(66946007)(66556008)(66476007)(6666004)(6486002)(4326008)(31696002)(6506007)(53546011)(36756003)(41300700001)(26005)(8676002)(5660300002)(3450700001)(8936002)(4744005)(2906002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG9NbHVGcDNiSDhkUmViZTRIUU1EUkxVNzYxYmNmaDgxaWpOQUpVTHpRV1Jm?=
 =?utf-8?B?QkpPeG5UVUY5MkNORHcwOVNEMnRKZEpBL0NqNmtRSVlOaDQrMGdGTGtJYk9T?=
 =?utf-8?B?ZmtqZjhwZmpLQ0g5dnFLRXN5NUN2L0E1ajJSVWhqRHdZNnNpLzdzekQxbEV4?=
 =?utf-8?B?NzVmVE0vckJHNys5ZDhPaU5rYXM1RnMxQnpIR01KUlZlcGR2N0xQbnhBaEd6?=
 =?utf-8?B?aE5OaHY0NEYrK1pkTFNabnRXQTNYM29SSUdPL2Vsam9XYmZFSnhpT2xYa3pi?=
 =?utf-8?B?ajJUYzF4SnArb2lYUnp1ZUZxdDY2eE9WNThsUFNSTWNFdWwrQVpRWnpFMytk?=
 =?utf-8?B?WDNQWlZoR3RTZ3p6cUI2bXJybE1Dd1JBZHA4OUdLbC9rSUF3bTlYWFZZWVMx?=
 =?utf-8?B?clF1U2N1K2h1OXRILzFjenF0UzZ2RjdwbENaakVNVzljVEoyK0MwanR0cHha?=
 =?utf-8?B?c0Jla3F5NWE5YWRMV3hlVGpUaXZmSUJqazRLK1FGcjZlaHdKdG8rMmdYcUk2?=
 =?utf-8?B?akhUWEhPa2M0N3FlWk81a1FwRGhXdUQwa29KZ2gwempJNENxeU5idmhQcUJp?=
 =?utf-8?B?aDJLL3U0YjJBZ3NwVGp0SFA0aVNIZ3hwRkRwMlozOUpOWGpzaVpjNWIwdlVx?=
 =?utf-8?B?aCt4eW01Q25JbnBDRDltdW9SaUdGTXBGV0MxZjJqR3o1eHZkNjhmN3VxdUVy?=
 =?utf-8?B?Yk5MOU9rSGFRM0FIQnNxekVzSGp3TVpBMXNtZ0oxZE5CZ3EvRmtoeHRaSmU1?=
 =?utf-8?B?WU12elNnMTBGd1U3cFFnWkM3UmpFMmZMUk5GQnllektjc0cwc0p4dkNxOGxt?=
 =?utf-8?B?d09FZ1ZDa0d3YzlxMFZYc2JpWWZVbXA5a09xK29KZ1lGM3l5OHpDdmo2NHJz?=
 =?utf-8?B?YzYxYXNBWWpPb3Naa2FzSnFNbHJuUWNwOU5KZWxZcTlRRUFtVDgySU9ZRXdF?=
 =?utf-8?B?VzRDcVk4MGhtbk1TYVRwSzhZaThPaVNFZG1VUTQvUko5WVpJS0Jidjk3c3hV?=
 =?utf-8?B?SmZRSFlVRjh2QjJWOUdzNS93a2tMcjVjQXp5dVo4VHcwNTJBUGN0elprMzNi?=
 =?utf-8?B?TnFXWnJXT2U5bld5aUJIdUMwN0V4dEllMGg1dENwWkJiQTN6YUxwUEE4bnVk?=
 =?utf-8?B?Q3F5cmhNNWQ1Q2RnUi8zdElJR081VUo1bldUNzE5TCtiL1QyRGxFaXYwYXNk?=
 =?utf-8?B?Um9xUXRLZFNWZW5aMzNhY0xvVVF6cWxkL1c0TFpCeVJMVnplcXdJZXZzTmU3?=
 =?utf-8?B?TFEzWnlUUzFBbGlQYiszbjM4UTlqWjA2anUxV1BvVWZTNmo4SW5CNGtqQU00?=
 =?utf-8?B?cFVQdE0yVHZRYlNuTW9OWld0bmV2cWp3aWpOeW16amtCR0E0cXRvWnRTQVFH?=
 =?utf-8?B?Um9NalJuUEZML1NHaG9KWUc5TERQM0lURFJuVEI1WEFjZm5KVDlmcVptY3I2?=
 =?utf-8?B?OXIzWkVFTkhUcVIwSzNWMlMwdFlmRDh6bGRyQ2Z0QUhtMWxuVFZydjk5Lzl3?=
 =?utf-8?B?V001S20vdXlab3k2RDJObDZ0bENPbC9ZYzhMbTk1T1hZcDRHM1J6aEdHa3hF?=
 =?utf-8?B?TGdZTzNlQ1Q1SktNMFkyV3BBOUpYdktNek93VHZ0dVFqVldUMXdZaXJOV1dQ?=
 =?utf-8?B?VkdhQ0VmcG94VE1BVk9ETlBRZVVrQVcrWlBMRFpNUFdLTDZvdGR6QjFrRFR6?=
 =?utf-8?B?WiszSVNNMlZnd3k5cmR4Vk9iS1YzaTllaXE3ZUVEL2tyYUVXaVN3RmczbDVo?=
 =?utf-8?B?czEyc08yYXN6SGp2cmJveTZlNnRGUS9PTWNRUWI1clFJTG1JMXBUZmY2bWgr?=
 =?utf-8?B?M3RueklwR0MvMjJjTHQraDJKM2tOMGRsZzBBeCtjaEhwVDhOSE5CWWg1NHlD?=
 =?utf-8?B?T25XUVZVcjVPZ090VlJpWTQvMFlUWDZWcDNPK3BkMnh0T0dIbnEzQ3VtSm1P?=
 =?utf-8?B?WjVwOEdlTDJvck9LTlAveUM5bmEzeDRuTTJ5bUVhaElRYXcvL2Z6SC9QbGxj?=
 =?utf-8?B?b0QwNEE5cmFhamc1Z1ZEVlIyQllOeDJFY21EVXBsQWY2bHZZdCtyak4yNUs2?=
 =?utf-8?B?aDR1dkR2d2pJWFZQSmoybjNmL1Q2cy9xT2lpUGplbW9HQUROUXJSVjFXZTQz?=
 =?utf-8?Q?hcqpojlhKim0vcrRBdASXaYCP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b51742-89eb-4031-2691-08db930e1a3c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 04:08:18.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0leDK48aem4a3v2ttBdml11AMmWjhFIslvoA0hMh0LzDjwlMJtz7p4TbrBClSl+CDOA6ufTx37vA0Wg46x1UJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2023 9:04 PM, Tom Lendacky wrote:
>> In preparation of moving code to arch/x86/kernel/sev.c,
>> replace dev_dbg with pr_debug.
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
> 
> The subject is backwards, you're replacing dev_dbg with pr_debug. With that:

Sure, will fix the subject.

> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

Thanks,
Nikunj
