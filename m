Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC69377B1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 08:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjHNGj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 02:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbjHNGjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 02:39:17 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEECE5C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 23:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3mH84SKRapxIItDtCYz+HpceqeLL41NMFyKOOAqvaup+fjG5MiFD3HIjESGsxTARAlZRfWcjog6bzilAddSwkb0B694fkWUMZ4pkIve7PWxbNWIDbQwqMlvFniTzGx75Qr6x4CSaK0eAMvFByHFsJqu1KokRO3tMsY+KiTcGpN0rhjXtj4DOwB/iCyLbeGAA8mXiifdRFi3zZiWiQJmMZwmHjg7MMz2W6ywNUGXRxQKtrWlhBVZM7W56rImLBW/v0pEU4yBTEtWaFaQPkznw7L4rtu1disbGQg79HTkaxLp+fXj3RvIVV61DMl4HGjVAdMcz7drXMjqTnBggI9HnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dX3iG05bCMHGueaDoMwYAeggP4Jr4j3hzbRMC/OGeQ=;
 b=eSOX+AFmoSSsBwK/tNEpBiJRWoaUN+pJxe8zQqy3t2VYesDDajvoLAEjufgtXi2/XTxNdfBccUU636hVLz6cOvFv5dt7oJDl1OoMLSFKrc37/r5j3hZl+5IBo/oVXKpzKnhPfmccwPixXo2hxdX56LecmnWsNc/xhvvfjw3vR+mbjb5tOqKjfRDQU/NBVAfUO9IPMTx3cQIvh4kYgCvDV46iKm8h8Jmoxv3TQ9rb0evtSoYC9FCkA5e2P9ETSf/hjp4UG3w3uyI7vBE4fhp+5GL0kiEZuSO2c5O/s2Mn2KE5rqgKjWP+/rJjAOWWqwVx/+mMMAHkCDHiqOqq2j2gig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dX3iG05bCMHGueaDoMwYAeggP4Jr4j3hzbRMC/OGeQ=;
 b=k8wb4fMMoZwsGQodEYSr1uQvNoAPJgfWJokVSbKCxx0k97KW3AF8koM6mBCLLhy0Q/ygQz8yBZCVrlGggKKyhYasGQwZowA+BeAfQRWdSzezt3nHr3WQIycMrYR2FgbKlNcPJzCWudOXWQsEAdqLXuutIwF7uR0HNysaXown+fp05BpnjjuNHUSyUceiXMlBvW/iKgx3HKTjl//Evoz4QPQMMJT6/OTB0a7z3ZKp14n3j6/bF1rE3cByji7RVuR0l/xprnhHih47G8glV7aQZaH+1RHTFtTuWp2LFL1zUddsrRdRxmBPWmhHgWz/jZRpcAnq0ZxiNcIo5RQlQ6D53g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM9PR04MB7489.eurprd04.prod.outlook.com (2603:10a6:20b:281::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 06:39:14 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 06:39:14 +0000
