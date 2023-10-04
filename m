Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4067B871C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243480AbjJDSAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243611AbjJDSAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:00:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDB8AD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:00:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNUSO6NtkUzIYL4y6IisWm5UJ8Sd/qVs/MlDdpR8dMfmdzQRGb9FIg5vDKI3RbgEDN9dRai3YbGwzXUsfhKf3BrY6+D5yyqPVcrZFY73OW2AKgZ5EJkm4z0k1/eCKXbiiAokNvK18xu7tmsmztpguuL3jKBN7eXZdtXgNR5U5MnzJOxm9uylGPVXoqn7CBqnvS/RimBwkLv80sdozelGtrWCZgY0nN2iJJSAxBzMgYfY0yGE6PgPBGWczfnrQBkEtmrxQPHRtbBTBuNFR4X3VowUjyk3C6D8zBwuCxCDF4ufmAnI3ZTxYgOzDFLDgs+1umUZWh8pVhm5oBkPYem3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZyukch/CH2n4xM8wpCM6/2MSVEXmd2VSgwjLb9cFHY=;
 b=jtK74RPz7tptWIFL5BpJzKnKVmv8MHHqa1u2n8r9dmWi4ABBvhGrsYLNISarcij9lE7dXDNmuFamsJUS+KACLsFwTUdWo5SZMowgrf7utUq7RNrz1OW2h1FToq7n6OVo9FcICXJht9pONi7dz2lmHnuYAibUhOpUGQUqBUGwYgfXyNEPKI/TJbg0NLrZPo4663cBbuNVhA3gPC/y8K7vUbxvZelrY4Z04ghglJOIKC3WEkMTJ5Kuo04+SwypODNXY0xgqcDSf5KKDCy0M5eUvPKPuEqd3VYW3yLoLG6IrpgZnbcfzlpg6WmU4PsGk0/4q2YCMncZ2T0MF3EyrttJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZyukch/CH2n4xM8wpCM6/2MSVEXmd2VSgwjLb9cFHY=;
 b=5Wp0/zZd47Hw96TYmDup2KGOBUzdLrEncEDffz79NPnp6BIiAHSEgl7GGGqyD44kKg5dF7gC0qgbjGXWXRl17uN/BtOuqsdIXFc7T81rBaK5fuZX8EkxgAnCwME+AQwZioePv5rTQC9VqzKtZkfS03DRVfq6FkGfVN+kgp9AxGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 4 Oct
 2023 18:00:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 18:00:33 +0000
Message-ID: <7f95e9c8-73a6-4ccd-97e4-0d3723fbeafb@amd.com>
Date:   Wed, 4 Oct 2023 13:00:29 -0500
User-Agent: Mozilla Thunderbird
From:   "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v6 02/24] x86/resctrl: kfree() rmid_ptrs from
 rdtgroup_exit()
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
 <20230914172138.11977-3-james.morse@arm.com>
