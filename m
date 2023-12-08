Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2056980AC0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjLHS3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjLHS3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:29:22 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23A5BD;
        Fri,  8 Dec 2023 10:29:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/OHmDksUc1us+J0llijk+06ydHvi4joQQsLBkbudlbOEk4LNmNsRNKrm6O7nzYxUOgEFcydJYN7SV0YILYvs00vOdT+Xdl+9aNoNSIbdd/UjOjt4NcB/cH7Z3An10ka0N8qnZv7Nekrd/vwGKv3x05H4NvmM5HkdAjHSQjhTSq3HQ66/UHXPNU4x54sBxB0PC7WgKIeynQJbaf+kI425ofh6K/g7aE3lQcfSekrBVSMIlvmiVJwaiGj19cSpuEa0tUPiks5W+YBMl/LQu4BtMSkGfresJhU2sS3Pweor+nYX1Bur4mm9NlySAwFpFfMrypQYQA13SriROu84Och0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TUVeLkfnfjmJcSzV5551T1W0zp+GB7FddAOISmZHCs=;
 b=FrTr+bS9VKHo/lxh+iTc/HzWjmOdciIiZvRj85prNinZDNm9zF4BIsAGyUKvlfOXXlyqxeqR4gkOiqEo7RxYZQVTk3XJ99SwOV+2YvrakpiJoxxpGDNqGP87GgW/PBBV2Sy0xBlI5rnvq3Pt9feDtNHpDtM6Su8Bve5Z8aHTqayrF9c3kRNNq5reJsi1qYVxVN7x6SSryC00JLQvH5mflXbVQePTfc6D2gntGEirRaOVqzjewxjWYpyrufQW87JJpX7UOvhUd1jLF5DkRnEWNacUWVzCFHiTKb5gdE7fIEYU8Q/fPchiBBZ7MC3XoyOT94xDvqwqid45gJMinK1qPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TUVeLkfnfjmJcSzV5551T1W0zp+GB7FddAOISmZHCs=;
 b=MhPA2lMBhTsXk5CKjHI0I+ixifhRwcurZ4jPPDLgaj9YG/bMEqTRFIYEed2B7r3q3f+wKtUhpX07ly41bIdFivsnnjkviVvJ+mEstmA+4ph5Q1K+TxKVaPwPut0Y2Oc5YOT9pO1laoO7iP8ldF7sojYXU2Q3IeG8DGeUN3EpD0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 18:29:22 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 18:29:22 +0000
