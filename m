Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F48876EF70
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbjHCQ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbjHCQ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:28:34 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDF944A7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:28:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VorjOhtVgEUab0NUv0/JJ6qBoR1UPRXS3Gx6NjXRyH3m8CA6xfHZsk2uJjUby1gznOLddP6hFkIXVFZx7fqBLzHWsYwr9J1RgXqV5upSlFZ/B36egZkWw226MkvR/rlA027Z3I7ehwbSyiwNoMjtAfEi+lbACRq59pw1Lycr5jnEzA5MJnQyXu506Pz563ysGqzh+mciNvZFyNrKbPgCMI/ycomi30tU0k15l4wAw8yedcrNYjl5bFB8b33Mm4G6flB49d1y1dr8oD85iHKzOVBW1Vx0cJNQTMCOpm3Ea59Hu3osHc9fFEUTtUa078Cq25bArPWTLEjn/jGT8faWCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHNKzec/qiPyNOpOXM8i6lcnqCIoWY4yvUzInNiJz84=;
 b=UuYEofKf3MiooY9e9m2fpFcr0KksQ1ls72HLqZPBqz2uiGKwTKG3NHkoWlrFLSSBQs/0NFNXV4od59dOqFElr/sh08y/x41hfE1nYE34sWqQiZbn1qFW7GBhWAroz/DmM4m4YAtTSuGpEZVLencqLDJxF6UuA+t1U55nRtSdsdz77wUjIHqjLvafoXK1eZbqoeRjFNBy/FstLDjOI/C8obWdjBfkLZGsGgAQ8tzr0SvK3OUZK5yDwoZ1C5rKqsq8iIokyeKdKfdBE+SZ7QLocBfJ44ZDlhsp68BfzEBaLkF64rYwTNJVatdZklVipe/leKHWEHro8uoqstTJimWFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHNKzec/qiPyNOpOXM8i6lcnqCIoWY4yvUzInNiJz84=;
 b=0HpQwEuwaj5FFGTTEi7n3ZG6L3tJlU21Ct7ANONQh3lJoksGIMP9nsIAsO61Lis7MtiL/j8/K/nPhS42F97v01Fa9HpohIJXmQOcJmZK8uCIZUVRnr/U751Ah46FV3TNlyqvYZi9khei9LMjkzy7fFXMqIQAepuedNHszY7/bhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BY5PR12MB4854.namprd12.prod.outlook.com (2603:10b6:a03:1d1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20; Thu, 3 Aug 2023 16:28:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 16:28:19 +0000
Message-ID: <a34b1c3c-6fc6-d762-4139-bcc397a00f3f@amd.com>
Date:   Thu, 3 Aug 2023 21:58:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/smp: Validate APIC ID before parking CPU in INIT
Content-Language: en-US
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de,
        mingo@redhat.com,
        Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
References: <20230719051302.15801-1-vasant.hegde@amd.com>
From:   Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230719051302.15801-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::28) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BY5PR12MB4854:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d818a53-7f5a-4653-b977-08db943ea56f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rclA+oiUvXCHagDOxuwxEG8QV9vi7M4JTduRxJ8euOpjnYO9V6AuWlAMCHQRwMLNtkbZhEqdz1jx8ucyq6E+7Yz/Fkj4nUtkIm+gJx/m4MOChHv3ls+lwdOEiFx5XTa4a/Gw+Ug/ScMI8ooOoZ+y/e/WDn8qT2BEykAzoGG7lscTgM5qGiJyHN4XcC2TLB4TYyv1wuwddISZuajRjPtruScRSULafqZPubHOzHp87DkRps3IqLxNsnn0ZLOkSqhlHDCv0n0t5EdlgkLC9HRaC4ZHzEI/SGn/x7VyDg61dYgBf+kksveBXE9KCC/zIeFwez7RQ+uQWZyixfZ/jqXhJLdh2jGKXD3eri6j1H+zn0O9daz0Atdcf9Hvs0OXTeKR3cVevfiFob0J2yjDY5UlMJIVK3HnEpbG/hk+xDoyVjlpf3jRpKBsb36emVX5vfuXV/K31vXDYu+qftVakKBsY1dPG0BpvtV/AchlBct8zcpNL3n4ZIu/CBO7gaDhaujsiVEZ9T55nkRcL5z7BlauyTq4pqtfxqmsG3jpFhtEfa7E/mW/HePpozY98/PL8qmRSnYGqRVSKZuCbHOfyts6XoE+R2HR49EWGkdFtifiPCzRgIsQ7g3gSmkeRaRwUd8OfoB8wrLvObHYJa/D3A8vFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(53546011)(6506007)(83380400001)(186003)(26005)(8676002)(316002)(66556008)(2906002)(4326008)(66946007)(5660300002)(66476007)(41300700001)(44832011)(8936002)(6486002)(6666004)(6512007)(478600001)(38100700002)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qmd2S1VXNlk3eC9aTEt6WlVxcWttWDZjY1dlaHBoNlRNSEZCMythdVNqbFc3?=
 =?utf-8?B?MklZZUZjRitCOEdYNG1jbUhtTmdBZ0JvbWhpc1J0VmF4MDEvd01qUHZlQmhi?=
 =?utf-8?B?WkNzQm1EdC9QSWtSRGVhamxhYi9hZ1paU2l2Ymh2YjdrQmtCWmFtOGQrQklC?=
 =?utf-8?B?bDY4aytxdUd3eG9nNW9HQXBCSXZEdUttSnBmL1liVzIzSXd3UHZqRFFQZjhy?=
 =?utf-8?B?K2FIMW9XSGhheHA2REdSSXEwbWdKZnltUmhZbGsxNjg3MnduMGFXZkJyVFFm?=
 =?utf-8?B?RlZBQm9BYk0rV3JnUktJajJsdmJkZnppc05xbWRpSHZNUGl6eXlZamZYakxw?=
 =?utf-8?B?c2dsM0F0TjE3WmV3NHFDdE9wK1plUGVnS3NZYXU1Nk9EYlFwUHU3eWdNeGd1?=
 =?utf-8?B?ZmlKcjBQb2NpeHhOdWI1bkl0UE0zRXA5M05ObE1wMXg1TTVaaC94RjQ4c3Fi?=
 =?utf-8?B?aCs4Z09yUDhxc2ZucnM0UjFQTC9ORWlqdFVncHRxSjd2VTNKMVpobm9xcVBp?=
 =?utf-8?B?ZmZyc0dhV2IyWms0TUI1ZjJVcG9XU3BmZ3o1bFlzWHpxM0R1TlJ3UkVjd2Zm?=
 =?utf-8?B?T0xIbXh4TTFyU0dwKzdYdlJyMUtndDNzbnc1azBIZHpYaWJEUmU5NFdLYmtT?=
 =?utf-8?B?WHdJbFRlQ291ZEg5czVaWFVlNEg0MU5zMVVSVW9yMGNFTkVRMXZyUjBybzhQ?=
 =?utf-8?B?cmZ2b3JCUUVYM2V1RHluZnVHR2phSmJxamMvRlRJdTNsWGNCRmsrTHA2QzRr?=
 =?utf-8?B?MHUyMU8zT0Z2NXE0dXZURlpDTWlCOFpWV0NRQTdUazlPYmlKb0dMVERXZFFX?=
 =?utf-8?B?Z1ZUdnNoZnJZOWlmMjBWRzBJc0VUNVNFUmUralNobHdlODQ3ck56czRpSkps?=
 =?utf-8?B?Q05LSHc3dmM5RmpZVUluaW5rOGo4Y09DdWk0cmFDWHUxY1FzeFNUVHpPM2sr?=
 =?utf-8?B?ZWNST2FvcXFpaGpwMTA2K3VXTFRqUmc5V1BiOGUrdzZwTE0zMjJrWXBBS3My?=
 =?utf-8?B?bUVkZ2hMQTN6cVN4QW9VOWQ4clNONWpjRUhFdHhVZk1La3hiR0VBSkRoZHM0?=
 =?utf-8?B?amFPUTF5WmlVeTdVSTBjT2JVOTRwMGNUdDA4b2huUVMyNzZxYm9ZY3JKWDJU?=
 =?utf-8?B?VVAyNFZUY3FXeW1uakpoVnUrZ1huTzU2R01UYUYzczAwVlFXd2VJOW1LVjll?=
 =?utf-8?B?aDZnNGZTOHh6ZFkrbVNpOENSSWNQVDNRYm0rSHk4QTc5d2xvS1dmZHdCaUIy?=
 =?utf-8?B?OTMzQy9vMndDMUdMVVJJaUE4WWorWDV0bW9XMkI4MEpIVzhpQXdka0RIcmdh?=
 =?utf-8?B?SUVCSDdMdGY3ZmJmZ3pFWXFBT0RTb2R0YXhkdlllUSs5Z2JIZUpkeFI0QnIy?=
 =?utf-8?B?cFlKc1R2c2dPWmIxSTRXNDR2T0RweDU4dHpQaFpqRzJ2M3l2MHlSVzNpbjhj?=
 =?utf-8?B?Vm15QXBrRXcwMWlaNzdaTUoyVWtyVXNSenNTNW5ndWpuM1Y0WVhla2c3ZmZk?=
 =?utf-8?B?ZEsvd1dQOXZzR2tMbVp2M3ZXQWlVV0hkNjUzNWR2eVpwVUYvM3FRZG1sS0E4?=
 =?utf-8?B?NjU1VUFibmdJakEwVXREUmEvV3JacnlmeCtCL05uTFBBcjJielk4WklnT2Fv?=
 =?utf-8?B?VkNLd3ZoZ1FkMEJ4Yng5NHE1MDNPaUdwN3Y5UDRLaUV5ckJ0ekFHWlZ2QnlI?=
 =?utf-8?B?Y21uRGEzajVuNzFUSzhOUS9pQ2g0dEFFV3BxVHNtRnduYW5kQkpLWVViQ3RL?=
 =?utf-8?B?UTRyY21wU0V1YTF4dmN5cUtteVJvZWQrUGt1ZzVTcmNobzBhRzhMKzdSNlVG?=
 =?utf-8?B?MVh2VlJsem9qeWU1NVBOZzhmdFpMZFlPSHNlUHkxWUhQMWVmcjNOMjQ0MzJF?=
 =?utf-8?B?SGNNT2RVaWFjS0o3VHU0MkVTeXcrbkUzWENGMVUreTJjb3ZpOUV4Uko2UTRH?=
 =?utf-8?B?UzVlUVJEZytXNktZNDZmeWJ1bnI4U2Q5M0VwT0pFRW9yUHVuaDUvZmc1d2lM?=
 =?utf-8?B?Ukh4WE4ycllicnNYMUpwSlptY2Z3T1hUVkY1UStwZGVJcTlZYUNMU1Q2RUtB?=
 =?utf-8?B?WURjdFBlZzh6d204R1prMVFEb1ZXTDZDaE85dUZBT1BVa1RiZnQ3K1JmMGxD?=
 =?utf-8?Q?R87YBoYE1FvkCCAsQ6PtD/8TU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d818a53-7f5a-4653-b977-08db943ea56f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 16:28:19.1696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fgVviyJPK+rhQp4kQFWLiQFkqXaI7mx/UUIo3oeqEOGVPwN12arP1KWVGVNC8AbvXWPt+lFZLAepSUB/Ny825w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4854
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Did you get a chance to look into this patch?