Content-Language: en-US
In-Reply-To: <20230914172138.11977-3-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:806:122::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|BL1PR12MB5064:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef3ddcc-c07c-4c2f-6a83-08dbc503ce15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNLvu+96Nnfkhi7zqPpkbh6Ch3uXu3X+OA0Q9nLYUfM9z41p/HYlEHFijLYzswRohX/rfFouh8QxldofvktjlCGXlYWJBHtepIg/WKqzYGO6XRMeziGPVxNR0RmsrmBIxI1JU3cpHc1WT500yGMvsU4OG/JIsaE1IqVfcSgtbGFfj6mYHTSWfnnhDoOU/4bXpERZmfwVfJBC5qOoTUGFkNvUZudSfEdhC+05N/LOdTK5puN0gh/vwI/pK8lrEBnJ798iY9FFZmdQhcRFdy1CKMZCVPHtRWoDqh2yAU72gW3OIOrznOH3BevLW5Oni3dtl4j+9itV6cFoChYrB1aeShJ/jIBDgL+P+Ilgjw5+zHZaDG+HukS8Rp51x0N9E26BTw9AkMSzf6vAhiV0udLUK2v8U4vTYyAl8VcNRoyetpYeybMLayalHEkUmqDzvrd6Zpk0BKAFx9k7Gzoh9qK9AUgc2Lm5qPRA6EjdDlokeswQkdpPNKZtUV9CpwI2DnrvOpRKm+BX/E0ZwjXKsCFtiKFGgfcCGf4HY2kJbucQl+ojQN7r/edH8WDKxhp4+19JDTmBK82MHqOun7pvetQM97fq5eZX/fS+zi7r3w/e9ILrE6vYQnFTPOlllUsX/0mquTxaDt6Da8ct8FDCo84vVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(6486002)(6506007)(6666004)(6512007)(53546011)(7416002)(83380400001)(26005)(2616005)(2906002)(3450700001)(316002)(54906003)(66476007)(66556008)(66946007)(8676002)(8936002)(4326008)(41300700001)(5660300002)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjFoVXFDdUxmZVNKTXplZDl0bDlKaXBHMjNDMVpMQlZYV2xXUStUMjcraGpK?=
 =?utf-8?B?dHkwWDRkd0dCRlhzWEtrNGFkMzJaUlpVQWhNMktrMEMvSGRMWTdGWklYMWxw?=
 =?utf-8?B?K0RncC8waXFSbTZTTEozWFZsR2hMU2Z3VlF0K3VqOWZwTjRiN0tOb3ZwYkJG?=
 =?utf-8?B?cHhqNGpWME5tSFdONFlHUWd0NlZMTXkxSysySy9XSk5uc1FZb0hWTnVRdVlK?=
 =?utf-8?B?NzBMMXJERjNVcllXN2lPUllXYzFPakxiWlFIanZaaDJLS05LdU5wN3NQcmpj?=
 =?utf-8?B?ZXEybG54NitUNTEyNmRuRVNQNVp2Z0l6NkswazUzWk43YmxNQm9Sam5vT2ls?=
 =?utf-8?B?MzlaQ0xZdHlOYXV1ZG5INXFkditwSGF6RmUxUThMdjZNWkZoV2pzTGd0TnF4?=
 =?utf-8?B?UTc5M3VQZFV1QVRqUWpiemlwN1hkLzJyU1h1Q0l2K3FyUUJKOE9ZWFRPUnZR?=
 =?utf-8?B?eVlkbk9Rc2N2THVUd2JRZm9LNlhCUHlFZVFJUFpYTXloTjk1aG5aLzVVc3Nu?=
 =?utf-8?B?OGp2VUM5bTU4RFk0UVdITmE0U1J3dDN5WTBaTEV4b0xlVTFVRnc4OGsyand4?=
 =?utf-8?B?NGZiL2pMajdCbEg1QnduYXR1ejZZVG1PMUlaeE5YQnNhdy9qU1VYQ0t1aFdr?=
 =?utf-8?B?eE1HRzhPZGdobFg1MC9GdmYwZmUwNE9MY2RQbWdWSUVhRjNqd0ZqYkFFcVFu?=
 =?utf-8?B?U2dVRjNzR3JRN25uREgxcnZPb28wbGxyMjREaXhRWml1VlVSNThVU1cwWThj?=
 =?utf-8?B?S28vaUJjTDlTTFBBL0dsTWtwUnIvbE1TNm1CSlluc1hUcC9aWEVubkhRc01O?=
 =?utf-8?B?cWVWOENtWWVMcVRnZzg3VTllc3AzSS9xOFBxczYwVEJDWTVXRlhRVHRLaStq?=
 =?utf-8?B?OUkwNnZ4ZjlkdE1zeUIreUtpcXpzTWdGSjdyQXNKaVBKdDNFZkdPeE1xUjV1?=
 =?utf-8?B?NEtOUkpMbnVyRW8zM2cxNmEwaXNrblVXVnJFUmw3Rmp1RlNLQS96cW56TEpJ?=
 =?utf-8?B?V1ZJQU1RZldiaXNTc3pSa2tzK2lXQzhhWkp0ZEcxaGZORWcxd2VuRVhSNjJh?=
 =?utf-8?B?bmkweEVoYUI4cW1SU3ZpSVZKVlhLN1BXSm93L3Y2L2ZlTmVlamNJaHdvOFMy?=
 =?utf-8?B?YllvUXVoMmpUYk4zWWpYWEtDWldqL1p3bmFTYUhVaFAyTWtVYkozNFVObDBW?=
 =?utf-8?B?WW13Y1hTVERwN01QQWU4VFhLOWRIR3Y2MEZKMi9YMDlqdnh1UWVodzlKSW5K?=
 =?utf-8?B?dm83YWFvcjE0QWZHWnhnUHhldzVrQklMSUNDWmloNnRMYmNxSzRCNlM5L1Iz?=
 =?utf-8?B?enpwZ3QzZjExZEIxRklPZml0MGJsaktmZlRPbXRjVk5tQzQyUDREZERsTVVE?=
 =?utf-8?B?cnNXTEQyckRPckN6c3dyVkFTa1ZFMVBLMzJsbnhlMm4zVldBSTBaOTF6Z0sr?=
 =?utf-8?B?VjcrWFBYOFZ1SUltaHp6djdMLzlYeitWb0xtbTRMbUdjdTlrZjBxbGgrMkxz?=
 =?utf-8?B?WTZITVRKcmxyQVJhMm04UzFPOU1SaFFtMXJoYnNFelhOdSttQk9aelFVZUhU?=
 =?utf-8?B?NU8zbXZGRmxlWnF5WHRVNkVEY1lBVi9pTC9PYjhySWo4eHFPM0VTM2NPR3A0?=
 =?utf-8?B?TTVqQ2Qyb1BLeTFvOVBNNE10WWlkMW5GV3FSS2FEOWwxc3ZVU05Qb3hMdlFr?=
 =?utf-8?B?a09zOTY1dWNBT2lIdVBBWGFSNjJoR28zbVltYzNkWkFXTm4wWG95RXRFWjhv?=
 =?utf-8?B?d3MyNFIxTjc3QUZSejZCQXV2Z0VJcXNFZU5Ua3MwdlZ2MGhzUHgvcWtLQm5l?=
 =?utf-8?B?R2RocWhzUFBTSFN6ZkZ4b2xMNXFna1pxcEdlZEFmd3hvdi9BUExmSU4xNU1L?=
 =?utf-8?B?bi8rUERqc3pMdVZVWkM0cXFnYU5kN3JLREdFanJZWTU1VkVLdms0ZitGZzlK?=
 =?utf-8?B?UWxieDFoNEVUeXhtU0RwQ01hQU12bTdaeUp6RU1rVGdvbjZGTE43anVhek1o?=
 =?utf-8?B?Q2kwOThKU0ovN01RejR4d1NHZzUxYnhlU3lyUEhEcDExck1DL0NMdkxJalpI?=
 =?utf-8?B?cEtRb1M5UjlocE5NYzFrV2FmL3Zrd0FDeWpVakJTL1gxOXorTFZDZnZFSDQ3?=
 =?utf-8?Q?zngY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef3ddcc-c07c-4c2f-6a83-08dbc503ce15
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:00:33.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tnrzl6OmBcUIDXOQrKHxOAaSbn3X8ob1Q5yTOjLWojZ0WGzAB2dXe7JmvVZTFheO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/23 12:21, James Morse wrote:
> rmid_ptrs[] is allocated from dom_data_init() but never free()d.
> 
> While the exit text ends up in the linker script's DISCARD section,
> the direction of travel is for resctrl to be/have loadable modules.
> 
> Add resctrl_exit_mon_l3_config() to cleanup any memory allocated
> by rdt_get_mon_l3_config().
> 
> There is no reason to backport this to a stable kernel.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v5:
>  * This patch is new
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 10 ++++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  5 +++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 85ceaf9a31ac..57cf1e6a57bd 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -537,6 +537,7 @@ void closid_free(int closid);
>  int alloc_rmid(void);
>  void free_rmid(u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);
> +void resctrl_exit_mon_l3_config(struct rdt_resource *r);
>  bool __init rdt_cpu_has(int flag);
>  void mon_event_count(void *info);
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index ded1fc7cb7cb..cfb3f632a4b2 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -741,6 +741,16 @@ static int dom_data_init(struct rdt_resource *r)
>  	return 0;
>  }
>  
> +void resctrl_exit_mon_l3_config(struct rdt_resource *r)
> +{
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	kfree(rmid_ptrs);
> +	rmid_ptrs = NULL;
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +}

What is the need for passing "rdt_resource *r" here?
Is mutex_lock required?

Thanks
Babu
