Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3687BAB70
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjJEU0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjJEU0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:26:51 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260B598
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLLiUJyZRy/mW5x0U8jwt/lsUi3/+LK0sS1Z6xzmCr3vmerwfgcXhQcpWD2fkKw5oInpl/63zC16t6nkIuONjJLcM8gFJSNSCjppje3XZsBdcIIyWHhxzCAulguFjoXcjbGygbPFsTUuxw6NJn7o4lnyqhgJ3+HkIwl60pZ2e/2RMMYsBnSdLK6BouynV/qk4FWkJ1fmSa4Pqg5YnVos/cF1v7Wh5t8t52gVDR8WnTM874o/uPRXBwZKWxnvEaBjSri8mY/hsgiEnmkWJfZtprTLBqwB1cxf1FmaIVO9TjDIM1a4Be7CGvMoWLup+bJLa+g+5Dis7J8J1Ef6pvsZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYtyrSK0q7zvHmo+N0NBzeb7Lc0hqXUE0JufOQbhpd8=;
 b=n6FgpfW2C4ac0oaqbqL9AyX6C9XazZ3PsqYcpsUwW0y9tLu2mP3S2L6Lb53hoYHTDNZY3o7envnCsOpG955Mk5AYZyrq1ISIMDgTOCcT67ri4AAanR0i5zKmO2m6Tm4aV2FgJasLPLSjLNFN99pV5B6T6l3+mYP815gFyfzFjdA6fTmk+ZIJS7qx9jDi2x26QUm0OYM7Kvg8Y80JzFbOua+55f6cJqCWODnmYF1X8exj7M0bcPpCRO/fXeC8BAd7iw0xFCM6dHRfKmhY4pP4Cnva8bOFXp/z+TXqRxfkVljpJXyvSoZAOHUSKH0QW3Dc6bweWxG5eTTOnmUPKmCztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYtyrSK0q7zvHmo+N0NBzeb7Lc0hqXUE0JufOQbhpd8=;
 b=MtIfgCNnyH0IRXUAm08tr14KPF80RlMjxrkInH+fU1taqYc/JJHG5/bvu1frL/RR+b7eGcZQLtvU8R8j2XfW6/zsIykwkdR4wu2GUENQl1rVKRnZ/NiGTSdFQcI5bh25a+l4v7My9tvc14P+5zPDLJhAYxtU7L4n9VGDefketE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 20:26:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 20:26:43 +0000
