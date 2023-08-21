Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D68782342
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjHUFmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjHUFmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:42:46 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2059.outbound.protection.outlook.com [40.107.14.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C43A8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 22:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoaN5nY13KanpYOkeM97kKG1JK6yrnp8o1L3hyKtyBAdld7ciJE5cqqWDUm+LPqIOOT0f8F8rp1NV6RbGeYWQ5XrYCDbhADRRLAJ6v5W5xiNEJvAFVwWbw1a9tPy0Kw8EqlXabzNZN0yH+zcPh6ZDmv/CU/iSoQRdTES1qnJ3V2ojU8XohzvyuHSOL/4759R2cO4IZP9CmnByCMDgiZ7I0le3k9Ei+gdoUnLkX4qMKY5g4U9K3pnX1+ykP2aDMWdfqX/n87wwE+5mgidupmd9j0OnVRGDDI7Tct9fAgRWg+QpKz7/3jOe+vpqZtIFB6pCQ6rYFUColkxfeuLo0Z3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOWdLOa43h+lnaADEK3STnF9h/zO/MQ6Aa9OQvxhFys=;
 b=kZFZDHdXFJZU1UixJ6EJqpHO49CqkUlAYx/Jam+NOhs9o2nyQABPstlGF+2ZOQ4y57WHEjbEAYFi3eKCWbks7XmXdlYbV8C6Sr6dRMZznhAebRG3BAPGDU61JXk5XKa4gECniF7C3tEyuZj0F/5+QQXMUxD0RqI2qUFezD2paFfT22UD8Wg+CTrKvx1/tBTAh0faTOJwBSyEEc2stIWrVz02cnFgvAoC5fIoFc3bfbWr80UOCi+ZQh34XhQUhG0m1kComywXL3gaShuYhTLoBpuRdR4vtp2fU/mA48j/3r5xGikFOi4XMzgZON/pxgfb9tfHChcQ5OLN4J1Nz90FFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOWdLOa43h+lnaADEK3STnF9h/zO/MQ6Aa9OQvxhFys=;
 b=EKH+Kr2mYovZLQXbtYgJ4xDwEMSB5WXBuhzDP7XjzQedOMEbWbBYUvxbnnqHBi0o+0LGokGI2M+3ku/vaxdgJDqPlfaZ6UeGmyescvYSn+jg02u1sbaS9TbpEsSBM3xjCM/rm71eU1gWh+TQllWjZ49xawVzq0xJF5krIC8v8m5TIwXIDfu+D6gip/te/GY8LI06pS8+P17j9mzhLtG/dq/pzIuS0oerLjnZcOAUxYdCXgf0jqSAGfy8yD/NjcfhRMJ9mSdDOTzHOMSC5LV8VzddLYp0hd9B+YGXV1bhER+8b8udcX6ptKixvAYwE2p5bSdF6aN/WAYcvSM2cweNXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM9PR04MB8083.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 05:42:42 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 05:42:42 +0000
Message-ID: <d0cee6c4-5598-3b69-d99b-6020fdd67f51@suse.com>
Date:   Mon, 21 Aug 2023 08:42:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/22] x86/srso: Fix srso_show_state() side effect
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>, David.Kaplan@amd.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
References: <cover.1692580085.git.jpoimboe@kernel.org>
 <fc64c4e5749d10b398c86b60902d6f9394eb5012.1692580085.git.jpoimboe@kernel.org>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <fc64c4e5749d10b398c86b60902d6f9394eb5012.1692580085.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0250.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::17) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM9PR04MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3eb5d2-acd5-4767-50ef-08dba2096fec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOgKnqHok/IGvdp4A6S7e4GG1TzyB+eVovqB5AXiD6getvgPuVsMCdWMztSD+eP+kE82knUGQXla535CKWYJo9Ubd5KWrwyeKoAsOsZwj8BzzFUOREMuzmUH1KN8sONc1JSKextkAbiEmpVSRL7nJooCgRZuXSn8zLFtBkHPuQ5AZKXrhzj0q6MoVJDxoj9/CaHfxsl18N6w0iP2+7bDfAHTN/5b3Za7r7LklPzrvGJ6x5Iin/tHcbirmJ80RPQXaYHGeKO/csbWSsHFrHYqsOxcPJb6gUsdOOmZjvfBBTI/6JOzDVMBzBUvNUgDDO2bUB6av+i3iOiEdJMg4/52JWC0EE7QE5cvyNrpNtGlLeEshX+frDehnklucUkC0YfbXSp0fxQOJ92vxYiJDpWSFAxeHG5A780XdjNDUdnbssjUAb99+d2ABGtfG9f6E/WRmp9+ldmUkWXanDvDlfSsXOYh3LkapJf4CPRRagpYNg9LUsKeifWwYdqghDYYw+/PuwzhIz83II8bm0WwNk35xPjDceZhm1xi6V6hnRNaKtWEfTf14FZs3xGzcm6qfto4bXSvzze1c7fuiOl/9j753PkIYif+aW6kyydDReQ9FWXgcLpq9DQKTD5Q0t8JBFEk/bRDIpzkbKLVyaU/wJPcvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(54906003)(66476007)(66556008)(66946007)(316002)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6506007)(6486002)(2906002)(7416002)(83380400001)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N21DVmJHZW5KdnYxa3QwQnJkQmF6Q3FMODA0cTlzd2ZONFFNc09VZHpPWWZS?=
 =?utf-8?B?TTkweTlYRnN4MEkvNnQ1YnM5bTUxUjAveWUxTzMrY3FVTzJIL0NaYzg2OWN1?=
 =?utf-8?B?eGMvNjFZcDRibUhpQnp6alpKLzVaSnlmNGdnNmFvVnhtVTAwWDhTN3RGalFl?=
 =?utf-8?B?ZUpFNUMvc0FJV29ua2pOR0t1MXozcHFmWm9yZ2o4WVBSMGhGaWdOKzltOU9a?=
 =?utf-8?B?ZWYvQW12ZURmdFRTMTdxcGg0OWdlVHFUQlZDS1hUeVQwcU95Tnc4Mkp5bGhX?=
 =?utf-8?B?dFdHV1FOUG10U0JZL1g2VmtrL0wxU0VTdnlmSncvREk3OVpBTU1QUC82aHZT?=
 =?utf-8?B?VTV6NjUvTXcrMlNUaE9sTTYrZGhGemNlT0g5QTNNQ0h2b0hGem9ZQnp0Zmd3?=
 =?utf-8?B?UWJkVktRbWlOczdyS1d3ZXhrd3NPZzVXL1Q5TkZKaG9qcUo3T0lHdTMwV1Np?=
 =?utf-8?B?R2hMUVJaWUoxVy9ROWh6NUY3bXV5Rjlmc0w2c1F0VmRWQ21QT0p1Uy9TN2Ix?=
 =?utf-8?B?OWVwcWRHY0YwdE40Mk96ekJyakxZYURidmQrbkRUK3NtY2RyeTFUb0szMzR5?=
 =?utf-8?B?V0wxa1RIQWdNa21wVmFQN2c5N0NZNCtXMjlreklKYXM3d1E3WGZLTTlBU2xu?=
 =?utf-8?B?c2xtdlVpQ3ZzeEN1ZWp4ck1qNld5dEpjT0tGYVRuaDJ0Rm1MMm9zc2VXU05B?=
 =?utf-8?B?YlJ6b3Z2VEdlcXMrbVFzcmdVMWQraDcyNmJGMDQ5ZS9Ma0tpcnFTS3dlMkVQ?=
 =?utf-8?B?czhGd05kYmJnSWg3VXQ4M1JGNVQ0dExJV29RQXdGTUZyU21zUkRNVEgvRzRk?=
 =?utf-8?B?RDNiUXM1alFZdTAxMFZUTU44V2F2ZmtqOWJjQzlILzZZUklxa21zZVJnQjM4?=
 =?utf-8?B?TzFQSXBEbWFCUjhMcEI0M2Q3bHkvaFpQbXBvUHdLL3pIYlRabmpzU1pxN3F3?=
 =?utf-8?B?bCtwZ01NUUVxaDFrYkFFc1MwK0t3RldVdmt2akdId29mTVpPdDNwTXlpeFpu?=
 =?utf-8?B?YVhmSFZmMUs4R3pmRHFZZERXSHZYNHlLNWF5Wnh5QXIrNzA3UTk2MFFLN1Y5?=
 =?utf-8?B?SC9NZTBuZXVtb1lCc1FDSkU3ZDF3R01QRkZOWUxHNUJGYkFEeHhvS3h3Wmxu?=
 =?utf-8?B?WnBoM2R4Zk14YUV5dUtSOStMbWp3MC8yNisyTTh2Skw2ckNhRGlpdWRSblRW?=
 =?utf-8?B?TmlLeFQrOHdWSWJtZllYUTBnQTdyRGs5anBxVnEyREU5QlIramFuamFOVytP?=
 =?utf-8?B?ZFd0eUQrNC84UStDZDZ4WEpmU1grMHN4WUVQNzF2VUFFQ0RaRTAxSzcwem16?=
 =?utf-8?B?TjEvTmNJL0UyUDJBWU11YkNaZ2NFVE1SN3QwRDEzeERobHNOUDFpamgvb1NB?=
 =?utf-8?B?Z3NoSzFnWUpPSm1UVmZpR1V5OVFmcytTbU9Gb2F6eE1jQVVIV1NYd2diYWZK?=
 =?utf-8?B?OCtFLytnTENzbDluWFJXOGdCenN6RDRqUjhPbzllRHRwMERCVWkwVVRwZmFR?=
 =?utf-8?B?VDBFdmRiaVI3ZWVqNlNXcUV0V3FEemxPNU01QysyTXJjR0RqMXoyWTh2MlVy?=
 =?utf-8?B?d2xDR3ZBaXlNbFZhaTR2dnVnQldCV1pmSzdQY1FZa0JpTjhRZEJMKzlsaFZZ?=
 =?utf-8?B?ZWdYOE9hNGIwQmRqcW1jYllSZGpRMXA2KzBWOXBzK2xScStiSkgxUFFuOU5M?=
 =?utf-8?B?K0ZUMmxsaCtWSmF0QkRHOXpjbU5WQTRsQlN6Tklvc1BCTUNhUjFRN1F4d2Jh?=
 =?utf-8?B?WTZDQnA4UHdJb0R1QUs5dWhLYnlNWVRBV1A4VUQwZXVLWFN6TVVPSEdibGhN?=
 =?utf-8?B?L2Z4U3hYdG91YXNTYWpvWDRPbU9OaElidnJQUWJjU1gyMjErK2NOdGtydm94?=
 =?utf-8?B?Z2xEZDEvOFpGMVI4WmF6ekpUdDVZdW90ZlVjMFhmdDZTMVhzTXRmQjV5TkRo?=
 =?utf-8?B?bVNCV2w3SFQyZE0zSVFKM3l0aFFKNzlXRmVMYVd1Mi9kSnFQYTlDeWtOYXlx?=
 =?utf-8?B?T3hqYXlTemZ2QUt0VjlHM2FOY3Z4djF6V2tHY3RDdnNIT1FzckJQM0lKRTZU?=
 =?utf-8?B?T2JJeStrbW1sZWwyZ2ZjSkVKZGhiUXJta2RZQW1ZeUFHcmhXMFZlUDZuVjlh?=
 =?utf-8?Q?V0dvqlORU5Ze/7+YQkguUMlXf?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3eb5d2-acd5-4767-50ef-08dba2096fec
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 05:42:42.0208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xHkTxW2u+QuniH6OAVPbUjl4o/iKb1bftppZUnuh7GpiITVn1QUxDRLG5rE0LZfqV/jX4VK9F9qhpvb4fFfxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8083
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.08.23 г. 4:18 ч., Josh Poimboeuf wrote:
> Reading the 'spec_rstack_overflow' sysfs file can trigger an unnecessary
> MSR write, and possibly even a (handled) exception if the microcode
> hasn't been updated.
> 
> Avoid all that by just checking X86_FEATURE_IBPB_BRTYPE instead, which
> gets set by srso_select_mitigation() if the updated microcode exists.
> 
> Fixes: fb3bd914b3ec ("x86/srso: Add a Speculative RAS Overflow mitigation")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/x86/kernel/cpu/bugs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index f081d26616ac..bdd3e296f72b 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -2717,7 +2717,7 @@ static ssize_t srso_show_state(char *buf)
>   
>   	return sysfs_emit(buf, "%s%s\n",
>   			  srso_strings[srso_mitigation],
> -			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
> +			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
>   }
>   
>   static ssize_t gds_show_state(char *buf)


Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