-Vasant

On 7/19/2023 10:43 AM, Vasant Hegde wrote:
> Below commit is causing kexec to hang in certain scenarios with >255 CPUs.
> 
> Reproduce steps:
>   - We are using 2 socket system with 384 CPUs
>   - Booting first kernel with kernel command line intremap=off
>     This disabled x2apic in kernel and booted with apic mode
>   - During kexec it tries to send INIT to all CPUs except boot CPU
>     If APIC ID is 0x100 (like in our case) then it will send CPU0
>     to INIT mode and system hangs (in APIC mode DEST field is 8bit)
> 
> Fix this issue by adding apic->apic_id_valid() check before sending
> INIT sequence.
> 
> Fixes: 45e34c8af58f ("x86/smp: Put CPUs into INIT on shutdown if possible")
> Reported-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  arch/x86/kernel/smpboot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index e1aa2cd7734b..e5ca0689c4dd 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1360,7 +1360,7 @@ bool smp_park_other_cpus_in_init(void)
>  		if (cpu == this_cpu)
>  			continue;
>  		apicid = apic->cpu_present_to_apicid(cpu);
> -		if (apicid == BAD_APICID)
> +		if (apicid == BAD_APICID || !apic->apic_id_valid(apicid))
>  			continue;
>  		send_init_sequence(apicid);
>  	}
