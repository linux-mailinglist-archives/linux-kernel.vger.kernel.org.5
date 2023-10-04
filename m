Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2297B8E30
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjJDUiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjJDUiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:38:13 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA026AD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:38:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaU8Griqzo0sPMVliAkIq8qsuN1atf+if25hZGJyBIprpAvJGdLth4LkspJZ78901JsAaeyR6eaPeHtLPKQhFZTlaTnVxbSw6PZudlbQjsUdYCwl+2BIZlx+UJuhbHK3hYjTpy6AFzbst+HPCOx4ZLUV/F08dE404PJkXkEJ/DKkx0LvYF0ylIz1qcRh+6AV/jC/BewkyJ1DuTyL9UMS+mbESascnwLIbbA7rC3X2zBQ4t98DiJ2BLhgNY3Rx/XCASqMNOS/BSSbG9dBWDs4JTbtFkDVVtvmvutMfUfFb+SHB0Dp+mv5oBYl5s8/gbbM6U2B1SYGG7g7d18p6FCvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8gcxKQOMsl+3C97OLuR1M6qiLqxigDXnQu7Sej+WRo=;
 b=iJ33hcdA45uobU5kQo0THXdciSJVydyeMNtDs4rGfGGAKXMD4zCZsoAZ1WmtZLZSZu1UcmwpSyU60gvKCxriJNy5sQ9RHeXhYawRGnjz2lnxVVuaLAoJBbtrR0EIuZKPLhGvi5glmm7GciUIbi7zLSFVfO3JgUTiI83fVDcXlUTrgGCR8bJMGWVnJV/WhsO/NYovVcOtuPGzLlV+4PHvP8FeWK0rT/ShyTbv+oKFVBzymyMZy2vjTeh4OzBOrPUC8q0Sh9nAF2baUYi6/nunw4fVcL3LChnOo4aTRm8w94kiIspKiWX3PjXXI/G/X+JMhz54fD+vMNGv74KCq6w5Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8gcxKQOMsl+3C97OLuR1M6qiLqxigDXnQu7Sej+WRo=;
 b=YZglqtlVu+T088yk3RYwqtT5x7E4WrhCdPt/R6zb1e61mgbWxQ7tRrK7TZDrXCGChXAruJu44a5AkI048G5vpTEHWJuwYTWR/KAuPakY2xbDedG0/dKzcsQc9dZVd4DbUFH27XQQlPocuOJ6tiYtn3xOCDwiVzUfJaCJqizZ2t4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 20:38:07 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 20:38:07 +0000
Message-ID: <b31e1fd2-31b6-4240-94e7-870bcfd51754@amd.com>
Date:   Wed, 4 Oct 2023 15:38:03 -0500
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 09/24] x86/resctrl: Use set_bit()/clear_bit() instead
 of open coding
