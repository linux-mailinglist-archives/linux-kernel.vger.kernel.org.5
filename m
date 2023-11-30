Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65EC7FF433
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346484AbjK3P7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346478AbjK3P7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:59:33 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDB410D5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:59:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EuhTBtzjac2K7w2qXhiqdhKgSm/mHVccg+apFxvnz6/XblCUnDOBkojhUU/rgEny1n/Gj7nIAbSRmEget5WBIMtVhtPNqjOyTGqbdewJhgRwn9mzv3wr7eItKMtjkWgCZKDGR79bgfLDO6CVQsQ34XWLpr2R+PtQ78jryjp0CHF2vCzjYbdfFSWQdi/K6Sx2cfIpbX7n9HMV6mXkWbqufnQVZIaXz/IysYgA50NTgJ/grY3FR4qKnpNF3hk5y/sSBsnO64rtojmFIbYrOC7Ie1c5Pgt2Fki2liKirk7IWk2G1QqmlILsKC39d1+10g94GtCh+jd8O/mwL15Segy5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JjQnX4j7SE98pk/4eH6RjzyJOwKfBttdbIn4AImRFQ=;
 b=ObVdbZgWYVZFtMhiFXu2pvqq+HH59PsOPBsVOgKBSspR5Cf2AZ8w4sEX+TytP49nYscmWNL1Uv6GJI1Uhm6PLMU1/BrBFoNnenb36tyJEpokHjS9mMoblR3kfDw6YxpPVojQR3aiejLOfD7yB433QoXOiLa2nCzsgI27wm7TdO0T84xMSk7UwwPYaQiftL342P+PcKViI6Ro+jPomV+8m4gQoZo88sXYdSn9AsBryrFGmqnOq8V7X4PvD6ccDVXIRBTSm46p9Io/viEdJhQCAOkdH+uYhPkozvhit9PG097y04euqdzPiwFuG3qZTTV7girrciWwThHQx5SKawG/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JjQnX4j7SE98pk/4eH6RjzyJOwKfBttdbIn4AImRFQ=;
 b=YsZWxB+3mWoSHpa8dH2s6lapN+hPdvZ4lOvPoLYPVhAZyZnzVYCfo9yzPBWPqfpndQo7D5RjcsM0zjVaoMqS70zqw/CpS8ny8BNp3U8UcpGgTZvHZK5GeVi8hPu/u1nNx9ZmBBWRxzt8F9T7JXmETBKse9gVhiantAwsAe3bz5rwL47gJ2If8UZ0pjBm4TaRSwRc4yHE8+MDsDeMpKdDjNYMSuRgoRzUb1lvv7Bt3bv60w6dDIuNw7C/kW1+Q7u62a+GTh9fhx0UObaH57hIlgT0qCZBjO6pEjoghK+A3NvYzZS/CfX+Sw6Xo9osCRJQJvK2YMBx79wPN/NwV7L3kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DBAPR04MB7288.eurprd04.prod.outlook.com (2603:10a6:10:1a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 15:59:36 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::e665:a062:c68b:dd17%3]) with mapi id 15.20.7068.008; Thu, 30 Nov 2023
 15:59:36 +0000
