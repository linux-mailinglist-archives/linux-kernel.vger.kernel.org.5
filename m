Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0387177A554
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 08:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHMGzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 02:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjHMGzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 02:55:10 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2063.outbound.protection.outlook.com [40.107.241.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BF7171B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 23:55:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1krt4nl20TLBUs+xtA+CdlDzw531rakP29ucz7TV28NLl5qTR1UTBT2jqSSV1YawrdJc1voAKRqVNsOOcLTYPsaU3ah5U2fQccRwH7zoycDQCpUasJH5/+HZ1XiTSVhOum6yurksx6HDdfX8/wLGE2vx6CD8taKZVZX8uUMJMP6iTg19LF511jVu98tFag/Wo4blMGrxJUuiUmPMwiNrMKcM8kV9v1t0it+Wr8UpgIggv1rTC0VoD2Gth3Ge0/TKqDkobB0dExT4qkdW71ZhKt/Asz+5LM7fjuD2J7m2tWuOF2meH5s7T+2NI9HtLMLQyOILqRu/iyvqti5qJhdPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQ8W/V6Sb7F4XSwtLKhTuxftUsxsWc9ErkYcfnEGAyY=;
 b=bHWyqcybzCYUoMqRyoqg8fieiF7o9rqMrx9eq7RJKJGBpLI3zPvAOg29Xj5b73Luzzx37/eTkV3jjn8sbZBy4c2dy8ZxWo3tRW/RHOA6QPvIQa/QCvDno1yAv8A2FH6WISdAUfOSqtzwg6Q+oydmHfu0eNRf7/anUg9vl4gmdo8S+5yWUNd/pX8g2EwbIQHyE1/FoSJS2fB8dm+KcuPLwD5GlwLJV2IXve14vF0WACbNXg40XR1lZhwumpdQi/Kd1GvaKptabXUNULqWs8ym25RgqS5vSB5E21bkpjNCyUEpL4skA6gaaDG1r8ysccv08uAxKIlrHsCxUmub2opt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ8W/V6Sb7F4XSwtLKhTuxftUsxsWc9ErkYcfnEGAyY=;
 b=qRFWstMzu1LVV6awHniShaFc4nK4XFUcqJNjEGLTTuqG/TgfDJTnqxpbpbMtX/rrnMkxJwZMb0zsPnVqawoBVJcomFQ5AbhMaEL0Ndy7tRGfJb8PPFGTW9HYX0O4ATsvs47mDbwvdNpDEsll6Jdos3d2lFlayWyjpJpzF7+9QUyMkonZknB9WbpogupfQA9heJ8TOAnE9hRqkFu81eVqtymAzELKUZAwqD+8zAjAt+hSsZGpA5VxzskKOblcyZ0ykTeVs0VkP4KRsfJ2k/l5/uddRL+/aZFN5vhiF6KnQgHYd60XaiEz5RVCGVDMK2h7d+7osIrTmLbAz1KA1GFkNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AS8PR04MB7525.eurprd04.prod.outlook.com (2603:10a6:20b:29b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Sun, 13 Aug
 2023 06:55:10 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6678.022; Sun, 13 Aug 2023
 06:55:10 +0000
Message-ID: <c1fb4972-765a-d06a-14d1-028a8a75bd97@suse.com>
Date:   Sun, 13 Aug 2023 09:55:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch V2 09/37] x86/microcode/intel: Remove pointless mutex
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
References: <20230812194003.682298127@linutronix.de>
 <20230812195728.069849788@linutronix.de>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230812195728.069849788@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0050.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::15) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AS8PR04MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9c9f56-2b90-4c66-1d8c-08db9bca3c45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Is+sJIpEbcpRDv/O9WhRS9DIt2YZHzirUdPffoR+b4degP1AVSk8acl8Oy6ad6VqP9gvhWMr7TBckOvaJ9wnPOlk0MImPKO4xvHcO9Y1E35cFogv+32MIntac4Si1WhJXLd13R/2VTx6nVOBXwlSa3Mvxg8kezs0ZCEOrZHjuaZa3cgQPf5ti1WP9cV3FXuR6JY1kPImsiyTRfeJ18Cffq7xldyVYKxT+eP9hXxGWtKeiWdIelhzDXKlwP6BdkMnezClz/2eo6Me2SLPsJpdNKxKCEGiJvub8QS7ZymbeRI5a0/odtxtTFVflqvprVRCuC99HhJJj38hOI6cciO3fH6gukCEVAMrjWCIObnJadKL2UFZ2dR3q3ZcHE9k9CXZJTJcL9FnWhkblyoIRAYuWdnEaKI2hC9olhjUkA+XbugiBjKnlCNniRkXaPO0PrBvNuJaUY8wqXbxpkPEx2M0ajr/xjYDdPjhHZtaguGeWB9N4tZ8EX5tRZI7yhkYFbK5qIZkVk8+KXm4PRxPxLrgh+EnqbUO9fAZntSrkCU3soDLlLYsaWx0eXQTaLph0WgDXi5aKkuPk8PBCls2aA05EBD5Oahd+X77d1EycZD/IdUb0h0/mzFRd/QMQzrKu97tQGXudjju8Hit5XPJHauxPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(186006)(1800799006)(5660300002)(110136005)(478600001)(41300700001)(316002)(66946007)(66556008)(66476007)(4326008)(54906003)(2616005)(36756003)(6512007)(6486002)(6666004)(26005)(6506007)(8676002)(8936002)(2906002)(31696002)(86362001)(38100700002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzJwc0Fna25hQk40dXhYdmFWUlNaMGVCSnYyN3pQanRTSE9xcTVkaXlSRHJF?=
 =?utf-8?B?ZlgwRzlTd001ajUxeDdjTGhLamRrWFJ6N2ZiQWtIT0lMNVJIRzNEOHlqc1RQ?=
 =?utf-8?B?NWt6VEtleGc5VURETE04djc0NTRLaklKQUhSNktqU044ZWVIOUhvRllhOGpo?=
 =?utf-8?B?cVkrbUFmUzBPSnFOblFMY0IwT2E2WEVvY0hIdGdoNEhkM2RCelp2RFN3U3Zi?=
 =?utf-8?B?d0JxcTZNc3dSTk9LblFQcW1qYm5IWUZ1VzBKV0dLNmZjTTB4OEp0THBxVFl4?=
 =?utf-8?B?VEVWbUdEN25LLytmOUIzOGp4anAzY0laN0ZFWlJtdEZvSDNNZm9kNWc3K0NI?=
 =?utf-8?B?RnRDMjEvSG9yYkFoRDh3a2RvQ0pyNUlzS3NrWUlJZGhra2RWNGRoWmM5YU9K?=
 =?utf-8?B?bksyZHl4SFRlcndENXJ2eXlYU2hLeUpyS0V5K1BuT0ZkOGhHeWJDc1dOUXZV?=
 =?utf-8?B?bGJ4dDNRV1JvMmZ0TGVGRHgxTzRzZU9Vek10UlJJM2l0eS9nb0YvSGhaVElw?=
 =?utf-8?B?ekltQy9SVnJtREVHQWo4RmFRL1lhWG4yY1F4Umc5VmhNdmh4Z3RmZzd4K1FP?=
 =?utf-8?B?MnpXM2szVWhTeE0wZXk4ckRpT2h5VzZsMEpvb0NWTEVsTGxxR0F1YnQwN0g0?=
 =?utf-8?B?Ump4KzdkVHVsWWtPaXJRdms2NUNFaXVyZ0pIL2ZYenVHY0g0bnFWTXovQVdp?=
 =?utf-8?B?TERuQWxUVFhmdUQzNHA4WVZCWkVWVEZPNEZlWjRScHQzTGRjYUxnUnBxZVFa?=
 =?utf-8?B?SEVEQnNZbGhzbFdDNTVqME53VjJOWm9JR3RiY1d6bTFUOWZ6OWJEclB0UmVj?=
 =?utf-8?B?MFNLQ3FzZndJelhLL3c1VDlZOVVpZVNZNmRSY08wVEgwd0FXU05ZdzVXUEQw?=
 =?utf-8?B?eWpQSlFJdWN0cE1PYXY0UWI5a0I3c3RES3Y3eXoyWkJUcThMU0x3K20yT3Zt?=
 =?utf-8?B?STlwRVVOQW5rbk1wWTY3ZFVxZzNpa1FTL2lJQkZLbThlbGhqcWs5djV5Y05Y?=
 =?utf-8?B?SENabHRmbEs1R0pKZFI1VE5jYkN1NjBJSGRPZmJlZ0ZnSGRsYjdKQlVwRXNB?=
 =?utf-8?B?MDJIdnUrdVZXU0ZqTFV1cHcwTC9GY1Y1MkdhT2VEZmJ0RGZrTVB4cGlOS0Fn?=
 =?utf-8?B?N1pJQjdFVGYxVnhUMElBUzB3S1lrODYvMG5YNUlHTGlaalhJQXh1UFJDN0pN?=
 =?utf-8?B?WFJwdnMya050aUsrVjZsNXRudEtRNXA2cnkvZFM5TENWbGFIamozdU8vSE1G?=
 =?utf-8?B?eGhTTGozQkh5RFJKTzRZVERXT1VwZzJsRm1NTDE3UkZ6aTh2eXpqNmduMVNW?=
 =?utf-8?B?T2FCNCtQV3hoRVc0UDltRUExcXZkWW1NOU4wdXNuSEkxa1hRRXVIYm5vaU5U?=
 =?utf-8?B?bTlDTlErS2FkdU1UV09QZnpUb3BTNWtyLys2Z2dGYVJPQS9LSjltQ1kzb1Nq?=
 =?utf-8?B?d0hIYTYyc00raEp3bUJ3azhCTWNHTGgwdzB5bzR5bkFEZHlOYlNxRkcxTWZ5?=
 =?utf-8?B?bnNScWhMdzZjRkNiRnRNS08wa2ZScHdHdEtCSzBlM1owaElybStlRmQ5SDhz?=
 =?utf-8?B?MU5yZzliTFJ4dWxRVjV3WFZIQWhxNmFlU0ltVm9seURuTkxNZHdUUk5HdEsv?=
 =?utf-8?B?b3JkWnpacWVwbThici9HYkt1UXVzYkpaZGIrUkpTRityQ0ZqbzBnOUVkK3Z3?=
 =?utf-8?B?S1B6ajBGT0hrSE1rcVlBVFAweE5HMTQ2clNCUmErdk1rU2N6M04wcEcrcDlk?=
 =?utf-8?B?eDBYTkY4Y1FDK0ZhNFhkdUdaNXV0cGF1am1pYVhjcFpZZm1wNkZCdnh5byt1?=
 =?utf-8?B?TDNJdzlDbE5ZVWFpTXlpdW4ySGFHcHoyemNFTTdzb2Fjckl6QkJTZkRYYXc5?=
 =?utf-8?B?cVpDLzBNeWJNSUdrMkJROHNYSk0va0tjcUpoUU54d0ZUL0hRK2Q1eExwVTBC?=
 =?utf-8?B?Vk5VRVYvNFlrazJObE8zWFZ2YW1LNEZKTlQvL0hYaEVzQWJUeFZpY3I4SW5J?=
 =?utf-8?B?NXVlUTNscStBRW05S1l0UXFXNVc2QUxhamt5RGlleEt1UFlrNStRL0NWY1ph?=
 =?utf-8?B?RklkVWozanJVRi8vbHBmZ2k4SkVyNUhBY3NtTWtmeWZhOG9ZM2dKeHBIWlYy?=
 =?utf-8?Q?Z1t/1AwExDxT2dTS+1rlqhlyx?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9c9f56-2b90-4c66-1d8c-08db9bca3c45
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2023 06:55:10.1713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3L+qCB63P5AE8EGoJNRC7koRcShCV8MEaXgKkUNtC5IhJAzyHDo11FAYn8xYecT1Age5ffjxqrkdlkqFZFW1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7525
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.08.23 г. 22:58 ч., Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> There is no concurreny.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>   arch/x86/kernel/cpu/microcode/intel.c |   24 ++----------------------
>   1 file changed, 2 insertions(+), 22 deletions(-)
> ---
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -397,22 +397,6 @@ scan_microcode(void *data, size_t size,
>   	return patch;
>   }
>   
> -/*
> - * Save this microcode patch. It will be loaded early when a CPU is
> - * hot-added or resumes.
> - */
> -static void save_mc_for_early(struct ucode_cpu_info *uci, u8 *mc, unsigned int size)
> -{
> -	/* Synchronization during CPU hotplug. */
> -	static DEFINE_MUTEX(x86_cpu_microcode_mutex);
> -
> -	mutex_lock(&x86_cpu_microcode_mutex);
> -
> -	save_microcode_patch(uci, mc, size);
> -
> -	mutex_unlock(&x86_cpu_microcode_mutex);
> -}
> -


So this function is ultimately invoked from a write to the 'reload' 
sysfs file, what about 2 racing writes to this file ? Though if it's 
about cpu hotplug then in reload_store() this is handled via 
cpus_read_lock I guess so indeed this is correct.