Message-ID: <1dc0fb2f-7b68-d1b3-e6fe-bf341afb545d@amd.com>
Date:   Thu, 5 Oct 2023 15:26:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 10/24] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, amitsinght@marvell.com
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-11-james.morse@arm.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20230914172138.11977-11-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::10) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 841c1597-e4bb-4641-a73f-08dbc5e163bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dwtHvnGKVekF51tyIQbQtkNYuF47qOXO/yPcM/BY82oEJU7jVul3wAI3c84sj//QerMyekQfOWjMWsRGT4P0yVDR/ox3gWSsPKOqJPbgn5tf/V4fKHLagohOZdbyWkMXXV28ztdXGyxjPHtUsBbglZ0eLOcA9bzpnjJjS+oq+W3sMDHRcqijRtAnM/6e8PSNquaCahHkq71KyYnAYWzVpUILBnwna8IFZnIjXmipWCDhL/jvTNeO/K8p+eAWdc+2OYRTcUQZc5Snro2NP+ZjkAkVAA/SX7Vlmh0r0uMaVTdSBLY8PHG/070zu88bNR96CWDb7gYDueiLcKuKWSB5WwY8kMfRK+DTefiSSip/0QvUHCemUAx4ZkvD7n2wO15MzSpD06MngpzYYZc+xoVk2Yhlqp3+55tTItrrBiWEhS+iqfwupzb42lVo5JYNBRm9xx05R9G4FwB8z9G343tmwREwmD8JJHGW7dtrrot+HRWTACZs2pI96/ZNOb+/u7O6wGudUzG7y3+mQd93nuY0nqgNzYxC5pAQY7TiWFz8jsj4bZmC2aytJYJg7Snti30oiTFpjuwK54yRIN833Qp2HkdSS6iu6pAsSrcnyhpkfnjPmBpVxZdJAjMn60Y1Tp8FES3HWPRQz6h6j5G6tnfxVztBHFTMjIt1GAy+e8RLe0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6666004)(66476007)(66556008)(54906003)(66946007)(6512007)(2616005)(41300700001)(316002)(5660300002)(7416002)(6506007)(478600001)(53546011)(2906002)(8676002)(6486002)(26005)(83380400001)(4326008)(8936002)(31686004)(31696002)(38100700002)(36756003)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anFzbTdxaDIrNTQ3RHlQYlRncm8rK3lFeE9aZm81ZGl0OEUvLzJpdWJqRlgz?=
 =?utf-8?B?VTF5NmpzOGJzOVU0eFBKLzRPdWhIZ3hoT0ovOGx1ZEk2QlpRZ1BWR2V2VW4y?=
 =?utf-8?B?V2RUaXpFSDIrQjFuTzBWZEhPUWI1UzZsNzVLNlM0TVdtUHcxZ2NQK3Q5N0tv?=
 =?utf-8?B?TnJRZzJDZ3pHczRjQ1ZXWWFEelNmUFJNOWt3VmhNUzB0bUlBei9oU0hubVp6?=
 =?utf-8?B?cEFtOTQ2UUxDNUFXSDlxWDAySXB6TWNGQUZJSlM0cmdqZENqdlFnZFR6RE4r?=
 =?utf-8?B?SGhNbSs4amVvV1c2ZktadlpjaThFWXZzQmZERThsSjY0MDJiMi9aNU1XVkhj?=
 =?utf-8?B?SndFUDBsaXVQZFFITkVqZHVxTDgveU1LcTJEbEtQbjdqNUhSdW9mMFlaZzQy?=
 =?utf-8?B?NFRCbjZBZVYzUUJ3S1BCeWc1TnNQeVJOVERkTjh6S3dWVTduMGdsNkxsMlQ5?=
 =?utf-8?B?N3VERVk1R3orakYvQ1FSTlJmL0lyM2ozbzVxa1MyaU9IMkhVdEJtUG03QnYw?=
 =?utf-8?B?MllXRlFQRGtGM2E3L0tucUhMdnpZMmFRTWg4WFJWZTdIK2taTUZPTXpiN29x?=
 =?utf-8?B?dGhxMEdFbGdOcUwzT1ArRFVXem1YQUsrTEJHcTM2b2s4YXdER0RvWGZDbDhr?=
 =?utf-8?B?TmlkT1E1VnFvenBhdW9nMGJHejlsS1R1WUJEMkFxNkJ5VnBpeU0zN2xyZGFV?=
 =?utf-8?B?S1JLbisyS01ZUWkxV1c5NDVWdTlHVFVNbnRDdzFSTXY2ZTIxcWFsWG1zWXNF?=
 =?utf-8?B?VDZNY2hKYzBEdU9JczJpNThBMFpoWjI0N1pZakRralk0cis1NWo4Yms0OWxl?=
 =?utf-8?B?MzFNZE4zbFR2WHdpejJoamtDVThUU3d0NEd2VjYvL1hocjZzNjVhUWNoc1VH?=
 =?utf-8?B?VDlOZDgvUXp5YlMweDdxSnBWT1JhRys0RnRCYnloYVlFam5WU1JRcHdqdVFG?=
 =?utf-8?B?YWVwcEYwZGJoQzRwTUlXMkI4ZGtmTWY0N2ZiM2ViUmovQmxkUlNOc0duRW5i?=
 =?utf-8?B?TjVzZmhmNGM2U2NNWXlkbnJ3ZXhjR2t2TXcwTU1idnl3WEF0U1dveWh1Y1VR?=
 =?utf-8?B?Y2E4YVhSeDJMMTF6QzBqMEhGbEY3N1dLQVZKTE0yN1dieG15RGJwM0cyUjZz?=
 =?utf-8?B?Uk9UaEt0cy8xUlRyRGxJbDkzYkgzOENnZzJDSzA1d2hOUjQvemVxV003Qjlj?=
 =?utf-8?B?Z0FVWFlNUGlZYUYvazYwSTZpa0gyQjFKaEVOMnhmYjFSV1kvR0k2Zm9HbE9T?=
 =?utf-8?B?aVZhNzNmYlN3aSttdFNKTXZWQkNQSkx1cUlheFRnTkNET1ZHVXhDTUZpcllX?=
 =?utf-8?B?eVdzODYwRWlQZGJCb3U0RVBjQTJSUForY2pEQmhNOXV3QkFzbTkweVUySHVo?=
 =?utf-8?B?bGNUSi9LNzltQjUyRDZsUWs0anQzNGtoczFaakJocHlmWEk3SWpDbktSL1Q5?=
 =?utf-8?B?OTJWTDE5d1BUd0FZKzRUQU0zd0FBVTVBNjVpQU9DRkFwQSthaXg3MS9XTjlU?=
 =?utf-8?B?Y2drN3ROQit0WlhXNHFVbTJ3bUd0Q0NMaGI4NVZsbjl2dnNubTdLSnFqU3E4?=
 =?utf-8?B?dzdscmxNcElKWlUxWVA2SXQ5T2k4NFlQTWtEMnUzNDFiY1ZlaGIxSGVhS1M1?=
 =?utf-8?B?ajJ3blptSnd2U2p4c3NSUVI3WFpTZ2JLYXNWbjNZK1YxQmNlRlkzbkF2YVBR?=
 =?utf-8?B?VCtBcU9XSkgzT2VMUU1TeUZoUmduWGxZYzltTUw4U3hvQVNVeGg1ckdtb3JH?=
 =?utf-8?B?TldXVWxoMTdraTU1L3RGVlYvdHd0Nm54eVNtUjdBa1FiZC9EenNoUm5UTFJ5?=
 =?utf-8?B?cnRxaXBRbXNLSXlZeGZNSW1LY3BNNktIK05YclZFUUhwcjYwSHFWZ2xBYzFD?=
 =?utf-8?B?VnVMc0lKNm05ZXNIdmFOSkJBSUFqRUVLYm5tblJiVFF1azRPZDZHQ1lhZXor?=
 =?utf-8?B?ajJyWW92VE0rUzN4WmhkN1o0N1NQR2JNT2ZNTmRmVXFLb0d2THoyL1pzcWFQ?=
 =?utf-8?B?aE5IUS83OTBSNUExYzhPaGJyT0dVWnBjcmdlRXJ0bm82MXcxelNicENQZ2FJ?=
 =?utf-8?B?WDk2NUZOMlJhY0tDcXR4c2lLYktnMkVmRU1aMWd2cGJHUXJXMjl0Ym5uMHJ2?=
 =?utf-8?Q?ynySW7K6XbtR4M6cRx5M/WKq6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841c1597-e4bb-4641-a73f-08dbc5e163bb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 20:26:43.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOPdF9H4MPAsKt+MmrNn3E/+iQsLdd6FSp3KTWHHBgvF9xPClUDUAQgYzPV+RwBm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