Message-ID: <12a5af2d-c58f-4b4a-a994-49a935f59693@suse.com>
Date:   Thu, 30 Nov 2023 17:59:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/ia32: State that IA32 emulation is disabled
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231130155213.1407-1-bp@alien8.de>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231130155213.1407-1-bp@alien8.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0271.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::38) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DBAPR04MB7288:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b9e533-3926-412e-0905-08dbf1bd59b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jH3LHQSteqOBJlY4YBkcSkPB9GLlyrzFtSzy6ULJRmfRwcjCqLLPULm2yo2lfELDp62eevrp/duQPBnP3icWvDtTD/SLsrlGobVkYlOqegcXUqLolv1LH2MhDvX1NSLUQ4zuk0QXjiI6cmUMW67rwNViSQ2/p7lYpLjYkQsXPaiwuBdtw/Jiusz92hVy+1Q5r6aog8ufQ2cNrEGmei57Ad9A4OdLXC5xgONKUVCAL3mMSCV03LjgSifWtXuXdTUiD8uS8JF0TqI84WKiXOyzZr8EibgYfHOskX4gBFjA0sivBjcbeVraqv8fyHVagIfTIV5xlYZnb9tOOMG1oMdq0U5MIVWBIW4eyCO9hkcnaBJteXjBHyi/ULHEot6kGA5O0IXaum+8xCdJO26ra9FQhTVyrbaYSMXT33Hwv1pRappsD+7DEpoZwwh6fU6KIkiSk9f1yFQ8IrUnCNDQzV6gKRaULceTuEkerWF/O4HO4GLa8/fDnHyX1b1TlFAkRyEFyNpev+46g/bXr+sCrmVtmsBWm2xidwMSmspQyzwqi5w5lHADXmNzhdZkahqfBBR9QceNbzy1/3/6PFemN7wTYs/Mnkv4cKI7icjC4MxtqguUA1+1kmoS2tAkx9HbDi3YgmkVzazSErqNIzn28/fm6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(6506007)(83380400001)(6666004)(6512007)(2616005)(41300700001)(478600001)(4326008)(5660300002)(8676002)(8936002)(2906002)(110136005)(6486002)(316002)(66556008)(66476007)(66946007)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXhZcHZmUlpCOFNXUXYvSlExU0Q0ZFVhWHZRTUZ4NmxwamZqRVFtWnU3cHh5?=
 =?utf-8?B?SXlkUVExZU9nMm9qZHl3bWVBYUVoU1c5VXh2UGxJOU81MDBDMGZIdU1MdzVq?=
 =?utf-8?B?V0REK1RrNFNxUUl6VVBsa1hnd2JlcGVsVDJIYlVuQ0NwOXI2L1h4Zi83NjNP?=
 =?utf-8?B?OEg0UzlYNHI2S1dNd3JtdEpLSEJ3WVBYWVB4SEdUbVBsUmo5eU8zaVhSajJ0?=
 =?utf-8?B?dWJCckNFWER3M3dKeWIxOXlyNjJZendKcnRSbnp6aSt2VmRSd3gwTW5Da2pw?=
 =?utf-8?B?ZkhSRmtGL2pqVUNldjVNOTZLOXVJaW5YenNFcXcyTk9HYWlPMVQ2RWwwcUJt?=
 =?utf-8?B?bjMza0ttOXNNZUVhVGdLMmdSVDBFVzVna2pBM3JRNGhuNkg3S1lHdmYraENh?=
 =?utf-8?B?aEdPQjdiVVlKN0UwZkYyT3lGWndIK1JheXo4OFEzSEFEREN2enNlYVZMRVRy?=
 =?utf-8?B?VjY4ZklQUWdVMk5Vb09mTDBySncvYXFFMUdXWG9hMXBTMGdsZmRTK2tDVVNz?=
 =?utf-8?B?aHMwSG5FSUFQVkhPMzBoYXZzNC9RaEN2ZkJWUVl5V3dEdytZZW5sVkJNMk4z?=
 =?utf-8?B?QUtyNHU4YTcyK3JSZU5XT2RhOGlWendPUjE0ZjM5aGN4bUozSU41MDJCa3FX?=
 =?utf-8?B?MjVuRHE5ZzBYSTdwMVJrV1kralRXU2hORS9uakNTT1FkbXNwazhGN0F5M0tW?=
 =?utf-8?B?S1lPd2Fha0Z3UmlUUDd2VW9FM2poUm9JNlNOQUU0Uy92WFJlNHFCWlQ5UHZq?=
 =?utf-8?B?SFBrK0Y0SDNVUHVwOE5sMk9BV3o4K3NJZTNPWkhxT2pZSUYrc2VpMXgzZmRt?=
 =?utf-8?B?MHQvR0xQTDFxWU5aVjNvZHRGWGI3YmlqQkdYRVZmOEc3N09vS1QyNVQwUXhZ?=
 =?utf-8?B?cHVLOGlUYVpUSEFWaGkweWdwaEJzWVVRdk5vSGtKZVEvZDQ4SWNROHdJVzRW?=
 =?utf-8?B?VmlWa1FuMThJcEgwSzBodkw1VTJ4cGdMalVuTVR4ZmQraWJDamxaUEpWbWdM?=
 =?utf-8?B?ODhtMy9TajRDdXpaanRIU1VPNUIyK0dhVE9PdDdsMGptZG1UWTVRY0FWMmdE?=
 =?utf-8?B?OGxxTjVFK3JZcEhkVXdUL0tuRkZnTHhJWFJSVU1RMFNPNTRCc1VrbUpJYlpq?=
 =?utf-8?B?TGNIOWlENDNlUW4yeC9oeWc0Q29DYm1oRTFjMmx2WUdKWDB6Q0V3VW1PRDlQ?=
 =?utf-8?B?dnQ5RitOeXJWWTBPMExKSytMd1BabjRaWTBnVXdSNG5CcVVrclNLUlZNNFR3?=
 =?utf-8?B?d1BTQWFJdmFnRGdwVVRrL0w1NFlMRDJueDhVYVpXdWRPY1JPK0xnOGFXeG9F?=
 =?utf-8?B?OENnb3pOL0pFOGJsMTI1OTlEMzRDd2M4djRIaGxJdVR3aUJJTzJuS0wyMTdt?=
 =?utf-8?B?OFpvREpKZXk3QUQ2enowOXhpL2hteDJpVk9OZEt1TW40ZjBHN2c5T1dRc0RT?=
 =?utf-8?B?d0xFUkk3K1FyR25FdFNkZGFxNHNDVnNPS1VOeHluc3dFZkFtd2s1UlFKR0VH?=
 =?utf-8?B?Kys5VU1MUGp5cnAvN0NFUU1MNS8rc2V2NGZyclN4WUNKU3RvYVZFVXlUdlA5?=
 =?utf-8?B?bXFJaHByK0pCUlEwUks2WFFsZGh2QWR3cjFJNk91ZEhNWnhJUUo2S3h0OWxh?=
 =?utf-8?B?VlU3QXlBTE1NdzN3OGkwZGV4RmV4cjBUbUtPd2hSeGNEcGhadGo1VWM1cE9W?=
 =?utf-8?B?SDFaVnBpQXJxbkdPbDlMOGptU0tlMDFyMjI0L3lHMTRKL3RIemVlYktIcTYv?=
 =?utf-8?B?YWJVR21GS3dxMHEwY0pKOGZsaFo2c3M3STFwOXBkcmhQcENXb3pxOVZ0MWJm?=
 =?utf-8?B?Ni9XU29qRFdlNjlPMmlNWVFacHpsVUlJLzgrV1pHL2laSWlxUWx0NVpreStm?=
 =?utf-8?B?dEQyWDFBOTcxWFZhWWE5Nzd0N0wvN0hiZUdOSml1MUIxa2ovMnVsR0xKcXNB?=
 =?utf-8?B?bHFMd3ZWSHdqNXZPU2pHU1l3Yzhuc1AybVFuTDdUbDZtWSsyZ0dXNHovQzA5?=
 =?utf-8?B?b05IU0N1L0JmVkR5T3VMVUJzWW0yU1NXd2JraHJNTSttOGpSdlZqL3BZbThC?=
 =?utf-8?B?MTJGeFMrQVFNUm5ZdkZGOFN4N3FrYnZaSzl4R05nWVdPZmtmbXQzajJLSFFH?=
 =?utf-8?B?NnBNMFZIeXYzNVh4bXpMTzd4Z0RaU0tKNVlJcUs5SVpibm1tZEpFN1VsMkdT?=
 =?utf-8?Q?QMjrE52VN3+tHdZ4d99YfsvNDWaX9Lp6QbTJ31nvFrcZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b9e533-3926-412e-0905-08dbf1bd59b9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 15:59:36.0906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URjkK9cL6BiQlehellF99sUrLZEa6JNZ5cuxCXz7r+Jc+RGO3WrXaOrFk89T/UYg3RTsiZIrngjVBBEgSFFl1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.11.23 г. 17:52 ч., Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Issue a short message once, on the first try to load a 32-bit process to