Message-ID: <1588ed00-be11-ff9d-e4c2-12db78cca06f@suse.com>
Date:   Mon, 14 Aug 2023 09:39:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] x86/srso: Disable the mitigation on unaffected
 configurations
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230813104517.3346-1-bp@alien8.de>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20230813104517.3346-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0902CA0046.eurprd09.prod.outlook.com
 (2603:10a6:802:1::35) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM9PR04MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: a33c3a69-efca-4fef-a7e1-08db9c912cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x28RIF6VGAEjru6+WXMXNpQW/yD/MZBeJd9jEQ6pQ1Bmign0bKMJoVKXeEGfl7+B55TRBkcUG1xGXvxSNWm97dVV2h+K6bJP7VGegj/31S6T6oj30o8vT9Y586O1FXVzJn/CoxbjtQ4l+kjdxpabcDHAtLLScX/fZdggsqPobjytTjTVYFCN6ZUlBI3oBRcFU0YI3ITvQy5WV0dx+iX4/edxHiEkjLfB0+rFXW0AyqxzsxdBvwfaFHvXTdSrBpJU0oX5RhD2ycJ16uuirOTvfcfslCFh0R77gChcsWavHX2eo8WYdJ+kBrGVTv/on6RzmJhY+1LY31lvZFf4bcbbsaGff/GxCCGlnQbhK2qU50v+sl1PUiSsDEr6WHmrZTgcJiBlRvBaTM5AyVLkqS4ClIkSSJpqteL/hdz++nrZlSTDukd4lJg4whOPSUhqA3W/cwbCszaooP/iowZK2I4zAY278zOAr5edL9iH1grGeUNmNY3DoVaZiMnFMnzouCnbPfJGd4wyLYmAZ79Pofeq1BHx08qCZAsjiH8PlHXG8FIpYo/s90NHhq8CdVydZsY8KCd9f6PVbrfHYPb3iX2Dpo1eW8iAsZ25NNoedpzstfw34AiRcI+LlNY1gAI+EjD8y51up6WiJ+Jefi5bKc4L7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(1800799006)(186006)(451199021)(83380400001)(41300700001)(8936002)(66476007)(66556008)(66946007)(8676002)(316002)(6512007)(31686004)(2616005)(26005)(6506007)(6666004)(6486002)(54906003)(478600001)(38100700002)(110136005)(31696002)(36756003)(86362001)(4326008)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGhkcVdWdzBsSUZPS2FWNTNKY3lHNENmWnlBN2xRT01MaGRlOEd5YkVmd3hJ?=
 =?utf-8?B?TU5GbnZVUnowR25iY3h6WldVTVhjWjJCSWk5WjUwV2FWT3RSaXN0emFvQVRp?=
 =?utf-8?B?Q09tT3ZuaXJtL3plbjY2cFlBcm5GY0J3Mk42TGYyejB1NjY3WDA4U0lXeThV?=
 =?utf-8?B?Nk5wYXFEUkhIRm5tamRrRVN2SG0zS2d3MW5oTFlOaC9UNWQ3U052ZGRTNEJx?=
 =?utf-8?B?T3RPK1hMN1FOV3FPd2ZFRTRpdzFKSWg5UnJsMlBzZ2x4SUhlWk8rYkppR1Bj?=
 =?utf-8?B?V3p5Qi9JbWxQbWQwOXJnRTk1VkwxM1B2QjdUQ3d0OVZUQVZUUGZPOVBTK1VZ?=
 =?utf-8?B?bGMvYkdTcmQ5TXlDeXowbXpGM2lMTlU2R1pSOHRYbnZNREF2UVI0a1dVN0da?=
 =?utf-8?B?NFp3SXNsTWlkSTRpN1pxQktmZmJ1OURwc3VmK21BUitndGk5NUVaTW1mWkVU?=
 =?utf-8?B?Qk8rZGU4M0VBVlBlTGN2UUh4a1g1ak9ESWNBNHZHTGh5c2tsOHVmQUo4OUNx?=
 =?utf-8?B?ai9zTnVuTTBmUS8zM2lCbTRsQ0lVQXRjTFcwVnk1c0lvMDlsNlJNVVNPMEtB?=
 =?utf-8?B?K3hQZCtFblcyWjlBN1Baam9EcGJkeXBGeHcwbjc3WjVzanQxT3djM082eVhy?=
 =?utf-8?B?RTZnd1l0Z2xEYTg5dVFoVVlqM3c1YVM1T2FLMkVxOWdlaDRYWE9FOHJXNmlw?=
 =?utf-8?B?WHdKVnh3QUs2ZFpVUnJRd1ZDdlcxcG5jOE5RZXBvOCt6MVp1NnJOZi8xeFBj?=
 =?utf-8?B?aFlmR2JMTHROUGo5YUpWV2Q5MTJCL1NXMjNnNDFXR09VNWdzYXRJbnJTSWVt?=
 =?utf-8?B?RGY4Ym90UlowNEpVWm8rS0cxKzFWR2p1dFdOWlBjaThRSW1vZUNkbldxV2Ix?=
 =?utf-8?B?dFlaSU5RbjlINWZ6N2orbmw4WjkvK1BsV28xSjVwVWRGWUlyY01MTkFhMDYv?=
 =?utf-8?B?MFU0WHJtTlNWNWx2NG5qYXk5eTZVaWhJK3NNWDlNRndQTHJDZ2NSUklIdmIr?=
 =?utf-8?B?OVVsYTRxbi9HVldYcXh6cnJ5SVBxR01lbEpDN2VKbGJUY3BBK21lV2RGV055?=
 =?utf-8?B?SHhjbEdyUld0Y25mbVNJdkk5YmRab1ZxeGduRGZKWFFwQzNWN2xMUDM3eFhS?=
 =?utf-8?B?aFQ0Y3RQcnhudXVRclVXdXRmaGttN1FRNWNnMnFiSHp6Ujh4NS9xS2Mza21J?=
 =?utf-8?B?WW5QWFFSYzVsQU1zNkRLNmhHQmZGQUxSaUlHY01TMzZqMEhFYnd1Y0VqMXRx?=
 =?utf-8?B?V0xXb3NsYlhPd3JrTkhVL1YyRURVVDFLMWdMNi81c2c3R05lYWs0RmEwWnMv?=
 =?utf-8?B?L2NmRmp6dGZMMXZ5Sk5USFJQSDlWQ2RQbUtKZjI5ZmgvUTVydlFOL0NXZ3Uv?=
 =?utf-8?B?VWZtSzBCR2F3am1aQkxWeXpQdmE0U3Z0SDI2MXc4cWJEZUZUTWpibUFVdm50?=
 =?utf-8?B?RnorekJCT0tTSjUrZzM1TVliQlg2M1R5WEVXN0lVSDRLMmpqWFBsNWxIc2tE?=
 =?utf-8?B?Z0wvZ0pHS0MrN2dJRXlNQkhvZjJFRVZjMWJPWDZNZFFmaklXWDhqNXpSbkFW?=
 =?utf-8?B?NUthdmZESlhLQWV3SnRHZ2ZQOHlLaHFybEhSNllYRURpdTdVWWNvS0x1R2cw?=
 =?utf-8?B?RFMzNVp5L3VPd2JRVXFxbEplSC8zV04zK2YwU2VWOExWYWx0TTZXS2VNNm11?=
 =?utf-8?B?MjlMUHE4Qjl6eWpmMlRPbnJUWFZmeW96UExqakE5M1pyNTZ1cjVYdVQwTUQ5?=
 =?utf-8?B?VkZvUXpUSmxqc0RDMDQzNFBYMk4ydmdXZGNETGVHNVRXNE55Zzdzd0EzdjFJ?=
 =?utf-8?B?QlhkcjBpMit0T2dPK2RJSHk2THh6N2lCS2svQjlsaHVZTUxZb29TWjR1OXN2?=
 =?utf-8?B?cEUvYXBoL3o4cG4xbXNsdkJmdDdId0x4VWFiaFBzVGg0Sk5sb3JzTEViVTJI?=
 =?utf-8?B?TU5oMGlvMklMVXhTa1IyRFMrTUZ3T09yUHczei9ya2JvNnV0eUhBOUdhcjFF?=
 =?utf-8?B?RU13WXZDc2ZqVnVXRDREMFlURnlwenIrUHk2MVE3U3EwVEdHRnBYWXBHWkpS?=
 =?utf-8?B?T3pxdmYvMmNIdUQ4bmZlcG5heG4wNXA5THdscjFpZXcyZnJLNE50QXhFK25m?=
 =?utf-8?Q?omQZ4YpqkPXSg9kBuzJVNZPj4?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33c3a69-efca-4fef-a7e1-08db9c912cb5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 06:39:13.9188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Goi72gu8lEZLqihBFlthUZgSbn3XE3O9+9wTn1A38p9lGwqwMjxBhoAxkuiChfXjXW7xiLAt8o3z3lrqGgPEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7489
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.08.23 г. 13:45 ч., Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Skip the srso cmd line parsing which is not needed on Zen1/2 with SMT
> disabled and with the proper microcode applied (latter should be the
> case anyway) as those are not affected.
> 
> Fixes: 5a15d8348881 ("x86/srso: Tie SBPB bit setting to microcode patch detection")
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>   arch/x86/kernel/cpu/bugs.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index d02f73c5339d..8959a1b9fb80 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2418,8 +2418,10 @@ static void __init srso_select_mitigation(void)
>   		 * IBPB microcode has been applied.
>   		 */
>   		if ((boot_cpu_data.x86 < 0x19) &&
> -		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED)))
> +		    (!cpu_smt_possible() || (cpu_smt_control == CPU_SMT_DISABLED))) {
>   			setup_force_cpu_cap(X86_FEATURE_SRSO_NO);
> +			goto pred_cmd;

Actually can't you simply return, given that zen1/2 never have the SBPB 
flag set? Only zen3/4 with the updated microcode?


> +		}
>   	}
>   
>   	if (retbleed_mitigation == RETBLEED_MITIGATION_IBPB) {
> @@ -2696,6 +2698,9 @@ static ssize_t retbleed_show_state(char *buf)
>   
>   static ssize_t srso_show_state(char *buf)
>   {
> +	if (boot_cpu_has(X86_FEATURE_SRSO_NO))
> +		return sysfs_emit(buf, "Not affected\n");
> +
>   	return sysfs_emit(buf, "%s%s\n",
>   			  srso_strings[srso_mitigation],
>   			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