One more comment.

On 9/14/2023 12:21 PM, James Morse wrote:
> MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be
> used for different control groups.
>
> This means once a CLOSID is allocated, all its monitoring ids may still be
> dirty, and held in limbo.
>
> Instead of allocating the first free CLOSID, on architectures where
> CONFIG_RESCTRL_RMID_DEPENDS_ON_COSID is enabled, search
> closid_num_dirty_rmid[] to find the cleanest CLOSID.
>
> The CLOSID found is returned to closid_alloc() for the free list
> to be updated.
>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v4:
>   * Dropped stale section from comment
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 42 ++++++++++++++++++++++++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++++---
>   3 files changed, 58 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index ad6e874d9ed2..f06d3d3e0808 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -558,5 +558,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>   void __init thread_throttle_mode_init(void);
>   void __init mbm_config_rftype_init(const char *config);
>   void rdt_staged_configs_clear(void);
> +bool closid_allocated(unsigned int closid);
> +int resctrl_find_cleanest_closid(void);
>   
>   #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 0c783301d106..0bbed8c62d42 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -388,6 +388,48 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
>   	return ERR_PTR(-ENOSPC);
>   }
>   
> +/**
> + * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
> + *                                  RMID are clean, or the CLOSID that has
> + *                                  the most clean RMID.
> + *
> + * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
> + * may not be able to allocate clean RMID. To avoid this the allocator will
> + * choose the CLOSID with the most clean RMID.
> + *
> + * When the CLOSID and RMID are independent numbers, the first free CLOSID will
> + * be returned.
> + */
> +int resctrl_find_cleanest_closid(void)
> +{
> +	u32 cleanest_closid = ~0, iter_num_dirty;
> +	int i = 0;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
> +		return -EIO;
> +
> +	for (i = 0; i < closids_supported(); i++) {
> +		if (closid_allocated(i))
> +			continue;
> +
> +		iter_num_dirty = closid_num_dirty_rmid[i];
> +		if (iter_num_dirty == 0)
> +			return i;
> +
> +		if (cleanest_closid == ~0)
> +			cleanest_closid = i;
> +
> +		if (iter_num_dirty < closid_num_dirty_rmid[cleanest_closid])
> +			cleanest_closid = i;
> +	}
> +
> +	if (cleanest_closid == ~0)
> +		return -ENOSPC;
> +	return cleanest_closid;
> +}
> +
>   /*
>    * For MPAM the RMID value is not unique, and has to be considered with
>    * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index fa449ee0d1a7..1f8f1c417a4b 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -132,11 +132,20 @@ static void closid_init(void)
>   
>   static int closid_alloc(void)
>   {
> -	u32 closid = ffs(closid_free_map);
> +	u32 closid;
> +	int err;

Naming "err" seems odd here.  How about cleanest_closid ?

Thanks

Babu

>   
> -	if (closid == 0)
> -		return -ENOSPC;
> -	closid--;
> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
> +		err = resctrl_find_cleanest_closid();
> +		if (err < 0)
> +			return err;
> +		closid = err;
> +	} else {
> +		closid = ffs(closid_free_map);
> +		if (closid == 0)
> +			return -ENOSPC;
> +		closid--;
> +	}
>   	clear_bit(closid, &closid_free_map);
>   
>   	return closid;
> @@ -154,7 +163,7 @@ void closid_free(int closid)
>    * Return: true if @closid is currently associated with a resource group,
>    * false if @closid is free
>    */
> -static bool closid_allocated(unsigned int closid)
> +bool closid_allocated(unsigned int closid)
>   {
>   	return !test_bit(closid, &closid_free_map);
>   }