Reply-To: babu.moger@amd.com
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-10-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20230914172138.11977-10-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0053.namprd08.prod.outlook.com
 (2603:10b6:4:60::42) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW4PR12MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e2fd09-9edf-481c-9cb5-08dbc519d0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fqhB8PTdBiMTXpKGb8w0zS2HwJdo/bsaLSCq1z0AtBmvAmhe/ozknbmx4HflGdfdE7aEobjuRUxM8mcRDR3gv1PuOrZwpj3p7KdMAj+d3bejAnEvQtPaRn8DY4B4vCXUdWqev7SgNxPCqVTMEZBzzest4NPCCt2XOWpseKYhWHY18e0YAuQj+EjR0SQHfrAhLg3+GaWs8ea0+uxjCFpIUxR2FAaisZYLbkwkXaL51NuPX7gNiUuOWEpnejhkxYNyCfkxFQz5nmNF/fpc+PxLEbV728qCvaQ2PQqciedWDFspgjI3wnOCH0yTN2ET2QF8j5gKtxXaT+wgTHQAXtlNurz93PLTfGl4SfZJk5JOApwzWQCoKu0u53tNc8BUE0o2thms5BbPk7vFn616kyGJjsNYOaOQBAFeOr9l1xAme0/w2r7lcKH86QtU5usZjVYdTXhKfByGOFQuDUc2ZiKgSue3sKFTL46wl/91g/R4hPB0JQhTvx2PxFoEUzpcelZAD2zOBQyviw+DmUddBfzebCF5SjzGUUCLtWUFTtsOB3gG+X1lxQ2jLuH6/lELPQ/vG7HFmg8pABPPhApZrMpSRRTXi1s9+Ru+IWlokT3NsmroVR7MffT1fNcJQQ/wk6S0s8hbo5dBUtR9hhVOnyvO/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(2616005)(6512007)(6506007)(53546011)(86362001)(31696002)(38100700002)(36756003)(26005)(7416002)(2906002)(3450700001)(6486002)(6666004)(478600001)(83380400001)(8676002)(4326008)(41300700001)(316002)(8936002)(5660300002)(66556008)(66476007)(66946007)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3pnWEswenBSQzJ2bXh1Z2N4QkVJd21HSGg4ZHUyaHFKcGo5UUhPUHBQbDB2?=
 =?utf-8?B?cjdXOU14ZVBySCtvSkp5T0VCdkZ0eldTZFVSclhTWmlzUnVCaVJXTlVBSWd1?=
 =?utf-8?B?ek5tOTM0QXJsWlNaQ09DaHFJZEpvZU5pa1diZDhSaDNqclVLelhpejdGOU92?=
 =?utf-8?B?bEY1SzltNjh1OUJ2MkozS3JWRks3UEE2em5rcjVJaGdwbXRQS0JBRmhWUzJn?=
 =?utf-8?B?Vmg4ejhNQlQ2d1hDdEE5YjVOaHZ5czRPaGJnalhTSFdxWVBveE5YUW5DVFhL?=
 =?utf-8?B?Zm5pN1dncTdNbUVOaC9GSmIyZDZnVjFQSDd6WG15K1hoTEJDNUxuM2ZTcmtP?=
 =?utf-8?B?Nm96STBTZ0JPV090OHl5NzgvUExxQUhkTHRDTUFKOG5EU0VJUWQ0NXpGQS9Q?=
 =?utf-8?B?b285eTRaUVpPWE0za1VzcWptbG5obWYzeXVmMGQ4T1hCWm5TMFZzaStQWGdj?=
 =?utf-8?B?UVo2T0h1NDV1c0d5STRCQzR4MmNXaHA0WWNHb3lacnRMZWpkSmJ0b3I5WVA3?=
 =?utf-8?B?em5JQ1o3Nk5DOTFJcTVzbjh6c0doWVQyZERMY1BzQWVnbVB0MUkxazZrRUdD?=
 =?utf-8?B?djNRODkzRWxPVlVJaXhSem5tR2JPUkFnbGE1STlDRndrbDRXRlNOYTBjaU9E?=
 =?utf-8?B?dWpyOVlTcU5JOFhSdFBwYi83Q0FTUFRrcG1wNnhTN0xnN2YrZENpSWpFNEUx?=
 =?utf-8?B?QmJGQUFPSjdyYVVWSGhsbXNGdHUwNHluZlVvcTlGQlI2dHJleXIweXlCMEM2?=
 =?utf-8?B?MTUveGtGQWk1TEtzY2JtQXlUekhHaUlRdHBZTWc4VDE2VHJ6bWNaUUF3dmJQ?=
 =?utf-8?B?N2I4M2V1blkxRnMrS2U2alBSV2pXNThIU1hpK1pLbVNvcTd5M01vY0h3a09S?=
 =?utf-8?B?enlXYWlzRUdUaTBLTGpTUk5uRnVuTk5IcS91V3psSU41czBtek1GVGo4d1ZC?=
 =?utf-8?B?L0lqb2dGam1mbGVGZUhSOGhlVjZkVElBYk9JOVhKQ05NakNaUzA2cmdpb0No?=
 =?utf-8?B?Z0RaV0g3cEJ5L3c5VzlHRFBQc3ZmT3plSUxtaHZzelNNdWhLRVE5amRMTTkv?=
 =?utf-8?B?QzV6c2dCOWZjWjRIcVp5SDZkRkUzWit3WEhWQ3lNU04rK3AzZFRPNCtNdVlQ?=
 =?utf-8?B?amRwdFlPOGpiVEdwUi9TendwRTNxeTA1Q0FYak5ENWQwcXZ3OUw4ZzdsL2Rl?=
 =?utf-8?B?aFI5bGNiUCtiUjZBalk4NmptL1RvdWlERStmVUo0THFoRi90bGVscEZMSDBR?=
 =?utf-8?B?YUFxSTE5WkFCRSsyamZhd3BDN0NQbnFGYlJSMnhnZWwzQWZTMEtvcXgvNWpV?=
 =?utf-8?B?YUd4M0xCZ04wRTFsWnNmMUlyWHorZ0ZQOTlyV0x5Z0lMQ2ltQVlZMkVVcE9N?=
 =?utf-8?B?NWk5Q2I5RmYwTkIydkh6TllqakpQR1Z1aGJLZ2hiUjdHUm14VzNPSzBIeWxo?=
 =?utf-8?B?ck0rODdLUko5SWtRQWE2TzFSaDdiODdtSkYySXB2SjZHM2EwMEN3Tno0WXVT?=
 =?utf-8?B?cWlWQ0diTG9HUHZQN2NkMDBjejI5R3ZXMGQzOGJOclpZQnEvR0JuUHRselBn?=
 =?utf-8?B?STlSbXhJNGNpK1VMMW83Y1hRd0VpUWYvMWROZnFvMXp5YzliSE04bXQvY2Zq?=
 =?utf-8?B?YzgzL1hXRktEV0tiUDRQZEFYMkU1Qzh1LzlxOStWcnBkNUNIVEdGcFlyNnhO?=
 =?utf-8?B?VzFEejQ5aUJWQWt2dmtrcDEwVkREUGJaVlgxSE96a0ZlV1FMdFBvN25uY2Rr?=
 =?utf-8?B?MHRyUGJEQUxYVmRCUFJpMmlqcHpzVUpWem9STGlWSmVDZ2ZTYmhOQ3JwaFpD?=
 =?utf-8?B?clZhQXVYdG9sVzVheXc2T2Qrb1BWMnZGQnprd1pUKzlyaXpQNzY1bkl4eUYz?=
 =?utf-8?B?OFhlUENKdVFLMDY3ZHV1ODZFWGpJYWowUnB6WVZWWElBc2ljL3VMUnBhZmxB?=
 =?utf-8?B?WFBRb094aXJXWlpYTXZOd1d4cHIxb1FUZ0hXNWxSaGVqVDNCbFVlNjJ4WkJo?=
 =?utf-8?B?czE2SFBYL0l0OGdQQnhydVUrUzI5VzVQMi9IYldZMW1Yb0tJK21zUzlLbGxR?=
 =?utf-8?B?SVlOYnlmTGdyL0dKWmJQMWJzQ1pmYkYycUk4dnBuZmd4VXpScUxYa2o0T3Qv?=
 =?utf-8?Q?R/sE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e2fd09-9edf-481c-9cb5-08dbc519d0a6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 20:38:06.9781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJ0jP4BUZad5OSiY/OkHb4Z0LlCKyPuKXdtG97e+r7vNkKoolnW0S+zt/3wsrsLv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/23 12:21, James Morse wrote:
> The resctrl CLOSID allocator uses a single 32bit word to track which
> CLOSID are free. The setting and clearing of bits is open coded.
> 
> A subsequent patch adds resctrl_closid_is_free(), which adds more open
> coded bitmaps operations. These will eventually need changing to use
> the bitops helpers so that a CLOSID bitmap of the correct size can be
> allocated dynamically.
> 
> Convert the existing open coded bit manipulations of closid_free_map
> to use set_bit() and friends.
> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index ac1a6437469f..fa449ee0d1a7 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -106,7 +106,7 @@ void rdt_staged_configs_clear(void)
>   * - Our choices on how to configure each resource become progressively more
>   *   limited as the number of resources grows.
>   */
> -static int closid_free_map;
> +static unsigned long closid_free_map;
>  static int closid_free_map_len;
>  
>  int closids_supported(void)
> @@ -126,7 +126,7 @@ static void closid_init(void)
>  	closid_free_map = BIT_MASK(rdt_min_closid) - 1;
>  
>  	/* CLOSID 0 is always reserved for the default group */
> -	closid_free_map &= ~1;
> +	clear_bit(0, &closid_free_map);

How about using RESCTRL_RESERVED_CLOSID instead of 0 here?

Thanks
Babu Moger