Message-ID: <7de1b242-e8cb-9968-876e-d3e311443b57@amd.com>
Date:   Fri, 8 Dec 2023 12:29:18 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v6 1/3] x86/resctrl: Add mount option "mba_MBps_event"
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20231201214737.104444-1-tony.luck@intel.com>
 <20231207195613.153980-1-tony.luck@intel.com>
 <20231207195613.153980-2-tony.luck@intel.com>
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20231207195613.153980-2-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::14) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: 0181451b-a3d4-4632-269e-08dbf81b9977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R408m7Cb6T0dyVJORUolm6dBUlvnMpsXlgsALCg2ICr2HXKtcNkWHgFmCaZVk56fhVo2aKoBsJWhO8yXIezb9jHRlockl/c56i+i1KDIqCEG+bE+SmWRFYkS9bR2yeSxXvLY9rQj99ihhEw68lZZpcE2n1GFvjeT7OqzkmLKZFo/nPBPiDTod/y4iWSS0HTJTIeNWYjQzhx26sJiXV0ApVNRrRux/xI3ou0HmxHw6BPnX9bCoEAm/d8R7pTupGAnOpertlEll6AorjbicqGNaPw+i0pF1lOOja9YGvy6BsBjZXaHfa0fslnCBcvx504ZPJ8UXTmh7jACCo8z8F+YWaf0IKOPYr+AIRM3YCE+RP+ZwHb3BexI0i0K873s/2YjFmR4lZMX9Fx4P3iSXNBlf1B41+tWn8OOl2MdoJhpxf1CpsmzNLNttEj7PyUPS5ddEuC7NgElozO5/YHlkuok/6BhMM63qBiL8Z5ylc55Ssq/vh0upl2EVUzvadaAJCGYZSCUbLTrIWhRWUeauCjM9Bekm6ZyozPv7l+nVxmTC4nPKXaKFVil/RlB6G2+KAANWbKGdm2f/1/M7WnR2djRn16L+KWgLNNEe4HB5NYALuYwIfUD/6Rp6llB8sqgRitNX+C71Hv9/uqv2WjmrMD/wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(5660300002)(2906002)(4326008)(8676002)(36756003)(7416002)(41300700001)(8936002)(83380400001)(26005)(2616005)(31686004)(66946007)(66556008)(66476007)(31696002)(54906003)(110136005)(316002)(38100700002)(6512007)(53546011)(6666004)(6506007)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXhUZ0cwQ1FuK2NPNkpLWm8vcVpnT21PRWdxODBVMGttc3lvWldyYWtrZ0pJ?=
 =?utf-8?B?OUF0ZHJCOUpIRTNHVXNsUnZGYTk1TlFHVGJPZFhWNWh3UVpSS2hXZDl3M1ZG?=
 =?utf-8?B?cUxpZkYzZXZkeWVYSzZqZ1JDMHVhcVVBQ2RobWlJcHFYT1NNai9yNm9ZLzRT?=
 =?utf-8?B?cytJMnN5ZTlwSHR1a0R3VmEvZngyYkhPTDh0cy84a2NGeWI5K2pRa3ZpNllw?=
 =?utf-8?B?QXV0VHVYZlJnbXh6NkN2NkxvMEU0Q2VzQU1vQ0x5T25KbzJwVGxTazNXalVO?=
 =?utf-8?B?SFdseHhQdVJTbnhsU2Y3QVh4ZTc3dHVPRU5nN3BGUjlZa2VoNVh4VmJuYlVI?=
 =?utf-8?B?Znc3QmZLMWxyY21USldxdmFTTS9aS3JjMksvWkYxY21STTlBeE1kYTZ1MmJ2?=
 =?utf-8?B?K2tVdG9paEs5RGQ3Rkc2RVgrc1B2SE5ZUTFUQ0REOXNpMm80M1ROcEs0ZU4r?=
 =?utf-8?B?TzAvcklwa2NOdWNIVlVFMkl6a1lmWUFjSWgwbEFZakJxRVBFcHgrc09Fdjc2?=
 =?utf-8?B?N29BZkJSVlRuVWsrMURNR1l5WWsxdnE1dzZaUzRYT1k4dUFtcTNyalBtVkRD?=
 =?utf-8?B?VHFWNW12d3AreFdvRTRuOXFqRXFjTmlsMkp6K0ZKbzJWdVJvcFdybXpWWGR6?=
 =?utf-8?B?Z1VJaE9JLzNLY1hoT2ZnM1JNQ2VUczlWNlNEN0d0enlUT3VJMm9wbnpqUE81?=
 =?utf-8?B?aHFMVmZGUTdyMHo2dExxZ0p1VFBQbmZiNHJraC9Xcy94NDk1cHBWZzJZczNj?=
 =?utf-8?B?ZnBFQnd4TjBnMmdxaGQvWGdxd1B5Y1FPeHRwNmhkTll1OHgvNHIxR1FwREhw?=
 =?utf-8?B?aFhnWlBqQ3FHNFQxSGpseXpnSnZjdE5DdVNCeUs1bTd4ZUtkSXhvcTA4RktW?=
 =?utf-8?B?eEViNW9XbjFoc3ZWendLZ2FZckRocXFZRDR4ZjlkTVpzczlWTmJKaW1FRkNh?=
 =?utf-8?B?cVdRMllBd1cyZ080eTRFUHoyQTFKRkg4ODlDK3h3L1I2bmpsNi9ha05OallW?=
 =?utf-8?B?a0kzWGN6Y3p4dmRMcUFUMDVuZ2V6Nm5tY2F5QlF1TG5zUkJFYzZ6a0hFa2V6?=
 =?utf-8?B?dnU5aTNIYmo1OW1uVGZzZU5ESUZzKzNnelN6WXVNbGtJbG5NMXYwb1lpemp0?=
 =?utf-8?B?Uk1scnJaRmM4bGE2YUNpOWhVeUN0TEoxWm4vZlIxQ3JocUJoakUwVnBHcHFJ?=
 =?utf-8?B?dHJjMCtYWm96TmdDZzU3MWtyaml0aDlSUmtJTzBmcHlJaEIyREtQRHJDcG9T?=
 =?utf-8?B?WldHdjloRWpZS0ZtZGNNQUNnUFVybnJVYzhxYWwyaW8yWE1YWWlISzQyQVVk?=
 =?utf-8?B?QkY3eVo0Rmp2SjBlVDFDRWpTU0lDbnoxMktObCttZk5PbGlFSDQ1ZDJNa2ZS?=
 =?utf-8?B?dUdjU0ZCTkdicUZWVzMydkgyZUJhbmRuSjE4UlBXZ3pzWVVLSHNYaXNxclV2?=
 =?utf-8?B?bWlBSXk0S3BqQ29OcGViRW9tRTRhTlNZK2tJWTE2UWJ4cWhpV3lITlVjUEFV?=
 =?utf-8?B?QUEzclI1T2VIT2hhNVRKS1RiTzM4ZXl0UndFRU8yQzFVcFFwRjgxd0NiNXdP?=
 =?utf-8?B?UCs1aWNDalpvd2MzdmsvT1VUUitINXFibGVHMCtVcytoSGZ6U2VxTlVNV1lE?=
 =?utf-8?B?S1RybElaRFU3d3gwNGtLaGtvN1RpSWI3cDVxdGJEeFZwdUhxSFozMzIvSkhZ?=
 =?utf-8?B?NWpWeXRXajIwUGZXYi9oeFJoVUMzUCszU0V5ald2aUFKT3JYZzQ3ZU5wK2tJ?=
 =?utf-8?B?bE5GSHFUME9OYm1mN1NDS1QvSjU5U2JSamZnWUZYb3RvRG1GV0dJMTZndkpK?=
 =?utf-8?B?MnY0bzkwRnNSUXRxbUN2L0IwQ2I2djVPeVJnS1JkTGFCa096RG1ZaGlzRGxt?=
 =?utf-8?B?Q2kyN1V4V0NkZmtkbVVSV0dyWXQ2RzJ0eFlFajFxMTZ2WHNaTkpHVnNEMmNq?=
 =?utf-8?B?ckJ4NmQrTExoWW9mY0NCNG5IZzVWYUZPUmxDYjBGQ2dMYVJBOVBPQlEyNkNS?=
 =?utf-8?B?aElrMWJWbnJPRmZjeXRCaWw0U042Vk1JZ0hRSXRSMjF4L1FwTUNCTytXQzJh?=
 =?utf-8?B?d1o5Ni9peFdTd1FPdzI2RnFnRERMRkQrcGRPbW1rOWxRL0tWNDlSd3NZZ2hY?=
 =?utf-8?Q?0Xohd2cIt06CZWeqN31STQmLX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0181451b-a3d4-4632-269e-08dbf81b9977
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 18:29:22.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgQyCEyeGc11Tt1ORURH8x4+4Z3A8onBbSMH1f6bEJAfpfIOhD+D0oC09fBrQuZI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 12/7/2023 1:56 PM, Tony Luck wrote:
> The MBA Software Controller(mba_sc) is a feedback loop that uses
> measurements of local memory bandwidth to adjust MBA throttling levels
> to keep workloads in a resctrl group within a target bandwidth set in
> the schemata file.
>
> Users may want to use total memory bandwidth instead of local to handle
> workloads that have poor NUMA localization.
>
> Add a new mount option "mba_MBps_event={event_name}" where event_name
> is one of "mbm_Local_bytes" or "mbm_total_bytes" that allows a user to
> specify which monitoring event to use.
>
> Update the once-per-second polling code to use the chosen event (local
> or total memory bandwidth).
>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>   include/linux/resctrl.h                |  2 +
>   arch/x86/kernel/cpu/resctrl/internal.h |  3 +-
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 21 +++++----
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 61 +++++++++++++++++++++-----
>   4 files changed, 63 insertions(+), 24 deletions(-)
>
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 66942d7fba7f..1feb3b2e64fa 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -129,6 +129,7 @@ enum membw_throttle_mode {
>    * @throttle_mode:	Bandwidth throttling mode when threads request
>    *			different memory bandwidths
>    * @mba_sc:		True if MBA software controller(mba_sc) is enabled
> + * @mba_mbps_event:	Event (local or total) for mba_sc
>    * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
>    */
>   struct resctrl_membw {
> @@ -138,6 +139,7 @@ struct resctrl_membw {
>   	bool				arch_needs_linear;
>   	enum membw_throttle_mode	throttle_mode;
>   	bool				mba_sc;
> +	enum resctrl_event_id		mba_mbps_event;
>   	u32				*mb_map;
>   };
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a4f1aa15f0a2..8b9b8f664324 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -58,7 +58,8 @@ struct rdt_fs_context {
>   	struct kernfs_fs_context	kfc;
>   	bool				enable_cdpl2;
>   	bool				enable_cdpl3;
> -	bool				enable_mba_mbps;
> +	bool				enable_mba_mbps_local;
> +	bool				enable_mba_mbps_total;
>   	bool				enable_debug;
>   };
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..d9e590f1cbc3 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -431,9 +431,10 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
>    */
>   static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
>   {
> -	struct mbm_state *m = &rr->d->mbm_local[rmid];
>   	u64 cur_bw, bytes, cur_bytes;
> +	struct mbm_state *m;
>   
> +	m = get_mbm_state(rr->d, rmid, rr->evtid);
>   	cur_bytes = rr->val;
>   	bytes = cur_bytes - m->prev_bw_bytes;
>   	m->prev_bw_bytes = cur_bytes;
> @@ -521,19 +522,21 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   	u32 closid, rmid, cur_msr_val, new_msr_val;
>   	struct mbm_state *pmbm_data, *cmbm_data;
>   	u32 cur_bw, delta_bw, user_bw;
> +	enum resctrl_event_id evt_id;
>   	struct rdt_resource *r_mba;
>   	struct rdt_domain *dom_mba;
>   	struct list_head *head;
>   	struct rdtgroup *entry;
>   
> -	if (!is_mbm_local_enabled())
> +	if (!is_mbm_enabled())
>   		return;
>   
>   	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +	evt_id = r_mba->membw.mba_mbps_event;
>   
>   	closid = rgrp->closid;
>   	rmid = rgrp->mon.rmid;
> -	pmbm_data = &dom_mbm->mbm_local[rmid];
> +	pmbm_data = get_mbm_state(dom_mbm, rmid, evt_id);
>   
>   	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
>   	if (!dom_mba) {
> @@ -553,7 +556,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
>   	 */
>   	head = &rgrp->mon.crdtgrp_list;
>   	list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
> +		cmbm_data = get_mbm_state(dom_mbm, entry->mon.rmid, evt_id);
>   		cur_bw += cmbm_data->prev_bw;
>   		delta_bw += cmbm_data->delta_bw;
>   	}
> @@ -616,18 +619,14 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
>   		rr.evtid = QOS_L3_MBM_TOTAL_EVENT_ID;
>   		rr.val = 0;
>   		__mon_event_count(rmid, &rr);
> +		if (is_mba_sc(NULL) && rr.evtid == r->membw.mba_mbps_event)
> +			mbm_bw_count(rmid, &rr);
>   	}
>   	if (is_mbm_local_enabled()) {
>   		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>   		rr.val = 0;
>   		__mon_event_count(rmid, &rr);
> -
> -		/*
> -		 * Call the MBA software controller only for the
> -		 * control groups and when user has enabled
> -		 * the software controller explicitly.
> -		 */
> -		if (is_mba_sc(NULL))
> +		if (is_mba_sc(NULL) && rr.evtid == r->membw.mba_mbps_event)
>   			mbm_bw_count(rmid, &rr);
>   	}
>   }
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 69a1de92384a..5f64a0b2597c 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2294,7 +2294,7 @@ static bool supports_mba_mbps(void)
>   {
>   	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>   
> -	return (is_mbm_local_enabled() &&
> +	return (is_mbm_enabled() &&
>   		r->alloc_capable && is_mba_linear());
>   }
>   
> @@ -2302,7 +2302,7 @@ static bool supports_mba_mbps(void)
>    * Enable or disable the MBA software controller
>    * which helps user specify bandwidth in MBps.
>    */
> -static int set_mba_sc(bool mba_sc)
> +static int set_mba_sc(bool mba_sc, enum resctrl_event_id mba_mbps_event)
>   {
>   	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
>   	u32 num_closid = resctrl_arch_get_num_closid(r);
> @@ -2313,6 +2313,7 @@ static int set_mba_sc(bool mba_sc)
>   		return -EINVAL;
>   
>   	r->membw.mba_sc = mba_sc;
> +	r->membw.mba_mbps_event = mba_mbps_event;
>   
>   	list_for_each_entry(d, &r->domains, list) {
>   		for (i = 0; i < num_closid; i++)
> @@ -2445,13 +2446,14 @@ static void rdt_disable_ctx(void)
>   {
>   	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>   	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> -	set_mba_sc(false);
> +	set_mba_sc(false, QOS_L3_MBM_LOCAL_EVENT_ID);

This is kind of miss leading. Why do you pass 
"QOS_L3_MBM_LOCAL_EVENT_ID" here?

If you move the following initialization to rdt_enable_ctx, then you 
don't need to pass the second argument.

r->membw.mba_mbps_event = mba_mbps_event;

Thanks
Babu

>   
>   	resctrl_debug = false;
>   }
>   
>   static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>   {
> +	enum resctrl_event_id mba_mbps_event;
>   	int ret = 0;
>   
>   	if (ctx->enable_cdpl2) {
> @@ -2466,8 +2468,12 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>   			goto out_cdpl2;
>   	}
>   
> -	if (ctx->enable_mba_mbps) {
> -		ret = set_mba_sc(true);
> +	if (ctx->enable_mba_mbps_local || ctx->enable_mba_mbps_total) {
> +		if (ctx->enable_mba_mbps_total)
> +			mba_mbps_event = QOS_L3_MBM_TOTAL_EVENT_ID;
> +		else
> +			mba_mbps_event = QOS_L3_MBM_LOCAL_EVENT_ID;
> +		ret = set_mba_sc(true, mba_mbps_event);
>   		if (ret)
>   			goto out_cdpl3;
>   	}
> @@ -2683,15 +2689,17 @@ enum rdt_param {
>   	Opt_cdp,
>   	Opt_cdpl2,
>   	Opt_mba_mbps,
> +	Opt_mba_mbps_event,
>   	Opt_debug,
>   	nr__rdt_params
>   };
>   
>   static const struct fs_parameter_spec rdt_fs_parameters[] = {
> -	fsparam_flag("cdp",		Opt_cdp),
> -	fsparam_flag("cdpl2",		Opt_cdpl2),
> -	fsparam_flag("mba_MBps",	Opt_mba_mbps),
> -	fsparam_flag("debug",		Opt_debug),
> +	fsparam_flag("cdp",			Opt_cdp),
> +	fsparam_flag("cdpl2",			Opt_cdpl2),
> +	fsparam_flag("mba_MBps",		Opt_mba_mbps),
> +	fsparam_string("mba_MBps_event",	Opt_mba_mbps_event),
> +	fsparam_flag("debug",			Opt_debug),
>   	{}
>   };
>   
> @@ -2715,7 +2723,25 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   	case Opt_mba_mbps:
>   		if (!supports_mba_mbps())
>   			return -EINVAL;
> -		ctx->enable_mba_mbps = true;
> +		if (is_mbm_local_enabled())
> +			ctx->enable_mba_mbps_local = true;
> +		else
> +			return -EINVAL;
> +		return 0;
> +	case Opt_mba_mbps_event:
> +		if (!supports_mba_mbps())
> +			return -EINVAL;
> +		if (!strcmp("mbm_local_bytes", param->string)) {
> +			if (!is_mbm_local_enabled())
> +				return -EINVAL;
> +			ctx->enable_mba_mbps_local = true;
> +		} else if (!strcmp("mbm_total_bytes", param->string)) {
> +			if (!is_mbm_total_enabled())
> +				return -EINVAL;
> +			ctx->enable_mba_mbps_total = true;
> +		} else {
> +			return -EINVAL;
> +		}
>   		return 0;
>   	case Opt_debug:
>   		ctx->enable_debug = true;
> @@ -3780,16 +3806,27 @@ static int rdtgroup_rename(struct kernfs_node *kn,
>   	return ret;
>   }
>   
> +static char *mba_sc_event_opt_name(struct rdt_resource *r)
> +{
> +	if (r->membw.mba_mbps_event == QOS_L3_MBM_LOCAL_EVENT_ID)
> +		return ",mba_MBps_event=mbm_local_bytes";
> +	else if (r->membw.mba_mbps_event == QOS_L3_MBM_TOTAL_EVENT_ID)
> +		return ",mba_MBps_event=mbm_total_bytes";
> +	return "";
> +}
> +
>   static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>   {
> +	struct rdt_resource *r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> +
>   	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
>   		seq_puts(seq, ",cdp");
>   
>   	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
>   		seq_puts(seq, ",cdpl2");
>   
> -	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
> -		seq_puts(seq, ",mba_MBps");
> +	if (is_mba_sc(r_mba))
> +		seq_puts(seq, mba_sc_event_opt_name(r_mba));
>   
>   	if (resctrl_debug)
>   		seq_puts(seq, ",debug");