> save people time when wondering why it won't load and says:
> 
>    -bash: ./strsep32: cannot execute binary file: Exec format error
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Nikolay Borisov <nik.borisov@suse.com>

LGTM:

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>

Would have liked for this function to replace the non-verbose variant 
but since it's used in syscall it might be easier to miss.

> ---
>   arch/x86/include/asm/elf.h  | 2 +-
>   arch/x86/include/asm/ia32.h | 9 ++++++++-
>   2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index a0234dfd1031..1e16bd5ac781 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -150,7 +150,7 @@ do {						\
>   	((x)->e_machine == EM_X86_64)
>   
>   #define compat_elf_check_arch(x)					\
> -	((elf_check_arch_ia32(x) && ia32_enabled()) ||			\
> +	((elf_check_arch_ia32(x) && ia32_enabled_verbose()) ||		\
>   	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
>   
>   static inline void elf_common_init(struct thread_struct *t,
> diff --git a/arch/x86/include/asm/ia32.h b/arch/x86/include/asm/ia32.h
> index 5a2ae24b1204..43e02b52ad19 100644
> --- a/arch/x86/include/asm/ia32.h
> +++ b/arch/x86/include/asm/ia32.h
> @@ -2,7 +2,6 @@
>   #ifndef _ASM_X86_IA32_H
>   #define _ASM_X86_IA32_H
>   
> -
>   #ifdef CONFIG_IA32_EMULATION
>   
>   #include <linux/compat.h>
> @@ -84,4 +83,12 @@ static inline bool ia32_enabled(void)
>   
>   #endif
>   
> +static inline bool ia32_enabled_verbose(void)
> +{
> +#ifdef CONFIG_IA32_EMULATION
> +	pr_notice_once("32-bit emulation disabled. You can reenable with ia32_emulation=on\n");
> +#endif
> +	return ia32_enabled();
> +}
> +
>   #endif /* _ASM_X86_IA32_H */
